/* strcspn function */
#include <string.h>
_STD_BEGIN

size_t (strcspn)(const char *s1, const char *s2)
	{	/* find index of first s1[i] that matches any s2[] */
	const char *sc1, *sc2;

	for (sc1 = s1; *sc1 != '\0'; ++sc1)
		for (sc2 = s2; *sc2 != '\0'; ++sc2)
			if (*sc1 == *sc2)
				return (sc1 - s1);
	return (sc1 - s1);	/* terminating nulls match */
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
