/*----------------------------------------------------------------------
Name           __threadid - return thread ID

Usage          #include <stddef.h>
               unsigned long _RTLENTRY __threadid(void);

Prototype in   stddef.h

Description    This function returns the current thread ID.

Return value   A long word containing the current thread ID.
------------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2013, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision:$ */

#include <stddef.h>

unsigned long _RTLENTRY _EXPFUNC __threadid(void)
{
    return GetCurrentThreadId();
}
