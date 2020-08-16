import os
import neuron as nrn

def load_and_run(run_file, stim_file, times_file, out_file):
	nrn.h.load_file(run_file)
	nrn.h.stimFile = stim_file
	nrn.h.timesFile = times_file
	nrn.h.outFile = out_file
	print('******************************going to runmodel******************************')
	nrn.h("runModel()")

run_file = './run_model_cori_pin_bbp.hoc'
times = './times.csv'
stims_path = './stims/'
volts_path = './volts/'
stims_name_list = os.listdir(stims_path)

for stim in stims_name_list:
	load_and_run(run_file, stims_path + stim, times, volts_path + 'pin_200_' + stim)
