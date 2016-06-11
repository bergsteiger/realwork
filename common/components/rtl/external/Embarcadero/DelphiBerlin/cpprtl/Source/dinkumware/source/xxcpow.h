/* xxcpow.h -- common cpow[fl] functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FFUN(cpow))(FCTYPE x, FCTYPE y)
	{	/* find complex x^y */
	if (!(FFUN(cimag)(x) == FLIT(0.0)))
		return (FFUN(cexp)(FNAME(Cmulcc)(y, FFUN(clog)(x))));
	else if (!(FFUN(cimag)(y) == FLIT(0.0)))
		return (FFUN(cexp)(FNAME(Cmulcr)(y, FFUN(log)(FFUN(creal)(x)))));
	else
		return (FNAME(Cbuild)(FFUN(pow)(FFUN(creal)(x), FFUN(creal)(y)),
			FLIT(0.0)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
