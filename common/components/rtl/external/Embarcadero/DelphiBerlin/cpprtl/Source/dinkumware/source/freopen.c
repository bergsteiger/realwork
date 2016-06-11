/* freopen function */
#include <stdlib.h>
#include "xstdio.h"
_STD_BEGIN

FILE *(freopen)(const char *_Restrict filename,
	const char *_Restrict mods,
	FILE *_Restrict str)
	{	/* reopen a file */
	unsigned short mode;

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
	mode = (unsigned short)(str->_Mode & _MALFIL);
	str->_Mode &= ~_MALFIL;
	fclose(str);
	str->_Mode = mode;

	_Lockfileatomic(str);
	str = _Foprep(NAME, MODS, str, _FD_INVALID);
	_Unlockfileatomic(str);

	_Unlocksyslock(_LOCK_STREAM);
	return (str);
	}
_STD_END

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
