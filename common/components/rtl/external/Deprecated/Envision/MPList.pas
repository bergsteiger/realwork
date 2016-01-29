unit MPList;

{$I MPC.INC}
{$R-} { range checking must be off here }

interface

uses
  Classes;

type
  TMPSortedStringList = class(TStringList)
    public
      constructor Create;
  end;

  { this class DOES NOT dispose of its objects when freed }
  TMPObjectList = class(TList)
    protected
      function GetObject(Index: integer): TObject;
      procedure SetObject(Index: integer; Value: TObject);

    public
      function First: TObject;
      function Last: TObject;
      property Objects[Index: integer]: TObject read GetObject write SetObject;
  end;

  { This class disposes of its objects when freed. To remove an object without freeing it, set the object to nil
    and then delete it. }
  TMPOwnedObjectList = class(TMPObjectList)
    private
      procedure FreeObject(Index: integer);

    protected
      procedure SetCount(Value: integer);

    public
      destructor Destroy; override;
      procedure Clear;
      procedure Delete(Index: integer);
      property Count write SetCount;
  end;

  TMPPackProc = procedure(Index: longint) of object;

(*
  TMPCustomLongList = class(TObject)
    private
      FList: pointer;
      FCount: longint;
      FCapacity: longint;

    protected
      procedure ReAllocList(NewCapacity: longint); virtual;
      procedure CheckIndex(Index: longint); virtual;
      function ExpandSize: longint; virtual;
      function GetItem(Index: longint): pointer; virtual;
      procedure SetItem(Index: longint; Value: pointer); virtual;
      procedure SetCapacity(NewCapacity: longint); virtual;
      procedure SetCount(NewCount: longint); virtual;
      procedure DoPack(PackProc: TMPPackProc);
      property Items[Index: longint]: pointer read GetItem write SetItem;

    public
      destructor Destroy; override;
      function Add(Item: pointer): longint; virtual;
      procedure Clear; virtual;
      function Delete(Index: longint): pointer; virtual;
      procedure Exchange(i1, i2: longint); virtual;
      function Expand: TMPCustomLongList;
      function First: pointer;
      function IndexOf(Item: pointer): longint; virtual;
      procedure Insert(Index: longint; Item: pointer); virtual;
      function Last: pointer;
      procedure Move(CurIndex, NewIndex: longint); virtual;
      procedure Pack;
      function Remove(Item: pointer): longint; virtual;
      property Capacity: longint read FCapacity write SetCapacity;
      property Count: longint read FCount write SetCount;
    end;

  TMPLongList = class(TMPCustomLongList)
    public
      property Items; default;
  end;

  { this class DOES NOT dispose of it's objects when freed }
  TMPObjectLongList = class(TMPCustomLongList)
    protected
      function GetObject(Index: longint): TObject;
      procedure SetObject(Index: longint; Value: TObject);

    public
      function Add(Item: TObject): longint; virtual;
      function Delete(Index: longint): TObject; virtual;
      function First: TObject;
      function Last: TObject;
      function Remove(Item: TObject): longint; virtual;
      property Objects[Index: longint]: TObject read GetObject write SetObject; default;
  end;

  { This class disposes of it's objects when freed. To remove an object without freeing it, set the object to nil
    and then delete it. }
  TMPOwnedObjectLongList = class(TMPObjectLongList)
    private
      procedure FreeObject(Index: longint);

    protected
      procedure SetCapacity(NewCapacity: longint); override;
      procedure SetCount(NewCount: longint); override;

    public
      procedure Clear; override;
      function Delete(Index: longint): TObject; override;
  end;
*)

implementation

uses
  {$IFDEF Win32}
  WinProcs,
  {$ENDIF}
  Consts, MPHuge;

constructor TMPSortedStringList.Create;
begin
  inherited Create;
  Sorted:= true;
  Duplicates:= dupError;
end;

function TMPObjectList.GetObject(Index: integer): TObject;
begin
  Result:= TObject(Get(Index));
end;

procedure TMPObjectList.SetObject(Index: integer; Value: TObject);
begin
  Put(Index, Value);
end;

function TMPObjectList.First: TObject;
begin
  Result:= TObject(inherited First);
end;

function TMPObjectList.Last: TObject;
begin
  Result:= TObject(inherited Last);
end;

procedure TMPOwnedObjectList.FreeObject(Index: integer);
begin
  GetObject(Index).Free;
end;

procedure TMPOwnedObjectList.SetCount(Value: integer);

var
  x: integer;

begin
  try
    for x:= Count -1 downto Value do
      FreeObject(x);
  finally
    inherited SetCount(Value);
  end;
end;

procedure TMPOwnedObjectList.Clear;

var
  x: integer;

begin
  for x:= 0 to Count -1 do
    FreeObject(x);
  inherited Clear;
end;

destructor TMPOwnedObjectList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TMPOwnedObjectList.Delete(Index: integer);
begin
  FreeObject(Index);
  inherited Delete(Index);
end;

(*
procedure TMPCustomLongList.CheckIndex(Index: LongInt);
begin
  if (Index < 0) or (Index >= Count) then
    {$IFDEF Win32}
    raise EListError.Create(SListIndexError);
    {$ELSE}
    raise EListError.CreateRes(SListIndexError);
    {$ENDIF}
end;

destructor TMPCustomLongList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TMPCustomLongList.ReAllocList(NewCapacity: longint);

{$IFNDEF Win32}
var
  NewList: pointer;
{$ENDIF}
  
begin
  { If the list is shrinking, then update Count for the smaller size. }
  if NewCapacity < Count then
    FCount:= NewCapacity;

  {$IFDEF Win32}
  ReAllocMem(FList, NewCapacity * sizeof(pointer));
  {$ELSE}
  if assigned(FList) then
  begin
    NewList:= GlobalReallocPtr(FList, NewCapacity * sizeof(pointer), GMem_Moveable or GMem_ZeroInit);
    if not assigned(NewList) then
      OutOfMemoryError;
    HMemCpy(NewList, FList, FCount * sizeof(pointer));
    GlobalFreePtr(FList);
    FList:= NewList;
  end
  else
  begin
    FList:= GlobalAllocPtr(GMem_Moveable or GMem_ZeroInit, NewCapacity * sizeof(pointer));
    if not assigned(FList) then
      OutOfMemoryError;
  end;
  {$ENDIF}

  {$IFDEF Win32}
  FCapacity:= NewCapacity;
  {$ELSE}
  { If Windows allocated even more memory, then see how much we really have. }
  { Get the selector of the list pointer, to retrieve the memory handle.
    Extract the handle part of the value returned by GlobalHandle to
    get the size in bytes. Then divide to get the size as a capacity. }
  FCapacity:= GlobalSize(word(GlobalHandle(Seg(FList^)))) div sizeof(pointer);
  {$ENDIF}
end;

function TMPCustomLongList.ExpandSize: longint;
begin
  if Capacity > 8 then
    ExpandSize:= Capacity + 16
  else if Capacity > 4 then
    ExpandSize:= Capacity + 8
  else
    ExpandSize:= Capacity + 4
end;

function TMPCustomLongList.GetItem(Index: longint): pointer;
begin
  CheckIndex(Index);
  Result:= pointer(HugeOffset(FList, Index * sizeof(pointer))^);
end;

procedure TMPCustomLongList.SetItem(Index: longint; Value: pointer);
begin
  CheckIndex(Index);
  pointer(HugeOffset(FList, Index * sizeof(pointer))^):= Value;
end;

procedure TMPCustomLongList.SetCapacity(NewCapacity: LongInt);
begin
  if NewCapacity < 0 then
    raise EListError.Create(sListIndexError);
    
  if Capacity <> NewCapacity then
    ReAllocList(NewCapacity);
end;

procedure TMPCustomLongList.SetCount(NewCount: longint);
begin
  if NewCount <> FCount then
  begin
    if NewCount < 0 then
      raise EListError.Create(sListIndexError);

    if NewCount > Capacity then
      Capacity:= NewCount;
      
    if Count < NewCount then
      { zero all the new items, which may cross segment boundaries }
      ZeroMemory(HugeOffset(FList, Count * sizeof(pointer)), (NewCount - Count) * sizeof(pointer));

    FCount:= NewCount;
  end; {if}
end;

function TMPCustomLongList.Add(Item: pointer): longint;
begin
  Insert(Count, Item);
  Result:= Count -1;
end;

procedure TMPCustomLongList.Clear;
begin
  if assigned(FList) then
  begin
    GlobalFreePtr(FList);
    FList:= nil;
  end; {if}

  FCount:= 0;
  FCapacity:= 0;
end;

function TMPCustomLongList.Delete(Index: longint): pointer;
begin
  Result:= GetItem(Index);
  dec(FCount);
  HugeMove(FList, Index, Index + 1, Count - Index);
end;

procedure TMPCustomLongList.Exchange(i1, i2: longint);

var
  Tmp: pointer;
  P, Q: ^pointer;

begin
  CheckIndex(i1);
  CheckIndex(i2);
  P:= HugeOffset(FList, i1 * sizeof(pointer));
  Q:= HugeOffset(FList, i2 * sizeof(pointer));
  Tmp:= P^;
  P^:= Q^;
  Q^:= Tmp;
end;

function TMPCustomLongList.First: Pointer;
begin
  First:= GetItem(0);
end;

function TMPCustomLongList.IndexOf(Item: pointer): longint;

var
  Ptr: ^pointer;

begin
  Ptr:= FList;
  for Result:= 0 to Count -1 do
  begin
    if (Ptr^ = Item) then
      exit;
    Ptr:= HugeOffset(Ptr, sizeof(pointer));
  end; {for}
  
  Result:= -1;
end;

procedure TMPCustomLongList.Insert(Index: longint; Item: pointer);

var
  Ptr: ^pointer;
  
begin
  if (Index < 0) or (Index > Count) then
    raise EListError.Create(SListIndexError);
    
  if Count >= Capacity then
    Expand;
    
  Ptr:= HugeOffset(FList, Index * sizeof(pointer));
  HugeMove(Ptr, 1, 0, Count - Index);
  Ptr^:= Item;
  inc(FCount);
end;

function TMPCustomLongList.Last: Pointer;
begin
  Last:= GetItem(Count -1);
end;

procedure TMPCustomLongList.Move(CurIndex, NewIndex: longint);

var
  Tmp: pointer;
  Ptr: ^pointer;
  
begin
  CheckIndex(NewIndex);
  if NewIndex <> CurIndex then
  begin
    Tmp:= Items[CurIndex];
    if NewIndex < CurIndex then
    begin
      Ptr:= HugeOffset(FList, NewIndex * sizeof(pointer));
      HugeMove(Ptr, 1, 0, CurIndex - NewIndex)
    end
    else
    begin
      Ptr:= HugeOffset(FList, CurIndex * sizeof(pointer));
      HugeMove(Ptr, 0, 1, NewIndex - CurIndex);
      Ptr:= HugeOffset(FList, NewIndex * sizeof(pointer));
    end;
    Ptr^:= Tmp;
  end; {if}
end;

procedure TMPCustomLongList.DoPack(PackProc: TMPPackProc);

var
  I, J, K: longint;
  P, Q: ^pointer;
  
begin
  { Instead of a for loop, use a while loop, and use the current value of Count for each iteration, since Count
    changes during the loop. }
  I:= 0;
  P:= FList;
  while I < Count do
  begin
    if assigned(P^) then
    begin
      Inc(I);
      P:= HugeOffset(FList, I * sizeof(pointer));
    end
    else
    begin
      if Assigned(PackProc) then
        PackProc(I);
      { Collect a run of nil slots. }
      for J:= I + 1 to Count -1 do
      begin
        P:= HugeOffset(fList, J * sizeof(pointer));
        if assigned(P^) then
          break;
        if Assigned(PackProc) then
          PackProc(J);
      end; {for}
      { Shift slots if there is a non-nil value.
        If all the remaining slots are nil, then the loop is done. }
      if not assigned(P^) then
      begin
        FCount:= I;
        Break;
      end; {if}
      { Now shift the slots; setting the newly vacated slots to nil,
        as a safety measure. Stop at the next nil slot. }
      K:= I;
      while J < Count do
      begin
        P:= HugeOffset(FList, K * sizeof(pointer));
        Q:= HugeOffset(FList, J * sizeof(pointer));
        P^:= Q^;
        { Check after assigning to P^, so the check for nil at
          the top of the loop is true.  A small inefficiency for
          greater programming ease and maintainability. }
        if not assigned(Q^) then
          Break;
        Q^:= nil;
        Inc(K);
        Inc(J);
      end; {while}
      { Adjust Count by the number of nil slots removed. }
      Dec(FCount, J - K);
      { Set the loop counter to the next nil slot. }
      I:= K;
    end;
  end;
end;

procedure TMPCustomLongList.Pack;
begin
  DoPack(nil);
end;

function TMPCustomLongList.Remove(Item: pointer): longint;
begin
  Result:= IndexOf(Item);
  if Result >= 0 then
    Delete(Result);
end;

function TMPCustomLongList.Expand: TMPCustomLongList;
begin
  Capacity:= ExpandSize;
  Result:= self;
end;

function TMPObjectLongList.GetObject(Index: LongInt): TObject;
begin
  Result:= TObject(GetItem(Index));
end;

procedure TMPObjectLongList.SetObject(Index: longint; Value: TObject);
begin
  SetItem(Index, Value);
end;

function TMPObjectLongList.Add(Item: TObject): LongInt;
begin
  Result:= inherited Add(Item);
end;

function TMPObjectLongList.Delete(Index: longint): TObject;
begin
  Result:= TObject(inherited Delete(Index));
end;

function TMPObjectLongList.First: TObject;
begin
  Result:= TObject(inherited First);
end;

function TMPObjectLongList.Last: TObject;
begin
  Result:= TObject(inherited Last);
end;

function TMPObjectLongList.Remove(Item: TObject): longint;
begin
  Result:= inherited Remove(Item);
end;

procedure TMPOwnedObjectLongList.SetCapacity(NewCapacity: LongInt);

var
  x: longint;

begin
  try
    for x:= Capacity -1 downto NewCapacity do
      FreeObject(x);
  finally
    inherited SetCapacity(NewCapacity);
  end;
end;

procedure TMPOwnedObjectLongList.SetCount(NewCount: LongInt);

var
  x: longint;

begin
  try
    for x:= Count -1 downto NewCount do
      FreeObject(x);
  finally
    inherited SetCount(NewCount);
  end;
end;

procedure TMPOwnedObjectLongList.Clear;

var
  x: longint;

begin
  for x:= 0 to Count -1 do
    FreeObject(x);
  inherited Clear;
end;

function TMPOwnedObjectLongList.Delete(Index: LongInt): TObject;
begin
  inherited Delete(Index).Free;
  Result:= nil;
end;

procedure TMPOwnedObjectLongList.FreeObject(Index: longint);
begin
  GetObject(Index).Free;
end;
*)

end.
