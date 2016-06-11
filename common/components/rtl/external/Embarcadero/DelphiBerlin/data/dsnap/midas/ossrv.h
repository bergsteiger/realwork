/********************************************************
*                                                       *
*                Delphi Runtime Library                 *
*                                                       *
* Copyright(c) 2016 Embarcadero Technologies, Inc.      *
*               All rights reserved                     *
*                                                       *
*   Copyright and license exceptions noted in source    *
*                                                       *
********************************************************/

#ifndef OSSRV_H
#define OSSRV_H
#ifdef __cplusplus
    extern "C" {
#endif // __cplusplus

#include "bdetypes.h"


#define  CopyMem(pDest, pSrc, iLen)  memmove(pDest, pSrc, iLen)
#define  ZeroMem(pDest, iLen)        memset(pDest, 0, iLen)
#define  ByteComp(p1, p2, iLen)      memcmp(p1, p2, iLen)

#if defined(_UNIX)
#include <string.h>
#if defined(__BORLANDC__) && !defined(__arm__) && !defined(__arm64__)
#include <wchar.h>
#endif
#include <stdlib.h>
#include <ctype.h>
#include <stdio.h>
#define LdStrCpy(d, s)     strcpy((pCHAR) d, (pCHAR) s)
#define LdStrCmp(f1, f2)   strcmp((pCHAR) f1, (pCHAR) f2)
#define stricmp(f1, f2)    strcasecmp((pCHAR) f1, (pCHAR) f2)
#define LdStrCmpi(f1, f2)  strcasecmp((pCHAR) f1, (pCHAR) f2)
#define LdStrLen(s)        strlen((pCHAR) s)
#define LdStrCat(s1, s2)   strcat((pCHAR) s1, (pCHAR) s2)
#define LdToUpper(ch)      toupper(*((int*)ch))
#define LdToLower(ch)      tolower(*((int*)ch))
#define lstrcpyn(s1, s2, n ) strncpy( s1, s2, n )
#define min(i1, i2 )       ((i1 > i2) ? i1 : i2)
#define itoa( iVal, pszString, iRadix )  sprintf( pszString, "%d", iVal )
#define _atold( pszString )   strtod( pszString, NULL );
#define UNREFERENCED_PARAMETER( riid ) ( (void)riid )
#else
#define LdStrCpy(d, s)     lstrcpy((pCHAR) d, (pCHAR) s)
#define LdStrCmp(f1, f2)   lstrcmp((pCHAR) f1, (pCHAR) f2)
#define LdStrCmpi(f1, f2)  lstrcmpi((pCHAR) f1, (pCHAR) f2)
#define LdStrLen(s)        lstrlen((pCHAR) s)
#define LdStrCat(s1, s2)   lstrcat((pCHAR) s1, (pCHAR) s2)
#define LdToUpper(ch)      CharUpper(ch)
#define LdToLower(ch)      CharLower(ch)
#endif // ifdef _UNIX

#ifdef _UNIX
typedef unsigned short ucs2char_t;
#else
typedef WCHAR ucs2char_t;
#endif
typedef       ucs2char_t *pUCS2Char;
typedef const ucs2char_t *pCUCS2Char;

#if defined(_UNIX)
  #define NORM_IGNORECASE     1
  #define LCID_SUPPORTED      1
  #define LCID_INSTALLED      2
  #define SORT_STRINGSORT     0x00001000

  #define CSTR_LESS_THAN      1
  #define CSTR_EQUAL          2
  #define CSTR_GREATER_THAN   3

  #define LIBC_LESS_THAN     -1
  #define LIBC_EQUAL          0
  #define LIBC_GREATER_THAN   1

  #define LIBC_TO_CSTR(X)     ((X) > 0 ? CSTR_GREATER_THAN : (X) < 0 ? CSTR_LESS_THAN : CSTR_EQUAL)
  #define IsIgnoreCase(X)     (((X) & NORM_IGNORECASE) == NORM_IGNORECASE)

  typedef UINT32 DWORD;
  typedef wchar_t * LPCWSTR;
  typedef UINT32 LCID;

  int CompareString(LCID lcid, int iCase, pCCHAR pszStr1, int iSize1, pCHAR pszStr2, int iSize2 );
  int CompareStringW( LCID lcid, int iCase, pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2 );
  bool IsValidLocale(LCID lcid, DWORD dwFlags);

#endif

#ifndef UINT
typedef unsigned int        UINT;
#endif

#define LCStrCmp(lcid, f1, f2)   (CompareString(lcid, SORT_STRINGSORT, f1, -1, f2, -1) -2)
#define LCStrCmpi(lcid, f1, f2)  (CompareString(lcid, SORT_STRINGSORT|NORM_IGNORECASE, f1, -1, f2, -1) -2)

#define WLCStrCmp(lcid, l1, f1, l2, f2)   (CompareStringW(lcid, SORT_STRINGSORT, f1, l1, f2, l2) -2)
#define WLCStrCmpi(lcid, l1, f1, l2, f2)  (CompareStringW(lcid, SORT_STRINGSORT|NORM_IGNORECASE, f1, l1, f2, l2) -2)

#define LCStrnCmp(lcid, f1, f2, n)   (CompareString(lcid, SORT_STRINGSORT, f1, n, f2, n) -2)
#define LCStrnCmpi(lcid, f1, f2, n)  (CompareString(lcid, SORT_STRINGSORT|NORM_IGNORECASE, f1, n, f2, n) -2)

pVOID  DBIFN DsCalloc(UINT32 nelem, UINT32 elsize);

VOID   DBIFN DsFree( pVOID q );

pVOID  DBIFN DsMalloc (UINT32 nbytes);


pVOID  DBIFN DsRealloc(pVOID p, UINT32 iSize, UINT32 iNewSize);

// Initializes, and returns Safearray descriptor
// Returns buffer of 'iInitial size'. NULL if out of memory
// The buffer is LOCKED, and needs to be unlocked by calling 'SATruncate'
// before passing array to other subsystem, or by calling SAExit
pVOID DBIFN SAInit(UINT32 iInitialSize, SAFEARRAY **ppSa);

// Deallocates safearray descriptor, and memory
VOID DBIFN SAExit(SAFEARRAY *pSa);

// Get and lock data pointer
pVOID DBIFN SAGetPtr(SAFEARRAY *pSa);

// Unlock data pointer (used if SAGetPtr was used)
VOID  DBIFN SARelPtr(SAFEARRAY *pSa);

// Reallocates memory, and returns new pointer
#define SARealloc(pSa, iSize) SAResize(pSa, iSize, FALSE)

// Reallocates memory to smaller size, AND unlocks memory
#define SATruncate(pSa, iSize) SAResize(pSa, iSize, TRUE)

// Reallocates array, and returns pointer
// If bUnlock is TRUE, resizes, and returns NULL (buffer not accesible)
pVOID DBIFN SAResize(SAFEARRAY *pSa, UINT32 iSize, BOOL bUnlock);

// String conversions
pUCS2Char WideLowerCase( pUCS2Char pWSrc );
pUCS2Char WideUpperCase( pUCS2Char pWSrc );

// Wide String Duplicate
pUCS2Char WideStrNDup( pUCS2Char pVal, int iSize );

#if defined(_Windows)
#define WideStrLen( pVal ) wcslen( pVal )
#endif
#ifdef _UNIX
int WideStrLen( pCUCS2Char pVal );
#endif

#ifdef _UNIX
wchar_t *UCS2ToWChar( pUCS2Char pWS, int ucs2len );
pUCS2Char WCharToUCS2( wchar_t *pWS, int wcharlen );
#endif

// Wide String Comp
int WideStrComp( pCUCS2Char pVal1, pCUCS2Char pVal2 );
int WideStrLComp( pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2 );
int WideStrIComp( pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2 );
int WideStrLIComp( pCUCS2Char pVal1, int iSize1, pCUCS2Char pVal2, int iSize2 );
int WideStrToInt(const pUCS2Char wp);

#ifdef _UNIX
// Ansi-like functions
pCHAR AnsiStrNDup( pCCHAR pszStr, int iSize );
int AnsiStrLen( pCCHAR pszStr );
int AnsiStrComp( pCHAR pszStr1, pCHAR pszStr2 );
#endif

//TODO: Remove ALIGNWORKAROUND and PtrToDFloat once clang does a better job of
//      handling alignment issues on arm
#if defined(__arm__) || defined(__arm64__)
#define ALIGNWORKAROUND
#endif

DFLOAT PtrToDFloat(pVOID Value);
#if defined(MIDAS_OBJ)
double bsdstrtod(const char *string, char **endPtr);
#endif

#ifdef __cplusplus
   }
#endif // __cplusplus

#endif
