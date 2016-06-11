/* copysignf function */
#include "xmath.h"
_STD_BEGIN

float (copysignf)(float x, float y)
	{	/* copy sign from y to x */
	unsigned short *const px = (unsigned short *)(char *)&x + _F0;
	unsigned short *const py = (unsigned short *)(char *)&y + _F0;

	*px = *px & ~_FSIGN | *py & _FSIGN;
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
