/*-----------------------------------------------------------------------*
 * filename - newplarr.cpp
 * C++ placement new[]
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1994, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <new>

void *operator new[](size_t, void *ptr)
{
    return ptr;
}
