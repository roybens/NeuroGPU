for ncells in 1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384
  do 
     SECONDS=0
     sbatch run_cn.sh $ncells
     runtime=$SECONDS
     array[$i]=$runtime
     i=$(($i+1))
 done
echo "${array[*]}"
echo "changes"
