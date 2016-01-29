{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

procedure Sleep(dwMilliseconds: Cardinal); stdcall;
  external kernel name 'Sleep';

function SysGetMem(Size: NativeInt): Pointer;
begin
  Result := HeapAlloc(GetProcessHeap, 0, Size);
end;

function SysFreeMem(P: Pointer): Integer;
begin
  HeapFree(GetProcessHeap, 0, P);
  Result := 0;
end;

function SysReallocMem(P: Pointer; Size: NativeInt): Pointer;
begin
  Result := HeapReAlloc(GetProcessHeap, 0, P, Size);
end;

function SysAllocMem(Size: NativeUInt): Pointer;
begin
  Result := SysGetMem(Size);
end;

function SysRegisterExpectedMemoryLeak(P: Pointer): Boolean;
begin
  Result := False;
end;

function SysUnregisterExpectedMemoryLeak(P: Pointer): Boolean;
begin
  Result := False;
end;

procedure InitializeMemoryManager;
begin
end;

procedure FinalizeMemoryManager;
begin
end;

function GetHeapStatus: THeapStatus; {Unsupported}
begin
end;

{Returns information about the current state of the memory manager}
procedure GetMemoryManagerState(var AMemoryManagerState: TMemoryManagerState);
begin
end;

{Gets the state of every 64K block in the 4GB address space}
procedure GetMemoryMap(var AMemoryMap: TMemoryMap);
begin
end;

{Set the minimum block alignment. In the current implementation blocks >=160
 bytes will always be at least 16 byte aligned, even if only 8-byte alignment
 (the default) is required.}
function GetMinimumBlockAlignment: TMinimumBlockAlignment;
begin
  Result := mba16Byte;
end;

procedure SetMinimumBlockAlignment(AMinimumBlockAlignment: TMinimumBlockAlignment);
begin
end;

{Searches the current process for a shared memory manager. If no memory has
 been allocated using this memory manager it will switch to using the shared
 memory manager instead. Returns true if another memory manager was found and
 this module is now sharing it.}
function AttemptToUseSharedMemoryManager: Boolean;
begin
  Result := False;
end;

{Makes this memory manager available for sharing to other modules in the
 current process. Only one memory manager may be shared per process, so this
 function may fail.}
function ShareMemoryManager: Boolean;
begin
  Result := False;
end;
