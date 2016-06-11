/* calloc function */
#include <stdlib.h>
#include <string.h>
_STD_BEGIN

void *(calloc)(size_t nelem, size_t size)
	{	/* allocate a data object on the heap and clear it */
	const size_t n = nelem * size;
	char *p = (char *)malloc(n);

	if (p)
		memset(p, '\0', n);
	return (p);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
