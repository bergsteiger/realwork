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
/*  Delphi Memory Manager                                                 */
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
 * This memory manager implementation is licensed under the Embarcadero Technologies Inc. 
 * license terms.
 *
 * The initial developer of the original code is Pierre le Riche.
 *
 * Portions created by the initial developer are Copyright (c) 2008
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Pierre le Riche / Professional Software Development
 *
 * ***** END LICENSE BLOCK ***** */

// -----------------------------Options Block-------------------------------

// *************************************************************************
// *** If you change an option, you must also change it in _fastmma.asm  ***
// *************************************************************************

/* Enable to use the C code path */
#if defined(_WIN64)
#define USE_C_CODE
#else
/* Include the memory leak tracking and reporting code. Without this define set
   the memory leak registration functions will do nothing and the memory leak
   report will not be shown on shutdown. */
//#define INCLUDE_MEMORYLEAK_TRACKING_CODE

/* Use custom fixed size move routines for some small blocks */
#define USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES

/* Use custom variable size move routines for larger blocks */
#define USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
#endif

// -----------------------------Options Block-------------------------------
/* Enable to automatically share the EXE's memory manager. DLLs try to use
   it. */
#define AUTO_SHARE_MEMORYMANAGER

// --------------------------------Windows API------------------------------

#include <windows.h>

// -------------------------------------------------------------------------
#include "_fastmm.h"

/* Helper macros to keep the source code cleaner */
#define DWORD_PTR_OFS(addr, offset) ((LPDWORD)((DWORD_PTR)(addr) + offset))
#define DWORD_PTR_SUBOFS(addr, offset) ((LPDWORD)((DWORD_PTR)(addr) - offset))

// -------------------------------Symbol imports----------------------------
#ifdef AUTO_SHARE_MEMORYMANAGER
/* _hInstance is used to detect if FastMM is used from a DLL or the EXE */
extern void *_hInstance;
#endif


/******************************************************/
#pragma pack(push, 1)
/******************************************************/

// ---------------------------Public variables-----------------------------
#ifdef _MT
char _FastMM_IsMultiThread = 1;
#else
char _FastMM_IsMultiThread = 0;
#endif

/* Set this variable to true to report memory leaks on shutdown. This setting
   has no effect if this module is sharing a memory manager owned by another
   module. */
char _FastMM_ReportMemoryLeaksOnShutdown = 0;

/* Set this variable to true to employ a "busy waiting" loop instead of putting
   the thread to sleep if a thread contention occurs inside the memory manager.
   This may improve performance on multi-CPU systems with a relatively low thread
   count, but will hurt performance otherwise. */
char _FastMM_NeverSleepOnMMThreadContention = 0;

// -------------------------Fixed size move procedures----------------------
#ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
/* Fixed size move operations ignore the size parameter. All moves are assumed to
   be non-overlapping. */
extern void __FASTCALL _FastMM_Move12(void* ASource, void* ADest, int ACount);
extern void __FASTCALL _FastMM_Move20(void* ASource, void* ADest, int ACount);
extern void __FASTCALL _FastMM_Move28(void* ASource, void* ADest, int ACount);
extern void __FASTCALL _FastMM_Move36(void* ASource, void* ADest, int ACount);
extern void __FASTCALL _FastMM_Move44(void* ASource, void* ADest, int ACount);
extern void __FASTCALL _FastMM_Move52(void* ASource, void* ADest, int ACount);
extern void __FASTCALL _FastMM_Move60(void* ASource, void* ADest, int ACount);
extern void __FASTCALL _FastMM_Move68(void* ASource, void* ADest, int ACount);
#endif

// ----------------------Specialised Move Procedures------------------------


#if !defined(_WIN64)
extern void __FASTCALL _internal_memmove(void* ASource, void* ADest, int ACount);
#else
#define _internal_memmove(__src, __dest, __n) memmove(__dest, __src, __n)
#endif

#ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
/* Variable size move procedure: Assumes ACount is 4 less than a multiple of 16.
   Always moves at least 12 bytes, irrespective of ACount. */
extern void __FASTCALL _FastMM_MoveX16L4(void* ASource, void* ADest, int ACount);
/* Variable size move procedure: Assumes ACount is 4 less than a multiple of 8.
   Always moves at least 12 bytes, irrespective of ACount. */
extern void __FASTCALL _FastMM_MoveX8L4(void* ASource, void* ADest, int ACount);
#endif

// ---------------------------Private constants-----------------------------
/* The size of a medium block pool. This is allocated through VirtualAlloc and
   is used to serve medium blocks. The size must be a multiple of 16 and at
   least 4 bytes less than a multiple of 4K (the page size) to prevent a
   possible read access violation when reading past the end of a memory block
   in the optimized move routine (MoveX16L4). */
#define MediumBlockPoolSize  (20 * 64 * 1024 - 16)

/* The granularity of small blocks */
#define SmallBlockGranularity  8

/* The granularity of medium blocks. Newly allocated medium blocks are
   a multiple of this size plus MediumBlockSizeOffset, to avoid cache line
   conflicts */
#define MediumBlockGranularity 256
#define MediumBlockSizeOffset 48

/* The granularity of large blocks */
#define LargeBlockGranularity 65536

/* The maximum size of a small block. Blocks Larger than this are either
   medium or large blocks. */
#define MaximumSmallBlockSize 2608

/* The smallest medium block size. (Medium blocks are rounded up to the nearest
   multiple of MediumBlockGranularity plus MediumBlockSizeOffset) */
#define MinimumMediumBlockSize  (11 * 256 + MediumBlockSizeOffset)

/* The number of bins reserved for medium blocks */
#define MediumBlockBinsPerGroup 32
#define MediumBlockBinGroupCount 32
#define MediumBlockBinCount (MediumBlockBinGroupCount * MediumBlockBinsPerGroup)

/* The maximum size allocatable through medium blocks. Blocks larger than this
   fall through to VirtualAlloc ( = large blocks). */
#define MaximumMediumBlockSize (MinimumMediumBlockSize + (MediumBlockBinCount - 1) * MediumBlockGranularity)

/* The target number of small blocks per pool. The actual number of blocks per
   pool may be much greater for very small sizes and less for larger sizes. The
   cost of allocating the small block pool is amortized across all the small
   blocks in the pool, however the blocks may not all end up being used so they
   may be lying idle. */
#define TargetSmallBlocksPerPool 48

/* The minimum number of small blocks per pool. Any available medium block must
   have space for roughly this many small blocks (or more) to be useable as a
   small block pool. */
#define MinimumSmallBlocksPerPool 12

/* The lower and upper limits for the optimal small block pool size */
#define OptimalSmallBlockPoolSizeLowerLimit (29 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset)
#define OptimalSmallBlockPoolSizeUpperLimit (64 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset)

/* The maximum small block pool size. If a free block is this size or larger
   then it will be split. */
#define MaximumSmallBlockPoolSize (OptimalSmallBlockPoolSizeUpperLimit + MinimumMediumBlockSize)

// ----------------------------Block type flags---------------------------
/* The lower 3 bits in the dword header of small blocks (4 bits in medium and
   large blocks) are used as flags to indicate the state of the block */
/* Set if the block is not in use */
#define IsFreeBlockFlag 1

/* Set if this is a medium block */
#define IsMediumBlockFlag 2

/* Set if it is a medium block being used as a small block pool. Only valid if
   IsMediumBlockFlag is set. */
#define IsSmallBlockPoolInUseFlag 4

/* Set if it is a large block. Only valid if IsMediumBlockFlag is not set. */
#define IsLargeBlockFlag 4

/* Is the medium block preceding this block available? */
#define PreviousMediumBlockIsFreeFlag 8

/* Is this large block segmented? I.e. is it actually built up from more than
   one chunk allocated through VirtualAlloc? (Only used by large blocks.) */
#define LargeBlockIsSegmented 8

/* The flags masks for small blocks */
#define DropSmallFlagsMask -8
#define ExtractSmallFlagsMask 7

/* The flags masks for medium and large blocks */
#define DropMediumAndLargeFlagsMask -16
#define ExtractMediumAndLargeFlagsMask 15

// -------------------------Block resizing constants----------------------
#define SmallBlockDownsizeCheckAdder 64
#define SmallBlockUpsizeAdder 32

/* When a medium block is reallocated to a size smaller than this, then it must
   be reallocated to a small block and the data moved. If not, then it is
   shrunk in place down to MinimumMediumBlockSize. Currently the limit is set
   at a quarter of the minimum medium block size. */
#define MediumInPlaceDownsizeLimit (MinimumMediumBlockSize / 4)

// -----------------------------Other constants---------------------------
/* Sleep time when a resource (small/medium/large block manager) is in use */
#define InitialSleepTime 0

/* Used when the resource is still in use after the first sleep */
#define AdditionalSleepTime 10

/* The number of small block types employed by the default memory manager */
#define NumSmallBlockTypes 55

/* Copyright message - not used anywhere in the code */
#define Copyright "FastMM Borland Edition (c) 2004 - 2008 Pierre le Riche / Professional Software Development";

#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE
// -----------------------Memory leak reporting constants-----------------
#define ExpectedMemoryLeaksListSize (64 * 1024)
// -------------------Memory leak messages (may be localized)-------------
/* Leak checking messages */
#define LeakMessageHeader   "An unexpected memory leak has occurred. "
#define SmallLeakDetail     "The unexpected small block leaks are:\n"
#define LargeLeakDetail     "The sizes of unexpected leaked medium and large blocks are: "
#define BytesMessage        " bytes: "
#define UnknownClassNameMsg "Unknown"
#define LeakMessageFooter   "\n\0"
#define LeakMessageTitle    "Unexpected Memory Leak"
#endif
/* Sharing errors */
#define ShareMMErrorTitle    "Cannot Switch Memory Manager"
#define LivePointersErrorMsg "The memory manager cannot be changed after it has been used."

// ------------------------------Private types------------------------------

/* Move procedure type */
typedef void (__FASTCALL *TMoveProc)(void* ASource, void* ADest, int ACount);

// -----------------------Small block structures--------------------------

/* Pointer to the header of a small block pool */
typedef struct _TSmallBlockPoolHeader *PSmallBlockPoolHeader;

/* Small block type (Size = 32) */
typedef struct _TSmallBlockType
{
    /* True = Block type is locked */
    char BlockTypeLocked;

    /* Bitmap indicating which of the first 8 medium block groups contain blocks
       of a suitable size for a block pool. */
    unsigned char AllowedGroupsForBlockPoolBitmap;

    /* The block size for this block type */
    WORD BlockSize;

    /* The first partially free pool for the given small block type (offset = +4
       for typecast compatibility with TSmallBlockPoolHeader). This is a circular
       buffer. */
    PSmallBlockPoolHeader NextPartiallyFreePool;

    /* The offset of the last block that was served sequentially (0ffset = +8 to
       to be at the same offset as the "FirstFreeBlock" of TSmallBlockPoolHeader */
    void* NextSequentialFeedBlockAddress;

    /* The last block that can be served sequentially. Offset is at +12 to be
       at the same address as the "BlocksInUse" field of TSmallBlockPoolHeader */
    void* MaxSequentialFeedBlockAddress;

    /* The pool that is current being used to serve blocks in sequential order */
    PSmallBlockPoolHeader CurrentSequentialFeedPool;
    /* The previous partially free pool for the small block type (offset = +20
       for typecast compatibility with TSmallBlockPoolHeader) */
    PSmallBlockPoolHeader PreviousPartiallyFreePool;

    /* The minimum and optimal size of a small block pool for this block type */
    WORD MinimumBlockPoolSize;
    WORD OptimalBlockPoolSize;
#ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
    /* The fixed size move procedure used to move data for this block size when
       it is upsized. When a block is downsized (which usually does not occur
       that often) the variable size move routine is used. */
    TMoveProc UpsizeMoveProcedure;
#else
    DWORD Reserved;
#endif
} TSmallBlockType, *PSmallBlockType;

/* Small block pool (Size = 32 bytes) */
typedef struct _TSmallBlockPoolHeader
{
    /* BlockType */
    PSmallBlockType BlockType;

    /* The next pool that has free blocks of this size. Must be at offset +4
       to be typecast compatible with TSmallBlockType */
    PSmallBlockPoolHeader NextPartiallyFreePool;

    /* Pointer to the first free block inside this pool. Must be at offset + 8
     to be at the same offset as "NextSequentialFeedBlockAddress" of
     TSmallBlockType */
    void* FirstFreeBlock;

    /* The number of blocks allocated in this pool. Must be at offset + 12
       to be at the same offset as "MaxSequentialFeedBlockAddress" of
       TSmallBlockType */
    DWORD BlocksInUse;

    /* Small block pool signature. Used by the leak checking mechanism to
       determine whether a medium block is a small block pool or a regular medium
       block. */
    DWORD SmallBlockPoolSignature;

    /* The previous pool that has free blocks of this size. Must be at offset +20
       to be compatible with TSmallBlockType */
    PSmallBlockPoolHeader PreviousPartiallyFreePool;

    /* Reserved */
    DWORD Reserved1;

    /* The pool pointer and flags of the first block */
    DWORD FirstBlockPoolPointerAndFlags;
} TSmallBlockPoolHeader;


/* Small block layout:
   Offset: -4 = Flags + address of the small block pool
   Offset: BlockSize - 4 = Flags + address of the small block pool for the next small block
*/

// ------------------------Medium block structures------------------------

/* The medium block pool from which medium blocks are drawn */
typedef struct _TMediumBlockPoolHeader *PMediumBlockPoolHeader;
typedef struct _TMediumBlockPoolHeader
{
    /* Points to the previous and next medium block pools. This circular linked
     list is used to track memory leaks on program shutdown. */
    PMediumBlockPoolHeader PreviousMediumBlockPoolHeader;
    PMediumBlockPoolHeader NextMediumBlockPoolHeader;
    /* Unused dword */
    DWORD Reserved;
    /* The block size and flags of the first medium block in the block pool */
    DWORD FirstMediumBlockSizeAndFlags;
} TMediumBlockPoolHeader;


/* Medium block layout:
   Offset: -8 = Previous Block Size (only if the previous block is free)
   Offset: -4 = This block size and flags
   Offset: 0 = User data / Previous Free Block (if this block is free)
   Offset: 4 = Next Free Block (if this block is free)
   Offset: BlockSize - 8 = Size of this block (if this block is free)
   Offset: BlockSize - 4 = Size of the next block and flags
*/

/* A medium block that is unused */
typedef struct _TMediumFreeBlock *PMediumFreeBlock;
typedef struct _TMediumFreeBlock
{
    PMediumFreeBlock PreviousFreeBlock;
    PMediumFreeBlock NextFreeBlock;
} TMediumFreeBlock;

// -------------------------Large block structures------------------------

/* Large block header record (size = 16) */
typedef struct _TLargeBlockHeader *PLargeBlockHeader;
typedef struct _TLargeBlockHeader
{
    /* Points to the previous and next large blocks. This circular linked
       list is used to track memory leaks on program shutdown. */
    PLargeBlockHeader PreviousLargeBlockHeader;
    PLargeBlockHeader NextLargeBlockHeader;
    /* The user allocated size of the Large block */
    DWORD UserAllocatedSize;
    /* The size of this block plus the flags */
    DWORD BlockSizeAndFlags;
} TLargeBlockHeader;

// --------------------Expected Memory Leak Structures--------------------

#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE
typedef struct _TExpectedMemoryLeaks
{
    /* The number of entries used in the expected leaks buffer */
    unsigned int NumExpectedLeaks;
    /* The expected leaks buffer */
    void* ExpectedLeaks[(ExpectedMemoryLeaksListSize - 4) / 4];
} TExpectedMemoryLeaks, *PExpectedMemoryLeaks;
#endif

// ---------------------------Private constants-----------------------------
/* The size of the block header in front of small and medium blocks */
#define BlockHeaderSize 4

/* The size of a small block pool header */
#define SmallBlockPoolHeaderSize sizeof(TSmallBlockPoolHeader)

/* The size of a medium block pool header */
#define MediumBlockPoolHeaderSize sizeof(TMediumBlockPoolHeader)

/* The size of the header in front of Large blocks */
#define LargeBlockHeaderSize sizeof(TLargeBlockHeader)

static char Initialized = 0;

extern void*       __FASTCALL _FastMM_GetMem                (int Size);
extern int         __FASTCALL _FastMM_FreeMem               (void *P);
extern void*       __FASTCALL _FastMM_ReallocMem            (void *P, int Size);
extern void*       __FASTCALL _FastMM_AllocMem              (int Size);

static void*       __FASTCALL Init_GetMem                   (int Size);
static int         __FASTCALL Init_FreeMem                  (void *P);
static void*       __FASTCALL Init_ReallocMem               (void *P, int Size);
static void*       __FASTCALL Init_AllocMem                 (int Size);

static int         __FASTCALL RegisterExpectedMemoryLeak    (void *P);
static int         __FASTCALL UnregisterExpectedMemoryLeak  (void *P);


static const TMemoryManagerEx ThisMemoryManager = {
  _FastMM_GetMem, _FastMM_FreeMem, _FastMM_ReallocMem,
  _FastMM_AllocMem, RegisterExpectedMemoryLeak, UnregisterExpectedMemoryLeak
};

static const TMemoryManagerEx InitMemoryManager = {
  Init_GetMem, Init_FreeMem, Init_ReallocMem,
  Init_AllocMem, RegisterExpectedMemoryLeak, UnregisterExpectedMemoryLeak
};

TMemoryManagerEx _FastMM_MemoryManager = {
  Init_GetMem, Init_FreeMem, Init_ReallocMem,
  Init_AllocMem, RegisterExpectedMemoryLeak, UnregisterExpectedMemoryLeak
};
#define MemoryManager _FastMM_MemoryManager

