// Automatically generated CU for C:\Users\Maxwell Chen\Desktop\NeuroGPU\Figures\Figure4_mainen./runModel.hoc
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
#define celsius (37.0)
#define stoprun (0.0)
#define clamp_resist (0.001)
#define secondorder (0.0)

// NGlobals:
#define q10_ca (2.3)
#define temp_ca (23.0)
#define tadj_ca (3.2093639532679714)
#define vmin_ca (-120.0)
#define vmax_ca (100.0)
#define vshift_ca (0.0)
#define depth_cad (0.09334562733124982)
#define cainf_cad (0.0001)
#define taur_cad (200.0)
#define q10_kca (2.3)
#define temp_kca (23.0)
#define tadj_kca (3.2093639532679714)
#define vmin_kca (-120.0)
#define vmax_kca (100.0)
#define q10_km (2.3)
#define temp_km (23.0)
#define tadj_km (3.2093639532679714)
#define vmin_km (-120.0)
#define vmax_km (100.0)
#define q10_kv (2.3)
#define temp_kv (23.0)
#define tadj_kv (3.2093639532679714)
#define vmin_kv (-120.0)
#define vmax_kv (100.0)
#define q10_na (2.3)
#define temp_na (23.0)
#define tadj_na (3.2093639532679714)
#define vmin_na (-120.0)
#define vmax_na (100.0)
#define vshift_na (-5.0)
// Reversals:
#define ek (-90.0f)
#define DEF_eca2 (140.0f)
#define ena (60.0f)

