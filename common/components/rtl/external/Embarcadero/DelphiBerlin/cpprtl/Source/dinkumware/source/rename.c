/* rename function */
#include <stdlib.h>
#include "xstdio.h"

 #ifdef _WIN32_WCE
  #include "wrapwin.h"
_STD_BEGIN

int (rename)(const char *oldnm, const char *newnm)
	{	/* rename a file */

 #if _FN_WIDE
  #define OLDNM wc_oldnm
  #define NEWNM wc_newnm

	wchar_t wc_oldnm[_FNAMAX], wc_newnm[_FNAMAX];

	if (mbstowcs(wc_oldnm, oldnm, _FNAMAX) == (size_t)(-1)
		|| mbstowcs(wc_newnm, newnm, _FNAMAX) == (size_t)(-1))
		return (-1);

 #else /* _FN_WIDE */
  #define OLDNM oldnm
  #define NEWNM newnm
 #endif /* _FN_WIDE */

	return (MoveFile(OLDNM, NEWNM) ? 0 : -1);
	}
_STD_END

 #elif _HAS_POSIX_C_LIB
_STD_BEGIN

 #if _USE_EXISTING_SYSTEM_NAMES
  #define _Unlink unlink
  #define _Link link
 #endif /* _USE_EXISTING_SYSTEM_NAMES */

_EXTERN_C
int _Unlink(const char *);
int _Link(const char *, const char *);
_END_EXTERN_C

int (rename)(const char *oldnm, const char *newnm)
	{	/* rename a file */
	return (link(oldnm, newnm) ? -1 : unlink(oldnm));
	}
_STD_END

 #elif _DUMMY_C_LIB
_STD_BEGIN
int (rename)(const char *oldnm, const char *newnm)
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
