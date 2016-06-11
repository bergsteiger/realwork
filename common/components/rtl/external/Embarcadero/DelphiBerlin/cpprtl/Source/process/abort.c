/*-----------------------------------------------------------------------*
 * filename - abort.c
 *
 * function(s)
 *        abort - abnormally terminate program
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1987, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 32029 $        */

#include <signal.h>
#include <process.h>
#include <_io.h>
#include <windows.h>
#include <ntbc.h>

static int  abort_notify = 1;

int _RTLENTRY _abort_notify(int state)
{
    int ret = abort_notify;
    abort_notify = state;
    return ret;
}

void _do_abort(void)
{
    _ErrorMessage("Abnormal program termination");
    _exit(3);
}

void _abort(void)
{
#if !defined(MINIRTL)
    __try 
    {
        if (abort_notify && IsDebuggerPresent())
            RaiseException(STATUS_FATAL_APP_EXIT, 0, 0, 0);
    } 
    __except(GetExceptionCode() == STATUS_FATAL_APP_EXIT)
    {
    }
#endif
    _do_abort();
}

void _RTLENTRY _EXPFUNC abort(void)
{
#if !defined(MINIRTL)
    raise(SIGABRT);
#endif
    _abort();
}
