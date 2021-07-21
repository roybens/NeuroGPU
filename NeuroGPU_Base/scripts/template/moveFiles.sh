#python extractModel.py
#python extractModel_Mappings.py
mkdir pyNeuroGPU_unix/python
cp runBBP.py pyNeuroGPU_unix/python/
#cp -r ../../gen_alg_GPU/params pyNeuroGPU_unix
cp -r params pyNeuroGPU_unix/

cp -r ../../gen_alg_GPU/objectives pyNeuroGPU_unix

# why these two?
cp Data/* pyNeuroGPU_unix/Data/
cp pyNeuroGPU_unix/Data/Stim_raw.csv pyNeuroGPU_unix/Data/Stim_raw0.csv

cp  *.dat pyNeuroGPU_unix/python/
cp  Fmatrix.csv pyNeuroGPU_unix/python/
cp  64MDL.csv pyNeuroGPU_unix/python/
cp  64MDL.csv pyNeuroGPU_unix/Data/


cp -r ../../gen_alg_GPU/stims pyNeuroGPU_unix
cp -r ../../gen_alg_GPU/Data//target_volts_BBP19.csv pyNeuroGPU_unix/Data
cp -r ../../gen_alg_GPU/Data/AllParams_for_params.csv pyNeuroGPU_unix/Data
cp pyNeuroGPU_unix/Data/Stim_raw.csv pyNeuroGPU_unix/Data/Stim_raw.csv
cp pyNeuroGPU_unix/Data/times.csv pyNeuroGPU_unix/Data/times0.csv



cp plot_data.ipynb pyNeuroGPU_unix/python/
cp extractModel_mappings.py pyNeuroGPU_unix/python/
cp stim_converter.py pyNeuroGPU_unix/python/

cp extractModel.py pyNeuroGPU_unix/python/
cp file_io.py pyNeuroGPU_unix/python/
cp auxilliary.py pyNeuroGPU_unix/python/
cp neuron_object.py pyNeuroGPU_unix/python/
cp proc_add_param_to_hoc_for_opt.py pyNeuroGPU_unix/python/
cp cell.py pyNeuroGPU_unix/python/
cp nrn_structs.py pyNeuroGPU_unix/python/
cp create_auxilliary_data_3.py pyNeuroGPU_unix/python/
cp make_tree_from_parent_vec.py pyNeuroGPU_unix/python/
cp get_parent_from_neuron.py pyNeuroGPU_unix/python/
cp runModel.hoc pyNeuroGPU_unix/python/
cp mosinit.hoc pyNeuroGPU_unix/python/
cp morphology.hoc pyNeuroGPU_unix/python/
cp init.hoc pyNeuroGPU_unix/python/
cp biophysics.hoc pyNeuroGPU_unix/python/
cp constants.hoc pyNeuroGPU_unix/python/
cp createsimulation.hoc pyNeuroGPU_unix/python/
cp template.hoc pyNeuroGPU_unix/python/
cp fitCori_bbp.hoc pyNeuroGPU_unix/python/
cp basicCompareBBP.ipynb pyNeuroGPU_unix/python/
# perhaps just move all .o, .c and .hoc and .mod
cp *.mod pyNeuroGPU_unix/python/
cp *.mod2 pyNeuroGPU_unix/python/
cp *.hoc pyNeuroGPU_unix/python/
cp *.h pyNeuroGPU_unix/python/

cp *.c pyNeuroGPU_unix/python/
cp *.o pyNeuroGPU_unix/python/


cp -r CParsed  pyNeuroGPU_unix/python/
cp -r morphology  pyNeuroGPU_unix/python/
cp -r params  pyNeuroGPU_unix/python/
cp -r Stims  pyNeuroGPU_unix/python/



cd pyNeuroGPU_unix/src 
module load cuda
make

cd ../python/
nrnivmodl


cp ../../Data/Stim_raw.csv ../Data/Stim_raw0.csv


#make neuroGPU todo
