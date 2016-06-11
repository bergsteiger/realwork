/* xxexp1.h -- common exp[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(exp))(FTYPE x)
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
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
