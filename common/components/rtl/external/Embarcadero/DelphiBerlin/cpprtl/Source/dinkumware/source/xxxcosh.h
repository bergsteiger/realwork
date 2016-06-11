/* xxcosh.h -- common _[FL]Cosh functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE FNAME(Cosh)(FTYPE x, FTYPE y)
	{	/* compute cosh(x)*y */
	const short errx = FNAME(Dtest)(&x);
	const short erry = FNAME(Dtest)(&y);

	if (0 <= errx || 0 <= erry)
		{	/* x or y is 0, Inf, or NAN */
		if (errx == _NANCODE)
			return (x);	/* cosh(NaN)*y */
		else if (erry == _NANCODE)
			return (y);	/* cosh(x)*NaN */
		else if (errx == _INFCODE)
			if (erry != 0)
				return (y < FLIT(0.0) ? -FCONST(Inf)
					: FCONST(Inf));	/* cosh(Inf)*{finite or Inf} */
			else
				{	/* cosh(Inf)*0, report invalid */
				_Feraise(_FE_INVALID);
				return (FCONST(Nan));
				}
		else
			return (y);	/* cosh(0)*y or cosh(finite)*{0 or Inf} */
			}
	else
		{	/* x and y finite */
		if (x < FLIT(0.0))
			x = -x;

		if (x < FNAME(Xbig))
			{	/* worth adding in exp(-x) */
			FNAME(Exp)(&x, FLIT(1.0), -1);
			return (y * (x + FLIT(0.25) / x));
			}
		else
			{	/* x large, compute y*exp(x)/2 */
			FNAME(Exp)(&x, y, -1);
			return (x);
			}
		}
					}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
