// newaop -- operator new[](size_t) REPLACEABLE
#include <new>

_CRTIMP2 void *_CDECL operator new[](_CSTD size_t count)

 #if _HAS_CPP1X

 #else /* _HAS_CPP1X */
	_THROWS(_XSTD bad_alloc)	// allocate or throw exception
 #endif /* _HAS_CPP1X */

	{	// try to allocate count bytes for an array
	return (operator new(count));
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
