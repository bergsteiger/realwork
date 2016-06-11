/* _FDunscale function -- IEEE 754 version */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 short _FDunscale(short *pex, float *px)
	{	/* separate *px to 1/2 <= |frac| < 1 and 2^*pex */
	unsigned short *ps = (unsigned short *)(char *)px;
	short xchar = (ps[_F0] & _FMASK) >> _FOFF;

	if (xchar == _FMAX)
		{	/* NaN or INF */
		*pex = 0;
		return ((ps[_F0] & _FFRAC) != 0 || ps[_F1] != 0
			? _NANCODE : _INFCODE);
		}
	else if (0 < xchar || (xchar = _FDnorm(ps)) <= 0)
		{	/* finite, reduce to [1/2, 1) */
		ps[_F0] = ps[_F0] & ~_FMASK | _FBIAS << _FOFF;
		*pex = xchar - _FBIAS;
		return (_FINITE);
		}
	else
		{	/* zero */
		*pex = 0;
		return (0);
		}
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
