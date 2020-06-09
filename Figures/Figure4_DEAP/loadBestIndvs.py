# -*- coding: utf-8 -*-
"""
Created on Wed Jun 19 10:30:07 2019

@author: bensr

"""
import pickle
import matplotlib.pyplot as plt
import neuron as nrn
import os
import subprocess
import shutil
import time
from NeuroGPUFromPkl import run_params_with_pkl
from deap import base, creator, tools, algorithms
import numpy as np
import struct
import bluepyopt as bpop
from efel_ext import eval


feature_list = ['voltage_base','steady_state_voltage_stimend','decay_time_constant_after_stim','sag_amplitude','ohmic_input_resistance','voltage_after_stim']

creator.create("FitnessMax", base.Fitness, weights=(-1.0,-1.0,-1.0,-1.0,-1.0,-1.0)) #-1.0,-1.0,-1.0
creator.create("FitnessMulti", base.Fitness, weights=(-1.0,-1.0,-1.0,-1.0,-1.0,-1.0)) #-1.0,-1.0,-1.0

#creator.create("FitnessMulti", base.Fitness, weights=(-1.0,-1.0,-1.0))
creator.create("Individual", list, fitness=creator.FitnessMulti)


model_dir = 'E:/Workspace/BBP_scn2a/BBP_new_400amp'
data_dir = model_dir+'/Data/'
orig_volts_fn = data_dir + './022817H_400_het.txt'
ga_res_fn = model_dir + '/volts/ga_res.txt'
params_table = './params/opt_table.csv'
param_file = './params/best_inds.csv'
run_dir = 'C:/pyNeuroGPU_win2/'
vs_fn = run_dir + 'Data/VHotP.dat'
NPARAMS = 6
orig_volts = np.genfromtxt(orig_volts_fn)
def init_nrngpu():
    global pmin
    global pmax
    global ptarget
    data = np.genfromtxt(params_table,delimiter=',',names=True)
    pmin = data[0]
    pmax = data[1]
    ptarget = data[2]
    modelFile = "./runModel.hoc"
    nrn.h.load_file(modelFile)
    




init_nrngpu()
hocmodel_name =  data_dir + os.path.basename(nrn.h.modelFile)[:-3] + 'pkl'

def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.double)
def nrnMreadOrig(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.float32)


def get_hof():
    fn = 'E:/Workspace/BBP_scn2a/BBP_new_50ampv2/Optim_results/hof.pkl'
    
    f = open(fn, 'rb') 
    best_indvs = pickle.load(f)
    param_mat = np.array(best_indvs)
#    for pind in range(0,NPARAMS):
#        min_p = pmin[pind]
#        max_p = pmax[pind]
#        neg_ind = np.where(param_mat[:,pind]<0)
#        param_mat[neg_ind,pind] = param_mat[neg_ind,pind] *-1
#        p_values = param_mat[:,pind]*(max_p-min_p)+min_p
#        if(min(p_values)<0):
#            print("we have a serious error")
#        param_mat[:,pind] = p_values
    #param_mat[0] = [-79.8, 4.1e-05, 1.953, 0.733] 
    param_mat = param_mat[1:100,:]
    print (param_mat)
    np.savetxt(param_file,param_mat,delimiter=' ')
    if os.path.exists(vs_fn):
        os.remove(vs_fn)
    np.savetxt(param_file,param_mat,delimiter=' ')
    os.chdir(model_dir)
    curr_psize = len(param_mat)
    run_params_with_pkl(hocmodel_name, param_file, curr_psize)
    shutil.move(data_dir + 'AllParams.csv', run_dir + "/Data/AllParams.csv")
    time.sleep(1)
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
    f.close()
    return all_volts

def get_efels(volts):
    times = np.linspace(0,499.9,5000)
    efels = eval([orig_volts], volts,times)
    mins_inds = np.argmin(efels,0)
    print (mins_inds)
    curr_feature = 0
    for i in mins_inds:
        print('i is ',str(i),'feature is ', feature_list[curr_feature] )
        curr_feature = curr_feature + 1
        curr_volt = volts[i]
        plt.plot(times,orig_volts,'r',times,curr_volt,'b')
        plt.show()
    return efels
    
    
    


def similiar(indv1,indv2):
    ans = 0
    for ind in range(len(indv1)):
        ans = ans + abs(indv1[ind] - indv2[ind])
    if(ans<0.01):
        return True
    return False

        
def print_best_volts():
    all_volts = get_hof()
    #all_volts = np.genfromtxt(ga_res_fn,delimiter=',')
    time = np.linspace(0,499.9,5000)
    for curr_volt in all_volts:
        #plt.plot(time,orig_volts,'r',time,curr_volt[:-1],'b')
        plt.plot(time,orig_volts,'r',time,curr_volt,'b')
        plt.show()
        
    





all_volts = get_hof()
efels = get_efels(all_volts)
#print_best_volts()