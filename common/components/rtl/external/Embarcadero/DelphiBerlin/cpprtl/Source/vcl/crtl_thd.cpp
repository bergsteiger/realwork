/*-----------------------------------------------------------------------*
 * filename - crtl_thd.cpp
 *
 * function(s)
 *
 *   __CRTL_VCL_Thread_Hook
 *   __CRTL_VCL_Thread_Unhook
 *
 *-----------------------------------------------------------------------*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 2005, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision: 23293 $        */

#include <windows.h>
#include <process.h>
#include <stdlib.h>

#ifndef UNIT_TEST
#include "delphimm.h"
#endif

///////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////
// Pascal Thread Functions                                               //
///////////////////////////////////////////////////////////////////////////

/* Note: TThreadFunc and ThreadRec must match the same named definitions in
   the Pascal RTL's System.pas
*/
typedef int (__fastcall * TThreadFunc) (void *);

#pragma option push -a8
struct ThreadRec
{
    ThreadRec(TThreadFunc f, void *p) :
        Func(f),
        Parameter(p),
        Ret(0)
    {
    }

    /* These two members match those in Pascal's System.pas */

    TThreadFunc Func;
    void *      Parameter;

    /* Extra member (defined only in C++) used to hold the return value of the
       thread function.
    */
    int         Ret;
};
#pragma option pop

///////////////////////////////////////////////////////////////////////////

static void _USERENTRY AdoptionWrapper(void *param)
{
    ThreadRec *inner = reinterpret_cast<ThreadRec *>(param);

    if (inner)
    {
        /* Run the specified function */

        if (inner->Func)
            inner->Ret = inner->Func(inner->Parameter);
    }
}

///////////////////////////////////////////////////////////////////////////

static int __fastcall CppThreadWrapper(void *param)
{
    ThreadRec *inner = reinterpret_cast<ThreadRec *>(param);
    int ret = -1;

    if (inner)
    {
        _adopt_thread(AdoptionWrapper, inner, 1);
        ret = inner->Ret;
    }

    /* Delete the inner ThreadRec */

    delete inner;

    return ret;
}

///////////////////////////////////////////////////////////////////////////

static void * __fastcall CppThreadFuncProc(void *func, void *param)
{
    /*  CppThreadFuncProc is called from System.BeginThread in System.pas
        when System::SystemThreadFuncProc is pointed to it (which happens
        in __CRTL_VCL_Thread_Hook, called from __CRTL_VCL_Init).

        This function allocates and returns a ThreadRec that holds the
        function address and parameter that the user wants to execute in
        the new thread.  We need to have _adopt_thread called on the thread,
        so we wrap up two nested ThreadRec's the inner one with the user's
        data, and the outer one with our stub that adopts the thread.

        Although this routine is called for the threads created by TThread
        in VCL, the thread stub in TThread exits the thread early by calling
        EndThread().  So this routine is only useful for direct calls to
        System.BeginThread.  TThread instances will be cleaned up by the
        callout to CppThreadEndProc (see below).
    */

#ifndef UNIT_TEST /* the UNIT_TEST doesn't call this function. */

    ThreadRec *inner = NULL, *outer = NULL;

    try
    {
        /* Outer is freed in Pascal (in System.ThreadWrapper() ) so we'll allocate
           it such that CodeGuard won't complain about allocator/deallocator
           mismatches.
        */
        outer = static_cast<ThreadRec *>(System::GetMemory(sizeof(ThreadRec)));

        if (outer)
        {
            /* Inner is freed by our C++ wrapper function so we'll use standard
               C++
            */
            inner = new ThreadRec(reinterpret_cast<TThreadFunc>(func), param);

            outer->Func = CppThreadWrapper;
            outer->Parameter = inner;
        }
    }
    catch(...)
    {
        delete inner;

        if (outer)
        {
            System::FreeMemory(outer);
            outer = NULL;
        }

    }

    return outer;
#else
    /* Suppress param usage and return warnings */

    _EAX = ((char *)func - (char *)param);
    return NULL;
#endif
}

