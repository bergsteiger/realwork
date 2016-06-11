/*------------------------------------------------------------------------
 * filename - atexit.c
 *
 * function(s)
 *        atexit - registers termination function
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 35783 $        */

#include <stdlib.h>
#include <stdio.h>
#include <_stdio.h>
#include <_process.h>

/*-------------------------------------------------------------------------*

Name            atexit - registers termination function

Usage           #include <stdlib.h>
                int atexit(atexit_t func);

Prototype in    stdlib.h

Description     atexit registers provided to by func as an "exit function".
                Upon normal  termination of the  program, exit calls  *func
                (without  args)  just  before  returning  to  the operating
                system.

                Each call to atexit registers  another exit function; up to
                512  functions can  be registered  and they  are executed on
                last in, first out basis.

Return value    atexit returns 0 on success and non-zero on failure(no space
                left to register the function)

*---------------------------------------------------------------------------*/
int _RTLENTRY _EXPFUNC atexit(atexit_t func)
{
    return __atexit(func, _hInstance);
}
