module load tensorflow/intel-1.12.0-py36
module load python/3.6-anaconda-4.4

#source ~/neuron-setup.ext
c=''
coreN=${c}
wrkDir=${SCRATCH}/data_axonrun/runs/${coreN}
mkdir -p ${wrkDir}
mkdir -p ${wrkDir}/'volts'
mkdir -p ${wrkDir}/'stims'
mkdir -p ${wrkDir}/'params'

cp ../model/params/params.hdf5 ${wrkDir}/params/params.hdf5 # change the location of where params are
cp ../model/stims/stims.hdf5 ${wrkDir}/stims/stims.hdf5 # change the location of where stims are

#python paramsetGen.py --size=512 --model "test_10" --vary 2 4 7 8 --seed=1846353

sbatch sbatch_run_volts.slr
