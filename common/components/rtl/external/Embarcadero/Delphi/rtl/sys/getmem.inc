{ *********************************************************************** }
{                                                                         }
{  Embarcadero Delphi Memory Manager                                      }
{                                                                         }
{          Copyright(c) 1996-2013 Embarcadero Technologies, Inc.          }
{                                                                         }
{  Portions created by Pierre le Riche are                                }
{   Copyright (c) Pierre le Riche                                         }
{                                                                         }
{  Acknowledgement: With special thanks to the Fastcode community and     }
{   supporters for their valuable input and feedback.                     }
{                                                                         }
{                                                                         }
{ *********************************************************************** }

(* ***** BEGIN LICENSE BLOCK *****
 *
 * This memory manager implementation is licensed under the Embarcadero license
 * terms.
 *
 * The initial developer of the original code is Pierre le Riche.
 *
 * Portions created by the initial developer are Copyright (c) 2011
 * the initial developer. All Rights Reserved.
 *
 * Contributor(s): Pierre le Riche
 *
 * ***** END LICENSE BLOCK ***** *)

{-----------------------------Options Block-------------------------------}
{Include the memory leak tracking and reporting code. Without this define set
 the memory leak registration functions will do nothing and the memory leak
 report will not be shown on shutdown.}
{$define IncludeMemoryLeakTrackingCode}
{Enable to use the pascal code path}
{.$define UsePascalCode}
{Use custom fixed size move routines for some small blocks}
{$define UseCustomFixedSizeMoveRoutines}
{Use custom variable size move routines for larger blocks}
{$define UseCustomVariableSizeMoveRoutines}

{--------------------------------Windows API------------------------------}
const
  {Memory constants}
  MEM_COMMIT = $1000;
  MEM_RESERVE  = $2000;
  MEM_RELEASE = $8000;
  MEM_FREE = $10000;
  MEM_TOP_DOWN = $100000;
  PAGE_READONLY = 2;
  PAGE_READWRITE = 4;
  PAGE_EXECUTE = $10;
  PAGE_EXECUTE_READ = $20;
  PAGE_EXECUTE_READWRITE = $40;
  PAGE_EXECUTE_WRITECOPY = $80;
  PAGE_GUARD = $100;
  {Messagebox Constants}
  MB_OK = $00000000;
  MB_ICONERROR = $00000010;
  MB_TASKMODAL = $00002000;
  {File mapping constants}
  INVALID_HANDLE_VALUE = NativeUInt(-1);
  FILE_MAP_WRITE = 2;
  FILE_MAP_READ = 4;

{Windows API functions used by the memory manager}
function VirtualAlloc(lpAddress: Pointer;
  dwSize: NativeUInt; flAllocationType, flProtect: Cardinal): Pointer; stdcall;
  external kernel name 'VirtualAlloc';
function VirtualFree(lpAddress: Pointer; dwSize: NativeUInt;
  dwFreeType: Cardinal): LongBool; stdcall;
  external kernel name 'VirtualFree';
procedure Sleep(dwMilliseconds: Cardinal); stdcall;
  external kernel name 'Sleep';
function GetCurrentProcessId: Cardinal; stdcall;
  external kernel name 'GetCurrentProcessId';
function CreateFileMappingA(hFile: THandle; lpFileMappingAttributes: Pointer;
  flProtect, dwMaximumSizeHigh, dwMaximumSizeLow: Cardinal;
  lpName: _PAnsiChr): THandle; stdcall;
  external kernel name 'CreateFileMappingA';
function OpenFileMappingA(dwDesiredAccess: Cardinal; bInheritHandle: LongBool;
  lpName: _PAnsiChr): THandle; stdcall;
  external kernel name 'OpenFileMappingA';
function MapViewOfFile(hFileMappingObject: THandle; dwDesiredAccess: Cardinal;
  dwFileOffsetHigh, dwFileOffsetLow: Cardinal;
  dwNumberOfBytesToMap: NativeUInt): Pointer; stdcall;
  external kernel name 'MapViewOfFile';
function UnmapViewOfFile(lpBaseAddress: Pointer): LongBool; stdcall;
  external kernel name 'UnmapViewOfFile';

