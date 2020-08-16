#!/bin/bash

python param_stim_generator/make_paramset_hdf5/makeParamSet.py
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

#making directory for the run
templtDir=models/${model}/${peel}
wrkDir=runs/${model}_${peel}_${CURRENTDATE}${custom}
mkdir -p ${wrkDir}

#make_volts
module load tensorflow/intel-1.12.0-py36
module load python/3.6-anaconda-4.4

source ~/neuron-setup.ext
c=''
coreN=${c}
wrkDir=${SCRATCH}/data_axonrun/runs/${coreN}
mkdir -p ${wrkDir}
mkdir -p ${wrkDir}/'volts'
mkdir -p ${wrkDir}/'stims'
mkdir -p ${wrkDir}/'params'

cp model/params/params.hdf5 ${wrkDir}/params/params.hdf5 # change the location of where params are
cp model/stims/stims.hdf5 ${wrkDir}/stims/stims.hdf5 # change the location of where stims are


sbatch sbatch_run_volts.slr

cd ${wrkDir}/'volts'
num_files=$(ls -l | grep ^- | wc -l)
while  [$num_files -ne $num_volts ]
do
    remaining=$num_volts - $num_files
    echo "num_volts_to_do=${remaining}"> input
done

cd ..

c="sand_${model}_${peeling}_scores"
coreN=${c}
wrkDir=${SCRATCH}/${coreN}
mkdir -p ${wrkDir}
mkdir -p ${wrkDir}


sbatch sbatch_run_scores.slr

cd ${wrkDir}/'scores'
num_files=$(ls -l | grep ^- | wc -l)
while  [$num_files -ne $num_volts ]
do
    remaining=$num_volts - $num_files
    echo "num_scores_to_do=${remaining}"> input
done


cd ..

$endTIME =`date +%T`
python log.py $CURRENTDATE $startTIME $user $model $peel $nSubZones $nPerSubZone $norm $seed $wrkDir
