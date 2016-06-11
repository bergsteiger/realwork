/* xxmodf.h -- common modf[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(modf))(FTYPE x, FTYPE *pint)
	{	/* compute modf(x, &intpart) */
	*pint = x;
	switch (FNAME(Dint)(pint, 0))
		{	/* test for special codes */
	case _NANCODE:
		return (x);

	case _INFCODE:
	case 0:
		return (FISNEG(x) ? -FNAME(Zero) : FLIT(0.0));

	default:	/* finite */
		if (*pint == FLIT(0.0))
			return (x);
		else
			return (x - *pint);
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
