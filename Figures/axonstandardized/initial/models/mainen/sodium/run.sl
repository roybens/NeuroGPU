#!/bin/bash
#SBATCH -N 16
#SBATCH -C haswell
#SBATCH -q debug
#SBATCH --mail-user=kyung4952@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH -t 05:00:00

#run the application:
export OMP_NUM_THREADS=1
srun -n 1024 python run_stim_hdf5.py
