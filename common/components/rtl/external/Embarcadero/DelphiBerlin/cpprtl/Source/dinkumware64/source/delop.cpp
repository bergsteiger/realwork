// delop -- operator delete(void *) REPLACEABLE
#include <cstdlib>
#include <new>

_CRTIMP2 void _CDECL operator delete(void *ptr)
	{	// free an allocated object
	if (ptr != 0)
		_CSTD free(ptr);
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
