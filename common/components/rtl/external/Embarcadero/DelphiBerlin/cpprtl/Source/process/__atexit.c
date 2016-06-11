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

/* $Revision: 35332 $        */

#include <assert.h>
#include <stdlib.h>
#include <stdio.h>
#include <_stdio.h>
#include <_process.h>

/* This is the only place where MAX_ATEXIT lives now. */
#define MAX_ATEXIT      2048

typedef struct {
    void *handle;
    atexit_t func;
} internal_atexit_t;

static internal_atexit_t _atexittbl[MAX_ATEXIT]; /* array of atexit function pointers */
static int  _atexitcnt;                          /* count of atexit functions */

static void coalesce_atexit(int count)
{
    int i, j;

    // find initial empty slot
    i = 0;
    while (i < _atexitcnt && _atexittbl[i].handle)
        i++;
    // No empty slots so done
    if (i == _atexitcnt)
        return;
    j = i + 1;

    while (1)
    {
        // First non-empty slot
        while (j < _atexitcnt && _atexittbl[j].handle == 0)
            j++;
        // No more entries in table so done
        if (j == _atexitcnt)
        {
            // recursive calls to exit can fire assert
            // assert(_atexitcnt - count == i);
            _atexitcnt = i;
            return;
        }
        else
        {
            _atexittbl[i].handle = _atexittbl[j].handle;
            _atexittbl[i].func = _atexittbl[j].func;
            _atexittbl[j].handle = 0;
            _atexittbl[j].func = 0;
            i++;
        }
    }
}

/*-------------------------------------------------------------------------*

Name            __atexit - registers termination function

Usage           #include <stdlib.h>
                int __atexit(atexit_t func, void *handle);

Prototype in    stdlib.h

Description     atexit registers provided to by func as an "exit function".
                Upon normal  termination of the  program, exit calls  *func
                (without  args)  just  before  returning  to  the operating
                system.

                Each call to atexit registers  another exit function; up to
                32  functions can  be registered  and they  are executed on
                last in, first out basis.

Return value    atexit returns 0 on success and non-zero on failure(no space
                left to register the function)

*---------------------------------------------------------------------------*/
int _RTLENTRY _EXPFUNC __atexit(atexit_t func, void *handle)
{
    _lock_exit();
    if (_atexitcnt == MAX_ATEXIT)
    {
        _unlock_exit();
        return(1);
    }
    _atexittbl[_atexitcnt].func = func;
    _atexittbl[_atexitcnt].handle = handle;
    _atexitcnt++;
    _unlock_exit();
    return(0);
}

void _RTLENTRY _EXPFUNC __call_atexit_procs(void *handle)
{
    int i;
    void *hndl;
    int count = 0;
    
    _lock_exit();
    /* Execute "atexit" functions
     */
    i = _atexitcnt - 1;
    while (i >= 0)
    {
        hndl = _atexittbl[i].handle;
        if (hndl && ((hndl == handle) || (handle == (void *)-1)))
        {
            count++;
            _atexittbl[i].handle = 0;
            _atexittbl[i].func();
        }
        i--;
    }
    coalesce_atexit(count);
    _unlock_exit();
}
