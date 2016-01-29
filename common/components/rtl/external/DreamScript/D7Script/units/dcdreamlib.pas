{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcdreamlib;
interface
{$I dc.inc}
uses
  ActiveX,Consts, dcconsts, Classes, Sysutils,
  {$IFDEF WIN32}
  windows, messages,
  {$ELSE}
  dcactivex,
  {$ENDIF}

  Typinfo, dcHook, dcClasses
  {$IFDEF D6}
  ,RTLConsts, Variants
  {$ENDIF}
  ;


//=========================================================================
// _consts
// ------------------------ constant declaration ------------------

const
  VK_PLUS  = 107;
  VK_MINUS = 109;

//=========================================================================
// msgconsts
// ------------------------ message constant declaration ------------------
const
  CM_DCBASE = {$IFDEF WIN32}WM_USER+{$ENDIF}1000;

  CM_NAMECHANGED         = CM_DCBASE + 1;
  CM_PROPCHANGED         = CM_DCBASE + 2;
  CM_PACKAGEUNLOADED     = CM_DCBASE + 4;
  CM_PALETTECLICK        = CM_DCBASE + 5;
  CM_BEFOREPACKAGEUNLOAD = CM_DCBASE + 6;
  CM_OBJINSERT           = CM_DCBASE + 7;
  CM_REGISTERACTIVEX     = CM_DCBASE + 8;  // wParam = <pointer to GUID of registering type library>
  CM_UNREGISTERACTIVEX   = CM_DCBASE + 9;  // wParam = <pointer to GUID of unregistering type library>
  CM_INSPECTOR_CHANGED   = CM_DCBASE + 10;
  CM_UPDATEEDITORS       = CM_DCBASE + 11;
  CM_SELECTIONCHANGED    = CM_DCBASE + 12;
  cm_ShowInspector       = CM_DCBASE + 13;
  cm_LoadColorStyles     = CM_DCBASE + 14;
  cm_SaveColorStyles     = CM_DCBASE + 15;
  CM_PACKAGELOADED       = CM_DCBASE + 16;
  cm_HideInspector       = CM_DCBASE + 17;
  cm_ToolBarForm         = CM_DCBASE + 18;
  CM_DESIGNRESFORM       = CM_DCBASE + 19;
  CM_EDITTEXTPROP        = CM_DCBASE + 20;

  CM_IDECHANGED          = CM_DCBASE + 21;
  CM_IDEADDTO            = CM_DCBASE + 22;
  CM_IDESAVETO           = CM_DCBASE + 24;
  CM_IDEAPROJCHANGED     = CM_DCBASE + 25;
  CM_SOURCEEMPTY         = CM_DCBASE + 26;
  CM_IDECLOSEALL         = CM_DCBASE + 27;
  CM_IDEOBJPROPSCHANGED  = CM_DCBASE + 28;
  CM_IDEEndUpdate        = CM_DCBASE + 29;
  CM_IDEBeginUpdate      = CM_DCBASE + 31;
  CM_TSNOTIFY            = CM_DCBASE + 32;
  cm_ToggleInspector     = CM_DCBASE + 33;
  CM_FREEEDITGROUP       = CM_DCBASE + 34;
  CM_OBJDESTROYED        = CM_DCBASE + 35;
  CM_UPDATEEDITOR        = CM_DCBASE + 36;
  CM_SCRIPTERROR         = CM_DCBASE + 37;
  CM_INSPECTORRESCAN     = CM_DCBASE + 38;
  CM_SHOWPALETTE         = CM_DCBASE + 39;
  CM_HIDEPALETTE         = CM_DCBASE + 40;
  CM_SHOWALIGNPALETTE    = CM_DCBASE + 41;
  CM_HIDEALIGNPALETTE    = CM_DCBASE + 42;
  CM_MENUITEMINSERTED    = CM_DCBASE + 44; // wParam = TMenuItem
  CM_REGISTERCOMPS       = CM_DCBASE + 45;
  CM_OBJECTCHANGED       = CM_DCBASE + 46;
  CM_UPDATESELECTION     = CM_DCBASE + 47;
  CM_DESIGNFINISHED      = CM_DCBASE + 48;
  CM_APPLYOPTIONS        = CM_DCBASE + 49;
  CM_TRACKERROR          = CM_DCBASE + 50;

  CM_PaletteChanged      = CM_DCBASE + 51;
  CM_ActiveXChanged      = CM_DCBASE + 52;
  CM_CANCELOPTIONS       = CM_DCBASE + 53;
  CM_RefreshPalette      = CM_DCBASE + 54;

  CM_UPDATEOPTIONS       = CM_DCBASE + 55;

const
  DefaultOpenMode : integer = fmOpenRead or fmShareDenyWrite;

//=========================================================================
// typedec
// ------------------------ types declaration ------------------
type
{$IFNDEF D3}
  OleVariant = Variant;
{$ENDIF}

{$IFDEF D4}
{$IFDEF BCB}
  POleVariant = ^OleVariant;
{$ENDIF}
{$ELSE}
  POleVariant = ^OleVariant;
{$ENDIF}

  TPropCallBack=procedure(Instance:TPersistent;PropInfo:PPropInfo;UserData:Integer) of object;

  TNotifyProc = procedure(AComponent : TComponent; Operation : TOperation) of object;

  TSortedList = class(TCustomSortedList);

  TSortedKeyList=class(TSortedList)
  protected
    function KeyByItem(Item:Pointer):Pointer;virtual;
  public
    function  CompareWithKey(Item,Key:Pointer):Integer;override;//final
    function  Compare(Item1, Item2: Pointer):integer;override;//final
  end;

  TSortedListEx = class(TSortedList)
  private
    FCurrentIndex : integer;
    function InternalFindNearest(Item: Pointer; var Index: Integer;
             CompareProc:TListCompare): Boolean;
  protected
    property CurrentIndex : integer read FCurrentIndex;
  public
    function FindNearest(Item: Pointer; var Index: Integer): Boolean;
  end;

  TRecordList = class(TInterfacedObject)
  private
    fRecordSize : integer;
    fCount      : integer;
    fCapacity   : integer;
    fMemory     : PChar;

    function    Get(index : integer) : Pointer;
  protected
    procedure SetCount(Value : integer);
    procedure Grow(NewCount:Integer);
  public
    constructor Create(RecordSize : integer);
    destructor  Destroy; override;
    function    Add(Data : pointer) : integer;
    procedure   Delete(Index : integer);
    procedure   SetCapacity(Size : integer);
    procedure   Clear;

    procedure   SaveToStream(S : TStream);
    procedure   LoadFromStream(S : TStream);

    property    Count : integer read fCount Write SetCount;
    property    Items[index: Integer] : pointer read Get; default;
    property    Capacity  : integer read FCapacity write SetCapacity;
  end;

  TMethodList = class
  private
    fList : TRecordList;

    function Get(index : integer) : TMethod;
    function GetCapacity : integer;
    procedure SetCapacity(val : integer);
    function GetCount : integer;
  public
    constructor Create;
    destructor  Destroy; override;
    function    Add(const Data : TMethod) : integer;
    procedure   Remove(const Data : TMethod);
    procedure   Delete(Index : integer);
    procedure   Clear;

    property    Count : integer read GetCount;
    property    Items[index: Integer] : TMethod read Get; default;
    property    Capacity  : integer read GetCapacity write SetCapacity;
  end;

  TDCNamedItem=class(TCollectionItem)
  private
    FName:String;
  protected
    procedure OnChange(Sender:TObject); virtual;
    {$IFDEF D3}
    procedure SetDisplayName(const Value: string);override;
    function GetDisplayName: string; override;
    {$ENDIF}
    property Name:String Read FName Write FName;
  public
    procedure Assign(Source:TPersistent);override;
  published
  end;

  TDCNamedItemClass=class of TDCNamedItem;

  TUpdateCollectionEvent=procedure(Sender:TObject;Item:TCollectionItem) of object;

  TCustomDCNamedItems=class(TCollection)
  private
    FOwner:TComponent;
    FOnChange:TNotifyEvent;
    FOnUpdate:TUpdateCollectionEvent;
  protected
    Procedure FreeNotificationProc(Instance:TObject);
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(AOwner:TComponent;ItemClass: TDCNamedItemClass);virtual;
    destructor Destroy; override;
    {$IFDEF D3}
    function GetOwner:TPersistent;override;
    {$ENDIF}

    function IndexOfName(const Name:String):Integer;
    function IndexOf(Item:TDCNamedItem):Integer;
    {$IFNDEF D6}
    property Owner:TComponent Read FOwner;
    {$ENDIF}

    property OnChange:TNotifyEvent Read FOnChange write FOnChange;
    property OnUpdate:TUpdateCollectionEvent Read FOnUpdate Write FOnUpdate;
    property Items[Index: Integer]: TCollectionItem read GetItem write SetItem;

  end;

  TSortedCustomData=class
  private
    FKeyPtr:Pointer;
  protected
  public
    constructor Create(KeyPtr:Pointer);virtual;
  end;

  TSortedListData=class(TSortedCustomData)
  public
    ValuePtr:Pointer;
  end;

  TSortedCustomDataClass=class of TSortedCustomData;

  TSortedKeyDataList=class(TSortedKeyList)
  private
    FListDataClass:TSortedCustomDataClass;
  protected
    function KeyByItem(Item:Pointer):Pointer;override;//final
  public
    procedure Delete(Index: Integer);override;
    destructor Destroy;override;
    function ItemByKey(KeyPtr:Pointer):Pointer;virtual;
    function Add(KeyPtr:Pointer):TSortedCustomData;virtual;
    constructor Create(ListDataClass:TSortedCustomDataClass);virtual;
  end;

  TDCLinkedComponent = class(TComponent)
  private
    fNotifyProc : TNotifyProc;
    fLink : TObject;

    procedure SetLink(V:TObject);
    procedure FreeNotifyProc(Instance : TObject);
  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation); override;
  public
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;

    property Link : TObject read fLink write SetLink;
    property NotifyProc : TNotifyProc read fNotifyProc write fNotifyProc;
  end;

  TSortedCompKeyList=class(TSortedKeyDataList)
  private
  protected
    procedure Notification(Instance: TObject);
  public
    procedure Delete(Index: Integer);override;
    constructor Create(ListDataClass:TSortedCustomDataClass);override;
    destructor Destroy;override;
    function Add(KeyPtr:Pointer):TSortedCustomData;override;
  end;

  TDCVersion = type string;

  TIntStack = Class(TList)
  public
    function Pop: Integer;
    function Push(I: Integer): Integer;
    function IsEmpty : boolean;
  end;

  PInt = ^integer;
  
  TVariantStack = class
  private
    fLst  : PPointerList;
    fList : TList;
    fSize : integer;

  public
    constructor Create;
    destructor  Destroy; override;

    procedure Push(const v : OleVariant);
    procedure PopLast(value : POleVariant);
    function  Pop : OleVariant;


    procedure PushInt (i : integer);

    procedure Expand(delta : integer);
    procedure Collapse(delta : integer);
    procedure FillWithItems(buffer : PInt; firstitem, itemnum : cardinal);

    function  IsEmpty : boolean;
    function  Items(i : integer) : POleVariant; // Doesn't check that Index is valid
    function  Count : integer;
  end;

