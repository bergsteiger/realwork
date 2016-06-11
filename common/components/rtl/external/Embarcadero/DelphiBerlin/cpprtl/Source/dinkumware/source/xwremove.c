/* _wremove function */
#include <stdlib.h>
#include "xstdio.h"
_STD_BEGIN

 #if _USE_EXISTING_SYSTEM_NAMES

  #if _FN_WIDE

  #else /* _FN_WIDE */
   #define _Unlink	unlink
  #endif /* _FN_WIDE */

 #endif /* _USE_EXISTING_SYSTEM_NAMES */

_EXTERN_C
int _Unlink(const char *);
int _WUnlink(const wchar_t *);
_END_EXTERN_C

 #if _HAS_POSIX_C_LIB || _WIN32_C_LIB
int (_wremove)(const wchar_t *filename)
	{	/* remove a file */

 #if _FN_WIDE
	return (_WUnlink(filename));

 #else /* _FN_WIDE */
	char c_fname[_FNAMAX];

	if (wcstombs(c_fname, filename, _FNAMAX) == (size_t)(-1))
		return (-1);
	else
		return (_Unlink(c_fname));
 #endif /* _FN_WIDE */

	}

 #elif _DUMMY_C_LIB
int (_wremove)(const wchar_t *fname)
	{	/* remove a file */
 	return (-1);
	}

 #else /* _LIB version */
	/* revert to system library */
 #endif /* _LIB version */

_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
