// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit map;

interface

uses
  Classes,{$IFDEF WIN32}windows,{$ENDIF}orbtypes,map_int,SysUtils,osthread,Contnrs;

{$IFNDEF USELIB}

type

  TLargeInt = LARGE_INTEGER;
  Comp = LONGLONG;
  PCompList = ^TCompList;
  TCompList = array[0..MaxListSize - 1] of LONGLONG;

  TMap = class(TInterfacedObject)
  private
    FList: PCompList;
    FCount: Integer;
    FCapacity : Integer;
  protected
    procedure Grow; virtual;
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
    function Find(Start,Last,Key : DWORD): integer; overload;
    function FindA(Start,Last,Key : DWORD): integer;
    procedure Insert(Index: Integer; Item: Comp);
    procedure _Put(Key: DWORD;Item: DWORD);
    procedure Delete(Index: Integer); virtual;
    function Expand: TMap;
    procedure clear(); virtual;
    function _Get(Key: DWORD): integer;
    function IndexOf(Item: DWORD): integer;
    procedure Pack;
    function count(): integer;
    property List: PCompList read FList;
    class procedure Error(const Msg: AnsiString; Data: Integer); virtual;
    function Remove(Key: DWORD): Integer;
  public
    destructor Destroy; override;
  end;

  TLongInterfaceMap = class(TMap,ILongInterfaceMap)
  protected
    procedure Put(Key: _ulong;Item: IUnknown);
    function Get(Key: _ulong): IUnknown;
    procedure clear(); override;
    procedure erase(Key: _ulong);
    procedure Delete(Index: Integer); override;
    function Items(Index: integer): IUnknown;
    function IndexOf(Item: IUnknown): integer;
  public
    property Item[Key: _ulong]: IUnknown read Get write Put; default;
  end;

  TLongObjectMap = class(TMap,ILongObjectMap)
  protected
    procedure Put(Key: long; Item: TObject);
    function Get(Key: long): TObject;
    procedure clear(); override;
    procedure erase(Key: long);
    procedure Delete(Index: Integer); override;
    function Items(Index: integer): TObject;
    function IndexOf(Item: TObject): integer;
  public
    property Item[Key: long]: TObject read Get write Put; default;
  end;

  TInterfaceLongMap = class(TMap,IInterfaceLongMap)
  protected
    procedure Put(Key: IUnknown;Item: long);
    function Get(Key: IUnknown): long;
    procedure clear(); override;
    procedure Delete(Index: Integer); override;
    function IndexOf(Key: IUnknown): integer;
    procedure erase(Key: IUnknown);
  public
    property Item[Key: IUnknown]: long read Get write Put; default;
  end;

  TInterfaceInterfaceMap = class(TMap,IInterfaceInterfaceMap)
  private
    FCompareFunc: TInterfaceInterfaceMapCompare;
  protected
    procedure Put(Key: IUnknown;Item: IUnknown);
    function Get(Key: IUnknown): IUnknown;
    function IndexOf(Key: IUnknown): integer;
    property Item[Key: IUnknown]: IUnknown read Get write Put; default;
    procedure clear(); override;
    procedure Delete(Index: Integer); override;
    procedure erase(Key: IUnknown);
    function Second(Index: Integer): IUnknown;
    function Find(Key: IInterface): IInterface; overload;
    procedure SetCompareFunc(AFunc: TInterfaceInterfaceMapCompare);
  end;

  TInterfaceStack = class(TInterfacedObject, IInterfaceStack)
  private
    FMutex: TRecursiveMutex;
    FStack: TStack;
  protected
    function Count: integer;
    function Peek: IInterface;
    function Pop: IInterface;
    procedure Push(const AIntf: IInterface);
    procedure Lock;
    procedure Unlock;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TStringInterfaceMap = class(TInterfacedObject, IStringInterfaceMap)
  private
    FMutex: TRecursiveMutex;
    FList: TStringList;
  protected
    procedure Put(Key: AnsiString; const Item: IInterface);
    function Get(Key: AnsiString): IInterface;
    procedure Clear();
    procedure Erase(const Key: AnsiString);
    procedure Delete(Index: Integer);
    function Count(): Integer;
    function IndexOf(const Item: IInterface): AnsiString;
    function Items(Index: integer): IInterface;
    procedure Lock;
    procedure Unlock;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  function long_interface_map: ILongInterfaceMap;
  function interface_long_map: IInterfaceLongMap;
  function interface_interface_map: IInterfaceInterfaceMap;
  function interface_stack: IInterfaceStack;

