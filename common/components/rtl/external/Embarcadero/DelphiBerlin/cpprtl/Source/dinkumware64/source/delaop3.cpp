// delaop3 -- operator delete[](void *, void *)
#include <new>

_CRTIMP2 void _CDECL operator delete[](void *, void *) _THROW0()
	{	// do nothing if placement new fails
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
