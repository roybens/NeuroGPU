#line 1 "x64/Release/MainC.cudafe1.gpu"
typedef char __nv_bool;
#line 461 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt.h"
struct __crt_locale_pointers;
#line 54 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
enum cudaDataType_t {
#line 56 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_R_16F = 2,
#line 57 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_C_16F = 6,
#line 58 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_R_32F = 0,
#line 59 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_C_32F = 4,
#line 60 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_R_64F = 1,
#line 61 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_C_64F = 5,
#line 62 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_R_8I = 3,
#line 63 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_C_8I = 7,
#line 64 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_R_8U,
#line 65 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_C_8U,
#line 66 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_R_32I,
#line 67 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_C_32I,
#line 68 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_R_32U,
#line 69 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
CUDA_C_32U};
#line 73 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
enum libraryPropertyType_t {
#line 75 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
MAJOR_VERSION,
#line 76 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
MINOR_VERSION,
#line 77 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\library_types.h"
PATCH_LEVEL};
#line 25 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_wstdio.h"
struct _iobuf;
#line 29 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\locale.h"
struct lconv;
#line 70 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo.h"
struct _Cvtvec;
#line 66 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
struct HMat;
#line 111 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
struct Stim;
#line 126 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
struct Sim;
#line 72 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseStatus_t {
#line 73 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_SUCCESS,
#line 74 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_NOT_INITIALIZED,
#line 75 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_ALLOC_FAILED,
#line 76 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_INVALID_VALUE,
#line 77 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_ARCH_MISMATCH,
#line 78 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_MAPPING_ERROR,
#line 79 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_EXECUTION_FAILED,
#line 80 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_INTERNAL_ERROR,
#line 81 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_MATRIX_TYPE_NOT_SUPPORTED,
#line 82 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_STATUS_ZERO_PIVOT};
#line 138 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparsePointerMode_t {
#line 139 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_POINTER_MODE_HOST,
#line 140 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_POINTER_MODE_DEVICE};
#line 143 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseAction_t {
#line 144 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_ACTION_SYMBOLIC,
#line 145 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_ACTION_NUMERIC};
#line 148 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseMatrixType_t {
#line 149 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_MATRIX_TYPE_GENERAL,
#line 150 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_MATRIX_TYPE_SYMMETRIC,
#line 151 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_MATRIX_TYPE_HERMITIAN,
#line 152 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_MATRIX_TYPE_TRIANGULAR};
#line 155 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseFillMode_t {
#line 156 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_FILL_MODE_LOWER,
#line 157 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_FILL_MODE_UPPER};
#line 160 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseDiagType_t {
#line 161 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_DIAG_TYPE_NON_UNIT,
#line 162 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_DIAG_TYPE_UNIT};
#line 165 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseIndexBase_t {
#line 166 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_INDEX_BASE_ZERO,
#line 167 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_INDEX_BASE_ONE};
#line 170 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseOperation_t {
#line 171 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_OPERATION_NON_TRANSPOSE,
#line 172 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_OPERATION_TRANSPOSE,
#line 173 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_OPERATION_CONJUGATE_TRANSPOSE};
#line 176 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseDirection_t {
#line 177 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_DIRECTION_ROW,
#line 178 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_DIRECTION_COLUMN};
#line 181 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseHybPartition_t {
#line 182 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_HYB_PARTITION_AUTO,
#line 183 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_HYB_PARTITION_USER,
#line 184 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_HYB_PARTITION_MAX};
#line 188 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseSolvePolicy_t {
#line 189 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_SOLVE_POLICY_NO_LEVEL,
#line 190 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_SOLVE_POLICY_USE_LEVEL};
#line 193 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseSideMode_t {
#line 194 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_SIDE_LEFT,
#line 195 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_SIDE_RIGHT};
#line 198 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseColorAlg_t {
#line 199 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_COLOR_ALG0,
#line 200 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_COLOR_ALG1};
#line 203 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
enum cusparseAlgMode_t {
#line 204 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_ALG0,
#line 205 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\cusparse.h"
CUSPARSE_ALG1};
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
enum _ZN27__vcrt_va_list_is_referenceIKP21__crt_locale_pointersEUt_E {
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
_ZN27__vcrt_va_list_is_referenceIKP21__crt_locale_pointersE11__the_valueE};
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
enum _ZN27__vcrt_va_list_is_referenceIKPKwEUt_E {
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
_ZN27__vcrt_va_list_is_referenceIKPKwE11__the_valueE};
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
enum _ZN27__vcrt_va_list_is_referenceIPKwEUt_E {
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
_ZN27__vcrt_va_list_is_referenceIPKwE11__the_valueE};
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
enum _ZN27__vcrt_va_list_is_referenceIP21__crt_locale_pointersEUt_E {
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
_ZN27__vcrt_va_list_is_referenceIP21__crt_locale_pointersE11__the_valueE};
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
enum _ZN27__vcrt_va_list_is_referenceIKPKcEUt_E {
#line 127 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
_ZN27__vcrt_va_list_is_referenceIKPKcE11__the_valueE};
#line 612 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\yvals.h"
enum _ZSt14_Uninitialized {
#line 614 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\yvals.h"
_ZSt7_Noinit};
#line 621 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\yvals.h"
struct _ZSt7_Lockit;
#line 53 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
enum _ZSt18float_denorm_style {
#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt20denorm_indeterminate = (-1),
#line 55 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt13denorm_absent,
#line 56 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt14denorm_present};
#line 61 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
enum _ZSt17float_round_style {
#line 62 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt19round_indeterminate = (-1),
#line 63 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt17round_toward_zero,
#line 64 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt16round_to_nearest,
#line 65 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt21round_toward_infinity,
#line 66 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\limits"
_ZSt25round_toward_neg_infinity};
#line 505 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\iosfwd"
struct _ZSt11char_traitsIcE;
#line 15 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
enum _ZSt12memory_order {
#line 16 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
_ZSt20memory_order_relaxed,
#line 17 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
_ZSt20memory_order_consume,
#line 18 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
_ZSt20memory_order_acquire,
#line 19 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
_ZSt20memory_order_release,
#line 20 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
_ZSt20memory_order_acq_rel,
#line 21 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
_ZSt20memory_order_seq_cst};
#line 612 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\iosfwd"
struct _ZSaIcE;
#line 502 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIcEEUt_E {
#line 503 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIcEE9_BUF_SIZEE = 16};
#line 506 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIcEEUt0_E {
#line 507 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIcEE11_ALLOC_MASKE = 15};
#line 567 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIcSaIcEEEUt_E {
#line 568 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIcSaIcEEE9_BUF_SIZEE = 16};
#line 572 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIcSaIcEEEUt0_E {
#line 573 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIcSaIcEEE11_ALLOC_MASKE = 15};
#line 750 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
struct _ZSs;
#line 3713 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
struct _ZSt5_YarnIcE;
#line 3713 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
struct _ZSt5_YarnIwE;
#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt8_Locinfo;
#line 20 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xfacet"
struct _ZSt11_Facet_base;
#line 61 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZSt15_Crt_new_delete;
#line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZSt8_LocbaseIiE;
#line 105 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZNSt6locale2idE;
#line 138 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZNSt6locale5facetE;
#line 183 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZNSt6locale7_LocimpE;
#line 98 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZSt6locale;
#line 821 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
enum _ZNSt12codecvt_baseUt_E {
#line 822 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt12codecvt_base2okE,
#line 822 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt12codecvt_base7partialE,
#line 822 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt12codecvt_base5errorE,
#line 822 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt12codecvt_base6noconvE};
#line 997 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
enum _ZSt13_Codecvt_mode {
#line 998 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZSt15_Consume_header = 4,
#line 999 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZSt16_Generate_header = 2};
#line 2093 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
enum _ZNSt10ctype_baseUt_E {
#line 2094 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5alnumE = 263,
#line 2094 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5alphaE = 259,
#line 2095 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5cntrlE = 32,
#line 2095 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5digitE = 4,
#line 2095 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5graphE = 279,
#line 2096 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5lowerE = 2,
#line 2096 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5printE = 471,
#line 2097 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5punctE = 16,
#line 2097 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5spaceE = 72,
#line 2097 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5upperE = 1,
#line 2098 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base6xdigitE = 128,
#line 2098 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZNSt10ctype_base5blankE = 72};
#line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
enum _ZSt4errc {
#line 25 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc28address_family_not_supportedE = 102,
#line 26 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14address_in_useE = 100,
#line 27 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc21address_not_availableE,
#line 28 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc17already_connectedE = 113,
#line 29 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc22argument_list_too_longE = 7,
#line 30 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc22argument_out_of_domainE = 33,
#line 31 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc11bad_addressE = 14,
#line 32 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc19bad_file_descriptorE = 9,
#line 33 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc11bad_messageE = 104,
#line 34 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc11broken_pipeE = 32,
#line 35 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc18connection_abortedE = 106,
#line 36 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc30connection_already_in_progressE = 103,
#line 37 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc18connection_refusedE = 107,
#line 38 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc16connection_resetE,
#line 39 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc17cross_device_linkE = 18,
#line 40 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc28destination_address_requiredE = 109,
#line 41 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc23device_or_resource_busyE = 16,
#line 42 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc19directory_not_emptyE = 41,
#line 43 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc23executable_format_errorE = 8,
#line 44 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc11file_existsE = 17,
#line 45 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14file_too_largeE = 27,
#line 46 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc17filename_too_longE = 38,
#line 47 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc22function_not_supportedE = 40,
#line 48 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc16host_unreachableE = 110,
#line 49 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc18identifier_removedE,
#line 50 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc21illegal_byte_sequenceE = 42,
#line 51 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc34inappropriate_io_control_operationE = 25,
#line 52 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc11interruptedE = 4,
#line 53 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc16invalid_argumentE = 22,
#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc12invalid_seekE = 29,
#line 55 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc8io_errorE = 5,
#line 56 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14is_a_directoryE = 21,
#line 57 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc12message_sizeE = 115,
#line 58 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc12network_downE,
#line 59 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc13network_resetE,
#line 60 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc19network_unreachableE,
#line 61 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc15no_buffer_spaceE,
#line 62 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc16no_child_processE = 10,
#line 63 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc7no_linkE = 121,
#line 64 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc17no_lock_availableE = 39,
#line 65 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc20no_message_availableE = 120,
#line 66 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc10no_messageE = 122,
#line 67 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc18no_protocol_optionE,
#line 68 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc18no_space_on_deviceE = 28,
#line 69 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc19no_stream_resourcesE = 124,
#line 70 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc25no_such_device_or_addressE = 6,
#line 71 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14no_such_deviceE = 19,
#line 72 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc25no_such_file_or_directoryE = 2,
#line 73 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc15no_such_processE,
#line 74 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc15not_a_directoryE = 20,
#line 75 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc12not_a_socketE = 128,
#line 76 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc12not_a_streamE = 125,
#line 77 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc13not_connectedE,
#line 78 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc17not_enough_memoryE = 12,
#line 79 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc13not_supportedE = 129,
#line 80 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc18operation_canceledE = 105,
#line 81 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc21operation_in_progressE = 112,
#line 82 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc23operation_not_permittedE = 1,
#line 83 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc23operation_not_supportedE = 130,
#line 84 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc21operation_would_blockE = 140,
#line 85 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc10owner_deadE = 133,
#line 86 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc17permission_deniedE = 13,
#line 87 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14protocol_errorE = 134,
#line 88 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc22protocol_not_supportedE,
#line 89 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc21read_only_file_systemE = 30,
#line 90 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc29resource_deadlock_would_occurE = 36,
#line 91 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc30resource_unavailable_try_againE = 11,
#line 92 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc19result_out_of_rangeE = 34,
#line 93 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc21state_not_recoverableE = 127,
#line 94 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14stream_timeoutE = 137,
#line 95 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14text_file_busyE = 139,
#line 96 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc9timed_outE = 138,
#line 97 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc29too_many_files_open_in_systemE = 23,
#line 98 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc19too_many_files_openE,
#line 99 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc14too_many_linksE = 31,
#line 100 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc29too_many_symbolic_link_levelsE = 114,
#line 101 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc15value_too_largeE = 132,
#line 102 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt4errc19wrong_protocol_typeE = 136};
#line 109 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
enum _ZSt7io_errc {
#line 110 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt7io_errc6streamE = 1};
#line 211 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
enum _ZNSt14error_categoryUt_E {
#line 213 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt14error_category12_Future_addrE = 1ULL,
#line 214 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt14error_category13_Generic_addrE = 3ULL,
#line 215 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt14error_category14_Iostream_addrE = 5ULL,
#line 216 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\system_error"
_ZNSt14error_category12_System_addrE = 7ULL};
#line 51 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
enum _ZNSt5_IosbIiE11_Dummy_enumE {
#line 51 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE15_Dummy_enum_valE = 1};
#line 52 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
enum _ZNSt5_IosbIiE9_FmtflagsE {
#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE8_FmtmaskE = 65535,
#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE8_FmtzeroE = 0};
#line 83 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
enum _ZNSt5_IosbIiE8_IostateE {
#line 85 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE9_StatmaskE = 23};
#line 92 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
enum _ZNSt5_IosbIiE9_OpenmodeE {
#line 94 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE9_OpenmaskE = 255};
#line 105 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
enum _ZNSt5_IosbIiE8_SeekdirE {
#line 107 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE8_SeekbegE,
#line 108 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE8_SeekcurE,
#line 109 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE8_SeekendE};
#line 117 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
enum _ZNSt5_IosbIiEUt_E {
#line 118 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt5_IosbIiE9_OpenprotE = 64};
#line 213 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
enum _ZNSt8ios_base5eventE {
#line 215 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt8ios_base11erase_eventE,
#line 215 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt8ios_base11imbue_eventE,
#line 215 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xiosbase"
_ZNSt8ios_base13copyfmt_eventE};
#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
struct _ZSt8numpunctIcE;
#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
struct _ZSt8numpunctIwE;
#line 502 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIwEEUt_E {
#line 503 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIwEE9_BUF_SIZEE = 8};
#line 506 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIwEEUt0_E {
#line 507 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIwEE11_ALLOC_MASKE = 7};
#line 567 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIwSaIwEEEUt_E {
#line 568 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIwSaIwEEE9_BUF_SIZEE = 8};
#line 572 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIwSaIwEEEUt0_E {
#line 573 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIwSaIwEEE11_ALLOC_MASKE = 7};
#line 502 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIDsEEUt_E {
#line 503 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIDsEE9_BUF_SIZEE = 8};
#line 506 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIDsEEUt0_E {
#line 507 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIDsEE11_ALLOC_MASKE = 7};
#line 567 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIDsSaIDsEEEUt_E {
#line 568 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIDsSaIDsEEE9_BUF_SIZEE = 8};
#line 572 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIDsSaIDsEEEUt0_E {
#line 573 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIDsSaIDsEEE11_ALLOC_MASKE = 7};
#line 502 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIDiEEUt_E {
#line 503 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIDiEE9_BUF_SIZEE = 4};
#line 506 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt11_String_valISt13_Simple_typesIDiEEUt0_E {
#line 507 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt11_String_valISt13_Simple_typesIDiEE11_ALLOC_MASKE = 3};
#line 567 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIDiSaIDiEEEUt_E {
#line 568 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIDiSaIDiEEE9_BUF_SIZEE = 4};
#line 572 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
enum _ZNSt13_String_allocISt18_String_base_typesIDiSaIDiEEEUt0_E {
#line 573 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
_ZNSt13_String_allocISt18_String_base_typesIDiSaIDiEEE11_ALLOC_MASKE = 3};
#line 194 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vcruntime.h"
typedef unsigned long long size_t;
#line 1 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"





































#line 1 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"


























































































#line 92 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"










#line 103 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"








































#line 144 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"








#line 155 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"



#line 159 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"








#line 168 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"




#line 173 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"










#line 185 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"













        





#line 205 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"








#line 214 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"
























#line 239 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"


#line 242 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\host_defines.h"
#line 39 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"





typedef __declspec(__device_builtin_texture_type__) unsigned long long __texture_type__;
typedef __declspec(__device_builtin_surface_type__) unsigned long long __surface_type__;



#line 50 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"






































































































#line 153 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"






































extern __declspec(__device__) void* malloc(size_t);
extern __declspec(__device__) void free(void*);
static __declspec(__device__) void __nv_sized_free(void *p, size_t sz) { free(p); }
static __declspec(__device__) void __nv_sized_array_free(void *p, size_t sz) { free(p); }







#line 203 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"

extern __declspec(__device__) void __assertfail(
  const void  *message,
  const void  *file,
  unsigned int line,
  const void  *function,
  size_t       charsize);















#line 226 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"













#line 240 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"













#line 254 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"













#line 268 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"
static __declspec(__device__) void _wassert(
  const unsigned short *_Message,
  const unsigned short *_File,
  unsigned              _Line)
{
  __assertfail(
    (const void *)_Message,
    (const void *)_File,
                  _Line,
    (const void *)0,
    sizeof(unsigned short));
}
#line 281 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"

#line 283 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"

#line 1 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\builtin_types.h"























































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\device_types.h"




















































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\host_defines.h"
















































































































































































































































#line 242 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\host_defines.h"
#line 54 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\device_types.h"







enum __declspec(__device_builtin__) cudaRoundMode
{
    cudaRoundNearest,
    cudaRoundZero,
    cudaRoundPosInf,
    cudaRoundMinInf
};

#line 70 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\device_types.h"
#line 57 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\builtin_types.h"


#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"




















































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\host_defines.h"
















































































































































































































































#line 242 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\host_defines.h"
#line 54 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"



























































































#line 146 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"










enum __declspec(__device_builtin__) cudaError
{
    




