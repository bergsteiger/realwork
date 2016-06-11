/* xxatan.h -- common atan[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

FTYPE (_CDECL FFUN(atan))(FTYPE x)
	{	/* compute atan(x) */
	unsigned short hex;
	_STATIC_CONST FTYPE piby2 = FLIT(1.5707963267948966192313216916397515);

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case 0:
		return (x);

	case _INFCODE:
		return (FISNEG(x) ? -piby2 : piby2);

	default:	/* finite */
		if (x < FLIT(0.0))
			{	/* make positive and remember sign */
			FNEGATE(x);
			hex = 0x8;
			}
		else
			hex = 0x0;

		if (FLIT(1.0) < x)
			{	/* make x < 1 and remember inversion */
			x = FINVERT(x);
			hex ^= 0x2;
			}
		return (FNAME(Atan)(x, hex));
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
