import os

os.environ['OPENBLAS_NUM_THREADS'] = '1'

import numpy as np
import os
import subprocess
import shutil
import bluepyopt as bpop
import struct
import time
import pandas as pd
import efel_ext
import efel_ext_old

import time
import glob
import ctypes
import matplotlib.pyplot as plt
import bluepyopt.deapext.algorithms as algo
from extractModel_mappings_linux import   allparams_from_mapping
import multiprocessing
from multiprocessing import Process
#from multiprocessing import Pool
import h5py
from concurrent.futures import ProcessPoolExecutor as Pool
import hdf5maker as h5help
from joblib import Parallel, delayed, parallel_backend

import h5py
import subprocess
import pandas as pd
import csv
import numpy as np


model_dir = '../'
param_file ='./params/gen.csv'               #What is gen.csv? does it matter?
data_dir = model_dir+'/Data/'
params_table = data_dir + 'opt_table.csv'    #bbp template ORIG
run_dir = '../bin'
orig_volts_fn = data_dir + './exp_data.csv' #ORIG volts
vs_fn = model_dir + 'Data/VHotP'
times_file_path = model_dir + 'Data/times.csv'
nstims = 8
target_volts = np.genfromtxt(orig_volts_fn)
times =  np.cumsum(np.genfromtxt(times_file_path,delimiter=','))
nCpus =  multiprocessing.cpu_count()

#times = times[:-1]

old_eval = algo._evaluate_invalid_fitness
def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.double)

def nrnMreadH5(fileName):
    f = h5py.File(fileName,'r')
    dat = f['Data'][:][0]
    return np.array(dat)


def makeallparams():
    filename = "../Data/AllParams.csv"


    #apCsv =  pd.read_csv(filename)

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
    