const
  SListIndexError = 'Invalid index';
  SListCapacityError = 'Capacity error';
  SListCountError = 'List error';
  REASONABLE_INT = 7;

implementation

//*********************************************************************
//   TMap
//*********************************************************************
destructor TMap.Destroy;
begin
  Clear;
end;

function TMap.count(): integer;
begin
  result := FCount;
end;

procedure TMap._Put(Key: DWORD;Item: DWORD);
var
  x,y : TLargeInt;
  ind : integer;
begin
  x.HighPart := Key;
  x.LowPart := Item;
  if FCount > 0 then
    begin
      ind := Find(0,FCount-1,Key);
      if (ind < FCount) then
        begin
          y.QuadPart := FList^[ind];
          if (DWORD(y.HighPart) = Key) then
            begin
              FList^[ind] := x.QuadPart;
              Exit;
            end;
        end;
    end
  else
    ind := 0;
  Insert(ind,x.QuadPart);
end;

procedure TMap.Clear;
begin
  SetCount(0);
  SetCapacity(0);
end;

procedure TMap.Delete(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then Error(SListIndexError, Index);
  Dec(FCount);
  if Index < FCount then
    System.Move(FList^[Index + 1], FList^[Index],
      (FCount - Index) * SizeOf(Comp));
end;

class procedure TMap.Error(const Msg: AnsiString; Data: Integer);

  function ReturnAddr: Pointer;
  asm
          MOV     EAX,[EBP+4]
  end;

begin
  raise EListError.CreateFmt(String(Msg), [Data]) at ReturnAddr;
end;

function TMap.Expand: TMap;
begin
  if FCount = FCapacity then Grow;
  Result := Self;
end;

procedure TMap.Grow;
var
  Delta: Integer;
begin
  if FCapacity > 64 then Delta := FCapacity div 4 else
    if FCapacity > 8 then Delta := 16 else
      Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

function TMap.Find(Start,Last,Key : DWORD): integer;
begin
  Result := Last;
  while True do
    begin
      Result := Last;
      if DWORD(FList^[Last] shr 32)  = Key then
        Break
      else if DWORD(FList^[Last] shr 32) < Key then
        begin
          Inc(Result);
          Break;
        end
      else if DWORD(FList^[Start] shr 32) >= Key then
        begin
          Result := Start;
          Break;
        end
      else if Start = Last then
        Break
      else
        begin
          Result := (Start+Last) div 2;
          if DWORD(FList^[Result] shr 32) <= Key then
            begin
              Dec(Last);
              Start := Result;
            end
          else
            begin
              Inc(Start);
              Last := Result - 1;
            end;
        end
    end;
end;

function TMap.Finda(Start,Last,Key : DWORD): integer;
asm
  push ebx
  push edi
  push esi
  mov esi,Start
  mov edi,Last
  mov ebx, Key
  mov ecx, [eax+4h] // FList
@@4:
  mov eax, [ecx+edi*8h+4h]
  cmp eax ,ebx
  je  @@1
  jl  @@2
  mov edx, [ecx+esi*8h+4h]
  cmp edx ,ebx
  jge @@3
  cmp esi,edi
  je @@1
  mov eax,esi
  add eax,edi
  sar eax,1
  mov edx, eax
  mov eax, [ecx+eax*8h+4h]
  cmp eax ,ebx
  jg  @@5
  dec edi
  mov esi, edx
  jmp @@4
@@5:
  inc esi
  dec edx
  mov edi,edx
  jmp @@4
@@3:
  mov edi,esi
  jmp @@1
@@2:
  inc edi
@@1:
  mov eax,edi
  pop esi
  pop edi
  pop ebx
end;

function TMap._Get(Key: DWORD): integer;
begin
  if FCount > 0 then
    begin
      Result := Find(0,FCount-1,Key);
      if (Result >= FCount) or (DWORD(FList^[Result] shr 32) <> Key) then
        Result := -1;
    end
  else
    Result := -1;
end;

function TMap.IndexOf(Item: DWORD): Integer;
begin
  Result := 0;
  while (Result < FCount) and ((FList^[Result] and $FFFFFFFF) <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

procedure TMap.Insert(Index: Integer; Item: Comp);
begin
  if (Index < 0) or (Index > FCount) then Error(SListIndexError, Index);
  if FCount = FCapacity then Grow;
  if Index < FCount then
    System.Move(FList^[Index], FList^[Index + 1],
      (FCount - Index) * SizeOf(Comp));
  FList^[Index] := Item;
  Inc(FCount);
end;

function TMap.Remove(Key: DWORD): Integer;
begin
  Result := Find(0,FCount-1,Key);
  if (Result <> -1) and (DWORD(FList^[Result] shr 32) = Key) then
    Delete(Result)
  else
    Result := -1;
end;

procedure TMap.Pack;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do if (FList^[I] and $FFFFFFFF) = 0 then Delete(I);
end;

procedure TMap.SetCapacity(NewCapacity: Integer);
begin
  if (NewCapacity < FCount) or (NewCapacity > MaxListSize) then
    Error(SListCapacityError, NewCapacity);
  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(Comp));
    FCapacity := NewCapacity;
  end;
end;

procedure TMap.SetCount(NewCount: Integer);
begin
  if (NewCount < 0) or (NewCount > MaxListSize) then
    Error(SListCountError, NewCount);
  if NewCount > FCapacity then SetCapacity(NewCount);
  if NewCount > FCount then
    FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(Comp), 0);
  FCount := NewCount;
