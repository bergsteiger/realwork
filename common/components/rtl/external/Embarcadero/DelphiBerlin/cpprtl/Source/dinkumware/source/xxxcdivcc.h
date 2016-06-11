/* xxxcdivcc.h -- common _[FL]Cdivcc functionality */
#include <complex.h>
#include "xmath.h"
_STD_BEGIN

FCTYPE (FNAME(Cdivcc))(FCTYPE x, FCTYPE y)
	{	/* find complex quotient */
	FTYPE xre = FFUN(creal)(x);
	FTYPE xim = FFUN(cimag)(x);
	FTYPE yre = FFUN(creal)(y);
	FTYPE yim = FFUN(cimag)(y);
	FTYPE zre;
	FTYPE zim;

	if ((yim < 0 ? -yim : +yim) < (yre < 0 ? -yre : +yre))
		{	/* |yim| < |yre| */
		FTYPE wr = yim / yre;
		FTYPE wd = yre + wr * yim;

		zre = (xre + xim * wr) / wd;
		zim = (xim - xre * wr) / wd;
		}
	else
		{	/* 0 < |yre| <= |yim| */
		FTYPE wr = yre / yim;
		FTYPE wd = yim + wr * yre;

		zre = (xre * wr + xim) / wd;
		zim = (xim * wr - xre) / wd;
		}
	return (FNAME(Cbuild)(zre, zim));
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
