// newaop2 -- operator new[](size_t, const nothrow_t&) REPLACEABLE
#include <new>

_CRTIMP2 void *_CDECL operator new[](_CSTD size_t count,
	const _STD nothrow_t& x) _THROW0()
	{	// try to allocate count bytes for an array
	return (operator new(count, x));
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
