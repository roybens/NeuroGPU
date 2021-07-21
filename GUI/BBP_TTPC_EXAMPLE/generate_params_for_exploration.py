# -*- coding: utf-8 -*-
"""
Created on Tue Apr  9 15:34:15 2019

@author: bensr
"""
import numpy as np
data_folder = 'E:\\Workspace\\BBP_new_PE'
opt_table_fn = data_folder + '\\params\\opt_table.csv'
table = np.genfromtxt(opt_table_fn, dtype=float, delimiter=',', names=True) 
lb = table[0]
ub = table[1]
base = table[2].tolist()
param1 = np.linspace(0, 10, 100)
param2 = np.linspace(0, 20, 100)
params = []
for p1 in param1:
    for p2 in param2:
        curr_param =np.copy(base)
        curr_param[0] = p1
        curr_param[2] = p2
        params.append(curr_param)
np.savetxt('E:\\BBP_new\\params\\params_explor10000bigK.csv',params,delimiter=' ')