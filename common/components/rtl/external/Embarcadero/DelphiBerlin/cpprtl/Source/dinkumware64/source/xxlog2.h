/* xxlog2.h -- common log2[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(log2))(FTYPE x)
	{	/* compute log2(x) */
	return (FNAME(Log)(x, -1));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