// Declarations:
__device__ void Cutrates_ca(MYFTYPE v ,MYFTYPE gbar_ca,MYFTYPE cao_ca,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau);
__device__ void Curates_ca(MYFTYPE vm ,MYFTYPE gbar_ca,MYFTYPE cao_ca,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau);
__device__ void Curates_kca(MYFTYPE cai,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau);
__device__ void Cutrates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau);
__device__ void Curates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau);
__device__ void Cutrates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau);
__device__ void Curates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau);
__device__ void Cutrates_na(MYFTYPE v,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau);
__device__ void Curates_na(MYFTYPE vm,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau);
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
__device__ MYFTYPE Cuefun_ca(MYFTYPE z){
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
__device__ MYFTYPE Cuefun_km(MYFTYPE z){
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
__device__ MYFTYPE Cuefun_kv(MYFTYPE z){
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
__device__ MYFTYPE Cutrap0_na(MYFTYPE v,MYFTYPE th,MYFTYPE a,MYFTYPE q){
	if (fabs((v-th)/q) > 1e-6) {;
	        return  a * (v - th) / (1 - exp(-(v - th)/q));
	} else {;
	        return  a * q;
	};
}	;

// Procedures:
__device__ void Cutrates_ca(MYFTYPE v ,MYFTYPE gbar_ca,MYFTYPE cao_ca,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau) {
   Curates_ca (   v ,gbar_ca,cao_ca,hinf,htau,minf,mtau);
}
__device__ void Curates_ca(MYFTYPE vm ,MYFTYPE gbar_ca,MYFTYPE cao_ca,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau) {
   MYFTYPE a , b ;
/* removed tadj_ca recalculation */
   a = 0.209 * Cuefun_ca (   - ( 27.0 + vm ) / 3.8 ) ;
   b = 0.94 * exp ( ( - 75.0 - vm ) / 17.0 ) ;
   mtau = 1.0 / tadj_ca / ( a + b ) ;
   minf = a / ( a + b ) ;
   a = 0.000457 * exp ( ( - 13.0 - vm ) / 50.0 ) ;
   b = 0.0065 / ( exp ( ( - vm - 15.0 ) / 28.0 ) + 1.0 ) ;
   htau = 1.0 / tadj_ca / ( a + b ) ;
   hinf = a / ( a + b ) ;
}
__device__ void Curates_kca(MYFTYPE cai,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau) {
   a = Ra_kca * powf( cai , caix_kca ) ;
   b = Rb_kca ;
  /* removed tadj_kca recalculation */
   ntau = 1.0 / tadj_kca / ( a + b ) ;
   ninf = a / ( a + b ) ;
}
__device__ void Cutrates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau) {
   Curates_km (   v ,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
}
__device__ void Curates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau) {
   a = Ra_km * qa_km * Cuefun_km (   - ( v - tha_km ) / qa_km ) ;
   b = Rb_km * qa_km * Cuefun_km (   ( v - tha_km ) / qa_km ) ;
  /* removed tadj_km recalculation */
   ntau = 1.0 / tadj_km / ( a + b ) ;
   ninf = a / ( a + b ) ;
}
__device__ void Cutrates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau) {
   Curates_kv (   v ,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
}
__device__ void Curates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv,MYFTYPE &a,MYFTYPE &b,MYFTYPE &ninf,MYFTYPE &ntau) {
   a = Ra_kv * qa_kv * Cuefun_kv (   - ( v - tha_kv ) / qa_kv ) ;
   b = Rb_kv * qa_kv * Cuefun_kv (   ( v - tha_kv ) / qa_kv ) ;
  /* removed tadj_kv recalculation */
   ntau = 1.0 / tadj_kv / ( a + b ) ;
   ninf = a / ( a + b ) ;
}
__device__ void Cutrates_na(MYFTYPE v,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau) {
   Curates_na (   v ,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na,hinf,htau,minf,mtau);
}
__device__ void Curates_na(MYFTYPE vm,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na,MYFTYPE &hinf,MYFTYPE &htau,MYFTYPE &minf,MYFTYPE &mtau) {
   MYFTYPE a , b ;
 a = Cutrap0_na (   vm , tha_na , Ra_na , qa_na ) ;
   b = Cutrap0_na (   - vm , - tha_na , Rb_na , qa_na ) ;
  /* removed tadj_na recalculation */
   mtau = 1.0 / tadj_na / ( a + b ) ;
   minf = a / ( a + b ) ;
   a = Cutrap0_na (   vm , thi1_na , Rd_na , qi_na ) ;
   b = Cutrap0_na (   - vm , - thi2_na , Rg_na , qi_na ) ;
   htau = 1.0 / tadj_na / ( a + b ) ;
   hinf = 1.0 / ( 1.0 + exp ( ( vm - thinf_na ) / qinf_na ) ) ;
}

// Inits:


__device__ void CuInitModel_ca(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca){
MYFTYPE hinf,htau,minf,mtau;
eca = DEF_eca2;
eca =DEF_eca2;
   /* removed tadj_ca recalculation */
Cutrates_ca(v+vshift_ca,gbar_ca,cao_ca,hinf,htau,minf,mtau);
   m = minf;
   h = hinf;
};


__device__ void CuInitModel_cad(MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca){
cai = DEF_cai;
eca = ktf/2 *log(DEF_cao / cai);
   ca = cainf_cad;
   cai = ca;
};


__device__ void CuInitModel_kca(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca){
MYFTYPE a,b,ninf,ntau;
eca =DEF_eca2;
Curates_kca(cai,gbar_kca,caix_kca,Ra_kca,Rb_kca,a,b,ninf,ntau);
   n = ninf;
};


__device__ void CuInitModel_km(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km){
MYFTYPE a,b,ninf,ntau;
   /* removed tadj_km recalculation */
Cutrates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
   n = ninf;
};


__device__ void CuInitModel_kv(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv){
MYFTYPE a,b,ninf,ntau;
   /* removed tadj_kv recalculation */
Cutrates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
   n = ninf;
};


__device__ void CuInitModel_na(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na){
MYFTYPE hinf,htau,minf,mtau;
   /* removed tadj_na recalculation */
Cutrates_na(v+vshift_na,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na,hinf,htau,minf,mtau);
   m = minf;
   h = hinf;
};


__device__ void CuInitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas){
};


__device__ void CuInitModel_pas2(MYFTYPE v,MYFTYPE g_pas2,MYFTYPE e_pas2){
};


__device__ void CuInitModel_pasx(MYFTYPE v,MYFTYPE g_pasx,MYFTYPE e_pasx){
};

// Derivs:
__device__ void CuDerivModel_ca(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca){

MYFTYPE hinf,htau,minf,mtau;
Cutrates_ca (   v + vshift_ca,gbar_ca,cao_ca,hinf,htau,minf,mtau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0 ) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0 ) ) ) / htau ) - h) ;
eca = DEF_eca2;
}
__device__ void CuDerivModel_cad(MYFTYPE dt, MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca){
MYFTYPE drive_channel;
   drive_channel = - ( 10000.0 ) * ica / ( 2.0 * FARADAY * depth_cad ) ;
   if ( drive_channel <= 0. ) {
     drive_channel = 0. ;
     }
    ca = ca + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / taur_cad)))*(- ( drive_channel + ( ( cainf_cad ) ) / taur_cad ) / ( ( ( ( - 1.0 ) ) ) / taur_cad ) - ca) ;
   cai = ca ;
