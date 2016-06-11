/* _FDscale function -- IEEE 754 version */
#include <float.h>
#include "xmath.h"
_C_LIB_DECL

#define ROUNDING_TBD	4

short _CDECL _FDscale(float *px, long lexp)
	{	/* scale *px by 2^xexp with checking */
	return (_FDscalex(px, lexp, ROUNDING_TBD));	/* get current mode */
	}

short _CDECL _FDscalex(float *px, long lexp, int round_mode)
	{	/* scale *px by 2^xexp with checking */
	_Fval *ps = (_Fval *)(char *)px;
	short xchar = (short)((ps->_Sh[_F0] & _FMASK) >> _FOFF);

	if (xchar == _FMAX)
		return ((short)((ps->_Sh[_F0] & _FFRAC) != 0 || ps->_Sh[_F1] != 0
			? _NANCODE : _INFCODE));
	else if (xchar == 0 && 0 < (xchar = _FDnorm(ps)))
		return (0);

	if (0 < lexp && _FMAX - xchar <= lexp)
		{	/* overflow, return +/-INF */
		*px = ps->_Sh[_F0] & _FSIGN ? -_FInf._Float : _FInf._Float;
		return (_INFCODE);
		}
	else if (-xchar < lexp)
		{	/* finite result, repack */
		ps->_Sh[_F0] = (unsigned short)((ps->_Sh[_F0] & ~_FMASK)
			| (lexp + xchar) << _FOFF);
		return (_FINITE);
		}
	else
		{	/* denormalized, scale */
		unsigned short sign = (unsigned short)(ps->_Sh[_F0] & _FSIGN);

		ps->_Sh[_F0] = (unsigned short)(1 << _FOFF | (ps->_Sh[_F0] & _FFRAC));
		lexp += xchar - 1;
		if (lexp < -(16 + 1 + _FOFF) || 0 <= lexp)
			{	/* underflow, return +/-0 */
			ps->_Sh[_F0] = sign;
			ps->_Sh[_F1] = 0;
			return (0);
			}
		else
			{	/* nonzero, align fraction */
			short xexp = (short)lexp;
			unsigned short psx = 0;

			if (xexp <= -16)
				{	/* scale by words */
				psx = ps->_Sh[_F1] | (psx != 0 ? 1 : 0);
				ps->_Sh[_F1] = ps->_Sh[_F0];
				ps->_Sh[_F0] = 0;
				xexp += 16;
				}
			if ((xexp = (short)-xexp) != 0)
				{	/* scale by bits */
				psx = (ps->_Sh[_F1] << (16 - xexp)) | (psx != 0 ? 1 : 0);
				ps->_Sh[_F1] = (unsigned short)(ps->_Sh[_F1] >> xexp
					| ps->_Sh[_F0] << (16 - xexp));
				ps->_Sh[_F0] >>= xexp;
				}

			ps->_Sh[_F0] |= sign;
			if (psx != 0)
				{	/* round by specified mode */
				int roundup = 0;

				if (round_mode == ROUNDING_TBD)
					round_mode = FLT_ROUNDS;
				switch (round_mode)
					{	/* round according to current mode */
				case 0:	/* toward zero */
					break;

				case 2:	/* upward */
					if (!sign)
						roundup = 1;
					break;

				case 3:	/* downward */
					if (sign)
						roundup = 1;
					break;

				default:	/* -1 => indeterminate, 1 => to nearest */
					if ((0x8000 < psx
						|| (0x8000 == psx && (ps->_Sh[_F1] & 0x0001) != 0)))
						roundup = 1;
					break;
					}

				if (roundup
					&& (++ps->_Sh[_F1] & 0xffff) == 0)
					++ps->_Sh[_F0];
				}

			if (ps->_Sh[_F0] == sign
				&& ps->_Sh[_F1] == 0)
				return (0);
			else
				return (_FINITE);
			}
		}
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
