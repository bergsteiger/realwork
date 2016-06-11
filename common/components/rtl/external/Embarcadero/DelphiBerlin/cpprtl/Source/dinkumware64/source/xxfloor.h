/* xxfloor.h -- common floor[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(floor))(FTYPE x)
	{	/* compute floor(x) */
	FTYPE y = x;

	return (FNAME(Dint)(&y, 0) < 0 && x < FLIT(0.0) ? y - FLIT(1.0) : y);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
