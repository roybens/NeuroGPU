#define __NV_MODULE_ID _12_Util_cpp1_ii_b6b78192
#define __NV_CUBIN_HANDLE_STORAGE__ extern
#include "crt/host_runtime.h"
#include "Util.fatbin.c"
static void __nv_cudaEntityRegisterCallback(void **);
static void __sti____cudaRegisterAll_12_Util_cpp1_ii_b6b78192(void);
#pragma section(".CRT$XCU",read,write)
__declspec(allocate(".CRT$XCU"))static void (*__dummy_static_init__sti____cudaRegisterAll_12_Util_cpp1_ii_b6b78192[])(void) = {__sti____cudaRegisterAll_12_Util_cpp1_ii_b6b78192};
static void __nv_cudaEntityRegisterCallback(void **__T20){__nv_dummy_param_ref(__T20);__nv_save_fatbinhandle_for_managed_rt(__T20);}
static void __sti____cudaRegisterAll_12_Util_cpp1_ii_b6b78192(void){____cudaRegisterLinkedBinary(__nv_cudaEntityRegisterCallback);}
