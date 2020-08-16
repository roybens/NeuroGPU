import numpy as np
import h5py
from neuron import h
import bluepyopt as bpop
import nrnUtils
import score_functions as sf
import efel
import pandas as pd
import os
import subprocess
import time
import shutil, errno
import struct
from extractModel_mappings_linux import   allparams_from_mapping
import bluepyopt.deapext.algorithms as algo


########################################################################################
#TODO: clean up dead weight imports and fix file paths                                                         
########################################################################################

model='bbp'
peeling='sodium'
date='04_08_2020'
run_file = './run_model_cori.hoc'
print(os.getcwd())
paramsCSV = '../../param_stim_generator/params_reference/params_'+ model + '_' + peeling +'.csv'
orig_params = h5py.File('../../params/params_bbp_sodium.hdf5')['orig_' + peeling][0]
scores_path = '../scores/'


old_eval = algo._evaluate_invalid_fitness

model_dir = '../'
param_file ='./params/gen.csv'               #What is gen.csv? does it matter?
data_dir = model_dir+'Data/'
params_table = data_dir + 'opt_table.csv'    #bbp template ORIG
run_dir = '../bin'
orig_volts_fn = data_dir + 'exp_data.csv' #ORIG volts
vs_fn = model_dir + 'Data/VHotP'
times_file_path = model_dir + 'Data/times.csv'
target_volts = np.genfromtxt(orig_volts_fn)
times =  np.cumsum(np.genfromtxt(times_file_path,delimiter=','))
#nCpus =  multiprocessing.cpu_count()
nstims = 4
nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])

objectives_file = h5py.File('./objectives/multi_stim_without_sensitivity_bbp_potassium_04_08_2020_stims.hdf5', 'r')
opt_weight_list = objectives_file['opt_weight_list'][:]
opt_stim_name_list = objectives_file['opt_stim_name_list'][:]
score_function_ordered_list = objectives_file['ordered_score_function_list'][:]
stims_path = '../../../stims/stims_full.hdf5'

allen_stim_file = h5py.File('../run_volts_bbp_full_gpu_tuned/stims/allen_data_stims_10000.hdf5', 'r')

custom_score_functions = [
                    'chi_square_normal',\
                    'traj_score_1',\
                    'traj_score_2',\
                    'traj_score_3',\
                    'isi',\
                    'rev_dot_product',\
                    'KL_divergence']

# Number of timesteps for the output volt.
ntimestep = 1000

# Value of dt in miliseconds
dt = 0.02

def run_model(stim_ind, params):
    volts_fn = vs_fn + str(stim_ind) + '.h5'
    if os.path.exists(volts_fn):
        os.remove(volts_fn)
    #p_object = subprocess.Popen(['../bin/h5NeuroGPU',str(stim_ind)])
    p_object = subprocess.Popen(['../bin/neuroGPU',str(stim_ind)])
    return p_object

# opt_stim_name_list = objectives_file['opt_stim_name_list'][:]
# allen_stim_file = h5py.File('../run_volts_bbp_full_gpu_tuned/stims/allen_data_stims_10000.hdf5', 'r')

# convert the allen data and save as csv
def convert_allen_data():
    for i in range(len(opt_stim_name_list)):
        stim = opt_stim_name_list[i].decode("utf-8")
        np.savetxt("../Data/stim_{}.csv".format(i), 
                   allen_stim_file[stim][:],
                   delimiter=",")
        np.savetxt("../Data/dt_{}.csv".format(i), 
                   allen_stim_file[stim+'_dt'][:],
                   delimiter=",")
 
    

def stim_swap(idx, i):
    old_stim = '../Data/Stim_raw' + str(idx) + '.csv'
    old_time = '../Data/times' + str(idx) + '.csv'
    if os.path.exists(old_stim):
        os.remove(old_stim)
        os.remove(old_time)
    os.rename(r'../Data/Stim_raw' + str(i) + '.csv', r'../Data/Stim_raw' + str(idx) + '.csv')
    os.rename(r'../Data/times' + str(i) + '.csv', r'../Data/times' + str(idx) + '.csv')

