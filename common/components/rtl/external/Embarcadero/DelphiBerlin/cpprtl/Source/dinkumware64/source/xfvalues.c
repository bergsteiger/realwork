/* values used by math functions -- IEEE 754 float version */
#include "xmath.h"
_C_LIB_DECL

		/* macros */
#define NBITS	(16 + _FOFF)

 #if _D0 == 0
  #define INIT(w0)		{w0, 0}
  #define INIT2(w0, w1)	{w0, w1}
 #else /* _D0 == 0 */
  #define INIT(w0)		{0, w0}
  #define INIT2(w0, w1)	{w1, w0}
 #endif /* _D0 == 0 */

		/* static data */
_EXTERN_CONST _Dconst _FDenorm = {INIT2(0, 1)};
_EXTERN_CONST _Dconst _FEps = {
	INIT((_FBIAS - NBITS - 1) << _FOFF)};
_EXTERN_CONST _Dconst _FInf = {INIT(_FMAX << _FOFF)};
_EXTERN_CONST _Dconst _FNan = {INIT((_FMAX << _FOFF)
	| (1 << (_FOFF - 1)))};
_EXTERN_CONST _Dconst _FSnan = {INIT2(_FMAX << _FOFF, 1)};
_EXTERN_CONST _Dconst _FRteps = {
	INIT((_FBIAS - NBITS / 2) << _FOFF)};

_EXTERN_CONST float _FZero = 0.0F;
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