{-------------------------Fixed size move procedures----------------------}
{$ifdef UseCustomFixedSizeMoveRoutines}
{$ifdef CPU386}
procedure Move12(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move20(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move28(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move36(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move44(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move52(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move60(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move68(const ASource; var ADest; ACount: NativeInt); forward;
{$else}
procedure Move8(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move24(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move40(const ASource; var ADest; ACount: NativeInt); forward;
procedure Move56(const ASource; var ADest; ACount: NativeInt); forward;
{$endif}
{$endif}

{---------------------------Private constants-----------------------------}
const
  {The size of a medium block pool. This is allocated through VirtualAlloc and
   is used to serve medium blocks. The size must be a multiple of 16 and at
   least 4 bytes less than a multiple of 4K (the page size) to prevent a
   possible read access violation when reading past the end of a memory block
   in the optimized move routine (MoveX16LP).}
  MediumBlockPoolSize = 20 * 64 * 1024 - 16;
  {The granularity of small blocks}
  SmallBlockGranularity = 8;
  {The granularity of medium blocks. Newly allocated medium blocks are
   a multiple of this size plus MediumBlockSizeOffset, to avoid cache line
   conflicts}
  MediumBlockGranularity = 256;
  MediumBlockSizeOffset = 48;
  {The granularity of large blocks}
  LargeBlockGranularity = 65536;
  {The maximum size of a small block. Blocks Larger than this are either
   medium or large blocks.}
  MaximumSmallBlockSize = 2608;
  {The smallest medium block size. (Medium blocks are rounded up to the nearest
   multiple of MediumBlockGranularity plus MediumBlockSizeOffset)}
  MinimumMediumBlockSize = 11 * 256 + MediumBlockSizeOffset;
  {The number of bins reserved for medium blocks}
  MediumBlockBinsPerGroup = 32;
  MediumBlockBinGroupCount = 32;
  MediumBlockBinCount = MediumBlockBinGroupCount * MediumBlockBinsPerGroup;
  {The maximum size allocatable through medium blocks. Blocks larger than this
   fall through to VirtualAlloc ( = large blocks).}
  MaximumMediumBlockSize = MinimumMediumBlockSize + (MediumBlockBinCount - 1) * MediumBlockGranularity;
  {The target number of small blocks per pool. The actual number of blocks per
   pool may be much greater for very small sizes and less for larger sizes. The
   cost of allocating the small block pool is amortized across all the small
   blocks in the pool, however the blocks may not all end up being used so they
   may be lying idle.}
  TargetSmallBlocksPerPool = 48;
  {The minimum number of small blocks per pool. Any available medium block must
   have space for roughly this many small blocks (or more) to be useable as a
   small block pool.}
  MinimumSmallBlocksPerPool = 12;
  {The lower and upper limits for the optimal small block pool size}
  OptimalSmallBlockPoolSizeLowerLimit = 29 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset;
  OptimalSmallBlockPoolSizeUpperLimit = 64 * 1024 - MediumBlockGranularity + MediumBlockSizeOffset;
  {The maximum small block pool size. If a free block is this size or larger
   then it will be split.}
  MaximumSmallBlockPoolSize = OptimalSmallBlockPoolSizeUpperLimit + MinimumMediumBlockSize;
  {----------------------------Block type flags---------------------------}
  {The lower 3 bits in the dword header of small blocks (4 bits in medium and
   large blocks) are used as flags to indicate the state of the block}
  {Set if the block is not in use}
  IsFreeBlockFlag = 1;
  {Set if this is a medium block}
  IsMediumBlockFlag = 2;
  {Set if it is a medium block being used as a small block pool. Only valid if
   IsMediumBlockFlag is set.}
  IsSmallBlockPoolInUseFlag = 4;
  {Set if it is a large block. Only valid if IsMediumBlockFlag is not set.}
  IsLargeBlockFlag = 4;
  {Is the medium block preceding this block available?}
  PreviousMediumBlockIsFreeFlag = 8;
  {Is this large block segmented? I.e. is it actually built up from more than
   one chunk allocated through VirtualAlloc? (Only used by large blocks.)}
  LargeBlockIsSegmented = 8;
  {The flags masks for small blocks}
  DropSmallFlagsMask = -8;
  ExtractSmallFlagsMask = 7;
  {The flags masks for medium and large blocks}
  DropMediumAndLargeFlagsMask = -16;
  ExtractMediumAndLargeFlagsMask = 15;
  {-------------------------Block resizing constants----------------------}
  SmallBlockDownsizeCheckAdder = 64;
  SmallBlockUpsizeAdder = 32;
  {When a medium block is reallocated to a size smaller than this, then it must
   be reallocated to a small block and the data moved. If not, then it is
   shrunk in place down to MinimumMediumBlockSize. Currently the limit is set
   at a quarter of the minimum medium block size.}
  MediumInPlaceDownsizeLimit = MinimumMediumBlockSize div 4;
  {-----------------------------Other constants---------------------------}
  {Sleep time when a resource (small/medium/large block manager) is in use}
  InitialSleepTime = 0;
  {Used when the resource is still in use after the first sleep}
  AdditionalSleepTime = 10;
  {Hexadecimal characters}
  HexTable: array[0..15] of _AnsiChr = ('0', '1', '2', '3', '4', '5', '6', '7',
    '8', '9', 'A', 'B', 'C', 'D', 'E', 'F');
  {Copyright message - not used anywhere in the code}
  Copyright: _AnsiStr = 'FastMM Embarcadero Edition (c) 2004 - 2011 Pierre le Riche';
{$ifdef IncludeMemoryLeakTrackingCode}
  {-----------------------Memory leak reporting constants-----------------}
  ExpectedMemoryLeaksListSize = 64 * 1024;
  {-------------------Memory leak messages (may be localized)-------------}
  {Leak checking messages}
  LeakMessageHeader: _PAnsiChr = 'An unexpected memory leak has occurred. ';
  SmallLeakDetail: _PAnsiChr = 'The unexpected small block leaks are:'#13#10;
  LargeLeakDetail: _PAnsiChr = 'The sizes of unexpected leaked medium and large blocks are: ';
  BytesMessage: _PAnsiChr = ' bytes: ';
  UnknownClassNameMsg: _PAnsiChr = 'Unknown';
  AnsiStringBlockMessage: _PAnsiChr = 'AnsiString';
  UnicodeStringBlockMessage: _PAnsiChr = 'UnicodeString';
  LeakMessageFooter: _PAnsiChr = #13#10#0;
  LeakMessageTitle: _PAnsiChr = 'Unexpected Memory Leak';
{$endif}
  {Sharing errors}
  ShareMMErrorTitle: _PAnsiChr = 'Cannot Switch Memory Manager';
  LivePointersErrorMsg: _PAnsiChr = 'The memory manager cannot be changed after it has been used.';

{------------------------------Private types------------------------------}
type

  {Move procedure type}
  TMoveProc = procedure(const ASource; var ADest; ACount: NativeInt);

  {-----------------------Small block structures--------------------------}

  {Pointer to the header of a small block pool}
  PSmallBlockPoolHeader = ^TSmallBlockPoolHeader;

  {Small block type (Size = 32 bytes for 32-bit, 64 bytes for 64-bit).}
  PSmallBlockType = ^TSmallBlockType;
  TSmallBlockType = record
    {True = Block type is locked}
    BlockTypeLocked: Boolean;
    {Bitmap indicating which of the first 8 medium block groups contain blocks
     of a suitable size for a block pool.}
    AllowedGroupsForBlockPoolBitmap: Byte;
    {The block size for this block type}
    BlockSize: Word;
    {The minimum and optimal size of a small block pool for this block type}
    MinimumBlockPoolSize: Word;
    OptimalBlockPoolSize: Word;
    {The first partially free pool for the given small block. This field must
     be at the same offset as TSmallBlockPoolHeader.NextPartiallyFreePool.}
    NextPartiallyFreePool: PSmallBlockPoolHeader;
    {The last partially free pool for the small block type. This field must
     be at the same offset as TSmallBlockPoolHeader.PreviousPartiallyFreePool.}
    PreviousPartiallyFreePool: PSmallBlockPoolHeader;
    {The offset of the last block that was served sequentially. The field must
     be at the same offset as TSmallBlockPoolHeader.FirstFreeBlock.}
    NextSequentialFeedBlockAddress: Pointer;
    {The last block that can be served sequentially.}
    MaxSequentialFeedBlockAddress: Pointer;
    {The pool that is current being used to serve blocks in sequential order}
    CurrentSequentialFeedPool: PSmallBlockPoolHeader;
{$ifdef UseCustomFixedSizeMoveRoutines}
    {The fixed size move procedure used to move data for this block size when
     it is upsized. When a block is downsized (which usually does not occur
     that often) the variable size move routine is used.}
    UpsizeMoveProcedure: TMoveProc;
{$else}
    Reserved1: Pointer;
{$endif}
{$if SizeOf(Pointer) = 8}
    {Pad to 64 bytes for 64-bit}
    Reserved2: Pointer;
{$endif}
  end;

  {Small block pool (Size = 32 bytes for 32-bit, 48 bytes for 64-bit).}
  TSmallBlockPoolHeader = record
    {BlockType}
    BlockType: PSmallBlockType;
{$if SizeOf(Pointer) <> 8}
    {Align the next fields to the same fields in TSmallBlockType and pad this
     structure to 32 bytes for 32-bit}
    Reserved1: Cardinal;
{$endif}
    {The next and previous pool that has free blocks of this size. Do not
     change the position of these two fields: They must be at the same offsets
     as the fields in TSmallBlockType of the same name.}
    NextPartiallyFreePool: PSmallBlockPoolHeader;
    PreviousPartiallyFreePool: PSmallBlockPoolHeader;
    {Pointer to the first free block inside this pool. This field must be at
     the same offset as TSmallBlockType.NextSequentialFeedBlockAddress.}
    FirstFreeBlock: Pointer;
    {The number of blocks allocated in this pool.}
    BlocksInUse: Cardinal;
    {Small block pool signature. Used by the leak checking mechanism to
     determine whether a medium block is a small block pool or a regular medium
     block.}
    SmallBlockPoolSignature: Cardinal;
    {The pool pointer and flags of the first block}
    FirstBlockPoolPointerAndFlags: NativeUInt;
  end;

  {Small block layout:
   At offset -SizeOf(Pointer) = Flags + address of the small block pool.
   At offset BlockSize - SizeOf(Pointer) = Flags + address of the small block
   pool for the next small block.
  }

  {------------------------Medium block structures------------------------}

  {The medium block pool from which medium blocks are drawn. Size = 16 bytes
   for 32-bit and 32 bytes for 64-bit.}
  PMediumBlockPoolHeader = ^TMediumBlockPoolHeader;
  TMediumBlockPoolHeader = record
    {Points to the previous and next medium block pools. This circular linked
     list is used to track memory leaks on program shutdown.}
    PreviousMediumBlockPoolHeader: PMediumBlockPoolHeader;
    NextMediumBlockPoolHeader: PMediumBlockPoolHeader;
    {Padding}
    Reserved1: NativeUInt;
    {The block size and flags of the first medium block in the block pool}
    FirstMediumBlockSizeAndFlags: NativeUInt;
  end;

  {Medium block layout:
   Offset: -2 * SizeOf(Pointer) = Previous Block Size (only if the previous block is free)
   Offset: -SizeOf(Pointer) = This block size and flags
   Offset: 0 = User data / Previous Free Block (if this block is free)
   Offset: SizeOf(Pointer) = Next Free Block (if this block is free)
   Offset: BlockSize - 2*SizeOf(Pointer) = Size of this block (if this block is free)
   Offset: BlockSize - SizeOf(Pointer) = Size of the next block and flags

  {A medium block that is unused}
  PMediumFreeBlock = ^TMediumFreeBlock;
  TMediumFreeBlock = record
    PreviousFreeBlock: PMediumFreeBlock;
    NextFreeBlock: PMediumFreeBlock;
  end;

  {-------------------------Large block structures------------------------}

  {Large block header record (Size = 16 for 32-bit, 32 for 64-bit)}
  PLargeBlockHeader = ^TLargeBlockHeader;
  TLargeBlockHeader = record
    {Points to the previous and next large blocks. This circular linked
     list is used to track memory leaks on program shutdown.}
    PreviousLargeBlockHeader: PLargeBlockHeader;
    NextLargeBlockHeader: PLargeBlockHeader;
    {The user allocated size of the Large block}
    UserAllocatedSize: NativeUInt;
    {The size of this block plus the flags}
    BlockSizeAndFlags: NativeUInt;
  end;

  {--------------------Expected Memory Leak Structures--------------------}

{$ifdef IncludeMemoryLeakTrackingCode}
  TExpectedMemoryLeaks = record
    {The number of entries used in the expected leaks buffer}
    NumExpectedLeaks: Integer;
    {The expected leaks buffer}
    ExpectedLeaks: array[0..(ExpectedMemoryLeaksListSize - SizeOf(Pointer)) div SizeOf(Pointer) - 1] of Pointer;
  end;
  PExpectedMemoryLeaks = ^TExpectedMemoryLeaks;
{$endif}

{---------------------------Private constants-----------------------------}
const
  {The size of the block header in front of small and medium blocks}
  BlockHeaderSize = SizeOf(Pointer);
  {The size of a small block pool header}
  SmallBlockPoolHeaderSize = SizeOf(TSmallBlockPoolHeader);
  {The size of a medium block pool header}
  MediumBlockPoolHeaderSize = SizeOf(TMediumBlockPoolHeader);
  {The size of the header in front of Large blocks}
  LargeBlockHeaderSize = SizeOf(TLargeBlockHeader);
  {This memory manager}
  ThisMemoryManager: TMemoryManagerEx = (
    GetMem: SysGetMem;
    FreeMem: SysFreeMem;
    ReallocMem: SysReallocMem;
    AllocMem: SysAllocMem;
    RegisterExpectedMemoryLeak: SysRegisterExpectedMemoryLeak;
    UnregisterExpectedMemoryLeak: SysUnregisterExpectedMemoryLeak);

{---------------------------Private variables-----------------------------}
var
  {-----------------------Small block management--------------------------}
  {The small block types. Sizes include the leading block header. Sizes are
   picked to limit maximum wastage to about 10% or 256 bytes (whichever is
   less) where possible.}
  SmallBlockTypes: array[0..NumSmallBlockTypes - 1] of TSmallBlockType =(
    {8/16 byte jumps}
    (BlockSize: 16{$ifdef UseCustomFixedSizeMoveRoutines};
      UpsizeMoveProcedure: {$ifdef CPU386)}Move12{$else}Move8{$endif}{$endif}),
{$ifdef CPU386}
    (BlockSize: 24{$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move20{$endif}),
{$endif}
    (BlockSize: 32{$ifdef UseCustomFixedSizeMoveRoutines};
      UpsizeMoveProcedure: {$ifdef CPU386}Move28{$else}Move24{$endif}{$endif}),
{$ifdef CPU386}
    (BlockSize: 40{$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move36{$endif}),
{$endif}
    (BlockSize: 48{$ifdef UseCustomFixedSizeMoveRoutines};
      UpsizeMoveProcedure: {$ifdef CPU386}Move44{$else}Move40{$endif}{$endif}),
{$ifdef CPU386}
    (BlockSize: 56{$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move52{$endif}),
{$endif}
    (BlockSize: 64{$ifdef UseCustomFixedSizeMoveRoutines};
      UpsizeMoveProcedure: {$ifdef CPU386}Move60{$else}Move56{$endif}{$endif}),
{$ifdef CPU386}
    (BlockSize: 72{$ifdef UseCustomFixedSizeMoveRoutines}; UpsizeMoveProcedure: Move68{$endif}),
{$endif}
    (BlockSize: 80),
{$ifdef CPU386}
    (BlockSize: 88),
{$endif}
    (BlockSize: 96),
{$ifdef CPU386}
    (BlockSize: 104),
{$endif}
    (BlockSize: 112),
{$ifdef CPU386}
    (BlockSize: 120),
{$endif}
    (BlockSize: 128),
{$ifdef CPU386}
    (BlockSize: 136),
{$endif}
    (BlockSize: 144),
{$ifdef CPU386}
    (BlockSize: 152),
{$endif}
    (BlockSize: 160),
    {16 byte jumps}
    (BlockSize: 176),
    (BlockSize: 192),
    (BlockSize: 208),
    (BlockSize: 224),
    (BlockSize: 240),
    (BlockSize: 256),
    (BlockSize: 272),
    (BlockSize: 288),
    (BlockSize: 304),
    (BlockSize: 320),
    {32 byte jumps}
    (BlockSize: 352),
    (BlockSize: 384),
    (BlockSize: 416),
    (BlockSize: 448),
    (BlockSize: 480),
    {48 byte jumps}
    (BlockSize: 528),
    (BlockSize: 576),
    (BlockSize: 624),
    (BlockSize: 672),
    {64 byte jumps}
    (BlockSize: 736),
    (BlockSize: 800),
    {80 byte jumps}
    (BlockSize: 880),
    (BlockSize: 960),
    {96 byte jumps}
    (BlockSize: 1056),
    (BlockSize: 1152),
    {112 byte jumps}
    (BlockSize: 1264),
    (BlockSize: 1376),
    {128 byte jumps}
    (BlockSize: 1504),
    {144 byte jumps}
    (BlockSize: 1648),
    {160 byte jumps}
    (BlockSize: 1808),
    {176 byte jumps}
    (BlockSize: 1984),
    {192 byte jumps}
    (BlockSize: 2176),
    {208 byte jumps}
    (BlockSize: 2384),
    {224 byte jumps}
    (BlockSize: MaximumSmallBlockSize),
    {The last block size occurs three times. If, during a GetMem call, the
     requested block size is already locked by another thread then up to two
     larger block sizes may be used instead. Having the last block size occur
     three times avoids the need to have a size overflow check.}
    (BlockSize: MaximumSmallBlockSize),
    (BlockSize: MaximumSmallBlockSize));
  {Size to small block type translation table}
  AllocSize2SmallBlockTypeIndX4: array[0..(MaximumSmallBlockSize - 1) div SmallBlockGranularity] of byte;
  {The minimum block alignment. Under 64-bit blocks are always aligned to a 16
   byte boundary.}
  MinimumBlockAlignment: TMinimumBlockAlignment {$if SizeOf(Pointer) = 8} = mba16Byte {$endif};
  {-----------------------Medium block management-------------------------}
  {A dummy medium block pool header: Maintains a circular list of all medium
   block pools to enable memory leak detection on program shutdown.}
  MediumBlockPoolsCircularList: TMediumBlockPoolHeader;
  {Are medium blocks locked?}
  MediumBlocksLocked: Boolean;
  {The sequential feed medium block pool.}
  LastSequentiallyFedMediumBlock: Pointer;
  MediumSequentialFeedBytesLeft: Cardinal;
  {The medium block bins are divided into groups of 32 bins. If a bit
   is set in this group bitmap, then at least one bin in the group has free
   blocks.}
  MediumBlockBinGroupBitmap: Cardinal;
  {The medium block bins: total of 32 * 32 = 1024 bins of a certain
   minimum size.}
  MediumBlockBinBitmaps: array[0..MediumBlockBinGroupCount - 1] of Cardinal;
  {The medium block bins. There are 1024 LIFO circular linked lists each
   holding blocks of a specified minimum size. The sizes vary in size from
   MinimumMediumBlockSize to MaximumMediumBlockSize. The bins are treated as
   type TMediumFreeBlock to avoid pointer checks.}
  MediumBlockBins: array[0..MediumBlockBinCount - 1] of TMediumFreeBlock;
  {-------------------------Large block management------------------------}
  {Are large blocks locked?}
  LargeBlocksLocked: Boolean;
  {A dummy large block header: Maintains a list of all allocated large blocks
   to enable memory leak detection on program shutdown.}
  LargeBlocksCircularList: TLargeBlockHeader;
  {---------------------Expected Memory Leak Structures-------------------}
{$ifdef IncludeMemoryLeakTrackingCode}
  {The expected memory leaks}
  ExpectedMemoryLeaks: PExpectedMemoryLeaks;
  ExpectedMemoryLeaksListLocked: Boolean;
{$endif}
  {------------------------------Other info-------------------------------}
  {A string uniquely identifying the current process (for sharing the memory
   manager between DLLs and the main application).}
  MappingObjectName: array[0..25] of _AnsiChr = ('L', 'o', 'c', 'a', 'l', '\',
    'F', 'a', 's', 't', 'M', 'M', '_', 'P', 'I', 'D', '_', '?', '?', '?', '?',
    '?', '?', '?', '?', #0);
  {The handle of the memory mapped file that contains the pointer to the
   TMemoryManagerEx structure of the shared memory manager.}
  MappingObjectHandle: THandle;

{----------------------------Utility Functions----------------------------}

{Compare [AAddress], CompareVal:
 If Equal: [AAddress] := NewVal and result = CompareVal
 If Unequal: Result := [AAddress]}
function LockCmpxchg(CompareVal, NewVal: Byte; AAddress: PByte): Byte;
asm
{$ifdef CPU386}
  {On entry:
    al = CompareVal,
    dl = NewVal,
    ecx = AAddress}
  lock cmpxchg [ecx], dl
{$else}
  {On entry:
    cl = CompareVal
    dl = NewVal
    r8 = AAddress}
  .noframe
  mov rax, rcx
  lock cmpxchg [r8], dl
{$endif}
end;

{$ifdef UsePascalCode}
{Gets the first set bit and resets it, returning the bit index}
function FindFirstSetBit(ACardinal: Cardinal): Cardinal;
asm
  {On entry:
    eax = ACardinal}
{$if not defined(CPU386)}
  mov rax, rcx
{$endif}
  bsf eax, eax
end;
{$endif}

{----------------------Specialised Move Procedures------------------------}

{$ifdef UseCustomFixedSizeMoveRoutines}
{Fixed size move operations ignore the size parameter. All moves are assumed to
 be non-overlapping.}

{$ifdef CPU386}

procedure Move12(const ASource; var ADest; ACount: NativeInt);
asm
  mov ecx, [eax]
  mov [edx], ecx
  mov ecx, [eax + 4]
  mov eax, [eax + 8]
  mov [edx + 4], ecx
  mov [edx + 8], eax
end;

procedure Move20(const ASource; var ADest; ACount: NativeInt);
asm
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
end;

procedure Move28(const ASource; var ADest; ACount: NativeInt);
asm
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
end;

procedure Move36(const ASource; var ADest; ACount: NativeInt);
asm
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
end;

procedure Move44(const ASource; var ADest; ACount: NativeInt);
asm
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
end;

procedure Move52(const ASource; var ADest; ACount: NativeInt);
asm
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
end;

procedure Move60(const ASource; var ADest; ACount: NativeInt);
asm
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
end;

procedure Move68(const ASource; var ADest; ACount: NativeInt);
asm
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
end;

{$else}

procedure Move8(const ASource; var ADest; ACount: NativeInt);
asm
  mov rax, [rcx]
  mov [rdx], rax
end;

procedure Move24(const ASource; var ADest; ACount: NativeInt);
asm
  movdqa xmm0, [rcx]
  mov r8, [rcx + 16]
  movdqa [rdx], xmm0
  mov [rdx + 16], r8
end;

procedure Move40(const ASource; var ADest; ACount: NativeInt);
asm
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  mov r8, [rcx + 32]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  mov [rdx + 32], r8
end;

procedure Move56(const ASource; var ADest; ACount: NativeInt);
asm
  movdqa xmm0, [rcx]
  movdqa xmm1, [rcx + 16]
  movdqa xmm2, [rcx + 32]
  mov r8, [rcx + 48]
  movdqa [rdx], xmm0
  movdqa [rdx + 16], xmm1
  movdqa [rdx + 32], xmm2
  mov [rdx + 48], r8
end;
{$endif}
{$endif}

{$ifdef UseCustomVariableSizeMoveRoutines}
{Variable size move procedure: Rounds ACount up to the next multiple of 16 less
 SizeOf(Pointer). Important note: Always moves at least 16 - SizeOf(Pointer)
 bytes (the minimum small block size with 16 byte alignment), irrespective of
 ACount.}
procedure MoveX16LP(const ASource; var ADest; ACount: NativeInt);
asm
{$ifdef CPU386}
  {Make the counter negative based: The last 12 bytes are moved separately}
  sub ecx, 12
  add eax, ecx
  add edx, ecx
  neg ecx
  jns @MoveLast12
@MoveLoop:
  {Move a 16 byte block}
  fild qword ptr [eax + ecx]
  fild qword ptr [eax + ecx + 8]
  fistp qword ptr [edx + ecx + 8]
  fistp qword ptr [edx + ecx]
  {Are there another 16 bytes to move?}
  add ecx, 16
  js @MoveLoop
@MoveLast12:
  {Do the last 12 bytes}
  fild qword ptr [eax + ecx]
  fistp qword ptr [edx + ecx]
  mov eax, [eax + ecx + 8]
  mov [edx + ecx + 8], eax
{$else}
  {Make the counter negative based: The last 8 bytes are moved separately}
  sub r8, 8
  add rcx, r8
  add rdx, r8
  neg r8
  jns @MoveLast12
@MoveLoop:
  {Move a 16 byte block}
  movdqa xmm0, [rcx + r8]
  movdqa [rdx + r8], xmm0
  {Are there another 16 bytes to move?}
  add r8, 16
  js @MoveLoop
@MoveLast12:
  {Do the last 8 bytes}
  mov r9, [rcx + r8]
  mov [rdx + r8], r9
{$endif}
end;

{$ifdef CPU386}
{Variable size move procedure: Rounds ACount up to the next multiple of 8 less
 SizeOf(Pointer). Important note: Always moves at least 8 - SizeOf(Pointer)
 bytes (the minimum small block size with 8 byte alignment), irrespective of
 ACount.}
procedure MoveX8LP(const ASource; var ADest; ACount: NativeInt);
asm
  {Make the counter negative based: The last 4 bytes are moved separately}
  sub ecx, 4
  add eax, ecx
  add edx, ecx
  neg ecx
@MoveLoop:
  {Move an 8 byte block}
  fild qword ptr [eax + ecx]
  fistp qword ptr [edx + ecx]
  {Are there another 8 bytes to move?}
  add ecx, 8
  js @MoveLoop
  {Do the last 4 bytes}
  mov eax, [eax + ecx]
  mov [edx + ecx], eax
end;
{$endif}
{$endif}

{-------------------------Small Block Management-------------------------}

{Locks all small block types}
procedure LockAllSmallBlockTypes;
var
  LInd: Cardinal;
begin
  if IsMultiThread then
  begin
    for LInd := 0 to NumSmallBlockTypes - 1 do
    begin
      while LockCmpxchg(0, 1, @SmallBlockTypes[LInd].BlockTypeLocked) <> 0 do
      begin
        if not NeverSleepOnMMThreadContention then
        begin
          Sleep(InitialSleepTime);
          if LockCmpxchg(0, 1, @SmallBlockTypes[LInd].BlockTypeLocked) = 0 then
            Break;
          Sleep(AdditionalSleepTime);
        end;
      end;
    end;
  end;
end;

{-------------------------Medium Block Management-------------------------}

{Locks the medium blocks}
procedure LockMediumBlocks;
begin
  {Lock the medium blocks}
  if IsMultiThread then
  begin
    while LockCmpxchg(0, 1, @MediumBlocksLocked) <> 0 do
    begin
      if not NeverSleepOnMMThreadContention then
      begin
        Sleep(InitialSleepTime);
        if LockCmpxchg(0, 1, @MediumBlocksLocked) = 0 then
          Break;
        Sleep(AdditionalSleepTime);
      end;
    end;
  end;
end;

{Removes a medium block from the circular linked list of free blocks.
 Does not change any header flags. Medium blocks should be locked
 before calling this procedure.}
{$ifdef UsePascalCode}
procedure RemoveMediumFreeBlock(APMediumFreeBlock: PMediumFreeBlock);
var
  LPreviousFreeBlock, LNextFreeBlock: PMediumFreeBlock;
  LBinNumber, LBinGroupNumber: Cardinal;
begin
  {Get the current previous and next blocks}
  LNextFreeBlock := APMediumFreeBlock.NextFreeBlock;
  LPreviousFreeBlock := APMediumFreeBlock.PreviousFreeBlock;
  {Remove this block from the linked list}
  LPreviousFreeBlock.NextFreeBlock := LNextFreeBlock;
  LNextFreeBlock.PreviousFreeBlock := LPreviousFreeBlock;
  {Is this bin now empty? If the previous and next free block pointers are
   equal, they must point to the bin.}
  if LPreviousFreeBlock = LNextFreeBlock then
  begin
    {Get the bin number for this block size}
    LBinNumber := (UIntPtr(LNextFreeBlock) - UIntPtr(@MediumBlockBins)) div SizeOf(TMediumFreeBlock);
    LBinGroupNumber := LBinNumber div 32;
    {Flag this bin as empty}
    MediumBlockBinBitmaps[LBinGroupNumber] := MediumBlockBinBitmaps[LBinGroupNumber]
      and (not (1 shl (LBinNumber and 31)));
    {Is the group now entirely empty?}
    if MediumBlockBinBitmaps[LBinGroupNumber] = 0 then
    begin
      {Flag this group as empty}
      MediumBlockBinGroupBitmap := MediumBlockBinGroupBitmap
        and (not (1 shl LBinGroupNumber));
    end;
  end;
end;
{$else}
procedure RemoveMediumFreeBlock(APMediumFreeBlock: PMediumFreeBlock);
asm
{$ifdef CPU386}
  {On entry: eax = APMediumFreeBlock}
  {Get the current previous and next blocks}
  mov ecx, TMediumFreeBlock[eax].NextFreeBlock
  mov edx, TMediumFreeBlock[eax].PreviousFreeBlock
  {Is this bin now empty? If the previous and next free block pointers are
   equal, they must point to the bin.}
  cmp ecx, edx
  {Remove this block from the linked list}
  mov TMediumFreeBlock[ecx].PreviousFreeBlock, edx
  mov TMediumFreeBlock[edx].NextFreeBlock, ecx
  {Is this bin now empty? If the previous and next free block pointers are
   equal, they must point to the bin.}
  je @BinIsNowEmpty
@Done:
  ret
  {Align branch target}
  nop
@BinIsNowEmpty:
  {Get the bin number for this block size in ecx}
  sub ecx, offset MediumBlockBins
  mov edx, ecx
  shr ecx, 3
  {Get the group number in edx}
  movzx edx, dh
  {Flag this bin as empty}
  mov eax, -2
  rol eax, cl
  and dword ptr [MediumBlockBinBitmaps + edx * 4], eax
  jnz @Done
  {Flag this group as empty}
  mov eax, -2
  mov ecx, edx
  rol eax, cl
  and MediumBlockBinGroupBitmap, eax
{$else}
  {On entry: rcx = APMediumFreeBlock}
  mov rax, rcx
  {Get the current previous and next blocks}
  mov rcx, TMediumFreeBlock[rax].NextFreeBlock
  mov rdx, TMediumFreeBlock[rax].PreviousFreeBlock
  {Is this bin now empty? If the previous and next free block pointers are
   equal, they must point to the bin.}
  cmp rcx, rdx
  {Remove this block from the linked list}
  mov TMediumFreeBlock[rcx].PreviousFreeBlock, rdx
  mov TMediumFreeBlock[rdx].NextFreeBlock, rcx
  {Is this bin now empty? If the previous and next free block pointers are
   equal, they must point to the bin.}
  jne @Done
  {Get the bin number for this block size in rcx}
  lea r8, MediumBlockBins
  sub rcx, r8
  mov edx, ecx
  shr ecx, 4
  {Get the group number in edx}
  shr edx, 9
  {Flag this bin as empty}
  mov eax, -2
  rol eax, cl
  lea r8, MediumBlockBinBitmaps
  and dword ptr [r8 + rdx * 4], eax
  jnz @Done
  {Flag this group as empty}
  mov eax, -2
  mov ecx, edx
  rol eax, cl
  and MediumBlockBinGroupBitmap, eax
@Done:
{$endif}
end;
{$endif}

{Inserts a medium block into the appropriate medium block bin.}
{$ifdef UsePascalCode}
procedure InsertMediumBlockIntoBin(APMediumFreeBlock: PMediumFreeBlock; AMediumBlockSize: Cardinal);
var
  LBinNumber, LBinGroupNumber: Cardinal;
  LPBin, LPFirstFreeBlock: PMediumFreeBlock;
begin
  {Get the bin number for this block size. Get the bin that holds blocks of at
   least this size.}
  LBinNumber := (AMediumBlockSize - MinimumMediumBlockSize) div MediumBlockGranularity;
  if LBinNumber >= MediumBlockBinCount then
    LBinNumber := MediumBlockBinCount - 1;
  {Get the bin}
  LPBin := @MediumBlockBins[LBinNumber];
  {Bins are LIFO, se we insert this block as the first free block in the bin}
  LPFirstFreeBlock := LPBin.NextFreeBlock;
  APMediumFreeBlock.PreviousFreeBlock := LPBin;
  APMediumFreeBlock.NextFreeBlock := LPFirstFreeBlock;
  LPFirstFreeBlock.PreviousFreeBlock := APMediumFreeBlock;
  LPBin.NextFreeBlock := APMediumFreeBlock;
  {Was this bin empty?}
  if LPFirstFreeBlock = LPBin then
  begin
    {Get the group number}
    LBinGroupNumber := LBinNumber div 32;
    {Flag this bin as used}
    MediumBlockBinBitmaps[LBinGroupNumber] := MediumBlockBinBitmaps[LBinGroupNumber]
      or (1 shl (LBinNumber and 31));
    {Flag the group as used}
    MediumBlockBinGroupBitmap := MediumBlockBinGroupBitmap
      or (1 shl LBinGroupNumber);
  end;
end;
{$else}
procedure InsertMediumBlockIntoBin(APMediumFreeBlock: PMediumFreeBlock; AMediumBlockSize: Cardinal);
asm
{$ifdef CPU386}
  {On entry: eax = APMediumFreeBlock, edx = AMediumBlockSize}
  {Get the bin number for this block size. Get the bin that holds blocks of at
   least this size.}
  sub edx, MinimumMediumBlockSize
  shr edx, 8
  {Validate the bin number}
  sub edx, MediumBlockBinCount - 1
  sbb ecx, ecx
  and edx, ecx
  add edx, MediumBlockBinCount - 1
  {Get the bin in ecx}
  lea ecx, [MediumBlockBins + edx * 8]
  {Bins are LIFO, se we insert this block as the first free block in the bin}
  mov edx, TMediumFreeBlock[ecx].NextFreeBlock
  {Was this bin empty?}
  cmp edx, ecx
  mov TMediumFreeBlock[eax].PreviousFreeBlock, ecx
  mov TMediumFreeBlock[eax].NextFreeBlock, edx
  mov TMediumFreeBlock[edx].PreviousFreeBlock, eax
  mov TMediumFreeBlock[ecx].NextFreeBlock, eax
  {Was this bin empty?}
  je @BinWasEmpty
  ret
  {Align branch target}
  nop
  nop
@BinWasEmpty:
  {Get the bin number in ecx}
  sub ecx, offset MediumBlockBins
  mov edx, ecx
  shr ecx, 3
  {Get the group number in edx}
  movzx edx, dh
  {Flag this bin as not empty}
  mov eax, 1
  shl eax, cl
  or dword ptr [MediumBlockBinBitmaps + edx * 4], eax
  {Flag the group as not empty}
  mov eax, 1
  mov ecx, edx
  shl eax, cl
  or MediumBlockBinGroupBitmap, eax
{$else}
  {On entry: rax = APMediumFreeBlock, edx = AMediumBlockSize}
  mov rax, rcx
  {Get the bin number for this block size. Get the bin that holds blocks of at
   least this size.}
  sub edx, MinimumMediumBlockSize
  shr edx, 8
  {Validate the bin number}
  sub edx, MediumBlockBinCount - 1
  sbb ecx, ecx
  and edx, ecx
  add edx, MediumBlockBinCount - 1
  mov r9, rdx
  {Get the bin address in rcx}
  lea rcx, MediumBlockBins
  shl edx, 4
  add rcx, rdx
  {Bins are LIFO, se we insert this block as the first free block in the bin}
  mov rdx, TMediumFreeBlock[rcx].NextFreeBlock
  {Was this bin empty?}
  cmp rdx, rcx
  mov TMediumFreeBlock[rax].PreviousFreeBlock, rcx
  mov TMediumFreeBlock[rax].NextFreeBlock, rdx
  mov TMediumFreeBlock[rdx].PreviousFreeBlock, rax
  mov TMediumFreeBlock[rcx].NextFreeBlock, rax
  {Was this bin empty?}
  jne @Done
  {Get the bin number in ecx}
  mov rcx, r9
  {Get the group number in edx}
  mov rdx, r9
  shr edx, 5
  {Flag this bin as not empty}
  mov eax, 1
  shl eax, cl
  lea r8, MediumBlockBinBitmaps
  or dword ptr [r8 + rdx * 4], eax
  {Flag the group as not empty}
  mov eax, 1
  mov ecx, edx
  shl eax, cl
  or MediumBlockBinGroupBitmap, eax
@Done:
{$endif}
end;
{$endif}

{Bins what remains in the current sequential feed medium block pool. Medium
 blocks must be locked.}
{$ifdef UsePascalCode}
procedure BinMediumSequentialFeedRemainder;
var
  LSequentialFeedFreeSize, LNextBlockSizeAndFlags: NativeUInt;
  LPRemainderBlock, LNextMediumBlock: Pointer;
begin
  LSequentialFeedFreeSize := MediumSequentialFeedBytesLeft;
  if LSequentialFeedFreeSize > 0 then
  begin
    {Get the block after the open space}
    LNextMediumBlock := LastSequentiallyFedMediumBlock;
    LNextBlockSizeAndFlags := PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^;
    {Point to the remainder}
    LPRemainderBlock := Pointer(PByte(LNextMediumBlock) - LSequentialFeedFreeSize);
    {Can the next block be combined with the remainder?}
    if (LNextBlockSizeAndFlags and IsFreeBlockFlag) <> 0 then
    begin
      {Increase the size of this block}
      Inc(LSequentialFeedFreeSize, LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask);
      {Remove the next block as well}
      if (LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask) >= MinimumMediumBlockSize then
        RemoveMediumFreeBlock(LNextMediumBlock);
    end
    else
    begin
      {Set the "previous block is free" flag of the next block}
      PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^ := LNextBlockSizeAndFlags or PreviousMediumBlockIsFreeFlag;
    end;
    {Store the size of the block as well as the flags}
    PNativeUInt(PByte(LPRemainderBlock) - BlockHeaderSize)^ := LSequentialFeedFreeSize or IsMediumBlockFlag or IsFreeBlockFlag;
    {Store the trailing size marker}
    PNativeUInt(PByte(LPRemainderBlock) + LSequentialFeedFreeSize - BlockHeaderSize * 2)^ := LSequentialFeedFreeSize;
    {Bin this medium block}
    if LSequentialFeedFreeSize >= MinimumMediumBlockSize then
      InsertMediumBlockIntoBin(LPRemainderBlock, LSequentialFeedFreeSize);
  end;
end;
{$else}
procedure BinMediumSequentialFeedRemainder;
asm
{$ifdef CPU386}
  cmp MediumSequentialFeedBytesLeft, 0
  jne @MustBinMedium
  {Nothing to bin}
  ret
  {Align branch target}
  nop
  nop
@MustBinMedium:
  {Get a pointer to the last sequentially allocated medium block}
  mov eax, LastSequentiallyFedMediumBlock
  {Is the block that was last fed sequentially free?}
  test byte ptr [eax - 4], IsFreeBlockFlag
  jnz @LastBlockFedIsFree
  {Set the "previous block is free" flag in the last block fed}
  or dword ptr [eax - 4], PreviousMediumBlockIsFreeFlag
  {Get the remainder in edx}
  mov edx, MediumSequentialFeedBytesLeft
  {Point eax to the start of the remainder}
  sub eax, edx
@BinTheRemainder:
  {Status: eax = start of remainder, edx = size of remainder}
  {Store the size of the block as well as the flags}
  lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [eax - 4], ecx
  {Store the trailing size marker}
  mov [eax + edx - 8], edx
  {Bin this medium block}
  cmp edx, MinimumMediumBlockSize
  jnb InsertMediumBlockIntoBin
  ret
  {Align branch target}
  nop
  nop
@LastBlockFedIsFree:
  {Drop the flags}
  mov edx, DropMediumAndLargeFlagsMask
  and edx, [eax - 4]
  {Free the last block fed}
  cmp edx, MinimumMediumBlockSize
  jb @DontRemoveLastFed
  {Last fed block is free - remove it from its size bin}
  call RemoveMediumFreeBlock
  {Re-read eax and edx}
  mov eax, LastSequentiallyFedMediumBlock
  mov edx, DropMediumAndLargeFlagsMask
  and edx, [eax - 4]
@DontRemoveLastFed:
  {Get the number of bytes left in ecx}
  mov ecx, MediumSequentialFeedBytesLeft
  {Point eax to the start of the remainder}
  sub eax, ecx
  {edx = total size of the remainder}
  add edx, ecx
  jmp @BinTheRemainder
{$else}
  .params 2
  xor eax, eax
  cmp MediumSequentialFeedBytesLeft, eax
  je @Done
  {Get a pointer to the last sequentially allocated medium block}
  mov rax, LastSequentiallyFedMediumBlock
  {Is the block that was last fed sequentially free?}
  test byte ptr [rax - BlockHeaderSize], IsFreeBlockFlag
  jnz @LastBlockFedIsFree
  {Set the "previous block is free" flag in the last block fed}
  or qword ptr [rax - BlockHeaderSize], PreviousMediumBlockIsFreeFlag
  {Get the remainder in edx}
  mov edx, MediumSequentialFeedBytesLeft
  {Point eax to the start of the remainder}
  sub rax, rdx
@BinTheRemainder:
  {Status: rax = start of remainder, edx = size of remainder}
  {Store the size of the block as well as the flags}
  lea rcx, [rdx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [rax - BlockHeaderSize], rcx
  {Store the trailing size marker}
  mov [rax + rdx - 2 * BlockHeaderSize], rdx
  {Bin this medium block}
  cmp edx, MinimumMediumBlockSize
  jb @Done
  mov rcx, rax
  call InsertMediumBlockIntoBin
  jmp @Done
@LastBlockFedIsFree:
  {Drop the flags}
  mov rdx, DropMediumAndLargeFlagsMask
  and rdx, [rax - BlockHeaderSize]
  {Free the last block fed}
  cmp edx, MinimumMediumBlockSize
  jb @DontRemoveLastFed
  {Last fed block is free - remove it from its size bin}
  mov rcx, rax
  call RemoveMediumFreeBlock
  {Re-read rax and rdx}
  mov rax, LastSequentiallyFedMediumBlock
  mov rdx, DropMediumAndLargeFlagsMask
  and rdx, [rax - BlockHeaderSize]
@DontRemoveLastFed:
  {Get the number of bytes left in ecx}
  mov ecx, MediumSequentialFeedBytesLeft
  {Point rax to the start of the remainder}
  sub rax, rcx
  {edx = total size of the remainder}
  add edx, ecx
  jmp @BinTheRemainder
@Done:
{$endif}
end;
{$endif}

{Allocates a new sequential feed medium block pool and immediately splits off a
 block of the requested size. The block size must be a multiple of 16 and
 medium blocks must be locked.}
function AllocNewSequentialFeedMediumPool(AFirstBlockSize: Cardinal): Pointer;
var
  LOldFirstMediumBlockPool: PMediumBlockPoolHeader;
  LNewPool: Pointer;
begin
  {Bin the current sequential feed remainder}
  BinMediumSequentialFeedRemainder;
  {Allocate a new sequential feed block pool}
  LNewPool := VirtualAlloc(nil, MediumBlockPoolSize, MEM_COMMIT, PAGE_READWRITE);
  if LNewPool <> nil then
  begin
    {Insert this block pool into the list of block pools}
    LOldFirstMediumBlockPool := MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
    PMediumBlockPoolHeader(LNewPool).PreviousMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
    MediumBlockPoolsCircularList.NextMediumBlockPoolHeader := LNewPool;
    PMediumBlockPoolHeader(LNewPool).NextMediumBlockPoolHeader := LOldFirstMediumBlockPool;
    LOldFirstMediumBlockPool.PreviousMediumBlockPoolHeader := LNewPool;
    {Store the sequential feed pool trailer}
    PNativeUInt(PByte(LNewPool) + MediumBlockPoolSize - BlockHeaderSize)^ := IsMediumBlockFlag;
    {Get the number of bytes still available}
    MediumSequentialFeedBytesLeft := (MediumBlockPoolSize - MediumBlockPoolHeaderSize) - AFirstBlockSize;
    {Get the result}
    Result := Pointer(PByte(LNewPool) + MediumBlockPoolSize - AFirstBlockSize);
    LastSequentiallyFedMediumBlock := Result;
    {Store the block header}
    PNativeUInt(PByte(Result) - BlockHeaderSize)^ := AFirstBlockSize or IsMediumBlockFlag;
  end
  else
  begin
    {Out of memory}
    MediumSequentialFeedBytesLeft := 0;
    Result := nil;
  end;
end;

{Frees a medium block pool. Medium blocks must be locked on entry.}
procedure FreeMediumBlockPool(AMediumBlockPool: PMediumBlockPoolHeader);
var
  LPPreviousMediumBlockPoolHeader, LPNextMediumBlockPoolHeader: PMediumBlockPoolHeader;
begin
  {Remove this medium block pool from the linked list}
  LPPreviousMediumBlockPoolHeader := AMediumBlockPool.PreviousMediumBlockPoolHeader;
  LPNextMediumBlockPoolHeader := AMediumBlockPool.NextMediumBlockPoolHeader;
  LPPreviousMediumBlockPoolHeader.NextMediumBlockPoolHeader := LPNextMediumBlockPoolHeader;
  LPNextMediumBlockPoolHeader.PreviousMediumBlockPoolHeader := LPPreviousMediumBlockPoolHeader;
  {Free the medium block pool}
  VirtualFree(AMediumBlockPool, 0, MEM_RELEASE);
end;

{--------------------------Large Block Management-------------------------}

{Locks the large blocks}
procedure LockLargeBlocks;
begin
  {Lock the large blocks}
  if IsMultiThread then
  begin
    while LockCmpxchg(0, 1, @LargeBlocksLocked) <> 0 do
    begin
      if not NeverSleepOnMMThreadContention then
      begin
        Sleep(InitialSleepTime);
        if LockCmpxchg(0, 1, @LargeBlocksLocked) = 0 then
          Break;
        Sleep(AdditionalSleepTime);
      end;
    end;
  end;
end;

{Allocates a Large block of at least ASize (actual size may be Larger to
 allow for alignment etc.). ASize must be the actual user requested size. This
 procedure will pad it to the appropriate page boundary and also add the space
 required by the header.}
function AllocateLargeBlock(ASize: NativeUInt): Pointer;
var
  LLargeUsedBlockSize: NativeUInt;
  LOldFirstLargeBlock: PLargeBlockHeader;
begin
  {Pad the block size to include the header and granularity. We also add a
   SizeOf(Pointer) overhead so a huge block size is a multiple of 16 bytes less
   SizeOf(Pointer) (so we can use a single move function for reallocating all
   block types)}
  LLargeUsedBlockSize := (ASize + LargeBlockHeaderSize + LargeBlockGranularity - 1 + BlockHeaderSize)
    and -LargeBlockGranularity;
  {Get the Large block}
  Result := VirtualAlloc(nil, LLargeUsedBlockSize, MEM_COMMIT or MEM_TOP_DOWN,
    PAGE_READWRITE);
  {Set the Large block fields}
  if Result <> nil then
  begin
    {Set the large block size and flags}
    PLargeBlockHeader(Result).UserAllocatedSize := ASize;
    PLargeBlockHeader(Result).BlockSizeAndFlags := LLargeUsedBlockSize or IsLargeBlockFlag;
    {Insert the large block into the linked list of large blocks}
    LockLargeBlocks;
    LOldFirstLargeBlock := LargeBlocksCircularList.NextLargeBlockHeader;
    PLargeBlockHeader(Result).PreviousLargeBlockHeader := @LargeBlocksCircularList;
    LargeBlocksCircularList.NextLargeBlockHeader := Result;
    PLargeBlockHeader(Result).NextLargeBlockHeader := LOldFirstLargeBlock;
    LOldFirstLargeBlock.PreviousLargeBlockHeader := Result;
    LargeBlocksLocked := False;
    {Add the size of the header}
    Inc(PByte(Result), LargeBlockHeaderSize);
  end;
end;

{Frees a large block, returning 0 on success, -1 otherwise}
function FreeLargeBlock(APointer: Pointer): Integer;
var
  LPreviousLargeBlockHeader, LNextLargeBlockHeader: PLargeBlockHeader;
  LRemainingSize: NativeUInt;
  LCurrentSegment: Pointer;
  LMemInfo: TMemoryBasicInformation;
begin
  {Point to the start of the large block}
  APointer := Pointer(PByte(APointer) - LargeBlockHeaderSize);
  {Get the previous and next large blocks}
  LockLargeBlocks;
  LPreviousLargeBlockHeader := PLargeBlockHeader(APointer).PreviousLargeBlockHeader;
  LNextLargeBlockHeader := PLargeBlockHeader(APointer).NextLargeBlockHeader;
  {Is the large block segmented?}
  if PLargeBlockHeader(APointer).BlockSizeAndFlags and LargeBlockIsSegmented = 0 then
  begin
    {Single segment large block: Try to free it}
    if VirtualFree(APointer, 0, MEM_RELEASE) then
      Result := 0
    else
      Result := -1;
  end
  else
  begin
    {The large block is segmented - free all segments}
    LCurrentSegment := APointer;
    LRemainingSize := PLargeBlockHeader(APointer).BlockSizeAndFlags and DropMediumAndLargeFlagsMask;
    Result := 0;
    while True do
    begin
      {Get the size of the current segment}
      VirtualQuery(LCurrentSegment, LMemInfo, SizeOf(LMemInfo));
      {Free the segment}
      if not VirtualFree(LCurrentSegment, 0, MEM_RELEASE) then
      begin
        Result := -1;
        Break;
      end;
      {Done?}
      if NativeUInt(LMemInfo.RegionSize) >= LRemainingSize then
        Break;
      {Decrement the remaining size}
      Dec(LRemainingSize, NativeUInt(LMemInfo.RegionSize));
      Inc(PByte(LCurrentSegment), NativeUInt(LMemInfo.RegionSize));
    end;
  end;
  {Success?}
  if Result = 0 then
  begin
    {Remove the large block from the linked list}
    LNextLargeBlockHeader.PreviousLargeBlockHeader := LPreviousLargeBlockHeader;
    LPreviousLargeBlockHeader.NextLargeBlockHeader := LNextLargeBlockHeader;
  end;
  {Unlock the large blocks}
  LargeBlocksLocked := False;
end;

{Reallocates a large block to at least the requested size. Returns the new
 pointer, or nil on error}
function ReallocateLargeBlock(APointer: Pointer; ANewSize: NativeUInt): Pointer;
var
  LOldAvailableSize, LBlockHeader, LOldUserSize, LMinimumUpsize,
    LNewAllocSize, LNewSegmentSize: NativeUInt;
  LNextSegmentPointer: Pointer;
  LMemInfo: TMemoryBasicInformation;
begin
  {Get the block header}
  LBlockHeader := PNativeUInt(PByte(APointer) - BlockHeaderSize)^;
  {Subtract the overhead to determine the useable size in the large block.}
  LOldAvailableSize := (LBlockHeader and DropMediumAndLargeFlagsMask) - (LargeBlockHeaderSize + BlockHeaderSize);
  {Is it an upsize or a downsize?}
  if ANewSize > LOldAvailableSize then
  begin
    {This pointer is being reallocated to a larger block and therefore it is
     logical to assume that it may be enlarged again. Since reallocations are
     expensive, there is a minimum upsize percentage to avoid unnecessary
     future move operations.}
    {Add 25% for large block upsizes}
    LMinimumUpsize := LOldAvailableSize + (LOldAvailableSize shr 2);
    if ANewSize < LMinimumUpsize then
      LNewAllocSize := LMinimumUpsize
    else
      LNewAllocSize := ANewSize;
    {Can another large block segment be allocated directly after this segment,
     thus negating the need to move the data?}
    LNextSegmentPointer := Pointer(PByte(APointer) - LargeBlockHeaderSize + (LBlockHeader and DropMediumAndLargeFlagsMask));
    VirtualQuery(LNextSegmentPointer, LMemInfo, SizeOf(LMemInfo));
    if LMemInfo.State = MEM_FREE then
    begin
      {Round the region size to the previous 64K}
      LMemInfo.RegionSize := LMemInfo.RegionSize and -LargeBlockGranularity;
      {Enough space to grow in place?}
      if NativeUInt(LMemInfo.RegionSize) > (ANewSize - LOldAvailableSize) then
      begin
        {There is enough space after the block to extend it - determine by how
         much}
        LNewSegmentSize := (LNewAllocSize - LOldAvailableSize + LargeBlockGranularity - 1) and -LargeBlockGranularity;
        if LNewSegmentSize > LMemInfo.RegionSize then
          LNewSegmentSize := LMemInfo.RegionSize;
        if (VirtualAlloc(LNextSegmentPointer, LNewSegmentSize, MEM_RESERVE, PAGE_READWRITE) <> nil)
          and (VirtualAlloc(LNextSegmentPointer, LNewSegmentSize, MEM_COMMIT, PAGE_READWRITE) <> nil) then
        begin
          {Update the requested size}
          PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
          PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).BlockSizeAndFlags :=
            (PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).BlockSizeAndFlags + LNewSegmentSize)
            or LargeBlockIsSegmented;
          {Success}
          Result := APointer;
          Exit;
        end;
      end;
    end;
    {Could not resize in place: Allocate the new block}
    Result := SysGetMem(LNewAllocSize);
    if Result <> nil then
    begin
      {If it's a large block - store the actual user requested size (it may
       not be if the block that is being reallocated from was previously
       downsized)}
      if LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize) then
        PLargeBlockHeader(PByte(Result) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
      {The user allocated size is stored for large blocks}
      LOldUserSize := PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize;
      {The number of bytes to move is the old user size.}
{$ifdef UseCustomVariableSizeMoveRoutines}
      MoveX16LP(APointer^, Result^, LOldUserSize);
{$else}
      Move(APointer^, Result^, LOldUserSize);
{$endif}
      {Free the old block}
      SysFreeMem(APointer);
    end;
  end
  else
  begin
    {It's a downsize: do we need to reallocate? Only if the new size is less
     than half the old size}
    if ANewSize >= (LOldAvailableSize shr 1) then
    begin
      {No need to reallocate}
      Result := APointer;
      {Update the requested size}
      PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
    end
    else
    begin
      {The block is less than half the old size: reallocate}
      Result := SysGetMem(ANewSize);
      if Result <> nil then
      begin
        {Still a large block? -> Set the user size}
        if ANewSize > (MaximumMediumBlockSize - BlockHeaderSize) then
          PLargeBlockHeader(PByte(APointer) - LargeBlockHeaderSize).UserAllocatedSize := ANewSize;
        {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  {$ifdef CPU386}
        MoveX8LP(APointer^, Result^, ANewSize);
  {$else}
        {Blocks are always 16-byte aligned under 64-bit.}
        MoveX16LP(APointer^, Result^, ANewSize);
  {$endif}
{$else}
        Move(APointer^, Result^, ANewSize);
{$endif}
        {Free the old block}
        SysFreeMem(APointer);
      end;
    end;
  end;
end;

{----------------------Main Memory Manager Functions----------------------}

{$ifdef UsePascalCode}
function SysGetMem(Size: NativeInt): Pointer;
var
  LMediumBlock, LNextFreeBlock, LSecondSplit: PMediumFreeBlock;
  LNextMediumBlockHeader: PNativeUInt;
  LBlockSize, LAvailableBlockSize, LSecondSplitSize: Cardinal;
  LPSmallBlockType: PSmallBlockType;
  LPSmallBlockPool, LPNewFirstPool: PSmallBlockPoolHeader;
  LBinNumber: Cardinal;
  LNewFirstFreeBlock: Pointer;
  LPMediumBin: PMediumFreeBlock;
  LSequentialFeedFreeSize: Cardinal;
  LBinGroupsMasked, LBinGroupMasked, LBinGroupNumber: Cardinal;
begin
  {Is it a small block? -> Take the header size into account when
   determining the required block size}
  if NativeUInt(Size) <= (MaximumSmallBlockSize - BlockHeaderSize) then
  begin
    {-----------------------Allocate a small block------------------------}
    {Get the block type from the size}
    LPSmallBlockType := PSmallBlockType(AllocSize2SmallBlockTypeIndX4[
      (Cardinal(Size) + (BlockHeaderSize - 1)) div SmallBlockGranularity]
      * (SizeOf(TSmallBlockType) div 4)
      + UIntPtr(@SmallBlockTypes));
    {Lock the block type}
    if IsMultiThread then
    begin
      while True do
      begin
        {Try to lock the small block type}
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        {Try the next block type}
        Inc(PByte(LPSmallBlockType), SizeOf(TSmallBlockType));
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        {Try up to two sizes past the requested size}
        Inc(PByte(LPSmallBlockType), SizeOf(TSmallBlockType));
        if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
          Break;
        {All three sizes locked - given up and sleep}
        Dec(PByte(LPSmallBlockType), 2 * SizeOf(TSmallBlockType));
        if not NeverSleepOnMMThreadContention then
        begin
          {Both this block type and the next is in use: sleep}
          Sleep(InitialSleepTime);
          {Try the lock again}
          if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
            Break;
          {Sleep longer}
          Sleep(AdditionalSleepTime);
        end;
      end;
    end;
    {Get the first pool with free blocks}
    LPSmallBlockPool := LPSmallBlockType.NextPartiallyFreePool;
    {Is the pool valid?}
    if UIntPtr(LPSmallBlockPool) <> UIntPtr(LPSmallBlockType) then
    begin
      {Get the first free offset}
      Result := LPSmallBlockPool.FirstFreeBlock;
      {Get the new first free block}
      LNewFirstFreeBlock := PPointer(PByte(Result) - BlockHeaderSize)^;
      LNewFirstFreeBlock := Pointer(UIntPtr(LNewFirstFreeBlock) and DropSmallFlagsMask);
      {Increment the number of used blocks}
      Inc(LPSmallBlockPool.BlocksInUse);
      {Set the new first free block}
      LPSmallBlockPool.FirstFreeBlock := LNewFirstFreeBlock;
      {Is the pool now full?}
      if LNewFirstFreeBlock = nil then
      begin
        {Pool is full - remove it from the partially free list}
        LPNewFirstPool := LPSmallBlockPool.NextPartiallyFreePool;
        LPSmallBlockType.NextPartiallyFreePool := LPNewFirstPool;
        LPNewFirstPool.PreviousPartiallyFreePool := PSmallBlockPoolHeader(LPSmallBlockType);
      end;
    end
    else
    begin
      {Try to feed a small block sequentially}
      Result := LPSmallBlockType.NextSequentialFeedBlockAddress;
      {Can another block fit?}
      if UIntPtr(Result) <= UIntPtr(LPSmallBlockType.MaxSequentialFeedBlockAddress) then
      begin
        {Get the sequential feed block pool}
        LPSmallBlockPool := LPSmallBlockType.CurrentSequentialFeedPool;
        {Increment the number of used blocks in the sequential feed pool}
        Inc(LPSmallBlockPool.BlocksInUse);
        {Store the next sequential feed block address}
        LPSmallBlockType.NextSequentialFeedBlockAddress := Pointer(PByte(Result) + LPSmallBlockType.BlockSize);
      end
      else
      begin
        {Need to allocate a pool: Lock the medium blocks}
        LockMediumBlocks;
        {Are there any available blocks of a suitable size?}
        LBinGroupsMasked := MediumBlockBinGroupBitmap and ($ffffff00 or LPSmallBlockType.AllowedGroupsForBlockPoolBitmap);
        if LBinGroupsMasked <> 0 then
        begin
          {Get the bin group with free blocks}
          LBinGroupNumber := FindFirstSetBit(LBinGroupsMasked);
          {Get the bin in the group with free blocks}
          LBinNumber := FindFirstSetBit(MediumBlockBinBitmaps[LBinGroupNumber])
            + LBinGroupNumber * 32;
          LPMediumBin := @MediumBlockBins[LBinNumber];
          {Get the first block in the bin}
          LMediumBlock := LPMediumBin.NextFreeBlock;
          {Remove the first block from the linked list (LIFO)}
          LNextFreeBlock := LMediumBlock.NextFreeBlock;
          LPMediumBin.NextFreeBlock := LNextFreeBlock;
          LNextFreeBlock.PreviousFreeBlock := LPMediumBin;
          {Is this bin now empty?}
          if LNextFreeBlock = LPMediumBin then
          begin
            {Flag this bin as empty}
            MediumBlockBinBitmaps[LBinGroupNumber] := MediumBlockBinBitmaps[LBinGroupNumber]
              and (not (1 shl (LBinNumber and 31)));
            {Is the group now entirely empty?}
            if MediumBlockBinBitmaps[LBinGroupNumber] = 0 then
            begin
              {Flag this group as empty}
              MediumBlockBinGroupBitmap := MediumBlockBinGroupBitmap
                and (not (1 shl LBinGroupNumber));
            end;
          end;
          {Get the size of the available medium block}
          LBlockSize := PNativeUInt(PByte(LMediumBlock) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask;
          {Medium blocks are never split or coalesced in full debug mode}
          {Should the block be split?}
          if LBlockSize >= MaximumSmallBlockPoolSize then
          begin
            {Get the size of the second split}
            LSecondSplitSize := LBlockSize - LPSmallBlockType.OptimalBlockPoolSize;
            {Adjust the block size}
            LBlockSize := LPSmallBlockType.OptimalBlockPoolSize;
            {Split the block in two}
            LSecondSplit := PMediumFreeBlock(PByte(LMediumBlock) + LBlockSize);
            PNativeUInt(PByte(LSecondSplit) - BlockHeaderSize)^ := LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
            {Store the size of the second split as the second last dword/qword}
            PNativeUInt(PByte(LSecondSplit) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
            {Put the remainder in a bin (it will be big enough)}
            InsertMediumBlockIntoBin(LSecondSplit, LSecondSplitSize);
          end
          else
          begin
            {Mark this block as used in the block following it}
            LNextMediumBlockHeader := PNativeUInt(PByte(LMediumBlock) + LBlockSize - BlockHeaderSize);
            LNextMediumBlockHeader^ := LNextMediumBlockHeader^ and (not PreviousMediumBlockIsFreeFlag);
          end;
        end
        else
        begin
          {Check the sequential feed medium block pool for space}
          LSequentialFeedFreeSize := MediumSequentialFeedBytesLeft;
          if LSequentialFeedFreeSize >= LPSmallBlockType.MinimumBlockPoolSize then
          begin
            {Enough sequential feed space: Will the remainder be usable?}
            if LSequentialFeedFreeSize >= (LPSmallBlockType.OptimalBlockPoolSize + MinimumMediumBlockSize) then
            begin
              LBlockSize := LPSmallBlockType.OptimalBlockPoolSize;
            end
            else
              LBlockSize := LSequentialFeedFreeSize;
            {Get the block}
            LMediumBlock := Pointer(PByte(LastSequentiallyFedMediumBlock) - LBlockSize);
            {Update the sequential feed parameters}
            LastSequentiallyFedMediumBlock := LMediumBlock;
            MediumSequentialFeedBytesLeft := LSequentialFeedFreeSize - LBlockSize;
          end
          else
          begin
            {Need to allocate a new sequential feed medium block pool: use the
             optimal size for this small block pool}
            LBlockSize := LPSmallBlockType.OptimalBlockPoolSize;
            {Allocate the medium block pool}
            LMediumBlock := AllocNewSequentialFeedMediumPool(LBlockSize);
            if LMediumBlock = nil then
            begin
              {Out of memory}
              {Unlock the medium blocks}
              MediumBlocksLocked := False;
              {Unlock the block type}
              LPSmallBlockType.BlockTypeLocked := False;
              {Failed}
              Result := nil;
              {done}
              Exit;
            end;
          end;
        end;
        {Mark this block as in use}
        {Set the size and flags for this block}
        PNativeUInt(PByte(LMediumBlock) - BlockHeaderSize)^ :=
          LBlockSize or IsMediumBlockFlag or IsSmallBlockPoolInUseFlag;
        {Unlock medium blocks}
        MediumBlocksLocked := False;
        {Set up the block pool}
        LPSmallBlockPool := PSmallBlockPoolHeader(LMediumBlock);
        LPSmallBlockPool.BlockType := LPSmallBlockType;
        LPSmallBlockPool.FirstFreeBlock := nil;
        LPSmallBlockPool.BlocksInUse := 1;
        {Set it up for sequential block serving}
        LPSmallBlockType.CurrentSequentialFeedPool := LPSmallBlockPool;
        Result := Pointer(PByte(LPSmallBlockPool) + SmallBlockPoolHeaderSize);
        LPSmallBlockType.NextSequentialFeedBlockAddress :=
          Pointer(PByte(Result) + LPSmallBlockType.BlockSize);
        LPSmallBlockType.MaxSequentialFeedBlockAddress :=
          Pointer(PByte(LPSmallBlockPool) + LBlockSize - LPSmallBlockType.BlockSize);
      end;
    end;
    {Unlock the block type}
    LPSmallBlockType.BlockTypeLocked := False;
    {Set the block header}
    PNativeUInt(PByte(Result) - BlockHeaderSize)^ := UIntPtr(LPSmallBlockPool);
  end
  else
  begin
    {Medium block or Large block?}
    if NativeUInt(Size) <= (MaximumMediumBlockSize - BlockHeaderSize) then
    begin
      {---------------------Allocate a medium block-----------------------}
      {Get the block size and bin number for this block size. Block sizes are
       rounded up to the next bin size.}
      LBlockSize := ((Cardinal(Size) + (MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset))
        and -MediumBlockGranularity) + MediumBlockSizeOffset;
      {Get the bin number}
      LBinNumber := (LBlockSize - MinimumMediumBlockSize) div MediumBlockGranularity;
      {Lock the medium blocks}
      LockMediumBlocks;
      {Calculate the bin group}
      LBinGroupNumber := LBinNumber div 32;
      {Is there a suitable block inside this group?}
      LBinGroupMasked := MediumBlockBinBitmaps[LBinGroupNumber] and -(1 shl (LBinNumber and 31));
      if LBinGroupMasked <> 0 then
      begin
        {Get the actual bin number}
        LBinNumber := FindFirstSetBit(LBinGroupMasked) + LBinGroupNumber * 32;
      end
      else
      begin
        {Try all groups greater than this group}
        LBinGroupsMasked := MediumBlockBinGroupBitmap and -(2 shl LBinGroupNumber);
        if LBinGroupsMasked <> 0 then
        begin
          {There is a suitable group with space: get the bin number}
          LBinGroupNumber := FindFirstSetBit(LBinGroupsMasked);
          {Get the bin in the group with free blocks}
          LBinNumber := FindFirstSetBit(MediumBlockBinBitmaps[LBinGroupNumber])
            + LBinGroupNumber * 32;
        end
        else
        begin
          {There are no bins with a suitable block: Sequentially feed the
           required block}
          LSequentialFeedFreeSize := MediumSequentialFeedBytesLeft;
          if LSequentialFeedFreeSize >= LBlockSize then
          begin
            {Block can be fed sequentially}
            Result := Pointer(PByte(LastSequentiallyFedMediumBlock) - LBlockSize);
            {Store the last sequentially fed block}
            LastSequentiallyFedMediumBlock := Result;
            {Store the remaining bytes}
            MediumSequentialFeedBytesLeft := LSequentialFeedFreeSize - LBlockSize;
            {Set the flags for the block}
            PNativeUInt(PByte(Result) - BlockHeaderSize)^ := LBlockSize or IsMediumBlockFlag;
          end
          else
          begin
            {Need to allocate a new sequential feed block}
            Result := AllocNewSequentialFeedMediumPool(LBlockSize);
          end;
          {Done}
          MediumBlocksLocked := False;
          Exit;
        end;
      end;
      {If we get here we have a valid LBinGroupNumber and LBinNumber:
       Use the first block in the bin, splitting it if necessary}
      {Get a pointer to the bin}
      LPMediumBin := @MediumBlockBins[LBinNumber];
      {Get the result}
      Result := LPMediumBin.NextFreeBlock;
      {Remove the block from the bin containing it}
      RemoveMediumFreeBlock(Result);
      {Get the block size}
      LAvailableBlockSize := PNativeUInt(PByte(Result) - BlockHeaderSize)^
        and DropMediumAndLargeFlagsMask;
      {Is it an exact fit or not?}
      LSecondSplitSize := LAvailableBlockSize - LBlockSize;
      if LSecondSplitSize <> 0 then
      begin
        {Split the block in two}
        LSecondSplit := PMediumFreeBlock(PByte(Result) + LBlockSize);
        {Set the size of the second split}
        PNativeUInt(PByte(LSecondSplit) - BlockHeaderSize)^ :=
          LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
        {Store the size of the second split}
        PNativeUInt(PByte(LSecondSplit) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
        {Put the remainder in a bin if it is big enough}
        if LSecondSplitSize >= MinimumMediumBlockSize then
          InsertMediumBlockIntoBin(LSecondSplit, LSecondSplitSize);
      end
      else
      begin
        {Mark this block as used in the block following it}
        LNextMediumBlockHeader := Pointer(PByte(Result) + LBlockSize - BlockHeaderSize);
        LNextMediumBlockHeader^ :=
          LNextMediumBlockHeader^ and (not PreviousMediumBlockIsFreeFlag);
      end;
      {Set the size and flags for this block}
      PNativeUInt(PByte(Result) - BlockHeaderSize)^ := LBlockSize or IsMediumBlockFlag;
      {Unlock the medium blocks}
      MediumBlocksLocked := False;
    end
    else
    begin
      {Allocate a Large block}
      if Size > 0 then
        Result := AllocateLargeBlock(Size)
      else
        Result := nil;
    end;
  end;
end;
{$else}
function SysGetMem(Size: NativeInt): Pointer;
asm
{$ifdef CPU386}
{---------------32-bit BASM SysGetMem---------------}
  {On entry:
    eax = ASize}
  {Since most allocations are for small blocks, determine the small block type
   index so long}
  lea edx, [eax + BlockHeaderSize - 1]
  shr edx, 3
  {Is it a small block?}
  cmp eax, (MaximumSmallBlockSize - BlockHeaderSize)
  {Save ebx}
  push ebx
  {Get the IsMultiThread variable so long}
  mov cl, IsMultiThread
  {Is it a small block?}
  ja @NotASmallBlock
  {Do we need to lock the block type?}
  test cl, cl
  {Get the small block type in ebx}
  movzx eax, byte ptr [AllocSize2SmallBlockTypeIndX4 + edx]
  lea ebx, [SmallBlockTypes + eax * 8]
  {Do we need to lock the block type?}
  jnz @LockBlockTypeLoop
@GotLockOnSmallBlockType:
  {Find the next free block: Get the first pool with free blocks in edx}
  mov edx, TSmallBlockType[ebx].NextPartiallyFreePool
  {Get the first free block (or the next sequential feed address if edx = ebx)}
  mov eax, TSmallBlockPoolHeader[edx].FirstFreeBlock
  {Get the drop flags mask in ecx so long}
  mov ecx, DropSmallFlagsMask
  {Is there a pool with free blocks?}
  cmp edx, ebx
  je @TrySmallSequentialFeed
  {Increment the number of used blocks}
  add TSmallBlockPoolHeader[edx].BlocksInUse, 1
  {Get the new first free block}
  and ecx, [eax - 4]
  {Set the new first free block}
  mov TSmallBlockPoolHeader[edx].FirstFreeBlock, ecx
  {Set the block header}
  mov [eax - 4], edx
  {Is the chunk now full?}
  jz @RemoveSmallPool
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Restore ebx}
  pop ebx
  {All done}
  ret
  {Align branch target}
  nop
  nop
  nop
@TrySmallSequentialFeed:
  {Try to feed a small block sequentially: Get the sequential feed block pool}
  mov edx, TSmallBlockType[ebx].CurrentSequentialFeedPool
  {Get the next sequential feed address so long}
  movzx ecx, TSmallBlockType[ebx].BlockSize
  add ecx, eax
  {Can another block fit?}
  cmp eax, TSmallBlockType[ebx].MaxSequentialFeedBlockAddress
  {Can another block fit?}
  ja @AllocateSmallBlockPool
  {Increment the number of used blocks in the sequential feed pool}
  add TSmallBlockPoolHeader[edx].BlocksInUse, 1
  {Store the next sequential feed block address}
  mov TSmallBlockType[ebx].NextSequentialFeedBlockAddress, ecx
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Set the block header}
  mov [eax - 4], edx
  {Restore ebx}
  pop ebx
  {All done}
  ret
  {Align branch target}
  nop
  nop
  nop
@RemoveSmallPool:
  {Pool is full - remove it from the partially free list}
  mov ecx, TSmallBlockPoolHeader[edx].NextPartiallyFreePool
  mov TSmallBlockPoolHeader[ecx].PreviousPartiallyFreePool, ebx
  mov TSmallBlockType[ebx].NextPartiallyFreePool, ecx
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Restore ebx}
  pop ebx
  {All done}
  ret
  {Align branch target}
  nop
  nop
@LockBlockTypeLoop:
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Try the next size}
  add ebx, Type(TSmallBlockType)
  mov eax, $100
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Try the next size (up to two sizes larger)}
  add ebx, Type(TSmallBlockType)
  mov eax, $100
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Block type and two sizes larger are all locked - sleep and/or retry}
  sub ebx, 2 * Type(TSmallBlockType)
  {The pause instruction improves spinlock performance}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  cmp NeverSleepOnMMThreadContention, 0
  jne @LockBlockTypeLoop
  {Couldn't grab the block type - sleep and try again}
  push InitialSleepTime
  call Sleep
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Couldn't grab the block type - sleep and try again}
  push AdditionalSleepTime
  call Sleep
  {Try again}
  jmp @LockBlockTypeLoop
  {Align branch target}
@AllocateSmallBlockPool:
  {save additional registers}
  push esi
  push edi
  {Do we need to lock the medium blocks?}
  cmp IsMultiThread, False
  je @MediumBlocksLockedForPool
@LockMediumBlocksForPool:
  mov eax, $100
  {Attempt to lock the medium blocks}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumBlocksLockedForPool
  {The pause instruction improves spinlock performance}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  cmp NeverSleepOnMMThreadContention, 0
  jne @LockMediumBlocksForPool
  {Couldn't lock the medium blocks - sleep and retry}
  push InitialSleepTime
  call Sleep
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumBlocksLockedForPool
  {Couldn't lock the medium blocks - sleep and try again}
  push AdditionalSleepTime
  call Sleep
  {Try again}
  jmp @LockMediumBlocksForPool
  {Align branch target}
@MediumBlocksLockedForPool:
  {Are there any available blocks of a suitable size?}
  movsx esi, TSmallBlockType[ebx].AllowedGroupsForBlockPoolBitmap
  and esi, MediumBlockBinGroupBitmap
  jz @NoSuitableMediumBlocks
  {Get the bin group number with free blocks in eax}
  bsf eax, esi
  {Get the bin number in ecx}
  lea esi, [eax * 8]
  mov ecx, dword ptr [MediumBlockBinBitmaps + eax * 4]
  bsf ecx, ecx
  lea ecx, [ecx + esi * 4]
  {Get a pointer to the bin in edi}
  lea edi, [MediumBlockBins + ecx * 8]
  {Get the free block in esi}
  mov esi, TMediumFreeBlock[edi].NextFreeBlock
  {Remove the first block from the linked list (LIFO)}
  mov edx, TMediumFreeBlock[esi].NextFreeBlock
  mov TMediumFreeBlock[edi].NextFreeBlock, edx
  mov TMediumFreeBlock[edx].PreviousFreeBlock, edi
  {Is this bin now empty?}
  cmp edi, edx
  jne @MediumBinNotEmpty
  {eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block type}
  {Flag this bin as empty}
  mov edx, -2
  rol edx, cl
  and dword ptr [MediumBlockBinBitmaps + eax * 4], edx
  jnz @MediumBinNotEmpty
  {Flag the group as empty}
  btr MediumBlockBinGroupBitmap, eax
@MediumBinNotEmpty:
  {esi = free block, ebx = block type}
  {Get the size of the available medium block in edi}
  mov edi, DropMediumAndLargeFlagsMask
  and edi, [esi - 4]
  cmp edi, MaximumSmallBlockPoolSize
  jb @UseWholeBlock
  {Split the block: get the size of the second part, new block size is the
   optimal size}
  mov edx, edi
  movzx edi, TSmallBlockType[ebx].OptimalBlockPoolSize
  sub edx, edi
  {Split the block in two}
  lea eax, [esi + edi]
  lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [eax - 4], ecx
  {Store the size of the second split as the second last dword}
  mov [eax + edx - 8], edx
  {Put the remainder in a bin (it will be big enough)}
  call InsertMediumBlockIntoBin
  jmp @GotMediumBlock
  {Align branch target}
@NoSuitableMediumBlocks:
  {Check the sequential feed medium block pool for space}
  movzx ecx, TSmallBlockType[ebx].MinimumBlockPoolSize
  mov edi, MediumSequentialFeedBytesLeft
  cmp edi, ecx
  jb @AllocateNewSequentialFeed
  {Get the address of the last block that was fed}
  mov esi, LastSequentiallyFedMediumBlock
  {Enough sequential feed space: Will the remainder be usable?}
  movzx ecx, TSmallBlockType[ebx].OptimalBlockPoolSize
  lea edx, [ecx + MinimumMediumBlockSize]
  cmp edi, edx
  jb @NotMuchSpace
  mov edi, ecx
@NotMuchSpace:
  sub esi, edi
  {Update the sequential feed parameters}
  sub MediumSequentialFeedBytesLeft, edi
  mov LastSequentiallyFedMediumBlock, esi
  {Get the block pointer}
  jmp @GotMediumBlock
  {Align branch target}
@AllocateNewSequentialFeed:
  {Need to allocate a new sequential feed medium block pool: use the
   optimal size for this small block pool}
  movzx eax, TSmallBlockType[ebx].OptimalBlockPoolSize
  mov edi, eax
  {Allocate the medium block pool}
  call AllocNewSequentialFeedMediumPool
  mov esi, eax
  test eax, eax
  jnz @GotMediumBlock
  mov MediumBlocksLocked, al
  mov TSmallBlockType[ebx].BlockTypeLocked, al
  pop edi
  pop esi
  pop ebx
  ret
  {Align branch target}
@UseWholeBlock:
  {esi = free block, ebx = block type, edi = block size}
  {Mark this block as used in the block following it}
  and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GotMediumBlock:
  {esi = free block, ebx = block type, edi = block size}
  {Set the size and flags for this block}
  lea ecx, [edi + IsMediumBlockFlag + IsSmallBlockPoolInUseFlag]
  mov [esi - 4], ecx
  {Unlock medium blocks}
  xor eax, eax
  mov MediumBlocksLocked, al
  {Set up the block pool}
  mov TSmallBlockPoolHeader[esi].BlockType, ebx
  mov TSmallBlockPoolHeader[esi].FirstFreeBlock, eax
  mov TSmallBlockPoolHeader[esi].BlocksInUse, 1
  {Set it up for sequential block serving}
  mov TSmallBlockType[ebx].CurrentSequentialFeedPool, esi
  {Return the pointer to the first block}
  lea eax, [esi + SmallBlockPoolHeaderSize]
  movzx ecx, TSmallBlockType[ebx].BlockSize
  lea edx, [eax + ecx]
  mov TSmallBlockType[ebx].NextSequentialFeedBlockAddress, edx
  add edi, esi
  sub edi, ecx
  mov TSmallBlockType[ebx].MaxSequentialFeedBlockAddress, edi
  {Unlock the small block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {Set the small block header}
  mov [eax - 4], esi
  {Restore registers}
  pop edi
  pop esi
  pop ebx
  {Done}
  ret
{--------------------------Medium block allocation------------------------}
  {Align branch target}
  nop
@LockMediumBlocks:
  mov eax, $100
  {Attempt to lock the medium blocks}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumBlocksLocked
  {The pause instruction improves spinlock performance}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  cmp NeverSleepOnMMThreadContention, 0
  jne @LockMediumBlocks
  {Couldn't lock the medium blocks - sleep and try again}
  push InitialSleepTime
  call Sleep
  {Try again}
  mov eax, $100
  {Attempt to lock the medium blocks}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumBlocksLocked
  {Couldn't lock the medium blocks - sleep and try again}
  push AdditionalSleepTime
  call Sleep
  {Try again}
  jmp @LockMediumBlocks
  {Align branch target}
  nop
  nop
  nop
@NotASmallBlock:
  cmp eax, (MaximumMediumBlockSize - BlockHeaderSize)
  ja @IsALargeBlockRequest
  {Get the bin size for this block size. Block sizes are
   rounded up to the next bin size.}
  lea ebx, [eax + MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset]
  and ebx, -MediumBlockGranularity
  add ebx, MediumBlockSizeOffset
  {Do we need to lock the medium blocks?}
  test cl, cl
  jnz @LockMediumBlocks
@MediumBlocksLocked:
  {Get the bin number in ecx and the group number in edx}
  lea edx, [ebx - MinimumMediumBlockSize]
  mov ecx, edx
  shr edx, 8 + 5
  shr ecx, 8
  {Is there a suitable block inside this group?}
  mov eax, -1
  shl eax, cl
  and eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
  jz @GroupIsEmpty
  {Get the actual bin number}
  and ecx, -32
  bsf eax, eax
  or ecx, eax
  jmp @GotBinAndGroup
  {Align branch target}
  nop
  nop
@GroupIsEmpty:
  {Try all groups greater than this group}
  mov eax, -2
  mov ecx, edx
  shl eax, cl
  and eax, MediumBlockBinGroupBitmap
  jz @TrySequentialFeedMedium
  {There is a suitable group with space: get the bin number}
  bsf edx, eax
  {Get the bin in the group with free blocks}
  mov eax, dword ptr [MediumBlockBinBitmaps + edx * 4]
  bsf ecx, eax
  mov eax, edx
  shl eax, 5
  or ecx, eax
  jmp @GotBinAndGroup
  {Align branch target}
  nop
@TrySequentialFeedMedium:
  mov ecx, MediumSequentialFeedBytesLeft
  {Block can be fed sequentially?}
  sub ecx, ebx
  jc @AllocateNewSequentialFeedForMedium
  {Get the block address}
  mov eax, LastSequentiallyFedMediumBlock
  sub eax, ebx
  mov LastSequentiallyFedMediumBlock, eax
  {Store the remaining bytes}
  mov MediumSequentialFeedBytesLeft, ecx
  {Set the flags for the block}
  or ebx, IsMediumBlockFlag
  mov [eax - 4], ebx
  jmp @MediumBlockGetDone
  {Align branch target}
@AllocateNewSequentialFeedForMedium:
  mov eax, ebx
  call AllocNewSequentialFeedMediumPool
@MediumBlockGetDone:
  mov MediumBlocksLocked, False
  pop ebx
  ret
  {Align branch target}
@GotBinAndGroup:
  {ebx = block size, ecx = bin number, edx = group number}
  push esi
  push edi
  {Get a pointer to the bin in edi}
  lea edi, [MediumBlockBins + ecx * 8]
  {Get the free block in esi}
  mov esi, TMediumFreeBlock[edi].NextFreeBlock
  {Remove the first block from the linked list (LIFO)}
  mov eax, TMediumFreeBlock[esi].NextFreeBlock
  mov TMediumFreeBlock[edi].NextFreeBlock, eax
  mov TMediumFreeBlock[eax].PreviousFreeBlock, edi
  {Is this bin now empty?}
  cmp edi, eax
  jne @MediumBinNotEmptyForMedium
  {eax = bin group number, ecx = bin number, edi = @bin, esi = free block, ebx = block size}
  {Flag this bin as empty}
  mov eax, -2
  rol eax, cl
  and dword ptr [MediumBlockBinBitmaps + edx * 4], eax
  jnz @MediumBinNotEmptyForMedium
  {Flag the group as empty}
  btr MediumBlockBinGroupBitmap, edx
@MediumBinNotEmptyForMedium:
  {esi = free block, ebx = block size}
  {Get the size of the available medium block in edi}
  mov edi, DropMediumAndLargeFlagsMask
  and edi, [esi - 4]
  {Get the size of the second split in edx}
  mov edx, edi
  sub edx, ebx
  jz @UseWholeBlockForMedium
  {Split the block in two}
  lea eax, [esi + ebx]
  lea ecx, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [eax - 4], ecx
  {Store the size of the second split as the second last dword}
  mov [eax + edx - 8], edx
  {Put the remainder in a bin}
  cmp edx, MinimumMediumBlockSize
  jb @GotMediumBlockForMedium
  call InsertMediumBlockIntoBin
  jmp @GotMediumBlockForMedium
  {Align branch target}
  nop
  nop
  nop
@UseWholeBlockForMedium:
  {Mark this block as used in the block following it}
  and byte ptr [esi + edi - 4], not PreviousMediumBlockIsFreeFlag
@GotMediumBlockForMedium:
  {Set the size and flags for this block}
  lea ecx, [ebx + IsMediumBlockFlag]
  mov [esi - 4], ecx
  {Unlock medium blocks}
  mov MediumBlocksLocked, False
  mov eax, esi
  pop edi
  pop esi
  pop ebx
  ret
{---------------------------Large block allocation------------------------}
  {Align branch target}
@IsALargeBlockRequest:
  pop ebx
  test eax, eax
  jns AllocateLargeBlock
  xor eax, eax
{$else}
{---------------64-bit BASM SysGetMem---------------}
  {On entry:
    rcx = ASize}
  .params 2
  .pushnv rbx
  .pushnv rsi
  .pushnv rdi
  {Since most allocations are for small blocks, determine the small block type
   index so long}
  lea edx, [ecx + BlockHeaderSize - 1]
  shr edx, 3
  {Preload the addresses of some small block structures}
  lea r8, AllocSize2SmallBlockTypeIndX4
  lea rbx, SmallBlockTypes
  {Get the IsMultiThread variable so long}
  movzx esi, IsMultiThread
  {Is it a small block?}
  cmp rcx, (MaximumSmallBlockSize - BlockHeaderSize)
  ja @NotASmallBlock
  {Get the small block type pointer in rbx}
  movzx ecx, byte ptr [r8 + rdx]
  shl ecx, 4 //SizeOf(TSmallBlockType) = 64
  add rbx, rcx
  {Do we need to lock the block type?}
  test esi, esi
  jnz @LockBlockTypeLoop
@GotLockOnSmallBlockType:
  {Find the next free block: Get the first pool with free blocks in rdx}
  mov rdx, TSmallBlockType[rbx].NextPartiallyFreePool
  {Get the first free block (or the next sequential feed address if rdx = rbx)}
  mov rax, TSmallBlockPoolHeader[rdx].FirstFreeBlock
  {Get the drop flags mask in rcx so long}
  mov rcx, DropSmallFlagsMask
  {Is there a pool with free blocks?}
  cmp rdx, rbx
  je @TrySmallSequentialFeed
  {Increment the number of used blocks}
  add TSmallBlockPoolHeader[rdx].BlocksInUse, 1
  {Get the new first free block}
  and rcx, [rax - BlockHeaderSize]
  {Set the new first free block}
  mov TSmallBlockPoolHeader[rdx].FirstFreeBlock, rcx
  {Set the block header}
  mov [rax - BlockHeaderSize], rdx
  {Is the chunk now full?}
  jz @RemoveSmallPool
  {Unlock the block type}
  mov TSmallBlockType[rbx].BlockTypeLocked, False
  jmp @Done
@TrySmallSequentialFeed:
  {Try to feed a small block sequentially: Get the sequential feed block pool}
  mov rdx, TSmallBlockType[rbx].CurrentSequentialFeedPool
  {Get the next sequential feed address so long}
  movzx ecx, TSmallBlockType[rbx].BlockSize
  add rcx, rax
  {Can another block fit?}
  cmp rax, TSmallBlockType[rbx].MaxSequentialFeedBlockAddress
  ja @AllocateSmallBlockPool
  {Increment the number of used blocks in the sequential feed pool}
  add TSmallBlockPoolHeader[rdx].BlocksInUse, 1
  {Store the next sequential feed block address}
  mov TSmallBlockType[rbx].NextSequentialFeedBlockAddress, rcx
  {Unlock the block type}
  mov TSmallBlockType[rbx].BlockTypeLocked, False
  {Set the block header}
  mov [rax - BlockHeaderSize], rdx
  jmp @Done
@RemoveSmallPool:
  {Pool is full - remove it from the partially free list}
  mov rcx, TSmallBlockPoolHeader[rdx].NextPartiallyFreePool
  mov TSmallBlockPoolHeader[rcx].PreviousPartiallyFreePool, rbx
  mov TSmallBlockType[rbx].NextPartiallyFreePool, rcx
  {Unlock the block type}
  mov TSmallBlockType[rbx].BlockTypeLocked, False
  jmp @Done
@LockBlockTypeLoop:
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([rbx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Try the next size}
  add rbx, Type(TSmallBlockType)
  mov eax, $100
  lock cmpxchg TSmallBlockType([rbx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Try the next size (up to two sizes larger)}
  add rbx, Type(TSmallBlockType)
  mov eax, $100
  lock cmpxchg TSmallBlockType([rbx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Block type and two sizes larger are all locked - give up and sleep}
  sub rbx, 2 * Type(TSmallBlockType)
  {Pause instruction (improves performance on P4)}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  lea rax, NeverSleepOnMMThreadContention
  cmp byte ptr [rax], 0
  jne @LockBlockTypeLoop
  {Couldn't grab the block type - sleep and try again}
  mov ecx, InitialSleepTime
  call Sleep
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([rbx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Couldn't grab the block type - sleep and try again}
  mov ecx, AdditionalSleepTime
  call Sleep
  {Try again}
  jmp @LockBlockTypeLoop
@AllocateSmallBlockPool:
  {Do we need to lock the medium blocks?}
  test esi, esi
  jz @MediumBlocksLockedForPool
  call LockMediumBlocks
@MediumBlocksLockedForPool:
  {Are there any available blocks of a suitable size?}
  movsx esi, TSmallBlockType[rbx].AllowedGroupsForBlockPoolBitmap
  and esi, MediumBlockBinGroupBitmap
  jz @NoSuitableMediumBlocks
  {Get the bin group number with free blocks in eax}
  bsf eax, esi
  {Get the bin number in ecx}
  lea r8, MediumBlockBinBitmaps
  lea r9, [rax * 4]
  mov ecx, [r8 + r9]
  bsf ecx, ecx
  lea ecx, [ecx + r9d * 8]
  {Get a pointer to the bin in edi}
  lea rdi, MediumBlockBins
  lea esi, [ecx * 8]
  lea rdi, [rdi + rsi * 2] //SizeOf(TMediumBlockBin) = 16
  {Get the free block in rsi}
  mov rsi, TMediumFreeBlock[rdi].NextFreeBlock
  {Remove the first block from the linked list (LIFO)}
  mov rdx, TMediumFreeBlock[rsi].NextFreeBlock
  mov TMediumFreeBlock[rdi].NextFreeBlock, rdx
  mov TMediumFreeBlock[rdx].PreviousFreeBlock, rdi
  {Is this bin now empty?}
  cmp rdi, rdx
  jne @MediumBinNotEmpty
  {r8 = @MediumBlockBinBitmaps, eax = bin group number,
   r9 = bin group number * 4, ecx = bin number, edi = @bin, esi = free block,
   ebx = block type}
  {Flag this bin as empty}
  mov edx, -2
  rol edx, cl
  and [r8 + r9], edx
  jnz @MediumBinNotEmpty
  {Flag the group as empty}
  btr MediumBlockBinGroupBitmap, eax
@MediumBinNotEmpty:
  {esi = free block, ebx = block type}
  {Get the size of the available medium block in edi}
  mov rdi, DropMediumAndLargeFlagsMask
  and rdi, [rsi - BlockHeaderSize]
  cmp edi, MaximumSmallBlockPoolSize
  jb @UseWholeBlock
  {Split the block: get the size of the second part, new block size is the
   optimal size}
  mov edx, edi
  movzx edi, TSmallBlockType[rbx].OptimalBlockPoolSize
  sub edx, edi
  {Split the block in two}
  lea rcx, [rsi + rdi]
  lea rax, [rdx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [rcx - BlockHeaderSize], rax
  {Store the size of the second split as the second last qword}
  mov [rcx + rdx - BlockHeaderSize * 2], rdx
  {Put the remainder in a bin (it will be big enough)}
  call InsertMediumBlockIntoBin
  jmp @GotMediumBlock
@NoSuitableMediumBlocks:
  {Check the sequential feed medium block pool for space}
  movzx ecx, TSmallBlockType[rbx].MinimumBlockPoolSize
  mov edi, MediumSequentialFeedBytesLeft
  cmp edi, ecx
  jb @AllocateNewSequentialFeed
  {Get the address of the last block that was fed}
  mov rsi, LastSequentiallyFedMediumBlock
  {Enough sequential feed space: Will the remainder be usable?}
  movzx ecx, TSmallBlockType[rbx].OptimalBlockPoolSize
  lea edx, [ecx + MinimumMediumBlockSize]
  cmp edi, edx
  jb @NotMuchSpace
  mov edi, ecx
@NotMuchSpace:
  sub rsi, rdi
  {Update the sequential feed parameters}
  sub MediumSequentialFeedBytesLeft, edi
  mov LastSequentiallyFedMediumBlock, rsi
  {Get the block pointer}
  jmp @GotMediumBlock
  {Align branch target}
@AllocateNewSequentialFeed:
  {Need to allocate a new sequential feed medium block pool: use the
   optimal size for this small block pool}
  movzx ecx, TSmallBlockType[rbx].OptimalBlockPoolSize
  mov edi, ecx
  {Allocate the medium block pool}
  call AllocNewSequentialFeedMediumPool
  mov rsi, rax
  test rax, rax
  jnz @GotMediumBlock
  mov MediumBlocksLocked, al
  mov TSmallBlockType[rbx].BlockTypeLocked, al
  jmp @Done
@UseWholeBlock:
  {rsi = free block, rbx = block type, edi = block size}
  {Mark this block as used in the block following it}
  and byte ptr [rsi + rdi - BlockHeaderSize], not PreviousMediumBlockIsFreeFlag
@GotMediumBlock:
  {rsi = free block, rbx = block type, edi = block size}
  {Set the size and flags for this block}
  lea ecx, [edi + IsMediumBlockFlag + IsSmallBlockPoolInUseFlag]
  mov [rsi - BlockHeaderSize], rcx
  {Unlock medium blocks}
  xor eax, eax
  mov MediumBlocksLocked, al
  {Set up the block pool}
  mov TSmallBlockPoolHeader[rsi].BlockType, rbx
  mov TSmallBlockPoolHeader[rsi].FirstFreeBlock, rax
  mov TSmallBlockPoolHeader[rsi].BlocksInUse, 1
  {Set it up for sequential block serving}
  mov TSmallBlockType[rbx].CurrentSequentialFeedPool, rsi
  {Return the pointer to the first block}
  lea rax, [rsi + SmallBlockPoolHeaderSize]
  movzx ecx, TSmallBlockType[rbx].BlockSize
  lea rdx, [rax + rcx]
  mov TSmallBlockType[rbx].NextSequentialFeedBlockAddress, rdx
  add rdi, rsi
  sub rdi, rcx
  mov TSmallBlockType[rbx].MaxSequentialFeedBlockAddress, rdi
  {Unlock the small block type}
  mov TSmallBlockType[rbx].BlockTypeLocked, False
  {Set the small block header}
  mov [rax - BlockHeaderSize], rsi
  jmp @Done
{-------------------Medium block allocation-------------------}
@NotASmallBlock:
  cmp rcx, (MaximumMediumBlockSize - BlockHeaderSize)
  ja @IsALargeBlockRequest
  {Get the bin size for this block size. Block sizes are
   rounded up to the next bin size.}
  lea ebx, [ecx + MediumBlockGranularity - 1 + BlockHeaderSize - MediumBlockSizeOffset]
  and ebx, -MediumBlockGranularity
  add ebx, MediumBlockSizeOffset
  {Do we need to lock the medium blocks?}
  test esi, esi
  jz @MediumBlocksLocked
  call LockMediumBlocks
@MediumBlocksLocked:
  {Get the bin number in ecx and the group number in edx}
  lea edx, [ebx - MinimumMediumBlockSize]
  mov ecx, edx
  shr edx, 8 + 5
  shr ecx, 8
  {Is there a suitable block inside this group?}
  mov eax, -1
  shl eax, cl
  lea r8, MediumBlockBinBitmaps
  and eax, [r8 + rdx * 4]
  jz @GroupIsEmpty
  {Get the actual bin number}
  and ecx, -32
  bsf eax, eax
  or ecx, eax
  jmp @GotBinAndGroup
@GroupIsEmpty:
  {Try all groups greater than this group}
  mov eax, -2
  mov ecx, edx
  shl eax, cl
  and eax, MediumBlockBinGroupBitmap
  jz @TrySequentialFeedMedium
  {There is a suitable group with space: get the bin number}
  bsf edx, eax
  {Get the bin in the group with free blocks}
  mov eax, [r8 + rdx * 4]
  bsf ecx, eax
  mov eax, edx
  shl eax, 5
  or ecx, eax
  jmp @GotBinAndGroup
@TrySequentialFeedMedium:
  mov ecx, MediumSequentialFeedBytesLeft
  {Block can be fed sequentially?}
  sub ecx, ebx
  jc @AllocateNewSequentialFeedForMedium
  {Get the block address}
  mov rax, LastSequentiallyFedMediumBlock
  sub rax, rbx
  mov LastSequentiallyFedMediumBlock, rax
  {Store the remaining bytes}
  mov MediumSequentialFeedBytesLeft, ecx
  {Set the flags for the block}
  or rbx, IsMediumBlockFlag
  mov [rax - BlockHeaderSize], rbx
  jmp @MediumBlockGetDone
@AllocateNewSequentialFeedForMedium:
  mov ecx, ebx
  call AllocNewSequentialFeedMediumPool
@MediumBlockGetDone:
  xor cl, cl
  mov MediumBlocksLocked, cl //workaround for QC99023
  jmp @Done
@GotBinAndGroup:
  {ebx = block size, ecx = bin number, edx = group number}
  {Get a pointer to the bin in edi}
  lea rdi, MediumBlockBins
  lea eax, [ecx + ecx]
  lea rdi, [rdi + rax * 8]
  {Get the free block in esi}
  mov rsi, TMediumFreeBlock[rdi].NextFreeBlock
  {Remove the first block from the linked list (LIFO)}
  mov rax, TMediumFreeBlock[rsi].NextFreeBlock
  mov TMediumFreeBlock[rdi].NextFreeBlock, rax
  mov TMediumFreeBlock[rax].PreviousFreeBlock, rdi
  {Is this bin now empty?}
  cmp rdi, rax
  jne @MediumBinNotEmptyForMedium
  {edx = bin group number, ecx = bin number, rdi = @bin, rsi = free block, ebx = block size}
  {Flag this bin as empty}
  mov eax, -2
  rol eax, cl
  lea r8, MediumBlockBinBitmaps
  and [r8 + rdx * 4], eax
  jnz @MediumBinNotEmptyForMedium
  {Flag the group as empty}
  btr MediumBlockBinGroupBitmap, edx
@MediumBinNotEmptyForMedium:
  {rsi = free block, ebx = block size}
  {Get the size of the available medium block in edi}
  mov rdi, DropMediumAndLargeFlagsMask
  and rdi, [rsi - BlockHeaderSize]
  {Get the size of the second split in edx}
  mov edx, edi
  sub edx, ebx
  jz @UseWholeBlockForMedium
  {Split the block in two}
  lea rcx, [rsi + rbx]
  lea rax, [rdx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [rcx - BlockHeaderSize], rax
  {Store the size of the second split as the second last dword}
  mov [rcx + rdx - BlockHeaderSize * 2], rdx
  {Put the remainder in a bin}
  cmp edx, MinimumMediumBlockSize
  jb @GotMediumBlockForMedium
  call InsertMediumBlockIntoBin
  jmp @GotMediumBlockForMedium
@UseWholeBlockForMedium:
  {Mark this block as used in the block following it}
  and byte ptr [rsi + rdi - BlockHeaderSize], not PreviousMediumBlockIsFreeFlag
@GotMediumBlockForMedium:
  {Set the size and flags for this block}
  lea rcx, [rbx + IsMediumBlockFlag]
  mov [rsi - BlockHeaderSize], rcx
  {Unlock medium blocks}
  xor cl, cl
  mov MediumBlocksLocked, cl //workaround for QC99023
  mov rax, rsi
  jmp @Done
{-------------------Large block allocation-------------------}
@IsALargeBlockRequest:
  xor rax, rax
  test rcx, rcx
  js @Done
  call AllocateLargeBlock
@Done:
{$endif}
end;
{$endif}

{$ifdef UsePascalCode}
function SysFreeMem(P: Pointer): Integer;
var
  LNextMediumBlock, LPreviousMediumBlock: PMediumFreeBlock;
  LNextMediumBlockSizeAndFlags: NativeUInt;
  LBlockSize, LPreviousMediumBlockSize: Cardinal;
  LPSmallBlockPool, LPPreviousPool, LPNextPool,
    LPOldFirstPool: PSmallBlockPoolHeader;
  LPSmallBlockType: PSmallBlockType;
  LOldFirstFreeBlock: Pointer;
  LBlockHeader: NativeUInt;
  LPPreviousMediumBlockPoolHeader, LPNextMediumBlockPoolHeader: PMediumBlockPoolHeader;
begin
  {Get the small block header: Is it actually a small block?}
  LBlockHeader := PNativeUInt(PByte(P) - BlockHeaderSize)^;
  {Is it a small block that is in use?}
  if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag or IsLargeBlockFlag) = 0 then
  begin
    {Get a pointer to the block pool}
    LPSmallBlockPool := PSmallBlockPoolHeader(LBlockHeader);
    {Get the block type}
    LPSmallBlockType := LPSmallBlockPool.BlockType;
    {Lock the block type}
    if IsMultiThread then
    begin
      while (LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) <> 0) do
      begin
        if not NeverSleepOnMMThreadContention then
        begin
          Sleep(InitialSleepTime);
          if LockCmpxchg(0, 1, @LPSmallBlockType.BlockTypeLocked) = 0 then
            Break;
          Sleep(AdditionalSleepTime);
        end;
      end;
    end;
    {Get the old first free block}
    LOldFirstFreeBlock := LPSmallBlockPool.FirstFreeBlock;
    {Was the pool manager previously full?}
    if LOldFirstFreeBlock = nil then
    begin
      {Insert this as the first partially free pool for the block size}
      LPOldFirstPool := LPSmallBlockType.NextPartiallyFreePool;
      LPSmallBlockPool.NextPartiallyFreePool := LPOldFirstPool;
      LPOldFirstPool.PreviousPartiallyFreePool := LPSmallBlockPool;
      LPSmallBlockPool.PreviousPartiallyFreePool := PSmallBlockPoolHeader(LPSmallBlockType);
      LPSmallBlockType.NextPartiallyFreePool := LPSmallBlockPool;
    end;
    {Store the old first free block}
    PNativeUInt(PByte(P) - BlockHeaderSize)^ := UIntPtr(LOldFirstFreeBlock) or IsFreeBlockFlag;
    {Store this as the new first free block}
    LPSmallBlockPool.FirstFreeBlock := P;
    {Decrement the number of allocated blocks}
    Dec(LPSmallBlockPool.BlocksInUse);
    {Is the entire pool now free? -> Free it.}
    if LPSmallBlockPool.BlocksInUse = 0 then
    begin
      {Get the previous and next chunk managers}
      LPPreviousPool := LPSmallBlockPool.PreviousPartiallyFreePool;
      LPNextPool := LPSmallBlockPool.NextPartiallyFreePool;
      {Remove this manager}
      LPPreviousPool.NextPartiallyFreePool := LPNextPool;
      LPNextPool.PreviousPartiallyFreePool := LPPreviousPool;
      {Is this the sequential feed pool? If so, stop sequential feeding}
      if LPSmallBlockType.CurrentSequentialFeedPool = LPSmallBlockPool then
        LPSmallBlockType.MaxSequentialFeedBlockAddress := nil;
      {Unlock this block type}
      LPSmallBlockType.BlockTypeLocked := False;
      {No longer a small block pool in use (the flag must be reset in the
       pascal version, since IsSmallBlockPoolInUseFlag = IsLargeBlockFlag)}
      PNativeUInt(PByte(LPSmallBlockPool) - BlockHeaderSize)^ :=
        PNativeUInt(PByte(LPSmallBlockPool) - BlockHeaderSize)^ and (not IsSmallBlockPoolInUseFlag);
      {Release this pool}
      SysFreeMem(LPSmallBlockPool);
    end
    else
    begin
      {Unlock this block type}
      LPSmallBlockType.BlockTypeLocked := False;
    end;
    {No error}
    Result := 0;
  end
  else
  begin
    {Is this a medium block or a large block?}
    if LBlockHeader and (IsFreeBlockFlag or IsLargeBlockFlag) = 0 then
    begin
      {Get the medium block size}
      LBlockSize := LBlockHeader and DropMediumAndLargeFlagsMask;
      {Lock the medium blocks}
      LockMediumBlocks;
      {Can we combine this block with the next free block?}
      LNextMediumBlock := PMediumFreeBlock(PByte(P) + LBlockSize);
      LNextMediumBlockSizeAndFlags := PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^;
      if (LNextMediumBlockSizeAndFlags and IsFreeBlockFlag) <> 0 then
      begin
        {Increase the size of this block}
        Inc(LBlockSize, LNextMediumBlockSizeAndFlags and DropMediumAndLargeFlagsMask);
        {Remove the next block as well}
        if LNextMediumBlockSizeAndFlags >= MinimumMediumBlockSize then
          RemoveMediumFreeBlock(LNextMediumBlock);
      end
      else
      begin
        {Reset the "previous in use" flag of the next block}
        PNativeUInt(PByte(LNextMediumBlock) - BlockHeaderSize)^ :=
          LNextMediumBlockSizeAndFlags or PreviousMediumBlockIsFreeFlag;
      end;
      {Can we combine this block with the previous free block? We need to
       re-read the flags since it could have changed before we could lock the
       medium blocks.}
      if (PNativeUInt(PByte(P) - BlockHeaderSize)^ and PreviousMediumBlockIsFreeFlag) <> 0 then
      begin
        {Get the size of the free block just before this one}
        LPreviousMediumBlockSize := PNativeUInt(PByte(P) - 2 * BlockHeaderSize)^;
        {Get the start of the previous block}
        LPreviousMediumBlock := PMediumFreeBlock(PByte(P) - LPreviousMediumBlockSize);
        {Set the new block size}
        Inc(LBlockSize, LPreviousMediumBlockSize);
        {This is the new current block}
        P := LPreviousMediumBlock;
        {Remove the previous block from the linked list}
        if LPreviousMediumBlockSize >= MinimumMediumBlockSize then
          RemoveMediumFreeBlock(LPreviousMediumBlock);
      end;
      {Is the entire medium block pool free, and there are other free blocks
       that can fit the largest possible medium block? -> free it.}
      if LBlockSize <> (MediumBlockPoolSize - MediumBlockPoolHeaderSize) then
      begin
        {Store the size of the block as well as the flags}
        PNativeUInt(PByte(P) - BlockHeaderSize)^ := LBlockSize or (IsMediumBlockFlag or IsFreeBlockFlag);
        {Store the trailing size marker}
        PNativeUInt(PByte(P) + LBlockSize - 2 * BlockHeaderSize)^ := LBlockSize;
        {Insert this block back into the bins: Size check not required here,
         since medium blocks that are in use are not allowed to be
         shrunk smaller than MinimumMediumBlockSize}
        InsertMediumBlockIntoBin(P, LBlockSize);
        {Unlock medium blocks}
        MediumBlocksLocked := False;
        {All OK}
        Result := 0;
      end
      else
      begin
        {Should this become the new sequential feed?}
        if MediumSequentialFeedBytesLeft <> MediumBlockPoolSize - MediumBlockPoolHeaderSize then
        begin
          {Bin the current sequential feed}
          BinMediumSequentialFeedRemainder;
          {Set this medium pool up as the new sequential feed pool:
           Store the sequential feed pool trailer}
          PNativeUInt(PByte(P) + LBlockSize - BlockHeaderSize)^ := IsMediumBlockFlag;
          {Store the number of bytes available in the sequential feed chunk}
          MediumSequentialFeedBytesLeft := MediumBlockPoolSize - MediumBlockPoolHeaderSize;
          {Set the last sequentially fed block}
          LastSequentiallyFedMediumBlock := Pointer(PByte(P) + LBlockSize);
          {Unlock medium blocks}
          MediumBlocksLocked := False;
          {Success}
          Result := 0;
        end
        else
        begin
          {Remove this medium block pool from the linked list}
          Dec(PByte(P), MediumBlockPoolHeaderSize);
          LPPreviousMediumBlockPoolHeader := PMediumBlockPoolHeader(P).PreviousMediumBlockPoolHeader;
          LPNextMediumBlockPoolHeader := PMediumBlockPoolHeader(P).NextMediumBlockPoolHeader;
          LPPreviousMediumBlockPoolHeader.NextMediumBlockPoolHeader := LPNextMediumBlockPoolHeader;
          LPNextMediumBlockPoolHeader.PreviousMediumBlockPoolHeader := LPPreviousMediumBlockPoolHeader;
          {Unlock medium blocks}
          MediumBlocksLocked := False;
          {Free the medium block pool}
          if VirtualFree(P, 0, MEM_RELEASE) then
            Result := 0
          else
            Result := -1;
        end;
      end;
    end
    else
    begin
      {Validate: Is this actually a Large block, or is it an attempt to free an
       already freed small block?}
      if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag) = 0 then
        Result := FreeLargeBlock(P)
      else
        Result := -1;
    end;
  end;
end;
{$else}
function SysFreeMem(P: Pointer): Integer;
asm
{$ifdef CPU386}
{---------------32-bit BASM SysFreeMem---------------}
  {On entry:
    eax = P}
  {Get the block header in edx}
  mov edx, [eax - 4]
  {Is it a small block in use?}
  test dl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
  {Save the pointer in ecx}
  mov ecx, eax
  {Save ebx}
  push ebx
  {Get the IsMultiThread variable in bl}
  mov bl, IsMultiThread
  {Is it a small block that is in use?}
  jnz @NotSmallBlockInUse
  {Do we need to lock the block type?}
  test bl, bl
  {Get the small block type in ebx}
  mov ebx, TSmallBlockPoolHeader[edx].BlockType
  {Do we need to lock the block type?}
  jnz @LockBlockTypeLoop
@GotLockOnSmallBlockType:
  {Current state: edx = @SmallBlockPoolHeader, ecx = P, ebx = @SmallBlockType}
  {Decrement the number of blocks in use}
  sub TSmallBlockPoolHeader[edx].BlocksInUse, 1
  {Get the old first free block}
  mov eax, TSmallBlockPoolHeader[edx].FirstFreeBlock
  {Is the pool now empty?}
  jz @PoolIsNowEmpty
  {Was the pool full?}
  test eax, eax
  {Store this as the new first free block}
  mov TSmallBlockPoolHeader[edx].FirstFreeBlock, ecx
  {Store the previous first free block as the block header}
  lea eax, [eax + IsFreeBlockFlag]
  mov [ecx - 4], eax
  {Insert the pool back into the linked list if it was full}
  jz @SmallPoolWasFull
  {All ok}
  xor eax, eax
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, al
  {Restore registers}
  pop ebx
  {Done}
  ret
  {Align branch target}
  nop
@SmallPoolWasFull:
  {Insert this as the first partially free pool for the block size}
  mov ecx, TSmallBlockType[ebx].NextPartiallyFreePool
  mov TSmallBlockPoolHeader[edx].PreviousPartiallyFreePool, ebx
  mov TSmallBlockPoolHeader[edx].NextPartiallyFreePool, ecx
  mov TSmallBlockPoolHeader[ecx].PreviousPartiallyFreePool, edx
  mov TSmallBlockType[ebx].NextPartiallyFreePool, edx
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, False
  {All ok}
  xor eax, eax
  {Restore registers}
  pop ebx
  {Done}
  ret
  {Align branch target}
  nop
  nop
@PoolIsNowEmpty:
  {Was this pool actually in the linked list of pools with space? If not, it
   can only be the sequential feed pool (it is the only pool that may contain
   only one block, i.e. other blocks have not been split off yet)}
  test eax, eax
  jz @IsSequentialFeedPool
  {Pool is now empty: Remove it from the linked list and free it}
  mov eax, TSmallBlockPoolHeader[edx].PreviousPartiallyFreePool
  mov ecx, TSmallBlockPoolHeader[edx].NextPartiallyFreePool
  {Remove this manager}
  mov TSmallBlockPoolHeader[eax].NextPartiallyFreePool, ecx
  mov TSmallBlockPoolHeader[ecx].PreviousPartiallyFreePool, eax
  {Zero out eax}
  xor eax, eax
  {Is this the sequential feed pool? If so, stop sequential feeding}
  cmp TSmallBlockType[ebx].CurrentSequentialFeedPool, edx
  jne @NotSequentialFeedPool
@IsSequentialFeedPool:
  mov TSmallBlockType[ebx].MaxSequentialFeedBlockAddress, eax
@NotSequentialFeedPool:
  {Unlock the block type}
  mov TSmallBlockType[ebx].BlockTypeLocked, al
  {Release this pool}
  mov eax, edx
  mov edx, [edx - 4]
  mov bl, IsMultiThread
  jmp @FreeMediumBlock
  {Align branch target}
@LockBlockTypeLoop:
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {The pause instruction improves spinlock performance}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  cmp NeverSleepOnMMThreadContention, 0
  jne @LockBlockTypeLoop
  {Couldn't grab the block type - sleep and try again}
  push ecx
  push edx
  push InitialSleepTime
  call Sleep
  pop edx
  pop ecx
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([ebx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Couldn't grab the block type - sleep and try again}
  push ecx
  push edx
  push AdditionalSleepTime
  call Sleep
  pop edx
  pop ecx
  {Try again}
  jmp @LockBlockTypeLoop
  {Align branch target}
  nop
  nop
  nop
  {-----------------------------Medium blocks-----------------------------}
@LockMediumBlocks:
  mov eax, $100
  {Attempt to lock the medium blocks}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumBlocksLocked
  {The pause instruction improves spinlock performance}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  cmp NeverSleepOnMMThreadContention, 0
  jne @LockMediumBlocks
  {Couldn't lock the medium blocks - sleep and try again}
  push InitialSleepTime
  call Sleep
  {Try again}
  mov eax, $100
  {Attempt to lock the medium blocks}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumBlocksLocked
  {Couldn't lock the medium blocks - sleep and try again}
  push AdditionalSleepTime
  call Sleep
  {Try again}
  jmp @LockMediumBlocks
  {Align branch target}
  nop
  nop
  nop
@NotSmallBlockInUse:
  {Not a small block in use: is it a medium or large block?}
  test dl, IsFreeBlockFlag + IsLargeBlockFlag
  jnz @NotASmallOrMediumBlock
@FreeMediumBlock:
  {Drop the flags}
  and edx, DropMediumAndLargeFlagsMask
  {Free the large block pointed to by eax, header in edx, bl = IsMultiThread}
  {Do we need to lock the medium blocks?}
  test bl, bl
  {Block size in ebx}
  mov ebx, edx
  {Save registers}
  push esi
  {Pointer in esi}
  mov esi, eax
  {Do we need to lock the medium blocks?}
  jnz @LockMediumBlocks
@MediumBlocksLocked:
  {Can we combine this block with the next free block?}
  test dword ptr [esi + ebx - 4], IsFreeBlockFlag
  {Get the next block size and flags in ecx}
  mov ecx, [esi + ebx - 4]
  jnz @NextBlockIsFree
  {Set the "PreviousIsFree" flag in the next block}
  or ecx, PreviousMediumBlockIsFreeFlag
  mov [esi + ebx - 4], ecx
@NextBlockChecked:
  {Can we combine this block with the previous free block? We need to
   re-read the flags since it could have changed before we could lock the
   medium blocks.}
  test byte ptr [esi - 4], PreviousMediumBlockIsFreeFlag
  jnz @PreviousBlockIsFree
@PreviousBlockChecked:
  {Is the entire medium block pool free, and there are other free blocks
   that can fit the largest possible medium block -> free it.}
  cmp ebx, (MediumBlockPoolSize - MediumBlockPoolHeaderSize)
  je @EntireMediumPoolFree
@BinFreeMediumBlock:
  {Store the size of the block as well as the flags}
  lea eax, [ebx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [esi - 4], eax
  {Store the trailing size marker}
  mov [esi + ebx - 8], ebx
  {Insert this block back into the bins: Size check not required here,
   since medium blocks that are in use are not allowed to be
   shrunk smaller than MinimumMediumBlockSize}
  mov eax, esi
  mov edx, ebx
  {Insert into bin}
  call InsertMediumBlockIntoBin
  {Unlock medium blocks}
  mov MediumBlocksLocked, False;
  {All OK}
  xor eax, eax
  {Restore registers}
  pop esi
  pop ebx
  {Return}
  ret
  {Align branch target}
  nop
@NextBlockIsFree:
  {Get the next block address in eax}
  lea eax, [esi + ebx]
  {Increase the size of this block}
  and ecx, DropMediumAndLargeFlagsMask
  add ebx, ecx
  {Was the block binned?}
  cmp ecx, MinimumMediumBlockSize
  jb @NextBlockChecked
  call RemoveMediumFreeBlock
  jmp @NextBlockChecked
  {Align branch target}
  nop
@PreviousBlockIsFree:
  {Get the size of the free block just before this one}
  mov ecx, [esi - 8]
  {Include the previous block}
  sub esi, ecx
  {Set the new block size}
  add ebx, ecx
  {Remove the previous block from the linked list}
  cmp ecx, MinimumMediumBlockSize
  jb @PreviousBlockChecked
  mov eax, esi
  call RemoveMediumFreeBlock
  jmp @PreviousBlockChecked
  {Align branch target}
@EntireMediumPoolFree:
  {Should we make this the new sequential feed medium block pool? If the
   current sequential feed pool is not entirely free, we make this the new
   sequential feed pool.}
  cmp MediumSequentialFeedBytesLeft, MediumBlockPoolSize - MediumBlockPoolHeaderSize
  jne @MakeEmptyMediumPoolSequentialFeed
  {Point esi to the medium block pool header}
  sub esi, MediumBlockPoolHeaderSize
  {Remove this medium block pool from the linked list}
  mov eax, TMediumBlockPoolHeader[esi].PreviousMediumBlockPoolHeader
  mov edx, TMediumBlockPoolHeader[esi].NextMediumBlockPoolHeader
  mov TMediumBlockPoolHeader[eax].NextMediumBlockPoolHeader, edx
  mov TMediumBlockPoolHeader[edx].PreviousMediumBlockPoolHeader, eax
  {Unlock medium blocks}
  mov MediumBlocksLocked, False;
  {Free the medium block pool}
  push MEM_RELEASE
  push 0
  push esi
  call VirtualFree
  {VirtualFree returns >0 if all is ok}
  cmp eax, 1
  {Return 0 on all ok}
  sbb eax, eax
  {Restore registers}
  pop esi
  pop ebx
  ret
  {Align branch target}
  nop
  nop
  nop
@MakeEmptyMediumPoolSequentialFeed:
  {Get a pointer to the end-marker block}
  lea ebx, [esi + MediumBlockPoolSize - MediumBlockPoolHeaderSize]
  {Bin the current sequential feed pool}
  call BinMediumSequentialFeedRemainder
  {Set this medium pool up as the new sequential feed pool:
   Store the sequential feed pool trailer}
  mov dword ptr [ebx - BlockHeaderSize], IsMediumBlockFlag
  {Store the number of bytes available in the sequential feed chunk}
  mov MediumSequentialFeedBytesLeft, MediumBlockPoolSize - MediumBlockPoolHeaderSize
  {Set the last sequentially fed block}
  mov LastSequentiallyFedMediumBlock, ebx
  {Unlock medium blocks}
  mov MediumBlocksLocked, False;
  {Success}
  xor eax, eax
  {Restore registers}
  pop esi
  pop ebx
  ret
  {Align branch target}
  nop
  nop
@NotASmallOrMediumBlock:
  {Restore ebx}
  pop ebx
  {Is it in fact a large block?}
  test dl, IsFreeBlockFlag + IsMediumBlockFlag
  jz FreeLargeBlock
  {Attempt to free an already free block}
  mov eax, -1
{$else}
{---------------64-bit BASM SysFreeMem---------------}
  .params 3
  .pushnv rbx
  .pushnv rsi
  {Get the block header in rdx}
  mov rdx, [rcx - BlockHeaderSize]
  {Is it a small block in use?}
  test dl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
  {Get the IsMultiThread variable in bl}
  mov bl, IsMultiThread
  {Is it a small block that is in use?}
  jnz @NotSmallBlockInUse
  {Do we need to lock the block type?}
  test bl, bl
  {Get the small block type in rbx}
  mov rbx, TSmallBlockPoolHeader[rdx].BlockType
  {Do we need to lock the block type?}
  jnz @LockBlockTypeLoop
@GotLockOnSmallBlockType:
  {Current state: rdx = @SmallBlockPoolHeader, rcx = APointer, rbx = @SmallBlockType}
  {Decrement the number of blocks in use}
  sub TSmallBlockPoolHeader[rdx].BlocksInUse, 1
  {Get the old first free block}
  mov rax, TSmallBlockPoolHeader[rdx].FirstFreeBlock
  {Is the pool now empty?}
  jz @PoolIsNowEmpty
  {Was the pool full?}
  test rax, rax
  {Store this as the new first free block}
  mov TSmallBlockPoolHeader[rdx].FirstFreeBlock, rcx
  {Store the previous first free block as the block header}
  lea rax, [rax + IsFreeBlockFlag]
  mov [rcx - BlockHeaderSize], rax
  {Insert the pool back into the linked list if it was full}
  jz @SmallPoolWasFull
  {All ok}
  xor eax, eax
  {Unlock the block type}
  mov TSmallBlockType[rbx].BlockTypeLocked, al
  jmp @Done
@SmallPoolWasFull:
  {Insert this as the first partially free pool for the block size}
  mov rcx, TSmallBlockType[rbx].NextPartiallyFreePool
  mov TSmallBlockPoolHeader[rdx].PreviousPartiallyFreePool, rbx
  mov TSmallBlockPoolHeader[rdx].NextPartiallyFreePool, rcx
  mov TSmallBlockPoolHeader[rcx].PreviousPartiallyFreePool, rdx
  mov TSmallBlockType[rbx].NextPartiallyFreePool, rdx
  {Unlock the block type}
  mov TSmallBlockType[rbx].BlockTypeLocked, False
  {All ok}
  xor eax, eax
  jmp @Done
@PoolIsNowEmpty:
  {Was this pool actually in the linked list of pools with space? If not, it
   can only be the sequential feed pool (it is the only pool that may contain
   only one block, i.e. other blocks have not been split off yet)}
  test rax, rax
  jz @IsSequentialFeedPool
  {Pool is now empty: Remove it from the linked list and free it}
  mov rax, TSmallBlockPoolHeader[rdx].PreviousPartiallyFreePool
  mov rcx, TSmallBlockPoolHeader[rdx].NextPartiallyFreePool
  {Remove this manager}
  mov TSmallBlockPoolHeader[rax].NextPartiallyFreePool, rcx
  mov TSmallBlockPoolHeader[rcx].PreviousPartiallyFreePool, rax
  {Zero out eax}
  xor rax, rax
  {Is this the sequential feed pool? If so, stop sequential feeding}
  cmp TSmallBlockType[rbx].CurrentSequentialFeedPool, rdx
  jne @NotSequentialFeedPool
@IsSequentialFeedPool:
  mov TSmallBlockType[rbx].MaxSequentialFeedBlockAddress, rax
@NotSequentialFeedPool:
  {Unlock the block type}
  mov TSmallBlockType[rbx].BlockTypeLocked, al
  {Release this pool}
  mov rcx, rdx
  mov rdx, [rdx - BlockHeaderSize]
  mov bl, IsMultiThread
  jmp @FreeMediumBlock
@LockBlockTypeLoop:
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([rbx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Pause instruction (improves performance on P4)}
  pause
  lea rax, NeverSleepOnMMThreadContention
  test byte ptr [rax], 0
  jne @LockBlockTypeLoop
  {Couldn't grab the block type - sleep and try again}
  mov rsi, rcx
  mov ecx, InitialSleepTime
  call Sleep
  mov rcx, rsi
  mov rdx, [rcx - BlockHeaderSize]
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg TSmallBlockType([rbx]).BlockTypeLocked, ah
  je @GotLockOnSmallBlockType
  {Couldn't grab the block type - sleep and try again}
  mov rsi, rcx
  mov ecx, AdditionalSleepTime
  call Sleep
  mov rcx, rsi
  mov rdx, [rcx - BlockHeaderSize]
  {Try again}
  jmp @LockBlockTypeLoop
  {---------------------Medium blocks------------------------------}
@NotSmallBlockInUse:
  {Not a small block in use: is it a medium or large block?}
  test dl, IsFreeBlockFlag + IsLargeBlockFlag
  jnz @NotASmallOrMediumBlock
@FreeMediumBlock:
{$ifdef ClearSmallAndMediumBlocksInFreeMem}
  mov rsi, rcx
  and rdx, DropMediumAndLargeFlagsMask
  sub rdx, BlockHeaderSize
  xor r8, r8
  call System.@FillChar
  mov rcx, rsi
  mov rdx, [rcx - BlockHeaderSize]
{$endif}
  {Drop the flags}
  and rdx, DropMediumAndLargeFlagsMask
  {Free the medium block pointed to by eax, header in edx, bl = IsMultiThread}
{$ifndef AssumeMultiThreaded}
  {Do we need to lock the medium blocks?}
  test bl, bl
{$endif}
  {Block size in rbx}
  mov rbx, rdx
  {Pointer in rsi}
  mov rsi, rcx
  {Do we need to lock the medium blocks?}
{$ifndef AssumeMultiThreaded}
  jz @MediumBlocksLocked
{$endif}
  call LockMediumBlocks
@MediumBlocksLocked:
  {Can we combine this block with the next free block?}
  test qword ptr [rsi + rbx - BlockHeaderSize], IsFreeBlockFlag
  {Get the next block size and flags in rcx}
  mov rcx, [rsi + rbx - BlockHeaderSize]
  jnz @NextBlockIsFree
  {Set the "PreviousIsFree" flag in the next block}
  or rcx, PreviousMediumBlockIsFreeFlag
  mov [rsi + rbx - BlockHeaderSize], rcx
@NextBlockChecked:
  {Can we combine this block with the previous free block? We need to
   re-read the flags since it could have changed before we could lock the
   medium blocks.}
  test byte ptr [rsi - BlockHeaderSize], PreviousMediumBlockIsFreeFlag
  jnz @PreviousBlockIsFree
@PreviousBlockChecked:
  {Is the entire medium block pool free, and there are other free blocks
   that can fit the largest possible medium block -> free it.}
  cmp ebx, (MediumBlockPoolSize - MediumBlockPoolHeaderSize)
  je @EntireMediumPoolFree
@BinFreeMediumBlock:
  {Store the size of the block as well as the flags}
  lea rax, [rbx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [rsi - BlockHeaderSize], rax
  {Store the trailing size marker}
  mov [rsi + rbx - 2 * BlockHeaderSize], rbx
  {Insert this block back into the bins: Size check not required here,
   since medium blocks that are in use are not allowed to be
   shrunk smaller than MinimumMediumBlockSize}
  mov rcx, rsi
  mov rdx, rbx
  {Insert into bin}
  call InsertMediumBlockIntoBin
  {All OK}
  xor eax, eax
  {Unlock medium blocks}
  mov MediumBlocksLocked, al
  jmp @Done
@NextBlockIsFree:
  {Get the next block address in rax}
  lea rax, [rsi + rbx]
  {Increase the size of this block}
  and rcx, DropMediumAndLargeFlagsMask
  add rbx, rcx
  {Was the block binned?}
  cmp rcx, MinimumMediumBlockSize
  jb @NextBlockChecked
  mov rcx, rax
  call RemoveMediumFreeBlock
  jmp @NextBlockChecked
@PreviousBlockIsFree:
  {Get the size of the free block just before this one}
  mov rcx, [rsi - 2 * BlockHeaderSize]
  {Include the previous block}
  sub rsi, rcx
  {Set the new block size}
  add rbx, rcx
  {Remove the previous block from the linked list}
  cmp ecx, MinimumMediumBlockSize
  jb @PreviousBlockChecked
  mov rcx, rsi
  call RemoveMediumFreeBlock
  jmp @PreviousBlockChecked
@EntireMediumPoolFree:
  {Should we make this the new sequential feed medium block pool? If the
   current sequential feed pool is not entirely free, we make this the new
   sequential feed pool.}
  lea r8, MediumSequentialFeedBytesLeft
  cmp dword ptr [r8], MediumBlockPoolSize - MediumBlockPoolHeaderSize //workaround for QC99023
  jne @MakeEmptyMediumPoolSequentialFeed
  {Point esi to the medium block pool header}
  sub rsi, MediumBlockPoolHeaderSize
  {Remove this medium block pool from the linked list}
  mov rax, TMediumBlockPoolHeader[rsi].PreviousMediumBlockPoolHeader
  mov rdx, TMediumBlockPoolHeader[rsi].NextMediumBlockPoolHeader
  mov TMediumBlockPoolHeader[rax].NextMediumBlockPoolHeader, rdx
  mov TMediumBlockPoolHeader[rdx].PreviousMediumBlockPoolHeader, rax
  {Unlock medium blocks}
  xor eax, eax
  mov MediumBlocksLocked, al
{$ifdef ClearMediumBlockPoolsBeforeReturningToOS}
  mov rcx, rsi
  mov edx, MediumBlockPoolSize
  xor r8, r8
  call System.@FillChar
{$endif}
  {Free the medium block pool}
  mov rcx, rsi
  xor edx, edx
  mov r8d, MEM_RELEASE
  call VirtualFree
  {VirtualFree returns >0 if all is ok}
  cmp eax, 1
  {Return 0 on all ok}
  sbb eax, eax
  jmp @Done
@MakeEmptyMediumPoolSequentialFeed:
  {Get a pointer to the end-marker block}
  lea rbx, [rsi + MediumBlockPoolSize - MediumBlockPoolHeaderSize]
  {Bin the current sequential feed pool}
  call BinMediumSequentialFeedRemainder
  {Set this medium pool up as the new sequential feed pool:
   Store the sequential feed pool trailer}
  mov qword ptr [rbx - BlockHeaderSize], IsMediumBlockFlag
  {Store the number of bytes available in the sequential feed chunk}
  lea rax, MediumSequentialFeedBytesLeft
  mov dword ptr [rax], MediumBlockPoolSize - MediumBlockPoolHeaderSize //QC99023 workaround
  {Set the last sequentially fed block}
  mov LastSequentiallyFedMediumBlock, rbx
  {Success}
  xor eax, eax
  {Unlock medium blocks}
  mov MediumBlocksLocked, al
  jmp @Done
@NotASmallOrMediumBlock:
  {Attempt to free an already free block?}
  mov eax, -1
  {Is it in fact a large block?}
  test dl, IsFreeBlockFlag + IsMediumBlockFlag
  jnz @Done
  call FreeLargeBlock
@Done:
{$endif}
end;
{$endif}

{$ifdef UsePascalCode}
function SysReallocMem(P: Pointer; Size: NativeInt): Pointer;
var
  LBlockHeader, LNextBlockSizeAndFlags, LNewAllocSize: NativeUInt;
  LBlockFlags, LOldAvailableSize, LNextBlockSize, LNewAvailableSize,
    LMinimumUpsize, LSecondSplitSize, LNewBlockSize: Cardinal;
  LPSmallBlockType: PSmallBlockType;
  LPNextBlock, LPNextBlockHeader: Pointer;

  {Upsizes a large block in-place. The following variables are assumed correct:
    LBlockFlags, LOldAvailableSize, LPNextBlock, LNextBlockSizeAndFlags,
    LNextBlockSize, LNewAvailableSize. Medium blocks must be locked on entry if
    required.}
  procedure MediumBlockInPlaceUpsize;
  begin
    {Remove the next block}
    if LNextBlockSizeAndFlags >= MinimumMediumBlockSize then
      RemoveMediumFreeBlock(LPNextBlock);
    {Add 25% for medium block in-place upsizes}
    LMinimumUpsize := LOldAvailableSize + (LOldAvailableSize shr 2);
    if Cardinal(Size) < LMinimumUpsize then
      LNewAllocSize := LMinimumUpsize
    else
      LNewAllocSize := Cardinal(Size);
    {Round up to the nearest block size granularity}
    LNewBlockSize := ((LNewAllocSize + (BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    {Calculate the size of the second split}
    LSecondSplitSize := LNewAvailableSize + BlockHeaderSize - LNewBlockSize;
    {Does it fit?}
    if Integer(LSecondSplitSize) <= 0 then
    begin
      {The block size is the full available size plus header}
      LNewBlockSize := LNewAvailableSize + BlockHeaderSize;
      {Grab the whole block: Mark it as used in the block following it}
      LPNextBlockHeader := Pointer(PByte(P) + LNewAvailableSize);
      PNativeUInt(LPNextBlockHeader)^ :=
        PNativeUInt(LPNextBlockHeader)^ and (not PreviousMediumBlockIsFreeFlag);
    end
    else
    begin
      {Split the block in two}
      LPNextBlock := PMediumFreeBlock(PByte(P) + LNewBlockSize);
      {Set the size of the second split}
      PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^ := LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
      {Store the size of the second split before the header of the next block}
      PNativeUInt(PByte(LPNextBlock) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
      {Put the remainder in a bin if it is big enough}
      if LSecondSplitSize >= MinimumMediumBlockSize then
        InsertMediumBlockIntoBin(LPNextBlock, LSecondSplitSize);
    end;
    {Set the size and flags for this block}
    PNativeUInt(PByte(P) - BlockHeaderSize)^ := LNewBlockSize or LBlockFlags;
  end;

  {In-place downsize of a medium block. On entry Size must be less than half of
   LOldAvailableSize.}
  procedure MediumBlockInPlaceDownsize;
  begin
    {Round up to the next medium block size}
    LNewBlockSize := ((Size + (BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    {Get the size of the second split}
    LSecondSplitSize := (LOldAvailableSize + BlockHeaderSize) - LNewBlockSize;
    {Lock the medium blocks}
    LockMediumBlocks;
    {Set the new size}
    PNativeUInt(PByte(P) - BlockHeaderSize)^ :=
      (PNativeUInt(PByte(P) - BlockHeaderSize)^ and ExtractMediumAndLargeFlagsMask)
      or LNewBlockSize;
    {Is the next block in use?}
    LPNextBlock := PNativeUInt(PByte(P) + LOldAvailableSize + BlockHeaderSize);
    LNextBlockSizeAndFlags := PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^;
    if LNextBlockSizeAndFlags and IsFreeBlockFlag = 0 then
    begin
      {The next block is in use: flag its previous block as free}
      PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^ :=
        LNextBlockSizeAndFlags or PreviousMediumBlockIsFreeFlag;
    end
    else
    begin
      {The next block is free: combine it}
      LNextBlockSizeAndFlags := LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask;
      Inc(LSecondSplitSize, LNextBlockSizeAndFlags);
      if LNextBlockSizeAndFlags >= MinimumMediumBlockSize then
        RemoveMediumFreeBlock(LPNextBlock);
    end;
    {Set the split}
    LPNextBlock := PNativeUInt(PByte(P) + LNewBlockSize);
    {Store the free part's header}
    PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^ := LSecondSplitSize or (IsMediumBlockFlag or IsFreeBlockFlag);
    {Store the trailing size field}
    PNativeUInt(PByte(LPNextBlock) + LSecondSplitSize - 2 * BlockHeaderSize)^ := LSecondSplitSize;
    {Bin this free block}
    if LSecondSplitSize >= MinimumMediumBlockSize then
      InsertMediumBlockIntoBin(LPNextBlock, LSecondSplitSize);
    {Unlock the medium blocks}
    MediumBlocksLocked := False;
  end;

begin
  {Get the block header: Is it actually a small block?}
  LBlockHeader := PNativeUInt(PByte(P) - BlockHeaderSize)^;
  {Is it a small block that is in use?}
  if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag or IsLargeBlockFlag) = 0 then
  begin
    {----------------------------Small block------------------------------}
    {The block header is a pointer to the block pool: Get the block type}
    LPSmallBlockType := PSmallBlockPoolHeader(LBlockHeader).BlockType;
    {Get the available size inside blocks of this type.}
    LOldAvailableSize := LPSmallBlockType.BlockSize - BlockHeaderSize;
    {Is it an upsize or a downsize?}
    if LOldAvailableSize >= NativeUInt(Size) then
    begin
      {It's a downsize. Do we need to allocate a smaller block? Only if the new
       block size is less than a quarter of the available size less
       SmallBlockDownsizeCheckAdder bytes}
      if (Cardinal(Size) * 4 + SmallBlockDownsizeCheckAdder) >= LOldAvailableSize then
      begin
        {In-place downsize - return the pointer}
        Result := P;
        Exit;
      end
      else
      begin
        {Allocate a smaller block}
        Result := SysGetMem(Size);
        {Allocated OK?}
        if Result <> nil then
        begin
          {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  {$ifdef CPU386}
        MoveX8LP(P^, Result^, Size);
  {$else}
        {Blocks are always 16-byte aligned under 64-bit.}
        MoveX16LP(P^, Result^, Size);
  {$endif}
{$else}
          Move(P^, Result^, Size);
{$endif}
          {Free the old pointer}
          SysFreeMem(P);
        end;
      end;
    end
    else
    begin
      {This pointer is being reallocated to a larger block and therefore it is
       logical to assume that it may be enlarged again. Since reallocations are
       expensive, there is a minimum upsize percentage to avoid unnecessary
       future move operations.}
      {Must grow with at least 100% + x bytes}
      LNewAllocSize := LOldAvailableSize * 2 + SmallBlockUpsizeAdder;
      {Still not large enough?}
      if LNewAllocSize < NativeUInt(Size) then
        LNewAllocSize := Size;
      {Allocate the new block}
      Result := SysGetMem(LNewAllocSize);
      {Allocated OK?}
      if Result <> nil then
      begin
        {Do we need to store the requested size? Only large blocks store the
         requested size.}
        if LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize) then
          PLargeBlockHeader(PByte(Result) - LargeBlockHeaderSize).UserAllocatedSize := Size;
        {Move the data across}
{$ifdef UseCustomFixedSizeMoveRoutines}
        LPSmallBlockType.UpsizeMoveProcedure(P^, Result^, LOldAvailableSize);
{$else}
        Move(P^, Result^, LOldAvailableSize);
{$endif}
        {Free the old pointer}
        SysFreeMem(P);
      end;
    end;
  end
  else
  begin
    {Is this a medium block or a large block?}
    if LBlockHeader and (IsFreeBlockFlag or IsLargeBlockFlag) = 0 then
    begin
      {-------------------------Medium block------------------------------}
      {What is the available size in the block being reallocated?}
      LOldAvailableSize := (LBlockHeader and DropMediumAndLargeFlagsMask);
      {Get a pointer to the next block}
      LPNextBlock := PNativeUInt(PByte(P) + LOldAvailableSize);
      {Subtract the block header size from the old available size}
      Dec(LOldAvailableSize, BlockHeaderSize);
      {Is it an upsize or a downsize?}
      if NativeUInt(Size) > LOldAvailableSize then
      begin
        {Can we do an in-place upsize?}
        LNextBlockSizeAndFlags := PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^;
        {Is the next block free?}
        if LNextBlockSizeAndFlags and IsFreeBlockFlag <> 0 then
        begin
          LNextBlockSize := LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask;
          {The available size including the next block}
          LNewAvailableSize := LOldAvailableSize + LNextBlockSize;
          {Can the block fit?}
          if NativeUInt(Size) <= LNewAvailableSize then
          begin
            {The next block is free and there is enough space to grow this
             block in place.}
            if IsMultiThread then
            begin
              {Multi-threaded application - lock medium blocks and re-read the
               information on the blocks.}
              LockMediumBlocks;
              {Re-read the info for this block}
              LBlockFlags := PNativeUInt(PByte(P) - BlockHeaderSize)^ and ExtractMediumAndLargeFlagsMask;
              {Re-read the info for the next block}
              LNextBlockSizeAndFlags := PNativeUInt(PByte(LPNextBlock) - BlockHeaderSize)^;
              {Recalculate the next block size}
              LNextBlockSize := LNextBlockSizeAndFlags and DropMediumAndLargeFlagsMask;
              {The available size including the next block}
              LNewAvailableSize := LOldAvailableSize + LNextBlockSize;
              {Is the next block still free and the size still sufficient?}
              if (LNextBlockSizeAndFlags and IsFreeBlockFlag <> 0)
                and (NativeUInt(Size) <= LNewAvailableSize) then
              begin
                {Upsize the block in-place}
                MediumBlockInPlaceUpsize;
                {Unlock the medium blocks}
                MediumBlocksLocked := False;
                {Return the result}
                Result := P;
                {Done}
                Exit;
              end;
              {Couldn't use the block: Unlock the medium blocks}
              MediumBlocksLocked := False;
            end
            else
            begin
              {Extract the block flags}
              LBlockFlags := ExtractMediumAndLargeFlagsMask and LBlockHeader;
              {Upsize the block in-place}
              MediumBlockInPlaceUpsize;
              {Return the result}
              Result := P;
              {Done}
              Exit;
            end;
          end;
        end;
        {Couldn't upsize in place. Grab a new block and move the data across:
         If we have to reallocate and move medium blocks, we grow by at
         least 25%}
        LMinimumUpsize := LOldAvailableSize + (LOldAvailableSize shr 2);
        if NativeUInt(Size) < LMinimumUpsize then
          LNewAllocSize := LMinimumUpsize
        else
          LNewAllocSize := Size;
        {Allocate the new block}
        Result := SysGetMem(LNewAllocSize);
        if Result <> nil then
        begin
          {If its a Large block - store the actual user requested size}
          if LNewAllocSize > (MaximumMediumBlockSize - BlockHeaderSize) then
            PLargeBlockHeader(PByte(Result) - LargeBlockHeaderSize).UserAllocatedSize := Size;
          {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
          MoveX16LP(P^, Result^, LOldAvailableSize);
{$else}
          Move(P^, Result^, LOldAvailableSize);
{$endif}
          {Free the old block}
          SysFreeMem(P);
        end;
      end
      else
      begin
        {Must be less than half the current size or we don't bother resizing.}
        if NativeUInt(Size * 2) >= LOldAvailableSize then
        begin
          Result := P;
        end
        else
        begin
          {In-place downsize? Balance the cost of moving the data vs. the cost of
           fragmenting the memory pool. Medium blocks in use may never be smaller
           than MinimumMediumBlockSize.}
          if NativeUInt(Size) >= (MinimumMediumBlockSize - BlockHeaderSize) then
          begin
            MediumBlockInPlaceDownsize;
            Result := P;
          end
          else
          begin
            {The requested size is less than the minimum medium block size. If
             the requested size is less than the threshold value (currently a
             quarter of the minimum medium block size), move the data to a small
             block, otherwise shrink the medium block to the minimum allowable
             medium block size.}
            if NativeUInt(Size) >= MediumInPlaceDownsizeLimit then
            begin
              {The request is for a size smaller than the minimum medium block
               size, but not small enough to justify moving data: Reduce the
               block size to the minimum medium block size}
              Size := MinimumMediumBlockSize - BlockHeaderSize;
              {Is it already at the minimum medium block size?}
              if LOldAvailableSize > NativeUInt(Size) then
                MediumBlockInPlaceDownsize;
              Result := P;
            end
            else
            begin
              {Allocate the new block}
              Result := SysGetMem(Size);
              if Result <> nil then
              begin
                {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  {$ifdef CPU386}
                MoveX8LP(P^, Result^, Size);
  {$else}
                {Blocks are always 16-byte aligned under 64-bit.}
                MoveX16LP(P^, Result^, Size);
  {$endif}
{$else}
                Move(P^, Result^, Size);
{$endif}
                {Free the old block}
                SysFreeMem(P);
              end;
            end;
          end;
        end;

      end;
    end
    else
    begin
      {Is this a valid large block?}
      if LBlockHeader and (IsFreeBlockFlag or IsMediumBlockFlag) = 0 then
      begin
        {-----------------------Large block------------------------------}
        Result := ReallocateLargeBlock(P, Size);
      end
      else
      begin
        {-----------------------Invalid block------------------------------}
        {Bad pointer: probably an attempt to reallocate a free memory block.}
        Result := nil;
      end;
    end;
  end;
end;
{$else}
function SysReallocMem(P: Pointer; Size: NativeInt): Pointer;
asm
{$ifdef CPU386}
{-----------------32-bit BASM SysReallocMem-----------------}
  {On entry: eax = P; edx = Size}
  {Get the block header: Is it actually a small block?}
  mov ecx, [eax - 4]
  {Is it a small block?}
  test cl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
  {Save ebx}
  push ebx
  {Save esi}
  push esi
  {Save the original pointer in esi}
  mov esi, eax
  {Is it a small block?}
  jnz @NotASmallBlock
  {----------------------------Small block--------------------------------}
  {Get the block type in ebx}
  mov ebx, TSmallBlockPoolHeader[ecx].BlockType
  {Get the available size inside blocks of this type.}
  movzx ecx, TSmallBlockType[ebx].BlockSize
  sub ecx, 4
  {Is it an upsize or a downsize?}
  cmp ecx, edx
  jb @SmallUpsize
  {It's a downsize. Do we need to allocate a smaller block? Only if the new
   size is less than a quarter of the available size less
   SmallBlockDownsizeCheckAdder bytes}
  lea ebx, [edx * 4 + SmallBlockDownsizeCheckAdder]
  cmp ebx, ecx
  jb @NotSmallInPlaceDownsize
  {In-place downsize - return the original pointer}
  pop esi
  pop ebx
  ret
  {Align branch target}
  nop
@NotSmallInPlaceDownsize:
  {Save the requested size}
  mov ebx, edx
  {Allocate a smaller block}
  mov eax, edx
  call SysGetMem
  {Allocated OK?}
  test eax, eax
  jz @SmallDownsizeDone
  {Move data across: count in ecx}
  mov ecx, ebx
  {Destination in edx}
  mov edx, eax
  {Save the result in ebx}
  mov ebx, eax
  {Original pointer in eax}
  mov eax, esi
  {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  call MoveX8LP
{$else}
  call Move
{$endif}
  {Free the original pointer}
  mov eax, esi
  call SysFreeMem
  {Return the pointer}
  mov eax, ebx
@SmallDownsizeDone:
  pop esi
  pop ebx
  ret
  {Align branch target}
  nop
  nop
@SmallUpsize:
  {State: esi = P, edx = Size, ecx = Current Block Size, ebx = Current Block Type}
  {This pointer is being reallocated to a larger block and therefore it is
   logical to assume that it may be enlarged again. Since reallocations are
   expensive, there is a minimum upsize percentage to avoid unnecessary
   future move operations.}
  {Small blocks always grow with at least 100% + SmallBlockUpsizeAdder bytes}
  lea ecx, [ecx + ecx + SmallBlockUpsizeAdder]
  {save edi}
  push edi
  {Save the requested size in edi}
  mov edi, edx
  {New allocated size is the maximum of the requested size and the minimum
   upsize}
  xor eax, eax
  sub ecx, edx
  adc eax, -1
  and eax, ecx
  add eax, edx
  {Allocate the new block}
  call SysGetMem
  {Allocated OK?}
  test eax, eax
  jz @SmallUpsizeDone
  {Do we need to store the requested size? Only large blocks store the
   requested size.}
  cmp edi, MaximumMediumBlockSize - BlockHeaderSize
  jbe @NotSmallUpsizeToLargeBlock
  {Store the user requested size}
  mov [eax - 8], edi
@NotSmallUpsizeToLargeBlock:
  {Get the size to move across}
  movzx ecx, TSmallBlockType[ebx].BlockSize
  sub ecx, BlockHeaderSize
  {Move to the new block}
  mov edx, eax
  {Save the result in edi}
  mov edi, eax
  {Move from the old block}
  mov eax, esi
  {Move the data across}
{$ifdef UseCustomFixedSizeMoveRoutines}
  call TSmallBlockType[ebx].UpsizeMoveProcedure
{$else}
  call Move
{$endif}
  {Free the old pointer}
  mov eax, esi
  call SysFreeMem
  {Done}
  mov eax, edi
@SmallUpsizeDone:
  pop edi
  pop esi
  pop ebx
  ret
  {Align branch target}
{$ifndef UseCustomFixedSizeMoveRoutines}
  nop
  nop
{$endif}
  nop
@NotASmallBlock:
  {Is this a medium block or a large block?}
  test cl, IsFreeBlockFlag + IsLargeBlockFlag
  jnz @PossibleLargeBlock
  {----------------------------Medium block-------------------------------}
  {Status: ecx = Current Block Size + Flags, eax/esi = P,
   edx = Requested Size}
  mov ebx, ecx
  {Drop the flags from the header}
  and ecx, DropMediumAndLargeFlagsMask
  {Save edi}
  push edi
  {Get a pointer to the next block in edi}
  lea edi, [eax + ecx]
  {Subtract the block header size from the old available size}
  sub ecx, BlockHeaderSize
  {Get the complete flags in ebx}
  and ebx, ExtractMediumAndLargeFlagsMask
  {Is it an upsize or a downsize?}
  cmp edx, ecx
  {Save ebp}
  push ebp
  {Is it an upsize or a downsize?}
  ja @MediumBlockUpsize
  {Status: ecx = Current Block Size - 4, bl = Current Block Flags,
   edi = @Next Block, eax/esi = P, edx = Requested Size}
  {Must be less than half the current size or we don't bother resizing.}
  lea ebp, [edx + edx]
  cmp ebp, ecx
  jb @MediumMustDownsize
@MediumNoResize:
  {Restore registers}
  pop ebp
  pop edi
  pop esi
  pop ebx
  {Return}
  ret
  {Align branch target}
  nop
  nop
  nop
@MediumMustDownsize:
  {In-place downsize? Balance the cost of moving the data vs. the cost of
   fragmenting the memory pool. Medium blocks in use may never be smaller
   than MinimumMediumBlockSize.}
  cmp edx, MinimumMediumBlockSize - BlockHeaderSize
  jae @MediumBlockInPlaceDownsize
  {The requested size is less than the minimum medium block size. If the
  requested size is less than the threshold value (currently a quarter of the
  minimum medium block size), move the data to a small block, otherwise shrink
  the medium block to the minimum allowable medium block size.}
  cmp edx, MediumInPlaceDownsizeLimit
  jb @MediumDownsizeRealloc
  {The request is for a size smaller than the minimum medium block size, but
   not small enough to justify moving data: Reduce the block size to the
   minimum medium block size}
  mov edx, MinimumMediumBlockSize - BlockHeaderSize
  {Is it already at the minimum medium block size?}
  cmp ecx, edx
  jna @MediumNoResize
@MediumBlockInPlaceDownsize:
  {Round up to the next medium block size}
  lea ebp, [edx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
  and ebp, -MediumBlockGranularity;
  add ebp, MediumBlockSizeOffset
  {Get the size of the second split}
  add ecx, BlockHeaderSize
  sub ecx, ebp
  {Lock the medium blocks}
  cmp IsMultiThread, False
  je @DoMediumInPlaceDownsize
  {We have to re-read the flags}
@DoMediumLockForDownsize:
  {Lock the medium blocks}
  mov eax, $100
  {Attempt to lock the medium blocks}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumDownsizeRereadFlags
  {The pause instruction improves spinlock performance}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  cmp NeverSleepOnMMThreadContention, 0
  jne @DoMediumLockForDownsize
  {Couldn't lock the medium blocks - sleep and try again}
  push ecx
  push InitialSleepTime
  call Sleep
  pop ecx
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg MediumBlocksLocked, ah
  je @MediumDownsizeRereadFlags
  {Couldn't lock the medium blocks - sleep and try again}
  push ecx
  push AdditionalSleepTime
  call Sleep
  pop ecx
  {Try again}
  jmp @DoMediumLockForDownsize
  {Align branch target}
  nop
@MediumDownsizeRereadFlags:
  mov ebx, ExtractMediumAndLargeFlagsMask
  and ebx, [esi - 4]
@DoMediumInPlaceDownsize:
  {Set the new size}
  or ebx, ebp
  mov [esi - 4], ebx
  {Get the second split size in ebx}
  mov ebx, ecx
  {Is the next block in use?}
  mov edx, [edi - 4]
  test dl, IsFreeBlockFlag
  jnz @MediumDownsizeNextBlockFree
  {The next block is in use: flag its previous block as free}
  or edx, PreviousMediumBlockIsFreeFlag
  mov [edi - 4], edx
  jmp @MediumDownsizeDoSplit
  {Align branch target}
  nop
@MediumDownsizeNextBlockFree:
  {The next block is free: combine it}
  mov eax, edi
  and edx, DropMediumAndLargeFlagsMask
  add ebx, edx
  add edi, edx
  cmp edx, MinimumMediumBlockSize
  jb @MediumDownsizeDoSplit
  call RemoveMediumFreeBlock
@MediumDownsizeDoSplit:
  {Store the trailing size field}
  mov [edi - 8], ebx
  {Store the free part's header}
  lea eax, [ebx + IsMediumBlockFlag + IsFreeBlockFlag];
  mov [esi + ebp - 4], eax
  {Bin this free block}
  cmp ebx, MinimumMediumBlockSize
  jb @MediumBlockDownsizeDone
  lea eax, [esi + ebp]
  mov edx, ebx
  call InsertMediumBlockIntoBin
@MediumBlockDownsizeDone:
  {Unlock the medium blocks}
  mov MediumBlocksLocked, False
  {Result = old pointer}
  mov eax, esi
  {Restore registers}
  pop ebp
  pop edi
  pop esi
  pop ebx
  {Return}
  ret
  {Align branch target}
@MediumDownsizeRealloc:
  {Save the requested size}
  mov edi, edx
  mov eax, edx
  {Allocate the new block}
  call SysGetMem
  test eax, eax
  jz @MediumBlockDownsizeExit
  {Save the result}
  mov ebp, eax
  mov edx, eax
  mov eax, esi
  mov ecx, edi
  {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  call MoveX8LP
{$else}
  call Move
{$endif}
  mov eax, esi
  call SysFreeMem
  {Return the result}
  mov eax, ebp
@MediumBlockDownsizeExit:
  pop ebp
  pop edi
  pop esi
  pop ebx
  ret
  {Align branch target}
@MediumBlockUpsize:
  {Status: ecx = Current Block Size - 4, bl = Current Block Flags,
   edi = @Next Block, eax/esi = P, edx = Requested Size}
  {Can we do an in-place upsize?}
  mov eax, [edi - 4]
  test al, IsFreeBlockFlag
  jz @CannotUpsizeMediumBlockInPlace
  {Get the total available size including the next block}
  and eax, DropMediumAndLargeFlagsMask
  {ebp = total available size including the next block (excluding the header)}
  lea ebp, [eax + ecx]
  {Can the block fit?}
  cmp edx, ebp
  ja @CannotUpsizeMediumBlockInPlace
  {The next block is free and there is enough space to grow this
   block in place.}
  cmp IsMultiThread, False
  je @DoMediumInPlaceUpsize
@DoMediumLockForUpsize:
  {Lock the medium blocks}
  mov eax, $100
  {Attempt to lock the medium blocks}
  lock cmpxchg MediumBlocksLocked, ah
  je @RecheckMediumInPlaceUpsize
  {The pause instruction improves spinlock performance}
  pause
  {"Busy waiting" or "sleep and retry" strategy?}
  cmp NeverSleepOnMMThreadContention, 0
  jne @DoMediumLockForUpsize
  {Couldn't lock the medium blocks - sleep and try again}
  push ecx
  push edx
  push InitialSleepTime
  call Sleep
  pop edx
  pop ecx
  {Try again}
  mov eax, $100
  {Attempt to grab the block type}
  lock cmpxchg MediumBlocksLocked, ah
  je @RecheckMediumInPlaceUpsize
  {Couldn't lock the medium blocks - sleep and try again}
  push ecx
  push edx
  push AdditionalSleepTime
  call Sleep
  pop edx
  pop ecx
  {Try again}
  jmp @DoMediumLockForUpsize
  {Align branch target}
  nop
@RecheckMediumInPlaceUpsize:
  {Re-read the info for this block}
  mov ebx, ExtractMediumAndLargeFlagsMask
  and ebx, [esi - 4]
  {Re-read the info for the next block}
  mov eax, [edi - 4]
  {Next block still free?}
  test al, IsFreeBlockFlag
  jz @NextMediumBlockChanged
  {Recalculate the next block size}
  and eax, DropMediumAndLargeFlagsMask
  {The available size including the next block}
  lea ebp, [eax + ecx]
  {Can the block still fit?}
  cmp edx, ebp
  ja @NextMediumBlockChanged
@DoMediumInPlaceUpsize:
  {Is the next block binnable?}
  cmp eax, MinimumMediumBlockSize
  {Remove the next block}
  jb @MediumInPlaceNoNextRemove
  mov eax, edi
  push ecx
  push edx
  call RemoveMediumFreeBlock
  pop edx
  pop ecx
@MediumInPlaceNoNextRemove:
  {Medium blocks grow a minimum of 25% in in-place upsizes}
  mov eax, ecx
  shr eax, 2
  add eax, ecx
  {Get the maximum of the requested size and the minimum growth size}
  xor edi, edi
  sub eax, edx
  adc edi, -1
  and eax, edi
  {Round up to the nearest block size granularity}
  lea eax, [eax + edx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
  and eax, -MediumBlockGranularity
  add eax, MediumBlockSizeOffset
  {Calculate the size of the second split}
  lea edx, [ebp + BlockHeaderSize]
  sub edx, eax
  {Does it fit?}
  ja @MediumInPlaceUpsizeSplit
  {Grab the whole block: Mark it as used in the block following it}
  and dword ptr [esi + ebp], not PreviousMediumBlockIsFreeFlag
  {The block size is the full available size plus header}
  add ebp, 4
  {Upsize done}
  jmp @MediumUpsizeInPlaceDone
  {Align branch target}
  nop
  nop
@MediumInPlaceUpsizeSplit:
  {Store the size of the second split as the second last dword}
  mov [esi + ebp - 4], edx
  {Set the second split header}
  lea edi, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [esi + eax - 4], edi
  mov ebp, eax
  cmp edx, MinimumMediumBlockSize
  jb @MediumUpsizeInPlaceDone
  add eax, esi
  call InsertMediumBlockIntoBin
@MediumUpsizeInPlaceDone:
  {Set the size and flags for this block}
  or ebp, ebx
  mov [esi - 4], ebp
  {Unlock the medium blocks}
  mov MediumBlocksLocked, False
  {Result = old pointer}
  mov eax, esi
@MediumBlockResizeDone2:
  {Restore registers}
  pop ebp
  pop edi
  pop esi
  pop ebx
  {Return}
  ret
  {Align branch target for @CannotUpsizeMediumBlockInPlace}
  nop
  nop
@NextMediumBlockChanged:
  {The next medium block changed while the medium blocks were being locked}
  mov MediumBlocksLocked, False
@CannotUpsizeMediumBlockInPlace:
  {Couldn't upsize in place. Grab a new block and move the data across:
   If we have to reallocate and move medium blocks, we grow by at
   least 25%}
  mov eax, ecx
  shr eax, 2
  add eax, ecx
  {Get the maximum of the requested size and the minimum growth size}
  xor edi, edi
  sub eax, edx
  adc edi, -1
  and eax, edi
  add eax, edx
  {Save the size to allocate}
  mov ebp, eax
  {Save the size to move across}
  mov edi, ecx
  {Get the block}
  push edx
  call SysGetMem
  pop edx
  {Success?}
  test eax, eax
  jz @MediumBlockResizeDone2
  {If it's a Large block - store the actual user requested size}
  cmp ebp, MaximumMediumBlockSize - BlockHeaderSize
  jbe @MediumUpsizeNotLarge
  mov [eax - 8], edx
@MediumUpsizeNotLarge:
  {Save the result}
  mov ebp, eax
  {Move the data across}
  mov edx, eax
  mov eax, esi
  mov ecx, edi
{$ifdef UseCustomVariableSizeMoveRoutines}
  call MoveX16LP
{$else}
  call Move
{$endif}
  {Free the old block}
  mov eax, esi
  call SysFreeMem
  {Restore the result}
  mov eax, ebp
  {Restore registers}
  pop ebp
  pop edi
  pop esi
  pop ebx
  {Return}
  ret
  {Align branch target}
  nop
@PossibleLargeBlock:
  {-----------------------Large block------------------------------}
  {Restore registers}
  pop esi
  pop ebx
  {Is this a valid large block?}
  test cl, IsFreeBlockFlag + IsMediumBlockFlag
  jz ReallocateLargeBlock
  {-----------------------Invalid block------------------------------}
  xor eax, eax
{$else}
{-----------------64-bit BASM SysReallocMem-----------------}
  .params 3
  .pushnv rbx
  .pushnv rsi
  .pushnv rdi
  .pushnv r14
  .pushnv r15
  {On entry: rcx = APointer; rdx = ANewSize}
  {Save the original pointer in rsi}
  mov rsi, rcx
  {Get the block header}
  mov rcx, [rcx - BlockHeaderSize]
  {Is it a small block?}
  test cl, IsFreeBlockFlag + IsMediumBlockFlag + IsLargeBlockFlag
  jnz @NotASmallBlock
  {-----------------------------------Small block-------------------------------------}
  {Get the block type in rbx}
  mov rbx, TSmallBlockPoolHeader[rcx].BlockType
  {Get the available size inside blocks of this type.}
  movzx ecx, TSmallBlockType[rbx].BlockSize
  sub ecx, BlockHeaderSize
  {Is it an upsize or a downsize?}
  cmp rcx, rdx
  jb @SmallUpsize
  {It's a downsize. Do we need to allocate a smaller block? Only if the new
   size is less than a quarter of the available size less
   SmallBlockDownsizeCheckAdder bytes}
  lea ebx, [edx * 4 + SmallBlockDownsizeCheckAdder]
  cmp ebx, ecx
  jb @NotSmallInPlaceDownsize
  {In-place downsize - return the original pointer}
  mov rax, rsi
  jmp @Done
@NotSmallInPlaceDownsize:
  {Save the requested size}
  mov rbx, rdx
  {Allocate a smaller block}
  mov rcx, rdx
  call SysGetMem
  {Allocated OK?}
  test rax, rax
  jz @Done
  {Move data across: count in r8}
  mov r8, rbx
  {Destination in edx}
  mov rdx, rax
  {Save the result in ebx}
  mov rbx, rax
  {Original pointer in ecx}
  mov rcx, rsi
  {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  call MoveX16LP
{$else}
  call System.Move
{$endif}
  {Free the original pointer}
  mov rcx, rsi
  call SysFreeMem
  {Return the pointer}
  mov rax, rbx
  jmp @Done
@SmallUpsize:
  {State: rsi = APointer, rdx = ANewSize, rcx = Current Block Size, rbx = Current Block Type}
  {This pointer is being reallocated to a larger block and therefore it is
   logical to assume that it may be enlarged again. Since reallocations are
   expensive, there is a minimum upsize percentage to avoid unnecessary
   future move operations.}
  {Small blocks always grow with at least 100% + SmallBlockUpsizeAdder bytes}
  lea ecx, [ecx + ecx + SmallBlockUpsizeAdder]
  {Save the requested size in rdi}
  mov rdi, rdx
  {New allocated size is the maximum of the requested size and the minimum
   upsize}
  xor rax, rax
  sub rcx, rdx
  adc rax, -1
  and rcx, rax
  add rcx, rdx
  {Allocate the new block}
  call SysGetMem
  {Allocated OK?}
  test rax, rax
  jz @Done
  {Do we need to store the requested size? Only large blocks store the
   requested size.}
  cmp rdi, MaximumMediumBlockSize - BlockHeaderSize
  jbe @NotSmallUpsizeToLargeBlock
  {Store the user requested size}
  mov [rax - 2 * BlockHeaderSize], rdi
@NotSmallUpsizeToLargeBlock:
  {Get the size to move across}
  movzx r8d, TSmallBlockType[rbx].BlockSize
  sub r8d, BlockHeaderSize
  {Move to the new block}
  mov rdx, rax
  {Save the result in edi}
  mov rdi, rax
  {Move from the old block}
  mov rcx, rsi
  {Move the data across}
{$ifdef UseCustomFixedSizeMoveRoutines}
  call TSmallBlockType[rbx].UpsizeMoveProcedure
{$else}
  call System.Move
{$endif}
  {Free the old pointer}
  mov rcx, rsi
  call SysFreeMem
  {Done}
  mov rax, rdi
  jmp @Done
@NotASmallBlock:
  {Is this a medium block or a large block?}
  test cl, IsFreeBlockFlag + IsLargeBlockFlag
  jnz @PossibleLargeBlock
  {-------------------------------Medium block--------------------------------------}
  {Status: rcx = Current Block Size + Flags, rsi = APointer,
   rdx = Requested Size}
  mov rbx, rcx
  {Drop the flags from the header}
  and ecx, DropMediumAndLargeFlagsMask
  {Get a pointer to the next block in rdi}
  lea rdi, [rsi + rcx]
  {Subtract the block header size from the old available size}
  sub ecx, BlockHeaderSize
  {Get the complete flags in ebx}
  and ebx, ExtractMediumAndLargeFlagsMask
  {Is it an upsize or a downsize?}
  cmp rdx, rcx
  ja @MediumBlockUpsize
  {Status: ecx = Current Block Size - BlockHeaderSize, bl = Current Block Flags,
   rdi = @Next Block, rsi = APointer, rdx = Requested Size}
  {Must be less than half the current size or we don't bother resizing.}
  lea r15, [rdx + rdx]
  cmp r15, rcx
  jb @MediumMustDownsize
@MediumNoResize:
  mov rax, rsi
  jmp @Done
@MediumMustDownsize:
  {In-place downsize? Balance the cost of moving the data vs. the cost of
   fragmenting the memory pool. Medium blocks in use may never be smaller
   than MinimumMediumBlockSize.}
  cmp edx, MinimumMediumBlockSize - BlockHeaderSize
  jae @MediumBlockInPlaceDownsize
  {The requested size is less than the minimum medium block size. If the
  requested size is less than the threshold value (currently a quarter of the
  minimum medium block size), move the data to a small block, otherwise shrink
  the medium block to the minimum allowable medium block size.}
  cmp edx, MediumInPlaceDownsizeLimit
  jb @MediumDownsizeRealloc
  {The request is for a size smaller than the minimum medium block size, but
   not small enough to justify moving data: Reduce the block size to the
   minimum medium block size}
  mov edx, MinimumMediumBlockSize - BlockHeaderSize
  {Is it already at the minimum medium block size?}
  cmp ecx, edx
  jna @MediumNoResize
@MediumBlockInPlaceDownsize:
  {Round up to the next medium block size}
  lea r15, [rdx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
  and r15, -MediumBlockGranularity
  add r15, MediumBlockSizeOffset
  {Get the size of the second split}
  add ecx, BlockHeaderSize
  sub ecx, r15d
  {Lock the medium blocks}
  lea r8, IsMultiThread
  cmp byte ptr [r8], False
  je @DoMediumInPlaceDownsize
@DoMediumLockForDownsize:
  {Lock the medium blocks}
  mov ebx, ecx
  call LockMediumBlocks
  mov ecx, ebx
  {Reread the flags - they may have changed before medium blocks could be
   locked.}
  mov rbx, ExtractMediumAndLargeFlagsMask
  and rbx, [rsi - BlockHeaderSize]
@DoMediumInPlaceDownsize:
  {Set the new size}
  or rbx, r15
  mov [rsi - BlockHeaderSize], rbx
  {Get the second split size in ebx}
  mov ebx, ecx
  {Is the next block in use?}
  mov rdx, [rdi - BlockHeaderSize]
  test dl, IsFreeBlockFlag
  jnz @MediumDownsizeNextBlockFree
  {The next block is in use: flag its previous block as free}
  or rdx, PreviousMediumBlockIsFreeFlag
  mov [rdi - BlockHeaderSize], rdx
  jmp @MediumDownsizeDoSplit
@MediumDownsizeNextBlockFree:
  {The next block is free: combine it}
  mov rcx, rdi
  and rdx, DropMediumAndLargeFlagsMask
  add rbx, rdx
  add rdi, rdx
  cmp edx, MinimumMediumBlockSize
  jb @MediumDownsizeDoSplit
  call RemoveMediumFreeBlock
@MediumDownsizeDoSplit:
  {Store the trailing size field}
  mov [rdi - 2 * BlockHeaderSize], rbx
  {Store the free part's header}
  lea rcx, [rbx + IsMediumBlockFlag + IsFreeBlockFlag];
  mov [rsi + r15 - BlockHeaderSize], rcx
  {Bin this free block}
  cmp rbx, MinimumMediumBlockSize
  jb @MediumBlockDownsizeDone
  lea rcx, [rsi + r15]
  mov rdx, rbx
  call InsertMediumBlockIntoBin
@MediumBlockDownsizeDone:
  {Unlock the medium blocks}
  lea rax, MediumBlocksLocked
  mov byte ptr [rax], False
  {Result = old pointer}
  mov rax, rsi
  jmp @Done
@MediumDownsizeRealloc:
  {Save the requested size}
  mov rdi, rdx
  mov rcx, rdx
  {Allocate the new block}
  call SysGetMem
  test rax, rax
  jz @Done
  {Save the result}
  mov r15, rax
  mov rdx, rax
  mov rcx, rsi
  mov r8, rdi
  {Move the data across}
{$ifdef UseCustomVariableSizeMoveRoutines}
  call MoveX16LP
{$else}
  call System.Move
{$endif}
  mov rcx, rsi
  call SysFreeMem
  {Return the result}
  mov rax, r15
  jmp @Done
@MediumBlockUpsize:
  {Status: ecx = Current Block Size - BlockHeaderSize, bl = Current Block Flags,
   rdi = @Next Block, rsi = APointer, rdx = Requested Size}
  {Can we do an in-place upsize?}
  mov rax, [rdi - BlockHeaderSize]
  test al, IsFreeBlockFlag
  jz @CannotUpsizeMediumBlockInPlace
  {Get the total available size including the next block}
  and rax, DropMediumAndLargeFlagsMask
  {r15 = total available size including the next block (excluding the header)}
  lea r15, [rax + rcx]
  {Can the block fit?}
  cmp rdx, r15
  ja @CannotUpsizeMediumBlockInPlace
  {The next block is free and there is enough space to grow this
   block in place.}
  lea r8, IsMultiThread
  cmp byte ptr [r8], False
  je @DoMediumInPlaceUpsize
@DoMediumLockForUpsize:
  {Lock the medium blocks.}
  mov rbx, rcx
  mov r15, rdx
  call LockMediumBlocks
  mov rcx, rbx
  mov rdx, r15
  {Re-read the info for this block (since it may have changed before the medium
   blocks could be locked)}
  mov rbx, ExtractMediumAndLargeFlagsMask
  and rbx, [rsi - BlockHeaderSize]
  {Re-read the info for the next block}
  mov rax, [rdi - BlockheaderSize]
  {Next block still free?}
  test al, IsFreeBlockFlag
  jz @NextMediumBlockChanged
  {Recalculate the next block size}
  and eax, DropMediumAndLargeFlagsMask
  {The available size including the next block}
  lea r15, [rax + rcx]
  {Can the block still fit?}
  cmp rdx, r15
  ja @NextMediumBlockChanged
@DoMediumInPlaceUpsize:
  {Is the next block binnable?}
  cmp eax, MinimumMediumBlockSize
  {Remove the next block}
  jb @MediumInPlaceNoNextRemove
  mov r14, rcx
  mov rcx, rdi
  mov rdi, rdx
  call RemoveMediumFreeBlock
  mov rcx, r14
  mov rdx, rdi
@MediumInPlaceNoNextRemove:
  {Medium blocks grow a minimum of 25% in in-place upsizes}
  mov eax, ecx
  shr eax, 2
  add eax, ecx
  {Get the maximum of the requested size and the minimum growth size}
  xor edi, edi
  sub eax, edx
  adc edi, -1
  and eax, edi
  {Round up to the nearest block size granularity}
  lea eax, [eax + edx + BlockHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset]
  and eax, -MediumBlockGranularity
  add eax, MediumBlockSizeOffset
  {Calculate the size of the second split}
  lea rdx, [r15 + BlockHeaderSize]
  sub edx, eax
  {Does it fit?}
  ja @MediumInPlaceUpsizeSplit
  {Grab the whole block: Mark it as used in the block following it}
  and qword ptr [rsi + r15], not PreviousMediumBlockIsFreeFlag
  {The block size is the full available size plus header}
  add r15, BlockHeaderSize
  {Upsize done}
  jmp @MediumUpsizeInPlaceDone
@MediumInPlaceUpsizeSplit:
  {Store the size of the second split as the second last dword}
  mov [rsi + r15 - BlockHeaderSize], rdx
  {Set the second split header}
  lea edi, [edx + IsMediumBlockFlag + IsFreeBlockFlag]
  mov [rsi + rax - BlockHeaderSize], rdi
  mov r15, rax
  cmp edx, MinimumMediumBlockSize
  jb @MediumUpsizeInPlaceDone
  lea rcx, [rsi + rax]
  call InsertMediumBlockIntoBin
@MediumUpsizeInPlaceDone:
  {Set the size and flags for this block}
  or r15, rbx
  mov [rsi - BlockHeaderSize], r15
  {Unlock the medium blocks}
  lea rax, MediumBlocksLocked
  mov byte ptr [rax], False
  {Result = old pointer}
  mov rax, rsi
  jmp @Done
@NextMediumBlockChanged:
  {The next medium block changed while the medium blocks were being locked}
  lea rax, MediumBlocksLocked
  mov byte ptr [rax], False
@CannotUpsizeMediumBlockInPlace:
  {Couldn't upsize in place. Grab a new block and move the data across:
   If we have to reallocate and move medium blocks, we grow by at
   least 25%}
  mov eax, ecx
  shr eax, 2
  add eax, ecx
  {Get the maximum of the requested size and the minimum growth size}
  xor rdi, rdi
  sub rax, rdx
  adc rdi, -1
  and rax, rdi
  add rax, rdx
  {Save the size to allocate}
  mov r15, rax
  {Save the size to move across}
  mov edi, ecx
  {Save the requested size}
  mov rbx, rdx
  {Get the block}
  mov rcx, rax
  call SysGetMem
  mov rdx, rbx
  {Success?}
  test eax, eax
  jz @Done
  {If it's a Large block - store the actual user requested size}
  cmp r15, MaximumMediumBlockSize - BlockHeaderSize
  jbe @MediumUpsizeNotLarge
  mov [rax - 2 * BlockHeaderSize], rdx
@MediumUpsizeNotLarge:
  {Save the result}
  mov r15, rax
  {Move the data across}
  mov rdx, rax
  mov rcx, rsi
  mov r8, rdi
{$ifdef UseCustomVariableSizeMoveRoutines}
  call MoveX16LP
{$else}
  call System.Move
{$endif}
  {Free the old block}
  mov rcx, rsi
  call SysFreeMem
  {Restore the result}
  mov rax, r15
  jmp @Done
@PossibleLargeBlock:
  {-----------------------Large block------------------------------}
  {Is this a valid large block?}
  test cl, IsFreeBlockFlag + IsMediumBlockFlag
  jnz @Error
  mov rcx, rsi
  call ReallocateLargeBlock
  jmp @Done
  {-----------------------Invalid block------------------------------}
@Error:
  xor eax, eax
@Done:
{$endif}
end;
{$endif}

{Allocates a block and fills it with zeroes}
{$ifdef UsePascalCode}
function SysAllocMem(Size: NativeInt): Pointer;
begin
  Result := SysGetMem(Size);
  {Large blocks are already zero filled}
  if (Result <> nil) and (Size <= (MaximumMediumBlockSize - BlockHeaderSize)) then
    FillChar(Result^, Size, 0);
end;
{$else}
function SysAllocMem(Size: NativeInt): Pointer;
asm
{$ifdef CPU386}
{---------------32-bit BASM SysAllocMem---------------}
  push ebx
  {Get the size rounded down to the previous multiple of 4 into ebx}
  lea ebx, [eax - 1]
  and ebx, -4
  {Get the block}
  call SysGetMem
  {Could a block be allocated? ecx = 0 if yes, $ffffffff if no}
  cmp eax, 1
  sbb ecx, ecx
  {Point edx to the last dword}
  lea edx, [eax + ebx]
  {ebx = $ffffffff if no block could be allocated, otherwise size rounded down
   to previous multiple of 4}
  or ebx, ecx
  {Large blocks are already zero filled}
  cmp ebx, MaximumMediumBlockSize - BlockHeaderSize
  jae @Done
  {Make the counter negative based}
  neg ebx
  {Load zero into st(0)}
  fldz
  {Clear groups of 8 bytes. Block sizes are always four less than a multiple
   of 8, with a minimum of 12 bytes}
@FillLoop:
  fst qword ptr [edx + ebx]
  add ebx, 8
  js @FillLoop
  {Clear the last four bytes}
  mov [edx], ecx
  {Clear st(0)}
  ffree st(0)
  {Correct the stack top}
  fincstp
@Done:
  pop ebx
{$else}
{---------------64-bit BASM SysAllocMem---------------}
  .params 1
  .pushnv rbx
  {Get the size rounded down to the previous multiple of SizeOf(Pointer) into
   ebx}
  lea rbx, [rcx - 1]
  and rbx, -8
  {Get the block}
  call SysGetMem
  {Could a block be allocated? rcx = 0 if yes, -1 if no}
  cmp rax, 1
  sbb rcx, rcx
  {Point rdx to the last dword}
  lea rdx, [rax + rbx]
  {rbx = -1 if no block could be allocated, otherwise size rounded down
   to previous multiple of 8. If rbx = 0 then the block size is 1..8 bytes and
   the SSE2 based clearing loop should not be used (since it clears 16 bytes per
   iteration).}
  or rbx, rcx
  jz @ClearLastQWord
  {Large blocks are already zero filled}
  cmp rbx, MaximumMediumBlockSize - BlockHeaderSize
  jae @Done
  {Make the counter negative based}
  neg rbx
  {Load zero into xmm0}
  pxor xmm0, xmm0
  {Clear groups of 16 bytes. Block sizes are always 8 less than a multiple of
   16.}
@FillLoop:
  movdqa [rdx + rbx], xmm0
  add rbx, 16
  js @FillLoop
  {Clear the last 8 bytes}
@ClearLastQWord:
  xor rcx, rcx
  mov [rdx], rcx
@Done:
{$endif}
end;
{$endif}

{----------Leak Checking and State Reporting Support Functions------------}

{Advances to the next medium block. Returns nil if the end of the medium block
 pool has been reached}
function NextMediumBlock(APMediumBlock: Pointer): Pointer;
var
  LBlockSize: Cardinal;
begin
  {Get the size of this block}
  LBlockSize := PNativeUInt(PByte(APMediumBlock) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask;
  {Advance the pointer}
  Result := Pointer(PByte(APMediumBlock) + LBlockSize);
  {Is the next block the end of medium pool marker?}
  LBlockSize := PNativeUInt(PByte(Result) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask;
  if LBlockSize = 0 then
    Result := nil;
end;

{Gets the first medium block in the medium block pool}
function GetFirstMediumBlockInPool(APMediumBlockPoolHeader: PMediumBlockPoolHeader): Pointer;
begin
  if (MediumSequentialFeedBytesLeft = 0)
    or (UIntPtr(LastSequentiallyFedMediumBlock) < UIntPtr(APMediumBlockPoolHeader))
    or (UIntPtr(LastSequentiallyFedMediumBlock) > UIntPtr(APMediumBlockPoolHeader) + MediumBlockPoolSize) then
  begin
    Result := Pointer(PByte(APMediumBlockPoolHeader) + MediumBlockPoolHeaderSize);
  end
  else
  begin
    {Is the sequential feed pool empty?}
    if MediumSequentialFeedBytesLeft <> MediumBlockPoolSize - MediumBlockPoolHeaderSize then
      Result := LastSequentiallyFedMediumBlock
    else
      Result := nil;
  end;
end;

{Gets the first and last block pointer for a small block pool}
procedure GetFirstAndLastSmallBlockInPool(APSmallBlockPool: PSmallBlockPoolHeader;
  var AFirstPtr, ALastPtr: Pointer);
var
  LBlockSize: Cardinal;
begin
  {Get the pointer to the first block}
  AFirstPtr := Pointer(PByte(APSmallBlockPool) + SmallBlockPoolHeaderSize);
  {Get a pointer to the last block}
  if (APSmallBlockPool.BlockType.CurrentSequentialFeedPool <> APSmallBlockPool)
    or (UIntPtr(APSmallBlockPool.BlockType.NextSequentialFeedBlockAddress) > UIntPtr(APSmallBlockPool.BlockType.MaxSequentialFeedBlockAddress)) then
  begin
    {Not the sequential feed - point to the end of the block}
    LBlockSize := PNativeUInt(PByte(APSmallBlockPool) - BlockHeaderSize)^ and DropMediumAndLargeFlagsMask;
    ALastPtr := Pointer(PByte(APSmallBlockPool) + LBlockSize - APSmallBlockPool.BlockType.BlockSize);
  end
  else
  begin
    {The sequential feed pool - point to before the next sequential feed block}
    ALastPtr := Pointer(PByte(APSmallBlockPool.BlockType.NextSequentialFeedBlockAddress) - 1);
  end;
end;

{--------------------Memory Leak Checking and Reporting-------------------}

{$ifdef IncludeMemoryLeakTrackingCode}
{Converts a cardinal to string at the buffer location, returning the new
 buffer position.}
function NativeUIntToStrBuf(ANum: NativeUInt; APBuffer: _PAnsiChr): _PAnsiChr;
const
  MaxDigits = 20;
var
  LDigitBuffer: array[0..MaxDigits - 1] of _AnsiChr;
  LCount: Cardinal;
  LDigit: NativeUInt;
begin
  {Generate the digits in the local buffer}
  LCount := 0;
  repeat
    LDigit := ANum;
    ANum := ANum div 10;
    LDigit := LDigit - ANum * 10;
    Inc(LCount);
    LDigitBuffer[MaxDigits - LCount] := _AnsiChr(Ord('0') + LDigit);
  until ANum = 0;
  {Copy the digits to the output buffer and advance it}
  System.Move(LDigitBuffer[MaxDigits - LCount], APBuffer^, LCount);
  Result := APBuffer + LCount;
end;

{Appends the source text to the destination and returns the new destination
 position}
function AppendStringToBuffer(const ASource, ADestination: _PAnsiChr; ACount: Cardinal): _PAnsiChr;
begin
  System.Move(ASource^, ADestination^, ACount);
  Result := Pointer(PByte(ADestination) + ACount);
end;

{Appends the name of the class to the destination buffer and returns the new
 destination position}
function AppendClassNameToBuffer(AClass: TClass; ADestination: _PAnsiChr): _PAnsiChr;
var
  LPClassName: _PShortStr;
begin
  {Get a pointer to the class name}
  if AClass <> nil then
  begin
    LPClassName := _PShortStr(PPointer(PByte(AClass) + vmtClassName)^);
    {Append the class name}
    Result := AppendStringToBuffer(@LPClassName^[1], ADestination, Length(LPClassName^));
  end
  else
  begin
    Result := AppendStringToBuffer(UnknownClassNameMsg, ADestination, Length(UnknownClassNameMsg));
  end;
end;

{Returns the class for a memory block. Returns nil if it is not a valid class}
function GetObjectClass(APointer: Pointer): TClass;
var
  LMemInfo: TMemoryBasicInformation;

  {Checks whether the given address is a valid address for a VMT entry.}
  function IsValidVMTAddress(APAddress: Pointer): Boolean;
  begin
    {Do some basic pointer checks: Must be dword aligned and beyond 64K}
    if (UIntPtr(APAddress) > 65535)
      and (UIntPtr(APAddress) and 3 = 0) then
    begin
      {Do we need to recheck the virtual memory?}
      if (UIntPtr(LMemInfo.BaseAddress) > UIntPtr(APAddress))
        or ((UIntPtr(LMemInfo.BaseAddress) + NativeUInt(LMemInfo.RegionSize)) < (UIntPtr(APAddress) + SizeOf(Pointer))) then
      begin
        {Get the VM status for the pointer}
        LMemInfo.RegionSize := 0;
        VirtualQuery(APAddress,  LMemInfo, SizeOf(LMemInfo));
      end;
      {Check the readability of the memory address}
      Result := (NativeUInt(LMemInfo.RegionSize) >= SizeOf(Pointer))
        and (LMemInfo.State = MEM_COMMIT)
        and (LMemInfo.Protect and (PAGE_READONLY or PAGE_READWRITE
          or PAGE_EXECUTE or PAGE_EXECUTE_READ or PAGE_EXECUTE_READWRITE or PAGE_EXECUTE_WRITECOPY) <> 0)
        and (LMemInfo.Protect and PAGE_GUARD = 0);
    end
    else
      Result := False;
  end;

  {Returns true if AClassPointer points to a class VMT}
  function InternalIsValidClass(AClassPointer: Pointer; ADepth: Integer = 0): Boolean;
  var
    LParentClassSelfPointer: PPointer;
  begin
    {Check that the self pointer as well as parent class self pointer addresses
     are valid}
    if (ADepth < 1000)
      and IsValidVMTAddress(Pointer(PByte(AClassPointer) + vmtSelfPtr))
      and IsValidVMTAddress(Pointer(PByte(AClassPointer) + vmtParent)) then
    begin
      {Get a pointer to the parent class' self pointer}
      LParentClassSelfPointer := PPointer(PByte(AClassPointer) + vmtParent)^;
      {Check that the self pointer as well as the parent class is valid}
      Result := (PPointer(PByte(AClassPointer) + vmtSelfPtr)^ = AClassPointer)
        and ((LParentClassSelfPointer = nil)
          or (IsValidVMTAddress(LParentClassSelfPointer)
            and InternalIsValidClass(LParentClassSelfPointer^, ADepth + 1)));
    end
    else
      Result := False;
  end;

begin
  {Get the class pointer from the (suspected) object}
  Result := TClass(PNativeUInt(APointer)^);
  {No VM info yet}
  LMemInfo.RegionSize := 0;
  {Check the block}
  if not InternalIsValidClass(Pointer(Result), 0) then
    Result := nil;
end;
{$endif}

{$ifdef IncludeMemoryLeakTrackingCode}
{Locks the expected leaks. Returns false if the list could not be allocated.}
function LockExpectedMemoryLeaksList: Boolean;
begin
  {Lock the expected leaks list}
  if IsMultiThread then
  begin
    while LockCmpxchg(0, 1, @ExpectedMemoryLeaksListLocked) <> 0 do
    begin
      if not NeverSleepOnMMThreadContention then
      begin
        Sleep(InitialSleepTime);
        if LockCmpxchg(0, 1, @ExpectedMemoryLeaksListLocked) = 0 then
          Break;
        Sleep(AdditionalSleepTime);
      end;
    end;
  end;
  {Allocate the list if it does not exist}
  if ExpectedMemoryLeaks = nil then
    ExpectedMemoryLeaks := VirtualAlloc(nil, ExpectedMemoryLeaksListSize, MEM_COMMIT, PAGE_READWRITE);
  {Done}
  Result := ExpectedMemoryLeaks <> nil;
end;
{$endif}

{Registers expected memory leaks. Returns True on success. The list of leaked
 blocks is limited, so failure is possible if the list is full.}
function SysRegisterExpectedMemoryLeak(P: Pointer): Boolean;
begin
{$ifdef IncludeMemoryLeakTrackingCode}
  if LockExpectedMemoryLeaksList and
    (ExpectedMemoryLeaks.NumExpectedLeaks < High(ExpectedMemoryLeaks.ExpectedLeaks)) then
  begin
    ExpectedMemoryLeaks.ExpectedLeaks[ExpectedMemoryLeaks.NumExpectedLeaks] := P;
    Inc(ExpectedMemoryLeaks.NumExpectedLeaks);
    Result := True;
  end
  else
    Result := False;
  ExpectedMemoryLeaksListLocked := False;
{$else}
  Result := False;
{$endif}
end;

function SysUnregisterExpectedMemoryLeak(P: Pointer): Boolean;
{$ifdef IncludeMemoryLeakTrackingCode}
var
  LIndex: Integer;
{$endif}
begin
  {Default to error}
  Result := False;
{$ifdef IncludeMemoryLeakTrackingCode}
  if (ExpectedMemoryleaks <> nil) and LockExpectedMemoryLeaksList then
  begin
    for LIndex := 0 to ExpectedMemoryleaks.NumExpectedLeaks - 1 do
    begin
      if ExpectedMemoryleaks.ExpectedLeaks[LIndex] = P then
      begin
        ExpectedMemoryleaks.ExpectedLeaks[LIndex] :=
          ExpectedMemoryleaks.ExpectedLeaks[ExpectedMemoryleaks.NumExpectedLeaks - 1];
        Dec(ExpectedMemoryleaks.NumExpectedLeaks);
        Result := True;
        Break;
      end;
    end;
    ExpectedMemoryLeaksListLocked := False;
  end;
{$endif}
end;

{$ifdef IncludeMemoryLeakTrackingCode}
{Checks for memory leaks on shutdown}
procedure ScanForMemoryLeaks;
type
  {Leaked class type}
  TLeakedClass = record
    ClassPointer: TClass;
    NumLeaks: Cardinal;
  end;
  TLeakedClasses = array[0..255] of TLeakedClass;
  PLeakedClasses = ^TLeakedClasses;
  {Leak statistics for a small block type}
  TSmallBlockLeaks = array[0..NumSmallBlockTypes - 1] of TLeakedClasses;
  {A leaked medium or large block}
  TMediumAndLargeBlockLeaks = array[0..4095] of NativeUInt;
var
  {The leaked classes for small blocks}
  LSmallBlockLeaks: TSmallBlockLeaks;
  LMediumAndLargeBlockLeaks: TMediumAndLargeBlockLeaks;
  LNumMediumAndLargeLeaks: Integer;
  LPLargeBlock: PLargeBlockHeader;
  LLeakMessage: array[0..32767] of _AnsiChr;
  LMsgPtr: _PAnsiChr;
  LExpectedLeaksOnly, LSmallLeakHeaderAdded, LBlockSizeHeaderAdded: Boolean;
  LLargeBlockSize: NativeUInt;
  LBlockTypeInd, LMediumBlockSize, LClassInd, LPreviousBlockSize,
    LThisBlockSize, LBlockInd: Cardinal;
  LPMediumBlock: Pointer;
  LPMediumBlockPoolHeader: PMediumBlockPoolHeader;
  LMediumBlockHeader: NativeUInt;

  {Checks the small block pool for leaks.}
  procedure CheckSmallBlockPoolForLeaks(APSmallBlockPool: PSmallBlockPoolHeader);
  type
    {Have to redeclare StrRec here, because it is not in the interface section of system.pas}
    PStrRec = ^StrRec;
    StrRec = packed record
    {$IF defined(CPUX64)}
      _Padding: LongInt; // Make 16 byte align for payload..
    {$ENDIF}
      codePage: Word;
      elemSize: Word;
      refCnt: Longint;
      length: Longint;
    end;
  var
    LLeakedClass: TClass;
    LCharInd, LClassIndex, LStringLength, LElemSize: Integer;
    LPAnsiStr: _PAnsiChr;
    LPUniStr: PWideChar;
    LPossibleString: Boolean;
    LCurPtr, LEndPtr: Pointer;
    LBlockTypeIndex: Cardinal;
    LPLeakedClasses: PLeakedClasses;
  begin
    {Get the block type index}
    LBlockTypeIndex := (UIntPtr(APSmallBlockPool.BlockType) - UIntPtr(@SmallBlockTypes[0])) div SizeOf(TSmallBlockType);
    LPLeakedClasses := @LSmallBlockLeaks[LBlockTypeIndex];
    {Get the first and last pointer for the pool}
    GetFirstAndLastSmallBlockInPool(APSmallBlockPool, LCurPtr, LEndPtr);
    {Step through all blocks}
    while UIntPtr(LCurPtr) <= UIntPtr(LEndPtr) do
    begin
      {Is this block an unexpected leak?}
      if ((PNativeUInt(PByte(LCurPtr) - BlockHeaderSize)^ and IsFreeBlockFlag) = 0)
        and (not SysUnregisterExpectedMemoryLeak(LCurPtr)) then
      begin
        LExpectedLeaksOnly := False;
        {Default to an unknown block}
        LClassIndex := 0;
        {Get the class contained by the block}
        LLeakedClass := GetObjectClass(LCurPtr);
        {Not a class? -> is it perhaps a string?}
        if LLeakedClass = nil then
        begin
          {Reference count < 256}
          if PStrRec(LCurPtr).refCnt < 256 then
          begin
            {Get the string length and element size}
            LStringLength := PStrRec(LCurPtr).length;
            {$if RTLVersion >= 20}
            LElemSize := PStrRec(LCurPtr).elemSize;
            {$else}
            LElemSize := 1;
            {$endif}
            {Valid element size?}
            if (LElemSize = 1) or (LElemSize = 2) then
            begin
              {Does the string fit?}
              if (LStringLength > 0)
                and ((APSmallBlockPool.BlockType.BlockSize - BlockHeaderSize - SizeOf(StrRec)) div LElemSize > LStringLength) then
              begin
                {It is possibly a string}
                LPossibleString := True;
                {Check for no characters < #32. If there are, then it is
                 probably not a string.}
                if LElemSize = 1 then
                begin
                  {Check that all characters are >= #32}
                  LPAnsiStr := _PAnsiChr(PByte(LCurPtr) + SizeOf(StrRec));
                  for LCharInd := 1 to LStringLength do
                  begin
                    LPossibleString := LPossibleString and (LPAnsiStr^ >= #32);
                    Inc(LPAnsiStr);
                  end;
                  {Must have a trailing #0}
                  if LPossibleString and (LPAnsiStr^ = #0) then
                    LClassIndex := 1;
                end
                else
                begin
                  {Check that all characters are >= #32}
                  LPUniStr := PWideChar(PByte(LCurPtr) + SizeOf(StrRec));
                  for LCharInd := 1 to LStringLength do
                  begin
                    LPossibleString := LPossibleString and (LPUniStr^ >= #32);
                    Inc(LPUniStr);
                  end;
                  {Must have a trailing #0}
                  if LPossibleString and (LPUniStr^ = #0) then
                    LClassIndex := 2;
                end;
              end;
            end;
          end;
        end
        else
        begin
          {Class index 3 and up are actual classes}
          LClassIndex := 3;
          while LClassIndex <= High(TLeakedClasses) do
          begin
            if (LPLeakedClasses[LClassIndex].ClassPointer = LLeakedClass)
              or (LPLeakedClasses[LClassIndex].ClassPointer = nil) then
            begin
              Break;
            end;
            Inc(LClassIndex);
          end;
          if LClassIndex <= High(TLeakedClasses) then
            LPLeakedClasses[LClassIndex].ClassPointer := LLeakedClass
          else
            LClassIndex := 0;
        end;
        {Add to the number of leaks for the class}
        Inc(LPLeakedClasses[LClassIndex].NumLeaks);
      end;
      {Next block}
      Inc(PByte(LCurPtr), APSmallBlockPool.BlockType.BlockSize);
    end;
  end;

begin
  {Clear the leak arrays}
  FillChar(LSmallBlockLeaks, SizeOf(LSmallBlockLeaks), 0);
  FillChar(LMediumAndLargeBlockLeaks, SizeOf(LMediumAndLargeBlockLeaks), 0);
  {Step through all the medium block pools}
  LNumMediumAndLargeLeaks := 0;
  {No unexpected leaks so far}
  LExpectedLeaksOnly := True;
  {Step through all the medium block pools}
  LPMediumBlockPoolHeader := MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
  while LPMediumBlockPoolHeader <> @MediumBlockPoolsCircularList do
  begin
    LPMediumBlock := GetFirstMediumBlockInPool(LPMediumBlockPoolHeader);
    while LPMediumBlock <> nil do
    begin
      LMediumBlockHeader := PNativeUInt(PByte(LPMediumBlock) - BlockHeaderSize)^;
      {Is the block in use?}
      if LMediumBlockHeader and IsFreeBlockFlag = 0 then
      begin
        if (LMediumBlockHeader and IsSmallBlockPoolInUseFlag) <> 0 then
        begin
          {Get all the leaks for the small block pool}
          CheckSmallBlockPoolForLeaks(LPMediumBlock);
        end
        else
        begin
          if LNumMediumAndLargeLeaks < Length(LMediumAndLargeBlockLeaks) then
          begin
            LMediumBlockSize := (LMediumBlockHeader and DropMediumAndLargeFlagsMask) - BlockHeaderSize;
            {Is it an expected leak?}
            if not SysUnregisterExpectedMemoryLeak(LPMediumBlock) then
            begin
              LExpectedLeaksOnly := False;
              {Add the leak to the list}
              LMediumAndLargeBlockLeaks[LNumMediumAndLargeLeaks] := LMediumBlockSize;
              Inc(LNumMediumAndLargeLeaks);
            end;
          end;
        end;
      end;
      {Next medium block}
      LPMediumBlock := NextMediumBlock(LPMediumBlock);
    end;
    {Get the next medium block pool}
    LPMediumBlockPoolHeader := LPMediumBlockPoolHeader.NextMediumBlockPoolHeader;
  end;
  {Get all leaked large blocks}
  LPLargeBlock := LargeBlocksCircularList.NextLargeBlockHeader;
  while (LPLargeBlock <> @LargeBlocksCircularList)
    and (LNumMediumAndLargeLeaks < Length(LMediumAndLargeBlockLeaks)) do
  begin
    {Is it an expected leak?}
    if not SysUnregisterExpectedMemoryLeak(Pointer(PByte(LPLargeBlock) + LargeBlockHeaderSize)) then
    begin
      {Add the leak}
      LExpectedLeaksOnly := False;
      LLargeBlockSize := (LPLargeBlock.BlockSizeAndFlags and DropMediumAndLargeFlagsMask)
        - BlockHeaderSize - LargeBlockHeaderSize;
      LMediumAndLargeBlockLeaks[LNumMediumAndLargeLeaks] := LLargeBlockSize;
      Inc(LNumMediumAndLargeLeaks);
    end;
    {Get the next large block}
    LPLargeBlock := LPLargeBlock.NextLargeBlockHeader;
  end;
  {Display the leak message if required}
  if not LExpectedLeaksOnly then
  begin
    {Small leak header has not been added}
    LSmallLeakHeaderAdded := False;
    LPreviousBlockSize := 0;
    {Set up the leak message header so long}
    LMsgPtr := AppendStringToBuffer(LeakMessageHeader, @LLeakMessage[0], Length(LeakMessageHeader));
    {Step through all the small block types}
    for LBlockTypeInd := 0 to NumSmallBlockTypes - 1 do
    begin
      LThisBlockSize := SmallBlockTypes[LBlockTypeInd].BlockSize - BlockHeaderSize;
      LBlockSizeHeaderAdded := False;
      {Any leaks?}
      for LClassInd := High(LSmallBlockLeaks[LBlockTypeInd]) downto 0 do
      begin
        {Is there still space in the message buffer? Reserve space for the message
         footer.}
        if LMsgPtr > @LLeakMessage[High(LLeakMessage) - 2048] then
          Break;
        {Check the count}
        if LSmallBlockLeaks[LBlockTypeInd][LClassInd].NumLeaks > 0 then
        begin
          {Need to add the header?}
          if not LSmallLeakHeaderAdded then
          begin
            LMsgPtr := AppendStringToBuffer(SmallLeakDetail, LMsgPtr, Length(SmallLeakDetail));
            LSmallLeakHeaderAdded := True;
          end;
          {Need to add the size header?}
          if not LBlockSizeHeaderAdded then
          begin
            LMsgPtr^ := #13;
            Inc(LMsgPtr);
            LMsgPtr^ := #10;
            Inc(LMsgPtr);
            LMsgPtr := NativeUIntToStrBuf(LPreviousBlockSize + 1, LMsgPtr);
            LMsgPtr^ := ' ';
            Inc(LMsgPtr);
            LMsgPtr^ := '-';
            Inc(LMsgPtr);
            LMsgPtr^ := ' ';
            Inc(LMsgPtr);
            LMsgPtr := NativeUIntToStrBuf(LThisBlockSize, LMsgPtr);
            LMsgPtr := AppendStringToBuffer(BytesMessage, LMsgPtr, Length(BytesMessage));
            LBlockSizeHeaderAdded := True;
          end
          else
          begin
            LMsgPtr^ := ',';
            Inc(LMsgPtr);
            LMsgPtr^ := ' ';
            Inc(LMsgPtr);
          end;
          {Show the count}
          case LClassInd of
            {Unknown}
            0:
            begin
              LMsgPtr := AppendStringToBuffer(UnknownClassNameMsg, LMsgPtr, Length(UnknownClassNameMsg));
            end;
            {AnsiString}
            1:
            begin
              LMsgPtr := AppendStringToBuffer(AnsiStringBlockMessage, LMsgPtr, Length(AnsiStringBlockMessage));
            end;
            {UnicodeString}
            2:
            begin
              LMsgPtr := AppendStringToBuffer(UnicodeStringBlockMessage, LMsgPtr, Length(UnicodeStringBlockMessage));
            end;
            {Classes}
          else
            begin
              LMsgPtr := AppendClassNameToBuffer(LSmallBlockLeaks[LBlockTypeInd][LClassInd].ClassPointer, LMsgPtr);
            end;
          end;
          {Add the count}
          LMsgPtr^ := ' ';
          Inc(LMsgPtr);
          LMsgPtr^ := 'x';
          Inc(LMsgPtr);
          LMsgPtr^ := ' ';
          Inc(LMsgPtr);
          LMsgPtr := NativeUIntToStrBuf(LSmallBlockLeaks[LBlockTypeInd][LClassInd].NumLeaks, LMsgPtr);
        end;
      end;
      {If the minimum block alignment is 16 bytes, then disregard 8-byte
       aligned sizes in the calculation of the starting size for the next block
       type. Note: Under 32-bit it is possible for there to be 8-byte aligned
       leaks if the minimum alignment was set to 16 bytes after the leaked
       blocks were allocated.}
      if LBlockSizeHeaderAdded
        or (MinimumBlockAlignment = mba8Byte)
        or ((LThisBlockSize + BlockHeaderSize) and 15 = 0) then
      begin
        LPreviousBlockSize := LThisBlockSize;
      end;
    end;
    {Add the medium/large block leak message}
    if LNumMediumAndLargeLeaks > 0 then
    begin
      {Any non-small leaks?}
      if LSmallLeakHeaderAdded then
      begin
        LMsgPtr^ := #13;
        Inc(LMsgPtr);
        LMsgPtr^ := #10;
        Inc(LMsgPtr);
        LMsgPtr^ := #13;
        Inc(LMsgPtr);
        LMsgPtr^ := #10;
        Inc(LMsgPtr);
      end;
      {Add the medium/large block leak message}
      LMsgPtr := AppendStringToBuffer(LargeLeakDetail, LMsgPtr, Length(LargeLeakDetail));
      {List all the blocks}
      for LBlockInd := 0 to LNumMediumAndLargeLeaks - 1 do
      begin
        if LBlockInd <> 0 then
        begin
          LMsgPtr^ := ',';
          Inc(LMsgPtr);
          LMsgPtr^ :=  ' ';
          Inc(LMsgPtr);
        end;
        LMsgPtr := NativeUIntToStrBuf(LMediumAndLargeBlockLeaks[LBlockInd], LMsgPtr);
        {Is there still space in the message buffer? Reserve space for the
         message footer.}
        if LMsgPtr > @LLeakMessage[High(LLeakMessage) - 2048] then
          Break;
      end;
    end;
    {Set the message footer}
    AppendStringToBuffer(LeakMessageFooter, LMsgPtr, Length(LeakMessageFooter));
    {Show the message}
    MessageBoxA(0, LLeakMessage, LeakMessageTitle,
      MB_OK or MB_ICONERROR or MB_TASKMODAL);
  end;
end;
{$endif}

{-------------Memory Manager and Memory Usage Stats Reporting-------------}

{Returns statistics about the current state of the memory manager}
procedure GetMemoryManagerState(var AMemoryManagerState: TMemoryManagerState);
var
  LPMediumBlockPoolHeader: PMediumBlockPoolHeader;
  LPMediumBlock: Pointer;
  LInd: Integer;
  LBlockTypeIndex, LMediumBlockSize: Cardinal;
  LMediumBlockHeader, LLargeBlockSize: NativeUInt;
  LPLargeBlock: PLargeBlockHeader;
begin
  {Clear the results}
  FillChar(AMemoryManagerState, SizeOf(AMemoryManagerState), 0);
  {Set the small block size stats}
  for LInd := 0 to NumSmallBlockTypes - 1 do
  begin
    AMemoryManagerState.SmallBlockTypeStates[LInd].InternalBlockSize :=
      SmallBlockTypes[LInd].BlockSize;
    AMemoryManagerState.SmallBlockTypeStates[LInd].UseableBlockSize :=
      SmallBlockTypes[LInd].BlockSize - BlockHeaderSize;
    if Integer(AMemoryManagerState.SmallBlockTypeStates[LInd].UseableBlockSize) < 0 then
      AMemoryManagerState.SmallBlockTypeStates[LInd].UseableBlockSize := 0;
  end;
  {Lock all small block types}
  LockAllSmallBlockTypes;
  {Lock the medium blocks}
  LockMediumBlocks;
  {Step through all the medium block pools}
  LPMediumBlockPoolHeader := MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
  while LPMediumBlockPoolHeader <> @MediumBlockPoolsCircularList do
  begin
    {Add to the medium block used space}
    Inc(AMemoryManagerState.ReservedMediumBlockAddressSpace, MediumBlockPoolSize);
    LPMediumBlock := GetFirstMediumBlockInPool(LPMediumBlockPoolHeader);
    while LPMediumBlock <> nil do
    begin
      LMediumBlockHeader := PNativeUInt(PByte(LPMediumBlock) - BlockHeaderSize)^;
      {Is the block in use?}
      if LMediumBlockHeader and IsFreeBlockFlag = 0 then
      begin
        {Get the block size}
        LMediumBlockSize := LMediumBlockHeader and DropMediumAndLargeFlagsMask;
        if (LMediumBlockHeader and IsSmallBlockPoolInUseFlag) <> 0 then
        begin
          {Get the block type index}
          LBlockTypeIndex := (UIntPtr(PSmallBlockPoolHeader(LPMediumBlock).BlockType)
            - UIntPtr(@SmallBlockTypes[0])) div SizeOf(TSmallBlockType);
          {Subtract from medium block usage}
          Dec(AMemoryManagerState.ReservedMediumBlockAddressSpace, LMediumBlockSize);
          {Add it to the reserved space for the block size}
          Inc(AMemoryManagerState.SmallBlockTypeStates[LBlockTypeIndex].ReservedAddressSpace, LMediumBlockSize);
          {Add the usage for the pool}
          Inc(AMemoryManagerState.SmallBlockTypeStates[LBlockTypeIndex].AllocatedBlockCount,
            PSmallBlockPoolHeader(LPMediumBlock).BlocksInUse);
        end
        else
        begin
          Inc(AMemoryManagerState.AllocatedMediumBlockCount);
          Inc(AMemoryManagerState.TotalAllocatedMediumBlockSize, LMediumBlockSize - BlockHeaderSize);
        end;
      end;
      {Next medium block}
      LPMediumBlock := NextMediumBlock(LPMediumBlock);
    end;
    {Get the next medium block pool}
    LPMediumBlockPoolHeader := LPMediumBlockPoolHeader.NextMediumBlockPoolHeader;
  end;
  {Unlock medium blocks}
  MediumBlocksLocked := False;
  {Unlock all the small block types}
  for LInd := 0 to NumSmallBlockTypes - 1 do
    SmallBlockTypes[LInd].BlockTypeLocked := False;
  {Step through all the large blocks}
  LockLargeBlocks;
  LPLargeBlock := LargeBlocksCircularList.NextLargeBlockHeader;
  while LPLargeBlock <> @LargeBlocksCircularList do
  begin
    LLargeBlockSize := LPLargeBlock.BlockSizeAndFlags and DropMediumAndLargeFlagsMask;
    Inc(AMemoryManagerState.AllocatedLargeBlockCount);
    Inc(AMemoryManagerState.ReservedLargeBlockAddressSpace, LLargeBlockSize);
    Inc(AMemoryManagerState.TotalAllocatedLargeBlockSize, LPLargeBlock.UserAllocatedSize);
    {Get the next large block}
    LPLargeBlock := LPLargeBlock.NextLargeBlockHeader;
  end;
  LargeBlocksLocked := False;
end;

{Gets the state of every 64K block in the 4GB address space for 32-bit, and the
 low 4GB of the address space under 64-bit.}
procedure GetMemoryMap(var AMemoryMap: TMemoryMap);
var
  LPMediumBlockPoolHeader: PMediumBlockPoolHeader;
  LPLargeBlock: PLargeBlockHeader;
  LChunkIndex, LInd: Cardinal;
  LLargeBlockSize: NativeUInt;
  LMBI: TMemoryBasicInformation;
begin
  {Clear the map}
  FillChar(AMemoryMap, SizeOf(AMemoryMap), ord(csUnallocated));
  {Step through all the medium block pools}
  LockMediumBlocks;
  LPMediumBlockPoolHeader := MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
  while LPMediumBlockPoolHeader <> @MediumBlockPoolsCircularList do
  begin
    {Add to the medium block used space}
    LChunkIndex := UIntPtr(LPMediumBlockPoolHeader) shr 16;
    for LInd := LChunkIndex to LChunkIndex + (MediumBlockPoolSize - 1) shr 16 do
    begin
      if LChunkIndex > High(AMemoryMap) then
        Break;
      AMemoryMap[LInd] := csAllocated;
    end;
    {Get the next medium block pool}
    LPMediumBlockPoolHeader := LPMediumBlockPoolHeader.NextMediumBlockPoolHeader;
  end;
  MediumBlocksLocked := False;
  {Step through all the large blocks}
  LockLargeBlocks;
  LPLargeBlock := LargeBlocksCircularList.NextLargeBlockHeader;
  while LPLargeBlock <> @LargeBlocksCircularList do
  begin
    LChunkIndex := UIntPtr(LPLargeBlock) shr 16;
    LLargeBlockSize := LPLargeBlock.BlockSizeAndFlags and DropMediumAndLargeFlagsMask;
    for LInd := LChunkIndex to LChunkIndex + (LLargeBlockSize - 1) shr 16 do
    begin
      if LChunkIndex > High(AMemoryMap) then
        Break;
      AMemoryMap[LInd] := csAllocated;
    end;
    {Get the next large block}
    LPLargeBlock := LPLargeBlock.NextLargeBlockHeader;
  end;
  LargeBlocksLocked := False;
  {Fill in the rest of the map}
  for LInd := 0 to 65535 do
  begin
    {If the chunk is not allocated by this MM, what is its status?}
    if AMemoryMap[LInd] = csUnallocated then
    begin
      {Get all the reserved memory blocks and windows allocated memory blocks, etc.}
      VirtualQuery(Pointer(LInd * 65536), LMBI, SizeOf(LMBI));
      if LMBI.State = MEM_COMMIT then
        AMemoryMap[LInd] := csSysAllocated
      else
        if LMBI.State = MEM_RESERVE then
          AMemoryMap[LInd] := csSysReserved;
    end;
  end;
end;

{Returns summarised information about the state of the memory manager.}
function GetHeapStatus: THeapStatus;
var
  LPMediumBlockPoolHeader: PMediumBlockPoolHeader;
  LPMediumBlock: Pointer;
  LMediumBlockHeader, LLargeBlockSize: NativeUInt;
  LBlockTypeIndex, LMediumBlockSize, LSmallBlockUsage, LSmallBlockOverhead: Cardinal;
  LInd: Integer;
  LPLargeBlock: PLargeBlockHeader;
begin
  {Clear the structure}
  FillChar(Result, SizeOf(Result), 0);
  {Lock all small block types}
  LockAllSmallBlockTypes;
  {Lock the medium blocks}
  LockMediumBlocks;
  {Step through all the medium block pools}
  LPMediumBlockPoolHeader := MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
  while LPMediumBlockPoolHeader <> @MediumBlockPoolsCircularList do
  begin
    {Add to the total and committed address space}
    Inc(Result.TotalAddrSpace, ((MediumBlockPoolSize + $ffff) and $ffff0000));
    Inc(Result.TotalCommitted, ((MediumBlockPoolSize + $ffff) and $ffff0000));
    {Add the medium block pool overhead}
    Inc(Result.Overhead, (((MediumBlockPoolSize + $ffff) and $ffff0000)
      - MediumBlockPoolSize + MediumBlockPoolHeaderSize));
    {Get the first medium block in the pool}
    LPMediumBlock := GetFirstMediumBlockInPool(LPMediumBlockPoolHeader);
    while LPMediumBlock <> nil do
    begin
      {Get the block header}
      LMediumBlockHeader := PNativeUInt(PByte(LPMediumBlock) - BlockHeaderSize)^;
      {Get the block size}
      LMediumBlockSize := LMediumBlockHeader and DropMediumAndLargeFlagsMask;
      {Is the block in use?}
      if LMediumBlockHeader and IsFreeBlockFlag = 0 then
      begin
        if (LMediumBlockHeader and IsSmallBlockPoolInUseFlag) <> 0 then
        begin
          {Get the block type index}
          LBlockTypeIndex := (UIntPtr(PSmallBlockPoolHeader(LPMediumBlock).BlockType)
            - UIntPtr(@SmallBlockTypes[0])) div SizeOf(TSmallBlockType);
          {Get the usage in the block}
          LSmallBlockUsage := PSmallBlockPoolHeader(LPMediumBlock).BlocksInUse
            * SmallBlockTypes[LBlockTypeIndex].BlockSize;
          {Get the total overhead for all the small blocks}
          LSmallBlockOverhead := PSmallBlockPoolHeader(LPMediumBlock).BlocksInUse
            * BlockHeaderSize;
          {Add to the totals}
          Inc(Result.FreeSmall, LMediumBlockSize - LSmallBlockUsage - BlockHeaderSize);
          Inc(Result.Overhead, LSmallBlockOverhead + BlockHeaderSize);
          Inc(Result.TotalAllocated, LSmallBlockUsage - LSmallBlockOverhead);
        end
        else
        begin
          {Add to the result}
          Inc(Result.TotalAllocated, LMediumBlockSize - BlockHeaderSize);
          Inc(Result.Overhead, BlockHeaderSize);
        end;
      end
      else
      begin
        {The medium block is free}
        Inc(Result.FreeBig, LMediumBlockSize);
      end;
      {Next medium block}
      LPMediumBlock := NextMediumBlock(LPMediumBlock);
    end;
    {Get the next medium block pool}
    LPMediumBlockPoolHeader := LPMediumBlockPoolHeader.NextMediumBlockPoolHeader;
  end;
  {Add the sequential feed unused space}
  Inc(Result.Unused, MediumSequentialFeedBytesLeft);
  {Unlock the medium blocks}
  MediumBlocksLocked := False;
  {Unlock all the small block types}
  for LInd := 0 to NumSmallBlockTypes - 1 do
    SmallBlockTypes[LInd].BlockTypeLocked := False;
  {Step through all the large blocks}
  LockLargeBlocks;
  LPLargeBlock := LargeBlocksCircularList.NextLargeBlockHeader;
  while (LPLargeBlock <> @LargeBlocksCircularList) do
  begin
    LLargeBlockSize := LPLargeBlock.BlockSizeAndFlags and DropMediumAndLargeFlagsMask;
    Inc(Result.TotalAddrSpace, LLargeBlockSize);
    Inc(Result.TotalCommitted, LLargeBlockSize);
    Inc(Result.TotalAllocated, LPLargeBlock.UserAllocatedSize);
    Inc(Result.Overhead, LLargeBlockSize - LPLargeBlock.UserAllocatedSize);
    {Get the next large block}
    LPLargeBlock := LPLargeBlock.NextLargeBlockHeader;
  end;
  LargeBlocksLocked := False;
  {Set the total number of free bytes}
  Result.TotalFree := Result.FreeSmall + Result.FreeBig + Result.Unused;
end;

{------------------------Memory Manager Sharing---------------------------}

{Generates a string identifying the process}
procedure BuildMappingObjectName;
var
  i, LProcessID: Cardinal;
begin
  LProcessID := GetCurrentProcessId;
  for i := 0 to 7 do
  begin
    MappingObjectName[(High(MappingObjectName) - 1) - i] :=
      HexTable[((LProcessID shr (i * 4)) and $F)];
  end;
end;

{Searches the current process for a shared memory manager}
function FindSharedMemoryManager: PMemoryManagerEx;
var
  LPMapAddress: Pointer;
  LLocalMappingObjectHandle: THandle;
begin
  BuildMappingObjectName;
  {Try to open the shared memory manager file mapping}
  LLocalMappingObjectHandle := OpenFileMappingA(FILE_MAP_READ, False,
    MappingObjectName);
  {Is a memory manager in this process sharing its memory manager?}
  if LLocalMappingObjectHandle = 0 then
  begin
    {No shared memory manager in the process}
    Result := nil;
  end
  else
  begin
    {Map a view of the memory}
    LPMapAddress := MapViewOfFile(LLocalMappingObjectHandle, FILE_MAP_READ, 0,
      0, 0);
    {Get the address of the shared memory manager}
    Result := PPointer(LPMapAddress)^;
    {Unmap the file}
    UnmapViewOfFile(LPMapAddress);
    {Close the file mapping}
    CloseHandle(LLocalMappingObjectHandle);
  end;
end;

{Searches the current process for a shared memory manager. If no memory has
 been allocated using this memory manager it will switch to using the shared
 memory manager instead. Returns true if another memory manager was found and
 it could be shared. If this memory manager instance *is* the shared memory
 manager, it will do nothing and return true.}
function AttemptToUseSharedMemoryManager: Boolean;
var
  LPMemoryManagerEx: PMemoryManagerEx;
begin
  if not IsMemoryManagerSet then
  begin
    {Is this MM being shared? If so, switching to another MM is not allowed}
    if MappingObjectHandle = 0 then
    begin
      {May not switch memory manager after memory has been allocated}
      if (MediumBlockPoolsCircularList.NextMediumBlockPoolHeader = @MediumBlockPoolsCircularList)
        and (LargeBlocksCircularList.NextLargeBlockHeader = @LargeBlocksCircularList) then
      begin
        LPMemoryManagerEx := FindSharedMemoryManager;
        if LPMemoryManagerEx <> nil then
        begin
          SetMemoryManager(LPMemoryManagerEx^);
          Result := True;
        end
        else
          Result := False;
      end
      else
      begin
        {Memory has already been allocated using this memory manager. We cannot
         rip the memory manager out from under live pointers.}
        MessageBoxA(0, LivePointersErrorMsg, ShareMMErrorTitle,
          MB_OK or MB_ICONERROR or MB_TASKMODAL);
        Result := False;
      end;
    end
    else
    begin
      {This memory manager is being shared, and an attempt is being made by the
       application to use the shared memory manager (which is this one): Don't
       do anything and return success. (This situation can occur when using
       SimpleShareMem in a DLL together with runtime packages.)}
      Result := True;
    end;
  end
  else
  begin
    {Another memory manager has already been installed.}
    Result := False;
  end;
end;

{Starts sharing this memory manager with other modules in the current process.
 Only one memory manager may be shared per process, so this function may fail.}
function ShareMemoryManager: Boolean;
var
  LPMapAddress: Pointer;
begin
  if (not IsMemoryManagerSet) and (MappingObjectHandle = 0) then
  begin
    {Is any other module already sharing its MM?}
    if FindSharedMemoryManager = nil then
    begin
      {Create the memory mapped file}
      MappingObjectHandle := CreateFileMappingA(INVALID_HANDLE_VALUE, nil,
        PAGE_READWRITE, 0, SizeOf(Pointer), MappingObjectName);
      {Map a view of the memory}
      LPMapAddress := MapViewOfFile(MappingObjectHandle, FILE_MAP_WRITE, 0, 0, 0);
      {Set a pointer to the new memory manager}
      PPointer(LPMapAddress)^ := @ThisMemoryManager;
      {Unmap the file}
      UnmapViewOfFile(LPMapAddress);
      {Sharing this MM}
      Result := True;
    end
    else
    begin
      {Another module is already sharing its memory manager}
      Result := False;
    end;
  end
  else
  begin
    {Either another memory manager has been set or this memory manager is
     already being shared}
    Result := False;
  end;
end;

{--------------------------Memory Manager Setup---------------------------}

{Builds the block size to small block type lookup table}
procedure BuildBlockTypeLookupTable;
var
  LBlockTypeInd, LStartIndex, LNextStartIndex: Cardinal;
  LBlockTypeVal: Byte;
begin
  LStartIndex := 0;
  for LBlockTypeInd := 0 to High(SmallBlockTypes) do
  begin
    {Is this a valid block type for the alignment restriction?}
    if (MinimumBlockAlignment = mba8Byte)
      or (SmallBlockTypes[LBlockTypeInd].BlockSize and 15 = 0) then
    begin
      LNextStartIndex := SmallBlockTypes[LBlockTypeInd].BlockSize div SmallBlockGranularity;
      {Store the block type index * 4 in the appropriate slots.}
      LBlockTypeVal := LBlockTypeInd * 4;
      while LStartIndex < LNextStartIndex do
      begin
        AllocSize2SmallBlockTypeIndX4[LStartIndex] := LBlockTypeVal;
        Inc(LStartIndex);
      end;
      {Set the start of the next block type}
      LStartIndex := LNextStartIndex;
    end;
  end;
end;

function GetMinimumBlockAlignment: TMinimumBlockAlignment;
begin
  Result := MinimumBlockAlignment;
end;

procedure SetMinimumBlockAlignment(AMinimumBlockAlignment: TMinimumBlockAlignment);
begin
{16-byte alignment is required under 64-bit.}
{$if SizeOf(Pointer) <> 8}
  if AMinimumBlockAlignment <> MinimumBlockAlignment then
  begin
    MinimumBlockAlignment := AMinimumBlockAlignment;
    {Rebuild the size to small block type lookup table}
    BuildBlockTypeLookupTable;
  end;
{$endif}
end;

{Initializes the lookup tables for the memory manager}
procedure InitializeMemoryManager;
var
  i, LMinimumPoolSize, LOptimalPoolSize, LGroupNumber, LBlocksPerPool: Cardinal;
  LPMediumFreeBlock: PMediumFreeBlock;
begin
  {---------------------Set up the small block types----------------------}
  for i := 0 to High(SmallBlockTypes) do
  begin
    {The upsize move procedure may move chunks in 16 bytes even with 8-byte
    alignment, since the new size will always be at least 8 bytes bigger than
    the old size.}
{$ifdef UseCustomFixedSizeMoveRoutines}
    if not Assigned(SmallBlockTypes[i].UpsizeMoveProcedure) then
  {$ifdef UseCustomVariableSizeMoveRoutines}
      SmallBlockTypes[i].UpsizeMoveProcedure := MoveX16LP;
  {$else}
      SmallBlockTypes[i].UpsizeMoveProcedure := Move;
  {$endif}
{$endif}
    {Set the first "available pool" to the block type itself, so that the
     allocation routines know that there are currently no pools with free
     blocks of this size.}
    SmallBlockTypes[i].PreviousPartiallyFreePool := @SmallBlockTypes[i];
    SmallBlockTypes[i].NextPartiallyFreePool := @SmallBlockTypes[i];
    {Cannot sequential feed yet: Ensure that the next address is greater than
     the maximum address}
    SmallBlockTypes[i].MaxSequentialFeedBlockAddress := Pointer(0);
    SmallBlockTypes[i].NextSequentialFeedBlockAddress := Pointer(1);
    {Get the mask to use for finding a medium block suitable for a block pool}
    LMinimumPoolSize :=
      ((SmallBlockTypes[i].BlockSize * MinimumSmallBlocksPerPool
        + (SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    if LMinimumPoolSize < MinimumMediumBlockSize then
      LMinimumPoolSize := MinimumMediumBlockSize;
    {Get the closest group number for the minimum pool size}
    LGroupNumber := (LMinimumPoolSize + (- MinimumMediumBlockSize + MediumBlockBinsPerGroup * MediumBlockGranularity div 2))
      div (MediumBlockBinsPerGroup * MediumBlockGranularity);
    {Too large?}
    if LGroupNumber > 7 then
      LGroupNumber := 7;
    {Set the bitmap}
    SmallBlockTypes[i].AllowedGroupsForBlockPoolBitmap := Byte(Byte(-1) shl LGroupNumber);
    {Set the minimum pool size}
    SmallBlockTypes[i].MinimumBlockPoolSize := MinimumMediumBlockSize + LGroupNumber * (MediumBlockBinsPerGroup * MediumBlockGranularity);
    {Get the optimal block pool size}
    LOptimalPoolSize := ((SmallBlockTypes[i].BlockSize * TargetSmallBlocksPerPool
        + (SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
      and -MediumBlockGranularity) + MediumBlockSizeOffset;
    {Limit the optimal pool size to within range}
    if LOptimalPoolSize < OptimalSmallBlockPoolSizeLowerLimit then
      LOptimalPoolSize := OptimalSmallBlockPoolSizeLowerLimit;
    if LOptimalPoolSize > OptimalSmallBlockPoolSizeUpperLimit then
      LOptimalPoolSize := OptimalSmallBlockPoolSizeUpperLimit;
    {How many blocks will fit in the adjusted optimal size?}
    LBlocksPerPool := (LOptimalPoolSize - SmallBlockPoolHeaderSize) div SmallBlockTypes[i].BlockSize;
    {Recalculate the optimal pool size to minimize wastage due to a partial
     last block.}
    SmallBlockTypes[i].OptimalBlockPoolSize :=
      ((LBlocksPerPool * SmallBlockTypes[i].BlockSize + (SmallBlockPoolHeaderSize + MediumBlockGranularity - 1 - MediumBlockSizeOffset))
        and -MediumBlockGranularity) + MediumBlockSizeOffset;
  end;
  {Build the requested size to block type lookup table}
  BuildBlockTypeLookupTable;
  {--------------------------Set up the medium blocks---------------------}
  {There are currently no medium block pools}
  MediumBlockPoolsCircularList.PreviousMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
  MediumBlockPoolsCircularList.NextMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
  {All medium bins are empty}
  for i := 0 to High(MediumBlockBins) do
  begin
    LPMediumFreeBlock := @MediumBlockBins[i];
    LPMediumFreeBlock.PreviousFreeBlock := LPMediumFreeBlock;
    LPMediumFreeBlock.NextFreeBlock := LPMediumFreeBlock;
  end;
  {------------------------Set up the large blocks------------------------}
  LargeBlocksCircularList.PreviousLargeBlockHeader := @LargeBlocksCircularList;
  LargeBlocksCircularList.NextLargeBlockHeader := @LargeBlocksCircularList;
end;

{Frees all allocated memory.}
procedure FreeAllMemory;
var
  LPMediumBlockPoolHeader, LPNextMediumBlockPoolHeader: PMediumBlockPoolHeader;
  LPMediumFreeBlock: PMediumFreeBlock;
  LPLargeBlock, LPNextLargeBlock: PLargeBlockHeader;
  LInd: Integer;
begin
  {Free all block pools}
  LPMediumBlockPoolHeader := MediumBlockPoolsCircularList.NextMediumBlockPoolHeader;
  while LPMediumBlockPoolHeader <> @MediumBlockPoolsCircularList do
  begin
    {Get the next medium block pool so long}
    LPNextMediumBlockPoolHeader := LPMediumBlockPoolHeader.NextMediumBlockPoolHeader;
    {Free this pool}
    VirtualFree(LPMediumBlockPoolHeader, 0, MEM_RELEASE);
    {Next pool}
    LPMediumBlockPoolHeader := LPNextMediumBlockPoolHeader;
  end;
  {Clear all small block types}
  for LInd := 0 to High(SmallBlockTypes) do
  begin
    SmallBlockTypes[LInd].PreviousPartiallyFreePool := @SmallBlockTypes[LInd];
    SmallBlockTypes[LInd].NextPartiallyFreePool := @SmallBlockTypes[LInd];
    SmallBlockTypes[LInd].NextSequentialFeedBlockAddress := Pointer(1);
    SmallBlockTypes[LInd].MaxSequentialFeedBlockAddress := nil;
  end;
  {Clear all medium block pools}
  MediumBlockPoolsCircularList.PreviousMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
  MediumBlockPoolsCircularList.NextMediumBlockPoolHeader := @MediumBlockPoolsCircularList;
  {All medium bins are empty}
  for LInd := 0 to High(MediumBlockBins) do
  begin
    LPMediumFreeBlock := @MediumBlockBins[LInd];
    LPMediumFreeBlock.PreviousFreeBlock := LPMediumFreeBlock;
    LPMediumFreeBlock.NextFreeBlock := LPMediumFreeBlock;
  end;
  MediumBlockBinGroupBitmap := 0;
  FillChar(MediumBlockBinBitmaps, SizeOf(MediumBlockBinBitmaps), 0);
  MediumSequentialFeedBytesLeft := 0;
  {Free all large blocks}
  LPLargeBlock := LargeBlocksCircularList.NextLargeBlockHeader;
  while LPLargeBlock <> @LargeBlocksCircularList do
  begin
    {Get the next large block}
    LPNextLargeBlock := LPLargeBlock.NextLargeBlockHeader;
    {Free this large block}
    VirtualFree(LPLargeBlock, 0, MEM_RELEASE);
    {Next large block}
    LPLargeBlock := LPNextLargeBlock;
  end;
  {There are no large blocks allocated}
  LargeBlocksCircularList.PreviousLargeBlockHeader := @LargeBlocksCircularList;
  LargeBlocksCircularList.NextLargeBlockHeader := @LargeBlocksCircularList;
end;

procedure FinalizeMemoryManager;
begin
  {Destroy the memory mapped file handle used for sharing the memory manager.}
  if MappingObjectHandle <> 0 then
  begin
    CloseHandle(MappingObjectHandle);
    MappingObjectHandle := 0;
  end;
{$ifdef IncludeMemoryLeakTrackingCode}
  {Should memory leaks be reported?}
  if ReportMemoryLeaksOnShutdown then
    ScanForMemoryLeaks;
  {Free the expected memory leaks list}
  if ExpectedMemoryLeaks <> nil then
  begin
    VirtualFree(ExpectedMemoryLeaks, 0, MEM_RELEASE);
    ExpectedMemoryLeaks := nil;
  end;
{$endif}
  {Clean up: Free all memory allocated through this memory manager. If this is
   a library that is frequently loaded and unloaded then it is necessary to
   prevent the process from running out of address space.}
  FreeAllMemory;
end;

