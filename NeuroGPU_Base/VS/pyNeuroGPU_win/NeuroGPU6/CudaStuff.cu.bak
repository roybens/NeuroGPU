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
__device__ void BeforeLU(HMat InMat, MYSECONDFTYPE* uHP, MYSECONDFTYPE* bHP, MYDTYPE Depth)
{
	MYDTYPE PIdx = threadIdx.x;
	MYDTYPE i, j, CurJ, CurB, t, CurLevel, LRelIndex;
	MYDTYPE JumctionI;
	LRelIndex = cLRelStarts[CurLevel];
	LRelIndex = LRelIndex + cLRelEnds[CurLevel];
	for (CurLevel = 0; CurLevel <= Depth; CurLevel++) {

		for (LRelIndex = cLRelStarts[CurLevel]; LRelIndex <= cLRelEnds[CurLevel]; LRelIndex++) {
			//for(LRelIndex=cLRelStarts[CurLevel];LRelIndex<=InMat.LRelEnds[CurLevel];LRelIndex++){ 
			JumctionI = cCompByLevel32[LRelIndex*WARPSIZE + PIdx] - 1;
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
				CurB = cCompByFLevel32[(LRelIndex)*WARPSIZE + PIdx] - 1;//RB i inserted another  -1 into the index RB 2 i removed the-1 from the curlevel 
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
}

#ifdef BKSUB1
__device__ void BkSub(HMat InMat, MYSECONDFTYPE* PX, MYSECONDFTYPE* PF, MYSECONDFTYPE* uHP, MYSECONDFTYPE* bHP, MYDTYPE LognDepth)
{
	// MYDTYPE PIdx_1=threadIdx.x; // MYDTYPE NextID_1;
	MYDTYPE PIdx[NILP + 1];
	MYDTYPE NextID[NILP + 1];
	for (int count = 1; count < NILP + 1; count++) {
		PIdx[count] = threadIdx.x + (WARPSIZE*(count - 1));
		//this is from a different superilp
		PX[PIdx[count]] = PX[PIdx[count]] / PF[PIdx[count]];
		PF[PIdx[count]] = -cF[PIdx[count]] / PF[PIdx[count]];
	}
	MYFTYPE OldPXj[NILP + 1];
	MYFTYPE OldPXNextID[NILP + 1];
	MYFTYPE OldPFj[NILP + 1];
	MYFTYPE OldPFNextID[NILP + 1];
	MYDTYPE i;
	PX[InMat.N] = 0;
	PF[InMat.N] = 1;
	for (i = 0; i<LognDepth; i++) {
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

__device__ void runSimulation(HMat InMat, const MYFTYPE* __restrict__ ParamsM, MYFTYPE* ModelStates, MYFTYPE* V, Stim stim, Sim sim, MYFTYPE* VHotGlobal)
{

	__shared__ MYSECONDFTYPE uHP_all[(NSEG + 2)*NTRACES];
	__shared__ MYSECONDFTYPE bHP_all[(NSEG + 2)*NTRACES];
	__shared__ MYFTYPE SMemVHot_all[WARPSIZE*NTRACES];
	MYSECONDFTYPE *uHP = &uHP_all[(NSEG + 2)*threadIdx.y];
	MYSECONDFTYPE *bHP = &bHP_all[(NSEG + 2)*threadIdx.y];
	MYFTYPE *SMemVHot = &SMemVHot_all[(WARPSIZE)*threadIdx.y];
	MYDTYPE StimID = threadIdx.y;

	//MYDTYPE PerStimulus;
	//PerStimulus = InMat.N+2;
	
	
	
	MYDTYPE NeuronID = blockIdx.x;
	int Nt = stim.Nt;
	MYFTYPE t = 0;
	MYSECONDFTYPE *PX, *PF;
	PX = bHP;
	PF = uHP;
	MYDTYPE PIdx[NILP + 1];
	for (int count = 1; count < NILP + 1; count++) {
		PIdx[count] = threadIdx.x + (WARPSIZE*(count - 1));
	}
	int perBlockStatesSize = (NSEG)*(NSTATES + 1);
#define state_macro(stateind,segmentInd) ModelStates[NeuronID*perBlockStatesSize + stateind*NSEG+PIdx[segmentInd]]//Is this coalesced?
	MYFTYPE Vmid[NILP + 1];
	MYFTYPE v[NILP + 1];
	MYFTYPE dv[NILP + 1];
	MYSECONDFTYPE sumCurrents[NILP + 1];
	MYSECONDFTYPE sumCurrentsDv[NILP + 1];
	MYFTYPE sumConductivity[NILP + 1];
	MYFTYPE sumConductivityDv[NILP + 1];
	MYDTYPE parentIndex[NILP + 1];
	MYDTYPE Eidx[NILP + 1];
	MYSECONDFTYPE rhs[NILP + 1];
	MYSECONDFTYPE D[NILP + 1];
	MYFTYPE gModel[NILP + 1];
	MYFTYPE cai[NILP + 1];
	MYFTYPE ica[NILP + 1];
	MYFTYPE eca[NILP + 1];
	MYFTYPE StimCurrent[NILP + 1];
	for (int count = 1; count < NILP + 1; count++) {
		v[count] = V[PIdx[count]];
		sumCurrents[count] = 0;
		sumCurrentsDv[count] = 0;
		sumConductivity[count] = 0;
		sumConductivityDv[count] = 0;
		bHP[count] = 0;
		dv[count] = 0;
		Eidx[count] = InMat.N - PIdx[count] - 1;
		parentIndex[count] = InMat.N - cKs[InMat.N - PIdx[count]];
		cai[count] = 0;
		ica[count] = 0;
		eca[count] = 0;
		if (PIdx[count] == 0) {
			parentIndex[count] = 0;
		};
		for (int count1 = 0; count1 < NSTATES; count1++) {
			state_macro(count1, count) = 0;
		}
	}

	if (Eidx[1]>InMat.N - 1) {
		Eidx[1] = InMat.N - 1;
	}
	MYDTYPE perThreadParamMSize = InMat.NComps*NPARAMS;

#define param_macro(paramInd,segmentInd) ParamsM[NeuronID*perThreadParamMSize + paramInd*InMat.NComps+cSegToComp[segmentInd] ]
#ifdef NKIN_STATES
	MYDTYPE perThreadStateMSize = InMat.NComps*NKIN_STATES;
#define init_state_macro(stateInd,segmentInd) InitStatesM[NeuronID*perThreadStateMSize + stateInd*InMat.NComps+cSegToComp[segmentInd] ]	;
	SUPERILPMACRO(SET_KINETIC_STATE)
#endif 

	for (int count = 1; count < NILP + 1; count++) {
	if(cBoolModel[PIdx[count] +0*NSEG]){CuInitModel_Ca_HVA(v[count],state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuInitModel_Ca_LVAst(v[count],state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuInitModel_CaDynamics_E2(v[count],cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuInitModel_Ih(v[count],state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuInitModel_Im(v[count],state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuInitModel_K_Pst(v[count],state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuInitModel_K_Tst(v[count],state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuInitModel_Nap_Et2(v[count],state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuInitModel_NaTa_t(v[count],state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuInitModel_NaTs2_t(v[count],state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuInitModel_pas(v[count],param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuInitModel_SK_E2(v[count],state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuInitModel_SKv3_1(v[count],state_macro(18,count) ,param_macro(18, PIdx[count]) );}
	}
	MYDTYPE stimLoc = stim.loc;
	MYFTYPE stimArea = stim.area;
	MYDTYPE dtCounter = 0;
	MYFTYPE  dt = sim.dt;
	MYFTYPE temp;
	for (int i = 0; i<Nt; i++) {
#ifdef STIMFROMCSV
		dt = stim.durs[i];
#endif STIMFROMCSV

		t += 0.5*dt;

		if ((i % (WARPSIZE) == 0)) {
			if (i>0) {
				for (int recInd = 0; recInd<sim.NRecSites; recInd++) {
					VHotGlobal[NeuronID*(sim.NRecSites*Nt*blockDim.y) + threadIdx.y*Nt*sim.NRecSites + recInd*Nt + (i - WARPSIZE) + PIdx[1]] = SMemVHot[WARPSIZE*recInd + PIdx[1]];
				}
			}

			//amps[PIdx[1]] = stim.amps[threadIdx.y*Nt + i + PIdx[1]];
		}
		for (int recInd = 0; recInd<sim.NRecSites; recInd++) {
			if (sim.RecSites[recInd] % WARPSIZE == threadIdx.x)
				//This is done by all threads why???
				SMemVHot[recInd*WARPSIZE + i % (WARPSIZE)] = v[1];//This is going to be challenging to make it general but possible.

		}
		for (int count = 1; count < NILP + 1; count++) {
			rhs[count] = 0;
			D[count] = 0;
			sumCurrents[count] = 0;
			sumConductivity[count] = 0;
			sumCurrentsDv[count] = 0;
			sumConductivityDv[count] = 0;
			StimCurrent[count] = 0;
			ica[count] = 0;//SERIOUSLY??? check if this is correct does not seem right!!!! the whole point of ica is not to be initialized every time step...
			if (PIdx[count] == stimLoc) {
				StimCurrent[count] = 100 * stim.amps[threadIdx.y*Nt + i] / stimArea;
			}
		}
		for (int count = 1; count < NILP + 1; count++) {
		   if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_Ca_HVA(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , temp,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_Ca_LVAst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , temp,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_CaDynamics_E2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , temp,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_Ih(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_Im(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_K_Pst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_K_Tst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_Nap_Et2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_NaTa_t(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuBreakpointModel_NaTs2_t(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuBreakpointModel_pas(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuBreakpointModel_SK_E2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuBreakpointModel_SKv3_1(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(18,count) ,param_macro(18, PIdx[count]) );}
		  if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_Ca_HVA(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_Ca_LVAst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_CaDynamics_E2(sumCurrents[count] , sumConductivity[count],v[count] ,cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_Ih(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_Im(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_K_Pst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_K_Tst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_Nap_Et2(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_NaTa_t(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuBreakpointModel_NaTs2_t(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuBreakpointModel_pas(sumCurrents[count] , sumConductivity[count],v[count] ,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuBreakpointModel_SK_E2(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuBreakpointModel_SKv3_1(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(18,count) ,param_macro(18, PIdx[count]) );}

			
		}
		for (int count = 1; count < NILP + 1; count++) {
			gModel[count] = (sumCurrentsDv[count] - sumCurrents[count]) / EPS_V;
			rhs[count] = StimCurrent[count] - sumCurrents[count];
			D[count] = gModel[count] + cCm[PIdx[count]] / (dt * 1000);
			D[count] -= cF[InMat.N - PIdx[count] - 1];
			dv[count] += bHP[InMat.N - parentIndex[count] - 1] - bHP[InMat.N - PIdx[count] - 1];

		}
		for (int count = 1; count < NILP + 1; count++) {
			rhs[count] -= cF[InMat.N - PIdx[count] - 1] * dv[count];
			bHP[InMat.N - PIdx[count] - 1] = rhs[count];
			uHP[InMat.N - PIdx[count] - 1] = D[count];
		}
		//__syncthreads();
		for (int count = 1; count < NILP + 1; count++) {
			if (cSonNoVec[PIdx[count]] == 1) {
				bHP[InMat.N - parentIndex[count] - 1] += cE[Eidx[count]] * dv[count];
				uHP[InMat.N - parentIndex[count] - 1] -= cE[Eidx[count]];
			}//WILL THIS WORK???
			if (cSonNoVec[PIdx[count]] == 2) {
				bHP[InMat.N - parentIndex[count] - 1] += cE[Eidx[count]] * dv[count];
				uHP[InMat.N - parentIndex[count] - 1] -= cE[Eidx[count]];
			}
		}
		//__syncthreads();
		BeforeLU(InMat, uHP, bHP, InMat.Depth);
#ifdef BKSUB1
		//__syncthreads();
		BkSub(InMat, PX, PF, uHP, bHP, InMat.LognDepth);
		//__syncthreads();
		for (int count = 1; count < NILP + 1; count++) {
			Vmid[count] = PX[InMat.N - PIdx[count] - 1];
			v[count] += Vmid[count];
		}
#endif

		
#ifdef BKSUB2
#define THISCOMMANDHERE37(VARILP) MYFTYPE vTemp_ ## VARILP=Vs[PIdx_ ## VARILP];
		MYFTYPE vTemp[1] = Vs[PIdx[1]];
		__syncthreads();
		BkSub(InMat, uHP, bHP, Vs, InMat.Depth);
		__syncthreads();
		PX = Vs;

#define THISCOMMANDHERE38(VARILP) Vmid_ ## VARILP =PX[InMat.N-PIdx_ ## VARILP -1]; v_ ## VARILP +=Vmid_ ## VARILP ;
		Vmid[1] = PX[InMat.N - PIdx[1] - 1]; v[1] += Vmid[1];
		__syncthreads();
#define THISCOMMANDHERE39(VARILP) Vs[PIdx_ ## VARILP ]= vTemp_ ## VARILP +Vmid_ ## VARILP ;
		Vs[PIdx[1]] = vTemp[1] + Vmid[1];
#endif		
            t+=0.5*dt;

        

//      if(InMat.boolModel[PIdx_1 +0*InMat.N]){CuDerivModel_ca(dt, v_1,ModelStates_1[0],ModelStates_1[1],p0_1 ,p1_1 ,ModelStates_1[8],ModelStates_1[9]);} if(InMat.boolModel[PIdx_1 +1*InMat.N]){CuDerivModel_cad(dt, v_1,ModelStates_1[2],ModelStates_1[9],ModelStates_1[8]);} if(InMat.boolModel[PIdx_1 +2*InMat.N]){CuDerivModel_kca(dt, v_1,ModelStates_1[3],p2_1 ,p3_1 ,p4_1 ,p5_1 ,ModelStates_1[8]);} if(InMat.boolModel[PIdx_1 +3*InMat.N]){CuDerivModel_km(dt, v_1,ModelStates_1[4],p6_1 ,p7_1 ,p8_1 ,p9_1 ,p10_1 );} if(InMat.boolModel[PIdx_1 +4*InMat.N]){CuDerivModel_kv(dt, v_1,ModelStates_1[5],p11_1 ,p12_1 ,p13_1 ,p14_1 ,p15_1 );} if(InMat.boolModel[PIdx_1 +5*InMat.N]){CuDerivModel_na(dt, v_1,ModelStates_1[6],ModelStates_1[7],p16_1 ,p17_1 ,p18_1 ,p19_1 ,p20_1 ,p21_1 ,p22_1 ,p23_1 ,p24_1 ,p25_1 ,p26_1 ,p27_1 );}  if(InMat.boolModel[PIdx_2 +0*InMat.N]){CuDerivModel_ca(dt, v_2,ModelStates_2[0],ModelStates_2[1],p0_2 ,p1_2 ,ModelStates_2[8],ModelStates_2[9]);} if(InMat.boolModel[PIdx_2 +1*InMat.N]){CuDerivModel_cad(dt, v_2,ModelStates_2[2],ModelStates_2[9],ModelStates_2[8]);} if(InMat.boolModel[PIdx_2 +2*InMat.N]){CuDerivModel_kca(dt, v_2,ModelStates_2[3],p2_2 ,p3_2 ,p4_2 ,p5_2 ,ModelStates_2[8]);} if(InMat.boolModel[PIdx_2 +3*InMat.N]){CuDerivModel_km(dt, v_2,ModelStates_2[4],p6_2 ,p7_2 ,p8_2 ,p9_2 ,p10_2 );} if(InMat.boolModel[PIdx_2 +4*InMat.N]){CuDerivModel_kv(dt, v_2,ModelStates_2[5],p11_2 ,p12_2 ,p13_2 ,p14_2 ,p15_2 );} if(InMat.boolModel[PIdx_2 +5*InMat.N]){CuDerivModel_na(dt, v_2,ModelStates_2[6],ModelStates_2[7],p16_2 ,p17_2 ,p18_2 ,p19_2 ,p20_2 ,p21_2 ,p22_2 ,p23_2 ,p24_2 ,p25_2 ,p26_2 ,p27_2 );}  if(InMat.boolModel[PIdx_3 +0*InMat.N]){CuDerivModel_ca(dt, v_3,ModelStates_3[0],ModelStates_3[1],p0_3 ,p1_3 ,ModelStates_3[8],ModelStates_3[9]);} if(InMat.boolModel[PIdx_3 +1*InMat.N]){CuDerivModel_cad(dt, v_3,ModelStates_3[2],ModelStates_3[9],ModelStates_3[8]);} if(InMat.boolModel[PIdx_3 +2*InMat.N]){CuDerivModel_kca(dt, v_3,ModelStates_3[3],p2_3 ,p3_3 ,p4_3 ,p5_3 ,ModelStates_3[8]);} if(InMat.boolModel[PIdx_3 +3*InMat.N]){CuDerivModel_km(dt, v_3,ModelStates_3[4],p6_3 ,p7_3 ,p8_3 ,p9_3 ,p10_3 );} if(InMat.boolModel[PIdx_3 +4*InMat.N]){CuDerivModel_kv(dt, v_3,ModelStates_3[5],p11_3 ,p12_3 ,p13_3 ,p14_3 ,p15_3 );} if(InMat.boolModel[PIdx_3 +5*InMat.N]){CuDerivModel_na(dt, v_3,ModelStates_3[6],ModelStates_3[7],p16_3 ,p17_3 ,p18_3 ,p19_3 ,p20_3 ,p21_3 ,p22_3 ,p23_3 ,p24_3 ,p25_3 ,p26_3 ,p27_3 );}
for (int count = 1; count < NILP + 1; count++) {
	  if(cBoolModel[PIdx[count] +0*NSEG]){CuDerivModel_Ca_HVA(dt, v[count],state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , ica[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuDerivModel_Ca_LVAst(dt, v[count],state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , ica[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuDerivModel_CaDynamics_E2(dt, v[count],cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuDerivModel_Ih(dt, v[count],state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuDerivModel_Im(dt, v[count],state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuDerivModel_K_Pst(dt, v[count],state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuDerivModel_K_Tst(dt, v[count],state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuDerivModel_Nap_Et2(dt, v[count],state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuDerivModel_NaTa_t(dt, v[count],state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuDerivModel_NaTs2_t(dt, v[count],state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){}if(cBoolModel[PIdx[count] +11*NSEG]){CuDerivModel_SK_E2(dt, v[count],state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuDerivModel_SKv3_1(dt, v[count],state_macro(18,count) ,param_macro(18, PIdx[count]) );}
		}

 
 
    }
	//This one looks suspicious but leaving it and will check it later.
	for (int recInd = 0; recInd<sim.NRecSites; recInd++) {
		VHotGlobal[NeuronID*(sim.NRecSites*Nt*blockDim.y) + threadIdx.y*Nt*sim.NRecSites + recInd*Nt + Nt - WARPSIZE + PIdx[1]] = SMemVHot[WARPSIZE*recInd + PIdx[1]];
	}
}
__global__ void NeuroGPUKernel(Stim stim, MYFTYPE* ParamsM, MYFTYPE* ModelStates, Sim sim, HMat InMat, MYFTYPE *V, MYFTYPE* VHotGlobal, MYDTYPE CompDepth, MYDTYPE CompFDepth)
{

	MYFTYPE *amps, *SMemVHot;
	MYDTYPE offset = 0;
	runSimulation(InMat, ParamsM, ModelStates, V, stim, sim, VHotGlobal);
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

//	printf("in initframework\n");
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
//	printf("done with all init framework\n");
}





void callKernel(Stim stim, Sim sim, MYFTYPE* ParamsM, MYFTYPE* InitStatesM, HMat& Mat_d, MYFTYPE* V, MYDTYPE CompDepth, MYDTYPE CompFDepth, MYDTYPE prevRuns, MYDTYPE currKernelRun, MYFTYPE* VHotsHost) {
	MYDTYPE Nt = stim.Nt;
	MYFTYPE *d_modelParams, *d_modelStates;
	MYFTYPE *VHotsGlobal;
	MYFTYPE *V_d;
	CUDA_RT_CALL(cudaMalloc((void**)&VHotsGlobal, currKernelRun*sim.NRecSites*Nt *stim.NStimuli * sizeof(MYFTYPE)));
	int memSizeForVHotGlobal = Nt*stim.NStimuli*sim.NRecSites;
	MYDTYPE memSizeForModelParams = NPARAMS * Mat_d.NComps;
	MYDTYPE memSizeForInitStatae = NSTATES * Mat_d.NComps;
	CUDA_RT_CALL(cudaMalloc((void**)&V_d, Mat_d.N * sizeof(MYFTYPE)));

	CUDA_RT_CALL(cudaMemcpy(V_d, V, Mat_d.N * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
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
#ifdef STIMFROMCSV
	printf("in mallocing loop\n******\n");
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.durs, stim_d.Nt * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMalloc((void**)&stim_d.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE)));
#endif // STIMFROMFILE

	CUDA_RT_CALL(cudaMalloc((void**)&sim_d.RecSites, sim_d.NRecSites * sizeof(MYDTYPE)));

#ifdef STIMFROMCSV
	CUDA_RT_CALL(cudaMemcpy(stim_d.durs, stim.durs, stim_d.Nt * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
	CUDA_RT_CALL(cudaMemcpy(stim_d.amps, stim.amps, stim_d.Nt*stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
#endif // stimf
	CUDA_RT_CALL(cudaMemcpy(sim_d.RecSites, sim.RecSites, sim_d.NRecSites * sizeof(MYDTYPE), cudaMemcpyHostToDevice));
#ifdef NKIN_STATES
	MYFTYPE *d_initStates;
	CUDA_RT_CALL(cudaMalloc((void**)&d_initStates, NSTATES * InMat.NComps *NSets * sizeof(MYFTYPE));
	CUDA_RT_CALL(cudaMemcpy(d_initStates, InitStatesM, NSTATES * InMat.NComps * NSets * sizeof(MYFTYPE), cudaMemcpyHostToDevice);
#endif 
	CUDA_RT_CALL(cudaMalloc((void**)&d_modelParams, NPARAMS * Mat_d.NComps *currKernelRun * sizeof(MYFTYPE)));
	CUDA_RT_CALL(cudaMemcpy(d_modelParams, &ParamsM[prevRuns*memSizeForModelParams], NPARAMS * Mat_d.NComps * currKernelRun * sizeof(MYFTYPE), cudaMemcpyHostToDevice));
	CUDA_RT_CALL(cudaMalloc((void**)&d_modelStates, (NSTATES + 1) * (NSEG) * currKernelRun * sizeof(MYFTYPE)));
	dim3 blockDim(WARPSIZE, stim.NStimuli);
	dim3 gridDim(currKernelRun);


#ifdef NKIN_STATES
	if (streamID == 0) {
		NeuroGPUKernel << <currKernelRun, blockDim, TotalSMem, stream0 >> > (stim_d, &d_modelParams[prevRuns*memSizeForModelParams], &d_initStates[prevRuns*memSizeForInitStatae], sim_d, Mat_d, V_d, &VHotsGlobal[prevRuns*memSizeForVHotGlobal], CompDepth, CompFDepth); // RRR	

		CUDA_RT_CALL(cudaMemcpyAsync(&VHotsHost[prevRuns*memSizeForVHotGlobal], &VHotsGlobal[prevRuns*memSizeForVHotGlobal], currKernelRun * Nt * sim.NRecSites * stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyDeviceToHost, stream0);
		printf("dev id is %d, cudastatus is %s\n", currDevice, cudaStatus);
	}
#endif
//#ifndef NKIN_STATES
	printf("kernel not ran yet\n");
	NeuroGPUKernel << <currKernelRun, blockDim >> >(stim_d, d_modelParams, d_modelStates, sim_d, Mat_d, V_d, VHotsGlobal, CompDepth, CompFDepth); // RRR	
	printf("kernel ran before memcpyasync currkernel run is %d\n", currKernelRun);
	CUDA_RT_CALL(cudaMemcpyAsync(VHotsHost, VHotsGlobal, currKernelRun * Nt * sim.NRecSites * stim.NStimuli * sizeof(MYFTYPE), cudaMemcpyDeviceToHost));
	printf("done copying*&*&*&*&*&*&*\n");
}

void stEfork2Main(Stim stim, Sim sim, MYFTYPE* ParamsM, MYFTYPE* InitStatesM, HMat& InMat, MYFTYPE* V, MYDTYPE CompDepth, MYDTYPE CompFDepth, int NSets, int* p2pCapableGPUs, int np2p) {
	MYFTYPE *Vhots;
	MYFTYPE **vhots_dev;
	MYDTYPE Nt = stim.Nt;
	printf("in stefork\n");
	vhots_dev = (MYFTYPE**)(malloc(np2p * sizeof(MYFTYPE*)));
	Vhots = (MYFTYPE*)malloc(NSets*Nt*stim.NStimuli*sim.NRecSites * sizeof(MYFTYPE));
	HMat Mat_d;
	if (np2p == 0) {
		np2p = 1;
	}
	for (int i = 0; i < np2p; i++) {
		printf("calling initframework p2pCapableGPUs[i] is %d\n", p2pCapableGPUs[i]);
		CUDA_RT_CALL(cudaSetDevice(p2pCapableGPUs[i]));
	//	cudaDeviceSetSharedMemConfig(cudaSharedMemBankSizeEightByte);
		initFrameWork(stim, sim, ParamsM, InitStatesM, InMat, CompDepth, CompFDepth, NSets, Mat_d);
	}
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
		cudaMallocHost((void**)&vhots_dev[i], stim.NStimuli*Nt*sim.NRecSites*currRun * sizeof(MYFTYPE));
		callKernel(stim, sim, ParamsM, InitStatesM, Mat_d, V, CompDepth, CompFDepth, prevRuns, currRun, vhots_dev[i]);
		prevRuns += currRun;

	}
	for (int i = 0; i < np2p; i++) {
		CUDA_RT_CALL(cudaSetDevice(p2pCapableGPUs[i]));
		CUDA_RT_CALL(cudaDeviceSynchronize());
		printf("done synch%d\n", p2pCapableGPUs[i]);
		if (NSets <np2p) {
			printf("nsets >p2pdevs");
			Vhots = vhots_dev[0];
		}
		else {
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
    int curr_dev;
    CUDA_RT_CALL(cudaGetDevice(&curr_dev));
    char FileName[300];
	sprintf(FileName, "%s%d.dat", VHOT_OUT_FN_P,curr_dev);
	SaveArrayToFile(FileName, NSets*Nt*stim.NStimuli*sim.NRecSites, Vhots);
}



