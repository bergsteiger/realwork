/*-----------------------------------------------------------------------*
 * filename - heapchkn.c
 *
 * function(s)
 *      heapchecknode - check and verify a single node on the heap
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24898 $        */

#include <alloc.h>
#include <malloc.h>
#include <_heap.h>
#include <_fastmm.h>

/*---------------------------------------------------------------------*

Name            heapchecknode - check and verify a single node on the heap

Usage           int heapchecknode(void *node);

Prototype in    alloc.h

Related
functions usage int _heapchk (void);
                int _rtl_heapwalk(_HEAPINFO *__entry);

Description     If a node has been freed and heapchecknode is called
                with a pointer to the freed block, heapchecknode can
                return _BADNODE rather than the expected _FREEENTRY.
                This is because adjacent free blocks on the heap are
                merged, and the block in question no longer exists.

Return value    One of the following constants is returned (values
                are defined in alloc.h):

                _HEAPEMPTY      no heap exists
                _HEAPCORRUPT    heap has been corrupted
                _BADNODE        node could not be found
                _FREEENTRY      node is a free block
                _USEDENTRY      node is a used block

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC heapchecknode(void *node)
{
    if (_FastMM_GetMemBlockSize(node) > 0)
        return _USEDENTRY;
    return _BADNODE;
}
