#!/bin/bash


#!/bin/bash

echo `pwd`
source ./input.txt
echo $gaGPU        #test               #test

if [ "$gaGPU" = "True" ]
    then
       cd gen_alg_GPU1/
       sbatch running_GA_GPU.sh
       exit 1
fi

python param_stim_generator/makeParamSet.py

CURRENTDATE=`date +%m_%d_%Y`
startTIME=`date +%T`
custom=''
input="input.txt"
while IFS= read -r line
do
    IFS="=" read -ra inputs <<< "$line"
    name="${inputs[0]}"
    data="${inputs[1]}"
    printf -v $name "$data"
done < "$input"

true=True


#making directory for the run
mkdir -p runs/${model}_${peeling}_${CURRENTDATE}${custom}
wrkDir=runs/${model}_${peeling}_${CURRENTDATE}${custom}
mkdir -p ${wrkDir}/'volts'
mkdir -p ${wrkDir}/'scores'
mkdir -p runs/${model}_${peeling}_${CURRENTDATE}${custom}/'slurm'


#module load tensorflow/intel-1.12.0-py36
#module load python/3.6-anaconda-4.4

#source ~/neuron-setup.ext

# set sandbox array parameters in score_sandbox and volt_sandbox
# to match those in input.txt
python modifySandboxArray.py $num_volts

#LOCAL, uses shell script for local imitation
if [ ${makeVolts} == ${true} ]
  then
    sbatch volts_sandbox_setup/sbatch_run.slr
  fi
#sh passive/volts_sandbox_setup/sbatch_local_volts.sh

echo making volts....


#waits until slurm has put enough volts in directory
shopt -s nullglob
found=0
target_volts=$num_volts

# while [ $found -ne $target_volts ]
# do
#         found=`ls -lR ${wrkDir}/volts/*.hdf5 | wc -l`
# done

echo made $num_volts volts successfully
shopt -u nullglob

#move the slurm into runs
mv slurm* runs/${model}_${peeling}_${CURRENTDATE}${custom}/'slurm'



if [ ${makeScores} == ${true} ]
  then
    sbatch scores_sandbox_setup/sbatch_run.slr
  fi


echo making scores....


shopt -s nullglob
found=0
target_volts=$num_volts

# while [ $found -ne $target_volts ]
# do
#         found=`ls -lR ${wrkDir}/scores/*.hdf5 | wc -l`
# done

echo made $num_volts scores successfully
shopt -u nullglob

#move slurm into runs
mv slurm* runs/${model}_${peeling}_${CURRENTDATE}${custom}/'slurm'


sbatch analyze_p_bbp_full/analyze_p.slr

shopt -s nullglob
found=0
target_files=1

# while [ $found -ne $target_files ]
# do
#         found=`ls -lR ${wrkDir}/genetic_alg/objectives/*.hdf5 | wc -l`
# done

echo finished creating objectives file
shopt -u nullglob

if [ ${runGA} == ${true} ]
  then
    sbatch genetic_alg/running_GA_parallel.sh
  fi




endTIME =`date +%T`
python log.py $CURRENTDATE $startTIME $user $model $peeling $nSubZones $nPerSubZone $norm $seed $wrkDir