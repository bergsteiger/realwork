// delaop2 -- operator delete[](void *, nothrow_t) REPLACEABLE
#include <new>

_CRTIMP2 void _CDECL operator delete[](void *ptr,
	const _STD nothrow_t& arg) _THROW0()
	{	// free an allocated object
	operator delete(ptr, arg);
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