    cudaSuccess                           =      0,
  
    



    cudaErrorMissingConfiguration         =      1,
  
    



    cudaErrorMemoryAllocation             =      2,
  
    



    cudaErrorInitializationError          =      3,
  
    







    cudaErrorLaunchFailure                =      4,
  
    






    cudaErrorPriorLaunchFailure           =      5,
  
    








    cudaErrorLaunchTimeout                =      6,
  
    






    cudaErrorLaunchOutOfResources         =      7,
  
    



    cudaErrorInvalidDeviceFunction        =      8,
  
    






    cudaErrorInvalidConfiguration         =      9,
  
    



    cudaErrorInvalidDevice                =     10,
  
    



    cudaErrorInvalidValue                 =     11,
  
    



    cudaErrorInvalidPitchValue            =     12,
  
    



    cudaErrorInvalidSymbol                =     13,
  
    


    cudaErrorMapBufferObjectFailed        =     14,
  
    


    cudaErrorUnmapBufferObjectFailed      =     15,
  
    



    cudaErrorInvalidHostPointer           =     16,
  
    



    cudaErrorInvalidDevicePointer         =     17,
  
    



    cudaErrorInvalidTexture               =     18,
  
    



    cudaErrorInvalidTextureBinding        =     19,
  
    




    cudaErrorInvalidChannelDescriptor     =     20,
  
    



