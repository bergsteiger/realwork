/* memset function */
#include <string.h>
_STD_BEGIN

void *(memset)(void *s, int c, size_t n)
	{	/* store c throughout unsigned char s[n] */
	const unsigned char uc = (unsigned char)c;
	unsigned char *su = (unsigned char *)s;

	for (; 0 < n; ++su, --n)
		*su = uc;
	return (s);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
