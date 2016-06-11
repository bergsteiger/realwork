/* xxround.h -- common round[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(round))(FTYPE x)
	{	/* round x to nearest */
	switch (FNAME(Dint)(&x, 1))
		{	/* test for special codes */
	case _NANCODE:
	case _INFCODE:
		break;

	default:	/* zero or finite fraction */
		if (FNAME(Dint)(&x, 0) == 0)
			;	/* didn't have 0.5 bit set, do nothing */
		else if (FISNEG(x))
			x -= FLIT(1.0);
		else
			x += FLIT(1.0);
		break;
		}
	return (x);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
