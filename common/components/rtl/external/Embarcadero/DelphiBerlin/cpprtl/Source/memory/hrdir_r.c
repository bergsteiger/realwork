/*-----------------------------------------------------------------------*
 * filename - hrdir_r.c
 *
 * function(s)
 *
 *     realloc
 *
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

void * _RTLENTRY _EXPFUNC realloc(void * block, size_t size)
{
    return _heap_redirector.realloc(block, size);
}