// ---------------------------Private variables-----------------------------

// -----------------------Small block management--------------------------

/* The small block types. Sizes include the leading 4-byte overhead. Sizes are
   picked to limit maximum wastage to about 10% or 256 bytes (whichever is
   less) where possible. */
TSmallBlockType _FastMM_SmallBlockTypes[NumSmallBlockTypes] =
{
    /* 8/16 byte jumps */
    #ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
    { 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move12 },
    { 0, 0, 24, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move20 },
    { 0, 0, 32, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move28 },
    { 0, 0, 40, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move36 },
    { 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move44 },
    { 0, 0, 56, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move52 },
    { 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move60 },
    { 0, 0, 72, 0, 0, 0, 0, 0, 0, 0, _FastMM_Move68 },
    #else
    { 0, 0, 16 },
    { 0, 0, 24 },
    { 0, 0, 32 },
    { 0, 0, 40 },
    { 0, 0, 48 },
    { 0, 0, 56 },
    { 0, 0, 64 },
    { 0, 0, 72 },
    #endif
    { 0, 0, 80 },
    { 0, 0, 88 },
    { 0, 0, 96 },
    { 0, 0, 104 },
    { 0, 0, 112 },
    { 0, 0, 120 },
    { 0, 0, 128 },
    { 0, 0, 136 },
    { 0, 0, 144 },
    { 0, 0, 152 },
    { 0, 0, 160 },
    /* 16 byte jumps */
    { 0, 0, 176 },
    { 0, 0, 192 },
    { 0, 0, 208 },
    { 0, 0, 224 },
    { 0, 0, 240 },
    { 0, 0, 256 },
    { 0, 0, 272 },
    { 0, 0, 288 },
    { 0, 0, 304 },
    { 0, 0, 320 },
    /* 32 byte jumps */
    { 0, 0, 352 },
    { 0, 0, 384 },
    { 0, 0, 416 },
    { 0, 0, 448 },
    { 0, 0, 480 },
    /* 48 byte jumps */
    { 0, 0, 528 },
    { 0, 0, 576 },
    { 0, 0, 624 },
    { 0, 0, 672 },
    /* 64 byte jumps */
    { 0, 0, 736 },
    { 0, 0, 800 },
    /* 80 byte jumps */
    { 0, 0, 880 },
    { 0, 0, 960 },
    /* 96 byte jumps */
    { 0, 0, 1056 },
    { 0, 0, 1152 },
    /* 112 byte jumps */
    { 0, 0, 1264 },
    { 0, 0, 1376 },
    /* 128 byte jumps */
    { 0, 0, 1504 },
    /* 144 byte jumps */
    { 0, 0, 1648 },
    /* 160 byte jumps */
    { 0, 0, 1808 },
    /* 176 byte jumps */
    { 0, 0, 1984 },
    /* 192 byte jumps */
    { 0, 0, 2176 },
    /* {208 byte jumps */
    { 0, 0, 2384 },
    /* 224 byte jumps */
    { 0, 0, MaximumSmallBlockSize },
    /* The last block size occurs three times. If, during a GetMem call, the
       requested block size is already locked by another thread then up to two
       larger block sizes may be used instead. Having the last block size occur
       three times avoids the need to have a size overflow check. */
    { 0, 0, MaximumSmallBlockSize },
    { 0, 0, MaximumSmallBlockSize }
};
#define SmallBlockTypes _FastMM_SmallBlockTypes

/* The minimum block alignment */
static TMinimumBlockAlignment MinimumBlockAlignment;
// -----------------------Medium block management-------------------------
/* A dummy medium block pool header: Maintains a circular list of all medium
   block pools to enable memory leak detection on program shutdown. */
static TMediumBlockPoolHeader MediumBlockPoolsCircularList;

/* Are medium blocks locked? */
char _FastMM_MediumBlocksLocked = 0;
#define MediumBlocksLocked _FastMM_MediumBlocksLocked

/* Size to small block type translation table */
unsigned char _FastMM_AllocSize2SmallBlockTypeIndX4[MaximumSmallBlockSize / SmallBlockGranularity];
#define AllocSize2SmallBlockTypeIndX4 _FastMM_AllocSize2SmallBlockTypeIndX4

/* The sequential feed medium block pool. */
void* _FastMM_LastSequentiallyFedMediumBlock;
#define LastSequentiallyFedMediumBlock _FastMM_LastSequentiallyFedMediumBlock
DWORD _FastMM_MediumSequentialFeedBytesLeft;
#define MediumSequentialFeedBytesLeft _FastMM_MediumSequentialFeedBytesLeft
/* The medium block bins are divided into groups of 32 bins. If a bit
   is set in this group bitmap, then at least one bin in the group has free
   blocks. */
DWORD _FastMM_MediumBlockBinGroupBitmap;
#define MediumBlockBinGroupBitmap _FastMM_MediumBlockBinGroupBitmap
/* The medium block bins: total of 32 * 32 = 1024 bins of a certain
   minimum size. */
DWORD _FastMM_MediumBlockBinBitmaps[MediumBlockBinGroupCount];
#define MediumBlockBinBitmaps _FastMM_MediumBlockBinBitmaps

/* The medium block bins. There are 1024 LIFO circular linked lists each
   holding blocks of a specified minimum size. The sizes vary in size from
   MinimumMediumBlockSize to MaximumMediumBlockSize. The bins are treated as
   type TMediumFreeBlock to avoid pointer checks. */
TMediumFreeBlock _FastMM_MediumBlockBins[MediumBlockBinCount];
#define MediumBlockBins _FastMM_MediumBlockBins

// -------------------------Large block management------------------------
/* Are large blocks locked? */
static char LargeBlocksLocked;
/* A dummy large block header: Maintains a list of all allocated large blocks
   to enable memory leak detection on program shutdown. */
static TLargeBlockHeader LargeBlocksCircularList;
// ---------------------Expected Memory Leak Structures-------------------
#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE
/* The expected memory leaks */
static PExpectedMemoryLeaks ExpectedMemoryLeaks;
static char ExpectedMemoryLeaksListLocked;
#endif
// ------------------------------Other info-------------------------------
/* A string uniquely identifying the current process (for sharing the memory
   manager between DLLs and the main application). */
static char MappingObjectName[26] = "Local\\FastMM_PID_???????\0";
/* The handle of the memory mapped file that contains the pointer to the
   TMemoryManagerEx structure of the shared memory manager. */
static HANDLE MappingObjectHandle;

/******************************************************/
#pragma pack(pop)

// Remove unnecessary stack frames where possible
#pragma option push -k-
/******************************************************/

// ---------------------------Utility Functions----------------------------

void __FASTCALL _FastMM_SetMemoryManager(const TMemoryManagerEx *MemMgrEx)
{
    if (MemMgrEx)
        memcpy(&MemoryManager, MemMgrEx, sizeof(TMemoryManagerEx));
}

int __FASTCALL _FastMM_IsMemoryManagerSet(void)
{
    return (MemoryManager.GetMem != _FastMM_GetMem ||
            MemoryManager.FreeMem != _FastMM_FreeMem ||
            MemoryManager.ReallocMem != _FastMM_ReallocMem ||
            MemoryManager.AllocMem != _FastMM_AllocMem ||
            MemoryManager.RegisterExpectedMemoryLeak != RegisterExpectedMemoryLeak ||
            MemoryManager.UnregisterExpectedMemoryLeak != UnregisterExpectedMemoryLeak);
}

static int __FASTCALL IsInitMemoryManagerSet(void)
{
    return (MemoryManager.GetMem == Init_GetMem ||
            MemoryManager.FreeMem == Init_FreeMem ||
            MemoryManager.ReallocMem == Init_ReallocMem ||
            MemoryManager.AllocMem == Init_AllocMem ||
            MemoryManager.RegisterExpectedMemoryLeak == RegisterExpectedMemoryLeak ||
            MemoryManager.UnregisterExpectedMemoryLeak == UnregisterExpectedMemoryLeak);
}

/* Compare [AAddress], CompareVal:
   If Equal: [AAddress] := NewVal and result = CompareVal
   If Unequal: Result := [AAddress] */
extern char __FASTCALL _FastMM_LockCmpxchg(char CompareVal, char NewVal, char* AAddress);

#ifdef USE_C_CODE
/* Gets the first set bit and resets it, returning the bit index */
extern unsigned int __FASTCALL _FastMM_FindFirstSetBit(unsigned int ACardinal);
#endif

// ----------------------------Block Locking---------------------------

static void __FASTCALL LockBlocks(void *Lock)
{
    while (_FastMM_LockCmpxchg(0, 1, Lock) != 0)
    {
        if (!_FastMM_NeverSleepOnMMThreadContention)
        {
            Sleep(InitialSleepTime);
            if (_FastMM_LockCmpxchg(0, 1, Lock) == 0)
                break;
            Sleep(AdditionalSleepTime);
        }
    }
}

// ----------------------Small Block Management-------------------------

/* Locks all small block types */
static void __FASTCALL LockAllSmallBlockTypes(void)
{
    DWORD LInd;
    if (_FastMM_IsMultiThread)
    {
        for (LInd = 0; LInd < NumSmallBlockTypes; LInd++)
            LockBlocks(&SmallBlockTypes[LInd].BlockTypeLocked);
    }
}

// -------------------------Medium Block Management-------------------------

/* Locks the medium blocks */
static inline void __FASTCALL LockMediumBlocks(void)
{
    /* Lock the medium blocks */
    if (_FastMM_IsMultiThread)
        LockBlocks(&MediumBlocksLocked);
}

/* Removes a medium block from the circular linked list of free blocks.
   Does not change any header flags. Medium blocks should be locked
   before calling this procedure. */
#ifdef USE_C_CODE
void __FASTCALL _FastMM_RemoveMediumFreeBlock(PMediumFreeBlock APMediumFreeBlock)
{
    DWORD LBinNumber, LBinGroupNumber;

    /* Get the current previous and next blocks */
    PMediumFreeBlock LNextFreeBlock = APMediumFreeBlock->NextFreeBlock;
    PMediumFreeBlock LPreviousFreeBlock = APMediumFreeBlock->PreviousFreeBlock;
    /* Remove this block from the linked list */
    LPreviousFreeBlock->NextFreeBlock = LNextFreeBlock;
    LNextFreeBlock->PreviousFreeBlock = LPreviousFreeBlock;
    /* Is this bin now empty? If the previous and next free block pointers are
       equal, they must point to the bin. */
    if (LPreviousFreeBlock == LNextFreeBlock)
    {
        /* Get the bin number for this block size */
        LBinNumber = ((DWORD)LNextFreeBlock - (DWORD)&MediumBlockBins) / sizeof(TMediumFreeBlock);
        LBinGroupNumber = LBinNumber / 32;
        /* lag this bin as empty */
        MediumBlockBinBitmaps[LBinGroupNumber] = MediumBlockBinBitmaps[LBinGroupNumber]
            & (~ (1 << (LBinNumber & 31)));
        /* Is the group now entirely empty? */
        if (MediumBlockBinBitmaps[LBinGroupNumber] == 0)
        {
            /* Flag this group as empty */
            MediumBlockBinGroupBitmap = MediumBlockBinGroupBitmap
                & (~ (1 << LBinGroupNumber));
        }
    }
}
#else
extern void __FASTCALL _FastMM_RemoveMediumFreeBlock(PMediumFreeBlock APMediumFreeBlock);
#endif

/* Inserts a medium block into the appropriate medium block bin. */
#ifdef USE_C_CODE
void __FASTCALL _FastMM_InsertMediumBlockIntoBin(PMediumFreeBlock APMediumFreeBlock, DWORD AMediumBlockSize)
{
    DWORD LBinNumber, LBinGroupNumber;
    PMediumFreeBlock LPBin, LPFirstFreeBlock;

    /* Get the bin number for this block size. Get the bin that holds blocks of at
    least this size. */
    LBinNumber = (AMediumBlockSize - MinimumMediumBlockSize) / MediumBlockGranularity;
    if (LBinNumber >= MediumBlockBinCount)
        LBinNumber = MediumBlockBinCount - 1;

    /* Get the bin */
    LPBin = &MediumBlockBins[LBinNumber];
    /* Bins are LIFO, se we insert this block as the first free block in the bin */
    LPFirstFreeBlock = LPBin->NextFreeBlock;
    APMediumFreeBlock->PreviousFreeBlock = LPBin;
    APMediumFreeBlock->NextFreeBlock = LPFirstFreeBlock;
    LPFirstFreeBlock->PreviousFreeBlock = APMediumFreeBlock;
    LPBin->NextFreeBlock = APMediumFreeBlock;
    /* Was this bin empty? */
    if (LPFirstFreeBlock == LPBin)
    {
        /* Get the group number */
        LBinGroupNumber = LBinNumber / 32;
        /* Flag this bin as used */
        MediumBlockBinBitmaps[LBinGroupNumber] = MediumBlockBinBitmaps[LBinGroupNumber]
            | (1 << (LBinNumber & 31));
        /* Flag the group as used */
        MediumBlockBinGroupBitmap = MediumBlockBinGroupBitmap
            | (1 << LBinGroupNumber);
    }
}
#else
extern void __FASTCALL _FastMM_InsertMediumBlockIntoBin(PMediumFreeBlock APMediumFreeBlock, DWORD AMediumBlockSize);
#endif

/* Bins what remains in the current sequential feed medium block pool. Medium
   blocks must be locked. */
#ifdef USE_C_CODE
void __FASTCALL _FastMM_BinMediumSequentialFeedRemainder(void)
{
    DWORD LSequentialFeedFreeSize, LNextBlockSizeAndFlags;
    void *LPRemainderBlock, *LNextMediumBlock;

    LSequentialFeedFreeSize = MediumSequentialFeedBytesLeft;
    if (LSequentialFeedFreeSize > 0)
    {
        /* Get the block after the open space */
        LNextMediumBlock = LastSequentiallyFedMediumBlock;
        LNextBlockSizeAndFlags = *DWORD_PTR_SUBOFS(LNextMediumBlock, BlockHeaderSize);
        /* Point to the remainder */
        LPRemainderBlock = DWORD_PTR_SUBOFS(LNextMediumBlock, LSequentialFeedFreeSize);
        /* Can the next block be combined with the remainder? */
        if ((LNextBlockSizeAndFlags & IsFreeBlockFlag) != 0)
        {
            /* Increase the size of this block */
            LSequentialFeedFreeSize += LNextBlockSizeAndFlags & DropMediumAndLargeFlagsMask;
            /* Remove the next block as well */
            if ((LNextBlockSizeAndFlags & DropMediumAndLargeFlagsMask) >= MinimumMediumBlockSize)
              _FastMM_RemoveMediumFreeBlock(LNextMediumBlock);
        } else {
            /* Set the "previous block is free" flag of the next block */
            *DWORD_PTR_SUBOFS(LNextMediumBlock, BlockHeaderSize) = LNextBlockSizeAndFlags | PreviousMediumBlockIsFreeFlag;
        }
        /* Store the size of the block as well as the flags */
        *DWORD_PTR_SUBOFS(LPRemainderBlock, BlockHeaderSize) = LSequentialFeedFreeSize | IsMediumBlockFlag | IsFreeBlockFlag;
        /* Store the trailing size marker */
        *DWORD_PTR_OFS(LPRemainderBlock, LSequentialFeedFreeSize - 8) = LSequentialFeedFreeSize;
        /* Bin this medium block */
        if (LSequentialFeedFreeSize >= MinimumMediumBlockSize)
          _FastMM_InsertMediumBlockIntoBin(LPRemainderBlock, LSequentialFeedFreeSize);
    }
}
#else
extern void __FASTCALL _FastMM_BinMediumSequentialFeedRemainder(void);
#endif

/* Allocates a new sequential feed medium block pool and immediately splits off a
   block of the requested size. The block size must be a multiple of 16 and
   medium blocks must be locked. */
void* __FASTCALL _FastMM_AllocNewSequentialFeedMediumPool(DWORD AFirstBlockSize)
{
    PMediumBlockPoolHeader LOldFirstMediumBlockPool;
    void* LNewPool;
    void* Result;

    /* Bin the current sequential feed remainder */
    _FastMM_BinMediumSequentialFeedRemainder();
    /* Allocate a new sequential feed block pool */
    LNewPool = VirtualAlloc(0, MediumBlockPoolSize, MEM_COMMIT, PAGE_READWRITE);
    if (LNewPool)
    {
        /* Insert this block pool into the list of block pools */
        LOldFirstMediumBlockPool = MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
        ((PMediumBlockPoolHeader)LNewPool)->PreviousMediumBlockPoolHeader = &MediumBlockPoolsCircularList;
        MediumBlockPoolsCircularList.NextMediumBlockPoolHeader = LNewPool;
        ((PMediumBlockPoolHeader)LNewPool)->NextMediumBlockPoolHeader = LOldFirstMediumBlockPool;
        LOldFirstMediumBlockPool->PreviousMediumBlockPoolHeader = LNewPool;
        /* Store the sequential feed pool trailer */
        *DWORD_PTR_OFS(LNewPool, MediumBlockPoolSize - BlockHeaderSize) = IsMediumBlockFlag;
        /* Get the number of bytes still available */
        MediumSequentialFeedBytesLeft = (MediumBlockPoolSize - MediumBlockPoolHeaderSize) - AFirstBlockSize;
        /* Get the result */
        Result = DWORD_PTR_OFS(LNewPool, MediumBlockPoolSize - AFirstBlockSize);
        LastSequentiallyFedMediumBlock = Result;
        /* Store the block header */
        *DWORD_PTR_SUBOFS(Result, BlockHeaderSize) = AFirstBlockSize | IsMediumBlockFlag;
        return Result;
    } else {
        /* Out of memory */
        MediumSequentialFeedBytesLeft = 0;
        return 0;
    }
}

