#include <stdio.h>
#include "hocdec.h"
#define IMPORT extern __declspec(dllimport)
IMPORT int nrnmpi_myid, nrn_nobanner_;

extern void _branching_reg();
extern void _ca_reg();
extern void _cad_reg();
extern void _kca_reg();
extern void _km_reg();
extern void _kv_reg();
extern void _na_reg();
extern void _passive_reg();
extern void _pasx_reg();

void modl_reg(){
	//nrn_mswindll_stdio(stdin, stdout, stderr);
    if (!nrn_nobanner_) if (nrnmpi_myid < 1) {
	fprintf(stderr, "Additional mechanisms from files\n");

fprintf(stderr," branching.mod");
fprintf(stderr," ca.mod");
fprintf(stderr," cad.mod");
fprintf(stderr," kca.mod");
fprintf(stderr," km.mod");
fprintf(stderr," kv.mod");
fprintf(stderr," na.mod");
fprintf(stderr," passive.mod");
fprintf(stderr," pasx.mod");
fprintf(stderr, "\n");
    }
_branching_reg();
_ca_reg();
_cad_reg();
_kca_reg();
_km_reg();
_kv_reg();
_na_reg();
_passive_reg();
_pasx_reg();
}
