/*-----------------------------------------------------------------------*
 * filename - hrdir_s.c
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 34730 $        */

#include <_heap.h>
#include <_hrdir.h>

/* Disable stack frames for all the functions in this file since none of
   them have local vars, and we want to ge as efficient as possible.  If
   we have debug info enabled, though, we'll leave the stack frames on */

#if !defined(__DEBUG__) && !defined(MINIRTL_EDG)
#pragma option -k-
#endif

/* The functions:

     _free_init
     _malloc_init
     _allocmem_init
     _realloc_init

   are simple initializers.  They are the default routines that the heap
   redirector points to, and will be used only for the first call.  During
   that first call, the __CRTL_MEM_Revector() function is called to do several things.
   It calls __CRTL_MEM_CheckBorMem() to see if the Borlndmm.dll is loaded,
   and if so, the heap redirector is pointed to the functions in the DLL.
   If Borlndmm.dll is not loaded, the pointers in the _heap_redirector
   structure will be reset to point directly to the internal memory
   routines.  Then the allocated flag is set to 1, so that anyone else who
   intends to point the redirector vectors elsewhere knows that it may be
   unsafe to do so, since memory has already been allocated via the current
   redirectors. */

void _RTLENTRY __CRTL_MEM_Revector(int allocated)
{
    if (!__CRTL_MEM_CheckBorMem())
    {
        /* Point the heap redirectors to our internal versions
           if CheckBorMem didn't re-vector them to BorMem */

        _heap_redirector.free      = _internal_free;
        _heap_redirector.malloc    = _internal_malloc;
        _heap_redirector.allocmem  = _internal_allocmem;
        _heap_redirector.realloc   = _internal_realloc;
        _heap_redirector.terminate = _internal_free_heaps;

#ifdef MAGIC
        _heap_redirector.flags     = _hrf_vcl_system;
#else
        _heap_redirector.flags     = _hrf_internal;
#endif

    }
    _heap_redirector.allocated = allocated;
}

_STATIC void _RTLENTRY _free_init(void *p)
{
    __CRTL_MEM_Revector(1);
    _heap_redirector.free(p);
}

_STATIC void * _RTLENTRY _malloc_init(size_t size)
{
    __CRTL_MEM_Revector(1);
    return _heap_redirector.malloc(size);
}

_STATIC void * _RTLENTRY _allocmem_init(size_t size)
{
    __CRTL_MEM_Revector(1);
    return _heap_redirector.allocmem(size);
}

_STATIC void * _RTLENTRY _realloc_init(void *p, size_t s)
{
    __CRTL_MEM_Revector(1);
    return _heap_redirector.realloc(p, s);
}

_STATIC void _RTLENTRY _terminate_default(void)
{
  /* This default finction does nothing */
}

_STATIC int releaseHeap = 0;

_STATIC void set_releaseHeap()
{
#pragma exit set_releaseHeap 0 /* Finalization of the heap redirector routines */

    releaseHeap = 1;
}

void _RTLENTRY _EXPFUNC _free_heaps(void)
{
    if (releaseHeap)
    {
        _heap_redirector.terminate();
    }
}

/* This is the instance of our heap redirector structure.  It is initialized
   with its defaults here.  A public getter function is provded elsewhere. */

_heap_redirector_t _heap_redirector =
{
    sizeof (_heap_redirector_t),   /* size of the structure */
    0,                             /* Has anything been allocated yet? */
    _hrf_virgin,                   /* flags */
    _free_init,                    /* free routine */
    _malloc_init,                  /* alloc routine */
    _realloc_init,                 /* re-alloc routine */
    _terminate_default,            /* this default does nothing */
    _allocmem_init                 /* alloc w/zeros routine */
};
