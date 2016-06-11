/* _LDtest function -- IEEE 754 version */
#include "xmath.h"
_STD_BEGIN

 #if _DLONG == 0
_CRTIMP2 short _LDtest(long double *px)
	{	/* categorize *px -- 64-bit */
	return (_Dtest((double *)px));
	}

 #elif _DLONG == 1
_CRTIMP2 short _LDtest(long double *px)
	{	/* categorize *px -- 80-bit */
	unsigned short *ps = (unsigned short *)(char *)px;
	short xchar = ps[_L0] & _LMASK;

	if (xchar == _LMAX)
		return ((ps[_L1] & 0x7fff) != 0 || ps[_L2] != 0
			|| ps[_L3] != 0 || ps[_L4] != 0 ? _NANCODE : _INFCODE);
	else if (0 < xchar || ps[_L1] != 0 || ps[_L2] || ps[_L3]
		|| ps[_L4])
		return (ps[_L1] < 0x8000 ? _DENORM : _FINITE);
	else
		return (0);
	}

 #else	/* 1 < _DLONG */
_CRTIMP2 short _LDtest(long double *px)
	{	/* categorize *px -- 128-bit SPARC */
	unsigned short *ps = (unsigned short *)(char *)px;
	short xchar = ps[_L0] & _LMASK;

	if (xchar == _LMAX)
		return (ps[_L1] != 0 || ps[_L2] != 0 || ps[_L3] != 0
			|| ps[_L4] != 0 || ps[_L5] != 0 || ps[_L6] != 0
			|| ps[_L7] != 0 ? _NANCODE : _INFCODE);
	else if (0 < xchar || ps[_L1] != 0 || ps[_L2] != 0 || ps[_L3] != 0
		|| ps[_L4] != 0 || ps[_L5] != 0 || ps[_L6] != 0 || ps[_L7] != 0)
		return (xchar == 0 ? _DENORM : _FINITE);
	else
		return (0);
	}
 #endif /* _DLONG */

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
