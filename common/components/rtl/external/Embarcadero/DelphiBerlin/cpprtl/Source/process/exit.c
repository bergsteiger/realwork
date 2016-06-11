/*------------------------------------------------------------------------
 * filename - exit.c
 *
 * function(s)
 *      exit    - terminate program
 *      _exit   - quick termination
 *      _cexit  - perform exit cleanup without termination
 *      _c_exit - perform quick exit cleanup without termination
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

/*---------------------------------------------------------------------------*

Name            exit - terminates program

Usage           void exit(int status);

Prototype in    process.h and stdlib.h

Related
functions usage void _exit(int status);
                void _cexit(void);
                void _c_exit(void);

Description     exit  terminates the  calling process.  Before exiting, all
                files are closed, buffered output (waiting to be output) is
                written, interrupt vectors taken by the startup code are
                restored, and  any registered "exit functions"  (posted with
                atexit) are called.

                status is provided for the  calling process as the the exit
                status of  the process. Typically a  value of 0 is  used to
                indicate a normal exit, and a non-zero value indicates some
                error.

                _exit is "quick" version of exit.  It does everything
                that exit does, except that it doesn't flush files or
                call atexit or #pragma exit routines.

                _cexit is a non-terminating version of exit().  It does
                everything that exit does, except that it doesn't
                close files or terminate the program.

                _c_exit is a non-terminating version of _exit().  It
                does no cleanup and does not terminate the program.

Return value    exit and _exit never return.  _cexit and _c_exit do
                not return a value.

*----------------------------------------------------------------------------*/
void _RTLENTRY _EXPFUNC exit(int c)
{
    __exit(0,0,c, _hInstance);
}

void _RTLENTRY _EXPFUNC _NO_RETURN_DECL _exit(int c)
{
    __exit(1,0,c, _hInstance);
}

void _RTLENTRY _EXPFUNC _cexit(void)
{
    __exit(0,1,0, _hInstance);
}

void _RTLENTRY _EXPFUNC _c_exit(void)
{
    __exit(1,1,0, _hInstance);
}
