import numpy as np
import os
import subprocess
import shutil
import bluepyopt as bpop
import struct
import time
import pandas as pd
import efel_ext as efel_ext
import time
import glob
import ctypes
import matplotlib.pyplot as plt
import bluepyopt.deapext.algorithms as algo
from extractModel_mappings_linux import   allparams_from_mapping
import h5py

model_dir = '../'
param_file ='./params/gen.csv'
data_dir = model_dir+'/Data/'
params_table = data_dir + 'opt_table.csv'
run_dir = '../bin'
orig_volts_fn = data_dir + './exp_data.csv'
vs_fn = model_dir + 'Data/VHotP'
times_file_path = model_dir + 'Data/times.csv'
nstims = 2
target_volts = np.genfromtxt(orig_volts_fn)
times =  np.cumsum(np.genfromtxt(times_file_path,delimiter=','))
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



class hoc_evaluator(bpop.evaluators.Evaluator):
    def __init__(self):
        #for fl in glob.glob(vs_fn + "*"):
        #    os.remove(fl)
        """Constructor"""
        def read_with_genfromtxt(path, type=float, delim=None):
            r = np.genfromtxt(path, dtype=type, delimiter=delim)
            if np.shape(r) == ():
                return np.array([r.item()])
            return r
        super(hoc_evaluator, self).__init__()
        
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
        volts_fn = vs_fn + str(stim_ind) + '.dat'
        if os.path.exists(volts_fn):
            os.remove(volts_fn)
        p_object = subprocess.Popen(['../bin/neuroGPU',str(stim_ind)])
        return p_object
   

    def evaluate_with_lists(self,param_values):
        nindv = len(param_values)
        allparams = allparams_from_mapping(param_values)
        scores=[]
        start_time_sim = time.time()
        print('running stim #')
        p_objects = []
        for i in range(nstims):
            p_objects.append(self.run_model(i,param_values))
        stim_count = 0
        for p_obj in p_objects:
            p_obj.wait()
            if stim_count == 0:
                stim_end_time = time.time()
            fn = vs_fn + str(stim_count) + '.dat'
            curr_volts = nrnMread(fn)
            Nt = int(len(curr_volts)/nindv)
            shaped_volts = np.reshape(curr_volts, [nindv, Nt])
            if stim_count == 0:
                start_time_scores = time.time()
                print("volts:", shaped_volts[0],"break", shaped_volts[10])
                scores = efel_ext.eval([target_volts[7]], shaped_volts,times)
            else:
                stim_scores = efel_ext.eval([target_volts[stim_count]], shaped_volts,times)
                for ind in range(len(stim_scores)):
                    scores[ind] = np.append( scores[ind],stim_scores[ind])
            stim_count +=1
        print ('simulation time took: ', str(stim_end_time-start_time_sim))
        print ('scoring time took: ', str(time.time()-start_time_scores))
        print ('everything took: ', str(time.time()-start_time_sim))
        print(scores.shape, "SCORES FINAL SHAPE")
        return scores

algo._evaluate_invalid_fitness =hoc_evaluator.my_evaluate_invalid_fitness