{$IFDEF D6}
  IPSCGetInstance=interface(IUnknown)
  ['{6CCD5C87-AE0F-11D3-BCE2-00E07D743236}']
    function GetIntfImplementer:TObject;
  end;

  TDCInterfaceListSortCompare=function (Item1, Item2: IUnknown):Integer;

  TDCInterfaceList=class(TInterfaceList)
  public
    procedure Sort(Compare:TDCInterfaceListSortCompare);
  end;
{$ENDIF}

//=========================================================================
// globproc
// ------------------------ global procedures and functions ------------------

function  PosEx(const SubStr, S : AnsiString; FromChar : Integer) : Integer;
function  BackPosEx(const SubStr, S : AnsiString; FromChar : Integer) : Integer;

function GetDWordSize(i : integer) : integer;

{$IFDEF D3}
function ResStr(const Ident: string): string;
{$ELSE}
function ResStr(Ident: Cardinal): string;
{$ENDIF}

// -------------------- string handling --------------------

procedure ParseString(const s : string; Separator : char; AStrings : TStrings);
Procedure ParseAndCompactString( Const S : String; ASeparator : Char; AStrings : TStrings );
function  ChangeCharTo(FromChar,ToChar:Char; Const S:String):String;


// -------------------- integer handling -------------------

function  Min(A,B:Integer):Integer;
procedure SwapInt (var a, b : integer);
function  Max(A,B:Integer):Integer;
procedure SwapMaxInt(var A , B : integer);

// -------------------- Boolean handling -------------------

function StrToBool(const Value : string) : boolean;

Function BoolToStr(Value : Boolean) : String;

// -------------------- errors handling --------------------

procedure ErrorFmt(const ErrorStr:String; const Args:Array of const);
procedure Error(const ErrorStr:String);

// -------------------- TObject and TClass handling -------------------

procedure WriteObjToStream(Stream : TStream; Instance : TPersistent);
procedure ReadObjFromStream(Stream : TStream; Instance : TPersistent);
procedure ReadObjFromFile(Instance:TPersistent;const FileName:String);
procedure WriteObjToFile(Instance:TPersistent;const Filename:String);

procedure WriteObjToTextStream(Stream:TStream;Instance:TPersistent);
procedure ReadObjFromTextStream(Stream:TStream;Instance:TPersistent);
procedure WriteObjToTextFile(Instance:TPersistent;const FileName:String);
procedure ReadObjFromTextFile(Instance:TPersistent;const FileName:String);

function  InheritsFromClassName(Instance : TObject; const CName : string) : boolean;
Function  isMethodsEqual(const A, B : TMethod) : Boolean;
function  GetOwner(c : TObject) : TPersistent;
function GetVMT(Obj:TObject):Pointer;

// ------------------- TList handling ----------------------

Procedure CopyList( FromList, ToList : TList );
Procedure AppendList( FromList, ToList : TList );
procedure ClearSortedList(List:TSortedList);

procedure ClearList(const List:TList);

{$IFDEF D4}
procedure ClearInterfaceList(const List:TInterfaceList);
procedure FreeInterfaceList(const List:TInterfaceList;var ListVar);
{$ENDIF}

procedure FreeList(const List:TList;var ListVar);{$IFDEF D5}overload{$ENDIF}
procedure FreeSortedList(const List:TSortedList;var ListVar);{$IFDEF D5}overload{$ENDIF}

{$IFDEF OLDSTYLEFREEPROCS}
{$IFDEF D5}
procedure FreeList(var ListVar);overload;
procedure FreeSortedList(var ListVar);overload
{$ENDIF}
{$ENDIF}

// ------------------- TStrings handling ----------------------

procedure RemoveFromStrings(Strings : TStrings; const s : string);
procedure AddToCountedStrings(Strings : TStrings; const s : string);
procedure RemoveFromCountedStrings(Strings : TStrings; const s : string);

// ---------------------- property handling ---------------------------

procedure IterateProps(Instance:TPersistent;TypeKinds: TTypeKinds;CallBack:TPropCallBack;
          AOnlyStored:Boolean;UserData:Integer);
procedure ForEachProp(Instance:TPersistent;CallBack:TPropCallBack;AOnlyStored:Boolean;UserData:Integer);
function AreObjNotEqualNotNil(Obj1,Obj2:TObject):Boolean;
function  GetPropValueSize(Instance : TPersistent; Propinfo : PPropInfo) : integer;
function  GetFloatSize(FloatType : TFloatType) : integer;
procedure AssignAllPropsExclude(Source,Dest:TPersistent;ExcludeList:TStringList);
procedure AssignAllProps(Source,Dest:TPersistent);
function CorrectBool(const V:Variant):Variant;
function  GetPTypeInfo(PropInfo:PPropInfo):PTypeInfo;
procedure AssignProp(Source,Dest:TPersistent;const Propname:String);
procedure AssignPropInfo(Source,Dest:TPersistent;SourceInfo,DestInfo:PPropInfo);
Function  GetOrdSize(O:TOrdType):Integer;
function  GetPropValueByPropInfo(Instance : TPersistent; Propinfo : PPropInfo) : Variant;
procedure SetPropValueByPropInfo(Instance : TPersistent; Propinfo : PPropInfo; const Value : Variant);
function  GetClassProperty(Instance : TPersistent; const PropName : String) : TObject;

// ---------------------- Pointer handling ---------------------------

procedure FreePointer(var Ptr);

// ---------------------- Hooks handling -------------------------

Function GetVirtualProcAddress(ObjClass:TClass;BaseObjClass:TClass;Proc:Pointer):Pointer;

//------------------------ Delphi related ------------------------
{$IFDEF WIN}
procedure CheckTrialVersion;
{$ENDIF}


procedure GetMem0(var P; Size: Integer);

function  DelphiRunning : boolean;

const
  CompanyURL = 'http://www.dream-com.com'; // don't resource

{$IFNDEF D4}
{$DEFINE OwnSynchronizer}
{$ENDIF}

{$IFNDEF WIN}
{$IFDEF WIN32}
{$DEFINE OwnSynchronizer}
{$ENDIF}
{$ENDIF}

{$DEFINE OwnSynchronizer}

{$IFDEF OwnSynchronizer}
type
  TMultiReadExclusiveWriteSynchronizer = class
  private
    fLock : TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    procedure BeginRead;
    procedure EndRead;
    procedure BeginWrite;
    procedure EndWrite;
  end;
{$ENDIF}

type
  TPersHolder = class(TComponent)
  private
    fP : TPersistent;
  published
    property P : TPersistent read fP write fP;
  end;

  TFastStringList = class(TStringList)
    procedure Sort; override;
    procedure QuickSort(L, R: Integer);
    procedure ExchangeItems(Index1, Index2: Integer);
    function Find(const s : string; var index: integer) : boolean; override;
  end;

{------------------------------------------------------------------}

  TDCCaseSensitiveStringList = class( TStringList )
  {$IFNDEF D5}
  private
    Function CaseSensitiveStringListCompare( AFirstItem, ASecondItem : Integer ) : Integer;
    Procedure ExchangeCallBack( AOrigin, ADestination : Integer );
  {$ENDIF}
  public
    Function Find( Const S : String; Var Index : Integer ) : Boolean; override;
    Procedure Sort; override;
  end;

{------------------------------------------------------------------}

Function ListIndexOf(List:TList;Item:Pointer):Integer;

const
  SSeparatorTag = '|';
  SBoldTag : char = '~';
  SReturn = #13#10;

