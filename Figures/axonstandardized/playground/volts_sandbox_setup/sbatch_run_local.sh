
CSCRATCH="test"
SCRATCH="test"
job_sh="1"
SLURM_ARRAY_TASK_ID="10"
SLURM_JOBID="13"
CURRENTDATE=`date +%m_%d_%Y`
input="input.txt"
while IFS= read -r line
do
    IFS='=' read -ra inputs <<< "$line"
    name="${inputs[0]}"
    data="${inputs[1]}"
    printf -v $name "$data"
done < "$input"


echo "start-A "`hostname`" task="${job_sh}
echo  'cscratch='${CSCRATCH}
echo  'scratch='${SCRATCH}
echo SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID}
echo SLURM_JOBID=${SLURM_JOBID}
srcDir=`pwd`

sleep 2

dirToRun='run_volts_' + ${model}_${peel}

cp -rp ../../'run_volts'/${dirToRun} ${wrkDir}/

coreN=${srcDir}/'runs'/${model}_${peel}_${CURRENTDATE}${custom}/'volts_sand'/${SLURM_ARRAY_JOB_ID}
arrIdx=${SLURM_ARRAY_TASK_ID}
wrkDir=${coreN}-${arrIdx}
echo 'my wrkDir='${wrkDir}
mkdir -p ${wrkDir}


cd ${wrkDir}/${dirToRun}

echo inventore at start
pwd
ls -l *

export OMP_NUM_THREADS=1

srun -n 68 python run_stim_hdf5.py $arrIdx

# mv slurm log to final destination - it is alwasy a job-array
mv $srcDir/slurm-${SLURM_ARRAY_JOB_ID}_${SLURM_ARRAY_TASK_ID}.out .
