from file_io import *
from auxilliary import Aux
import numpy as np
import cell

def is_member(A, B):
	return np.array([np.sum(a == B) for a in A])

"""input_dict = load_input_csv('/home/devloop0/inputMakeTree.csv')
Nx = int(input_dict['Nx'][0])
Fathers = input_dict['Fathers']
Ks = np.array(input_dict['Ks'])
aux = Aux()
aux.Ks = Ks
N = Nx"""

def make_tree_from_parent_vec(aux, Ks, N):
	Nx = N
	NN = np.bincount(aux.Ks, minlength=Nx)[1:]
	Fathers = np.unique(Ks[np.logical_and(Ks != np.arange(1, Ks.size + 1), Ks > 0)])
	Related = np.array([np.where(Fathers[i] == Ks)[0] for i in range(Fathers.size)])
	if Fathers.size != 0:
		RelStarts, RelEnds, RelCN, RelVec = cell.cell_2_vec(Related)
	else:
		RelStarts, RelEnds, RelCN, RelVec = [], [], [], []
	
	CallForFathers = np.add(np.where(is_member(aux.Ks, Fathers)), 1)
	RFathers = np.zeros((np.max(Fathers),))
	for i in range(Fathers.size):
		RFathers[Fathers[i] - 1] = i + 1
	
	SegStartI = np.array([2] + np.add(CallForFathers, 1).tolist()[0])
	SegEndI = np.array(np.subtract(CallForFathers, 1).tolist()[0] + [Nx - 1])
	Level = np.multiply(SegStartI, 0)
	Level[np.where(is_member(np.subtract(SegStartI, 1), Fathers))] = 1
	for i in range(1, 51):
		FF = np.where(Level == i)
		ToWhoTheyCall = aux.Ks[SegEndI[FF]]
		Level[np.where(is_member(np.subtract(SegStartI, 1), ToWhoTheyCall))] = i + 1
	FLevel = np.add(np.multiply(Fathers, 0), 1)
	for i in range(1, np.max(Level) + 1):
		FF = np.where(Level == i)
		ToWhoTheyCall = aux.Ks[SegEndI[FF]]
		ToWhichFatherDoTheyCall = RFathers[np.subtract(ToWhoTheyCall[np.subtract(np.where(ToWhoTheyCall <= np.max(Fathers)), 1)], 1)][0]
		FLevel[np.subtract(ToWhichFatherDoTheyCall.astype(int), 1)] = i + 1
	SegEndI[-1] = N
	Depth = max(Level)
	ret = {}
	ret['FLevel'] = FLevel
	ret['Level'] = Level
	ret['Depth'] = Depth
	ret['SegStartI'] = SegStartI
	ret['SegEndI'] = SegEndI
	ret['Fathers'] = Fathers
	ret['RelVec'] = RelVec
	ret['RelStarts'] = RelStarts
	ret['RelEnds'] = RelEnds
	ret['CallForFathers'] = CallForFathers[0]
	return ret
