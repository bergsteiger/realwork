/* _Dscale function -- IEEE 754 version */
#include <float.h>
#include "xmath.h"
_C_LIB_DECL

#define ROUNDING_TBD	4

short _CDECL _Dscale(double *px, long lexp)
	{	/* scale *px by 2^xexp with checking */
	return (_Dscalex(px, lexp, ROUNDING_TBD));	/* get current mode */
	}

short _CDECL _Dscalex(double *px, long lexp, int round_mode)
	{	/* scale *px by 2^xexp with checking */
	_Dval *ps = (_Dval *)(char *)px;
	short xchar = (short)((ps->_Sh[_D0] & _DMASK) >> _DOFF);

	if (xchar == _DMAX)
		return ((short)((ps->_Sh[_D0] & _DFRAC) != 0 || ps->_Sh[_D1] != 0
			|| ps->_Sh[_D2] != 0 || ps->_Sh[_D3] != 0 ? _NANCODE : _INFCODE));
	else if (xchar == 0 && 0 < (xchar = _Dnorm(ps)))
		return (0);

	if (0 < lexp && _DMAX - xchar <= lexp)
		{	/* overflow, return +/-INF */
		*px = ps->_Sh[_D0] & _DSIGN ? -_Inf._Double : _Inf._Double;
		return (_INFCODE);
		}
	else if (-xchar < lexp)
		{	/* finite result, repack */
		ps->_Sh[_D0] = (unsigned short)((ps->_Sh[_D0] & ~_DMASK)
			| (lexp + xchar) << _DOFF);
		return (_FINITE);
		}
	else
		{	/* denormalized, scale */
		unsigned short sign = (unsigned short)(ps->_Sh[_D0] & _DSIGN);

		ps->_Sh[_D0] = (unsigned short)(1 << _DOFF | (ps->_Sh[_D0] & _DFRAC));
		lexp += xchar - 1;
		if (lexp < -(48 + 1 + _DOFF) || 0 <= lexp)
			{	/* certain underflow, return +/-0 */
			ps->_Sh[_D0] = sign;
			ps->_Sh[_D1] = 0;
			ps->_Sh[_D2] = 0;
			ps->_Sh[_D3] = 0;
			return (0);
			}
		else
			{	/* nonzero, align fraction */
			short xexp = (short)lexp;
			unsigned short psx = 0;

			for (; xexp <= -16; xexp += 16)
				{	/* scale by words */
				psx = ps->_Sh[_D3] | (psx != 0 ? 1 : 0);
				ps->_Sh[_D3] = ps->_Sh[_D2];
				ps->_Sh[_D2] = ps->_Sh[_D1];
				ps->_Sh[_D1] = ps->_Sh[_D0];
				ps->_Sh[_D0] = 0;
				}
			if ((xexp = (short)-xexp) != 0)
				{	/* scale by bits */
				psx = (ps->_Sh[_D3] << (16 - xexp)) | (psx != 0 ? 1 : 0);
				ps->_Sh[_D3] = (unsigned short)(ps->_Sh[_D3] >> xexp
					| ps->_Sh[_D2] << (16 - xexp));
				ps->_Sh[_D2] = (unsigned short)(ps->_Sh[_D2] >> xexp
					| ps->_Sh[_D1] << (16 - xexp));
				ps->_Sh[_D1] = (unsigned short)(ps->_Sh[_D1] >> xexp
					| ps->_Sh[_D0] << (16 - xexp));
				ps->_Sh[_D0] >>= xexp;
				}

			ps->_Sh[_D0] |= sign;
			if (psx != 0)
				{	/* round by current mode */
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
						|| (0x8000 == psx && (ps->_Sh[_D3] & 0x0001) != 0)))
						roundup = 1;
					break;
					}

				if (roundup
					&& (++ps->_Sh[_D3] & 0xffff) == 0
					&& (++ps->_Sh[_D2] & 0xffff) == 0
					&& (++ps->_Sh[_D1] & 0xffff) == 0)
					++ps->_Sh[_D0];
				}

			if (ps->_Sh[_D0] == sign
				&& ps->_Sh[_D1] == 0
				&& ps->_Sh[_D2] == 0
				&& ps->_Sh[_D3] == 0)
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
