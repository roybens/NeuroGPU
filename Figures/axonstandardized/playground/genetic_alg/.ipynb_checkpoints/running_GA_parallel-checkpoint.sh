#!/bin/bash

#SBATCH -q debug
#SBATCH -N 1
#SBATCH -t 00:30:00
#SBATCH -C knl
#SBATCH -L SCRATCH
#SBATCH --mail-user=zladd@berkeley.edu
#SBATCH --mail-type=ALL



CURRENTDATE=`date +%m_%d_%Y`
startTIME=`date +%T`
custom=''
input="input.txt"
while IFS= read -r line
do
    IFS='=' read -ra inputs <<< "$line"
    name="${inputs[0]}"
    data="${inputs[1]}"
    printf -v $name "$data"
done < "$input"

echo running GA
echo OFFSPRING_SIZE is ${OFFSPRING_SIZE}
echo for ${MAX_NGEN} generations
echo seed: ${seed}

export OMP_NUM_THREADS=1
export IPYTHONDIR=${PWD}/.ipython
export IPYTHON_PROFILE=benchmark.${SLURM_JOBID}
srcDir=`pwd`


wrkDir=${srcDir}/'runs'/${model}_${peeling}_${CURRENTDATE}${custom}
echo 'my wrkDir='${wrkDir}

dirToRun="genetic_alg/"

#cp -rp ${dirToRun} ${wrkDir}/'genetic_alg'

#make python command here to change files for specific gen alg
python modifyEvaluator.py ${model} ${peeling} ${CURRENTDATE} ${params}

cd ${wrkDir}/${dirToRun}




nrnivmodl
ipcontroller --init --ip='*' --sqlitedb --ping=30000 --profile=${IPYTHON_PROFILE} &
sleep 100
# srun -n 120 ipengine --timeout=50 --profile=${IPYTHON_PROFILE} &
#FOR KYUNG to change later ^ I don't have enough hours for this
srun -n 60 ipengine --timeout=50 --profile=${IPYTHON_PROFILE} &
sleep 100

#CHECKPOINTS_DIR="checkpoints"
#mkdir -p ${CHECKPOINTS_DIR}

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
