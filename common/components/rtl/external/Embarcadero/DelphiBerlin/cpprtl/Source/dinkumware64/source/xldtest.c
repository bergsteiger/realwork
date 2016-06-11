/* _LDtest function -- IEEE 754 version */
#include "xmath.h"
_C_LIB_DECL

 #if _DLONG == 0
_CRTIMP2P short _PCDECL _LDtest(long double *px)
	{	/* categorize *px -- 64-bit */
	return (_Dtest((double *)px));
	}

 #elif _DLONG == 1
_CRTIMP2P short _PCDECL _LDtest(long double *px)
	{	/* categorize *px -- 80-bit */
	_Lval *ps = (_Lval *)(char *)px;
	short xchar = ps->_Sh[_L0] & _LMASK;

	if (xchar == _LMAX)
		return ((ps->_Sh[_L1] & 0x7fff) != 0 || ps->_Sh[_L2] != 0
			|| ps->_Sh[_L3] != 0 || ps->_Sh[_L4] != 0 ? _NANCODE : _INFCODE);
	else if (0 < xchar || ps->_Sh[_L1] != 0 || ps->_Sh[_L2] || ps->_Sh[_L3]
		|| ps->_Sh[_L4])
		return (ps->_Sh[_L1] < 0x8000 ? _DENORM : _FINITE);
	else
		return (0);
	}

 #else	/* 1 < _DLONG */
_CRTIMP2P short _PCDECL _LDtest(long double *px)
	{	/* categorize *px -- 128-bit SPARC */
	_Lval *ps = (_Lval *)(char *)px;
	short xchar = ps->_Sh[_L0] & _LMASK;

	if (xchar == _LMAX)
		return (ps->_Sh[_L1] != 0 || ps->_Sh[_L2] != 0 || ps->_Sh[_L3] != 0
			|| ps->_Sh[_L4] != 0 || ps->_Sh[_L5] != 0 || ps->_Sh[_L6] != 0
			|| ps->_Sh[_L7] != 0 ? _NANCODE : _INFCODE);
	else if (0 < xchar
		|| ps->_Sh[_L1] != 0 || ps->_Sh[_L2] != 0 || ps->_Sh[_L3] != 0
		|| ps->_Sh[_L4] != 0 || ps->_Sh[_L5] != 0 || ps->_Sh[_L6] != 0
		|| ps->_Sh[_L7] != 0)
		return (xchar == 0 ? _DENORM : _FINITE);
	else
		return (0);
	}
 #endif /* _DLONG */

unsigned short *_LPlsw(long double *px)
	{	/* get pointer to lsw */
	return (&((_Lval *)(char *)px)->_Sh[_Lg]);
	}

unsigned short *_LPmsw(long double *px)
	{	/* get pointer to msw */
	return (&((_Lval *)(char *)px)->_Sh[_L0]);
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
