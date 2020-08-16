# Naming the new run
date='073019' # MMDDYY
custom='' # custom tag for new folder

# Specifying model/peeling
model='mainen' # mainen or bbp
peel='sodium' # passive, potassium, sodium, calcium, or full

# Access cscratch data
user='kyoungh' # user id

templtDir=../models/${model}/${peel}
wrkDir=../runs/${model}_${peel}_${date}_${custom}

mkdir -p ${wrkDir}
cp -rp ${templtDir}  ${wrkDir}/model/
cp /global/cscratch1/sd/kyoungh/data_axonrun/stims/stims.hdf5 ${wrkDir}/model/stims/stims.hdf5
cp /global/cscratch1/sd/kyoungh/data_axonrun/params/params_mainen_sodium.hdf5 ${wrkDir}/model/params/params.hdf5

cp -rp ../param_stim_generator ${wrkDir}/param_stim_generator/
cp -rp ../sandbox_volts ${wrkDir}/sandbox_volts/
cp -rp ../sandbox_scores ${wrkDir}/sandbox_scores/
cp -rp ../AnalyzeP ${wrkDir}/AnalyzeP/
