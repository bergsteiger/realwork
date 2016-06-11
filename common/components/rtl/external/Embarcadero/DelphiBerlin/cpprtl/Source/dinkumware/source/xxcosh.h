/* xxcosh.h -- common cosh[fl] functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE (FFUN(cosh))(FTYPE x)
	{	/* compute cosh(x) */
	return (FNAME(Cosh)(x, FLIT(1.0)));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
