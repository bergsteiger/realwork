/* nexttowardf function -- IEEE version */
#include "xmath.h"
_STD_BEGIN

float (nexttowardf)(float x, long double y)
	{	/* compute next value after x going toward y */
	unsigned short *const px = (unsigned short *)(char *)&x;
	short errx = _FDtest(&x);

	if (errx == _NANCODE)
		;
	else if (_LDtest(&y) == _NANCODE || x == y)
		x = y;
	else if (errx == _INFCODE)
		{	/* replace Inf with largest magnitude, same sign */
		px[_F0] = px[_F0] & _FSIGN | (_FMAX << _FOFF) - 1;
		px[_F1] = 0xffff;
		}
	else if (errx == 0)
		{	/* change zero to tiny */
		px[_F0] = x < y ? 0 : _FSIGN;
		px[_F1] = 1;
		}
	else if (x < y && 0.0F < x || y < x && x < 0.0F)
		{	/* increment magnitude of x */
		if ((++px[_F1] & 0xffff) == 0
			&& (++px[_F0] & ~_FSIGN) == _FMAX << _FOFF)
			_Feraise(_FE_OVERFLOW);
		}
	else if ((--px[_F1] & 0xffff) == 0xffff)	/* decrement magnitude of x */
		--px[_F0];

	if ((px[_F0] & _FMASK) == 0)
		_Feraise(_FE_UNDERFLOW);
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
