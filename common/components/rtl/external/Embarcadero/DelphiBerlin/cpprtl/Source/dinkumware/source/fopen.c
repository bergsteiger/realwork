/* fopen function */
#include "xstdio.h"

 #if _FN_WIDE
  #include "wrapwin.h"
 #endif /* _FN_WIDE */

_STD_BEGIN

FILE *(fopen)(const char *_Restrict filename,
	const char *_Restrict mods)
	{	/* open a file, given name */
	FILE *str;

 #if _FN_WIDE
  #define NAME wc_name
  #define MODS wc_mods

	wchar_t wc_name[_FNAMAX];
	wchar_t wc_mods[10];

	if (mbstowcs(wc_name, filename, _FNAMAX) == (size_t)(-1)
		|| mbstowcs(wc_mods, mods, 10) == (size_t)(-1))
		return (0);

 #else /* _FN_WIDE */
  #define NAME filename
  #define MODS mods
#endif /* _FN_WIDE */


	_Locksyslock(_LOCK_STREAM);
	str = _Foprep(NAME, MODS, _Fofind(), _FD_INVALID);
	_Unlocksyslock(_LOCK_STREAM);
	return (str);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
