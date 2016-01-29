unit tc5OpenAppClasses;

{$I tc5_ver.inc}

interface

uses
  Forms, Classes, Windows, ActiveX
{$IFDEF DELPHI7}
{$IFNDEF BCB}
  , ObjAuto
{$ENDIF}
{$ENDIF}
;

const
  cDelphiModuleInfoVersion = $04001010;


type
  TtcMethodType = (mtGet, mtPut, mtInvoke);

  TtcMethodProc = procedure(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;

  TtcTypeKind = (tckUnknown, tckInteger, tckChar, tckEnumeration, tckFloat,
    tckString, tckSet, tckClass, tckMethod, tckWChar, tckLString, tckWString,
    tckVariant, tckArray, tckRecord, tckInterface, tckInt64, tckDynArray);

  PtcParameter = ^TtcParameter;
  TtcParameter = packed record
    Name: WideString;
    TypeKind: TtcTypeKind;
    TypeName: WideString;
    VT: Integer;
    Data: Pointer;
  end;
  PtcParameterArray = ^TtcParameterArray;
  TtcParameterArray = array[0..MaxListSize] of PtcParameter;

  PtcMethodInfo = ^TtcMethodInfo;
  TtcMethodInfo = packed record
    MethodType: TtcMethodType;
    MethodName: WideString;
    RetVal: PtcParameter;
    ParamCount: Integer;
    Params: PtcParameterArray;
    MethodProc: TtcMethodProc;
    Cookie: Cardinal;
  end;

  PtcMethodInfoList = ^TtcMethodInfoList;
  TtcMethodInfoList = array[0..MaxListSize] of PtcMethodInfo;

type
  TVarToObject = function(const V: OleVariant): TObject;
  TVarFromObject = function(Obj: TObject): IDispatch;

var
  VarToObjectProc: TVarToObject;
  VarFromObjectProc: TVarFromObject;

type
  TGetMethodList = function(TypeInfo: Pointer;
    out MethodInfoList: PtcMethodInfoList; out Size: Integer): Boolean;
  TReleaseMethodList = procedure(MethodList: PtcMethodInfoList);

var
  GetMethodListProc: TGetMethodList;
  ReleaseMethodListProc: TReleaseMethodList;

type
  ItcObjectInfoProvider = interface
    ['{5257EAA5-3D83-435C-967D-583525F4BA12}']
    function CheckInheritedFrom(Instance: Pointer; const ClassName: WideString): WordBool; stdcall;
    function ObjectIsValid(Instance: Pointer): WordBool; stdcall;
    function GetVMT(Instance: Pointer; const ClassName: WideString;
      out Offset: Integer; out VMT: Pointer): WordBool; stdcall;
    function GetClassName(Instance: Pointer): WideString;
    function GetInstanceSize(Instance: Pointer): Integer;
  end;

  ItcComponentInfoProvider = interface
    ['{BE752B7C-D03C-4E54-9828-D9D80EE3E56E}']
    function GetComponentCount(Component: Pointer): Integer; stdcall;
    function GetChildComponent(Component: Pointer; Index: Integer): Pointer; stdcall;
    function GetComponentName(Component: Pointer): WideString; stdcall;
    function GetOwner(Component: Pointer): Pointer; stdcall;
    function FindComponent(Component: Pointer; const Name: WideString): Pointer; stdcall;
  end;

  ItcControlInfoProvider = interface
    ['{28AB2D28-4938-45F1-B2EB-510820D6CCC5}']
    procedure ClientToScreen(Control: Pointer; var Point: TPoint); stdcall;
    procedure ScreenToClient(Control: Pointer; var Point: TPoint); stdcall;
    function GetParent(Control: Pointer): Pointer; stdcall;
    function GetEnabled(Control: Pointer): WordBool; stdcall;
    function GetVisible(Control: Pointer): WordBool; stdcall;
    function GetWidth(Control: Pointer): Integer; stdcall;
    function GetHeight(Control: Pointer): Integer; stdcall;
    function GetLeft(Control: Pointer): Integer; stdcall;
    function GetTop(Control: Pointer): Integer; stdcall;
  end;

  PtcTypeInfo = ^TtcTypeInfo;
  TtcTypeInfo = packed record
    Name: WideString;
    ClassInstance: Pointer;
  end;

  ItcTypeInfoProvider = interface
    ['{A369A4CD-FBD0-458D-A610-D827E59C7FF4}']
    function GetTypeInfo(Instance: Pointer): PtcTypeInfo; stdcall;
    function GetMethodList(TypeInfo: PtcTypeInfo; out MethodList: PtcMethodInfoList;
      out Count: Integer): WordBool; stdcall;
    procedure ReleaseTypeInfo(TypeInfo: PtcTypeInfo); stdcall;
    procedure ReleaseMethodList(MethodList: PtcMethodInfoList); stdcall;
    function CreateInstance(TypeInfo: PtcTypeInfo): Pointer;
    procedure ReleaseInstance(Instance: Pointer);
  end;

  ItcTestClassProvider = interface
    ['{B9F3B9DC-E7B0-4337-AEA6-FE0E437B7A21}']
    function GetCount: Integer;
    function GetTypeInfos(Index: Integer): PtcTypeInfo;
    property Count: Integer read GetCount;
    property TypeInfos[Index: Integer]: PtcTypeInfo read GetTypeInfos;
  end;

  ItcTestClassProviderInternal = interface
    ['{62B4097A-CEBB-4008-99DC-14BCEDEE71DD}']
    procedure RegisterClass(ClassInstance: TClass);
  end;

  ItcWinControlInfoProvider = interface
    ['{38D5B6CE-858F-4EBE-A9D3-1E551E496804}']
    function GetHandle(WinControl: Pointer): Integer; stdcall;
    function GetControlAtPos(WinControl: Pointer; const Pos: TPoint): Pointer; stdcall;
    function FindControl(Handle: HWND): Pointer; stdcall;
    function GetControlCount(Control: Pointer): Integer; stdcall;
    function GetChildControl(Control: Pointer; Index: Integer): Pointer; stdcall;
  end;

  ItcTopComponentProvider = interface
    ['{1909E8AB-97AE-49AC-AE9C-5A32DBEBF722}']
    function GetComponent(Index: Integer): Pointer; stdcall;
    function GetCount: Integer; stdcall;
  end;

  ItcConversions = interface
    ['{072D6CC4-2E66-449B-B990-32484591EF22}']
    function VarToObject(const V: OleVariant): Pointer; stdcall;
    function VarFromObject(Obj: Pointer): IDispatch; stdcall;
  end;

  ItcMethodCallFrame = interface
    ['{753C09E9-D272-4DD9-9BAC-98417AF51346}']
    function GetSyncWindow: Cardinal;
    function MakeSafeCall(Method: TtcMethodProc; Instance: TObject; Args: PVariantArgList;
      out Value: OleVariant; Cookie: Cardinal; ExcepInfo: PExcepInfo): HResult;
  end;

  ItcModuleInfoProvider = interface
    ['{3184DF22-8DBC-4FBA-9747-E69A442337A2}']
    function GetVersion: Integer; stdcall;
    function GetInstance: Cardinal; stdcall;
    function GetTypeInfoProvider: ItcTypeInfoProvider; stdcall;
    function GetObjectInfoProvider: ItcObjectInfoProvider; stdcall;
    function GetComponentInfoProvider: ItcComponentInfoProvider; stdcall;
    function GetControlInfoProvider: ItcControlInfoProvider; stdcall;
    function GetWinControlInfoProvider: ItcWinControlInfoProvider; stdcall;
    function GetTopComponentProvider: ItcTopComponentProvider; stdcall;
    function GetTestClassProvider: ItcTestClassProvider;
    function GetCallFrame: ItcMethodCallFrame;
    procedure SetConversions(const Conversions: ItcConversions);
    function GetMemoryManager: Pointer;
    property Version: Integer read GetVersion;
    property Instance: Cardinal read GetInstance;
    property TypeInfoProvider: ItcTypeInfoProvider read GetTypeInfoProvider;
    property ObjectInfoProvider: ItcObjectInfoProvider read GetObjectInfoProvider;
    property ComponentInfoProvider: ItcComponentInfoProvider read GetComponentInfoProvider;
    property ControlInfoProvider: ItcControlInfoProvider read GetControlInfoProvider;
    property WinControlInfoProvider: ItcWinControlInfoProvider read GetWinControlInfoProvider;
    property TopComponentProvider: ItcTopComponentProvider read GetTopComponentProvider;
    property TestClassProvider: ItcTestClassProvider read GetTestClassProvider;
    property CallFrame: ItcMethodCallFrame read GetCallFrame;
    property MemoryManager: Pointer read GetMemoryManager;
  end;

  {$IFDEF DELPHI7}
  {$IFNDEF BCB}
  ItcMethodInfoProvider = interface
    ['{BD64EC83-9298-4205-B254-E35F81E86C58}']
    function GetCount: Integer;
    function GetName(AMethodIndex: Integer): WideString;
    function GetParamCount(AMethodIndex: Integer): Integer;
    function GetParamInfo(AMethodIndex, AParamIndex: Integer): PParamInfo;
    function GetReturnInfo(AMethodIndex: Integer): PReturnInfo;
    function GetCookie(AMethodIndex: Integer): Pointer;
  end;
  {$ENDIF}
  {$ENDIF}

  PtcTableEntry = ^TtcTableEntry;
  TtcTableEntry = packed record
    Key: Pointer;
    Value: Pointer;
    Next: PtcTableEntry;
  end;
  PtcTableEntryArray = ^TtcTableArray;
  TtcTableArray = array[0..MaxListSize] of PtcTableEntry;

  TtcTable = class
  private
    FItems: PtcTableEntryArray;
    FCount: Integer;
    FCapacity: Integer;
    FThreshold: Integer;
    FLoadFactor: Single;
    procedure Rehash;
  protected
    procedure DoRemove(AItem: Pointer); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    function Get(Key: Pointer): Pointer;
    procedure Put(Key: Pointer; Value: Pointer);
    procedure Remove(Key: Pointer);
    function Exclude(Key: Pointer): Pointer;
    function ContainsKey(Key: Pointer): Boolean;
    procedure Clear;

    property Items[Key: Pointer]: Pointer read Get write Put; default;
    property Count: Integer read FCount;
  end;

  TtcObjectTable = class(TtcTable)
  protected
    procedure DoRemove(AItem: Pointer); override;
  end;

function  CreateModuleInfoProvider: ItcModuleInfoProvider;
{$IFDEF DELPHI7}
{$IFNDEF BCB}
function  CreateMethodInfoProvider(AClass: TClass): ItcMethodInfoProvider;
{$ENDIF}
{$ENDIF}

{$IFNDEF DELPHI6}
{$IFNDEF DELPHI5}
function SameText(const S1, S2: string): Boolean; assembler;
procedure FreeAndNil(var Obj);
{$ENDIF}
function GetModuleName(Module: HMODULE): string;
{$ENDIF DELPHI6}

implementation

uses
  {$IFDEF DELPHI7}
  {$IFNDEF BCB}
  Variants,
  {$ENDIF}
  {$ENDIF}
  SysUtils, TypInfo, Controls, Messages, Math
{$IFDEF TC_USE_CLX}
  ,Qt, QControls, QTypes
{$ENDIF}
;

var
  _Conversions: ItcConversions;

type
  TWinControlFriend = class(TWinControl);

type
  TtcModuleInfoProvider = class(TInterfacedObject, ItcModuleInfoProvider,
    ItcMethodCallFrame)
  private
    FSyncWindow: Cardinal;
    FMemoryManager: TMemoryManager;
    FTypeInfoProvider: ItcTypeInfoProvider;
    FObjectInfoProvider: ItcObjectInfoProvider;
    FComponentInfoProvider: ItcComponentInfoProvider;
    FControlInfoProvider: ItcControlInfoProvider;
    FWinControlInfoProvider: ItcWinControlInfoProvider;
    FTopComponentProvider: ItcTopComponentProvider;
    FTestClassProvider: ItcTestClassProvider;
    procedure SyncWindowProc(var Message: Messages.TMessage);
  protected
    { ItcModuleInfoProvider }
    function GetVersion: Integer; stdcall;
    function GetInstance: Cardinal; stdcall;
    function GetTypeInfoProvider: ItcTypeInfoProvider; stdcall;
    function GetObjectInfoProvider: ItcObjectInfoProvider; stdcall;
    function GetComponentInfoProvider: ItcComponentInfoProvider; stdcall;
    function GetControlInfoProvider: ItcControlInfoProvider; stdcall;
    function GetWinControlInfoProvider: ItcWinControlInfoProvider; stdcall;
    function GetTopComponentProvider: ItcTopComponentProvider; stdcall;
    function GetTestClassProvider: ItcTestClassProvider;
    procedure SetConversions(const Conversions: ItcConversions);
    function GetCallFrame: ItcMethodCallFrame;
    function GetMemoryManager: Pointer;
    { ItcMethodCallFrame }
    function GetSyncWindow: Cardinal;
    function MakeSafeCall(Method: TtcMethodProc; Instance: TObject; Args: PVariantArgList;
      out Value: OleVariant; Cookie: Cardinal; ExcepInfo: PExcepInfo): HResult;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TtcTypeInfoProvider = class(TInterfacedObject, ItcTypeInfoProvider)
  protected
    { ItcTypeInfoProvider }
    function GetTypeInfo(Instance: Pointer): PtcTypeInfo; stdcall;
    function GetMethodList(TypeInfo: PtcTypeInfo; out MethodList: PtcMethodInfoList;
      out Count: Integer): WordBool; stdcall;
    procedure ReleaseTypeInfo(TypeInfo: PtcTypeInfo); stdcall;
    procedure ReleaseMethodList(MethodList: PtcMethodInfoList); stdcall;
    function CreateInstance(TypeInfo: PtcTypeInfo): Pointer;
    procedure ReleaseInstance(Instance: Pointer);
  end;

  TtcObjectInfoProvider = class(TInterfacedObject, ItcObjectInfoProvider)
  protected
    { ItcObjectInfoProvider }
    function CheckInheritedFrom(Instance: Pointer; const ClassName: WideString): WordBool; stdcall;
    function ObjectIsValid(Instance: Pointer): WordBool; stdcall;
    function GetVMT(Instance: Pointer; const ClassName: WideString;
      out Offset: Integer; out VMT: Pointer): WordBool; stdcall;
    function GetClassName(Instance: Pointer): WideString;
    function GetInstanceSize(Instance: Pointer): Integer;
  end;

  TtcComponentInfoProvider = class(TInterfacedObject, ItcComponentInfoProvider)
  protected
    { ItcComponentInfoProvider }
    function GetComponentCount(Component: Pointer): Integer; stdcall;
    function GetChildComponent(Component: Pointer; Index: Integer): Pointer; stdcall;
    function GetComponentName(Component: Pointer): WideString; stdcall;
    function GetOwner(Component: Pointer): Pointer; stdcall;
    function FindComponent(Component: Pointer; const Name: WideString): Pointer; stdcall;
  end;

  TtcControlInfoProvider = class(TInterfacedObject, ItcControlInfoProvider)
  protected
    { ItcControlInfoProvider }
    procedure ClientToScreen(Control: Pointer; var Point: TPoint); stdcall;
    procedure ScreenToClient(Control: Pointer; var Point: TPoint); stdcall;
    function GetParent(Control: Pointer): Pointer; stdcall;
    function GetEnabled(Control: Pointer): WordBool; stdcall;
    function GetVisible(Control: Pointer): WordBool; stdcall;
    function GetWidth(Control: Pointer): Integer; stdcall;
    function GetHeight(Control: Pointer): Integer; stdcall;
    function GetLeft(Control: Pointer): Integer; stdcall;
    function GetTop(Control: Pointer): Integer; stdcall;
  end;

{$IFDEF DELPHI7}
{$IFNDEF BCB}
  TtcMethodInfoHeaderArray = packed array[0..High(Word)-1] of TMethodInfoHeader;

  PtcPMethodTable = ^TtcPMethodTable;
  TtcPMethodTable = packed record
    Count:           Word;
    MethodInfoArray: TtcMethodInfoHeaderArray;
  end;

  TtcMethodInfoProvider = class(TInterfacedObject, ItcMethodInfoProvider)
  private
    FClass:            TClass;
    FMethodHeaders:    TList;
    FMethodNames:      TStringList;
    //
    procedure ClearMethodInfo;
    function  GetNextParam(AParamInfo: PParamInfo): PParamInfo;
    function  IsExtendedRTTIExists(AMethod: PMethodInfoHeader): Boolean;
    function  GetMethodTable(AClass: TClass): PtcPMethodTable;
    function  GetMethodInfoHeader(AClass: TClass; AIndex: Integer): PMethodInfoHeader;
    function  GetMethodInfoHeaderCount(AClass: TClass): Integer;
    function  GetCachedMethodInfoHeader(AIndex: Integer): PMethodInfoHeader;
    function  GetParamList(AMethodIndex: Integer): TList;
    function  IsReturnExtraParam(AParamInfo: PParamInfo): Boolean;
    function  ReadClass(AClass: TClass): Boolean;
  protected
    { ItcMethodInfoProvider }
    function GetCount: Integer;
    function GetName(AIndex: Integer): WideString;
    function GetParamCount(AMethodIndex: Integer): Integer;
    function GetParamInfo(AMethodIndex, AParamIndex: Integer): PParamInfo;
    function GetReturnInfo(AMethodIndex: Integer): PReturnInfo;
    function GetCookie(AMethodIndex: Integer): Pointer;
  public
    constructor Create(AClass: TClass);
    destructor  Destroy; override;
  end;
{$ENDIF}
{$ENDIF}

const
  WM_GETHANDLE = WM_USER + 1;

type
  PGetHandleData = ^TGetHandleData;
  TGetHandleData = record
    WinControl: TWinControl;
    Handle: THandle;
    Event: THandle;
  end;

  TtcWinControlInfoProvider = class(TInterfacedObject, ItcWinControlInfoProvider)
  protected
    { ItcWinControlInfoProvider }
    function GetHandle(WinControl: Pointer): Integer; stdcall;
    function GetControlAtPos(WinControl: Pointer; const Pos: TPoint): Pointer; stdcall;
    function FindControl(Handle: HWND): Pointer; stdcall;
    function GetControlCount(Control: Pointer): Integer; stdcall;
    function GetChildControl(Control: Pointer; Index: Integer): Pointer; stdcall;
  end;

  TtcTopComponentProvider = class(TInterfacedObject, ItcTopComponentProvider)
  protected
    { ItcTopComponentProvider }
    function GetComponent(Index: Integer): Pointer; stdcall;
    function GetCount: Integer; stdcall;
  end;

  TtcTestClassProvider = class(TInterfacedObject, ItcTestClassProvider,
    ItcTestClassProviderInternal)
  private
    FClasses: TList;
  protected
    { ItcTestClassProvider }
    function GetCount: Integer;
    function GetTypeInfos(Index: Integer): PtcTypeInfo;
    property Count: Integer read GetCount;
    property TypeInfos[Index: Integer]: PtcTypeInfo read GetTypeInfos;
    { ItcTestClassProviderInternal }
    procedure RegisterClass(ClassInstance: TClass);
  public
    constructor Create;
    destructor Destroy; override;
  end;

{$IFNDEF DELPHI6}
  PPointer = ^Pointer;

{$IFNDEF DELPHI5}
function SameText(const S1, S2: string): Boolean; assembler;
asm
        CMP     EAX,EDX
        JZ      @1
        OR      EAX,EAX
        JZ      @2
        OR      EDX,EDX
        JZ      @3
        MOV     ECX,[EAX-4]
        CMP     ECX,[EDX-4]
        JNE     @3
        CALL    CompareText
        TEST    EAX,EAX
        JNZ     @3
@1:     MOV     AL,1
@2:     RET
@3:     XOR     EAX,EAX
end;

procedure FreeAndNil(var Obj);
var
  Temp: TObject;
begin
  Temp := TObject(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;
{$ENDIF}

function GetModuleName(Module: HMODULE): string;
var
  ModName: array[0..MAX_PATH] of Char;
begin
  SetString(Result, ModName, Windows.GetModuleFileName(Module, ModName, SizeOf(ModName)));
end;

function WideSameText(const S1, S2: WideString): Boolean;
begin
  Result := SameText(S1, S2);
end;
{$ENDIF DELPHI6}

function CreateModuleInfoProvider: ItcModuleInfoProvider;
begin
  Result := TtcModuleInfoProvider.Create;
end;

{$IFDEF DELPHI7}
{$IFNDEF BCB}
function CreateMethodInfoProvider(AClass: TClass): ItcMethodInfoProvider;
begin
  Result := TtcMethodInfoProvider.Create(AClass);
end;
{$ENDIF}
{$ENDIF}

function GetClassType(Instance: Pointer): Pointer;
begin
  Result := Pointer(Instance^);
end;

function GetClassInstance(Instance: Pointer): Pointer;
begin
  Result := TObject(Instance).ClassType;
end;

function GetPTypeInfo(ClassInstance: Pointer): Pointer;
asm
  MOV EAX, [EAX + vmtTypeInfo]
end;

function GetClassParent(ClassInstance: Pointer): Pointer;
begin
  Result := TClass(ClassInstance).ClassParent;
end;

function GetClassClass(ClassInstance: Pointer): WideString;
begin
  Result := TClass(ClassInstance).ClassName;
end;

function CreateTypeInfo(Obj: TObject): PtcTypeInfo;
begin
  Assert(Obj <> nil);
  New(Result);
  Result.Name := Obj.ClassName;
  Result.ClassInstance := Obj.ClassType;
end;

function GetClassFromTypeInfo(TypeInfo: PtcTypeInfo): TClass;
begin
  Result := TClass(TypeInfo.ClassInstance);
end;

function _VarToObject(const V: OleVariant): TObject;
begin
  if _Conversions <> nil then
    Result := TObject(_Conversions.VarToObject(V))
  else
    Result := nil;
end;

function _VarFromObject(Obj: TObject): IDispatch;
begin
  if _Conversions <> nil then
    Result := _Conversions.VarFromObject(Obj)
  else
    Result := nil;
end;

{ TtcTypeInfoProvider }

function TtcTypeInfoProvider.GetMethodList(TypeInfo: PtcTypeInfo;
  out MethodList: PtcMethodInfoList; out Count: Integer): WordBool;
begin
  Result := Assigned(GetMethodListProc)
    and GetMethodListProc(TypeInfo.ClassInstance, MethodList, Count);
end;

function TtcTypeInfoProvider.GetTypeInfo(Instance: Pointer): PtcTypeInfo;
begin
  Result := CreateTypeInfo(TObject(Instance));
end;

procedure TtcTypeInfoProvider.ReleaseMethodList(
  MethodList: PtcMethodInfoList);
begin
  if Assigned(ReleaseMethodListProc) then
    ReleaseMethodListProc(MethodList);
end;

procedure TtcTypeInfoProvider.ReleaseTypeInfo(TypeInfo: PtcTypeInfo);
begin
  if TypeInfo <> nil then
    Dispose(TypeInfo);
end;

function TtcTypeInfoProvider.CreateInstance(
  TypeInfo: PtcTypeInfo): Pointer;
var
  ClassInstance: TClass;
  Obj: TObject;
begin
  Assert(TypeInfo <> nil);
  ClassInstance := GetClassFromTypeInfo(TypeInfo);
  Assert(ClassInstance <> nil);
  Obj := ClassInstance.NewInstance;
  try
    Obj.Create;
  except
    Obj := nil;
  end;
  Result := Obj;
end;

procedure TtcTypeInfoProvider.ReleaseInstance(Instance: Pointer);
begin
  Assert(Instance <> nil);
  TObject(Instance).Free;
end;

{ TtcObjectInfoProvider }

function TtcObjectInfoProvider.CheckInheritedFrom(Instance: Pointer;
  const ClassName: WideString): WordBool;

  function CheckClass(ClassInstance: TClass; const Name: WideString): Boolean;
  begin
    Assert(ClassInstance <> nil);
    if ClassInstance <> nil then
    begin
      Result := ClassInstance.ClassNameIs(Name);
      if not Result and (ClassInstance.ClassParent <> nil) then
        Result := CheckClass(ClassInstance.ClassParent, Name);
    end
    else
      Result := False;
  end;

var
  RealClassName: WideString;
begin
  Result := ObjectIsValid(Instance);
  if not Result then
    exit;

  RealClassName := ClassName;
  Result := CheckClass(TObject(Instance).ClassType, RealClassName);

{$IFDEF TC_USE_CLX}
  if not Result and (RealClassName = 'TWinControl') then
  begin
    RealClassName := 'TWidgetControl';
    Result := CheckClass(TObject(Instance).ClassType, RealClassName);

    if (not Result) then
    begin
      RealClassName := 'THandleComponent';
      Result := CheckClass(TObject(Instance).ClassType, RealClassName);
    end;
  end;
{$ENDIF}
end;

function TtcObjectInfoProvider.GetClassName(Instance: Pointer): WideString;
begin
  Result := TObject(Instance).ClassName;
end;

function TtcObjectInfoProvider.GetInstanceSize(Instance: Pointer): Integer;
begin
  Result := TObject(Instance).InstanceSize;
end;

function TtcObjectInfoProvider.GetVMT(Instance: Pointer;
  const ClassName: WideString; out Offset: Integer;
  out VMT: Pointer): WordBool;
var
  Parent: Pointer;
begin
  Result := False;
  VMT := nil;
  Offset := 0;

  if ObjectIsValid(Instance) then
  try
    Parent := GetClassInstance(Pointer(Instance));
    while (Parent <> nil) and not WideSameText(GetClassClass(Parent), ClassName) do
      Parent := GetClassParent(Parent);
    VMT := Parent;
  except
    // Do nothing
  end;

  if VMT <> nil then
  begin
    VMT := Pointer(Integer(VMT) + vmtParent + SizeOf(Pointer));
    Offset := Abs((vmtParent + SizeOf(Pointer)) div 4);
    Result := True;
  end;
end;

function TtcObjectInfoProvider.ObjectIsValid(Instance: Pointer): WordBool;
var
  P: Pointer;
  SelfPtr: Pointer;
begin
  Result := False;

  P := Pointer(Instance);
  if IsBadReadPtr(P, SizeOf(Pointer)) then
    Exit;

  P := Pointer(P^);
  if IsBadReadPtr(P, SizeOf(Pointer)) then
    Exit;

  SelfPtr := Pointer(Integer(P) + vmtSelfPtr);
  if IsBadReadPtr(SelfPtr, SizeOf(Pointer)) then
    Exit;
  SelfPtr := Pointer(SelfPtr^);

  Result := P = SelfPtr;
end;

{ TtcComponentInfoProvider }

function TtcComponentInfoProvider.FindComponent(Component: Pointer;
  const Name: WideString): Pointer;
begin
  Result := TComponent(Component).FindComponent(Name);
end;

function TtcComponentInfoProvider.GetChildComponent(Component: Pointer;
  Index: Integer): Pointer;
  var
    instance : TComponent;
begin
  // QC {
  instance := TComponent(Component).Components[Index];
  if (instance is TWinControl) AND (TWinControlFriend(instance).WindowHandle = 0) then
  begin
    Result := nil;
    Exit;
  end;
  Result := Pointer(instance);
  // } QC

  //Result := Pointer(TComponent(Component).Components[Index];);
end;

function TtcComponentInfoProvider.GetComponentCount(
  Component: Pointer): Integer;
begin
  Result := TComponent(Component).ComponentCount;
end;

function TtcComponentInfoProvider.GetComponentName(
  Component: Pointer): WideString;
  var
    comp : TComponent;
begin
  comp := TComponent(Component);

  // это попытка обойти задолбавший глюк ТестКомплита (или не его...), когда
  // главное окно вдруг теряет свое нормальное имя и представляется в стиле
  // Window('TnsMainWinow','',1)
  if (comp.Name = '') AND (comp.ClassName = 'TnsMainWindow') then
    comp.Name := 'nsMainWindow';

  Result := comp.Name;
end;

function TtcComponentInfoProvider.GetOwner(Component: Pointer): Pointer;
begin
  Result := Pointer(TComponent(Component).Owner);
end;

{ TtcControlInfoProvider }

procedure TtcControlInfoProvider.ClientToScreen(Control: Pointer;
  var Point: TPoint);
begin
  Point := TControl(Control).ClientToScreen(Point);
end;

function TtcControlInfoProvider.GetEnabled(Control: Pointer): WordBool;
begin
  Result := TControl(Control).Enabled;
end;

function TtcControlInfoProvider.GetHeight(Control: Pointer): Integer;
begin
  Result := TControl(Control).Height;
end;

function TtcControlInfoProvider.GetLeft(Control: Pointer): Integer;
begin
  Result := TControl(Control).Left;
end;

function TtcControlInfoProvider.GetParent(Control: Pointer): Pointer;
begin
  Result := Pointer(TControl(Control).Parent);
end;

function TtcControlInfoProvider.GetTop(Control: Pointer): Integer;
begin
  Result := TControl(Control).Top;
end;

function TtcControlInfoProvider.GetVisible(Control: Pointer): WordBool;
begin
  Result := TControl(Control).Visible;
end;

function TtcControlInfoProvider.GetWidth(Control: Pointer): Integer;
begin
  Result := TControl(Control).Width;
end;

procedure TtcControlInfoProvider.ScreenToClient(Control: Pointer;
  var Point: TPoint);
begin
  Point := TControl(Control).ScreenToClient(Point);
end;

{ TtcWinControlInfoProvider }

function TtcWinControlInfoProvider.FindControl(Handle: HWND): Pointer;
begin
  Result := Pointer(Controls.FindControl(Handle));
{$IFDEF TC_USE_CLX}
  if Result = nil then
    Result := Pointer(QClxObjectMap_find(QWidget_find(Handle)));
{$ENDIF}
end;

function TtcWinControlInfoProvider.GetChildControl(Control: Pointer;
  Index: Integer): Pointer;
begin
  if TObject(Control) is TWinControl then
    Result := TWinControl(Control).Controls[Index]
{$IFDEF TC_USE_CLX}
  else if TObject(Control) is TWidgetControl then
    Result := TWidgetControl(Control).Controls[Index]
{$ENDIF}
  else
    Result := nil;
end;

function TtcWinControlInfoProvider.GetControlAtPos(WinControl: Pointer;
  const Pos: TPoint): Pointer;
begin
  if WinControl <> nil then
    Result := Pointer(TWinControl(WinControl).ControlAtPos(Pos, True{$IFDEF DELPHI5}, False{$ENDIF}))
  else
    if Screen.ActiveForm <> nil then
      Result := Pointer(Screen.ActiveForm.ControlAtPos(Pos, True{$IFDEF DELPHI5}, False{$ENDIF}))
    else
      Result := nil;
end;

//type
//  TWinControlFriend = class(TWinControl);

function TtcWinControlInfoProvider.GetControlCount(
  Control: Pointer): Integer;
begin
  if TObject(Control) is TWinControl then
    Result := TWinControl(Control).ControlCount
{$IFDEF TC_USE_CLX}
  else if TObject(Control) is TWidgetControl then
    Result := TWidgetControl(Control).ControlCount
{$ENDIF}
  else
    Result := 0
end;

function TtcWinControlInfoProvider.GetHandle(WinControl: Pointer): Integer;
begin
{$IFNDEF TC_USE_CLX}
  if TObject(WinControl) is TWinControl then
    Result := TWinControlFriend(WinControl).WindowHandle
{$ELSE TC_USE_CLX}
  if TObject(WinControl) is TWidgetControl then
    Result := QWidget_winId(TWidgetControl(WinControl).Handle)
  else if TObject(WinControl) is THandleComponent then
    Result := QWidget_winId(QWidgetH(THandleComponent(WinControl).Handle))
{$ENDIF}
  else
    Result := 0;
end;

{ TtcTopComponentProvider }

function TtcTopComponentProvider.GetComponent(Index: Integer): Pointer;
begin
  Result := Screen.DataModules[Index];
end;

function TtcTopComponentProvider.GetCount: Integer;
begin
  Result := Screen.DataModuleCount;
end;

{ TtcModuleInfoProvider }

constructor TtcModuleInfoProvider.Create;
begin
  inherited Create;
  {$IFDEF DELPHI5}
  FSyncWindow := Forms.AllocateHWnd(SyncWindowProc);
  {$ELSE}
  FSyncWindow := Classes.AllocateHWnd(SyncWindowProc);
  {$ENDIF}
  System.GetMemoryManager(FMemoryManager);
  FTypeInfoProvider := TtcTypeInfoProvider.Create;
  FObjectInfoProvider := TtcObjectInfoProvider.Create;
  FComponentInfoProvider := TtcComponentInfoProvider.Create;
  FControlInfoProvider := TtcControlInfoProvider.Create;
  FWinControlInfoProvider := TtcWinControlInfoProvider.Create;
  FTopComponentProvider := TtcTopComponentProvider.Create;
  FTestClassProvider := TtcTestClassProvider.Create;
end;

destructor TtcModuleInfoProvider.Destroy;
begin
  DeallocateHWnd(FSyncWindow);
  inherited;
end;

function TtcModuleInfoProvider.GetCallFrame: ItcMethodCallFrame;
begin
  Result := Self;
end;

function TtcModuleInfoProvider.GetComponentInfoProvider: ItcComponentInfoProvider;
begin
  Result := FComponentInfoProvider;
end;

function TtcModuleInfoProvider.GetControlInfoProvider: ItcControlInfoProvider;
begin
  Result := FControlInfoProvider;
end;

function TtcModuleInfoProvider.GetInstance: Cardinal;
begin
  Result := HInstance;
end;

function TtcModuleInfoProvider.GetMemoryManager: Pointer;
begin
  Result := @FMemoryManager;
end;

function TtcModuleInfoProvider.GetObjectInfoProvider: ItcObjectInfoProvider;
begin
  Result := FObjectInfoProvider;
end;

function TtcModuleInfoProvider.GetSyncWindow: Cardinal;
begin
  Result := FSyncWindow;  
end;

function TtcModuleInfoProvider.GetTestClassProvider: ItcTestClassProvider;
begin
  Result := FTestClassProvider;
end;

function TtcModuleInfoProvider.GetTopComponentProvider: ItcTopComponentProvider;
begin
  Result := FTopComponentProvider;
end;

function TtcModuleInfoProvider.GetTypeInfoProvider: ItcTypeInfoProvider;
begin
  Result := FTypeInfoProvider;
end;

function TtcModuleInfoProvider.GetVersion: Integer;
begin
  Result := cDelphiModuleInfoVersion;
end;

function TtcModuleInfoProvider.GetWinControlInfoProvider: ItcWinControlInfoProvider;
begin
  Result := FWinControlInfoProvider;
end;

function TtcModuleInfoProvider.MakeSafeCall(Method: TtcMethodProc;
  Instance: TObject; Args: PVariantArgList; out Value: OleVariant;
  Cookie: Cardinal; ExcepInfo: PExcepInfo): HResult;
begin
  try
    Method(Instance, Args, Value, Cookie);
    Result := S_OK;
  except
    if ExcepInfo <> nil then
    begin
      ZeroMemory(ExcepInfo, SizeOf(TExcepInfo));

      ExcepInfo.bstrSource := ExtractFileName(GetModuleName(HInstance));
      if (ExceptObject <> nil) and (ExceptObject is Exception) then
        ExcepInfo.bstrDescription := (ExceptObject as Exception).Message
      else
        ExcepInfo.bstrDescription := 'Internal Error';

      ExcepInfo.scode := E_FAIL;
    end;
    Result := DISP_E_EXCEPTION;
  end;
end;

procedure TtcModuleInfoProvider.SetConversions(
  const Conversions: ItcConversions);
begin
  _Conversions := Conversions;
end;

procedure TtcModuleInfoProvider.SyncWindowProc(var Message: Messages.TMessage);
begin
  Message.Result := DefWindowProc(FSyncWindow, Message.Msg, Message.WParam, Message.LParam);
end;

{ TtcTable }

procedure TtcTable.Clear;
var
  Index: Integer;
  Entry: PtcTableEntry;
  OldEntry: PtcTableEntry;
begin
  for Index := FCapacity - 1 downto 0 do
  begin
    Entry := FItems^[Index];
    while Entry <> nil do
    begin
      OldEntry := Entry;
      Entry := Entry.Next;

      DoRemove(OldEntry.Value);
      FreeMem(OldEntry, SizeOf(TtcTableEntry));
    end;
    FItems^[Index] := nil;
  end;
  FCount := 0;
end;

function TtcTable.ContainsKey(Key: Pointer): Boolean;
var
  Entry: PtcTableEntry;
begin
  Entry := FItems^[(Integer(Key) and $7FFFFFFF) mod FCapacity];
  while Entry <> nil do
  begin
    if Entry.Key = Key then
    begin
      Result := True;
      Exit;
    end;
    Entry := Entry.Next;
  end;
  Result := False;
end;

constructor TtcTable.Create;
begin
  inherited Create;
  FLoadFactor := 0.5;
  FCapacity := 10;
  GetMem(FItems, FCapacity * SizeOf(Pointer));
  FillChar(FItems^, FCapacity * SizeOf(Pointer), 0);
  FThreshold := Round(FCapacity * FLoadFactor);
end;

destructor TtcTable.Destroy;
begin
  Clear;
  FreeMem(FItems);
  inherited;
end;

procedure TtcTable.DoRemove(AItem: Pointer);
begin

end;

function TtcTable.Exclude(Key: Pointer): Pointer;
var
  Index: Integer;
  Entry: PtcTableEntry;
  PrevEntry: PtcTableEntry;
begin
  Index := (Integer(Key) and $7FFFFFFF) mod FCapacity;
  Entry := FItems^[Index];
  PrevEntry := nil;
  while Entry <> nil do
  begin
    if Key = Entry.Key then
    begin
      Result := Entry.Value;

      if PrevEntry <> nil then
        PrevEntry.Next := Entry.Next
      else
        FItems^[Index] := Entry.Next;
      Dec(FCount);

      FreeMem(Entry, SizeOf(TtcTableEntry));
      Exit;
    end;
    PrevEntry := Entry;
    Entry := Entry.Next;
  end;
  Result := nil;
end;

function TtcTable.Get(Key: Pointer): Pointer;
var
  Entry: PtcTableEntry;
begin
  Entry := FItems^[(Integer(Key) and $7FFFFFFF) mod FCapacity];
  while Entry <> nil do
  begin
    if Entry.Key = Key then
    begin
      Result := Entry.Value;
      Exit;
    end;
    Entry := Entry.Next;
  end;
  Result := nil;
end;

procedure TtcTable.Put(Key, Value: Pointer);
var
  Index: Integer;
  Entry: PtcTableEntry;
begin
  Index := (Integer(Key) and $7FFFFFFF) mod FCapacity;
  Entry := FItems^[Index];
  while Entry <> nil do
  begin
    if Key = Entry.Key then
    begin
      DoRemove(Entry.Value);
      Entry.Value := Value;

      Exit;
    end;
    Entry := Entry.Next;
  end;

  if FCount >= FThreshold then
  begin
    Rehash;
    Index := (Integer(Key) and $7FFFFFFF) mod FCapacity;
  end;

  GetMem(Entry, SizeOf(TtcTableEntry));
  Entry.Key := Key;
  Entry.Value := Value;
  Entry.Next := FItems^[Index];

  FItems^[Index] := Entry;
  Inc(FCount);
end;

procedure TtcTable.Rehash;
var
  OldCapacity: Integer;
  OldItems: PtcTableEntryArray;
  NewItems: PtcTableEntryArray;
  OldEntry: PtcTableEntry;
  Entry: PtcTableEntry;
  I: Integer;
  Index: Integer;
begin
  OldCapacity := FCapacity;
  OldItems := FItems;

	FCapacity := OldCapacity * 2 + 1;
	FThreshold := Round(FCapacity * FLoadFactor);

  GetMem(NewItems, FCapacity * SizeOf(Pointer));
  FillChar(NewItems^, FCapacity * SizeOf(Pointer), 0);
	FItems := NewItems;

	for I := OldCapacity - 1 downto 0 do
  begin
    OldEntry := OldItems^[I];
    while OldEntry <> nil do
    begin
      Entry := OldEntry;
      OldEntry := OldEntry.Next;
      Index := (Integer(Entry.Key) and $7FFFFFFF) mod FCapacity;
      Entry.Next := NewItems^[Index];
      NewItems^[Index] := Entry;
    end;
  end;
  FreeMem(OldItems);
end;

procedure TtcTable.Remove(Key: Pointer);
var
  Value: Pointer;
begin
  Value := Exclude(Key);
  DoRemove(Value);
end;

{ TtcObjectTable }

procedure TtcObjectTable.DoRemove(AItem: Pointer);
begin
  inherited;
  if AItem <> nil then
    TObject(AItem).Free;
end;

{ TtcTestClassProvider }

constructor TtcTestClassProvider.Create;
begin
  inherited Create;
  FClasses := TList.Create;
end;

destructor TtcTestClassProvider.Destroy;
var
  I: Integer;
begin
  for I := 0 to FClasses.Count - 1 do
  begin
    Assert(FClasses[I] <> nil);
    Dispose(PtcTypeInfo(FClasses[I]));
  end;
  FreeAndNil(FClasses);
  inherited;
end;

function TtcTestClassProvider.GetCount: Integer;
begin
  Result := FClasses.Count;
end;

function TtcTestClassProvider.GetTypeInfos(Index: Integer): PtcTypeInfo;
begin
  Assert((Index >= 0) and (Index < FClasses.Count));
  Result := PtcTypeInfo(FClasses[Index]);
end;

procedure TtcTestClassProvider.RegisterClass(ClassInstance: TClass);
var
  TypeInfo: PtcTypeInfo;
begin
  Assert(ClassInstance <> nil);
  New(TypeInfo);
  TypeInfo.Name := ClassInstance.ClassName;
  TypeInfo.ClassInstance := ClassInstance;
  FClasses.Add(TypeInfo);
end;

{$IFDEF DELPHI7}
{$IFNDEF BCB}

{ TtcMethodInfoProvider }

constructor TtcMethodInfoProvider.Create(AClass: TClass);
begin
  inherited Create;
  FClass := AClass;
  FMethodNames   := TStringList.Create;
  FMethodHeaders := TList.Create;
  ClearMethodInfo;
  ReadClass(AClass);
end;

destructor TtcMethodInfoProvider.Destroy;
begin
  ClearMethodInfo;
  FreeAndNil(FMethodNames);
  FreeAndNil(FMethodHeaders);
  inherited;
end;

procedure TtcMethodInfoProvider.ClearMethodInfo;
var
  i: Integer;
begin
  FMethodHeaders.Clear;
  for i:= 0 to FMethodNames.Count - 1 do
    FMethodNames.Objects[i].Free;
  FMethodNames.Clear;
end;

const
  c_ShortStringLength = sizeof(ShortString) - 1;

function TtcMethodInfoProvider.IsExtendedRTTIExists(AMethod: PMethodInfoHeader): Boolean;
begin
  Result := False;
  if AMethod = nil then
    Exit;
  if AMethod.Len <= SizeOf(TMethodInfoHeader) - c_ShortStringLength + Length(AMethod.Name) then
    Result := False
  else
    Result := True;
end;

function TtcMethodInfoProvider.GetNextParam(AParamInfo: PParamInfo): PParamInfo;
begin
  Result := nil;
  if AParamInfo <> nil then
    Result := PParamInfo(Integer(AParamInfo) + SizeOf(AParamInfo^) - c_ShortStringLength + Length(AParamInfo.Name));
end;

type

  PVmt = ^TVmt;
  TVmt = packed record
    SelfPtr           : TClass;
    IntfTable         : PInterfaceTable;
    AutoTable         : Pointer;
    InitTable         : Pointer;
    TypeInfo          : Pointer;
    FieldTable        : Pointer;
    MethodTable       : PtcPMethodTable;
    DynamicTable      : Pointer;
    ClassName         : PShortString;
    InstanceSize      : PLongint;
    Parent            : Pointer;
    SafeCallException : Pointer;
    AfterConstruction : Pointer;
    BeforeDestruction : Pointer;
    Dispatch          : Pointer;
    DefaultHandler    : Pointer;
    NewInstance       : Pointer;
    FreeInstance      : Pointer;
    Destroy           : Pointer;
  end;

function GetVMT(AClass: TClass): PVmt;
begin
  Result := Pointer(Integer(Pointer(AClass)) - SizeOf(TVmt));
end;

function TtcMethodInfoProvider.GetMethodTable(AClass: TClass): PtcPMethodTable;
var
  VMT: PVmt;
begin
  VMT := GetVMT(AClass);
  if VMT <> nil then
    Result := VMT.MethodTable
  else
    Result := nil;
end;

function TtcMethodInfoProvider.GetMethodInfoHeader(AClass: TClass; AIndex: Integer): PMethodInfoHeader;
var
  PMT: PtcPMethodTable;
begin
  PMT := GetMethodTable(AClass);
  if (PMT <> nil) and (AIndex < PMT.Count) then
  begin
    Result := @PMT.MethodInfoArray[0];
    while AIndex > 0 do
    begin
      Inc(PChar(Result), Result.Len);
      Dec(AIndex);
    end;
  end
  else
    Result := nil;
end;

function TtcMethodInfoProvider.GetMethodInfoHeaderCount(AClass: TClass): Integer;
var
  Pmt: PtcPMethodTable;
begin
  Result := 0;
  Pmt := GetMethodTable(AClass);
  if Pmt <> nil then
    Result := Pmt.Count;
end;

function TtcMethodInfoProvider.GetCachedMethodInfoHeader(AIndex: Integer): PMethodInfoHeader;
begin
  Result := nil;
  if (AIndex >= 0) and (AIndex < FMethodHeaders.Count) then
    Result := FMethodHeaders.Items[AIndex];
end;

function TtcMethodInfoProvider.ReadClass(AClass: TClass): Boolean;
var
  Count:        Integer;
  i:            Integer;
  MethodHeader: PMethodInfoHeader;
  HeaderEnd:    Pointer;
  Params:       PParamInfo;
  Param:        PParamInfo;
  ParamList:    TList;
  MethodIdx:    Integer;
  VMT:          PVmt;
begin
  Result := FMethodNames.Count > 0;
  if AClass = nil then
    Exit;
  Count := GetMethodInfoHeaderCount(AClass);
  for i := 0 to Count - 1 do
  begin
    MethodHeader := GetMethodInfoHeader(AClass, i);
    if not IsExtendedRTTIExists(MethodHeader) then
    begin
      // There is no extended RTTI info.
      // You should compile your class with {$M+} and {$METHODINFO ON} directives
      Continue;
    end;
    //
    if MethodHeader <> nil then
    begin
      MethodIdx := FMethodNames.Add(MethodHeader.Name);
      FMethodHeaders.Add(MethodHeader);
      HeaderEnd := Pointer(Integer(MethodHeader) + MethodHeader.Len);
      Params := PParamInfo(Integer(MethodHeader) + SizeOf(MethodHeader^) - c_ShortStringLength + Length(MethodHeader.Name) + SizeOf(TReturnInfo));
      Param := Params;
      if Integer(Param) < Integer(HeaderEnd) then
      begin
        ParamList := TList.Create;
        while (Integer(Param) < Integer(HeaderEnd)) and not IsReturnExtraParam(Param) do
        begin
          ParamList.Add(Param);
          Param := GetNextParam(Param);
        end;
        FMethodNames.Objects[MethodIdx] := ParamList;
      end;
    end
    else
      Assert(False);
  end;
  // Result := FMethodNames.Count > 0;
  VMT := GetVMT(AClass);
  if (VMT <> nil) and (VMT.Parent <> nil) then
    Result := ReadClass(TClass(VMT.Parent^))
  else
    Result := FMethodNames.Count > 0;
end;

{ TtcMethodInfoProvider.ItcMethodInfoProvider }

function TtcMethodInfoProvider.GetCount: Integer;
begin
  Result := FMethodNames.Count;
end;

function TtcMethodInfoProvider.GetName(AIndex: Integer): WideString;
begin
  Result := '';
  if (AIndex >= 0) and (AIndex < FMethodNames.Count) then
    Result := FMethodNames.Strings[AIndex];
end;

function TtcMethodInfoProvider.GetParamList(AMethodIndex: Integer): TList;
begin
  Result := nil;
  if (AMethodIndex >= 0) and (AMethodIndex < FMethodNames.Count) then
    Result := TList(FMethodNames.Objects[AMethodIndex]);
end;

function TtcMethodInfoProvider.IsReturnExtraParam(AParamInfo: PParamInfo): Boolean;
begin
  Result := True;
  if AParamInfo <> nil then
    Result := pfResult in AParamInfo.Flags;
end;

function TtcMethodInfoProvider.GetParamCount(AMethodIndex: Integer): Integer;
var
  ParamList: TList;
begin
  Result := 0;
  ParamList := GetParamList(AMethodIndex);
  if ParamList <> nil then
     Result := ParamList.Count - 1; // - 1: First parameter is 'Self'
end;

function TtcMethodInfoProvider.GetParamInfo(AMethodIndex, AParamIndex: Integer): PParamInfo;
var
  ParamList: TList;
begin
  Result := nil;
  ParamList := GetParamList(AMethodIndex);
  if ParamList <> nil then
  begin
    Inc(AParamIndex); // First (zero) parameter is 'Self'
    if (AParamIndex >= 0) and (AParamIndex < ParamList.Count) then
      Result := ParamList.Items[AParamIndex]
  end;
end;

function TtcMethodInfoProvider.GetReturnInfo(AMethodIndex: Integer): PReturnInfo;
var
  MethodHeader: PMethodInfoHeader;
begin
  Result := nil;
  MethodHeader := GetCachedMethodInfoHeader(AMethodIndex);
  if MethodHeader <> nil then
    Result := PReturnInfo(Integer(MethodHeader) + SizeOf(MethodHeader^) - c_ShortStringLength + Length(MethodHeader.Name));
end;

function TtcMethodInfoProvider.GetCookie(AMethodIndex: Integer): Pointer;
begin
  Result := GetCachedMethodInfoHeader(AMethodIndex);
end;

{$ENDIF}
{$ENDIF}

initialization
  VarToObjectProc := _VarToObject;
  VarFromObjectProc := _VarFromObject;

end.
