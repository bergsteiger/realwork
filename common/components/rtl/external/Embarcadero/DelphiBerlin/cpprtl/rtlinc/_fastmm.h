/*  _fastmm.h

    Definitions for FastMM memory manager

*/

/*
 *      C/C++ Run Time Library - Version 24.0
 *
 *      Copyright (c) 1996, 2016 by Embarcadero Technologies, Inc.
 *      All Rights Reserved.
 *
 */

/* $Revision$ */


/**************************************************************************/
/*                                                                        */
/*  Portions created by Pierre le Riche are                               */
/*  Copyright (c) Pierre le Riche / Professional Software Development     */
/*                                                                        */
/*  Acknowledgement: With special thanks to the Fastcode community and    */
/*   supporters for their valuable input and feedback.                    */
/*                                                                        */
/**************************************************************************/

/* ***** BEGIN LICENSE BLOCK *****
 *
 * This memory manager implementation is licensed under the 
 * Embarcadero Technologies Inc. license terms.
 *
 * The initial developer of the original code is Pierre le Riche.
 *
 * Portions created by the initial developer are Copyright (c) 2008
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Pierre le Riche / Professional Software Development
 *
 * ***** END LICENSE BLOCK ***** */

/* $Revision: $ */


#ifndef __FASTMM_H
#define __FASTMM_H
#define _INC_FASTMM  /* MSC Guard name */

#pragma pack(push, 1)

#ifdef __cplusplus
extern "C" {
#endif

#define __FASTCALL __fastcall

// ------------------------------Memory State types-------------------------

typedef struct
{
    /* The internal size of the block type */
    unsigned int InternalBlockSize;
    /* Useable block size: The number of non-reserved bytes inside the block. */
    unsigned int UseableBlockSize;
    /* The number of allocated blocks */
    unsigned int AllocatedBlockCount;
    /* The total address space reserved for this block type (both allocated and
       free blocks) */
    unsigned int ReservedAddressSpace;
} TSmallBlockTypeState;

typedef TSmallBlockTypeState TSmallBlockTypeStates[55/*NumSmallBlockTypes*/];

/* The structure returned by GetMemoryManagerState */
typedef struct
{
    /* Small block type states */
    TSmallBlockTypeStates SmallBlockTypeStates;
    /* Medium block stats */
    unsigned int AllocatedMediumBlockCount;
    unsigned int TotalAllocatedMediumBlockSize;
    unsigned int ReservedMediumBlockAddressSpace;
    /* Large block stats */
    unsigned int AllocatedLargeBlockCount;
    unsigned int TotalAllocatedLargeBlockSize;
    unsigned int ReservedLargeBlockAddressSpace;
} TMemoryManagerState;

typedef struct {
    unsigned int TotalAddrSpace;
    unsigned int TotalUncommitted;
    unsigned int TotalCommitted;
    unsigned int TotalAllocated;
    unsigned int TotalFree;
    unsigned int FreeSmall;
    unsigned int FreeBig;
    unsigned int Unused;
    unsigned int Overhead;
    unsigned int HeapErrorCode;
} THeapStatus; /* deprecated */

/* Memory map */
#pragma option push -b-
typedef enum
{
    csUnallocated = 0,
    csAllocated = 1,
    csReserved = 2,
    csSysAllocated = 3,
    csSysReserved = 4
} TChunkStatus;
#pragma option pop

typedef TChunkStatus TMemoryMap[65536];

/* Block alignment options */
#pragma option push -b-
typedef enum
{
    mba8Byte = 0,
    mba16Byte = 1
} TMinimumBlockAlignment;
#pragma option pop


typedef struct
{
    /* The basic (required) memory manager functionality */
    void*   (__FASTCALL *GetMem    )                    (int Size);
    int     (__FASTCALL *FreeMem   )                    (void *P);
    void*   (__FASTCALL *ReallocMem)                    (void *P, int Size);

    /* Extended (optional) functionality. */
    void*   (__FASTCALL *AllocMem  )                    (int Size);

    /* Registers expected memory leaks. Returns true on success. The list of leaked
       blocks is limited in size, so failure is possible if the list is full. */
    int     (__FASTCALL *RegisterExpectedMemoryLeak)    (void *P);

    /* Removes expected memory leaks. Returns true if the previously registered leak
       was found and removed. */
    int     (__FASTCALL *UnregisterExpectedMemoryLeak)  (void *P);
} TMemoryManagerEx;

#pragma pack(pop)

// -------------------------------Public functions-------------------------

extern int         __FASTCALL   _FastMM_GetMemBlockSize     (void *P);
extern int         __FASTCALL   _FastMM_CanResizeInplace    (void *P, int Size);


/* Returns information about the current state of the memory manager */
extern void         __FASTCALL  _FastMM_GetMemoryManagerState   (TMemoryManagerState* AMemoryManagerState);
/* Gets the state of every 64K block in the 4GB address space */
extern void         __FASTCALL  _FastMM_GetMemoryMap            (TMemoryMap AMemoryMap);
extern THeapStatus  __FASTCALL  _FastMM_GetHeapStatus           (void);


/* Set the minimum block alignment. In the current implementation blocks >=160
   bytes will always be at least 16 byte aligned, even if only 8-byte alignment
   (the default) is required. */
extern TMinimumBlockAlignment  __FASTCALL   _FastMM_GetMinimumBlockAlignment    (void);
extern void                    __FASTCALL   _FastMM_SetMinimumBlockAlignment    (TMinimumBlockAlignment AMinimumBlockAlignment);

/* Searches the current process for a shared memory manager. If no memory has
   been allocated using this memory manager it will switch to using the shared
   memory manager instead. Returns true if another memory manager was found and
   this module is now sharing it. */
extern int     __FASTCALL   _FastMM_AttemptToUseSharedMemoryManager (void);


/* Makes this memory manager available for sharing to other modules in the
   current process. Only one memory manager may be shared per process, so this
   function may fail. */
extern int     __FASTCALL   _FastMM_ShareMemoryManager              (void);

//extern void     __FASTCALL  _FastMM_InitializeMemoryManager         (void);
extern void     __FASTCALL  _FastMM_FinalizeMemoryManager           (void);

// ---------------------------Public variables-----------------------------

extern TMemoryManagerEx _FastMM_MemoryManager;

extern char _FastMM_IsMultiThread;

/* Set this variable to true to report memory leaks on shutdown. This setting
   has no effect if this module is sharing a memory manager owned by another
   module. */
extern char _FastMM_ReportMemoryLeaksOnShutdown;

/* Set this variable to true to employ a "busy waiting" loop instead of putting
   the thread to sleep if a thread contention occurs inside the memory manager.
   This may improve performance on multi-CPU systems with a relatively low thread
   count, but will hurt performance otherwise. */
extern char _FastMM_NeverSleepOnMMThreadContention;

#ifdef __cplusplus
}
#endif


#endif __FASTMM_H
