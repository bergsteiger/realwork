/* values used by math functions -- IEEE 754 version */
#include "xmath.h"
_C_LIB_DECL

		/* macros */
#define NBITS	(48 + _DOFF)

 #if _D0 == 0
  #define INIT(w0)		{w0, 0, 0, 0}
  #define INIT2(w0, w1)	{w0, 0, 0, w1}
 #else /* _D0 == 0 */
  #define INIT(w0)		{0, 0, 0, w0}
  #define INIT2(w0, w1)	{w1, 0, 0, w0}
 #endif /* _D0 == 0 */

		/* static data */
_EXTERN_CONST _Dconst _Denorm = {INIT2(0, 1)};
_EXTERN_CONST _Dconst _Eps = {
	INIT((_DBIAS - NBITS - 1) << _DOFF)};
_EXTERN_CONST _Dconst _Hugeval = {INIT(_DMAX << _DOFF)};
_EXTERN_CONST _Dconst _Inf = {INIT(_DMAX << _DOFF)};
_EXTERN_CONST _Dconst _Nan = {INIT((_DMAX << _DOFF)
	| (1 << (_DOFF - 1)))};
_EXTERN_CONST _Dconst _Snan = {INIT2(_DMAX << _DOFF, 1)};
_EXTERN_CONST _Dconst _Rteps = {
	INIT((_DBIAS - NBITS / 2) << _DOFF)};

_EXTERN_CONST double _Zero = 0.0;
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
