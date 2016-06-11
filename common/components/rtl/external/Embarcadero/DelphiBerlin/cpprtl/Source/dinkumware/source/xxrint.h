/* xxrint.h -- common rint[fl] functionality */
#include <fenv.h>
#include "xmath.h"
_STD_BEGIN

FTYPE FNAME(Rint)(FTYPE x);

FTYPE (FFUN(rint))(FTYPE x)
	{	/* round x according to current mode, raise inexact as needed */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case _INFCODE:
	case 0:
		return (x);

	default:
		 {	/* finite fraction */
		FTYPE y = FNAME(Rint)(x);

		if (y != x)
			_Feraise(_FE_INEXACT);
		return (y);
		 }
		}
		}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
