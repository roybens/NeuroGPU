#!/bin/bash

#SBATCH -q regular
#SBATCH -N 20
#SBATCH -t 10:00:00
#SBATCH -C haswell
#SBATCH -L SCRATCH
#SBATCH --mail-user=kyung4952@berkeley.edu
#SBATCH --mail-type=ALL



OFFSPRING_SIZE=1000
MAX_NGEN=100

export OMP_NUM_THREADS=1
export IPYTHONDIR=${PWD}/.ipython
export IPYTHON_PROFILE=benchmark.${SLURM_JOBID}
#module load python/3.7-anaconda-2019.07
#source activate .env

ipcontroller --init --ip='*' --sqlitedb --ping=30000 --profile=${IPYTHON_PROFILE} &
sleep 600
srun -n 1100 ipengine --timeout=3000 --profile=${IPYTHON_PROFILE} &
sleep 600

#CHECKPOINTS_DIR="checkpoints"
#mkdir -p ${CHECKPOINTS_DIR}
seed=3788

python optimize_parameters_genetic_alg.py             \
	-vv                                \
	--compile                          \
	--offspring_size=${OFFSPRING_SIZE} \
	--max_ngen=${MAX_NGEN}             \
	--seed=${seed}                     \
	--ipyparallel                      \
	--start                         

# If job finishes in time analyze result

#mv ${CHECKPOINTS_DIR}/seed${seed}.pkl checkpoints_final/


# check if the job with 4th seed is finished

# if [[ $seed = 4 ]]; then
# 	sbatch analyse_stage2.slurm
# else
# 	seed_new=$(($seed+1))
# 	sed -i -e "s/seed in $seed/seed in $seed_new/g" start_haswell.sh 
# 	sed -i -e "s/seed in $seed/seed in $seed_new/g" restart_haswell.sh
# 	sbatch start_batchjob_stage2.slurm  
# fi






