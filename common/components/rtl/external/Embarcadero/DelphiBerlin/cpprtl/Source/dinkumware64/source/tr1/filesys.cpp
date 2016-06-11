// filesys.cpp -- filesystem support functions
#include <yvals.h>

 #if _HAS_CPP0X
#include <filesystem>

 #if _WIN32_C_LIB
 #if __EDG__
#pragma diag_suppress=161	/* unknown pragma */
#pragma diag_suppress=174	/* expression has no effect */
#pragma diag_suppress=177	/* variable declared but never references */
#pragma diag_suppress=748	/* calling convention specified more than once */
#pragma diag_suppress=940	/* missing return statement */
 #endif /* __EDG__ */

#include <wrapwin.h>
#include <io.h>	/* for _chmod/_wchmod */

  #ifndef INVALID_FILE_ATTRIBUTES
   #define INVALID_FILE_ATTRIBUTES	0
  #endif /* INVALID_FILE_ATTRIBUTES */

  #ifndef INVALID_SET_FILE_POINTER
   #define INVALID_SET_FILE_POINTER	(0U - 1)
  #endif /* INVALID_SET_FIE_POINTER */

#define _FILE_ATTRIBUTE_REGULAR	\
	(FILE_ATTRIBUTE_ARCHIVE \
	| FILE_ATTRIBUTE_COMPRESSED \
	| FILE_ATTRIBUTE_ENCRYPTED \
	| FILE_ATTRIBUTE_HIDDEN \
	| FILE_ATTRIBUTE_NORMAL \
	| FILE_ATTRIBUTE_NOT_CONTENT_INDEXED \
	| FILE_ATTRIBUTE_OFFLINE \
	| FILE_ATTRIBUTE_READONLY \
	| FILE_ATTRIBUTE_SPARSE_FILE \
	| FILE_ATTRIBUTE_SYSTEM \
	| FILE_ATTRIBUTE_TEMPORARY)

_STD_BEGIN
namespace tr2 {
	namespace sys {
static _File_type _Map_mode(int _Mode)
	{	// map Windows file attributes to file_status
	if ((_Mode & FILE_ATTRIBUTE_DIRECTORY) != 0)
		return (_File_type::directory);
	else if ((_Mode & _FILE_ATTRIBUTE_REGULAR) != 0)
		return (_File_type::regular);
	else
		return (_File_type::unknown);
	}

_FS_DLL void _PCDECL _Close_dir(void *_Handle)
	{	// close a directory
	FindClose((HANDLE)_Handle);
	}

 #define FILESYS_WIDE	1
 #include "filesys.h"

 #if _GHS	/* compiler test */
 #define FILESYS_WIDE	0
 #include "filesys.h"
 #endif /* _GHS */
	}	//namespace sys
}	// namespace tr2
_STD_END

 #elif _HAS_POSIX_C_LIB
#include <fstream>	// for ifstream/ofstream
#include <dirent.h>	// for opendir, readdir_r, closedir
#include <errno.h>
#include <unistd.h>	// for getcwd
#include <utime.h>	// for utimbuf
#include <sys/stat.h>	// for chmod, mkdir, lstat, stat
#include <sys/statvfs.h>	// for statvfs

