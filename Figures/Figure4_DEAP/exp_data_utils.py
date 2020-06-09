# -*- coding: utf-8 -*-
"""
Created on Mon Jun 17 22:03:24 2019

@author: bensr
"""
import numpy as np
import matplotlib.pyplot as plt
def chunks(l, n):
    for i in range(0, len(l), n):
        yield l[i:i+n]

# Resampling function
def resample(arr, newLength):
    chunkSize = int(len(arr)/newLength)
    return [np.mean(chunk) for chunk in chunks(arr, chunkSize)]
orig_volts_fn =  'C:/Data/Scn2a_Data/Adult_develop_FI/022817H_400_het.txt'
new_volts_fn =  'E:/Workspace/BBP_scn2a/BBP_new_400amp/Data/022817H_400_het.txt'
stim_fn = 'C:/pyNeuroGPU_win2/Data/Stim_raw.csv'
def downsample():
    orig_volts = np.genfromtxt(orig_volts_fn)
    
    new_volts = resample(orig_volts,5000)
    new_volts[:] = [x - 13 for x in new_volts]
    plt.plot(new_volts)
    plt.show()
    return new_volts
def add_initial_silence(volts):
    no_stim = volts[90:490]
    volts =no_stim+ no_stim +no_stim+ volts[:-1200] 
   

    plt.plot(volts)
    plt.show()
    return volts

def make_stim():
    stim = np.zeros(5000)
    stim[2750:3350] = -0.4
    plt.plot(stim)
    plt.show()
    np.savetxt(stim_fn,stim,delimiter=',',newline=',')
    
    
make_stim()
new_volts =  downsample()
#new_volts = add_initial_silence(new_volts)
np.savetxt(new_volts_fn,new_volts,delimiter=' ')

