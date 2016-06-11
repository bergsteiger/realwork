;[]-----------------------------------------------------------------[]
;|   _FASTMMA.ASM -- FastMM memory manager assembler code            |
;[]-----------------------------------------------------------------[]

;
;       C/C++ Run Time Library - Version 24.0
; 
;       Copyright (c) 2009, 2016 by Embarcadero Technologies, Inc.
;       All Rights Reserved.
; 

; $Revision: $

        include rules.asi
        include init.inc

Header@

pause   MACRO
            db 0f3h, 90h
        ENDM

;----------------------------------------------------------------------

; Enable to use the C code path
;USE_C_CODE                            = 1
; Use custom fixed size move routines for some small blocks
USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES    = 1

; Use custom variable size move routines for larger blocks
USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES = 1

; Include the memory leak tracking and reporting code. Without this define set
; the memory leak registration functions will do nothing and the memory leak
; report will not be shown on shutdown.
;INCLUDE_MEMORYLEAK_TRACKING_CODE       = 1

;----------------------------------------------------------------------

TMediumFreeBlock    STRUCT
    PreviousFreeBlock   dd  ?   ; TMediumFreeBlock*
    NextFreeBlock       dd  ?   ; TMediumFreeBlock*
TMediumFreeBlock    ENDS

TSmallBlockType     STRUCT
    BlockTypeLocked                     db  ?   ; char
    AllowedGroupsForBlockPoolBitmap     db  ?   ; char
    BlockSize                           dw  ?   ; WORD
    NextPartiallyFreePool               dd  ?   ; PSmallBlockPoolHeader
    NextSequentialFeedBlockAddress      dd  ?   ; LPVOID

    MaxSequentialFeedBlockAddress       dd  ?   ; LPVOID
    CurrentSequentialFeedPool           dd  ?   ; PSmallBlockPoolHeader
    PreviousPartiallyFreePool           dd  ?   ; PSmallBlockPoolHeader
    MinimumBlockPoolSize                dw  ?   ; WORD
    OptimalBlockPoolSize                dw  ?   ; WORD
  ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
    UpsizeMoveProcedure                 dd  ?   ; TMoveProc
  else
    Reserved                            dd  ?   ; DWORD
  endif
TSmallBlockType     ENDS

TSmallBlockPoolHeader   STRUCT
    BlockType                       dd  ?   ; PSmallBlockType
    NextPartiallyFreePool           dd  ?   ; PSmallBlockPoolHeader
    FirstFreeBlock                  dd  ?   ; LPVOID
    BlocksInUse                     dd  ?   ; DWORD
    SmallBlockPoolSignature         dd  ?   ; DWORD
    PreviousPartiallyFreePool       dd  ?   ; PSmallBlockPoolHeader
    Reserved1                       dd  ?   ; DWORD
    FirstBlockPoolPointerAndFlags   dd  ?   ; DWORD
TSmallBlockPoolHeader   ENDS

TMediumBlockPoolHeader  STRUCT
    PreviousMediumBlockPoolHeader   dd  ?   ; PMediumBlockPoolHeader
    NextMediumBlockPoolHeader       dd  ?   ; PMediumBlockPoolHeader
    Reserved                        dd  ?   ; DWORD
    FirstMediumBlockSizeAndFlags    dd  ?   ; DWORD
TMediumBlockPoolHeader  ENDS


;----------------------------------------------------------------------

MEM_COMMIT                      EQU     1000h
MEM_RESERVE                     EQU     2000h
MEM_DECOMMIT                    EQU     4000h
MEM_RELEASE                     EQU     8000h
MEM_FREE                        EQU     10000h
MEM_PRIVATE                     EQU     20000h
MEM_MAPPED                      EQU     40000h
MEM_RESET                       EQU     80000h
MEM_TOP_DOWN                    EQU     100000h


InitialSleepTime                EQU     0
AdditionalSleepTime             EQU     10

BlockHeaderSize                 EQU     4
MaximumSmallBlockSize           EQU     2608
IsSmallBlockPoolInUseFlag       EQU     4
IsLargeBlockFlag                EQU     4

DropSmallFlagsMask              EQU     -8
ExtractSmallFlagsMask           EQU     7

MediumBlockPoolSize             EQU     (20 * 64 * 1024 - 16)
MediumBlockSizeOffset           EQU     48
MinimumMediumBlockSize          EQU     (11 * 256 + MediumBlockSizeOffset)
MediumBlockBinsPerGroup         EQU     32
MediumBlockBinGroupCount        EQU     32
MediumBlockBinCount             EQU     (MediumBlockBinGroupCount * MediumBlockBinsPerGroup)
MaximumMediumBlockSize          EQU     (MinimumMediumBlockSize + (MediumBlockBinCount - 1) * MediumBlockGranularity)
MediumBlockPoolHeaderSize       EQU     TYPE(TMediumBlockPoolHeader)
MediumInPlaceDownsizeLimit      EQU     (MinimumMediumBlockSize / 4)


IsFreeBlockFlag                 EQU     1
IsMediumBlockFlag               EQU     2
PreviousMediumBlockIsFreeFlag   EQU     8

DropMediumAndLargeFlagsMask     EQU     -16
ExtractMediumAndLargeFlagsMask  EQU     15

MediumBlockGranularity          EQU     256
MediumBlockSizeOffset           EQU     48

OptimalSmallBlockPoolSizeLowerLimit EQU (29 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset)
OptimalSmallBlockPoolSizeUpperLimit EQU (64 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset)

MaximumSmallBlockPoolSize       EQU     (OptimalSmallBlockPoolSizeUpperLimit + MinimumMediumBlockSize)
SmallBlockDownsizeCheckAdder    EQU     64
SmallBlockUpsizeAdder           EQU     32

;----------------------------------------------------------------------
;       Segments Definitions

Data_Seg@
    ; char _FastMM_IsMultiThread = 1;
    ExtSym@ _FastMM_IsMultiThread, byte, cdecl
    IsMultiThread                           EQU     __FastMM_IsMultiThread

    ; char _FastMM_NeverSleepOnMMThreadContention = 0
    ExtSym@ _FastMM_NeverSleepOnMMThreadContention, byte, cdecl
    NeverSleepOnMMThreadContention          EQU     __FastMM_NeverSleepOnMMThreadContention

    ; char MediumBlocksLocked = 0;
    ExtSym@ _FastMM_MediumBlocksLocked, byte, cdecl
    MediumBlocksLocked                      EQU     __FastMM_MediumBlocksLocked

    ; DWORD MediumBlockBinBitmaps[MediumBlockBinGroupCount];
    ExtSym@ _FastMM_MediumBlockBinBitmaps, dword, cdecl
    MediumBlockBinBitmaps                   EQU     __FastMM_MediumBlockBinBitmaps

    ; TMediumFreeBlock MediumBlockBins[MediumBlockBinCount];
    ExtSym@ _FastMM_MediumBlockBins, dword, cdecl
    MediumBlockBins                         EQU     __FastMM_MediumBlockBins

    ; DWORD MediumBlockBinGroupBitmap;
    ExtSym@ _FastMM_MediumBlockBinGroupBitmap, dword, cdecl
    MediumBlockBinGroupBitmap               EQU     __FastMM_MediumBlockBinGroupBitmap

    ; LPVOID LastSequentiallyFedMediumBlock;
    ExtSym@ _FastMM_LastSequentiallyFedMediumBlock, dword, cdecl
    LastSequentiallyFedMediumBlock          EQU     __FastMM_LastSequentiallyFedMediumBlock

    ; DWORD MediumSequentialFeedBytesLeft;
    ExtSym@ _FastMM_MediumSequentialFeedBytesLeft, dword, cdecl
    MediumSequentialFeedBytesLeft           EQU     __FastMM_MediumSequentialFeedBytesLeft

    ; char AllocSize2SmallBlockTypeIndX4[MaximumSmallBlockSize / SmallBlockGranularity];
    ExtSym@ _FastMM_AllocSize2SmallBlockTypeIndX4, dword, cdecl
    AllocSize2SmallBlockTypeIndX4           EQU     __FastMM_AllocSize2SmallBlockTypeIndX4

    ; TSmallBlockType SmallBlockTypes[NumSmallBlockTypes] =
    ExtSym@ _FastMM_SmallBlockTypes, dword, cdecl
    SmallBlockTypes                         EQU     __FastMM_SmallBlockTypes

Data_EndS@

;----------------------------------------------------------------------

Code_Seg@

; WiNAPI
ExtFunc@    VirtualFree, stdcall
ExtFunc@    Sleep, stdcall

; FastMM
ExtFunc@    _FastMM_AllocNewSequentialFeedMediumPool, fastcall
ExtFunc@    _FastMM_AllocateLargeBlock, fastcall
ExtFunc@    _FastMM_FreeLargeBlock, fastcall
ExtFunc@    _FastMM_ReallocateLargeBlock, fastcall
ExtFunc@    _internal_memmove, fastcall


;----------------------------------------------------------------------
; Name          _FastMM_LockCmpxchg
;
; Usage         char __FASTCALL _FastMM_LockCmpxchg(char CompareVal, char NewVal, char* AAddress)
;
; Note          Compare [AAddress], CompareVal:
;                 If Equal: [AAddress] = NewVal && result == CompareVal
;                 If Unequal: Result = [AAddress]
;----------------------------------------------------------------------

Func@   _FastMM_LockCmpxchg, _EXPFUNC, fastcall
        ; On entry:
        ;   al = CompareVal,
        ;   dl = NewVal,
        ;   ecx = AAddress

        lock cmpxchg [ecx], dl

        ret
EndFunc@ _FastMM_LockCmpxchg


;----------------------------------------------------------------------
; Name          _FastMM_FindFirstSetBit
;
; Usage         unsigned int __FASTCALL _FastMM_FindFirstSetBit(unsigned int ACardinal)
;
; Note          Gets the first set bit and resets it, returning the bit index
;----------------------------------------------------------------------
ifdef USE_C_CODE

Func@   _FastMM_FindFirstSetBit, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = ACardinal

        bsf eax, eax

        Return@
EndFunc@ _FastMM_FindFirstSetBit

endif ; USE_C_CODE



ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES

