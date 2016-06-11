/*------------------------------------------------------------------------
 * filename - ntbc.h
 *
 *  NT API functions and definitions
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1993, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 35396 $ */

#ifndef _NTBC_H
#define _NTBC_H

#pragma option push -a8 -w-bbf  // -w-bbf is needed here since we'll be
                                // bypassing Windows.h which does this in
                                // an MS #pragma warning(disable:4214)

#if defined(_WIN64)
#define _AMD64_
#else
#if !defined(__clang__)
#define _M_IX86 300
#endif
#define _X86_
#define i386
#endif
#define WIN32
#define NONAMELESSUNION
#define NO_ANONYMOUS_STRUCT
#ifdef __cplusplus
#  define __inline inline
#endif


#ifdef _UNICODE
#define UNICODE
#endif

#if defined(__cplusplus)
#  define _WCHAR_T_DEFINED
#endif

#if defined(NONAMELESSUNION) && !defined(_UNION_NAME)
# define _UNION_NAME(X) X
#else
# define _UNION_NAME(X)
#endif

#ifndef INCL_ERROR_H
#define _WINERROR_      /* prevent including winerror.h */
#endif

#include <stdarg.h>
#include <excpt.h>

#if !defined(__cplusplus)
#if defined(_WIN64)
#include <windows.h>
#include <dosexcpt.h>
#else
#include <windef.h>
#include <winbase.h>
#include <dosexcpt.h>       /* OS-2 compatible exception definitions */
#endif

#ifdef INCL_USER
#include <wingdi.h>
#include <winuser.h>
#endif

#ifdef INCL_CON
#include <wincon.h>
#endif

#else
#if defined(__clang__)
#include <windows.h>
#else
#include <windows.hpp>
#endif
#endif

#if !defined(STATUS_FATAL_APP_EXIT)    
#define STATUS_FATAL_APP_EXIT            (0x40000015L)
#endif

#pragma option pop
#endif  /* _NTBC_H */

