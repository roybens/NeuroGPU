#include "CudaStuff.cuh"
//#include "AllModels.cu"
#include "AllModels.cuh"
#define ILP16
__constant__ MYFTYPE cCm[NSEG];
__constant__ MYSECONDFTYPE cE[NSEG];
__constant__ MYSECONDFTYPE cF[NSEG];
__constant__ MYDTYPE cFIdxs[NSEG*LOG_N_DEPTH];
__constant__ MYDTYPE cKs[NSEG];
__constant__ MYDTYPE cSegToComp[NSEG];
__constant__ MYDTYPE cBoolModel[NSEG * N_MODELS];//One day change this to bool
__constant__ MYDTYPE cRelStarts[N_FATHERS];//nFathers
__constant__ MYDTYPE cRelEnds[N_FATHERS];//nFathers
__constant__ MYDTYPE cFathers[N_FATHERS];//nFathers
__constant__ MYDTYPE cRelVec[N_CALL_FOR_FATHER];//nCallForFather
__constant__ MYDTYPE cSegStartI[N_CALL_FOR_FATHER + 1];//nCallForFather
__constant__ MYDTYPE cSegEndI[N_CALL_FOR_FATHER + 1];//nCallForFather

__constant__ MYDTYPE cCompByLevel32[COMP_DEPTH*WARPSIZE];//CompDepth
__constant__ MYDTYPE cCompByFLevel32[COMP_DEPTH*WARPSIZE];//CompFDepth
__constant__ MYDTYPE cLRelStarts[N_L_REL];//nLRel
__constant__ MYDTYPE cLRelEnds[N_L_REL];//nLRel
__constant__ MYDTYPE cFLRelStarts[N_F_L_REL];//nFLRel
__constant__ MYDTYPE cFLRelEnds[N_F_L_REL];//nFLRel
__constant__ MYDTYPE cSonNoVec[NSEG];//InMat.N 


#ifdef __INTELLISENSE__
void __syncthreads();
#endif

#define d_bhp_macro(segmentInd) d_bHP[NeuronID*(NSEG+2)+ segmentInd]
#define d_uhp_macro(segmentInd) d_uHP[NeuronID*(NSEG+2) + segmentInd]

__global__ void BeforeLU(HMat InMat, MYSECONDFTYPE* d_uHP, MYSECONDFTYPE* d_bHP, MYDTYPE Depth)
{
	MYSECONDFTYPE *uHP, *bHP;
	MYDTYPE NeuronID = blockIdx.x;
	MYDTYPE PerStimulus = ((NSEG + 2) * 2 * sizeof(MYSECONDFTYPE));
	PerStimulus = ceilf(MYSECONDFTYPE(PerStimulus) / sizeof(MYSECONDFTYPE)) * sizeof(MYSECONDFTYPE);
	MYDTYPE offset = PerStimulus*threadIdx.y;
	uHP = (MYSECONDFTYPE*)&smem[offset];
	offset += (NSEG + 2) * sizeof(MYSECONDFTYPE);
	bHP = (MYSECONDFTYPE*)&smem[offset];
	offset += (NSEG + 2) * sizeof(MYSECONDFTYPE);
	offset = ceilf(MYSECONDFTYPE(offset) / sizeof(MYSECONDFTYPE)) * sizeof(MYSECONDFTYPE);
	MYDTYPE currIdx = threadIdx.x;
	MYDTYPE i, j, CurJ, CurB, t, CurLevel, LRelIndex;
	MYDTYPE JumctionI;
	MYDTYPE PIdx[NILP + 1];
	for (int count = 1; count < NILP + 1; count++) {
		PIdx[count] = threadIdx.x + (WARPSIZE*(count - 1));
		bHP[PIdx[count]] = d_bhp_macro(PIdx[count]);
		uHP[PIdx[count]] = d_uhp_macro(PIdx[count]);
	}
	//__syncthreads;

	LRelIndex = cLRelStarts[CurLevel];
	LRelIndex = LRelIndex + cLRelEnds[CurLevel];
	for (CurLevel = 0; CurLevel <= Depth; CurLevel++) {

		for (LRelIndex = cLRelStarts[CurLevel]; LRelIndex <= cLRelEnds[CurLevel]; LRelIndex++) {
			//for(LRelIndex=cLRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
			JumctionI = cCompByLevel32[LRelIndex*WARPSIZE + currIdx] - 1;
			for (i = cSegStartI[JumctionI] - 1; i<cSegEndI[JumctionI]; i++) {
				MYSECONDFTYPE uHPm1 = uHP[i - 1];

				uHP[i] = uHP[i] - cF[i - 1] * (cE[i - 1] / uHPm1); // So far same as paper parallel
				uHPm1 = uHP[i - 1];
				MYSECONDFTYPE bHPm1 = bHP[i - 1];
				bHP[i] = bHP[i] - bHPm1*cE[i - 1] / uHPm1; // bH is y
			}
		}
		if (CurLevel<Depth) {
			for (LRelIndex = cFLRelStarts[CurLevel]; LRelIndex <= cFLRelEnds[CurLevel]; LRelIndex++) {
				CurB = cCompByFLevel32[(LRelIndex)*WARPSIZE + currIdx] - 1;//RB i inserted another  -1 into the index RB 2 i removed the-1 from the curlevel 
				CurJ = cFathers[CurB] - 1;
				MYDTYPE St = cRelStarts[CurB];
				MYDTYPE En = cRelEnds[CurB];
				for (j = St; j <= En; j++) {
					t = cRelVec[j - 1] - 1;
					MYSECONDFTYPE uHPm1 = uHP[t - 1];
					uHP[CurJ] -= cF[t - 1] * (cE[t - 1] / uHPm1);
					uHPm1 = uHP[t - 1];
					MYSECONDFTYPE bHPm1 = bHP[t - 1];
					bHP[CurJ] -= bHPm1*cE[t - 1] / uHPm1;
				}
			}
		}
	}
	//__syncthreads;
	for (int count = 1; count < NILP + 1; count++) {
		d_bhp_macro(PIdx[count]) = bHP[PIdx[count]];
		d_uhp_macro(PIdx[count]) = uHP[PIdx[count]];
	}
}

