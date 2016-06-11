/* xxfmin.h -- common fmin[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(fmin))(FTYPE x, FTYPE y)
	{	/* compute larger of x and y */
	if (FNAME(Dtest)(&x) == _NANCODE)
		return (y);
	else if (FNAME(Dtest)(&y) == _NANCODE)
		return (x);
	else if (x < y || x == y && FISNEG(x))
		return (x);
	else
		return (y);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
