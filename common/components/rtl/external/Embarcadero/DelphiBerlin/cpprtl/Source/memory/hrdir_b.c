/*-----------------------------------------------------------------------*
 * filename - hrdir_b.c
 *
 * function(s)
 *
 *   __CRTL_MEM_CheckBorMem
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1998, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 24928 $        */

#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <_defs.h>
#include "_io.h"
#include <_hrdir.h>
#include "_heap.h"

#define BORLNDMM                 "borlndmm"
#define BORLNDMM_SYSGETMEM       "@Borlndmm@SysGetMem$qqri"
#define BORLNDMM_SYSALLOCMEM     "@Borlndmm@SysAllocMem$qqri"
#define BORLNDMM_SYSFREEMEM      "@Borlndmm@SysFreeMem$qqrpv"
#define BORLNDMM_SYSREALLOCMEM   "@Borlndmm@SysReallocMem$qqrpvi"
#define BORLNDMM_HEAPADDREF      "@Borlndmm@HeapAddRef$qqrv"
#define BORLNDMM_HEAPRELEASE     "@Borlndmm@HeapRelease$qqrv"

/* We don't use the next three for anything at all, we just pass them around */
#define BORLNDMM_SYSREGISTEREXPECTEDMEMORYLEAK       "@Borlndmm@SysRegisterExpectedMemoryLeak$qqrpi"
#define BORLNDMM_SYSUNREGISTEREXPECTEDMEMORYLEAK     "@Borlndmm@SysUnregisterExpectedMemoryLeak$qqrpi"

static HANDLE mmdll;

_hr_pfn_bormm_malloc   _bormm_pfn_GetMem;
_hr_pfn_bormm_free     _bormm_pfn_FreeMem;
_hr_pfn_bormm_realloc  _bormm_pfn_ReallocMem;
_hr_pfn_bormm_malloc   _bormm_pfn_AllocMem;
_hr_pfn_bormm_addref   _bormm_pfn_HeapAddRef;
_hr_pfn_bormm_release  _bormm_pfn_HeapRelease;

//Keeps the address of GetMem for the default AllocMem handler.
_hr_pfn_bormm_malloc   _borlndmm_GetMem;

int __fastcall DefaultRegisterAndUnregisterExpectedMemoryLeak (void *aleakptr)
{
  //leak registration and unregistration is not implemented - return false
  return 0;
}

// Used if AllocMem isn't directly supported
void * __fastcall DefaultAllocMem (size_t ablocksize)
{
  void * memblock = _borlndmm_GetMem(ablocksize);

  if (memblock != 0)
    memset(memblock, 0, ablocksize);

  return memblock;
}

#if defined(MAGIC) && !defined(_BUILDRTLDLL)
void __CRTL_VCL_HookSystem (void *gMem, void *fMem, void *rMem, void *aMem, void *regMem, void *unregMem);
#endif

static void _RTLENTRY BorMemForce (void)
{
    HANDLE h;

    h = LoadLibrary(BORLNDMM);  /* Force the DLL to be initialized */
    if (h != mmdll)
      _ErrorExit (__FILE__ ": LoadLibrary != mmdll " BORLNDMM " failed");

}

int _RTLENTRY _EXPFUNC __CRTL_MEM_GetBorMemPtrs (void **gMem, void **fMem, void **rMem,
                                                 void **aMem, void **regMem, void **unregMem)
{
    HANDLE mm;

    if (!(gMem && fMem && rMem))
        return 0;

    mm = GetModuleHandle(BORLNDMM);

    if (!mm)
        return 0;

    *gMem = (void *) GetProcAddress(mm, BORLNDMM_SYSGETMEM);
    *fMem = (void *) GetProcAddress(mm, BORLNDMM_SYSFREEMEM);
    *rMem = (void *) GetProcAddress(mm, BORLNDMM_SYSREALLOCMEM);
    *aMem = (void *) GetProcAddress(mm, BORLNDMM_SYSALLOCMEM);
    *regMem = (void *)GetProcAddress(mm, BORLNDMM_SYSREGISTEREXPECTEDMEMORYLEAK);
    *unregMem = (void *)GetProcAddress(mm, BORLNDMM_SYSUNREGISTEREXPECTEDMEMORYLEAK);

    //Save the GetMem function address for the Default AllocMem handler
    _borlndmm_GetMem = *gMem;

    //Use defaults for unimplemented functionality
    if (*aMem == 0)
      *aMem = &DefaultAllocMem;
    if (*regMem == 0)
      *regMem = &DefaultRegisterAndUnregisterExpectedMemoryLeak;
    if (*unregMem == 0)
      *unregMem = &DefaultRegisterAndUnregisterExpectedMemoryLeak;

    if (!(*gMem && *fMem && *rMem && *aMem && *regMem && *unregMem))
        return 0;

    return 1;
}

