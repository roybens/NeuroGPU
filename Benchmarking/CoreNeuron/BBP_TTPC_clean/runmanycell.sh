#for i in 1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384
i=0
for ncells in 1 2
  do 
     SECONDS=0
     srun -n 32 shifter --image==balewski/ubu18-py3-mpich:v4 ./runnrn.sh $ncells
     runtime=$SECONDS
     array[$i]=$runtime
     i=$(($i+1))
 done
echo "${array[*]}"
