# axonstandardized
standardization updates to the axon research run procedure. Started 10/15/19.

To set up environment / dependencies
=======================================
1. In root_dir run "conda env create -f environment_root.yml"
2. then "conda activate pipeline_env"
3. Make sure you have correct module files with "source load_env" in playground folder


To run
=======================================
1. Makre sure dependecies installed and you can activate pipeline env
2. Go in playground directory
3. Fill out input.txt with params, model, peeling and number of trials to run
4. sh run.sh

To run neurogpu with sbatch
===================================
1. go into playground directory (axonstandardized/playground/)
2. make sure inputs.txt has correct offspring_size and ngen and that gaGPU is set to True
3. run "module load esslurm"
3. run "sh run.sh" (in playground)
4. results pkl files in **axonstandardized/playground/gen_algGPU/python/** and slurm left in axonstandardized/playground/slurm_out/


To run neurogpu interactively
===================================
1. go into neuroGPU directory (axonstandardized/playground/gen_algGPU/python/)
2. run command: source load_env
3. salloc -C gpu -N 1 -t 20 --gres=gpu:8 -c 80  -A m2043 (note: can lower cores or gpus to get node faster)
4. run command: source load_env (yes twice)
7. srun python optimize_parameters_genetic_alg.py --offspring_size 2 --max_ngen 1
    **you can also run srun python test_neuroGPU.py to run my unit tests**
8. results pkl files in axonstandardized/playground/gen_algGPU/python/

if you are running anything using GPU make sure your account is configured for that or else you will get an error saying invalid QOS.


Steps in run.sh
=======================================
1. Generate Params using input.txt and makeParamSet.py
    - input.txt is parsed with makeParamSet.py in param_stim_generator/make_paramset_hdf5/ folder
      - saves as h5py file on users scratch account @ h5py.File('/global/cscratch1/sd/' + user + '/run_volts/run_volts_model_peeling/params/params.hdf5', 'a')
2. Script parses input.txt to set instance variables, makes directories, and edits sbatch scripts so they match.
3. Script hits run_volts.slr which creates volts and volts_sandboxes in runs/model_peeling_date/
4. Script waits for slurm to complete and then moves slurm into runs/model_peeling_date/ (do not exit program here)
5. Script hits run_scores.slr which creates scores and score_sandbox in runs/model_peeling_date/
6. Script waits for slurm to complete and then moves slurm into runs/model_peeling_date/ (do not exit program here)
7. logs stuff to spreadsheets

initial is how we received files originally

![Proposed File Struct](/proposed_file_struct.png)


TODO
=======================================
* fix passive params template, it has an n/a where it shouldn't. give zander mainen specific run files
* create a good way to insure all correct module files are loaded
* neuroGPU has to have one executable for each rank because I couldn't figure out how to make MPI aware cuda yet
* integration tests
* sandbox procedure needs to be debugged
* need to try cprofile inside multiprocessing for more speed up at some point
* adapt to work on files for more datasets
* pycuda wrappers for efel? 
* cpython
* look into allen inst spike eval: https://github.com/AllenInstitute/ipfx