int _RTLENTRY __CRTL_MEM_CheckBorMem (void)
{
    void *regMem, *unregMem;

#if !defined(MAGIC) && !defined(_BUILDRTLDLL)
    /* (!MAGIC && ! _BUILDRTLDLL) leaves only CW32.LIB and CW32MT.LIB.
       In this case, don't attempt revector the memory manager to BORLNDMM
       even if it's in memory.  This is because if the user chose to link
       with the static versions of the RTL, he probably doesn't want calls
       to malloc flying off into BORLNDMM.
    */
    return 0;
#else

    mmdll = GetModuleHandle(BORLNDMM);

    if (!mmdll)
        return 0;  /* Borlndmm.dll is not loaded, so don't hook */

    /* At this point we know that the Borlndmm.dll is loaded, but we don't
       know whether or not it has been initialized yet.  Since this code
       could be executing from the RTLDLL's process init, and the RTLDLL was
       probably loaded first, we need to ensure that the Borlndmm.dll gets
       initialized before we return from this function.  This is because the
       Borlndmm.dll allocation routines will soon be called.

       To force the initialization of Borlndmm.dll, we call LoadLibrary on
       it.  */

    BorMemForce();

    __CRTL_MEM_GetBorMemPtrs(
                             (void*)&_bormm_pfn_GetMem,
                             (void*)&_bormm_pfn_FreeMem,
                             (void*)&_bormm_pfn_ReallocMem,
                             (void*)&_bormm_pfn_AllocMem,
                             &regMem, &unregMem
                            );

    _bormm_pfn_HeapAddRef = (void *)  GetProcAddress(mmdll, BORLNDMM_HEAPADDREF);
    _bormm_pfn_HeapRelease = (void *) GetProcAddress(mmdll, BORLNDMM_HEAPRELEASE);

    /* This is needed to ensure that only the new version of the dll gets
       used */

    if (!(_bormm_pfn_HeapAddRef && _bormm_pfn_HeapRelease))
    {
        /* If these functions don't exist, then this is the wrong
           version of borlndmm.dll, so don't use it. Instead, point the
           heap redirectors to our internal versions */

        _heap_redirector.free      = _internal_free;
        _heap_redirector.malloc    = _internal_malloc;
        _heap_redirector.allocmem  = _internal_allocmem;
        _heap_redirector.realloc   = _internal_realloc;
        _heap_redirector.terminate = _internal_free_heaps;
        _heap_redirector.flags     = _hrf_old_borlndmm;

        return 1;

    }

    if (!(_bormm_pfn_GetMem && _bormm_pfn_FreeMem && _bormm_pfn_ReallocMem))
        _ErrorExit (__FILE__ ": GetMem or FreeMem or ReallocMem from " BORLNDMM " failed");

#if 1
    if (_heap_redirector.allocated || (_heap_redirector.flags != _hrf_virgin))
        _ErrorExit (__FILE__ ": FATAL!!! memory has been allocated prior to heap redirector hook!");
#endif

    /* Now point the redirector vectors to the addresses of some stub
       functions (in hrdir_bh.c) that will then call via the _bormm_pfn_xxxx
       pointers into the Borlndmm memory routines. */

    _heap_redirector.free      = (_hr_pfn_free)      _bormm_stub_FreeMem;
    _heap_redirector.malloc    = (_hr_pfn_malloc)    _bormm_stub_GetMem;
    _heap_redirector.allocmem  = (_hr_pfn_malloc)    _bormm_stub_AllocMem;
    _heap_redirector.realloc   = (_hr_pfn_realloc)   _bormm_stub_ReallocMem;
    _heap_redirector.terminate = (_hr_pfn_terminate) _bormm_stub_Terminate;
    _heap_redirector.flags     = _hrf_borlndmm;    /* specify that the Borlndmm.dll manager is
                                                    in use */

#if defined(MAGIC) && !defined(_BUILDRTLDLL)
    /* By getting here we know that the user linked with CP32MT.LIB and also
       forced BORLNDMM.DLL to be loaded.  So we must force the copy of
       System that is linked in, to redirect it's memory requests into
       Borlndmm.dll */

    __CRTL_VCL_HookSystem (
                           _bormm_pfn_GetMem,
                           _bormm_pfn_FreeMem,
                           _bormm_pfn_ReallocMem,
                           _bormm_pfn_AllocMem,
                           regMem, unregMem
                          ) ; /* this lives in SOURCE\VCL\syshook.cpp */
#endif

    /* Inform bormm's ref counting system that we are a client */

    _bormm_pfn_HeapAddRef ();

    return 1;
#endif /* !defined(MAGIC) && !defined(_BUILDRTLDLL) */
}
