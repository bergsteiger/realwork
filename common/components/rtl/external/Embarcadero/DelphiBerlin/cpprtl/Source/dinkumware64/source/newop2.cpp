// newop2 operator new(size_t, const nothrow_t&) REPLACEABLE
#include <cstdlib>
#include <new>

_CRTIMP2 void *_CDECL operator new(_CSTD size_t count, const _STD nothrow_t&)
	_THROW0()
	{	// try to allocate count bytes
	void *p;

	if (count == 0)
		count = 1;
	while ((p = _CSTD malloc(count)) == 0)
		{	// buy more memory or return null pointer
		_STD new_handler phand = _STD get_new_handler();
		if (phand == 0)
			return (0);	// no new handler, give up

		_TRY_BEGIN
			(*phand)();	// call new handler and retry
		_CATCH(_XSTD bad_alloc)
			return (0);	// threw bad_alloc, give up
		_CATCH_END
		}
	return (p);
	}

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
