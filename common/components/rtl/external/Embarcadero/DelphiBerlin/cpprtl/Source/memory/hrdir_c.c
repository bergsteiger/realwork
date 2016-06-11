/*-----------------------------------------------------------------------*
 * filename - hrdir_c.c
 *
 * function(s)
 *
 *     calloc
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <alloc.h>
#include <_hrdir.h>

void * _RTLENTRY _EXPFUNC calloc(size_t nelem, size_t elsize)
{
    return _heap_redirector.allocmem(nelem * elsize);
}
