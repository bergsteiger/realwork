/* xxcbrt.h -- common cbrt[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(cbrt))(FTYPE x)
	{	/* compute x^(1/3) */
	short xexp;
	FTYPE y;
	int fix;

	switch (FNAME(Dunscale)(&xexp, &x))
		{	/* test for special codes */
	case _NANCODE:
	case 0:
	case _INFCODE:
		return (x);
	default:	/* -INF or finite */
		for (fix = 0; (xexp / 3) * 3 != xexp; ++xexp)
			--fix;
		if (fix < 0)
			FNAME(Dscale)(&x, fix);
		if (!FISNEG(x))
			fix = 0;
		else
			fix = 1, x = -x;

		y = ((FLIT(0.24379) * x + FLIT(0.95807)) * x + FLIT(0.07892))
			/ (x + FLIT(0.27962));	/* 10 bits */
		y = FLIT(0.5) * (y + FLIT(1.5) * x
			/ (y * y + FLIT(0.5) * x / y));	/* 30 bits */

 #if   FBITS <= 30

 #elif FBITS <= 92
		y = FLIT(0.5) * (y + FLIT(1.5) * x
			/ (y * y + FLIT(0.5) * x / y));	/* 92 bits */

 #elif FBITS <= 278
		y = FLIT(0.5) * (y + FLIT(1.5) * x
			/ (y * y + FLIT(0.5) * x / y));	/* 92 bits */
		y = FLIT(0.5) * (y + FLIT(1.5) * x
			/ (y * y + FLIT(0.5) * x / y));	/* 278 bits */

 #else /* FBITS */
  #error cbrt has insufficient precision
 #endif /* FBITS */

		if (fix)
			y = -y;
		FNAME(Dscale)(&y, xexp / 3);
		return (y);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
