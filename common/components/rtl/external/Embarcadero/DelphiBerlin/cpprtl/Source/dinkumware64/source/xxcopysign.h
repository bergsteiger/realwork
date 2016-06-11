/* xxcopysign.h -- common copysign[fl] functionality */
#include "xmath.h"
_C_LIB_DECL
FTYPE (_CDECL FFUN(copysign))(FTYPE x, FTYPE y)
	{	/* copy sign from y to x */
	if (FISNEG(y))
		FMAKENEG(x);
	else
		FMAKEPOS(x);
	return (x);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
