unit tc6OpenAppClasses;

{$Include l3XE.inc}

{$I tc6_ver.inc}

interface

{$IfNDef XE}

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
    function GetHandle(WinControl: Pointer): HWND; stdcall;
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
{$EndIf XE}

implementation

{$IfNDef XE}

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
  , vg_scene
;


// QC
{$IFNDEF QC_OUTPUT_DEBUG_INFORMATION}
  {$DEFINE QC_OUTPUT_DEBUG_INFORMATION}
{$ENDIF QC_OUTPUT_DEBUG_INFORMATION}

{$IFNDEF QC_CATCH_EXCEPTIONS}
  {$DEFINE QC_CATCH_EXCEPTIONS}
{$ENDIF QC_CATCH_EXCEPTIONS}

{$IFNDEF QC_IGNORE_EXCEPTIONS}
  {$DEFINE QC_IGNORE_EXCEPTIONS}
{$ENDIF QC_IGNORE_EXCEPTIONS}

{$IFDEF QC_IGNORE_EXCEPTIONS}
  {$WARNINGS OFF}
  const IS_IGNORED = true;
{$ELSE}
  const IS_IGNORED = false;
{$ENDIF QC_IGNORE_EXCEPTIONS}  


procedure OutputDebugStringF(const MethodName : String; const S : String; const Args : array of const);
  var
    str : String;
begin
  str := 'QC: ' + MethodName + ': ';
  try
    str := str + Format(S, Args);
  except
    on E : Exception do
      str := str + 'Exception "' + E.Message +'" while formatting string "' + S + '"';
  end;
  OutputDebugString(PAnsiChar(str));
end;

procedure OutputDebugStringE(const MethodName : String; const Ex : Exception; isIgnored : Boolean = false);
  var
    str : String;
begin
  str := '';
  if isIgnored then
    str := 'IGNORED_';
  str := str + 'EXCEPTION: ' + MethodName;

  OutputDebugStringF(
    str,
    'Exception.Message = "%s"',
    [Ex.Message]
  );
end;
//QC

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
    function GetHandle(WinControl: Pointer): HWND; stdcall;
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
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TtcModuleInfoProvider.Create;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('CreateModuleInfoProvider', E);
      Raise E;
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{$IFDEF DELPHI7}
{$IFNDEF BCB}
function CreateMethodInfoProvider(AClass: TClass): ItcMethodInfoProvider;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TtcMethodInfoProvider.Create(AClass);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('CreateMethodInfoProvider', E, IS_IGNORED);
      Raise E;
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;
{$ENDIF}
{$ENDIF}

