/*-----------------------------------------------------------------------*
 * filename - newarray.cpp
 * C++ new[]
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1990, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */


#include <new>

void * _RTLENTRY _EXPFUNC operator new[]( size_t size )
{
    return ::operator new(size);
}
