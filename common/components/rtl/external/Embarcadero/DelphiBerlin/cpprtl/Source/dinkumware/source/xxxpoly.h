/* xxxpoly.h -- common _[FL]Poly functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE FNAME(Poly)(FTYPE x, const FTYPE *tab, int n)
	{	/* compute polynomial */
	FTYPE y;

	for (y = *tab; 0 <= --n; )
		y = y * x + *++tab;
	return (y);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