    cudaErrorInvalidMemcpyDirection       =     21,
  
    







    cudaErrorAddressOfConstant            =     22,
  
    






    cudaErrorTextureFetchFailed           =     23,
  
    






    cudaErrorTextureNotBound              =     24,
  
    






    cudaErrorSynchronizationError         =     25,
  
    



    cudaErrorInvalidFilterSetting         =     26,
  
    



    cudaErrorInvalidNormSetting           =     27,
  
    





    cudaErrorMixedDeviceExecution         =     28,
  
    




    cudaErrorCudartUnloading              =     29,
  
    


    cudaErrorUnknown                      =     30,

    





    cudaErrorNotYetImplemented            =     31,
  
    






    cudaErrorMemoryValueTooLarge          =     32,
  
    




    cudaErrorInvalidResourceHandle        =     33,
  
    





    cudaErrorNotReady                     =     34,
  
    




    cudaErrorInsufficientDriver           =     35,
  
    










    cudaErrorSetOnActiveProcess           =     36,
  
    



    cudaErrorInvalidSurface               =     37,
  
    



    cudaErrorNoDevice                     =     38,
  
    



    cudaErrorECCUncorrectable             =     39,
  
    


    cudaErrorSharedObjectSymbolNotFound   =     40,
  
    


    cudaErrorSharedObjectInitFailed       =     41,
  
    



    cudaErrorUnsupportedLimit             =     42,
  
    



    cudaErrorDuplicateVariableName        =     43,
  
    



    cudaErrorDuplicateTextureName         =     44,
  
    



    cudaErrorDuplicateSurfaceName         =     45,
  
    







    cudaErrorDevicesUnavailable           =     46,
  
    


    cudaErrorInvalidKernelImage           =     47,
  
    





    cudaErrorNoKernelImageForDevice       =     48,
  
    










    cudaErrorIncompatibleDriverContext    =     49,
      
    




    cudaErrorPeerAccessAlreadyEnabled     =     50,
    
    




    cudaErrorPeerAccessNotEnabled         =     51,
    
    



    cudaErrorDeviceAlreadyInUse           =     54,

    




    cudaErrorProfilerDisabled             =     55,

    





    cudaErrorProfilerNotInitialized       =     56,

    




    cudaErrorProfilerAlreadyStarted       =     57,

    




     cudaErrorProfilerAlreadyStopped       =    58,

    





    cudaErrorAssert                        =    59,
  
    




    cudaErrorTooManyPeers                 =     60,
  
    



    cudaErrorHostMemoryAlreadyRegistered  =     61,
        
    



    cudaErrorHostMemoryNotRegistered      =     62,

    


    cudaErrorOperatingSystem              =     63,

    



    cudaErrorPeerAccessUnsupported        =     64,

    




    cudaErrorLaunchMaxDepthExceeded       =     65,

    





    cudaErrorLaunchFileScopedTex          =     66,

    





    cudaErrorLaunchFileScopedSurf         =     67,

    












    cudaErrorSyncDepthExceeded            =     68,

    









    cudaErrorLaunchPendingCountExceeded   =     69,
    
    


    cudaErrorNotPermitted                 =     70,

    



    cudaErrorNotSupported                 =     71,

    






    cudaErrorHardwareStackError           =     72,

    





    cudaErrorIllegalInstruction           =     73,

    






    cudaErrorMisalignedAddress            =     74,

    








    cudaErrorInvalidAddressSpace          =     75,

    





    cudaErrorInvalidPc                    =     76,

    





    cudaErrorIllegalAddress               =     77,

    



    cudaErrorInvalidPtx                   =     78,

    


    cudaErrorInvalidGraphicsContext       =     79,

    



    cudaErrorNvlinkUncorrectable          =     80,

    


    cudaErrorStartupFailure               =   0x7f,

    





    cudaErrorApiFailureBase               =  10000
};




enum __declspec(__device_builtin__) cudaChannelFormatKind
{
    cudaChannelFormatKindSigned           =   0,      
    cudaChannelFormatKindUnsigned         =   1,      
    cudaChannelFormatKindFloat            =   2,      
    cudaChannelFormatKindNone             =   3       
};




struct __declspec(__device_builtin__) cudaChannelFormatDesc
{
    int                        x; 
    int                        y; 
    int                        z; 
    int                        w; 
    enum cudaChannelFormatKind f; 
};




typedef struct cudaArray *cudaArray_t;




typedef const struct cudaArray *cudaArray_const_t;

struct cudaArray;




typedef struct cudaMipmappedArray *cudaMipmappedArray_t;




typedef const struct cudaMipmappedArray *cudaMipmappedArray_const_t;

struct cudaMipmappedArray;




enum __declspec(__device_builtin__) cudaMemoryType
{
    cudaMemoryTypeHost   = 1, 
    cudaMemoryTypeDevice = 2  
};




enum __declspec(__device_builtin__) cudaMemcpyKind
{
    cudaMemcpyHostToHost          =   0,      
    cudaMemcpyHostToDevice        =   1,      
    cudaMemcpyDeviceToHost        =   2,      
    cudaMemcpyDeviceToDevice      =   3,      
    cudaMemcpyDefault             =   4       
};






struct __declspec(__device_builtin__) cudaPitchedPtr
{
    void   *ptr;      
    size_t  pitch;    
    size_t  xsize;    
    size_t  ysize;    
};






struct __declspec(__device_builtin__) cudaExtent
{
    size_t width;     
    size_t height;    
    size_t depth;     
};






struct __declspec(__device_builtin__) cudaPos
{
    size_t x;     
    size_t y;     
    size_t z;     
};




struct __declspec(__device_builtin__) cudaMemcpy3DParms
{
    cudaArray_t            srcArray;  
    struct cudaPos         srcPos;    
    struct cudaPitchedPtr  srcPtr;    
  
    cudaArray_t            dstArray;  
    struct cudaPos         dstPos;    
    struct cudaPitchedPtr  dstPtr;    
  
    struct cudaExtent      extent;    
    enum cudaMemcpyKind    kind;      
};




struct __declspec(__device_builtin__) cudaMemcpy3DPeerParms
{
    cudaArray_t            srcArray;  
    struct cudaPos         srcPos;    
    struct cudaPitchedPtr  srcPtr;    
    int                    srcDevice; 
  
    cudaArray_t            dstArray;  
    struct cudaPos         dstPos;    
    struct cudaPitchedPtr  dstPtr;    
    int                    dstDevice; 
  
    struct cudaExtent      extent;    
};




struct cudaGraphicsResource;




enum __declspec(__device_builtin__) cudaGraphicsRegisterFlags
{
    cudaGraphicsRegisterFlagsNone             = 0,  
    cudaGraphicsRegisterFlagsReadOnly         = 1,   
    cudaGraphicsRegisterFlagsWriteDiscard     = 2,  
    cudaGraphicsRegisterFlagsSurfaceLoadStore = 4,  
    cudaGraphicsRegisterFlagsTextureGather    = 8   
};




enum __declspec(__device_builtin__) cudaGraphicsMapFlags
{
    cudaGraphicsMapFlagsNone         = 0,  
    cudaGraphicsMapFlagsReadOnly     = 1,  
    cudaGraphicsMapFlagsWriteDiscard = 2   
};




enum __declspec(__device_builtin__) cudaGraphicsCubeFace 
{
    cudaGraphicsCubeFacePositiveX = 0x00, 
    cudaGraphicsCubeFaceNegativeX = 0x01, 
    cudaGraphicsCubeFacePositiveY = 0x02, 
    cudaGraphicsCubeFaceNegativeY = 0x03, 
    cudaGraphicsCubeFacePositiveZ = 0x04, 
    cudaGraphicsCubeFaceNegativeZ = 0x05  
};




enum __declspec(__device_builtin__) cudaResourceType
{
    cudaResourceTypeArray          = 0x00, 
    cudaResourceTypeMipmappedArray = 0x01, 
    cudaResourceTypeLinear         = 0x02, 
    cudaResourceTypePitch2D        = 0x03  
};




enum __declspec(__device_builtin__) cudaResourceViewFormat
{
    cudaResViewFormatNone                      = 0x00, 
    cudaResViewFormatUnsignedChar1             = 0x01, 
    cudaResViewFormatUnsignedChar2             = 0x02, 
    cudaResViewFormatUnsignedChar4             = 0x03, 
    cudaResViewFormatSignedChar1               = 0x04, 
    cudaResViewFormatSignedChar2               = 0x05, 
    cudaResViewFormatSignedChar4               = 0x06, 
    cudaResViewFormatUnsignedShort1            = 0x07, 
    cudaResViewFormatUnsignedShort2            = 0x08, 
    cudaResViewFormatUnsignedShort4            = 0x09, 
    cudaResViewFormatSignedShort1              = 0x0a, 
    cudaResViewFormatSignedShort2              = 0x0b, 
    cudaResViewFormatSignedShort4              = 0x0c, 
    cudaResViewFormatUnsignedInt1              = 0x0d, 
    cudaResViewFormatUnsignedInt2              = 0x0e, 
    cudaResViewFormatUnsignedInt4              = 0x0f, 
    cudaResViewFormatSignedInt1                = 0x10, 
    cudaResViewFormatSignedInt2                = 0x11, 
    cudaResViewFormatSignedInt4                = 0x12, 
    cudaResViewFormatHalf1                     = 0x13, 
    cudaResViewFormatHalf2                     = 0x14, 
    cudaResViewFormatHalf4                     = 0x15, 
    cudaResViewFormatFloat1                    = 0x16, 
    cudaResViewFormatFloat2                    = 0x17, 
    cudaResViewFormatFloat4                    = 0x18, 
    cudaResViewFormatUnsignedBlockCompressed1  = 0x19, 
    cudaResViewFormatUnsignedBlockCompressed2  = 0x1a, 
    cudaResViewFormatUnsignedBlockCompressed3  = 0x1b, 
    cudaResViewFormatUnsignedBlockCompressed4  = 0x1c, 
    cudaResViewFormatSignedBlockCompressed4    = 0x1d, 
    cudaResViewFormatUnsignedBlockCompressed5  = 0x1e, 
    cudaResViewFormatSignedBlockCompressed5    = 0x1f, 
    cudaResViewFormatUnsignedBlockCompressed6H = 0x20, 
    cudaResViewFormatSignedBlockCompressed6H   = 0x21, 
    cudaResViewFormatUnsignedBlockCompressed7  = 0x22  
};




struct __declspec(__device_builtin__) cudaResourceDesc {
	enum cudaResourceType resType;             
	
