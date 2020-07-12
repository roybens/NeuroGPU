# -*- coding: utf-8 -*-
"""
Created on Mon Jun 17 22:03:24 2019

@author: bensr
"""
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
def chunks(l, n):
    for i in range(0, len(l), n):
        yield l[i:i+n]

# Resampling function
def resample(arr, newLength):
    chunkSize = int(len(arr)/newLength)
    return [np.mean(chunk) for chunk in chunks(arr, chunkSize)]

def downsample():
    orig_volts = np.genfromtxt(orig_volts_fn)
    
    new_volts = resample(orig_volts,5000)
    new_volts[:] = [x - 12 for x in new_volts]
    plt.plot(new_volts)
    plt.show()
    return new_volts
def add_initial_silence(volts):
    no_stim = volts[90:490]
    volts =no_stim+ no_stim +no_stim+ volts[:-1200] 
   

    plt.plot(volts)
    plt.show()
    return volts

def make_stim(amp):
    stim = np.zeros(5000)
    stim[500:2000] = amp
    plt.plot(stim)
    plt.show()
    #np.savetxt(stim_fn,stim,delimiter=',',newline=',')
    return stim
    
 
    
def get_exp_data():
    raw_data = np.genfromtxt('./Data/exp_data_raw.csv',delimiter=',', names=True)
    stims_amp = [0.200 + 0.02*i for i in range(8)]
    headers = ['exp' + str(i) for i in stims_amp]
    all_stims = []
    all_recs = []
    for curr_amp in stims_amp:
        curr_stim = make_stim(curr_amp)
        all_stims.append(curr_stim)
        curr_rec = raw_data['exp'+str(int(1000*curr_amp))]
        new_rec =  signal.resample(curr_rec,5000)
        new_rec[:] = [x  for x in new_rec]
        all_recs.append(new_rec)
        plt.plot(new_rec,'blue')
        plt.show()
        plt.plot(curr_rec,'black')
        plt.show()
    np.savetxt('stims2.csv',all_stims)
    np.savetxt('exp_data2.csv',all_recs)
    
#orig_volts_fn =  'C:/Data/Scn2a_Data/Adult_develop_FI/022817H_400_het.txt'
#new_volts_fn =  'E:/Workspace/BBP_scn2a/BBP_new_400amp/Data/022817H_400_het.txt'
#stim_fn = 'C:/pyNeuroGPU_win2/Data/Stim_raw.csv'    
get_exp_data()    
#make_stim()
#new_volts =  downsample()
#new_volts = add_initial_silence(new_volts)
#np.savetxt(new_volts_fn,new_volts,delimiter=' ')

