import unittest
import sys, os
from mpi4py import MPI
import csv
comm = MPI.COMM_WORLD
import h5py
objectives_file = h5py.File('./objectives/multi_stim_bbp_full_allen_gpu_tune_18_stims.hdf5', 'r')
opt_weight_list = objectives_file['opt_weight_list'][:]
opt_stim_name_list = objectives_file['opt_stim_name_list'][:]
score_function_ordered_list = objectives_file['ordered_score_function_list'][:]

from unittest.mock import patch
nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])
size = comm.Get_size()
if size > 1:
    global_rank = comm.Get_rank()
    from hoc_evaluatorGPU_allen_MPI import hoc_evaluator
else:
    from hoc_evaluatorGPU_allen_par import hoc_evaluator
##################
# run same tests but for allen_MPI
##################
import numpy as np
import struct
import unittest
from contextlib import contextmanager
import optimize_parameters_genetic_alg
import subprocess
from extractModel_mappings_linux import   allparams_from_mapping
import multiprocessing
import h5py


# Number of timesteps for the output volt.
ntimestep = 10000
model_dir = '..'
data_dir = model_dir+'/Data/'
run_dir = '../bin'
vs_fn = '/tmp/Data/VHotP'
nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])
nCpus =  multiprocessing.cpu_count()
objectives_file = h5py.File('./objectives/multi_stim_bbp_full_allen_gpu_tune_18_stims.hdf5', 'r')
opt_weight_list = objectives_file['opt_weight_list'][:]
opt_stim_name_list = objectives_file['opt_stim_name_list'][:]

def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    file = np.fromfile(f,np.double)
    file.close()
    return file

def nrnMreadH5(fileName):
    f = h5py.File(fileName,'r')
    dat = f['Data'][:][0]
    return np.array(dat)
@contextmanager
def suppress_stdout():
    with open(os.devnull, "w") as devnull:
        old_stdout = sys.stdout
        sys.stdout = devnull
        try:  
            yield
        finally:
            sys.stdout = old_stdout

def nrnMread(fileName):
    f = open(fileName, "rb")
    nparam = struct.unpack('i', f.read(4))[0]
    typeFlg = struct.unpack('i', f.read(4))[0]
    res = np.fromfile(f,np.double)
    f.close      
    return res


