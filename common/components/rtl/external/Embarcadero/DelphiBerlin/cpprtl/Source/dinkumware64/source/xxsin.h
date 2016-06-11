/* xxsin.h -- common sin[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(sin))(FTYPE x)
	{	/* compute sin(x) */
	return (FNAME(Sinx)(x, 0, 0));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
