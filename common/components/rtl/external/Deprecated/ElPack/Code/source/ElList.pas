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

unit ElList;

interface

uses
    SysUtils,
    {$IFNDEF VCL_5_USED}
    ElVCLUtils, // FreeAndNil
    {$ENDIF}
    Classes,
    ElContBase,
    ElTools;

const AlignMem    =   $500; // Align at 1280 items

type
  TElListSortCompare = function(Item1,
                                Item2: TxListItem;
                                Cargo: TxListItem): Integer;

  TElListSortCompareEx = function(Item1,
                                  Item2: TxListItem;
                                  Cargo: TxListItem): Integer of object;


  TElListDeleteEvent = procedure (Sender: TObject; Item: TxListItem) of object;

    PElPointerList = ^TElPointerList;
    TElPointerList = array[0..MaxListSize - 1] of TxListItem;

  {:
  }
  TElList = class (TPersistent)
  protected
    FAutoClearObjects: Boolean;
    FCapacity: Integer;
    FCount: Integer;
    FList: PElPointerList;
    FOnDelete: TElListDeleteEvent;
    class procedure Error(const Msg: string; Data: Integer);
    function Get(Index: Integer): TxListItem; virtual;
    procedure Grow; virtual;
    procedure Put(Index: Integer; const Item: TxListItem); virtual;
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
    procedure IntDelete(Index: Integer);
    procedure TriggerDeleteEvent(const Item: TxListItem); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CheckRange(Index: Integer);
    function FastGet(Index: Integer): TxListItem;
    function Add(const Item: TxListItem): Integer;
    procedure Assign(Source : TPersistent); override;
    procedure Clear; virtual;
    procedure Delete(Index: Integer); virtual;
    procedure DeleteRange(StartIndex, EndIndex: Integer); virtual;
    procedure Exchange(Index1, Index2: Integer);
    function Expand: TElList;
    function First: TxListItem;
    function IndexOf(const Item: TxListItem): Integer;
    function IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
    function IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
    procedure Insert(Index: Integer; const Item: TxListItem);
    function Last: TxListItem;
    procedure Move(CurIndex, NewIndex: Integer);
    procedure MoveRange(CurStart, CurEnd, NewStart: integer);
    procedure Pack;
    function Remove(const Item: TxListItem): Integer;
    procedure Sort(Compare: TElListSortCompare; const Cargo: TxListItem);
    procedure SortC(Compare: TElListSortCompareEx; const Cargo: TxListItem);
    property AutoClearObjects: Boolean read FAutoClearObjects write
        FAutoClearObjects;
    property Capacity: Integer read FCapacity write SetCapacity;
    property Count: Integer read FCount write SetCount;
    property Items[Index: Integer]: TxListItem read Get write Put; default;
    {.$ifndef BUILDER_USED}
      property List: PElPointerList read FList;
    {.$endif}
    property OnDelete: TElListDeleteEvent read FOnDelete write FOnDelete;
  end;

implementation

type
  {:
  }
  EElListError = class (Exception)
  end;


//T & R
{$ifdef D_3_UP}
resourcestring
{$else}
const
{$endif}
  rs_ListIndexOutOfBounds = 'List index [%d] out of bounds...';

procedure RaiseOutOfBoundsError(Ind: integer);
begin
  raise EelListError.CreateFmt(rs_ListIndexOutOfBounds, [Ind]);
end;

procedure QuickSortC(SortList: PElPointerList; L, R: Integer;
  SCompare: TelListSortCompareEx; const Cargo: TxListItem);
var
  I, J : Integer;
  P, T : TxListItem;
begin
  repeat
    I := L;
    J := R;
    //vAd: old: P := SortList^[(L + R) shr 1];
    // remove all ^
    P := SortList[(L + R) shr 1];
    repeat
      while SCompare(SortList[I], P, Cargo) < 0 do
        Inc(I);
      while SCompare(SortList[J], P, Cargo) > 0 do
        Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
          T := SortList[I];
          SortList[I] := SortList[J];
          SortList[J] := T;
        end;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSortC(SortList, L, J, SCompare, Cargo);
    L := I;
  until I >= R;
