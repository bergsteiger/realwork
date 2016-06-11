/*------------------------------------------------------------------------
 * filename - __exit.c
 *
 * function(s)
 *      __exit  - handle the four flavors of exit
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 32029 $        */

#include <stdlib.h>
#include <stdio.h>
#include <_stdio.h>
#include <_process.h>

extern void _terminate( int );          /* terminate program */
extern void _cleanup( void );           /* call #pragma exit routines */

static  void    dummy(void) {}

void    (*_exitbuf)(void)   = dummy;
void    (*_exitfopen)(void) = dummy;
void    (*_exitopen)(void)  = dummy;

#if defined(__MT__)
void _cleanup_handle_locks(void);
void _cleanup_stream_locks(void);
#endif

/*---------------------------------------------------------------------------*

Name            __exit - perform cleanup and optionally terminate the program

Usage           void __exit(int quick, int dontexit, int errcode);

Prototype in    local

Description     __exit is an internal routine used by the various flavors
                of exit.  If the "quick" flag is false, buffered output
                (waiting to be output) is written to files, any registered
                "exit functions"  (posted with atexit) are called, and
                #pragma exit functions are called.

                In all cases, interrupt vectors taken by the RTL are
                restored, and in small and medium models, stray NULL pointers
                are checked for by seeing if the copyright message
                got zapped.

                Finally, if the "dontexit" flag is false, all files
                are closed, and the program is terminated with the
                error code "errcode".

Return value    If dontexit is false, __exit never returns; otherwise
                it returns no value.

*----------------------------------------------------------------------------*/
void _RTLENTRY _EXPFUNC __exit(int quick, int dontexit, int errcode, void *handle)
{
    _lock_exit();
    if (!quick)
    {
        /* Execute "atexit" functions
         */
         __call_atexit_procs(handle);

        /* First run #pragma exit routines...
         */
        _cleanup();

        /* ... Then Flush files.
         */
        (*_exitbuf)();

    }
    else
    {
        // If we want to support quick with dontexit not calling
        // routines next time exit() is called then a function like
        // __unregister_atexit_procs(handle) should be added.
    }

    if (!dontexit)
    {
        if (!quick)
        {
            (*_exitfopen)();    /* close stream files */
            (*_exitopen)();     /* close handle files */
        }
        _unlock_exit();
        /* Optionally release virtual memory here
	 */
#if defined(__MT__)
        /*
          These functions free the memory for the locks so the CG doesn't
          complain.
        */
#if 0 /* 261420 */
	/* Abusive use during DLL shutdown can cause issues. */
        _cleanup_handle_locks();
        _cleanup_stream_locks();
#endif
#endif
        _terminate(errcode);    /* terminate program */
    }
    _unlock_exit();
}
