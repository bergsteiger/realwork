/* xxnearbyint.h -- common nnearbyint[fl] functionality */
#include "xmath.h"
_STD_BEGIN

FTYPE FNAME(Rint)(FTYPE x);

FTYPE (FFUN(nearbyint))(FTYPE x)
	{	/* round x according to current mode, don't raise inexact */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case _INFCODE:
	case 0:
		return (x);

	default:
		return (FNAME(Rint)(x));
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