end;

procedure QuickSort(SortList: PElPointerList; L, R: Integer;
  SCompare: TelListSortCompare; const Cargo: TxListItem);
var
  I, J : Integer;
  P, T : TxListItem;
begin
  repeat
    I := L;
    J := R;
    P := SortList[(L + R) shr 1];

    repeat

      // rI := SCompare(SortList^[I], P, Cargo);
      while SCompare(SortList[I], P, Cargo) < 0 do
        Inc(I);

      // rJ := SCompare(SortList^[J], P, Cargo);
      while SCompare(SortList[J], P, Cargo) > 0 do
        Dec(J);

      if I <= J then
      begin

        if I <> J then
        begin
          T := SortList[I];
          SortList[I] := SortList[J];
          SortList[J] := T;
        end;

        Inc(I);
        Dec(J);
      end;
    until I > J;

    if L < J then QuickSort(SortList, L, J, SCompare, Cargo);

    L := I;
  until I >= R;
end;

{:
}
{:
}
{
*********************************** TElList ************************************
}
constructor TElList.Create;
begin
  inherited;
  FList := nil;
  FCount := 0;
  FCapacity := 0;
  FAutoClearObjects := FALSE;
  FOnDelete := nil;
end;

destructor TElList.Destroy;
begin
  Clear;
  inherited;
end;

function TElList.Add(const Item: TxListItem): Integer;
begin
  if FCount = FCapacity then
  begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  end;
  FList[FCount] := Item;
  Result := FCount;
  Inc(FCount);
end;

procedure TElList.Assign(Source : TPersistent);
begin
  if Source is TElList then
  begin
    Clear;
    SetCapacity(TElList(Source).Capacity);
    SetCount(TElList(Source).Count);
    if FCount > 0 then
         System.Move(TElList(Source).FList^[0], FList^[0], FCount * sizeof(TxListItem));
  end else inherited;
end;

procedure TElList.Clear;
var
  I: Integer;
  P: TxListItem;
begin
  for I := 0 to Count - 1 do
     TriggerDeleteEvent(FList[I]);
  if AutoClearObjects then
    for I := 0 to FCount - 1 do
    begin
        p := Get(i);
        try
          if (P <> nil) and (TObject(P) is TObject)
            then TObject(P).Free;
        except
        end;
    end;
  // Don't call two routines for this. Just assign
  FCount := 0;
  FCapacity := 0;
    ReallocMem(FList, 0);
end;

procedure TElList.IntDelete(Index: Integer);
begin
  CheckRange(Index);
  Dec(FCount);
  if Index < FCount then
      System.Move(FList[Index + 1],
                  FList[Index],
                  (FCount - Index) * SizeOf(TxListItem));
end;

procedure TElList.DeleteRange(StartIndex, EndIndex: Integer);
var i : integer;
begin
  CheckRange(StartIndex);
  CheckRange(EndIndex);
  if (EndIndex < StartIndex) then
    RaiseOutOfBoundsError(EndIndex);
  for i := StartIndex to EndIndex do
    TriggerDeleteEvent(FList[I]);
  if (FCount > EndIndex + 1) then
      System.Move(FList[EndIndex + 1],
                  FList[StartIndex],
                  (FCount - (EndIndex - StartIndex + 1)) * SizeOf(TxListItem));
  Dec(FCount, EndIndex - StartIndex + 1);
  if FCount < FCapacity shr 1 then
  begin
    FCapacity := FCapacity shr 1;
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  end;
end;

