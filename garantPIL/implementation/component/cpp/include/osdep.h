#ifndef __OSDEP_H__
#define __OSDEP_H__

/* General platform/compiler defines.
 * Used to define platform symbols, i. e. one of
 * { __WIN32__, __FreeBSD__, Solaris__, __Linux__, __DOS32__, __WIN16__, __DOS16__}
 * */

#if defined (__cplusplus) && defined (USE_ACE)
#include "ace/OS.h"
#endif

#ifdef WIN32
 #ifndef __WIN32__
  #define __WIN32__
 #endif
#endif

#ifdef sun
#define __Solaris__
#define __Sun__
#endif

#ifdef linux
#define __Linux__
#endif

#if defined (_MSC_VER)
	#define __MSVC__
	#if _MSC_VER <= 800 && _MSC_VER > 0
		#define __WIN16__
	#else
		#ifndef __WIN32__
			#define __WIN32__
		#endif
	#endif
#endif

#ifdef __GO32__
	#define __DOS32__
#endif

#ifdef __CYGWIN32__
	#define __WIN32__
#endif

#ifdef	__DPMI16__
	#define	__DOS16__
#endif

#ifdef	__BORLANDC__
	#define	__DOS16__
#endif

/*
 * Common constants that defines target- and compiler-specific options.
 * Generally, we need to find the following options:
 *  - platform-independent set of known-size int types
 *  - the same pointer type named caddr_t
 *  - presence of several header files with function prototypes
 *  - platform-indepenednt string function
 */

#define __OSDEP_NEED_DOS_DATE

#if   defined (__FreeBSD__)                       /* FreeBSD/GCC */
	#define __OSDEP_DUMMY_O_BINARY
	#define __OSDEP_NEED_STR_I_FUNCS
	#define __OSDEP_NEED_CHSIZE
	#define __OSDEP_HAS_STRCASE_FUNCS
	#define __OSDEP_HAS_FTRUNC
	#define __OSDEP_DUMMY_CDECL
	#define __OSDEP_DUMMY_HEAP_FN
	#define __OSDEP_NEED_FILELENGTH
#elif defined (__Linux__)                         /* Linux/GCC */
	#define __OSDEP_DUMMY_O_BINARY
	#define __OSDEP_NEED_STR_I_FUNCS
	#define __OSDEP_NEED_CHSIZE
	#define __OSDEP_HAS_STRCASE_FUNCS
	#define __OSDEP_HAS_FTRUNC
	#define __OSDEP_DUMMY_CDECL
	#define __OSDEP_DUMMY_HEAP_FN
	#define __OSDEP_NEED_FILELENGTH
#elif defined (__Solaris__)                       /* Solaris/{GCC, Sun cc} */
	#define __OSDEP_DUMMY_O_BINARY
	#define __OSDEP_NEED_STR_I_FUNCS
	#define __OSDEP_NEED_CHSIZE
	#define __OSDEP_HAS_STRCASE_FUNCS
	#define __OSDEP_HAS_FTRUNC
	#define __OSDEP_NEED_SOLARIS_INT_TYPES
	#define __OSDEP_DUMMY_CDECL
	#define __OSDEP_DUMMY_HEAP_FN
	#define __OSDEP_NEED_FILELENGTH
#elif defined (__DOS16__)                         /* DOS/Borland C++ 4.5 */
	#define __OSDEP_NEED_INT_TYPES
	#define __OSDEP_NEED_CADDR_T
	#define __OSDEP_NEED_BZERO
	#define __OSDEP_NEED_STRCASE_FUNCS
	#define __OSDEP_HAS_STR_I_FUNCS
	#define __OSDEP_HAS_CHSIZE
	#define __OSDEP_HAS_DUMB_POINTERS
	#define __OSDEP_INT64_NOT_SUPPORTED
	#define __OSDEP_NEED_MKSTEMP
	#define __OSDEP_HAS_HEAPCHECK
	#undef	__OSDEP_NEED_DOS_DATE
	#define	__OSDEP_DOS_FAR_GK
	#define __DISABLE_CXX_EXCEPTIONS__
#elif defined (__DOS32__)                         /* DOS/{Borland C 4.5, GCC} */
	#ifdef __GNUC__
		#define __OSDEP_NEED_STR_I_FUNCS
		#define __OSDEP_NEED_CHSIZE
		#define __OSDEP_HAS_STRCASE_FUNCS
		#define __OSDEP_HAS_FTRUNC
		#define __OSDEP_DUMMY_CDECL
		#define __OSDEP_DUMMY_HEAP_FN
	#else
		#define __OSDEP_NEED_OFF_T
		#define __OSDEP_NEED_BZERO
		#define __OSDEP_NEED_FTRUNCATE
		#define __OSDEP_NEED_STRCASE_FUNCS
		#define __OSDEP_HAS_STR_I_FUNCS
		#define __OSDEP_HAS_CHSIZE
		#define __OSDEP_NEED_MKSTEMP
		#define __OSDEP_NEED_GETOPT
	#endif
	#define __OSDEP_NEED_INT_TYPES
	#define __OSDEP_NEED_CADDR_T
	#define __DISABLE_CXX_EXCEPTIONS__
