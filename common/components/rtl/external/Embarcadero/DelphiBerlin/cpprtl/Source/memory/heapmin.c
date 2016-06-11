/*-----------------------------------------------------------------------*
 * filename - heapmin.c
 *
 * function(s)
 *      _heapmin - return unused portion of heap to OS
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <malloc.h>

/*---------------------------------------------------------------------*

Name            _heapmin - return unused portion of heap to OS

Usage           int _heapmin(void);

Prototype in    malloc.h

Related
functions usage int _heapchk(void);p
                int _heapset (unsigned int __fill);
                int _heapmin(_HEAPINFO *entry);

Description     _heapmin minimizes heap usage by releasing unused portions
                of the heap to the OS.

Return value    If _heapmin is successful, it returns 0; otherwise it
                returns -1.

*---------------------------------------------------------------------*/

int _RTLENTRY _EXPFUNC _heapmin(void)
{
  return -1;
}