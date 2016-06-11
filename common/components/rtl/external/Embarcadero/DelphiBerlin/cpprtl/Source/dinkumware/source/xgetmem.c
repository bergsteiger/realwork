/* _Getmem function */
#include "xalloc.h"

 #if _USE_EXISTING_SYSTEM_NAMES
  #define _Sbrk sbrk
 #endif /* _USE_EXISTING_SYSTEM_NAMES */

_STD_BEGIN

_EXTERN_C
void *_Sbrk(int);
_END_EXTERN_C

void *_Getmem(size_t size)
	{	/* allocate raw storage */
	void *p;
	int isize = size;

	return (isize <= 0 || (p = _Sbrk(isize)) == (void *)-1 ? 0 : p);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
