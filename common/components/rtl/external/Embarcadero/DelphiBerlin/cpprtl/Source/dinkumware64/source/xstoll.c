/* _Stoll function */
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <stdlib.h>
#include "xmath.h"
_C_LIB_DECL

#define MYMIN	(-_LLONG_MAX - _C2)	/* LLONG_MIN */
#define MYMAX	_LLONG_MAX	/* LLONG_MAX */

_ULonglong _CDECL _Stoullx(const char *, char **, int, int *);

_CRTIMP2 _Longlong _CDECL _Stollx(const char * s, char ** endptr,
	int base, int *perr)
	{	/* convert string to long long, with checking */
	const char *sc;
	char *se, sign;
	_ULonglong x;

	if (endptr == 0)
		endptr = &se;
	for (sc = s; isspace((unsigned char)*sc); ++sc)
		;
	if (*sc == '-' || *sc == '+')
		sign = (char)*sc++;
	else
		sign = '+';
	x = _Stoullx(sc, endptr, base, perr);

	if (sc == *endptr)
		{	/* bad parse, return zero */
		*endptr = (char *)s;
		return (0);
		}
	else if ((sign == '+' && MYMAX < x)
		|| (sign == '-' && 0 - (_ULonglong)MYMIN < x))
		{	/* overflow, return largest + or - */
		errno = ERANGE;
		if (perr != 0)
			*perr = 1;
		return (sign == '-' ? MYMIN : MYMAX);
		}
	else
		return ((_Longlong)(sign == '-' ? 0 - x : x));
	}

_CRTIMP2 _Longlong (_CDECL _Stoll)(const char * s, char ** endptr, int base)
	{	/* convert string, discard error code */
	return (_Stollx(s, endptr, base, 0));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