_STD_BEGIN
namespace tr2 {
	namespace sys {
static _File_type _Map_mode(int _Mode)
	{	// map Posix mode to file_status
	if (S_ISREG(_Mode))
		return (_File_type::regular);
	else if (S_ISDIR(_Mode))
		return (_File_type::directory);
	else if (S_ISLNK(_Mode))
		return (_File_type::symlink);
	else if (S_ISBLK(_Mode))
		return (_File_type::block);
	else if (S_ISCHR(_Mode))
		return (_File_type::character);
	else if (S_ISFIFO(_Mode))
		return (_File_type::fifo);
 #ifdef S_ISSOCK
	else if (S_ISSOCK(_Mode))
		return (_File_type::socket);
 #endif /* S_ISSOCK */
	else
		return (_File_type::unknown);
	}

void _Close_dir(void *_Handle)
	{	// close a directory
	closedir((DIR *)_Handle);
	}

static char *_Strcpy_narrow(char *_Dest, const wchar_t *_Src)
	{	// copy wide to narrow
	char *_Ans = _Dest;
	int _Left = _MAX_FILESYS_NAME - 1;

 #if 0
	for (; 0 < _Left && *_Src != L'\0'; --_Left)
		*_Dest++ = (char)*_Src++;

 #else /* 0 */
	for (; 0 < _Left && *_Src != L'\0'; )
		{	// convert UCS-2/4 to UTF-8
		wchar_t _Wc = *_Src++;
		int _Nextra;

		if ((_Wc & (wchar_t)~0x7f) == 0)
			{	// generate a single byte
			*_Dest++ = (unsigned char)_Wc;
			_Nextra = 0;
			}
		else if ((_Wc & (wchar_t)~0x7ff) == 0)
			{	// generate two bytes
			*_Dest++ = (unsigned char)(0xc0 | _Wc >> 6);
			_Nextra = 1;
			}
		else if ((_Wc & (wchar_t)~0xffff) == 0)
			{	// generate three bytes
			*_Dest++ = (unsigned char)(0xe0 | _Wc >> 12);
			_Nextra = 2;
			}
		else if ((_Wc & (wchar_t)~0x1fffff) == 0)
			{	// generate four bytes
			*_Dest++ = (unsigned char)(0xf0 | _Wc >> 18);
			_Nextra = 3;
			}
		else if ((_Wc & (wchar_t)~0x3ffffff) == 0)
			{	// generate five bytes
			*_Dest++ = (unsigned char)(0xf8 | _Wc >> 24);
			_Nextra = 4;
			}
		else
			{	// generate six bytes
			*_Dest++ = (unsigned char)(0xfc | (_Wc >> 30 & 0x03));
			_Nextra = 5;
			}

		for (--_Left; 0 <= --_Nextra && 0 < _Left; --_Left)
			*_Dest++ = (unsigned char)(0x80 | (_Wc >> 6 * _Nextra & 0x3f));
		}
 #endif /* 0 */

	*_Dest = L'\0';
	return (_Ans);
	}

static wchar_t *_Strcpy_widen(wchar_t *_Dest, const char *_Src)
	{	// copy narrow to wide
	wchar_t *_Ans = _Dest;
	int _Left = _MAX_FILESYS_NAME - 1;

 #if 0
	for (; 0 < _Left && *_Src != '\0'; --Left)
		*_Dest++ = (wchar_t)*_Src++;

 #else /* 0 */
	for (; 0 < _Left && *_Src != '\0'; )
		{	// convert UTF-8 to UCS-2/4
		wchar_t _Wc;
		int _Nextra;

		if ((*_Src & 0x80) == 0)
			{	// consume a single byte
			_Wc = *_Src;
			_Nextra = 0;
			}
		else if ((*_Src & 0xe0) == 0xc0)
			{	// consume first of two bytes
			_Wc = (wchar_t)(*_Src & 0x1f);
			_Nextra = 1;
			}
		else if ((*_Src & 0xf0) == 0xe0)
			{	// consume first of three bytes
			_Wc = (wchar_t)(*_Src & 0x0f);
			_Nextra = 2;
			}
		else if ((*_Src & 0xf8) == 0xf0)
			{	// consume first of four bytes
			_Wc = (wchar_t)(*_Src & 0x07);
			_Nextra = 3;
			}
		else if ((*_Src & 0xfc) == 0xf8)
			{	// consume first of five bytes
			_Wc = (wchar_t)(*_Src & 0x03);
			_Nextra = 4;
			}
		else
			{	// consume first of six bytes
			_Wc = (wchar_t)(*_Src & 0x03);
			_Nextra = 5;
			}

		for (--_Left, ++_Src; 0 < _Left && 0 < _Nextra;
			--_Nextra, --_Left, ++_Src)
			if ((*_Src & 0xc0) != 0x80)
				break;	// bad encoding
			else
				_Wc = (_Wc << 6) | (*_Src & 0x3f);

		*_Dest++ = _Wc;
		}
 #endif /* 0 */

	*_Dest = '\0';
	return (_Ans);
	}

// #define FILESYS_WIDE	1
// #include "filesys.h"

 #define FILESYS_WIDE	0
 #include "filesys.h"
	}	//namespace sys
}	// namespace tr2
_STD_END

 #else /* library type */
  #error Unknown platform
 #endif	/* library type */
 #endif /* _HAS_CPP0X */

/*
 * Copyright (c) by P.J. Plauger. All rights reserved.
 * Consult your license regarding permissions and restrictions.
V6.50:1422 */