;----------------------------------------------------------------------
; Name          _FastMM_Move12
;
; Usage         void __FASTCALL _FastMM_Move12(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move12, _EXPFUNC, fastcall
        mov ecx, [eax]
        mov [edx], ecx
        mov ecx, [eax + 4]
        mov eax, [eax + 8]
        mov [edx + 4], ecx
        mov [edx + 8], eax

        Return@
EndFunc@ _FastMM_Move12

;----------------------------------------------------------------------
; Name          _FastMM_Move20
;
; Usage         void __FASTCALL _FastMM_Move20(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move20, _EXPFUNC, fastcall
        mov ecx, [eax]
        mov [edx], ecx
        mov ecx, [eax + 4]
        mov [edx + 4], ecx
        mov ecx, [eax + 8]
        mov [edx + 8], ecx
        mov ecx, [eax + 12]
        mov eax, [eax + 16]
        mov [edx + 12], ecx
        mov [edx + 16], eax

        Return@
EndFunc@ _FastMM_Move20

;----------------------------------------------------------------------
; Name          _FastMM_Move28
;
; Usage         void __FASTCALL _FastMM_Move28(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move28, _EXPFUNC, fastcall
        mov ecx, [eax]
        mov [edx], ecx
        mov ecx, [eax + 4]
        mov [edx + 4], ecx
        mov ecx, [eax + 8]
        mov [edx + 8], ecx
        mov ecx, [eax + 12]
        mov [edx + 12], ecx
        mov ecx, [eax + 16]
        mov [edx + 16], ecx
        mov ecx, [eax + 20]
        mov eax, [eax + 24]
        mov [edx + 20], ecx
        mov [edx + 24], eax

        Return@
EndFunc@ _FastMM_Move28

;----------------------------------------------------------------------
; Name          _FastMM_Move36
;
; Usage         void __FASTCALL _FastMM_Move36(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move36, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        mov ecx, [eax + 32]
        mov [edx + 32], ecx
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move36

;----------------------------------------------------------------------
; Name          _FastMM_Move44
;
; Usage         void __FASTCALL _FastMM_Move44(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move44, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        mov ecx, [eax + 40]
        mov [edx + 40], ecx
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move44

;----------------------------------------------------------------------
; Name          _FastMM_Move52
;
; Usage         void __FASTCALL _FastMM_Move52(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move52, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        fild qword ptr [eax + 40]
        mov ecx, [eax + 48]
        mov [edx + 48], ecx
        fistp qword ptr [edx + 40]
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move52

;----------------------------------------------------------------------
; Name          _FastMM_Move60
;
; Usage         void __FASTCALL _FastMM_Move60(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move60, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        fild qword ptr [eax + 40]
        fild qword ptr [eax + 48]
        mov ecx, [eax + 56]
        mov [edx + 56], ecx
        fistp qword ptr [edx + 48]
        fistp qword ptr [edx + 40]
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move60

;----------------------------------------------------------------------
; Name          _FastMM_Move68
;
; Usage         void __FASTCALL _FastMM_Move68(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move68, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        fild qword ptr [eax + 40]
        fild qword ptr [eax + 48]
        fild qword ptr [eax + 56]
        mov ecx, [eax + 64]
        mov [edx + 64], ecx
        fistp qword ptr [edx + 56]
        fistp qword ptr [edx + 48]
        fistp qword ptr [edx + 40]
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move68

endif ; USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES

ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES

;----------------------------------------------------------------------
; Name          _FastMM_MoveX16L4
;
; Usage         void __FASTCALL _FastMM_MoveX16L4(void* ASource, void* ADest, int ACount)
;
; Note          Variable size move procedure: Assumes ACount is 4 less than a multiple of 16.
;               Always moves at least 12 bytes, irrespective of ACount.
;----------------------------------------------------------------------

Func@   _FastMM_MoveX16L4, _EXPFUNC, fastcall
        ; Make the counter negative based: The last 12 bytes are moved separately
        sub ecx, 12
        add eax, ecx
        add edx, ecx
        neg ecx
        jns @MoveLast12_16
@MoveLoop_16:
        ; Move a 16 byte block
        fild qword ptr [eax + ecx]
        fild qword ptr [eax + ecx + 8]
        fistp qword ptr [edx + ecx + 8]
        fistp qword ptr [edx + ecx]
        ; Are there another 16 bytes to move?
        add ecx, 16
        js @MoveLoop_16
@MoveLast12_16:
        ; Do the last 12 bytes
        fild qword ptr [eax + ecx]
        fistp qword ptr [edx + ecx]
        mov eax, [eax + ecx + 8]
        mov [edx + ecx + 8], eax

        Return@
EndFunc@ _FastMM_MoveX16L4


;----------------------------------------------------------------------
; Name          _FastMM_MoveX8L4
;
; Usage         void __FASTCALL _FastMM_MoveX8L4(void* ASource, void* ADest, int ACount)
;
; Note          Variable size move procedure: Assumes ACount is 4 less than a multiple of 8.
;               Always moves at least 12 bytes, irrespective of ACount.
;----------------------------------------------------------------------

Func@   _FastMM_MoveX8L4, _EXPFUNC, fastcall
        ; Make the counter negative based: The last 4 bytes are moved separately
        sub ecx, 4
        add eax, ecx
        add edx, ecx
        neg ecx
@MoveLoop_8:
        ; Move an 8 byte block
        fild qword ptr [eax + ecx]
        fistp qword ptr [edx + ecx]
        ; Are there another 8 bytes to move?
        add ecx, 8
        js @MoveLoop_8
        ; Do the last 4 bytes
        mov eax, [eax + ecx]
        mov [edx + ecx], eax

        Return@
EndFunc@ _FastMM_MoveX8L4

endif ; USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES


ifndef USE_C_CODE
;----------------------------------------------------------------------
; Name          _FastMM_RemoveMediumFreeBlock
;
; Usage         void __FASTCALL _FastMM_RemoveMediumFreeBlock(PMediumFreeBlock APMediumFreeBlock)
;
; Note          Removes a medium block from the circular linked list of free blocks.
;               Does not change any header flags. Medium blocks should be locked
;               before calling this procedure.
;----------------------------------------------------------------------

Func@   _FastMM_RemoveMediumFreeBlock, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = APMediumFreeBlock

        ; Get the current previous and next blocks
        mov ecx, [eax.TMediumFreeBlock.NextFreeBlock]
        mov edx, [eax.TMediumFreeBlock.PreviousFreeBlock]
        ; Is this bin now empty? If the previous and next free block pointers are
        ; equal, they must point to the bin.
        cmp ecx, edx
        ; Remove this block from the linked list
        mov [ecx.TMediumFreeBlock.PreviousFreeBlock], edx
        mov [edx.TMediumFreeBlock.NextFreeBlock], ecx
        ; Is this bin now empty? If the previous and next free block pointers are
        ; equal, they must point to the bin.
        je @BinIsNowEmpty
@RemoveMediumFreeBlock_Done:
        ret
        ; Align branch target
        nop
@BinIsNowEmpty:
        ; Get the bin number for this block size in ecx
        sub ecx, offset MediumBlockBins
        mov edx, ecx
        shr ecx, 3
        ; Get the group number in edx
        movzx edx, dh
        ; Flag this bin as empty
        mov eax, -2
        rol eax, cl
        and dword ptr [MediumBlockBinBitmaps + edx * 4], eax
        jnz @RemoveMediumFreeBlock_Done
        ; Flag this group as empty
        mov eax, -2
        mov ecx, edx
        rol eax, cl
        and MediumBlockBinGroupBitmap, eax

        Return@
EndFunc@ _FastMM_RemoveMediumFreeBlock


;----------------------------------------------------------------------
; Name          _FastMM_InsertMediumBlockIntoBin
;
; Usage         void __FASTCALL _FastMM_InsertMediumBlockIntoBin(PMediumFreeBlock APMediumFreeBlock, DWORD AMediumBlockSize)
;
; Note          Inserts a medium block into the appropriate medium block bin.
;----------------------------------------------------------------------

Func@   _FastMM_InsertMediumBlockIntoBin, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = APMediumFreeBlock
        ;   edx = AMediumBlockSize

        ; Get the bin number for this block size. Get the bin that holds blocks of at
        ; least this size.
        sub edx, MinimumMediumBlockSize
        shr edx, 8
        ; Validate the bin number
        sub edx, MediumBlockBinCount - 1
        sbb ecx, ecx
        and edx, ecx
        add edx, MediumBlockBinCount - 1
        ; Get the bin in ecx
        lea ecx, [MediumBlockBins + edx * 8]
        ; Bins are LIFO, se we insert this block as the first free block in the bin
        mov edx, [ecx.TMediumFreeBlock.NextFreeBlock]
        ; Was this bin empty?
        cmp edx, ecx
        mov [eax.TMediumFreeBlock.PreviousFreeBlock], ecx
        mov [eax.TMediumFreeBlock.NextFreeBlock], edx
        mov [edx.TMediumFreeBlock.PreviousFreeBlock], eax
        mov [ecx.TMediumFreeBlock.NextFreeBlock], eax
        ; Was this bin empty?
        je @BinWasEmpty
        ret
        ; Align branch target
        nop
        nop
@BinWasEmpty:
        ; Get the bin number in ecx
        sub ecx, offset MediumBlockBins
        mov edx, ecx
        shr ecx, 3
        ; Get the group number in edx
        movzx edx, dh
        ; Flag this bin as not empty
        mov eax, 1
        shl eax, cl
        or dword ptr [MediumBlockBinBitmaps + edx * 4], eax
        ; Flag the group as not empty
        mov eax, 1
        mov ecx, edx
        shl eax, cl
        or MediumBlockBinGroupBitmap, eax

        Return@
EndFunc@ _FastMM_InsertMediumBlockIntoBin

;----------------------------------------------------------------------
; Name          _FastMM_BinMediumSequentialFeedRemainder
;
; Usage         void __FASTCALL _FastMM_BinMediumSequentialFeedRemainder(void)
;
; Note          Inserts a medium block into the appropriate medium block bin.
;----------------------------------------------------------------------

Func@   _FastMM_BinMediumSequentialFeedRemainder, _EXPFUNC, fastcall
        ;
        cmp MediumSequentialFeedBytesLeft, 0
        jne @MustBinMedium
        ; Nothing to bin
        ret
        ; Align branch target
        nop
        nop
@MustBinMedium:
        ; Get a pointer to the last sequentially allocated medium block
        mov eax, LastSequentiallyFedMediumBlock
        ; Is the block that was last fed sequentially free?
        test byte ptr [eax - 4], IsFreeBlockFlag
        jnz @LastBlockFedIsFree
        ; Set the "previous block is free" flag in the last block fed
        or dword ptr [eax - 4], PreviousMediumBlockIsFreeFlag
        ; Get the remainder in edx
        mov edx, MediumSequentialFeedBytesLeft
        ; Point eax to the start of the remainder
        sub eax, edx
@BinTheRemainder:
        ; Status: eax = start of remainder, edx = size of remainder
        ; Store the size of the block as well as the flags
        lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [eax - 4], ecx
        ; Store the trailing size marker
        mov [eax + edx - 8], edx
        ; Bin this medium block
        cmp edx, MinimumMediumBlockSize
        FastCallOp@ jnb _FastMM_InsertMediumBlockIntoBin
        ret
        ; Align branch target
        nop
        nop
@LastBlockFedIsFree:
        ; Drop the flags
        mov edx, DropMediumAndLargeFlagsMask
        and edx, [eax - 4]
        ; Free the last block fed
        cmp edx, MinimumMediumBlockSize
        jb @DontRemoveLastFed
        ; Last fed block is free - remove it from its size bin
        FastCall@ _FastMM_RemoveMediumFreeBlock
        ; Re-read eax and edx
        mov eax, LastSequentiallyFedMediumBlock
        mov edx, DropMediumAndLargeFlagsMask
        and edx, [eax - 4]
@DontRemoveLastFed:
        ; Get the number of bytes left in ecx
        mov ecx, MediumSequentialFeedBytesLeft
        ; Point eax to the start of the remainder
        sub eax, ecx
        ; edx = total size of the remainder
        add edx, ecx
        jmp @BinTheRemainder

        Return@
EndFunc@ _FastMM_BinMediumSequentialFeedRemainder

; ----------------------Main Memory Manager Functions----------------------

;----------------------------------------------------------------------
; Name          _FastMM_GetMem
;
; Usage         void* __FASTCALL _FastMM_GetMem(size_t Size)
;
; Note          Allocates uninitialized memory
;----------------------------------------------------------------------

Func@   _FastMM_GetMem, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = ASize

        ; Since most allocations are for small blocks, determine the small block type
        ; index so long
        lea edx, [eax + BlockHeaderSize - 1]
        shr edx, 3
        ; Is it a small block?
        cmp eax, (MaximumSmallBlockSize - BlockHeaderSize)
        ; Save ebx
        push ebx
        ; Get the IsMultiThread variable so long
        mov cl, IsMultiThread
        ; Is it a small block?
        ja @GetMem_NotASmallBlock
        ; Do we need to lock the block type?
        test cl, cl
        ; Get the small block type in ebx
        movzx eax, byte ptr [AllocSize2SmallBlockTypeIndX4 + edx]
        lea ebx, [SmallBlockTypes + eax * 8]
        ; Do we need to lock the block type?
        jnz @GetMem_LockBlockTypeLoop
@GetMem_GotLockOnSmallBlockType:
        ; Find the next free block: Get the first pool with free blocks in edx
        mov edx, [ebx.TSmallBlockType.NextPartiallyFreePool]
        ; Get the first free block (or the next sequential feed address if edx = ebx)
        mov eax, [edx.TSmallBlockPoolHeader.FirstFreeBlock]
        ; Get the drop flags mask in ecx so long
        mov ecx, DropSmallFlagsMask
        ; Is there a pool with free blocks?
        cmp edx, ebx
        je @GetMem_TrySmallSequentialFeed
        ; Increment the number of used blocks
        add [edx.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Get the new first free block
        and ecx, [eax - 4]
        ; Set the new first free block
        mov [edx.TSmallBlockPoolHeader.FirstFreeBlock], ecx
        ; Set the block header
        mov [eax - 4], edx
        ; Is the chunk now full?
        jz @GetMem_RemoveSmallPool
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Restore ebx
        pop ebx
        ; All done
        ret
        ; Align branch target
        nop
        nop
        nop
@GetMem_TrySmallSequentialFeed:
        ; Try to feed a small block sequentially: Get the sequential feed block pool
        mov edx, [ebx.TSmallBlockType.CurrentSequentialFeedPool]
        ; Get the next sequential feed address so long
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        add ecx, eax
        ; Can another block fit?
        cmp eax, [ebx.TSmallBlockType.MaxSequentialFeedBlockAddress]
        ; Can another block fit?
        ja @GetMem_AllocateSmallBlockPool
        ; Increment the number of used blocks in the sequential feed pool
        add [edx.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Store the next sequential feed block address
        mov [ebx.TSmallBlockType.NextSequentialFeedBlockAddress], ecx
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Set the block header
        mov [eax - 4], edx
        ; Restore ebx
        pop ebx
        ; All done
        ret
        ; Align branch target
        nop
        nop
        nop
@GetMem_RemoveSmallPool:
        ; Pool is full - remove it from the partially free list
        mov ecx, [edx.TSmallBlockPoolHeader.NextPartiallyFreePool]
        mov [ecx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], ebx
        mov [ebx.TSmallBlockType.NextPartiallyFreePool], ecx
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Restore ebx
        pop ebx
        ; All done
        ret
        ; Align branch target
        nop
        nop
@GetMem_LockBlockTypeLoop:
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Try the next size
        add ebx, TYPE(TSmallBlockType)
        mov eax, 100h
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Try the next size (up to two sizes larger)
        add ebx, TYPE(TSmallBlockType)
        mov eax, 100h
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Block type and two sizes larger are all locked - sleep and/or retry
        sub ebx, 2 * TYPE(TSmallBlockType)
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @GetMem_LockBlockTypeLoop
        ; Couldn't grab the block type - sleep and try again
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Couldn't grab the block type - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @GetMem_LockBlockTypeLoop
        ; Align branch target
@GetMem_AllocateSmallBlockPool:
        ; save additional registers
        push esi
        push edi
        ; Do we need to lock the medium blocks?
        cmp IsMultiThread, 0 ; false
        je @GetMem_MediumBlocksLockedForPool
@GetMem_LockMediumBlocksForPool:
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLockedForPool
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @GetMem_LockMediumBlocksForPool
        ; Couldn't lock the medium blocks - sleep and retry
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLockedForPool
        ; Couldn't lock the medium blocks - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @GetMem_LockMediumBlocksForPool
        ; Align branch target
@GetMem_MediumBlocksLockedForPool:
        ; Are there any available blocks of a suitable size?
        movsx esi, [ebx.TSmallBlockType.AllowedGroupsForBlockPoolBitmap]
        and esi, MediumBlockBinGroupBitmap
        jz @GetMem_NoSuitableMediumBlocks
        ; Get the bin group number with free blocks in eax
        bsf eax, esi
        ; Get the bin number in ecx
        lea esi, [eax * 8]
        mov ecx, dword ptr [MediumBlockBinBitmaps + eax * 4]
        bsf ecx, ecx
        lea ecx, [ecx + esi * 4]
        ; Get a pointer to the bin in edi
        lea edi, [MediumBlockBins + ecx * 8]
        ; Get the free block in esi
        mov esi, [edi.TMediumFreeBlock.NextFreeBlock]
        ; Remove the first block from the linked list (LIFO)
        mov edx, [esi.TMediumFreeBlock.NextFreeBlock]
        mov [edi.TMediumFreeBlock.NextFreeBlock], edx
        mov [edx.TMediumFreeBlock.PreviousFreeBlock], edi
        ; Is this bin now empty?
        cmp edi, edx
        jne @GetMem_MediumBinNotEmpty
        ; eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block type
        ; Flag this bin as empty
        mov edx, -2
        rol edx, cl
        and dword ptr [MediumBlockBinBitmaps + eax * 4], edx
        jnz @GetMem_MediumBinNotEmpty
        ; Flag the group as empty
        btr MediumBlockBinGroupBitmap, eax
@GetMem_MediumBinNotEmpty:
        ; esi = free block, ebx = block type
        ; Get the size of the available medium block in edi
        mov edi, DropMediumAndLargeFlagsMask
        and edi, [esi - 4]
        cmp edi, MaximumSmallBlockPoolSize
        jb @GetMem_UseWholeBlock
        ; Split the block: get the size of the second part, new block size is the
        ; optimal size
        mov edx, edi
        movzx edi, [ebx.TSmallBlockType.OptimalBlockPoolSize]
        sub edx, edi
        ; Split the block in two
        lea eax, [esi + edi]
        lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [eax - 4], ecx
        ; Store the size of the second split as the second last dword
        mov [eax + edx - 8], edx
        ; Put the remainder in a bin (it will be big enough)
        FastCall@ _FastMM_InsertMediumBlockIntoBin
        jmp @GetMem_GotMediumBlock
        ; Align branch target
@GetMem_NoSuitableMediumBlocks:
        ; Check the sequential feed medium block pool for space
        movzx ecx, [ebx.TSmallBlockType.MinimumBlockPoolSize]
        mov edi, MediumSequentialFeedBytesLeft
        cmp edi, ecx
        jb @GetMem_AllocateNewSequentialFeed
        ; Get the address of the last block that was fed
        mov esi, LastSequentiallyFedMediumBlock
        ; Enough sequential feed space: Will the remainder be usable?
        movzx ecx, [ebx.TSmallBlockType.OptimalBlockPoolSize]
        lea edx, [ecx + MinimumMediumBlockSize]
        cmp edi, edx
        jb @GetMem_NotMuchSpace
        mov edi, ecx
@GetMem_NotMuchSpace:
        sub esi, edi
        ; Update the sequential feed parameters
        sub MediumSequentialFeedBytesLeft, edi
        mov LastSequentiallyFedMediumBlock, esi
        ; Get the block pointer
        jmp @GetMem_GotMediumBlock
        ; Align branch target
@GetMem_AllocateNewSequentialFeed:
        ; Need to allocate a new sequential feed medium block pool: use the
        ; optimal size for this small block pool
        movzx eax, [ebx.TSmallBlockType.OptimalBlockPoolSize]
        mov edi, eax
        ; Allocate the medium block pool
        FastCall@ _FastMM_AllocNewSequentialFeedMediumPool
        mov esi, eax
        test eax, eax
        jnz @GetMem_GotMediumBlock
        mov MediumBlocksLocked, al
        mov [ebx.TSmallBlockType.BlockTypeLocked], al
        pop edi
        pop esi
        pop ebx
        ret
        ; Align branch target
@GetMem_UseWholeBlock:
        ; esi = free block, ebx = block type, edi = block size
        ; Mark this block as used in the block following it
        and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GetMem_GotMediumBlock:
        ; esi = free block, ebx = block type, edi = block size
        ; Set the size and flags for this block
        lea ecx, [edi + IsMediumBlockFlag + IsSmallBlockPoolInUseFlag]
        mov [esi - 4], ecx
        ; Unlock medium blocks
        xor eax, eax
        mov MediumBlocksLocked, al
        ; Set up the block pool
        mov [esi.TSmallBlockPoolHeader.BlockType], ebx
        mov [esi.TSmallBlockPoolHeader.FirstFreeBlock], eax
        mov [esi.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Set it up for sequential block serving
        mov [ebx.TSmallBlockType.CurrentSequentialFeedPool], esi
        ; Return the pointer to the first block
        lea eax, [esi + TYPE(TSmallBlockPoolHeader)]
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        lea edx, [eax + ecx]
        mov [ebx.TSmallBlockType.NextSequentialFeedBlockAddress], edx
        add edi, esi
        sub edi, ecx
        mov [ebx.TSmallBlockType.MaxSequentialFeedBlockAddress], edi
        ; Unlock the small block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Set the small block header
        mov [eax - 4], esi
        ; Restore registers
        pop edi
        pop esi
        pop ebx
        ; Done
        ret
        ; --------------------------Medium block allocation------------------------
        ; Align branch target
        nop
@GetMem_LockMediumBlocks:
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLocked
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @GetMem_LockMediumBlocks
        ; Couldn't lock the medium blocks - sleep and try again
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLocked
        ; Couldn't lock the medium blocks - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @GetMem_LockMediumBlocks
        ; Align branch target
        nop
        nop
        nop
@GetMem_NotASmallBlock:
        cmp eax, (MaximumMediumBlockSize - BlockHeaderSize)
        ja @GetMem_IsALargeBlockRequest
        ; Get the bin size for this block size. Block sizes are
        ; rounded up to the next bin size.
        lea ebx, [eax + MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset]
        and ebx, -MediumBlockGranularity
        add ebx, MediumBlockSizeOffset
        ; Do we need to lock the medium blocks?
        test cl, cl
        jnz @GetMem_LockMediumBlocks
@GetMem_MediumBlocksLocked:
        ; Get the bin number in ecx and the group number in edx
        lea edx, [ebx - MinimumMediumBlockSize]
        mov ecx, edx
        shr edx, 8 + 5
        shr ecx, 8
        ; Is there a suitable block inside this group?
        mov eax, -1
        shl eax, cl
        and eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
        jz @GetMem_GroupIsEmpty
        ; Get the actual bin number
        and ecx, -32
        bsf eax, eax
        or ecx, eax
        jmp @GetMem_GotBinAndGroup
        ; Align branch target
        nop
        nop
@GetMem_GroupIsEmpty:
        ; Try all groups greater than this group
        mov eax, -2
        mov ecx, edx
        shl eax, cl
        and eax, MediumBlockBinGroupBitmap
        jz @GetMem_TrySequentialFeedMedium
        ; There is a suitable group with space: get the bin number
        bsf edx, eax
        ; Get the bin in the group with free blocks
        mov eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
        bsf ecx, eax
        mov eax, edx
        shl eax, 5
        or ecx, eax
        jmp @GetMem_GotBinAndGroup
        ; Align branch target
        nop
@GetMem_TrySequentialFeedMedium:
        mov ecx, MediumSequentialFeedBytesLeft
        ; Block can be fed sequentially?
        sub ecx, ebx
        jc @GetMem_AllocateNewSequentialFeedForMedium
        ; Get the block address
        mov eax, LastSequentiallyFedMediumBlock
        sub eax, ebx
        mov LastSequentiallyFedMediumBlock, eax
        ; Store the remaining bytes
        mov MediumSequentialFeedBytesLeft, ecx
        ; Set the flags for the block
        or ebx, IsMediumBlockFlag
        mov [eax - 4], ebx
        jmp @GetMem_MediumBlockGetDone
        ; Align branch target
@GetMem_AllocateNewSequentialFeedForMedium:
        mov eax, ebx
        FastCall@ _FastMM_AllocNewSequentialFeedMediumPool
@GetMem_MediumBlockGetDone:
        mov MediumBlocksLocked, 0 ; false
        pop ebx
        ret
        ; Align branch target
@GetMem_GotBinAndGroup:
        ; ebx = block size, ecx = bin number, edx = group number
        push esi
        push edi
        ; Get a pointer to the bin in edi
        lea edi, [MediumBlockBins + ecx * 8]
        ; Get the free block in esi
        mov esi, [edi.TMediumFreeBlock.NextFreeBlock]
        ; Remove the first block from the linked list (LIFO)
        mov eax, [esi.TMediumFreeBlock.NextFreeBlock]
        mov [edi.TMediumFreeBlock.NextFreeBlock], eax
        mov [eax.TMediumFreeBlock.PreviousFreeBlock], edi
        ; Is this bin now empty?
        cmp edi, eax
        jne @GetMem_MediumBinNotEmptyForMedium
        ; eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block size
        ; Flag this bin as empty
        mov eax, -2
        rol eax, cl
        and dword ptr [MediumBlockBinBitmaps + edx * 4], eax
        jnz @GetMem_MediumBinNotEmptyForMedium
        ; Flag the group as empty
        btr MediumBlockBinGroupBitmap, edx
@GetMem_MediumBinNotEmptyForMedium:
        ; esi = free block, ebx = block size
        ; Get the size of the available medium block in edi
        mov edi, DropMediumAndLargeFlagsMask
        and edi, [esi - 4]
        ; Get the size of the second split in edx
        mov edx, edi
        sub edx, ebx
        jz @GetMem_UseWholeBlockForMedium
        ; Split the block in two
        lea eax, [esi + ebx]
        lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [eax - 4], ecx
        ; Store the size of the second split as the second last dword
        mov [eax + edx - 8], edx
        ; Put the remainder in a bin
        cmp edx, MinimumMediumBlockSize
        jb @GetMem_GotMediumBlockForMedium
        FastCall@ _FastMM_InsertMediumBlockIntoBin
        jmp @GetMem_GotMediumBlockForMedium
        ; Align branch target
        nop
        nop
        nop
@GetMem_UseWholeBlockForMedium:
        ; Mark this block as used in the block following it
        and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GetMem_GotMediumBlockForMedium:
        ; Set the size and flags for this block
        lea ecx, [ebx + IsMediumBlockFlag]
        mov [esi - 4], ecx
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        mov eax, esi
        pop edi
        pop esi
        pop ebx
        ret
        ; ---------------------------Large block allocation------------------------
        ; Align branch target
@GetMem_IsALargeBlockRequest:
        pop ebx
        test eax, eax
        FastCallOp@ jns _FastMM_AllocateLargeBlock
        xor eax, eax

        Return@
EndFunc@ _FastMM_GetMem


;----------------------------------------------------------------------
; Name          _FastMM_FreeMem
;
; Usage         int __FASTCALL _FastMM_FreeMem(void *P)
;
; Note          Release memory
;----------------------------------------------------------------------

Func@   _FastMM_FreeMem, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = P

        ; Get the block header in edx
        mov edx, [eax - 4]
        ; Is it a small block in use?
        test dl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
        ; Save the pointer in ecx
        mov ecx, eax
        ; Save ebx
        push ebx
        ; Get the IsMultiThread variable in bl
        mov bl, IsMultiThread
        ; Is it a small block that is in use?
        jnz @FreeMem_NotSmallBlockInUse
        ; Do we need to lock the block type?
        test bl, bl
        ; Get the small block type in ebx
        mov ebx, [edx.TSmallBlockPoolHeader.BlockType]
        ; Do we need to lock the block type?
        jnz @FreeMem_LockBlockTypeLoop
@FreeMem_GotLockOnSmallBlockType:
        ; Current state: edx = @SmallBlockPoolHeader, ecx = P, ebx = @SmallBlockType
        ; Decrement the number of blocks in use
        sub [edx.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Get the old first free block
        mov eax, [edx.TSmallBlockPoolHeader.FirstFreeBlock]
        ; Is the pool now empty?
        jz @FreeMem_PoolIsNowEmpty
        ; Was the pool full?
        test eax, eax
        ; Store this as the new first free block
        mov [edx.TSmallBlockPoolHeader.FirstFreeBlock], ecx
        ; Store the previous first free block as the block header
        lea eax, [eax + IsFreeBlockFlag]
        mov [ecx - 4], eax
        ; Insert the pool back into the linked list if it was full
        jz @FreeMem_SmallPoolWasFull
        ; All ok
        xor eax, eax
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], al
        ; Restore registers
        pop ebx
        ; Done
        ret
        ; Align branch target
        nop
@FreeMem_SmallPoolWasFull:
        ; Insert this as the first partially free pool for the block size
        mov ecx, [ebx.TSmallBlockType.NextPartiallyFreePool]
        mov [edx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], ebx
        mov [edx.TSmallBlockPoolHeader.NextPartiallyFreePool], ecx
        mov [ecx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], edx
        mov [ebx.TSmallBlockType.NextPartiallyFreePool], edx
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; All ok
        xor eax, eax
        ; Restore registers
        pop ebx
        ; Done
        ret
        ; Align branch target
        nop
        nop
@FreeMem_PoolIsNowEmpty:
        ; Was this pool actually in the linked list of pools with space? If not, it
        ; can only be the sequential feed pool (it is the only pool that may contain
        ; only one block, i.e. other blocks have not been split off yet)
        test eax, eax
        jz @FreeMem_IsSequentialFeedPool
        ; Pool is now empty: Remove it from the linked list and free it
        mov eax, [edx.TSmallBlockPoolHeader.PreviousPartiallyFreePool]
        mov ecx, [edx.TSmallBlockPoolHeader.NextPartiallyFreePool]
        ; Remove this manager
        mov [eax.TSmallBlockPoolHeader.NextPartiallyFreePool], ecx
        mov [ecx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], eax
        ; Zero out eax
        xor eax, eax
        ; Is this the sequential feed pool? If so, stop sequential feeding
        cmp [ebx.TSmallBlockType.CurrentSequentialFeedPool], edx
        jne @FreeMem_NotSequentialFeedPool
@FreeMem_IsSequentialFeedPool:
        mov [ebx.TSmallBlockType.MaxSequentialFeedBlockAddress], eax
@FreeMem_NotSequentialFeedPool:
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], al
        ; Release this pool
        mov eax, edx
        mov edx, [edx - 4]
        mov bl, IsMultiThread
        jmp @FreeMem_FreeMediumBlock
        ; Align branch target
@FreeMem_LockBlockTypeLoop:
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @FreeMem_GotLockOnSmallBlockType
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @FreeMem_LockBlockTypeLoop
        ; Couldn't grab the block type - sleep and try again
        push ecx
        push edx
        push InitialSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @FreeMem_GotLockOnSmallBlockType
        ; Couldn't grab the block type - sleep and try again
        push ecx
        push edx
        push AdditionalSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        jmp @FreeMem_LockBlockTypeLoop
        ; Align branch target
        nop
        nop
        nop
        ; -----------------------------Medium blocks-----------------------------
@FreeMem_LockMediumBlocks:
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @FreeMem_MediumBlocksLocked
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @FreeMem_LockMediumBlocks
        ; Couldn't lock the medium blocks - sleep and try again
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @FreeMem_MediumBlocksLocked
        ; Couldn't lock the medium blocks - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @FreeMem_LockMediumBlocks
        ; Align branch target
        nop
        nop
        nop
@FreeMem_NotSmallBlockInUse:
        ; Not a small block in use: is it a medium or large block?
        test dl, IsFreeBlockFlag + IsLargeBlockFlag
        jnz @FreeMem_NotASmallOrMediumBlock
@FreeMem_FreeMediumBlock:
        ; Drop the flags
        and edx, DropMediumAndLargeFlagsMask
        ; Free the large block pointed to by eax, header in edx, bl = IsMultiThread
        ; Do we need to lock the medium blocks?
        test bl, bl
        ; Block size in ebx
        mov ebx, edx
        ; Save registers
        push esi
        ; Pointer in esi
        mov esi, eax
        ; Do we need to lock the medium blocks?
        jnz @FreeMem_LockMediumBlocks
@FreeMem_MediumBlocksLocked:
        ; Can we combine this block with the next free block?
        test dword ptr [esi + ebx - 4], IsFreeBlockFlag
        ; Get the next block size and flags in ecx
        mov ecx, [esi + ebx - 4]
        jnz @FreeMem_NextBlockIsFree
        ; Set the "PreviousIsFree" flag in the next block
        or ecx, PreviousMediumBlockIsFreeFlag
        mov [esi + ebx - 4], ecx
@FreeMem_NextBlockChecked:
        ; Can we combine this block with the previous free block? We need to
        ; re-read the flags since it could have changed before we could lock the
        ; medium blocks.
        test byte ptr [esi - 4], PreviousMediumBlockIsFreeFlag
        jnz @FreeMem_PreviousBlockIsFree
@FreeMem_PreviousBlockChecked:
        ; Is the entire medium block pool free, and there are other free blocks
        ; that can fit the largest possible medium block -> free it.
        cmp ebx, (MediumBlockPoolSize - MediumBlockPoolHeaderSize)
        je @FreeMem_EntireMediumPoolFree
@FreeMem_BinFreeMediumBlock:
        ; Store the size of the block as well as the flags
        lea eax, [ebx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [esi - 4], eax
        ; Store the trailing size marker
        mov [esi + ebx - 8], ebx
        ; Insert this block back into the bins: Size check not required here,
        ; since medium blocks that are in use are not allowed to be
        ; shrunk smaller than MinimumMediumBlockSize
        mov eax, esi
        mov edx, ebx
        ; Insert into bin
        FastCall@ _FastMM_InsertMediumBlockIntoBin
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; All OK
        xor eax, eax
        ; Restore registers
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
        nop
@FreeMem_NextBlockIsFree:
        ; Get the next block address in eax
        lea eax, [esi + ebx]
        ; Increase the size of this block
        and ecx, DropMediumAndLargeFlagsMask
        add ebx, ecx
        ; Was the block binned?
        cmp ecx, MinimumMediumBlockSize
        jb @FreeMem_NextBlockChecked
        FastCall@ _FastMM_RemoveMediumFreeBlock
        jmp @FreeMem_NextBlockChecked
        ; Align branch target
        nop
@FreeMem_PreviousBlockIsFree:
        ; Get the size of the free block just before this one
        mov ecx, [esi - 8]
        ; Include the previous block
        sub esi, ecx
        ; Set the new block size
        add ebx, ecx
        ; Remove the previous block from the linked list
        cmp ecx, MinimumMediumBlockSize
        jb @FreeMem_PreviousBlockChecked
        mov eax, esi
        FastCall@ _FastMM_RemoveMediumFreeBlock
        jmp @FreeMem_PreviousBlockChecked
        ; Align branch target
@FreeMem_EntireMediumPoolFree:
        ; Should we make this the new sequential feed medium block pool? If the
        ; current sequential feed pool is not entirely free, we make this the new
        ; sequential feed pool.
        cmp MediumSequentialFeedBytesLeft, MediumBlockPoolSize - MediumBlockPoolHeaderSize
        jne @FreeMem_MakeEmptyMediumPoolSequentialFeed
        ; Point esi to the medium block pool header
        sub esi, TYPE(TMediumBlockPoolHeader)
        ; Remove this medium block pool from the linked list
        mov eax, [esi.TMediumBlockPoolHeader.PreviousMediumBlockPoolHeader]
        mov edx, [esi.TMediumBlockPoolHeader.NextMediumBlockPoolHeader]
        mov [eax.TMediumBlockPoolHeader.NextMediumBlockPoolHeader], edx
        mov [edx.TMediumBlockPoolHeader.PreviousMediumBlockPoolHeader], eax
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Free the medium block pool
        push MEM_RELEASE
        push 0
        push esi
        call VirtualFree
        ; VirtualFree returns >0 if all is ok
        cmp eax, 1
        ; Return 0 on all ok
        sbb eax, eax
        ; Restore registers
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
        nop
        nop
@FreeMem_MakeEmptyMediumPoolSequentialFeed:
        ; Get a pointer to the end-marker block
        lea ebx, [esi + MediumBlockPoolSize - MediumBlockPoolHeaderSize]
        ; Bin the current sequential feed pool
        FastCall@ _FastMM_BinMediumSequentialFeedRemainder
        ; Set this medium pool up as the new sequential feed pool:
        ; Store the sequential feed pool trailer
        mov dword ptr [ebx - BlockHeaderSize], IsMediumBlockFlag
        ; Store the number of bytes available in the sequential feed chunk
        mov MediumSequentialFeedBytesLeft, MediumBlockPoolSize - MediumBlockPoolHeaderSize
        ; Set the last sequentially fed block
        mov LastSequentiallyFedMediumBlock, ebx
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Success
        xor eax, eax
        ; Restore registers
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
        nop
@FreeMem_NotASmallOrMediumBlock:
        ; Restore ebx
        pop ebx
        ; Is it in fact a large block?
        test dl, IsFreeBlockFlag + IsMediumBlockFlag
        FastCallOp@ jz _FastMM_FreeLargeBlock
        ; Attempt to free an already free block
        mov eax, -1

        Return@
EndFunc@ _FastMM_FreeMem


;----------------------------------------------------------------------
; Name          _FastMM_ReallocMem
;
; Usage         void* __FASTCALL _FastMM_ReallocMem(void *P, size_t Size)
;
; Note          Reallocate memory
;----------------------------------------------------------------------

Func@   _FastMM_ReallocMem, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = P
        ;   edx = Size

        ; Get the block header: Is it actually a small block?
        mov ecx, [eax - 4]
        ; Is it a small block?
        test cl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
        ; Save ebx
        push ebx
        ; Save esi
        push esi
        ; Save the original pointer in esi
        mov esi, eax
        ; Is it a small block?
        jnz @ReallocMem_NotASmallBlock
        ; ----------------------------Small block--------------------------------
        ; Get the block type in ebx
        mov ebx, [ecx.TSmallBlockPoolHeader.BlockType]
        ; Get the available size inside blocks of this type.
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        sub ecx, 4
        ; Is it an upsize or a downsize?
        cmp ecx, edx
        jb @ReallocMem_SmallUpsize
        ; It's a downsize. Do we need to allocate a smaller block? Only if the new
        ; size is less than a quarter of the available size less
        ; SmallBlockDownsizeCheckAdder bytes
        lea ebx, [edx * 4 + SmallBlockDownsizeCheckAdder]
        cmp ebx, ecx
        jb @ReallocMem_NotSmallInPlaceDownsize
        ; In-place downsize - return the original pointer
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
@ReallocMem_NotSmallInPlaceDownsize:
        ; Save the requested size
        mov ebx, edx
        ; Allocate a smaller block
        mov eax, edx
        FastCall@ _FastMM_GetMem
        ; Allocated OK?
        test eax, eax
        jz @ReallocMem_SmallDownsizeDone
        ; Move data across: count in ecx
        mov ecx, ebx
        ; Destination in edx
        mov edx, eax
        ; Save the result in ebx
        mov ebx, eax
        ; Original pointer in eax
        mov eax, esi
        ; Move the data across
    ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
        FastCall@ _FastMM_MoveX8L4
    else
        FastCall@ _internal_memmove
    endif
        ; Free the original pointer
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Return the pointer
        mov eax, ebx
@ReallocMem_SmallDownsizeDone:
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
        nop
@ReallocMem_SmallUpsize:
        ; State: esi = P, edx = Size, ecx = Current Block Size, ebx = Current Block Type
        ; This pointer is being reallocated to a larger block and therefore it is
        ; logical to assume that it may be enlarged again. Since reallocations are
        ; expensive, there is a minimum upsize percentage to avoid unnecessary
        ; future move operations.
        ; Small blocks always grow with at least 100% + SmallBlockUpsizeAdder bytes
        lea ecx, [ecx + ecx + SmallBlockUpsizeAdder]
        ; save edi
        push edi
        ; Save the requested size in edi
        mov edi, edx
        ; New allocated size is the maximum of the requested size and the minimum
        ; upsize
        xor eax, eax
        sub ecx, edx
        adc eax, -1
        and eax, ecx
        add eax, edx
        ; Allocate the new block
        FastCall@ _FastMM_GetMem
        ; Allocated OK?
        test eax, eax
        jz @ReallocMem_SmallUpsizeDone
        ; Do we need to store the requested size? Only large blocks store the
        ; requested size.
        cmp edi, MaximumMediumBlockSize - BlockHeaderSize
        jbe @ReallocMem_NotSmallUpsizeToLargeBlock
        ; Store the user requested size
        mov [eax - 8], edi
@ReallocMem_NotSmallUpsizeToLargeBlock:
        ; Get the size to move across
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        sub ecx, BlockHeaderSize
        ; Move to the new block
        mov edx, eax
        ; Save the result in edi
        mov edi, eax
        ; Move from the old block
        mov eax, esi
        ; Move the data across
    ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
        call [ebx.TSmallBlockType.UpsizeMoveProcedure]
    else
        FastCall@ _internal_memmove
    endif
        ; Free the old pointer
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Done
        mov eax, edi
@ReallocMem_SmallUpsizeDone:
        pop edi
        pop esi
        pop ebx
        ret
        ; Align branch target
    ifndef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
        nop
        nop
    endif
        nop
@ReallocMem_NotASmallBlock:
        ; Is this a medium block or a large block?
        test cl, IsFreeBlockFlag + IsLargeBlockFlag
        jnz @ReallocMem_PossibleLargeBlock
        ; ----------------------------Medium block-------------------------------
        ; Status: ecx = Current Block Size + Flags, eax/esi = P,
        ; edx = Requested Size
        mov ebx, ecx
        ; Drop the flags from the header
        and ecx, DropMediumAndLargeFlagsMask
        ; Save edi
        push edi
        ; Get a pointer to the next block in edi
        lea edi, [eax + ecx]
        ; Subtract the block header size from the old available size
        sub ecx, BlockHeaderSize
        ; Get the complete flags in ebx
        and ebx, ExtractMediumAndLargeFlagsMask
        ; Is it an upsize or a downsize?
        cmp edx, ecx
        ; Save ebp
        push ebp
        ; Is it an upsize or a downsize?
        ja @ReallocMem_MediumBlockUpsize
        ; Status: ecx = Current Block Size - 4, bl = Current Block Flags,
        ; edi = @Next Block, eax/esi = P, edx = Requested Size
        ; Must be less than half the current size or we don't bother resizing.
        lea ebp, [edx + edx]
        cmp ebp, ecx
        jb @ReallocMem_MediumMustDownsize
@ReallocMem_MediumNoResize:
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
        nop
        nop
        nop
@ReallocMem_MediumMustDownsize:
        ; In-place downsize? Balance the cost of moving the data vs. the cost of
        ; fragmenting the memory pool. Medium blocks in use may never be smaller
        ; than MinimumMediumBlockSize.
        cmp edx, MinimumMediumBlockSize - BlockHeaderSize
        jae @ReallocMem_MediumBlockInPlaceDownsize
        ; The requested size is less than the minimum medium block size. If the
        ; requested size is less than the threshold value (currently a quarter of the
        ; minimum medium block size), move the data to a small block, otherwise shrink
        ; the medium block to the minimum allowable medium block size.
        cmp edx, MediumInPlaceDownsizeLimit
        jb @ReallocMem_MediumDownsizeRealloc
        ; The request is for a size smaller than the minimum medium block size, but
        ; not small enough to justify moving data: Reduce the block size to the
        ; minimum medium block size
        mov edx, MinimumMediumBlockSize - BlockHeaderSize
        ; Is it already at the minimum medium block size?
        cmp ecx, edx
        jna @ReallocMem_MediumNoResize
@ReallocMem_MediumBlockInPlaceDownsize:
        ; Round up to the next medium block size
        lea ebp, [edx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
        and ebp, -MediumBlockGranularity;
        add ebp, MediumBlockSizeOffset
        ; Get the size of the second split
        add ecx, BlockHeaderSize
        sub ecx, ebp
        ; Lock the medium blocks
        cmp IsMultiThread, 0 ; false
        je @ReallocMem_DoMediumInPlaceDownsize
        ; We have to re-read the flags
@ReallocMem_DoMediumLockForDownsize:
        ; Lock the medium blocks
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_MediumDownsizeRereadFlags
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @ReallocMem_DoMediumLockForDownsize
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push InitialSleepTime
        call Sleep
        pop ecx
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_MediumDownsizeRereadFlags
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push AdditionalSleepTime
        call Sleep
        pop ecx
        ; Try again
        jmp @ReallocMem_DoMediumLockForDownsize
        ; Align branch target
        nop
@ReallocMem_MediumDownsizeRereadFlags:
        mov ebx, ExtractMediumAndLargeFlagsMask
        and ebx, [esi - 4]
@ReallocMem_DoMediumInPlaceDownsize:
        ; Set the new size
        or ebx, ebp
        mov [esi - 4], ebx
        ; Get the second split size in ebx
        mov ebx, ecx
        ; Is the next block in use?
        mov edx, [edi - 4]
        test dl, IsFreeBlockFlag
        jnz @ReallocMem_MediumDownsizeNextBlockFree
        ; The next block is in use: flag its previous block as free
        or edx, PreviousMediumBlockIsFreeFlag
        mov [edi - 4], edx
        jmp @ReallocMem_MediumDownsizeDoSplit
        ; Align branch target
        nop
@ReallocMem_MediumDownsizeNextBlockFree:
        ; The next block is free: combine it
        mov eax, edi
        and edx, DropMediumAndLargeFlagsMask
        add ebx, edx
        add edi, edx
        cmp edx, MinimumMediumBlockSize
        jb @ReallocMem_MediumDownsizeDoSplit
        FastCall@ _FastMM_RemoveMediumFreeBlock
@ReallocMem_MediumDownsizeDoSplit:
        ; Store the trailing size field
        mov [edi - 8], ebx
        ; Store the free part's header
        lea eax, [ebx + IsMediumBlockFlag + IsFreeBlockFlag];
        mov [esi + ebp - 4], eax
        ; Bin this free block
        cmp ebx, MinimumMediumBlockSize
        jb @ReallocMem_MediumBlockDownsizeDone
        lea eax, [esi + ebp]
        mov edx, ebx
        FastCall@ _FastMM_InsertMediumBlockIntoBin
@ReallocMem_MediumBlockDownsizeDone:
        ; Unlock the medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Result = old pointer
        mov eax, esi
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
@ReallocMem_MediumDownsizeRealloc:
        ; Save the requested size
        mov edi, edx
        mov eax, edx
        ; Allocate the new block
        FastCall@ _FastMM_GetMem
        test eax, eax
        jz @ReallocMem_MediumBlockDownsizeExit
        ; Save the result
        mov ebp, eax
        mov edx, eax
        mov eax, esi
        mov ecx, edi
        ; Move the data across
    ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
        FastCall@ _FastMM_MoveX8L4
    else
        FastCall@ _internal_memmove
    endif
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Return the result
        mov eax, ebp
@ReallocMem_MediumBlockDownsizeExit:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        ; Align branch target
@ReallocMem_MediumBlockUpsize:
        ; Status: ecx = Current Block Size - 4, bl = Current Block Flags,
        ; edi = @Next Block, eax/esi = P, edx = Requested Size
        ; Can we do an in-place upsize?
        mov eax, [edi - 4]
        test al, IsFreeBlockFlag
        jz @ReallocMem_CannotUpsizeMediumBlockInPlace
        ; Get the total available size including the next block
        and eax, DropMediumAndLargeFlagsMask
        ; ebp = total available size including the next block (excluding the header)
        lea ebp, [eax + ecx]
        ; Can the block fit?
        cmp edx, ebp
        ja @ReallocMem_CannotUpsizeMediumBlockInPlace
        ; The next block is free and there is enough space to grow this
        ; block in place.
        cmp IsMultiThread, 0 ; false
        je @ReallocMem_DoMediumInPlaceUpsize
@ReallocMem_DoMediumLockForUpsize:
        ; Lock the medium blocks
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_RecheckMediumInPlaceUpsize
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @ReallocMem_DoMediumLockForUpsize
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push edx
        push InitialSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_RecheckMediumInPlaceUpsize
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push edx
        push AdditionalSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        jmp @ReallocMem_DoMediumLockForUpsize
        ; Align branch target
        nop
@ReallocMem_RecheckMediumInPlaceUpsize:
        ; Re-read the info for this block
        mov ebx, ExtractMediumAndLargeFlagsMask
        and ebx, [esi - 4]
        ; Re-read the info for the next block
        mov eax, [edi - 4]
        ; Next block still free?
        test al, IsFreeBlockFlag
        jz @ReallocMem_NextMediumBlockChanged
        ; Recalculate the next block size
        and eax, DropMediumAndLargeFlagsMask
        ; The available size including the next block
        lea ebp, [eax + ecx]
        ; Can the block still fit?
        cmp edx, ebp
        ja @ReallocMem_NextMediumBlockChanged
@ReallocMem_DoMediumInPlaceUpsize:
        ; Is the next block binnable?
        cmp eax, MinimumMediumBlockSize
        ; Remove the next block
        jb @ReallocMem_MediumInPlaceNoNextRemove
        mov eax, edi
        push ecx
        push edx
        FastCall@ _FastMM_RemoveMediumFreeBlock
        pop edx
        pop ecx
@ReallocMem_MediumInPlaceNoNextRemove:
        ; Medium blocks grow a minimum of 25% in in-place upsizes
        mov eax, ecx
        shr eax, 2
        add eax, ecx
        ; Get the maximum of the requested size and the minimum growth size
        xor edi, edi
        sub eax, edx
        adc edi, -1
        and eax, edi
        ; Round up to the nearest block size granularity
        lea eax, [eax + edx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
        and eax, -MediumBlockGranularity
        add eax, MediumBlockSizeOffset
        ; Calculate the size of the second split
        lea edx, [ebp + BlockHeaderSize]
        sub edx, eax
        ; Does it fit?
        ja @ReallocMem_MediumInPlaceUpsizeSplit
        ; Grab the whole block: Mark it as used in the block following it
        and dword ptr [esi + ebp], not PreviousMediumBlockIsFreeFlag
        ; The block size is the full available size plus header
        add ebp, 4
        ; Upsize done
        jmp @ReallocMem_MediumUpsizeInPlaceDone
        ; Align branch target
        nop
        nop
@ReallocMem_MediumInPlaceUpsizeSplit:
        ; Store the size of the second split as the second last dword
        mov [esi + ebp - 4], edx
        ; Set the second split header
        lea edi, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [esi + eax - 4], edi
        mov ebp, eax
        cmp edx, MinimumMediumBlockSize
        jb @ReallocMem_MediumUpsizeInPlaceDone
        add eax, esi
        FastCall@ _FastMM_InsertMediumBlockIntoBin
@ReallocMem_MediumUpsizeInPlaceDone:
        ; Set the size and flags for this block
        or ebp, ebx
        mov [esi - 4], ebp
        ; Unlock the medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Result = old pointer
        mov eax, esi
@ReallocMem_MediumBlockResizeDone2:
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target for @ReallocMem_CannotUpsizeMediumBlockInPlace
        nop
        nop
@ReallocMem_NextMediumBlockChanged:
        ; The next medium block changed while the medium blocks were being locked
        mov MediumBlocksLocked, 0 ; false
@ReallocMem_CannotUpsizeMediumBlockInPlace:
        ; Couldn't upsize in place. Grab a new block and move the data across:
        ; If we have to reallocate and move medium blocks, we grow by at
        ; least 25%
        mov eax, ecx
        shr eax, 2
        add eax, ecx
        ; Get the maximum of the requested size and the minimum growth size
        xor edi, edi
        sub eax, edx
        adc edi, -1
        and eax, edi
        add eax, edx
        ; Save the size to allocate
        mov ebp, eax
        ; Save the size to move across
        mov edi, ecx
        ; Get the block
        push edx
        FastCall@ _FastMM_GetMem
        pop edx
        ; Success?
        test eax, eax
        jz @ReallocMem_MediumBlockResizeDone2
        ; If it's a Large block - store the actual user requested size
        cmp ebp, MaximumMediumBlockSize - BlockHeaderSize
        jbe @ReallocMem_MediumUpsizeNotLarge
        mov [eax - 8], edx
@ReallocMem_MediumUpsizeNotLarge:
        ; Save the result
        mov ebp, eax
        ; Move the data across
        mov edx, eax
        mov eax, esi
        mov ecx, edi
    ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
        FastCall@ _FastMM_MoveX16L4
    else
        FastCall@ _internal_memmove
    endif
        ; Free the old block
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Restore the result
        mov eax, ebp
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
        nop
@ReallocMem_PossibleLargeBlock:
        ; -----------------------Large block------------------------------
        ; Restore registers
        pop esi
        pop ebx
        ; Is this a valid large block?
        test cl, IsFreeBlockFlag + IsMediumBlockFlag
        FastCallOp@ jz _FastMM_ReallocateLargeBlock
        ; -----------------------Invalid block------------------------------
        xor eax, eax

        Return@
EndFunc@ _FastMM_ReallocMem

;----------------------------------------------------------------------
; Name          _FastMM_AllocMem
;
; Usage         void* __FASTCALL _FastMM_AllocMem(size_t Size)
;
; Note          Allocates a block and fills it with zeroes
;----------------------------------------------------------------------

Func@   _FastMM_AllocMem, _EXPFUNC, fastcall
        push ebx
        ; Get the size rounded down to the previous multiple of 4 into ebx
        lea ebx, [eax - 1]
        and ebx, -4
        ; Get the block
        FastCall@ _FastMM_GetMem
        ; Could a block be allocated? ecx = 0 if yes, 0xffffffff if no
        cmp eax, 1
        sbb ecx, ecx
        ; Point edx to the last dword
        lea edx, [eax + ebx]
        ; ebx = 0xffffffff if no block could be allocated, otherwise size rounded down
        ; to previous multiple of 4
        or ebx, ecx
        ; Large blocks are already zero filled
        cmp ebx, MaximumMediumBlockSize - BlockHeaderSize
        jae @AllocMem_Done
        ; Make the counter negative based
        neg ebx
        ; Load zero into st(0)
        fldz
        ; Clear groups of 8 bytes. Block sizes are always four less than a multiple
        ; of 8, with a minimum of 12 bytes
@AllocMem_FillLoop:
        fst qword ptr [edx + ebx]
        add ebx, 8
        js @AllocMem_FillLoop
        ; Clear the last four bytes
        mov [edx], ecx
        ; Clear st(0)
        ffree st(0)
        ; Correct the stack top
        fincstp
@AllocMem_Done:
        pop ebx

        Return@
EndFunc@ _FastMM_AllocMem

endif ; !USE_C_CODE


; --------------------Memory Leak Checking and Reporting-------------------

ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE

;----------------------------------------------------------------------
; Name          _FastMM_CardinalToStrBuf
;
; Usage         char* __FASTCALL _FastMM_CardinalToStrBuf(unsigned int ACardinal, char *ABuffer)
;
; Note          Converts a cardinal to string at the buffer location, returning the new
;               buffer position.
;----------------------------------------------------------------------

Func@   _FastMM_CardinalToStrBuf, _EXPFUNC, fastcall
        ; On entry: eax = ACardinal, edx = ABuffer
        push edi
        mov edi, edx                ; Pointer to the first character in edi
        ; Calculate leading digit: divide the number by 1e9
        add eax, 1                  ; Increment the number
        mov edx, 89705f41h          ; 1e9 reciprocal
        mul edx                     ; Multplying with reciprocal
        shr eax, 30                 ; Save fraction bits
        mov ecx, edx                ; First digit in bits <31:29>
        and edx, 1fffffffh          ; Filter fraction part edx<28:0>
        shr ecx, 29                 ; Get leading digit into accumulator
        lea edx, [edx + edx * 4]    ; Calculate ...
        add edx, eax                ; ... 5*fraction
        mov eax, ecx                ; Copy leading digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #2
        mov eax, edx                ; Point format such that 1.0 = 2^28
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 28                 ; Next digit
        and edx, 0fffffffh          ; Fraction part edx<27:0>
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #3
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:27>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<26:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 27                 ; Next digit
        and edx, 07ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #4
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:26>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<25:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 26                 ; Next digit
        and edx, 03ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #5
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:25>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<24:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 25                 ; Next digit
        and edx, 01ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #6
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:24>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<23:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 24                 ; Next digit
        and edx, 00ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #7
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:23>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<31:23>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 23                 ; Next digit
        and edx, 007fffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #8
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:22>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<22:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 22                 ; Next digit
        and edx, 003fffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #9
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:21>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<21:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 21                 ; Next digit
        and edx, 001fffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #10
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:20>
        cmp ecx, 1                  ; Any-non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 20                 ; Next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store last digit and end marker out to memory
        ; Return a pointer to the next character
        lea eax, [edi + 1]
        ; Restore edi
        pop edi

        Return@
EndFunc@ _FastMM_CardinalToStrBuf

endif ; INCLUDE_MEMORYLEAK_TRACKING_CODE

;----------------------------------------------------------------------

Code_EndS@

        end

;[]-----------------------------------------------------------------[]
;|   _FASTMMA.ASM -- FastMM memory manager assembler code            |
;[]-----------------------------------------------------------------[]

; $Revision: $

        include rules.asi
        include init.inc

Header@

pause   MACRO
            db 0f3h, 90h
        ENDM

;----------------------------------------------------------------------

; Enable to use the C code path
;USE_C_CODE                            = 1
; Use custom fixed size move routines for some small blocks
USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES    = 1

; Use custom variable size move routines for larger blocks
USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES = 1

; Include the memory leak tracking and reporting code. Without this define set
; the memory leak registration functions will do nothing and the memory leak
; report will not be shown on shutdown.
INCLUDE_MEMORYLEAK_TRACKING_CODE       = 1

;----------------------------------------------------------------------

TMediumFreeBlock    STRUCT
    PreviousFreeBlock   dd  ?   ; TMediumFreeBlock*
    NextFreeBlock       dd  ?   ; TMediumFreeBlock*
TMediumFreeBlock    ENDS

TSmallBlockType     STRUCT
    BlockTypeLocked                     db  ?   ; char
    AllowedGroupsForBlockPoolBitmap     db  ?   ; char
    BlockSize                           dw  ?   ; WORD
    NextPartiallyFreePool               dd  ?   ; PSmallBlockPoolHeader
    NextSequentialFeedBlockAddress      dd  ?   ; LPVOID

    MaxSequentialFeedBlockAddress       dd  ?   ; LPVOID
    CurrentSequentialFeedPool           dd  ?   ; PSmallBlockPoolHeader
    PreviousPartiallyFreePool           dd  ?   ; PSmallBlockPoolHeader
    MinimumBlockPoolSize                dw  ?   ; WORD
    OptimalBlockPoolSize                dw  ?   ; WORD
  ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
    UpsizeMoveProcedure                 dd  ?   ; TMoveProc
  else
    Reserved                            dd  ?   ; DWORD
  endif
TSmallBlockType     ENDS

TSmallBlockPoolHeader   STRUCT
    BlockType                       dd  ?   ; PSmallBlockType
    NextPartiallyFreePool           dd  ?   ; PSmallBlockPoolHeader
    FirstFreeBlock                  dd  ?   ; LPVOID
    BlocksInUse                     dd  ?   ; DWORD
    SmallBlockPoolSignature         dd  ?   ; DWORD
    PreviousPartiallyFreePool       dd  ?   ; PSmallBlockPoolHeader
    Reserved1                       dd  ?   ; DWORD
    FirstBlockPoolPointerAndFlags   dd  ?   ; DWORD
TSmallBlockPoolHeader   ENDS

TMediumBlockPoolHeader  STRUCT
    PreviousMediumBlockPoolHeader   dd  ?   ; PMediumBlockPoolHeader
    NextMediumBlockPoolHeader       dd  ?   ; PMediumBlockPoolHeader
    Reserved                        dd  ?   ; DWORD
    FirstMediumBlockSizeAndFlags    dd  ?   ; DWORD
TMediumBlockPoolHeader  ENDS


;----------------------------------------------------------------------

MEM_COMMIT                      EQU     1000h
MEM_RESERVE                     EQU     2000h
MEM_DECOMMIT                    EQU     4000h
MEM_RELEASE                     EQU     8000h
MEM_FREE                        EQU     10000h
MEM_PRIVATE                     EQU     20000h
MEM_MAPPED                      EQU     40000h
MEM_RESET                       EQU     80000h
MEM_TOP_DOWN                    EQU     100000h


InitialSleepTime                EQU     0
AdditionalSleepTime             EQU     10

BlockHeaderSize                 EQU     4
MaximumSmallBlockSize           EQU     2608
IsSmallBlockPoolInUseFlag       EQU     4
IsLargeBlockFlag                EQU     4

DropSmallFlagsMask              EQU     -8
ExtractSmallFlagsMask           EQU     7

MediumBlockPoolSize             EQU     (20 * 64 * 1024 - 16)
MediumBlockSizeOffset           EQU     48
MinimumMediumBlockSize          EQU     (11 * 256 + MediumBlockSizeOffset)
MediumBlockBinsPerGroup         EQU     32
MediumBlockBinGroupCount        EQU     32
MediumBlockBinCount             EQU     (MediumBlockBinGroupCount * MediumBlockBinsPerGroup)
MaximumMediumBlockSize          EQU     (MinimumMediumBlockSize + (MediumBlockBinCount - 1) * MediumBlockGranularity)
MediumBlockPoolHeaderSize       EQU     TYPE(TMediumBlockPoolHeader)
MediumInPlaceDownsizeLimit      EQU     (MinimumMediumBlockSize / 4)


IsFreeBlockFlag                 EQU     1
IsMediumBlockFlag               EQU     2
PreviousMediumBlockIsFreeFlag   EQU     8

DropMediumAndLargeFlagsMask     EQU     -16
ExtractMediumAndLargeFlagsMask  EQU     15

MediumBlockGranularity          EQU     256
MediumBlockSizeOffset           EQU     48

OptimalSmallBlockPoolSizeLowerLimit EQU (29 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset)
OptimalSmallBlockPoolSizeUpperLimit EQU (64 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset)

MaximumSmallBlockPoolSize       EQU     (OptimalSmallBlockPoolSizeUpperLimit + MinimumMediumBlockSize)
SmallBlockDownsizeCheckAdder    EQU     64
SmallBlockUpsizeAdder           EQU     32

;----------------------------------------------------------------------
;       Segments Definitions

Data_Seg@
    ; char _FastMM_IsMultiThread = 1;
    ExtSym@ _FastMM_IsMultiThread, byte, cdecl
    IsMultiThread                           EQU     __FastMM_IsMultiThread

    ; char _FastMM_NeverSleepOnMMThreadContention = 0
    ExtSym@ _FastMM_NeverSleepOnMMThreadContention, byte, cdecl
    NeverSleepOnMMThreadContention          EQU     __FastMM_NeverSleepOnMMThreadContention

    ; char MediumBlocksLocked = 0;
    ExtSym@ _FastMM_MediumBlocksLocked, byte, cdecl
    MediumBlocksLocked                      EQU     __FastMM_MediumBlocksLocked

    ; DWORD MediumBlockBinBitmaps[MediumBlockBinGroupCount];
    ExtSym@ _FastMM_MediumBlockBinBitmaps, dword, cdecl
    MediumBlockBinBitmaps                   EQU     __FastMM_MediumBlockBinBitmaps

    ; TMediumFreeBlock MediumBlockBins[MediumBlockBinCount];
    ExtSym@ _FastMM_MediumBlockBins, dword, cdecl
    MediumBlockBins                         EQU     __FastMM_MediumBlockBins

    ; DWORD MediumBlockBinGroupBitmap;
    ExtSym@ _FastMM_MediumBlockBinGroupBitmap, dword, cdecl
    MediumBlockBinGroupBitmap               EQU     __FastMM_MediumBlockBinGroupBitmap

    ; LPVOID LastSequentiallyFedMediumBlock;
    ExtSym@ _FastMM_LastSequentiallyFedMediumBlock, dword, cdecl
    LastSequentiallyFedMediumBlock          EQU     __FastMM_LastSequentiallyFedMediumBlock

    ; DWORD MediumSequentialFeedBytesLeft;
    ExtSym@ _FastMM_MediumSequentialFeedBytesLeft, dword, cdecl
    MediumSequentialFeedBytesLeft           EQU     __FastMM_MediumSequentialFeedBytesLeft

    ; char AllocSize2SmallBlockTypeIndX4[MaximumSmallBlockSize / SmallBlockGranularity];
    ExtSym@ _FastMM_AllocSize2SmallBlockTypeIndX4, dword, cdecl
    AllocSize2SmallBlockTypeIndX4           EQU     __FastMM_AllocSize2SmallBlockTypeIndX4

    ; TSmallBlockType SmallBlockTypes[NumSmallBlockTypes] =
    ExtSym@ _FastMM_SmallBlockTypes, dword, cdecl
    SmallBlockTypes                         EQU     __FastMM_SmallBlockTypes

Data_EndS@

;----------------------------------------------------------------------

Code_Seg@

; WiNAPI
ExtFunc@    VirtualFree, stdcall
ExtFunc@    Sleep, stdcall

; FastMM
ExtFunc@    _FastMM_AllocNewSequentialFeedMediumPool, fastcall
ExtFunc@    _FastMM_AllocateLargeBlock, fastcall
ExtFunc@    _FastMM_FreeLargeBlock, fastcall
ExtFunc@    _FastMM_ReallocateLargeBlock, fastcall
ExtFunc@    _internal_memmove, fastcall


;----------------------------------------------------------------------
; Name          _FastMM_LockCmpxchg
;
; Usage         char __FASTCALL _FastMM_LockCmpxchg(char CompareVal, char NewVal, char* AAddress)
;
; Note          Compare [AAddress], CompareVal:
;                 If Equal: [AAddress] = NewVal && result == CompareVal
;                 If Unequal: Result = [AAddress]
;----------------------------------------------------------------------

Func@   _FastMM_LockCmpxchg, _EXPFUNC, fastcall
        ; On entry:
        ;   al = CompareVal,
        ;   dl = NewVal,
        ;   ecx = AAddress

        lock cmpxchg [ecx], dl

        ret
EndFunc@ _FastMM_LockCmpxchg


;----------------------------------------------------------------------
; Name          _FastMM_FindFirstSetBit
;
; Usage         unsigned int __FASTCALL _FastMM_FindFirstSetBit(unsigned int ACardinal)
;
; Note          Gets the first set bit and resets it, returning the bit index
;----------------------------------------------------------------------
ifdef USE_C_CODE

Func@   _FastMM_FindFirstSetBit, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = ACardinal

        bsf eax, eax

        Return@
EndFunc@ _FastMM_FindFirstSetBit

endif ; USE_C_CODE



ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES

;----------------------------------------------------------------------
; Name          _FastMM_Move12
;
; Usage         void __FASTCALL _FastMM_Move12(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move12, _EXPFUNC, fastcall
        mov ecx, [eax]
        mov [edx], ecx
        mov ecx, [eax + 4]
        mov eax, [eax + 8]
        mov [edx + 4], ecx
        mov [edx + 8], eax

        Return@
EndFunc@ _FastMM_Move12

;----------------------------------------------------------------------
; Name          _FastMM_Move20
;
; Usage         void __FASTCALL _FastMM_Move20(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move20, _EXPFUNC, fastcall
        mov ecx, [eax]
        mov [edx], ecx
        mov ecx, [eax + 4]
        mov [edx + 4], ecx
        mov ecx, [eax + 8]
        mov [edx + 8], ecx
        mov ecx, [eax + 12]
        mov eax, [eax + 16]
        mov [edx + 12], ecx
        mov [edx + 16], eax

        Return@
EndFunc@ _FastMM_Move20

;----------------------------------------------------------------------
; Name          _FastMM_Move28
;
; Usage         void __FASTCALL _FastMM_Move28(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move28, _EXPFUNC, fastcall
        mov ecx, [eax]
        mov [edx], ecx
        mov ecx, [eax + 4]
        mov [edx + 4], ecx
        mov ecx, [eax + 8]
        mov [edx + 8], ecx
        mov ecx, [eax + 12]
        mov [edx + 12], ecx
        mov ecx, [eax + 16]
        mov [edx + 16], ecx
        mov ecx, [eax + 20]
        mov eax, [eax + 24]
        mov [edx + 20], ecx
        mov [edx + 24], eax

        Return@
EndFunc@ _FastMM_Move28

;----------------------------------------------------------------------
; Name          _FastMM_Move36
;
; Usage         void __FASTCALL _FastMM_Move36(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move36, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        mov ecx, [eax + 32]
        mov [edx + 32], ecx
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move36

;----------------------------------------------------------------------
; Name          _FastMM_Move44
;
; Usage         void __FASTCALL _FastMM_Move44(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move44, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        mov ecx, [eax + 40]
        mov [edx + 40], ecx
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move44

;----------------------------------------------------------------------
; Name          _FastMM_Move52
;
; Usage         void __FASTCALL _FastMM_Move52(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move52, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        fild qword ptr [eax + 40]
        mov ecx, [eax + 48]
        mov [edx + 48], ecx
        fistp qword ptr [edx + 40]
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move52

;----------------------------------------------------------------------
; Name          _FastMM_Move60
;
; Usage         void __FASTCALL _FastMM_Move60(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move60, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        fild qword ptr [eax + 40]
        fild qword ptr [eax + 48]
        mov ecx, [eax + 56]
        mov [edx + 56], ecx
        fistp qword ptr [edx + 48]
        fistp qword ptr [edx + 40]
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move60

;----------------------------------------------------------------------
; Name          _FastMM_Move68
;
; Usage         void __FASTCALL _FastMM_Move68(void* ASource, void* ADest, int ACount)
;
; Note          Fixed size move operations ignore the size parameter. All moves are assumed to
;               be non-overlapping.
;----------------------------------------------------------------------

Func@   _FastMM_Move68, _EXPFUNC, fastcall
        fild qword ptr [eax]
        fild qword ptr [eax + 8]
        fild qword ptr [eax + 16]
        fild qword ptr [eax + 24]
        fild qword ptr [eax + 32]
        fild qword ptr [eax + 40]
        fild qword ptr [eax + 48]
        fild qword ptr [eax + 56]
        mov ecx, [eax + 64]
        mov [edx + 64], ecx
        fistp qword ptr [edx + 56]
        fistp qword ptr [edx + 48]
        fistp qword ptr [edx + 40]
        fistp qword ptr [edx + 32]
        fistp qword ptr [edx + 24]
        fistp qword ptr [edx + 16]
        fistp qword ptr [edx + 8]
        fistp qword ptr [edx]

        Return@
EndFunc@ _FastMM_Move68

endif ; USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES

ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES

;----------------------------------------------------------------------
; Name          _FastMM_MoveX16L4
;
; Usage         void __FASTCALL _FastMM_MoveX16L4(void* ASource, void* ADest, int ACount)
;
; Note          Variable size move procedure: Assumes ACount is 4 less than a multiple of 16.
;               Always moves at least 12 bytes, irrespective of ACount.
;----------------------------------------------------------------------

Func@   _FastMM_MoveX16L4, _EXPFUNC, fastcall
        ; Make the counter negative based: The last 12 bytes are moved separately
        sub ecx, 12
        add eax, ecx
        add edx, ecx
        neg ecx
        jns @MoveLast12_16
@MoveLoop_16:
        ; Move a 16 byte block
        fild qword ptr [eax + ecx]
        fild qword ptr [eax + ecx + 8]
        fistp qword ptr [edx + ecx + 8]
        fistp qword ptr [edx + ecx]
        ; Are there another 16 bytes to move?
        add ecx, 16
        js @MoveLoop_16
@MoveLast12_16:
        ; Do the last 12 bytes
        fild qword ptr [eax + ecx]
        fistp qword ptr [edx + ecx]
        mov eax, [eax + ecx + 8]
        mov [edx + ecx + 8], eax

        Return@
EndFunc@ _FastMM_MoveX16L4


;----------------------------------------------------------------------
; Name          _FastMM_MoveX8L4
;
; Usage         void __FASTCALL _FastMM_MoveX8L4(void* ASource, void* ADest, int ACount)
;
; Note          Variable size move procedure: Assumes ACount is 4 less than a multiple of 8.
;               Always moves at least 12 bytes, irrespective of ACount.
;----------------------------------------------------------------------

Func@   _FastMM_MoveX8L4, _EXPFUNC, fastcall
        ; Make the counter negative based: The last 4 bytes are moved separately
        sub ecx, 4
        add eax, ecx
        add edx, ecx
        neg ecx
@MoveLoop_8:
        ; Move an 8 byte block
        fild qword ptr [eax + ecx]
        fistp qword ptr [edx + ecx]
        ; Are there another 8 bytes to move?
        add ecx, 8
        js @MoveLoop_8
        ; Do the last 4 bytes
        mov eax, [eax + ecx]
        mov [edx + ecx], eax

        Return@
EndFunc@ _FastMM_MoveX8L4

endif ; USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES


ifndef USE_C_CODE
;----------------------------------------------------------------------
; Name          _FastMM_RemoveMediumFreeBlock
;
; Usage         void __FASTCALL _FastMM_RemoveMediumFreeBlock(PMediumFreeBlock APMediumFreeBlock)
;
; Note          Removes a medium block from the circular linked list of free blocks.
;               Does not change any header flags. Medium blocks should be locked
;               before calling this procedure.
;----------------------------------------------------------------------

Func@   _FastMM_RemoveMediumFreeBlock, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = APMediumFreeBlock

        ; Get the current previous and next blocks
        mov ecx, [eax.TMediumFreeBlock.NextFreeBlock]
        mov edx, [eax.TMediumFreeBlock.PreviousFreeBlock]
        ; Is this bin now empty? If the previous and next free block pointers are
        ; equal, they must point to the bin.
        cmp ecx, edx
        ; Remove this block from the linked list
        mov [ecx.TMediumFreeBlock.PreviousFreeBlock], edx
        mov [edx.TMediumFreeBlock.NextFreeBlock], ecx
        ; Is this bin now empty? If the previous and next free block pointers are
        ; equal, they must point to the bin.
        je @BinIsNowEmpty
@RemoveMediumFreeBlock_Done:
        ret
        ; Align branch target
        nop
@BinIsNowEmpty:
        ; Get the bin number for this block size in ecx
        sub ecx, offset MediumBlockBins
        mov edx, ecx
        shr ecx, 3
        ; Get the group number in edx
        movzx edx, dh
        ; Flag this bin as empty
        mov eax, -2
        rol eax, cl
        and dword ptr [MediumBlockBinBitmaps + edx * 4], eax
        jnz @RemoveMediumFreeBlock_Done
        ; Flag this group as empty
        mov eax, -2
        mov ecx, edx
        rol eax, cl
        and MediumBlockBinGroupBitmap, eax

        Return@
EndFunc@ _FastMM_RemoveMediumFreeBlock


;----------------------------------------------------------------------
; Name          _FastMM_InsertMediumBlockIntoBin
;
; Usage         void __FASTCALL _FastMM_InsertMediumBlockIntoBin(PMediumFreeBlock APMediumFreeBlock, DWORD AMediumBlockSize)
;
; Note          Inserts a medium block into the appropriate medium block bin.
;----------------------------------------------------------------------

Func@   _FastMM_InsertMediumBlockIntoBin, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = APMediumFreeBlock
        ;   edx = AMediumBlockSize

        ; Get the bin number for this block size. Get the bin that holds blocks of at
        ; least this size.
        sub edx, MinimumMediumBlockSize
        shr edx, 8
        ; Validate the bin number
        sub edx, MediumBlockBinCount - 1
        sbb ecx, ecx
        and edx, ecx
        add edx, MediumBlockBinCount - 1
        ; Get the bin in ecx
        lea ecx, [MediumBlockBins + edx * 8]
        ; Bins are LIFO, se we insert this block as the first free block in the bin
        mov edx, [ecx.TMediumFreeBlock.NextFreeBlock]
        ; Was this bin empty?
        cmp edx, ecx
        mov [eax.TMediumFreeBlock.PreviousFreeBlock], ecx
        mov [eax.TMediumFreeBlock.NextFreeBlock], edx
        mov [edx.TMediumFreeBlock.PreviousFreeBlock], eax
        mov [ecx.TMediumFreeBlock.NextFreeBlock], eax
        ; Was this bin empty?
        je @BinWasEmpty
        ret
        ; Align branch target
        nop
        nop
@BinWasEmpty:
        ; Get the bin number in ecx
        sub ecx, offset MediumBlockBins
        mov edx, ecx
        shr ecx, 3
        ; Get the group number in edx
        movzx edx, dh
        ; Flag this bin as not empty
        mov eax, 1
        shl eax, cl
        or dword ptr [MediumBlockBinBitmaps + edx * 4], eax
        ; Flag the group as not empty
        mov eax, 1
        mov ecx, edx
        shl eax, cl
        or MediumBlockBinGroupBitmap, eax

        Return@
EndFunc@ _FastMM_InsertMediumBlockIntoBin

;----------------------------------------------------------------------
; Name          _FastMM_BinMediumSequentialFeedRemainder
;
; Usage         void __FASTCALL _FastMM_BinMediumSequentialFeedRemainder(void)
;
; Note          Inserts a medium block into the appropriate medium block bin.
;----------------------------------------------------------------------

Func@   _FastMM_BinMediumSequentialFeedRemainder, _EXPFUNC, fastcall
        ;
        cmp MediumSequentialFeedBytesLeft, 0
        jne @MustBinMedium
        ; Nothing to bin
        ret
        ; Align branch target
        nop
        nop
@MustBinMedium:
        ; Get a pointer to the last sequentially allocated medium block
        mov eax, LastSequentiallyFedMediumBlock
        ; Is the block that was last fed sequentially free?
        test byte ptr [eax - 4], IsFreeBlockFlag
        jnz @LastBlockFedIsFree
        ; Set the "previous block is free" flag in the last block fed
        or dword ptr [eax - 4], PreviousMediumBlockIsFreeFlag
        ; Get the remainder in edx
        mov edx, MediumSequentialFeedBytesLeft
        ; Point eax to the start of the remainder
        sub eax, edx
@BinTheRemainder:
        ; Status: eax = start of remainder, edx = size of remainder
        ; Store the size of the block as well as the flags
        lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [eax - 4], ecx
        ; Store the trailing size marker
        mov [eax + edx - 8], edx
        ; Bin this medium block
        cmp edx, MinimumMediumBlockSize
        FastCallOp@ jnb _FastMM_InsertMediumBlockIntoBin
        ret
        ; Align branch target
        nop
        nop
@LastBlockFedIsFree:
        ; Drop the flags
        mov edx, DropMediumAndLargeFlagsMask
        and edx, [eax - 4]
        ; Free the last block fed
        cmp edx, MinimumMediumBlockSize
        jb @DontRemoveLastFed
        ; Last fed block is free - remove it from its size bin
        FastCall@ _FastMM_RemoveMediumFreeBlock
        ; Re-read eax and edx
        mov eax, LastSequentiallyFedMediumBlock
        mov edx, DropMediumAndLargeFlagsMask
        and edx, [eax - 4]
@DontRemoveLastFed:
        ; Get the number of bytes left in ecx
        mov ecx, MediumSequentialFeedBytesLeft
        ; Point eax to the start of the remainder
        sub eax, ecx
        ; edx = total size of the remainder
        add edx, ecx
        jmp @BinTheRemainder

        Return@
EndFunc@ _FastMM_BinMediumSequentialFeedRemainder

; ----------------------Main Memory Manager Functions----------------------

;----------------------------------------------------------------------
; Name          _FastMM_GetMem
;
; Usage         void* __FASTCALL _FastMM_GetMem(size_t Size)
;
; Note          Allocates uninitialized memory
;----------------------------------------------------------------------

Func@   _FastMM_GetMem, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = ASize

        ; Since most allocations are for small blocks, determine the small block type
        ; index so long
        lea edx, [eax + BlockHeaderSize - 1]
        shr edx, 3
        ; Is it a small block?
        cmp eax, (MaximumSmallBlockSize - BlockHeaderSize)
        ; Save ebx
        push ebx
        ; Get the IsMultiThread variable so long
        mov cl, IsMultiThread
        ; Is it a small block?
        ja @GetMem_NotASmallBlock
        ; Do we need to lock the block type?
        test cl, cl
        ; Get the small block type in ebx
        movzx eax, byte ptr [AllocSize2SmallBlockTypeIndX4 + edx]
        lea ebx, [SmallBlockTypes + eax * 8]
        ; Do we need to lock the block type?
        jnz @GetMem_LockBlockTypeLoop
@GetMem_GotLockOnSmallBlockType:
        ; Find the next free block: Get the first pool with free blocks in edx
        mov edx, [ebx.TSmallBlockType.NextPartiallyFreePool]
        ; Get the first free block (or the next sequential feed address if edx = ebx)
        mov eax, [edx.TSmallBlockPoolHeader.FirstFreeBlock]
        ; Get the drop flags mask in ecx so long
        mov ecx, DropSmallFlagsMask
        ; Is there a pool with free blocks?
        cmp edx, ebx
        je @GetMem_TrySmallSequentialFeed
        ; Increment the number of used blocks
        add [edx.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Get the new first free block
        and ecx, [eax - 4]
        ; Set the new first free block
        mov [edx.TSmallBlockPoolHeader.FirstFreeBlock], ecx
        ; Set the block header
        mov [eax - 4], edx
        ; Is the chunk now full?
        jz @GetMem_RemoveSmallPool
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Restore ebx
        pop ebx
        ; All done
        ret
        ; Align branch target
        nop
        nop
        nop
@GetMem_TrySmallSequentialFeed:
        ; Try to feed a small block sequentially: Get the sequential feed block pool
        mov edx, [ebx.TSmallBlockType.CurrentSequentialFeedPool]
        ; Get the next sequential feed address so long
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        add ecx, eax
        ; Can another block fit?
        cmp eax, [ebx.TSmallBlockType.MaxSequentialFeedBlockAddress]
        ; Can another block fit?
        ja @GetMem_AllocateSmallBlockPool
        ; Increment the number of used blocks in the sequential feed pool
        add [edx.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Store the next sequential feed block address
        mov [ebx.TSmallBlockType.NextSequentialFeedBlockAddress], ecx
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Set the block header
        mov [eax - 4], edx
        ; Restore ebx
        pop ebx
        ; All done
        ret
        ; Align branch target
        nop
        nop
        nop
@GetMem_RemoveSmallPool:
        ; Pool is full - remove it from the partially free list
        mov ecx, [edx.TSmallBlockPoolHeader.NextPartiallyFreePool]
        mov [ecx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], ebx
        mov [ebx.TSmallBlockType.NextPartiallyFreePool], ecx
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Restore ebx
        pop ebx
        ; All done
        ret
        ; Align branch target
        nop
        nop
@GetMem_LockBlockTypeLoop:
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Try the next size
        add ebx, TYPE(TSmallBlockType)
        mov eax, 100h
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Try the next size (up to two sizes larger)
        add ebx, TYPE(TSmallBlockType)
        mov eax, 100h
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Block type and two sizes larger are all locked - sleep and/or retry
        sub ebx, 2 * TYPE(TSmallBlockType)
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @GetMem_LockBlockTypeLoop
        ; Couldn't grab the block type - sleep and try again
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @GetMem_GotLockOnSmallBlockType
        ; Couldn't grab the block type - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @GetMem_LockBlockTypeLoop
        ; Align branch target
@GetMem_AllocateSmallBlockPool:
        ; save additional registers
        push esi
        push edi
        ; Do we need to lock the medium blocks?
        cmp IsMultiThread, 0 ; false
        je @GetMem_MediumBlocksLockedForPool
@GetMem_LockMediumBlocksForPool:
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLockedForPool
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @GetMem_LockMediumBlocksForPool
        ; Couldn't lock the medium blocks - sleep and retry
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLockedForPool
        ; Couldn't lock the medium blocks - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @GetMem_LockMediumBlocksForPool
        ; Align branch target
@GetMem_MediumBlocksLockedForPool:
        ; Are there any available blocks of a suitable size?
        movsx esi, [ebx.TSmallBlockType.AllowedGroupsForBlockPoolBitmap]
        and esi, MediumBlockBinGroupBitmap
        jz @GetMem_NoSuitableMediumBlocks
        ; Get the bin group number with free blocks in eax
        bsf eax, esi
        ; Get the bin number in ecx
        lea esi, [eax * 8]
        mov ecx, dword ptr [MediumBlockBinBitmaps + eax * 4]
        bsf ecx, ecx
        lea ecx, [ecx + esi * 4]
        ; Get a pointer to the bin in edi
        lea edi, [MediumBlockBins + ecx * 8]
        ; Get the free block in esi
        mov esi, [edi.TMediumFreeBlock.NextFreeBlock]
        ; Remove the first block from the linked list (LIFO)
        mov edx, [esi.TMediumFreeBlock.NextFreeBlock]
        mov [edi.TMediumFreeBlock.NextFreeBlock], edx
        mov [edx.TMediumFreeBlock.PreviousFreeBlock], edi
        ; Is this bin now empty?
        cmp edi, edx
        jne @GetMem_MediumBinNotEmpty
        ; eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block type
        ; Flag this bin as empty
        mov edx, -2
        rol edx, cl
        and dword ptr [MediumBlockBinBitmaps + eax * 4], edx
        jnz @GetMem_MediumBinNotEmpty
        ; Flag the group as empty
        btr MediumBlockBinGroupBitmap, eax
@GetMem_MediumBinNotEmpty:
        ; esi = free block, ebx = block type
        ; Get the size of the available medium block in edi
        mov edi, DropMediumAndLargeFlagsMask
        and edi, [esi - 4]
        cmp edi, MaximumSmallBlockPoolSize
        jb @GetMem_UseWholeBlock
        ; Split the block: get the size of the second part, new block size is the
        ; optimal size
        mov edx, edi
        movzx edi, [ebx.TSmallBlockType.OptimalBlockPoolSize]
        sub edx, edi
        ; Split the block in two
        lea eax, [esi + edi]
        lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [eax - 4], ecx
        ; Store the size of the second split as the second last dword
        mov [eax + edx - 8], edx
        ; Put the remainder in a bin (it will be big enough)
        FastCall@ _FastMM_InsertMediumBlockIntoBin
        jmp @GetMem_GotMediumBlock
        ; Align branch target
@GetMem_NoSuitableMediumBlocks:
        ; Check the sequential feed medium block pool for space
        movzx ecx, [ebx.TSmallBlockType.MinimumBlockPoolSize]
        mov edi, MediumSequentialFeedBytesLeft
        cmp edi, ecx
        jb @GetMem_AllocateNewSequentialFeed
        ; Get the address of the last block that was fed
        mov esi, LastSequentiallyFedMediumBlock
        ; Enough sequential feed space: Will the remainder be usable?
        movzx ecx, [ebx.TSmallBlockType.OptimalBlockPoolSize]
        lea edx, [ecx + MinimumMediumBlockSize]
        cmp edi, edx
        jb @GetMem_NotMuchSpace
        mov edi, ecx
@GetMem_NotMuchSpace:
        sub esi, edi
        ; Update the sequential feed parameters
        sub MediumSequentialFeedBytesLeft, edi
        mov LastSequentiallyFedMediumBlock, esi
        ; Get the block pointer
        jmp @GetMem_GotMediumBlock
        ; Align branch target
@GetMem_AllocateNewSequentialFeed:
        ; Need to allocate a new sequential feed medium block pool: use the
        ; optimal size for this small block pool
        movzx eax, [ebx.TSmallBlockType.OptimalBlockPoolSize]
        mov edi, eax
        ; Allocate the medium block pool
        FastCall@ _FastMM_AllocNewSequentialFeedMediumPool
        mov esi, eax
        test eax, eax
        jnz @GetMem_GotMediumBlock
        mov MediumBlocksLocked, al
        mov [ebx.TSmallBlockType.BlockTypeLocked], al
        pop edi
        pop esi
        pop ebx
        ret
        ; Align branch target
@GetMem_UseWholeBlock:
        ; esi = free block, ebx = block type, edi = block size
        ; Mark this block as used in the block following it
        and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GetMem_GotMediumBlock:
        ; esi = free block, ebx = block type, edi = block size
        ; Set the size and flags for this block
        lea ecx, [edi + IsMediumBlockFlag + IsSmallBlockPoolInUseFlag]
        mov [esi - 4], ecx
        ; Unlock medium blocks
        xor eax, eax
        mov MediumBlocksLocked, al
        ; Set up the block pool
        mov [esi.TSmallBlockPoolHeader.BlockType], ebx
        mov [esi.TSmallBlockPoolHeader.FirstFreeBlock], eax
        mov [esi.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Set it up for sequential block serving
        mov [ebx.TSmallBlockType.CurrentSequentialFeedPool], esi
        ; Return the pointer to the first block
        lea eax, [esi + TYPE(TSmallBlockPoolHeader)]
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        lea edx, [eax + ecx]
        mov [ebx.TSmallBlockType.NextSequentialFeedBlockAddress], edx
        add edi, esi
        sub edi, ecx
        mov [ebx.TSmallBlockType.MaxSequentialFeedBlockAddress], edi
        ; Unlock the small block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; Set the small block header
        mov [eax - 4], esi
        ; Restore registers
        pop edi
        pop esi
        pop ebx
        ; Done
        ret
        ; --------------------------Medium block allocation------------------------
        ; Align branch target
        nop
@GetMem_LockMediumBlocks:
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLocked
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @GetMem_LockMediumBlocks
        ; Couldn't lock the medium blocks - sleep and try again
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @GetMem_MediumBlocksLocked
        ; Couldn't lock the medium blocks - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @GetMem_LockMediumBlocks
        ; Align branch target
        nop
        nop
        nop
@GetMem_NotASmallBlock:
        cmp eax, (MaximumMediumBlockSize - BlockHeaderSize)
        ja @GetMem_IsALargeBlockRequest
        ; Get the bin size for this block size. Block sizes are
        ; rounded up to the next bin size.
        lea ebx, [eax + MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset]
        and ebx, -MediumBlockGranularity
        add ebx, MediumBlockSizeOffset
        ; Do we need to lock the medium blocks?
        test cl, cl
        jnz @GetMem_LockMediumBlocks
@GetMem_MediumBlocksLocked:
        ; Get the bin number in ecx and the group number in edx
        lea edx, [ebx - MinimumMediumBlockSize]
        mov ecx, edx
        shr edx, 8 + 5
        shr ecx, 8
        ; Is there a suitable block inside this group?
        mov eax, -1
        shl eax, cl
        and eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
        jz @GetMem_GroupIsEmpty
        ; Get the actual bin number
        and ecx, -32
        bsf eax, eax
        or ecx, eax
        jmp @GetMem_GotBinAndGroup
        ; Align branch target
        nop
        nop
@GetMem_GroupIsEmpty:
        ; Try all groups greater than this group
        mov eax, -2
        mov ecx, edx
        shl eax, cl
        and eax, MediumBlockBinGroupBitmap
        jz @GetMem_TrySequentialFeedMedium
        ; There is a suitable group with space: get the bin number
        bsf edx, eax
        ; Get the bin in the group with free blocks
        mov eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
        bsf ecx, eax
        mov eax, edx
        shl eax, 5
        or ecx, eax
        jmp @GetMem_GotBinAndGroup
        ; Align branch target
        nop
@GetMem_TrySequentialFeedMedium:
        mov ecx, MediumSequentialFeedBytesLeft
        ; Block can be fed sequentially?
        sub ecx, ebx
        jc @GetMem_AllocateNewSequentialFeedForMedium
        ; Get the block address
        mov eax, LastSequentiallyFedMediumBlock
        sub eax, ebx
        mov LastSequentiallyFedMediumBlock, eax
        ; Store the remaining bytes
        mov MediumSequentialFeedBytesLeft, ecx
        ; Set the flags for the block
        or ebx, IsMediumBlockFlag
        mov [eax - 4], ebx
        jmp @GetMem_MediumBlockGetDone
        ; Align branch target
@GetMem_AllocateNewSequentialFeedForMedium:
        mov eax, ebx
        FastCall@ _FastMM_AllocNewSequentialFeedMediumPool
@GetMem_MediumBlockGetDone:
        mov MediumBlocksLocked, 0 ; false
        pop ebx
        ret
        ; Align branch target
@GetMem_GotBinAndGroup:
        ; ebx = block size, ecx = bin number, edx = group number
        push esi
        push edi
        ; Get a pointer to the bin in edi
        lea edi, [MediumBlockBins + ecx * 8]
        ; Get the free block in esi
        mov esi, [edi.TMediumFreeBlock.NextFreeBlock]
        ; Remove the first block from the linked list (LIFO)
        mov eax, [esi.TMediumFreeBlock.NextFreeBlock]
        mov [edi.TMediumFreeBlock.NextFreeBlock], eax
        mov [eax.TMediumFreeBlock.PreviousFreeBlock], edi
        ; Is this bin now empty?
        cmp edi, eax
        jne @GetMem_MediumBinNotEmptyForMedium
        ; eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block size
        ; Flag this bin as empty
        mov eax, -2
        rol eax, cl
        and dword ptr [MediumBlockBinBitmaps + edx * 4], eax
        jnz @GetMem_MediumBinNotEmptyForMedium
        ; Flag the group as empty
        btr MediumBlockBinGroupBitmap, edx
@GetMem_MediumBinNotEmptyForMedium:
        ; esi = free block, ebx = block size
        ; Get the size of the available medium block in edi
        mov edi, DropMediumAndLargeFlagsMask
        and edi, [esi - 4]
        ; Get the size of the second split in edx
        mov edx, edi
        sub edx, ebx
        jz @GetMem_UseWholeBlockForMedium
        ; Split the block in two
        lea eax, [esi + ebx]
        lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [eax - 4], ecx
        ; Store the size of the second split as the second last dword
        mov [eax + edx - 8], edx
        ; Put the remainder in a bin
        cmp edx, MinimumMediumBlockSize
        jb @GetMem_GotMediumBlockForMedium
        FastCall@ _FastMM_InsertMediumBlockIntoBin
        jmp @GetMem_GotMediumBlockForMedium
        ; Align branch target
        nop
        nop
        nop
@GetMem_UseWholeBlockForMedium:
        ; Mark this block as used in the block following it
        and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GetMem_GotMediumBlockForMedium:
        ; Set the size and flags for this block
        lea ecx, [ebx + IsMediumBlockFlag]
        mov [esi - 4], ecx
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        mov eax, esi
        pop edi
        pop esi
        pop ebx
        ret
        ; ---------------------------Large block allocation------------------------
        ; Align branch target
@GetMem_IsALargeBlockRequest:
        pop ebx
        test eax, eax
        FastCallOp@ jns _FastMM_AllocateLargeBlock
        xor eax, eax

        Return@
EndFunc@ _FastMM_GetMem


;----------------------------------------------------------------------
; Name          _FastMM_FreeMem
;
; Usage         int __FASTCALL _FastMM_FreeMem(void *P)
;
; Note          Release memory
;----------------------------------------------------------------------

Func@   _FastMM_FreeMem, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = P

        ; Get the block header in edx
        mov edx, [eax - 4]
        ; Is it a small block in use?
        test dl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
        ; Save the pointer in ecx
        mov ecx, eax
        ; Save ebx
        push ebx
        ; Get the IsMultiThread variable in bl
        mov bl, IsMultiThread
        ; Is it a small block that is in use?
        jnz @FreeMem_NotSmallBlockInUse
        ; Do we need to lock the block type?
        test bl, bl
        ; Get the small block type in ebx
        mov ebx, [edx.TSmallBlockPoolHeader.BlockType]
        ; Do we need to lock the block type?
        jnz @FreeMem_LockBlockTypeLoop
@FreeMem_GotLockOnSmallBlockType:
        ; Current state: edx = @SmallBlockPoolHeader, ecx = P, ebx = @SmallBlockType
        ; Decrement the number of blocks in use
        sub [edx.TSmallBlockPoolHeader.BlocksInUse], 1
        ; Get the old first free block
        mov eax, [edx.TSmallBlockPoolHeader.FirstFreeBlock]
        ; Is the pool now empty?
        jz @FreeMem_PoolIsNowEmpty
        ; Was the pool full?
        test eax, eax
        ; Store this as the new first free block
        mov [edx.TSmallBlockPoolHeader.FirstFreeBlock], ecx
        ; Store the previous first free block as the block header
        lea eax, [eax + IsFreeBlockFlag]
        mov [ecx - 4], eax
        ; Insert the pool back into the linked list if it was full
        jz @FreeMem_SmallPoolWasFull
        ; All ok
        xor eax, eax
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], al
        ; Restore registers
        pop ebx
        ; Done
        ret
        ; Align branch target
        nop
@FreeMem_SmallPoolWasFull:
        ; Insert this as the first partially free pool for the block size
        mov ecx, [ebx.TSmallBlockType.NextPartiallyFreePool]
        mov [edx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], ebx
        mov [edx.TSmallBlockPoolHeader.NextPartiallyFreePool], ecx
        mov [ecx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], edx
        mov [ebx.TSmallBlockType.NextPartiallyFreePool], edx
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], 0 ; false
        ; All ok
        xor eax, eax
        ; Restore registers
        pop ebx
        ; Done
        ret
        ; Align branch target
        nop
        nop
@FreeMem_PoolIsNowEmpty:
        ; Was this pool actually in the linked list of pools with space? If not, it
        ; can only be the sequential feed pool (it is the only pool that may contain
        ; only one block, i.e. other blocks have not been split off yet)
        test eax, eax
        jz @FreeMem_IsSequentialFeedPool
        ; Pool is now empty: Remove it from the linked list and free it
        mov eax, [edx.TSmallBlockPoolHeader.PreviousPartiallyFreePool]
        mov ecx, [edx.TSmallBlockPoolHeader.NextPartiallyFreePool]
        ; Remove this manager
        mov [eax.TSmallBlockPoolHeader.NextPartiallyFreePool], ecx
        mov [ecx.TSmallBlockPoolHeader.PreviousPartiallyFreePool], eax
        ; Zero out eax
        xor eax, eax
        ; Is this the sequential feed pool? If so, stop sequential feeding
        cmp [ebx.TSmallBlockType.CurrentSequentialFeedPool], edx
        jne @FreeMem_NotSequentialFeedPool
@FreeMem_IsSequentialFeedPool:
        mov [ebx.TSmallBlockType.MaxSequentialFeedBlockAddress], eax
@FreeMem_NotSequentialFeedPool:
        ; Unlock the block type
        mov [ebx.TSmallBlockType.BlockTypeLocked], al
        ; Release this pool
        mov eax, edx
        mov edx, [edx - 4]
        mov bl, IsMultiThread
        jmp @FreeMem_FreeMediumBlock
        ; Align branch target
@FreeMem_LockBlockTypeLoop:
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @FreeMem_GotLockOnSmallBlockType
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @FreeMem_LockBlockTypeLoop
        ; Couldn't grab the block type - sleep and try again
        push ecx
        push edx
        push InitialSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg [ebx.TSmallBlockType.BlockTypeLocked], ah
        je @FreeMem_GotLockOnSmallBlockType
        ; Couldn't grab the block type - sleep and try again
        push ecx
        push edx
        push AdditionalSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        jmp @FreeMem_LockBlockTypeLoop
        ; Align branch target
        nop
        nop
        nop
        ; -----------------------------Medium blocks-----------------------------
@FreeMem_LockMediumBlocks:
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @FreeMem_MediumBlocksLocked
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @FreeMem_LockMediumBlocks
        ; Couldn't lock the medium blocks - sleep and try again
        push InitialSleepTime
        call Sleep
        ; Try again
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @FreeMem_MediumBlocksLocked
        ; Couldn't lock the medium blocks - sleep and try again
        push AdditionalSleepTime
        call Sleep
        ; Try again
        jmp @FreeMem_LockMediumBlocks
        ; Align branch target
        nop
        nop
        nop
@FreeMem_NotSmallBlockInUse:
        ; Not a small block in use: is it a medium or large block?
        test dl, IsFreeBlockFlag + IsLargeBlockFlag
        jnz @FreeMem_NotASmallOrMediumBlock
@FreeMem_FreeMediumBlock:
        ; Drop the flags
        and edx, DropMediumAndLargeFlagsMask
        ; Free the large block pointed to by eax, header in edx, bl = IsMultiThread
        ; Do we need to lock the medium blocks?
        test bl, bl
        ; Block size in ebx
        mov ebx, edx
        ; Save registers
        push esi
        ; Pointer in esi
        mov esi, eax
        ; Do we need to lock the medium blocks?
        jnz @FreeMem_LockMediumBlocks
@FreeMem_MediumBlocksLocked:
        ; Can we combine this block with the next free block?
        test dword ptr [esi + ebx - 4], IsFreeBlockFlag
        ; Get the next block size and flags in ecx
        mov ecx, [esi + ebx - 4]
        jnz @FreeMem_NextBlockIsFree
        ; Set the "PreviousIsFree" flag in the next block
        or ecx, PreviousMediumBlockIsFreeFlag
        mov [esi + ebx - 4], ecx
@FreeMem_NextBlockChecked:
        ; Can we combine this block with the previous free block? We need to
        ; re-read the flags since it could have changed before we could lock the
        ; medium blocks.
        test byte ptr [esi - 4], PreviousMediumBlockIsFreeFlag
        jnz @FreeMem_PreviousBlockIsFree
@FreeMem_PreviousBlockChecked:
        ; Is the entire medium block pool free, and there are other free blocks
        ; that can fit the largest possible medium block -> free it.
        cmp ebx, (MediumBlockPoolSize - MediumBlockPoolHeaderSize)
        je @FreeMem_EntireMediumPoolFree
@FreeMem_BinFreeMediumBlock:
        ; Store the size of the block as well as the flags
        lea eax, [ebx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [esi - 4], eax
        ; Store the trailing size marker
        mov [esi + ebx - 8], ebx
        ; Insert this block back into the bins: Size check not required here,
        ; since medium blocks that are in use are not allowed to be
        ; shrunk smaller than MinimumMediumBlockSize
        mov eax, esi
        mov edx, ebx
        ; Insert into bin
        FastCall@ _FastMM_InsertMediumBlockIntoBin
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; All OK
        xor eax, eax
        ; Restore registers
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
        nop
@FreeMem_NextBlockIsFree:
        ; Get the next block address in eax
        lea eax, [esi + ebx]
        ; Increase the size of this block
        and ecx, DropMediumAndLargeFlagsMask
        add ebx, ecx
        ; Was the block binned?
        cmp ecx, MinimumMediumBlockSize
        jb @FreeMem_NextBlockChecked
        FastCall@ _FastMM_RemoveMediumFreeBlock
        jmp @FreeMem_NextBlockChecked
        ; Align branch target
        nop
@FreeMem_PreviousBlockIsFree:
        ; Get the size of the free block just before this one
        mov ecx, [esi - 8]
        ; Include the previous block
        sub esi, ecx
        ; Set the new block size
        add ebx, ecx
        ; Remove the previous block from the linked list
        cmp ecx, MinimumMediumBlockSize
        jb @FreeMem_PreviousBlockChecked
        mov eax, esi
        FastCall@ _FastMM_RemoveMediumFreeBlock
        jmp @FreeMem_PreviousBlockChecked
        ; Align branch target
@FreeMem_EntireMediumPoolFree:
        ; Should we make this the new sequential feed medium block pool? If the
        ; current sequential feed pool is not entirely free, we make this the new
        ; sequential feed pool.
        cmp MediumSequentialFeedBytesLeft, MediumBlockPoolSize - MediumBlockPoolHeaderSize
        jne @FreeMem_MakeEmptyMediumPoolSequentialFeed
        ; Point esi to the medium block pool header
        sub esi, TYPE(TMediumBlockPoolHeader)
        ; Remove this medium block pool from the linked list
        mov eax, [esi.TMediumBlockPoolHeader.PreviousMediumBlockPoolHeader]
        mov edx, [esi.TMediumBlockPoolHeader.NextMediumBlockPoolHeader]
        mov [eax.TMediumBlockPoolHeader.NextMediumBlockPoolHeader], edx
        mov [edx.TMediumBlockPoolHeader.PreviousMediumBlockPoolHeader], eax
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Free the medium block pool
        push MEM_RELEASE
        push 0
        push esi
        call VirtualFree
        ; VirtualFree returns >0 if all is ok
        cmp eax, 1
        ; Return 0 on all ok
        sbb eax, eax
        ; Restore registers
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
        nop
        nop
@FreeMem_MakeEmptyMediumPoolSequentialFeed:
        ; Get a pointer to the end-marker block
        lea ebx, [esi + MediumBlockPoolSize - MediumBlockPoolHeaderSize]
        ; Bin the current sequential feed pool
        FastCall@ _FastMM_BinMediumSequentialFeedRemainder
        ; Set this medium pool up as the new sequential feed pool:
        ; Store the sequential feed pool trailer
        mov dword ptr [ebx - BlockHeaderSize], IsMediumBlockFlag
        ; Store the number of bytes available in the sequential feed chunk
        mov MediumSequentialFeedBytesLeft, MediumBlockPoolSize - MediumBlockPoolHeaderSize
        ; Set the last sequentially fed block
        mov LastSequentiallyFedMediumBlock, ebx
        ; Unlock medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Success
        xor eax, eax
        ; Restore registers
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
        nop
@FreeMem_NotASmallOrMediumBlock:
        ; Restore ebx
        pop ebx
        ; Is it in fact a large block?
        test dl, IsFreeBlockFlag + IsMediumBlockFlag
        FastCallOp@ jz _FastMM_FreeLargeBlock
        ; Attempt to free an already free block
        mov eax, -1

        Return@
EndFunc@ _FastMM_FreeMem


;----------------------------------------------------------------------
; Name          _FastMM_ReallocMem
;
; Usage         void* __FASTCALL _FastMM_ReallocMem(void *P, size_t Size)
;
; Note          Reallocate memory
;----------------------------------------------------------------------

Func@   _FastMM_ReallocMem, _EXPFUNC, fastcall
        ; On entry:
        ;   eax = P
        ;   edx = Size

        ; Get the block header: Is it actually a small block?
        mov ecx, [eax - 4]
        ; Is it a small block?
        test cl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
        ; Save ebx
        push ebx
        ; Save esi
        push esi
        ; Save the original pointer in esi
        mov esi, eax
        ; Is it a small block?
        jnz @ReallocMem_NotASmallBlock
        ; ----------------------------Small block--------------------------------
        ; Get the block type in ebx
        mov ebx, [ecx.TSmallBlockPoolHeader.BlockType]
        ; Get the available size inside blocks of this type.
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        sub ecx, 4
        ; Is it an upsize or a downsize?
        cmp ecx, edx
        jb @ReallocMem_SmallUpsize
        ; It's a downsize. Do we need to allocate a smaller block? Only if the new
        ; size is less than a quarter of the available size less
        ; SmallBlockDownsizeCheckAdder bytes
        lea ebx, [edx * 4 + SmallBlockDownsizeCheckAdder]
        cmp ebx, ecx
        jb @ReallocMem_NotSmallInPlaceDownsize
        ; In-place downsize - return the original pointer
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
@ReallocMem_NotSmallInPlaceDownsize:
        ; Save the requested size
        mov ebx, edx
        ; Allocate a smaller block
        mov eax, edx
        FastCall@ _FastMM_GetMem
        ; Allocated OK?
        test eax, eax
        jz @ReallocMem_SmallDownsizeDone
        ; Move data across: count in ecx
        mov ecx, ebx
        ; Destination in edx
        mov edx, eax
        ; Save the result in ebx
        mov ebx, eax
        ; Original pointer in eax
        mov eax, esi
        ; Move the data across
    ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
        FastCall@ _FastMM_MoveX8L4
    else
        FastCall@ _internal_memmove
    endif
        ; Free the original pointer
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Return the pointer
        mov eax, ebx
@ReallocMem_SmallDownsizeDone:
        pop esi
        pop ebx
        ret
        ; Align branch target
        nop
        nop
@ReallocMem_SmallUpsize:
        ; State: esi = P, edx = Size, ecx = Current Block Size, ebx = Current Block Type
        ; This pointer is being reallocated to a larger block and therefore it is
        ; logical to assume that it may be enlarged again. Since reallocations are
        ; expensive, there is a minimum upsize percentage to avoid unnecessary
        ; future move operations.
        ; Small blocks always grow with at least 100% + SmallBlockUpsizeAdder bytes
        lea ecx, [ecx + ecx + SmallBlockUpsizeAdder]
        ; save edi
        push edi
        ; Save the requested size in edi
        mov edi, edx
        ; New allocated size is the maximum of the requested size and the minimum
        ; upsize
        xor eax, eax
        sub ecx, edx
        adc eax, -1
        and eax, ecx
        add eax, edx
        ; Allocate the new block
        FastCall@ _FastMM_GetMem
        ; Allocated OK?
        test eax, eax
        jz @ReallocMem_SmallUpsizeDone
        ; Do we need to store the requested size? Only large blocks store the
        ; requested size.
        cmp edi, MaximumMediumBlockSize - BlockHeaderSize
        jbe @ReallocMem_NotSmallUpsizeToLargeBlock
        ; Store the user requested size
        mov [eax - 8], edi
@ReallocMem_NotSmallUpsizeToLargeBlock:
        ; Get the size to move across
        movzx ecx, [ebx.TSmallBlockType.BlockSize]
        sub ecx, BlockHeaderSize
        ; Move to the new block
        mov edx, eax
        ; Save the result in edi
        mov edi, eax
        ; Move from the old block
        mov eax, esi
        ; Move the data across
    ifdef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
        call [ebx.TSmallBlockType.UpsizeMoveProcedure]
    else
        FastCall@ _internal_memmove
    endif
        ; Free the old pointer
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Done
        mov eax, edi
@ReallocMem_SmallUpsizeDone:
        pop edi
        pop esi
        pop ebx
        ret
        ; Align branch target
    ifndef USE_CUSTOM_FIXED_SIZE_MOVE_ROUTINES
        nop
        nop
    endif
        nop
@ReallocMem_NotASmallBlock:
        ; Is this a medium block or a large block?
        test cl, IsFreeBlockFlag + IsLargeBlockFlag
        jnz @ReallocMem_PossibleLargeBlock
        ; ----------------------------Medium block-------------------------------
        ; Status: ecx = Current Block Size + Flags, eax/esi = P,
        ; edx = Requested Size
        mov ebx, ecx
        ; Drop the flags from the header
        and ecx, DropMediumAndLargeFlagsMask
        ; Save edi
        push edi
        ; Get a pointer to the next block in edi
        lea edi, [eax + ecx]
        ; Subtract the block header size from the old available size
        sub ecx, BlockHeaderSize
        ; Get the complete flags in ebx
        and ebx, ExtractMediumAndLargeFlagsMask
        ; Is it an upsize or a downsize?
        cmp edx, ecx
        ; Save ebp
        push ebp
        ; Is it an upsize or a downsize?
        ja @ReallocMem_MediumBlockUpsize
        ; Status: ecx = Current Block Size - 4, bl = Current Block Flags,
        ; edi = @Next Block, eax/esi = P, edx = Requested Size
        ; Must be less than half the current size or we don't bother resizing.
        lea ebp, [edx + edx]
        cmp ebp, ecx
        jb @ReallocMem_MediumMustDownsize
@ReallocMem_MediumNoResize:
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
        nop
        nop
        nop
@ReallocMem_MediumMustDownsize:
        ; In-place downsize? Balance the cost of moving the data vs. the cost of
        ; fragmenting the memory pool. Medium blocks in use may never be smaller
        ; than MinimumMediumBlockSize.
        cmp edx, MinimumMediumBlockSize - BlockHeaderSize
        jae @ReallocMem_MediumBlockInPlaceDownsize
        ; The requested size is less than the minimum medium block size. If the
        ; requested size is less than the threshold value (currently a quarter of the
        ; minimum medium block size), move the data to a small block, otherwise shrink
        ; the medium block to the minimum allowable medium block size.
        cmp edx, MediumInPlaceDownsizeLimit
        jb @ReallocMem_MediumDownsizeRealloc
        ; The request is for a size smaller than the minimum medium block size, but
        ; not small enough to justify moving data: Reduce the block size to the
        ; minimum medium block size
        mov edx, MinimumMediumBlockSize - BlockHeaderSize
        ; Is it already at the minimum medium block size?
        cmp ecx, edx
        jna @ReallocMem_MediumNoResize
@ReallocMem_MediumBlockInPlaceDownsize:
        ; Round up to the next medium block size
        lea ebp, [edx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
        and ebp, -MediumBlockGranularity;
        add ebp, MediumBlockSizeOffset
        ; Get the size of the second split
        add ecx, BlockHeaderSize
        sub ecx, ebp
        ; Lock the medium blocks
        cmp IsMultiThread, 0 ; false
        je @ReallocMem_DoMediumInPlaceDownsize
        ; We have to re-read the flags
@ReallocMem_DoMediumLockForDownsize:
        ; Lock the medium blocks
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_MediumDownsizeRereadFlags
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @ReallocMem_DoMediumLockForDownsize
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push InitialSleepTime
        call Sleep
        pop ecx
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_MediumDownsizeRereadFlags
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push AdditionalSleepTime
        call Sleep
        pop ecx
        ; Try again
        jmp @ReallocMem_DoMediumLockForDownsize
        ; Align branch target
        nop
@ReallocMem_MediumDownsizeRereadFlags:
        mov ebx, ExtractMediumAndLargeFlagsMask
        and ebx, [esi - 4]
@ReallocMem_DoMediumInPlaceDownsize:
        ; Set the new size
        or ebx, ebp
        mov [esi - 4], ebx
        ; Get the second split size in ebx
        mov ebx, ecx
        ; Is the next block in use?
        mov edx, [edi - 4]
        test dl, IsFreeBlockFlag
        jnz @ReallocMem_MediumDownsizeNextBlockFree
        ; The next block is in use: flag its previous block as free
        or edx, PreviousMediumBlockIsFreeFlag
        mov [edi - 4], edx
        jmp @ReallocMem_MediumDownsizeDoSplit
        ; Align branch target
        nop
@ReallocMem_MediumDownsizeNextBlockFree:
        ; The next block is free: combine it
        mov eax, edi
        and edx, DropMediumAndLargeFlagsMask
        add ebx, edx
        add edi, edx
        cmp edx, MinimumMediumBlockSize
        jb @ReallocMem_MediumDownsizeDoSplit
        FastCall@ _FastMM_RemoveMediumFreeBlock
@ReallocMem_MediumDownsizeDoSplit:
        ; Store the trailing size field
        mov [edi - 8], ebx
        ; Store the free part's header
        lea eax, [ebx + IsMediumBlockFlag + IsFreeBlockFlag];
        mov [esi + ebp - 4], eax
        ; Bin this free block
        cmp ebx, MinimumMediumBlockSize
        jb @ReallocMem_MediumBlockDownsizeDone
        lea eax, [esi + ebp]
        mov edx, ebx
        FastCall@ _FastMM_InsertMediumBlockIntoBin
@ReallocMem_MediumBlockDownsizeDone:
        ; Unlock the medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Result = old pointer
        mov eax, esi
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
@ReallocMem_MediumDownsizeRealloc:
        ; Save the requested size
        mov edi, edx
        mov eax, edx
        ; Allocate the new block
        FastCall@ _FastMM_GetMem
        test eax, eax
        jz @ReallocMem_MediumBlockDownsizeExit
        ; Save the result
        mov ebp, eax
        mov edx, eax
        mov eax, esi
        mov ecx, edi
        ; Move the data across
    ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
        FastCall@ _FastMM_MoveX8L4
    else
        FastCall@ _internal_memmove
    endif
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Return the result
        mov eax, ebp
@ReallocMem_MediumBlockDownsizeExit:
        pop ebp
        pop edi
        pop esi
        pop ebx
        ret
        ; Align branch target
@ReallocMem_MediumBlockUpsize:
        ; Status: ecx = Current Block Size - 4, bl = Current Block Flags,
        ; edi = @Next Block, eax/esi = P, edx = Requested Size
        ; Can we do an in-place upsize?
        mov eax, [edi - 4]
        test al, IsFreeBlockFlag
        jz @ReallocMem_CannotUpsizeMediumBlockInPlace
        ; Get the total available size including the next block
        and eax, DropMediumAndLargeFlagsMask
        ; ebp = total available size including the next block (excluding the header)
        lea ebp, [eax + ecx]
        ; Can the block fit?
        cmp edx, ebp
        ja @ReallocMem_CannotUpsizeMediumBlockInPlace
        ; The next block is free and there is enough space to grow this
        ; block in place.
        cmp IsMultiThread, 0 ; false
        je @ReallocMem_DoMediumInPlaceUpsize
@ReallocMem_DoMediumLockForUpsize:
        ; Lock the medium blocks
        mov eax, 100h
        ; Attempt to lock the medium blocks
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_RecheckMediumInPlaceUpsize
        ; The pause instruction improves spinlock performance
        pause
        ; "Busy waiting" or "sleep and retry" strategy?
        cmp NeverSleepOnMMThreadContention, 0
        jne @ReallocMem_DoMediumLockForUpsize
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push edx
        push InitialSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        mov eax, 100h
        ; Attempt to grab the block type
        lock cmpxchg MediumBlocksLocked, ah
        je @ReallocMem_RecheckMediumInPlaceUpsize
        ; Couldn't lock the medium blocks - sleep and try again
        push ecx
        push edx
        push AdditionalSleepTime
        call Sleep
        pop edx
        pop ecx
        ; Try again
        jmp @ReallocMem_DoMediumLockForUpsize
        ; Align branch target
        nop
@ReallocMem_RecheckMediumInPlaceUpsize:
        ; Re-read the info for this block
        mov ebx, ExtractMediumAndLargeFlagsMask
        and ebx, [esi - 4]
        ; Re-read the info for the next block
        mov eax, [edi - 4]
        ; Next block still free?
        test al, IsFreeBlockFlag
        jz @ReallocMem_NextMediumBlockChanged
        ; Recalculate the next block size
        and eax, DropMediumAndLargeFlagsMask
        ; The available size including the next block
        lea ebp, [eax + ecx]
        ; Can the block still fit?
        cmp edx, ebp
        ja @ReallocMem_NextMediumBlockChanged
@ReallocMem_DoMediumInPlaceUpsize:
        ; Is the next block binnable?
        cmp eax, MinimumMediumBlockSize
        ; Remove the next block
        jb @ReallocMem_MediumInPlaceNoNextRemove
        mov eax, edi
        push ecx
        push edx
        FastCall@ _FastMM_RemoveMediumFreeBlock
        pop edx
        pop ecx
@ReallocMem_MediumInPlaceNoNextRemove:
        ; Medium blocks grow a minimum of 25% in in-place upsizes
        mov eax, ecx
        shr eax, 2
        add eax, ecx
        ; Get the maximum of the requested size and the minimum growth size
        xor edi, edi
        sub eax, edx
        adc edi, -1
        and eax, edi
        ; Round up to the nearest block size granularity
        lea eax, [eax + edx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
        and eax, -MediumBlockGranularity
        add eax, MediumBlockSizeOffset
        ; Calculate the size of the second split
        lea edx, [ebp + BlockHeaderSize]
        sub edx, eax
        ; Does it fit?
        ja @ReallocMem_MediumInPlaceUpsizeSplit
        ; Grab the whole block: Mark it as used in the block following it
        and dword ptr [esi + ebp], not PreviousMediumBlockIsFreeFlag
        ; The block size is the full available size plus header
        add ebp, 4
        ; Upsize done
        jmp @ReallocMem_MediumUpsizeInPlaceDone
        ; Align branch target
        nop
        nop
@ReallocMem_MediumInPlaceUpsizeSplit:
        ; Store the size of the second split as the second last dword
        mov [esi + ebp - 4], edx
        ; Set the second split header
        lea edi, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
        mov [esi + eax - 4], edi
        mov ebp, eax
        cmp edx, MinimumMediumBlockSize
        jb @ReallocMem_MediumUpsizeInPlaceDone
        add eax, esi
        FastCall@ _FastMM_InsertMediumBlockIntoBin
@ReallocMem_MediumUpsizeInPlaceDone:
        ; Set the size and flags for this block
        or ebp, ebx
        mov [esi - 4], ebp
        ; Unlock the medium blocks
        mov MediumBlocksLocked, 0 ; false
        ; Result = old pointer
        mov eax, esi
@ReallocMem_MediumBlockResizeDone2:
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target for @ReallocMem_CannotUpsizeMediumBlockInPlace
        nop
        nop
@ReallocMem_NextMediumBlockChanged:
        ; The next medium block changed while the medium blocks were being locked
        mov MediumBlocksLocked, 0 ; false
@ReallocMem_CannotUpsizeMediumBlockInPlace:
        ; Couldn't upsize in place. Grab a new block and move the data across:
        ; If we have to reallocate and move medium blocks, we grow by at
        ; least 25%
        mov eax, ecx
        shr eax, 2
        add eax, ecx
        ; Get the maximum of the requested size and the minimum growth size
        xor edi, edi
        sub eax, edx
        adc edi, -1
        and eax, edi
        add eax, edx
        ; Save the size to allocate
        mov ebp, eax
        ; Save the size to move across
        mov edi, ecx
        ; Get the block
        push edx
        FastCall@ _FastMM_GetMem
        pop edx
        ; Success?
        test eax, eax
        jz @ReallocMem_MediumBlockResizeDone2
        ; If it's a Large block - store the actual user requested size
        cmp ebp, MaximumMediumBlockSize - BlockHeaderSize
        jbe @ReallocMem_MediumUpsizeNotLarge
        mov [eax - 8], edx
@ReallocMem_MediumUpsizeNotLarge:
        ; Save the result
        mov ebp, eax
        ; Move the data across
        mov edx, eax
        mov eax, esi
        mov ecx, edi
    ifdef USE_CUSTOM_VARIABLE_SIZE_MOVE_ROUTINES
        FastCall@ _FastMM_MoveX16L4
    else
        FastCall@ _internal_memmove
    endif
        ; Free the old block
        mov eax, esi
        FastCall@ _FastMM_FreeMem
        ; Restore the result
        mov eax, ebp
        ; Restore registers
        pop ebp
        pop edi
        pop esi
        pop ebx
        ; Return
        ret
        ; Align branch target
        nop
@ReallocMem_PossibleLargeBlock:
        ; -----------------------Large block------------------------------
        ; Restore registers
        pop esi
        pop ebx
        ; Is this a valid large block?
        test cl, IsFreeBlockFlag + IsMediumBlockFlag
        FastCallOp@ jz _FastMM_ReallocateLargeBlock
        ; -----------------------Invalid block------------------------------
        xor eax, eax

        Return@
EndFunc@ _FastMM_ReallocMem

;----------------------------------------------------------------------
; Name          _FastMM_AllocMem
;
; Usage         void* __FASTCALL _FastMM_AllocMem(size_t Size)
;
; Note          Allocates a block and fills it with zeroes
;----------------------------------------------------------------------

Func@   _FastMM_AllocMem, _EXPFUNC, fastcall
        push ebx
        ; Get the size rounded down to the previous multiple of 4 into ebx
        lea ebx, [eax - 1]
        and ebx, -4
        ; Get the block
        FastCall@ _FastMM_GetMem
        ; Could a block be allocated? ecx = 0 if yes, 0xffffffff if no
        cmp eax, 1
        sbb ecx, ecx
        ; Point edx to the last dword
        lea edx, [eax + ebx]
        ; ebx = 0xffffffff if no block could be allocated, otherwise size rounded down
        ; to previous multiple of 4
        or ebx, ecx
        ; Large blocks are already zero filled
        cmp ebx, MaximumMediumBlockSize - BlockHeaderSize
        jae @AllocMem_Done
        ; Make the counter negative based
        neg ebx
        ; Load zero into st(0)
        fldz
        ; Clear groups of 8 bytes. Block sizes are always four less than a multiple
        ; of 8, with a minimum of 12 bytes
@AllocMem_FillLoop:
        fst qword ptr [edx + ebx]
        add ebx, 8
        js @AllocMem_FillLoop
        ; Clear the last four bytes
        mov [edx], ecx
        ; Clear st(0)
        ffree st(0)
        ; Correct the stack top
        fincstp
@AllocMem_Done:
        pop ebx

        Return@
EndFunc@ _FastMM_AllocMem

endif ; !USE_C_CODE


; --------------------Memory Leak Checking and Reporting-------------------

ifdef INCLUDE_MEMORYLEAK_TRACKING_CODE

;----------------------------------------------------------------------
; Name          _FastMM_CardinalToStrBuf
;
; Usage         char* __FASTCALL _FastMM_CardinalToStrBuf(unsigned int ACardinal, char *ABuffer)
;
; Note          Converts a cardinal to string at the buffer location, returning the new
;               buffer position.
;----------------------------------------------------------------------

Func@   _FastMM_CardinalToStrBuf, _EXPFUNC, fastcall
        ; On entry: eax = ACardinal, edx = ABuffer
        push edi
        mov edi, edx                ; Pointer to the first character in edi
        ; Calculate leading digit: divide the number by 1e9
        add eax, 1                  ; Increment the number
        mov edx, 89705f41h          ; 1e9 reciprocal
        mul edx                     ; Multplying with reciprocal
        shr eax, 30                 ; Save fraction bits
        mov ecx, edx                ; First digit in bits <31:29>
        and edx, 1fffffffh          ; Filter fraction part edx<28:0>
        shr ecx, 29                 ; Get leading digit into accumulator
        lea edx, [edx + edx * 4]    ; Calculate ...
        add edx, eax                ; ... 5*fraction
        mov eax, ecx                ; Copy leading digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #2
        mov eax, edx                ; Point format such that 1.0 = 2^28
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 28                 ; Next digit
        and edx, 0fffffffh          ; Fraction part edx<27:0>
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #3
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:27>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<26:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 27                 ; Next digit
        and edx, 07ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #4
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:26>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<25:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 26                 ; Next digit
        and edx, 03ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #5
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:25>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<24:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 25                 ; Next digit
        and edx, 01ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #6
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:24>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<23:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 24                 ; Next digit
        and edx, 00ffffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #7
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:23>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<31:23>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 23                 ; Next digit
        and edx, 007fffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #8
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:22>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<22:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 22                 ; Next digit
        and edx, 003fffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #9
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:21>
        lea edx, [edx + edx * 4]    ; 5*fraction, new fraction edx<21:0>
        cmp ecx, 1                  ; Any non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 21                 ; Next digit
        and edx, 001fffffh          ; Fraction part
        or ecx, eax                 ; Accumulate next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store digit out to memory
        ; Calculate digit #10
        lea eax, [edx + edx * 4]    ; 5*fraction, new digit eax<31:20>
        cmp ecx, 1                  ; Any-non-zero digit yet ?
        sbb edi, -1                 ; Yes->increment ptr, No->keep old ptr
        shr eax, 20                 ; Next digit
        or eax, '0'                 ; Convert digit to ASCII
        mov [edi], al               ; Store last digit and end marker out to memory
        ; Return a pointer to the next character
        lea eax, [edi + 1]
        ; Restore edi
        pop edi

        Return@
EndFunc@ _FastMM_CardinalToStrBuf

endif ; INCLUDE_MEMORYLEAK_TRACKING_CODE

;----------------------------------------------------------------------

Code_EndS@

        end

