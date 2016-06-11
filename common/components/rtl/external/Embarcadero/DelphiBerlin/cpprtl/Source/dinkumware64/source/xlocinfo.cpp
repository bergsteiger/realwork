/* xlocinfo.cpp -- dummies for xlocinfo.h */
#include <cctype>
#include <climits>
#include <cstdio>
#include <cstdlib>
#include <xlocinfo.h>

 #if EOF != -1 || UCHAR_MAX != 255
  #error WRONG CTYPE TABLE
 #endif

_C_STD_BEGIN
_C_LIB_DECL

		/* macros */
#define XBB (_BB | _CN)	/* blank or control */
#define XDI (_DI | _XD)	/* digit or hex digit */
#define XLO (_LO | _XD)	/* lower case or hex digit */
#define XUP (_UP | _XD)	/* upper case or hex digit */

		/* static data */
const short _Ctyptab[256] =
	{	/* indexed by [0, UCHAR_MAX] */
 _BB, _BB, _BB, _BB, _BB, _BB, _BB, _BB,
 _BB, XBB, XBB, XBB, XBB, XBB, _BB, _BB,
 _BB, _BB, _BB, _BB, _BB, _BB, _BB, _BB,
 _BB, _BB, _BB, _BB, _BB, _BB, _BB, _BB,
 _SP, _PU, _PU, _PU, _PU, _PU, _PU, _PU,
 _PU, _PU, _PU, _PU, _PU, _PU, _PU, _PU,
 XDI, XDI, XDI, XDI, XDI, XDI, XDI, XDI,
 XDI, XDI, _PU, _PU, _PU, _PU, _PU, _PU,
 _PU, XUP, XUP, XUP, XUP, XUP, XUP, _UP,
 _UP, _UP, _UP, _UP, _UP, _UP, _UP, _UP,
 _UP, _UP, _UP, _UP, _UP, _UP, _UP, _UP,
 _UP, _UP, _UP, _PU, _PU, _PU, _PU, _PU,
 _PU, XLO, XLO, XLO, XLO, XLO, XLO, _LO,
 _LO, _LO, _LO, _LO, _LO, _LO, _LO, _LO,
 _LO, _LO, _LO, _LO, _LO, _LO, _LO, _LO,
 _LO, _LO, _LO, _PU, _PU, _PU, _PU, _BB,
 };	/* rest all match nothing */

	/* LOCALE functions */
_CRTIMP2 const short *_Getctyptab()
	{	/* get locale-specific info for _Tolower, etc. */
	short *ptab = (short *)calloc(256, sizeof (short));

	if (ptab == 0)
		return (&_Ctyptab[0]);	/* can't allocate storage */
	else
		{	/* got storage, initialize table */
		int i;
		short *p;

		p = ptab;
		for (i = 0; i < 256; ++i, ++p)
			{	/* set bits for all categories */
			if (iscntrl(i))
				*p |= _BB;
			else if (isdigit(i))
				*p |= _DI;
			else if (islower(i))
				*p |= _LO;
			else if (ispunct(i))
				*p |= _PU;
			else if (isupper(i))
				*p |= _UP;
			else if (isalnum(i))
				*p |= _XA;

			if (i == ' ')
				*p = _SP;
			else if (isspace(i))
				*p |= _CN;

 #if _HAS_C9X
			else if (isblank(i))
				*p |= _XB;
 #endif /* _HAS_C9X */

			if (isxdigit(i))
				*p |= _XD;
			}
		return (ptab);
		}
	}
_END_C_LIB_DECL
_C_STD_END

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
