/* xxhypot.h -- common hypot[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(hypot))(FTYPE x, FTYPE y)
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
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
