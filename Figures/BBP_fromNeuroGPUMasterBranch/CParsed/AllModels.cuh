// Automatically generated CUH for E:\GitHub\NeuroGPU\Figures\BBP_fromNeuroGPUMasterBranch./runModel.hoc

#ifndef __ALLMODELSCU__
#define __ALLMODELSCU__
#include "Util.h"

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#define NSEG 512
#define NCOMPS 241
#define LOG_N_DEPTH 6
#define N_MODELS 13
#define N_FATHERS 128
#define N_CALL_FOR_FATHER 252
#define COMP_DEPTH 29
#define N_L_REL 25
#define N_F_L_REL 24
#define NILP 16
#define NSTATES 19
#define NPARAMS 19

#define NTRACES 1

__device__ void CuInitModel_Ca_HVA(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai);
__device__ void CuInitModel_Ca_LVAst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai);
__device__ void CuInitModel_CaDynamics_E2(MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca);
__device__ void CuInitModel_Ih(MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih);
__device__ void CuInitModel_Im(MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im);
__device__ void CuInitModel_K_Pst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst);
__device__ void CuInitModel_K_Tst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst);
__device__ void CuInitModel_Nap_Et2(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2);
__device__ void CuInitModel_NaTa_t(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t);
__device__ void CuInitModel_NaTs2_t(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t);
__device__ void CuInitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas);
__device__ void CuInitModel_SK_E2(MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca);
__device__ void CuInitModel_SKv3_1(MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1);
__device__ void CuDerivModel_Ca_HVA(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica);
__device__ void CuDerivModel_Ca_LVAst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica);
__device__ void CuDerivModel_CaDynamics_E2(MYFTYPE dt, MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca);
__device__ void CuDerivModel_Ih(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih);
__device__ void CuDerivModel_Im(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im);
__device__ void CuDerivModel_K_Pst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst);
__device__ void CuDerivModel_K_Tst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst);
__device__ void CuDerivModel_Nap_Et2(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2);
__device__ void CuDerivModel_NaTa_t(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t);
__device__ void CuDerivModel_NaTs2_t(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t);
__device__ void CuDerivModel_SK_E2(MYFTYPE dt, MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca);
__device__ void CuDerivModel_SKv3_1(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1);
__device__ void CuBreakpointModel_Ca_HVA(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai) ;

__device__ void CuBreakpointModel_Ca_LVAst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai) ;

__device__ void CuBreakpointModel_CaDynamics_E2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca) ;

__device__ void CuBreakpointModel_Ih(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih) ;

__device__ void CuBreakpointModel_Im(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im) ;

__device__ void CuBreakpointModel_K_Pst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst) ;

__device__ void CuBreakpointModel_K_Tst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst) ;

__device__ void CuBreakpointModel_Nap_Et2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2) ;

__device__ void CuBreakpointModel_NaTa_t(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t) ;

__device__ void CuBreakpointModel_NaTs2_t(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t) ;

__device__ void CuBreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) ;

__device__ void CuBreakpointModel_SK_E2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca) ;

__device__ void CuBreakpointModel_SKv3_1(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1) ;



#define SET_STATES(VARILP) ModelStates_## VARILP [0]=0; ModelStates_## VARILP [1]=0; ModelStates_## VARILP [2]=0; ModelStates_## VARILP [3]=0; ModelStates_## VARILP [4]=0; ModelStates_## VARILP [5]=0; ModelStates_## VARILP [6]=0; ModelStates_## VARILP [7]=0; ModelStates_## VARILP [8]=0; ModelStates_## VARILP [9]=0; ModelStates_## VARILP [10]=0; ModelStates_## VARILP [11]=0; ModelStates_## VARILP [12]=0; ModelStates_## VARILP [13]=0; ModelStates_## VARILP [14]=0; ModelStates_## VARILP [15]=0; ModelStates_## VARILP [16]=0; ModelStates_## VARILP [17]=0; ModelStates_## VARILP [18]=0; ; 


#define CALL_TO_INIT_STATES_CU(VARILP) if(cBoolModel[PIdx[count] +0*NSEG]){CuInitModel_Ca_HVA(v[count],state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuInitModel_Ca_LVAst(v[count],state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuInitModel_CaDynamics_E2(v[count],cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuInitModel_Ih(v[count],state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuInitModel_Im(v[count],state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuInitModel_K_Pst(v[count],state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuInitModel_K_Tst(v[count],state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuInitModel_Nap_Et2(v[count],state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuInitModel_NaTa_t(v[count],state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuInitModel_NaTs2_t(v[count],state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuInitModel_pas(v[count],param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuInitModel_SK_E2(v[count],state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuInitModel_SKv3_1(v[count],state_macro(18,count) ,param_macro(18, PIdx[count]) );}

