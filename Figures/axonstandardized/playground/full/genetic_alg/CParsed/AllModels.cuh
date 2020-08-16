// Automatically generated CUH for C:\BBP_new./runModel.hoc

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


#define CALL_TO_INIT_STATES_CU(VARILP) if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuInitModel_Ca_HVA(v_ ## VARILP,ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0, PIdx_ ## VARILP) , ica## VARILP ,eca## VARILP , cai## VARILP );}if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuInitModel_Ca_LVAst(v_ ## VARILP,ModelStates_ ## VARILP[3],ModelStates_ ## VARILP[4],param_macro(1, PIdx_ ## VARILP) , ica## VARILP ,eca## VARILP , cai## VARILP );}if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuInitModel_CaDynamics_E2(v_ ## VARILP,cai## VARILP,param_macro(2, PIdx_ ## VARILP) ,param_macro(3, PIdx_ ## VARILP) ,param_macro(4, PIdx_ ## VARILP) ,param_macro(5, PIdx_ ## VARILP) , ica## VARILP ,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuInitModel_Ih(v_ ## VARILP,ModelStates_ ## VARILP[5],param_macro(6, PIdx_ ## VARILP) ,param_macro(7, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuInitModel_Im(v_ ## VARILP,ModelStates_ ## VARILP[6],param_macro(8, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuInitModel_K_Pst(v_ ## VARILP,ModelStates_ ## VARILP[7],ModelStates_ ## VARILP[8],param_macro(9, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +6*InMat.N]){CuInitModel_K_Tst(v_ ## VARILP,ModelStates_ ## VARILP[9],ModelStates_ ## VARILP[10],param_macro(10, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +7*InMat.N]){CuInitModel_Nap_Et2(v_ ## VARILP,ModelStates_ ## VARILP[11],ModelStates_ ## VARILP[12],param_macro(11, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +8*InMat.N]){CuInitModel_NaTa_t(v_ ## VARILP,ModelStates_ ## VARILP[13],ModelStates_ ## VARILP[14],param_macro(12, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +9*InMat.N]){CuInitModel_NaTs2_t(v_ ## VARILP,ModelStates_ ## VARILP[15],ModelStates_ ## VARILP[16],param_macro(13, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +10*InMat.N]){CuInitModel_pas(v_ ## VARILP,param_macro(14, PIdx_ ## VARILP) ,param_macro(15, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +11*InMat.N]){CuInitModel_SK_E2(v_ ## VARILP,ModelStates_ ## VARILP[18],param_macro(16, PIdx_ ## VARILP) ,param_macro(17, PIdx_ ## VARILP) , cai## VARILP ,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +12*InMat.N]){CuInitModel_SKv3_1(v_ ## VARILP,ModelStates_ ## VARILP[17],param_macro(18, PIdx_ ## VARILP) );}

#define CALL_TO_DERIV_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuDerivModel_Ca_HVA(dt, v_ ## VARILP,ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0, PIdx_ ## VARILP) , ica## VARILP );}if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuDerivModel_Ca_LVAst(dt, v_ ## VARILP,ModelStates_ ## VARILP[3],ModelStates_ ## VARILP[4],param_macro(1, PIdx_ ## VARILP) , ica## VARILP );}if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuDerivModel_CaDynamics_E2(dt, v_ ## VARILP,cai## VARILP,param_macro(2, PIdx_ ## VARILP) ,param_macro(3, PIdx_ ## VARILP) ,param_macro(4, PIdx_ ## VARILP) ,param_macro(5, PIdx_ ## VARILP) , ica## VARILP ,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuDerivModel_Ih(dt, v_ ## VARILP,ModelStates_ ## VARILP[5],param_macro(6, PIdx_ ## VARILP) ,param_macro(7, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuDerivModel_Im(dt, v_ ## VARILP,ModelStates_ ## VARILP[6],param_macro(8, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuDerivModel_K_Pst(dt, v_ ## VARILP,ModelStates_ ## VARILP[7],ModelStates_ ## VARILP[8],param_macro(9, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +6*InMat.N]){CuDerivModel_K_Tst(dt, v_ ## VARILP,ModelStates_ ## VARILP[9],ModelStates_ ## VARILP[10],param_macro(10, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +7*InMat.N]){CuDerivModel_Nap_Et2(dt, v_ ## VARILP,ModelStates_ ## VARILP[11],ModelStates_ ## VARILP[12],param_macro(11, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +8*InMat.N]){CuDerivModel_NaTa_t(dt, v_ ## VARILP,ModelStates_ ## VARILP[13],ModelStates_ ## VARILP[14],param_macro(12, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +9*InMat.N]){CuDerivModel_NaTs2_t(dt, v_ ## VARILP,ModelStates_ ## VARILP[15],ModelStates_ ## VARILP[16],param_macro(13, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +10*InMat.N]){}if(cBoolModel[PIdx_ ## VARILP +11*InMat.N]){CuDerivModel_SK_E2(dt, v_ ## VARILP,ModelStates_ ## VARILP[18],param_macro(16, PIdx_ ## VARILP) ,param_macro(17, PIdx_ ## VARILP) , cai## VARILP ,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +12*InMat.N]){CuDerivModel_SKv3_1(dt, v_ ## VARILP,ModelStates_ ## VARILP[17],param_macro(18, PIdx_ ## VARILP) );}

