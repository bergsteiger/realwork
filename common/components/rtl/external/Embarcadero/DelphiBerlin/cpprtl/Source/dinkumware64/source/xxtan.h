/* xxtan.h -- common tan[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FNAME(Tan))(FTYPE x, int quads);

FTYPE (_CDECL FFUN(tan))(FTYPE x)
	{	/* compute tan(x) */
	return (FNAME(Tan)(x, 0));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
