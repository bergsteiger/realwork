/* sprintf function */
#include <string.h>
#include "xstdio.h"
_STD_BEGIN

static void *prout(void *s, const char *buf, size_t n)
	{	/* write to string */
	return ((char *)memcpy(s, buf, n) + n);
	}

int (sprintf)(char *_Restrict s, const char *_Restrict fmt, ...)
	{	/* print formatted to string */
	int ans;
	va_list ap;

	va_start(ap, fmt);
	ans = _Printf(&prout, s, fmt, ap);
	if (0 <= ans)
		s[ans] = '\0';
	va_end(ap);
	return (ans);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