	union {
		struct {
			cudaArray_t array;                 
		} array;
        struct {
            cudaMipmappedArray_t mipmap;       
        } mipmap;
		struct {
			void *devPtr;                      
			struct cudaChannelFormatDesc desc; 
			size_t sizeInBytes;                
		} linear;
		struct {
			void *devPtr;                      
			struct cudaChannelFormatDesc desc; 
			size_t width;                      
			size_t height;                     
			size_t pitchInBytes;               
		} pitch2D;
	} res;
};




struct __declspec(__device_builtin__) cudaResourceViewDesc
{
    enum cudaResourceViewFormat format;           
    size_t                      width;            
    size_t                      height;           
    size_t                      depth;            
    unsigned int                firstMipmapLevel; 
    unsigned int                lastMipmapLevel;  
    unsigned int                firstLayer;       
    unsigned int                lastLayer;        
};




struct __declspec(__device_builtin__) cudaPointerAttributes
{
    



    enum cudaMemoryType memoryType;

    








    int device;

    



    void *devicePointer;

    



    void *hostPointer;

    


    int isManaged;
};




struct __declspec(__device_builtin__) cudaFuncAttributes
{
   




   size_t sharedSizeBytes;

   



   size_t constSizeBytes;

   


   size_t localSizeBytes;

   




   int maxThreadsPerBlock;

   


   int numRegs;

   




   int ptxVersion;

   




   int binaryVersion;

   



   int cacheModeCA;
};




enum __declspec(__device_builtin__) cudaFuncCache
{
    cudaFuncCachePreferNone   = 0,    
    cudaFuncCachePreferShared = 1,    
    cudaFuncCachePreferL1     = 2,    
    cudaFuncCachePreferEqual  = 3     
};





enum __declspec(__device_builtin__) cudaSharedMemConfig
{
    cudaSharedMemBankSizeDefault   = 0,
    cudaSharedMemBankSizeFourByte  = 1,
    cudaSharedMemBankSizeEightByte = 2
};




enum __declspec(__device_builtin__) cudaComputeMode
{
    cudaComputeModeDefault          = 0,  
    cudaComputeModeExclusive        = 1,  
    cudaComputeModeProhibited       = 2,  
    cudaComputeModeExclusiveProcess = 3   
};




enum __declspec(__device_builtin__) cudaLimit
{
    cudaLimitStackSize                    = 0x00, 
    cudaLimitPrintfFifoSize               = 0x01, 
    cudaLimitMallocHeapSize               = 0x02, 
    cudaLimitDevRuntimeSyncDepth          = 0x03, 
    cudaLimitDevRuntimePendingLaunchCount = 0x04  
};




enum __declspec(__device_builtin__) cudaMemoryAdvise
{
    cudaMemAdviseSetReadMostly          = 1, 
    cudaMemAdviseUnsetReadMostly        = 2, 
    cudaMemAdviseSetPreferredLocation   = 3, 
    cudaMemAdviseUnsetPreferredLocation = 4, 
    cudaMemAdviseSetAccessedBy          = 5, 
    cudaMemAdviseUnsetAccessedBy        = 6  
};




enum __declspec(__device_builtin__) cudaMemRangeAttribute
{
    cudaMemRangeAttributeReadMostly           = 1, 
    cudaMemRangeAttributePreferredLocation    = 2, 
    cudaMemRangeAttributeAccessedBy           = 3, 
    cudaMemRangeAttributeLastPrefetchLocation = 4  
};




enum __declspec(__device_builtin__) cudaOutputMode
{
    cudaKeyValuePair    = 0x00, 
    cudaCSV             = 0x01  
};




enum __declspec(__device_builtin__) cudaDeviceAttr
{
    cudaDevAttrMaxThreadsPerBlock             = 1,  
    cudaDevAttrMaxBlockDimX                   = 2,  
    cudaDevAttrMaxBlockDimY                   = 3,  
    cudaDevAttrMaxBlockDimZ                   = 4,  
    cudaDevAttrMaxGridDimX                    = 5,  
    cudaDevAttrMaxGridDimY                    = 6,  
    cudaDevAttrMaxGridDimZ                    = 7,  
    cudaDevAttrMaxSharedMemoryPerBlock        = 8,  
    cudaDevAttrTotalConstantMemory            = 9,  
    cudaDevAttrWarpSize                       = 10, 
    cudaDevAttrMaxPitch                       = 11, 
    cudaDevAttrMaxRegistersPerBlock           = 12, 
    cudaDevAttrClockRate                      = 13, 
    cudaDevAttrTextureAlignment               = 14, 
    cudaDevAttrGpuOverlap                     = 15, 
    cudaDevAttrMultiProcessorCount            = 16, 
    cudaDevAttrKernelExecTimeout              = 17, 
    cudaDevAttrIntegrated                     = 18, 
    cudaDevAttrCanMapHostMemory               = 19, 
    cudaDevAttrComputeMode                    = 20, 
    cudaDevAttrMaxTexture1DWidth              = 21, 
    cudaDevAttrMaxTexture2DWidth              = 22, 
    cudaDevAttrMaxTexture2DHeight             = 23, 
    cudaDevAttrMaxTexture3DWidth              = 24, 
    cudaDevAttrMaxTexture3DHeight             = 25, 
    cudaDevAttrMaxTexture3DDepth              = 26, 
    cudaDevAttrMaxTexture2DLayeredWidth       = 27, 
    cudaDevAttrMaxTexture2DLayeredHeight      = 28, 
    cudaDevAttrMaxTexture2DLayeredLayers      = 29, 
    cudaDevAttrSurfaceAlignment               = 30, 
    cudaDevAttrConcurrentKernels              = 31, 
    cudaDevAttrEccEnabled                     = 32, 
    cudaDevAttrPciBusId                       = 33, 
    cudaDevAttrPciDeviceId                    = 34, 
    cudaDevAttrTccDriver                      = 35, 
    cudaDevAttrMemoryClockRate                = 36, 
    cudaDevAttrGlobalMemoryBusWidth           = 37, 
    cudaDevAttrL2CacheSize                    = 38, 
    cudaDevAttrMaxThreadsPerMultiProcessor    = 39, 
    cudaDevAttrAsyncEngineCount               = 40, 
    cudaDevAttrUnifiedAddressing              = 41,     
    cudaDevAttrMaxTexture1DLayeredWidth       = 42, 
    cudaDevAttrMaxTexture1DLayeredLayers      = 43, 
    cudaDevAttrMaxTexture2DGatherWidth        = 45, 
    cudaDevAttrMaxTexture2DGatherHeight       = 46, 
    cudaDevAttrMaxTexture3DWidthAlt           = 47, 
    cudaDevAttrMaxTexture3DHeightAlt          = 48, 
    cudaDevAttrMaxTexture3DDepthAlt           = 49, 
    cudaDevAttrPciDomainId                    = 50, 
    cudaDevAttrTexturePitchAlignment          = 51, 
    cudaDevAttrMaxTextureCubemapWidth         = 52, 
    cudaDevAttrMaxTextureCubemapLayeredWidth  = 53, 
    cudaDevAttrMaxTextureCubemapLayeredLayers = 54, 
    cudaDevAttrMaxSurface1DWidth              = 55, 
    cudaDevAttrMaxSurface2DWidth              = 56, 
    cudaDevAttrMaxSurface2DHeight             = 57, 
    cudaDevAttrMaxSurface3DWidth              = 58, 
    cudaDevAttrMaxSurface3DHeight             = 59, 
    cudaDevAttrMaxSurface3DDepth              = 60, 
    cudaDevAttrMaxSurface1DLayeredWidth       = 61, 
    cudaDevAttrMaxSurface1DLayeredLayers      = 62, 
    cudaDevAttrMaxSurface2DLayeredWidth       = 63, 
    cudaDevAttrMaxSurface2DLayeredHeight      = 64, 
    cudaDevAttrMaxSurface2DLayeredLayers      = 65, 
    cudaDevAttrMaxSurfaceCubemapWidth         = 66, 
    cudaDevAttrMaxSurfaceCubemapLayeredWidth  = 67, 
    cudaDevAttrMaxSurfaceCubemapLayeredLayers = 68, 
    cudaDevAttrMaxTexture1DLinearWidth        = 69, 
    cudaDevAttrMaxTexture2DLinearWidth        = 70, 
    cudaDevAttrMaxTexture2DLinearHeight       = 71, 
    cudaDevAttrMaxTexture2DLinearPitch        = 72, 
    cudaDevAttrMaxTexture2DMipmappedWidth     = 73, 
    cudaDevAttrMaxTexture2DMipmappedHeight    = 74, 
    cudaDevAttrComputeCapabilityMajor         = 75,  
    cudaDevAttrComputeCapabilityMinor         = 76, 
    cudaDevAttrMaxTexture1DMipmappedWidth     = 77, 
    cudaDevAttrStreamPrioritiesSupported      = 78, 
    cudaDevAttrGlobalL1CacheSupported         = 79, 
    cudaDevAttrLocalL1CacheSupported          = 80, 
    cudaDevAttrMaxSharedMemoryPerMultiprocessor = 81, 
    cudaDevAttrMaxRegistersPerMultiprocessor  = 82, 
    cudaDevAttrManagedMemory                  = 83, 
    cudaDevAttrIsMultiGpuBoard                = 84, 
    cudaDevAttrMultiGpuBoardGroupID           = 85, 
    cudaDevAttrHostNativeAtomicSupported      = 86, 
    cudaDevAttrSingleToDoublePrecisionPerfRatio = 87, 
    cudaDevAttrPageableMemoryAccess           = 88, 
    cudaDevAttrConcurrentManagedAccess        = 89, 
    cudaDevAttrComputePreemptionSupported     = 90, 
    cudaDevAttrCanUseHostPointerForRegisteredMem = 91 
};





enum __declspec(__device_builtin__) cudaDeviceP2PAttr {
    cudaDevP2PAttrPerformanceRank              = 1, 
    cudaDevP2PAttrAccessSupported              = 2, 
    cudaDevP2PAttrNativeAtomicSupported        = 3  
};



struct __declspec(__device_builtin__) cudaDeviceProp
{
    char   name[256];                  
    size_t totalGlobalMem;             
    size_t sharedMemPerBlock;          
    int    regsPerBlock;               
    int    warpSize;                   
    size_t memPitch;                   
    int    maxThreadsPerBlock;         
    int    maxThreadsDim[3];           
    int    maxGridSize[3];             
    int    clockRate;                  
    size_t totalConstMem;              
    int    major;                      
    int    minor;                      
    size_t textureAlignment;           
    size_t texturePitchAlignment;      
    int    deviceOverlap;              
    int    multiProcessorCount;        
    int    kernelExecTimeoutEnabled;   
    int    integrated;                 
    int    canMapHostMemory;           
    int    computeMode;                
    int    maxTexture1D;               
    int    maxTexture1DMipmap;         
    int    maxTexture1DLinear;         
    int    maxTexture2D[2];            
    int    maxTexture2DMipmap[2];      
    int    maxTexture2DLinear[3];      
    int    maxTexture2DGather[2];      
    int    maxTexture3D[3];            
    int    maxTexture3DAlt[3];         
    int    maxTextureCubemap;          
    int    maxTexture1DLayered[2];     
    int    maxTexture2DLayered[3];     
    int    maxTextureCubemapLayered[2];
    int    maxSurface1D;               
    int    maxSurface2D[2];            
    int    maxSurface3D[3];            
    int    maxSurface1DLayered[2];     
    int    maxSurface2DLayered[3];     
    int    maxSurfaceCubemap;          
    int    maxSurfaceCubemapLayered[2];
    size_t surfaceAlignment;           
    int    concurrentKernels;          
    int    ECCEnabled;                 
    int    pciBusID;                   
    int    pciDeviceID;                
    int    pciDomainID;                
    int    tccDriver;                  
    int    asyncEngineCount;           
    int    unifiedAddressing;          
    int    memoryClockRate;            
    int    memoryBusWidth;             
    int    l2CacheSize;                
    int    maxThreadsPerMultiProcessor;
    int    streamPrioritiesSupported;  
    int    globalL1CacheSupported;     
    int    localL1CacheSupported;      
    size_t sharedMemPerMultiprocessor; 
    int    regsPerMultiprocessor;      
    int    managedMemory;              
    int    isMultiGpuBoard;            
    int    multiGpuBoardGroupID;       
    int    hostNativeAtomicSupported;  
    int    singleToDoublePrecisionPerfRatio; 
    int    pageableMemoryAccess;       
    int    concurrentManagedAccess;    
};















































































typedef __declspec(__device_builtin__) struct __declspec(__device_builtin__) cudaIpcEventHandle_st
{
    char reserved[64];
}cudaIpcEventHandle_t;




typedef __declspec(__device_builtin__) struct __declspec(__device_builtin__) cudaIpcMemHandle_st 
{
    char reserved[64];
}cudaIpcMemHandle_t;










typedef __declspec(__device_builtin__) enum cudaError cudaError_t;




typedef __declspec(__device_builtin__) struct CUstream_st *cudaStream_t;




typedef __declspec(__device_builtin__) struct CUevent_st *cudaEvent_t;




typedef __declspec(__device_builtin__) struct cudaGraphicsResource *cudaGraphicsResource_t;




typedef __declspec(__device_builtin__) struct CUuuid_st cudaUUID_t;




typedef __declspec(__device_builtin__) enum cudaOutputMode cudaOutputMode_t;


 

#line 1509 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"

#line 60 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\builtin_types.h"

#line 62 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\builtin_types.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\surface_types.h"


























































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"



































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 1509 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"

#line 60 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\surface_types.h"
























enum __declspec(__device_builtin__) cudaSurfaceBoundaryMode
{
    cudaBoundaryModeZero  = 0,    
    cudaBoundaryModeClamp = 1,    
    cudaBoundaryModeTrap  = 2     
};




enum __declspec(__device_builtin__)  cudaSurfaceFormatMode
{
    cudaFormatModeForced = 0,     
    cudaFormatModeAuto = 1        
};




struct __declspec(__device_builtin__) surfaceReference
{
    


