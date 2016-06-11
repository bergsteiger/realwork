/* _Dtest function -- IEEE 754 version */
#include "xmath.h"
_STD_BEGIN

_CRTIMP2 short _Dtest(double *px)
	{	/* categorize *px */
	unsigned short *ps = (unsigned short *)(char *)px;

	if ((ps[_D0] & _DMASK) == _DMAX << _DOFF)
		return ((short)((ps[_D0] & _DFRAC) != 0 || ps[_D1] != 0
			|| ps[_D2] != 0 || ps[_D3] != 0 ? _NANCODE : _INFCODE));
	else if ((ps[_D0] & ~_DSIGN) != 0 || ps[_D1] != 0
		|| ps[_D2] != 0 || ps[_D3] != 0)
		return ((ps[_D0] & _DMASK) == 0 ? _DENORM : _FINITE);
	else
		return (0);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