end;

//*********************************************************************
//  TLongInterfaceMap
//*********************************************************************
function TLongInterfaceMap.Get(Key: _ulong): IUnknown;
var
  ind : integer;
begin
  result := nil;
  ind := _Get(key);
  if ind >= 0 then
    result := IUnknown(Pointer(FList^[ind] and $FFFFFFFF));
end;

function TLongInterfaceMap.IndexOf(Item: IUnknown): integer;
begin
  result := inherited IndexOf(DWORD(Pointer(Item)));
end;

procedure TLongInterfaceMap.Put(Key: _ulong; Item: IUnknown);
var
  x,y : TLargeInt;
  ind : integer;
begin
  x.HighPart := Key;
  x.LowPart := DWORD(Pointer(Item));
  if FCount > 0 then
    begin
      ind := Find(0,FCount-1,Key);
      if (ind < FCount) then
        begin
          y.QuadPart := FList^[ind];
          if (DWORD(y.HighPart) = Key) then
            begin
              if y.LowPart <> 0 then
                IUnknown(Pointer(y.LowPart))._Release;
              if Item <> nil then
                Item._AddRef;
              FList^[ind] := x.QuadPart;
              Exit;
            end;
        end;
    end
  else
    ind := 0;
  Insert(ind,x.QuadPart);
  Item._AddRef;
end;

procedure TLongInterfaceMap.clear();
var
  i : integer;
begin
  for i := 0 to Pred(FCount) do
    if (FList^[i] and $FFFFFFFF) <> 0 then
      IUnknown(Pointer((FList^[i] and $FFFFFFFF)))._Release;
  inherited clear();
end;

procedure TLongInterfaceMap.erase(Key: _ulong);
var
  idx: integer;
begin
  //self.Remove(Key);
  idx := _Get(key);
  if idx >= 0 then
    Delete(idx);
end;

procedure TLongInterfaceMap.Delete(Index: Integer);
begin
  if (FList^[Index] and $FFFFFFFF) <> 0 then
    IUnknown(Pointer((FList^[Index] and $FFFFFFFF)))._Release;
  inherited Delete(Index);
end;

function TLongInterfaceMap.Items(Index: integer): IUnknown;
begin
  result := nil;
  if Index < FCount then
    result := IUnknown(Pointer((FList^[Index] and $FFFFFFFF)))
  else
    Error(SListIndexError, Index);
end;

