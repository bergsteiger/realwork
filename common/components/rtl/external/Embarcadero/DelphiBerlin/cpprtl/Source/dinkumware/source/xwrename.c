/* _wremove function */
#include <stdlib.h>
#include "xstdio.h"

 #if _HAS_POSIX_C_LIB
_STD_BEGIN

 #if _USE_EXISTING_SYSTEM_NAMES
  #define _Unlink unlink
  #define _Link link
 #endif /* _USE_EXISTING_SYSTEM_NAMES */

_EXTERN_C
int _Unlink(const char *);
int _Link(const char *, const char *);
_END_EXTERN_C

int (_wrename)(const wchar_t *oldnm, const wchar_t *newnm)
	{	/* rename a file */
	char c_oldnm[_FNAMAX], c_newnm[_FNAMAX];

	if (wcstombs(c_oldnm, oldnm, _FNAMAX) == (size_t)(-1)
		|| wcstombs(c_newnm, newnm, _FNAMAX) == (size_t)(-1))
		return (-1);

	return (link(c_oldnm, c_newnm) ? -1 : unlink(c_oldnm));
	}

_STD_END

 #elif _DUMMY_C_LIB
_STD_BEGIN

int (_wrename)(const wchar_t *oldnm, const wchar_t *newnm)
	{	/* rename a file */
	return (-1);
	}
_STD_END

 #else /* _LIB version */
	/* revert to system library */
 #endif /* _LIB version */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
