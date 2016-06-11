/* _LDscale function -- IEEE 754 version */
#include <float.h>
#include "xmath.h"
_C_LIB_DECL

#define ROUNDING_TBD	4

short _CDECL _LDscale(long double *px, long lexp)
	{	/* scale *px by 2^xexp with checking */
	return (_LDscalex(px, lexp, ROUNDING_TBD));	/* get current mode */
	}

 #if _DLONG == 0
short _CDECL _LDscalex(long double *px, long lexp, int round_mode)
	{	/* scale *px by 2^lexp with checking -- 64-bit */
	return (_Dscalex((double *)px, lexp, round_mode));
	}

 #elif _DLONG == 1
short _CDECL _LDscalex(long double *px, long lexp, int round_mode)
	{	/* scale *px by 2^lexp with checking -- 80-bit */
	_Lval *ps = (_Lval *)(char *)px;
	short xchar = ps->_Sh[_L0] & _LMASK;

	if (xchar == _LMAX)
		return ((ps->_Sh[_L1] & 0x7fff) != 0 || ps->_Sh[_L2] != 0
			|| ps->_Sh[_L3] != 0 || ps->_Sh[_L4] != 0 ? _NANCODE : _INFCODE);
	else if (ps->_Sh[_L1] == 0 && ps->_Sh[_L2] == 0
		&& ps->_Sh[_L3] == 0 && ps->_Sh[_L4] == 0)
		{	/* zero fraction, clear any exponent */
		ps->_Sh[_L0] &= _LSIGN;
		return (0);
		}

	if (xchar == 0)
		xchar = 1;	/* correct denormalized exponent */
	xchar += _LDnorm(ps);
	if (0 < lexp && _LMAX - xchar <= lexp)
		{	/* overflow, return +/-INF */
		*px = ps->_Sh[_L0] & _LSIGN ? -_LInf._Long_double
			: _LInf._Long_double;
		return (_INFCODE);
		}
	else if (-xchar < lexp)
		{	/* finite result, repack */
		ps->_Sh[_L0] = (ps->_Sh[_L0] & _LSIGN) | (lexp + xchar);
		return (_FINITE);
		}
	else
		{	/* denormalized, scale */
		unsigned short sign = (unsigned short)(ps->_Sh[_L0] & _LSIGN);

		ps->_Sh[_L0] = 0;
		lexp += xchar - 1;
		if (lexp <= -(64 + 1) || 0 <= lexp)
			{	/* underflow, return +/-0 */
			ps->_Sh[_L1] = 0;
			ps->_Sh[_L2] = 0;
			ps->_Sh[_L3] = 0;
			ps->_Sh[_L4] = 0;
			return (0);
			}
		else
			{	/* nonzero, align fraction */
			short xexp = (short)lexp;
			unsigned short psx = 0;

			for (; xexp <= -16; xexp += 16)
				{	/* scale by words */
				psx = ps->_Sh[_L4] | (psx != 0 ? 1 : 0);
				ps->_Sh[_L4] = ps->_Sh[_L3];
				ps->_Sh[_L3] = ps->_Sh[_L2];
				ps->_Sh[_L2] = ps->_Sh[_L1];
				ps->_Sh[_L1] = 0;
				}
			if ((xexp = (short)-xexp) != 0)
				{	/* scale by bits */
				psx = (ps->_Sh[_L4] << (16 - xexp)) | (psx != 0 ? 1 : 0);
				ps->_Sh[_L4] = ps->_Sh[_L4] >> xexp
					| ps->_Sh[_L3] << (16 - xexp);
				ps->_Sh[_L3] = ps->_Sh[_L3] >> xexp
					| ps->_Sh[_L2] << (16 - xexp);
				ps->_Sh[_L2] = ps->_Sh[_L2] >> xexp
					| ps->_Sh[_L1] << (16 - xexp);
				ps->_Sh[_L1] >>= xexp;
				}

			ps->_Sh[_L0] |= sign;
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
						|| (0x8000 == psx && (ps->_Sh[_L4] & 0x0001) != 0)))
						roundup = 1;
					break;
					}

				if (roundup
					&& (++ps->_Sh[_L4] & 0xffff) == 0
					&& (++ps->_Sh[_L3] & 0xffff) == 0
					&& (++ps->_Sh[_L2] & 0xffff) == 0
					&& (++ps->_Sh[_L1] & 0xffff) == 0x8000)
					++ps->_Sh[_L0];
				}

			if (ps->_Sh[_L0] == sign
				&& ps->_Sh[_L1] == 0
				&& ps->_Sh[_L2] == 0
				&& ps->_Sh[_L3] == 0
				&& ps->_Sh[_L4] == 0)
				return (0);
			else
				return (_FINITE);
			}
		}
	}

 #else	/* 1 < _DLONG */
