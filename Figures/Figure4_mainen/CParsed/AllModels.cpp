// Automatically generated C for C:\Users\Maxwell Chen\Desktop\NeuroGPU\Figures\Figure4_mainen./runModel.hoc
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "AllModels.h"

// Universals:
#define PI (3.1415927f)
#define R (8.31441f)
#define FARADAY (96485.309f)
#define ktf (1000.*8.3134*(celsius + 273.15)/FARADAY)

// Reversals:
#define ena (60.0f)
#define ek (-90.0f)
#define DEF_cai		5.e-5	   /* mM */
#define DEF_cao		2.	   /* mM */

// Locals:
MYFTYPE a,b,drive_channel,gca,gk,gna,hinf,htau,minf,mtau,ninf,ntau,vi;

// Ion currents as Locals:
MYFTYPE ina,ica,ik;

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

// Declarations:
void trates_ca(MYFTYPE v ,MYFTYPE gbar_ca,MYFTYPE cao_ca);
void rates_ca(MYFTYPE vm ,MYFTYPE gbar_ca,MYFTYPE cao_ca);
void rates_kca(MYFTYPE cai,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca);
void trates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km);
void rates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km);
void trates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv);
void rates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv);
void trates_na(MYFTYPE v,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na);
void rates_na(MYFTYPE vm,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na);

// Functions:
MYFTYPE efun_ca(MYFTYPE z){
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
MYFTYPE efun_km(MYFTYPE z){
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
MYFTYPE efun_kv(MYFTYPE z){
	if (fabs(z) < 1e-4) {;
		return  1 - z/2;
	}else{;
		return  z/(exp(z) - 1);
	};
};
MYFTYPE trap0_na(MYFTYPE v,MYFTYPE th,MYFTYPE a,MYFTYPE q){
	if (fabs((v-th)/q) > 1e-6) {;
	        return  a * (v - th) / (1 - exp(-(v - th)/q));
	} else {;
	        return  a * q;
	};
}	;

// Inits:


void InitModel_ca(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca){
eca = DEF_eca2;
eca =DEF_eca2;
   /* removed tadj_ca recalculation */
	trates_ca(v+vshift_ca,gbar_ca,cao_ca);
	m = minf;
	h = hinf;
};


void InitModel_cad(MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca){
cai = DEF_cai;
eca = ktf/2 *log(DEF_cao / cai);
	ca = cainf_cad;
	cai = ca;
};


void InitModel_kca(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca){
eca =DEF_eca2;
	rates_kca(cai,gbar_kca,caix_kca,Ra_kca,Rb_kca);
	n = ninf;
};


void InitModel_km(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km){
   /* removed tadj_km recalculation */
	trates_km(v,gbar_km,tha_km,qa_km,Ra_km,Rb_km);
	n = ninf;
};


void InitModel_kv(MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv){
   /* removed tadj_kv recalculation */
	trates_kv(v,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv);
	n = ninf;
};


void InitModel_na(MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na){
   /* removed tadj_na recalculation */
	trates_na(v+vshift_na,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na);
	m = minf;
	h = hinf;
};


void InitModel_pas(MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas){
};


void InitModel_pas2(MYFTYPE v,MYFTYPE g_pas2,MYFTYPE e_pas2){
};


void InitModel_pasx(MYFTYPE v,MYFTYPE g_pasx,MYFTYPE e_pasx){
};

// Procedures:
void trates_ca(MYFTYPE v ,MYFTYPE gbar_ca,MYFTYPE cao_ca) {
   rates_ca (   v ,gbar_ca,cao_ca) ;
}
void rates_ca(MYFTYPE vm ,MYFTYPE gbar_ca,MYFTYPE cao_ca) {
   MYFTYPE a , b ;
/* removed tadj_ca recalculation */
   a = 0.209 * efun_ca (   - ( 27.0 + vm ) / 3.8 ) ;
   b = 0.94 * exp ( ( - 75.0 - vm ) / 17.0 ) ;
   mtau = 1.0 / tadj_ca / ( a + b ) ;
   minf = a / ( a + b ) ;
   a = 0.000457 * exp ( ( - 13.0 - vm ) / 50.0 ) ;
   b = 0.0065 / ( exp ( ( - vm - 15.0 ) / 28.0 ) + 1.0 ) ;
   htau = 1.0 / tadj_ca / ( a + b ) ;
   hinf = a / ( a + b ) ;
}
void rates_kca(MYFTYPE cai,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca) {
   a = Ra_kca * powf( cai , caix_kca ) ;
   b = Rb_kca ;
  /* removed tadj_kca recalculation */
   ntau = 1.0 / tadj_kca / ( a + b ) ;
   ninf = a / ( a + b ) ;
}
void trates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km) {
   rates_km (   v ,gbar_km,tha_km,qa_km,Ra_km,Rb_km) ;
}
void rates_km(MYFTYPE v ,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km) {
   a = Ra_km * qa_km * efun_km (   - ( v - tha_km ) / qa_km ) ;
   b = Rb_km * qa_km * efun_km (   ( v - tha_km ) / qa_km ) ;
  /* removed tadj_km recalculation */
   ntau = 1.0 / tadj_km / ( a + b ) ;
   ninf = a / ( a + b ) ;
}
void trates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv) {
   rates_kv (   v ,gbar_kv,tha_kv,qa_kv,Ra_kv,Rb_kv) ;
}
void rates_kv(MYFTYPE v ,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv) {
   a = Ra_kv * qa_kv * efun_kv (   - ( v - tha_kv ) / qa_kv ) ;
   b = Rb_kv * qa_kv * efun_kv (   ( v - tha_kv ) / qa_kv ) ;
  /* removed tadj_kv recalculation */
   ntau = 1.0 / tadj_kv / ( a + b ) ;
   ninf = a / ( a + b ) ;
}
void trates_na(MYFTYPE v,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na) {
   rates_na (   v ,gbar_na,tha_na,qa_na,Ra_na,Rb_na,thi1_na,thi2_na,qi_na,thinf_na,qinf_na,Rg_na,Rd_na) ;
}
void rates_na(MYFTYPE vm,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na) {
   MYFTYPE a , b ;
 a = trap0_na (   vm , tha_na , Ra_na , qa_na ) ;
   b = trap0_na (   - vm , - tha_na , Rb_na , qa_na ) ;
  /* removed tadj_na recalculation */
   mtau = 1.0 / tadj_na / ( a + b ) ;
   minf = a / ( a + b ) ;
   a = trap0_na (   vm , thi1_na , Rd_na , qi_na ) ;
   b = trap0_na (   - vm , - thi2_na , Rg_na , qi_na ) ;
   htau = 1.0 / tadj_na / ( a + b ) ;
   hinf = 1.0 / ( 1.0 + exp ( ( vm - thinf_na ) / qinf_na ) ) ;
}