class test_neuroGPU(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        print('initializing')
        if not os.path.isdir("/tmp/Data"):
            os.mkdir("/tmp/Data")
        
    def setUp(self):
        self.NG = hoc_evaluator()
        self.NG.nindv = 1
        self.ntimesteps = 0
        print('initialized')
        
        
        stim_fn = "../Data/Stim_meta.csv"
        f =  open(stim_fn)
        reader = csv.reader(f, delimiter=',', )
        data = []
        for row in reader:
            data.append([elem for elem in row])
        data = np.array(data)
        assert float(data[1]) > 1000 # makes sure there are more than 1000 timesteps
        self.ntimesteps = float(data[1])
        
        f.close()

    def test_initialization(self):
        """
        1. check that starting param bounds are correct
        2. check volts are shaped (stims, ntimesteps)
        """
        assert(len(self.NG.pmin) > 12)
        for i in range(len(self.NG.pmin)):
            assert self.NG.pmin[i] <= self.NG.pmax[i]
                        
        # check target volt shape and stim list shape
        targ_volts_shape = np.array(self.NG.target_volts_list).shape
        assert targ_volts_shape[0] == len(self.NG.opt_stim_list)
        assert targ_volts_shape[1] == ntimestep
        
    def test_run_model_dat(self):
        """runs unit test for neuroGPU src code"""
        allparams = allparams_from_mapping(np.reshape(self.NG.orig_params,(1,-1)))
        if size > 1:
            #start running neuroGPU
            stim_range = np.arange(nGpus) + (nGpus * global_rank)
            p_objects = []
            for stim_num in stim_range:
                adjusted_ind = stim_num % nGpus
                p_objects.append(self.NG.run_model(adjusted_ind, []))
            for p_object in p_objects:
                p_object.wait()
                
        else:
            p_object = self.NG.run_model(0,[])
            p_object.wait()
            fn = '/tmp/Data/VHotP' + str(0) +  '.h5'
            curr_volts =  nrnMreadH5(fn)
            assert np.isnan(curr_volts).any() ==  False
            Nt = int(len(curr_volts)/self.NG.nindv)
            self.NG.data_volts_list = np.reshape(curr_volts, [self.NG.nindv, Nt])
    
        
    def test_writingDTSandStims(self):
        """ tests that everything is being ran during runtime"""
        if size > 1:
            self.NG.convert_allen_data(18)
        else:
            self.NG.convert_allen_data()
        comm.Barrier() 
        for i in range(len(self.NG.opt_stim_list)):
            old_stim = "../Data/Stim_raw" + str(i) + ".csv"
            old_time = "../Data/times_"  + str(i) + ".csv"
            assert os.path.exists(old_stim)
    
    def test_StimDataShape(self):
        """
        check that stim data is one dimensional
        """
        stim_fn = "../Data/Stim_raw" + str(0) + ".csv"
        f =  open(stim_fn,'r')
        stim = np.fromfile(f)
        f.close
        #check that stim data is one dimensional 
        assert stim.shape[0] > 1
        assert len(stim.shape) == 1
        
    def test_StimDataElem(self):
        """ 
        range check format of stim data element
        """
        stim_fn = "../Data/Stim_raw" + str(0) + ".csv"
        f =  open(stim_fn)
        reader = csv.reader(f, delimiter=',', lineterminator='\n')
        for row in reader:
            assert float("".join(row)) > -10000 #some general range for the currents to be in
            assert float("".join(row)) < 10000
        f.close
    
    def test_StimDataTimsteps(self):
        """
        Check that there are more than 1000 timesteps
        """
        stim_fn = "../Data/Stim_raw" + str(0) + ".csv"
        f =  open(stim_fn)
        reader = csv.reader(f, delimiter=',', lineterminator='\n')
        data = np.array([row for row in reader])
        assert data.shape[0] > 1000 # usemore than 1000 timsteps 
        f.close
    
    def test_DTElem(self):
        """
        Check all the elements of timesteps, they should be in range (-1,1)
        """
        stim_fn = "../Data/times" + str(0) + ".csv"
        f =  open(stim_fn)
        reader = csv.reader(f, delimiter=',')
        for row in reader:
            for elem in row:
                assert float(elem) > -1 #some general range for timsteps to be in
                assert float(elem) < 1
        f.close
        
    def test_TimesDataTimsteps(self):
        """
        Test that you have set correct number of timesteps
        """
        stim_fn = "../Data/times" + str(0) + ".csv"
        f =  open(stim_fn)
        reader = csv.reader(f, delimiter=',', )
        data = []
        for row in reader:
            data.append([elem for elem in row])
        data = np.array(data)
        assert data.shape[0] > 1000  or   data.shape[1] > 1000# usemore than 1000 timsteps 
        if data.shape[1] > 1000:
            self.ntimesteps = data.shape[1]
        else:
            self.ntimesteps = data.shape[0]
        f.close
        
    def test_MyVolts(self):
        """
        test that there is a voltage at each timestep
        """
        if size > 1:
            pass # maybe write test here, but pretty sure this is handled by getVolts function better in hoc eval
        else:
            fn = '/tmp/Data/VHotP' + str(0) +  '.h5'
            curr_volts =  nrnMreadH5(fn)
            assert self.ntimesteps == len(curr_volts)*self.NG.nindv
    
    
        
    def test_eval_funct(self):
        """assert score is the right shape from eval function"""
        if size > 1:
            if global_rank == 0:
                self.NG.convert_allen_data(18)
        else:
            self.NG.convert_allen_data()
        fn = vs_fn + str(0) +  '.h5'    #'.h5'
        curr_volts =  nrnMreadH5(fn)
        assert np.isnan(curr_volts).any() ==  False
        Nt = int(len(curr_volts)/self.NG.nindv)
        self.NG.data_volts_list = np.reshape(curr_volts, [1,self.NG.nindv, Nt])
        self.NG.data_volts_list = np.repeat(self.NG.data_volts_list,nGpus, axis =0 )
        self.NG.targV = self.NG.target_volts_list
        allen_stim_file = h5py.File('../run_volts_bbp_full_gpu_tuned/stims/allen_data_stims_10000.hdf5', 'r')
        self.NG.dts = [allen_stim_file[stim.decode("utf-8") + '_dt'][:][0] for stim in opt_stim_name_list]  
        if size > 1:
            score = self.NG.map_par()
        else:
            score = self.NG.map_par(0)
        assert score.shape[0] == self.NG.nindv
        assert score.shape[1] == nGpus
    
    def test_topSfPicker(self):
        """
        Test that score function mapping pair that gets mapped in parallel
        matches the correct weight/score function number.
        """
        if size > 1:
            fxnsNStims = self.NG.top_SFs()
            first_stim = 0
            last_stim = 10
            
        else:
            fxnsNStims = self.NG.top_SFs(0)
            first_stim = 0
            last_stim = 3
        prev_sf_idx = 0 
        for i in range(first_stim, last_stim):  # iterate stims and sum
            num_curr_sfs = sum([1 for pair in fxnsNStims if pair[0]==i]) #find how many sf indices for this stim
            pairs_matching_stim_num = [pair for pair in fxnsNStims if pair[0]==i]#, "PAIRS for stim :" , i)
            pairs_selected_by_topsf = fxnsNStims[prev_sf_idx:prev_sf_idx+num_curr_sfs]#, "FXNS BEING SUMMED at ", i)
            prev_sf_idx = prev_sf_idx + num_curr_sfs # update score function tracking index
            assert pairs_matching_stim_num == pairs_selected_by_topsf 
    
    def test_topSfWeights(self):
        if size > 1:
            fxnsNStims = self.NG.top_SFs()
            first_stim = 0
            last_stim = 10
            
        else:
            fxnsNStims = self.NG.top_SFs(0)
            first_stim = 0
            last_stim = 3
        for pair in fxnsNStims:
            i = pair[0]
            j = pair[1]
            curr_weight = self.NG.weights[len(score_function_ordered_list)*i + j]
        


        
if __name__ == '__main__':
    #with suppress_stdout():
    nGpus = len([devicenum for devicenum in os.environ['CUDA_VISIBLE_DEVICES'] if devicenum != ","])
#     if nGpus > 1:
#         print(1/0)
    unittest.main()
    ########### TODO : SET condition to switch evalutors based on env variables
    print("testing with :", " ntimesteps -", ntimestep)