/* _Stolx function */
#include <yvals.h>
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <stdlib.h>
#include "xmath.h"
_C_LIB_DECL

unsigned long _CDECL _Stoulx(const char *, char **, int, int *);

_CRTIMP2 long _CDECL _Stolx(const char * s, char ** endptr,
	int base, int *perr)
	{	/* convert string to long, with checking */
	const char *sc;
	char *se, sign;
	unsigned long x;

	if (endptr == 0)
		endptr = &se;
	for (sc = s; isspace((unsigned char)*sc); ++sc)
		;
	if (*sc == '-' || *sc == '+')
		sign = (char)*sc++;
	else
		sign = '+';
	x = _Stoulx(sc, endptr, base, perr);

	if (sc == *endptr)
		{	/* bad parse, return zero */
		*endptr = (char *)s;
		return (0);
		}
	else if ((sign == '+' && LONG_MAX < x)
		|| (sign == '-' && 0 - (unsigned long)LONG_MIN < x))
		{	/* overflow, return largest + or - */
		errno = ERANGE;
		if (perr != 0)
			*perr = 1;
		return (sign == '-' ? LONG_MIN : LONG_MAX);
		}
	else
		return ((long)(sign == '-' ? 0 - x : x));
	}
_END_C_LIB_DECL

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
