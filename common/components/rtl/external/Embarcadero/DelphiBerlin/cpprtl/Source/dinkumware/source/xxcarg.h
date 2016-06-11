/* xxcarg.h -- common carg[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(carg))(FCTYPE x)
	{	/* find phase of complex */
	return (FFUN(atan2)(FFUN(cimag)(x), FFUN(creal)(x)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