/* Frees a medium block pool. Medium blocks must be locked on entry. */
//static void __FASTCALL FreeMediumBlockPool(PMediumBlockPoolHeader AMediumBlockPool)
//{
//    PMediumBlockPoolHeader LPPreviousMediumBlockPoolHeader, LPNextMediumBlockPoolHeader;
//
//    /* Remove this medium block pool from the linked list */
//    LPPreviousMediumBlockPoolHeader = AMediumBlockPool->PreviousMediumBlockPoolHeader;
//    LPNextMediumBlockPoolHeader = AMediumBlockPool->NextMediumBlockPoolHeader;
//    LPPreviousMediumBlockPoolHeader->NextMediumBlockPoolHeader = LPNextMediumBlockPoolHeader;
//    LPNextMediumBlockPoolHeader->PreviousMediumBlockPoolHeader = LPPreviousMediumBlockPoolHeader;
//    /* Free the medium block pool */
//    VirtualFree(AMediumBlockPool, 0, MEM_RELEASE);
//}

/* --------------------------Large Block Management------------------------- */

/* Locks the large blocks */
static void __FASTCALL LockLargeBlocks(void)
{
    /* Lock the large blocks */
    if (_FastMM_IsMultiThread)
        LockBlocks(&LargeBlocksLocked);
}


/* Allocates a Large block of at least ASize (actual size may be Larger to
   allow for alignment etc.). ASize must be the actual user requested size. This
   procedure will pad it to the appropriate page boundary and also add the space
   required by the header. */
void* __FASTCALL _FastMM_AllocateLargeBlock(DWORD ASize)
{
    DWORD LLargeUsedBlockSize;
    PLargeBlockHeader LOldFirstLargeBlock;
    void* Result;

    /* Pad the block size to include the header and granularity. We also add a
     4-byte overhead so a huge block size is a multiple of 16 bytes less 4 (so we
     can use a single move function for reallocating all block types) */
    LLargeUsedBlockSize = (ASize + LargeBlockHeaderSize + LargeBlockGranularity - 1 + BlockHeaderSize)
        & (-LargeBlockGranularity);
    /* Get the Large block */
    Result = VirtualAlloc(0, LLargeUsedBlockSize, MEM_COMMIT | MEM_TOP_DOWN,
        PAGE_READWRITE);
    /* Set the Large block fields */
    if (Result)
    {
        /* Set the large block size and flags */
        ((PLargeBlockHeader)Result)->UserAllocatedSize = ASize;
        ((PLargeBlockHeader)Result)->BlockSizeAndFlags = LLargeUsedBlockSize | IsLargeBlockFlag;
        /* Insert the large block into the linked list of large blocks */
        LockLargeBlocks();
        LOldFirstLargeBlock = LargeBlocksCircularList.NextLargeBlockHeader;
        ((PLargeBlockHeader)Result)->PreviousLargeBlockHeader = &LargeBlocksCircularList;
        LargeBlocksCircularList.NextLargeBlockHeader = Result;
        ((PLargeBlockHeader)Result)->NextLargeBlockHeader = LOldFirstLargeBlock;
        LOldFirstLargeBlock->PreviousLargeBlockHeader = Result;
        LargeBlocksLocked = 0; /* false */
        /* Add the size of the header */
        Result = DWORD_PTR_OFS(Result, LargeBlockHeaderSize);
    }
    return Result;
}

/* Frees a large block, returning 0 on success, -1 otherwise */
int __FASTCALL _FastMM_FreeLargeBlock(void* APointer)
{
    PLargeBlockHeader LPreviousLargeBlockHeader, LNextLargeBlockHeader;
    DWORD LRemainingSize;
    void* LCurrentSegment;
    MEMORY_BASIC_INFORMATION LMemInfo;
    int Result;

    /* Point to the start of the large block */
    APointer = DWORD_PTR_SUBOFS(APointer, LargeBlockHeaderSize);
    /* Get the previous and next large blocks */
    LockLargeBlocks();
    LPreviousLargeBlockHeader = ((PLargeBlockHeader)APointer)->PreviousLargeBlockHeader;
    LNextLargeBlockHeader = ((PLargeBlockHeader)APointer)->NextLargeBlockHeader;
    /* Is the large block segmented? */
    if ((((PLargeBlockHeader)APointer)->BlockSizeAndFlags & LargeBlockIsSegmented) == 0)
    {
        /* Single segment large block: Try to free it */
        Result = (VirtualFree(APointer, 0, MEM_RELEASE)) ? 0 : -1;
    } else {
        /* The large block is segmented - free all segments */
        LCurrentSegment = APointer;
        LRemainingSize = ((PLargeBlockHeader)APointer)->BlockSizeAndFlags & DropMediumAndLargeFlagsMask;
        Result = 0;
        while (1)
        {
            /* Get the size of the current segment */
            VirtualQuery(LCurrentSegment, &LMemInfo, sizeof(LMemInfo));
            /* Free the segment */
            if (!VirtualFree(LCurrentSegment, 0, MEM_RELEASE))
            {
                Result = -1;
                break;
            }
            /* Done? */
            if ((DWORD)LMemInfo.RegionSize >= LRemainingSize)
                break;
            /* Decrement the remaining size */
            LRemainingSize -= (DWORD)LMemInfo.RegionSize;
            LCurrentSegment = DWORD_PTR_OFS(LCurrentSegment, ((DWORD)LMemInfo.RegionSize));
        }
    }
    /* Success? */
    if (Result == 0)
    {
        /* Remove the large block from the linked list */
        LNextLargeBlockHeader->PreviousLargeBlockHeader = LPreviousLargeBlockHeader;
        LPreviousLargeBlockHeader->NextLargeBlockHeader = LNextLargeBlockHeader;
    }
    /* Unlock the large blocks */
    LargeBlocksLocked = 0; /* false */
    return Result;
}

/* Reallocates a large block to at least the requested size. Returns the new
   pointer, or nil on error */
void* __FASTCALL _FastMM_ReallocateLargeBlock(void* APointer, DWORD ANewSize)
{
    DWORD LOldAvailableSize, LBlockHeader, LOldUserSize, LMinimumUpsize,
        LNewAllocSize;
    DWORD LNewSegmentSize;
    void* LNextSegmentPointer;
    MEMORY_BASIC_INFORMATION LMemInfo;
    void* Result;
    PLargeBlockHeader b;

    /* Get the block header */
    LBlockHeader = *DWORD_PTR_SUBOFS(APointer, BlockHeaderSize);
    /* Large block - size is (16 + 4) less than the allocated size */
    LOldAvailableSize = (LBlockHeader & DropMediumAndLargeFlagsMask) - (LargeBlockHeaderSize + BlockHeaderSize);
    /* Is it an upsize or a downsize? */
    if ((DWORD)ANewSize > LOldAvailableSize)
    {
        /* This pointer is being reallocated to a larger block and therefore it is
           logical to assume that it may be enlarged again. Since reallocations are
           expensive, there is a minimum upsize percentage to avoid unnecessary
           future move operations. */
        /* Add 25% for large block upsizes */
        LMinimumUpsize = ((DWORD)LOldAvailableSize) + (((DWORD)LOldAvailableSize) >> 2);
        LNewAllocSize = ((DWORD)ANewSize < LMinimumUpsize) ? LMinimumUpsize : ANewSize;
        /* Can another large block segment be allocated directly after this segment,
           thus negating the need to move the data? */
        LNextSegmentPointer = DWORD_PTR_SUBOFS(APointer, LargeBlockHeaderSize + (LBlockHeader & DropMediumAndLargeFlagsMask));
        VirtualQuery(LNextSegmentPointer, &LMemInfo, sizeof(LMemInfo));
        if (LMemInfo.State == MEM_FREE)
        {
            /* Round the region size to the previous 64K */
            LMemInfo.RegionSize = LMemInfo.RegionSize & (-LargeBlockGranularity);
            /* Enough space to grow in place? */
            if (((DWORD)LMemInfo.RegionSize) > (ANewSize - LOldAvailableSize))
            {
                /* There is enough space after the block to extend it - determine by how
                   much */
                LNewSegmentSize = (LNewAllocSize - LOldAvailableSize + LargeBlockGranularity - 1) & (-LargeBlockGranularity);
                if (LNewSegmentSize > (DWORD)LMemInfo.RegionSize)
                    LNewSegmentSize = (DWORD)LMemInfo.RegionSize;
                if (VirtualAlloc(LNextSegmentPointer, LNewSegmentSize, MEM_RESERVE, PAGE_READWRITE)
                    && VirtualAlloc(LNextSegmentPointer, LNewSegmentSize, MEM_COMMIT, PAGE_READWRITE))
                {
                    /* Update the requested size */
                    b = ((PLargeBlockHeader)(((DWORD_PTR)APointer) - LargeBlockHeaderSize));
                    b->UserAllocatedSize = ANewSize;
                    b->BlockSizeAndFlags = (b->BlockSizeAndFlags + LNewSegmentSize) | LargeBlockIsSegmented;
                    /* Success */
                    return APointer;
                }
            }
        }
        /* Could not resize in place: Allocate the new block */
        Result = _FastMM_GetMem(LNewAllocSize);
        if (Result)
        {
            /* If it's a large block - store the actual user requested size (it may
               not be if the block that is being reallocated from was previously
               downsized) */
            if (LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize))
                ((PLargeBlockHeader)(((DWORD_PTR)Result) - LargeBlockHeaderSize))->UserAllocatedSize = ANewSize;
            /* The user allocated size is stored for large blocks */
            LOldUserSize = ((PLargeBlockHeader)(((DWORD_PTR)APointer) - LargeBlockHeaderSize))->UserAllocatedSize;
            /* The number of bytes to move is the old user size. */
#ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
            _FastMM_MoveX16L4(APointer, Result, LOldUserSize);
#else
            _internal_memmove(APointer, Result, LOldUserSize);
#endif
            /* Free the old block */
            _FastMM_FreeMem(APointer);
        }
    } else {
        /* It's a downsize: do we need to reallocate? Only if the new size is less
           than half the old size */
        if ((DWORD)(ANewSize) >= (LOldAvailableSize >> 1))
        {
            /* No need to reallocate */
            Result = APointer;
            /* Update the requested size */
            ((PLargeBlockHeader)(((DWORD_PTR)APointer) - LargeBlockHeaderSize))->UserAllocatedSize = ANewSize;
        } else {
            /* The block is less than half the old size: reallocate */
            Result = _FastMM_GetMem(ANewSize);
            if (Result)
            {
                /* Still a large block? -> Set the user size */
                if (ANewSize > (MaximumMediumBlockSize - BlockHeaderSize))
                    ((PLargeBlockHeader)(((DWORD_PTR)APointer) - LargeBlockHeaderSize))->UserAllocatedSize = ANewSize;
                /* Move the data across */
#ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
                _FastMM_MoveX8L4(APointer, Result, (int)ANewSize);
#else
                _internal_memmove(APointer, Result, (int)ANewSize);
#endif
                /* Free the old block */
                _FastMM_FreeMem(APointer);
            }
        }
    }
    return Result;
}

/* ----------------------Main Memory Manager Functions---------------------- */

