/* xxxcsubcc.h -- common _[FL]Csubcc functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FNAME(Csubcc))(FCTYPE x, FCTYPE y)
	{	/* find complex difference */
	return (FNAME(Cbuild)(FFUN(creal)(x) - FFUN(creal)(y),
		FFUN(cimag)(x) - FFUN(cimag)(y)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
