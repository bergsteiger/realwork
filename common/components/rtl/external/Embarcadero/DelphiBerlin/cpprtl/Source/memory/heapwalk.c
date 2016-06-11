/*-----------------------------------------------------------------------*
 * filename - heapwalk.c
 *
 * function(s)
 *      _rtl_heapwalk - walk through the heap node by node
 *      _heapwalk - walk through the heap node by node (obsolete)
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

/*---------------------------------------------------------------------*

Name            heapwalk - iterates through the heap(s)

Usage           void heapwalk(void);

Prototype in    alloc.h

Description     walks through the whole heap and returns each node

Return value    _HEAPOK
                _HEAPEND
                _HEAPBADPTR

*---------------------------------------------------------------------*/

#pragma argsused
int _RTLENTRY _EXPFUNC _rtl_heapwalk(_HEAPINFO * __entry)
{
    return _HEAPEND;
}

int _RTLENTRY _EXPFUNC _heapwalk(_HEAPINFO * __entry)
{
    return _rtl_heapwalk((_HEAPINFO *) __entry);
}
