/* xxatan2.h -- common atan2[fl] functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE (FFUN(atan2))(FTYPE  y, FTYPE x)
	{	/* compute atan(y/x) */
	FTYPE z;
	const short errx = FNAME(Dtest)(&x);
	const short erry = FNAME(Dtest)(&y);
	unsigned short hex;

	if (errx <= 0 && erry <= 0)
		{	/* x & y both finite or 0 */
		if (FISNEG(y))
			y = -y, hex = 0x8;
		else
			hex = 0x0;
		if (FISNEG(x))
			x = -x, hex ^= 0x6;
		if (x < y)
			z = x / y, hex ^= 0x2;
		else if (errx < 0)
			z = y / x;
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
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
