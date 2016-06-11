/* xxilogb.h -- common ilogb[fl] functionality */
#include <float.h>
#include <limits.h>
#include "xmath.h"
_STD_BEGIN

 #if FLT_RADIX != 2
  #error correct only for FLT_RADIX == 2
 #endif /* FLT_RADIX != 2 */

int (FFUN(ilogb))(FTYPE x)
	{	/* compute ilogb(x) */
	short xexp;

	switch (FNAME(Dunscale)(&xexp, &x))
		{	/* test for special codes */
	case _NANCODE:
		return (_FP_ILOGBNAN);
	case 0:
		return (_FP_ILOGB0);
	case _INFCODE:
		return (INT_MAX);	/* INF */
	default:	/* finite */
		return (--xexp);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
