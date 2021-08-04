import os
import numpy as np
import matplotlib.pyplot as plt
import struct
import h5py
import numpy as np
import matplotlib.pyplot as plt
import pickle
from extractModel_mappings import   allparams_from_mapping
import subprocess
import csv
import bluepyopt as bpop
import shutil, errno
import pandas as pd

#os.chdir("NeuroGPU/NeuroGPU_Base/VS/pyNeuroGPU_win2/NeuroGPU6/python/")


## set up filepaths
paramsCSV = '../params/params.csv'
data_dir = '../Data/'
run_dir = '../bin'
vs_fn = '/tmp/Data/VHotP'
ntimestep = 100000
nstims = 1

nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])



if not os.path.isdir('/tmp/Data'):
    os.mkdir('/tmp/Data')
    


def copyanything(src, dst):
    try:
        shutil.copytree(src, dst)
    except OSError as exc: # python >2.5
        if exc.errno == errno.ENOTDIR:
            shutil.copy(src, dst)
        else: raise


def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    return np.fromfile(f,np.double)


def nrnMreadH5(fileName):
    f = h5py.File(fileName,'r')
    dat = f['Data'][:][0]
    return np.array(dat)


def readParamsCSV(fileName):
    fields = ['Param name', 'Base value','Lower bound', 'Upper bound']
    df = pd.read_csv(fileName,skipinitialspace=True, usecols=fields)
    
    paramsList = [tuple(x) for x in df.values]
    return paramsList


        
def run_model(stim_ind,real_ind):
    """
    Parameters
    -------------------------------------------------------
    stim_ind: index to send as arg to neuroGPU 
    params: DEPRECATED remove

    Returns
    ---------------------------------------------------------
    p_object: process object that stops when neuroGPU done
    """
    global_rank = 0
    volts_fn = vs_fn + str(stim_ind) + '.h5'
    if os.path.exists(volts_fn):
        #print("removing ", volts_fn, " from ", global_rank)
        #os.remove(volts_fn)
        pass
    #!{'../bin/neuroGPU'+str(global_rank),str(stim_ind), str(global_rank)}
    p_object = subprocess.Popen(['../bin/neuroGPU',str(stim_ind)],
                    stdout=subprocess.PIPE, 
                    stderr=subprocess.STDOUT,  # <-- redirect stderr to stdout
                    bufsize=1)
    
    with p_object.stdout:
        for line in iter(p_object.stdout.readline, b''):
            print(line),
    p_object.wait()
    print(p_object.stderr)
    #os.rename(volts_fn,'/tmp/Data/VHotP'+str(real_ind)+'.h5')

    return p_object

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

def getVolts(idx):
    '''Helper function that gets volts from data and shapes them for a given stim index'''
    fn = vs_fn + str(idx) +  '.h5'    #'.h5' 
    curr_volts =  nrnMreadH5(fn)
    #fn = vs_fn + str(idx) +  '.dat'    #'.h5'
    #curr_volts =  nrnMread(fn)
    Nt = int(len(curr_volts)/ntimestep)
    shaped_volts = np.reshape(curr_volts, [Nt,ntimestep])
    return shaped_volts




def main():
    nstims = 8 # only running first 8 stims


    ###### TEN COPIES OF ORIG PARAMS FOR DEBUG #################
    param_values =  np.genfromtxt(paramsCSV)
    print(param_values.shape,  " : param value shape")
       
    ###### CREATE MAPPING ################# 
    #allparams_from_mapping(param_values)
    run_model(0,0)
    data = nrnMread("../Data/VHotP0.dat")
    print(np.max(data))

#     # run neuroGPU -- set up for either ONE gpu or 8
#     if nGpus == 1: 
#         for i in range(0,nstims):
#             if i != 0:
#                 # swaps stim0.csv and times0.csv for stimi.csv and timesi.csv
#                 stim_swap(0,i)
#                 # run ...  wait is built into run model
#                 run_model(0,i)
#             else: 
#                 run_model(0,0)
#     else:
#         for i in range(0,nstims):
#             # run ...  wait is built into run model
#             run_model(i,i)




if __name__ == "__main__":
    main()
#     for file in os.listdir('../Data'):
#         if 'h5' in file:
#             print("replacing: ", file)
#             os.remove('../Data/' + file)

#     for file in os.listdir('/tmp/Data'):
#         shutil.move("/tmp/Data/"+ file, "../Data/" + file)