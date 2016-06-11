/*-----------------------------------------------------------------------*
 * filename - heapset.c
 *
 * function(s)
 *      _heapset - fill free blocks with constant
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

#pragma argsused
int _RTLENTRY _EXPFUNC _heapset (unsigned int __fill)
{
    return _HEAPOK;
}