#define CALL_TO_BREAK_CU(VARILP)   if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_Ca_HVA(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0, PIdx_ ## VARILP) , ica## VARILP ,eca## VARILP , cai## VARILP );}if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuBreakpointModel_Ca_LVAst(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[3],ModelStates_ ## VARILP[4],param_macro(1, PIdx_ ## VARILP) , ica## VARILP ,eca## VARILP , cai## VARILP );}if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuBreakpointModel_CaDynamics_E2(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,cai## VARILP,param_macro(2, PIdx_ ## VARILP) ,param_macro(3, PIdx_ ## VARILP) ,param_macro(4, PIdx_ ## VARILP) ,param_macro(5, PIdx_ ## VARILP) , ica## VARILP ,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuBreakpointModel_Ih(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[5],param_macro(6, PIdx_ ## VARILP) ,param_macro(7, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuBreakpointModel_Im(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[6],param_macro(8, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuBreakpointModel_K_Pst(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[7],ModelStates_ ## VARILP[8],param_macro(9, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +6*InMat.N]){CuBreakpointModel_K_Tst(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[9],ModelStates_ ## VARILP[10],param_macro(10, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +7*InMat.N]){CuBreakpointModel_Nap_Et2(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[11],ModelStates_ ## VARILP[12],param_macro(11, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +8*InMat.N]){CuBreakpointModel_NaTa_t(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[13],ModelStates_ ## VARILP[14],param_macro(12, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +9*InMat.N]){CuBreakpointModel_NaTs2_t(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[15],ModelStates_ ## VARILP[16],param_macro(13, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +10*InMat.N]){CuBreakpointModel_pas(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,param_macro(14, PIdx_ ## VARILP) ,param_macro(15, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +11*InMat.N]){CuBreakpointModel_SK_E2(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[18],param_macro(16, PIdx_ ## VARILP) ,param_macro(17, PIdx_ ## VARILP) , cai## VARILP ,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +12*InMat.N]){CuBreakpointModel_SKv3_1(sumCurrents_ ## VARILP , sumConductivity_ ## VARILP,v_ ## VARILP ,ModelStates_ ## VARILP[17],param_macro(18, PIdx_ ## VARILP) );}

#define CALL_TO_BREAK_DV_CU(VARILP)    if(cBoolModel[PIdx_ ## VARILP +0*InMat.N]){CuBreakpointModel_Ca_HVA(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[1],ModelStates_ ## VARILP[2],param_macro(0, PIdx_ ## VARILP) , temp,eca## VARILP , cai## VARILP );}if(cBoolModel[PIdx_ ## VARILP +1*InMat.N]){CuBreakpointModel_Ca_LVAst(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[3],ModelStates_ ## VARILP[4],param_macro(1, PIdx_ ## VARILP) , temp,eca## VARILP , cai## VARILP );}if(cBoolModel[PIdx_ ## VARILP +2*InMat.N]){CuBreakpointModel_CaDynamics_E2(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,cai## VARILP,param_macro(2, PIdx_ ## VARILP) ,param_macro(3, PIdx_ ## VARILP) ,param_macro(4, PIdx_ ## VARILP) ,param_macro(5, PIdx_ ## VARILP) , temp,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +3*InMat.N]){CuBreakpointModel_Ih(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[5],param_macro(6, PIdx_ ## VARILP) ,param_macro(7, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +4*InMat.N]){CuBreakpointModel_Im(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[6],param_macro(8, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +5*InMat.N]){CuBreakpointModel_K_Pst(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[7],ModelStates_ ## VARILP[8],param_macro(9, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +6*InMat.N]){CuBreakpointModel_K_Tst(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[9],ModelStates_ ## VARILP[10],param_macro(10, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +7*InMat.N]){CuBreakpointModel_Nap_Et2(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[11],ModelStates_ ## VARILP[12],param_macro(11, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +8*InMat.N]){CuBreakpointModel_NaTa_t(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[13],ModelStates_ ## VARILP[14],param_macro(12, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +9*InMat.N]){CuBreakpointModel_NaTs2_t(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[15],ModelStates_ ## VARILP[16],param_macro(13, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +10*InMat.N]){CuBreakpointModel_pas(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,param_macro(14, PIdx_ ## VARILP) ,param_macro(15, PIdx_ ## VARILP) );}if(cBoolModel[PIdx_ ## VARILP +11*InMat.N]){CuBreakpointModel_SK_E2(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[18],param_macro(16, PIdx_ ## VARILP) ,param_macro(17, PIdx_ ## VARILP) , cai## VARILP ,eca## VARILP );}if(cBoolModel[PIdx_ ## VARILP +12*InMat.N]){CuBreakpointModel_SKv3_1(sumCurrentsDv_ ## VARILP , sumConductivityDv_ ## VARILP ,v_ ## VARILP +0.001,ModelStates_ ## VARILP[17],param_macro(18, PIdx_ ## VARILP) );}


#endif