/* xxxcmulcc.h -- common _[FL]Cmulcc functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FNAME(Cmulcc))(FCTYPE x, FCTYPE y)
	{	/* find complex product */
	FTYPE xre = FFUN(creal)(x);
	FTYPE xim = FFUN(cimag)(x);
	FTYPE yre = FFUN(creal)(y);
	FTYPE yim = FFUN(cimag)(y);

	return (FNAME(Cbuild)(xre * yre - xim * yim,
		xre * yim + xim * yre));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
