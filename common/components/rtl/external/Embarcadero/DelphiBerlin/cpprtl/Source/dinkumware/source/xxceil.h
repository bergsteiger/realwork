/* xxceil.h -- common ceil[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(ceil))(FTYPE x)
	{	/* compute ceil(x) */
	FTYPE y = x;

	return (FNAME(Dint)(&y, 0) < 0 && FLIT(0.0) < x ? y + FLIT(1.0) : y);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
