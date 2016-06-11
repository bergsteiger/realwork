/* xxfdim.h -- common fdim[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(fdim))(FTYPE x, FTYPE y)
	{	/* compute larger of x-y and zero */
	if (FNAME(Dtest)(&x) == _NANCODE)
		return (x);
	else if (FNAME(Dtest)(&y) == _NANCODE)
		return (y);
	else if (x <= y)
		return (FLIT(0.0));
	else
		return (x - y);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