#ifdef USE_C_CODE
void* __FASTCALL _FastMM_GetMem(int Size)
{
    PMediumFreeBlock LMediumBlock, LNextFreeBlock, LSecondSplit;
    LPDWORD LNextMediumBlockHeader;
    DWORD LBlockSize, LAvailableBlockSize, LSecondSplitSize;
    PSmallBlockType LPSmallBlockType;
    PSmallBlockPoolHeader LPSmallBlockPool, LPNewFirstPool;
    DWORD LBinNumber;
    void *LNewFirstFreeBlock;
    PMediumFreeBlock LPMediumBin;
    DWORD LSequentialFeedFreeSize;
    DWORD LBinGroupsMasked, LBinGroupMasked, LBinGroupNumber;
    void *Result;

    /* Is it a small block? -> Take the header size into account when
       determining the required block size */
    if (((DWORD)Size) <= (MaximumSmallBlockSize - BlockHeaderSize))
    {
        /* -----------------------Allocate a small block------------------------ */
        /* Get the block type from the size */
        LPSmallBlockType = (PSmallBlockType)(AllocSize2SmallBlockTypeIndX4[
            ((DWORD)Size + (BlockHeaderSize - 1)) / SmallBlockGranularity] * 8
                + (DWORD_PTR)SmallBlockTypes);
            /* Lock the block type */
            if (_FastMM_IsMultiThread)
            {
                while (1)
                {
                    /* Try to lock the small block type */
                    if (_FastMM_LockCmpxchg(0, 1, &LPSmallBlockType->BlockTypeLocked) == 0)
                        break;
                    /* Try the next block type */
                    //Inc(Cardinal(LPSmallBlockType), sizeof(TSmallBlockType));
                    LPSmallBlockType++;
                    if (_FastMM_LockCmpxchg(0, 1, &LPSmallBlockType->BlockTypeLocked) == 0)
                        break;
                    /* Try up to two sizes past the requested size */
                    //Inc(Cardinal(LPSmallBlockType), sizeof(TSmallBlockType));
                    LPSmallBlockType++;
                    if (_FastMM_LockCmpxchg(0, 1, &LPSmallBlockType->BlockTypeLocked) == 0)
                        break;
                    /* All three sizes locked - given up and sleep */
                    //Dec(Cardinal(LPSmallBlockType), 2 * sizeof(TSmallBlockType));
                    LPSmallBlockType--;
                    LPSmallBlockType--;
                    if (!_FastMM_NeverSleepOnMMThreadContention)
                    {
                        /* Both this block type and the next is in use: sleep */
                        Sleep(InitialSleepTime);
                        /* Try the lock again */
                        if (_FastMM_LockCmpxchg(0, 1, &LPSmallBlockType->BlockTypeLocked) == 0)
                            break;
                        /* Sleep longer */
                        Sleep(AdditionalSleepTime);
                    }
                }
            }
            /* Get the first pool with free blocks */
            LPSmallBlockPool = LPSmallBlockType->NextPartiallyFreePool;
            /* Is the pool valid? */
            if ((DWORD_PTR)LPSmallBlockPool != (DWORD_PTR)LPSmallBlockType)
            {
                /* Get the first free offset */
                Result = LPSmallBlockPool->FirstFreeBlock;
                /* Get the new first free block */
                LNewFirstFreeBlock = (void*)*DWORD_PTR_SUBOFS(Result, 4);
                LNewFirstFreeBlock = (void*)(((DWORD_PTR)LNewFirstFreeBlock) & DropSmallFlagsMask);
                /* Increment the number of used blocks */
                LPSmallBlockPool->BlocksInUse++;
                /* Set the new first free block */
                LPSmallBlockPool->FirstFreeBlock = LNewFirstFreeBlock;
                /* Is the pool now full? */
                if (!LNewFirstFreeBlock)
                {
                    /* Pool is full - remove it from the partially free list */
                    LPNewFirstPool = LPSmallBlockPool->NextPartiallyFreePool;
                    LPSmallBlockType->NextPartiallyFreePool = LPNewFirstPool;
                    LPNewFirstPool->PreviousPartiallyFreePool = (PSmallBlockPoolHeader)LPSmallBlockType;
                }
            } else {
                /* Try to feed a small block sequentially */
                Result = LPSmallBlockType->NextSequentialFeedBlockAddress;
                /* Can another block fit? */
                if ((DWORD_PTR)Result <= (DWORD_PTR)LPSmallBlockType->MaxSequentialFeedBlockAddress)
                {
                    /* Get the sequential feed block pool */
                    LPSmallBlockPool = LPSmallBlockType->CurrentSequentialFeedPool;
                    /* Increment the number of used blocks in the sequential feed pool */
                    LPSmallBlockPool->BlocksInUse++;
                    /* Store the next sequential feed block address */
                    LPSmallBlockType->NextSequentialFeedBlockAddress = DWORD_PTR_OFS(Result, LPSmallBlockType->BlockSize);
                } else {
                    /* Need to allocate a pool: Lock the medium blocks */
                    LockMediumBlocks();
                    /* Are there any available blocks of a suitable size? */
                    LBinGroupsMasked = MediumBlockBinGroupBitmap & (0xffffff00 | LPSmallBlockType->AllowedGroupsForBlockPoolBitmap);
                    if (LBinGroupsMasked)
                    {
                        /* Get the bin group with free blocks */
                        LBinGroupNumber = _FastMM_FindFirstSetBit(LBinGroupsMasked);
                        /* Get the bin in the group with free blocks */
                        LBinNumber = _FastMM_FindFirstSetBit(MediumBlockBinBitmaps[LBinGroupNumber])
                            + LBinGroupNumber * 32;
                        LPMediumBin = &MediumBlockBins[LBinNumber];
                        /* Get the first block in the bin */
                        LMediumBlock = LPMediumBin->NextFreeBlock;
                        /* Remove the first block from the linked list (LIFO) */
                        LNextFreeBlock = LMediumBlock->NextFreeBlock;
                        LPMediumBin->NextFreeBlock = LNextFreeBlock;
                        LNextFreeBlock->PreviousFreeBlock = LPMediumBin;
                        /* Is this bin now empty? */
                        if (LNextFreeBlock == LPMediumBin)
                        {
                            /* Flag this bin as empty */
                            MediumBlockBinBitmaps[LBinGroupNumber] = MediumBlockBinBitmaps[LBinGroupNumber]
                            & (~ (1 << (LBinNumber & 31)));
                            /* Is the group now entirely empty? */
                            if (MediumBlockBinBitmaps[LBinGroupNumber] == 0)
                            {
                                /* Flag this group as empty */
                                MediumBlockBinGroupBitmap = MediumBlockBinGroupBitmap
                                    & (~ (1 << LBinGroupNumber));
                            }
                        }
                        /* Get the size of the available medium block */
                        LBlockSize = *DWORD_PTR_SUBOFS(LMediumBlock, BlockHeaderSize) & DropMediumAndLargeFlagsMask;
                        /* Medium blocks are never split or coalesced in full debug mode */
                        /* Should the block be split? */
                        if (LBlockSize >= MaximumSmallBlockPoolSize)
                        {
                            /* Get the size of the second split */
                            LSecondSplitSize = LBlockSize - LPSmallBlockType->OptimalBlockPoolSize;
                            /* Adjust the block size */
                            LBlockSize = LPSmallBlockType->OptimalBlockPoolSize;
                            /* Split the block in two */
                            LSecondSplit = (PMediumFreeBlock)(((DWORD_PTR)LMediumBlock) + LBlockSize);
                            *DWORD_PTR_SUBOFS(LSecondSplit, BlockHeaderSize) = LSecondSplitSize | (IsMediumBlockFlag | IsFreeBlockFlag);
                            /* Store the size of the second split as the second last dword */
                            *DWORD_PTR_OFS(LSecondSplit, LSecondSplitSize - 8) = LSecondSplitSize;
                            /* Put the remainder in a bin (it will be big enough) */
                            _FastMM_InsertMediumBlockIntoBin(LSecondSplit, LSecondSplitSize);
                        } else {
                            /* Mark this block as used in the block following it */
                            LNextMediumBlockHeader = DWORD_PTR_OFS(LMediumBlock, LBlockSize - BlockHeaderSize);
                            *LNextMediumBlockHeader = *LNextMediumBlockHeader & ~PreviousMediumBlockIsFreeFlag;
                        }
                    } else {
                        /* Check the sequential feed medium block pool for space */
                        LSequentialFeedFreeSize = MediumSequentialFeedBytesLeft;
                        if (LSequentialFeedFreeSize >= (DWORD)LPSmallBlockType->MinimumBlockPoolSize)
                        {
                            /* Enough sequential feed space: Will the remainder be usable? */
                            if (LSequentialFeedFreeSize >= ((DWORD)LPSmallBlockType->OptimalBlockPoolSize + MinimumMediumBlockSize))
                            {
                                LBlockSize = LPSmallBlockType->OptimalBlockPoolSize;
                            } else {
                                LBlockSize = LSequentialFeedFreeSize;
                            }
                            /* Get the block */
                            LMediumBlock = (void*)DWORD_PTR_SUBOFS(LastSequentiallyFedMediumBlock, LBlockSize);
                            /* Update the sequential feed parameters */
                            LastSequentiallyFedMediumBlock = LMediumBlock;
                            MediumSequentialFeedBytesLeft = LSequentialFeedFreeSize - LBlockSize;
                        } else {
                            /* Need to allocate a new sequential feed medium block pool: use the
                               optimal size for this small block pool */
                            LBlockSize = LPSmallBlockType->OptimalBlockPoolSize;
                            /* Allocate the medium block pool */
                            LMediumBlock = _FastMM_AllocNewSequentialFeedMediumPool(LBlockSize);
                            if (!LMediumBlock)
                            {
                                /* Out of memory */
                                /* Unlock the medium blocks */
                                MediumBlocksLocked = 0; /* false */
                                /* Unlock the block type */
                                LPSmallBlockType->BlockTypeLocked = 0; /* false */
                                /* Failed */
                                return 0;
                            }
                        }
                    }
                    /* Mark this block as in use */
                    /* Set the size and flags for this block */
                    *DWORD_PTR_SUBOFS(LMediumBlock, BlockHeaderSize) =
                        LBlockSize | IsMediumBlockFlag | IsSmallBlockPoolInUseFlag;
                    /* Unlock medium blocks */
                    MediumBlocksLocked = 0; /* false */
                    /* Set up the block pool */
                    LPSmallBlockPool = (PSmallBlockPoolHeader)LMediumBlock;
                    LPSmallBlockPool->BlockType = LPSmallBlockType;
                    LPSmallBlockPool->FirstFreeBlock = 0;
                    LPSmallBlockPool->BlocksInUse = 1;
                    /* Set it up for sequential block serving */
                    LPSmallBlockType->CurrentSequentialFeedPool = LPSmallBlockPool;
                    Result = (void*)(((DWORD_PTR)LPSmallBlockPool) + SmallBlockPoolHeaderSize);
                    LPSmallBlockType->NextSequentialFeedBlockAddress =
                        (void*)(((DWORD_PTR)Result) + LPSmallBlockType->BlockSize);
                    LPSmallBlockType->MaxSequentialFeedBlockAddress =
                        (void*)(((DWORD_PTR)LPSmallBlockPool) + LBlockSize - LPSmallBlockType->BlockSize);
                }
            }
            /* Unlock the block type */
            LPSmallBlockType->BlockTypeLocked = 0; /* false */
            /* Set the block header */
            *DWORD_PTR_SUBOFS(Result, BlockHeaderSize) = (DWORD_PTR)LPSmallBlockPool;
    } else {
        /* Medium block or Large block? */
        if ((DWORD)Size <= (MaximumMediumBlockSize - BlockHeaderSize))
        {
            /* ---------------------Allocate a medium block----------------------- */
            /* Get the block size and bin number for this block size. Block sizes are
               rounded up to the next bin size. */
            LBlockSize = (((DWORD)Size + (MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset))
                & (-MediumBlockGranularity)) + MediumBlockSizeOffset;
            /* Get the bin number */
            LBinNumber = (LBlockSize - MinimumMediumBlockSize) / MediumBlockGranularity;
            /* Lock the medium blocks */
            LockMediumBlocks();
            /* Calculate the bin group */
            LBinGroupNumber = LBinNumber / 32;
            /* Is there a suitable block inside this group? */
            LBinGroupMasked = MediumBlockBinBitmaps[LBinGroupNumber] & -(1 << (LBinNumber & 31));
            if (LBinGroupMasked != 0)
            {
                /* Get the actual bin number */
                LBinNumber = _FastMM_FindFirstSetBit(LBinGroupMasked) + LBinGroupNumber * 32;
            } else {
                /* Try all groups greater than this group */
                LBinGroupsMasked = MediumBlockBinGroupBitmap & -(2 << LBinGroupNumber);
                if (LBinGroupsMasked != 0)
                {
                    /* There is a suitable group with space: get the bin number */
                    LBinGroupNumber = _FastMM_FindFirstSetBit(LBinGroupsMasked);
                    /* Get the bin in the group with free blocks */
                    LBinNumber = _FastMM_FindFirstSetBit(MediumBlockBinBitmaps[LBinGroupNumber])
                        + LBinGroupNumber * 32;
                } else {
                    /* There are no bins with a suitable block: Sequentially feed the required block */
                    LSequentialFeedFreeSize = MediumSequentialFeedBytesLeft;
                    if (LSequentialFeedFreeSize >= LBlockSize)
                    {
                        /* Block can be fed sequentially */
                        Result = (void*)(((DWORD_PTR)LastSequentiallyFedMediumBlock) - LBlockSize);
                        /* Store the last sequentially fed block */
                        LastSequentiallyFedMediumBlock = Result;
                        /* Store the remaining bytes */
                        MediumSequentialFeedBytesLeft = LSequentialFeedFreeSize - LBlockSize;
                        /* Set the flags for the block */
                        *DWORD_PTR_SUBOFS(Result, BlockHeaderSize) = LBlockSize | IsMediumBlockFlag;
                    } else {
                        /* Need to allocate a new sequential feed block */
                        Result = _FastMM_AllocNewSequentialFeedMediumPool(LBlockSize);
                    }
                    /* Done */
                    MediumBlocksLocked = 0; /* false */
                    return Result;
                }
            }
            /* If we get here we have a valid LBinGroupNumber and LBinNumber:
               Use the first block in the bin, splitting it if necessary */
            /* Get a pointer to the bin */
            LPMediumBin = &MediumBlockBins[LBinNumber];
            /* Get the result */
            Result = LPMediumBin->NextFreeBlock;
            /* Remove the block from the bin containing it */
            _FastMM_RemoveMediumFreeBlock(Result);
            /* Get the block size */
            LAvailableBlockSize = *DWORD_PTR_SUBOFS(Result, BlockHeaderSize) & DropMediumAndLargeFlagsMask;
            /* Is it an exact fit or not? */
            LSecondSplitSize = LAvailableBlockSize - LBlockSize;
            if (LSecondSplitSize != 0)
            {
                /* Split the block in two */
                LSecondSplit = (PMediumFreeBlock)(((DWORD_PTR)Result) + LBlockSize);
                /* Set the size of the second split */
                *DWORD_PTR_SUBOFS(LSecondSplit, BlockHeaderSize) =
                    LSecondSplitSize | (IsMediumBlockFlag | IsFreeBlockFlag);
                /* Store the size of the second split as the second last dword */
                *DWORD_PTR_OFS(LSecondSplit, LSecondSplitSize - 8) = LSecondSplitSize;
                /* Put the remainder in a bin if it is big enough */
                if (LSecondSplitSize >= MinimumMediumBlockSize)
                    _FastMM_InsertMediumBlockIntoBin(LSecondSplit, LSecondSplitSize);
            } else {
                /* Mark this block as used in the block following it */
                LNextMediumBlockHeader = (void*)(((DWORD_PTR)Result) + LBlockSize - BlockHeaderSize);
                *LNextMediumBlockHeader = *LNextMediumBlockHeader & ~PreviousMediumBlockIsFreeFlag;
            }
            /* Set the size and flags for this block */
            *DWORD_PTR_SUBOFS(Result, BlockHeaderSize) = LBlockSize | IsMediumBlockFlag;
            /* Unlock the medium blocks */
            MediumBlocksLocked = 0; /* false */
            return Result;
        } else {
            /* Allocate a Large block */
            if (Size > 0)
                return _FastMM_AllocateLargeBlock(Size);
            else
                return 0;
        }
    }
    return Result;
}
#else
extern void* __FASTCALL _FastMM_GetMem(int Size);
#endif

#ifdef USE_C_CODE
int __FASTCALL _FastMM_FreeMem(void *P)
{
    PMediumFreeBlock LNextMediumBlock, LPreviousMediumBlock;
    DWORD LNextMediumBlockSizeAndFlags;
    DWORD LBlockSize, LPreviousMediumBlockSize;
    PSmallBlockPoolHeader LPSmallBlockPool, LPPreviousPool, LPNextPool, LPOldFirstPool;
    PSmallBlockType LPSmallBlockType;
    void* LOldFirstFreeBlock;
    DWORD LBlockHeader;
    PMediumBlockPoolHeader LPPreviousMediumBlockPoolHeader, LPNextMediumBlockPoolHeader;

    /* Get the small block header: Is it actually a small block? */
    LBlockHeader = *DWORD_PTR_SUBOFS(P, BlockHeaderSize);
    /* Is it a small block that is in use? */
    if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag | IsLargeBlockFlag)) == 0)
    {
        /* Get a pointer to the block pool */
        LPSmallBlockPool = (PSmallBlockPoolHeader)LBlockHeader;
        /* Get the block type */
        LPSmallBlockType = LPSmallBlockPool->BlockType;
        /* Lock the block type */
        if (_FastMM_IsMultiThread)
            LockBlocks(&LPSmallBlockType->BlockTypeLocked);

        /* Get the old first free block */
        LOldFirstFreeBlock = LPSmallBlockPool->FirstFreeBlock;
        /* Was the pool manager previously full? */
        if (!LOldFirstFreeBlock)
        {
            /* Insert this as the first partially free pool for the block size */
            LPOldFirstPool = LPSmallBlockType->NextPartiallyFreePool;
            LPSmallBlockPool->NextPartiallyFreePool = LPOldFirstPool;
            LPOldFirstPool->PreviousPartiallyFreePool = LPSmallBlockPool;
            LPSmallBlockPool->PreviousPartiallyFreePool = (PSmallBlockPoolHeader)LPSmallBlockType;
            LPSmallBlockType->NextPartiallyFreePool = LPSmallBlockPool;
        }
        /* Store the old first free block */
        *DWORD_PTR_SUBOFS(P, BlockHeaderSize) = (DWORD_PTR)LOldFirstFreeBlock | IsFreeBlockFlag;
        /* Store this as the new first free block */
        LPSmallBlockPool->FirstFreeBlock = P;
        /* Decrement the number of allocated blocks */
        LPSmallBlockPool->BlocksInUse--;
        /* Small block pools are never freed in full debug mode. This increases the
           likehood of success in catching objects still being used after being
           destroyed. */
        /* Is the entire pool now free? -> Free it. */
        if (LPSmallBlockPool->BlocksInUse == 0)
        {
            /* Get the previous and next chunk managers */
            LPPreviousPool = LPSmallBlockPool->PreviousPartiallyFreePool;
            LPNextPool = LPSmallBlockPool->NextPartiallyFreePool;
            /* Remove this manager */
            LPPreviousPool->NextPartiallyFreePool = LPNextPool;
            LPNextPool->PreviousPartiallyFreePool = LPPreviousPool;
            /* Is this the sequential feed pool? If so, stop sequential feeding */
            if (LPSmallBlockType->CurrentSequentialFeedPool == LPSmallBlockPool)
                LPSmallBlockType->MaxSequentialFeedBlockAddress = 0;
            /* Unlock this block type */
            LPSmallBlockType->BlockTypeLocked = 0; /* false */
            /* No longer a small block pool in use (the flag must be reset in the
               pascal version, since IsSmallBlockPoolInUseFlag = IsLargeBlockFlag) */
            *DWORD_PTR_SUBOFS(LPSmallBlockPool, 4) =
                *DWORD_PTR_SUBOFS(LPSmallBlockPool, 4) & ~IsSmallBlockPoolInUseFlag;
            /* Release this pool */
            _FastMM_FreeMem(LPSmallBlockPool);
        } else {
            /* Unlock this block type */
            LPSmallBlockType->BlockTypeLocked = 0; /* false */
        }
        /* No error */
        return 0;
    } else {
        /* Is this a medium block or a large block? */
        if ((LBlockHeader & (IsFreeBlockFlag | IsLargeBlockFlag)) == 0)
        {
            /* Get the medium block size */
            LBlockSize = LBlockHeader & DropMediumAndLargeFlagsMask;
            /* Lock the medium blocks */
            LockMediumBlocks();
            /* Can we combine this block with the next free block? */
            LNextMediumBlock = (PMediumFreeBlock)((DWORD_PTR)P + LBlockSize);
            LNextMediumBlockSizeAndFlags = *DWORD_PTR_SUBOFS(LNextMediumBlock, BlockHeaderSize);
            if ((LNextMediumBlockSizeAndFlags & IsFreeBlockFlag) != 0)
            {
                /* Increase the size of this block */
                LBlockSize += LNextMediumBlockSizeAndFlags & DropMediumAndLargeFlagsMask;
                /* Remove the next block as well */
                if (LNextMediumBlockSizeAndFlags >= MinimumMediumBlockSize)
                    _FastMM_RemoveMediumFreeBlock(LNextMediumBlock);
            } else {
                /* Reset the "previous in use" flag of the next block */
                *DWORD_PTR_SUBOFS(LNextMediumBlock, BlockHeaderSize) =
                    LNextMediumBlockSizeAndFlags | PreviousMediumBlockIsFreeFlag;
            }
            /* Can we combine this block with the previous free block? We need to
               re-read the flags since it could have changed before we could lock the
               medium blocks. */
            if ((*DWORD_PTR_SUBOFS(P, BlockHeaderSize) & PreviousMediumBlockIsFreeFlag) != 0)
            {
                /* Get the size of the free block just before this one */
                LPreviousMediumBlockSize = *DWORD_PTR_SUBOFS(P, 8);
                /* Get the start of the previous block */
                LPreviousMediumBlock = (PMediumFreeBlock)(((DWORD_PTR)P) - LPreviousMediumBlockSize);
                /* Set the new block size */
                LBlockSize += LPreviousMediumBlockSize;
                /* This is the new current block */
                P = LPreviousMediumBlock;
                /* Remove the previous block from the linked list */
                if (LPreviousMediumBlockSize >= MinimumMediumBlockSize)
                    _FastMM_RemoveMediumFreeBlock(LPreviousMediumBlock);
            }
            /* Is the entire medium block pool free, and there are other free blocks
               that can fit the largest possible medium block? -> free it. (Except in
               full debug mode where medium pools are never freed.) */
            if (LBlockSize != (MediumBlockPoolSize - MediumBlockPoolHeaderSize))
            {
                /* Store the size of the block as well as the flags */
                *DWORD_PTR_SUBOFS(P, BlockHeaderSize) = LBlockSize | (IsMediumBlockFlag | IsFreeBlockFlag);
                /* Store the trailing size marker */
                *DWORD_PTR_OFS(P, LBlockSize - 8) = LBlockSize;
                /* Insert this block back into the bins: Size check not required here,
                   since medium blocks that are in use are not allowed to be
                   shrunk smaller than MinimumMediumBlockSize */
                _FastMM_InsertMediumBlockIntoBin(P, LBlockSize);
                /* Unlock medium blocks */
                MediumBlocksLocked = 0; /* false */
                /* All OK */
                return 0;
            } else {
                /* Should this become the new sequential feed? */
                if (MediumSequentialFeedBytesLeft != MediumBlockPoolSize - MediumBlockPoolHeaderSize)
                {
                    /* Bin the current sequential feed */
                    _FastMM_BinMediumSequentialFeedRemainder();
                    /* Set this medium pool up as the new sequential feed pool:
                    Store the sequential feed pool trailer */
                    *DWORD_PTR_OFS(P, LBlockSize - BlockHeaderSize) = IsMediumBlockFlag;
                    /* Store the number of bytes available in the sequential feed chunk */
                    MediumSequentialFeedBytesLeft = MediumBlockPoolSize - MediumBlockPoolHeaderSize;
                    /* Set the last sequentially fed block */
                    LastSequentiallyFedMediumBlock = (void*)((DWORD_PTR)P + LBlockSize);
                    /* Unlock medium blocks */
                    MediumBlocksLocked = 0; /* false */
                    /* Success */
                    return 0;
                } else {
                    /* Remove this medium block pool from the linked list */
                    P = (void*)((DWORD_PTR)P - MediumBlockPoolHeaderSize);
                    LPPreviousMediumBlockPoolHeader = ((PMediumBlockPoolHeader)P)->PreviousMediumBlockPoolHeader;
                    LPNextMediumBlockPoolHeader = ((PMediumBlockPoolHeader)P)->NextMediumBlockPoolHeader;
                    LPPreviousMediumBlockPoolHeader->NextMediumBlockPoolHeader = LPNextMediumBlockPoolHeader;
                    LPNextMediumBlockPoolHeader->PreviousMediumBlockPoolHeader = LPPreviousMediumBlockPoolHeader;
                    /* Unlock medium blocks */
                    MediumBlocksLocked = 0; /* false */
                    /* Free the medium block pool */
                    return (VirtualFree(P, 0, MEM_RELEASE)) ? 0 : -1;
                }
            }
        } else {
            /* Validate: Is this actually a Large block, or is it an attempt to free an
               already freed small block? */
            if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag)) == 0)
                return _FastMM_FreeLargeBlock(P);
            else
                return -1;
        }
    }
}
#else
extern int __FASTCALL _FastMM_FreeMem(void *P);
#endif

