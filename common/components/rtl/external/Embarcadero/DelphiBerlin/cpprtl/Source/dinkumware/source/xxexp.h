/* xxexp1.h -- common exp[fl] functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE (FFUN(exp))(FTYPE x)
	{	/* compute e^x */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	case _INFCODE:
		return (FISNEG(x) ? FLIT(0.0) : x);

	case 0:
		return (FLIT(1.0));

	default:	/* finite */
		FNAME(Exp)(&x, FLIT(1.0), 0);
		return (x);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
