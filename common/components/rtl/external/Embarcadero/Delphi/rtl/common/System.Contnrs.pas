{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit System.Contnrs;

interface

uses
  System.SysUtils, System.Classes;

type

{ TObjectList class }

  TObjectList = class(TList)
  private
    FOwnsObjects: Boolean;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    function GetItem(Index: Integer): TObject; inline;
    procedure SetItem(Index: Integer; AObject: TObject); inline;
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;

    function Add(AObject: TObject): Integer; inline;
    function Extract(Item: TObject): TObject; inline;
    function ExtractItem(Item: TObject; Direction: TList.TDirection): TObject; inline;
    function Remove(AObject: TObject): Integer; overload; inline;
    function RemoveItem(AObject: TObject; ADirection: TList.TDirection): Integer; inline;
    function IndexOf(AObject: TObject): Integer; inline;
    function IndexOfItem(AObject: TObject; ADirection: TList.TDirection): Integer; inline;
    function FindInstanceOf(AClass: TClass; AExact: Boolean = True; AStartAt: Integer = 0): Integer;
    procedure Insert(Index: Integer; AObject: TObject); inline;
    function First: TObject; inline;
    function Last: TObject; inline;
    property OwnsObjects: Boolean read FOwnsObjects write FOwnsObjects;
    property Items[Index: Integer]: TObject read GetItem write SetItem; default;
  end;

{ TComponentList class }

  TComponentList = class(TObjectList)
  private
    FNexus: TComponent;
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    function GetItems(Index: Integer): TComponent; inline;
    procedure SetItems(Index: Integer; AComponent: TComponent); inline;
    procedure HandleFreeNotify(Sender: TObject; AComponent: TComponent);
  public
    constructor Create; overload;
    constructor Create(AOwnsObjects: Boolean); overload;
    destructor Destroy; override;

    function Add(AComponent: TComponent): Integer; inline;
    function Extract(Item: TComponent): TComponent; inline;
    function ExtractItem(Item: TComponent; Direction: TList.TDirection): TComponent; inline;
    function Remove(AComponent: TComponent): Integer; inline;
    function RemoveItem(AComponent: TComponent; ADirection: TList.TDirection): Integer; inline;
    function IndexOf(AComponent: TComponent): Integer; inline;
    function IndexOfItem(AComponent: TComponent; ADirection: TList.TDirection): Integer; inline;
    function First: TComponent; inline;
    function Last: TComponent; inline;
    procedure Insert(Index: Integer; AComponent: TComponent); inline;
    property Items[Index: Integer]: TComponent read GetItems write SetItems; default;
  end;

{ TClassList class }

  TClassList = class(TList)
  protected
    function GetItems(Index: Integer): TClass; inline;
    procedure SetItems(Index: Integer; AClass: TClass); inline;
  public
    function Add(AClass: TClass): Integer; inline;
    function Extract(Item: TClass): TClass; inline;
    function ExtractItem(Item: TClass; Direction: TList.TDirection): TClass; inline;
    function Remove(AClass: TClass): Integer; inline;
    function RemoveItem(AClass: TClass; ADirection: TList.TDirection): Integer; inline;
    function IndexOf(AClass: TClass): Integer; inline;
    function IndexOfItem(AClass: TClass; ADirection: TList.TDirection): Integer; inline;
    function First: TClass; inline;
    function Last: TClass; inline;
    procedure Insert(Index: Integer; AClass: TClass); inline;
    property Items[Index: Integer]: TClass read GetItems write SetItems; default;
  end;

{ TOrdered class }

  TOrderedList = class(TObject)
  private
    FList: TList;
  protected
    procedure PushItem(AItem: Pointer); virtual; abstract;
    function PopItem: Pointer; virtual;
    function PeekItem: Pointer; virtual;
    property List: TList read FList;
  public
    constructor Create;
    destructor Destroy; override;

    function Count: Integer;
    function AtLeast(ACount: Integer): Boolean;
    function Push(AItem: Pointer): Pointer;
    function Pop: Pointer; inline;
    function Peek: Pointer; inline;
  end;

{ TStack class }

  TStack = class(TOrderedList)
  protected
    procedure PushItem(AItem: Pointer); override;
  end;

{ TObjectStack class }

  TObjectStack = class(TStack)
  public
    function Push(AObject: TObject): TObject; inline;
    function Pop: TObject; inline;
    function Peek: TObject; inline;
  end;

{ TQueue class }

  TQueue = class(TOrderedList)
  protected
    procedure PushItem(AItem: Pointer); override;
  end;

{ TObjectQueue class }

  TObjectQueue = class(TQueue)
  public
    function Push(AObject: TObject): TObject; inline;
    function Pop: TObject; inline;
    function Peek: TObject; inline;
  end;

{ TBucketList, Hashed associative list }

  TCustomBucketList = class;

  TBucketItem = record
    Item, Data: Pointer;
  end;
  TBucketItemArray = array of TBucketItem;

  TBucket = record
    Count: Integer;
    Items: TBucketItemArray;
  end;
  TBucketArray = array of TBucket;

  TBucketProc = procedure (AInfo, AItem, AData: Pointer; out AContinue: Boolean);
  TBucketEvent = procedure (AItem, AData: Pointer; out AContinue: Boolean) of object;

  TCustomBucketList = class(TObject)
  private
    FBuckets: TBucketArray;
    FBucketCount: Integer;
    FListLocked: Boolean;
    FClearing: Boolean;
    function GetData(AItem: Pointer): Pointer;
    procedure SetData(AItem: Pointer; const AData: Pointer);
    procedure SetBucketCount(const Value: Integer);
  protected
    property Buckets: TBucketArray read FBuckets;
    property BucketCount: Integer read FBucketCount write SetBucketCount;

    function BucketFor(AItem: Pointer): Integer; virtual; abstract;

    function FindItem(AItem: Pointer; out ABucket, AIndex: Integer): Boolean; virtual;
    function AddItem(ABucket: Integer; AItem, AData: Pointer): Pointer; virtual;
    function DeleteItem(ABucket: Integer; AIndex: Integer): Pointer; virtual;
  public
    destructor Destroy; override;
    procedure Clear;

    function Add(AItem, AData: Pointer): Pointer;
    function Remove(AItem: Pointer): Pointer;

    function ForEach(AProc: TBucketProc; AInfo: Pointer = nil): Boolean; overload;
    function ForEach(AEvent: TBucketEvent): Boolean; overload;
    procedure Assign(AList: TCustomBucketList);

    function Exists(AItem: Pointer): Boolean;
    function Find(AItem: Pointer; out AData: Pointer): Boolean;
    property Data[AItem: Pointer]: Pointer read GetData write SetData; default;
  end;

{ TBucketList }

  TBucketListSizes = (bl2, bl4, bl8, bl16, bl32, bl64, bl128, bl256);

  TBucketList = class(TCustomBucketList)
  private
    FBucketMask: Byte;
  protected
    function BucketFor(AItem: Pointer): Integer; override;
  public
    constructor Create(ABuckets: TBucketListSizes = bl16);
  end;

{ TObjectBucketList }

  TObjectBucketList = class(TBucketList)
  protected
    function GetData(AItem: TObject): TObject;
    procedure SetData(AItem: TObject; const AData: TObject);
  public
    function Add(AItem, AData: TObject): TObject;
    function Remove(AItem: TObject): TObject;

    property Data[AItem: TObject]: TObject read GetData write SetData; default;
  end;

  TIntegerBucketList = class(TBucketList)
  protected
    function GetData(AItem: NativeInt): NativeInt;
    procedure SetData(AItem: NativeInt; const AData: NativeInt);
  public
    function Add(AItem, AData: NativeInt): NativeInt;
    function Remove(AItem: NativeInt): NativeInt;

    property Data[AItem: NativeInt]: NativeInt read GetData write SetData; default;
  end;

{ Easy access error message }

procedure RaiseListError(const ATemplate: string; const AData: array of const); deprecated;

implementation

uses
  System.Types, System.RTLConsts;

{ Easy access error message }
procedure RaiseListError(const ATemplate: string; const AData: array of const);
begin
  raise EListError.CreateFmt(ATemplate, AData);
end;

{ TObjectList }

function TObjectList.Add(AObject: TObject): Integer;
begin
  Result := inherited Add(AObject);
{$IFDEF AUTOREFCOUNT}
  AObject.__ObjAddRef;
{$ENDIF AUTOREFCOUNT}
end;

constructor TObjectList.Create;
begin
  inherited Create;
  FOwnsObjects := True;
end;

constructor TObjectList.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

function TObjectList.Extract(Item: TObject): TObject;
begin
  Result := TObject(inherited Extract(Item));
{$IFDEF AUTOREFCOUNT}
  Result.__ObjRelease;
{$ENDIF AUTOREFCOUNT}
end;

function TObjectList.ExtractItem(Item: TObject; Direction: TList.TDirection): TObject;
begin
  Result := TObject(inherited ExtractItem(Item, Direction));
{$IFDEF AUTOREFCOUNT}
  Result.__ObjRelease;
{$ENDIF AUTOREFCOUNT}
end;

function TObjectList.FindInstanceOf(AClass: TClass; AExact: Boolean;
  AStartAt: Integer): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := AStartAt to Count - 1 do
    if (AExact and
        (Items[I].ClassType = AClass)) or
       (not AExact and
        Items[I].InheritsFrom(AClass)) then
    begin
      Result := I;
      break;
    end;
end;

function TObjectList.First: TObject;
begin
  Result := TObject(inherited First);
end;

function TObjectList.GetItem(Index: Integer): TObject;
begin
  Result := inherited Items[Index];
end;

function TObjectList.IndexOf(AObject: TObject): Integer;
begin
  Result := inherited IndexOf(AObject);
end;

function TObjectList.IndexOfItem(AObject: TObject; ADirection: TList.TDirection): Integer;
begin
  Result := inherited IndexOfItem(AObject, ADirection);
end;

procedure TObjectList.Insert(Index: Integer; AObject: TObject);
begin
  inherited Insert(Index, AObject);
end;

function TObjectList.Last: TObject;
begin
  Result := TObject(inherited Last);
end;

procedure TObjectList.Notify(Ptr: Pointer; Action: TListNotification);
begin
{$IFNDEF AUTOREFCOUNT}
  if (Action = lnDeleted) and OwnsObjects then
    TObject(Ptr).Free;
{$ENDIF !AUTOREFCOUNT}
  inherited Notify(Ptr, Action);
end;

function TObjectList.Remove(AObject: TObject): Integer;
begin
  Result := inherited Remove(AObject);
{$IFDEF AUTOREFCOUNT}
  if Result <> 01 then
    AObject.__ObjRelease;
{$ENDIF AUTOREFCOUNT}
end;

function TObjectList.RemoveItem(AObject: TObject; ADirection: TList.TDirection): Integer;
begin
  Result := inherited RemoveItem(AObject, ADirection);
{$IFDEF AUTOREFCOUNT}
  if Result <> 01 then
    AObject.__ObjRelease;
{$ENDIF AUTOREFCOUNT}
end;

procedure TObjectList.SetItem(Index: Integer; AObject: TObject);
begin
  inherited Items[Index] := AObject;
end;


{ TComponentListNexus }
{ used by TComponentList to get free notification }

type
  TComponentListNexusEvent = procedure(Sender: TObject; AComponent: TComponent) of object;
  TComponentListNexus = class(TComponent)
  private
    FOnFreeNotify: TComponentListNexusEvent;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property OnFreeNotify: TComponentListNexusEvent read FOnFreeNotify write FOnFreeNotify;
  end;

{ TComponentListNexus }

procedure TComponentListNexus.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and Assigned(FOnFreeNotify) then
    FOnFreeNotify(Self, AComponent);
  inherited Notification(AComponent, Operation);
end;

{ TComponentList }

// The following two forwarding constructors are to resolve
// QC:2298 (http://qc.embarcadero.com/wc/qcmain.aspx?d=2298)
// The real issue is more generic and described in QC:29735
// (http://qc.embarcadero.com/wc/qcmain.aspx?d=29735). When
// the latter is resolved, these constructors can be removed
constructor TComponentList.Create; 
begin
  inherited;
end;

constructor TComponentList.Create(AOwnsObjects: Boolean);
begin
  inherited;
end;

function TComponentList.Add(AComponent: TComponent): Integer;
begin
  Result := inherited Add(AComponent);
end;

destructor TComponentList.Destroy;
begin
  inherited Destroy;
  FNexus.Free;
end;

function TComponentList.Extract(Item: TComponent): TComponent;
begin
  Result := TComponent(inherited Extract(Item));
end;

function TComponentList.ExtractItem(Item: TComponent; Direction: TList.TDirection): TComponent;
begin
  Result := TComponent(inherited ExtractItem(Item, Direction));
end;

function TComponentList.First: TComponent;
begin
  Result := TComponent(inherited First);
end;

function TComponentList.GetItems(Index: Integer): TComponent;
begin
  Result := TComponent(inherited Items[Index]);
end;

procedure TComponentList.HandleFreeNotify(Sender: TObject; AComponent: TComponent);
begin
  Extract(AComponent);
end;

function TComponentList.IndexOf(AComponent: TComponent): Integer;
begin
  Result := inherited IndexOf(AComponent);
end;

function TComponentList.IndexOfItem(AComponent: TComponent; ADirection: TList.TDirection): Integer;
begin
  Result := inherited IndexOfItem(AComponent, ADirection);
end;

procedure TComponentList.Insert(Index: Integer; AComponent: TComponent);
begin
  inherited Insert(Index, AComponent);
end;

function TComponentList.Last: TComponent;
begin
  Result := TComponent(inherited Last);
end;

procedure TComponentList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if not Assigned(FNexus) then
  begin
    FNexus := TComponentListNexus.Create(nil);
    TComponentListNexus(FNexus).OnFreeNotify := HandleFreeNotify;
  end;
  case Action of
    lnAdded:
      if Ptr <> nil then
        TComponent(Ptr).FreeNotification(FNexus);
    lnExtracted,
    lnDeleted:
      if Ptr <> nil then
        TComponent(Ptr).RemoveFreeNotification(FNexus);
  end;
  inherited Notify(Ptr, Action);
end;

function TComponentList.Remove(AComponent: TComponent): Integer;
begin
  Result := inherited Remove(AComponent);
end;

function TComponentList.RemoveItem(AComponent: TComponent; ADirection: TList.TDirection): Integer;
begin
  Result := inherited RemoveItem(AComponent, ADirection);
end;

procedure TComponentList.SetItems(Index: Integer; AComponent: TComponent);
begin
  inherited Items[Index] := AComponent;
end;

{ TClassList }

function TClassList.Add(AClass: TClass): Integer;
begin
  Result := inherited Add(AClass);
end;

function TClassList.Extract(Item: TClass): TClass;
begin
  Result := TClass(inherited Extract(Item));
end;

function TClassList.ExtractItem(Item: TClass; Direction: TList.TDirection): TClass;
begin
  Result := TClass(inherited ExtractItem(Item, Direction));
end;

function TClassList.First: TClass;
begin
  Result := TClass(inherited First);
end;

function TClassList.GetItems(Index: Integer): TClass;
begin
  Result := TClass(inherited Items[Index]);
end;

function TClassList.IndexOf(AClass: TClass): Integer;
begin
  Result := inherited IndexOf(AClass);
end;

function TClassList.IndexOfItem(AClass: TClass; ADirection: TList.TDirection): Integer;
begin
  Result := inherited IndexOfItem(AClass, ADirection);
end;

procedure TClassList.Insert(Index: Integer; AClass: TClass);
begin
  inherited Insert(Index, AClass);
end;

function TClassList.Last: TClass;
begin
  Result := TClass(inherited Last);
end;

function TClassList.Remove(AClass: TClass): Integer;
begin
  Result := inherited Remove(AClass);
end;

function TClassList.RemoveItem(AClass: TClass; ADirection: TList.TDirection): Integer;
begin
  Result := inherited RemoveItem(AClass, ADirection);
end;

procedure TClassList.SetItems(Index: Integer; AClass: TClass);
begin
  inherited Items[Index] := AClass;
end;

{ TOrderedList }

function TOrderedList.AtLeast(ACount: integer): boolean;
begin
  Result := List.Count >= ACount;
end;

function TOrderedList.Peek: Pointer;
begin
  Result := PeekItem;
end;

function TOrderedList.Pop: Pointer;
begin
  Result := PopItem;
end;

function TOrderedList.Push(AItem: Pointer): Pointer;
begin
  PushItem(AItem);
  Result := AItem;
end;

function TOrderedList.Count: Integer;
begin
  Result := List.Count;
end;

constructor TOrderedList.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TOrderedList.Destroy;
begin
  FList.Free;
  inherited Destroy;
end;

function TOrderedList.PeekItem: Pointer;
begin
  Result := List[List.Count-1];
end;

function TOrderedList.PopItem: Pointer;
begin
  Result := PeekItem;
  List.Delete(List.Count-1);
end;

{ TStack }

procedure TStack.PushItem(AItem: Pointer);
begin
  List.Add(AItem);
end;

{ TObjectStack }

function TObjectStack.Peek: TObject;
begin
  Result := TObject(inherited Peek);
end;

function TObjectStack.Pop: TObject;
begin
  Result := TObject(inherited Pop);
end;

function TObjectStack.Push(AObject: TObject): TObject;
begin
  Result := TObject(inherited Push(AObject));
end;

{ TQueue }

procedure TQueue.PushItem(AItem: Pointer);
begin
  List.Insert(0, AItem);
end;

{ TObjectQueue }

function TObjectQueue.Peek: TObject;
begin
  Result := TObject(inherited Peek);
end;

function TObjectQueue.Pop: TObject;
begin
  Result := TObject(inherited Pop);
end;

function TObjectQueue.Push(AObject: TObject): TObject;
begin
  Result := TObject(inherited Push(AObject));
end;

{ TCustomBucketList }

function TCustomBucketList.Add(AItem, AData: Pointer): Pointer;
var
  LBucket: Integer;
  LIndex: Integer;
begin
  if FListLocked then
    raise EListError.Create(SBucketListLocked);
  if FindItem(AItem, LBucket, LIndex) then
    raise EListError.CreateFmt(SDuplicateItem, [Integer(AItem)])
  else
    Result := AddItem(LBucket, AItem, AData);
end;

function TCustomBucketList.AddItem(ABucket: Integer; AItem, AData: Pointer): Pointer;
var
  LDelta, LSize: Integer;
begin
  LSize := Length(Buckets[ABucket].Items);
  if Buckets[ABucket].Count = LSize then
  begin
    if LSize > 64 then
      LDelta := LSize div 4
    else if LSize > 8 then
      LDelta := 16
    else
      LDelta := 4;
    SetLength(Buckets[ABucket].Items, LSize + LDelta);
  end;

  Buckets[ABucket].Items[Buckets[ABucket].Count].Item := AItem;
  Buckets[ABucket].Items[Buckets[ABucket].Count].Data := AData;
  Inc(Buckets[ABucket].Count);
  Result := AData;
end;

procedure AssignProc(AInfo, AItem, AData: Pointer; out AContinue: Boolean);
begin
  TCustomBucketList(AInfo).Add(AItem, AData);
end;

procedure TCustomBucketList.Assign(AList: TCustomBucketList);
begin
  Clear;
  AList.ForEach(AssignProc, Self);
end;

procedure TCustomBucketList.Clear;
var
  LBucket, LIndex: Integer;
begin
  if FListLocked then
    raise EListError.Create(SBucketListLocked);

  FClearing := True;
  try
    for LBucket := 0 to BucketCount - 1 do
    begin
      for LIndex := Buckets[LBucket].Count - 1 downto 0 do
        DeleteItem(LBucket, LIndex);

      SetLength(Buckets[LBucket].Items, 0);
      Buckets[LBucket].Count := 0;
    end;
  finally
    FClearing := False;
  end;
end;

function TCustomBucketList.DeleteItem(ABucket, AIndex: Integer): Pointer;
begin
  Result := Buckets[ABucket].Items[AIndex].Data;

  if not FClearing then
  begin
    if Buckets[ABucket].Count = 1 then
      SetLength(Buckets[ABucket].Items, 0)
    else if AIndex < (Buckets[ABucket].Count - 1) then
      System.Move(Buckets[ABucket].Items[AIndex + 1], Buckets[ABucket].Items[AIndex],
                  (Buckets[ABucket].Count - 1 - AIndex) * SizeOf(TBucketItem));
    Dec(Buckets[ABucket].Count);
  end;
end;

destructor TCustomBucketList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TCustomBucketList.Exists(AItem: Pointer): Boolean;
var
  LBucket, LIndex: Integer;
begin
  Result := FindItem(AItem, LBucket, LIndex);
end;

function TCustomBucketList.Find(AItem: Pointer; out AData: Pointer): Boolean;
var
  LBucket, LIndex: Integer;
begin
  Result := FindItem(AItem, LBucket, LIndex);
  if Result then
    AData := Buckets[LBucket].Items[LIndex].Data;
end;

function TCustomBucketList.FindItem(AItem: Pointer; out ABucket, AIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  ABucket := BucketFor(AItem);
  for I := 0 to FBuckets[ABucket].Count - 1 do
    if FBuckets[ABucket].Items[I].Item = AItem then
    begin
      AIndex := I;
      Result := True;
      Break;
    end;
end;

function TCustomBucketList.ForEach(AProc: TBucketProc; AInfo: Pointer): Boolean;
var
  LBucket, LIndex: Integer;
  LOldListLocked: Boolean;
begin
  Result := True;
  LOldListLocked := FListLocked;
  FListLocked := True;
  try
    for LBucket := 0 to BucketCount - 1 do
      for LIndex := Buckets[LBucket].Count - 1 downto 0 do
      begin
        AProc(AInfo, Buckets[LBucket].Items[LIndex].Item, Buckets[LBucket].Items[LIndex].Data, Result);
        if not Result then
          Exit;
      end;
  finally
    FListLocked := LOldListLocked;
  end;
end;

function TCustomBucketList.ForEach(AEvent: TBucketEvent): Boolean;
var
  LBucket, LIndex: Integer;
  LOldListLocked: Boolean;
begin
  Result := True;
  LOldListLocked := FListLocked;
  FListLocked := True;
  try
    for LBucket := 0 to BucketCount - 1 do
      for LIndex := Buckets[LBucket].Count - 1 downto 0 do
      begin
        AEvent(Buckets[LBucket].Items[LIndex].Item, Buckets[LBucket].Items[LIndex].Data, Result);
        if not Result then
          Exit;
      end;
  finally
    FListLocked := LOldListLocked;
  end;
end;

function TCustomBucketList.GetData(AItem: Pointer): Pointer;
var
  LBucket, LIndex: Integer;
begin
  if not FindItem(AItem, LBucket, LIndex) then
    raise EListError.CreateFmt(SItemNotFound, [Integer(AItem)]);
  Result := Buckets[LBucket].Items[LIndex].Data;
end;

function TCustomBucketList.Remove(AItem: Pointer): Pointer;
var
  LBucket, LIndex: Integer;
begin
  if FListLocked then
    raise EListError.Create(SBucketListLocked);
  Result := nil;
  if FindItem(AItem, LBucket, LIndex) then
    Result := DeleteItem(LBucket, LIndex);
end;

procedure TCustomBucketList.SetBucketCount(const Value: Integer);
begin
  if Value <> FBucketCount then
  begin
    FBucketCount := Value;
    SetLength(FBuckets, FBucketCount);
  end;
end;

procedure TCustomBucketList.SetData(AItem: Pointer; const AData: Pointer);
var
  LBucket, LIndex: Integer;
begin
  if not FindItem(AItem, LBucket, LIndex) then
    raise EListError.CreateFmt(SItemNotFound, [Integer(AItem)]);
  Buckets[LBucket].Items[LIndex].Data := AData;
end;

{ TBucketList }

function TBucketList.BucketFor(AItem: Pointer): Integer;
begin
  // this can be overridden with your own calculation but remember to
  //  keep it in sync with your bucket count.
  Result := Integer((IntPtr(AItem) shr 8)  and FBucketMask);
end;

constructor TBucketList.Create(ABuckets: TBucketListSizes);
const
  cBucketMasks: array [TBucketListSizes] of Byte =
    ($01, $03, $07, $0F, $1F, $3F, $7F, $FF);
begin
  inherited Create;
  FBucketMask := CBucketMasks[ABuckets];
  BucketCount := FBucketMask + 1;
end;

{ TObjectBucketList }

function TObjectBucketList.Add(AItem, AData: TObject): TObject;
begin
  Result := TObject(inherited Add(AItem, AData));
end;

function TObjectBucketList.GetData(AItem: TObject): TObject;
begin
  Result := TObject(inherited Data[AItem]);
end;

function TObjectBucketList.Remove(AItem: TObject): TObject;
begin
  Result := TObject(inherited Remove(AItem));
end;

procedure TObjectBucketList.SetData(AItem: TObject; const AData: TObject);
begin
  inherited Data[AItem] := AData;
end;

{ TIntegerBucketList }

function TIntegerBucketList.Add(AItem, AData: NativeInt): NativeInt;
begin
  Result := IntPtr(inherited Add(Pointer(AItem), Pointer(AData)));
end;

function TIntegerBucketList.GetData(AItem: NativeInt): NativeInt;
begin
  Result := IntPtr(inherited Data[Pointer(AItem)]);
end;

function TIntegerBucketList.Remove(AItem: NativeInt): NativeInt;
begin
  Result := IntPtr(inherited Remove(Pointer(AItem)));
end;

procedure TIntegerBucketList.SetData(AItem: NativeInt; const AData: NativeInt);
begin
  inherited Data[Pointer(AItem)] := Pointer(AData);
end;

end.
