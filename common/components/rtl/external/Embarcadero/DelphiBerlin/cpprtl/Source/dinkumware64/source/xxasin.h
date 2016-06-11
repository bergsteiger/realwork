/* xxasin.h -- common asin[fl] functionality */
#include "xmath.h"
_C_LIB_DECL

	/* coefficients */

 #if FBITS <= 24
  #define CPOLY(x)	((((c[0] * x + c[1]) * x) + c[2]) * x + c[3])
  #define SPOLY(x)	((((s[0] * x + s[1]) * x) + s[2]) * x + s[3])

_STATIC_CONST FTYPE c[] = {	/* asin(x), |x| <= 0.28 */
	FLIT(-0.5502915502e-1),
	FLIT( 0.5774048001),
	FLIT(-1.3957927402),
	FLIT( 0.9278244000),
	};
_STATIC_CONST FTYPE s[] = {
	FLIT(-0.2205875623e-1),
	FLIT( 0.4143602999),
	FLIT(-1.2411553540),
	FLIT( 0.9278243915),
	};
 #endif /* FBITS <= 30 */

_STATIC_CONST FTYPE rthalf = FLIT(0.70710678118654752440084436210484905);

FTYPE (_CDECL FFUN(asin))(FTYPE x)
	{	/* compute asin(x) */
	unsigned short hex;

	switch (FNAME(Dtest)(&x))
		{	/* test for special codes */
	case _NANCODE:
	case 0:
		return (x);

	default:	/* FINITE or INF */
		if (x < FLIT(0.0))
			{	/* make positive and remember sign */
			FNEGATE(x);
			hex = 0x8;
			}
		else
			hex = 0x0;

		if (x < FCONST(Rteps))
			{	/* correct sign and return result */
			if (hex != 0)
				FNEGATE(x);
			return (x);
			}

 #ifdef SPOLY
		else if (x <= FLIT(0.28))
			{	/* return approximation */
			FTYPE xsq = x * x;

			x = FDIV(x * SPOLY(xsq), CPOLY(xsq));
			if (hex != 0)
				FNEGATE(x);
			return (x);
			}
 #endif /* SPOLY */

		else if (x <= rthalf)
			return (FNAME(Atan)(FDIV(x,
				FFUN(sqrt)((FLIT(1.0) - x)
					* (FLIT(1.0) + x))), hex));
		else if (x <= FLIT(1.0))
			return (FNAME(Atan)(FDIV(FFUN(sqrt)(FLIT(1.0) - x)
				* FFUN(sqrt)(FLIT(1.0) + x), x), hex ^ 0x2));
		else
			{	/* 1 < |x| */
			_Feraise(_FE_INVALID);
			return (FCONST(Nan));
			}
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
