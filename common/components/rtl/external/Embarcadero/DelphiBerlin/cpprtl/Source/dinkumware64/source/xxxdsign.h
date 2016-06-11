/* xxxdsign.h -- common _[FL]Dsign functionality */
#include "xmath.h"
_C_LIB_DECL

int _CDECL FNAME(Dsign)(FTYPE x)
	{	/* test floating-point sign bit */
	return (FISNEG(x));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
