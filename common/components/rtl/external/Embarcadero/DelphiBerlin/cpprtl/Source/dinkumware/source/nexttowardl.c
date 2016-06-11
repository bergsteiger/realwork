/* nexttowardl function -- IEEE version */
#include "xmath.h"
_STD_BEGIN

long double (nexttowardl)(long double x, long double y)
	{	/* compute next value after x going toward y */
	unsigned short *const px = (unsigned short *)(char *)&x;
	short errx = _LDtest(&x);

	if (errx == _NANCODE)
		;
	else if (_LDtest(&y) == _NANCODE || x == y)
		x = y;
	else if (errx == _INFCODE)
		{	/* replace Inf with largest magnitude, same sign */

 #if _DLONG == 0	/* assume IEEE 754 8 byte */
		px[_D0] = px[_D0] & _DSIGN | (_DMAX << _DOFF) - 1;
		px[_D1] = 0xffff;
		px[_D2] = 0xffff;
		px[_D3] = 0xffff;

 #elif _DLONG == 1	/* assume IEEE 754 10 byte */
		px[_L0] = px[_L0] & _LSIGN | _LMAX - 1;
		px[_L1] = 0xffff;
		px[_L2] = 0xffff;
		px[_L3] = 0xffff;
		px[_L4] = 0xffff;

 #else	/* assume IEEE 754 16 byte */
		px[_L0] = px[_L0] & _LSIGN | _LMAX - 1;
		px[_L1] = 0xffff;
		px[_L2] = 0xffff;
		px[_L3] = 0xffff;
		px[_L4] = 0xffff;
		px[_L5] = 0xffff;
		px[_L6] = 0xffff;
		px[_L7] = 0xffff;
 #endif /* _DLONG */

		}
	else if (errx == 0)
		{	/* change zero to tiny */

 #if _DLONG == 0	/* assume IEEE 754 8 byte */
		px[_D0] = x < y ? 0 : _DSIGN;
		px[_D3] = 1;

 #elif _DLONG == 1	/* assume IEEE 754 10 byte */
		px[_L0] = x < y ? 0 : _LSIGN;
		px[_L4] = 1;

 #else	/* assume IEEE 754 16 byte */
		px[_L0] = x < y ? 0 : _LSIGN;
		px[_L7] = 1;
 #endif /* _DLONG */

		}
	else if (x < y && 0.0L < x || y < x && x < 0.0L)
		{	/* increment magnitude of x */

 #if _DLONG == 0	/* assume IEEE 754 8 byte */
		if ((++px[_D3] & 0xffff) == 0
			&& (++px[_D2] & 0xffff) == 0
			&& (++px[_D1] & 0xffff) == 0
			&& (++px[_D0] & ~_DSIGN) == _DMAX << _DOFF)
			_Feraise(_FE_OVERFLOW);

 #elif _DLONG == 1	/* assume IEEE 754 10 byte */
		if ((++px[_L4] & 0xffff) == 0
			&& (++px[_L3] & 0xffff) == 0
			&& (++px[_L2] & 0xffff) == 0
			&& (++px[_L1] & 0xffff) == 0)
			{	/* replace leading bit and check for Inf */
			px[_L1] = 0x8000;	/* make it Inf, not NaN */
			if ((++px[_L0] & _LMASK) == _LMAX)
				_Feraise(_FE_OVERFLOW);
			}

 #else	/* assume IEEE 754 16 byte */
		if ((++px[_L7] & 0xffff) == 0
			&& (++px[_L6] & 0xffff) == 0
			&& (++px[_L5] & 0xffff) == 0
			&& (++px[_L4] & 0xffff) == 0
			&& (++px[_L3] & 0xffff) == 0
			&& (++px[_L2] & 0xffff) == 0
			&& (++px[_L1] & 0xffff) == 0
			&& (++px[_L0] & _LMASK) == _LMAX)
			_Feraise(_FE_OVERFLOW);
 #endif /* _DLONG */

		}

 #if _DLONG == 0	/* assume IEEE 754 8 byte */
	else if ((--px[_D3] & 0xffff) == 0xffff	/* decrement magnitude of x */
		&& (--px[_D2] & 0xffff) == 0xffff
		&& (--px[_D1] & 0xffff) == 0xffff)
		--px[_D0];
	if ((px[_D0] & _DMASK) == 0)
		_Feraise(_FE_UNDERFLOW);

 #elif _DLONG == 1	/* assume IEEE 754 10 byte */
	else if ((--px[_L4] & 0xffff) == 0xffff	/* decrement magnitude of x */
		&& (--px[_L3] & 0xffff) == 0xffff
		&& (--px[_L2] & 0xffff) == 0xffff
		&& (--px[_L1] & 0xffff) < 0x8000)
		{	/* decrement exponent if not denormalized */
		if ((px[_L0] & _LMASK) != 0)
			{	/* renormalize with smaller exponent */
			if ((--px[_L0] & _LMASK) == 0)
				px[_L1] = 0x7fff;	/* denormalized, decrement 0x8000 */
			else
				px[_L1] = 0xffff;
			}
		}
	if ((px[_L0] & _LMASK) == 0)
		_Feraise(_FE_UNDERFLOW);

 #else	/* assume IEEE 754 16 byte */
	else if ((--px[_L7] & 0xffff) == 0xffff	/* decrement magnitude of x */
		&& (--px[_L6] & 0xffff) == 0xffff
		&& (--px[_L5] & 0xffff) == 0xffff
		&& (--px[_L4] & 0xffff) == 0xffff
		&& (--px[_L3] & 0xffff) == 0xffff
		&& (--px[_L2] & 0xffff) == 0xffff
		&& (--px[_L1] & 0xffff) == 0xffff)
		--px[_L0];
	if ((px[_L0] & _LMASK) == 0)
		_Feraise(_FE_UNDERFLOW);
 #endif /* _DLONG */

	return (x);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
