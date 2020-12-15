#include <cstdio>
namespace coreneuron {
extern int nrnmpi_myid;
extern int nrn_nobanner_;
extern int _exp2syn_reg(void),
  _expsyn_reg(void),
  _hh_reg(void),
  _netstim_reg(void),
  _passive_reg(void),
  _pattern_reg(void),
  _stim_reg(void),
  _svclmp_reg(void);

void modl_reg() {
    if (!nrn_nobanner_ && nrnmpi_myid < 1) {
        fprintf(stderr, " Additional mechanisms from files\n");
        fprintf(stderr, " exp2syn.mod");
        fprintf(stderr, " expsyn.mod");
        fprintf(stderr, " hh.mod");
        fprintf(stderr, " netstim.mod");
        fprintf(stderr, " passive.mod");
        fprintf(stderr, " pattern.mod");
        fprintf(stderr, " stim.mod");
        fprintf(stderr, " svclmp.mod");
        fprintf(stderr, "\n\n");
    }

    _exp2syn_reg();
    _expsyn_reg();
    _hh_reg();
    _netstim_reg();
    _passive_reg();
    _pattern_reg();
    _stim_reg();
    _svclmp_reg();
}
} //namespace coreneuron
