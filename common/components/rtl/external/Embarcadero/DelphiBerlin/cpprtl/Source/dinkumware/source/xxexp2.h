/* xxexp2.h -- common exp2[fl] functionality */
#include <limits.h>
#include "xmath.h"
_STD_BEGIN

static const FTYPE ln2 = FLIT(0.69314718055994530941723212145817658);

FTYPE (FFUN(exp2))(FTYPE x)
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
		if (x <= LONG_MIN || LONG_MAX <= x)
			xexp = 0;
		else
			{	/* pick off binary exponent to improve precision */
			FTYPE y = x;

			FNAME(Dint)(&y, 0);
			xexp = (short)y;
			x -= y;
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
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
