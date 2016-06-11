// delop2 -- operator delete(void *, nothrow_t) REPLACEABLE
#include <new>

#if defined(__BORLANDC__)
/*
  These C++ file must be compiled to generate PUBDEFs since the new & delete
  operators will be smashed into their __org_xxx names by PUBDUP.EXE
  The -V?- switch will prevent COMDEFs and cause PUBDEFs to be generated
*/
#pragma option -V?-
#endif

_CRTIMP2 void operator delete(void *ptr,
	const _STD nothrow_t&) _THROW0()
	{	// free an allocated object
	operator delete(ptr);
	}

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
