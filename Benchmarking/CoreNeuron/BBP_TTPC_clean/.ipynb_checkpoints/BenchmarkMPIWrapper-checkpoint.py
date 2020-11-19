# -*- coding: utf-8 -*-
"""
Created on Thu Oct  8 10:34:19 2020

@author: bensr
"""

from IPython import get_ipython
import time
ip = get_ipython()
file1 = open("timenrnpar.txt", "w")  
file1.close()
#ip.run_cell("!mpiexec -n 4 nrniv -python -mpi test.py")
#ip.run_cell("!mpiexec -n 4 python NeuronBenchmark.py")
import time
times=[]
nneurons = [1,2,4,8,16,32,64,128,256,512,1024,2048,4096,8192]
#nneurons = [1,2,4,8,16]
for N in nneurons:
    file1 = open("timenrnpar2.txt", "a")  
    start_time = time.time()
    ip.run_cell(f'!mpiexec -n 8 python RunTTPC1Parallel.py {N}')
    curr_time = time.time() - start_time
    times.append((time.time() - start_time))
    file1.write(f'{N} - {curr_time}\n')
    file1.close()
