/* xxnorm.h -- common norm[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(norm))(FCTYPE x)
	{	/* compute squared magnitude of complex */
	FTYPE re = FFUN(creal)(x);
	FTYPE im = FFUN(cimag)(x);

	return (re * re + im * im);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
