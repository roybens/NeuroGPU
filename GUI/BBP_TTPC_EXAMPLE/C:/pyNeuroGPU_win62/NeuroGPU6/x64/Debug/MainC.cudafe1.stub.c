#define __NV_MODULE_ID _13_MainC_cpp1_ii_debugFN
#define __NV_CUBIN_HANDLE_STORAGE__ extern
#if !defined(__CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__)
#define __CUDA_INCLUDE_COMPILER_INTERNAL_HEADERS__
#endif
#include "crt/host_runtime.h"
#include "MainC.fatbin.c"
static void __nv_cudaEntityRegisterCallback(void **);
static void __sti____cudaRegisterAll(void);
#pragma section(".CRT$XCU",read)
__declspec(allocate(".CRT$XCU"))static void (*__dummy_static_init__sti____cudaRegisterAll[])(void) = {__sti____cudaRegisterAll};
static void __nv_cudaEntityRegisterCallback(
void **__T0)
{
__nv_dummy_param_ref(__T0);
__nv_save_fatbinhandle_for_managed_rt(__T0);
}
static void __sti____cudaRegisterAll(void)
{
____cudaRegisterLinkedBinary(__nv_cudaEntityRegisterCallback);
}
