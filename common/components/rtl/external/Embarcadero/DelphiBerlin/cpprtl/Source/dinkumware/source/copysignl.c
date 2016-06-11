/* copysignl function */
#include "xmath.h"
_STD_BEGIN

long double (copysignl)(long double x, long double y)
	{	/* copy sign from y to x */
	unsigned short *const px = (unsigned short *)(char *)&x + _L0;
	unsigned short *const py = (unsigned short *)(char *)&y + _L0;

	*px = *px & ~_LSIGN | *py & _LSIGN;
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
