/* strncmp function */
#include <string.h>
_STD_BEGIN

int (strncmp)(const char *s1, const char *s2, size_t n)
	{	/* compare unsigned char s1[max n], s2[max n] */
	for (; 0 < n; ++s1, ++s2, --n)
		if (*s1 != *s2)
			return (*(unsigned char *)s1
				< *(unsigned char *)s2 ? -1 : +1);
		else if (*s1 == '\0')
			return (0);
	return (0);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
