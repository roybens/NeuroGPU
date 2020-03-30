import numpy as np
import os
import subprocess
import shutil
import bluepyopt as bpop
import struct
import time
import pandas as pd
import efel_ext
import time
import matplotlib.pyplot as plt
import bluepyopt.deapext.algorithms as algo
from mpi4py import MPI

comm = MPI.COMM_WORLD
#nproc = comm.Get_size()
nproc = 8
rank = comm.Get_rank()
print('my rank is ' + str(rank))
pop_divider = 5

model_dir = '../'
param_file ='./params/gen.csv'
data_dir = model_dir+'/Data/'
params_table = data_dir + 'opt_table.csv'
run_dir = '../bin'
orig_volts_fn = data_dir + './exp_data.csv'
vs_fn = run_dir + 'Data/VHotP.dat'
times_file_path = model_dir + 'Data/times.csv'
nstims = 4

target_volts = np.genfromtxt(orig_volts_fn)
times =  np.cumsum(np.genfromtxt(times_file_path,delimiter=','))
#times = times[:-1]


old_eval = algo._evaluate_invalid_fitness
def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.double)








class neurogpu_multistim_evaluator(bpop.evaluators.Evaluator):
    def __init__(self):
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
                           bpop.objectives.Objective('chi_4')
                          
                           ]
        #self.toolbox.register("evaluate", self.evaluator.evaluate_with_lists)
    def my_evaluate_invalid_fitness(toolbox, population):
        '''Evaluate the individuals with an invalid fitness

        Returns the count of individuals with invalid fitness
        '''
        if rank == 0:
            
            invalid_ind = [ind for ind in population if not ind.fitness.valid]
            invalid_ind = [population[0]] + invalid_ind 
            fitnesses = toolbox.evaluate(invalid_ind)
        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit

        return len(invalid_ind)
    def run_model(self,population):
        all_volts = []
        param_mat = np.array(population)
        if os.path.exists(vs_fn):
            os.remove(vs_fn)
        
        os.chdir(model_dir)
        np.savetxt(param_file,param_mat,delimiter=' ')
        curr_psize = len(population)
        #run_params_with_pkl(hoc_pkl, param_file, curr_psize)
        shutil.move(data_dir + 'AllParams.csv', run_dir + "/Data/AllParams.csv")
        #time.sleep(1)
        print('params are:')
        print(population[0])
        for stim_ind in range(4):
            if os.path.exists(vs_fn):
                os.remove(vs_fn)
            stim_ind +=1
            shutil.copy(run_dir + "/Data/Stim_raw" + str(stim_ind) + ".csv", run_dir + "/Data/Stim_raw.csv")
            os.chdir(run_dir + '/x64/')
            print("call neurogpu6")
            subprocess.call('NeuroGPU6.exe')
            while not os.path.exists(vs_fn):
                time.sleep(10)
                subprocess.call('NeuroGPU6.exe')
                print("call neurogpu6 again")
        #file exists
            volts = nrnMread(vs_fn)
            os.remove(run_dir + "/Data/Stim_raw.csv")
            Nt = int(len(volts)/curr_psize)
            shaped_volts = np.reshape(volts, [curr_psize, Nt])
            plt.plot(shaped_volts[0],'r')
            plt.plot(target_volts[stim_ind-1][:],'black')
            plt.show()
            all_volts.append(shaped_volts)
            
        return all_volts
   
    


    def evaluate_with_lists(self,param_values):
        
        scores=[]
        st_inds_pop = np.linspace(0,len(param_values),num=pop_divider+1,dtype=int)
        
        # dividing the population to peices ideally ~1000 (see figure BBP)
        for i in range(len(st_inds_pop)-1):
            st_ind = st_inds_pop[i]
            end_ind = st_inds_pop[i+1]
            curr_pop = param_values[st_ind:end_ind]
				##Write allparams.csv Here.
            for curr_stim in range(nstims):
					#self.run_model(curr_stim)
                if rank == 0:
                    print('running stim #' + str(curr_stim))
                    time.sleep(1)
                    curr_volts = np.random.randint(-120,50,size=(len(curr_pop),5000))
                    st_inds_volts = np.linspace(0,len(curr_volts),num=nproc+1,dtype=int)
					#divide volts to nprocessors segments and scatter them
                    scattered_volts = []
                    for proc_ind in range(len(st_inds_volts)-1):
                        curr_st = st_inds_volts[proc_ind]
                        curr_end = st_inds_volts[proc_ind+1]
                        scattered_volts.append( curr_volts[curr_st:curr_end-1][:])     
                comm.scatter(scattered_volts,root=0)
                proc_scores = efel_ext.eval([target_volts[curr_stim]], scattered_volts,times)
                stim_scores = comm.gather(proc_scores, root=0)
                scores.append(stim_scores)
        
                    
        # #scores = efel_ext.eval([target_volts[0]], volts[0],times) #IS THIS NECESSARY???
        # for volts_ind in range(len(scattered_volts)):
        #     curr_scores = efel_ext.eval([target_volts[volts_ind]], volts[volts_ind],times)
        #     for ind in range(len(curr_scores)):
        #         scores[ind] = np.append( scores[ind],curr_scores[ind])
                
        #data_volts_list = run_model(param_values, self.opt_stim_list)
        #score = efel_ext.eval(self.opt_stim_list, self.target_volts_list, data_volts_list)
        # This should be a list
        #return score
        
        return scores
algo._evaluate_invalid_fitness =neurogpu_multistim_evaluator.my_evaluate_invalid_fitness