function GetClassType(Instance: Pointer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Pointer(Instance^);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('GetClassType', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function GetClassInstance(Instance: Pointer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TObject(Instance).ClassType;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('GetClassInstance', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function GetPTypeInfo(ClassInstance: Pointer): Pointer;
asm
  MOV EAX, [EAX + vmtTypeInfo]
end;

function GetClassParent(ClassInstance: Pointer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TClass(ClassInstance).ClassParent;
    
{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('GetClassParent', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function GetClassClass(ClassInstance: Pointer): WideString;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TClass(ClassInstance).ClassName;
    
{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('GetClassClass', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function CreateTypeInfo(Obj: TObject): PtcTypeInfo;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Assert(Obj <> nil);
    New(Result);
    Result.Name := Obj.ClassName;
    Result.ClassInstance := Obj.ClassType;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('CreateTypeInfo', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function GetClassFromTypeInfo(TypeInfo: PtcTypeInfo): TClass;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TClass(TypeInfo.ClassInstance);
    
{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('GetClassFromTypeInfo', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function _VarToObject(const V: OleVariant): TObject;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if _Conversions <> nil then
      Result := TObject(_Conversions.VarToObject(V))
    else
      Result := nil;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('_VarToObject', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function _VarFromObject(Obj: TObject): IDispatch;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if _Conversions <> nil then
      Result := _Conversions.VarFromObject(Obj)
    else
      Result := nil;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('_VarFromObject', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcTypeInfoProvider }

function TtcTypeInfoProvider.GetMethodList(TypeInfo: PtcTypeInfo;
  out MethodList: PtcMethodInfoList; out Count: Integer): WordBool;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Assigned(GetMethodListProc)
      and GetMethodListProc(TypeInfo.ClassInstance, MethodList, Count);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTypeInfoProvider.GetMethodList', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcTypeInfoProvider.GetTypeInfo(Instance: Pointer): PtcTypeInfo;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := CreateTypeInfo(TObject(Instance));

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTypeInfoProvider.GetTypeInfo', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcTypeInfoProvider.ReleaseMethodList(
  MethodList: PtcMethodInfoList);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if Assigned(ReleaseMethodListProc) then
      ReleaseMethodListProc(MethodList);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTypeInfoProvider.ReleaseMethodList', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcTypeInfoProvider.ReleaseTypeInfo(TypeInfo: PtcTypeInfo);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if TypeInfo <> nil then
      Dispose(TypeInfo);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTypeInfoProvider.ReleaseTypeInfo', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcTypeInfoProvider.CreateInstance(
  TypeInfo: PtcTypeInfo): Pointer;
var
  ClassInstance: TClass;
  Obj: TObject;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTypeInfoProvider.CreateInstance', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcTypeInfoProvider.ReleaseInstance(Instance: Pointer);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Assert(Instance <> nil);
    TObject(Instance).Free;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTypeInfoProvider.ReleaseInstance', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcObjectInfoProvider }

function TtcObjectInfoProvider.CheckInheritedFrom(Instance: Pointer;
  const ClassName: WideString): WordBool;

  function CheckClass(ClassInstance: TClass; const Name: WideString): Boolean;
  begin
  {$IFDEF QC_CATCH_EXCEPTIONS}
    try
  {$ENDIF QC_CATCH_EXCEPTIONS}

      Assert(ClassInstance <> nil);
      if ClassInstance <> nil then
      begin
        Result := ClassInstance.ClassNameIs(Name);
        if not Result and (ClassInstance.ClassParent <> nil) then
          Result := CheckClass(ClassInstance.ClassParent, Name);
      end
      else
        Result := False;

  {$IFDEF QC_CATCH_EXCEPTIONS}
    except
      on E : Exception do
      begin
        OutputDebugStringE('TtcObjectInfoProvider.CheckInheritedFrom.CheckClass', E, IS_IGNORED);
        {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
      end;
    end;
  {$ENDIF QC_CATCH_EXCEPTIONS}
  end;

var
  RealClassName: WideString;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcObjectInfoProvider.CheckInheritedFrom', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcObjectInfoProvider.GetClassName(Instance: Pointer): WideString;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TObject(Instance).ClassName;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcObjectInfoProvider.GetClassName', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcObjectInfoProvider.GetInstanceSize(Instance: Pointer): Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TObject(Instance).InstanceSize;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcObjectInfoProvider.GetInstanceSize', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcObjectInfoProvider.GetVMT(Instance: Pointer;
  const ClassName: WideString; out Offset: Integer;
  out VMT: Pointer): WordBool;
var
  Parent: Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcObjectInfoProvider.GetVMT', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcObjectInfoProvider.ObjectIsValid(Instance: Pointer): WordBool;
var
  P: Pointer;
  SelfPtr: Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcObjectInfoProvider.ObjectIsValid', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcComponentInfoProvider }

function TtcComponentInfoProvider.FindComponent(Component: Pointer;
  const Name: WideString): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TComponent(Component).FindComponent(Name);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcComponentInfoProvider.FindComponent', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
      Result := nil;
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcComponentInfoProvider.GetChildComponent(Component: Pointer;
  Index: Integer): Pointer;
  var
    l_ParentComponent , l_ChildComponent : TComponent;
begin
  // QC {
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}
    l_ParentComponent := TComponent(Component);

    if l_ParentComponent is TVGScene then
      l_ChildComponent := TVGScene(Component).Children[Index]
    else if l_ParentComponent is TVGObject then
      l_ChildComponent := TVGObject(Component).Children[Index]
    else
    begin
      l_ChildComponent := l_ParentComponent.Components[Index];
      if (l_ChildComponent is TVGObject) // TVGObject возвращаем только если его родитель TVGObject или TVGScene для сохранения стройности иерархии
        OR ((l_ChildComponent is TWinControl) AND (TWinControlFriend(l_ChildComponent).WindowHandle = 0))
      then
      begin
        Result := nil;
        Exit;
      end;
    end;
    Result := Pointer(l_ChildComponent);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcComponentInfoProvider.GetChildComponent', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
  // } QC
  //Result := Pointer(TComponent(Component).Components[Index];);
end;

function TtcComponentInfoProvider.GetComponentCount(
  Component: Pointer): Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if TComponent(Component) is TVGScene then
      Result := TVGScene(Component).Count
    else if TComponent(Component) is TVGObject then
      Result := TVGObject(Component).ChildrenCount
    else
      Result := TComponent(Component).ComponentCount;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcComponentInfoProvider.GetComponentCount', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcComponentInfoProvider.GetComponentName(
  Component: Pointer): WideString;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TComponent(Component).Name;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcComponentInfoProvider.GetComponentName', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
      Result := '_QC_UNKNOWN_NAME_';
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcComponentInfoProvider.GetOwner(Component: Pointer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Pointer(TComponent(Component).Owner);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcComponentInfoProvider.GetOwner', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcControlInfoProvider }

procedure TtcControlInfoProvider.ClientToScreen(Control: Pointer;
  var Point: TPoint);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Point := TControl(Control).ClientToScreen(Point);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.ClientToScreen', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcControlInfoProvider.GetEnabled(Control: Pointer): WordBool;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TControl(Control).Enabled;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.GetEnabled', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcControlInfoProvider.GetHeight(Control: Pointer): Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TControl(Control).Height;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.GetHeight', E, IS_IGNORED);      
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcControlInfoProvider.GetLeft(Control: Pointer): Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TControl(Control).Left;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.GetLeft(', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcControlInfoProvider.GetParent(Control: Pointer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Pointer(TControl(Control).Parent);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.GetParent', E, IS_IGNORED);      
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcControlInfoProvider.GetTop(Control: Pointer): Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TControl(Control).Top;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.GetTop', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcControlInfoProvider.GetVisible(Control: Pointer): WordBool;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TControl(Control).Visible;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.GetVisible', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcControlInfoProvider.GetWidth(Control: Pointer): Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := TControl(Control).Width;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.GetWidth', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcControlInfoProvider.ScreenToClient(Control: Pointer;
  var Point: TPoint);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Point := TControl(Control).ScreenToClient(Point);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcControlInfoProvider.ScreenToClient', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcWinControlInfoProvider }

function TtcWinControlInfoProvider.FindControl(Handle: HWND): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Pointer(Controls.FindControl(Handle));
    {$IFDEF TC_USE_CLX}
    if Result = nil then
      Result := Pointer(QClxObjectMap_find(QWidget_find(Handle)));
    {$ENDIF}

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcWinControlInfoProvider.FindControl', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcWinControlInfoProvider.GetChildControl(Control: Pointer;
  Index: Integer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if TObject(Control) is TWinControl then
      Result := TWinControl(Control).Controls[Index]
  {$IFDEF TC_USE_CLX}
    else if TObject(Control) is TWidgetControl then
      Result := TWidgetControl(Control).Controls[Index]
  {$ENDIF}
    else
      Result := nil;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcWinControlInfoProvider.GetChildControl', E, IS_IGNORED);      
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcWinControlInfoProvider.GetControlAtPos(WinControl: Pointer;
  const Pos: TPoint): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if WinControl <> nil then
      Result := Pointer(TWinControl(WinControl).ControlAtPos(Pos, True{$IFDEF DELPHI5}, False{$ENDIF}))
    else
      if Screen.ActiveForm <> nil then
        Result := Pointer(Screen.ActiveForm.ControlAtPos(Pos, True{$IFDEF DELPHI5}, False{$ENDIF}))
      else
        Result := nil;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcWinControlInfoProvider.GetControlAtPos', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

//type
//  TWinControlFriend = class(TWinControl);

function TtcWinControlInfoProvider.GetControlCount(
  Control: Pointer): Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    if TObject(Control) is TWinControl then
      Result := TWinControl(Control).ControlCount
  {$IFDEF TC_USE_CLX}
    else if TObject(Control) is TWidgetControl then
      Result := TWidgetControl(Control).ControlCount
  {$ENDIF}
    else
      Result := 0

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcWinControlInfoProvider.GetControlCount', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcWinControlInfoProvider.GetHandle(WinControl: Pointer): HWND;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcWinControlInfoProvider.GetHandle', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
      Result := 0;
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcTopComponentProvider }

function TtcTopComponentProvider.GetComponent(Index: Integer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Screen.DataModules[Index];

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTopComponentProvider.GetComponent', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcTopComponentProvider.GetCount: Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Screen.DataModuleCount;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTopComponentProvider.GetCount', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcModuleInfoProvider }

constructor TtcModuleInfoProvider.Create;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    inherited Create;
    {$IFDEF DELPHI5}
    FSyncWindow := Forms.AllocateHWnd(SyncWindowProc);
    {$ELSE}
    FSyncWindow := AllocateHWnd(SyncWindowProc);
    {$ENDIF}
    System.GetMemoryManager(FMemoryManager);
    FTypeInfoProvider := TtcTypeInfoProvider.Create;
    FObjectInfoProvider := TtcObjectInfoProvider.Create;
    FComponentInfoProvider := TtcComponentInfoProvider.Create;
    FControlInfoProvider := TtcControlInfoProvider.Create;
    FWinControlInfoProvider := TtcWinControlInfoProvider.Create;
    FTopComponentProvider := TtcTopComponentProvider.Create;
    FTestClassProvider := TtcTestClassProvider.Create;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcModuleInfoProvider.Create', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

destructor TtcModuleInfoProvider.Destroy;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    DeallocateHWnd(FSyncWindow);
    inherited;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcModuleInfoProvider.Destroy', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
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
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcModuleInfoProvider.MakeSafeCall', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcModuleInfoProvider.SetConversions(
  const Conversions: ItcConversions);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    _Conversions := Conversions;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcModuleInfoProvider.SetConversions', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcModuleInfoProvider.SyncWindowProc(var Message: Messages.TMessage);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Message.Result := DefWindowProc(FSyncWindow, Message.Msg, Message.WParam, Message.LParam);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcModuleInfoProvider.SyncWindowProc', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcTable }

procedure TtcTable.Clear;
var
  Index: Integer;
  Entry: PtcTableEntry;
  OldEntry: PtcTableEntry;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Clear', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcTable.ContainsKey(Key: Pointer): Boolean;
var
  Entry: PtcTableEntry;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.ContainsKey', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

constructor TtcTable.Create;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    inherited Create;
    FLoadFactor := 0.5;
    FCapacity := 10;
    GetMem(FItems, FCapacity * SizeOf(Pointer));
    FillChar(FItems^, FCapacity * SizeOf(Pointer), 0);
    FThreshold := Round(FCapacity * FLoadFactor);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Create', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

destructor TtcTable.Destroy;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Clear;
    FreeMem(FItems);
    inherited;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Destroy', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
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
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Exclude', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcTable.Get(Key: Pointer): Pointer;
var
  Entry: PtcTableEntry;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Get', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcTable.Put(Key, Value: Pointer);
var
  Index: Integer;
  Entry: PtcTableEntry;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Put', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
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
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Rehash', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcTable.Remove(Key: Pointer);
var
  Value: Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Value := Exclude(Key);
    DoRemove(Value);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTable.Remove', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcObjectTable }

procedure TtcObjectTable.DoRemove(AItem: Pointer);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    inherited;
    if AItem <> nil then
      TObject(AItem).Free;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcObjectTable.DoRemove', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcTestClassProvider }

constructor TtcTestClassProvider.Create;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    inherited Create;
    FClasses := TList.Create;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTestClassProvider.Create', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

destructor TtcTestClassProvider.Destroy;
var
  I: Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    for I := 0 to FClasses.Count - 1 do
    begin
      Assert(FClasses[I] <> nil);
      Dispose(PtcTypeInfo(FClasses[I]));
    end;
    FreeAndNil(FClasses);
    inherited;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTestClassProvider.Destroy', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcTestClassProvider.GetCount: Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := FClasses.Count;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTestClassProvider.GetCount', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcTestClassProvider.GetTypeInfos(Index: Integer): PtcTypeInfo;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Assert((Index >= 0) and (Index < FClasses.Count));
    Result := PtcTypeInfo(FClasses[Index]);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTestClassProvider.GetTypeInfos', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcTestClassProvider.RegisterClass(ClassInstance: TClass);
var
  TypeInfo: PtcTypeInfo;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Assert(ClassInstance <> nil);
    New(TypeInfo);
    TypeInfo.Name := ClassInstance.ClassName;
    TypeInfo.ClassInstance := ClassInstance;
    FClasses.Add(TypeInfo);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcTestClassProvider.RegisterClass', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{$IFDEF DELPHI7}
{$IFNDEF BCB}

{ TtcMethodInfoProvider }

constructor TtcMethodInfoProvider.Create(AClass: TClass);
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    inherited Create;
    FClass := AClass;
    FMethodNames   := TStringList.Create;
    FMethodHeaders := TList.Create;
    ClearMethodInfo;
    ReadClass(AClass);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.Create', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

destructor TtcMethodInfoProvider.Destroy;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    ClearMethodInfo;
    FreeAndNil(FMethodNames);
    FreeAndNil(FMethodHeaders);
    inherited;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.Destroy', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

procedure TtcMethodInfoProvider.ClearMethodInfo;
var
  i: Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    FMethodHeaders.Clear;
    for i:= 0 to FMethodNames.Count - 1 do
      FMethodNames.Objects[i].Free;
    FMethodNames.Clear;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.ClearMethodInfo', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

const
  c_ShortStringLength = sizeof(ShortString) - 1;

function TtcMethodInfoProvider.IsExtendedRTTIExists(AMethod: PMethodInfoHeader): Boolean;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := False;
    if AMethod = nil then
      Exit;
    if AMethod.Len <= SizeOf(TMethodInfoHeader) - c_ShortStringLength + Length(AMethod.Name) then
      Result := False
    else
      Result := True;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.IsExtendedRTTIExists', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetNextParam(AParamInfo: PParamInfo): PParamInfo;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := nil;
    if AParamInfo <> nil then
      Result := PParamInfo(Integer(AParamInfo) + SizeOf(AParamInfo^) - c_ShortStringLength + Length(AParamInfo.Name));

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetNextParam', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
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
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := Pointer(Integer(Pointer(AClass)) - SizeOf(TVmt));

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('GetVMT', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetMethodTable(AClass: TClass): PtcPMethodTable;
var
  VMT: PVmt;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    VMT := GetVMT(AClass);
    if VMT <> nil then
      Result := VMT.MethodTable
    else
      Result := nil;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetMethodTable', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetMethodInfoHeader(AClass: TClass; AIndex: Integer): PMethodInfoHeader;
var
  PMT: PtcPMethodTable;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetMethodInfoHeader', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetMethodInfoHeaderCount(AClass: TClass): Integer;
var
  Pmt: PtcPMethodTable;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := 0;
    Pmt := GetMethodTable(AClass);
    if Pmt <> nil then
      Result := Pmt.Count;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetMethodInfoHeaderCount', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNOR?LCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetCachedMethodInfoHeader(AIndex: Integer): PMethodInfoHeader;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := nil;
    if (AIndex >= 0) and (AIndex < FMethodHeaders.Count) then
      Result := FMethodHeaders.Items[AIndex];

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetCachedMethodInfoHeader', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
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
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

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

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.ReadClass', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{ TtcMethodInfoProvider.ItcMethodInfoProvider }

function TtcMethodInfoProvider.GetCount: Integer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := FMethodNames.Count;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetCount', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetName(AIndex: Integer): WideString;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := '';
    if (AIndex >= 0) and (AIndex < FMethodNames.Count) then
      Result := FMethodNames.Strings[AIndex];

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetName', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetParamList(AMethodIndex: Integer): TList;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := nil;
    if (AMethodIndex >= 0) and (AMethodIndex < FMethodNames.Count) then
      Result := TList(FMethodNames.Objects[AMethodIndex]);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetParamList', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.IsReturnExtraParam(AParamInfo: PParamInfo): Boolean;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := True;
    if AParamInfo <> nil then
      Result := pfResult in AParamInfo.Flags;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.IsReturnExtraParam(', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetParamCount(AMethodIndex: Integer): Integer;
var
  ParamList: TList;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := 0;
    ParamList := GetParamList(AMethodIndex);
    if ParamList <> nil then
       Result := ParamList.Count - 1; // - 1: First parameter is 'Self'

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetParamCount', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetParamInfo(AMethodIndex, AParamIndex: Integer): PParamInfo;
var
  ParamList: TList;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := nil;
    ParamList := GetParamList(AMethodIndex);
    if ParamList <> nil then
    begin
      Inc(AParamIndex); // First (zero) parameter is 'Self'
      if (AParamIndex >= 0) and (AParamIndex < ParamList.Count) then
        Result := ParamList.Items[AParamIndex]
    end;

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetParamInfo', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetReturnInfo(AMethodIndex: Integer): PReturnInfo;
var
  MethodHeader: PMethodInfoHeader;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := nil;
    MethodHeader := GetCachedMethodInfoHeader(AMethodIndex);
    if MethodHeader <> nil then
      Result := PReturnInfo(Integer(MethodHeader) + SizeOf(MethodHeader^) - c_ShortStringLength + Length(MethodHeader.Name));

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetReturnInfo', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

function TtcMethodInfoProvider.GetCookie(AMethodIndex: Integer): Pointer;
begin
{$IFDEF QC_CATCH_EXCEPTIONS}
  try
{$ENDIF QC_CATCH_EXCEPTIONS}

    Result := GetCachedMethodInfoHeader(AMethodIndex);

{$IFDEF QC_CATCH_EXCEPTIONS}
  except
    on E : Exception do
    begin
      OutputDebugStringE('TtcMethodInfoProvider.GetCookie', E, IS_IGNORED);
      {$IFNDEF QC_IGNORE_EXCEPTIONS} Raise E; {$ENDIF QC_IGNORE_EXCEPTIONS}
    end;
  end;
{$ENDIF QC_CATCH_EXCEPTIONS}
end;

{$ENDIF}
{$ENDIF}

initialization
  VarToObjectProc := _VarToObject;
  VarFromObjectProc := _VarFromObject;

{$EndIf XE}

end.
