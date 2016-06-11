/* xxmremainder.h -- common remainder[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(remquo)(FTYPE, FTYPE, int *);

FTYPE (FFUN(remainder))(FTYPE x, FTYPE y)
	{	/* compute remainder of x/y */
	return (FFUN(remquo)(x, y, 0));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
