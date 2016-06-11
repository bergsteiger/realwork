/* strtol function */
#include <yvals.h>
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <stdlib.h>
#include "xmath.h"
_STD_BEGIN

long _Stolx(const char *, char **, int, int *);

/* Use Borland's c strtol */
#if !defined(__BORLANDC__)
long (strtol)(const char *_Restrict s, char **_Restrict endptr,
	int base)
	{	/* convert string, discard error code */
	return (_Stolx(s, endptr, base, 0));
	}
#endif
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