///////////////////////////////////////////////////////////////////////////

static void __fastcall CppThreadEndProc(int exit_code)
{
    /*  CppThreadEndProc is called from System.EndThread in System.pas
        when System::SystemThreadEndProc is pointed to it (which happens
        in __CRTL_VCL_Thread_Hook).

        This function simply free's any thread local data that has been
        allocated during the life of the thread and then terminates the
        thread to the OS, setting the exit code.  Fortunately there is
        an RTL function that will do this for us.

        All TThread derived classes pass through here when they're finished
        running.
    */

    _endthreadex(exit_code);
}

///////////////////////////////////////////////////////////////////////////
// Module Management Functions                                           //
///////////////////////////////////////////////////////////////////////////

/*
    ModuleNode is the definition of an element in the dynamic array that
    will hold the addresses of any instances of System.pas running in the
    process whose thread creation and destruction functions have been
    hooked. Hopefully there will only be one copy of System.pas in the
    process (preferably the one in the vcl package dlls), but it is possible
    to build non-package C++ Dlls that link with their own static copy of
    VCL (although this is usually problematic, and we don't encourage it).

    These functions are made thread safe by a single critical section
    object. Only the two public entry point functions lock and unlock the
    critical section, all the other functions assume they have full access.

*/

struct ModuleNode
{
    void *func;
    void *end;
    int   usage;

    ModuleNode(void *f = NULL, void *e = NULL) : func(f), end(e), usage(1)
    {
    }

    void UpRef()
    {
        ++usage;
    }

    int DownRef()
    {
        return --usage;
    }

    static int _USERENTRY Compare(void const *raw_a, void const *raw_b)
    {
        ModuleNode const *a = static_cast<ModuleNode const *>(raw_a);
        ModuleNode const *b = static_cast<ModuleNode const *>(raw_b);

        int ret = 0;

        if (a->func < b->func)
        {
            ret = -1;
        }
        else if (a->func > b->func)
        {
            ret = 1;
        }
        else
        {
            /* 'func' is equal, so test 'end' */

            if (a->end < b->end)
            {
                ret = -1;
            }
            else if (a->end > b->end)
            {
                ret = 1;
            }
            else
            {
                /* 'end' is equal */

                ret = 0;
            }
        }

        return ret;
    }
};

///////////////////////////////////////////////////////////////////////////

/* Static data for this module */

static HGLOBAL          NodeHandle;
static ModuleNode *     NodeHead;
static size_t           NodeCount;
static size_t           NodeAlloc;
static const size_t     InitialNodeSize = 8;
static LONG             Initialized;
static CRITICAL_SECTION Crit;

///////////////////////////////////////////////////////////////////////////

static ModuleNode *FindModuleNode(void *func, void *end)
{

    if (!NodeHead)
        return NULL;

    ModuleNode *found, key(func, end);

    /* Look for these values in the array */

    found = static_cast<ModuleNode *>
            (
                bsearch
                (
                    &key,
                    NodeHead,
                    NodeCount,
                    sizeof(ModuleNode),
                    &ModuleNode::Compare
                )
            );

    return found;
}

///////////////////////////////////////////////////////////////////////////

static void FreeNodes()
{
    GlobalFree(NodeHandle);

    NodeHandle = NULL;
    NodeHead = NULL;
    NodeCount = 0;
    NodeAlloc = 0;
}

///////////////////////////////////////////////////////////////////////////

