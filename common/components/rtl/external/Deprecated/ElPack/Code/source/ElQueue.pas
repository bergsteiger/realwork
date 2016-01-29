
{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

unit ElQueue;

interface

uses
     classes,
     ElContBase,
{$ifndef KYLIX_USED}
     Windows,
{$else}
     Libc,
{$endif}
     SysUtils
;

type
  EElQueueError = class(Exception)
  end;

  OnDiscardEvent = procedure(Sender : TObject; Item : TxListItem) of object;

type
  TElQueue = class(TObject)
  private
     FList :PPointerList;
    FCount : Integer;
    FCapacity : Integer;
    FOnDiscard : OnDiscardEvent;
  protected
    function Get(Index : Integer) : TxListItem;
    procedure SetCapacity(NewCapacity : Integer);
    procedure SetCount(NewCount : Integer);
  public
    destructor Destroy; override;
    function Add(Item : TxListItem) : Integer;
    procedure Delete(Index : Integer);
    procedure Clear;
    class procedure Error(const Msg : string; Data : Integer); virtual;
    procedure Exchange(Index1, Index2 : Integer);
    function First : TxListItem;
    function IndexOf(Item : TxListItem) : Integer;
    function Last : TxListItem;
    property Capacity : Integer read FCapacity write SetCapacity;
    property Count : Integer read FCount write SetCount;
    property Items[Index : Integer] : TxListItem read Get; default;
     property List : PPointerList read FList;
    property OnDiscard : OnDiscardEvent read FOnDiscard write FOnDiscard;
  end;

implementation

destructor TElQueue.Destroy;
begin
  Clear;
  SetCapacity(0);
  inherited;
end;

function TElQueue.Add(Item : TxListItem) : Integer;
begin
  result := -1;
  if Capacity = 0 then exit;
  if FCount = FCapacity then
  begin
    if Assigned(FOnDiscard) then FOnDiscard(Self, Items[0]);
    Delete(0);
  end;
  Result := FCount;
   FList^[Result] := Item;
  Inc(FCount);
end;

procedure TElQueue.Clear;
begin
  SetCount(0);
  //SetCapacity(0);
end;

procedure TElQueue.Delete(Index : Integer);
begin
  if (Index < 0) or (Index >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
  Dec(FCount);
  if Index < FCount then
     System.Move( FList^[Index + 1], FList^[Index], (FCount - Index) * SizeOf(TxListItem) );
  if FCount < (FCapacity div 2) then SetCapacity(FCapacity div 2);
end;

class procedure TElQueue.Error(const Msg : string; Data : Integer);
  function ReturnAddr : TxListItem;
  asm
          MOV     EAX,[EBP+4]
  end;
begin
  raise EListError.CreateFmt(Msg, [Data])  at ReturnAddr ;
end;

procedure TElQueue.Exchange(Index1, Index2 : Integer);
var
  Item : TxListItem;
begin
  if (Index1 < 0) or (Index1 >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
  if (Index2 < 0) or (Index2 >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
   Item := FList^[Index1];
   FList^[Index1] := FList^[Index2];
   FList^[Index2] := Item;
end;

function TElQueue.First : TxListItem;
begin
  Result := Get(0);
end;

function TElQueue.Get(Index : Integer) : TxListItem;
begin
  if (Index < 0) or (Index >= FCount) then raise EElQueueError.Create('Queue index out of bounds');
   Result := FList^[Index];
end;

function TElQueue.IndexOf(Item : TxListItem) : Integer;
begin
  Result := 0;
  while (Result < FCount) and (FList^[Result] <> Item) do
    Inc(Result);
  if Result = FCount then Result := -1;
end;

function TElQueue.Last : TxListItem;
begin
  if FCount = 0 then
     result := nil
  else
    Result := Get(FCount - 1);
end;

procedure TElQueue.SetCapacity(NewCapacity : Integer);
begin
  if (NewCapacity > MaxListSize) then
    raise EElQueueError.Create('Queue index out of bounds');
  if NewCapacity > FCapacity then
  begin
     ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    FCapacity := NewCapacity;
  end
  else if NewCapacity < FCapacity then
  begin
{$ifndef KYLIX_USED}
     //procedure MoveMemory(Destination: TxListItem; Source: TxListItem; Length: DWORD);
     MoveMemory(FList, @(FList[FCapacity - NewCapacity]), (NewCapacity) * SizeOf(TxListItem));
{$else}
    memmove(FList, @(FList[FCapacity - NewCapacity]),
      (NewCapacity) * SizeOf(TxListItem));
{$endif}
     ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    FCapacity := NewCapacity;
    if FCapacity = 0 then FList := nil;
  end;
end;

procedure TElQueue.SetCount(NewCount : Integer);
begin
  if (NewCount < 0)
     or (NewCount > MaxListSize)
  then
    raise EElQueueError.Create('Queue index out of bounds');
  if NewCount > FCapacity then SetCapacity(NewCount);
  if NewCount > FCount then
     FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(TxListItem), 0);
  FCount := NewCount;
end;

end.
