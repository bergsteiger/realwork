/* xxsinh.h -- common sinh[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(sinh))(FTYPE x)
	{	/* compute sinh(x) */
	return (FNAME(Sinh)(x, FLIT(1.0)));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