#ifdef USE_C_CODE

  /* Upsizes a large block in-place. The following variables are assumed correct:
     LBlockFlags, LOldAvailableSize, LPNextBlock, LNextBlockSizeAndFlags,
     LNextBlockSize, LNewAvailableSize. Medium blocks must be locked on entry if
     required. */
void __FASTCALL MediumBlockInPlaceUpsize(DWORD LNextBlockSizeAndFlags, DWORD LOldAvailableSize,
                                         DWORD LNewAvailableSize, DWORD LBlockFlags, int Size, void *LPNextBlock, void *P)
{
    DWORD LMinimumUpsize, LNewAllocSize, LNewBlockSize, LSecondSplitSize;
    void* LPNextBlockHeader;

    /* Remove the next block */
    if (LNextBlockSizeAndFlags >= MinimumMediumBlockSize)
        _FastMM_RemoveMediumFreeBlock(LPNextBlock);
    /* Add 25% for medium block in-place upsizes */
    LMinimumUpsize = LOldAvailableSize + (LOldAvailableSize >> 2);
    if ((DWORD)Size < LMinimumUpsize)
        LNewAllocSize = LMinimumUpsize;
    else
        LNewAllocSize = Size;
    /* Round up to the nearest block size granularity */
    LNewBlockSize = ((LNewAllocSize + (BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
        & (-MediumBlockGranularity)) + MediumBlockSizeOffset;
    /* Calculate the size of the second split */
    LSecondSplitSize = LNewAvailableSize + BlockHeaderSize - LNewBlockSize;
    /* Does it fit? */
    if ((int)LSecondSplitSize <= 0)
    {
        /* The block size is the full available size plus header */
        LNewBlockSize = LNewAvailableSize + BlockHeaderSize;
        /* Grab the whole block: Mark it as used in the block following it */
        LPNextBlockHeader = (void*)((DWORD_PTR)P + LNewAvailableSize);
        *((DWORD*)LPNextBlockHeader) =
            *((DWORD*)LPNextBlockHeader) & ~PreviousMediumBlockIsFreeFlag;
    } else {
        /* Split the block in two */
        LPNextBlock = (PMediumFreeBlock)((DWORD_PTR)P + LNewBlockSize);
        /* Set the size of the second split */
        *DWORD_PTR_SUBOFS(LPNextBlock, BlockHeaderSize) = LSecondSplitSize | (IsMediumBlockFlag | IsFreeBlockFlag);
        /* Store the size of the second split as the second last dword */
        *DWORD_PTR_OFS(LPNextBlock, LSecondSplitSize - 8) = LSecondSplitSize;
        /* Put the remainder in a bin if it is big enough */
        if (LSecondSplitSize >= MinimumMediumBlockSize)
            _FastMM_InsertMediumBlockIntoBin(LPNextBlock, LSecondSplitSize);
    }
    /* Set the size and flags for this block */
    *DWORD_PTR_SUBOFS(P, BlockHeaderSize) = LNewBlockSize | LBlockFlags;
}

/* In-place downsize of a medium block. On entry ANewSize must be less than half
of LOldAvailableSize. */
static void MediumBlockInPlaceDownsize(DWORD LNextBlockSizeAndFlags, DWORD LOldAvailableSize,
                                int Size, void *LPNextBlock, void *P)
{
    DWORD LNewBlockSize, LSecondSplitSize;

    /* Round up to the next medium block size */
    LNewBlockSize = ((Size + (BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
        & (-MediumBlockGranularity)) + MediumBlockSizeOffset;
    /* Get the size of the second split */
    LSecondSplitSize = (LOldAvailableSize + BlockHeaderSize) - LNewBlockSize;
    /* Lock the medium blocks */
    LockMediumBlocks();
    /* Set the new size */
    *DWORD_PTR_SUBOFS(P, BlockHeaderSize) =
        (*DWORD_PTR_SUBOFS(P, BlockHeaderSize) & ExtractMediumAndLargeFlagsMask)
        | LNewBlockSize;
    /* Is the next block in use? */
    LPNextBlock = DWORD_PTR_OFS(P, LOldAvailableSize + BlockHeaderSize);
    LNextBlockSizeAndFlags = *DWORD_PTR_SUBOFS(LPNextBlock, BlockHeaderSize);
    if ((LNextBlockSizeAndFlags & IsFreeBlockFlag) == 0)
    {
        /* The next block is in use: flag its previous block as free */
        *DWORD_PTR_SUBOFS(LPNextBlock, BlockHeaderSize) =
            LNextBlockSizeAndFlags | PreviousMediumBlockIsFreeFlag;
    } else {
        /* The next block is free: combine it */
        LNextBlockSizeAndFlags = LNextBlockSizeAndFlags & DropMediumAndLargeFlagsMask;
        LSecondSplitSize += LNextBlockSizeAndFlags;
        if (LNextBlockSizeAndFlags >= MinimumMediumBlockSize)
            _FastMM_RemoveMediumFreeBlock(LPNextBlock);
    }
    /* Set the split */
    LPNextBlock = DWORD_PTR_OFS(P, LNewBlockSize);
    /* Store the free part's header */
    *DWORD_PTR_SUBOFS(LPNextBlock, BlockHeaderSize) = LSecondSplitSize | (IsMediumBlockFlag | IsFreeBlockFlag);
    /* Store the trailing size field */
    *DWORD_PTR_OFS(LPNextBlock, LSecondSplitSize - 8) = LSecondSplitSize;
    /* Bin this free block */
    if (LSecondSplitSize >= MinimumMediumBlockSize)
        _FastMM_InsertMediumBlockIntoBin(LPNextBlock, LSecondSplitSize);
    /* Unlock the medium blocks */
    MediumBlocksLocked = 0; /* false */
}

void* __FASTCALL _FastMM_ReallocMem(void *P, int Size)
{
    DWORD LBlockHeader, LBlockFlags, LOldAvailableSize, LNewAllocSize,
        LNextBlockSizeAndFlags, LNextBlockSize, LNewAvailableSize, LMinimumUpsize,
        LSecondSPlitSize, LNewBlockSize;
    PSmallBlockType LPSmallBlockType;
    void *LPNextBlock, *LPNextBlockHeader;
    void *Result;

    /* Get the block header: Is it actually a small block? */
    LBlockHeader = *DWORD_PTR_SUBOFS(P, BlockHeaderSize);
    /* Is it a small block that is in use? */
    if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag | IsLargeBlockFlag)) == 0)
    {
        /* ----------------------------Small block------------------------------ */
        /* The block header is a pointer to the block pool: Get the block type */
        LPSmallBlockType = ((PSmallBlockPoolHeader)LBlockHeader)->BlockType;
        /* Get the available size inside blocks of this type. */
        LOldAvailableSize = LPSmallBlockType->BlockSize - BlockHeaderSize;
        /* Is it an upsize or a downsize? */
        if (LOldAvailableSize >= (DWORD)Size)
        {
            /* It's a downsize. Do we need to allocate a smaller block? Only if the new
               block size is less than a quarter of the available size less
               SmallBlockDownsizeCheckAdder bytes */
            if (((DWORD)Size * 4 + SmallBlockDownsizeCheckAdder) >= LOldAvailableSize)
            {
                /* In-place downsize - return the pointer */
                return P;
            } else {
                /* Allocate a smaller block */
                Result = _FastMM_GetMem(Size);
                /* Allocated OK? */
                if (Result)
                {
                    /* Move the data across */
#ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
                    _FastMM_MoveX8L4(P, Result, (int)Size);
#else
                    _internal_memmove(P, Result, (int)Size);
#endif
                    /* Free the old pointer */
                    _FastMM_FreeMem(P);
                }
                return Result;
            }
        } else {
            /* This pointer is being reallocated to a larger block and therefore it is
               logical to assume that it may be enlarged again. Since reallocations are
               expensive, there is a minimum upsize percentage to avoid unnecessary
               future move operations. */
            /* Must grow with at least 100% + x bytes */
            LNewAllocSize = LOldAvailableSize * 2 + SmallBlockUpsizeAdder;
            /* Still not large enough? */
            if (LNewAllocSize < (DWORD)Size)
                LNewAllocSize = Size;
            /* Allocate the new block */
            Result = _FastMM_GetMem(LNewAllocSize);
            /* Allocated OK? */
            if (Result)
            {
                /* Do we need to store the requested size? Only large blocks store the
                requested size. */
                if (LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize))
                    ((PLargeBlockHeader)((DWORD_PTR)Result - LargeBlockHeaderSize))->UserAllocatedSize = Size;
                /* Move the data across */
#ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
                LPSmallBlockType->UpsizeMoveProcedure(P, Result, (int)LOldAvailableSize);
#else
                _internal_memmove(P, Result, (int)LOldAvailableSize);
#endif
                /* Free the old pointer */
                _FastMM_FreeMem(P);
            }
            return Result;
        }
    } else {
        /* Is this a medium block or a large block? */
        if ((LBlockHeader & (IsFreeBlockFlag | IsLargeBlockFlag)) == 0)
        {
            /* -------------------------Medium block------------------------------ */
            /* What is the available size in the block being reallocated? */
            LOldAvailableSize = (LBlockHeader & DropMediumAndLargeFlagsMask);
            /* Get a pointer to the next block */
            LPNextBlock = DWORD_PTR_OFS(P, LOldAvailableSize);
            /* Subtract the block header size from the old available size */
            LOldAvailableSize -= BlockHeaderSize;
            /* Is it an upsize or a downsize? */
            if ((DWORD)Size > LOldAvailableSize)
            {
                /* Can we do an in-place upsize? */
                LNextBlockSizeAndFlags = *DWORD_PTR_SUBOFS(LPNextBlock, BlockHeaderSize);
                /* Is the next block free? */
                if ((LNextBlockSizeAndFlags & IsFreeBlockFlag) != 0)
                {
                    LNextBlockSize = LNextBlockSizeAndFlags & DropMediumAndLargeFlagsMask;
                    /* The available size including the next block */
                    LNewAvailableSize = LOldAvailableSize + LNextBlockSize;
                    /* Can the block fit? */
                    if ((DWORD)Size <= LNewAvailableSize)
                    {
                        /* The next block is free and there is enough space to grow this
                           block in place. */
                        if (_FastMM_IsMultiThread)
                        {
                            /* Multi-threaded application - lock medium blocks and re-read the
                               information on the blocks. */
                            LockMediumBlocks();
                            /* Re-read the info for this block */
                            LBlockFlags = *DWORD_PTR_SUBOFS(P, BlockHeaderSize) & ExtractMediumAndLargeFlagsMask;
                            /* Re-read the info for the next block */
                            LNextBlockSizeAndFlags = *DWORD_PTR_SUBOFS(LPNextBlock, BlockHeaderSize);
                            /* Recalculate the next block size */
                            LNextBlockSize = LNextBlockSizeAndFlags & DropMediumAndLargeFlagsMask;
                            /* The available size including the next block */
                            LNewAvailableSize = LOldAvailableSize + LNextBlockSize;
                            /* Is the next block still free and the size still sufficient? */
                            if (((LNextBlockSizeAndFlags & IsFreeBlockFlag) != 0)
                                && ((DWORD)Size <= LNewAvailableSize))
                            {
                                /* Upsize the block in-place */
                                MediumBlockInPlaceUpsize(LNextBlockSizeAndFlags, LOldAvailableSize, LNewAvailableSize,
                                    LBlockFlags, Size, LPNextBlock, P);
                                /* Unlock the medium blocks */
                                MediumBlocksLocked = 0; /* false */
                                /* Return the result */
                                return P;
                            }
                            /* Couldn't use the block: Unlock the medium blocks */
                            MediumBlocksLocked = 0; /* false */
                        } else {
                            /* Extract the block flags */
                            LBlockFlags = ExtractMediumAndLargeFlagsMask & LBlockHeader;
                            /* Upsize the block in-place */
                            MediumBlockInPlaceUpsize(LNextBlockSizeAndFlags, LOldAvailableSize, LNewAvailableSize,
                                LBlockFlags, Size, LPNextBlock, P);
                            /* Return the result */
                            return P;
                        }
                    }
                }
                /* Couldn't upsize in place. Grab a new block and move the data across:
                   If we have to reallocate and move medium blocks, we grow by at
                   least 25% */
                LMinimumUpsize = LOldAvailableSize + (LOldAvailableSize >> 2);
                if ((DWORD)Size < LMinimumUpsize)
                    LNewAllocSize = LMinimumUpsize;
                else
                    LNewAllocSize = Size;
                /* Allocate the new block */
                Result = _FastMM_GetMem(LNewAllocSize);
                if (Result)
                {
                    /* If its a Large block - store the actual user requested size */
                    if (LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize))
                        ((PLargeBlockHeader)(((DWORD_PTR)Result) - LargeBlockHeaderSize))->UserAllocatedSize = Size;
                    /* Move the data across */
#ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
                    _FastMM_MoveX16L4(P, Result, (int)LOldAvailableSize);
#else
                    _internal_memmove(P, Result, (int)LOldAvailableSize);
#endif
                    /* Free the old block */
                    _FastMM_FreeMem(P);
                }
                return Result;
            } else {
                /* Must be less than half the current size or we don't bother resizing. */
                if ((DWORD)(Size * 2) >= LOldAvailableSize)
                {
                    return P;
                } else {
                    /* In-place downsize? Balance the cost of moving the data vs. the cost of
                       fragmenting the memory pool. Medium blocks in use may never be smaller
                       than MinimumMediumBlockSize. */
                    if (Size >= (MinimumMediumBlockSize - BlockHeaderSize))
                    {
                        MediumBlockInPlaceDownsize(LNextBlockSizeAndFlags, LOldAvailableSize, Size, LPNextBlock, P);
                        return P;
                    } else {
                        /* The requested size is less than the minimum medium block size. If
                           the requested size is less than the threshold value (currently a
                           quarter of the minimum medium block size), move the data to a small
                           block, otherwise shrink the medium block to the minimum allowable
                           medium block size. */
                        if ((DWORD)Size >= MediumInPlaceDownsizeLimit)
                        {
                            /* The request is for a size smaller than the minimum medium block
                               size, but not small enough to justify moving data: Reduce the
                               block size to the minimum medium block size */
                            Size = MinimumMediumBlockSize - BlockHeaderSize;
                            /* Is it already at the minimum medium block size? */
                            if (LOldAvailableSize > (DWORD)Size)
                                MediumBlockInPlaceDownsize(LNextBlockSizeAndFlags, LOldAvailableSize, Size, LPNextBlock, P);
                            return P;
                        } else {
                            /* Allocate the new block */
                            Result = _FastMM_GetMem(Size);
                            if (Result)
                            {
                                /* Move the data across */
#ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
                                _FastMM_MoveX8L4(P, Result, Size);
#else
                                _internal_memmove(P, Result, Size);
#endif
                                /* Free the old block */
                                _FastMM_FreeMem(P);
                            }
                            return Result;
                        }
                    }
                }
            }
        } else {
            /* Is this a valid large block? */
            if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag)) == 0)
            {
                /* -----------------------Large block------------------------------ */
                return _FastMM_ReallocateLargeBlock(P, Size);
            } else {
                /* -----------------------Invalid block------------------------------ */
                /* Bad pointer: probably an attempt to reallocate a free memory block. */
                return 0;
            }
        }
    }
}
#else
extern void* __FASTCALL _FastMM_ReallocMem(void *P, int Size);
#endif