Type
  TDCCompareCallBack = Function( AFirstItem, ASecondItem : Integer ) : Integer of object;
  TDCExchangeCallBack = Procedure( AOrigin, ADestination : Integer ) of object;

Procedure DCQuickSort( L, R: Integer; AOnCompare : TDCCompareCallBack;
                       AOnExchange : TDCExchangeCallBack );


procedure FreeObject(Obj:TObject;Var ObjVar);{$IFDEF D5}overload;{$ENDIF}
{$IFDEF D6}
procedure FreeObject(Obj:IInterface;Var ObjVar);overload;
{$ENDIF}

{$IFDEF OLDSTYLEFREEPROCS}
{$IFDEF D5}
procedure FreeObject(Var ObjVar);overload;
{$ENDIF}
{$ENDIF}

{$IFDEF D6}
function PSCGetIntfInstance(const Unk:IUnknown):TObject;
function PSCSupportsInstance(const Unk:IUnknown;const C:TClass;var Instance:TObject):boolean;
{$ENDIF}

function DCStringToOleSt(const Source: string): PWideChar;

function SafeFormat(const Format: string; const Args: array of const): string;
procedure SafeFmtStr(var Result: string; const Format: string;
  const Args: array of const);

implementation

{-----------------}

procedure SafeFmtStr(var Result: string; const Format: string;
  const Args: array of const);
var
  Len, BufLen: Integer;
  Buffer: array[0..4095] of Char;
begin
  BufLen := SizeOf(Buffer);
  if Length(Format) < (sizeof(Buffer) - (sizeof(Buffer) div 4)) then
    Len := FormatBuf(Buffer, sizeof(Buffer) - 1, Pointer(Format)^, Length(Format), Args)
  else
  begin
    BufLen := Length(Format);
    Len := BufLen;
  end;
  if Len >= BufLen - 1 then
  begin
    while Len >= BufLen - 1 do
    begin
      Inc(BufLen, BufLen);
      Result := '';          // prevent copying of existing data, for speed
      SetLength(Result, BufLen);
      Len := FormatBuf(Pointer(Result)^, BufLen - 1, Pointer(Format)^,
      Length(Format), Args);
    end;
    SetLength(Result, Len);
  end
  else
    SetString(Result, Buffer, Len);
end;

{-----------------}

function SafeFormat(const Format: string; const Args: array of const): string;
begin
  {$IFDEF D4}
  Result:=SysUtils.Format(Format,Args);
  {$ELSE}
  SafeFmtStr(Result, Format, Args);
  {$ENDIF}
end;

{-----------------}

type
  _TStringList = class(TStrings)
  private
    FList: PStringItemList;
  end;

procedure TFastStringList.ExchangeItems(Index1, Index2: Integer);
var
  Temp: Integer;
  Item1, Item2: PStringItem;
  _List: PStringItemList;
begin
  _List := _TStringList(self).FList;
  Item1 := @_List^[Index1];
  Item2 := @_List^[Index2];
  Temp := Integer(Item1^.FString);
  Integer(Item1^.FString) := Integer(Item2^.FString);
  Integer(Item2^.FString) := Temp;
  Temp := Integer(Item1^.FObject);
  Integer(Item1^.FObject) := Integer(Item2^.FObject);
  Integer(Item2^.FObject) := Temp;
end;

procedure TFastStringList.QuickSort(L, R: Integer);
var
  i, j, p : Integer;
  _List: PStringItemList;
begin
  _List := _TStringList(self).FList;
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while CompareText(_List^[i].FString, _List^[P].FString) < 0 do
        inc(i);

      while CompareText(_List^[j].FString, _List^[P].FString) > 0 do
        dec(j);

      if i <= j then
      begin
        if i <> j then
          ExchangeItems(i, j);

        if p = i then
          p := j
        else if p = j then
          p := i;

        inc(i);
        dec(j);
      end;
    until I > J;

    if L < J then
      QuickSort(L, J);
    L := I;
  until I >= R;
end;



procedure TFastStringList.Sort;
begin
  QuickSort(0, Count - 1);
end;

function TFastStringList.Find(const s : string; var index: integer) : boolean;
var
  L : integer;
  H : integer;
  I : integer;
  C : integer;
  _List: PStringItemList;
begin
  _List := _TStringList(self).FList;
  result := false;
  L := 0;
  H := Count - 1;
  while L <= H do
    begin
      I := (L + H) shr 1;
      C := CompareText(_List^[i].FString, S);
      if C < 0 then
        L := I + 1
      else
        begin
          H := I - 1;
          if C = 0 then
            begin
              result := true;
              if Duplicates <> dupAccept then
                L := I;
            end;
        end;
    end;
  index := L;
end;

const
  A2 = 'TAlignPalette'; //don't resource
  A3 = 'TPropertyInspector'; //don't resource
  A4 = 'TAppBuilder'; //don't resource

function DelphiRunning : boolean;
{$IFDEF WIN32}
var
  H2, H3, H4 : Hwnd;
{$ENDIF}
begin
{$IFDEF WIN32}
  H2 := FindWindow(A2, nil);
  H3 := FindWindow(A3, nil);
  H4 := FindWindow(A4, nil);
  Result := (H2 <> 0) and (H3 <> 0) and (H4 <> 0);
{$ELSE}
  result := true;
{$ENDIF}
end;

{-----------------------------------------------------------}

procedure StackIsEmpty;
begin
  raise Exception.Create(SErrStackEmpty);
end;

{***********************************************************}

function TIntStack.Pop : integer;
var
  lastindex : integer;
begin
  if Count = 0 then
    begin
      StackIsEmpty;
      result := 0;
    end
  else
    begin
      lastindex := Count - 1;
      result := integer(List[lastindex]);
      Delete(lastindex);
    end;
end;

{------------------------------------------}

function TIntStack.Push(i : integer) : integer;
begin
  result := Add(pointer(i));
end;

{----------------------------------------------------------}

function TIntStack.IsEmpty : boolean;
begin
  result := Count = 0;
end;

{**********************************************************}

procedure FillDWord(Value : DWORD; var X; Count : Integer);
asm
  xchg edi, edx // X
  rep  stosd
  mov  edi, edx
end;

{-----------------------------------------------------------}

const
  StackDelta = 1024;

constructor TVariantStack.Create;
begin
  inherited;
  fList := TList.Create;
end;

{-----------------------------------------------------------}

destructor  TVariantStack.Destroy;
var
  i : integer;
begin
  for i := fSize - 1 downto 0 do
    VarClear(Items(i)^);

  with fList do
    begin
      for i := Count - 1 downto 0 do
        FreeMem(List[i]);

      Free;
    end;

  inherited;
end;

{-----------------------------------------------------------}

procedure TVariantStack.Push(const v : OleVariant);
var
  pv : POleVariant;
begin
  if cardinal(fSize) mod StackDelta = 0 then
    begin
      GetMem0(pv, sizeof(Variant) * StackDelta);
      pv^ := v;
      fList.Add(pv);
      fLst := fList.List;
    end
  else
    POleVariant(cardinal(fLst[cardinal(fSize) div StackDelta]) + sizeof(Variant) * (cardinal(fSize) mod StackDelta))^ := v;

  inc(fSize);
end;

{-----------------------------------------------------------}

procedure TVariantStack.PushInt (i : integer);
begin
  Push(i);
end;

{-----------------------------------------------------------}

procedure TVariantStack.PopLast(value : POleVariant);
var
  pv : POleVariant;
  _size : integer;
begin
  _size := fsize;
  if _size = 0 then
    StackIsEmpty
  else
    begin
      dec(_size);
      pv := POleVariant(cardinal(fLst[cardinal(_size) div StackDelta]) + sizeof(Variant) * (cardinal(_size) mod StackDelta));
      if value <> nil then
        value^ := pv^;

      VarClear(pv^);
      if cardinal(_size) mod StackDelta = 0 then
        begin
          FreeMem(pv);
          fList.Delete(cardinal(_size) div StackDelta);
          flst := fList.List;
        end;
      fsize := _size;
    end;
end;

{-----------------------------------------------------------}

function  TVariantStack.Pop : OleVariant;
begin
  PopLast(@result);
end;

{-----------------------------------------------------------}

function  TVariantStack.IsEmpty : boolean;
begin
  result := fSize = 0;
end;

{-----------------------------------------------------------}

procedure TVariantStack.FillWithItems(buffer : PInt; firstitem, itemnum : cardinal);
var
  i : integer;
  _lst : PPointerList;
begin
  _lst := fLst;
  for i := 0 to itemnum - 1 do
    begin
      cardinal(buffer^) := cardinal(_lst[firstitem div StackDelta]) + ((firstitem mod StackDelta) * sizeof(Variant));
      inc(firstitem);
      inc(integer(buffer), 4);
    end;
end;

{-----------------------------------------------------------}

function  TVariantStack.Items(i : integer) : POleVariant;
begin
  if (i >= 0) and (i < fSize) then
    result := POleVariant(cardinal(fLst[cardinal(i) div StackDelta]) + (cardinal(i) mod StackDelta) * sizeof(Variant))
  else
    result := nil;
end;

{-----------------------------------------------------------}

function  TVariantStack.Count : integer;
begin
  result := fSize;
end;

{-----------------------------------------------------------}

procedure TVariantStack.Collapse(delta : integer);
var
  pv   : POleVariant;
  i    : integer;
  fmod : integer;
