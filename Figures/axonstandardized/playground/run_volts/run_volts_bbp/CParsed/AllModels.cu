// Automatically generated CU for C:\BBP_new./runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "AllModels.cuh"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)
#define DEF_vrest	-65.
#define DEF_nai 10.
#define DEF_nao 140.
#define DEF_ena (115. + DEF_vrest)
#define DEF_ki	54.4
#define DEF_ko 2.5
#define DEF_ek (-12. + DEF_vrest)
#include <math.h>
#define DEF_cai	5.e-5
#define DEF_cao	2.
#define	DEF_eca		12.5 *log(DEF_cao / DEF_cai)

// GGlobals:
#define celsius (34.0)
#define stoprun (0.0)
#define clamp_resist (0.001)
#define secondorder (0.0)

// NGlobals:
// Reversals:
#define ena (50.0f)
#define ek (-85.0f)
#define def_eca2 (140.218711995f)

// Declarations:
__device__ void Curates_Ca_HVA(MYFTYPE v,MYFTYPE gCa_HVAbar_Ca_HVA,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_Ca_LVAst(MYFTYPE v,MYFTYPE gCa_LVAstbar_Ca_LVAst,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_Ih(MYFTYPE v,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_Im(MYFTYPE v,MYFTYPE gImbar_Im,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_K_Pst(MYFTYPE v,MYFTYPE gK_Pstbar_K_Pst,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_K_Tst(MYFTYPE v,MYFTYPE gK_Tstbar_K_Tst,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_Nap_Et2(MYFTYPE v,MYFTYPE gNap_Et2bar_Nap_Et2,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_NaTa_t(MYFTYPE v,MYFTYPE gNaTa_tbar_NaTa_t,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_NaTs2_t(MYFTYPE v,MYFTYPE gNaTs2_tbar_NaTs2_t,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau);
__device__ void Curates_SK_E2(MYFTYPE ca,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2,MYFTYPE &zInf);
__device__ void Curates_SKv3_1(MYFTYPE v,MYFTYPE gSKv3_1bar_SKv3_1,MYFTYPE &mInf,MYFTYPE &mTau);
float Cunernst(float ci,float co, float z) {
	if (z == 0) {
		return 0.;
	}
	if (ci <= 0.) {
		return 1e6;
	}else if (co <= 0.) {
		return -1e6;
	}else{
		return ktf/z*log(co/ci);
	}	
}

// Functions:

// Procedures:
__device__ void Curates_Ca_HVA(MYFTYPE v,MYFTYPE gCa_HVAbar_Ca_HVA,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau) {
    if ( ( v  == - 27.0 ) ) {
     v = v + 0.0001 ;
     }
   mAlpha = ( 0.055 * ( - 27.0 - v ) ) / ( exp ( ( - 27.0 - v ) / 3.8 ) - 1.0 ) ;
   mBeta = ( 0.94 * exp ( ( - 75.0 - v ) / 17.0 ) ) ;
   mInf = mAlpha / ( mAlpha + mBeta ) ;
   mTau = 1.0 / ( mAlpha + mBeta ) ;
   hAlpha = ( 0.000457 * exp ( ( - 13.0 - v ) / 50.0 ) ) ;
   hBeta = ( 0.0065 / ( exp ( ( - v - 15.0 ) / 28.0 ) + 1.0 ) ) ;
   hInf = hAlpha / ( hAlpha + hBeta ) ;
   hTau = 1.0 / ( hAlpha + hBeta ) ;
}
__device__ void Curates_Ca_LVAst(MYFTYPE v,MYFTYPE gCa_LVAstbar_Ca_LVAst,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mInf,MYFTYPE &mTau) {
   MYFTYPE qt ;
 qt = powf( 2.3 , ( ( 34.0 - 21.0 ) / 10.0 ) ) ;
    v = v + 10.0 ;
   mInf = 1.0000 / ( 1.0 + exp ( ( v - - 30.000 ) / - 6.0 ) ) ;
   mTau = ( 5.0000 + 20.0000 / ( 1.0 + exp ( ( v - - 25.000 ) / 5.0 ) ) ) / qt ;
   hInf = 1.0000 / ( 1.0 + exp ( ( v - - 80.000 ) / 6.4 ) ) ;
   hTau = ( 20.0000 + 50.0000 / ( 1.0 + exp ( ( v - - 40.000 ) / 7.0 ) ) ) / qt ;
   v = v - 10.0 ;
}
__device__ void Curates_Ih(MYFTYPE v,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau) {
    if ( v  == - 154.9 ) {
     v = v + 0.0001 ;
     }
   mAlpha = 0.001 * 6.43 * ( v + 154.9 ) / ( exp ( ( v + 154.9 ) / 11.9 ) - 1.0 ) ;
   mBeta = 0.001 * 193.0 * exp ( v / 33.1 ) ;
   mInf = mAlpha / ( mAlpha + mBeta ) ;
   mTau = 1.0 / ( mAlpha + mBeta ) ;
}
__device__ void Curates_Im(MYFTYPE v,MYFTYPE gImbar_Im,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau) {
   MYFTYPE qt ;
 qt = powf( 2.3 , ( ( 34.0 - 21.0 ) / 10.0 ) ) ;
    mAlpha = 3.3e-3 * exp ( 2.5 * 0.04 * ( v - - 35.0 ) ) ;
   mBeta = 3.3e-3 * exp ( - 2.5 * 0.04 * ( v - - 35.0 ) ) ;
   mInf = mAlpha / ( mAlpha + mBeta ) ;
   mTau = ( 1.0 / ( mAlpha + mBeta ) ) / qt ;
}
__device__ void Curates_K_Pst(MYFTYPE v,MYFTYPE gK_Pstbar_K_Pst,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mInf,MYFTYPE &mTau) {
   MYFTYPE qt ;
 qt = powf( 2.3 , ( ( 34.0 - 21.0 ) / 10.0 ) ) ;
    v = v + 10.0 ;
   mInf = ( 1.0 / ( 1.0 + exp ( - ( v + 1.0 ) / 12.0 ) ) ) ;
   if ( v < - 50.0 ) {
     mTau = ( 1.25 + 175.03 * exp ( - v * - 0.026 ) ) / qt ;
     }
   else {
     mTau = ( ( 1.25 + 13.0 * exp ( - v * 0.026 ) ) ) / qt ;
     }
   hInf = 1.0 / ( 1.0 + exp ( - ( v + 54.0 ) / - 11.0 ) ) ;
   hTau = ( 360.0 + ( 1010.0 + 24.0 * ( v + 55.0 ) ) * exp ( - powf( ( ( v + 75.0 ) / 48.0 ) , 2.0 ) ) ) / qt ;
   v = v - 10.0 ;
}
__device__ void Curates_K_Tst(MYFTYPE v,MYFTYPE gK_Tstbar_K_Tst,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mInf,MYFTYPE &mTau) {
   MYFTYPE qt ;
 qt = powf( 2.3 , ( ( 34.0 - 21.0 ) / 10.0 ) ) ;
    v = v + 10.0 ;
   mInf = 1.0 / ( 1.0 + exp ( - ( v + 0.0 ) / 19.0 ) ) ;
   mTau = ( 0.34 + 0.92 * exp ( - powf( ( ( v + 71.0 ) / 59.0 ) , 2.0 ) ) ) / qt ;
   hInf = 1.0 / ( 1.0 + exp ( - ( v + 66.0 ) / - 10.0 ) ) ;
   hTau = ( 8.0 + 49.0 * exp ( - powf( ( ( v + 73.0 ) / 23.0 ) , 2.0 ) ) ) / qt ;
   v = v - 10.0 ;
}
__device__ void Curates_Nap_Et2(MYFTYPE v,MYFTYPE gNap_Et2bar_Nap_Et2,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau) {
   MYFTYPE qt ;
 qt = powf( 2.3 , ( ( 34.0 - 21.0 ) / 10.0 ) ) ;
    mInf = 1.0 / ( 1.0 + exp ( ( v - - 52.6 ) / - 4.6 ) ) ;
   if ( v  == - 38.0 ) {
     v = v + 0.0001 ;
     }
   mAlpha = ( 0.182 * ( v - - 38.0 ) ) / ( 1.0 - ( exp ( - ( v - - 38.0 ) / 6.0 ) ) ) ;
   mBeta = ( 0.124 * ( - v - 38.0 ) ) / ( 1.0 - ( exp ( - ( - v - 38.0 ) / 6.0 ) ) ) ;
   mTau = 6.0 * ( 1.0 / ( mAlpha + mBeta ) ) / qt ;
   if ( v  == - 17.0 ) {
     v = v + 0.0001 ;
     }
   if ( v  == - 64.4 ) {
     v = v + 0.0001 ;
     }
   hInf = 1.0 / ( 1.0 + exp ( ( v - - 48.8 ) / 10.0 ) ) ;
   hAlpha = - 2.88e-6 * ( v + 17.0 ) / ( 1.0 - exp ( ( v + 17.0 ) / 4.63 ) ) ;
   hBeta = 6.94e-6 * ( v + 64.4 ) / ( 1.0 - exp ( - ( v + 64.4 ) / 2.63 ) ) ;
   hTau = ( 1.0 / ( hAlpha + hBeta ) ) / qt ;
}
__device__ void Curates_NaTa_t(MYFTYPE v,MYFTYPE gNaTa_tbar_NaTa_t,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau) {
   MYFTYPE qt ;
 qt = powf( 2.3 , ( ( 34.0 - 21.0 ) / 10.0 ) ) ;
    if ( v  == - 38.0 ) {
     v = v + 0.0001 ;
     }
   mAlpha = ( 0.182 * ( v - - 38.0 ) ) / ( 1.0 - ( exp ( - ( v - - 38.0 ) / 6.0 ) ) ) ;
   mBeta = ( 0.124 * ( - v - 38.0 ) ) / ( 1.0 - ( exp ( - ( - v - 38.0 ) / 6.0 ) ) ) ;
   mTau = ( 1.0 / ( mAlpha + mBeta ) ) / qt ;
   mInf = mAlpha / ( mAlpha + mBeta ) ;
   if ( v  == - 66.0 ) {
     v = v + 0.0001 ;
     }
   hAlpha = ( - 0.015 * ( v - - 66.0 ) ) / ( 1.0 - ( exp ( ( v - - 66.0 ) / 6.0 ) ) ) ;
   hBeta = ( - 0.015 * ( - v - 66.0 ) ) / ( 1.0 - ( exp ( ( - v - 66.0 ) / 6.0 ) ) ) ;
   hTau = ( 1.0 / ( hAlpha + hBeta ) ) / qt ;
   hInf = hAlpha / ( hAlpha + hBeta ) ;
}
__device__ void Curates_NaTs2_t(MYFTYPE v,MYFTYPE gNaTs2_tbar_NaTs2_t,MYFTYPE &hAlpha,MYFTYPE &hBeta,MYFTYPE &hInf,MYFTYPE &hTau,MYFTYPE &mAlpha,MYFTYPE &mBeta,MYFTYPE &mInf,MYFTYPE &mTau) {
   MYFTYPE qt ;
 qt = powf( 2.3 , ( ( 34.0 - 21.0 ) / 10.0 ) ) ;
    if ( v  == - 32.0 ) {
     v = v + 0.0001 ;
     }
   mAlpha = ( 0.182 * ( v - - 32.0 ) ) / ( 1.0 - ( exp ( - ( v - - 32.0 ) / 6.0 ) ) ) ;
   mBeta = ( 0.124 * ( - v - 32.0 ) ) / ( 1.0 - ( exp ( - ( - v - 32.0 ) / 6.0 ) ) ) ;
   mInf = mAlpha / ( mAlpha + mBeta ) ;
   mTau = ( 1.0 / ( mAlpha + mBeta ) ) / qt ;
   if ( v  == - 60.0 ) {
     v = v + 0.0001 ;
     }
   hAlpha = ( - 0.015 * ( v - - 60.0 ) ) / ( 1.0 - ( exp ( ( v - - 60.0 ) / 6.0 ) ) ) ;
   hBeta = ( - 0.015 * ( - v - 60.0 ) ) / ( 1.0 - ( exp ( ( - v - 60.0 ) / 6.0 ) ) ) ;
   hInf = hAlpha / ( hAlpha + hBeta ) ;
   hTau = ( 1.0 / ( hAlpha + hBeta ) ) / qt ;
}
__device__ void Curates_SK_E2(MYFTYPE ca,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2,MYFTYPE &zInf) {
   if ( ca < 1e-7 ) {
     ca = ca + 1e-07 ;
     }
   zInf = 1.0 / ( 1.0 + powf( ( 0.00043 / ca ) , 4.8 ) ) ;
}
__device__ void Curates_SKv3_1(MYFTYPE v,MYFTYPE gSKv3_1bar_SKv3_1,MYFTYPE &mInf,MYFTYPE &mTau) {
    mInf = 1.0 / ( 1.0 + exp ( ( ( v - ( 18.700 ) ) / ( - 9.700 ) ) ) ) ;
   mTau = 0.2 * 20.000 / ( 1.0 + exp ( ( ( v - ( - 46.560 ) ) / ( - 44.140 ) ) ) ) ;
}

// Inits:


__device__ void CuInitModel_Ca_HVA(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai){
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
cai = DEF_cai;
eca = ktf/2 *log(DEF_cao / cai);
Curates_Ca_HVA(v,gCa_HVAbar_Ca_HVA,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
   m = mInf;
   h = hInf;
};


__device__ void CuInitModel_Ca_LVAst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai){
MYFTYPE hInf,hTau,mInf,mTau;
cai = DEF_cai;
eca = ktf/2 *log(DEF_cao / cai);
Curates_Ca_LVAst(v,gCa_LVAstbar_Ca_LVAst,hInf,hTau,mInf,mTau);
   m = mInf;
   h = hInf;
};


__device__ void CuInitModel_CaDynamics_E2(MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca){
cai = DEF_cai;
eca = ktf/2 *log(DEF_cao / cai);
};


__device__ void CuInitModel_Ih(MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih){
MYFTYPE mAlpha,mBeta,mInf,mTau;
Curates_Ih(v,gIhbar_Ih,ehcn_Ih,mAlpha,mBeta,mInf,mTau);
   m = mInf;
};


__device__ void CuInitModel_Im(MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im){
MYFTYPE mAlpha,mBeta,mInf,mTau;
Curates_Im(v,gImbar_Im,mAlpha,mBeta,mInf,mTau);
   m = mInf;
};


__device__ void CuInitModel_K_Pst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst){
MYFTYPE hInf,hTau,mInf,mTau;
Curates_K_Pst(v,gK_Pstbar_K_Pst,hInf,hTau,mInf,mTau);
   m = mInf;
   h = hInf;
};


__device__ void CuInitModel_K_Tst(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst){
MYFTYPE hInf,hTau,mInf,mTau;
Curates_K_Tst(v,gK_Tstbar_K_Tst,hInf,hTau,mInf,mTau);
   m = mInf;
   h = hInf;
};


__device__ void CuInitModel_Nap_Et2(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2){
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
Curates_Nap_Et2(v,gNap_Et2bar_Nap_Et2,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
   m = mInf;
   h = hInf;
};


__device__ void CuInitModel_NaTa_t(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t){
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
Curates_NaTa_t(v,gNaTa_tbar_NaTa_t,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
   m = mInf;
   h = hInf;
};


__device__ void CuInitModel_NaTs2_t(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t){
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
Curates_NaTs2_t(v,gNaTs2_tbar_NaTs2_t,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
   m = mInf;
   h = hInf;
};


__device__ void CuInitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas){
};


__device__ void CuInitModel_SK_E2(MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca){
MYFTYPE zInf;
eca = ktf/2 *log(DEF_cao / cai);
Curates_SK_E2(cai,gSK_E2bar_SK_E2,zTau_SK_E2,zInf);
        z = zInf;
};


__device__ void CuInitModel_SKv3_1(MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1){
MYFTYPE mInf,mTau;
Curates_SKv3_1(v,gSKv3_1bar_SKv3_1,mInf,mTau);
   m = mInf;
};

// Derivs:
__device__ void CuDerivModel_Ca_HVA(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica){
MYFTYPE gCa;
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
Curates_Ca_HVA (v,gCa_HVAbar_Ca_HVA,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / hTau)))*(- ( ( ( hInf ) ) / hTau ) / ( ( ( ( - 1.0 ) ) ) / hTau ) - h) ;
}
__device__ void CuDerivModel_Ca_LVAst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica){
MYFTYPE gCa_LVAst;
MYFTYPE hInf,hTau,mInf,mTau;
Curates_Ca_LVAst (v,gCa_LVAstbar_Ca_LVAst,hInf,hTau,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / hTau)))*(- ( ( ( hInf ) ) / hTau ) / ( ( ( ( - 1.0 ) ) ) / hTau ) - h) ;
}
__device__ void CuDerivModel_CaDynamics_E2(MYFTYPE dt, MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca){

    cai = cai + (1. - exp(dt*(( - ( ( 1.0 ) ) / decay_CaDynamics_E2 ))))*(- ( ( - ( 10000.0 ) )*( ( ( ( ica )*( gamma_CaDynamics_E2 ) ) / ( 2.0 * FARADAY * depth_CaDynamics_E2 ) ) ) - ( ( ( - minCai_CaDynamics_E2 ) ) ) / decay_CaDynamics_E2 ) / ( ( - ( ( 1.0 ) ) / decay_CaDynamics_E2 ) ) - cai) ;
eca = ktf/2 *log(DEF_cao / cai);
}
__device__ void CuDerivModel_Ih(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih){
MYFTYPE ihcn,gIh;
MYFTYPE mAlpha,mBeta,mInf,mTau;
Curates_Ih (v,gIhbar_Ih,ehcn_Ih,mAlpha,mBeta,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
}
__device__ void CuDerivModel_Im(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im){
MYFTYPE gIm;
MYFTYPE mAlpha,mBeta,mInf,mTau;
Curates_Im (v,gImbar_Im,mAlpha,mBeta,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
}
__device__ void CuDerivModel_K_Pst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst){
MYFTYPE gK_Pst;
MYFTYPE hInf,hTau,mInf,mTau;
Curates_K_Pst (v,gK_Pstbar_K_Pst,hInf,hTau,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / hTau)))*(- ( ( ( hInf ) ) / hTau ) / ( ( ( ( - 1.0 ) ) ) / hTau ) - h) ;
}
__device__ void CuDerivModel_K_Tst(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst){
MYFTYPE gK_Tst;
MYFTYPE hInf,hTau,mInf,mTau;
Curates_K_Tst (v,gK_Tstbar_K_Tst,hInf,hTau,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / hTau)))*(- ( ( ( hInf ) ) / hTau ) / ( ( ( ( - 1.0 ) ) ) / hTau ) - h) ;
}
__device__ void CuDerivModel_Nap_Et2(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2){
MYFTYPE gNap_Et2;
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
Curates_Nap_Et2 (v,gNap_Et2bar_Nap_Et2,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / hTau)))*(- ( ( ( hInf ) ) / hTau ) / ( ( ( ( - 1.0 ) ) ) / hTau ) - h) ;
}
__device__ void CuDerivModel_NaTa_t(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t){
MYFTYPE gNaTa_t;
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
Curates_NaTa_t (v,gNaTa_tbar_NaTa_t,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / hTau)))*(- ( ( ( hInf ) ) / hTau ) / ( ( ( ( - 1.0 ) ) ) / hTau ) - h) ;
}
__device__ void CuDerivModel_NaTs2_t(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t){
MYFTYPE gNaTs2_t;
MYFTYPE hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau;
Curates_NaTs2_t (v,gNaTs2_tbar_NaTs2_t,hAlpha,hBeta,hInf,hTau,mAlpha,mBeta,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / hTau)))*(- ( ( ( hInf ) ) / hTau ) / ( ( ( ( - 1.0 ) ) ) / hTau ) - h) ;
}
__device__ void CuDerivModel_SK_E2(MYFTYPE dt, MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca){
MYFTYPE gSK_E2;
MYFTYPE zInf;
Curates_SK_E2 (   cai,gSK_E2bar_SK_E2,zTau_SK_E2,zInf);
    z = z + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / zTau_SK_E2)))*(- ( ( ( zInf ) ) / zTau_SK_E2 ) / ( ( ( ( - 1.0 ) ) ) / zTau_SK_E2 ) - z) ;
}
__device__ void CuDerivModel_SKv3_1(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1){
MYFTYPE gSKv3_1;
MYFTYPE mInf,mTau;
Curates_SKv3_1 (v,gSKv3_1bar_SKv3_1,mInf,mTau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mTau)))*(- ( ( ( mInf ) ) / mTau ) / ( ( ( ( - 1.0 ) ) ) / mTau ) - m) ;
}