    struct cudaChannelFormatDesc channelDesc;
};




typedef __declspec(__device_builtin__) unsigned long long cudaSurfaceObject_t;


 

#line 120 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\surface_types.h"
#line 63 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\builtin_types.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\texture_types.h"


























































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"



































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 1509 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"

#line 60 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\texture_types.h"
























enum __declspec(__device_builtin__) cudaTextureAddressMode
{
    cudaAddressModeWrap   = 0,    
    cudaAddressModeClamp  = 1,    
    cudaAddressModeMirror = 2,    
    cudaAddressModeBorder = 3     
};




enum __declspec(__device_builtin__) cudaTextureFilterMode
{
    cudaFilterModePoint  = 0,     
    cudaFilterModeLinear = 1      
};




enum __declspec(__device_builtin__) cudaTextureReadMode
{
    cudaReadModeElementType     = 0,  
    cudaReadModeNormalizedFloat = 1   
};




struct __declspec(__device_builtin__) textureReference
{
    


    int                          normalized;
    


    enum cudaTextureFilterMode   filterMode;
    


    enum cudaTextureAddressMode  addressMode[3];
    


    struct cudaChannelFormatDesc channelDesc;
    


    int                          sRGB;
    


    unsigned int                 maxAnisotropy;
    


    enum cudaTextureFilterMode   mipmapFilterMode;
    


    float                        mipmapLevelBias;
    


    float                        minMipmapLevelClamp;
    


    float                        maxMipmapLevelClamp;
    int                          __cudaReserved[15];
};




struct __declspec(__device_builtin__) cudaTextureDesc
{
    


    enum cudaTextureAddressMode addressMode[3];
    


    enum cudaTextureFilterMode  filterMode;
    


    enum cudaTextureReadMode    readMode;
    


    int                         sRGB;
    


    float                       borderColor[4];
    


    int                         normalizedCoords;
    


    unsigned int                maxAnisotropy;
    


    enum cudaTextureFilterMode  mipmapFilterMode;
    


    float                       mipmapLevelBias;
    


    float                       minMipmapLevelClamp;
    


