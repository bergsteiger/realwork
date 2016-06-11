// newop operator new(size_t) REPLACEABLE
#include <cstdlib>
#include <new>

 #if _IS_EMBEDDED

 #else /* _IS_EMBEDDED */
#include <xutility>
 #endif /* _IS_EMBEDDED */

_CRTIMP2 void *_CDECL operator new(_CSTD size_t count)

 #if _HAS_CPP1X

 #else /* _HAS_CPP1X */
	_THROWS(_XSTD bad_alloc)	// allocate or throw exception
 #endif /* _HAS_CPP1X */

	{	// try to allocate count bytes
	void *p;

	if (count == 0)
		count = 1;
	while ((p = _CSTD malloc(count)) == 0)
		{	// no storage, try calling new handler
		_STD new_handler phand = _STD get_new_handler();
		if (phand == 0)

 #if _IS_EMBEDDED
			{	// report no memory
			static const _XSTD bad_alloc nomem;
			_RAISE(nomem);
			}

 #else /* _IS_EMBEDDED */
			_STD _Xbad_alloc();	// report no memory
 #endif /* _IS_EMBEDDED */

		else
			(*phand)();	// call new handler and retry
		}
	return (p);
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
