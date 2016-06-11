/*-----------------------------------------------------------------------*
 * filename - realloc.c
 *
 * function(s)
 *      _expand           - grow or shrink a block in place
 *      _internal_realloc - change size of block, copy contents
 *      _msize            - return size of a heap block
 *      big_realloc       - realloc for large block sizes
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34745 $        */

#if !defined(_WIN64)
#include <stdio.h>
#include <mem.h>
#include <_heap.h>
#include <_io.h>
#include <windows.h>
#include <_fastmm.h>

/*---------------------------------------------------------------------*

Name            _expand - grow or shrink a block in place

Usage           void * _expand(void *block, size_t size);

Prototype in    malloc.h

Description     This function attempts to changes the size of an
                allocated block without moving the block.  The contents
                of the block, up to the shorter of the old and new size,
                are not changed.

                For information about the heap data structures,
                see the comments in heap.c.

Return value    If the block can be succesfully resized, the
                address of the block is returned; otherwise NULL
                is returned.

*---------------------------------------------------------------------*/

void * _RTLENTRY _EXPFUNC _expand(void * block, size_t size)
{
    if (block && _FastMM_CanResizeInplace(block, size))
        return block;
    return NULL;
}


/*---------------------------------------------------------------------*

Name            _msize - return size of a heap block

Usage           size_t _msize(void *block);

Prototype in    malloc.h

Description     This function returns the actual size of an allocated
                block, in bytes.

Return value    The size of the allocated block.

*---------------------------------------------------------------------*/

size_t _RTLENTRY _EXPFUNC _msize(void * block)
{
    return (size_t)_FastMM_GetMemBlockSize(block);
}


/*---------------------------------------------------------------------*

Name            _internal_realloc - change size of block, copy contents

Usage           void * _internal_realloc(void *block, size_t size);

Prototype in    malloc.h

Description     This function changes the size of an allocated block
                by allocating a new block of the requested size,
                and then copying the contents of the old block to the
                new.  The number of bytes copied is the smaller
                of the new and old block sizes.  If a new block
                is allocated, the old block is freed; otherwise
                the old block is left unchanged.

Return value    If the new block can be succesfully reallocated, the
                address of the new block is returned; otherwise NULL
                is returned.

*---------------------------------------------------------------------*/

void * _RTLENTRY _internal_realloc(void * block, size_t size)
{
    if (size == 0)
    {
        if (block)
            _FastMM_MemoryManager.FreeMem(block);
        return NULL;
    }

    if (block == NULL)
        return _FastMM_MemoryManager.GetMem((int)size);

    return _FastMM_MemoryManager.ReallocMem(block, (int)size);
}

#else

#include <_heap.h>
/*---------------------------------------------------------------------*

Name            _internal_realloc - change size of block, copy contents

Usage           void * _internal_realloc(void *block, size_t size);

Prototype in    malloc.h

Description     This function changes the size of an allocated block
                by allocating a new block of the requested size,
                and then copying the contents of the old block to the
                new.  The number of bytes copied is the smaller
                of the new and old block sizes.  If a new block
                is allocated, the old block is freed; otherwise
                the old block is left unchanged.

Return value    If the new block can be succesfully reallocated, the
                address of the new block is returned; otherwise NULL
                is returned.

*---------------------------------------------------------------------*/

void * _RTLENTRY _internal_realloc(void * block, size_t size)
{
    if (size == 0)
    {
        if (block)
            __dlfree(block);
        return NULL;
    }

    if (block == NULL)
        return __dlmalloc((int)size);

    return __dlrealloc(block, (int)size);
}
#endif