// Derivs:

// Breaks:


void BreakpointModel_ca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_ca,MYFTYPE cao_ca, MYFTYPE cai, MYFTYPE &ica,MYFTYPE &eca) {
MYFTYPE ica_ca;

   gca = tadj_ca * gbar_ca * m * m * h ;
   ica_ca = ( 1e-4 ) * gca * ( v - eca ) ;
sumCurrents+= ica_ca;

 ica += ica_ca;
sumConductivity+= gca;
};


void BreakpointModel_cad(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &ca, MYFTYPE ica, MYFTYPE &cai,MYFTYPE &eca) {
};


void BreakpointModel_kca(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kca,MYFTYPE caix_kca,MYFTYPE Ra_kca,MYFTYPE Rb_kca, MYFTYPE cai,MYFTYPE &eca) {
   gk = tadj_kca * gbar_kca * n ;
   ik = ( 1e-4 ) * gk * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gk;
};


void BreakpointModel_km(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_km,MYFTYPE tha_km,MYFTYPE qa_km,MYFTYPE Ra_km,MYFTYPE Rb_km) {
   gk = tadj_km * gbar_km * n ;
   ik = ( 1e-4 ) * gk * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gk;
};


void BreakpointModel_kv(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &n,MYFTYPE gbar_kv,MYFTYPE tha_kv,MYFTYPE qa_kv,MYFTYPE Ra_kv,MYFTYPE Rb_kv) {
   gk = tadj_kv * gbar_kv * n ;
   ik = ( 1e-4 ) * gk * ( v - ek ) ;
sumCurrents+= ik;
sumConductivity+= gk;
};


void BreakpointModel_na(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE &m,MYFTYPE &h,MYFTYPE gbar_na,MYFTYPE tha_na,MYFTYPE qa_na,MYFTYPE Ra_na,MYFTYPE Rb_na,MYFTYPE thi1_na,MYFTYPE thi2_na,MYFTYPE qi_na,MYFTYPE thinf_na,MYFTYPE qinf_na,MYFTYPE Rg_na,MYFTYPE Rd_na) {
   gna = tadj_na * gbar_na * m * m * m * h ;
   ina = ( 1e-4 ) * gna * ( v - ena ) ;
sumCurrents+= ina;
sumConductivity+= gna;
};


void BreakpointModel_pas(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas,MYFTYPE e_pas) {
   i = g_pas * ( v - e_pas ) ;
i = i;

sumCurrents+= i;
sumConductivity+= g_pas;
};


void BreakpointModel_pas2(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pas2,MYFTYPE e_pas2) {
   i = g_pas2 * ( v - e_pas2 ) ;
i = i;

sumCurrents+= i;
};


void BreakpointModel_pasx(MYSECONDFTYPE &sumCurrents, MYFTYPE &sumConductivity, MYFTYPE v,MYFTYPE g_pasx,MYFTYPE e_pasx) {
   i = g_pasx * ( v - e_pasx ) ;
i = i;

sumCurrents+= i;
};