#ifdef BKSUB1
__global__ void BkSub(HMat InMat, MYSECONDFTYPE* d_uHP, MYSECONDFTYPE* d_bHP,  MYDTYPE LognDepth)
{
	MYDTYPE NeuronID = blockIdx.x;
	// MYDTYPE PIdx_1=threadIdx.x; // MYDTYPE NextID_1;
	MYDTYPE PIdx[NILP + 1];
	MYDTYPE NextID[NILP + 1];
	MYSECONDFTYPE *PX,*PF;
	MYDTYPE PerStimulus = ((NSEG + 2) * 2 * sizeof(MYSECONDFTYPE));
	PerStimulus = ceilf(MYSECONDFTYPE(PerStimulus) / sizeof(MYSECONDFTYPE)) * sizeof(MYSECONDFTYPE);
	MYDTYPE offset = PerStimulus*threadIdx.y;
	PF = (MYSECONDFTYPE*)&smem[offset];
	offset += (NSEG + 2) * sizeof(MYSECONDFTYPE);
	PX = (MYSECONDFTYPE*)&smem[offset];
	offset += (NSEG + 2) * sizeof(MYSECONDFTYPE);
	offset = ceilf(MYSECONDFTYPE(offset) / sizeof(MYSECONDFTYPE)) * sizeof(MYSECONDFTYPE);
	for (int count = 1; count < NILP + 1; count++) {
		PIdx[count] = threadIdx.x + (WARPSIZE*(count - 1));
		PX[PIdx[count]] = d_bhp_macro(PIdx[count]);
		PF[PIdx[count]] = d_uhp_macro(PIdx[count]);

	}
	//__syncthreads;
	for (int count = 1; count < NILP + 1; count++) {
		PX[PIdx[count]] = PX[PIdx[count]] / PF[PIdx[count]];
		PF[PIdx[count]] = -cF[PIdx[count]] / PF[PIdx[count]];
		
	}
	MYFTYPE OldPXj[NILP + 1];
	MYFTYPE OldPXNextID[NILP + 1];
	MYFTYPE OldPFj[NILP + 1];
	MYFTYPE OldPFNextID[NILP + 1];

	//#define Replace MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*(## VARILP -1)); MYDTYPE NextID_ ## VARILP ;
	MYDTYPE i;
	// PX[PIdx_1]=PX[PIdx_1]/PF[PIdx_1]; // PF[PIdx_1]=-cF[PIdx_1]/PF[PIdx_1];
	//#define Replace  PX[PIdx_ ## VARILP ]=PX[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ]; PF[PIdx_ ## VARILP ]=-cF[PIdx_ ## VARILP ]/PF[PIdx_ ## VARILP ];


	PX[InMat.N] = 0;
	PF[InMat.N] = 1;
	for (i = 0; i<LognDepth; i++) {
		// NextID_1=cFIdxs[i*InMat.N+PIdx_1]-1; // MYFTYPE OldPXj_1=PX[PIdx_1]; // MYFTYPE OldPXNextID_1=PX[NextID_1]; // PX[PIdx_1]=OldPXj_1+OldPXNextID_1*PF[PIdx_1];
		//#define REPLACE NextID_ ## VARILP =cFIdxs[i*InMat.N+PIdx_ ## VARILP ]-1; MYFTYPE OldPXj_ ## VARILP =PX[PIdx_ ## VARILP ]; MYFTYPE OldPXNextID_ ## VARILP =PX[NextID_ ## VARILP ]; PX[PIdx_ ## VARILP ]=OldPXj_ ## VARILP +OldPXNextID_ ## VARILP *PF[PIdx_ ## VARILP ];
		for (int count = 1; count < NILP + 1; count++) {
			NextID[count] = cFIdxs[i*InMat.N + PIdx[count]] - 1;
			OldPXj[count] = PX[PIdx[count]];
			OldPXNextID[count] = PX[NextID[count]];
			PX[PIdx[count]] = OldPXj[count] + OldPXNextID[count] * PF[PIdx[count]];
		}
		for (int count = 1; count < NILP + 1; count++) {
			OldPFj[count] = PF[PIdx[count]];
			OldPFNextID[count] = PF[NextID[count]];
			PF[PIdx[count]] = OldPFj[count] * OldPFNextID[count];
		}



		// PX[j]=PX[j]+PX[NextID]*PF[j];
		// PF[j]=PF[j]*PF[NextID];
		// MYFTYPE OldPFj_1=PF[PIdx_1]; // MYFTYPE OldPFNextID_1=PF[NextID_1]; // PF[PIdx_1]=OldPFj_1*OldPFNextID_1;
		//#define TReplaced MYFTYPE OldPFj_ ## VARILP =PF[PIdx_ ## VARILP ]; MYFTYPE OldPFNextID_ ## VARILP =PF[NextID_ ## VARILP ]; PF[PIdx_ ## VARILP ]=OldPFj_ ## VARILP *OldPFNextID_ ## VARILP ;

	}
	for (int count = 1; count < NILP + 1; count++) {
		d_bhp_macro(PIdx[count]) = PX[PIdx[count]];
		d_uhp_macro(PIdx[count]) = PF[PIdx[count]];

	}
}
#endif

