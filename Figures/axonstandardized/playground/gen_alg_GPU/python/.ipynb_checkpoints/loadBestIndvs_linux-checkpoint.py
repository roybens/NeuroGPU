# -*- coding: utf-8 -*-
"""
Created on Wed Jun 19 10:30:07 2019

@author: bensr

"""
import pickle
import matplotlib.pyplot as plt
from extractModel_mappings_linux import   allparams_from_mapping
import os
import subprocess
import shutil
import time
from deap import base, creator, tools, algorithms
import numpy as np
import struct
import bluepyopt as bpop
from efel_ext import eval


feature_list = ['voltage_base','steady_state_voltage_stimend','decay_time_constant_after_stim','sag_amplitude','ohmic_input_resistance','voltage_after_stim']
feature_list =  ['voltage_base','AP_amplitude','voltage_after_stim','peak_time','spike_half_width','AHP_depth','chi']
creator.create("FitnessMax", base.Fitness, weights=(-1.0,-1.0,-1.0,-1.0,-1.0,-1.0)) #-1.0,-1.0,-1.0
creator.create("FitnessMulti", base.Fitness, weights=(-1.0,-1.0,-1.0,-1.0,-1.0,-1.0)) #-1.0,-1.0,-1.0

#creator.create("FitnessMulti", base.Fitness, weights=(-1.0,-1.0,-1.0))
creator.create("Individual", list, fitness=creator.FitnessMulti)


model_dir = '../'

data_dir = model_dir+'/Data/'
params_table = data_dir + 'opt_table.csv'
run_dir = '../bin'
orig_volts_fn = data_dir + './exp_data.csv'
vs_fn = model_dir + 'Data/VHotP'
times_file_path = model_dir + 'Data/times.csv'
nstims = 8
ga_res_fn = model_dir + '/volts/ga_res.txt'

stim_ind = 7
NPARAMS = 9
nindvs = 1000
orig_volts = np.genfromtxt(orig_volts_fn)[stim_ind,:]
def init_nrngpu():
    global pmin
    global pmax
    global ptarget
    data = np.genfromtxt(params_table,delimiter=',',names=True)
    pmin = data[0]
    pmax = data[1]
    ptarget = data[2]
init_nrngpu()

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
    fn = time.strftime("_%d_%b_%Y")
    fn = fn + ".pkl"
    print("best_indvs_final"+fn)
    output = open("best_indvs_final"+fn, 'rb')
    best_indvs = pickle.load(output)
    print("best inds:", best_indvs)

    
    output = open("log"+fn, 'rb')
    log = pickle.load(output)
    print("log:", log)
    output.close()
    
    output = open("hst"+fn, 'r')
    hst = pickle.load(output)
    output.close()
    
    output = open("hof"+fn, 'r')
    hof = pickle.load(output)
    output.close()
    
#     f = open(fn, 'rb') 
#     best_indvs = pickle.load(f)
#     param_mat = np.array(best_indvs)
#     param_mat = param_mat[0:nindvs,:]
#     print (param_mat)
#     allparams = allparams_from_mapping(param_mat)
#     volts_fn = vs_fn + str(stim_ind) + '.dat'
#     if os.path.exists(volts_fn):
#             os.remove(volts_fn)
#     p_object = subprocess.Popen(['../bin/neuroGPU',str(stim_ind)])
#     p_object.wait()
#     curr_volts = nrnMread(volts_fn)
#     Nt = int(len(curr_volts)/nindvs)
#     shaped_volts = np.reshape(curr_volts, [nindvs, Nt])
#     return shaped_volts

def get_efels(volts):
    times = np.linspace(0,999.9,5000)
    
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
    print(all_volts)
    #all_volts = np.genfromtxt(ga_res_fn,delimiter=',')
    time = np.linspace(0,999.9,5000)
    for curr_volt in all_volts:
        #plt.plot(time,orig_volts,'r',time,curr_volt[:-1],'b')
        plt.plot(time,orig_volts,'r',time,curr_volt,'b')
        plt.show()
        
    





all_volts = get_hof()
#efels = get_efels(all_volts)
#print_best_volts()