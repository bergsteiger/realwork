/*------------------------------------------------------------------------
 * filename - _malloc.h
 *
 *   Internal memory management functions and definitions
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 33411 $ */

#if !defined( __DEFS_H )
#include <_defs.h>
#endif

#ifndef NULL
#include <_null.h>
#endif

#ifdef _DEBUG
#include <_heapdbg.h>
#endif

#ifndef BASETYPE_ULONG
typedef unsigned long ULONG;
#endif

#ifndef _STDDEF
#define _STDDEF
#ifndef _PTRDIFF_T
#define _PTRDIFF_T
typedef int ptrdiff_t;
#endif
#ifndef _SIZE_T
#define _SIZE_T
typedef unsigned size_t;
#endif
#endif

typedef char * PBLOCK;      /* pointer to a heap block */

#ifdef __cplusplus
extern "C" {
#endif

void * __cdecl _alloca       (size_t __size);
int            _getmem       (size_t __size);
size_t         _stackavail   (void);

int __fastcall _virt_commit  (void *__base, unsigned long __size);
int __fastcall _virt_alloc   (void **__ptr, unsigned long __size);
int __fastcall _virt_decommit(void *__base, unsigned long __size);
int __fastcall _virt_release (void *__base);
int __fastcall _virt_reserve (unsigned long __size, void **__ptr,
                             unsigned long *__actual);

#if defined(_BUILDRTLDLL) || defined(_WIN64)
#define     __org_malloc(a) malloc(a)
#define     __org_free(a)   free(a)
#else
void *      __org_malloc(size_t  __size);
void        __org_free(void * __block);
#endif

#define     _lock_heap()
#define     _unlock_heap()
#define     _same_seg(p,size) (1)

#ifdef _DEBUG
int         _is_allocated   (PBLOCK p);
int         _is_free        (PBLOCK p);
void        _heap_error     (PBLOCK __ptr, _heaperr_t __type);
void        _unlink_alloc   (PBLOCK p);
#endif

#ifdef __cplusplus
}
#endif

/*----------------------------------------------------------------------
 * Macros for rounding 'n' up or down to the next multiple of 's',
 * which must be a power of 2.
 */
#define ROUND_UP(n,s) (((ULONG)(n)+(s)-1)&~((s)-1))
#define ROUND_DOWN(n,s) ((ULONG)(n)&~((s)-1))

/*----------------------------------------------------------------------
 * Sizes of various boundaries
 */
#define PAGE_SIZE   0x1000      /* size of one page */
#define HEAP_SIZE   0x400000    /* heap virtual address space size */
                                /*  (must be multiple of SEG_SIZE) */
#define SHEAP_SIZE  0x100000    /* small heap size for DOS systems */