static bool GrowNodes()
{

    if (NodeHead == NULL)
    {
        /* Initially allocate a chunk of nodes */

        NodeHandle = GlobalAlloc
                     (
                         GMEM_MOVEABLE | GMEM_ZEROINIT,
                         sizeof(ModuleNode) * InitialNodeSize
                     );

        if (NodeHandle == NULL)
            return false;

        NodeHead = static_cast<ModuleNode *>(GlobalLock(NodeHandle));

        if (NodeHead == NULL)
            return false;
    }
    else
    {
        /* Reallocate the original chunk */

        GlobalUnlock(NodeHead);

        HGLOBAL new_handle = GlobalReAlloc
                             (
                                 NodeHandle,

                                 /* 1.5x + 1 growth for each realloc */
                                 sizeof(ModuleNode) * (((NodeCount * 15) / 10) + 1),

                                 GMEM_MOVEABLE | GMEM_ZEROINIT
                             );


        if (new_handle == NULL)
        {
            static DWORD err = GetLastError();

            return false;
        }

        NodeHandle = new_handle;

        NodeHead = static_cast<ModuleNode *>(GlobalLock(NodeHandle));

        if (NodeHead == NULL)
            return false;

    }

    /* Calculate the actual number of Nodes we can store in this block
       from the allocated size of the memory.
    */

    NodeAlloc = GlobalSize(NodeHandle) / sizeof(ModuleNode);


    /* Success */

    return true;
}

///////////////////////////////////////////////////////////////////////////

static bool AddModuleNode(void *func, void *end)
{

    /* See if we need more room in the array */

    if (NodeAlloc <= NodeCount)
    {
        if (!GrowNodes())
        {
            return true;
        }
    }


    /* Copy a new node into the array */

    NodeHead[NodeCount++] = ModuleNode(func, end);


    /* Sort the array so we can later find nodes in it quickly */

    qsort(NodeHead,NodeCount,sizeof(ModuleNode),&ModuleNode::Compare);


    /* Success */

    return true;
}


///////////////////////////////////////////////////////////////////////////

static void InitCrit()
{
    if (InterlockedIncrement(&Initialized) == 1)
    {
        /* We're the first ones in, so init the crit */

        InitializeCriticalSection(&Crit);
    }
    else
    {
        /* We've already been initialized, so remove the one we just added */

        InterlockedDecrement(&Initialized);
    }
}

///////////////////////////////////////////////////////////////////////////