//***************************************************************
// TLongObjectMap 
//***************************************************************
procedure TLongObjectMap.clear;
var
  i : integer;
begin
  for i := 0 to Pred(FCount) do
    if (FList^[i] and $FFFFFFFF) <> 0 then
      TObject(Pointer((FList^[i] and $FFFFFFFF))).Free;
  inherited clear();
end;

procedure TLongObjectMap.Delete(Index: Integer);
begin
  if (FList^[Index] and $FFFFFFFF) <> 0 then
    TObject(Pointer((FList^[Index] and $FFFFFFFF))).Free;
  inherited Delete(Index);
end;

procedure TLongObjectMap.erase(Key: long);
var
  idx: integer;
begin
  idx := _Get(key);
  if idx >= 0 then
    Delete(idx);
end;

function TLongObjectMap.Get(Key: long): TObject;
var
  ind : integer;
begin
  result := nil;
  ind := _Get(key);
  if ind >= 0 then
    result := TObject(Pointer(FList^[ind] and $FFFFFFFF));
end;

function TLongObjectMap.IndexOf(Item: TObject): integer;
begin
  result := inherited IndexOf(DWORD(Pointer(Item)));
end;

function TLongObjectMap.Items(Index: integer): TObject;
begin
  result := nil;
  if Index < FCount then
    result := TObject(Pointer((FList^[Index] and $FFFFFFFF)))
  else
    Error(SListIndexError, Index);
end;

procedure TLongObjectMap.Put(Key: long; Item: TObject);
var
  x,y : TLargeInt;
  ind : integer;
begin
  x.HighPart := Key;
  x.LowPart := DWORD(Pointer(Item));
  if FCount > 0 then
    begin
      ind := Find(0,FCount-1,Key);
      if (ind < FCount) then
        begin
          y.QuadPart := FList^[ind];
          if (DWORD(y.HighPart) = DWORD(Key)) then
            begin
              if y.LowPart <> 0 then
                TObject(Pointer(y.LowPart)).Free;
              FList^[ind] := x.QuadPart;
              Exit;
            end;
        end;
    end
  else
    ind := 0;
  Insert(ind,x.QuadPart);
end;

//***************************************************************
// TInterfaceKeyMap
//***************************************************************
procedure TInterfaceLongMap.clear;
var
  i : integer;
begin
  for i := 0 to Pred(FCount) do
    if (FList^[i] shr 32) <> 0 then
      IUnknown(Pointer((FList^[i] shr 32)))._Release;
  inherited clear();
end;

procedure TInterfaceLongMap.Delete(Index: Integer);
begin
  if (FList^[Index] shr 32) <> 0 then
    IUnknown(Pointer((FList^[Index] shr 32)))._Release;
  inherited Delete(Index);
end;

procedure TInterfaceLongMap.erase(Key: IInterface);
var
  ind : integer;
begin
  ind := _Get(DWORD(Pointer(key)));
  if ind >= 0 then
    Delete(ind);
end;

function TInterfaceLongMap.Get(Key: IUnknown): long;
var
  ind : integer;
begin
  result := 0;
  ind := _Get(DWORD(Pointer(key)));
  if ind >= 0 then
    result := FList^[ind] and $FFFFFFFF;
end;

function TInterfaceLongMap.IndexOf(Key: IUnknown): integer;
begin
  result := _Get(DWORD(Pointer(key)));
end;

procedure TInterfaceLongMap.Put(Key: IUnknown; Item: long);
var
  x,y : TLargeInt;
  ind : integer;
begin
  x.HighPart := DWORD(Pointer(Key));
  x.LowPart := Item;
  if FCount > 0 then
    begin
      ind := Find(0,FCount-1,DWORD(Pointer(Key)));
      if (ind < FCount) then
        begin
          y.QuadPart := FList^[ind];
          if (DWORD(y.HighPart) = DWORD(Pointer(Key))) then
            begin
              FList^[ind] := x.QuadPart;
              Exit;
            end;
        end;
    end
  else
    ind := 0;
  Insert(ind,x.QuadPart);
  Key._AddRef;
end;

{ TInterfaceInterfaceMap }

function TInterfaceInterfaceMap.Get(Key: IUnknown): IUnknown;
var
  ind : integer;