begin
  if fSize < delta then
    StackIsEmpty;

  while (delta > 0) do
    begin
      fmod := cardinal(fsize) mod StackDelta;
      if ((fmod = 0) and (delta < StackDelta)) or (delta < fmod) then
        break;

      if fmod = 0 then
        fmod := StackDelta;

      pv := fList.Last;

      for i := fmod - 1 downto 0 do
        VarClear(POleVariant(integer(pv) + i * sizeof(Variant))^);

      FreeMem(pv);
      fList.Delete(fList.Count - 1);
      dec(delta, fmod);
      dec(fsize, fmod);
    end;

  if delta > 0 then
    begin
      pv := POleVariant(cardinal(fList.Last) + (cardinal(fSize - 1) mod StackDelta) * sizeof(Variant));
      for i := 1 to delta do
        begin
          if TVarData(pv^).vType < varOleStr then
            TVarData(pv^).vType := 0
          else
            VarClear(pv^);

          dec(integer(pv), sizeof(Variant));
        end;
      dec(fsize, delta);
    end;

  fLst := fList.List;
end;

{-----------------------------------------------------------}

procedure TVariantStack.Expand(delta : integer);
var
  i : integer;
  pv : POleVariant;
  fmod : integer;
  sd : integer;
begin
  fmod := cardinal(fSize) mod StackDelta;
  if fmod > 0 then
    begin
      i := StackDelta - fmod;
      if delta < i then
        i := delta;

      dec(delta, i);
      inc(fsize, i);
    end;

  while delta > 0 do
    begin
      i := delta;
      sd := StackDelta;
      if i > sd then
        i := sd;

      GetMem(pv, sizeof(Variant) * StackDelta);
      FillDWORD(varInteger, pv^, sizeof(Variant) * StackDelta div 4);
      fList.Add(pv);
      fLst := fList.List;
      dec(delta, i);
      inc(fSize, i);
    end;
(*
  sd := StackDelta;
  fmod := cardinal(fSize) mod StackDelta;
  if fmod > 0 then
    begin
      i := StackDelta - fmod;
      if delta < i then
        i := delta;

      dec(delta, i);
      inc(fsize, i);
    end;

  while delta > 0 do
    begin
      i := delta;
      if i > StackDelta then
        i := StackDelta;

      GetMem(pv, sizeof(Variant) * StackDelta);
      FillDWORD(varInteger, pv^, sizeof(Variant) * StackDelta div 4);
      fList.Add(pv);
      fLst := fList.List;
      dec(delta, i);
      inc(fSize, i);
    end;
*)
end;

{***********************************************************}

{$IFDEF WIN}
var
  CheckTrialCalled : boolean = false;

procedure CheckTrialVersion;
begin
  if CheckTrialCalled then
    exit;
  CheckTrialCalled := true;

  {$IFDEF Demo}
   If not DelphiRunning then
     begin
       windows.MessageBox(0,'This application uses unregistered version of Dream Controls'#13#10+   //don't resource
         'Please register. Visit '+ CompanyURL + ' for details.' //don't resource
       ,'Warning', MB_OK+MB_ICONWARNING); //don't resource
     end;
  {$ENDIF}
end;
{$ENDIF}
{-----------------------------------------------------------}

{$IFDEF OwnSynchronizer}
constructor TMultiReadExclusiveWriteSynchronizer.Create;
begin
  inherited;
  InitializeCriticalSection(fLock);
end;

{-------------------------------------------------------------}

destructor TMultiReadExclusiveWriteSynchronizer.Destroy;
begin
  inherited;
  DeleteCriticalSection(fLock);
end;

{-------------------------------------------------------------}

procedure TMultiReadExclusiveWriteSynchronizer.BeginRead;
begin
  EnterCriticalSection(fLock);
end;

{-------------------------------------------------------------}

procedure TMultiReadExclusiveWriteSynchronizer.EndRead;
begin
  LeaveCriticalSection(fLock);
end;

{-------------------------------------------------------------}

procedure TMultiReadExclusiveWriteSynchronizer.BeginWrite;
begin
  EnterCriticalSection(fLock);
end;

{-------------------------------------------------------------}

procedure TMultiReadExclusiveWriteSynchronizer.EndWrite;
begin
  LeaveCriticalSection(fLock);
end;
{$ENDIF}

{*************************************************************}

procedure Error(const ErrorStr:String);
begin
  raise Exception.Create(ErrorStr);
end;

{-------------------------------------------------------------}
                                                                                
procedure ErrorFmt(const ErrorStr:String; const Args:Array of const);
begin
  raise Exception.CreateFmt(ErrorStr,Args);
end;

{------------------------------------------------------------------}

{$IFDEF D4}
procedure FreeInterfaceList(const List:TInterfaceList;var ListVar);
begin
  If List<>nil then
  begin
    ClearInterfaceList(List);
    List.Free;
    TInterfaceList(ListVar):=nil;
  end;
end;
{$ENDIF}
{------------------------------------------------------------------}

procedure FreeList(const List:TList;var ListVar);
begin
  if pointer(list) = nil then
    exit;

  ClearList(TObject(List) as TList);

  List.Free;
  TList(ListVar):=nil;
end;

{------------------------------------------------------------------}

{$IFDEF D4}
procedure ClearInterfaceList(const List:TInterfaceList);
Var
  A:IUnknown;
begin
  if list <> nil then
    with List do
      while Count > 0 do
        begin
          A := Items[0];
          Delete(0);
          A:=nil;
        end;
end;
{$ENDIF}
{------------------------------------------------------------------}
procedure ClearList(const List:TList);
Var
  A:TObject;
begin
  if list <> nil then
    with List do
      while Count > 0 do
        begin
          A := TObject(Items[0]);
          Delete(0);
          A.Free;
        end;
end;

{---------------------------------------------------------------}

{$IFDEF OLDSTYLEFREEPROCS}
{$IFDEF D5}
procedure FreeObject(Var ObjVar);overload;
begin
  FreeObject(TObject(ObjVar),ObjVar);
end;
{$ENDIF}
{$ENDIF}

{---------------------------------------------------------------}

procedure FreeObject(Obj:TObject;Var ObjVar);{$IFDEF D5}overload;{$ENDIF}
begin
  TObject(Obj).Free;
  TObject(ObjVar):=nil;
end;

{----------------------------------------------------------}

{$IFDEF D6}
procedure FreeObject(Obj:IInterface;Var ObjVar);overload;
begin
  IInterface(ObjVar):=nil;
end;
{$ENDIF}

{----------------------------------------------------------}

procedure FreePointer(var Ptr);
begin
  if pointer(Ptr) = nil then
    exit;
  FreeMem(pointer(Ptr));
  pointer(Ptr) := nil;
end;

{----------------------------------------------------------}

Function GetVirtualProcAddress(ObjClass:TClass;BaseObjClass:TClass;Proc:Pointer):Pointer;
Var
  Offset:Integer;
Begin
  Result:=ObjClass;
  Result:=Pointer(PChar(Result)-4);
  Offset:=-4;
  While (Pointer(Result^)<>Proc) Do
  Begin
    Inc(Integer(Result),4);
    Inc(Offset,4);
  End;
  Result:=BaseObjClass;
  Inc(Integer(Result),Offset);
  Result:=Pointer(Result^);
End;

{---------------------------------------------------------}

function isMethodsEqual(const A, B : TMethod) : boolean;
begin
  result := (A.Data = B.Data) and (A.Code = B.Code);
end;

{----------------------------------------------------------}

procedure ClearSortedList(List : TSortedList);
var
  A : TObject;
begin
  if List <> nil then
    with List do
      while Count > 0 do
        begin
          A := TObject(Items[0]);
          Delete(0);
          A.Free;
        end;
end;

{---------------------------------------------------------------}

procedure FreeSortedList(const List:TSortedList;var ListVar);
begin
  if pointer(list) = nil then
    exit;

  ClearSortedList(List);

  List.Free;
  TSortedList(ListVar):=nil;
end;

{-----------------------------------------------------------}

procedure RemoveFromStrings(Strings : TStrings; const s : string);
var
  i : integer;
begin
  i := Strings.IndexOf(s);
  if i >= 0 then
    Strings.Delete(i);
end;

{-----------------------------------------------------------}

procedure AddToCountedStrings(Strings : TStrings; const s : string);
var
  i : integer;
begin
  with Strings do
    begin
      i := IndexOf(s);
      if i < 0 then
        AddObject(s, pointer(1))
      else
        Objects[i] := pointer(integer(Objects[i]) + 1);
    end;
end;

{-----------------------------------------------------------}

procedure RemoveFromCountedStrings(Strings : TStrings; const s : string);
var
  i : integer;
  refcount : integer;
begin
  i := Strings.IndexOf(s);
  if i >= 0 then
    begin
      refcount := integer(Strings.Objects[i]);
      if refcount = 1 then
        Strings.Delete(i)
      else
        Strings.Objects[i] := pointer(refcount - 1);
    end;
end;

{-----------------------------------------------------------}

function Min(a, b : integer) : integer;
begin
  if a < b then
    result := a
  else
    result := b;
end;

{-----------------------------------------------------------}

function Max(a, b : integer) : integer;
begin
  if a > b then
    result := a
  else
    result := b;
end;

{------------------------------------------------------------------}