#ifdef BKSUB2
__device__ void BkSub(HMat InMat, MYSECONDFTYPE* uHP, MYSECONDFTYPE* bHP, MYSECONDFTYPE* Out, MYDTYPE Depth)
{
	// MYDTYPE PIdx_3=threadIdx.x+(WARPSIZE*2); Out[PIdx_2]=0; // might be useless?
#define THISCOMMANDHEREB1(VARILP) MYDTYPE PIdx_ ## VARILP =threadIdx.x+(WARPSIZE*( ## VARILP -1)); Out[PIdx_ ## VARILP ]=0;
	MYDTYPE PIdx[1] = threadIdx.x + (WARPSIZE*([1] - 1)); Out[PIdx[1]] = 0;

	MYDTYPE j, CurJ, CurB, t;
	MYDTYPE JumctionI;
	short CurLevel, i;

	// get KsB from MATLAB (this comes instead of FIdxsX)
	// KsB=Ks; // do in matlab

	// bPX=zeros(1,N); // might be useless
	// for CurLevel=Depth:-1:0
	MYDTYPE LRelIndex, k;
	MYFTYPE temp;
	for (CurLevel = Depth; CurLevel >= 0; CurLevel--) {
		//     Run all independent set for this level, in parallel
		// for JumctionI=find(Level==CurLevel) % in parallel
		for (LRelIndex = cLRelStarts[CurLevel]; LRelIndex <= cLRelEnds[CurLevel]; LRelIndex++) {
			JumctionI = cCompByLevel32[LRelIndex*WARPSIZE + PIdx_1] - 1;
			// for i=(cSegEndI(JumctionI)):-1:(cSegStartI(JumctionI)-1)
			for (i = cSegEndI[JumctionI] - 1; i >= (cSegStartI[JumctionI] - 2); i--) {
				// k=cKsB(i+1);
				k = cKsB[i + 1];

				// bPX(i)=(bH(i)-bPX(k)*f(i))/uH(i);
				Out[i] = (bHP[i] - Out[k] * cF[i]) / uHP[i];
			}
		}
	}
}
#endif
#define perThreadParamMSize NCOMPS*NPARAMS
#define perBlockStatesSize (NSEG)*(NSTATES + 1) 
#define perBlockCaSize (NSEG)
#define perBlockVSize  (NSEG)
#define param_macro(paramInd,segmentInd) ParamsM[NeuronID*perThreadParamMSize + paramInd*NCOMPS+cSegToComp[segmentInd] ]
#define state_macro(stateind,segmentInd) ModelStates[NeuronID*perBlockStatesSize + stateind*NSEG+PIdx[segmentInd]]
#define ca_macro(countInd,ca_arr) ca_arr[NeuronID*perBlockCaSize + PIdx[countInd]]
#define v_macro(segmentInd) V[NeuronID*perBlockVSize + segmentInd]
#define dv_macro(segmentInd) dv[NeuronID*perBlockVSize + segmentInd]
		


