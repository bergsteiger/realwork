/* vsprintf function */
#include <string.h>
#include "xstdio.h"
_STD_BEGIN

static void *prout(void *s, const char *buf, size_t n)
	{	/* write to string */
	return ((char *)memcpy(s, buf, n) + n);
	}

int (vsprintf)(char *_Restrict s, const char *_Restrict fmt,
	va_list ap)
	{	/* print formatted to string from arg list */
	int ans = _Printf(&prout, s, fmt, ap);

	if (0 <= ans)
		s[ans] = '\0';
	return (ans);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
