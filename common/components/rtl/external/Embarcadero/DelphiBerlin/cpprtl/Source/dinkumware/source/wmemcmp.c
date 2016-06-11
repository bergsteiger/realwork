/* wmemcmp function */
#include <wchar.h>
_STD_BEGIN

_CRTIMP2 int (wmemcmp)(const wchar_t *s1, const wchar_t *s2, size_t n)
	{	/* compare wchar_t s1[n], s2[n] */
	for (; 0 < n; ++s1, ++s2, --n)
		if (*s1 != *s2)
			return (*s1 < *s2 ? -1 : +1);
	return (0);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
