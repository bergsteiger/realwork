/*-----------------------------------------------------------------------*
 * filename - heap.c
 *
 * function(s)
 *      _heapadd                - add a block to the heap
 *      _internal_free          - free an allocated block
 *      _internal_malloc        - allocate a block from the heap
 *      _internal_allocmem      - allocate a zero filled block from the heap
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34730 $        */

#include <mem.h>
#include <stdio.h>
#include <_heap.h>
#include <_fastmm.h>

/*---------------------------------------------------------------------*

Name            _internal_free - free an allocated block

Usage           void _internal_free(void *block);

Prototype in

Description     Return a block to the heap.  The block must have
                previously allocated with malloc, realloc, or calloc.
                If the block pointer is NULL, no action is performed.

                There is an internal routine called _free which is
                identical, except that it does not call the _free_hook
                routine.  This should be used for internal calls to
                free that do not refer to user-specified blocks.

Return value    None.

*---------------------------------------------------------------------*/


void _RTLENTRY _internal_free(void *block)
{
    if (!block)
        return;

#if defined(_WIN64)
    __dlfree(block);
#else
    _FastMM_MemoryManager.FreeMem(block);
#endif
}

/*---------------------------------------------------------------------*

Name            _heapadd - add a block to the heap

Usage           int _heapadd(void *block, size_t size);

Prototype in    malloc.h

Description     This function adds a new block of memory to the heap.
                The block must not have been previously allocated from
                the heap.

Return value    If the block can be successfully added to the heap,
                0 is returned; otherwise -1.

*---------------------------------------------------------------------*/
#if 0
   int _RTLENTRY _EXPFUNC _heapadd(void *ptr, size_t size)
   {
        return -1;
   }
#endif

/*---------------------------------------------------------------------*

Name            _internal_malloc - allocate a block from the heap

Usage           void * _internal_malloc(size_t size);

Prototype in    local

Description     This function allocates a block from the heap.
                The contents of the block are undefined.

Return value    If the block can be successfully allocated, the
                address of the block is returned; otherwise NULL
                is returned.

*---------------------------------------------------------------------*/

void * _RTLENTRY _internal_malloc(size_t size)
{
    if (!size)
        return NULL;

#if defined(_WIN64)
    return __dlmalloc(size);
#else
    return _FastMM_MemoryManager.GetMem((int)size);
#endif
}

/*---------------------------------------------------------------------*

Name            _internal_allocmem - allocate a zero filled block from the heap

Usage           void * _internal_allocmem(size_t size);

Prototype in    local

Description     This function allocates a block from the heap.
                The contents of the block zero initialized.

Return value    If the block can be successfully allocated, the
                address of the block is returned; otherwise NULL
                is returned.

*---------------------------------------------------------------------*/

void * _RTLENTRY _internal_allocmem(size_t size)
{
    if (!size)
        return NULL;

#if defined(_WIN64)
    return __dlcalloc(1, size);
#else
    return _FastMM_MemoryManager.AllocMem((int)size);
#endif
}

void _RTLENTRY _internal_free_heaps()
{
#if defined(_WIN64)
  // FIXME
#else
    _FastMM_FinalizeMemoryManager();
#endif
}
