from mpi4py import MPI
import numpy as np
import h5py
from neuron import h
import os, sys

##########################
# Script PARAMETERS      #
##########################

# Relative path common to all other paths.
run_file = './run_model_cori.hoc'
params_file_path = './params/params_bbp_passive.hdf5'
stims_file_path = './stims/neg_stims.hdf5'

# Number of timesteps for the output volt.
ntimestep = 10000

# Value of dt in miliseconds
dt = 0.02

# Output destination.
volts_path = '../../../volts/'

# Required variables. Some should be updated at rank 0
prefix_list = ['orig', 'pin', 'pdx']
stims_hdf5 = h5py.File(stims_file_path, 'r')
params_hdf5 = h5py.File(params_file_path, 'r')
params_name_list = list(params_hdf5.keys())
stims_name_list = sorted(list(stims_hdf5.keys()))

num_stims_to_run = 1
i=int(sys.argv[1])
curr_stim_name_list = stims_name_list[(i-1)*num_stims_to_run:(i)*num_stims_to_run]


pin_set_size = None
pdx_set_size = None

##########################
# Utility Functions      #
##########################
def split(container, count):
	"""
	Simple function splitting a container into equal length chunks.

	Order is not preserved but this is potentially an advantage depending on
	the use case.
	"""
	return [container[_i::count] for _i in range(count)]

def run_model(run_file, param_set, stim_name, ntimestep):
	h.load_file(run_file)
	total_params_num = len(param_set)

	stim_data = stims_hdf5[stim_name]
	timestamps = np.array([dt for i in range(ntimestep)])

	h.curr_stim = h.Vector().from_python(stim_data)
	h.transvec = h.Vector(total_params_num, 1).from_python(param_set)
	h.stimtime = h.Matrix(1, len(timestamps)).from_vector(h.Vector().from_python(timestamps))
	h.ntimestep = ntimestep
	h.runStim()
	out = h.vecOut.to_python()
	return np.array(out)

# Use default communicator. No need to complicate things.
COMM = MPI.COMM_WORLD

for stim_ind in range(len(curr_stim_name_list)):
	# Collect whatever has to be done in a list. Here we'll just collect a list of
	# numbers. Only the first rank has to do this.
	if COMM.rank == 0:
		# Each job should contain params_name, a single param set index
		# and number of total params as a list: [params_name, param_ind, stim_ind, n]
		jobs = []
		for params_name in params_name_list:
			if 'orig' in params_name:
				jobs.append([params_name, 0, stim_ind, 1])
			elif 'pin' in params_name:
				n = params_hdf5[params_name].shape[0]
				pin_set_size = n
				for param_ind in range(n):
					jobs.append([params_name, param_ind, stim_ind, n])
			elif 'pdx' in params_name:
				n = params_hdf5[params_name].shape[0]
				pdx_set_size = n
				for param_ind in range(n):
					jobs.append([params_name, param_ind, stim_ind, n])
			else:
				continue
		# Split into however many cores are available.
		jobs = split(jobs, COMM.size)
	else:
		jobs = None

	jobs = COMM.scatter(jobs, root=0)
	# Now each rank just does its jobs and collects everything in a results list.
	# Make sure to not use super big objects in there as they will be pickled to be
	# exchanged over MPI.
	results = {}
	for job in jobs:
		# Compute voltage trace for each param sets.
		[params_name, param_ind, stim_ind, n] = job
		curr_stim_name = curr_stim_name_list[stim_ind]
		print("Currently working on stim " + curr_stim_name + " and params " + str(param_ind+1) + " of " + str(n))
		params_data = params_hdf5[params_name][param_ind]
		volts_at_i = run_model(run_file, params_data, curr_stim_name, ntimestep)
		result_key = (params_name, param_ind, stim_ind)
		results[result_key] = volts_at_i

	results = MPI.COMM_WORLD.gather(results, root=0)

	if COMM.rank == 0:
		flattened_dict = {}
		for d in results:
			k = d.keys()
			for key in k:
				flattened_dict[key] = d[key]
				
		curr_stim_name = curr_stim_name_list[stim_ind]
		volts_hdf5 = h5py.File(volts_path+curr_stim_name+'_volts.hdf5', 'w')
		for params_name in params_name_list:
			if 'orig' in params_name:
				volts = flattened_dict[(params_name, 0, stim_ind)]
				name_to_write = 'orig' + '_' + curr_stim_name
				print("Processing ", name_to_write)
				volts_hdf5.create_dataset(name_to_write, data=volts)
			elif 'pin' in params_name:
				volts = np.empty((pin_set_size, ntimestep))
				name_to_write = 'pin' + '_' + curr_stim_name
				for param_ind in range(pin_set_size):
					volts[param_ind] = flattened_dict[(params_name, param_ind, stim_ind)]
					print("Processing ", name_to_write, str(param_ind+1)+"/"+str(pin_set_size))
				volts_hdf5.create_dataset(name_to_write, data=volts)
			elif 'pdx' in params_name:
				volts = np.empty((pdx_set_size, ntimestep))
				name_to_write = 'pdx' + '_' + curr_stim_name
				for param_ind in range(pdx_set_size):
					volts[param_ind] = flattened_dict[(params_name, param_ind, stim_ind)]
					print("Processing ", name_to_write, str(param_ind+1)+"/"+str(pdx_set_size))
				volts_hdf5.create_dataset(name_to_write, data=volts)
		volts_hdf5.close()

