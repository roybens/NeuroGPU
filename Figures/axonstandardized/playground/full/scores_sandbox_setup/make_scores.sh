wrkDir=`pwd`
mkdir -p ${wrkDir}/'../sandbox'
mkdir -p ${wrkDir}/../'scores'

sbatch sbatch_run.slr