def stim_reset():
    shutil.rmtree('../Data')
    copyanything('../DataFroze', '../Data')
    
def copyanything(src, dst):
    try:
        shutil.copytree(src, dst)
    except OSError as exc: # python >2.5
        if exc.errno == errno.ENOTDIR:
            shutil.copy(src, dst)
        else: raise
    

def nrnMreadH5(fileName):
    f = h5py.File(fileName,'r')
    dat = f['Data'][:][0]
    return np.array(dat)

def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.double)

def makeallparams():
    filename = "../Data/AllParams.csv"
    with open(filename) as f:
        guts = f.readlines()
        nSets = int(guts[0])
        del guts[0]
        output = [float(s) for line in guts for s in line[:-1].split(',')]
    output = np.array(output)
    output = np.reshape(output, (len(output),1))
    hf = h5py.File('../Data/AllParams.h5', 'w')
    hf.create_dataset('Data', data=output)
    hf.create_dataset('nSets', data=nSets)
    hf.close()




class hoc_evaluator(bpop.evaluators.Evaluator):
    def __init__(self):
        """Constructor"""
        params_ = nrnUtils.readParamsCSV(paramsCSV)
        super(hoc_evaluator, self).__init__()
        self.orig_params = orig_params
        
        # code below more specific to neuroGPU
        data = np.genfromtxt(params_table,delimiter=',',names=True)
        self.pmin = data[0]
        print(self.pmin, "PMIN")
        self.pmax = data[1]
        self.ptarget = data[2]
        params = []
        for i in range(len(self.pmin)):
            params.append(bpop.parameters.Parameter('p' + str(i), bounds=(self.pmin[i],self.pmax[i])))
        self.params = params
        
        #print("Params to optimize:", [(name, minval, maxval) for name, minval, maxval in params_])
        self.weights = opt_weight_list
        self.opt_stim_list = [e.decode('ascii') for e in opt_stim_name_list]
        
        
        #self.objectives = [bpop.objectives.Objective('Weighted score functions')]
        
        self.objectives = np.repeat(bpop.objectives.Objective('Weighted score \
        functions'),4) #for 16 stims

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


        
    def evaluate_score_function(self,stim_name_list, target_volts_list, data_volts_list, weights):
        ''' This function is meant to evaluate voltage responses compared to target volts using custom and
        non-custom score functions and weights. Calculates normalized score for each stim and each score function 
        from objectives file and just stacks them in a list.
        Parameters
        -------------------- 
        stim_name_list: list of all the stims from optimisations procedure
        target_volts_list: (?? (TBD), ntimesteps) sized list of volts
        data_volts_list: (nindv, nstimesteps) sized list of voltage responses from param sets
        weights: list of weights from optimisations procedure
        
        Return
        --------------------
        List of scores for each parameter set
        '''
        def eval_function(target, data, function, dt):
            '''changed from hoc eval so that it returns eval for list of indvs, not just one'''
            if function in custom_score_functions:
                score = [getattr(sf, function)(target, data[i], dt) for indv in data] 
            else:
                score = sf.eval_efel(function, target, data, dt)
            score = np.reshape(score, self.nindv)
            return score
        def normalize_scores(curr_scores, transformation):
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
                return np.ones(len(self.nindv)) #verify
            return normalized_single_score
        
        total_scores = np.array([])
        for i in range(len(stim_name_list)): 
            curr_data_volt = data_volts_list[i,:,:]
            curr_target_volt = target_volts_list[i]
            stim_score = 0
            for j in range(len(score_function_ordered_list)):
                curr_sf = score_function_ordered_list[j].decode('ascii')
                curr_weight = weights[len(score_function_ordered_list)*i + j]
                transformation = h5py.File(scores_path+stim_name_list[i]+'_scores.hdf5', 'r')['transformation_const_'+curr_sf][:]
                if curr_weight == 0:
                    curr_scores = np.zeros(self.nindv)
                else:
                    curr_scores = eval_function(curr_target_volt, curr_data_volt, curr_sf, dt)
                norm_scores = normalize_scores(curr_scores, transformation)
                for k in range(len(norm_scores)):
                    if np.isnan(norm_scores[k]):
                        norm_scores[k] = 1
                if j == 0:
                    stim_score = norm_scores * curr_weight
                    #stim_score = np.sum(norm_scores * curr_weight)
                else:
                    stim_score += norm_scores * curr_weight
                
            if i == 0:
                total_scores = np.reshape(stim_score, (-1,1)) # np.array([stim_score])
            else:
                total_scores = np.append(total_scores,np.reshape(stim_score, (-1,1)),axis=1)
        return total_scores

    def evaluate_with_lists(self, param_values):
        '''This function overrides the BPOP built in function. It is currently set up to run GPU tasks for each 
        stim in chunks based on number of GPU resources then stacks these results and sends them off to be
        evaluated.
        Parameters
        -------------------- 
        param_values: Population sized list of parameter sets to be ran through neruoGPU then scored and evaluated
        
        Return
        --------------------
        List of scores for each parameter set (nindv, 1)
        '''
        #stim_reset()
        nindv = len(param_values)
        print(np.array(param_values).shape)
        print(1/0)
        self.nindv = nindv
        numParams = len(param_values[0])
        # convert these param values to allParams for neuroGPU
        allparams = allparams_from_mapping(param_values) #allparams is not finalized
        #makeallparams()
        start_time_sim = time.time()
        p_objects = []
        self.opt_stim_list2 = self.opt_stim_list * 4
        weights = np.repeat(self.weights,4)
        data_volts_list = np.array([])
        nstims = len(self.opt_stim_list2)
        
        start_times = []
        end_times = []
        for i in range(0, nGpus):
            start_times.append(time.time())
            p_objects.append(run_model(i, []))
            
        for i in range(0,nstims):
            idx = i % (nGpus)
            p_objects[idx].wait() #wait to get volts output from previous run then read and stack
            end_times.append(time.time())
            fn = vs_fn + str(idx) +  '.dat'    #'.h5'
            curr_volts =  nrnMread(fn)
            nindv = len(param_values)
            Nt = int(len(curr_volts)/nindv)
            shaped_volts = np.reshape(curr_volts, [nindv, Nt])
            if i == 0:
                data_volts_list = np.reshape(shaped_volts, (1,nindv,ntimestep))#start stacking volts
            else:
                data_volts_list = np.append(data_volts_list, np.reshape(shaped_volts, (1,nindv,ntimestep)), axis = 0)
            last_batch = i >= (nstims-nGpus) #use this so neuroGPU doesn't keep running 
            if not last_batch:
                start_times.append(time.time())
                if idx != i:
                    stim_swap(idx,i)
                p_objects[idx] = run_model(idx, []) #ship off job to neuroGPU for next iter
        
        
            
    
        data_volts_list = np.reshape(data_volts_list, (nstims,nindv,ntimestep))
        print(data_volts_list[1][0], data_volts_list[3][0])
        eval_start = time.time()
        score = self.evaluate_score_function(self.opt_stim_list2, target_volts, data_volts_list, weights)
        eval_end = time.time()
        
        print("average neuroGPU runtime: ", np.mean(np.array(end_times) - np.array(start_times)))
        print("evaluation took: ", eval_end - eval_start)
        print("everything took: ", eval_end - start_time_sim)

        #score = self.evaluate_score_function(self.opt_stim_list, target_volts, data_volts_list, self.weights)  
        #score = np.reshape(np.sum(score,axis=1), (-1,1)) # sum over stims, axis =0
        # gives answer that looks right but it should be axis=1 to sum over stims
        print(score, "SCORE SHAPE")
        return score

    
algo._evaluate_invalid_fitness =hoc_evaluator.my_evaluate_invalid_fitness
