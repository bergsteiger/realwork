/*-----------------------------------------------------------------------*
 * filename - heapchkf.c
 *
 * function(s)
 *      heapcheckfree - check free blocks for constant value
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24898 $        */

#include <stdio.h>
#include <mem.h>
#include <alloc.h>
#include <_heap.h>

int _RTLENTRY _EXPFUNC heapcheckfree(unsigned int value)
{
    return _HEAPOK;
}

