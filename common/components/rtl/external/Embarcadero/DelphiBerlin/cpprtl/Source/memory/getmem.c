/*-----------------------------------------------------------------------*
 * filename - getmem.c
 *
 * function(s)
 *      _getmem         - allocate new memory for the heap
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 25588 $        */

#include <_malloc.h>
#include <malloc.h>

/*---------------------------------------------------------------------*

Name            _getmem - allocate new memory for the heap

Usage           int _getmem(size_t size);

Prototype in    _malloc.h

Description     This function allocates a new memory block from OS/2,
                then adds it to the heap.  The allocation is performed
                by committing pages that have been previously allocated
                from the virtual address space but not committed.
                The block size is rounded up to the next multiple of
                64K.  Virtual address space is allocated in multiples
                of 4 Meg, and committed in multiples of 64K.

Return value    If the memory can be succesfully allocated and added
                to the heap, 0 is returned; otherwise -1.

*---------------------------------------------------------------------*/

/* No longer used */
int _getmem(size_t size)
{
    return 0;
}
