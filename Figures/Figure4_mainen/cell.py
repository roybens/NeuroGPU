import numpy as np

def cell_numel(input):
	out = np.zeros(input.shape[0])
	if input.size == 0:
		return None
	for i in range(input.size):
		out[i] = len(input[i])
	return out

def cell_2_vec(input):
	if len(input.shape) > 2:
		raise ValueError("Expected a 2-d array (cell) for an input.")
	cn = cell_numel(input)
	cs = []
	for i in np.cumsum(input):
		cs.append(np.sum(i))
	cs = np.array(cs)
	starts, ends = [], []
	start_counter = 0
	for i in input:
		starts.append(start_counter)
		ends.append(start_counter + len(i) - 1)
		start_counter += len(i)
	starts, ends = np.array(starts), np.array(ends)
	vec = []
	for i in input:
		vec += list(i)
	vec = np.array(vec)
	return (starts, ends, cn, vec)
