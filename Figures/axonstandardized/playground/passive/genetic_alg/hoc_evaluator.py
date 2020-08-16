import numpy as np
import h5py
from neuron import h
import bluepyopt as bpop
import nrnUtils
import score_functions as sf
import efel
import pandas as pd

run_file = './run_model_cori.hoc'
run_volts_path = '../run_volts_bbp_passive/'
paramsCSV = run_volts_path+'params/params_bbp_passive.csv'
orig_params = h5py.File(run_volts_path+'params/params_bbp_passive.hdf5', 'r')['orig_passive'][0]
scores_path = '../scores/'
objectives_file = h5py.File('./objectives/multi_stim_without_sensitivity_bbp_passive_1_0_20_stims.hdf5', 'r')
opt_weight_list = objectives_file['opt_weight_list'][:]
opt_stim_name_list = objectives_file['opt_stim_name_list'][:]
score_function_ordered_list = objectives_file['ordered_score_function_list'][:]
stims_path = run_volts_path+'/stims/neg_stims.hdf5'
params_opt_ind = [3, 20, 23]

custom_score_functions = [
					'chi_square_normal',\
					'traj_score_1',\
					'traj_score_2',\
					'traj_score_3',\
					'isi',\
					'rev_dot_product',\
					'KL_divergence']

# Number of timesteps for the output volt.
ntimestep = 10000

# Value of dt in miliseconds
dt = 0.02

def run_model(param_set, stim_name_list):
	h.load_file(run_file)
	volts_list = []
	for elem in stim_name_list:
		curr_stim = h5py.File(stims_path, 'r')[elem][:]
		total_params_num = len(param_set)
		timestamps = np.array([dt for i in range(ntimestep)])
		h.curr_stim = h.Vector().from_python(curr_stim)
		h.transvec = h.Vector(total_params_num, 1).from_python(param_set)
		h.stimtime = h.Matrix(1, len(timestamps)).from_vector(h.Vector().from_python(timestamps))
		h.ntimestep = ntimestep
		h.runStim()
		out = h.vecOut.to_python()		
		volts_list.append(out)
	return np.array(volts_list)

def evaluate_score_function(stim_name_list, target_volts_list, data_volts_list, weights):
	def eval_function(target, data, function, dt):
		if function in custom_score_functions:
			score = getattr(sf, function)(target, data, dt)
		else:
			score = sf.eval_efel(function, target, data, dt)
		return score
	def normalize_single_score(newValue, transformation):
		# transformation contains: [bottomFraction, numStds, newMean, std, newMax, addFactor, divideFactor]
		# indices for reference:   [      0       ,    1   ,    2   ,  3 ,    4  ,     5    ,      6      ]
		if newValue > transformation[4]:
			newValue = transformation[4]                                            # Cap newValue to newMax if it is too large
		normalized_single_score = (newValue + transformation[5])/transformation[6]  # Normalize the new score
		return normalized_single_score

	total_score = 0
	for i in range(len(stim_name_list)):
		curr_data_volt = data_volts_list[i]
		curr_target_volt = target_volts_list[i]
		for j in range(len(score_function_ordered_list)):
			curr_sf = score_function_ordered_list[j].decode('ascii')
			curr_weight = weights[len(score_function_ordered_list)*i + j]
			transformation = h5py.File(scores_path+stim_name_list[i]+'_scores.hdf5', 'r')['transformation_const_'+curr_sf][:]
			curr_score = eval_function(curr_target_volt, curr_data_volt, curr_sf, dt)
			norm_score = normalize_single_score(curr_score, transformation)
			if curr_weight:
				total_score += norm_score * curr_weight
	return total_score

class hoc_evaluator(bpop.evaluators.Evaluator):
	def __init__(self):
		"""Constructor"""
		params_ = nrnUtils.readParamsCSV(paramsCSV)
		super(hoc_evaluator, self).__init__()
		self.opt_ind = params_opt_ind
		params_ = [params_[i] for i in self.opt_ind]
		self.orig_params = orig_params
		self.params = [bpop.parameters.Parameter(name, bounds=(minval, maxval)) for name, minval, maxval in params_]
		print("Params to optimize:", [(name, minval, maxval) for name, minval, maxval in params_])
		print("Orig params:", self.orig_params)
		self.weights = opt_weight_list
		self.opt_stim_list = [e.decode('ascii') for e in opt_stim_name_list]
		self.objectives = [bpop.objectives.Objective('Weighted score functions')]
		print("Init target volts")
		self.target_volts_list = run_model(orig_params, self.opt_stim_list)
		
	def evaluate_with_lists(self, param_values):
		input_values = self.orig_params
		for i in range(len(param_values)):
			curr_opt_ind = self.opt_ind[i]
			input_values[curr_opt_ind] = param_values[i]
		data_volts_list = run_model(input_values, self.opt_stim_list)
		score = evaluate_score_function(self.opt_stim_list, self.target_volts_list, data_volts_list, self.weights)
		return [score]











