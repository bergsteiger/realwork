/* vfwprintf function */
#include "xwstdio.h"
_STD_BEGIN

static void *prout(void *arg, const wchar_t *buf, size_t n)
	{	/* write to wide file */
	FILE *str = (FILE *)arg;

	for (; 0 < n; --n, ++buf)
		if (fputwc(*buf, str) == WEOF)
			return (0);
	return (str);
	}

int (vfwprintf)(FILE *_Restrict str, const wchar_t *_Restrict fmt,
	va_list ap)
	{	/* print formatted to wide stream from arg list */
	int ans;

	_Lockfileatomic(str);
	ans = _WPrintf(&prout, str, fmt, ap);
	_Unlockfileatomic(str);
	return (ans);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
