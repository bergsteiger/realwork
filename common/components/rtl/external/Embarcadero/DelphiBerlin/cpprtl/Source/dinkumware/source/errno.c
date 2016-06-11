/* errno access */
#include <errno.h>
#include <stdio.h>	/* for _HAS_DINKUM_CLIB */

#undef errno

 #if _HAS_DINKUM_CLIB	/* compiler test */
#include <locale.h>
#include "xtls.h"
_STD_BEGIN

_TLS_DATA_DEF(_IMPLICIT_EXTERN, int, _Errno, 0);

_CRTIMP2 int *(_Geterrno)(void)
	{	/* get pointer to errno */
	int *ptr;

	_Locklocale();
	ptr = _TLS_DATA_PTR(_Errno);
	_Unlocklocale();
	return (ptr);
	}
_STD_END

#elif defined(__SUNPRO_CC)
int *(___errno)(void);

_STD_BEGIN

extern int errno;

_CRTIMP2 int *(_Geterrno)(void)
	{	/* get pointer to errno */
	return (___errno());
	}
_STD_END

 #else /* _HAS_DINKUM_CLIB */
_STD_BEGIN

extern int errno;

_CRTIMP2 int *(_Geterrno)(void)
	{	/* get pointer to errno */
	return (&errno);
	}
_STD_END
 #endif /* _HAS_DINKUM_CLIB */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
