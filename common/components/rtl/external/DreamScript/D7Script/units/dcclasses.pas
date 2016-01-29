{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcClasses;
{$I dc.inc}

{$D-,L-,Y-}
interface
uses
  {$IFDEF WIN32}
  Messages, Windows,
  {$ELSE}
  dcactivex,
  {$ENDIF}

  Classes, Sysutils, dcconsts;

type
  TListCompare = function (Item1, Item2: Pointer): Integer of Object;

type
  TFastList = class(TList)
    destructor Destroy; override;
  end;

  TCustomSortedList = class
  private
    FList : TList;
    FDuplicates: TDuplicates;
    FSorted:boolean;
    procedure SetSorted(Value:boolean);
    function  InternalFind(Item: Pointer; var Index: Integer; CompareProc:TListCompare): Boolean;
    function  GetCapacity : integer ;
    procedure SetCapacity(Value : integer);
    function  GetCount : integer;
    procedure SetCount(Value : integer);
    function  Get(Index : integer) : pointer;
  protected
  public
    property InternalList:TList Read FList;
    constructor Create;
    destructor Destroy ; override;
    function  CompareWithKey(Item,Key:Pointer):Integer;virtual;
    function  Compare(Item1, Item2: Pointer):integer;virtual;
    function  IndexOfKey(Key:Pointer):Integer;
    function  ItemByKey(Key : pointer) : pointer;
    function  Find(Item: Pointer; var Index: Integer): Boolean;
    function  FindByKey(Key: Pointer; var Index: Integer): Boolean;
    function  Add(Item: Pointer): Integer;
    procedure Insert(Index: Integer; Item: Pointer);
    function  IndexOf(Item: Pointer): Integer;
    function  Remove(Item: Pointer): Integer;
    procedure RemoveAll(Item:Pointer);
    procedure Clear;
    procedure Delete(Index: Integer);virtual;
    property  Sorted : boolean read FSorted write SetSorted;
    property  Duplicates: TDuplicates read FDuplicates write FDuplicates;
    property  Capacity: Integer read GetCapacity write SetCapacity;
    property  Count: Integer read GetCount write SetCount;
    property  Items[Index: Integer]: Pointer read Get; default;
  end;

function WriteMemory(const lpBaseAddress: Pointer; lpBuffer: Pointer;
  nSize: DWORD) : boolean;

implementation

function WriteMemory(const lpBaseAddress: Pointer; lpBuffer: Pointer;
  nSize: DWORD) : boolean;
var
  V1 : DWORD;
begin
{$IFDEF WIN32}
  Windows.WriteProcessMemory(GetCurrentProcess, lpBaseAddress, lpBuffer, nSize, V1);
{$ELSE}
  WriteProcessMemory(0, lpBaseAddress, lpBuffer, nSize, V1);
{$ENDIF}
  result := V1 = nsize;
end;


destructor TFastList.Destroy;
begin
  FreeMem(List);
end;

{******************************************************************}

function  TCustomSortedList.ItemByKey(Key : pointer) : pointer;
var
  i : integer;
begin
  i := IndexOfKey(Key);
  if i >= 0 then
    result := Items[i]
  else
    result := nil;
end;

{------------------------------------------------------------------}

function TCustomSortedList.IndexOfKey(Key:Pointer):Integer;
Var
  i:Integer;
begin
  If Sorted then
  begin
    if FindByKey(Key, Result) then
      exit;
  end else
    begin
      for i:=0 to Count-1 do
        if CompareWithKey(Items[i],Key)=0 then
        begin
          Result:=i;
          exit;
        end;
    end;
 result:= -1;
end;

{------------------------------------------------------------------}

function TCustomSortedList.FindByKey(Key: Pointer; var Index: Integer): Boolean;
begin
  if not Sorted then
    begin
      Index:= IndexOfKey(Key);
      Result:=Index>=0;
    end
  else
    Result:=InternalFind(Key,index,CompareWithKey);
end;

{------------------------------------------------------------------}

function TCustomSortedList.Find(Item: Pointer; var Index: Integer): Boolean;
begin
  if not Sorted then
    begin
      Index:= FList.IndexOf(Item);
      Result:=Index>=0;
    end
  else
    Result:=InternalFind(Item,index,Compare);
end;

{------------------------------------------------------------------}

function TCustomSortedList.InternalFind(Item: Pointer; var Index: Integer;
           CompareProc:TListCompare): Boolean;
var
  L, H, I, C: Integer;
  list : PPointerList;
begin
  Result := False;
  L := 0;
  H := fList.Count - 1;
  list := fList.List;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := CompareProc(list[I],Item);
    if C < 0 then L := I + 1 else
    begin
      H := I - 1;
      if C = 0 then
      begin
        Result := True;
        if Duplicates <> dupAccept then L := I;
      end;
    end;
  end;
  Index := L;
end;

{------------------------------------------------------------------}

function TCustomSortedList.Add(Item: Pointer): Integer;
begin
  if not Sorted then
    Result := FList.Add(Item)
  else
  begin
     If Find(Item, Result) then
       case Duplicates of
         dupIgnore: Exit;
         dupError: raise Exception.Create(SErrDuplicateItem);
       end;
     FList.Insert(Result, Item);
  end;
end;

{------------------------------------------------------------------}

procedure TCustomSortedList.Insert(Index: Integer; Item: Pointer);
begin
  if not Sorted then
    FList.Insert(Index,Item)
  else
   Add(Item);
end;

{------------------------------------------------------------------}

procedure TCustomSortedList.Clear;
begin
  FList.Clear;
end;

{------------------------------------------------------------------}

procedure TCustomSortedList.Delete(Index: Integer);
begin
  FList.Delete(Index);
end;

{------------------------------------------------------------------}

function TCustomSortedList.IndexOf(Item: Pointer): Integer;
begin
  if not Find(Item, Result) then
    result:= -1;
end;

{------------------------------------------------------------------}

procedure TCustomSortedList.RemoveAll(Item:Pointer);
begin
  While Remove(Item)<>-1 do
  begin
  end;
end;

{------------------------------------------------------------------}

function TCustomSortedList.Remove(Item: Pointer): Integer;
begin
  if Find(Item, Result) then
    Delete(Result)
  else
    result := -1;
end;

{------------------------------------------------------------------}

function  TCustomSortedList.GetCapacity : integer ;
begin
  result := FList.Capacity;
end;

{------------------------------------------------------------------}

procedure TCustomSortedList.SetCapacity(Value : integer);
begin
  FList.Capacity := Value;
end;

{------------------------------------------------------------------}

function  TCustomSortedList.GetCount : integer;
begin
  result := FList.Count;
end;

{------------------------------------------------------------------}

procedure TCustomSortedList.SetCount(Value : integer);
begin
  FList.Count := Value;
end;

{------------------------------------------------------------------}

function  TCustomSortedList.Get(Index : integer) : pointer;
begin
  result := FList.Items[Index];
end;

{------------------------------------------------------------------}

constructor TCustomSortedList.Create;
begin
  inherited;
  FList := TFastList.Create;
  FSorted:=True;
end;

{------------------------------------------------------------------}

destructor TCustomSortedList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------}

function  TCustomSortedList.Compare(Item1, Item2:pointer):integer;
begin
  result := integer(Item1) - integer(Item2);
end;

{------------------------------------------------------------------}

threadvar
  Lst:TCustomSortedList;

{------------------------------------------------------------------}

function  ListCompare(Item1, Item2:pointer):integer;
begin
  if Assigned(Lst) then
    result:= Lst.Compare(Item1, Item2)
  else result:=0;
end;

{------------------------------------------------------------------}

procedure  TCustomSortedList.SetSorted;
var
  i      : integer;
  plist  : PPointerList;
begin
  if FSorted <> Value then
    begin
      FSorted:=Value;
      if Value then
        begin
          plist := fList.List;

          i := Count - 2;

          while (i >= 0) and (Compare(pList[i], pList[i + 1]) <= 0) do
            dec(i);

          if i < 0 then
            exit;

          Lst := self;
          FList.Sort(ListCompare);
        end;
    end;
end;

{------------------------------------------------------------------}

function TCustomSortedList.CompareWithKey(Item,Key:Pointer):Integer;
begin
  result := integer(Item) - integer(Key);
end;

end.
