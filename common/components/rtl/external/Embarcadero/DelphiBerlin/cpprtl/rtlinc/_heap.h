/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */


/* $Revision: 33411 $ */

#include <stddef.h>

void * _RTLENTRY _internal_malloc(size_t size);
void   _RTLENTRY _internal_free(void *block);
void * _RTLENTRY _internal_realloc(void * block, size_t size);
void * _RTLENTRY _internal_allocmem(size_t size);
void   _RTLENTRY _internal_free_heaps(void);

#if !defined(_WIN64)
void * _RTLENTRY _EXPFUNC _expand(void * block, size_t size);
size_t _RTLENTRY _EXPFUNC _msize(void * block);
#else
void * __dlmalloc(size_t size);
void   __dlfree(void *block);
void * __dlrealloc(void * block, size_t size);
void*  __dlcalloc(size_t, size_t);
#endif
