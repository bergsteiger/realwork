/* xxlogb.h -- common logb[fl] functionality */
#include <float.h>
#include "xmath.h"
_STD_BEGIN

 #if FLT_RADIX != 2
  #error correct only for FLT_RADIX == 2
 #endif /* FLT_RADIX != 2 */

FTYPE (FFUN(logb))(FTYPE x)
	{	/* compute logb(x) */
	short xexp;

	switch (FNAME(Dunscale)(&xexp, &x))
		{	/* test for special codes */
	case _NANCODE:
		return (x);
	case 0:
		_Feraise(_FE_DIVBYZERO);
		return (-FCONST(Inf));
	case _INFCODE:
		return (FCONST(Inf));	/* INF */
	default:	/* finite */
		return ((FTYPE)--xexp);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
