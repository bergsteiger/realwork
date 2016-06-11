/* xxatan2.h -- common atan2[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

static FTYPE FNAME(Atan2_divide)(FTYPE y, FTYPE x)
	{	/* compute y/x, correcting for FTZ */
	FTYPE ans = FDIV(y, x);

	if (ans == FLIT(0.0))
		{	/* underflow, try harder */
		short xexp, yexp;

		FNAME(Dunscale)(&xexp, &x);
		FNAME(Dunscale)(&yexp, &y);
		ans = FDIV(y, x);
		FNAME(Dscale)(&ans, yexp - xexp);
		}
	return (ans);
	}

FTYPE (_CDECL FFUN(atan2))(FTYPE y, FTYPE x)
	{	/* compute atan(y/x) */
	FTYPE z;
	const short errx = FNAME(Dtest)(&x);
	const short erry = FNAME(Dtest)(&y);
	unsigned short hex;

	if (errx <= 0 && erry <= 0)
		{	/* x & y both finite or 0 */
		if (FISNEG(y))
			{	/* make positive and remember sign */
			FNEGATE(y);
			hex = 0x8;
			}
		else
			hex = 0x0;
		if (FISNEG(x))
			{	/* make positive and remember sign */
			FNEGATE(x);
			hex ^= 0x6;
			}

		if (x < y)
			z = FNAME(Atan2_divide)(x, y), hex ^= 0x2;
		else if (errx < 0)
			z = FNAME(Atan2_divide)(y, x);
		else
			z = FLIT(0.0);
		}
	else if (erry == _NANCODE)
		return (y);
	else if (errx == _NANCODE)
		return (x);
	else
		{	/* at least one _INFCODE */
		z = errx == erry ? FLIT(1.0) : FLIT(0.0);
		hex = FISNEG(y) ? 0x8 : 0x0;
		if (FISNEG(x))
			hex ^= 0x6;
		if (erry == _INFCODE)
			hex ^= 0x2;
		}
	return (FNAME(Atan)(z, hex));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