extern "C"
{

typedef void (__fastcall * TSystemThreadEnd) (int);

///////////////////////////////////////////////////////////////////////////

void _RTLENTRY _EXPFUNC __CRTL_VCL_Thread_Hook(void *func, void *end)
{

    /* __CRTL_VCL_Thread_Hook() is called from the __CRTL_VCL_Init()
       function that lives in the RTLDLL and from the one that lives in the
       static RTL lib.

       If we've never seen this module's addresses before, we add them to an
       array, and hook their pfn's so that future Pascal based thread
       allocations use them.

       If we already have these addresses in our array, we bump their ref
       count, so that when they go away (via __CRTL_VCL_Thread_Unhook) we
       can defer unhooking them until the last client exits.


       All of this can happen quite early in the startup process, so, we
       must make sure that our critical section is initialized before we try
       to use it.
    */
    InitCrit();

    /* Lock the array */

    EnterCriticalSection(&Crit);


    ModuleNode *node = FindModuleNode(func, end);

    if (node)
    {
        /* This module is already in our list, so we'll bump up its ref
           count.
        */
        node->UpRef();
    }
    else
    {
        /* This is a new module, so add it to the array */

        if (AddModuleNode(func, end))
        {

            /* Now point this module's pfn's to our routines

               We must tell the Pascal RTL to use our function to package up the
               thread function and parameter to send off to its thread wrapper
               function.
            */
            TThreadFunc *pfunc = reinterpret_cast<TThreadFunc *>(func);
            *pfunc = reinterpret_cast<int (__fastcall *)(void *)>(CppThreadFuncProc);

            /* And we also need to tell the Pascal RTL to use our function to end
               any threads that it started.
            */
            TSystemThreadEnd *pend = reinterpret_cast<TSystemThreadEnd *>(end);
            *pend = CppThreadEndProc;
        }

    }

    /* Unlock the array */

    LeaveCriticalSection(&Crit);
}

///////////////////////////////////////////////////////////////////////////

void _RTLENTRY _EXPFUNC __CRTL_VCL_Thread_Unhook(void *func, void *end)
{

    /* __CRTL_VCL_Thread_Unhook() is called from the __CRTL_VCL_Exit()
       function that lives in the RTLDLL and from the one that lives in the
       static RTL lib.

       This is the opposite of __CRTL_VCL_Thread_Hook() described above.

       All of this can happen quite early in the startup process, so, we
       must make sure that our critical section is initialized before we try
       to use it.
    */
    InitCrit();

    /* Lock the array */

    EnterCriticalSection(&Crit);

    ModuleNode *node = FindModuleNode(func, end);

    if (node)
    {
        /* This module is in our list, so will bump down its ref count. */

        if(node->DownRef() == 0)
        {
            /* This was the last client using this module, so unhook it. */

            TThreadFunc *pfunc = reinterpret_cast<TThreadFunc *>(func);
            *pfunc = NULL;

            /* And we also need to tell the Pascal RTL to use our function
               to end any threads that it started.
            */
            TSystemThreadEnd *pend = reinterpret_cast<TSystemThreadEnd *>(end);
            *pend = NULL;

            /* Now we need to shrink the array since this node is not being
               used anymore.  We'll do that by settiing the node's func and
               end to a very high value so that it sorts to the end of the
               array.  Then we can shrink the node count by one.
            */
            node->func = reinterpret_cast<void *>(0xFFFFFFFF);
            node->end = reinterpret_cast<void *>(0xFFFFFFFF);

            /* Sort the array to scoot the unneeded node to the end. */

            qsort(NodeHead,NodeCount,sizeof(ModuleNode),&ModuleNode::Compare);

            /* Now shrink the known node count */

            if (--NodeCount == 0)
            {
                /* Shut down the array if we run out of nodes completely. */

                FreeNodes();
            }

            /* NOTE: Since the process is probably exiting now (although not
               necessarily) we won't realloc the memory block smaller, so
               there will always be a chunk of memory allocated that will be
               big enough to hold the nodes for the maximum number of unique
               modules containing a System.pas.  Again, hopefully this
               number will be 1 as is the case where everything in the
               process uses the dynamic VCL packages (and nothing links with
               static VCL).
            */
        }
    }
    else
    {
        /* Oops, we may have a problem here.  Someone is using this module
           but we didn't find it in our list.  So something is out of whack.

           The only safe thing to do is to unhook the thread funcs and punt.
        */
        TThreadFunc *pfunc = reinterpret_cast<TThreadFunc *>(func);
        *pfunc = NULL;

        TSystemThreadEnd *pend = reinterpret_cast<TSystemThreadEnd *>(end);
        *pend = NULL;
    }


    /* Unlock the array */

    LeaveCriticalSection(&Crit);
}

///////////////////////////////////////////////////////////////////////////

} /* extern "C" */

///////////////////////////////////////////////////////////////////////////

#ifdef UNIT_TEST

#include <stdio.h>

int main (void)
{
    static const max = 1024 * 2;
    ModuleNode array[max];

    printf("Initializing with %d modules...\n", max);

    for(int j=0;j<max;++j)
    {
        array[j].func = reinterpret_cast<void *>(0x10000000);
        array[j].end = reinterpret_cast<void *>(0x20000000);
    }

    printf("Setting pfn's...\n");

    for(int j=0;j<max;++j)
    {
        __CRTL_VCL_Thread_Hook(&array[j].func, &array[j].end);
    }

    printf("Unsetting pfn's...\n\n");

    for(int j=0;j<max;++j)
    {
        int idx;

        /* Pick a random element to unhook so this test is more realistic */

        while(true)
        {
            idx = random(max);

            if (array[idx].func)
                break;
        }

        __CRTL_VCL_Thread_Unhook(&array[idx].func, &array[idx].end);

        float pct = ( j * 1.0 / max ) * 100.0;

        printf("\rPercent done: %4.2f        ", pct);

    }

    printf("\rPercent done: 100.00        \n");

    return 0;
}

#endif /* UNIT_TEST */

///////////////////////////////////////////////////////////////////////////
