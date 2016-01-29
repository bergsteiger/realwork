unit tc5PublicInfo;

{$Include l3XE.inc}

{$I tc5_ver.inc}

interface

{$IfNDef XE}
uses
  Classes, ActiveX, tc5OpenAppClasses;

function VarToObject(const V: OleVariant): TObject;
function VarFromObject(Obj: TObject): IDispatch;
{$IFNDEF DELPHI3}
function VarFromInt64(const Int64Val: Int64): OleVariant;
{$ENDIF DELPHI3}

procedure VarToSet(TypeInfo: Pointer; const V: OleVariant; var S; Size: Integer);
function VarFromSet(TypeInfo: Pointer; const S; Size: Integer): OleVariant;

function __coerce_Boolean(const Arg: TVariantArg): Boolean;
function __coerce_Byte(const Arg: TVariantArg): Byte;
function __coerce_Word(const Arg: TVariantArg): Word;
function __coerce_Integer(const Arg: TVariantArg): Integer;
function __coerce_Cardinal(const Arg: TVariantArg): Cardinal;
function __coerce_Shortint(const Arg: TVariantArg): Shortint;
function __coerce_Smallint(const Arg: TVariantArg): Smallint;
function __coerce_Longint(const Arg: TVariantArg): Longint;
function __coerce_Variant(const Arg: TVariantArg): Variant;
function __coerce_OleVariant(const Arg: TVariantArg): OleVariant;
{$IFNDEF DELPHI3}
function __coerce_Longword(const Arg: TVariantArg): Longword;
function __coerce_Int64(const Arg: TVariantArg): Int64;
{$ENDIF DELPHI3}
function __coerce_Largeint(const Arg: TVariantArg): Largeint;
function __coerce_WordBool(const Arg: TVariantArg): WordBool;

function __coerce_Char(const Arg: TVariantArg): Char;
function __coerce_WideChar(const Arg: TVariantArg): WideChar;
function __coerce_String(const Arg: TVariantArg): WideString;
function __coerce_WideString(const Arg: TVariantArg): WideString;

function __coerce_Real(const Arg: TVariantArg): Real;
function __coerce_Single(const Arg: TVariantArg): Single;

{$IFDEF DELPHI4}
function __coerce_Comp(const Arg: TVariantArg): Comp;
{$ENDIF DELPHI4}
function __coerce_Currency(const Arg: TVariantArg): Currency;
function __coerce_Extended(const Arg: TVariantArg): Extended;
function __coerce_Double(const Arg: TVariantArg): Double;

function __coerce_PChar(const Arg: TVariantArg): PChar;
function __coerce_PWideChar(const Arg: TVariantArg): PWideChar;

function __coerce_TObject(const Arg: TVariantArg): TObject;
function __coerce_IUnknown(const Arg: TVariantArg): IUnknown;
function __coerce_IDispatch(const Arg: TVariantArg): IDispatch;

function _RegisterMethod(ClassInfo: Pointer; MethodType: TtcMethodType;
  const MethodName: WideString; RetVal: Pointer; const Params: array of Pointer;
  const Names: array of WideString; MethodProc: TtcMethodProc): Boolean;
{$EndIf XE}

implementation

{$IfNDef XE}

uses
  {$IFDEF DELPHI6}
  Variants,
  {$ELSE}
  Forms,
  {$ENDIF}
  SysUtils,
  TypInfo,
  Messages,
  Windows
  {$IFDEF DELPHI7}
  {$IFNDEF BCB}
  , ObjAuto
  {$ENDIF}
  {$ENDIF}
  ;

type
  TtcMethodList = class(TList)
  protected
    {$IFDEF DELPHI5}
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
    {$ENDIF DELPHI5}
  end;

  PtcCallData = ^TtcCallData;
  TtcCallData = packed record
    MethodProc: TtcMethodProc;
    Instance: TObject;
    Args: PVariantArgList;
    Value: OleVariant;
    Cookie: Cardinal;
  end;

  PtcFrameData = ^TtcFrameData;
  TtcFrameData = packed record
    CallData: PtcCallData;
    FrameException: WideString;
    Signal: THandle;
  end;

  {$IFDEF DELPHI7}
  {$IFNDEF BCB}
  PtcClassMethodCookieData = ^TtcClassMethodCookieData;
  TtcClassMethodCookieData = packed record
    MethodInfo: PMethodInfoHeader;
    ParamCount: Integer;
    Params:     array of PParamInfo;
  end;
  {$ENDIF}
  {$ENDIF}

  TtcPublicInfoLibrary = class
  private
    FTable: TtcTable;
    FCompiledTable: TtcTable;
    FFrame: THandle;
    FMainThread: Cardinal;
    FBufferList: TList;
    {$IFDEF DELPHI7}
    {$IFNDEF BCB}
    FMethodCookieList: TList;
    {$ENDIF}
    {$ENDIF}
  protected
    procedure FrameProcedure(var Message: TMessage);
    procedure DispatchData(Data: PtcCallData);
    procedure Clear;
  public
    constructor Create;
    destructor Destroy; override;

    function RegisterMethod(ClassInfo: Pointer; MethodType: TtcMethodType;
      const MethodName: WideString; RetVal: Pointer; const Params: array of Pointer;
      const Names: array of WideString; MethodProc: TtcMethodProc): Boolean;

    function GetMethodList(ClassInfo: Pointer; out MethodInfoList: PtcMethodInfoList;
      out Size: Integer): Boolean;
    procedure ReleaseMethodList(MethodList: PtcMethodInfoList);
  end;

