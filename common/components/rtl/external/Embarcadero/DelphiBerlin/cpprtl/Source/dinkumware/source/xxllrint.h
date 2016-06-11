/* xxllrint.h -- common llrint[fl] functionality */
#include <limits.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(nearbyint)(FTYPE x);

#define MYMIN	(-_LLONG_MAX - _C2)	/* LLONG_MIN */
#define MYMAX	_LLONG_MAX	/* LLONG_MAX */

_Longlong (FFUN(llrint))(FTYPE x)
	{	/* round x according to current mode, raising inexact */
	FTYPE y;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	default:	/* finite fraction */
		y = FFUN(nearbyint)(x);
		if (y != x)
			_Feraise(_FE_INEXACT);

		if ((FTYPE)MYMIN <= y && y <=(FTYPE)MYMAX)
			return ((_Longlong)y);

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
