/* xxlog10.h -- common log10[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(log10))(FTYPE x)
	{	/* compute ln(x) */
	return (FNAME(Log)(x, 1));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