    float                       maxMipmapLevelClamp;
};




typedef __declspec(__device_builtin__) unsigned long long cudaTextureObject_t;


 

#line 218 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\texture_types.h"
#line 64 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\builtin_types.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"




























































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"























































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\device_types.h"




































































#line 70 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\device_types.h"
#line 57 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"


#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"



































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 1509 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\driver_types.h"

#line 60 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"

#line 62 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\surface_types.h"






















































































































#line 120 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\surface_types.h"
#line 63 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\texture_types.h"
























































































































































































































#line 218 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\texture_types.h"
#line 64 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"














































































































































































































































































































































































































































#line 432 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"
#line 65 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"
#line 62 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"

#line 64 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\host_defines.h"
















































































































































































































































#line 242 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\host_defines.h"
#line 65 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"






















#line 89 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"







#line 97 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"

struct __declspec(__device_builtin__) char1
{
    signed char x;
};

struct __declspec(__device_builtin__) uchar1
{
    unsigned char x;
};


struct __declspec(__device_builtin__) __declspec(align(2)) char2
{
    signed char x, y;
};

struct __declspec(__device_builtin__) __declspec(align(2)) uchar2
{
    unsigned char x, y;
};

struct __declspec(__device_builtin__) char3
{
    signed char x, y, z;
};

struct __declspec(__device_builtin__) uchar3
{
    unsigned char x, y, z;
};

struct __declspec(__device_builtin__) __declspec(align(4)) char4
{
    signed char x, y, z, w;
};

struct __declspec(__device_builtin__) __declspec(align(4)) uchar4
{
    unsigned char x, y, z, w;
};

struct __declspec(__device_builtin__) short1
{
    short x;
};

struct __declspec(__device_builtin__) ushort1
{
    unsigned short x;
};

struct __declspec(__device_builtin__) __declspec(align(4)) short2
{
    short x, y;
};

struct __declspec(__device_builtin__) __declspec(align(4)) ushort2
{
    unsigned short x, y;
};

struct __declspec(__device_builtin__) short3
{
    short x, y, z;
};

struct __declspec(__device_builtin__) ushort3
{
    unsigned short x, y, z;
};

struct __declspec(__device_builtin__) __declspec(align(8)) short4 { short x; short y; short z; short w; };
struct __declspec(__device_builtin__) __declspec(align(8)) ushort4 { unsigned short x; unsigned short y; unsigned short z; unsigned short w; };

struct __declspec(__device_builtin__) int1
{
    int x;
};

struct __declspec(__device_builtin__) uint1
{
    unsigned int x;
};

struct __declspec(__device_builtin__) __declspec(align(8)) int2 { int x; int y; };
struct __declspec(__device_builtin__) __declspec(align(8)) uint2 { unsigned int x; unsigned int y; };

struct __declspec(__device_builtin__) int3
{
    int x, y, z;
};

struct __declspec(__device_builtin__) uint3
{
    unsigned int x, y, z;
};

struct __declspec(__device_builtin__) __declspec(align(16)) int4
{
    int x, y, z, w;
};

struct __declspec(__device_builtin__) __declspec(align(16)) uint4
{
    unsigned int x, y, z, w;
};

struct __declspec(__device_builtin__) long1
{
    long int x;
};

struct __declspec(__device_builtin__) ulong1
{
    unsigned long x;
};


struct __declspec(__device_builtin__) __declspec(align(8)) long2 { long int x; long int y; };
struct __declspec(__device_builtin__) __declspec(align(8)) ulong2 { unsigned long int x; unsigned long int y; };












#line 231 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"

struct __declspec(__device_builtin__) long3
{
    long int x, y, z;
};

struct __declspec(__device_builtin__) ulong3
{
    unsigned long int x, y, z;
};

struct __declspec(__device_builtin__) __declspec(align(16)) long4
{
    long int x, y, z, w;
};

struct __declspec(__device_builtin__) __declspec(align(16)) ulong4
{
    unsigned long int x, y, z, w;
};

struct __declspec(__device_builtin__) float1
{
    float x;
};















#line 273 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"

struct __declspec(__device_builtin__) __declspec(align(8)) float2 { float x; float y; };

#line 277 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"


struct __declspec(__device_builtin__) float3
{
    float x, y, z;
};

struct __declspec(__device_builtin__) __declspec(align(16)) float4
{
    float x, y, z, w;
};

struct __declspec(__device_builtin__) longlong1
{
    long long int x;
};

struct __declspec(__device_builtin__) ulonglong1
{
    unsigned long long int x;
};

struct __declspec(__device_builtin__) __declspec(align(16)) longlong2
{
    long long int x, y;
};

struct __declspec(__device_builtin__) __declspec(align(16)) ulonglong2
{
    unsigned long long int x, y;
};

struct __declspec(__device_builtin__) longlong3
{
    long long int x, y, z;
};

struct __declspec(__device_builtin__) ulonglong3
{
    unsigned long long int x, y, z;
};

struct __declspec(__device_builtin__) __declspec(align(16)) longlong4
{
    long long int x, y, z ,w;
};

struct __declspec(__device_builtin__) __declspec(align(16)) ulonglong4
{
    unsigned long long int x, y, z, w;
};

struct __declspec(__device_builtin__) double1
{
    double x;
};

struct __declspec(__device_builtin__) __declspec(align(16)) double2
{
    double x, y;
};

struct __declspec(__device_builtin__) double3
{
    double x, y, z;
};

struct __declspec(__device_builtin__) __declspec(align(16)) double4
{
    double x, y, z, w;
};





#line 355 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"







typedef __declspec(__device_builtin__) struct char1 char1;
typedef __declspec(__device_builtin__) struct uchar1 uchar1;
typedef __declspec(__device_builtin__) struct char2 char2;
typedef __declspec(__device_builtin__) struct uchar2 uchar2;
typedef __declspec(__device_builtin__) struct char3 char3;
typedef __declspec(__device_builtin__) struct uchar3 uchar3;
typedef __declspec(__device_builtin__) struct char4 char4;
typedef __declspec(__device_builtin__) struct uchar4 uchar4;
typedef __declspec(__device_builtin__) struct short1 short1;
typedef __declspec(__device_builtin__) struct ushort1 ushort1;
typedef __declspec(__device_builtin__) struct short2 short2;
typedef __declspec(__device_builtin__) struct ushort2 ushort2;
typedef __declspec(__device_builtin__) struct short3 short3;
typedef __declspec(__device_builtin__) struct ushort3 ushort3;
typedef __declspec(__device_builtin__) struct short4 short4;
typedef __declspec(__device_builtin__) struct ushort4 ushort4;
typedef __declspec(__device_builtin__) struct int1 int1;
typedef __declspec(__device_builtin__) struct uint1 uint1;
typedef __declspec(__device_builtin__) struct int2 int2;
typedef __declspec(__device_builtin__) struct uint2 uint2;
typedef __declspec(__device_builtin__) struct int3 int3;
typedef __declspec(__device_builtin__) struct uint3 uint3;
typedef __declspec(__device_builtin__) struct int4 int4;
typedef __declspec(__device_builtin__) struct uint4 uint4;
typedef __declspec(__device_builtin__) struct long1 long1;
typedef __declspec(__device_builtin__) struct ulong1 ulong1;
typedef __declspec(__device_builtin__) struct long2 long2;
typedef __declspec(__device_builtin__) struct ulong2 ulong2;
typedef __declspec(__device_builtin__) struct long3 long3;
typedef __declspec(__device_builtin__) struct ulong3 ulong3;
typedef __declspec(__device_builtin__) struct long4 long4;
typedef __declspec(__device_builtin__) struct ulong4 ulong4;
typedef __declspec(__device_builtin__) struct float1 float1;
typedef __declspec(__device_builtin__) struct float2 float2;
typedef __declspec(__device_builtin__) struct float3 float3;
typedef __declspec(__device_builtin__) struct float4 float4;
typedef __declspec(__device_builtin__) struct longlong1 longlong1;
typedef __declspec(__device_builtin__) struct ulonglong1 ulonglong1;
typedef __declspec(__device_builtin__) struct longlong2 longlong2;
typedef __declspec(__device_builtin__) struct ulonglong2 ulonglong2;
typedef __declspec(__device_builtin__) struct longlong3 longlong3;
typedef __declspec(__device_builtin__) struct ulonglong3 ulonglong3;
typedef __declspec(__device_builtin__) struct longlong4 longlong4;
typedef __declspec(__device_builtin__) struct ulonglong4 ulonglong4;
typedef __declspec(__device_builtin__) struct double1 double1;
typedef __declspec(__device_builtin__) struct double2 double2;
typedef __declspec(__device_builtin__) struct double3 double3;
typedef __declspec(__device_builtin__) struct double4 double4;







struct __declspec(__device_builtin__) dim3
{
    unsigned int x, y, z;




#line 425 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"
};

typedef __declspec(__device_builtin__) struct dim3 dim3;



#line 432 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"
#line 65 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\builtin_types.h"
#line 285 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"
#line 1 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"




















































#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"














































































































































































































































































































































































































































#line 432 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\vector_types.h"
#line 54 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"






#line 61 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"


#line 64 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"

#line 66 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"



#line 70 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"

uint3 __declspec(__device_builtin__) extern const threadIdx;
uint3 __declspec(__device_builtin__) extern const blockIdx;
dim3 __declspec(__device_builtin__) extern const blockDim;
dim3 __declspec(__device_builtin__) extern const gridDim;
int __declspec(__device_builtin__) extern const warpSize;





#line 82 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"






#line 89 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"






#line 96 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"






#line 103 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"






#line 110 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"






#line 117 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"

#line 119 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\device_launch_parameters.h"
#line 286 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"
#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"










































#line 44 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"






#line 51 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 55 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 59 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 63 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 67 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 71 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 75 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 79 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 83 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 87 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 91 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 95 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 99 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 103 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 107 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 111 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 115 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 119 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 123 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 127 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 131 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 135 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 139 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 143 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"



#line 147 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"

#line 149 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\crt\\storage_class.h"
#line 287 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\crt/device_runtime.h"
#line 196 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vcruntime.h"
#line 39 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\vadefs.h"
typedef char *va_list;
#line 467 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt.h"
typedef struct __crt_locale_pointers *_locale_t;
#line 811 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\yvals.h"
typedef unsigned long _Uint32t;
#line 28 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_wstdio.h"
typedef struct _iobuf FILE;
#pragma pack(8)
#line 70 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo.h"
struct _Cvtvec {
#line 72 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo.h"
unsigned _Page;
#line 73 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo.h"
unsigned _Mbcurmax;
#line 74 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo.h"
int _Isclocale;
#line 75 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo.h"
unsigned char _Isleadbyte[32];};
#pragma pack()
#line 66 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
struct HMat {
#line 67 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
double *e;
#line 68 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
double *f;
#line 69 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short N;
#line 71 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *Ks;
#line 72 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float *Cms;
#line 73 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short NModels;
#line 74 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short NComps;
#line 75 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *boolModel;
#line 77 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short Depth;
#line 78 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short LognDepth;
#line 79 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short nFathers;
#line 80 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short nCallForFather;
#line 81 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *Fathers;
#line 83 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *SonNoVec;
#line 85 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *RelStarts;
#line 86 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *RelEnds;
#line 87 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *RelVec;
#line 88 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *SegStartI;
#line 89 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *SegEndI;
#line 90 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *SegToComp;
#line 91 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *MidComps;
#line 93 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *FIdxs;
#line 96 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *CompByLevel32;
#line 97 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *CompByFLevel32;
#line 98 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short nLRel;
#line 99 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *LRelStarts;
#line 100 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *LRelEnds;
#line 101 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short nFLRel;
#line 102 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *FLRelStarts;
#line 103 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *FLRelEnds;};
#line 108 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
typedef struct HMat HMat;
#line 111 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
struct Stim {
#line 112 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short NStimuli;
#line 113 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short loc;
#line 114 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short comp;
#line 115 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short numofdts;
#line 116 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float area;
#line 117 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *dtInds;
#line 118 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float *amps;
#line 119 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float *durs;
#line 120 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float *dels;
#line 121 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float Nt;char __nv_no_debug_dummy_end_padding_0[4];};
#line 122 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
typedef struct Stim Stim;
#line 126 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
struct Sim {
#line 127 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float *Vs;
#line 128 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float dt;
#line 129 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float TFinal;
#line 130 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
float Celsius;
#line 131 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short NRecSites;
#line 132 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
unsigned short *RecSites;};
#line 133 "c:\\pyneurogpu_winnew\\neurogpu6\\Util.h"
typedef struct Sim Sim;
#pragma pack(8)
#line 621 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\yvals.h"
struct _ZSt7_Lockit {
#line 662 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\yvals.h"
int _Locktype;};
#pragma pack()
#line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
typedef _Uint32t _ZSt8_Uint4_t;
#line 25 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
typedef _ZSt8_Uint4_t _ZSt18_Atomic_integral_t;
#line 52 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xatomic0.h"
typedef _ZSt18_Atomic_integral_t _ZSt17_Atomic_counter_t;
#line 2634 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xstring"
typedef struct _ZSs _ZSt6string;
#pragma pack(8)
#line 3713 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
struct _ZSt5_YarnIcE {
#line 3809 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
char *_Myptr;
#line 3810 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
char _Nul;char __nv_no_debug_dummy_end_padding_0[7];};
#pragma pack()
#pragma pack(8)
#line 3713 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
struct _ZSt5_YarnIwE {
#line 3809 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
unsigned short *_Myptr;
#line 3810 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xutility"
unsigned short _Nul;char __nv_no_debug_dummy_end_padding_0[6];};
#pragma pack()
#line 59 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
typedef struct _Cvtvec _ZNSt8_Locinfo7_CvtvecE;
#pragma pack(8)
#line 54 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt8_Locinfo {
#line 225 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt7_Lockit _Lock;
#line 228 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt5_YarnIcE _Days;
#line 229 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt5_YarnIcE _Months;
#line 230 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt5_YarnIwE _W_Days;
#line 231 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt5_YarnIwE _W_Months;
#line 232 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt5_YarnIcE _Oldlocname;
#line 233 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocinfo"
struct _ZSt5_YarnIcE _Newlocname;};
#pragma pack()
#pragma pack(8)
#line 20 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xfacet"
struct _ZSt11_Facet_base { const long long *__vptr;};
#pragma pack()
#pragma pack(8)
#line 61 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZSt15_Crt_new_delete {char __nv_no_debug_dummy_end_padding_0;};
#pragma pack()
#pragma pack(8)
#line 24 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZSt8_LocbaseIiE {char __nv_no_debug_dummy_end_padding_0;};
#pragma pack()
#pragma pack(8)
#line 105 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZNSt6locale2idE {
#line 126 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
size_t _Id;};
#pragma pack()
#pragma pack(8)
#line 138 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZNSt6locale5facetE { struct _ZSt11_Facet_base __b_St11_Facet_base;
#line 162 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
_ZSt17_Atomic_counter_t _Myrefs;char __nv_no_debug_dummy_end_padding_0[4];};
#pragma pack()
#pragma pack(8)
#line 98 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZSt6locale {
#line 511 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocale"
struct _ZNSt6locale7_LocimpE *_Ptr;};
#pragma pack()
#pragma pack(8)
#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
struct _ZSt8numpunctIcE { struct _ZNSt6locale5facetE __b_NSt6locale5facetE;
#line 263 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
const char *_Grouping;
#line 264 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
char _Dp;
#line 265 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
char _Kseparator;
#line 266 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
const char *_Falsename;
#line 267 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
const char *_Truename;};
#pragma pack()
#pragma pack(8)
#line 112 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
struct _ZSt8numpunctIwE { struct _ZNSt6locale5facetE __b_NSt6locale5facetE;
#line 263 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
const char *_Grouping;
#line 264 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
unsigned short _Dp;
#line 265 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
unsigned short _Kseparator;
#line 266 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
const unsigned short *_Falsename;
#line 267 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
const unsigned short *_Truename;};
#pragma pack()

#line 271 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"

#line 273 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"

#line 275 "C:\\Program Files (x86)\\Microsoft Visual Studio 14.0\\VC\\include\\xlocnum"
#line 85 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_malloc.h"
extern  __declspec(__device__) void free(void *);
#line 97 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_malloc.h"
extern  __declspec(__device__) void *malloc(size_t);

#line 100 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_malloc.h"

#line 102 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_malloc.h"

#line 104 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_malloc.h"

#line 106 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_malloc.h"

#line 108 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\corecrt_malloc.h"

#line 944 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\stdio.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) int printf(const char *const, ...);
#line 946 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\stdio.h"

#line 216 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) double fabs(double);
#line 218 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 220 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 222 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 224 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 226 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 228 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 230 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 232 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 234 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 236 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 238 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 240 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 242 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 244 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 246 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 248 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 250 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 252 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 254 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 256 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 258 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 260 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 262 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 264 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 266 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 268 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 270 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 272 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 274 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 276 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 278 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 280 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 282 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 284 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 286 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 288 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 290 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 292 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 294 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 296 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 298 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 300 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 302 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 304 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1821 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) double ldexp(double, int);
#line 1823 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1825 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1827 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1829 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1831 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1833 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1835 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1837 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1839 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2426 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) double frexp(double, int *);
#line 2428 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2430 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2432 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2434 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2436 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2438 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2440 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2442 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2444 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2446 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2448 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2450 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2452 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2454 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2456 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2458 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2460 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2462 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2464 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2466 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2468 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2470 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2472 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2474 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2476 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2478 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2480 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2482 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2484 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2486 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2488 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2490 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2492 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2494 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2496 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2498 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2500 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2502 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2504 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2506 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2508 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2510 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2512 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2514 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2516 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2518 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2520 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2522 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2524 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2526 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2528 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2530 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2532 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2534 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2536 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2538 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2540 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2542 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2544 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2546 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2548 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2550 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2552 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2554 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2556 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2558 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2560 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2562 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2564 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2566 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2568 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2570 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2572 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2574 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2576 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2578 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2580 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2582 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2584 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2586 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2588 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2590 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2592 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2594 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2596 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2598 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2600 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2602 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2604 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2606 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2608 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2610 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2612 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2614 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2616 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2618 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2620 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2622 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2624 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2626 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2628 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2630 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2632 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2634 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2636 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2638 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2640 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2642 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2644 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2646 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2648 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2650 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2652 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2654 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2656 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2658 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2660 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2662 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2664 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2666 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2668 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2670 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2672 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2674 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2676 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2678 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2680 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2682 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2684 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2686 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2688 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 2690 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 656 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) float fabsf(float);
#line 658 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 682 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) float frexpf(float, int *);
#line 684 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 687 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) float hypotf(float, float);
#line 689 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 692 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"
 __declspec(__device_builtin__) extern  __declspec(__device__) float ldexpf(float, int);
#line 694 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 696 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 698 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 700 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 702 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 704 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 706 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 708 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 710 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 712 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 714 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 716 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 718 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 720 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 722 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 724 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 726 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 728 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 730 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 732 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 734 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 736 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 738 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 740 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 742 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 744 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 746 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 748 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 750 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 752 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 754 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 756 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 758 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 760 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 762 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 764 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 766 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 768 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 770 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 772 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 774 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 776 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 778 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 780 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 782 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 784 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 786 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 788 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 790 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 792 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 794 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 796 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 798 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 800 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 802 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 804 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 806 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 808 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 810 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 812 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 814 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 816 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 818 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 820 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 822 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 824 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 826 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 828 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 830 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 832 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 834 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 836 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 838 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 840 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 842 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 844 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 846 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 848 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 850 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 852 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 854 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 856 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 858 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 860 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 862 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 864 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 866 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 868 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 870 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 872 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 874 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 876 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 878 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 880 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 882 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 884 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 886 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 888 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 890 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 892 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 894 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 896 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 898 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 900 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 902 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 904 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 906 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 908 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 910 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 912 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 914 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 916 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 918 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 920 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 922 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 924 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 926 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 928 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 930 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 932 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 934 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 936 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 938 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 940 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 942 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 944 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 946 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 948 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 950 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 952 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 954 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 956 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 958 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 960 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 962 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 964 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 966 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 968 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 970 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 972 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 974 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 976 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 978 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 980 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 982 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 984 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 986 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 988 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 990 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 992 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 994 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 996 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 998 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1000 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1002 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1004 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1006 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1008 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1010 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1012 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1014 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1016 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1018 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1020 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1022 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1024 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1026 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1028 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1030 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1032 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1034 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1036 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1038 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1040 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1042 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1044 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1046 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1048 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1050 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1052 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1054 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1056 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1058 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1060 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1062 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1064 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1066 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1068 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1070 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1072 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1074 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1076 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1078 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1080 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1082 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1084 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1086 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1088 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1090 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1092 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1094 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1096 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1098 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1100 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1102 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1104 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1106 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1108 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1110 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1112 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1114 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1116 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1118 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1120 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1122 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1124 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1126 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1128 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1130 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1132 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1134 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1136 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1138 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1140 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1142 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1144 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1146 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1148 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1150 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1152 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1154 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1156 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1158 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1160 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1162 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1164 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1166 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1168 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1170 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1172 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1174 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1176 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1178 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1180 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1182 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1184 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1186 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1188 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1190 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1192 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1194 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1196 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1198 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1200 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1202 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1204 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1206 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1208 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1210 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1212 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1214 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1216 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1218 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1220 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1222 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1224 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1226 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1228 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1230 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1232 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1234 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1236 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1238 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1240 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1242 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1244 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1246 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1248 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1250 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1252 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1254 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1256 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1258 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1260 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1262 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1264 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1266 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1268 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1270 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1272 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1274 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1276 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1278 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1280 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1282 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1284 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1286 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1288 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1290 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1292 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1294 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1296 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1298 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1300 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1302 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1304 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1306 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1308 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1310 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1312 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1314 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1316 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1318 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1320 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1322 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1324 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1326 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1328 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1330 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1332 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1334 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1336 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1338 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1340 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1342 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1344 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1346 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1348 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1350 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1352 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1354 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1356 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1358 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1360 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1362 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1364 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1366 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1368 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1370 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1372 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1374 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1376 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1378 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1380 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1382 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1384 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1386 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1388 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1390 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1392 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1394 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1396 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1398 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1400 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1402 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1404 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1406 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1408 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1410 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1412 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1414 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1416 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1418 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1420 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1422 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1424 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1426 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1428 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1430 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1432 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1434 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1436 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1438 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1440 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1442 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1444 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1446 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1448 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1450 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1452 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1454 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1456 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1458 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1460 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1462 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1464 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1466 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1468 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1470 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1472 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1474 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1476 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1478 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1480 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1482 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1484 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1486 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1488 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1490 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1492 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1494 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1496 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1498 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1500 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1502 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1504 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1506 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1508 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1510 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1512 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1514 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1516 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1518 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1520 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1522 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1524 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1526 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1528 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1530 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1532 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1534 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"
#line 1 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\common_functions.h"












































































































































































































































#line 238 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\common_functions.h"









#line 248 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\common_functions.h"

#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"





































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 9831 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"












































































































































































































































































































































































































































































































#line 10324 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"



#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.hpp"


































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 1092 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.hpp"










































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































































#line 3855 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.hpp"

#line 3857 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.hpp"


#line 10328 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 10330 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"






















































#line 56 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"

#line 58 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"

#line 60 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"













































































































































































































#line 266 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"




#line 1 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.hpp"






















































#line 56 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.hpp"

#line 58 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.hpp"

#line 60 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.hpp"











































































































































































































































































































































































































































































































#line 552 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.hpp"



#line 556 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.hpp"

#line 271 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"
#line 272 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"

#line 274 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions_dbl_ptx3.h"
#line 10332 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 10334 "c:\\program files\\nvidia gpu computing toolkit\\cuda\\v8.0\\include\\math_functions.h"

#line 250 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\common_functions.h"

#line 252 "C:\\Program Files\\NVIDIA GPU Computing Toolkit\\CUDA\\v8.0\\include\\common_functions.h"

#line 1535 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1537 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1539 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1541 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1543 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1545 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1547 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1549 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1551 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1553 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1555 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1557 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1559 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1561 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1563 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1565 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1567 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1569 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1571 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1573 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1575 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1577 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1579 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1581 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1583 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1585 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1587 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1589 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1591 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1593 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1595 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1597 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1599 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1601 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1603 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1605 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1607 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1609 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1611 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1613 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1615 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1617 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1619 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1621 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1623 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1625 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1627 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1629 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1631 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1633 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1635 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1637 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1639 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1641 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1643 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1645 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1647 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1649 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1651 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1653 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1655 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1657 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1659 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1661 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1663 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1665 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1667 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1669 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1671 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1673 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1675 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1677 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1679 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1681 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1683 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1685 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1687 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1689 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1691 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1693 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1695 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1697 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1699 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1701 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1703 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1705 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1707 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1709 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1711 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1713 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1715 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1717 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1719 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1721 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1723 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1725 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1727 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1729 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1731 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1733 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1735 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1737 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1739 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1741 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1743 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1745 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1747 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1749 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1751 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1753 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1755 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1757 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1759 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1761 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1763 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1765 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1767 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1769 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1771 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1773 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1775 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1777 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1779 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1781 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1783 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1785 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1787 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1789 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1791 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1793 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1795 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1797 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1799 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1801 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1803 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1805 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1807 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1809 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1811 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1813 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1815 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1817 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1819 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1821 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1823 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1825 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1827 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1829 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1831 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1833 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1835 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1837 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1839 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1841 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1843 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1845 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1847 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1849 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1851 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1853 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1855 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1857 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1859 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1861 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1863 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1865 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1867 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1869 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1871 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1873 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1875 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1877 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1879 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1881 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1883 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1885 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1887 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1889 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1891 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1893 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1895 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1897 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1899 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1901 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1903 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1905 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1907 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1909 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1911 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1913 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1915 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1917 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1919 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1921 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1923 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1925 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1927 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1929 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1931 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1933 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1935 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1937 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1939 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1941 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1943 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1945 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1947 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1949 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1951 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1953 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1955 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1957 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1959 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1961 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1963 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1965 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1967 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1969 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1971 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1973 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1975 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1977 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1979 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1981 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1983 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1985 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1987 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1989 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1991 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1993 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1995 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1997 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 1999 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2001 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2003 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2005 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2007 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2009 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2011 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2013 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2015 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2017 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2019 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2021 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2023 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2025 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2027 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2029 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2031 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2033 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2035 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2037 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2039 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2041 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2043 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2045 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2047 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2049 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2051 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2053 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2055 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2057 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2059 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2061 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2063 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2065 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2067 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2069 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2071 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2073 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2075 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2077 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2079 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2081 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2083 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2085 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2087 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2089 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2091 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2093 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2095 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2097 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2099 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2101 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2103 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2105 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2107 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2109 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2111 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2113 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2115 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2117 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2119 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2121 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2123 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2125 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2127 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2129 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2131 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2133 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2135 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2137 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2139 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2141 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2143 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2145 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2147 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2149 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2151 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2153 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2155 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2157 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2159 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2161 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2163 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2165 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2167 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2169 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2171 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2173 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2175 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2177 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2179 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2181 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2183 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2185 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2187 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2189 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2191 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2193 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2195 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2197 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2199 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2201 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2203 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2205 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2207 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2209 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2211 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2213 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2215 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2217 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2219 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2221 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2223 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2225 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2227 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2229 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2231 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2233 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2235 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2237 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2239 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2241 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2243 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2245 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2247 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2249 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2251 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2253 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2255 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2257 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2259 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2261 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2263 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2265 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2267 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2269 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2271 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2273 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2275 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2277 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2279 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2281 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2283 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2285 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2287 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2289 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2291 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2293 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2295 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2297 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2299 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2301 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2303 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2305 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2307 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2309 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2311 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2313 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2315 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2317 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2319 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2321 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2323 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2325 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2327 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2329 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2331 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2333 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2335 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2337 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2339 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2341 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2343 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2345 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2347 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2349 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2351 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2353 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2355 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2357 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2359 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2361 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2363 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2365 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2367 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2369 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2371 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2373 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2375 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2377 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2379 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2381 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2383 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2385 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2387 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2389 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2391 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2393 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2395 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2397 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2399 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2401 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2403 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2405 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2407 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2409 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2411 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2413 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2415 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2417 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2419 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2421 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2423 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2425 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2427 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2429 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2431 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2433 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2435 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2437 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2439 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2441 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2443 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2445 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2447 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2449 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2451 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2453 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2455 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2457 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2459 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2461 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2463 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2465 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2467 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2469 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2471 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2473 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2475 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2477 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2479 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2481 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2483 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2485 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2487 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2489 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2491 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2493 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2495 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2497 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2499 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2501 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2503 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2505 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2507 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2509 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2511 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2513 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2515 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2517 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2519 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2521 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2523 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2525 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2527 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2529 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2531 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2533 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2535 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2537 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2539 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2541 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2543 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2545 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2547 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2549 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2551 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2553 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2555 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2557 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2559 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2561 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2563 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2565 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2567 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2569 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2571 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2573 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2575 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2577 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2579 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2581 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2583 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2585 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2587 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2589 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2591 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2593 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2595 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2597 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2599 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2601 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2603 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2605 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2607 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2609 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2611 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2613 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2615 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2617 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2619 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2621 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2623 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2625 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2627 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2629 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2631 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2633 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2635 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2637 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2639 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2641 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2643 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2645 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2647 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2649 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2651 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2653 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2655 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2657 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2659 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2661 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2663 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2665 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2667 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2669 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2671 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2673 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2675 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2677 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2679 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2681 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2683 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2685 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2687 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2689 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2691 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2693 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2695 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2697 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2699 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2701 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2703 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2705 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2707 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2709 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2711 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2713 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2715 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2717 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2719 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2721 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2723 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2725 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2727 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2729 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2731 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2733 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2735 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2737 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2739 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2741 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2743 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2745 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2747 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2749 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2751 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2753 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2755 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2757 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2759 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2761 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2763 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2765 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2767 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2769 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

#line 2771 "C:\\Program Files (x86)\\Windows Kits\\10\\Include\\10.0.10240.0\\ucrt\\math.h"

