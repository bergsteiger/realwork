/* xxfabs.h -- common fabs[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(fabs))(FTYPE x)
	{	/* compute |x| */
	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
		return (FFUN(copysign)(x, FLIT(0.0)));

	default:	/* Inf, zero, or finite */
		FMAKEPOS(x);
		return (x);
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