// Breaks:


__device__ void CuBreakpointModel_Ca_HVA(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_HVAbar_Ca_HVA, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai) {
MYFTYPE gCa, gCa_HVA;
MYFTYPE ;
MYFTYPE ica_Ca_HVA;

   gCa = gCa_HVAbar_Ca_HVA * m * m * h ;
   ica_Ca_HVA = gCa * ( v - eca ) ;
sumCurrents+= ica_Ca_HVA;

 ica += ica_Ca_HVA;
sumConductivity+= gCa;
};


__device__ void CuBreakpointModel_Ca_LVAst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gCa_LVAstbar_Ca_LVAst, MYFTYPE &ica,MYFTYPE &eca, MYFTYPE &cai) {
MYFTYPE gca, gCa_LVAst;
MYFTYPE ;
MYFTYPE ica_Ca_LVAst;

   gCa_LVAst = gCa_LVAstbar_Ca_LVAst * m * m * h ;
   ica_Ca_LVAst = gCa_LVAst * ( v - eca ) ;
sumCurrents+= ica_Ca_LVAst;

 ica += ica_Ca_LVAst;
sumConductivity+= gCa_LVAst;
};


__device__ void CuBreakpointModel_CaDynamics_E2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &cai,MYFTYPE gamma_CaDynamics_E2,MYFTYPE decay_CaDynamics_E2,MYFTYPE depth_CaDynamics_E2,MYFTYPE minCai_CaDynamics_E2, MYFTYPE ica,MYFTYPE &eca) {
MYFTYPE gca;
MYFTYPE ;
};


