/* xxlrint.h -- common lrint[fl] functionality */
#include <limits.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(nearbyint)(FTYPE x);

long (FFUN(lrint))(FTYPE x)
	{	/* round x according to current mode, raising inexact */
	FTYPE y;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	default:	/* finite fraction */
		y = FFUN(nearbyint)(x);
		if (y != x)
			_Feraise(_FE_INEXACT);

		if ((FTYPE)LONG_MIN <= y && y <= (FTYPE)LONG_MAX)
			return ((long)y);

	case _NANCODE:	/* fall through */
	case _INFCODE:
		_Feraise(_FE_INVALID);

	case 0:	/* fall through */
		return (0);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