/* Allocates a block and fills it with zeroes */
#ifdef USE_C_CODE
void* __FASTCALL _FastMM_AllocMem(int Size)
{
  void *Result = _FastMM_GetMem(Size);
  /* Large blocks are already zero filled */
  if (Result && (Size <= (MaximumMediumBlockSize - BlockHeaderSize)))
    memset(Result, 0, (size_t)Size);
  return Result;
}
#else
extern void* __FASTCALL _FastMM_AllocMem(int Size);
#endif

/* ----------Leak Checking and State Reporting Support Functions------------ */

/* Advances to the next medium block. Returns nil if the end of the medium block
 pool has been reached */
static void* __FASTCALL NextMediumBlock(void* APMediumBlock)
{
    DWORD LBlockSize;
    void* Result;

    /* Get the size of this block */
    LBlockSize = *DWORD_PTR_SUBOFS(APMediumBlock, 4) & DropMediumAndLargeFlagsMask;
    /* Advance the pointer */
    Result = DWORD_PTR_OFS(APMediumBlock, LBlockSize);
    /* Is the next block the end of medium pool marker? */
    LBlockSize = *DWORD_PTR_SUBOFS(Result, 4) & DropMediumAndLargeFlagsMask;
    if (LBlockSize == 0)
        return 0;
    return Result;
}

/* Gets the first medium block in the medium block pool */
static void* __FASTCALL GetFirstMediumBlockInPool(PMediumBlockPoolHeader APMediumBlockPoolHeader)
{
    if (MediumSequentialFeedBytesLeft == 0
        || ((DWORD)LastSequentiallyFedMediumBlock < (DWORD)APMediumBlockPoolHeader)
        || ((DWORD)LastSequentiallyFedMediumBlock > (DWORD)APMediumBlockPoolHeader + MediumBlockPoolSize))
    {
        return DWORD_PTR_OFS(APMediumBlockPoolHeader, MediumBlockPoolHeaderSize);
    } else {
        /* Is the sequential feed pool empty? */
        if (MediumSequentialFeedBytesLeft != MediumBlockPoolSize - MediumBlockPoolHeaderSize)
          return LastSequentiallyFedMediumBlock;
        return 0;
    }
}

/* Gets the first and last block pointer for a small block pool */
static void __FASTCALL GetFirstAndLastSmallBlockInPool(PSmallBlockPoolHeader APSmallBlockPool,
  void* *AFirstPtr, void* *ALastPtr)
{
    DWORD LBlockSize;

    /* Get the pointer to the first block */
    *AFirstPtr = DWORD_PTR_OFS(APSmallBlockPool, SmallBlockPoolHeaderSize);
    /* Get a pointer to the last block */
    if ((APSmallBlockPool->BlockType->CurrentSequentialFeedPool != APSmallBlockPool)
        || ((DWORD)(APSmallBlockPool->BlockType->NextSequentialFeedBlockAddress) > (DWORD)(APSmallBlockPool->BlockType->MaxSequentialFeedBlockAddress)))
    {
        /* Not the sequential feed - point to the end of the block */
        LBlockSize = *DWORD_PTR_SUBOFS(APSmallBlockPool, 4) & DropMediumAndLargeFlagsMask;
        *ALastPtr = DWORD_PTR_OFS(APSmallBlockPool, LBlockSize - APSmallBlockPool->BlockType->BlockSize);
    } else {
        /* The sequential feed pool - point to before the next sequential feed block */
        *ALastPtr = DWORD_PTR_SUBOFS(APSmallBlockPool->BlockType->NextSequentialFeedBlockAddress, 1);
    }
}
/* --------------------Memory Leak Checking and Reporting------------------- */

#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE
/* Converts a cardinal to string at the buffer location, returning the new
   buffer position. */
extern char* __FASTCALL _FastMM_CardinalToStrBuf(unsigned int ACardinal, char *ABuffer);

/* Appends the source text to the destination and returns the new destination
   position */
static char* __FASTCALL AppendStringToBuffer(const char *ASource, const char *ADestination, unsigned int ACount)
{
    return ((char*)memcpy(ADestination, ASource, (unsigned int)ACount) + ACount);
}

/* Locks the expected leaks. Returns false if the list could not be allocated. */
static int __FASTCALL LockExpectedMemoryLeaksList(void)
{
    /* Lock the expected leaks list */
    if (_FastMM_IsMultiThread)
    {
        while (_FastMM_LockCmpxchg(0, 1, &ExpectedMemoryLeaksListLocked) != 0)
        {
            if (!_FastMM_NeverSleepOnMMThreadContention)
            {
                Sleep(InitialSleepTime);
                if (_FastMM_LockCmpxchg(0, 1, &ExpectedMemoryLeaksListLocked) == 0)
                    break;
                Sleep(AdditionalSleepTime);
            }
        }
    }
    /* Allocate the list if it does not exist */
    if (!ExpectedMemoryLeaks)
        ExpectedMemoryLeaks = VirtualAlloc(0, ExpectedMemoryLeaksListSize, MEM_COMMIT, PAGE_READWRITE);
    /* Done */
    return ExpectedMemoryLeaks != 0;
}
#endif

/* Registers expected memory leaks. Returns true on success. The list of leaked
 blocks is limited, so failure is possible if the list is full. */
int __FASTCALL RegisterExpectedMemoryLeak(void *P)
{
#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE
    if (LockExpectedMemoryLeaksList &&
        (ExpectedMemoryLeaks->NumExpectedLeaks < (sizeof(ExpectedMemoryLeaks->ExpectedLeaks) / sizeof(void*))))
    {
        ExpectedMemoryLeaks->ExpectedLeaks[ExpectedMemoryLeaks->NumExpectedLeaks] = P;
        ExpectedMemoryLeaks->NumExpectedLeaks++;
        return 1; /* true */
    }
    ExpectedMemoryLeaksListLocked = 0; /* false */
#endif
    return 0; /* false */
}

int __FASTCALL UnregisterExpectedMemoryLeak(void *P)
{
#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE
    unsigned int LIndex;

    if (ExpectedMemoryLeaks && LockExpectedMemoryLeaksList)
    {
        for (LIndex = 0; LIndex < ExpectedMemoryLeaks->NumExpectedLeaks; LIndex++)
        {
            if (ExpectedMemoryLeaks->ExpectedLeaks[LIndex] == P)
            {
                ExpectedMemoryLeaks->ExpectedLeaks[LIndex] =
                    ExpectedMemoryLeaks->ExpectedLeaks[ExpectedMemoryLeaks->NumExpectedLeaks - 1];
                ExpectedMemoryLeaks->NumExpectedLeaks--;
                ExpectedMemoryLeaksListLocked = 0; /* false */
                return 1; /* true */
            }
        }
        ExpectedMemoryLeaksListLocked = 0; /* false */
    }
#endif
    /* Default to error */
    return 0; /* false */
}

#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE


#define LMediumAndLargeBlockLeaksLength 4096
#define LLeakMessageLength 32768

typedef struct
{
    unsigned long NumLeaks;
} TLeakedBlock, *PLeakedBlock;

/* Leak statistics for a small block type */
typedef TLeakedBlock TSmallBlockLeaks[NumSmallBlockTypes];

/* Checks the small block pool for leaks. */
static void __FASTCALL CheckSmallBlockPoolForLeaks(PSmallBlockPoolHeader APSmallBlockPool,
  TLeakedBlock *LSmallBlockLeaks, char *LExpectedLeaksOnly)
{
    void *LCurPtr, *LEndPtr;
    unsigned long LBlockTypeIndex;
    PLeakedBlock LPLeakedBlock;

    /* Get the block type index */
    LBlockTypeIndex = ((DWORD_PTR)(APSmallBlockPool->BlockType) - (DWORD_PTR)(&SmallBlockTypes[0])) / sizeof(TSmallBlockType);
    LPLeakedBlock = &LSmallBlockLeaks[LBlockTypeIndex];
    /* Get the first and last pointer for the pool */
    GetFirstAndLastSmallBlockInPool(APSmallBlockPool, &LCurPtr, &LEndPtr);
    /* Step through all blocks */
    while ((DWORD_PTR)LCurPtr <= (DWORD_PTR)LEndPtr)
    {
        /* Is this block an unexpected leak? */
        if (((*DWORD_PTR_SUBOFS(LCurPtr, 4) & IsFreeBlockFlag) == 0)
            && !UnregisterExpectedMemoryLeak(LCurPtr))
        {
            *LExpectedLeaksOnly = 0; /* false */
            /* Add to the number of leaks for the class */
            LPLeakedBlock->NumLeaks++;
        }
        /* Next block */
        LCurPtr = DWORD_PTR_OFS(LCurPtr, APSmallBlockPool->BlockType->BlockSize);
    }
}

/* Checks for memory leaks on shutdown */
static void __FASTCALL ScanForMemoryLeaks(void)
{
    /* The leaked classes for small blocks */
    TSmallBlockLeaks LSmallBlockLeaks;
    /* A leaked medium or large block */
    unsigned long LMediumAndLargeBlockLeaks[LMediumAndLargeBlockLeaksLength];
    int LNumMediumAndLargeLeaks;
    PLargeBlockHeader LPLargeBlock;
    char LLeakMessage[LLeakMessageLength];
    char *LMsgPtr;
    char LExpectedLeaksOnly, LSmallLeakHeaderAdded;
    int LBlockTypeInd, LBlockInd;
    unsigned long LMediumBlockSize, LLargeBlockSize, LPreviousBlockSize, LThisBlockSize;
    void *LPMediumBlock;
    PMediumBlockPoolHeader LPMediumBlockPoolHeader;
    unsigned long LMediumBlockHeader;

    /* Clear the leak arrays */
    memset(LSmallBlockLeaks, 0, sizeof(LSmallBlockLeaks));
    memset(LMediumAndLargeBlockLeaks, 0, sizeof(LMediumAndLargeBlockLeaks));
    /* Step through all the medium block pools */
    LNumMediumAndLargeLeaks = 0;
    /* No unexpected leaks so far */
    LExpectedLeaksOnly = 1; /* true */
    /* Step through all the medium block pools */
    LPMediumBlockPoolHeader = MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
    while (LPMediumBlockPoolHeader != &MediumBlockPoolsCircularList)
    {
        LPMediumBlock = GetFirstMediumBlockInPool(LPMediumBlockPoolHeader);
        while (LPMediumBlock)
        {
            LMediumBlockHeader = *DWORD_PTR_SUBOFS(LPMediumBlock, 4);
            /* Is the block in use? */
            if ((LMediumBlockHeader & IsFreeBlockFlag) == 0)
            {
                if ((LMediumBlockHeader & IsSmallBlockPoolInUseFlag) != 0)
                {
                    /* Get all the leaks for the small block pool */
                    CheckSmallBlockPoolForLeaks(LPMediumBlock, LSmallBlockLeaks, &LExpectedLeaksOnly);
                } else {
                    if (LNumMediumAndLargeLeaks < LMediumAndLargeBlockLeaksLength)
                    {
                        LMediumBlockSize = (LMediumBlockHeader & DropMediumAndLargeFlagsMask) - BlockHeaderSize;
                        /* Is it an expected leak? */
                        if (!UnregisterExpectedMemoryLeak(LPMediumBlock))
                        {
                            LExpectedLeaksOnly = 0; /* false */
                            /* Add the leak to the list */
                            LMediumAndLargeBlockLeaks[LNumMediumAndLargeLeaks] = LMediumBlockSize;
                            LNumMediumAndLargeLeaks++;
                        }
                    }
                }
            }
            /* Next medium block */
            LPMediumBlock = NextMediumBlock(LPMediumBlock);
        }
        /* Get the next medium block pool */
        LPMediumBlockPoolHeader = LPMediumBlockPoolHeader->NextMediumBlockPoolHeader;
    }
    /* Get all leaked large blocks */
    LPLargeBlock = LargeBlocksCircularList.NextLargeBlockHeader;
    while ((LPLargeBlock != &LargeBlocksCircularList)
        && (LNumMediumAndLargeLeaks < LMediumAndLargeBlockLeaksLength))
    {
        /* Is it an expected leak? */
        if (!UnregisterExpectedMemoryLeak(DWORD_PTR_OFS(LPLargeBlock, LargeBlockHeaderSize)))
        {
            /* Add the leak */
            LExpectedLeaksOnly = 0; /* false */
            LLargeBlockSize = (LPLargeBlock->BlockSizeAndFlags & DropMediumAndLargeFlagsMask)
                - BlockHeaderSize - LargeBlockHeaderSize;
            LMediumAndLargeBlockLeaks[LNumMediumAndLargeLeaks] = LLargeBlockSize;
            LNumMediumAndLargeLeaks++;
        }
        /* Get the next large block */
        LPLargeBlock = LPLargeBlock->NextLargeBlockHeader;
    }
    /* Display the leak message if required */
    if (!LExpectedLeaksOnly)
    {
        /* Small leak header has not been added */
        LSmallLeakHeaderAdded = 0; /* false */
        LPreviousBlockSize = 0;
        /* Set up the leak message header so long */
        LMsgPtr = AppendStringToBuffer(LeakMessageHeader, &LLeakMessage[0], strlen(LeakMessageHeader));
        /* Step through all the small block types */
        for (LBlockTypeInd = 0; LBlockTypeInd < NumSmallBlockTypes; LBlockTypeInd++)
        {
            LThisBlockSize = SmallBlockTypes[LBlockTypeInd].BlockSize - BlockHeaderSize;
            /* Any leaks? */
            /* Is there still space in the message buffer? Reserve space for the message
             footer. */
            if (LMsgPtr > &LLeakMessage[(LLeakMessageLength - 1) - 2048])
              break;
            /* Check the count */
            if (LSmallBlockLeaks[LBlockTypeInd].NumLeaks > 0)
            {
                /* Need to add the header? */
                if (!LSmallLeakHeaderAdded)
                {
                    LMsgPtr = AppendStringToBuffer(SmallLeakDetail, LMsgPtr, strlen(SmallLeakDetail));
                    LSmallLeakHeaderAdded = 1; /* true */
                }
                /* Need to add the size header? */
                *LMsgPtr++ = '\n';
                LMsgPtr = _FastMM_CardinalToStrBuf(LPreviousBlockSize + 1, LMsgPtr);
                *LMsgPtr++ = ' ';
                *LMsgPtr++ = '-';
                *LMsgPtr++ = ' ';
                LMsgPtr = _FastMM_CardinalToStrBuf(LThisBlockSize, LMsgPtr);
                LMsgPtr = AppendStringToBuffer(BytesMessage, LMsgPtr, strlen(BytesMessage));
                /* Show the count */
                LMsgPtr = AppendStringToBuffer(UnknownClassNameMsg, LMsgPtr, strlen(UnknownClassNameMsg));
                /* Add the count */
                *LMsgPtr++ = ' ';
                *LMsgPtr++ = 'x';
                *LMsgPtr++ = ' ';
                LMsgPtr = _FastMM_CardinalToStrBuf(LSmallBlockLeaks[LBlockTypeInd].NumLeaks, LMsgPtr);
            }
            LPreviousBlockSize = LThisBlockSize;
        }
        /* Add the medium/large block leak message */
        if (LNumMediumAndLargeLeaks > 0)
        {
            /* Any non-small leaks? */
            if (LSmallLeakHeaderAdded)
            {
                *LMsgPtr++ = '\n';
                *LMsgPtr++ = '\n';
            }
            /* Add the medium/large block leak message */
            LMsgPtr = AppendStringToBuffer(LargeLeakDetail, LMsgPtr, strlen(LargeLeakDetail));
            /* List all the blocks */
            for (LBlockInd = 0; LBlockInd < LNumMediumAndLargeLeaks; LBlockInd++)
            {
                if (LBlockInd != 0)
                {
                    *LMsgPtr++ = ',';
                    *LMsgPtr++ = ' ';
                }
                LMsgPtr = _FastMM_CardinalToStrBuf(LMediumAndLargeBlockLeaks[LBlockInd], LMsgPtr);
                /* Is there still space in the message buffer? Reserve space for the
                   message footer. */
                if (LMsgPtr > &LLeakMessage[(LLeakMessageLength - 1) - 2048])
                    break;
            }
        }
        /* Set the message footer */
        AppendStringToBuffer(LeakMessageFooter, LMsgPtr, strlen(LeakMessageFooter));
        /* Show the message */
        MessageBoxA(0, LLeakMessage, LeakMessageTitle, MB_OK | MB_ICONERROR | MB_TASKMODAL);
    }
}

#undef LMediumAndLargeBlockLeaksLength
#undef LLeakMessageLength

#endif

/* -------------Memory Manager and Memory Usage Stats Reporting------------- */

