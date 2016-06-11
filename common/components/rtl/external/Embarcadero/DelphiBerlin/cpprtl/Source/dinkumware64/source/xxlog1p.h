/* xxlog1p.h -- common log1p[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(log1p))(FTYPE x)
	{	/* compute log(1+x) */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case 0:
		return (x);

	case _INFCODE:
		if (!FISNEG(x))
			return (x);

	default:	/* -INF or finite */
		if (x < FLIT(-1.0))
			{	/* undefined for 1+x < 0 */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		else if (x == FLIT(-1.0))
			{	/* pole at 1+x == 0 */
			_Feraise(_FE_DIVBYZERO);
			return (-FCONST(Inf));
			}
		else if (-FCONST(Eps) <= x && x < FCONST(Eps))
			return (x);
		else
			{	/* compute log(1+x) with fixup for small x */
			FTYPE y = FLIT(1.0) + x;

			return (FFUN(log)(y) - (((y - FLIT(1.0)) - x) * FINVERT(y)));
			}
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
