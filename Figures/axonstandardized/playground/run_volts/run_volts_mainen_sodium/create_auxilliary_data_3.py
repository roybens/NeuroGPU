from make_tree_from_parent_vec import make_tree_from_parent_vec
from collections import OrderedDict
from auxilliary import Aux
import numpy as np
import cell
from file_io import *
from get_parent_from_neuron import get_parent_from_neuron
import scipy.io as sio
from cStringIO import StringIO
WARPSIZE = 32
import csv
import math

# input_dict = clean_creat_aux_3_mat(load_creat_aux_3_mat('/home/devloop0/inputCreatAux3.mat'))
# A = input_dict['A']
# Parent = input_dict['Parent']
# cmVec = input_dict['cmVec']
# NSeg = input_dict['NSeg']
# N = input_dict['N']
# nrn = create_neuron(input_dict)
# FN_TopoList = './64TL.csv'
fmatrixFN = './Fmatrix.csv'
def create_auxilliary_data_3(A, N, NSeg, Parent, cmVec,parent_seg,bool_model,seg_start,n_segs,seg_to_comp,data_dir):
	bool_model = np.array(bool_model)
        #print bool_model
        #np.savetxt("foo.csv", bool_model.T,fmt='%i', delimiter=",")
	FTYPESTR = 'float'
	#/print 'createAuxData3'
	# DOCUMMENTATION:
	#A is the hines matrix where i,i is my element look at chapter 8 in mathematics for neuroscientists. i-1,i is the mother element
	#
	FatherBase = [0 for i in range(N - 1)]
	for i in range(N - 1, 0, -1):#iterating all over the matrix from the end
		if  A[i - 1, i] !=0: # if i-1 element's parents is i then k is i+1
			k = i
                        #print 'if'
		else:# find where
			k = np.where(A[i:,i - 1] != 0)[0] + i + 1
			k = k[0]
                        #print 'else'
         #       print str(k) + 'a is' + str( A[i - 1, i])+ ',i si,' + str(i)
		FatherBase[i - 1] = k
	FatherBase = np.array(FatherBase)
	#print FatherBase
        #print A
	d = np.diag(A).T
	e, f = [0 for i in range(N)], [0 for i in range(N)]
	for i in range(1, N-1):
                #print 'i is' + str(i)+',' + str(FatherBase[i])  
		f[i-1] = A[i-1, FatherBase[i-1]-1]
		e[i] = A[FatherBase[i-1]-1, i-1]
	f[-1] = 0
        f[-2] = A[-2,-1]
        e[-1] = A[-1,-2]
	f = np.array(f)
	e = np.array(e)
        #print f
        #print e
	#found an error with e and f just reading them directly for now.
	[e,f] = readEFDirectly(fmatrixFN)
	Ksx = np.array(parent_seg)
	Ks = [0]
	for i in range(2, Ksx.size + 1):
		Ks.append(N + 1 - Ksx[N + 2 - i - 1])
	Ks = np.array(Ks)
	aux = Aux()
	aux.Ks = Ks.astype(np.int)
	FatherBase = Ks[1:]
	Father = np.append(FatherBase, [FatherBase.size + 2, FatherBase.size + 2])
	FIdxsX = []
	for i in range(1, int(np.ceil(np.log2(N)) + 3 + 1)):
		CurF = np.array(list(range(1, Father.size + 1)))
		for j in range(1, 2 ** (i - 1) + 1):
			CurF = Father[np.subtract(CurF, 1)].astype(np.int)
		FIdxsX.append(CurF)
	FIdxsX = np.array(FIdxsX)
	ind = np.where(np.all(FIdxsX == FIdxsX[-1], 1))[0][0] + 1
	if ind != 0:
		FIdxsX = FIdxsX[:ind - 1,:]
	
	LognDepth = FIdxsX.shape[0]
	FIdxsX = FIdxsX[:,:N]
	
	aux.FIdxsX = FIdxsX
	aux.LognDepth = LognDepth
	Nx = N
	SonNoVec, ParentUsed = np.zeros(Nx), np.zeros(Nx)
	for seg in range(1, Nx + 1):
		if seg == 1:
			parentIndex = 1	
		else:
			parentIndex = Nx + 1 - aux.Ks[Nx + 2 - seg - 1]
		ParentUsed[parentIndex - 1] = ParentUsed[parentIndex - 1] + 1
		SonNoVec[seg - 1] = ParentUsed[parentIndex - 1]
	
	SonNoVec[0] = 0
	aux.SonNoVec = SonNoVec
	if np.max(SonNoVec) > 2:
		raise ValueError('error np.max(SonNoVec) > 2')
	
	tree_dict = make_tree_from_parent_vec(aux, Ks, N)
	
	Depth = tree_dict['Depth']
	Level = tree_dict['Level']
	FLevel = tree_dict['FLevel']
	SegStartI = tree_dict['SegStartI']
	SegEndI = tree_dict['SegEndI']
	Fathers = tree_dict['Fathers']
	
	aux.Depth = Depth
	aux.Level = Level
	aux.FLevel = FLevel
	aux.SegStartI = SegStartI
	aux.SegEndI = SegEndI
	aux.Fathers = Fathers
	
	RelVec = tree_dict['RelVec']
	RelStarts = tree_dict['RelStarts']
	RelEnds = tree_dict['RelEnds']
	
	aux.RelVec = np.add(RelVec,1)
	aux.RelStarts = np.add(RelStarts,1)
	aux.RelEnds = np.add(RelEnds,1)
	
	LastLevelsI = np.where(Level == np.max(Level))[0][0] + 1
	EndLastLevelsI = SegEndI[LastLevelsI - 1]
	KsB = Ks
	KsB = np.append(KsB, [EndLastLevelsI])
	aux.KsB = KsB
	
	FN = data_dir + '/BasicConst' + str(N) + 'Seg.mat'
	FNP = data_dir + '/BasicConst' + str(N) + 'SegP.mat'
	FNM = data_dir + '/ParamsMat' + str(N) + '.mat'

	FN_csv = data_dir + '/BasicConst' +  'Seg.csv'
	FNP_csv = data_dir + '/BasicConst' +  'SegP.csv'

        FN_uint16 = data_dir + '/BasicConst' + str(N) + 'Seg_uint16.mat'
        FN_double = data_dir + '/BasicConst' + str(N) + 'Seg_double.mat'

        FNP_uint16 = data_dir + '/BasicConst' + str(N) + 'SegP_uint16.mat'
        FNP_double = data_dir + '/BasicConst' + str(N) + 'SegP_double.mat'
	
	aux.d = d
	aux.e = e
	aux.f = f
	aux.Cms = cmVec
	
	FN_dict = OrderedDict()
	FN_dict['N'] = np.array([np.uint16(N)])
	FN_dict['e'] = np.double(e)
	FN_dict['f'] = np.double(f)
	FN_dict['Ks'] = np.uint16(Ks)
	FN_dict['auxCms'] = np.double(aux.Cms);
	FN_dict['nrnHasHH'] = np.uint16(bool_model)
        FN_data = ''
        for k in FN_dict:
            s = StringIO()
            np.savetxt(s, FN_dict[k].flatten(), fmt='%.9f', newline=',')
            st = s.getvalue()
            FN_data += st + '\n'
        with open(FN_csv, 'w') as fn_f:
            fn_f.write(FN_data)

	sio.savemat(FN, FN_dict)

        FN_dict_uint16 = {}
        FN_dict_uint16['N'] = np.uint16(N)
        FN_dict_uint16['Ks'] = np.uint16(Ks)
        FN_dict_uint16['nrnHasHH'] = np.uint16(bool_model)
        sio.savemat(FN_uint16, FN_dict_uint16)

        FN_dict_double = {}
        FN_dict_double['e'] = np.double(e)
        FN_dict_double['f'] = np.double(f)
        FN_dict_double['auxCms'] = np.double(aux.Cms)
        sio.savemat(FN_double, FN_dict_double)


	CompByLevel32 = np.zeros((0, WARPSIZE))
	CompByFLevel32 = np.zeros((0, WARPSIZE))
	nFComps, nComps = np.array([]), np.array([])
	LRelated, FLRelated = [], []
	nRoundForThisLevel = np.array([])
	
	for CurLevel in range(Depth + 1):
		CurComps = np.add(np.where(Level == CurLevel)[0], 1)
		nComps = np.append(nComps, [CurComps.size])
		Longer = np.multiply(np.ones(int(np.ceil(CurComps.size / float(WARPSIZE)) * WARPSIZE)), CurComps[-1])
		Longer[:CurComps.size] = CurComps
		StuffToAdd = Longer.reshape((Longer.size / WARPSIZE, WARPSIZE))
		StartPoint = CompByLevel32.shape[0] + 1
		CompByLevel32 = np.vstack((CompByLevel32, StuffToAdd))
		EndPoint = CompByLevel32.shape[0]
		LRelated.append(list(range(StartPoint, EndPoint + 1)))
		nRoundForThisLevel = np.append(nRoundForThisLevel, [CompByLevel32.shape[0]])
		
		if CurLevel < Depth:
			CurComps = np.add(np.where(FLevel == CurLevel + 1)[0], 1)
			nFComps = np.append(nFComps, [CurComps.size])
			Longer = np.multiply(np.ones(int(np.ceil(CurComps.size / float(WARPSIZE)) * WARPSIZE)), CurComps[-1])
			Longer[:CurComps.size] = CurComps
			StuffToAdd = Longer.reshape((Longer.size / WARPSIZE, WARPSIZE))
			StartPoint = CompByFLevel32.shape[0] + 1
			CompByFLevel32 = np.vstack((CompByFLevel32, StuffToAdd))
			EndPoint = CompByFLevel32.shape[0]
			FLRelated.append(list(range(StartPoint, EndPoint + 1)))
			
	
	LRelated = np.array(LRelated)
	FLRelated = np.array(FLRelated).astype(object)
	
	LRelStarts, LRelEnds, LRelCN, LRelVec = cell.cell_2_vec(LRelated)
	LRelStarts = np.add(LRelStarts, 1)
	LRelEnds = np.add(LRelEnds, 1)
	if Depth == 0:
		FLRelStarts, FLRelEnds, FLRelCN, FLRelVec = [], [], [], []
	else:
		FLRelStarts, FLRelEnds, FLRelCN, FLRelVec = cell.cell_2_vec(FLRelated)
		FLRelStarts = np.add(FLRelStarts, 1)
		FLRelEnds = np.add(FLRelEnds, 1)
	
	NComps = NSeg.size
	CompsMid = np.zeros((NComps, 1))
	for i in range(1, NComps + 1):
		CompsMid[i - 1] = seg_start[i - 1] + np.floor(n_segs[i - 1] / 2)

	aux.LRelStarts = LRelStarts
	aux.LRelEnds = LRelEnds
	aux.FLRelStarts = FLRelStarts
	aux.FLRelEnds = FLRelEnds

	CompDepth32 = CompByLevel32.shape[0]
	aux.CompDepth32 = CompDepth32
	CompFDepth32 = CompByFLevel32.shape[0]
	
	CompsMid[0] += 1
	Nd32 = np.ceil(N / WARPSIZE)
	N32 = Nd32 * WARPSIZE
	nFathers = Fathers.size
	CallForFathers = tree_dict['CallForFathers']
	nCallForFather = CallForFathers.size
	aux.nCallForFather = nCallForFather
	FNP_dict = OrderedDict()
	FNP_dict['N'] = np.array(np.uint16([N]))
	FNP_dict['NComps'] = np.array(np.uint16([NComps]))
	FNP_dict['e'] = np.double(e)
	FNP_dict['f'] = np.double(f)
        FNP_dict['Ks'] = np.uint16(Ks)
        FNP_dict['SegToComp'] = np.uint16(seg_to_comp)
        FNP_dict['cmVec'] = np.double(cmVec)
	FNP_dict['nrnHasHHSize'] = np.array(np.uint16([bool_model.shape[0]]))
	FNP_dict['nrnHasHHT'] = bool_model
	FNP_dict['SonNoVec'] = np.uint16(SonNoVec)
	FNP_dict['Depth'] = np.array(np.uint16([Depth]))
	FNP_dict['LognDepth'] = np.array(np.uint16([LognDepth]))
	FNP_dict['nFathers'] = np.array(np.uint16([nFathers]))
	FNP_dict['nCallForFather'] = np.array(np.uint16([nCallForFather]))
	FNP_dict['RelStarts'] = np.uint16(aux.RelStarts)
        
	FNP_dict['RelEnds'] = np.uint16(aux.RelEnds)
	FNP_dict['RelVec'] = np.uint16(aux.RelVec)
	FNP_dict['SegStartI'] = np.uint16(aux.SegStartI)
	FNP_dict['SegEndI'] = np.uint16(aux.SegEndI)
	FNP_dict['auxFathers'] = np.uint16(aux.Fathers)
	FNP_dict['FIdxsXT'] = np.uint16(FIdxsX)
	FNP_dict['CompDepth32'] = np.uint16(np.array([CompDepth32]))
	FNP_dict['CompFDepth32'] = np.uint16(np.array([CompFDepth32]))
	FNP_dict['CompByLevel32T'] = np.uint16(CompByLevel32)
	FNP_dict['CompByFLevel32T'] = np.uint16(CompByFLevel32)
	aux.CompDepth32 = CompDepth32
	aux.CompFDepth32 = CompFDepth32
	FNP_dict['auxLRelStartsSize'] = np.uint16(np.array([aux.LRelStarts.size]))
	FNP_dict['auxLRelStarts_1'] = np.uint16(np.subtract(aux.LRelStarts, 1))
	FNP_dict['auxLRelEnds_1'] = np.uint16(np.subtract(aux.LRelEnds, 1))
	FNP_dict['auxFLRelStartsSize'] = np.uint16(np.array([aux.FLRelStarts.size]))
	FNP_dict['auxFLRelStarts_1'] = np.uint16(np.subtract(aux.FLRelStarts, 1))
	FNP_dict['auxFLRelEnds_1'] = np.uint16(np.subtract(aux.FLRelEnds, 1))
	FNP_dict['auxKsB_1'] = np.uint16(np.subtract(aux.KsB, 1))
        FNP_data = ''
        for k in FNP_dict:
            s = StringIO()
            np.savetxt(s, FNP_dict[k].flatten(), fmt='%.9f', newline=',')
            st = s.getvalue()
            FNP_data += st + '\n'
        with open(FNP_csv, 'w') as fnp_f:
            fnp_f.write(FNP_data)

	sio.savemat(FNP, FNP_dict)
	
	FNP_dict['auxKsB_1'] = np.uint16(np.subtract(aux.KsB, 1))

        FNP_dict_uint16 = {}
	FNP_dict_uint16['N'] = np.array(np.uint16([N]))
        FNP_dict_uint16['Ks'] = np.uint16(Ks)
        FNP_dict_uint16['SegToComp'] = np.uint16(seg_to_comp)
	FNP_dict_uint16['nrnHasHHSize'] = np.array(np.uint16([bool_model.shape[0]]))
	FNP_dict_uint16['nrnHasHHT'] = bool_model.T
	FNP_dict_uint16['SonNoVec'] = np.uint16(SonNoVec)
	FNP_dict_uint16['Depth'] = np.array(np.uint16([Depth]))
	FNP_dict_uint16['LognDepth'] = np.array(np.uint16([LognDepth]))
	FNP_dict_uint16['nFathers'] = np.array(np.uint16([nFathers]))
	FNP_dict_uint16['nCallForFather'] = np.array(np.uint16([nCallForFather]))
	FNP_dict_uint16['RelStarts'] = np.uint16(RelStarts)
	FNP_dict_uint16['RelEnds'] = np.uint16(RelEnds)
	FNP_dict_uint16['RelVec'] = np.uint16(RelVec)
	FNP_dict_uint16['SegStartI'] = np.uint16(SegStartI)
	FNP_dict_uint16['SegEndI'] = np.uint16(SegEndI)
	FNP_dict_uint16['auxFathers'] = np.uint16(aux.Fathers)
	FNP_dict_uint16['FIdxsXT'] = np.uint16(FIdxsX.T)
	FNP_dict_uint16['CompDepth32'] = np.uint16(np.array([CompDepth32]))
	FNP_dict_uint16['CompFDepth32'] = np.uint16(np.array([CompFDepth32]))
	FNP_dict_uint16['CompByLevel32T'] = np.uint16(CompByLevel32.T)
	FNP_dict_uint16['CompByFLevel32T'] = np.uint16(CompByFLevel32.T)
	FNP_dict_uint16['auxLRelStartsSize'] = np.uint16(np.array([aux.RelStarts.size]))
	FNP_dict_uint16['auxLRelStarts_1'] = np.uint16(np.subtract(aux.LRelStarts, 1))
	FNP_dict_uint16['auxLRelEnds_1'] = np.uint16(np.subtract(aux.LRelEnds, 1))
	FNP_dict_uint16['auxFLRelStartsSize'] = np.uint16(np.array([aux.FLRelStarts.size]))
	FNP_dict_uint16['auxFLRelStarts_1'] = np.uint16(np.subtract(aux.FLRelStarts, 1))
	FNP_dict_uint16['auxFLRelEnds_1'] = np.uint16(np.subtract(aux.FLRelEnds, 1))
	FNP_dict_uint16['auxKsB_1'] = np.uint16(np.subtract(aux.KsB, 1))
        sio.savemat(FNP_uint16, FN_dict_uint16)

        FNP_dict_double = {}
	FNP_dict_double['e'] = np.double(e)
	FNP_dict_double['f'] = np.double(f)
	FNP_dict_double['cmVec'] = np.double(cmVec)
        sio.savemat(FNP_double, FNP_dict_double)

	return FN, FNP, FNM, aux
def readEFDirectly(fn):
	data = np.genfromtxt(fn, dtype=np.float64, delimiter=' ')
	f = np.flipud(data[:,1])
	e = np.flipud(data[:,2])

	return [e,f]