#elif defined (__WIN16__)                         /* Win16/MSVC 1.52 */
	#define __OSDEP_NEED_INT_TYPES
	#define __OSDEP_NEED_CADDR_T
	#define __OSDEP_NEED_BZERO
	#define __OSDEP_NEED_OFF_T
	#define __OSDEP_NEED_STRCASE_FUNCS
	#define __OSDEP_HAS_DUMB_POINTERS
	#define __OSDEP_INT64_NOT_SUPPORTED
	#define __OSDEP_MSVC_HUGE_GK
	#define __OSDEP_HAS_STR_I_FUNCS
	#define __OSDEP_HAS_CHSIZE
	#define __OSDEP_DUMMY_HEAP_FN
	#define __DISABLE_CXX_EXCEPTIONS__
#elif defined (__WIN32__)                         /* Win32/{Cygwin, GNU Win32, MSVC 4+} */
	#ifdef __GNUC__
		#define __OSDEP_NEED_STR_I_FUNCS
		#define __OSDEP_NEED_CHSIZE
		#define __OSDEP_HAS_FTRUNC
		#define __OSDEP_HAS_STRCASE_FUNCS
		#define __OSDEP_DUMMY_CDECL
		#define __OSDEP_NEED_FILELENGTH
		#ifdef __CYGWIN32__                          /* Assume we use Cygwin b18 */
			#define __OSDEP_USE_ATTRIBUTE_PACKED
		#endif
	#else
		#define __OSDEP_NEED_GETOPT
		#define __OSDEP_NEED_CADDR_T
		#if (_MSC_VER < 1800)
			#define __OSDEP_NEED_OFF_T
			#define __OSDEP_NEED_BZERO
			#define __OSDEP_NEED_FTRUNCATE
			#define __OSDEP_NEED_STRCASE_FUNCS
			#define __OSDEP_MS_INT64
			#define __OSDEP_HAS_CHSIZE
			#define __OSDEP_HAS_STR_I_FUNCS
			#define __OSDEP_NEED_MKSTEMP
			#define __OSDEP_MS_POINTERS_STYLE
			#define __OSDEP_NEED_SLEEP
			//		#define __OSDEP_NEED_ALLOCA
			//		#define __DISABLE_CXX_EXCEPTIONS__
		#endif
	#endif
	#if defined (_MSC_VER) && (_MSC_VER >= 1800) //MSVC++ 12.0 _MSC_VER == 1800 (Visual Studio 2013)
		#define __OSDEP_NEED_INT_TYPES_FOR_CPP11
	#elif !defined (__CYGWIN_EGCS__)
		#define __OSDEP_NEED_INT_TYPES
	#endif
	#define __OSDEP_DUMMY_HEAP_FN
#else
	#error Unknown target platform
#endif

/*
 * General defines, types, etc.
 * Worked as requested by platform-specific defines
 */

#include <sys/types.h>

/* GARANT_REDEFINED
#if defined(__DOS32__) || defined(__WIN32__) || defined(__WIN16__) || defined(__DOS16__)
#define PATHBRK '\\'
#else
#define PATHBRK '/'
#endif
*/

#ifdef __OSDEP_NEED_INT_TYPES
	typedef unsigned char u_int8_t;
	typedef signed char int8_t;
	typedef unsigned short u_int16_t;
	typedef signed short int16_t;
	typedef unsigned long u_int32_t;
	typedef signed long int32_t;
	#ifndef __OSDEP_INT64_NOT_SUPPORTED
		#if defined (__OSDEP_MS_INT64)
			typedef _int64 int64_t;
			typedef unsigned _int64 u_int64_t;
		/* #elif defined (__OSDEP_ANY_OTHER_INT64_STYLE) */
		#else
			typedef long long int64_t;
			typedef unsigned long long u_int64_t;
		#endif
	#endif
#endif

#ifdef __OSDEP_NEED_INT_TYPES_FOR_CPP11
	#include <stdint.h>

	#define bzero(dst, size)	memset (dst, 0, size)

	typedef uint8_t u_int8_t;
	typedef uint16_t u_int16_t;
	typedef uint32_t u_int32_t;
	typedef uint64_t u_int64_t;
#endif

