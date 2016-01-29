////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Модуль: "w:/shared/Core/fix/mpcxc.h"
// генератор заголовочных файлов C++ (.h)
// Generated from UML model, root element: <<UtilityPack::Class>> shared::Core::fix::mpcxc
//
// множественные исправления ACE, и др...
// От этого НУЖНО избавиться!!!
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#ifndef __SHARED_CORE_FIX_MPCXC_H__
#define __SHARED_CORE_FIX_MPCXC_H__


//#UC START# *45011F4F00FA_USER_INCLUDES*
#if defined(WIN32) || defined(_MSC_VER)
#define BUILTIN_CDECLSTDCALL
#else
#define IGNORE_CDECLSTDCALL
#endif

#if !defined(WIN32) && !defined(_MSC_VER)
	#define PLATFORM_INDEPENDENT_PATH
#endif

#if !defined(BUILTIN_CDECLSTDCALL) && defined(IGNORE_CDECLSTDCALL)
#define __cdecl
#define __stdcall
#define __declspec(x)
#elif !defined(BUILTIN_CDECLSTDCALL) && !defined(IGNORE_CDECLSTDCALL)
#error Attributes __cdecl/__stdcall have no sence.
#else // defined(BUILTIN_CDECLSTDCALL) && takes no care about IGNORE_CDECLSTDCALL
// __cdecl/__stdcall are keywords of a compiler
#endif

#define MPCXC_MAX_PATH 256 // remember to eliminate <cstring> code from Garant at all in the future
#define MPCXC_PATHBRK '\\' // these ancient macros should be replaced by constants

#if !defined(__cplusplus)
typedef int bool;
#endif

// ACE is first include in C++ mode to avoid /MD linkage in *_Static conf. under Windows
#if defined(__cplusplus)
#include "ace/ACE.h"
#include <iostream>
#include <cstdio>
#else
#include <stdio.h>
#endif

#if defined(__cplusplus)

#include "ace/Basic_Types.h"

// GARANT_MPCXC: Multi-Platform Common eXtra Code with C++ linkage

#include <string>
#include <stdexcept>
std::string platform_independent_path(const std::string& path) /*throw (std::logic_error)*/;
extern void mpcxc_set_se_handler ();
extern char* mpcxc_ulltoa_cpp(ACE_UINT64, char*, int);

extern "C" {
#endif

#if !defined(WIN32) && !defined(_MSC_VER)
extern void* __cdecl alloca(size_t); // native on all platforms supported
#else
#include <malloc.h>
#endif

// GARANT_MPCXC: Multi-Platform Common eXtra Code with C linkage

extern const size_t MPCXC_STACK_SIZE;

typedef int (*MainFunctionPtr)(int, char *[]);
extern int mpcxc_run_main_stack_size (MainFunctionPtr, int, char *[], size_t);

extern long mpcxc_timezone(void);

// slashes replacement
extern FILE* mpcxc_fopen(const char* fname, const char* mode);

extern long mpcxc_fseek(FILE*, long, int);

extern void mpcxc_fgetpos(FILE*, long*);
extern void mpcxc_fsetpos(FILE*, const long*);

enum code_t 
{
	cd_koi = 0,
	cd_dos = 1,
	cd_win = 2,
	cd_mac = 3
};

extern enum code_t mpcxc_cd_cursys(void); // GARANT_CROSSP: codepage of target OS
extern const char* mpcxc_encoding(void); // GARANT_CROSSP: return "win", "koi", "dos", "mac"

extern char* mpcxc_strtolower(char*, unsigned int);
extern char* mpcxc_strtoupper(char*, unsigned int);

extern const int MPCXC_FILE_ATTR_RW;
extern const int MPCXC_FILE_ATTR_RO;
extern bool mpcxc_chmod(const char *fname, int mpcxc_mode);

extern void mpcxc_makepath(char *path, const char *drive, const char *dir, const char *fname, const char *ext); // tmp

extern char* mpcxc_ltoa(long, char*, int);
extern char* mpcxc_ultoa(unsigned long, char*, int);
extern char* mpcxc_ulltoa(double, char*, int);

extern size_t MPCXC_GetPrivateProfileString(
  const char* lpAppName
  , const char* lpKeyName
  , const char* lpDefault
  , char* lpReturnedString
  , unsigned int nSize
  , const char* lpFileName
  );            
extern bool MPCXC_WritePrivateProfileString(
  const char* lpAppName
  , const char* lpKeyName
  , const char* lpString
  , const char* lpFileName
  );
        
extern bool MPCXC_CharToOem(const char* from, char* to);

extern int __cdecl getch(void); // native under windows

extern char* mpcxc_strrev(char *);

extern const int ACE_OS_O_RDONLY;
extern const int ACE_OS_O_WRONLY;
extern const int ACE_OS_O_RDWR;
extern const int ACE_OS_O_CREAT;
extern const int ACE_OS_O_TRUNC;
extern const int ACE_OS_O_BINARY;
extern const int ACE_OS_O_TEXT;
extern const int ACE_OS_O_EXCL;

extern const int ACE_OS_SEEK_SET;
extern const int ACE_OS_SEEK_CUR;
extern const int ACE_OS_SEEK_END;

extern int c_io_open(const char* fname, int flags);
extern int c_io_read(int fd, void* buf, int len);
extern int c_io_write(int fd, const void* buf, int len);
extern int c_io_lseek(int fd, int offset, int whence);
extern int c_io_tell(int fd);
extern int c_io_filesize(int fd);
extern int c_io_close(int fd);
extern void close_opened_files ();
extern int c_io_file_flush(int fd);

extern int ace_os_open(const char* fname, int flags);
extern int ace_os_open3(const char* fname, int flags, int prot);
extern int ace_os_read(int fd, void* buf, size_t len);
extern int ace_os_write(int fd, const void* buf, size_t len);
extern long ace_os_lseek(int fd, long offset, int whence);
extern long ace_os_tell(int fd);
extern long ace_os_filesize(int fd);
extern int ace_os_ftruncate(int fd, long offset);
extern int ace_os_close(int fd);
extern int ace_os_unlink(const char* fname);
extern int ace_os_rename(const char* fname1, const char* fname2);
extern int ace_os_copyfile(const char* fname1, const char* fname2);
extern void ace_os_date_win32(long *dosdateptr);
extern void ace_os_sleep(unsigned long milliseconds);
extern int ace_os_mkdir(const char* dirname);
extern int ace_os_dup(int);
extern FILE* ace_os_fdopen(int, const char*);
extern int ace_os_file_flush(int fd);

#ifdef __cplusplus
} // extern "C"
#endif
//#UC END# *45011F4F00FA_USER_INCLUDES*


//#UC START# *45011F4F00FA_USER_DEFINITION*
//#UC END# *45011F4F00FA_USER_DEFINITION*



#endif //__SHARED_CORE_FIX_MPCXC_H__
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
