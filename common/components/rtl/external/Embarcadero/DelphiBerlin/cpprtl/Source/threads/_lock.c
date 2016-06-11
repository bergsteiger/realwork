/*-----------------------------------------------------------------------*
 * filename - _lock.c
 *
 * function(s)
 *      _create_lock    - create a semaphore
 *      _lock_nt        - lock a semaphore
 *      _unlock_nt      - unlock a semahore
 *      _lock_error     - print semaphore error message and exit
 *      _interlocked_increment - Increments the variable as an atomic.
 *      _interlocked_decrement - Decrements the variable as an atomic.
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1991, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34070 $        */

/* The following line is required to define the CRITICAL_SECTION correctly
 * in WINNT.H for SDK3.  It apparently enables debugging fields, which
 * I assume will be removed for the final release of NT.
 * Remove when Microsoft fixes the problem.
 */
#define DEVL  1

#include <ntbc.h>

#include <_io.h>
#include <string.h>
#include <_thread.h>
#include <_nfile.h>

#define MAX_LOCKS (512 + _NFILE_) /* This should be big enough for everyone */

/*----------------------------------------------------------------------
 * crit - array of critical sections
 */
static CRITICAL_SECTION crit[MAX_LOCKS];
static int nlocks;

/*---------------------------------------------------------------------*

Name            _create_lock - create a semaphore

Usage           void _create_lock(lock_t *lockp, char *mesg);

Prototype in    _thread.h

Description     This function creates a semaphore, storing its handle
                at the long word pointed to by lockp.  If an error occurs,
                an error message containing 'mesg' is printed, and
                the program is terminated abnormally.

Return value    None.

*---------------------------------------------------------------------*/

void _create_lock(lock_t *lockp, char *mesg)
{
    EnterCriticalSection(&crit[0]);     /* lock the lock table */
    if (nlocks >= MAX_LOCKS)            /* exceeded maximum no. */
        _lock_error(mesg);
    InitializeCriticalSection(&crit[nlocks]);
    *lockp = (lock_t)&crit[nlocks++];     /* allocate the next free lock */
    LeaveCriticalSection(&crit[0]);
}

/*---------------------------------------------------------------------*

Name            _lock_nt - lock a semaphore

Usage           void _lock_nt(lock_t lock);

Prototype in    _thread.h

Related
functions usage void _unlock(lock_t lock);

Description     This function locks a semaphore.  No error can occur.

Return value    None.

*---------------------------------------------------------------------*/

void _lock_nt(lock_t lock)
{
    EnterCriticalSection((CRITICAL_SECTION *)lock);
}

/*---------------------------------------------------------------------*

Name            _unlock_nt - unlock a semaphore

Usage           void _unlock_nt(lock_t lock, char *mesg);

Prototype in    _thread.h

Related
functions usage void _lock_nt(lock_t lock, char *mesg);

Description     This function unlocks a semaphore.  No error can occur.

Return value    None.

*---------------------------------------------------------------------*/

void _unlock_nt(lock_t lock)
{
    LeaveCriticalSection((CRITICAL_SECTION *)lock);
}

/*---------------------------------------------------------------------*

Name            _lock_error - print semaphore error message and exit

Usage           void _lock_error(char *mesg);

Prototype in    _thread.h

Description     This function prints an error message to standard error,
                then terminates all threads in the current process.
                This function is called when a file handle semaphore
                operation fails.

Return value    None.

*---------------------------------------------------------------------*/

void _lock_error(char *mesg)
{
    char buf[80];

    strcpy(buf,"Semaphore error ");
    strcat(buf,mesg);
    _ErrorExit(buf);
}

/*---------------------------------------------------------------------*

Name            _interlocked_increment - Increments the variable as an atomic.

Usage           long _interlocked_increment(long *var);

Description     This function increases by one the value of the specified 
                32-bit variable as an atomic operation. 

Return value    Returns the resulting incremented value.

*---------------------------------------------------------------------*/
long _interlocked_increment(long *var)
{
    return InterlockedIncrement(var);
}

/*---------------------------------------------------------------------*

Name            _interlocked_decrement - Decrements the variable as an atomic.

Usage           long _interlocked_decrement(long *var);

Description     This function decreases by one the value of the specified 
                32-bit variable as an atomic operation. 

Return value    Returns the resulting decremented value.

*---------------------------------------------------------------------*/
long _interlocked_decrement(long *var)
{
    return InterlockedDecrement(var);
}

/*---------------------------------------------------------------------*

Name            _get_lock_level - get the current level of a specified lock

Usage           int _get_lock_level(lock_t lock);

Description     This function returns the number of levels that the
                specified lock has been locked.  This should only
                be called while the lock is actually locked

Return value    Returns # of nested times it has been locked.  1 means
                when you unlock it any other thread can enter.

*---------------------------------------------------------------------*/

int _get_lock_level(lock_t lock)
{
    return ((CRITICAL_SECTION *)lock)->LockCount + 1;
}

/*---------------------------------------------------------------------*

Name            _init_lock - initialize lock table

Usage           void _init_lock(void);

Description     This function creates the global lock that governs
                access to the lock table.

Return value    None.

*---------------------------------------------------------------------*/


_STATIC void _init_lock(void)
{
#pragma startup _init_lock 0 /* Initialization of the master MT lock for all other locks */

    /* Create the critical section used to govern access to the
     * table of other critical sections.  We use crit[0] for this.
     */
    InitializeCriticalSection(&crit[0]);
    nlocks = 1;
}