procedure CopyList(FromList,ToList : TList);
Var
  Size : Integer;
begin
  If FromList <> ToList Then
  begin
    Size := FromList.Count;
    ToList.Count := Size;
    Move( FromList.List^, ToList.List^, Size * SizeOf( Pointer ) );
  end;
end;

{------------------------------------------------------------------}

Procedure AppendList( FromList, ToList : TList );
Var
  OldSize, Size : Integer;
begin
  If FromList <> ToList Then
  begin
    Size := FromList.Count;
    OldSize := ToList.Count; 
    ToList.Count := ToList.Count + Size;
    Move( FromList.List^, ToList.List^[OldSize], Size * SizeOf( Pointer ) );
  end;
end;

{------------------------------------------------------------------}

function StrToBool(const Value : string) : boolean;
begin
  result := CompareText(Value, STrueText) = 0;
end;

{------------------------------------------------------------------}

function BoolToStr(Value : Boolean) : string;
begin
  if Value then
    Result := STrueText
  else
    Result := SFalseText;
end;

{------------------------------------------------------------------}

procedure SwapMaxInt(var A , B : integer);
var
  i1 : integer;
  i2 : integer;
begin
  i1 := A;
  i2 := B;
  if i1 > i2 then
    begin
      B := i1;
      A := i2;
    end;
end;

{-------------------------------------------------------------------------}

procedure SwapInt (var a, b : integer);
var
  i : integer;
begin
  i := a;
  a := b;
  b := i;
end;

{--------------------------------------------}

Procedure TCustomDCNamedItems.FreeNotificationProc(Instance:TObject);
Begin
  FOwner:=Nil;
  dcRemoveFreeNotification(Instance,FreeNotificationProc);
End;

{--------------------------------------------}

function TCustomDCNamedItems.IndexOfName(const Name:String):Integer;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    if CompareText(Name,TDCNamedItem(Items[i]).Name)=0 then
    begin
      Result:=i;
      exit;
    end;
  Result:=-1;
end;

{--------------------------------------------}

function TCustomDCNamedItems.IndexOf(Item:TDCNamedItem):Integer;
var
  i:Integer;
begin
  for i:=0 to Count-1 do
    if Items[i]=Item then
    begin
      Result:=i;
      exit;
    end;
  Result:=-1;
end;

{--------------------------------------------}

procedure TCustomDCNamedItems.Update(Item: TCollectionItem);
begin
  inherited;
  If Assigned(FOnChange) then
    FOnChange(Self);
  If Assigned(FOnUpdate) then
    FonUpdate(Self,Item);
end;

{--------------------------------------------}

constructor TCustomDCNamedItems.Create(AOwner:TComponent;ItemClass: TDCNamedItemClass);
begin
  inherited Create(ItemClass);
  FOwner:=AOwner;
  dcAddFreeNotification(FOwner,FreeNotificationProc);
end;

{--------------------------------------------}

destructor TCustomDCNamedItems.Destroy;
begin
  dcRemoveFreeNotification(fOwner, FreeNotificationProc);
  inherited;
end;

{--------------------------------------------}

{$IFDEF D3}
function TCustomDCNamedItems.GetOwner:TPersistent;
begin
  Result:=FOwner;
end;
{$ENDIF}

{--------------------------------------------}

procedure TDCNamedItem.Assign(Source:TPersistent);
begin
  If Source is TDCNamedItem then
    dcdreamLib.AssignAllProps(Source,Self)
  else
    inherited;
end;

{--------------------------------------------}

{$IFDEF D3}

procedure TDCNamedItem.SetDisplayName(const Value: string);
begin
  Name:=Value;
end;

{--------------------------------------------}

function TDCNamedItem.GetDisplayName: string;
begin
  Result:=Name;
  If Result='' then
    Result:=inherited GetDisplayName;
end;
{$ENDIF}

{--------------------------------------------}

procedure TDCNamedItem.OnChange(Sender:TObject);
begin
  Changed(False);
end;

{------------------------------------------------------------------}

function AreObjNotEqualNotNil(Obj1, Obj2 : TObject) : boolean;
begin
  Result:= (Obj2 <> Obj1) and (Obj1 <> nil) and (Obj2 <> nil);
end;

{----------------------------------------------------------}

procedure AssignAllPropsExclude(Source,Dest:TPersistent;ExcludeList:TStringList);
var
  i       : integer;
  Count   : integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
begin
  if not AreObjNotEqualNotNil(Source, Dest) then
    exit;

  Count := GetTypeData(Source.ClassInfo)^.PropCount;
  if Count > 0 then
    begin
      GetMem(PropList, Count * SizeOf(Pointer));
      try
        GetPropInfos(Source.ClassInfo,PropList);
        for i := 0 to Count - 1 do
          begin
            PropInfo := PropList^[I];
            if (ExcludeList = nil) or (ExcludeList.IndexOf(PropInfo.Name) < 0) then
              AssignProp(Source, Dest, PropInfo.Name);
          end;
      finally
        FreeMem(PropList);
      end;
    end;
end;

{----------------------------------------------------------}

procedure AssignAllProps(Source, Dest : TPersistent);
begin
  AssignAllPropsExclude(Source, Dest, nil);
end;

{----------------------------------------------------------}

procedure AssignProp(Source,Dest:TPersistent;const Propname:String);
begin
  AssignPropInfo(Source,Dest,GetPropInfo(Source.ClassInfo, PropName),
    GetPropInfo(Dest.ClassInfo, PropName));
end;

{----------------------------------------------------------}

procedure AssignPropInfo(Source,Dest:TPersistent;SourceInfo,DestInfo:PPropInfo);
begin
  if Assigned(sourceinfo) and Assigned(destinfo) then
    case GetPTypeInfo(sourceinfo).kind of
      tkInteger, tkChar, tkSet, tkClass, tkEnumeration :
        SetOrdProp(Dest, destinfo, GetOrdProp(Source, sourceinfo));
      tkFloat:
        SetFloatProp(Dest, destinfo, GetFloatProp(Source, sourceinfo));
      tkString,tkWChar, tkLString{$IFDEF D3} ,tkWString {$ENDIF}:
        SetStrProp(Dest, destinfo, GetStrProp(Source, sourceinfo));
      tkVariant:
        SetVariantProp(Dest, destinfo, GetVariantProp(Source, sourceinfo));
    end;
end;

{----------------------------------------------------------}

function GetPTypeInfo(PropInfo : PPropInfo) : PTypeInfo;
begin
  if PropInfo = nil then
    result := nil
  else
  {$IFDEF D3}
    result := PropInfo.PropType^;
  {$ELSE}
    result := PropInfo.PropType;
  {$ENDIF}
end;

{--------------------------------------------}

procedure ParseString(const s : string; Separator : char; AStrings : TStrings);
var
  slist : TStringList;
