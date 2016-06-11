/* xxlround.h -- common lround[fl] functionality */
#include <limits.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(round)(FTYPE x);

long (FFUN(lround))(FTYPE x)
	{	/* round x to nearest */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	default:	/* finite fraction */
		x = FFUN(round)(x);
		if ((FTYPE)LONG_MIN <= x && x <= (FTYPE)LONG_MAX)
			return ((long)x);

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
