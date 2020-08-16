import os
import neuron as nrn

def load_and_run(run_file, params_file, stim_file, times_file, out_file):
	nrn.h.load_file(1, run_file)
	nrn.h.stimFile = stim_file
	nrn.h.timesFile = times_file
	nrn.h.outFile = out_file
	nrn.h.paramsFile = params_file

	nrn.h("readCSVMatrix(timesFile,stimtime)")
	nrn.h("readCSVMatrix(paramsFile,pmat)")
	nrn.h("readCSVMatrix(stimFile,stims)")
	nrn.h("")
	nrn.h("runMatrix(pmat,stims)")
	nrn.h("writeMatrix(outFile,matOut)")

run_file_120 = './run_model_cori_120.hoc'
run_file_1440 = './run_model_cori_1440.hoc'
run_file_orig = './run_model.hoc'
orig_params = './params/orig.csv'
mdl25_params = './params/mdl25_params_passive.csv'
mdl50_params = './params/mdl50_params_passive.csv'
mdl100_params = './params/mdl100_params_passive.csv'
mdl200_params = './params/mdl200_params_passive.csv'
times = './times_0.02_2.0prepost.csv'
stims_path = './stims/'
volts_path = './volts/'
stims_name_list = [stim for stim in os.listdir(stims_path) if stim.endswith('.csv')]

for stim in stims_name_list:
	load_and_run(run_file_orig, orig_params, stims_path + stim, times, volts_path + stim)