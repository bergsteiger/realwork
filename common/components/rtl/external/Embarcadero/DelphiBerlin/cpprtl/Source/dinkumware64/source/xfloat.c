/* values used by <float.h> macros -- IEEE 754 version */
#include <float.h>
#include "xmath.h"
_C_LIB_DECL

		/* TYPE DEFINITIONS */
 #ifndef _DVALS
  #define _DVALS
typedef struct
	{	/* parameters for a floating-point type */
	int _Ddig, _Dmdig, _Dmax10e, _Dmaxe, _Dmin10e, _Dmine;
	union
		{	/* union of short array and all floats */
		unsigned short _Us[8];
#if !defined(__CODEGEARC__)
		Half _Half;
#endif
		float _Float;
		double _Double;
		long double _Long_double;
		} _Deps, _Dmax, _Dmin;
	} _Dvals;
 #endif /* _DVALS */

		/* MACROS */
#define LOG2	0.30103
#define ONES	0xffff

#define VFRAC	_VOFF
#define VMAXE	((1U << (15 - _VOFF)) - 1)
#define VINIT(w0)	{w0}
#define FFRAC	(17 + _FOFF)
#define FMAXE	((1U << (15 - _FOFF)) - 1)

#define DFRAC	(49 + _DOFF)
#define DMAXE	((1U << (15 - _DOFF)) - 1)

 #if _DLONG == 0
  #define LFRAC	(49 + _DOFF)	/* 64-bit long doubles */
  #define LMAXE	((1U << (15 - _DOFF)) - 1)

 #elif _DLONG == 1
  #define LFRAC	64	/* 80-bit long doubles */
  #define LMAXE	0x7fff

 #else /* 1 < _DLONG */
  #define LFRAC	113	/* 128-bit SPARC long doubles */
  #define LMAXE	0x7fff
 #endif /* _DLONG */

 #if _D0 == 0
  #define FINIT(w0, wx)	{w0, wx, 0, 0, 0, 0, 0, 0}	/* big-endian */
  #define DINIT(w0, wx)	{w0, wx, wx, wx, 0, 0, 0, 0}
  #define LINIT(w0, w1, wx)	{w0, w1, wx, wx, wx, wx, wx, wx}
 #elif _DLONG == 0
  #define FINIT(w0, wx)	{wx, w0, 0, 0, 0, 0}	/* little-endian, 64-bit */
  #define DINIT(w0, wx)	{wx, wx, wx, w0, 0, 0}
  #define LINIT(w0, w1, wx)	xxx	/* should never be used */

 #elif _DLONG == 1
  #define FINIT(w0, wx)	{wx, w0, 0, 0, 0, 0}	/* little-endian, 80-bit */
  #define DINIT(w0, wx)	{wx, wx, wx, w0, 0, 0}
  #define LINIT(w0, w1, wx)	{wx, wx, wx, w1, w0, 0}
 #else /* 1 < _DLONG */
  #define FINIT(w0, wx)	{wx, w0, 0, 0, 0, 0}	/* little-endian, 128-bit */
  #define DINIT(w0, wx)	{wx, wx, wx, w0, 0, 0}
  #define LINIT(w0, w1, wx)	{wx, wx, wx, wx, wx, wx, w1, w0}
 #endif /* _DLONG */

		/* static data */

_EXTERN_CONST _Dvals _Flt = {
	(int)((FFRAC - 1) * LOG2),				/* FLT_DIG */
	(int)FFRAC,								/* FLT_MANT_DIG */
	(int)((FMAXE - _FBIAS - 1) * LOG2),		/* FLT_MAX_10_EXP */
	(int)(FMAXE - _FBIAS - 1),				/* FLT_MAX_EXP */
	(int)(-_FBIAS * LOG2),					/* FLT_MIN_10_EXP */
	(int)(1 - _FBIAS),						/* FLT_MIN_EXP */
	FINIT((_FBIAS - FFRAC + 2) << _FOFF, 0),	/* FLT_EPSILON */
	FINIT((FMAXE << _FOFF) - 1, ONES),		/* FLT_MAX */
	FINIT(1 << _FOFF, 0),					/* FLT_MIN */
	};

