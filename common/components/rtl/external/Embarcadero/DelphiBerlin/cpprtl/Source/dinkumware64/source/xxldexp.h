/* xxldexp.h -- common ldexp[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(ldexp))(FTYPE x, int xexp)
	{	/* compute ldexp(x, xexp) */
	if (xexp != 0 && FNAME(Dtest)(&x) < 0)
		switch (FNAME(Dscalex)(&x, xexp, 1))	/* round to nearest */
			{	/* report over/underflow */
		case 0:
			_Feraise(_FE_UNDERFLOW);
			break;
		case _INFCODE:
			_Feraise(_FE_OVERFLOW);
			}
	return (x);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
