/* fprintf function */
#include "xstdio.h"
_STD_BEGIN

static void *prout(void *str, const char *buf, size_t n)
	{	/* write to file */
	return (fwrite(buf, 1, n, (FILE *)str) == n ? str : 0);
	}

int (fprintf)(FILE *_Restrict str, const char *_Restrict fmt, ...)
	{	/* print formatted to stream */
	int ans;
	va_list ap;

	va_start(ap, fmt);
	_Lockfileatomic(stdout);
	ans = _Printf(&prout, str, fmt, ap);
	_Unlockfileatomic(stdout);
	va_end(ap);
	return (ans);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
