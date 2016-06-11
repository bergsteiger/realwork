/* nexttoward function -- IEEE version */
#include "xmath.h"
_STD_BEGIN

double (nexttoward)(double x, long double y)
	{	/* compute next value after x going toward y */
	unsigned short *const px = (unsigned short *)(char *)&x;
	short errx = _Dtest(&x);

	if (errx == _NANCODE)
		;
	else if (_LDtest(&y) == _NANCODE || x == y)
		x = y;
	else if (errx == _INFCODE)
		{	/* replace Inf with largest magnitude, same sign */
		px[_D0] = px[_D0] & _DSIGN | (_DMAX << _DOFF) - 1;
		px[_D1] = 0xffff;
		px[_D2] = 0xffff;
		px[_D3] = 0xffff;
		}
	else if (errx == 0)
		{	/* change zero to tiny */
		px[_D0] = x < y ? 0 : _DSIGN;
		px[_D3] = 1;
		}
	else if (x < y && 0.0 < x || y < x && x < 0.0)
		{	/* increment magnitude of x */
		if ((++px[_D3] & 0xffff) == 0
			&& (++px[_D2] & 0xffff) == 0
			&& (++px[_D1] & 0xffff) == 0
			&& (++px[_D0] & ~_DSIGN) == _DMAX << _DOFF)
			_Feraise(_FE_OVERFLOW);
		}
	else if ((--px[_D3] & 0xffff) == 0xffff	/* decrement magnitude of x */
		&& (--px[_D2] & 0xffff) == 0xffff
		&& (--px[_D1] & 0xffff) == 0xffff)
		--px[_D0];

	if ((px[_D0] & _DMASK) == 0)
		_Feraise(_FE_UNDERFLOW);
	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
