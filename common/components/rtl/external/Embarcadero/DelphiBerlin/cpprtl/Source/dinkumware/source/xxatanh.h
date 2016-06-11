/* xxatanh.h -- common atanh[fl] functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE FFUN(log1p)(FTYPE);

FTYPE (FFUN(atanh))(FTYPE x)
	{	/* compute atanh(x) */
	FTYPE y;
	int neg;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case 0:
		return (x);
	default:	/* -INF or finite */
		if (x < FLIT(0.0))
			neg = 1, x = -x;
		else
			neg = 0;

		if (FLIT(1.0) < x)
			{	/* defined only for |x| < 1 */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		else if (x == FLIT(1.0))
			{	/* zero divide for |x| == 1 */
			_Feraise(_FE_DIVBYZERO);
			return (neg ? -FCONST(Inf) : FCONST(Inf));
			}
		else
			{	/* finite, compute it */
			y = FLIT(0.5) * FFUN(log1p)(FLIT(2.0) * x
				/ (FLIT(1.0) - x));
			return (neg ? -y : y);
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
