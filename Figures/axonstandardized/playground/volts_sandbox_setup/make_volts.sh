wrkDir=`pwd`
mkdir -p ${wrkDir}/'../sandbox'
mkdir -p ${wrkDir}/../'volts'

sbatch sbatch_run.slr