__global__ void initModels(HMat InMat,MYFTYPE *V, const MYFTYPE* __restrict__ ParamsM, MYFTYPE* ModelStates,MYFTYPE* cai,MYFTYPE* ica, MYFTYPE* eca ) {
	MYDTYPE PIdx[NILP+1];
	MYFTYPE v[NILP + 1];
	MYDTYPE NeuronID = blockIdx.x;

	for (int count = 1; count < NILP + 1; count++) {
		PIdx[count] = threadIdx.x + (WARPSIZE*(count - 1));
		v[count] = v_macro(PIdx[count]);
	if(cBoolModel[PIdx[count] +0*NSEG]){CuInitModel_Ca_HVA(v[count],state_macro(1,count) ,state_macro(2,count) ,param_macro(0, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuInitModel_Ca_LVAst(v[count],state_macro(3,count) ,state_macro(4,count) ,param_macro(1, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuInitModel_CaDynamics_E2(v[count],cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuInitModel_Ih(v[count],state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuInitModel_Im(v[count],state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuInitModel_K_Pst(v[count],state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuInitModel_K_Tst(v[count],state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuInitModel_Nap_Et2(v[count],state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuInitModel_NaTa_t(v[count],state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuInitModel_NaTs2_t(v[count],state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuInitModel_pas(v[count],param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuInitModel_SK_E2(v[count],state_macro(18,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuInitModel_SKv3_1(v[count],state_macro(17,count) ,param_macro(18, PIdx[count]) );}
	}
}




//currently only doing one point stimulus

__global__ void updateMatrix(const MYFTYPE* __restrict__ ParamsM, MYFTYPE* ModelStates, MYFTYPE* cai, MYFTYPE* ica, MYFTYPE* eca, MYFTYPE* V, MYFTYPE stimAmp,MYDTYPE stimLoc, MYFTYPE stimArea, MYFTYPE dt,MYFTYPE *d_uHP, MYFTYPE *d_bHP,MYFTYPE *dv)
{

	
	MYSECONDFTYPE *uHP, *bHP;
	//MYDTYPE StimID = threadIdx.y;

#ifdef BKSUB2
	MYDTYPE PerStimulus = ((NSEG + 2) * 2 * sizeof(MYSECONDFTYPE)) + (NSEG + 2 * WARPSIZE) * sizeof(MYFTYPE);
#endif
#ifdef BKSUB1

	MYDTYPE PerStimulus = ((NSEG + 2) * 2 * sizeof(MYSECONDFTYPE));
	PerStimulus = ceilf(MYSECONDFTYPE(PerStimulus) / sizeof(MYSECONDFTYPE)) * sizeof(MYSECONDFTYPE);
#endif

	MYDTYPE offset = PerStimulus*threadIdx.y;
	uHP = (MYSECONDFTYPE*)&smem[offset];
	offset += (NSEG + 2) * sizeof(MYSECONDFTYPE);
	bHP = (MYSECONDFTYPE*)&smem[offset];
	offset += (NSEG + 2) * sizeof(MYSECONDFTYPE);
	offset = ceilf(MYSECONDFTYPE(offset) / sizeof(MYSECONDFTYPE)) * sizeof(MYSECONDFTYPE);
	MYDTYPE NeuronID = blockIdx.x;
	//int Nt = stim.Nt;
	MYFTYPE t = 0;
	//MYSECONDFTYPE *PX, *PF;
	//PX = bHP;
	//PF = uHP;

	MYDTYPE PIdx[NILP + 1];
	for (int count = 1; count < NILP + 1; count++) {
		PIdx[count] = threadIdx.x + (WARPSIZE*(count - 1));
	}

	MYFTYPE Vmid[NILP + 1];
	MYFTYPE v[NILP + 1];
	MYSECONDFTYPE sumCurrents[NILP + 1];
	MYSECONDFTYPE sumCurrentsDv[NILP + 1];
	MYFTYPE sumConductivity[NILP + 1];
	MYFTYPE sumConductivityDv[NILP + 1];
	MYDTYPE parentIndex[NILP + 1];
	MYDTYPE Eidx[NILP + 1];
	MYSECONDFTYPE rhs[NILP + 1];
	MYSECONDFTYPE D[NILP + 1];
	MYFTYPE gModel[NILP + 1];
	MYFTYPE StimCurrent[NILP + 1];
	for (int count = 1; count < NILP + 1; count++) {
		v[count] = v_macro(PIdx[count]);
		sumCurrents[count] = 0;
		sumCurrentsDv[count] = 0;
		sumConductivity[count] = 0;
		sumConductivityDv[count] = 0;
		bHP[PIdx[count]] = d_bhp_macro(PIdx[count]);

		//dv[count] = 0;
		Eidx[count] = NSEG - PIdx[count] - 1;
		parentIndex[count] = NSEG - cKs[NSEG - PIdx[count]];
		if (PIdx[count] == 0) {
			parentIndex[count] = 0;
		};
	}
	if (Eidx[1] > NSEG - 1) {
		Eidx[1] = NSEG - 1;
	}
	MYFTYPE temp;
	for (int count = 1; count < NILP + 1; count++) {
		rhs[count] = 0;
		D[count] = 0;
		sumCurrents[count] = 0;
		sumConductivity[count] = 0;
		sumCurrentsDv[count] = 0;
		sumConductivityDv[count] = 0;
		StimCurrent[count] = 0;
		ca_macro(count,ica) = 0;//SERIOUSLY??? check if this is correct does not seem right!!!! the whole point of ica is not to be initialized every time step...
		if (PIdx[count] == stimLoc) {
			StimCurrent[count] = 100 * stimAmp / stimArea;
		}
	}
	for (int count = 1; count < NILP + 1; count++) {
	   if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_Ca_HVA(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(1,count) ,state_macro(2,count) ,param_macro(0, PIdx[count]) , temp,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_Ca_LVAst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(3,count) ,state_macro(4,count) ,param_macro(1, PIdx[count]) , temp,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_CaDynamics_E2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , temp,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_Ih(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_Im(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_K_Pst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_K_Tst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_Nap_Et2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_NaTa_t(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuBreakpointModel_NaTs2_t(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuBreakpointModel_pas(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuBreakpointModel_SK_E2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(18,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuBreakpointModel_SKv3_1(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(17,count) ,param_macro(18, PIdx[count]) );}
	  if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_Ca_HVA(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(1,count) ,state_macro(2,count) ,param_macro(0, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_Ca_LVAst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(3,count) ,state_macro(4,count) ,param_macro(1, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_CaDynamics_E2(sumCurrents[count] , sumConductivity[count],v[count] ,cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_Ih(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_Im(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_K_Pst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_K_Tst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_Nap_Et2(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_NaTa_t(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuBreakpointModel_NaTs2_t(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuBreakpointModel_pas(sumCurrents[count] , sumConductivity[count],v[count] ,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuBreakpointModel_SK_E2(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(18,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuBreakpointModel_SKv3_1(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(17,count) ,param_macro(18, PIdx[count]) );}
	}
	for (int count = 1; count < NILP + 1; count++) {
		gModel[count] = (sumCurrentsDv[count] - sumCurrents[count]) / EPS_V;
		rhs[count] = StimCurrent[count] - sumCurrents[count];
		D[count] = gModel[count] + cCm[PIdx[count]] / (dt * 1000);
		D[count] -= cF[NSEG - PIdx[count] - 1];
		dv_macro(PIdx[count]) += bHP[NSEG - parentIndex[count] - 1] - bHP[NSEG - PIdx[count] - 1];
	}
//	__syncthreads();
	for (int count = 1; count < NILP + 1; count++) {
		rhs[count] -= cF[NSEG - PIdx[count] - 1] * dv_macro(PIdx[count]);
		bHP[NSEG - PIdx[count] - 1] = rhs[count];
		uHP[NSEG - PIdx[count] - 1] = D[count];
	}
//	__syncthreads();
	for (int count = 1; count < NILP + 1; count++) {
		if (cSonNoVec[PIdx[count]] == 1) {
			bHP[NSEG - parentIndex[count] - 1] += cE[Eidx[count]] * dv_macro(PIdx[count]);
			uHP[NSEG - parentIndex[count] - 1] -= cE[Eidx[count]];
		}//WILL THIS WORK???
		if (cSonNoVec[PIdx[count]] == 2) {
			bHP[NSEG - parentIndex[count] - 1] += cE[Eidx[count]] * dv_macro(PIdx[count]);
			uHP[NSEG - parentIndex[count] - 1] -= cE[Eidx[count]];
		}
	}
	//__syncthreads();
	for (int count = 1; count < NILP + 1; count++) {
		d_bhp_macro(PIdx[count]) = bHP[PIdx[count]];
		d_uhp_macro(PIdx[count]) = uHP[PIdx[count]];
	}

}


__global__ void deriv_and_update_v( const MYFTYPE* __restrict__ ParamsM, MYFTYPE* ModelStates, MYFTYPE* cai, MYFTYPE* ica, MYFTYPE* eca,  MYFTYPE *V,MYFTYPE* d_bHP,MYFTYPE dt,MYDTYPE stimLoc,MYFTYPE* Vhot) {
	MYDTYPE PIdx[NILP + 1];
	MYDTYPE NeuronID = blockIdx.x;
	MYDTYPE v[NILP + 1];
	for (int count = 1; count < NILP + 1; count++) {
		PIdx[count] = threadIdx.x + (WARPSIZE*(count - 1));
		v_macro(PIdx[count]) += d_bhp_macro(NSEG - PIdx[count] - 1);
		v[count] = v_macro(PIdx[count]);
	  if(cBoolModel[PIdx[count] +0*NSEG]){CuDerivModel_Ca_HVA(dt, v[count],state_macro(1,count) ,state_macro(2,count) ,param_macro(0, PIdx[count]) , ica[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuDerivModel_Ca_LVAst(dt, v[count],state_macro(3,count) ,state_macro(4,count) ,param_macro(1, PIdx[count]) , ica[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuDerivModel_CaDynamics_E2(dt, v[count],cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuDerivModel_Ih(dt, v[count],state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuDerivModel_Im(dt, v[count],state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuDerivModel_K_Pst(dt, v[count],state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuDerivModel_K_Tst(dt, v[count],state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuDerivModel_Nap_Et2(dt, v[count],state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuDerivModel_NaTa_t(dt, v[count],state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuDerivModel_NaTs2_t(dt, v[count],state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){}if(cBoolModel[PIdx[count] +11*NSEG]){CuDerivModel_SK_E2(dt, v[count],state_macro(18,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuDerivModel_SKv3_1(dt, v[count],state_macro(17,count) ,param_macro(18, PIdx[count]) );}
	}
	if (threadIdx.x == 0) {
		Vhot[NeuronID] = v_macro(stimLoc);
	}

	
}

void ReadParamsMatX(const char* FN, MYFTYPE* ParamsM, MYDTYPE NParams, MYDTYPE Nx) {
	char FileName[300];
	sprintf(FileName, "%sForC.mat", FN);
	FILE *fl = fopen(FileName, "rb"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read TreeData.x\n");
		return;
	}
	fread(ParamsM, sizeof(MYFTYPE), Nx*NParams, fl);
	fclose(fl);
}

void ReadParamsMat(const char* FN, MYFTYPE** ParamsM, MYDTYPE NParams, MYDTYPE Nx) {
	char FileName[300];
	//sprintf(FileName,"%s%d.mat",FN,MUL32*32);
	sprintf(FileName, "%sForC.mat", FN);
	FILE *fl = fopen(FileName, "rb"); // YYY add FILE*
	if (!fl) {
		printf("Failed to read TreeData.x\n");
		return;
	}
	for (int i = 0; i<NParams; i++) {
		ParamsM[i] = (MYFTYPE*)malloc(Nx * sizeof(MYFTYPE));
		fread(ParamsM[i], sizeof(MYFTYPE), Nx, fl);
	}
	fclose(fl);
}


void initFrameWork(Stim stim, Sim sim, MYFTYPE* ParamsM, MYFTYPE* InitStatesM, HMat& InMat, MYDTYPE CompDepth, MYDTYPE CompFDepth, MYDTYPE NSets, HMat& Mat_d) {

	printf("in initframework\n");
	cudaError_t cudaStatus;
	int i, j, t;
	// For matrix -
	MYFTYPE *PXOut_d, *PFOut_d;
	MYFTYPE *uHPOut_d, *bHPOut_d;
	Mat_d.N = InMat.N;
	Mat_d.NComps = InMat.NComps;
	Mat_d.Depth = InMat.Depth;
	Mat_d.NModels = InMat.NModels;
	Mat_d.LognDepth = InMat.LognDepth;
	Mat_d.nFathers = InMat.nFathers;
	Mat_d.nCallForFather = InMat.nCallForFather;
	Mat_d.nLRel = InMat.nLRel;
	Mat_d.nFLRel = InMat.nFLRel;
	// 32 data
#ifdef BKSUB1
	//cudaStatus = cudaMalloc((void**)&Mat_d.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE));
#endif
#ifdef BKSUB2
	cudaStatus = cudaMalloc((void**)&Mat_d.KsB, (InMat.N + 1) * sizeof(MYDTYPE));
#endif
	CUDA_RT_CALL(cudaMemcpyToSymbol(cE, InMat.e, InMat.N * sizeof(MYSECONDFTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cF, InMat.f, InMat.N * sizeof(MYSECONDFTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cKs, InMat.Ks, InMat.N * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cSegToComp, InMat.SegToComp, InMat.N * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cBoolModel, InMat.boolModel, InMat.N * InMat.NModels * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cCm, InMat.Cms, InMat.N * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cSonNoVec, InMat.SonNoVec, InMat.N * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cRelStarts, InMat.RelStarts, InMat.nFathers * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cRelEnds, InMat.RelEnds, InMat.nFathers * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cRelVec, InMat.RelVec, InMat.nCallForFather * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMemcpyToSymbol(cSegStartI, InMat.SegStartI, (InMat.nCallForFather + 1) * sizeof(MYDTYPE)));
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.SegEndI, InMat.SegEndI, (InMat.nCallForFather+1)* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cSegEndI, InMat.SegEndI, (InMat.nCallForFather + 1) * sizeof(MYDTYPE)));
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.Fathers, InMat.Fathers, InMat.nFathers * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cFathers, InMat.Fathers, InMat.nFathers * sizeof(MYDTYPE)));
	// 32 data
#ifdef BKSUB1
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.FIdxs, InMat.FIdxs, InMat.LognDepth*InMat.N* sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cFIdxs, InMat.FIdxs, InMat.LognDepth*InMat.N * sizeof(MYDTYPE)));
#endif
#ifdef BKSUB2
	CUDA_RT_CALL(cudaMemcpy(Mat_d.KsB, InMat.KsB, (InMat.N + 1) * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
#endif
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.CompByLevel32, InMat.CompByLevel32, (CompDepth)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cCompByLevel32, InMat.CompByLevel32, (CompDepth)*WARPSIZE * sizeof(MYDTYPE)));
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.CompByFLevel32, InMat.CompByFLevel32, (CompFDepth)*WARPSIZE*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cCompByFLevel32, InMat.CompByFLevel32, (CompFDepth)*WARPSIZE * sizeof(MYDTYPE)));


	//CUDA_RT_CALL(cudaMemcpy(Mat_d.LRelStarts, InMat.LRelStarts,InMat.nLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cLRelStarts, InMat.LRelStarts, InMat.nLRel * sizeof(MYDTYPE)));
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.LRelEnds, InMat.LRelEnds,InMat.nLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cLRelEnds, InMat.LRelEnds, InMat.nLRel * sizeof(MYDTYPE)));
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.FLRelStarts, InMat.FLRelStarts,InMat.nFLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cFLRelStarts, InMat.FLRelStarts, InMat.nFLRel * sizeof(MYDTYPE)));
	//CUDA_RT_CALL(cudaMemcpy(Mat_d.FLRelEnds, InMat.FLRelEnds,InMat.nFLRel*sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpyToSymbol(cFLRelEnds, InMat.FLRelEnds, InMat.nFLRel * sizeof(MYDTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&PXOut_d, (InMat.N + 1) * sizeof(MYSECONDFTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&PFOut_d, (InMat.N + 1) * sizeof(MYSECONDFTYPE)));
	CUDA_RT_CALL(cudaThreadSynchronize());
	printf("done with all init framework\n");
}





void callKernel(Stim stim, Sim sim, MYFTYPE* ParamsM, MYFTYPE* InitStatesM, HMat& Mat_d, MYFTYPE* V, MYDTYPE CompDepth, MYDTYPE CompFDepth, MYDTYPE prevRuns, MYDTYPE currKernelRun,MYFTYPE* allvsPtr) {
	MYDTYPE Nt = stim.Nt;
	MYFTYPE *d_modelParams, *d_modelStates,*d_cai,*d_ica, *d_eca, *d_uHP,*d_bHP;
	MYFTYPE *V_uva,*dv;
	
	MYDTYPE memSizeForModelParams = NPARAMS * Mat_d.NComps;
	MYDTYPE memSizeForInitStatae = NSTATES * Mat_d.NComps;
	CUDA_RT_CALL(cudaMalloc((void**)&V_uva, currKernelRun* Mat_d.N * sizeof(MYFTYPE)));
	for (int i = 0; i < currKernelRun; i++) {
		CUDA_RT_CALL(cudaMemcpy(&V_uva[i*Mat_d.N ], V, Mat_d.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
	}
	CUDA_RT_CALL(cudaMallocManaged((void**)&dv, currKernelRun*Mat_d.N * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMemset(dv, 0, currKernelRun*Mat_d.N * sizeof(MYFTYPE)));
	Stim stim_d;
	stim_d.NStimuli = stim.NStimuli;
	stim_d.comp = stim.comp;
	stim_d.area = stim.area;
	stim_d.loc = stim.loc;
	stim_d.Nt = stim.Nt;
	Sim sim_d;
	sim_d.Celsius = sim.Celsius;
	sim_d.dt = sim.dt;
	sim_d.NRecSites = sim.NRecSites;
	sim_d.TFinal = sim.TFinal;
#ifndef STIMFROMFILE
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.dels, stim_d.NStimuli * sizeof(MYFTYPE));
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.durs, stim_d.NStimuli * sizeof(MYFTYPE));
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.amps, stim_d.NStimuli * sizeof(MYFTYPE));
#endif // !STIMFROMFILE
#ifndef STIMFROMCSV

	stim_d.numofdts = stim.numofdts;
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.dtInds, stim_d.numofdts * sizeof(MYDTYPE));
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.durs, stim_d.numofdts * sizeof(MYFTYPE));
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE));
#endif // STIMFROMFILE

#ifdef STIMFROMCSV
	printf("in mallocing loop\n******\n");
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.durs, stim_d.Nt * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE)));
#endif // STIMFROMFILE

	CUDA_RT_CALL(cudaMalloc((void**)&sim_d.RecSites, sim_d.NRecSites * sizeof(MYDTYPE)));
#ifndef STIMFROMFILE

	CUDA_RT_CALL(cudaMemcpy(stim_d.dels, stim.dels, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpy(stim_d.durs, stim.durs, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpy(stim_d.amps, stim.amps, stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
#endif // !STIMFROMFILE
#ifdef STIMFROMCSV
	CUDA_RT_CALL(cudaMemcpy(stim_d.durs, stim.durs, stim_d.Nt * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
	CUDA_RT_CALL(cudaMemcpy(stim_d.amps, stim.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
#endif // stimf
#ifndef STIMFROMCSV
	CUDA_RT_CALL(cudaMemcpy(stim_d.dtInds, stim.dtInds, stim.numofdts * sizeof(MYDTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpy(stim_d.durs, stim.durs, stim.numofdts * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
	CUDA_RT_CALL(cudaMemcpy(stim_d.amps, stim.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
#endif // STIMFROMFILE
	CUDA_RT_CALL(cudaMemcpy(sim_d.RecSites, sim.RecSites, sim_d.NRecSites * sizeof(MYDTYPE), cudaMemcpyHostToDevice));



#ifdef NKIN_STATES
	MYFTYPE *d_initStates;
	CUDA_RT_CALL(cudaMalloc((void**)&d_initStates, NSTATES * InMat.NComps *NSets * sizeof(MYFTYPE));
	CUDA_RT_CALL(cudaMemcpy(d_initStates, InitStatesM, NSTATES * InMat.NComps * NSets * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
#endif 

	CUDA_RT_CALL(cudaMalloc((void**)&d_modelParams, NPARAMS * Mat_d.NComps *currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMemcpy(d_modelParams, &ParamsM[prevRuns*memSizeForModelParams], NPARAMS * Mat_d.NComps * currKernelRun * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
	CUDA_RT_CALL(cudaMalloc((void**)&d_modelStates, (NSTATES+1) * (NSEG )* 8*currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&d_cai, (NSEG)* currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&d_eca, (NSEG)* currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&d_ica, (NSEG)* currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMemset(d_cai,0, (NSEG)* currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMemset(d_ica,0, (NSEG)* currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMemset(d_eca,0, (NSEG)* currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&d_uHP, ((NSEG + 2) *  currKernelRun * sizeof(MYSECONDFTYPE))));
	CUDA_RT_CALL(cudaMalloc((void**)&d_bHP, ((NSEG + 2) *  currKernelRun * sizeof(MYSECONDFTYPE))));
	dim3 blockDim(WARPSIZE, stim.NStimuli);
	dim3 gridDim(currKernelRun);
	
	MYDTYPE offset = 0;
#ifdef BKSUB2
	offset += (Mat_d.N + 1) * sizeof(MYDTYPE);
#endif
	MYDTYPE FrameworkMemSize = offset;
	//PerStimulus
	printf("offset is%d\n", offset);

	offset += (Mat_d.N + 2) * sizeof(MYSECONDFTYPE);  // uHP (Diag)
	offset += (Mat_d.N + 2) * sizeof(MYSECONDFTYPE); // bHP (rhs)

	MYDTYPE PerStimulus = offset - FrameworkMemSize;
	MYDTYPE TotalSMem = FrameworkMemSize + (PerStimulus)*stim.NStimuli;
	printf("Asking %d bytes, %d+%d*%d\n", TotalSMem, FrameworkMemSize, PerStimulus, stim.NStimuli);
	initModels << <currKernelRun, blockDim >> > (Mat_d, V_uva, d_modelParams, d_modelStates, d_cai, d_ica, d_eca);
	MYFTYPE stimAmp,dt;
	MYDTYPE stimLoc = stim.loc;
	MYFTYPE stimArea = stim.area;
	MYFTYPE T = 0;
	MYFTYPE* currVsPtr;
	CUDA_RT_CALL(cudaMalloc((void**)&currVsPtr, currKernelRun * sizeof(MYSECONDFTYPE)));
	for (int i = 0; i < Nt; i++) {
		stimAmp = stim.amps[i];
		dt = stim.durs[i];
		//cudaDeviceSynchronize();
		updateMatrix << <currKernelRun, blockDim, TotalSMem >> > (d_modelParams, d_modelStates, d_cai, d_ica, d_eca, V_uva, stimAmp,stimLoc,stimArea,dt,d_uHP,d_bHP,dv);
		//cudaDeviceSynchronize();
		BeforeLU<<<currKernelRun, blockDim, TotalSMem >> >(Mat_d, d_uHP, d_bHP, Mat_d.Depth);
		//cudaDeviceSynchronize();
		BkSub << <currKernelRun, blockDim, TotalSMem >> >(Mat_d,d_uHP,d_bHP, Mat_d.LognDepth);
		//cudaDeviceSynchronize();
		deriv_and_update_v << <currKernelRun, blockDim>>>(d_modelParams, d_modelStates, d_cai, d_ica, d_eca, V_uva,d_bHP,dt, stim.loc, currVsPtr);
		//cudaDeviceSynchronize();
		cudaMemcpyAsync(&allvsPtr[i*currKernelRun], currVsPtr, currKernelRun * sizeof(MYFTYPE), cudaMemcpyDeviceToHost);
		T += dt;
	}

#ifdef NKIN_STATES
	if (streamID == 0) {
		NeuroGPUKernel << <currKernelRun, blockDim, TotalSMem, stream0 >> > (stim_d, &d_modelParams[prevRuns*memSizeForModelParams], &d_initStates[prevRuns*memSizeForInitStatae], sim_d, Mat_d, V_d, &VHotsGlobal[prevRuns*memSizeForVHotGlobal], CompDepth, CompFDepth); // RRR	

		CUDA_RT_CALL(cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal], currKernelRun * Nt * sim.NRecSites * stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyDeviceToHost, stream0);
		printf("dev id is %d, cudastatus is %s\n", currDevice, cudaStatus);

	}
#endif
#ifndef NKIN_STATES
	//printf("kernel not ran yet\n");
	//NeuroGPUKernel << <currKernelRun, blockDim, TotalSMem >> >(stim_d, d_modelParams, d_modelStates,d_cai, d_ica, d_eca, sim_d, Mat_d, V_d, VHotsGlobal, CompDepth, CompFDepth); // RRR	
	//printf("kernel ran before memcpyasync currkernel run is %d\n", currKernelRun);
	//CUDA_RT_CALL(cudaMemcpyAsync(VHotsHost, V_d, currKernelRun * Nt * sim.NRecSites * stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyDeviceToHost));


	//printf("done copying*&*&*&*&*&*&*\n");
	//printf ("dev id is %d, cudastatus is %s\n",currDevice,cudaStatus);
#endif


	//currDevice += 1;


	
}

void stEfork2Main(Stim stim, Sim sim, MYFTYPE* ParamsM, MYFTYPE* InitStatesM, HMat& InMat, MYFTYPE* V, MYDTYPE CompDepth, MYDTYPE CompFDepth, int NSets, int* p2pCapableGPUs, int np2p) {
	MYFTYPE *Vhots;
	MYFTYPE **vhots_dev;
	MYDTYPE Nt = stim.Nt;
	printf("in stefork\n");
	vhots_dev = (MYFTYPE**)(malloc(np2p * sizeof(MYFTYPE*)));
	Vhots = (MYFTYPE*)malloc(NSets*Nt*stim.NStimuli*sim.NRecSites * sizeof(MYFTYPE));

	//cudaEventCreate(&start);
	//cudaEventCreate(&stop);
	HMat Mat_d;
	//cudaError_t cudaStatus;
	if (np2p == 0) {
		np2p = 1;
	}
	for (int i = 0; i < np2p; i++) {
		printf("calling initframework p2pCapableGPUs[i] is %d\n", p2pCapableGPUs[i]);
		CUDA_RT_CALL(cudaSetDevice(p2pCapableGPUs[i]));
		//cudaDeviceSetSharedMemConfig(cudaSharedMemBankSizeEightByte);
		initFrameWork(stim, sim, ParamsM, InitStatesM, InMat, CompDepth, CompFDepth, NSets, Mat_d);
	}
	//printf("in steforkmain p2pCapableGPUs[0] is %d\n", p2pCapableGPUs[0]);
	//CUDA_RT_CALL(cudaSetDevice(p2pCapableGPUs[0]));
	//printf("calling initframework dev0\n");


	//RRR sim
	MYDTYPE prevRuns = 0;
	MYDTYPE currRun;
	if (NSets > np2p) {
		currRun = ceil(NSets / np2p);
	}
	else { currRun = NSets; };

	printf("done initframework dev0 curr Kernel is %d\n", currRun);
	cudaEvent_t start, stop;
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start);

	for (int i = 0; i < np2p; i++) {
		if (prevRuns >= NSets)  break;
		CUDA_RT_CALL(cudaSetDevice(p2pCapableGPUs[i]));
		printf("calling kernel dev%d\n", p2pCapableGPUs[i]);
		
		vhots_dev[i] = (MYFTYPE*)malloc(currRun*Nt*stim.NStimuli*sim.NRecSites * sizeof(MYFTYPE));
		callKernel(stim, sim, ParamsM, InitStatesM, Mat_d, V, CompDepth, CompFDepth, prevRuns, currRun, vhots_dev[i]);
		prevRuns += currRun;

	}
	for (int i = 0; i < np2p; i++) {
		CUDA_RT_CALL(cudaSetDevice(p2pCapableGPUs[i]));
		CUDA_RT_CALL(cudaDeviceSynchronize());
		printf("done synch%d\n", p2pCapableGPUs[i]);
		if (NSets <np2p) {
			printf("nsets >p2pdevs");
			vhots_dev[0] = transposeMat(vhots_dev[0], currRun, Nt);
			Vhots = vhots_dev[0];
		}
		else {
			vhots_dev[i] = transposeMat(vhots_dev[i], currRun, Nt);
			memcpy(&Vhots[(currRun*i)*stim.NStimuli*Nt*sim.NRecSites], vhots_dev[i], stim.NStimuli*Nt*sim.NRecSites*currRun * sizeof(MYFTYPE));
		}
	}
	cudaEventRecord(stop);
	cudaEventSynchronize(stop);
	float milliseconds = 0;
	cudaEventElapsedTime(&milliseconds, start, stop);
	printf("it took %f ms\n", milliseconds);
	FILE *file = fopen(TIMES_FN, "w");
	if (file) {
		fprintf(file, "%d,%f\n", NSets, milliseconds);
	}
	else {
		printf("ERR SaveArrayToFile %s\n", TIMES_FN);
	}
	fclose(file);

	SaveArrayToFile(VHOT_OUT_FN_P, NSets*Nt*stim.NStimuli*sim.NRecSites, Vhots);



}



