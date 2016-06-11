/* xxllround.h -- common llround[fl] functionality */
#include <limits.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FFUN(round)(FTYPE x);

#define MYMIN	(-_LLONG_MAX - _C2)	/* LLONG_MIN */
#define MYMAX	_LLONG_MAX	/* LLONG_MAX */

_Longlong (FFUN(llround))(FTYPE x)
	{	/* round x to nearest */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	default:	/* finite fraction */
		x = FFUN(round)(x);
		if ((FTYPE)MYMIN <= x && x <= (FTYPE)MYMAX)
			return ((_Longlong)x);

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
