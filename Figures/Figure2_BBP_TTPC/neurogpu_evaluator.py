import numpy as np
import os
import subprocess
import shutil
import neuron as nrn
import bluepyopt as bpop

import struct
import time
import pandas as pd
import efel_ext
import matplotlib.pyplot as plt
import bluepyopt.deapext.algorithms as algo
from NeuroGPUFromPkl import run_params_with_pkl
run_file = './run_model_genetic_optimizer.hoc'
params_table = './params/opt_table.csv'
model_dir = 'E:/Workspace/BBP_scn2a/BBP_new_400amp'
param_file = model_dir + '/params/gen.csv'
data_dir = model_dir+'/Data/'
run_dir = 'C:/pyNeuroGPU_win2/'
orig_volts_fn = data_dir + './022817H_400_het.txt'
vs_fn = run_dir + 'Data/VHotP.dat'
times_file_path = 'E:/Workspace/BBP_scn2a/BBP_new/Stims/times.csv'

target_volts = [np.genfromtxt(orig_volts_fn)]
times =  np.cumsum(np.genfromtxt(times_file_path))

modelFile = "./runModel.hoc"
nrn.h.load_file(modelFile)
hoc_pkl = data_dir + os.path.basename(nrn.h.modelFile)[:-3] + 'pkl'
old_eval = algo._evaluate_invalid_fitness
def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.double)








class neurogpu_evaluator(bpop.evaluators.Evaluator):
    def __init__(self):
        """Constructor"""
        def read_with_genfromtxt(path, type=float, delim=None):
            r = np.genfromtxt(path, dtype=type, delimiter=delim)
            if np.shape(r) == ():
                return np.array([r.item()])
            return r
        super(neurogpu_evaluator, self).__init__()
        
        data = np.genfromtxt(params_table,delimiter=',',names=True)
        self.pmin = data[0]
        self.pmax = data[1]
        self.ptarget = data[2]
        
        params = []
        for i in range(len(self.pmin)):
            params.append(bpop.parameters.Parameter('p' + str(i), bounds=(self.pmin[i],self.pmax[i])))
        
        self.params = params
        
        #self.opt_stim_list = read_with_genfromtxt(opt_stim_name_list, str, ' ')
        # ['mean_frequency', 'adaptation_index', 'time_to_first_spike', 'mean_AP_amplitude', 'AHP_depth', 'spike_half_width']
        # ['voltage_base','steady_state_voltage_stimend','decay_time_constant_after_stim']
        
        
        
        self.objectives = [bpop.objectives.Objective('voltage_base'),\
                           bpop.objectives.Objective('steady_state_voltage_stimend'),\
                           bpop.objectives.Objective('decay_time_constant_after_stim'),\
                           bpop.objectives.Objective('sag_amplitude'),\
                           bpop.objectives.Objective('ohmic_input_resistance'),\
                           bpop.objectives.Objective('voltage_deflection'),\
                           bpop.objectives.Objective('voltage_deflection_vb_ssse'),\
                           bpop.objectives.Objective('sag_ratio1'),\
                           bpop.objectives.Objective('sag_ratio2'),\
                           bpop.objectives.Objective('voltage_after_stim')
                           
                          
                           ]
        #self.toolbox.register("evaluate", self.evaluator.evaluate_with_lists)
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
    def run_model(self,population):
        param_mat = np.array(population)
        if os.path.exists(vs_fn):
            os.remove(vs_fn)
        np.savetxt(param_file,param_mat,delimiter=' ')
        os.chdir(model_dir)
        curr_psize = len(population)
        run_params_with_pkl(hoc_pkl, param_file, curr_psize)
        shutil.move(data_dir + 'AllParams.csv', run_dir + "/Data/AllParams.csv")
        #time.sleep(1)
        os.chdir(run_dir + '/x64/')
        print("call neurogpu6")
        subprocess.call('NeuroGPU6.exe')
        while not os.path.exists(vs_fn):
            time.sleep(10)
            subprocess.call('NeuroGPU6.exe')
            print("call neurogpu6 again")
        #file exists
        volts = nrnMread(vs_fn)
        Nt = int(len(volts)/curr_psize)
        all_volts = np.reshape(volts, [curr_psize, Nt])
        print('params are:')
        print(population[0])
        plt.plot(all_volts[0],'r')
        plt.plot(target_volts[0],'b')
        
        
        plt.show()
        return all_volts
   
    


    def evaluate_with_lists(self,param_values):
        volts = self.run_model(param_values)
        scores = efel_ext.eval(target_volts, volts,times)
        #data_volts_list = run_model(param_values, self.opt_stim_list)
        #score = efel_ext.eval(self.opt_stim_list, self.target_volts_list, data_volts_list)
        # This should be a list
        #return score
        return scores



algo._evaluate_invalid_fitness =neurogpu_evaluator.my_evaluate_invalid_fitness







