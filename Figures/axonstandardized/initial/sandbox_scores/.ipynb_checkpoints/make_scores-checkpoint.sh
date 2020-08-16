c='sand_BBP_passive_scores'
coreN=${c}
wrkDir=${SCRATCH}/${coreN}
mkdir -p ${wrkDir}
mkdir -p ${wrkDir}

sbatch sbatch_run_scores.slr
