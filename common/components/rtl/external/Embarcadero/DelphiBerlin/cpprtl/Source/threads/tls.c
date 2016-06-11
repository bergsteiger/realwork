/*-----------------------------------------------------------------------*
 * filename - tls.c
 *
 * function(s)
 *      _init_tls     - startup initialization for thread local storage
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1992, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34089 $        */

#include <ntbc.h>

#include <_defs.h>

/*----------------------------------------------------------------------
 * _stkindex is used by the alloca() and stkavail() functions.  It contains
 * the base value of the stack.
 *
 * _tlsindex is used by the thread routines to hold the address of an
 * allocated THREAD_DATA block.
 *
 * Both of these used to hold indices returned by TlsAlloc, which were then
 * used with TlsGetValue / TlsSetValue to read / write to the actual
 * allocated memory.  We have now removed the need for TlsAlloc,
 * TlsGetValue, and TlsSetValue and simply changed the index variables to be
 * "__thread" types holding the actual data.  Thus the compiler accesses the
 * TLS info for us and we use fewer of the availible process-wide TLS slots
 * (of which there are a maximum of 64).
 *
 */

#if defined(__clang__)
__declspec(thread) void * _stkindex; /* each thread's stack base */
__declspec(thread) void * _tlsindex; /* each thread's THREAD_DATA block */
#else
void * __declspec(thread) _stkindex; /* each thread's stack base */
void * __declspec(thread) _tlsindex; /* each thread's THREAD_DATA block */
#endif

/*----------------------------------------------------------------------
 *
 * The following two functions are simple wrappers around the compiler's
 * access to the two __thread data items.  This is for easy access from
 * assembly modules.
 *
 */

void * __GetTlsIndex (void)
{
  return _tlsindex;
}

void * __GetStkIndex (void)
{
  return _stkindex;
}

/*---------------------------------------------------------------------*

Name            _init_tls - startup initialization for thread local storage

Usage           void _init_tls(void);

Description     This function is called at startup time if alloca()
                or threads are used (see _alloca.asm).  It sets up a
                thread local storage index that can be used to save
                the base of each thread's stack, and fetches the base
                of the main thread's stack.

                It also also sets up a tls index that is used by threads
                to save a pointer to a THRDDATA structure.

Return value    None.

*---------------------------------------------------------------------*/

void _RTLENTRY _init_tls(void)
{
#pragma startup _init_tls 1 /* Initialization of TLS routines */

    MEMORY_BASIC_INFORMATION info;
    OSVERSIONINFO ov;
    unsigned long extra = 0;

    ov.dwOSVersionInfoSize = sizeof (ov);
    GetVersionEx (&ov);

    if (ov.dwPlatformId == 1)
        extra = 0x10000;        /*  If we are running under Win95, the
                                 *  true bottom of the stack is 64k higher
                                 *  than what is reported by the OS.  So we
                                 *  add 64k to this value that the rest of
                                 *  the RTL uses.
                                 */


    /* Store the main thread's stack base in the thread local storage.
     * The _beginthread function will do the same for each new thread.
     * This is so that alloca() and stkavail() can check for stack overflow.
     */
    VirtualQuery((void *)&info, &info, sizeof(info));
    _stkindex = ((unsigned long)info.AllocationBase + extra);
}