#ifdef __OSDEP_NEED_SOLARIS_INT_TYPES
	typedef uint8_t u_int8_t;
	typedef uint16_t u_int16_t;
	typedef uint32_t u_int32_t;
	typedef uint64_t u_int64_t;
#endif

#ifdef __OSDEP_NEED_CADDR_T
#ifndef ACE_CC_MAJOR_VERSION
	typedef void *caddr_t;
#endif
#endif

//#ifdef __OSDEP_NEED_SLEEP
//	#define sleep _sleep;
//#endif

#ifdef __OSDEP_NEED_OFF_T
	typedef int32_t off_t;
#endif

#ifndef __OSDEP_HAS_DUMB_POINTERS
	#ifndef __OSDEP_MS_POINTERS_STYLE
		#if (_MSC_VER < 1800) 
			#define far
			#define FAR   
		#endif
		#define huge
		//#define HUGE // GARANT_REDEFINED
	#endif
#define gk_far
#define gk_huge
#else
#define gk_far far
#define gk_huge huge
#endif

#if defined (__OSDEP_MSVC_HUGE_GK)
	#define gk_malloc(a) _halloc(a,1)
	#define gk_free(a) _hfree(a)
	#define gk_memcpy(a,b,c) memcpy(a,b,c)
	#define gk_bzero(a,b) memset(a,0,b)
#elif defined (__OSDEP_DOS_FAR_GK)
	#define gk_malloc(a) farmalloc(a)
	#define gk_free(a) farfree(a)

	#ifdef __cplusplus
	extern "C" {
	#endif
	void	_cdecl	gk_bzero  ( void *, long );
	void    _cdecl	gk_memcpy ( void *, const void *, long );
	#ifdef __cplusplus
	}
	#endif
#else
	#define gk_malloc(a) malloc(a)
	#define gk_free(a) free(a)
	#define gk_memcpy(a,b,c) memcpy(a,b,c)
	#define gk_bzero(a,b) memset(a,0,b)
#endif

#ifdef __OSDEP_NEED_STRCASE_FUNCS
	#ifndef __OSDEP_HAS_STR_I_FUNCS
		#error Unable properly handle strcasecmp functions
	#else
		#define strcasecmp strcmpi
		#define strncasecmp strncmpi
	#endif
#endif

#ifdef __OSDEP_NEED_STR_I_FUNCS
	#ifndef __OSDEP_HAS_STRCASE_FUNCS
		#error Unable properly handle stricmp functions
	#else
		#ifndef strcmpi
			#define strcmpi strcasecmp
		#endif
		#ifndef stricmp
			#define stricmp strcasecmp
		#endif
		#ifndef strncmpi
			#define strncmpi strncasecmp
		#endif
		#ifndef strnicmp
			#define strnicmp strncasecmp
		#endif
	#endif
#endif

#ifdef __OSDEP_NEED_BZERO
	#define bzero(a,b) memset(a,0,b)
#endif

#ifdef __OSDEP_NEED_CHSIZE
	#define chsize ftruncate
#endif

#ifdef __OSDEP_NEED_FTRUNCATE
	#ifndef __OSDEP_HAS_CHSIZE
		#error Unable to handle chsize function
	#else
		#define ftruncate chsize
	#endif
#endif

#ifdef __OSDEP_DUMMY_CDECL
	#define cdecl
#endif

#if defined(__OSDEP_DUMMY_HEAP_FN)
#define heap()
#elif defined __OSDEP_HAS_HEAPCHECK
	#define	heap() 		assert ( heapcheck () == _HEAPOK )
#else
#endif

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __OSDEP_NEED_FILELENGTH
	off_t filelength(int);
#endif

#ifdef __OSDEP_NEED_MKSTEMP
	int mkstemp(char *);
#endif

#ifdef __OSDEP_DUMMY_O_BINARY
	#define O_TEXT 0
	#define O_BINARY 0
#endif  /* __OSDEP_DUMMY_O_BINARY */

#ifdef __OSDEP_USE_ATTRIBUTE_PACKED
	#define __PACKED__ __attribute__((packed))
#else
	#define __PACKED__
#endif

/*
#ifdef __OSDEP_NEED_ALLOCA
#define alloca(x) _alloca((x))
#endif
*/

#ifdef __OSDEP_NEED_DOS_DATE
#pragma pack(1)
struct date
{
	u_int16_t	da_year;
	unsigned char	da_day;
	unsigned char	da_mon;
} __PACKED__;
struct time
{
	unsigned char  ti_min;
	unsigned char  ti_hour;
	unsigned char  ti_hund;
	unsigned char  ti_sec;
} __PACKED__;
#pragma pack()
#else
#include <dos.h>
#endif

#ifdef __cplusplus
}
#endif

#endif  /* __OSDEP_H__ */

