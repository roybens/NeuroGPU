#!/bin/bash
#SBATCH --constraint=haswell
#SBATCH --nodes=32
#SBATCH --qos=regular
#SBATCH --mail-user=hkyoung@berkeley.edu
#SBATCH --mail-type=ALL
#SBATCH --time=6:00:00
#SBATCH --image=roybens/bpopt:v1

#run the application:
export PYTHONPATH=/build/nrn/src/nrnpython/build/lib.linux-x86_64-2.7/neuron:/build/nrn/share/lib/python
srun -n 2048 shifter /build/nrn/x86_64/bin/nrniv -mpi run_multiple_p_dx_bbp.py