procedure TElList.Delete(Index: Integer);
begin
  CheckRange(Index);

  if Assigned(FList[Index]) then
    begin
      TriggerDeleteEvent(FList[Index]);
      if AutoClearObjects then
        FreeAndNil(TObject(FList[Index]));
    end;

  Dec(FCount);
  if FCount > Index then
      System.Move(FList[Index + 1],
                  FList[Index],
                  (FCount - Index) * SizeOf(TxListItem));
  if FCount < FCapacity shr 1 Then
  begin
    FCapacity := FCapacity shr 1;
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  end;
end;

class procedure TElList.Error(const Msg: string; Data: Integer);

  function ReturnAddr: TxListItem;
  asm
    MOV     EAX,[EBP+4]
  end;

begin
  raise EElListError.CreateFmt(Msg, [Data])at ReturnAddr;
end;

procedure TElList.CheckRange(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    RaiseOutOfBoundsError(Index);
end;

procedure TElList.Exchange(Index1, Index2: Integer);
var
  Item: TxListItem;
begin
  CheckRange(Index1);
  CheckRange(Index2);

  Item := FList[Index1];
  FList[Index1] := FList[Index2];
  FList[Index2] := Item;
end;

function TElList.Expand: TElList;
begin
  if FCount = FCapacity then
  begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
      ReallocMem(FList, FCapacity * SizeOf(TxListItem));
  end;
  Result := Self;
end;

function TElList.First: TxListItem;
begin
  CheckRange(0);

  Result := FList[0];
end;

function TElList.FastGet(Index: Integer): TxListItem;
begin
  CheckRange(Index);

  Result := FList[Index];
end;

function TElList.Get(Index: Integer): TxListItem;
begin
  CheckRange(Index);

  Result := FList[Index];
end;

procedure TElList.Grow;
begin
  Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
    ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
end;

function TElList.IndexOf(const Item: TxListItem): Integer;
begin
  Result := 0;
  // TODO: rewrite in assembler
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

function TElList.IndexOfBack(StartIndex: integer; const Item: TxListItem): Integer;
begin
  CheckRange(StartIndex);

  Result := StartIndex;
  while (Result >= 0) and (FList[Result] <> Item) do
    dec(Result);
end;

function TElList.IndexOfFrom(StartIndex: integer; const Item: TxListItem): Integer;
begin
  CheckRange(StartIndex);

  Result := StartIndex;
  while (Result < FCount) and (FList[Result] <> Item) do
    Inc(Result);
  if Result = FCount then
    Result := -1;
end;

procedure TElList.Insert(Index: Integer; const Item: TxListItem);
begin
  if (Index < 0) or (Index > FCount) then
    RaiseOutOfBoundsError(Index);

  if FCount = FCapacity then
  Begin
    Inc(FCapacity, Min(Count * 2 + 1, AlignMem));
      ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
  End;
  // if Index < FCount then == Useless. See first line.
    System.Move(FList^[Index],
                FList^[Index + 1],
                (FCount - Index) * SizeOf(TxListItem));
  FList[Index] := Item;
  Inc(FCount);
end;

function TElList.Last: TxListItem;
begin
  if FCount = 0 then
    Result := nil
  else
    Result := FList[FCount-1];
end;

procedure TElList.Move(CurIndex, NewIndex: Integer);
var
  Item: TxListItem;
begin
  if CurIndex <> NewIndex then
  begin
    CheckRange(CurIndex);
    CheckRange(NewIndex);

    Item := FList[CurIndex];

      if NewIndex<CurIndex then
        // Shift Left
        System.Move(FList[NewIndex],
                    FList[NewIndex+1],
                    (CurIndex-NewIndex) * SizeOf(TxListItem))
      else
        // Shift Right
        System.Move(FList[CurIndex+1],
                    FList[CurIndex],
                    (NewIndex-CurIndex) * SizeOf(TxListItem));
      FList[NewIndex] := Item;
  end;
end;

procedure TElList.MoveRange(CurStart, CurEnd, NewStart: integer);
var
  bs: Integer;
  P: PChar;
begin
  if CurStart <> NewStart then
  begin
    CheckRange(CurStart);
    CheckRange(CurEnd);
    CheckRange(NewStart);

    if ((NewStart >= CurStart) and (NewStart <= CurEnd)) then // vAd: shift without overhead diapasone
      RaiseOutOfBoundsError(NewStart);

    if CurStart > NewStart then
    begin
      bs := CurEnd - CurStart + 1;
        GetMem(P, bs * SizeOf(TxListItem));
        System.Move(FList^[CurStart], P^, BS * SizeOf(TxListItem));
        System.Move(FList^[NewStart], FList^[NewStart + BS], (CurStart -
            NewStart) * SizeOf(TxListItem));
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
    end else
    begin
      bs := CurEnd - CurStart + 1;
        GetMem(P, BS * SizeOf(TxListItem));
        System.Move(FList^[CurStart], P^, BS * SizeOf(TxListItem));
        System.Move(FList^[CurEnd + 1], FList^[CurStart], (NewStart - CurEnd) *
            SizeOf(TxListItem));
        NewStart := CurStart - 1 + NewStart - CurEnd;
        System.Move(P^, FList^[NewStart], BS * SizeOf(TxListItem));
        FreeMem(P);
    end;
  end;
end;

procedure TElList.Pack;
var
  I: Integer;
begin
  for I := FCount - 1 downto 0 do
    if Items[I] = nil then
      Delete(I);
end;

procedure TElList.Put(Index: Integer; const Item: TxListItem);
begin
  CheckRange(Index);

  if Assigned(FList[Index]) then
    begin
      TriggerDeleteEvent(FList[Index]);
      if AutoClearObjects then
        FreeAndNil(TObject(FList[Index]));
    end;

  FList[Index] := Item;
end;

function TElList.Remove(const Item: TxListItem): Integer;
begin
  Result := IndexOf(Item);
  // changed by chmv. if Result <> -1 then
  if Result >= 0 then
  begin
    TriggerDeleteEvent(FList[Result]);
    Dec(FCount);
    // if Index < FCount then == Useless. See above.
      System.Move(FList^[Result + 1],
                  FList^[Result],
                  (FCount - Result) * SizeOf(TxListItem));
    if FCount < FCapacity shr 1 then
    begin
      FCapacity := FCapacity shr 1;
        ReAllocMem(FList, FCapacity * SizeOf(TxListItem));
    end;
  end;
end;

procedure TElList.SetCapacity(NewCapacity: Integer);
begin

  if (NewCapacity < FCount)
     or
     (NewCapacity > MaxListSize)
  then
    RaiseOutOfBoundsError(NewCapacity);

  if NewCapacity <> FCapacity then
  begin
      ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    FCapacity := NewCapacity;
  end;
end;

procedure TElList.SetCount(NewCount: Integer);
begin
  if (NewCount < 0)
     or
     (NewCount > MaxListSize)
  then
    RaiseOutOfBoundsError(NewCount);
  if NewCount > FCapacity then
    SetCapacity(NewCount);
  if NewCount > FCount then
      FillChar(FList^[FCount], (NewCount - FCount) * SizeOf(TxListItem), 0);
  FCount := NewCount;
end;

procedure TElList.Sort(Compare: TElListSortCompare; const Cargo: TxListItem);
begin
  if 
     (FList <> nil)
     and
     (Count > 0)
  then
    QuickSort(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TElList.SortC(Compare: TElListSortCompareEx; const Cargo: TxListItem);
begin
  if 
     (FList <> nil)
     and
     (Count > 0)
  then
    QuickSortC(FList, 0, Count - 1, Compare, Cargo);
end;

procedure TElList.TriggerDeleteEvent(const Item: TxListItem);

  { Triggers the OnDelete event. This is a virtual method (descendants of this
      component can override it). }

begin
  if (Assigned(FOnDelete)) then
    FOnDelete(Self, Item);
end;


end.
