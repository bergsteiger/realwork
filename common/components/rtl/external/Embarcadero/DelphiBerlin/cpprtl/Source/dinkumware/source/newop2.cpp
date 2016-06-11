// newop2 operator new(size_t, const nothrow_t&) REPLACEABLE
#include <cstdlib>
#include <new>

#if defined(__BORLANDC__)
/*
  These C++ file must be compiled to generate PUBDEFs since the new & delete
  operators will be smashed into their __org_xxx names by PUBDUP.EXE
  The -V?- switch will prevent COMDEFs and cause PUBDEFs to be generated
*/
#pragma option -V?-
#endif

_CRTIMP2 void *operator new(_CSTD size_t count, const _STD nothrow_t&)
	_THROW0()
	{	// try to allocate count bytes
	void *p;

	if (count == 0)
		count = 1;
	while ((p = _CSTD malloc(count)) == 0)
		{	// buy more memory or return null pointer
		if (_STD _New_hand == 0)
			return (0);	// no new handler, give up

		_TRY_BEGIN
			(*_STD _New_hand)();	// call new handler and retry
		_CATCH(_XSTD bad_alloc)
			return (0);	// threw bad_alloc, give up
		_CATCH_END
		}
	return (p);
	}

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
