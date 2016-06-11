/* xxsqrt.h -- common sqrt[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(sqrt))(FTYPE x)
	{	/* compute x^(1/2) */
	short xexp;
	FTYPE y;

	switch (FNAME(Dunscale)(&xexp, &x))
		{	/* test for special codes */
	case _NANCODE:
	case 0:
		return (x);
	case _INFCODE:
		if (!FISNEG(x))
			return (x);	/* INF */
	default:	/* -INF or finite */
		if (FISNEG(x))
			{	/* sqrt undefined for reals */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		if ((unsigned int)xexp & 1)
			x *= FLIT(2.0), --xexp;
		y = (FLIT(-0.09977) * x + FLIT(0.71035)) * x
			+ FLIT(0.38660);	/* 6 bits */
		y += FDIV(x, y);
		y = FLIT(0.25) * y + FDIV(x, y);	/* 27 bits */

 #if   FBITS <= 27

 #elif FBITS <= 56
		y = FLIT(0.5) * (y + FDIV(x, y));	/* 56 bits */

 #elif FBITS <= 113
		y += FDIV(x, y);
		y = FLIT(0.25) * y + FDIV(x, y);	/* 113 bits */

 #else /* FBITS */
  #error sqrt has insufficient precision
 #endif /* FBITS */

		FNAME(Dscale)(&y, xexp / 2);
		return (y);
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