begin
  slist := TStringList.Create;
  with slist do
    try
      Text := ChangeCharTo(Separator, #10, s);
      AStrings.AddStrings(slist);
    finally
      Free;
    end;
end;

{-------------------------------------------------------------------------}

Procedure ParseAndCompactString( Const S : String; ASeparator : Char; AStrings : TStrings );
Var
  I, OldCount : Integer;
begin
  OldCount := AStrings.Count;
  ParseString( S, ASeparator, AStrings );
  For I := AStrings.Count - 1 To OldCount Do
  begin
    AStrings[I] := Trim( AStrings[I] );
    If AStrings[I]= '' Then
      AStrings.Delete( I );
  end;
end;

{-------------------------------------------------------------------------}

function ChangeCharTo(FromChar, ToChar : char; const s : string) : string;
var
  i : Integer;
begin
  result := s;
  for i := Length(Result) - 1 downto 0 do
    if Result[i + 1] = FromChar then
      Result[i + 1] := ToChar;
end;

{------------------------------------------------------------------}

type
  TMPersistent = class(TPersistent)
  end;

{------------------------------------------------------------------}

function GetOwner(c : TObject) : TPersistent;
begin
{$IFDEF D3}
   if c is TPersistent then
     result := TMPersistent(c).GetOwner
   else
     result := nil;
{$ELSE}
   if c is TComponent then
     result := TComponent(c).Owner
   else
     result := nil;
{$ENDIF}
end;

{------------------------------------------------------------------}

function TSortedKeyList.KeyByItem(Item : Pointer) : pointer;
begin
  Result := Item;
end;

{------------------------------------------------------------------}

function  TSortedKeyList.CompareWithKey(Item, Key : Pointer) : integer;
begin
  result := inherited Compare(KeyByItem(Item), Key);
end;

{------------------------------------------------------------------}

function  TSortedKeyList.Compare(Item1, Item2 : Pointer) : integer;
begin
  result := inherited Compare(KeyByItem(Item1), KeyByItem(Item2));
end;

{--------TSortedListEx-----------------------------------------}

function TSortedListEx.InternalFindNearest(Item: Pointer; var Index: Integer;
           CompareProc : TListCompare) : boolean;
var
  L, H, I, C: Integer;
  list : PPointerList;
begin
  Result := False;
  L := 0;
  H := InternalList.Count - 1;
  list := InternalList.List;
  while L <= H do
  begin
    I := (L + H) shr 1;
    FCurrentIndex := I;
    C := CompareProc(list[I], Item);
    if C < 0 then L := I  else
    begin
      H := I;
      if C = 0 then
      begin
        Result := True;
        L := I;
        break;
      end
    end;
    if H - L <= 1 then
      break;
  end;
  Index := L;
end;

{-------------------------------------------------------------}

function TSortedListEx.FindNearest(Item: Pointer; var Index: Integer): Boolean;
begin
  if not Sorted then
    begin
      Index := InternalList.IndexOf(Item);
      Result := Index >= 0;
    end
  else
    Result := InternalFindNearest(Item, index, Compare);
end;

{***********************************************************}

constructor TRecordList.Create(RecordSize : integer);
begin
  inherited Create;
  fRecordSize := RecordSize;
end;

{-----------------------------------------------------------}

destructor  TRecordList.Destroy;
begin
  Clear;
  inherited;
end;

{-----------------------------------------------------------}

procedure TRecordList.Grow(NewCount:Integer);
var
  NewCapacity:Integer;
begin
  if NewCount>=Capacity then
  begin
    NewCapacity:=Max(Capacity*2,32);
    Capacity:=Max(NewCount,NewCapacity);
  end;
end;

{-----------------------------------------------------------}

function TRecordList.Add(Data : Pointer) : integer;
begin
  Result:=Count;
  Grow(Result);
  if Data <> nil then
    Move(Data^, Items[result]^, fRecordSize)
  else
    FillChar(Items[result]^, fRecordSize, 0);

  inc(fCount);
end;

{-----------------------------------------------------------}

function    TRecordList.Get(index : integer) : Pointer;

  procedure _Error(index : integer);
  begin
    ErrorFmt(ResStr(SListIndexError), [index]);
  end;

begin
  if index > fCount then
    _Error(index);
  result := fMemory + index * fRecordSize;
end;

{-----------------------------------------------------------}

procedure   TRecordList.Delete(Index : integer);
begin
  if (Index < 0) or (Index > fCount)  then
    ErrorFmt(ResStr(SListIndexError), [Index]);
  Dec(FCount);
  if Index < FCount then
    System.Move(Items[Index + 1]^, Items[Index]^, (FCount - Index) * fRecordSize);
end;

{-----------------------------------------------------------}

procedure TRecordList.Clear;
begin
  SetCapacity(0);
  fCount := 0;
end;

{-----------------------------------------------------------}

procedure TRecordList.SetCapacity(Size : Integer);
begin
  if Size <> fCapacity then
    begin
      ReallocMem(fMemory, Size * fRecordSize);
      fCapacity := Size;
    end;
end;

{-----------------------------------------------------------}

procedure TRecordList.SetCount(Value:integer);
begin
  Grow(Value);
  FCount:=Value;
end;

{-----------------------------------------------------------}

procedure   TRecordList.SaveToStream(S : TStream);
begin
  with S do
    begin
      Write(fCount, sizeof(fCount));
      Write(fMemory^, fCount * fRecordSize);
    end;
end;

{-----------------------------------------------------------}

procedure   TRecordList.LoadFromStream(S : TStream);
begin
  with S do
    begin
      Read(fcount, sizeof(integer));
      SetCapacity(fcount);
      Read(fMemory^, fcount * fRecordSize);
    end;
end;


{***************************************************************}

function GetVMT(Obj:TObject):Pointer;
asm
  mov eax, [eax]
end;

{------------------------------------------------------------------}

procedure TSortedKeyDataList.Delete(Index: Integer);
begin
  TObject(Items[Index]).Free;
  inherited;
end;

{------------------------------------------------------------------}

destructor TSortedKeyDataList.Destroy;
begin
  ClearList(InternalList);
  inherited;
end;

{------------------------------------------------------------------}

function TSortedKeyDataList.ItemByKey(KeyPtr : pointer) : pointer;
var
  index : integer;
begin
  result := nil;
  if not FListDataClass.InheritsFrom(TSortedListData) then
    exit;

  index := IndexOfKey(KeyPtr);
  if index >= 0 then
    result := TSortedListData(Items[Index]^).ValuePtr;
End;

{------------------------------------------------------------------}

function TSortedKeyDataList.KeyByItem(item : pointer) : pointer;
begin
  result := TSortedCustomData(item).FKeyPtr;
end;

{------------------------------------------------------------------}

constructor TSortedCustomData.Create(KeyPtr : pointer);
begin
  inherited Create;
  FKeyPtr := KeyPtr;
end;

{------------------------------------------------------------------}

constructor TSortedKeyDataList.Create(ListDataClass : TSortedCustomDataClass);
begin
  inherited Create;
  FListDataClass := ListDataClass;
end;

{------------------------------------------------------------------}

function TSortedKeyDataList.Add(KeyPtr : pointer) : TSortedCustomData;
begin
  result := FListDataClass.Create(KeyPtr);
  inherited Add(Result);
end;

{------------------------------------------------------------------}

constructor TSortedCompKeyList.Create(ListDataClass:TSortedCustomDataClass);
begin
  inherited;
end;

{------------------------------------------------------------------}

procedure TSortedCompKeyList.Delete(Index: Integer);
begin
  dcRemoveFreeNotification(
    TObject(TSortedCustomData(Items[Index]).FKeyPtr),Notification);
  inherited;
end;

{------------------------------------------------------------------}

procedure TSortedCompKeyList.Notification(Instance: TObject);
var
  index : integer;
begin
  index := IndexOfKey(Instance);
  if index >= 0 then
    Delete(index);
end;

{---------------------------------------------------}

destructor TSortedCompKeyList.Destroy;
Var
  I:Integer;
begin
  For I:=0 To Count-1 Do
    Delete(I);
  inherited;
end;

{---------------------------------------------------}

function TSortedCompKeyList.Add(KeyPtr : pointer) : TSortedCustomData;
begin
  Result := inherited Add(KeyPtr);
  dcAddFreeNotification(KeyPtr, Notification);
end;

{---------------------------------------------------}

type
  TDComponent = class(TComponent)
  end;

constructor TDCLinkedComponent.Create(AOwner : TComponent);
begin
  inherited;
  if AOwner <> nil then
    fNotifyProc := TDComponent(AOwner).Notification;
end;

{------------------------------------------------------------------}

destructor TDCLinkedComponent.Destroy;
begin
  if fLink <> nil then
    dcRemoveFreeNotification(fLink, FreeNotifyProc);

  inherited;
end;

{------------------------------------------------------------------}

procedure TDCLinkedComponent.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited;
  if AComponent = fLink then
    begin
      if Operation = opRemove then
        FLink:=nil;

      if Assigned(fNotifyProc) then
        fNotifyProc(AComponent, Operation);
    end;
end;

{------------------------------------------------------------------}

procedure TDCLinkedComponent.FreeNotifyProc(Instance : TObject);
begin
  if Instance = Link then
    begin
      if Assigned(fNotifyProc) then
        fNotifyProc(TComponent(Instance), opRemove);

      fLink := nil;
    end;
end;

{------------------------------------------------------------------}

procedure TDCLinkedComponent.SetLink(V:TObject);
begin
  if V <> FLink then
    begin
      if (fLink <> nil) then
        dcRemoveFreeNotification(fLink, FreeNotifyProc);

      fLink := V;

{      if V is TComponent then
        TComponent(V).FreeNotification(self)
      else
}
      if V <> nil then
        dcAddFreeNotification(V, FreeNotifyProc);
    end;
end;

{------------------------------------------------------------------}

function GetFloatSize(FloatType : TFloatType) : integer;
begin
  case FloatType of
    ftSingle : result := sizeof(Single);
    ftDouble : result := sizeof(Double);
    ftExtended : result := sizeof(Extended);
    ftComp : result := sizeof(Comp);
    ftCurr : result := sizeof(Currency);
    else
      result := 0;
  end;
end;

{------------------------------------------------------------------}

function GetPropValueSize(Instance : TPersistent; Propinfo : PPropInfo) : integer;
var
  pti : PTypeInfo;
begin
  if PropInfo = nil then
    result := 0
  else
    begin
      pti := GetPTypeInfo(propinfo);
      with pti^, GetTypeData(pti)^ do
        case kind of
          tkInteger, tkChar, tkSet, tkClass, tkEnumeration :
            result := GetOrdSize(OrdType);
          tkFloat:
            result := GetFloatSize(FloatType);
          tkString, tkWChar, tkLString {$IFDEF D3} ,tkWString {$ENDIF}:
            result := length(GetStrProp(Instance, propinfo));
          tkVariant:
            result := sizeof(Variant);
          else
            result := 0;
        end;
    end;
end;

{---------------------------------------}

function GetOrdSize(O : TOrdType) : integer;
begin
  case O of
    otSByte, otUByte : result := 1;
    otSWord, otUWord : result := 2;
  else
    result := 4;
  end;
end;

{------------------------------------------------------------------}

function GetPropValueByPropInfo(Instance : TPersistent; Propinfo : PPropInfo) : Variant;
begin
  if PropInfo = nil then
    result := UnAssigned
  else
    case GetPTypeInfo(propinfo).kind of
      tkInteger, tkChar, tkSet, tkClass, tkEnumeration :
         result := GetOrdProp(Instance, propinfo);
      tkFloat:
         result := GetFloatProp(Instance, propinfo);
      tkString, tkWChar, tkLString {$IFDEF D3} ,tkWString {$ENDIF}:
         result := GetStrProp(Instance, propinfo);
      tkVariant:
         result := GetVariantProp(Instance, propinfo);
    end;
end;

{------------------------------------------------------------------}

procedure SetPropValueByPropInfo(Instance : TPersistent; Propinfo : PPropInfo; const Value : Variant);
var
  CorrectedValue : Variant;
begin
  if PropInfo = nil then
    exit;

  case GetPTypeInfo(propinfo).kind of
    tkInteger, tkChar, tkSet, tkClass, tkEnumeration :
      begin
        If TVarData(Value).VType=VarString then
          CorrectedValue:=StrToInt(Value)
        else
          CorrectedValue := CorrectBool(Value);

        SetOrdProp(Instance, propinfo, CorrectedValue);
      end;
    tkFloat:
       SetFloatProp(Instance, propinfo, Value);
    tkString, tkWChar, tkLString {$IFDEF D3} ,tkWString {$ENDIF}:
       SetStrProp(Instance, propinfo, {$IFDEF D5}String(Value){$ELSE}Value{$ENDIF});
    tkVariant:
       SetVariantProp(Instance, propinfo, Value);
  end;
end;

{------------------------------------------------------------------}

function GetClassProperty(Instance : TPersistent; const PropName : String) : TObject;
var
  propinfo : PPropInfo;
begin
  result := nil;
  if Instance = nil then
    exit;

  propinfo := GetPropInfo(Instance.ClassInfo, PropName);

  if propinfo <> nil then
    result := TObject(GetOrdProp(Instance, propinfo));
end;

{------------------------------------------------------------------}

function CorrectBool(const V:Variant):Variant;
begin
  Result:=V;
  With TVarData(Result) do
    If (VType=varBoolean) and VBoolean then
    begin
      VType:=varInteger;
      VInteger:=1;
    end;
end;

{---------------------------------------}

procedure ForEachProp(Instance:TPersistent;CallBack:TPropCallBack;AOnlyStored:Boolean;UserData:Integer);
begin
  IterateProps(Instance,tkAny,CallBack,AOnlyStored,UserData);
end;

{---------------------------------------}

procedure IterateProps(Instance:TPersistent;TypeKinds: TTypeKinds;
            CallBack:TPropCallBack;AOnlyStored:Boolean;UserData:Integer);
var
  I, Count, RealCount: Integer;
  PropInfo: PPropInfo;
  PropList: PPropList;
begin
  If not Assigned(CallBack) then
    exit;

  if Instance.ClassInfo = nil then
    exit;

  Count := GetTypeData(Instance.ClassInfo)^.PropCount;
  if Count > 0 then
  begin
    GetMem(PropList, Count * SizeOf(Pointer));
    try
      RealCount:=GetPropList(Instance.ClassInfo,TypeKinds,PropList);
      for I := 0 to RealCount - 1 do
      begin
        PropInfo := PropList^[I];
        if not AOnlyStored or IsStoredProp(Instance, PropInfo) then
          CallBack(Instance,PropInfo,UserData);
      end;
    finally
      FreeMem(PropList, Count * SizeOf(Pointer));
    end;
  end;
end;

{------------------------------------------------------------------}

function  InheritsFromClassName(Instance : TObject; const CName : string) : boolean;
var
  c : TClass;
begin
  result := Instance <> nil;
  if not result then
    exit;

  c := Instance.ClassType;

  repeat
    if CompareText(c.ClassName, CName) = 0 then
      exit;
    c := c.ClassParent
  until c = nil;

  result := false;
end;

{---------------------------------------------------------}

function GetDWordSize(i : integer) : integer;
begin
  result := i div 4 + byte(i mod 4 > 0);
end;

{-----------------------------------------------------------}

{$IFDEF D3}
function ResStr(const Ident: string): string;
begin
  Result := Ident;
end;
{$ELSE}
function ResStr(Ident: Cardinal): string;
begin
  Result := LoadStr(Ident);
end;
{$ENDIF}

{-------------------------------------------------------------}

function ListIndexOf(List:TList;Item:Pointer):Integer;
asm
  mov   ecx, [eax + 8] // List.Count
  jcxz  @notfound
  push  edi
  mov   edi, [eax + 4] // List.List
  mov   eax, ecx
  xchg  eax, edx
  repne scasd
  pop   edi
  jne   @notfound
  mov   eax, edx
  sub   eax, ecx
  dec   eax
  ret
@notfound:
  or    eax, -1
end;

{-----------------------------------------------------------}

type
        StrRec = record
        allocSiz:       Longint;
        refCnt: Longint;
        length: Longint;
        end;

const
        skew = sizeof(StrRec);

function BackPosEx(const SubStr, S : String; FromChar : Integer) : Integer;
asm
        TEST    EAX,EAX
        JE      @@noWork

        TEST    EDX,EDX
        JE      @@stringEmpty

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI

        MOV     ESI,EAX
        MOV     EDI,EDX
        PUSH    EDI

        MOV     EAX, ECX

        MOV     ECX,[EDI-skew].StrRec.length

        MOV     EDX,[ESI-skew].StrRec.length

        CMP     ECX, EDX
        JL      @@fail

        MOV     ECX, EAX
        ADD     EDI, EAX
        DEC     EDI

@@l1:
        DEC     EDX
        JS      @@fail
        MOV     AL,[ESI]
        INC     ESI

        JLE     @@fail
@@loop:
        STD
        REPNE   SCASB
        JNE     @@fail
        MOV     EBX,ECX
        OR      EDX, EDX
        JE      @@found
        PUSH    ESI
        PUSH    EDI
        INC     EDI
        INC     EDI
        MOV     ECX,EDX
        CLD
        REPE    CMPSB
        POP     EDI
        POP     ESI
        JE      @@found
        MOV     ECX,EBX
        JMP     @@loop

@@fail:
        POP     EDX
        XOR     EAX,EAX
        JMP     @@exit

@@stringEmpty:
        XOR     EAX,EAX
        JMP     @@noWork

@@found:
        POP     EDX
        MOV     EAX,EDI
        SUB     EAX,EDX
        INC     EAX
        INC     EAX
@@exit:
        POP     EDI
        POP     ESI
        POP     EBX
        CLD
@@noWork:
end;

{------------------------------------------------------------------}

function PosEx(const SubStr, S : String; FromChar : Integer) : Integer;
asm
        TEST    EAX,EAX
        JE      @@noWork

        TEST    EDX,EDX
        JE      @@stringEmpty

        PUSH    EBX
        PUSH    ESI
        PUSH    EDI

        MOV     ESI,EAX
        MOV     EDI,EDX
        PUSH    EDI

        MOV     EAX, ECX

        MOV     ECX,[EDI-skew].StrRec.length

        MOV     EDX,[ESI-skew].StrRec.length

        CMP     ECX, EDX
        JL      @@fail

        ADD     EDI, EAX
        SUB     ECX, EAX
        INC     ECX
        DEC     EDI

@@l1:
        DEC     EDX
        JS      @@fail
        MOV     AL,[ESI]
        INC     ESI

        SUB     ECX,EDX

        JLE     @@fail
@@loop:
        REPNE   SCASB
        JNE     @@fail
        MOV     EBX,ECX
        PUSH    ESI
        PUSH    EDI

        MOV     ECX,EDX
        CLD
        REPE    CMPSB
        POP     EDI
        POP     ESI
        JE      @@found
        MOV     ECX,EBX
        JMP     @@loop

@@fail:
        POP     EDX
        XOR     EAX,EAX
        JMP     @@exit

@@stringEmpty:
        XOR     EAX,EAX
        JMP     @@noWork

@@found:
        POP     EDX
        MOV     EAX,EDI
        SUB     EAX,EDX
@@exit:
        POP     EDI
        POP     ESI
        POP     EBX
        CLD
@@noWork:
end;

{------------------------------------------------------------------}

procedure WriteObjToStream(Stream : TStream; Instance : TPersistent);
var
  c : TPersHolder;
begin
  if Instance is TComponent then
    Stream.WriteComponent(TComponent(Instance))
  else
    begin
      c := TPersHolder.Create(nil);
      try
        c.P := Instance;
        Stream.WriteComponent(c);
      finally
        c.Free;
      end;
    end;
end;

{------------------------------------------------------------------}

procedure ReadObjFromStream(Stream : TStream; Instance : TPersistent);
var
  c : TPersHolder;
begin
  BeginGlobalLoading;
  try
    if Instance is TComponent then
      begin
        Stream.ReadComponent(TComponent(Instance));
        NotifyGlobalLoading;
      end
    else
      begin
        c := TPersHolder.Create(nil);
        try
          c.P := Instance;
          Stream.ReadComponent(c);
        finally
          c.Free;
        end;
      end;
  finally
    EndGlobalLoading;
  end;
end;

{------------------------------------------------------------------}

procedure WriteObjToTextStream(Stream:TStream;Instance:TPersistent);
var
  TempStream:TMemoryStream;
begin
  TempStream:=TMemoryStream.Create;
  try
    WriteObjToStream(TempStream,Instance);
    TempStream.Seek(0,soFromBeginning);
    ObjectBinaryToText(TempStream,Stream);
  finally
    TempStream.Free;
  end;
end;

{--------------------------------------------}

procedure ReadObjFromTextStream(Stream:TStream;Instance:TPersistent);
var
  TempStream:TMemoryStream;
begin
  TempStream:=TMemoryStream.Create;
  try
    ObjectTextToBinary(Stream,TempStream);
    TempStream.Seek(0,soFromBeginning);
    ReadObjFromStream(TempStream,Instance);
  finally
    TempStream.Free;
  end;
end;

{--------------------------------------------}

procedure WriteObjToTextFile(Instance:TPersistent;const FileName:String);
Var
  F:TFileStream;
begin
  F:=TFileStream.Create(FileName,fmcreate);
  try
    WriteObjToTextStream(F,Instance);
  finally
    F.Free;
  end;
end;

{------------------------------------------------------------------}

procedure ReadObjFromTextFile(Instance:TPersistent;const FileName:String);
Var
  F:TFileStream;
begin
  F:=TFileStream.Create(FileName, DefaultOpenMode);
  try
    ReadObjFromTextStream(F,Instance);
  finally
    F.Free;
  end;
end;

{------------------------------------------------------------------}

procedure ReadObjFromFile(Instance:TPersistent;const FileName:String);
Var
  F:TFileStream;
begin
  F:=TFileStream.Create(FileName, DefaultOpenMode);
  try
    ReadObjFromStream(F,Instance);
  finally
    F.Free;
  end;
end;

{------------------------------------------------------------------}

procedure WriteObjToFile(Instance:TPersistent;const Filename:String);
Var
  F:TFileStream;
begin
  F:=TFileStream.Create(FileName,fmcreate);
  try
    WriteObjToStream(F,Instance);
  finally
    F.Free;
  end;
end;

{------------------------------------------------------------------}

procedure GetMem0(var P; Size: Integer);
begin
  GetMem(pointer(p), Size);
  FillChar(pointer(p)^, size, 0);
end;

{------------------------------------------------------------------}

Procedure DCQuickSort( L, R: Integer; AOnCompare : TDCCompareCallBack;
                       AOnExchange : TDCExchangeCallBack );
Var
  I, J, P : Integer;
begin
  If R <= L Then
    Exit;
  Repeat
    I := L;
    J := R;
    P := ( L + R ) Shr 1;
    Repeat
      While AOnCompare( I, P ) < 0 Do
        Inc( I );
      While AOnCompare( J, P ) > 0 Do
        Dec( J );
      If I <= J Then
      begin
        If I <> J Then
        begin
          If AOnCompare( I, J ) <> 0 Then
            AOnExchange( I, J );
          If P = I Then
            P := J
          Else
            If P = J Then
              P := I;
        end;
        Inc( I );
        Dec( J );
      end;
    Until I > J;
    If L < J Then
      DCQuickSort( L, J, AOnCompare, AOnExchange );
    L := I;
  Until I >= R;
end;

{------------------------------------------------------------------}

{ TDCCaseSensitiveStringList }

{$IFNDEF D5}
Function TDCCaseSensitiveStringList.CaseSensitiveStringListCompare( AFirstItem, ASecondItem : Integer ) : Integer;
begin
  Result := CompareStr( Strings[ AFirstItem ], Strings[ ASecondItem ] );
end;

{------------------------------------------------------------------}

Procedure TDCCaseSensitiveStringList.ExchangeCallBack( AOrigin, ADestination : Integer );
begin
  Exchange( AOrigin, ADestination );
end;
{$ENDIF}

{------------------------------------------------------------------}

Function TDCCaseSensitiveStringList.Find( Const S : String; Var Index : Integer ) : Boolean;
Var
  L, H, I, C: Integer;
begin
  Result := False;
  L := 0;
  H := Count - 1;
  While L <= H Do
  begin
    I := ( L + H ) Shr 1;
    C := CompareStr( Strings[ I ], S );
    If C < 0 Then
      L := I + 1
    Else
    begin
      H := I - 1;
      If C = 0 Then
      begin
        Result := True;
        If Duplicates <> dupAccept Then
          L := I;
      end;
    end;
  end;
  Index := L;
end;

{------------------------------------------------------------------}

{$IFDEF D5}
Function DCCaseInsensitiveStringListCompare( AList : TStringList; AFirstItem, ASecondItem : Integer ) : Integer;
begin
  Result := CompareStr( AList[ AFirstItem ], AList[ ASecondItem ] );
end;
{$ENDIF}
{------------------------------------------------------------------}

Procedure TDCCaseSensitiveStringList.Sort;
begin
  {$IFDEF D5}
  CustomSort( DCCaseInsensitiveStringListCompare );
  {$ELSE}
  If Not Sorted And ( Count > 1 ) Then
  begin
    Changing;
    DCQuickSort( 0, Count - 1, CaseSensitiveStringListCompare,  ExchangeCallBack);
    Changed;
  end;
  {$ENDIF}
end;

{------------------------------------------------------------------}

{ TMethodList }

function TMethodList.Add(const Data: TMethod): integer;
begin
  result := fList.Add(@Data); 
end;

{------------------------------------------------------------------}

procedure TMethodList.Clear;
begin
  fList.Clear;
end;

{------------------------------------------------------------------}

constructor TMethodList.Create;
begin
  inherited;
  fList := TRecordList.Create(sizeof(TMethod));
end;

{------------------------------------------------------------------}

procedure TMethodList.Delete(Index: integer);
begin
  fList.Delete(index);
end;

{------------------------------------------------------------------}

destructor TMethodList.Destroy;
begin
  fList.Free;
  inherited;
end;

{------------------------------------------------------------------}

function TMethodList.Get(index: integer): TMethod;
type
  PMethod = ^TMethod;
begin
  result := PMethod(fList.Items[index])^;
end;

{------------------------------------------------------------------}

function TMethodList.GetCapacity: integer;
begin
  result := fList.Capacity;
end;

{------------------------------------------------------------------}

function TMethodList.GetCount: integer;
begin
  result := fList.Count;
end;

{------------------------------------------------------------------}

procedure TMethodList.Remove(const Data: TMethod);
var
  i : integer;
begin
  for i := 0 to Count - 1 do
    if IsMethodsEqual(Get(i), Data) then
      begin
        Delete(i);
        exit;
      end;
end;

{------------------------------------------------------------------}

procedure TMethodList.SetCapacity(val: integer);
begin
  fList.Capacity := val;
end;

{------------------------------------------------------------------}
{$IFDEF D6}
function PSCSupportsInstance(const Unk:IUnknown;const C:TClass;var Instance:TObject):boolean;
begin
  Instance:=PSCGetIntfInstance(Unk);
  Result:=(Instance<>nil) and (Instance is C);
  If not Result then
    Instance:=nil;
end;

{------------------------------------------------------------------}

function PSCGetIntfInstance(const Unk:IUnknown):TObject;
var
  A:IPSCGetInstance;
begin
  if (Unk<>nil) and Supports(Unk,IPSCGetInstance, A) then
    Result:=A.GetIntfImplementer
  else
    Result:=nil;
end;
{$ENDIF}

{---------------------------}
{$IFDEF D6}
procedure InterfaceListQuickSort(SortList: TDCInterfaceList; L, R: Integer;
  SCompare: TDCInterfaceListSortCompare);
var
  I, J: Integer;
  P, T: IUnknown;
begin
  repeat
    I := L;
    J := R;
    P := SortList[(L + R) shr 1];
    repeat
      while SCompare(SortList[I], P) < 0 do
        Inc(I);
      while SCompare(SortList[J], P) > 0 do
        Dec(J);
      if I <= J then
      begin
        T := SortList[I];
        SortList[I] := SortList[J];
        SortList[J] := T;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      InterfaceListQuickSort(SortList, L, J, SCompare);
    L := I;
  until I >= R;
end;

{---------------------------}

procedure TDCInterfaceList.Sort(Compare:TDCInterfaceListSortCompare);
begin
  if (Count > 0) then
    InterfaceListQuickSort(Self, 0, Count - 1, Compare);
end;
{$ENDIF}

{------------------------------------------------------------------}

{$IFDEF OLDSTYLEFREEPROCS}
{$IFDEF D5}
procedure FreeList(var ListVar);overload;
begin
  FreeList(TList(ListVar),ListVar);
end;

{------------------------------------------------------------------}

procedure FreeSortedList(var ListVar);overload;
begin
  FreeSortedList(TSortedList(ListVar),ListVar);
end;

{$ENDIF}
{$ENDIF}

{-------------------------------------------------------------------------}
{$IFDEF D6}
function D5StringToOleSt(const Source: string): PWideChar;
var
  SourceLen, ResultLen: Integer;
  Buffer: array[0..1023] of WideChar;
begin
  SourceLen := Length(Source);
  if Length(Source) < SizeOf(Buffer) div 2 then
    Result := SysAllocStringLen(Buffer, MultiByteToWideChar(0, 0,
      PChar(Source), SourceLen, Buffer, SizeOf(Buffer) div 2))
  else
  begin
    ResultLen := MultiByteToWideChar(0, 0,
      Pointer(Source), SourceLen, nil, 0);
    Result := SysAllocStringLen(nil, ResultLen);
    MultiByteToWideChar(0, 0, Pointer(Source), SourceLen,
      Result, ResultLen);
  end;
end;
{$ENDIF}
{-------------------------------------------------------------------------}

function DCStringToOleSt(const Source: string): PWideChar;
begin
  {$IFDEF D6}
  If Source='' then
    Result:=D5StringToOleSt(Source)
  else
  {$ENDIF}
    Result:=StringToOleStr(Source);
end;

{------------------------------------------------------------------}

initialization
{$IFDEF WIN}
  CheckTrialVersion;
{$ENDIF}
end.
