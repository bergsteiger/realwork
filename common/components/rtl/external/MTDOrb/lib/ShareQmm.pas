
//////////////////////////////////////////////
//                                          //
//   ShareQmm 2.01                          //
//                                          //
//   Shared quick memory manager unit       //
//                                          //
//   Copyright (c) 2001, Andrew Driazgov    //
//   e-mail: andrey@asp.tstu.ru             //
//                                          //
//   Last updated: January 24, 2001         //
//                                          //
//////////////////////////////////////////////

unit ShareQmm;

interface

{ ShareQmm must be the first unit in your library's USES clause AND your
  project's (select Project-View Source) USES clause if some parts of your
  program have done as separate DLLs (especially if they export any procedures
  or functions that pass strings as parameters or function results). ShareQmm
  is the interface unit to the QMM.DLL shared memory manager, which must be
  deployed along with your DLL. You can't combine using of the standard
  ShareMem and custom ShareQmm memory managers in the same program project
  (including EXE-file with all DLLs). You can use either ShareMem or ShareQmm,
  but not both together. ShareQmm memory manager works at the same speed as
  a ShareMem memory manager with the blocks up to 4096 bytes and much more
  faster with the larger blocks. }

(*
  program Project1;

  uses
    ShareQmm in 'ShareQmm.pas',  // first unit !!!
    Forms,
    MainUnit in 'MainUnit.pas' {MainForm},
  ...

  library Project1;

  uses
    ShareQmm in 'ShareQmm.pas',  // first unit !!!
    SysUtils,
    Classes;
  ...
*)

{ QMemDecommitOverstock decommits large free blocks of memory. You may want
  to call this function from Application.Idle event handler. It is only way
  for decommit pages of the physical storage. If the function succeeds, the
  return value is 0, otherwise it returns -1. }

function QMemDecommitOverstock: Integer;

{ QMemSize returns the size, in bytes, of a memory block allocated from a
  custom heap. P is a pointer to the memory block whose size the function
  will obtain. The custom heap has to be installed. If the function succeeds,
  the return value is the size, in bytes, of the allocated memory block.
  If the function fails, the return value is -1. }

function QMemSize(P: Pointer): Integer;

{ QMemTotalAddrSpace returns the total address space of the custom heap,
  in bytes. This is fixed and will not grow as your program's dynamic memory
  usage grows. TotalUncommitted + TotalCommitted = TotalAddrSpace. The value
  is equal to MaximumSize, which you have specified when called QMemInstall
  function. If QMemTotalAddrSpace function fails, the return value is -1. }

function QMemTotalAddrSpace: Integer;

{ QMemTotalCommitted returns the total number of bytes (of TotalAddrSpace)
  for which space has been allocated in the swap file. If the function fails,
  the return value is -1. }

function QMemTotalCommitted: Integer;

{ QMemTotalUncommitted returns the total number of bytes (of TotalAddrSpace)
  for which space has not been allocated in the swap file. If the function
  fails, the return value is -1. }

function QMemTotalUncommitted: Integer;

{ QMemTotalAllocated returns the total number of bytes dynamically allocated
  by your program. It includes 4 bytes at the beginning of each memory block
  and the trailing bytes for maintain of 32-bytes align of a memory blocks.
  If the function fails, the return value is -1. }

function QMemTotalAllocated: Integer;

{ QMemTotalFree returns the total number of free bytes available in the
  custom heap for allocation by your program. If the function fails, the
  return value is -1. }

function QMemTotalFree: Integer;

{ QMemMaxFreeBlock returns the size, in bytes, of the maximum memory block
  which you can allocate in the custom heap. You can pass this value to
  the GetMem procedure (if you have physical storage of enought size).
  If the function fails, the return value is -1. }

function QMemMaxFreeBlock: Integer;

{ QMemCountOfFreeBlocks returns the total number of free blocks in the custom
  heap address space. If the function fails, the return value is -1. }

function QMemCountOfFreeBlocks: Integer;

{ QMemOverhead returns the total number of bytes required by the heap manager
  to manage all the blocks dynamically allocated by your program. More
  precisely, it returns the total size, in bytes, of additional committed
  space. If the function fails, the return value is -1. }

function QMemOverhead: Integer;

{ QMemGetHeapStatus returns the current status of the custom memory manager
  in a TQMemHeapStatus record. The fields of this record have been described
  above (they are analogues of the corresponding functions). If the function
  fails, all fields are 0. }

type
  TQMemHeapStatus = record
    TotalAddrSpace: Cardinal;
    TotalCommitted: Cardinal;
    TotalUncommitted: Cardinal;
    TotalAllocated: Cardinal;
    TotalFree: Cardinal;
    MaxFreeBlock: Cardinal;
    CountOfFreeBlocks: Cardinal;
    Overhead: Cardinal;
  end;

function QMemGetHeapStatus: TQMemHeapStatus;

implementation

const
  Qmm = 'Qmm.dll';

function ExtGetMem(Size: Integer): Pointer;
  external Qmm name 'ExtGetMem';
function ExtFreeMem(P: Pointer): Integer;
  external Qmm name 'ExtFreeMem';
function ExtReallocMem(P: Pointer; Size: Integer): Pointer;
  external Qmm name 'ExtReallocMem';
function QMemDecommitOverstock: Integer;
  external Qmm name 'QMemDecommitOverstock';
function QMemSize(P: Pointer): Integer;
  external Qmm name 'QMemSize';
function QMemTotalAddrSpace: Integer;
  external Qmm name 'QMemTotalAddrSpace';
function QMemTotalCommitted: Integer;
  external Qmm name 'QMemTotalCommitted';
function QMemTotalUncommitted: Integer;
  external Qmm name 'QMemTotalUncommitted';
function QMemTotalAllocated: Integer;
  external Qmm name 'QMemTotalAllocated';
function QMemTotalFree: Integer;
  external Qmm name 'QMemTotalFree';
function QMemMaxFreeBlock: Integer;
  external Qmm name 'QMemMaxFreeBlock';
function QMemCountOfFreeBlocks: Integer;
  external Qmm name 'QMemCountOfFreeBlocks';
function QMemOverhead: Integer;
  external Qmm name 'QMemOverhead';
function QMemGetHeapStatus: TQMemHeapStatus;
  external Qmm name 'QMemGetHeapStatus';
function QMemIsInstalled: Boolean;
  external Qmm name 'QMemIsInstalled';

var
  OldMemManager: TMemoryManager;

function IntFreeMem(P: Pointer): Integer;
begin
  Result := ExtFreeMem(P);
  if Result > 0 then
    Result := OldMemManager.FreeMem(P);
end;

function IntReallocMem(P: Pointer; Size: Integer): Pointer;
begin
  Result := ExtReallocMem(P,Size);
  if LongWord(Result) = $FFFFFFFF then
    Result := OldMemManager.ReallocMem(P,Size);
end;

const
  QMemManager: TMemoryManager = (
    GetMem: ExtGetMem;
    FreeMem: IntFreeMem;
    ReallocMem: IntReallocMem);

initialization
  GetMemoryManager(OldMemManager);
  if QMemIsInstalled then
    SetMemoryManager(QMemManager);

finalization
  SetMemoryManager(OldMemManager);

end.

