/* xxceil.h -- common ceil[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(ceil))(FTYPE x)
	{	/* compute ceil(x) */
	FTYPE y = x;

	return (FNAME(Dint)(&y, 0) < 0 && FLIT(0.0) < x ? y + FLIT(1.0) : y);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