begin
  result := nil;
  ind := _Get(DWORD(Pointer(key)));
  if ind >= 0 then
    result := IUnknown(Pointer(FList^[ind] and $FFFFFFFF));
end;

function TInterfaceInterfaceMap.IndexOf(Key: IUnknown): integer;
begin
  result := _Get(DWORD(Pointer(key)));
end;

procedure TInterfaceInterfaceMap.erase(Key: IUnknown);
var
  i : integer;
begin
  i := IndexOf(key);
  if i >= 0 then Delete(i)
end;

procedure TInterfaceInterfaceMap.Put(Key, Item: IUnknown);
var
  x,y : TLargeInt;
  ind : integer;
  tmp : IUnknown;
begin
  x.HighPart := LongInt(Pointer(Key));
  x.LowPart := DWORD(Pointer(Item));
  if FCount > 0 then
    begin
      ind := Find(0,FCount-1,DWORD(Pointer(Key)));
      if (ind < FCount) then
        begin
          y.QuadPart := FList^[ind];
          if (DWORD(y.HighPart) = DWORD(Pointer(Key))) then
            begin
              tmp := IUnknown(Pointer(FList^[ind] and $FFFFFFFF));
              if tmp <> nil then
                tmp._Release;
              if item <> nil then Item._AddRef;
              FList^[ind] := x.QuadPart;
              Exit;
            end;
        end;
    end
  else
    ind := 0;
  Insert(ind,x.QuadPart);
  Key._AddRef;
  if Item <> nil then
    Item._AddRef;
end;

procedure TInterfaceInterfaceMap.clear();
var
  i : integer;
begin
  for i := 0 to Pred(FCount) do
    begin
      if (FList^[i] shr 32) <> 0 then
        IUnknown(Pointer((FList^[i] shr 32)))._Release;
      if (FList^[i] and $FFFFFFFF) <> 0 then
        IUnknown(Pointer(FList^[i] and $FFFFFFFF))._Release;
    end;
  inherited clear();
end;

procedure TInterfaceInterfaceMap.Delete(Index: Integer);
begin
  if (FList^[Index] shr 32) <> 0 then
    IUnknown(Pointer((FList^[Index] shr 32)))._Release;
  if (FList^[Index] and $FFFFFFFF) <> 0 then
    IUnknown(Pointer(FList^[Index] and $FFFFFFFF))._Release;
  inherited Delete(Index);
end;

function TInterfaceInterfaceMap.Second(Index: Integer): IUnknown;
begin
  result := IUnknown(Pointer(FList^[Index] and $FFFFFFFF))
end;

function TInterfaceInterfaceMap.Find(Key: IInterface): IInterface;
var
  i: integer;
  intf: IInterface;
begin
  if not Assigned(FCompareFunc) then
    Exit;
  i := 0;
  while (i < FCount) do begin
    if (FList^[i] shr 32) <> 0 then begin
      intf := IInterface(Pointer((FList^[i] shr 32)));
      if FCompareFunc(intf, Key) then begin
        result := IInterface(Pointer(FList^[i] and $FFFFFFFF));
        Break;
      end;
    end;
    i := Succ(i);
  end; { while }
end;

procedure TInterfaceInterfaceMap.SetCompareFunc(
  AFunc: TInterfaceInterfaceMapCompare);
begin
  FCompareFunc := AFunc;
end;

{ TInterfaceStack }

function TInterfaceStack.Count: integer;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  result := FStack.Count;
end;

constructor TInterfaceStack.Create;
begin
  inherited;
  FMutex := TRecursiveMutex.Create;
  FStack := TStack.Create;
end;

destructor TInterfaceStack.Destroy;
begin
  FreeAndNil(FMutex);
  FreeAndNil(FStack);
  inherited;
end;

procedure TInterfaceStack.Lock;
begin
  FMutex.lock;
end;

function TInterfaceStack.Peek: IInterface;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  result := IInterface(FStack.Peek);
end;

function TInterfaceStack.Pop: IInterface;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  result := IInterface(FStack.Pop);
  result._Release;
end;

