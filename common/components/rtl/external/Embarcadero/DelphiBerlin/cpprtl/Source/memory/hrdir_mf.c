/*-----------------------------------------------------------------------*
 * filename - hrdir_mf.c
 *
 * function(s)
 *
 *     malloc
 *     free
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24928 $        */

#include <alloc.h>
#include <_hrdir.h>

void * _RTLENTRY _EXPFUNC malloc(size_t size)
{
    return _heap_redirector.malloc(size);
}

void _RTLENTRY _EXPFUNC free(void *block)
{
    _heap_redirector.free(block);
}
