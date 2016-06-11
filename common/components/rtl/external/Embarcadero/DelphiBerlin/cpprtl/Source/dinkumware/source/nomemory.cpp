// nomemory -- report out of memory
#include <new>
#include <yvals.h>
_STD_BEGIN

_CRTIMP2 void _Nomemory()
	{	// report out of memory
	static const _XSTD bad_alloc nomem;
	_RAISE(nomem);
	}
_STD_END

/*
 * Copyright (c) 1992-2002 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V4.00:126I */