__device__ void CuBreakpointModel_Ih(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gIhbar_Ih,MYFTYPE ehcn_Ih) {
MYFTYPE ihcn, gIh;
MYFTYPE i;
   gIh = gIhbar_Ih * m ;
   ihcn = gIh * ( v - ehcn_Ih ) ;
i = ihcn;

sumCurrents+= i;
sumConductivity+= gIh;
};


__device__ void CuBreakpointModel_Im(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gImbar_Im) {
MYFTYPE gIm, gk, ik;
MYFTYPE ;
   gIm = gImbar_Im * m ;
   ik = gIm * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gIm;
};


__device__ void CuBreakpointModel_K_Pst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Pstbar_K_Pst) {
MYFTYPE gK_Pst, ik, gk;
MYFTYPE ;
   gK_Pst = gK_Pstbar_K_Pst * m * m * h ;
   ik = gK_Pst * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gK_Pst;
};


__device__ void CuBreakpointModel_K_Tst(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gK_Tstbar_K_Tst) {
MYFTYPE gk, ik, gK_Tst;
MYFTYPE ;
   gK_Tst = gK_Tstbar_K_Tst * powf( m , 4.0 ) * h ;
   ik = gK_Tst * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gK_Tst;
};


__device__ void CuBreakpointModel_Nap_Et2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNap_Et2bar_Nap_Et2) {
MYFTYPE gna, ina, gNap_Et2;
MYFTYPE ;
   gNap_Et2 = gNap_Et2bar_Nap_Et2 * m * m * m * h ;
   ina = gNap_Et2 * ( v - ena ) ;
sumCurrents+= ina;
sumConductivity+= gNap_Et2;
};


