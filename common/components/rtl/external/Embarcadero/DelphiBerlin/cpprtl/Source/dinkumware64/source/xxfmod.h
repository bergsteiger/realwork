/* xxfmod.h -- common fmod[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(fmod))(FTYPE x, FTYPE y)
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

		FMAKEPOS(y);
		if (x < FLIT(0.0))
			{	/* negate x and remember sign */
			FNEGATE(x);
			neg = 1;
			}
		else
			neg = 0;
		for (t = y, FNAME(Dunscale)(&ychar, &t), n = 0; ; )
			{	/* subtract |y| until |x|<|y| */
			short xchar;

			t = x;
			if (n < 0 || FNAME(Dunscale)(&xchar, &t) == 0
				|| (n = (long)xchar - ychar) < 0)
				{	/* return signed result */
				if (neg)
					FNEGATE(x);
				return (x);
				}
			for (; 0 <= n; --n)
				{	/* try to subtract |y|*2^n */
				t = y, FNAME(Dscale)(&t, n);
				if (x < t)
					;
				else if (x == t)
					return (FLIT(0.0));
				else
					{	/* compute x -= t carefully */
					FNAME(Dunscale)(&xchar, &x);
					FNAME(Dscale)(&t, -xchar);
					x -= t;
					FNAME(Dscale)(&x, xchar);
					}
				}
			}
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
