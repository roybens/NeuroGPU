import h5py
import subprocess
import pandas as pd
import csv
import numpy as np






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
    
    