import h5py
import subprocess
import pandas as pd
import csv


filename = "../Data/AllParams.csv"


print("running stim ind" + str(1))
p_object = subprocess.Popen(['../bin/neuroGPU',str(1)]) 
p_object.wait()