_EXTERN_CONST _Dvals _Dbl = {
	(int)((DFRAC - 1) * LOG2),				/* DBL_DIG */
	(int)DFRAC,								/* DBL_MANT_DIG */
	(int)((DMAXE - _DBIAS - 1) * LOG2),		/* DBL_MAX_10_EXP */
	(int)(DMAXE - _DBIAS - 1),				/* DBL_MAX_EXP */
	(int)(-_DBIAS * LOG2),					/* DBL_MIN_10_EXP */
	(int)(1 - _DBIAS),						/* DBL_MIN_EXP */
	DINIT((_DBIAS - DFRAC + 2) << _DOFF, 0),	/* DBL_EPSILON */
	DINIT((DMAXE << _DOFF) - 1, ONES),		/* DBL_MAX */
	DINIT(1 << _DOFF, 0),					/* DBL_MIN */
	};

 #if _DLONG == 0
_EXTERN_CONST _Dvals _Ldbl = {	/* 64-bit */
	(int)((DFRAC - 1) * LOG2),				/* LDBL_DIG */
	(int)DFRAC,								/* LDBL_MANT_DIG */
	(int)((DMAXE - _DBIAS - 1) * LOG2),		/* LDBL_MAX_10_EXP */
	(int)(DMAXE - _DBIAS - 1),				/* LDBL_MAX_EXP */
	(int)(-_DBIAS * LOG2),					/* LDBL_MIN_10_EXP */
	(int)(1 - _DBIAS),						/* LDBL_MIN_EXP */
	DINIT((_DBIAS - DFRAC + 2) << _DOFF, 0),	/* LDBL_EPSILON */
	DINIT((DMAXE << _DOFF) - 1, ONES),		/* LDBL_MAX */
	DINIT(1 << _DOFF, 0),					/* LDBL_MIN */
	};

 #elif _DLONG == 1
_EXTERN_CONST _Dvals _Ldbl = {	/* 80-bit */
	(int)((LFRAC - 1) * LOG2),				/* LDBL_DIG */
	(int)LFRAC,								/* LDBL_MANT_DIG */
	(int)((LMAXE - _LBIAS - 1) * LOG2),		/* LDBL_MAX_10_EXP */
	(int)(LMAXE - _LBIAS - 1),				/* LDBL_MAX_EXP */
	(int)(-_LBIAS * LOG2),					/* LDBL_MIN_10_EXP */
	(int)(1 - _LBIAS),						/* LDBL_MIN_EXP */
	LINIT(_LBIAS - LFRAC + 2, 0x8000, 0),	/* LDBL_EPSILON */
	LINIT(LMAXE - 1, ONES, ONES),			/* LDBL_MAX */
	LINIT(1, 0x8000, 0),					/* LDBL_MIN */
	};

 #else /* 1 < _DLONG */
_EXTERN_CONST _Dvals _Ldbl = {	/* 128-bit SPARC */
	(int)((LFRAC - 1) * LOG2),				/* LDBL_DIG */
	(int)LFRAC,								/* LDBL_MANT_DIG */
	(int)((LMAXE - _LBIAS - 1) * LOG2),		/* LDBL_MAX_10_EXP */
	(int)(LMAXE - _LBIAS - 1),				/* LDBL_MAX_EXP */
	(int)(-_LBIAS * LOG2),					/* LDBL_MIN_10_EXP */
	(int)(1 - _LBIAS),						/* LDBL_MIN_EXP */
	LINIT(_LBIAS - LFRAC + 2, 0, 0),		/* LDBL_EPSILON */
	LINIT(LMAXE - 1, ONES, ONES),			/* LDBL_MAX */
	LINIT(1, 0, 0),							/* LDBL_MIN */
	};
 #endif /* _DLONG */

_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
