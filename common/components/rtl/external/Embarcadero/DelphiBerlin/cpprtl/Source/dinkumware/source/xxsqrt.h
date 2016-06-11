/* xxsqrt.h -- common sqrt[fl] functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE (FFUN(sqrt))(FTYPE x)
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
		y += x / y;
		y = FLIT(0.25) * y + x / y;	/* 27 bits */

 #if   FBITS <= 27

 #elif FBITS <= 56
		y = FLIT(0.5) * (y + x / y);	/* 56 bits */

 #elif FBITS <= 113
		y += x / y;
		y = FLIT(0.25) * y + x / y;	/* 113 bits */

 #else /* FBITS */
  #error sqrt has insufficient precision
 #endif /* FBITS */

		FNAME(Dscale)(&y, xexp / 2);
		return (y);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
