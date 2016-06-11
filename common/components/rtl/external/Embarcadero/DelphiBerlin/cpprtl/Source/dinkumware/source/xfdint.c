/* _FDint function -- IEEE 754 version */
#include "xmath.h"
_STD_BEGIN

short _FDint(float *px, short xexp)
	{	/* test and drop (scaled) fraction bits */
	unsigned short *ps = (unsigned short *)(char *)px;
	unsigned short frac;
	short xchar = (ps[_F0] & _FMASK) >> _FOFF;

	if (xchar == _FMAX)
		return ((ps[_F0] & _FFRAC) == 0 && ps[_F1] == 0
			? _INFCODE : _NANCODE);
	else if ((ps[_F0] & ~_FSIGN) == 0 && ps[_F1] == 0)
		return (0);
	xchar = (_FBIAS + 16 + _FOFF + 1) - xchar - xexp;
	if (xchar <= 0)
		return (0);	/* no frac bits to drop */
	else if ((16 + _FOFF + 1) <= xchar)
		{	/* all frac bits */
		ps[_F0] &= _FSIGN;
		ps[_F1] = 0;
		return (_FINITE);	/* report on frac, not result */
		}
	else
		{	/* strip out frac bits */
		static const unsigned short mask[] = {
			0x0000, 0x0001, 0x0003, 0x0007,
			0x000f, 0x001f, 0x003f, 0x007f,
			0x00ff, 0x01ff, 0x03ff, 0x07ff,
			0x0fff, 0x1fff, 0x3fff, 0x7fff};
		static const size_t sub[] = {_F1, _F0};

		frac = mask[xchar & 0xf];
		xchar >>= 4;
		frac &= ps[sub[xchar]];
		ps[sub[xchar]] ^= frac;
		if (0 < xchar)
			frac |= ps[_F1], ps[_F1] = 0;
		return (frac != 0 ? _FINITE : 0);
		}
		}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
