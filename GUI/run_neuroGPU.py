import numpy as np
import os
import pandas as pd

model_dir = 'pyNeuroGPU_unix/'
data_dir = os.path.join(model_dir, 'Data')
param_dir = os.path.join(model_dir, 'params')

param_file = os.path.join(model_dir,'params','gen.csv')
opt_table_fn = os.path.join(data_dir,'opt_table.csv')
run_dir = model_dir
vs_fn = os.path.join(run_dir,'Data', 'VHotP3.dat')
orig_volts = os.path.join(model_dir, 'Data', 'volts' , 'orig_step.dat')

def gen_params():
    table = np.genfromtxt(opt_table_fn, dtype=float, delimiter=',', names=True) 
    df = pd.read_csv(opt_table_fn)
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
    np.savetxt(os.path.join(data_dir, 'params', 'params_explor10000bigK.csv'),params,delimiter=',')
    
def my_gen_params():
    table = np.genfromtxt(opt_table_fn, dtype=float, delimiter=',', names=True) 
    df = pd.read_csv(opt_table_fn)
    lb = table[0]
    ub = table[1]
    base = np.genfromtxt("pyNeuroGPU_unix/params/params.csv")
    param1 = np.linspace(0, 10, 100)
    param2 = np.linspace(0, 20, 100)
    params = []
    for p1 in param1:
        for p2 in param2:
            curr_param =np.copy(base)
            curr_param[0] = p1
            curr_param[2] = p2
            params.append(curr_param)
    np.savetxt(os.path.join(param_dir, 'params_explor10000bigK.csv'),params,delimiter=',')
    print("saved params to ", os.path.join(param_dir, 'params_explor10000bigK.csv'))

    
if __name__ == "__main__":
    gen_params()