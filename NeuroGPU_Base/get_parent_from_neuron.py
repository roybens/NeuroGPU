import numpy as np


def get_parent_from_neuron(file_name):
	parent = [[float(i) for i in line.split()] for line in open(file_name)]
	max_length = 0
	for l in parent:
		if len(l) > max_length:
			max_length = len(l)
	for i in range(len(parent)):
		parent[i] = np.lib.pad(parent[i], (0, max_length - len(parent[i])), 'constant', constant_values=(0,0))
	parent = np.array(parent)
	rows, cols = parent.shape
	parent = parent[1:rows - 1] + 1
	parent = parent[:,1].T
	parent[0] = 0
	return parent