{$IFNDEF DELPHI5}
  TIntegerSet = set of 0..SizeOf(Integer) * 8 - 1;
{$ENDIF}

var
  PublicInfoLibrary: TtcPublicInfoLibrary;

const
  TypType2Type: array[TTypeKind] of TtcTypeKind = (
    tckUnknown, tckInteger, tckChar, tckEnumeration, tckFloat,
    tckString, tckSet, tckClass, tckMethod, tckWChar, tckLString, tckWString,
    tckVariant, tckArray, tckRecord, tckInterface {$IFNDEF DELPHI3}, tckInt64, tckDynArray{$ENDIF DELPHI3}
  );

  TypeToVT: array[TtcTypeKind] of Integer = (
    VT_EMPTY, VT_I4, VT_I1, VT_I4, VT_R8,
    VT_BSTR, VT_BSTR, VT_DISPATCH, VT_EMPTY, VT_BSTR, VT_BSTR, VT_BSTR,
    VT_VARIANT, VT_EMPTY, VT_EMPTY, VT_UNKNOWN, VT_DECIMAL, VT_EMPTY
  );

  VisibleTypeKinds: TTypeKinds = [tkInteger, tkChar, tkEnumeration, tkFloat,
          tkString, tkSet, tkClass, tkWChar, tkLString, tkWString,
          tkVariant, tkInterface];

var
  CMD_DISPATCH: UINT;

{$IFNDEF DELPHI6}
function VarToWideStr(const V: Variant): WideString;
begin
  if not VarIsNull(V) then
    Result := V
  else
    Result := '';
end;
{$ENDIF}

function _RegisterMethod(ClassInfo: Pointer; MethodType: TtcMethodType;
  const MethodName: WideString; RetVal: Pointer; const Params: array of Pointer;
  const Names: array of WideString; MethodProc: TtcMethodProc): Boolean;
begin
  Result := PublicInfoLibrary.RegisterMethod(ClassInfo, MethodType,
    MethodName, RetVal, Params, Names, MethodProc);
end;

function GetMethodList(ClassInfo: Pointer;
  out MethodInfoList: PtcMethodInfoList; out Size: Integer): Boolean;
begin
  Result := PublicInfoLibrary.GetMethodList(ClassInfo, MethodInfoList, Size);
end;

procedure ReleaseMethodList(MethodList: PtcMethodInfoList);
begin
  if PublicInfoLibrary <> nil then
    PublicInfoLibrary.ReleaseMethodList(MethodList);
end;

function CreateParameter(ParamType: Pointer; const Name: WideString): PtcParameter;
var
  Info: PTypeInfo;
begin
  New(Result);
  Result.Name := Name;
  Info := PTypeInfo(ParamType);
  if Info <> nil then
  begin
    Result.TypeKind := TypType2Type[Info.Kind];
    Result.TypeName := Info.Name;
    Result.VT := TypeToVT[Result.TypeKind];

    case Result.TypeKind of
    tckEnumeration:
      if SameText(Result.TypeName, 'Boolean') then
        Result.VT := VT_BOOL;
    tckInterface:
      if SameText(Result.TypeName, 'IDispatch') then
        Result.VT := VT_DISPATCH;
    end;
  end;
  Result.Data := Info;
end;