/* Returns statistics about the current state of the memory manager */
void __FASTCALL _FastMM_GetMemoryManagerState(TMemoryManagerState* AMemoryManagerState)
{
    PMediumBlockPoolHeader LPMediumBlockPoolHeader;
    void* LPMediumBlock;
    int LInd;
    DWORD LBlockTypeIndex, LMediumBlockSize, LMediumBlockHeader, LLargeBlockSize;
    PLargeBlockHeader LPLargeBlock;

    /* Clear the results */
    memset(AMemoryManagerState, 0, sizeof(TMemoryManagerState));
    /* Set the small block size stats */
    for (LInd = 0; LInd < NumSmallBlockTypes; LInd++)
    {
        AMemoryManagerState->SmallBlockTypeStates[LInd].InternalBlockSize =
          SmallBlockTypes[LInd].BlockSize;
        AMemoryManagerState->SmallBlockTypeStates[LInd].UseableBlockSize =
          SmallBlockTypes[LInd].BlockSize - BlockHeaderSize;
        if ((int)(AMemoryManagerState->SmallBlockTypeStates[LInd].UseableBlockSize) < 0)
          AMemoryManagerState->SmallBlockTypeStates[LInd].UseableBlockSize = 0;
    }
    /* Lock all small block types */
    LockAllSmallBlockTypes();
    /* Lock the medium blocks */
    LockMediumBlocks();
    /* Step through all the medium block pools */
    LPMediumBlockPoolHeader = MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
    while (LPMediumBlockPoolHeader != &MediumBlockPoolsCircularList)
    {
        /* Add to the medium block used space */
        AMemoryManagerState->ReservedMediumBlockAddressSpace += MediumBlockPoolSize;
        LPMediumBlock = GetFirstMediumBlockInPool(LPMediumBlockPoolHeader);
        while (LPMediumBlock)
        {
            LMediumBlockHeader = *DWORD_PTR_SUBOFS(LPMediumBlock, 4);
            /* Is the block in use? */
            if ((LMediumBlockHeader & IsFreeBlockFlag) == 0)
            {
                /* Get the block size */
                LMediumBlockSize = LMediumBlockHeader & DropMediumAndLargeFlagsMask;
                if ((LMediumBlockHeader & IsSmallBlockPoolInUseFlag) != 0)
                {
                    /* Get the block type index */
                    LBlockTypeIndex = ((DWORD)(((PSmallBlockPoolHeader)LPMediumBlock)->BlockType)
                      - (DWORD_PTR)(&SmallBlockTypes[0])) / sizeof(TSmallBlockType);
                    /* Subtract from medium block usage */
                    AMemoryManagerState->ReservedMediumBlockAddressSpace -= LMediumBlockSize;
                    /* Add it to the reserved space for the block size */
                    AMemoryManagerState->SmallBlockTypeStates[LBlockTypeIndex].ReservedAddressSpace += LMediumBlockSize;
                    /* Add the usage for the pool */
                    AMemoryManagerState->SmallBlockTypeStates[LBlockTypeIndex].AllocatedBlockCount +=
                      ((PSmallBlockPoolHeader)LPMediumBlock)->BlocksInUse;
                } else {
                    AMemoryManagerState->AllocatedMediumBlockCount++;
                    AMemoryManagerState->TotalAllocatedMediumBlockSize += LMediumBlockSize - BlockHeaderSize;
                }
            }
            /* Next medium block */
            LPMediumBlock = NextMediumBlock(LPMediumBlock);
        }
        /* Get the next medium block pool */
        LPMediumBlockPoolHeader = LPMediumBlockPoolHeader->NextMediumBlockPoolHeader;
    }

    /* Unlock medium blocks */
    MediumBlocksLocked = 0; /* false */
    /* Unlock all the small block types */
    for (LInd = 0; LInd < NumSmallBlockTypes; LInd++)
        SmallBlockTypes[LInd].BlockTypeLocked = 0; /* false */
    /* Step through all the large blocks */
    LockLargeBlocks();
    LPLargeBlock = LargeBlocksCircularList.NextLargeBlockHeader;
    while (LPLargeBlock != &LargeBlocksCircularList)
    {
        LLargeBlockSize = LPLargeBlock->BlockSizeAndFlags & DropMediumAndLargeFlagsMask;
        AMemoryManagerState->AllocatedLargeBlockCount++;
        AMemoryManagerState->ReservedLargeBlockAddressSpace += LLargeBlockSize;
        AMemoryManagerState->TotalAllocatedLargeBlockSize += LPLargeBlock->UserAllocatedSize;
        /* Get the next large block */
        LPLargeBlock = LPLargeBlock->NextLargeBlockHeader;
    }
    LargeBlocksLocked = 0; /* false */
}

/* Gets the state of every 64K block in the 4GB address space */
void __FASTCALL _FastMM_GetMemoryMap(TMemoryMap AMemoryMap)
{
    PMediumBlockPoolHeader LPMediumBlockPoolHeader;
    PLargeBlockHeader LPLargeBlock;
    unsigned long LLargeBlockSize, LChunkIndex, LInd;
    MEMORY_BASIC_INFORMATION LMBI;

    /* Clear the map */
    memset(AMemoryMap, csUnallocated, sizeof(TMemoryMap));
    /* Step through all the medium block pools */
    LockMediumBlocks();
    LPMediumBlockPoolHeader = MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
    while (LPMediumBlockPoolHeader != &MediumBlockPoolsCircularList)
    {
        /* Add to the medium block used space */
        LChunkIndex = ((DWORD_PTR)LPMediumBlockPoolHeader) >> 16;
        for (LInd = 0; LInd < (MediumBlockPoolSize >> 16); LInd++)
            AMemoryMap[LChunkIndex + LInd] = csAllocated;
        /* Get the next medium block pool */
        LPMediumBlockPoolHeader = LPMediumBlockPoolHeader->NextMediumBlockPoolHeader;
    }
    MediumBlocksLocked = 0; /* false */
    /* Step through all the large blocks */
    LockLargeBlocks();
    LPLargeBlock = LargeBlocksCircularList.NextLargeBlockHeader;
    while (LPLargeBlock != &LargeBlocksCircularList)
    {
        LChunkIndex = ((DWORD_PTR)LPLargeBlock) >> 16;
        LLargeBlockSize = LPLargeBlock->BlockSizeAndFlags & DropMediumAndLargeFlagsMask;
        for (LInd = 0; LInd < (LLargeBlockSize >> 16); LInd++)
            AMemoryMap[LChunkIndex + LInd] = csAllocated;
        /* Get the next large block */
        LPLargeBlock = LPLargeBlock->NextLargeBlockHeader;
    }
    LargeBlocksLocked = 0; /* false */
    /* Fill in the rest of the map */
    for (LInd = 0; LInd < 65536; LInd++)
    {
        /* If the chunk is not allocated by this MM, what is its status? */
        if (AMemoryMap[LInd] == csUnallocated)
        {
            /* Get all the reserved memory blocks and windows allocated memory blocks, etc. */
            VirtualQuery((void*)(LInd * 65536), &LMBI, sizeof(LMBI));
            if (LMBI.State == MEM_COMMIT)
                AMemoryMap[LInd] = csSysAllocated;
            else if (LMBI.State == MEM_RESERVE)
                AMemoryMap[LInd] = csSysReserved;
        }
    }
}

/* Returns summarised information about the state of the memory manager. */
THeapStatus __FASTCALL _FastMM_GetHeapStatus(void)
{
    PMediumBlockPoolHeader LPMediumBlockPoolHeader;
    void *LPMediumBlock;
    unsigned long LBlockTypeIndex, LMediumBlockSize, LMediumBlockHeader, LLargeBlockSize,
    LSmallBlockUsage, LSmallBlockOverhead;
    int LInd;
    PLargeBlockHeader LPLargeBlock;
    THeapStatus Result;

    /* Clear the structure */
    memset(&Result, 0, sizeof(Result));
    /* Lock all small block types */
    LockAllSmallBlockTypes();
    /* Lock the medium blocks */
    LockMediumBlocks();
    /* Step through all the medium block pools */
    LPMediumBlockPoolHeader = MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
    while (LPMediumBlockPoolHeader != &MediumBlockPoolsCircularList)
    {
        /* Add to the total and committed address space */
        Result.TotalAddrSpace += ((MediumBlockPoolSize + 0xffff) & 0xffff0000);
        Result.TotalCommitted += ((MediumBlockPoolSize + 0xffff) & 0xffff0000);
        /* Add the medium block pool overhead */
        Result.Overhead += (((MediumBlockPoolSize + 0xffff) & 0xffff0000)
          - MediumBlockPoolSize + MediumBlockPoolHeaderSize);
        /* Get the first medium block in the pool */
        LPMediumBlock = GetFirstMediumBlockInPool(LPMediumBlockPoolHeader);
        while (LPMediumBlock)
        {
            /* Get the block header */
            LMediumBlockHeader = *DWORD_PTR_SUBOFS(LPMediumBlock, 4);
            /* Get the block size */
            LMediumBlockSize = LMediumBlockHeader & DropMediumAndLargeFlagsMask;
            /* Is the block in use? */
            if ((LMediumBlockHeader & IsFreeBlockFlag) == 0)
            {
                if ((LMediumBlockHeader & IsSmallBlockPoolInUseFlag) != 0)
                {
                    /* Get the block type index */
                    LBlockTypeIndex = ((DWORD)(((PSmallBlockPoolHeader)LPMediumBlock)->BlockType)
                      - ((DWORD_PTR)&SmallBlockTypes[0])) / sizeof(TSmallBlockType);
                    /* Get the usage in the block */
                    LSmallBlockUsage = ((PSmallBlockPoolHeader)LPMediumBlock)->BlocksInUse
                      * SmallBlockTypes[LBlockTypeIndex].BlockSize;
                    /* Get the total overhead for all the small blocks */
                    LSmallBlockOverhead = ((PSmallBlockPoolHeader)LPMediumBlock)->BlocksInUse
                        * BlockHeaderSize;
                    /* Add to the totals */
                    Result.FreeSmall += LMediumBlockSize - LSmallBlockUsage - BlockHeaderSize;
                    Result.Overhead += LSmallBlockOverhead + BlockHeaderSize;
                    Result.TotalAllocated += LSmallBlockUsage - LSmallBlockOverhead;
                } else {
                  /* Add to the result */
                    Result.TotalAllocated += LMediumBlockSize - BlockHeaderSize;
                    Result.Overhead += BlockHeaderSize;
                }
            } else {
                /* The medium block is free */
                Result.FreeBig += LMediumBlockSize;
            }
            /* Next medium block */
            LPMediumBlock = NextMediumBlock(LPMediumBlock);
        }
        /* Get the next medium block pool */
        LPMediumBlockPoolHeader = LPMediumBlockPoolHeader->NextMediumBlockPoolHeader;
    }
    /* Add the sequential feed unused space */
    Result.Unused += MediumSequentialFeedBytesLeft;
    /* Unlock the medium blocks */
    MediumBlocksLocked = 0; /* false */
    /* Unlock all the small block types */
    for (LInd = 0; LInd < NumSmallBlockTypes; LInd++)
        SmallBlockTypes[LInd].BlockTypeLocked = 0; /* false */
    /* Step through all the large blocks */
    LockLargeBlocks();
    LPLargeBlock = LargeBlocksCircularList.NextLargeBlockHeader;
    while (LPLargeBlock != &LargeBlocksCircularList)
    {
        LLargeBlockSize = LPLargeBlock->BlockSizeAndFlags & DropMediumAndLargeFlagsMask;
        Result.TotalAddrSpace += LLargeBlockSize;
        Result.TotalCommitted += LLargeBlockSize;
        Result.TotalAllocated += LPLargeBlock->UserAllocatedSize;
        Result.Overhead += LLargeBlockSize - LPLargeBlock->UserAllocatedSize;
        /* Get the next large block */
        LPLargeBlock = LPLargeBlock->NextLargeBlockHeader;
    }
    LargeBlocksLocked = 0; /* false */
    /* Set the total number of free bytes */
    Result.TotalFree = Result.FreeSmall + Result.FreeBig + Result.Unused;

    return Result;
}

/* Returns the memory block size */
int __FASTCALL _FastMM_GetMemBlockSize(void *P)
{
    DWORD LBlockHeader, LAvailableSize;
    PSmallBlockType LPSmallBlockType;

    if (!P)
        return 0;

    /* Get the block header: Is it actually a small block? */
    LBlockHeader = *DWORD_PTR_SUBOFS(P, BlockHeaderSize);
    /* Is it a small block that is in use? */
    if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag | IsLargeBlockFlag)) == 0)
    {
        /* ----------------------------Small block------------------------------ */
        /* The block header is a pointer to the block pool: Get the block type */
        LPSmallBlockType = ((PSmallBlockPoolHeader)LBlockHeader)->BlockType;
        /* Get the available size inside blocks of this type. */
        return LPSmallBlockType->BlockSize - BlockHeaderSize;
    } else if ((LBlockHeader & (IsFreeBlockFlag | IsLargeBlockFlag)) == 0) {
        /* -------------------------Medium block------------------------------ */
        /* What is the available size in the block being reallocated? */
        LAvailableSize = (LBlockHeader & DropMediumAndLargeFlagsMask);
        /* Subtract the block header size from the old available size */
        return LAvailableSize -= BlockHeaderSize;
    } else if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag)) == 0) {
        /* -----------------------Large block------------------------------ */
        /* Large block - size is (16 + 4) less than the allocated size */
        LAvailableSize = (LBlockHeader & DropMediumAndLargeFlagsMask);
        return LAvailableSize -(LargeBlockHeaderSize + BlockHeaderSize);
    } else {
        /* -----------------------Invalid block------------------------------ */
        /* Bad pointer: probably an attempt to reallocate a free memory block. */
        return 0;
    }
}

int __FASTCALL _FastMM_CanResizeInplace(void *P, int Size)
{
    /* Reimplementation of ReallocMem without any reallocation */

    DWORD LBlockHeader, LAvailableSize, LNextBlockSizeAndFlags,
        LNextBlockSize, LNewAvailableSize;
    void *LPNextBlock;
    PSmallBlockType LPSmallBlockType;
    MEMORY_BASIC_INFORMATION LMemInfo;
    void *LNextSegmentPointer;

    if (!P)
        return 0;

    /* Get the block header: Is it actually a small block? */
    LBlockHeader = *DWORD_PTR_SUBOFS(P, BlockHeaderSize);
    /* Is it a small block that is in use? */
    if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag | IsLargeBlockFlag)) == 0)
    {
        /* ----------------------------Small block------------------------------ */
        /* The block header is a pointer to the block pool: Get the block type */
        LPSmallBlockType = ((PSmallBlockPoolHeader)LBlockHeader)->BlockType;
        /* Get the available size inside blocks of this type. */
        LAvailableSize = LPSmallBlockType->BlockSize - BlockHeaderSize;
        if (LAvailableSize >= (DWORD)Size)
        {
            /* It's a downsize. Do we need to allocate a smaller block? Only if the new
               block size is less than a quarter of the available size less
               SmallBlockDownsizeCheckAdder bytes */
            if (((DWORD)Size * 4 + SmallBlockDownsizeCheckAdder) >= LAvailableSize)
                return 1;
        }
        return 0;
    } else if ((LBlockHeader & (IsFreeBlockFlag | IsLargeBlockFlag)) == 0) {
        /* -------------------------Medium block------------------------------ */
        /* What is the available size in the block being reallocated? */
        LAvailableSize = (LBlockHeader & DropMediumAndLargeFlagsMask);
        /* Subtract the block header size from the old available size */
        LAvailableSize -= BlockHeaderSize;

        /* Get a pointer to the next block */
        LPNextBlock = DWORD_PTR_OFS(P, LAvailableSize);
        /* Subtract the block header size from the old available size */
        LAvailableSize -= BlockHeaderSize;
        /* Is it an upsize or a downsize? */
        if ((DWORD)Size > LAvailableSize)
        {
            /* Can we do an in-place upsize? */
            LNextBlockSizeAndFlags = *DWORD_PTR_SUBOFS(LPNextBlock, BlockHeaderSize);
            /* Is the next block free? */
            if ((LNextBlockSizeAndFlags & IsFreeBlockFlag) != 0)
            {
                LNextBlockSize = LNextBlockSizeAndFlags & DropMediumAndLargeFlagsMask;
                /* The available size including the next block */
                LNewAvailableSize = LAvailableSize + LNextBlockSize;
                /* Can the block fit? */
                if ((DWORD)Size <= LNewAvailableSize)
                    return 1;
            }
        } else {
            /* Must be less than half the current size or we don't bother resizing. */
            if ((DWORD)(Size * 2) >= LAvailableSize)
            {
                return 1;
            } else {
                /* In-place downsize? Balance the cost of moving the data vs. the cost of
                   fragmenting the memory pool. Medium blocks in use may never be smaller
                   than MinimumMediumBlockSize. */
                if (Size >= (MinimumMediumBlockSize - BlockHeaderSize))
                {
                    return 1;
                } else {
                    /* The requested size is less than the minimum medium block size. If
                       the requested size is less than the threshold value (currently a
                       quarter of the minimum medium block size), move the data to a small
                       block, otherwise shrink the medium block to the minimum allowable
                       medium block size. */
                    if ((DWORD)Size >= MediumInPlaceDownsizeLimit)
                    {
                        /* The request is for a size smaller than the minimum medium block
                           size, but not small enough to justify moving data */
                        return 1;
                    }
                }
            }
        }
        return 0;
    } else if ((LBlockHeader & (IsFreeBlockFlag | IsMediumBlockFlag)) == 0) {
        /* -----------------------Large block------------------------------ */
        /* Large block - size is (16 + 4) less than the allocated size */
        LAvailableSize = (LBlockHeader & DropMediumAndLargeFlagsMask) - (LargeBlockHeaderSize + BlockHeaderSize);
        if ((DWORD)Size > LAvailableSize)
        {
            /* This pointer is being reallocated to a larger block and therefore it is
               logical to assume that it may be enlarged again. */
            /* Can another large block segment be allocated directly after this segment,
               thus negating the need to move the data? */
            LNextSegmentPointer = DWORD_PTR_SUBOFS(P, LargeBlockHeaderSize + (LBlockHeader & DropMediumAndLargeFlagsMask));
            VirtualQuery(LNextSegmentPointer, &LMemInfo, sizeof(LMemInfo));
            if (LMemInfo.State == MEM_FREE)
            {
                /* Round the region size to the previous 64K */
                LMemInfo.RegionSize = LMemInfo.RegionSize & (-LargeBlockGranularity);
                /* Enough space to grow in place? */
                if ((DWORD)LMemInfo.RegionSize > (Size - LAvailableSize))
                {
                    /* There is enough space after the block to extend it */
                    return 1;
                }
            }
            /* Could not resize in place: Allocate the new block */
            return 0;
        } else {
            /* It's a downsize: do we need to reallocate? Only if the new size is less
               than half the old size */
            if ((DWORD)Size >= (LAvailableSize >> 1))
                /* No need to reallocate */
                return 1;
            return 0;
        }
    } else {
        /* -----------------------Invalid block------------------------------ */
        /* Bad pointer: probably an attempt to reallocate a free memory block. */
        return 0;
    }
}


