/* xxacosh.h -- common acosh[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

_STATIC_CONST FTYPE ln2 = FLIT(0.69314718055994530941723212145817658);

FTYPE (_CDECL FFUN(acosh))(FTYPE x)
	{	/* compute acosh(x) */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	case _INFCODE:
		if (!FISNEG(x))
			return (x);

	case 0:
	default:	/* -INF or finite */
		if (x < FLIT(1.0))
			{	/* defined only for 1 <= x */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		else if (x == FLIT(1.0))
			return (FLIT(0.0));

 #if FBITS <= 24
		else if (x < FLIT(1.002))
			{
			FTYPE z = x - FLIT(1.0);

			return (FFUN(sqrt)(z * x + z)
				* (FLIT(1.0) - FLIT(0.3330667) * z));
			}
 #endif /* FBITS <= 24 */

		else if (x < FDIV(FLIT(2.0), FCONST(Eps)))
			{	/* not big, compute carefully */
			FTYPE z = x - FLIT(1.0);

			return (FFUN(log1p)(z + FFUN(sqrt)(z * x + z)));
			}
		else
			return (FFUN(log)(x) + ln2);	/* x big, compute log(x+x) */
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