eca = DEF_eca2;
}
__device__ void CuDerivModel_kca(MYFTYPE dt, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca){
MYFTYPE ek;
MYFTYPE a,b,ninf,ntau;
Curates_kca (   cai,gbar_kca,caix_kca,Ra_kca,Rb_kca,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0 ) ) ) / ntau ) - n) ;
eca = DEF_eca2;
}
__device__ void CuDerivModel_km(MYFTYPE dt, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km){

MYFTYPE a,b,ninf,ntau;
Cutrates_km (   v,gbar_km,tha_km,qa_km,Ra_km,Rb_km,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0 ) ) ) / ntau ) - n) ;
}
__device__ void CuDerivModel_kv(MYFTYPE dt, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv){

MYFTYPE a,b,ninf,ntau;
Cutrates_kv (   v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv,a,b,ninf,ntau);
    n = n + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / ntau)))*(- ( ( ( ninf ) ) / ntau ) / ( ( ( ( - 1.0 ) ) ) / ntau ) - n) ;
}
__device__ void CuDerivModel_na(MYFTYPE dt, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na){

MYFTYPE hinf,htau,minf,mtau;
Cutrates_na (   v + vshift_na,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na,hinf,htau,minf,mtau);
    m = m + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / mtau)))*(- ( ( ( minf ) ) / mtau ) / ( ( ( ( - 1.0 ) ) ) / mtau ) - m) ;
    h = h + (1. - exp(dt*(( ( ( - 1.0 ) ) ) / htau)))*(- ( ( ( hinf ) ) / htau ) / ( ( ( ( - 1.0 ) ) ) / htau ) - h) ;
}

// Breaks:


__device__ void CuBreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca) {
MYFTYPE hinf, htau, gca, minf, mtau;
MYFTYPE ;
MYFTYPE ica_ca;

   gca = tadj_ca * gbar_ca * m * m * h ;
   ica_ca = ( 1e-4 ) * gca * ( v - eca ) ;
sumCurrents+= ica_ca;

 ica += ica_ca;
sumConductivity+= gca;
};


__device__ void CuBreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca) {
MYFTYPE gca;
MYFTYPE ;
};


__device__ void CuBreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca) {
MYFTYPE gca, gk, ninf, ntau;
MYFTYPE ik;
   gk = tadj_kca * gbar_kca * n ;
   ik = ( 1e-4 ) * gk * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gk;
};


__device__ void CuBreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km) {
MYFTYPE gk, ninf, ntau;
MYFTYPE ik;
   gk = tadj_km * gbar_km * n ;
   ik = ( 1e-4 ) * gk * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gk;
};


__device__ void CuBreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv) {
MYFTYPE gk, ninf, ntau;
MYFTYPE ik;
   gk = tadj_kv * gbar_kv * n ;
   ik = ( 1e-4 ) * gk * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gk;
};


__device__ void CuBreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na) {
MYFTYPE hinf, htau, gna, minf, mtau;
MYFTYPE ina;
   gna = tadj_na * gbar_na * m * m * m * h ;
   ina = ( 1e-4 ) * gna * ( v - ena ) ;
sumCurrents+= ina;
sumConductivity+= gna;
};


__device__ void CuBreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) {
MYFTYPE;
MYFTYPE i;
   i = g_pas * ( v - e_pas ) ;
i = i;

sumCurrents+= i;
sumConductivity+= g_pas;
};


__device__ void CuBreakpointModel_pas2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas2,MYFTYPE e_pas2) {
MYFTYPE;
MYFTYPE i;
   i = g_pas2 * ( v - e_pas2 ) ;
i = i;

sumCurrents+= i;
};


__device__ void CuBreakpointModel_pasx(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pasx,MYFTYPE e_pasx) {
MYFTYPE;
MYFTYPE i;
   i = g_pasx * ( v - e_pasx ) ;
i = i;

sumCurrents+= i;
};