procedure _PropSetMethodSync(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
var
  PropInfo: PPropInfo;
  V: OleVariant;
  S: WideString;
begin
  PropInfo := PPropInfo(Cookie);
  Assert(PropInfo <> nil);

  V := OleVariant(Args^[0]);
  case PropInfo.PropType^.Kind of
  tkInteger:
    SetOrdProp(Instance, PropInfo, V);

  tkWChar, tkChar:
    begin
      S := VarToWideStr(V);
      if S = '' then
        SetOrdProp(Instance, PropInfo, 0)
      else
        SetOrdProp(Instance, PropInfo, Ord(S[1]));
    end;

  tkString, tkLString, tkWString:
    SetStrProp(Instance, PropInfo, VarToWideStr(V));

  tkEnumeration:
    if SameText(PropInfo.PropType^.Name, 'Boolean') then
      SetOrdProp(Instance, PropInfo, Integer(Boolean(V)))
    else
      SetOrdProp(Instance, PropInfo, V);

  tkFloat:
    SetFloatProp(Instance, PropInfo, V);

  {$IFDEF DELPHI5}
  tkSet:
    SetSetProp(Instance, PropInfo, VarToWideStr(V));
  {$ENDIF DELPHI5}

  tkClass:
    SetOrdProp(Instance, PropInfo, Integer(VarToObject(V)));

  tkVariant:
    SetVariantProp(Instance, PropInfo, V);

  {$IFDEF DELPHI6}
  tkInt64:
    SetInt64Prop(Instance, PropInfo, Trunc(V));

  tkInterface:
    SetInterfaceProp(Instance, PropInfo, IUnknown(V));
  {$ENDIF DELPHI6}
  else
    // Unsupported types:
    // tkUnknown, tkMethod, tkRecord, tkArray, tkDynArray
  end;
end;

procedure _PropSetMethod(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
var
  CallData: TtcCallData;
begin
  CallData.MethodProc := _PropSetMethodSync;
  CallData.Instance := Instance;
  CallData.Args := Args;
  CallData.Cookie := Cookie;
  PublicInfoLibrary.DispatchData(@CallData);
  Value := CallData.Value;
end;

procedure _PropGetMethodSync(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
var
  PropInfo: PPropInfo;
begin
  PropInfo := PPropInfo(Cookie);
  Assert(PropInfo <> nil);

  case PropInfo.PropType^.Kind of
  tkInteger:
    Value := GetOrdProp(Instance, PropInfo);

  tkWChar, tkChar:
    Value := WideString(WideChar(GetOrdProp(Instance, PropInfo)));

  tkString, tkLString, tkWString:
    Value := GetStrProp(Instance, PropInfo);

  tkEnumeration:
    begin
      Value := GetOrdProp(Instance, PropInfo);
      if SameText(PropInfo.PropType^.Name, 'Boolean') then
        Value := Boolean(Value);
    end;

  tkFloat:
    Value := GetFloatProp(Instance, PropInfo);

  {$IFDEF DELPHI5}
  tkSet:
    Value := GetSetProp(Instance, PropInfo);
  {$ENDIF DELPHI5}

  tkClass:
    Value := VarFromObject(TObject(GetOrdProp(Instance, PropInfo)));

  tkVariant:
    Value := GetVariantProp(Instance, PropInfo);

  {$IFDEF DELPHI6}
  tkInt64:
    Value := GetInt64Prop(Instance, PropInfo);

  tkInterface:
    Value := GetInterfaceProp(Instance, PropInfo);
  {$ENDIF DELPHI6}
  else
    // Unsupported types:
    // tkUnknown, tkMethod, tkRecord, tkArray, tkDynArray
    Value := Null;
  end;
end;

procedure _PropGetMethod(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
var
  CallData: TtcCallData;
begin
  CallData.MethodProc := _PropGetMethodSync;
  CallData.Instance := Instance;
  CallData.Args := Args;
  CallData.Cookie := Cookie;
  PublicInfoLibrary.DispatchData(@CallData);
  Value := CallData.Value;
end;

{$IFDEF DELPHI7}
{$IFNDEF BCB}
function GetVarDataInd(AVarData: PVarData): PVarData;
begin
  if AVarData^.VType and varByRef <> 0 then
    Result := GetVarDataInd(AVarData.VPointer)
  else
    Result := AVarData;
end;

// GetVariantType and InterfaceDerivesFrom: see ObjAuto.pas
function GetVariantType(TypeInfo: PTypeInfo): TVarType;

  function InterfaceDerivesFrom(TypeData: PTypeData; const GUID: TGUID): Boolean;
  begin
    Result := True;
    while TypeData <> nil do
    begin
      if IsEqualGUID(TypeData^.Guid, GUID) then
         Exit;
      if (TypeData^.IntfParent <> nil) and (TypeData^.IntfParent^ <> nil) then
        TypeData := GetTypeData(TypeData^.IntfParent^)
      else
        Break;
    end;
    Result := False;
  end;

var
  TypeData: PTypeData;
begin
  case TypeInfo^.Kind of
    tkUnknown:  Result := varError;
    tkInteger, tkChar, tkEnumeration, tkWChar:
      if (TypeInfo = System.TypeInfo(Boolean)) or
        (TypeInfo = System.TypeInfo(WordBool)) or
        (TypeInfo = System.TypeInfo(LongBool)) then
        Result := varBoolean
      else
      begin
        TypeData := GetTypeData(TypeInfo);
        if TypeData^.MinValue >= 0 then
          if Cardinal(TypeData^.MaxValue) > $FFFF then
            Result := varLongWord
          else if TypeData^.MaxValue > $FF then
            Result := varWord
          else
            Result := varByte
          else
            if (TypeData^.MaxValue > $7FFF) or (TypeData^.MinValue < -$7FFF - 1) then
              Result := varInteger
            else if (TypeData^.MaxValue > $7F) or (TypeData^.MinValue < -$7F - 1) then
              Result := varSmallint
            else
              Result := varShortint;
      end;
    tkFloat:
      begin
        TypeData := GetTypeData(TypeInfo);
        case TypeData^.FloatType of
          ftSingle: Result := varSingle;
          ftDouble:
            if TypeInfo = System.TypeInfo(TDateTime) then
              Result := varDate
            else
              Result := varDouble;
          ftComp, ftCurr: Result := varCurrency;
        else
          Result := varError;
        end;
      end;
    tkString:   Result := varString;
    tkLString:  Result := varString;
    tkWString:  Result := varOleStr;
    tkInterface:
      begin
        TypeData := GetTypeData(TypeInfo);
        if InterfaceDerivesFrom(TypeData, IDispatch) then
          Result := varDispatch
        else
          Result := varUnknown;
      end;
    tkVariant:  Result := varVariant;
    tkInt64:    Result := varInt64;
  else
    Result := varError;
  end;
end;

procedure _ExecuteClassMethod(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
var
  ParamIndexes: array of Integer;
  Params:       array of Variant;
  ParamInfo:    PParamInfo;
  l, i, j:      Integer;
  MethodCookie: PtcClassMethodCookieData;
  CurrentParam: OleVariant;
  VarType:      TVarType;
  VarData:      PVarData;
begin
  MethodCookie := PtcClassMethodCookieData(Cookie);
  Assert(MethodCookie <> nil);
  l := MethodCookie.ParamCount;
  SetLength(ParamIndexes, l);
  SetLength(Params, l);
  j := 0;
  for i := l - 1 downto 0 do
  begin
    ParamInfo := MethodCookie.Params[j];
    if ParamInfo.Flags * [pfOut, pfVar] <> [] then
    begin
      VariantInit(CurrentParam);
      VarType := GetVariantType(ParamInfo.ParamType^) or varByRef;
      if ParamInfo.ParamType^.Kind <> tkVariant then
      begin
        TVarData(CurrentParam).VType := VarType;
        VarData := GetVarDataInd(PVarData(@Args^[i]));
        TVarData(CurrentParam).VPointer := @VarData.VPointer;
      end
      else
        CurrentParam := OleVariant(Args^[i]);
    end
    else
      CurrentParam := OleVariant(Args^[i]);
    Params[j] := CurrentParam;
    ParamIndexes[j] := j + 1;
    Inc(j);
  end;
  Value := ObjAuto.ObjectInvoke(Instance, MethodCookie.MethodInfo, ParamIndexes, Params);
  //
  j := 0;
  for i := l - 1 downto 0 do
  begin
    ParamInfo := MethodCookie.Params[j];
    if ParamInfo.Flags * [pfOut, pfVar] <> [] then
    begin
      if ParamInfo.ParamType^.Kind <> tkVariant then
        Continue
      else
        VarCopy(Args^[i].pvarVal^, Params[j]);
      end;
    Inc(j);
  end;
end;
{$ENDIF}
{$ENDIF}

procedure _StdMethod(Instance: TObject; Args: PVariantArgList; out Value: OleVariant; Cookie: Cardinal); stdcall;
var
  CallData: TtcCallData;
begin
  CallData.MethodProc := TtcMethodProc(Cookie);
  CallData.Instance := Instance;
  CallData.Args := Args;
  CallData.Cookie := 0;
  PublicInfoLibrary.DispatchData(@CallData);
  Value := CallData.Value;
end;

function GetClassTypeInfo(ClassInstance: Pointer): Pointer;
asm
  MOV EAX, [EAX + vmtTypeInfo]
end;

function VarToObject(const V: OleVariant): TObject;
begin
  Assert(Assigned(VarToObjectProc));
  if Assigned(VarToObjectProc) then
    Result := VarToObjectProc(V)
  else
    Result := nil;
end;

function VarFromObject(Obj: TObject): IDispatch;
begin
  Assert(Assigned(VarFromObjectProc));
  if Assigned(VarFromObjectProc) then
    Result := VarFromObjectProc(Obj)
  else
    Result := nil;
end;

{$IFNDEF DELPHI3}
function VarFromInt64(const Int64Val: Int64): OleVariant;
const
  VT_I8 = $0014;
begin
  Result := Null;             
  tagVariant(Result).vt := VT_I8;
  PInt64(@tagVariant(Result).lVal)^ := Int64Val;
end;
{$ENDIF DELPHI3}

function SetToInt(const S; Size: Integer): Integer;
begin
  case Size of
  1:
    Result := Byte(S);
  2:
    Result := Word(S);
  else
    Result := Integer(S);
  end;
end;

procedure SetFromInt(I: Integer; var S; Size: Integer);
begin
  case Size of
  1:
    Byte(S) := I;
  2:
    Word(S) := I;
  else
    Integer(S) := I;
  end;
end;

procedure VarToSet(TypeInfo: Pointer; const V: OleVariant; var S; Size: Integer);
var
  P: PChar;
  EnumName: string;
  EnumValue: Longint;
  EnumInfo: PTypeInfo;

  // grab the next enum name
  function NextWord(var P: PChar): string;
  var
    i: Integer;
  begin
    i := 0;

    // scan til whitespace
    while not (P[i] in [',', ' ', #0,']']) do
      Inc(i);

    SetString(Result, P, i);

    // skip whitespace
    while P[i] in [',', ' ',']'] do
      Inc(i);

    Inc(P, i);
  end;

var
  i4: Integer;
  Value: String;
begin
  i4 := 0;
  SetFromInt(i4, S, Size);

  Value := VarToWideStr(V);
  if Value = '' then Exit;
  P := PChar(Value);

  // skip leading bracket and whitespace
  while P^ in ['[',' '] do
    Inc(P);

  EnumInfo := GetTypeData(TypeInfo)^.CompType^;
  EnumName := NextWord(P);
  while EnumName <> '' do
  begin
    EnumValue := GetEnumValue(EnumInfo, EnumName);
    if EnumValue < 0 then
      break;
    Include(TIntegerSet(i4), EnumValue);
    EnumName := NextWord(P);
  end;
  SetFromInt(i4, S, Size);
end;

function VarFromSet(TypeInfo: Pointer; const S; Size: Integer): OleVariant;
var
  IntSet: TIntegerSet;
  CompType: PTypeInfo;
  I: Integer;
  Str: WideString;
begin
  Integer(IntSet) := SetToInt(S, Size);
  CompType := GetTypeData(TypeInfo)^.CompType^;
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if I in IntSet then
    begin
      if Str <> '' then
        Str := Str + ',';
      Str := Str + GetEnumName(CompType, I);
    end;
  Result := Str;
end;

// Standard coerce procedures

function __coerce_Boolean(const Arg: TVariantArg): Boolean;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Integer(const Arg: TVariantArg): Integer;
begin
  Result := OleVariant(Arg);
end;

function __coerce_TObject(const Arg: TVariantArg): TObject;
begin
  Result := VarToObject(OleVariant(Arg));
end;

function __coerce_WideString(const Arg: TVariantArg): WideString;
begin
  Result := VarToWideStr(OleVariant(Arg));
end;

function __coerce_Byte(const Arg: TVariantArg): Byte;
begin
  Result := OleVariant(Arg);
end;

function __coerce_IUnknown(const Arg: TVariantArg): IUnknown;
begin
  Result := IUnknown(OleVariant(Arg));
end;

function __coerce_IDispatch(const Arg: TVariantArg): IDispatch;
begin
  Result := IUnknown(OleVariant(Arg)) as IDispatch;
end;

function __coerce_Word(const Arg: TVariantArg): Word;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Cardinal(const Arg: TVariantArg): Cardinal;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Shortint(const Arg: TVariantArg): Shortint;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Smallint(const Arg: TVariantArg): Smallint;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Longint(const Arg: TVariantArg): Longint;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Variant(const Arg: TVariantArg): Variant;
begin
  Result := OleVariant(Arg);
end;

function __coerce_OleVariant(const Arg: TVariantArg): OleVariant;
begin
  Result := OleVariant(Arg);
end;

{$IFNDEF DELPHI6}
function _VarToInt64(const V: OleVariant): Largeint;
const
  VAR_LOCALE_USER_DEFAULT = $400; // = Windows.LOCALE_USER_DEFAULT
var
  LTemp: OleVariant;
  LResult: HResult;
begin
  LResult := VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varInteger);
  if LResult = S_OK then
    Result := TVarData(LTemp).VInteger
  else
  begin
    LResult := VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varDouble);
    if LResult = S_OK then
      Result := Round(TVarData(LTemp).VDouble)
    else if LResult = DISP_E_TYPEMISMATCH then
    begin
      {$IFNDEF DELPHI3}
      LResult := VariantChangeTypeEx(LTemp, V, VAR_LOCALE_USER_DEFAULT, 0, varBoolean);
      if LResult = S_OK then
        Result := Largeint(TVarData(LTemp).VBoolean)
      else
      {$ENDIF DELPHI3}
        Result := 0;
    end
    else
      Result := 0;
  end;
end;
{$ENDIF DELPHI6}

{$IFNDEF DELPHI3}
function __coerce_Longword(const Arg: TVariantArg): Longword;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Int64(const Arg: TVariantArg): Int64;
begin
  {$IFDEF DELPHI6}
  Result := OleVariant(Arg);
  {$ELSE}
  Result := _VarToInt64(OleVariant(Arg));
  {$ENDIF DELPHI6}
end;
{$ENDIF DELPHI3}

function __coerce_Largeint(const Arg: TVariantArg): Largeint;
begin
  {$IFDEF DELPHI6}
  Result := OleVariant(Arg);
  {$ELSE}
  Result := _VarToInt64(OleVariant(Arg));
  {$ENDIF DELPHI6}
end;

function __coerce_WordBool(const Arg: TVariantArg): WordBool;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Char(const Arg: TVariantArg): Char;
begin
  Result := String(VarToWideStr(OleVariant(Arg)))[1];
end;

function __coerce_WideChar(const Arg: TVariantArg): WideChar;
begin
  Result := VarToWideStr(OleVariant(Arg))[1];
end;

function __coerce_String(const Arg: TVariantArg): WideString;
begin
  Result := VarToWideStr(OleVariant(Arg));
end;

function __coerce_Real(const Arg: TVariantArg): Real;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Single(const Arg: TVariantArg): Single;
begin
  Result := OleVariant(Arg);
end;

{$IFDEF DELPHI4}
function __coerce_Comp(const Arg: TVariantArg): Comp;
begin
  Result := OleVariant(Arg);
end;
{$ENDIF DELPHI4}

function __coerce_Currency(const Arg: TVariantArg): Currency;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Extended(const Arg: TVariantArg): Extended;
begin
  Result := OleVariant(Arg);
end;

function __coerce_Double(const Arg: TVariantArg): Double;
begin
  Result := OleVariant(Arg);
end;

function __coerce_PChar(const Arg: TVariantArg): PChar;
begin
  Result := PChar(String(VarToWideStr(OleVariant(Arg))));
end;

function __coerce_PWideChar(const Arg: TVariantArg): PWideChar;
begin
  Result := PWideChar(VarToWideStr(OleVariant(Arg)));
end;

{ TtcPublicInfoLibrary }

procedure TtcPublicInfoLibrary.Clear;
var
  I: Integer;
begin
  for I := 0 to FBufferList.Count - 1 do
    FreeMem(FBufferList[I]);
  {$IFDEF DELPHI7}
  {$IFNDEF BCB}
  for I := 0 to FMethodCookieList.Count - 1 do
  begin
    SetLength(PtcClassMethodCookieData(FMethodCookieList[I]).Params, 0);
    FreeMem(FMethodCookieList[I]);
  end;
  {$ENDIF}
  {$ENDIF}
  FTable.Clear;
  FCompiledTable.Clear;
end;

constructor TtcPublicInfoLibrary.Create;
begin
  FMainThread := GetCurrentThreadId;
  FTable := TtcObjectTable.Create;
  FCompiledTable := TtcObjectTable.Create;
  FFrame := AllocateHWnd(FrameProcedure);
  FBufferList := TList.Create;
  {$IFDEF DELPHI7}
  {$IFNDEF BCB}
  FMethodCookieList := TList.Create;
  {$ENDIF}
  {$ENDIF}
end;

destructor TtcPublicInfoLibrary.Destroy;
begin
  Clear;
  {$IFDEF DELPHI7}
  {$IFNDEF BCB}
  FreeAndNil(FMethodCookieList);
  {$ENDIF}
  {$ENDIF}
  FreeAndNil(FBufferList);
  FreeAndNil(FTable);
  FreeAndNil(FCompiledTable);
  DeallocateHWnd(FFrame);
  inherited;
end;

procedure TtcPublicInfoLibrary.DispatchData(Data: PtcCallData);
var
  FrameData: TtcFrameData;
begin
  FrameData.CallData := Data;
  try
    if FMainThread <> GetCurrentThreadId then
    begin
      // Avoid COM ISC
      FrameData.Signal := CreateEvent(nil, True, False, nil);
      try
        PostMessage(FFrame, CMD_DISPATCH, Integer(@FrameData), 0);
        WaitForSingleObject(FrameData.Signal, INFINITE);
      finally
        CloseHandle(FrameData.Signal);
      end;
    end
    else
      SendMessage(FFrame, CMD_DISPATCH, Integer(@FrameData), 0);
  finally
    if FrameData.FrameException <> '' then
      raise Exception.Create(FrameData.FrameException);
  end;
end;

procedure TtcPublicInfoLibrary.FrameProcedure(var Message: TMessage);
begin
  if Message.Msg = CMD_DISPATCH then
  begin
    try
      with PtcFrameData(Message.WParam).CallData^ do
        MethodProc(Instance, Args, Value, Cookie);
    except
      on E: Exception do
        PtcFrameData(Message.WParam)^.FrameException := E.Message;
    end;
    SetEvent(PtcFrameData(Message.WParam).Signal);
    Message.Result := 0;
  end
  else
    Message.Result := DefWindowProc(FFrame, Message.Msg, Message.WParam, Message.LParam);
end;

function TtcPublicInfoLibrary.GetMethodList(ClassInfo: Pointer;
  out MethodInfoList: PtcMethodInfoList; out Size: Integer): Boolean;
var
  List: TList;

  procedure RetrieveTypeInfoMethods(ClassInfo: Pointer);

    function Clone(MethodInfo: PtcMethodInfo): PtcMethodInfo;
    var
      I: Integer;
      Parameter: PtcParameter;
    begin
      New(Result);
      Result.ParamCount := 0;
      Result.Params := nil;
      Result.MethodType := MethodInfo.MethodType;
      Result.MethodName := MethodInfo.MethodName;
      Result.MethodProc := MethodInfo.MethodProc;
      Result.Cookie := MethodInfo.Cookie;
      if MethodInfo.RetVal <> nil then
      begin
        New(Result.RetVal);
        Result.RetVal^ := MethodInfo.RetVal^;
      end
      else
        Result.RetVal := nil;

      if MethodInfo.ParamCount > 0 then
      begin
        Result.ParamCount := MethodInfo.ParamCount;
        GetMem(Result.Params, Result.ParamCount * SizeOf(Pointer));
        for I := 0 to MethodInfo.ParamCount - 1 do
        begin
          New(Parameter);
          Parameter^ := PtcParameter(MethodInfo.Params^[I])^;
          Result.Params^[I] := Parameter;
        end;
      end;
    end;

  var
    I: Integer;
    MethodList: TtcMethodList;
  begin
    if ClassInfo <> nil then
    begin
      MethodList := TtcMethodList(FTable.Get(ClassInfo));
      if MethodList <> nil then
      begin
        for I := 0 to MethodList.Count - 1 do
          List.Add(Clone(PtcMethodInfo(MethodList[I])));
      end;
    end;
  end;

  procedure IterateOverAncestors(ClassInfo: Pointer);
  var
    Ancestor: TClass;
  begin
    if ClassInfo <> nil then
    begin
      Ancestor := TClass(ClassInfo).ClassParent;
      if Ancestor <> nil then
      begin
        RetrieveTypeInfoMethods(Ancestor);
        IterateOverAncestors(Ancestor);
      end;
    end;
  end;

  procedure FillTypInfo;
  var
    I, Count: Integer;
    TypeData: PTypeData;
    PropList: PPropList;
    PropInfo: PPropInfo;
    MethodInfo: PtcMethodInfo;
    TypeInfo: PTypeInfo;
    {$IFDEF DELPHI7}
    {$IFNDEF BCB}
    J: Integer;
    MethodInfoProvider: ItcMethodInfoProvider;
    ParamInfo: PParamInfo;
    ReturnInfo: PReturnInfo;
    CookieData: PtcClassMethodCookieData;
    {$ENDIF}
    {$ENDIF}
  begin
    TypeInfo := PTypeInfo(TClass(ClassInfo).ClassInfo);
    if TypeInfo = nil then
      exit;

    TypeData := GetTypeData(TypeInfo);
    if TypeData = nil then
      exit;

    Count := TypeData.PropCount;
    if Count = 0 then
      exit;

    GetMem(PropList, SizeOf(Pointer) * Count);
    Assert(PropList <> nil);
    if PropList = nil then
      exit;
    FBufferList.Add(PropList);

    Count := GetPropList(TypeInfo, VisibleTypeKinds, PropList);
    for I := 0 to Count - 1 do
    begin
      PropInfo := PPropInfo(PropList^[I]);
      if PropInfo.SetProc <> nil then
      begin
        New(MethodInfo);
        MethodInfo.MethodType := mtPut;
        MethodInfo.MethodName := PropInfo.Name;
        MethodInfo.RetVal := nil;
        MethodInfo.ParamCount := 1;
        GetMem(MethodInfo.Params, SizeOf(Pointer));
        MethodInfo.Params^[0] := CreateParameter(PropInfo.PropType^, 'Value');
        MethodInfo.MethodProc := _PropSetMethod;
        MethodInfo.Cookie := Cardinal(PropInfo);
        List.Add(MethodInfo);
      end;

      if PropInfo.GetProc <> nil then
      begin
        New(MethodInfo);
        MethodInfo.ParamCount := 0;
        MethodInfo.Params := nil;
        MethodInfo.MethodType := mtGet;
        MethodInfo.MethodName := PropInfo.Name;
        MethodInfo.RetVal := CreateParameter(PropInfo.PropType^, '');
        MethodInfo.MethodProc := _PropGetMethod;
        MethodInfo.Cookie := Cardinal(PropInfo);
        List.Add(MethodInfo);
      end;
    end;

    {$IFDEF DELPHI7}
    {$IFNDEF BCB}
    MethodInfoProvider := CreateMethodInfoProvider(TClass(ClassInfo));
    Count := MethodInfoProvider.GetCount;
    for I := 0 to Count - 1 do
    begin
      New(MethodInfo);
      MethodInfo.MethodType := mtInvoke;
      MethodInfo.MethodName := MethodInfoProvider.GetName(I);
      MethodInfo.ParamCount := MethodInfoProvider.GetParamCount(I);
      MethodInfo.MethodProc := _ExecuteClassMethod;
      //
      GetMem(CookieData, SizeOf(CookieData^));
      FillChar(CookieData^, SizeOf(CookieData^), #0);
      SetLength(CookieData.Params, MethodInfo.ParamCount);
      CookieData.MethodInfo := MethodInfoProvider.GetCookie(I);
      CookieData.ParamCount := MethodInfo.ParamCount;
      MethodInfo.Cookie     := Cardinal(CookieData);
      //
      if MethodInfo.ParamCount > 0 then
      begin
        GetMem(MethodInfo.Params, SizeOf(Pointer) * MethodInfo.ParamCount);
        for J := 0 to MethodInfo.ParamCount - 1 do
        begin
          ParamInfo := MethodInfoProvider.GetParamInfo(I, J);
          Assert(ParamInfo <> nil);
          CookieData.Params[J] := ParamInfo;
          MethodInfo.Params^[J] := CreateParameter(ParamInfo.ParamType^, ParamInfo.Name);
        end;
      end;
      ReturnInfo := MethodInfoProvider.GetReturnInfo(I);
      if (ReturnInfo <> nil) and (ReturnInfo.ReturnType <> nil) then
        MethodInfo.RetVal := CreateParameter(ReturnInfo.ReturnType^, '')
      else
        MethodInfo.RetVal := nil;
      //
      List.Add(MethodInfo);
      FMethodCookieList.Add(CookieData);
    end;
    {$ENDIF}
    {$ENDIF}

  end;

begin
  Assert(ClassInfo <> nil);

  if not FCompiledTable.ContainsKey(ClassInfo) then
  begin
    List := TtcMethodList.Create;
    RetrieveTypeInfoMethods(ClassInfo);
    IterateOverAncestors(ClassInfo);

    //QC if List.Count = 0 then
      FillTypInfo;

    FCompiledTable.Put(ClassInfo, List);
  end
  else
    List := TList(FCompiledTable.Get(ClassInfo));

  Size := List.Count;
  GetMem(MethodInfoList, Size * SizeOf(Pointer));
  Move(List.List^, MethodInfoList^, Size * SizeOf(Pointer));
  Result := Size > 0;
end;

function TtcPublicInfoLibrary.RegisterMethod(ClassInfo: Pointer;
  MethodType: TtcMethodType; const MethodName: WideString; RetVal: Pointer;
  const Params: array of Pointer; const Names: array of WideString; MethodProc: TtcMethodProc): Boolean;
var
  List: TtcMethodList;
  MethodInfo: PtcMethodInfo;
  I: Integer;
begin
  Result := False;

  Assert(ClassInfo <> nil);
  if ClassInfo = nil then
    exit;

  if not FTable.ContainsKey(ClassInfo) then
  begin
    List := TtcMethodList.Create;
    FTable.Put(ClassInfo, List);
  end
  else
    List := TtcMethodList(FTable.Get(ClassInfo));

  Assert(List <> nil);
  New(MethodInfo);

  MethodInfo.MethodType := MethodType;
  MethodInfo.MethodName := MethodName;
  MethodInfo.MethodProc := _StdMethod;
  if RetVal <> nil then
    MethodInfo.RetVal := CreateParameter(RetVal, '')
  else
    MethodInfo.RetVal := nil;
  TtcMethodProc(MethodInfo.Cookie) := MethodProc;


  Assert((High(Params) - Low(Params)) = (High(Names) - Low(Names)));
  if (High(Params) = Low(Params)) and (Params[Low(Params)] = nil) then
  begin
    MethodInfo.ParamCount := 0;
    MethodInfo.Params := nil;
  end
  else
  begin
    MethodInfo.ParamCount := High(Params) - Low(Params) + 1;
    GetMem(MethodInfo.Params, MethodInfo.ParamCount * SizeOf(Pointer));

    for I := Low(Params) to High(Params) do
      MethodInfo.Params^[I - Low(Params)] := CreateParameter(Params[I], Names[I]);
  end;

  List.Add(MethodInfo);
  Result := True;
end;

procedure TtcPublicInfoLibrary.ReleaseMethodList(
  MethodList: PtcMethodInfoList);
begin
  FreeMem(MethodList);
end;


{ TtcMethodList }

{$IFDEF DELPHI5}

procedure TtcMethodList.Notify(Ptr: Pointer; Action: TListNotification);
var
  I: Integer;
begin
  inherited;
  if Action = lnDeleted then
  begin
    for I := 0 to PtcMethodInfo(Ptr).ParamCount - 1 do
      Dispose(PtcMethodInfo(Ptr).Params[I]);
    if PtcMethodInfo(Ptr).ParamCount > 0 then
      FreeMem(PtcMethodInfo(Ptr).Params);
    if PtcMethodInfo(Ptr).RetVal <> nil then
      Dispose(PtcMethodInfo(Ptr).RetVal);
    Dispose(PtcMethodInfo(Ptr));
  end;
end;
{$ENDIF DELPHI5}

initialization
  CMD_DISPATCH := RegisterWindowMessage('97A7D25DF77E429F8004E2EA817885F4');
  PublicInfoLibrary := TtcPublicInfoLibrary.Create;
  tc5OpenAppClasses.GetMethodListProc := GetMethodList;
  tc5OpenAppClasses.ReleaseMethodListProc := ReleaseMethodList;

finalization
  FreeAndNil(PublicInfoLibrary);

{$EndIf XE}

end.
