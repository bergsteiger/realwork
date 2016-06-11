/* xxcatan.h -- common catan[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FFUN(catan))(FCTYPE x)
	{	/* compute complex arctangent */
	x = FFUN(catanh)(FNAME(Cbuild)(-FFUN(cimag)(x), FFUN(creal)(x)));

	return (FNAME(Cbuild)(FFUN(cimag)(x), -FFUN(creal)(x)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
