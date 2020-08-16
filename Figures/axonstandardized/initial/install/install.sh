#!/bin/bash

# Create the run scripts with your email.
python setup_run_scripts.py

# Install neuron.
START=$(pwd)
module list
module swap PrgEnv-gnu PrgEnv-intel  # Make sure intel compilers are loaded
module load python/3.6-anaconda-4.4
yes | conda create --name .env python=3.6
source activate .env
mkdir $HOME/bin
cd $HOME/bin
wget https://neuron.yale.edu/ftp/neuron/versions/v7.6/nrn-7.6.tar.gz
tar xfz nrn-7.6.tar.gz
cd nrn-7.6
./configure --prefix=$HOME/bin/nrn-7.6 --with-nrnpython=$(which python) --without-iv
make
yes | make install
cd src/nrnpython
python setup.py install

echo "export LD_LIBRARY_PATH='$HOME/bin/nrn-7.6/x86_64/lib:$LD_LIBRARY_PATH'" >> ~/.bashrc.ext
echo "export PATH='$HOME/bin/nrn-7.6/x86_64/bin:$PATH'" >> ~/.bashrc.ext
echo "source activate .env" >> ~/.bashrc.ext

cd $START

# Install python package dependencies.
pip install -r requirements.txt

# Install mpi4py.
wget https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-3.0.0.tar.gz
tar zxvf mpi4py-3.0.0.tar.gz
mv mpi4py-3.0.0 $HOME/mpi4py-3.0.0
rm mpi4py-3.0.0.tar.gz
cd $HOME/mpi4py-3.0.0
module swap PrgEnv-intel PrgEnv-gnu
python setup.py build --mpicc=$(which cc)
python setup.py build_exe --mpicc="$(which cc) -dynamic"
python setup.py install
python setup.py install_exe


cd $START
cd run_volts_mainen

# Compile neuron files into `x86_64`.
#salloc -q interactive -N 1 -t 00:05:00 -C haswell srun -n 1 nrnivmodl
#don't need to salloc, reload bashrc by running: source ~/.bashrc , and then run: nrnivmodl
source ~/.bashrc
#conda install -n .env -c conda-forge -c clawpack h5py-parallel python=3
#pip install -U pynwb --find-links https://github.com/NeurodataWithoutBorders/pynwb/releases/tag/latest  --no-index
nrnivmodl
mv x86_64 $START/.

cd $START
conda deactivate