__device__ void CuBreakpointModel_NaTa_t(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTa_tbar_NaTa_t) {
MYFTYPE gna, gNaTa_t, ina;
MYFTYPE ;
   gNaTa_t = gNaTa_tbar_NaTa_t * m * m * m * h ;
   ina = gNaTa_t * ( v - ena ) ;
sumCurrents+= ina;
sumConductivity+= gNaTa_t;
};


__device__ void CuBreakpointModel_NaTs2_t(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gNaTs2_tbar_NaTs2_t) {
MYFTYPE gNaTs2_t, gna, ina;
MYFTYPE ;
   gNaTs2_t = gNaTs2_tbar_NaTs2_t * m * m * m * h ;
   ina = gNaTs2_t * ( v - ena ) ;
sumCurrents+= ina;
sumConductivity+= gNaTs2_t;
};


__device__ void CuBreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) {
MYFTYPE;
MYFTYPE i;
   i = g_pas * ( v - e_pas ) ;
i = i;

sumCurrents+= i;
sumConductivity+= g_pas;
};


__device__ void CuBreakpointModel_SK_E2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &z,MYFTYPE gSK_E2bar_SK_E2,MYFTYPE zTau_SK_E2, MYFTYPE cai,MYFTYPE &eca) {
MYFTYPE gca, ik, gk, gSK_E2;
MYFTYPE ;
   gSK_E2 = gSK_E2bar_SK_E2 * z ;
   ik = gSK_E2 * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gSK_E2;
};


__device__ void CuBreakpointModel_SKv3_1(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE gSKv3_1bar_SKv3_1) {
MYFTYPE ik, gk, gSKv3_1;
MYFTYPE ;
   gSKv3_1 = gSKv3_1bar_SKv3_1 * m ;
   ik = gSKv3_1 * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gSKv3_1;
};
