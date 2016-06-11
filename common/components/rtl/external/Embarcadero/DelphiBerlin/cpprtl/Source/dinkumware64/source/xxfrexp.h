/* xxfrexp.h -- common frexp[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(frexp))(FTYPE x, int *pexp)
	{	/* compute frexp(x, &i) */
	short binexp;

	FNAME(Dunscale)(&binexp, &x);
	*pexp = binexp;
	return (x);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
