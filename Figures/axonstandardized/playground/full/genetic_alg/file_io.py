import scipy.io as sio
from auxilliary import Aux
from neuron_object import Neuron
import numpy as np

def load_creat_aux_3_mat(fname):
	return sio.loadmat(fname)

def load_make_tree_mat(fname):
	return sio.loadmat(fname)

def clean_make_tree_mat(mat):
	ret = {}
	ret['j'] = mat['j'][0][0]
	ret['SegStartI'] = mat['SegStartI'][0]
	ret['seg'] = mat['seg'][0]
	ret['Father'] = mat['Father'][0]
	ret['Ksx'] = mat['Ksx'][0]
	ret['Nx'] = mat['Nx'][0][0]
	ret['FF'] = mat['FF'][0][0]
	ret['RFathers'] = mat['RFathers'][0]
	ret['RelEnds'] = mat['RelEnds'][0]
	auxDict = {}
	auxDict['Data'] = mat['Aux'][0][0][0][0]
	auxDict['Ks'] = None
	auxDict['FIdxsX'] = None
	auxDict['LognDepth'] = None
	auxDict['SonNoVec'] = None
	ret['Aux'] = auxDict
	ret['RelCN'] = mat['RelCN'][0]
	ret['Parent'] = mat['Parent'][0]
	ret['CallForFathers'] = mat['CallForFathers'][0]
	ret['FatherBase'] = mat['FatherBase'][0]
	ret['ToWhoTheyCall'] = mat['ToWhoTheyCall'][0]
	ret['FTYPESTR'] = mat['FTYPESTR'][0]
	ret['__version__'] = mat['__version__']
	ret['cmVec'] = mat['cmVec'][0]
	ret['A'] = mat['A'][0]
	ret['ToWhichFatherDoTheyCall'] = mat['ToWhichFatherDoTheyCall']
	ret['Level'] = mat['Level'][0]
	ret['NSeg'] = mat['NSeg'][0]
	ret['LognDepth'] = mat['LognDepth'][0]
	ret['N'] = mat['N'][0]
	ret['Ks'] = mat['Ks'][0]
	ret['ParentUsed'] = mat['ParentUsed'][0]
	ret['SonNoVec'] = mat['SonNoVec'][0]
	ret['parentIndex'] = mat['parentIndex'][0][0]
	ret['CurF'] = mat['CurF'][0]
	ret['e'] = mat['e'][0]
	ret['d'] = mat['d'][0]
	ret['FLevel'] = mat['FLevel'][0]
	ret['f'] = mat['f'][0]
	ret['i'] = mat['i'][0][0]
	ret['k'] = mat['k'][0][0]
	ret['__header__'] = mat['__header__']
	related = []
	for i in mat['Related'][0]:
		if i.size == 1:
			related.append((i[0][0]))
		else:
			related.append((i[0][0], i[0][1]))
	ret['Related'] = related
	ret['__globals__'] = mat['__globals__']
	ret['NN'] = mat['NN'][0]
	ret['FN_TopoList'] = mat['FN_TopoList'][0]
	ret['SegEndI'] = mat['SegEndI'][0]
	ret['RelStarts'] = mat['RelStarts'][0]
	ret['Fathers'] = mat['Fathers'][0]
	ret['RelVec'] = mat['RelVec'][0]
	return ret

def create_aux(cleaned):
	ret = Aux();
	ret.Ks = cleaned['Ks']
	return ret

def load_input_csv(file_name):
	f = open(file_name, 'r')
	d = {}
	for i in f:
		temp = i[:len(i) - 2].split(',')
		name = temp[0]
		values = [int(j) for j in temp[1:]]
		d[name] = values
	return d

def clean_creat_aux_3_mat(mat):
	ret = {}
	ret['Parent'] = mat['Parent'][0]
	ret['__globals__'] = mat['__globals__']
	ret['NSeg'] = mat['NSeg'][0]
	ret['__header__'] = mat['__header__']
	ret['N'] = mat['N'][0][0]
	ret['cmVec'] = mat['cmVec'][0]
	ret['FN_TopoList'] = mat['FN_TopoList'][0]
	ret['A'] = mat['A']
	ret['Neuron'] = {}
	ret['Neuron']['Cms'] = np.array([i[0] for i in mat['Neuron']['Cms'][0][0]])
	ret['Neuron']['HasHH'] = mat['Neuron']['HasHH'][0][0]
	ret['Neuron']['SegStart'] = mat['Neuron']['SegStart'][0][0][0]
	ret['Neuron']['NSegs'] = mat['Neuron']['NSegs'][0][0]
	ret['Neuron']['SegToComp'] = mat['Neuron']['SegToComp'][0][0][0]
	ret['Neuron']['HasHH'] = mat['Neuron']['HasHH'][0][0]
	return ret

def create_neuron(cleaned):
	ret = Neuron()
	ret.Cms = cleaned['Neuron']['Cms']
	ret.HasHH = cleaned['Neuron']['HasHH']
	ret.SegStart = cleaned['Neuron']['SegStart']
	ret.NSegs = cleaned['Neuron']['NSegs']
	ret.SegToComp = cleaned['Neuron']['SegToComp']
	ret.HasHH = cleaned['Neuron']['HasHH']
	return ret

def get_lines(file_name):
    lines = []
    with open(file_name, 'r') as f:
        for line in f:
		lines.append(line[:-1])
    return lines

def put_lines(file_name, lines):
    with open(file_name, 'w') as f:
        for line in lines:
            f.write(str(line) + '\n')
