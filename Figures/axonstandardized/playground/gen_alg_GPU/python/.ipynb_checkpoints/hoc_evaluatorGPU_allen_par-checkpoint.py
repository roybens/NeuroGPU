import numpy as np
import h5py
import bluepyopt as bpop
import nrnUtils
import score_functions as sf
import efel
import pandas as pd
import os
import subprocess
import time
import shutil
import struct
import glob
import ctypes
import matplotlib.pyplot as plt
from extractModel_mappings_linux import   allparams_from_mapping
import bluepyopt.deapext.algorithms as algo
from concurrent.futures import ProcessPoolExecutor as Pool
import multiprocessing
import csv
import ap_tuner as tuner
os.environ["OMP_NUM_THREADS"] = "1" # export OMP_NUM_THREADS=4
os.environ["OPENBLAS_NUM_THREADS"] = "1" # export OPENBLAS_NUM_THREADS=4
os.environ["MPICH_GNI_FORK_MODE"] = "FULLCOPY" # export MPICH_GNI_FORK_MODE=FULLCOPY
from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()


run_file = './run_model_cori.hoc'
run_volts_path = '../run_volts_bbp_full_gpu_tuned/'
paramsCSV = run_volts_path+'params/params_bbp_full_gpu_tuned_10_based.csv'
orig_params = h5py.File(run_volts_path+'params/params_bbp_full_allen_gpu_tune.hdf5', 'r')['orig_full'][0]
scores_path = '../scores/'
objectives_file = h5py.File('./objectives/multi_stim_bbp_full_allen_gpu_tune_18_stims.hdf5', 'r')
opt_weight_list = objectives_file['opt_weight_list'][:]
opt_stim_name_list = objectives_file['opt_stim_name_list'][:]
score_function_ordered_list = objectives_file['ordered_score_function_list'][:]
stims_path = run_volts_path+'/stims/allen_data_stims_10000.hdf5'
target_volts_path = './target_volts/allen_data_target_volts_10000.hdf5'
target_volts_hdf5 = h5py.File(target_volts_path, 'r')
ap_tune_stim_name = '18'
ap_tune_weight = 0
params_opt_ind = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
model_dir = '..'
data_dir = model_dir+'/Data/'
run_dir = '../bin'
vs_fn = '/tmp/Data/VHotP'
nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])
nCpus =  multiprocessing.cpu_count()
allen_stim_file = h5py.File('../run_volts_bbp_full_gpu_tuned/stims/allen_data_stims_10000.hdf5', 'r')
old_eval = algo._evaluate_invalid_fitness

print("USING nGPUS: ", nGpus, " and USING nCPUS: ", nCpus)

custom_score_functions = [
                    'chi_square_normal',\
                    'traj_score_1',\
                    'traj_score_2',\
                    'traj_score_3',\
                    'isi',\
                    'rev_dot_product',\
                    'KL_divergence']

# Number of timesteps for the output volt.
ntimestep = 10000

if not os.path.isdir("/tmp/Data"):
    os.mkdir("/tmp/Data")

def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.double)

def nrnMreadH5(fileName):
    f = h5py.File(fileName,'r')
    dat = f['Data'][:][0]
    return np.array(dat)


def stim_swap(idx, i):
    """
    Stim swap takes 'idx' which is the stim index % 8 and 'i' which is the actual stim idx
    and then deletes the one at 'idx' and replaces it with the stim at i so that 
    neuroGPU reads stims like 13 as stim_raw5 (13 % 8)
    """
    old_stim = '../Data/Stim_raw' + str(idx) + '.csv'
    old_time = '../Data/times' + str(idx) + '.csv'
    if os.path.exists(old_stim):
        os.remove(old_stim)
        os.remove(old_time)
    os.rename(r'../Data/Stim_raw' + str(i) + '.csv', r'../Data/Stim_raw' + str(idx) + '.csv')
    os.rename(r'../Data/times' + str(i) + '.csv', r'../Data/times' + str(idx) + '.csv')

def get_first_zero(stim):
    """Kyung helper function to penalize AP where there should not be one"""
    for i in range(len(stim)-2, -1, -1):
        if stim[i] > 0 and stim[i+1] == 0:
            return i+1
    return None

