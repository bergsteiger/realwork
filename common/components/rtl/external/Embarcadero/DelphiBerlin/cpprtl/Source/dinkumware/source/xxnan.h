/* xxnan.h -- common nan[fl] functionality */
#include <float.h>
#include "xmath.h"

 #if defined(__BORLANDC__)
  #pragma warn -par
 #endif /* __BORLANDC__ */

_STD_BEGIN

FTYPE FFUN(nan)(const char *s)
	{	/* construct a NaN */
	return (FCONST(Nan));	/* quiet diagnostic */
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
