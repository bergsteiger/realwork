/*------------------------------------------------------------------------
 * filename - debug_wrapper.cpp
 *
 * function(s)
 *        __dbk_fcall_wrapper - Debugging helper for internal use
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2015, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$        */

#include <_defs.h>

#if defined(_WIN32)
/* Do not export until able to supress external linkage */
#define EXPORT
#else
#define EXPORT
#endif

extern "C" {
    
void __cdecl __dbkFCallArgs(void *a01, void *a02, void *a03,
                            void *a04, void *a05, void *a06,
                            void *a07, void *a08, void *a09,
                            void *a10, void *a11, void *a12,
                            void *a13, void *a14, void *a15,
                            void *a16, void *a17, void *a18,
                            void *a19, void *a20, void *a21,
                            void *a22, void *a23, void *a24,
                            void *a25, void *a26, void *a27,
                            void *a28, void *a29, void *a30)
{
#if defined(__arm__)
    // Reserve 500 bytes of code (2x2x25x5)
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");

    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");

    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");

    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");

    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");
    asm volatile("mov r0, r0"); asm volatile("mov r0, r0");

#else    
    // Reserve 500 bytes of code (5x10x10)
    asm { 
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;

        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
        mov eax, -1;
    }
#endif
}

void _RTLENTRY EXPORT _internal_dbk_fcall_wrapper() 
{
    void *p = 0;
    try 
    {
        __dbkFCallArgs(p, p, p, p, p , p, p, p, p, p,
                       p, p, p, p, p , p, p, p, p, p,
                       p, p, p, p, p , p, p, p, p, p);
    } 
    __except(1)
    {
        __dbkFCallArgs(p, p, p, p, p , p, p, p, p, p,
                       p, p, p, p, p , p, p, p, p, p,
                       p, p, p, p, p , p, p, p, p, p);
    }

}

void _RTLENTRY EXPORT _dbk_fcall_wrapper()
{
    return _internal_dbk_fcall_wrapper();
}

void * _RTLENTRY EXPORT _dbk_fcall_wrapper_addr;

_STATIC void _dbk_fcall_wrapper_init()
{
    _dbk_fcall_wrapper_addr = (void *) _dbk_fcall_wrapper;
}
#pragma startup _dbk_fcall_wrapper_init 254

} // extern "C"

