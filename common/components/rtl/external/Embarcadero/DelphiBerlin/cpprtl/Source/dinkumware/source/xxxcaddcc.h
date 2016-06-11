/* xxxcaddcc.h -- common _[FL]Caddcc functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FNAME(Caddcc))(FCTYPE x, FCTYPE y)
	{	/* find complex sum */
	return (FNAME(Cbuild)(FFUN(creal)(x) + FFUN(creal)(y),
		FFUN(cimag)(x) + FFUN(cimag)(y)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