procedure TInterfaceStack.Push(const AIntf: IInterface);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  AIntf._AddRef;
  FStack.Push(Pointer(AIntf));
end;

procedure TInterfaceStack.Unlock;
begin
  FMutex.unlock;
end;

{ TStringInterfaceMap }

procedure TStringInterfaceMap.Clear;
var
  sync: ISynchronized;
  i: Integer;
begin
  sync := TSynchronized.Create(FMutex);
  for i := 0 to FList.Count - 1 do
    IInterface(Pointer(FList.Objects[i]))._Release;
  FList.Clear;
end;

function TStringInterfaceMap.Count: Integer;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  Result := FList.Count;
end;

constructor TStringInterfaceMap.Create;
begin
  FMutex := TRecursiveMutex.Create;
  FList := TStringList.Create;
end;

procedure TStringInterfaceMap.Delete(Index: Integer);
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  IInterface(Pointer(FList.Objects[Index]))._Release;
  FList.Delete(Index);
end;

destructor TStringInterfaceMap.Destroy;
begin
  Clear;
  FList.Free;
  FMutex.Free;
  inherited;
end;

procedure TStringInterfaceMap.Erase(const Key: AnsiString);
var
  sync: ISynchronized;
  idx: Integer;
begin
  sync := TSynchronized.Create(FMutex);
  idx := FList.IndexOf(String(Key));
  if idx <> -1 then begin
    IInterface(Pointer(FList.Objects[idx]))._Release;
    FList.Delete(idx);
  end;
end;

function TStringInterfaceMap.Get(Key: AnsiString): IInterface;
var
  sync: ISynchronized;
  idx: Integer;
begin
  sync := TSynchronized.Create(FMutex);
  idx := FList.IndexOf(String(Key));
  if idx <> -1 then
    Result := IInterface(Pointer(FList.Objects[idx]));
end;

function TStringInterfaceMap.IndexOf(const Item: IInterface): AnsiString;
var
  sync: ISynchronized;
  i: Integer;
begin
  sync := TSynchronized.Create(FMutex);
  for i := 0 to FList.Count -1 do
    if IInterface(Pointer(FList.Objects[i])) = Item then begin
      Result := AnsiString(FList[i]);
      Break;
    end;
end;

function TStringInterfaceMap.Items(Index: integer): IInterface;
var
  sync: ISynchronized;
begin
  sync := TSynchronized.Create(FMutex);
  Result := IInterface(Pointer(FList.Objects[Index]));
end;

procedure TStringInterfaceMap.Lock;
begin
  FMutex.lock;
end;

procedure TStringInterfaceMap.Put(Key: AnsiString;
  const Item: IInterface);
var
  sync: ISynchronized;
  idx: Integer;
begin
  sync := TSynchronized.Create(FMutex);
  Item._AddRef;
  idx := FList.IndexOf(String(Key));
  if idx <> -1 then begin
    IInterface(Pointer(FList.Objects[idx]))._Release;
    FList.Objects[idx] := Pointer(Item);
  end
  else
    FList.AddObject(String(Key), Pointer(Item));
end;

procedure TStringInterfaceMap.Unlock;
begin
  FMutex.unlock;
end;

{ Helper functions }

function long_interface_map: ILongInterfaceMap;
begin
  result := TLongInterfaceMap.Create;
end;

function interface_long_map: IInterfaceLongMap;
begin
  result := TInterfaceLongMap.Create;
end;

function interface_interface_map: IInterfaceInterfaceMap;
begin
  result := TInterfaceInterfaceMap.Create;
end;

function interface_stack: IInterfaceStack;
begin
  result := TInterfaceStack.Create;
end;

{$IFDEF LIBRARY}
exports
  long_interface_map,
  interface_long_map,
  interface_interface_map,
  interface_stack;
{$ENDIF}
{$ELSE}
  function long_interface_map: ILongInterfaceMap; external MTDORB_Library_Name;
  function interface_long_map: IInterfaceLongMap; external MTDORB_Library_Name;
  function interface_interface_map: IInterfaceInterfaceMap; external MTDORB_Library_Name;
  function interface_stack:IInterfaceStack ; external MTDORB_Library_Name;
implementation
{$ENDIF}
end.
