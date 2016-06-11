/* xxcabs.h -- common cabs[fl] functionality */
#include <complex.h>
#include <math.h>
_STD_BEGIN

FTYPE FFUN(hypot)(FTYPE, FTYPE);

FTYPE (FFUN(cabs))(FCTYPE x)
	{	/* find magnitude of complex */
	return (FFUN(hypot)(FFUN(creal)(x), FFUN(cimag)(x)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
