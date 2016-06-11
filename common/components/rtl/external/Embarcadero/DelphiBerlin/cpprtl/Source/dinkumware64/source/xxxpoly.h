/* xxxpoly.h -- common _[FL]Poly functionality */
#include "xmath.h"
_C_LIB_DECL

 #if defined(__OXILI_CLRUNTIME)	/* compiler test */
FTYPE __attribute__((overloadable)) FNAME(Poly)(FTYPE x,
	const FTYPE *tab, int n)
	{	/* compute polynomial */
	FTYPE y;

	for (y = *tab; 0 <= --n; )
		y = y * x + *++tab;
	return (y);
	}

FTYPE __attribute__((overloadable)) FNAME(Poly)(FTYPE x,
	_EXTERN_CONST FTYPE *tab, int n)
	{	/* compute polynomial */
	FTYPE y;

	for (y = *tab; 0 <= --n; )
		y = y * x + *++tab;
	return (y);
	}

 #else /* defined(__OXILI_CLRUNTIME) */
FTYPE FNAME(Poly)(FTYPE x, const FTYPE *tab, int n)
	{	/* compute polynomial */
	FTYPE y;

	for (y = *tab; 0 <= --n; )
		y = y * x + *++tab;
	return (y);
	}
 #endif /* defined(__OXILI_CLRUNTIME) */

_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
