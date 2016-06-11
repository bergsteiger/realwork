/* xxxhypot.h -- common _[FL]Hypot functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE FNAME(Hypot)(FTYPE x, FTYPE y, int *pexp)
	{	/* compute hypotenuse with scale factor */
	short xexp, yexp;
	short errx = FNAME(Dunscale)(&xexp, &x);
	short erry = FNAME(Dunscale)(&yexp, &y);

	*pexp = 0;
	if (errx == _INFCODE || erry == _INFCODE)
		return (FCONST(Inf));
	else if (errx == _NANCODE)
		return (x);
	else if (erry == _NANCODE)
		return (y);
	else
		{	/* x and y are finite */
		FTYPE z;

		if (x < FLIT(0.0))
			x = -x;
		if (y < FLIT(0.0))
			y = -y;

		if (y == FLIT(0.0))
			{	/* |y| <= x, check for (0, 0) */
			if (x == FLIT(0.0))
				return (FLIT(0.0));	/* |(0, 0)| == 0 */
			}
		else if (x == FLIT(0.0) || xexp < yexp || xexp == yexp && x < y)
			{	/* ensure that |y| < |x| */
			short texp = xexp;
			FTYPE tmp = x;

			xexp = yexp;
			yexp = texp;
			x = y;
			y = tmp;
			}

		if ((*pexp = (xexp / 4) * 2) == 0)
			*pexp = 2;
		FNAME(Dscale)(&x, xexp - *pexp);
		FNAME(Dscale)(&y, yexp - *pexp);

		z = x - y;
		if (z == x)
			;	/* y unimportant */
		else if (y < z)
			{	/* use simple approximation */
			const FTYPE qv = x / y;
			z = x + y / (qv + FFUN(sqrt)(qv * qv + FLIT(1.0)));
			}
		else
			{	/* use 1 1/2 precision to preserve bits */
			static const FTYPE root2 =
				FLIT(1.4142135623730950488016887242096982);
			static const FTYPE oneplusroot2high = FLIT(2.4142);
			static const FTYPE oneplusroot2low =
				FLIT(0.0000135623730950488016887242096980785698);
			const FTYPE qv = z / y;
			const FTYPE rv = (qv + FLIT(2.0)) * qv;
			const FTYPE sv = rv / (root2 + FFUN(sqrt)(rv + FLIT(2.0)))
				+ oneplusroot2low + qv + oneplusroot2high;
			z = x + y / sv;
			}
		return (z);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