class neurogpu_multistim_evaluator(bpop.evaluators.Evaluator):
    def __init__(self):
        #for fl in glob.glob(vs_fn + "*"):
        #    os.remove(fl)
        """Constructor"""
        def read_with_genfromtxt(path, type=float, delim=None):
            r = np.genfromtxt(path, dtype=type, delimiter=delim)
            if np.shape(r) == ():
                return np.array([r.item()])
            return r
        super(neurogpu_multistim_evaluator, self).__init__()

        data = np.genfromtxt(params_table,delimiter=',',names=True)
        self.pmin = data[0]
        self.pmax = data[1]
        self.ptarget = data[2]

        params = []
        for i in range(len(self.pmin)):
            params.append(bpop.parameters.Parameter('p' + str(i), bounds=(self.pmin[i],self.pmax[i])))

        self.params = params


        #self.opt_stim_list = read_with_genfromtxt(opt_stim_name_list, str, ' ')
        # ['mean_frequency', 'adaptation_index', 'time_to_first_spike', 'mean_AP_amplitude', 'ISI values', 'spike_half_width']
        # ['voltage_base','steady_state_voltage_stimend','decay_time_constant_after_stim']



        self.objectives = [bpop.objectives.Objective('voltage_base_1'),\
                           bpop.objectives.Objective('AP_amplitude_1'),\
                           bpop.objectives.Objective('voltage_after_stim_1'),\
                           bpop.objectives.Objective('ISI values_1'),\
                           bpop.objectives.Objective('spike_half_width_1'),\
                           bpop.objectives.Objective('AHP_Depth_1'),\
                           bpop.objectives.Objective('chi_1'),\

                           bpop.objectives.Objective('voltage_base_2'),\
                           bpop.objectives.Objective('AP_amplitude_2'),\
                           bpop.objectives.Objective('voltage_after_stim_2'),\
                           bpop.objectives.Objective('ISI values_2'),\
                           bpop.objectives.Objective('spike_half_width_2'),\
                           bpop.objectives.Objective('AHP_Depth_2'),\
                           bpop.objectives.Objective('chi_2'),\

                           bpop.objectives.Objective('voltage_base_3'),\
                           bpop.objectives.Objective('AP_amplitude_3'),\
                           bpop.objectives.Objective('voltage_after_stim_3'),\
                           bpop.objectives.Objective('ISI values_3'),\
                           bpop.objectives.Objective('spike_half_width_3'),\
                           bpop.objectives.Objective('AHP_Depth_3'),\
                           bpop.objectives.Objective('chi_3'),\

                           bpop.objectives.Objective('voltage_base_4'),\
                           bpop.objectives.Objective('AP_amplitude_4'),\
                           bpop.objectives.Objective('voltage_after_stim_4'),\
                           bpop.objectives.Objective('ISI values_4'),\
                           bpop.objectives.Objective('spike_half_width_4'),\
                           bpop.objectives.Objective('AHP_Depth_4'),\
                           bpop.objectives.Objective('chi_4'),\

                           bpop.objectives.Objective('voltage_base_5'),\
                           bpop.objectives.Objective('AP_amplitude_5'),\
                           bpop.objectives.Objective('voltage_after_stim_5'),\
                           bpop.objectives.Objective('ISI values_5'),\
                           bpop.objectives.Objective('spike_half_width_5'),\
                           bpop.objectives.Objective('AHP_Depth_5'),\
                           bpop.objectives.Objective('chi_5'),\

                           bpop.objectives.Objective('voltage_base_6'),\
                           bpop.objectives.Objective('AP_amplitude_6'),\
                           bpop.objectives.Objective('voltage_after_stim_6'),\
                           bpop.objectives.Objective('ISI values_6'),\
                           bpop.objectives.Objective('spike_half_width_6'),\
                           bpop.objectives.Objective('AHP_Depth_6'),\
                           bpop.objectives.Objective('chi_6'),\

                           bpop.objectives.Objective('voltage_base_7'),\
                           bpop.objectives.Objective('AP_amplitude_7'),\
                           bpop.objectives.Objective('voltage_after_stim_7'),\
                           bpop.objectives.Objective('ISI values_7'),\
                           bpop.objectives.Objective('spike_half_width_7'),\
                           bpop.objectives.Objective('AHP_Depth_7'),\
                           bpop.objectives.Objective('chi_7'),\

                           bpop.objectives.Objective('voltage_base_8'),\
                           bpop.objectives.Objective('AP_amplitude_8'),\
                           bpop.objectives.Objective('voltage_after_stim_8'),\
                           bpop.objectives.Objective('ISI values_8'),\
                           bpop.objectives.Objective('spike_half_width_8'),\
                           bpop.objectives.Objective('AHP_Depth_8'),\
                           bpop.objectives.Objective('chi_8')


                           ]
        self.objectives = self.objectives[0:nstims*7]
        #self.toolbox.register("evaluate", self.evaluator.evaluate_with_lists)
    def my_evaluate_invalid_fitness(toolbox, population):
        '''Evaluate the individuals with an invalid fitness

        Returns the count of individuals with invalid fitness
        '''

        invalid_ind = [ind for ind in population if not ind.fitness.valid]
        invalid_ind = [population[0]] + invalid_ind
        print(len(invalid_ind))
        fitnesses = toolbox.evaluate(invalid_ind)
        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit
        return len(invalid_ind)

    def run_model(self,stim_ind,params):
        print("running stim ind" + str(stim_ind))
        volts_fn = vs_fn + str(stim_ind) + '.h5'
        #volts_fn = vs_fn + str(stim_ind) + '.dat'  

        if os.path.exists(volts_fn):
            os.remove(volts_fn)
            #pass
        path = "./sleep.sh"
        #p_object = subprocess.Popen(path, shell=True)
        p_object = subprocess.Popen(['../bin/neuroGPU',str(stim_ind)])
        #p_object = subprocess.Popen(['../bin/neuroGPU2',str(stim_ind)])

        return p_object

    def info(self,title):
        print(title)
        print('module name:', __name__)
        print('parent process:', os.getppid())
        print('process id:', os.getpid())

    def eval_stim_parallel(self,curr_volts,idx):
        '''Function to be mapped in parallel, prints process ID then does
        normal prep for shaping volts and then ships it off to be evaled
        with function call to efel_ext
        
        Parameters
        --------------------
        curr_volts: raw volts produced by nrnMreadH5 function, output from neuroGPU
        idx: index of stim being evaluated (1-8)
        
        Return
        --------------------
        scores with shape (batch size, 7) '''
        
        self.info("evaling stim: " + str(idx))
        nindv = len(self.param_values)
        # fn = vs_fn + str(idx) + '.dat'
        # curr_volts = nrnMread(fn)
        Nt = int(len(curr_volts)/nindv)
        shaped_volts = np.reshape(curr_volts, [nindv, Nt])
        #print("TARG VOLTS", target_volts.shape , "SHaped", shaped_volts.shape)
        stim_scores = efel_ext.eval([target_volts[idx]], shaped_volts,times)
        return stim_scores

    def compare_scores_to_SG(self,scores):
        '''element-wise comparison to non-parallel version
        Parameters
        --------------------
        scores obtained with parellel code, shape: (nindvs, 14)

        Return
        --------------------
        boolean, true or false depending on if the scores obtained from parallel
        version are the same as non-parallel version '''
        
        scores2=[]
        for stim_count in range(nstims):
            fn = vs_fn + str(stim_count) + '.dat'
            curr_volts = nrnMread(fn)
            nindv = len(self.param_values)
            Nt = int(len(curr_volts)/nindv)
            shaped_volts = np.reshape(curr_volts, [nindv, Nt])
            if stim_count == 0:
                scores2 = efel_ext_old.eval([target_volts[0]], shaped_volts,times)

            else:
                stim_scores = efel_ext_old.eval([target_volts[stim_count]], shaped_volts,times)
                for ind in range(len(stim_scores)):
                    scores2[ind] = np.append( scores2[ind],stim_scores[ind])
        equal = True
        for i in range(len(scores2)):
            for j in range(len(scores2[i])):
                if scores2[i][j] != scores[i][j]:
                    equal = False
        return equal
    
    
    def evaluate_with_lists(self,param_values):
        ''' split version of evaluate w/ lists. Currently runs about 10 seconds faster
        but more work can be done to achieve better GPU CPU concurrency'''
        nindv = len(param_values)
        self.batch_size = int(nindv/10) # fastest for 20 so far
        leftover = nindv % 10 # if population is 1001 but batch is 100, last batch needs leftovers
        pool = Pool(nCpus)
        start_time_sim = time.time()
        p_objects = []
        
        for batch in range(0,nindv-leftover,self.batch_size):
            second_lastBatch = (batch + 2*self.batch_size + leftover) == nindv 
            lastBatch = (batch + self.batch_size + leftover) == nindv
            firstbatch = batch == 0
            
            allparams = allparams_from_mapping(param_values[batch:batch+self.batch_size])
            self.param_values = param_values[batch:batch+self.batch_size]
            makeallparams() # this is a command to fix allparams shape for batches of different sizes
            #TODO: it can be improved I think by folding it into allparams file at the end somehow
            
            if lastBatch:
                self.param_values = param_values[batch:nindv]
                 
            if firstbatch: #start running GPU
                 for i in range(nstims):
                    p_objects.append(self.run_model(i,param_values))
                    
            if second_lastBatch: #prepare to run GPU for a possibly different shaped last batch
                allparams = allparams_from_mapping(param_values[batch+self.batch_size:nindv])
                makeallparams() 
            
            waiting_room = np.array([]) # place for processes to wait as it is runnning eval, fills with callbacks
            
            for i in range(nstims):
                p_objects[i].wait()
                fn = vs_fn + str(i) + '.h5'
                curr_volts = nrnMreadH5(fn)
                stim_scores = pool.submit(self.eval_stim_parallel, curr_volts,i) #send out eval as soon as GPU is done
                if not lastBatch:
                    p_objects[i] = self.run_model(i,param_values) #immedietly put GPU for next run back in queue
                waiting_room = np.append(waiting_room, stim_scores)
                
            for i in range(len(waiting_room)):
                if i == 0:
                    batch_scores = waiting_room[i].result()
                else:
                    batch_scores = np.append(batch_scores, waiting_room[i].result(),axis=1) #.result() has our callback
            
            if firstbatch:
                final_scores = batch_scores
            else:
                final_scores = np.append(final_scores, batch_scores, axis=0)
                
            
        #uncomment this to reference parellel version to older version with
        # elemtwise comparison
        #equal = self.compare_scores_to_SG(scores)
        stim_end_time = time.time()
        print ('simulation time took: ', str(stim_end_time-start_time_sim))
        #print ('scoring time took: ', str(time.time()-start_time_scores))
        print ('everything took: ', str(time.time()-start_time_sim))
        #print ( "testing results are the same: ", self.compare_scores_to_SG(scores))
        print("score shape:", np.array(final_scores).shape)

        return final_scores

algo._evaluate_invalid_fitness =neurogpu_multistim_evaluator.my_evaluate_invalid_fitness

