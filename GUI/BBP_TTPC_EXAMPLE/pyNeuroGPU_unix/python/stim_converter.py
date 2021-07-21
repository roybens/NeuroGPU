import numpy as np
import csv

file = np.genfromtxt("../Data/Stim_raw0.csv")
writer = csv.writer(open("../Data/Stim_raw0.csv", 'w'))
writer.writerow(file)