/* ------------------------Memory Manager Sharing--------------------------- */

/* Generates a string identifying the process */
static void __FASTCALL BuildMappingObjectName(void)
{
    /* Hexadecimal characters */
    static const char HexTable[16] = "0123456789ABCDEF";

    DWORD LProcessID;
    int i;

    LProcessID = GetCurrentProcessId();
    for (i = 0; i < 8; i++)
        MappingObjectName[24 - i] = HexTable[((LProcessID >> (i * 4)) & 0xF)];
}

/* Searches the current process for a shared memory manager */
static TMemoryManagerEx* __FASTCALL FindSharedMemoryManager(void)
{
    void *LPMapAddress;
    HANDLE LLocalMappingObjectHandle;
    TMemoryManagerEx* Result;

    BuildMappingObjectName();
    /* Try to open the shared memory manager file mapping */
    LLocalMappingObjectHandle = OpenFileMappingA(FILE_MAP_READ, FALSE, MappingObjectName);
    /* Is a memory manager in this process sharing its memory manager? */
    if (!LLocalMappingObjectHandle)
        /* No shared memory manager in the process */
        return 0;
    else {
        /* Map a view of the memory */
        LPMapAddress = MapViewOfFile(LLocalMappingObjectHandle, FILE_MAP_READ, 0, 0, 0);
        /* Get the address of the shared memory manager */
        Result = *((void**)LPMapAddress);
        /* Unmap the file */
        UnmapViewOfFile(LPMapAddress);
        /* Close the file mapping */
        CloseHandle(LLocalMappingObjectHandle);
        return Result;
    }
}

/* Searches the current process for a shared memory manager. If no memory has
   been allocated using this memory manager it will switch to using the shared
   memory manager instead. Returns true if another memory manager was found and
   it could be shared. If this memory manager instance *is* the shared memory
   manager, it will do nothing and return true. */
int __FASTCALL _FastMM_AttemptToUseSharedMemoryManager(void)
{
    TMemoryManagerEx *LPMemoryManagerEx;

    if (!_FastMM_IsMemoryManagerSet())
    {
        /* Is this MM being shared? If so, switching to another MM is not allowed */
        if (!MappingObjectHandle)
        {
            /* May not switch memory manager after memory has been allocated */
            if ((MediumBlockPoolsCircularList.NextMediumBlockPoolHeader == &MediumBlockPoolsCircularList)
                && (LargeBlocksCircularList.NextLargeBlockHeader == &LargeBlocksCircularList))
            {
                LPMemoryManagerEx = FindSharedMemoryManager();
                if (LPMemoryManagerEx)
                {
                  _FastMM_SetMemoryManager(LPMemoryManagerEx);
                  return 1; /* true */
                }
                return 0; /* false */

            } else {
                /* Memory has already been allocated using this memory manager. We cannot
                   rip the memory manager out from under live pointers. */
                MessageBoxA(0, LivePointersErrorMsg, ShareMMErrorTitle,
                  MB_OK | MB_ICONERROR | MB_TASKMODAL);
                return 0; /* false */
            }
        }
        /* This memory manager is being shared, and an attempt is being made by the
           application to use the shared memory manager (which is this one): Don't
           do anything and return success. (This situation can occur when using
           SimpleShareMem in a DLL together with runtime packages.) */
        return 1; /* true */
    }
    /* Another memory manager has already been installed. */
    return 0; /* false */
}

/* Starts sharing this memory manager with other modules in the current process.
   Only one memory manager may be shared per process, so this function may fail. */
int __FASTCALL _FastMM_ShareMemoryManager(void)
{
    void *LPMapAddress;

    if (!_FastMM_IsMemoryManagerSet() && !MappingObjectHandle)
    {
        /* Is any other module already sharing its MM? */
        if (!FindSharedMemoryManager())
        {
            /* Create the memory mapped file */
            MappingObjectHandle = CreateFileMappingA(INVALID_HANDLE_VALUE, 0,
                PAGE_READWRITE, 0, 4, MappingObjectName);
            /* Map a view of the memory */
            LPMapAddress = MapViewOfFile(MappingObjectHandle, FILE_MAP_WRITE, 0, 0, 0);
            /* Set a pointer to the new memory manager */
            *((void**)LPMapAddress) = &ThisMemoryManager;
            /* Unmap the file */
            UnmapViewOfFile(LPMapAddress);
            /* Sharing this MM */
            return 1; /* true */
        }
        /* Another module is already sharing its memory manager */
        return 0; /* false */
    }
    /* Either another memory manager has been set or this memory manager is
       already being shared */
    return 0; /* false */
}

/* --------------------------Memory Manager Setup--------------------------- */

/* Builds the block size to small block type lookup table */
static void BuildBlockTypeLookupTable(void)
{
    unsigned int LBlockTypeInd, LStartIndex, LNextStartIndex;
    unsigned char LBlockTypeVal;

    LStartIndex = 0;
    for (LBlockTypeInd = 0; LBlockTypeInd < NumSmallBlockTypes; LBlockTypeInd++)
    {
        /* Is this a valid block type for the alignment restriction? */
        if ((MinimumBlockAlignment == mba8Byte)
            || ((SmallBlockTypes[LBlockTypeInd].BlockSize & 15) == 0))
        {
            LNextStartIndex = SmallBlockTypes[LBlockTypeInd].BlockSize / SmallBlockGranularity;
            /* Store the block type index * 4 in the appropriate slots. */
            LBlockTypeVal = LBlockTypeInd * 4;
            while (LStartIndex < LNextStartIndex)
            {
                AllocSize2SmallBlockTypeIndX4[LStartIndex] = LBlockTypeVal;
                LStartIndex++;
            }
            /* Set the start of the next block type */
            LStartIndex = LNextStartIndex;
        }
    }
}

TMinimumBlockAlignment __FASTCALL _FastMM_GetMinimumBlockAlignment(void)
{
    return MinimumBlockAlignment;
}

void __FASTCALL _FastMM_SetMinimumBlockAlignment(TMinimumBlockAlignment AMinimumBlockAlignment)
{
    if (AMinimumBlockAlignment != MinimumBlockAlignment)
    {
        MinimumBlockAlignment = AMinimumBlockAlignment;
        /* Rebuild the size to small block type lookup table */
        BuildBlockTypeLookupTable();
    }
}

/* Initializes the lookup tables for the memory manager */
void __FASTCALL _FastMM_InitializeMemoryManager(void)
{
    int i;
    unsigned long LMinimumPoolSize, LOptimalPoolSize, LGroupNumber, LBlocksPerPool;
    PMediumFreeBlock LPMediumFreeBlock;

    if (Initialized)
        return;
    Initialized = 1;

    if (IsInitMemoryManagerSet())
        _FastMM_SetMemoryManager(&ThisMemoryManager);

    /* ---------------------Set up the small block types---------------------- */
    for (i = 0; i < NumSmallBlockTypes; i++)
    {
        /* The upsize move procedure may move chunks in 16 bytes even with 8-byte
           alignment, since the new size will always be at least 8 bytes bigger than
           the old size. */
    #ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
        if (!SmallBlockTypes[i].UpsizeMoveProcedure)
      #ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
          SmallBlockTypes[i].UpsizeMoveProcedure = _FastMM_MoveX16L4;
      #else
          SmallBlockTypes[i].UpsizeMoveProcedure = Move;
      #endif
    #endif
        /* Set the first "available pool" to the block type itself, so that the
           allocation routines know that there are currently no pools with free
           blocks of this size. */
        SmallBlockTypes[i].PreviousPartiallyFreePool = (PSmallBlockPoolHeader)&SmallBlockTypes[i];
        SmallBlockTypes[i].NextPartiallyFreePool = (PSmallBlockPoolHeader)&SmallBlockTypes[i];
        /* Cannot sequential feed yet: Ensure that the next address is greater than
         the maximum address */
        SmallBlockTypes[i].MaxSequentialFeedBlockAddress = 0;
        SmallBlockTypes[i].NextSequentialFeedBlockAddress = (void*)1;
        /* Get the mask to use for finding a medium block suitable for a block pool */
        LMinimumPoolSize = ((SmallBlockTypes[i].BlockSize * MinimumSmallBlocksPerPool
              + (SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
            & (-MediumBlockGranularity)) + MediumBlockSizeOffset;
        if (LMinimumPoolSize < MinimumMediumBlockSize)
            LMinimumPoolSize = MinimumMediumBlockSize;
        /* Get the closest group number for the minimum pool size */
        LGroupNumber = (LMinimumPoolSize + (- MinimumMediumBlockSize + MediumBlockBinsPerGroup * MediumBlockGranularity / 2))
            / (MediumBlockBinsPerGroup * MediumBlockGranularity);
        /* Too large? */
        if (LGroupNumber > 7)
            LGroupNumber = 7;
        /* Set the bitmap */
        SmallBlockTypes[i].AllowedGroupsForBlockPoolBitmap = (unsigned char)((unsigned char)(-1) << LGroupNumber);
        /* Set the minimum pool size */
        SmallBlockTypes[i].MinimumBlockPoolSize = MinimumMediumBlockSize + LGroupNumber * (MediumBlockBinsPerGroup * MediumBlockGranularity);
        /* Get the optimal block pool size */
        LOptimalPoolSize = ((SmallBlockTypes[i].BlockSize * TargetSmallBlocksPerPool
              + (SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
            & (-MediumBlockGranularity)) + MediumBlockSizeOffset;
        /* Limit the optimal pool size to within range */
        if (LOptimalPoolSize < OptimalSmallBlockPoolSizeLowerLimit)
            LOptimalPoolSize = OptimalSmallBlockPoolSizeLowerLimit;
        if (LOptimalPoolSize > OptimalSmallBlockPoolSizeUpperLimit)
            LOptimalPoolSize = OptimalSmallBlockPoolSizeUpperLimit;
        /* How many blocks will fit in the adjusted optimal size? */
        LBlocksPerPool = (LOptimalPoolSize - SmallBlockPoolHeaderSize) / SmallBlockTypes[i].BlockSize;
        /* Recalculate the optimal pool size to minimize wastage due to a partial
           last block. */
        SmallBlockTypes[i].OptimalBlockPoolSize =
          ((LBlocksPerPool * SmallBlockTypes[i].BlockSize + (SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
            & (-MediumBlockGranularity)) + MediumBlockSizeOffset;
    }
  /* Build the requested size to block type lookup table */
    BuildBlockTypeLookupTable();
    /* --------------------------Set up the medium blocks--------------------- */
    /* There are currently no medium block pools */
    MediumBlockPoolsCircularList.PreviousMediumBlockPoolHeader = &MediumBlockPoolsCircularList;
    MediumBlockPoolsCircularList.NextMediumBlockPoolHeader = &MediumBlockPoolsCircularList;
    /* All medium bins are empty */
    for (i = 0; i < MediumBlockBinCount; i++)
    {
        LPMediumFreeBlock = &MediumBlockBins[i];
        LPMediumFreeBlock->PreviousFreeBlock = LPMediumFreeBlock;
        LPMediumFreeBlock->NextFreeBlock = LPMediumFreeBlock;
    }
    /* ------------------------Set up the large blocks------------------------ */
    LargeBlocksCircularList.PreviousLargeBlockHeader = &LargeBlocksCircularList;
    LargeBlocksCircularList.NextLargeBlockHeader = &LargeBlocksCircularList;

#ifdef AUTO_SHARE_MEMORYMANAGER
    if ((HMODULE)_hInstance == GetModuleHandle(0))
    {
        /* We are the EXE, so share our memory manager */
        _FastMM_ShareMemoryManager();
    } else {
        /* We are a DLL, so try to use the shared memory manager from the EXE */
        _FastMM_AttemptToUseSharedMemoryManager();
    }
#endif
}

/* Frees all allocated memory. */
static void FreeAllMemory(void)
{
    PMediumBlockPoolHeader LPMediumBlockPoolHeader, LPNextMediumBlockPoolHeader;
    PMediumFreeBlock LPMediumFreeBlock;
    PLargeBlockHeader LPLargeBlock, LPNextLargeBlock;
    int LInd;

    /* Free all block pools */
    LPMediumBlockPoolHeader = MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
    while (LPMediumBlockPoolHeader != &MediumBlockPoolsCircularList)
    {
        /* Get the next medium block pool so long */
        LPNextMediumBlockPoolHeader = LPMediumBlockPoolHeader->NextMediumBlockPoolHeader;
        /* Free this pool */
        VirtualFree(LPMediumBlockPoolHeader, 0, MEM_RELEASE);
        /* Next pool */
        LPMediumBlockPoolHeader = LPNextMediumBlockPoolHeader;
    }
    /* Clear all small block types */
    for (LInd = 0; LInd < NumSmallBlockTypes; LInd++)
    {
        SmallBlockTypes[LInd].PreviousPartiallyFreePool = (PSmallBlockPoolHeader)&SmallBlockTypes[LInd];
        SmallBlockTypes[LInd].NextPartiallyFreePool = (PSmallBlockPoolHeader)&SmallBlockTypes[LInd];
        SmallBlockTypes[LInd].NextSequentialFeedBlockAddress = (void*)1;
        SmallBlockTypes[LInd].MaxSequentialFeedBlockAddress = 0;
    }
    /* Clear all medium block pools */
    MediumBlockPoolsCircularList.PreviousMediumBlockPoolHeader = &MediumBlockPoolsCircularList;
    MediumBlockPoolsCircularList.NextMediumBlockPoolHeader = &MediumBlockPoolsCircularList;
    /* All medium bins are empty */
    for (LInd = 0; LInd < MediumBlockBinCount; LInd++)
    {
        LPMediumFreeBlock = &MediumBlockBins[LInd];
        LPMediumFreeBlock->PreviousFreeBlock = LPMediumFreeBlock;
        LPMediumFreeBlock->NextFreeBlock = LPMediumFreeBlock;
    }
    /* Free all large blocks */
    LPLargeBlock = LargeBlocksCircularList.NextLargeBlockHeader;
    while (LPLargeBlock != &LargeBlocksCircularList)
    {
        /* Get the next large block */
        LPNextLargeBlock = LPLargeBlock->NextLargeBlockHeader;
        /* Free this large block */
        VirtualFree(LPLargeBlock, 0, MEM_RELEASE);
        /* Next large block */
        LPLargeBlock = LPNextLargeBlock;
    }
    /* There are no large blocks allocated */
    LargeBlocksCircularList.PreviousLargeBlockHeader = &LargeBlocksCircularList;
    LargeBlocksCircularList.NextLargeBlockHeader = &LargeBlocksCircularList;
}

void __FASTCALL _FastMM_FinalizeMemoryManager(void)
{
    if (!Initialized)
        return;
    Initialized = 0;

    /* Destroy the memory mapped file handle used for sharing the memory manager. */
    if (MappingObjectHandle)
    {
        CloseHandle(MappingObjectHandle);
        MappingObjectHandle = 0;
    }
#ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE
    /* Should memory leaks be reported? */
    if (_FastMM_ReportMemoryLeaksOnShutdown)
        ScanForMemoryLeaks();
    /* Free the expected memory leaks list */
    if (ExpectedMemoryLeaks)
    {
        VirtualFree(ExpectedMemoryLeaks, 0, MEM_RELEASE);
        ExpectedMemoryLeaks = 0;
    }
#endif
    /* Clean up: Free all memory allocated through this memory manager. If this is
       a library that is frequently loaded and unloaded then it is necessary to
       prevent the process from running out of address space. */
    FreeAllMemory();

    if (!_FastMM_IsMemoryManagerSet())
        _FastMM_SetMemoryManager(&InitMemoryManager);
}

/* ---------------------Memory Manager initial callbacks------------------- */
/* The MemoryManager.* callbacks point to these function if the memory
   manager isn't initialized yet. A call to one of these init functions will
   automatically initialize the memory manager. After that the MemoryManager.*
   point to the real memory manager functions. */

static void* __FASTCALL Init_GetMem(int Size)
{
    _FastMM_InitializeMemoryManager();
    return _FastMM_GetMem(Size);
}

static int __FASTCALL Init_FreeMem(void *P)
{
    _FastMM_InitializeMemoryManager();
    return _FastMM_FreeMem(P);
}

static void* __FASTCALL Init_ReallocMem(void *P, int Size)
{
    _FastMM_InitializeMemoryManager();
    return _FastMM_ReallocMem(P, Size);
}

static void* __FASTCALL Init_AllocMem(int Size)
{
    _FastMM_InitializeMemoryManager();
    return _FastMM_AllocMem(Size);
}

/* ------------------------Memory Manager Startup------------------------ */
#if defined(_WIN64)
#define static
#endif

static void InitializeMemoryManager(void)
{
    _FastMM_InitializeMemoryManager();
}

#pragma startup InitializeMemoryManager 0

#if 0
static void FinalizeMemoryManager(void)
{
    _FastMM_FinalizeMemoryManager();
}

/* Exit-Proc is not necessary. Windows will clean up, and for DLLs the
   heap.c::internal_terminate() function finalizes the memory manager. */
#pragma exit FinalizeMemoryManager 0
#endif

// Restore stack frames option (-k)
#pragma option pop
