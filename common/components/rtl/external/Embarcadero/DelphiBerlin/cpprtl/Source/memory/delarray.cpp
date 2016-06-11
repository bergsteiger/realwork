/*-----------------------------------------------------------------------*
 * filename - delarray.cpp
 * C++ delete[]
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1990, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <stddef.h>

void _RTLENTRY _EXPFUNC operator delete[]( void *ptr )
{
    ::operator delete(ptr);
}