def check_ap_at_zero(stim_ind, volts):
    """
    Kyung function to check if a volt should be penalized for having an AP before there 
    should be one. Modified to take in "volts" as a list of individuals instead of "volt"
    """
    stim_name = list([e.decode('ascii') for e in opt_stim_name_list])[int(stim_ind)]
    stim = allen_stim_file[stim_name][:]
    first_zero_ind = get_first_zero(stim)
    nindv =volts.shape[0]
    checks = np.zeros(nindv)
    for i in range(nindv):
        volt = volts[i,:]
        if first_zero_ind:
            if np.mean(stim[first_zero_ind:]) == 0:
                first_ind_to_check = first_zero_ind + 1000
                APs = [True if v > 0 else False for v in volt[first_ind_to_check:]]
                if True in APs:
                    #return 400 # threshold parameter that I am still tuning
                    print("indv:",i, "stim ind: ", stim_ind)
                    checks[i] = 250
    return checks    

class hoc_evaluator(bpop.evaluators.Evaluator):
    def __init__(self):
        """Constructor"""
        data = nrnUtils.readParamsCSV(paramsCSV)
        super(hoc_evaluator, self).__init__()
        self.orig_params = orig_params
        self.opt_ind = params_opt_ind
        data = np.array([data[i] for i in self.opt_ind])
        self.orig_params = orig_params
        self.pmin = np.array((data[:,1]), dtype=np.float64)
        self.pmax = np.array((data[:,2]), dtype=np.float64) 
        self.pmax = np.delete(self.pmax, 1, 0) # need to delete second parameter because it is negative and BPOP cannot take negative params, we will add it back to every set of params in eval_list before allParams
        self.pmin = np.delete(self.pmin, 1, 0)
        #self.ptarget = self.orig_params
        params = [] 
        for i in range(len(self.pmin)):
            params.append(bpop.parameters.Parameter(data[i][0], bounds=(self.pmin[i],self.pmax[i])))
        self.params = params
        self.weights = opt_weight_list
        self.opt_stim_list = [e.decode('ascii') for e in opt_stim_name_list]
        self.target_volts_list = np.array([target_volts_hdf5[s][:] for s in self.opt_stim_list])
        self.objectives = [bpop.objectives.Objective('Weighted score functions')]
        # AP tune stuff not currently being used
        self.ap_tune_stim_name = ap_tune_stim_name
        self.ap_tune_weight = ap_tune_weight
        self.ap_tune_target = target_volts_hdf5[self.ap_tune_stim_name][:]
        self.dts = []
        

    def my_evaluate_invalid_fitness(toolbox, population):
        '''Evaluate the individuals with an invalid fitness
        Returns the count of individuals with invalid fitness
        '''
        invalid_ind = [ind for ind in population if not ind.fitness.valid]
        invalid_ind = [population[0]] + invalid_ind 
        fitnesses = toolbox.evaluate(invalid_ind)
        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit
        return len(invalid_ind)
    
    def top_SFs(self, run_num):
        """
        finds scoring functions w/ weight over 50 and pairs them with that stim and sends
        them to mapping function so that we will run so many processes
        Arguments
        --------------------------------------------------------------
        run_num: the number of times neuroGPU has ran for 8 stims,
        keep track of what stims we are picking out score functions for
        """
        all_pairs = []
        last_stim = (run_num + 1) * nGpus # ie: 0th run last_stim = (0+1)*8 = 8
        first_stim = last_stim - nGpus # on the the last round this will be 24 - 8 = 16
        if last_stim > 18:
            last_stim = 18
        #print(first_stim,last_stim, "first and last")
        for i in range(first_stim, last_stim):#range(first_stim,last_stim):
            sf_len = len(score_function_ordered_list)
            curr_weights = self.weights[sf_len*i: sf_len*i + sf_len] #get range of sfs for this stim
            #top_inds = sorted(range(len(curr_weights)), key=lambda i: curr_weights[i], reverse=True)[:10] #finds top ten biggest weight indices
            top_inds = np.where(curr_weights > 50)[0] # weights bigger than 50
            pairs = list(zip(np.repeat(i,len(top_inds)), [ind for ind in top_inds])) #zips up indices with corresponding stim # to make sure it is refrencing a relevant stim
            all_pairs.append(pairs)
        flat_pairs = [pair for pairs in all_pairs for pair in pairs] #flatten the list of tuples
        return flat_pairs

    
    def run_model(self,stim_ind, params):
        """
        Parameters
        -------------------------------------------------------
        stim_ind: index to send as arg to neuroGPU 
        params: DEPRECATED remove
        
        Returns
        ---------------------------------------------------------
        p_object: process object that stops when neuroGPU done
        """
        #volts_fn = vs_fn + str(stim_ind) + '.dat'
        volts_fn = vs_fn + str(stim_ind) + '.h5'
        if os.path.exists(volts_fn):
            os.remove(volts_fn)
        p_object = subprocess.Popen(['../bin/neuroGPU',str(stim_ind)])
        return p_object
    
    # convert the allen data and save as csv
    def convert_allen_data(self):
        """
        Function that sets up our new allen data every run. It reads and writes every stimi
        and timesi and removes previous ones. Using csv writer to write timesi so it reads well.
        """
        for i in range(len(opt_stim_name_list)):
            old_stim = "../Data/Stim_raw{}.csv"
            old_time = "../Data/times_{}.csv"
            if os.path.exists(old_stim) :
                os.remove(old_stim)
                os.remove(old_time)
        for i in range(len(opt_stim_name_list)):
            stim = opt_stim_name_list[i].decode("utf-8")
            dt = allen_stim_file[stim+'_dt'][:][0]
            self.dts.append(dt)
            f = open ("../Data/times{}.csv".format(i), 'w')
            wtr = csv.writer(f, delimiter=',', lineterminator='\n')
            current_times = [dt for i in range(ntimestep)]
            wtr.writerow(current_times)
            f.close()
            np.savetxt("../Data/Stim_raw{}.csv".format(i), 
                       allen_stim_file[stim][:],
                       delimiter=",")

        
    def eval_function(self,target, data, function, dt,i):
        """
        function that sends target and simulated volts to scorefunctions.py so they
        can be evaluated, then adds Kyung AP penalty function at the end
        
        Parameters
        -------------------------------------------------------------
        target: target volt for this stim
        data: set of volts with shape (nindvs, ntimsteps)
        function: string containing score function to use
        dt: dt of the stim as it is a parameter for some sfs
        i: index of the stim
        
        Returns
        ------------------------------------------------------------
        score: scores for each individual in an array corresponding to this score function
        with shape (nindv, 1)
        """
        
        num_indvs = data.shape[0]
        if function in custom_score_functions:
            score = [getattr(sf, function)(target, data[indv,:], dt) for indv in range(num_indvs)]
        else:
            score = sf.eval_efel(function, target, data, dt)
        return score + check_ap_at_zero(i, data)# here is I am adding penalty
    
    def normalize_scores(self,curr_scores, transformation,i):
        '''changed from hoc eval so that it returns normalized score for list of indvs, not just one
        TODO: not sure what transformation[6] does but I changed return statement to fit our 
        dimensions'''
        # transformation contains: [bottomFraction, numStds, newMean, std, newMax, addFactor, divideFactor]
        # indices for reference:   [      0       ,    1   ,    2   ,  3 ,    4  ,     5    ,      6      ]
        for i in range(len(curr_scores)):
            if curr_scores[i] > transformation[4]:
                curr_scores[i] = transformation[4]        # Cap newValue to newMax if it is too large
        normalized_single_score = (curr_scores + transformation[5])/transformation[6]  # Normalize the new score
        if transformation[6] == 0:
            #return 1
            return np.ones(len(self.nindv)) #verify w/ Kyung
        return normalized_single_score

    def eval_stim_sf_pair(self,perm):
        """ 
        function that evaluates a stim and score function pair on line 252. Sets i as the actual 
        index and and mod_i as it's adjusted index (should get 15th target volt but that will 
        be 7th in the data_volts_list). transform then normalize and then multiply by weight
        and then SENT BACK to MAPPER. uses self. for weights, data_volts, and target volts because
        it is easy information transfer instead of passing arguments into map.
        
        Arguments
        --------------------------------------------------------------------
        perm: pair of ints where first is the stim and second is the score function label index
        to run
        
        Returns
        ---------------------------------------------------------------------
        scores: normalized+weighted scores with the shape (nindv, 1), and sends them back to map
        to be stacked then summed.
        
        """
        i = perm[0]
        mod_i = i % 8
        j = perm[1]
        curr_data_volt = self.data_volts_list[mod_i,:,:]
        curr_target_volt = self.target_volts_list[i]
        curr_sf = score_function_ordered_list[j].decode('ascii')
        curr_weight = self.weights[len(score_function_ordered_list)*i + j]
        transformation = h5py.File(scores_path+self.opt_stim_list[i]+'_scores.hdf5', 'r')['transformation_const_'+curr_sf][:]
        if curr_weight == 0:
            curr_scores = np.zeros(self.nindv)
        else:
            curr_scores = self.eval_function(curr_target_volt, curr_data_volt, curr_sf, self.dts[i],i)
        norm_scores = self.normalize_scores(curr_scores, transformation,i)
        for k in range(len(norm_scores)):
            if np.isnan(norm_scores[k]):
                norm_scores[k] = 1
        return norm_scores * curr_weight 
    
    
    def map_par(self,run_num):
        ''' 
        This function maps out what stim and score function pairs should be mapped to be evaluated in parallel
        first it finds the pairs with the highest weights, the maps them and then adds up the score for each stim
        for every individual.
        
        Parameters
        -------------------- 
        run_num: the amount of times neuroGPU has ran for 8 stims
        
        Return
        --------------------
        2d list of scalar scores for each parameter set w/ shape (nindv,nstims)
        '''
        fxnsNStims = self.top_SFs(run_num) # 52 stim-sf combinations (stim#,sf#)
        with Pool(nCpus) as p: # parallel mapping
            res = p.map(self.eval_stim_sf_pair, fxnsNStims)
        res = np.array(list(res)) ########## important: map returns results with shape (# of sf stim pairs, nindv)
        res = res[:,:] 
        prev_sf_idx = 0 
        # look at key of each stim score pair to see how many stims to sum
        #num_selected_stims = len(set([pair[0] for pair in fxnsNStims])) # not always using 8 stims
        last_stim = (run_num + 1) * nGpus # ie: 0th run last_stim = (0+1)*8 = 8
        first_stim = last_stim - nGpus # on the the last round this will be 24 - 8 = 16
        if last_stim > 18:
            last_stim = 18
        #print(last_stim, first_stim, "last and first")
        for i in range(first_stim, last_stim):  # iterate stims and sum
            num_sfs = sum([1 for pair in fxnsNStims if pair[0]==i]) #find how many sf indices for this stim
            #print([pair for pair in fxnsNStims if pair[0]==i], "pairs from : ", run_num)
            #print(fxnsNStims[prev_sf_idx:prev_sf_idx+num_sfs], "Currently evaluating")

            if i % nGpus == 0:
                weighted_sums = np.reshape(np.sum(res[prev_sf_idx:prev_sf_idx+num_sfs, :], axis=0),(-1,1))
            else:
                #print(prev_sf_idx, "stim start idx", num_sfs, "stim end idx")
                curr_stim_sum = np.sum(res[prev_sf_idx:prev_sf_idx+num_sfs, :], axis=0)
                curr_stim_sum = np.reshape(curr_stim_sum, (-1,1))
                weighted_sums = np.append(weighted_sums, curr_stim_sum , axis = 1)
                #print(curr_stim_sum.shape," : cur stim sum SHAPE      ", weighted_sums.shape, ": weighted sums shape")
            prev_sf_idx = prev_sf_idx + num_sfs # update score function tracking index
        return weighted_sums
            
    def ap_tune(self,param_values, target_volts, stim_name, weight):
        '''
        DEPRECATED?, Kyung said he is not using this anymore
        '''
        stim_list = [stim_name]
        i  = int(stim_name) -1
        stim = opt_stim_name_list[i].decode("utf-8")
        np.savetxt("../Data/Stim_raw0.csv", 
                       allen_stim_file[stim][:],
                       delimiter=",")
        obj = self.run_model(0,[])
        obj.wait()
        data_volt = self.getVolts(0)
        data_volt = data_volt.flatten()
        stims_hdf5 = h5py.File(stims_path, 'r')
        dt = stims_hdf5[stim_name+'_dt']
        return tuner.fine_tune_ap(target_volts, data_volt, weight, dt)
    
    def getVolts(self,idx):
        '''Helper function that gets volts from data and shapes them for a given stim index'''
        fn = vs_fn + str(idx) +  '.h5'    #'.h5' 
        curr_volts =  nrnMreadH5(fn)
        #fn = vs_fn + str(idx) +  '.dat'    #'.h5'
        #curr_volts =  nrnMread(fn)
        Nt = int(len(curr_volts)/ntimestep)
        shaped_volts = np.reshape(curr_volts, [Nt,ntimestep])
        return shaped_volts

    def evaluate_with_lists(self, param_values):
        '''This function overrides the BPOP built in function. It is currently set up to run GPU tasks for each 
        stim in chunks based on number of GPU resources then stacks these results and sends them off to be
        evaluated. It runs concurrently so that while nGpus are busy, results ready for evaluation are evaluated.
        Parameters
        -------------------- 
        param_values: Population sized list of parameter sets to be ran through neruoGPU then scored and evaluated
        
        Return
        --------------------
        2d list of scalar scores for each parameter set w/ shape (nindv,1)
        '''
        
        self.dts = []
        self.convert_allen_data() # reintialize allen stuff for clean run
        self.nindv = len(param_values)
        # insert negative param value back in to each set
        full_params = np.insert(np.array(param_values), 1, orig_params[1], axis = 1)
        allparams = allparams_from_mapping(list(full_params)) 
        self.data_volts_list = np.array([])
        nstims = len(self.opt_stim_list)
        nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])
        #nstims = 4 # testing
        start_time_sim = time.time()
        p_objects = []
        score = []
        start_times = [] # a bunch of timers
        end_times = []
        eval_times = []
        run_num = 0
        
        #start running neuroGPU
        for i in range(0, nGpus):
            start_times.append(time.time())
            p_objects.append(self.run_model(i, []))
        # evlauate sets of volts and     
        for i in range(0,nstims):
            idx = i % (nGpus)
            p_objects[idx].wait() #wait to get volts output from previous run then read and stack
            end_times.append(time.time())
            shaped_volts = self.getVolts(idx)
            
            if idx == 0:
                self.data_volts_list = shaped_volts #start stacking volts
            else:
                self.data_volts_list = np.append(self.data_volts_list, shaped_volts, axis = 0) # check this
            first_batch = i < nGpus # we only evaluate on first batch because we already started neuroGPU
            last_batch  = i == (nstims - 1) # True if we are on last iter
            if not first_batch:
                start_times.append(time.time())
                if i != idx:
                    print("replaced dts and stims for ", idx, " with the ones for  ", i)
                    stim_swap(idx, i)
                p_objects[idx] = self.run_model(idx, []) #ship off job to neuroGPU for next iter
            if idx == nGpus-1:
                self.data_volts_list = np.reshape(self.data_volts_list, (nGpus,self.nindv,ntimestep)) # ok
                eval_start = time.time()
                if i == nGpus-1:
                    self.targV = self.target_volts_list[:nGpus] # shifting targV and current dts
                    self.curr_dts = self.dts[:nGpus] #  so that parallel evaluator can see just the relevant parts
                    score = self.map_par(run_num) # call to parallel eval
                else:
                    self.targV = self.target_volts_list[i-nGpus+1:i+1] # i = 15, i-nGpus+1 = 8, i+1 = 16 
                    self.curr_dts = self.dts[i-nGpus+1:i+1] # so therefore we get range(8,16) for dts and targ vs
                    score = np.append(score,self.map_par(run_num),axis =1) #stacks scores by stim
                    
                eval_end = time.time()
                eval_times.append(eval_end - eval_start)
                self.data_volts_list = np.array([])
                run_num += 1
            #### this part only runs on the last iteration, just to finish off the last two volts and stims
            #### same code as above but only runs two stims instead of 18
            if last_batch: #end of batch
                for ii in range(3):
                    idx = ii % (nGpus)
                    p_objects[idx].wait() #wait to get volts output from previous run then read and stack
                    end_times.append(time.time())
                    shaped_volts = self.getVolts(idx)
                    if idx == 0:
                        self.data_volts_list = shaped_volts #start stacking volts
                    else:
                        self.data_volts_list = np.append(self.data_volts_list, shaped_volts, axis = 0) 
                    if ii == 2:
                        self.data_volts_list = np.reshape(self.data_volts_list, (3,self.nindv,ntimestep))
                        self.targV = self.target_volts_list[16:18]
                        self.curr_dts = self.dts[16:18]
                        score = np.append(score,self.map_par(run_num),axis =1)

        # TODO: fix timers later
        #print("average neuroGPU runtime: ", np.mean(np.array(end_times) - np.array(start_times)))
        #print("neuroGPU runtimes: ", np.array(end_times) - np.array(start_times))
        #print("evaluation took: ", eval_times)
        print("everything took: ", eval_end - start_time_sim)
        score = np.reshape(np.sum(score,axis=1), (-1,1))
        # Minimum element indices in list 
        # Using list comprehension + min() + enumerate() 
        temp = min(score) 
        res = [i for i, j in enumerate(score) if j == temp] 
        print("The Positions of minimum element : " + str(res)) 
        #testing
#         for i in range(len(score)):
#             print(score[i], ": " + str(i))
            
        print(score.shape, "SCORE SHAPE")
        return score

    
algo._evaluate_invalid_fitness =hoc_evaluator.my_evaluate_invalid_fitness