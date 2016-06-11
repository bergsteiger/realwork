/* memmove function */
#include <string.h>
_STD_BEGIN

void *(memmove)(void *s1, const void *s2, size_t n)
	{	/* copy char s2[n] to s1[n] safely */
	char *sc1 = (char *)s1;
	const char *sc2 = (const char *)s2;

	if (sc2 < sc1 && sc1 < sc2 + n)
		for (sc1 += n, sc2 += n; 0 < n; --n)
			*--sc1 = *--sc2;	/* copy backwards */
	else
		for (; 0 < n; --n)
			*sc1++ = *sc2++;	/* copy forwards */
	return (s1);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
