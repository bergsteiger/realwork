/* xxxdclass.h -- common _[FL]Dclass functionality */
#include "xmath.h"
_C_LIB_DECL

int _CDECL FNAME(Dclass)(FTYPE x)
	{	/* test floating-point classification */
	return (FNAME(Dtest)(&x));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
