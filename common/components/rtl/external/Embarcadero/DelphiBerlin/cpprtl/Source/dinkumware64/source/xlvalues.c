/* values used by math functions -- IEEE 754 long version */
#include "xmath.h"
_C_LIB_DECL

 #if _DLONG == 0
		/* macros -- 64-bit */
  #define NBITS	(48 + _DOFF)

  #if _D0 == 0
   #define INIT(w0)		{w0, 0, 0, 0}
   #define INIT2(w0, w1)	{w0, 0, 0, w1}
  #else /* _DLONG == 0 */
   #define INIT(w0)		{0, 0, 0, w0}
   #define INIT2(w0, w1)	{w1, 0, 0, w0}
  #endif /* _DLONG == 0 */

		/* static data */
_EXTERN_CONST _Dconst _LDenorm = {INIT2(0, 1)};
_EXTERN_CONST _Dconst _LEps = {
	INIT((_DBIAS - NBITS - 1) << _DOFF)};
_EXTERN_CONST _Dconst _LInf = {INIT(_DMAX << _DOFF)};
_EXTERN_CONST _Dconst _LNan = {INIT((_DMAX << _DOFF)
	| (1 << (_DOFF - 1)))};
_EXTERN_CONST _Dconst _LSnan = {INIT2(_DMAX << _DOFF, 1)};
_EXTERN_CONST _Dconst _LRteps = {
	INIT((_DBIAS - NBITS / 2) << _DOFF)};

 #elif _DLONG == 1
		/* macros -- 80-bit */
  #define NBITS	64

  #if _D0 == 0
   #define INIT(w0, w1)		{w0, w1, 0, 0, 0}
   #define INIT3(w0, w1, wn)	{w0, w1, 0, 0, wn}
  #else /* _D0 == 0 */
   #define INIT(w0, w1)		{0, 0, 0, w1, w0}
   #define INIT3(w0, w1, wn)	{wn, 0, 0, w1, w0}
  #endif /* _D0 == 0 */

		/* static data */
_EXTERN_CONST _Dconst _LDenorm = {INIT3(0, 0, 1)};
_EXTERN_CONST _Dconst _LEps = {
	INIT(_LBIAS - NBITS - 1, 0x8000)};
_EXTERN_CONST _Dconst _LInf = {INIT(_LMAX, 0x8000)};
_EXTERN_CONST _Dconst _LNan = {INIT(_LMAX, 0xc000)};
_EXTERN_CONST _Dconst _LSnan = {INIT3(_LMAX, 0x8000, 1)};
_EXTERN_CONST _Dconst _LRteps = {
	INIT(_LBIAS - NBITS / 2, 0x8000)};

 #else /* 1 < _DLONG */
		/* macros -- 128-bit SPARC */
  #define NBITS	128

  #if _D0 == 0
   #define INIT(w0, w1)		{w0, w1, 0, 0, 0, 0, 0, 0}
   #define INIT3(w0, w1, wn)	{w0, w1, 0, 0, 0, 0, 0, wn}
  #else /* _D0 == 0 */
   #define INIT(w0, w1)		{0, 0, 0, 0, 0, 0, w1, w0}
   #define INIT3(w0, w1, wn)	{wn, 0, 0, 0, 0, 0, w1, w0}
  #endif /* _D0 == 0 */

		/* static data */
_EXTERN_CONST _Dconst _LDenorm = {INIT3(0, 0, 1)};
_EXTERN_CONST _Dconst _LEps = {
	INIT(_LBIAS - NBITS - 1, 0x8000)};
_EXTERN_CONST _Dconst _LInf = {INIT(_LMAX, 0)};
_EXTERN_CONST _Dconst _LNan = {INIT(_LMAX, 0x8000)};
_EXTERN_CONST _Dconst _LSnan = {INIT3(_LMAX, 0, 1)};
_EXTERN_CONST _Dconst _LRteps = {
	INIT(_LBIAS - NBITS / 2, 0x8000)};
 #endif /* _DLONG */

_EXTERN_CONST long double _LZero = 0.0L;
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
