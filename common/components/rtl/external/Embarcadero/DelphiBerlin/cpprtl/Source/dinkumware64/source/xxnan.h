/* xxnan.h -- common nan[fl] functionality */
#include <float.h>
#include "xmath.h"

 #if defined(__BORLANDC__)
  #pragma warn -par
 #endif /* __BORLANDC__ */

_C_LIB_DECL

FTYPE _CDECL FFUN(nan)(const char *s)
	{	/* construct a NaN */
	return (FCONST(Nan));	/* quiet diagnostic */
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