#define CALL_TO_DERIV_CU(VARILP)   if(cBoolModel[PIdx[count] +0*NSEG]){CuDerivModel_Ca_HVA(dt, v[count],state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , ica[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuDerivModel_Ca_LVAst(dt, v[count],state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , ica[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuDerivModel_CaDynamics_E2(dt, v[count],cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuDerivModel_Ih(dt, v[count],state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuDerivModel_Im(dt, v[count],state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuDerivModel_K_Pst(dt, v[count],state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuDerivModel_K_Tst(dt, v[count],state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuDerivModel_Nap_Et2(dt, v[count],state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuDerivModel_NaTa_t(dt, v[count],state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuDerivModel_NaTs2_t(dt, v[count],state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){}if(cBoolModel[PIdx[count] +11*NSEG]){CuDerivModel_SK_E2(dt, v[count],state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuDerivModel_SKv3_1(dt, v[count],state_macro(18,count) ,param_macro(18, PIdx[count]) );}

#define CALL_TO_BREAK_CU(VARILP)   if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_Ca_HVA(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_Ca_LVAst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , ica[count] ,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_CaDynamics_E2(sumCurrents[count] , sumConductivity[count],v[count] ,cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , ica[count] ,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_Ih(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_Im(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_K_Pst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_K_Tst(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_Nap_Et2(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_NaTa_t(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuBreakpointModel_NaTs2_t(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuBreakpointModel_pas(sumCurrents[count] , sumConductivity[count],v[count] ,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuBreakpointModel_SK_E2(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuBreakpointModel_SKv3_1(sumCurrents[count] , sumConductivity[count],v[count] ,state_macro(18,count) ,param_macro(18, PIdx[count]) );}

#define CALL_TO_BREAK_DV_CU(VARILP)    if(cBoolModel[PIdx[count] +0*NSEG]){CuBreakpointModel_Ca_HVA(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(0,count) ,state_macro(1,count) ,param_macro(0, PIdx[count]) , temp,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +1*NSEG]){CuBreakpointModel_Ca_LVAst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(2,count) ,state_macro(3,count) ,param_macro(1, PIdx[count]) , temp,eca[count] ,cai[count] );}if(cBoolModel[PIdx[count] +2*NSEG]){CuBreakpointModel_CaDynamics_E2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,cai[count]  ,param_macro(2, PIdx[count]) ,param_macro(3, PIdx[count]) ,param_macro(4, PIdx[count]) ,param_macro(5, PIdx[count]) , temp,eca[count] );}if(cBoolModel[PIdx[count] +3*NSEG]){CuBreakpointModel_Ih(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(5,count) ,param_macro(6, PIdx[count]) ,param_macro(7, PIdx[count]) );}if(cBoolModel[PIdx[count] +4*NSEG]){CuBreakpointModel_Im(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(6,count) ,param_macro(8, PIdx[count]) );}if(cBoolModel[PIdx[count] +5*NSEG]){CuBreakpointModel_K_Pst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(7,count) ,state_macro(8,count) ,param_macro(9, PIdx[count]) );}if(cBoolModel[PIdx[count] +6*NSEG]){CuBreakpointModel_K_Tst(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(9,count) ,state_macro(10,count) ,param_macro(10, PIdx[count]) );}if(cBoolModel[PIdx[count] +7*NSEG]){CuBreakpointModel_Nap_Et2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(11,count) ,state_macro(12,count) ,param_macro(11, PIdx[count]) );}if(cBoolModel[PIdx[count] +8*NSEG]){CuBreakpointModel_NaTa_t(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(13,count) ,state_macro(14,count) ,param_macro(12, PIdx[count]) );}if(cBoolModel[PIdx[count] +9*NSEG]){CuBreakpointModel_NaTs2_t(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(15,count) ,state_macro(16,count) ,param_macro(13, PIdx[count]) );}if(cBoolModel[PIdx[count] +10*NSEG]){CuBreakpointModel_pas(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,param_macro(14, PIdx[count]) ,param_macro(15, PIdx[count]) );}if(cBoolModel[PIdx[count] +11*NSEG]){CuBreakpointModel_SK_E2(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(17,count) ,param_macro(16, PIdx[count]) ,param_macro(17, PIdx[count]) , cai[count] ,eca[count] );}if(cBoolModel[PIdx[count] +12*NSEG]){CuBreakpointModel_SKv3_1(sumCurrentsDv[count] , sumConductivityDv[count] ,v[count] +0.001,state_macro(18,count) ,param_macro(18, PIdx[count]) );}


#endif