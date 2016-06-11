/*------------------------------------------------------------------------
 * filename - _process.h
 *
 *      definitions of internal routines for exec* and spawn*
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 35783 $ */

#if !defined( __DEFS_H )
#include <_defs.h>
#endif

#if !defined( __TCHAR_H )
#include <_tchar.h>
#endif

#include <stdarg.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

extern  void    (*_exitbuf)(void);
extern  void    (*_exitfopen)(void);
extern  void    (*_exitopen)(void);

int _RTLENTRY _getpid     (void);

#ifdef _MT
#ifndef _UNICODE
void       _lock_env   (void);
void       _unlock_env (void);
#else
void       _wlock_env   (void);
void       _wunlock_env (void);
#endif
#else
#ifndef _UNICODE
#define    _lock_env()
#define    _unlock_env()
#else
#define    _wlock_env()
#define    _wunlock_env()
#endif
#endif

#ifndef _UNICODE
int        _setenv     (const char *__string);
int        _LoadProg   (int __mode, const char *__path, const char * const * __argp,
                        const char * const * __envV, int __usepath);
#else
int        _wsetenv    (const wchar_t *__string);
int        _wLoadProg  (int __mode, const wchar_t *__path, const wchar_t * const * __argp,
                        const wchar_t * const * __envV, int __usepath);
#endif

#ifdef __OS2__
int        _noinherit  (int __handle);
#endif

void _RTLENTRY __exit(int quick, int dontexit, int errcode, void *handle);
int _RTLENTRY  __atexit(atexit_t func, void *handle);
void _RTLENTRY __call_atexit_procs(void *handle);
extern void *_hInstance;

int _RTLENTRY _cwait   (int *__term_stat, int __pid, int __action);

void       _abort      (void);

char * _RTLENTRY _EXPFUNC _getenv_nolock(const char *nameP);
wchar_t * _RTLENTRY _EXPFUNC _wgetenv_nolock(const wchar_t *nameP);

char ** _make_arglist(const char *first, va_list ap, int extra);
wchar_t ** _wmake_arglist(const wchar_t *first, va_list ap, int extra);

#ifdef __cplusplus
}
#endif
