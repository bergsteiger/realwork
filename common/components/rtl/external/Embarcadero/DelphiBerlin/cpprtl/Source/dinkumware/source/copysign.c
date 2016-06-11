/* copysign function */
#include "xmath.h"
_STD_BEGIN

double (copysign)(double x, double y)
	{	/* copy sign from y to x */
	unsigned short *const px = (unsigned short *)(char *)&x + _D0;
	unsigned short *const py = (unsigned short *)(char *)&y + _D0;

	*px = *px & ~_DSIGN | *py & _DSIGN;
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
