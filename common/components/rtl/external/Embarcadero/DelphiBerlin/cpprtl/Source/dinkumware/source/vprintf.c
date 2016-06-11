/* vprintf function */
#include "xstdio.h"
_STD_BEGIN

static void *prout(void *str, const char *buf, size_t n)
	{	/* write to file */
	return (fwrite(buf, 1, n, (FILE *)str) == n ? str : 0);
	}

int (vprintf)(const char *_Restrict fmt, va_list ap)
	{	/* print formatted to stdout from arg list */
	int ans;

	_Lockfileatomic(stdout);
	ans = _Printf(&prout, stdout, fmt, ap);
	_Unlockfileatomic(stdout);
	return (ans);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
