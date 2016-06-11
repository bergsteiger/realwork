/* xxldexp.h -- common ldexp[fl] functionality */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 FTYPE (FFUN(ldexp))(FTYPE x, int xexp)
	{	/* compute ldexp(x, xexp) */
	if (xexp != 0 && FNAME(Dtest)(&x) < 0)
		switch (FNAME(Dscale)(&x, xexp))
			{	/* report over/underflow */
		case 0:
			_Feraise(_FE_UNDERFLOW);
			break;
		case _INFCODE:
			_Feraise(_FE_OVERFLOW);
			}
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
