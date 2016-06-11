/* xxexp2.h -- common exp2[fl] functionality */
#include <limits.h>
#include "xmath.h"
_C_LIB_DECL

_STATIC_CONST FTYPE ln2 = FLIT(0.69314718055994530941723212145817658);

FTYPE (_CDECL FFUN(exp2))(FTYPE x)
	{	/* compute 2^x */
	long xexp;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	case _INFCODE:
		return (FISNEG(x) ? FLIT(0.0) : x);

	case 0:
		return (FLIT(1.0));

	default:	/* finite */
		if (x <= (FTYPE)LONG_MIN)
			return (FLIT(0.0));
		else if ((FTYPE)LONG_MAX <= x)
			return (FCONST(Inf));
		else
			{	/* pick off binary exponent to improve precision */
			xexp = (long)x;
			x -= (FTYPE)xexp;
			if (FLIT(0.5) < x)
				{	/* exponentiate smaller positive fraction */
				x -= FLIT(1.0);
				++xexp;
				}
			else if (x < -FLIT(0.5))
				{	/* exponentiate smaller negative fraction */
				x += FLIT(1.0);
				--xexp;
				}
			}
		x *= ln2;
		FNAME(Exp)(&x, FLIT(1.0), xexp);
		return (x);
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
