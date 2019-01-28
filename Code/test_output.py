import array
params_fn = './AllParams.csv'
timestep = 3168
with file(params_fn, 'r') as original:
    data = original.read()
splitted = data.split('\n')
psize = int(splitted[0][:-1])

N = timestep*psize

a = array.array('d')
with file('./VHotP.dat', 'rb') as f:
    a.fromfile(f, N)
maxa = max(a)
mina = min(a)
if(maxa<1000 and mina>-1000):
    print "pass results are good"
else:
    print "error:: results are out of physiological bounds"
