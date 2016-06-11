/* xxasinh.h -- common asinh[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

_STATIC_CONST FTYPE ln2 = FLIT(0.69314718055994530941723212145817658);

FTYPE (_CDECL FFUN(asinh))(FTYPE x)
	{	/* compute asinh(x) */
	FTYPE y;
	int neg;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case _INFCODE:
	case 0:
		return (x);
	default:	/* -INF or finite */
		if (x < FLIT(0.0))
			{	/* make positive and remember sign */
			FNEGATE(x);
			neg = 1;
			}
		else
			neg = 0;

		if (x < FCONST(Eps))
			y = x;
		else if (x < FDIV(FLIT(2.0), FCONST(Eps)))
			y = FFUN(log1p)(x
				+ x * FDIV(x, (FLIT(1.0) + FFUN(sqrt)(x * x + FLIT(1.0)))));
		else
			y = FFUN(log)(x) + ln2;	/* x big, compute log(x+x) */

		if (neg)
			FNEGATE(y);
		return (y);
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
