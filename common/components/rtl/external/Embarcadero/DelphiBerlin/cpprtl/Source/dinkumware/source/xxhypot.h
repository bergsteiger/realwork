/* xxhypot.h -- common hypot[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE (FFUN(hypot))(FTYPE x, FTYPE y)
	{	/* compute hypotenuse */
	int zexp;
	FTYPE z = FNAME(Hypot)(x, y, &zexp);

	if (zexp != 0)
		switch (FNAME(Dscale)(&z, zexp))
			{	/* report over/underflow */
		case 0:
			_Feraise(_FE_UNDERFLOW);
			break;
		case _INFCODE:
			_Feraise(_FE_OVERFLOW);
			}
	return (z);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
