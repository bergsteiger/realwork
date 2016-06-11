/* xxfmod.h -- common fmod[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(fmod))(FTYPE x, FTYPE y)
	{	/* compute fmod(x, y) */
	const short errx = FNAME(Dtest)(&x);
	const short erry = FNAME(Dtest)(&y);

	if (0 <= errx || 0 <= erry)
		{	/* x or y is 0, INF, or NAN */
		if (errx == _NANCODE)
			return (x);
		else if (erry == _NANCODE)
			return (y);
		else if (errx == _INFCODE || erry == 0)
			{	/* fmod(_INFCODE, y) or fmod(x, 0) */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		else
			return (x);	/* fmod(0, nonzero) or fmod(finite, INF) */
		}
	else
		{	/* fmod(finite, finite) */
		FTYPE t;
		short neg, ychar;
		long n;

		if (y < FLIT(0.0))
			y = -y;
		if (x < FLIT(0.0))
			x = -x, neg = 1;
		else
			neg = 0;
		for (t = y, FNAME(Dunscale)(&ychar, &t), n = 0; ; )
			{	/* subtract |y| until |x|<|y| */
			short xchar;

			t = x;
			if (n < 0 || FNAME(Dunscale)(&xchar, &t) == 0
				|| (n = (long)xchar - ychar) < 0)
				return (neg ? -x : x);
			for (; 0 <= n; --n)
				{	/* try to subtract |y|*2^n */
				t = y, FNAME(Dscale)(&t, n);
				if (t <= x)
					{
					x -= t;
					break;
					}
				}
			}
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
