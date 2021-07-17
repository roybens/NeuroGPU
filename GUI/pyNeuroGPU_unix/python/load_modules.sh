module purge
module load esslurm cuda pgi mvapich2 nccl
module load hdf5-parallel
cd ../src/
make clean
make
nvcc -ccbin g++ -gencode arch=compute_70,code=sm_70 -gencode arch=compute_70,code=compute_70 -I/usr/common/software/cuda/10.2.89/include -I/usr/common/software/cuda/10.2.89/include -o neuroGPU AllModels.o kernel.o MainC.o Util.o CudaStuff.o -L/usr/common/software/hdf5-parallel/1.10.1/pgi/lib -lhdf5_hl_cpp -lhdf5_cpp -lhdf5_hl -lhdf5 -L/opt/esslurm/lib64 -lz -ldl -lm -I/usr/common/software/mvapich2/2.3.2/pgi/19.10/cuda/10.2.89/include -L/usr/common/software/mvapich2/2.3.2/pgi/19.10/cuda/10.2.89/lib -lmpicxx -lmpi
rm ../bin/neuroGPU
cp neuroGPU ../bin