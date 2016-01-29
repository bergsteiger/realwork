
{*******************************************************}
{                                                       }
{       Turbo Pascal Version 7.0                        }
{       Turbo Vision Unit                               }
{                                                       }
{       Copyright (c) 1992 Borland International        }
{                                                       }
{       Virtual Pascal v2.1                             }
{       Copyright (C) 1996-2000 vpascal.com             }
{                                                       }
{*******************************************************}

unit Memory;

{$X+,I-,S-,Q-,H-}

interface

uses Use32;

const
  MaxHeapSize: longint = 655360 div 16;    { 640K }
  LowMemSize: longint = 4096 div 16;       {   4K }
  MaxBufMem: longint = 65536 div 16;       {  64K }

procedure InitMemory;
procedure DoneMemory;
procedure InitDosMem;
procedure DoneDosMem;
function LowMemory: Boolean;  pascal;
function MemAlloc(Size: longint): Pointer;  pascal;
function MemAllocSeg(Size: longint): Pointer;  pascal;
procedure NewCache(var P: Pointer; Size: longint); pascal;
procedure DisposeCache(P: Pointer);  pascal;
procedure NewBuffer(var P: Pointer; Size: longint);  pascal;
procedure DisposeBuffer(P: Pointer);  pascal;
function GetBufferSize(P: Pointer): longint;  pascal;
function SetBufferSize(var P: Pointer; Size: longint): Boolean;  pascal;


implementation

uses Objects;

type
  PCache = ^TCache;
  TCache = record
    Next   : PCache;  //4
    Size   : longint;   //4
    Master : ^Pointer;     //4
    Data   : record end;
  end;

  PBuffer = ^TBuffer;
  TBuffer = record
    Next   : PBuffer;
    Size   : longint;
    Master : ^Pointer;
    Data   : record end;
  end;

const
  CacheList  : PCache = nil;
  BufList    : PBuffer = nil;
  SafetyPool : Pointer = nil;
  SafetyPoolSize : longint = 0;
  DisablePool : Boolean = False;

function FreeCache: Boolean;
begin
  FreeCache := False;
  if CacheList <> nil then
   begin
     DisposeCache(CacheList^.Next^.Master^);
     FreeCache := True;
   end;
end;


function FreeSafetyPool: Boolean;
begin
  FreeSafetyPool := False;
  if SafetyPool <> nil then
   begin
     FreeMem(SafetyPool, SafetyPoolSize);
     SafetyPool := nil;
     FreeSafetyPool := True;
   end;
end;

procedure InitMemory;
begin
  SafetyPoolSize := LowMemSize * 16;
  LowMemory;
end;


procedure DoneMemory;
begin
  while FreeCache do;
   FreeSafetyPool;
end;


procedure InitDosMem;
begin
end;


procedure DoneDosMem;
begin
end;


function LowMemory: Boolean;
begin
  LowMemory := False;
  if SafetyPool = nil then
  begin
    SafetyPool := MemAlloc(SafetyPoolSize);
    if SafetyPool = nil then
      LowMemory := True;
  end;
end;


function MemAlloc(Size: longint): Pointer;
var
  P: Pointer;
begin
  DisablePool := True;
  GetMem(P, Size);
  DisablePool := False;
  MemAlloc := P;
end;


function MemAllocSeg(Size: longint): Pointer;
begin
  MemAllocSeg:=MemAlloc(Size);
end;

{procedure NewCache(var P: Pointer; Size: longint);
var
  Cache : PCache;
begin
  Inc(Size, SizeOf(TCache));
  GetMem(cache,Size);
  if Cache <> nil then
  begin
    Cache^.Next:=CacheList;
    CacheList:=Cache;
    Cache^.Master:=@P;
    Cache^.size:=Size;
    Inc(longint(Cache), SizeOf(TCache));
  end;
  P:=Cache;
end;


procedure DisposeCache(P: Pointer);
var
  Cache, C,Prev: PCache;
begin
  longint(Cache):= longint(P) - SizeOf(TCache);
  C:=CacheList;
  Prev:=nil;
  while assigned(C) and (C<>Cache) do
   begin
     Prev:=C;
     C := C^.Next;
   end;
  if assigned(C) then
  begin
     if assigned(Prev) then
      Prev^.Next:=Cache^.Next
     else
      CacheList:=Cache^.Next;
    Cache^.Master^ := nil;
    FreeMem(Cache,Cache^.Size);
  end;
end;}
procedure NewCache(var P: Pointer; Size: Word);
var
  Cache: PCache;
begin
  Inc(Size, SizeOf(TCache));
  GetMem(Cache,Size);
  if Cache <> nil then
  begin
    if CacheList = nil then Cache^.Next := Cache else
    begin
      Cache^.Next := CacheList^.Next;
      CacheList^.Next := Cache;
    end;
    CacheList := Cache;
    Cache^.Master := @P;
    Cache^.Size := Size;
    Inc(Cache{SizeOf(TCache)});
  end;
  P := Cache;
end;

procedure DisposeCache(P: Pointer);
var
  Cache, C: PCache;
begin
  Cache := pointer(Longint(P) - sizeof(TCache));
  C := CacheList;
  while (C^.Next <> Cache) and (C^.Next <> CacheList) do C := C^.Next;
  if C^.Next = Cache then
  begin
    if C = Cache then CacheList := nil else
    begin
      if CacheList = Cache then CacheList := C;
      C^.Next := Cache^.Next;
    end;
    Cache^.Master^ := nil;
    FreeMem(Cache,Cache^.Size);
  end;
end;

procedure NewBuffer(var P: Pointer; Size: longint);
var
  PBuf : PBuffer;
begin
  New(PBuf);
  GetMem(P,Size);
  PBuf^.Size:=Size;
  PBuf^.master:=P;
  PBuf^.Next:=BufList;
  BufList:=PBuf;
end;


procedure DisposeBuffer(P: Pointer);
var
  PBuf,Prev : PBuffer;
begin
  PBuf:=BufList;
  Prev:=nil;
  while assigned(Pbuf) and (PBuf^.master<>P) do
   begin
     Prev:=PBuf;
     PBuf:=PBuf^.next;
   end;
  if assigned(PBuf) then
   begin
     if assigned(Prev) then
      Prev^.Next:=PBuf^.next
     else
      BufList:=PBuf^.next;
     PBuf^.master:=nil;
     Freemem(P,PBuf^.Size);
     Dispose(PBuf);
   end;
end;


function GetBufferSize(P: Pointer): longint;
var
  PBuf : PBuffer;
begin
  PBuf:=BufList;
  while assigned(Pbuf) and (PBuf^.master<>P) do
    PBuf:=PBuf^.next;
  if assigned(PBuf) then
    GetBufferSize:=PBuf^.Size
  else
    GetBufferSize:=0;
end;


function SetBufferSize(var P: Pointer; Size: longint): Boolean;
var
  Pnew  : pointer;
  Osize : longint;
begin
  NewBuffer(PNew,Size);
  OSize:=GetBufferSize(P);
  if OSize>Size then
    move(P^,Pnew^,Size)
  else
    move(P^,Pnew^,OSize);
  DisposeBuffer(P);
  P:=PNew;
  SetBufferSize:=(PNew<>nil);
end;

end.

