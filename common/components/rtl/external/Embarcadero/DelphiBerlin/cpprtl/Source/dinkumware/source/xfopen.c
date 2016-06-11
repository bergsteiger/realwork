/* _Fopen function */
#include <assert.h>
#include "xstdio.h"

 #ifdef _WIN32_WCE
  #include "wrapwin.h"

_STD_BEGIN

HANDLE _Fopen(const _Sysch_t *name, unsigned int smode,
	const _Sysch_t *mods)
	{	/* open a file */
	HANDLE res;
	unsigned int acc;
	static const unsigned int rwacc[] =
		{0, GENERIC_READ, GENERIC_WRITE, GENERIC_READ|GENERIC_WRITE};

	acc = rwacc[smode & 0x03];
	if (smode & _MCREAT)
		{	/* create a file */
		res = CreateFile(name, acc, 0, 0,
			smode & _MOPENA ? OPEN_EXISTING : TRUNCATE_EXISTING,
			FILE_ATTRIBUTE_NORMAL, 0);
		if (res == INVALID_HANDLE_VALUE)
			res = CreateFile(name, acc, 0, 0,
				CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
		if (res != INVALID_HANDLE_VALUE && (smode & _MOPENA))
			SetFilePointer(res, 0, 0, FILE_END);
		}
	else
		res = CreateFile(name, acc, 0, 0,
			OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
	return (res == INVALID_HANDLE_VALUE ? 0 : res);
		}
_STD_END

 #else /* _WIN32_WCE */

  #if defined(__BORLANDC__)
   #pragma warn -par
  #endif /* defined(__BORLANDC__) */

_STD_BEGIN

  #if (_MOPENR | _MOPENW) != 0x03
   #error BAD ASSUMPTION ABOUT _MOPENR | _MOPENW
  #endif /* (_MOPENR | _MOPENW) != 0x03 */

  #if _USE_EXISTING_SYSTEM_NAMES
   #define _Open __open
  #endif /* _USE_EXISTING_SYSTEM_NAMES */

 #if defined(__MWERKS__)	/* compiler test */
  #define O_RDONLY	2
  #define O_WRONLY	4
  #define O_RDWR		1

  #define O_APPEND	0x0100
  #define O_TRUNC	0x0800
  #define O_CREAT	0x0200

  #define DEF_PERMS	0x0180
  #define _BINARY	0x8000
  #define _TEXT		0

 #else /* defined(__MWERKS__) */
  #define O_RDONLY	0
  #define O_WRONLY	1
  #define O_RDWR		2

  #if _LINUX_C_LIB
   #define O_APPEND	02000
   #define O_TRUNC	01000
   #define O_CREAT	00100

  #else /* _LINUX_C_LIB */
   #define O_APPEND	0x0008
   #define O_TRUNC	0x0200
   #define O_CREAT	0x0100
  #endif /* _LINUX_C_LIB */

  #if _HAS_POSIX_C_LIB
   #define DEF_PERMS	0666
   #define _BINARY	0
   #define _TEXT		0

  #else /* _HAS_POSIX_C_LIB */
   #define DEF_PERMS	0x0180
   #define _BINARY	0x8000
   #define _TEXT		0x4000
  #endif /* _HAS_POSIX_C_LIB */

 #endif /* defined(__MWERKS__) */

_EXTERN_C
int _Open(const char *, int, int);
_END_EXTERN_C

_FD_TYPE _Fopen(const char *path, unsigned int smode,
	const char *mods)
	{	/* open a file */
	unsigned int acc;
	static const unsigned int rwacc[] =
		{0, O_RDONLY, O_WRONLY, O_RDWR};

	acc = rwacc[smode & 0x03];
	if (smode & _MOPENA)
		acc |= O_APPEND;
	if (smode & _MTRUNC)
		acc |= O_TRUNC;
	if (smode & _MCREAT)
		acc |= O_CREAT;
	if (smode & _MBIN)
		acc |= _BINARY;
	else
	 	acc |= _TEXT;
	return ((_FD_TYPE)_Open(path, acc, DEF_PERMS));
		}
_STD_END
 #endif /* _WIN32_WCE */

/*
 * Copyright (c) 1992-2006 by P.J. Plauger.  ALL RIGHTS RESERVED.
 * Consult your license regarding permissions and restrictions.
V5.01:1422 */
