#!/bin/bash
#SBATCH -A m2043
#SBATCH -C gpu
#SBATCH -G 1
#SBATCH -c 10
#SBATCH -t 02:30:00
#SBATCH -J core_neuron

ncells=$1
echo "ncells = $ncells"
export PYTHONPATH=$HOME/install/lib/python:$PYTHONPATH
export PATH=$HOME/install/bin:$PATH
time srun -n 1 x86_64/special -python -mpi ./gpuCN_RunTTPC1Parallel.py $ncells
