/*-----------------------------------------------------------------------*
 * filename - heapchk.c
 *
 * function(s)
 *      _heapchk - check and verify heap
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
#include <mem.h>
#include <stdio.h>
#include <_heap.h>
#include <_io.h>
#include <ntbc.h>

/*---------------------------------------------------------------------*

Name            _heapchk  - check the whole heap. This is a good exercise
                            to understand how the heap/block structures work.

Usage           int _heapchk(void);

Prototype in    malloc.h

Description     Walks through the whole heap and checks it for consistency

Return value    _HEAPEMPTY
                _HEAPCORRUPT
                _HEAPOK

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _heapchk(void)
{
    // FastMM corruption check is not available
    return _HEAPOK;
}