short _CDECL _LDscalex(long double *px, long lexp, int round_mode)
	{	/* scale *px by 2^lexp with checking -- 128-bit SPARC */
	_Lval *ps = (_Lval *)(char *)px;
	short xchar = ps->_Sh[_L0] & _LMASK;

	if (xchar == _LMAX)
		return (ps->_Sh[_L1] != 0 || ps->_Sh[_L2] != 0 || ps->_Sh[_L3] != 0
			|| ps->_Sh[_L4] != 0 || ps->_Sh[_L5] != 0 || ps->_Sh[_L6] != 0
			|| ps->_Sh[_L7] != 0 ? _NANCODE : _INFCODE);
	else if (xchar == 0 && 0 < (xchar = _LDnorm(ps)))
		return (0);

	if (0 < lexp && _LMAX - xchar <= lexp)
		{	/* overflow, return +/-INF */
		*px = ps->_Sh[_L0] & _LSIGN ? -_LInf._Long_double
			: _LInf._Long_double;
		return (_INFCODE);
		}
	else if (-xchar < lexp)
		{	/* finite result, repack */
		ps->_Sh[_L0] = (ps->_Sh[_L0] & _LSIGN) | (lexp + xchar);
		return (_FINITE);
		}
	else
		{	/* denormalized, scale */
		unsigned short sign = ps->_Sh[_L0] & _LSIGN;

		ps->_Sh[_L0] = 1;
		lexp += xchar - 1;
		if (lexp <= -113 || 0 <= lexp)
			{	/* underflow, return +/-0 */
			ps->_Sh[_L7] = 0;
			ps->_Sh[_L6] = 0;
			ps->_Sh[_L5] = 0;
			ps->_Sh[_L4] = 0;
			ps->_Sh[_L3] = 0;
			ps->_Sh[_L2] = 0;
			ps->_Sh[_L1] = 0;
			ps->_Sh[_L0] = sign;
			return (0);
			}
		else
			{	/* nonzero, align fraction */
			short xexp = (short)lexp;
			unsigned short psx = 0;

			for (; xexp <= -16; xexp += 16)
				{	/* scale by words */
				psx = ps->_Sh[_L7] | (psx != 0 ? 1 : 0);
				ps->_Sh[_L7] = ps->_Sh[_L6];
				ps->_Sh[_L6] = ps->_Sh[_L5];
				ps->_Sh[_L5] = ps->_Sh[_L4];
				ps->_Sh[_L4] = ps->_Sh[_L3];
				ps->_Sh[_L3] = ps->_Sh[_L2];
				ps->_Sh[_L2] = ps->_Sh[_L1];
				ps->_Sh[_L1] = ps->_Sh[_L0];
				ps->_Sh[_L0] = 0;
				}
			if ((xexp = (short)-xexp) != 0)
				{	/* scale by bits */
				psx = (ps->_Sh[_L7] << (16 - xexp)) | (psx != 0 ? 1 : 0);
				ps->_Sh[_L7] = ps->_Sh[_L7] >> xexp
					| ps->_Sh[_L6] << 16 - xexp;
				ps->_Sh[_L6] = ps->_Sh[_L6] >> xexp
					| ps->_Sh[_L5] << 16 - xexp;
				ps->_Sh[_L5] = ps->_Sh[_L5] >> xexp
					| ps->_Sh[_L4] << 16 - xexp;
				ps->_Sh[_L4] = ps->_Sh[_L4] >> xexp
					| ps->_Sh[_L3] << 16 - xexp;
				ps->_Sh[_L3] = ps->_Sh[_L3] >> xexp
					| ps->_Sh[_L2] << 16 - xexp;
				ps->_Sh[_L2] = ps->_Sh[_L2] >> xexp
					| ps->_Sh[_L1] << 16 - xexp;
				ps->_Sh[_L1] = ps->_Sh[_L1] >> xexp
					| ps->_Sh[_L0] << 16 - xexp;
				ps->_Sh[_L0] = 0;
				}

			ps->_Sh[_L0] = sign;
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
						|| (0x8000 == psx && (ps->_Sh[_L7] & 0x0001) != 0)))
						roundup = 1;
					break;
					}

				if (roundup
					&& (++ps->_Sh[_L7] & 0xffff) == 0
					&& (++ps->_Sh[_L6] & 0xffff) == 0
					&& (++ps->_Sh[_L5] & 0xffff) == 0
					&& (++ps->_Sh[_L4] & 0xffff) == 0
					&& (++ps->_Sh[_L3] & 0xffff) == 0
					&& (++ps->_Sh[_L2] & 0xffff) == 0
					&& (++ps->_Sh[_L1] & 0xffff) == 0)
					++ps->_Sh[_L0];	/* round up */
				}

			if (ps->_Sh[_L0] == sign
				&& ps->_Sh[_L1] == 0
				&& ps->_Sh[_L2] == 0
				&& ps->_Sh[_L3] == 0
				&& ps->_Sh[_L4] == 0
				&& ps->_Sh[_L5] == 0
				&& ps->_Sh[_L6] == 0
				&& ps->_Sh[_L7] == 0)
				return (0);
			else
				return (_FINITE);
			}
		}
	}
 #endif /* _DLONG */

_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
