import os
import time
params_fn = '../Data/AllParams.csv'
with file(params_fn, 'r') as original:
    data = original.read()
splitted = data.split('\n')
f = open('../Data/lista.csv', 'w')
times = range(16);
for i in range(0, 16):
    psize = 2 ** i
    splitted[0] = str(psize) + ','
    new_str = '\n'.join(splitted)
    with file(params_fn, 'w') as modified:
        modified.write(new_str)

    os.system('NeuroGPU6.exe')
    time.sleep(10)
    with file('../Data/RunTimes.csv', 'r') as times_file:
        time_data = times_file.read()
	time_data = time_data.split(',')   
    print time_data[1]
    times[i] = time_data[1]
    f.write(str(times[i]) + "\n")
f.close()
