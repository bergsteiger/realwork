/* xxfabs.h -- common fabs[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(fabs))(FTYPE x)
	{	/* compute |x| */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);
	case _INFCODE:
		return (FCONST(Inf));
	case 0:
		return (FLIT(0.0));
	default:	/* finite */
		return (x < FLIT(0.0) ? -x : x);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
