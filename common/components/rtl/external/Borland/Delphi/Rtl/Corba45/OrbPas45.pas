{**********************************************************}
{                                                          }
{            Borland Visibroker for Delphi                 }
{                                                          }
{   Copyright (C) 1999-2001 Borland Software Corporation   }
{                                                          }
{**********************************************************}

unit OrbPas45;

interface

uses 
  Windows, VarUtils, Variants;

type
  ObjectProxy = interface;
  MarshalInBufferProxy = interface;
  MarshalOutBufferProxy = interface;
  ITypeCode = interface;
  IBOA = interface;
  OrbProxy = interface;
  ISkeleton = interface;           // C++ Skeleton Proxy's interface
  ISkeletonObject = interface;     // Skeleton delegation class' interface
  ICorbaObj = interface;

  Any = System.Variant;

  CorbaBoolean = ByteBool;
  CorbaULong = Integer;
  PCorbaAny = type Pointer;
  PCorbaObject = type Pointer;
  PCorbaOrb = type Pointer;
  PCorbaInterfaceDef = type Pointer;
  PMarshalInbuffer = type Pointer;
  PMarshalOutbuffer = type Pointer;
  PUserExceptionProxy = type Pointer;
  PExceptionDescription = type Pointer;
  PObjectProxy = type Pointer;

  TArgv = array of string;

  _RegistrationScope = (Scope_Global, Scope_Local);

  ProxyUser = interface
    ['{B5467DE0-8003-11D2-AAF6-00C04FB16F42}']
    function Proxy: IUnknown;
  end;

  PBindOptions = ^BindOptions;
  BindOptions = record
    defer_bind: ByteBool;
    enable_rebind: ByteBool;
    max_bind_tries: Integer;
    send_timeout: Integer;
    receive_timeout: Integer;
    connection_timeout: Integer;
  end;

  ICorbaObj = interface
    ['{47E946E1-BEA1-11D1-AA8A-00C04FB16F42}']
    function CorbaObject: PCorbaObject; stdcall;
    function Is_Local: CorbaBoolean; stdcall;
  end;

  ISkeleton = interface(ICorbaObj)
    ['{47E946E8-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure GetImplementation(out Impl: IUnknown); stdcall;
    procedure GetReplyBuffer(Cookie: Pointer; out Outbuf: MarshalOutBufferProxy); stdcall;
    procedure GetExceptionReplyBuffer(Cookie: Pointer; out Outbuf: MarshalOutBufferProxy); stdcall;
  end;

  ObjectProxy = interface(ISkeleton)
    ['{47E946E1-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure set_proxy_user(user: IUnknown); stdcall;
    procedure create_request(oper: PChar; response_expected: ByteBool;
      out outbuf: MarshalOutBufferProxy); stdcall;
    procedure invoke(const outbuf: MarshalOutBufferProxy;
      out inbuf: MarshalInBufferProxy); stdcall;
    function get_interface: PCorbaInterfaceDef; stdcall;
    function non_existent: ByteBool; stdcall;
    function hash(maximum: Integer): Integer; stdcall;
    function interface_name: PChar; stdcall;
    function is_a(logical_type_id: PChar): ByteBool; stdcall;
    function is_bound: ByteBool; stdcall;
    function is_equivalent(other_object: ObjectProxy): ByteBool; stdcall;
    function is_persistent: ByteBool; stdcall;
    function object_name: PChar; stdcall;
    function repository_ID: PChar; stdcall;
    procedure prepare_reply(out outbuf: MarshalOutBufferProxy); stdcall;
    function get_bind_options: PBindOptions; stdcall;
    procedure set_bind_options(opt: PBindOptions); stdcall;
  end;

  ISkeletonObject = interface
    ['{47E946E8-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure GetSkeleton(out Skeleton: ISkeleton); stdcall;
    procedure GetImplementation(out Impl: IUnknown); stdcall;
    function Execute(Operation: PChar; const Strm: MarshalInBufferProxy; Cookie: Pointer): CorbaBoolean; stdcall;
  end;

  MarshalInBufferProxy = interface
    ['{47E946E2-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure get_char(out value: Char); stdcall;
    procedure get_unsigned_char(out value: Byte); stdcall;
    procedure get_wchar(out value: WideChar); stdcall;
    procedure get_short(out value: SmallInt); stdcall;
    procedure get_unsigned_short(out value: Word); stdcall;
    procedure get_long(out value: Integer); stdcall;
    procedure get_unsigned_long(out value: Cardinal); stdcall;
    procedure get_long_long(out value: Int64); stdcall;
    procedure get_unsigned_long_long(out value: Int64); stdcall;
    procedure get_float(out value: Single); stdcall;
    procedure get_double(out value: Double); stdcall;
    procedure get_long_double(out value: Extended); stdcall;
    procedure get_char_ptr(value: PChar; size: Integer); stdcall;
    procedure get_unsigned_char_array(const value: array of Byte);
    procedure get_wchar_ptr(value: PWideChar; size: Integer); stdcall;
    procedure get_short_array(const value: array of SmallInt); stdcall;
    procedure get_unsigned_short_array(const value: array of Word); stdcall;
    procedure get_long_array(const value: array of Integer); stdcall;
    procedure get_unsigned_long_array(const value: array of Cardinal); stdcall;
    procedure get_long_long_array(const value: array of Int64); stdcall;
    procedure get_unsigned_long_long_array(const value: array of Int64); stdcall;
    procedure get_float_array(const value: array of Single); stdcall;
    procedure get_double_array(const value: array of Double); stdcall;
    procedure get_long_double_array(const value: array of Extended); stdcall;
    procedure get_object(out value: ObjectProxy); stdcall;
    procedure get_typecode(out value: ITypeCode); stdcall;
    procedure get_any(out value); stdcall;
  end;

  MarshalOutBufferProxy = interface
    ['{47E946E3-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure put_char(value: Char); stdcall;
    procedure put_unsigned_char(value: Byte); stdcall;
    procedure put_wchar(value: WideChar); stdcall;
    procedure put_short(value: SmallInt); stdcall;
    procedure put_unsigned_short(value: Word); stdcall;
    procedure put_long(value: Integer); stdcall;
    procedure put_unsigned_long(value: Cardinal); stdcall;
    procedure put_long_long(value: Int64); stdcall;
    procedure put_unsigned_long_long(value: Int64); stdcall;
    procedure put_float(value: Single); stdcall;
    procedure put_double(value: Double); stdcall;
    procedure put_long_double(value: Extended); stdcall;
    procedure put_char_ptr(value: PChar; size: Integer); stdcall;
    procedure put_char_array(const value: array of Char);
    procedure put_unsigned_char_array(const value: array of Byte);
    procedure put_wchar_ptr(value: PWideChar; size: Integer); stdcall;
    procedure put_wchar_array(const value: array of WideChar);
    procedure put_short_array(const value: array of SmallInt); stdcall;
    procedure put_unsigned_short_array(const value: array of Word); stdcall;
    procedure put_long_array(const value: array of Integer); stdcall;
    procedure put_unsigned_long_array(const value: array of Cardinal); stdcall;
    procedure put_long_long_array(const value: array of Int64); stdcall;
    procedure put_unsigned_long_long_array(const value: array of Int64); stdcall;
    procedure put_float_array(const value: array of Single); stdcall;
    procedure put_double_array(const value: array of Double); stdcall;
    procedure put_long_double_array(const value: array of Extended); stdcall;
    procedure put_object(const value: ObjectProxy); stdcall;
    procedure put_typecode(const value: ITypeCode); stdcall;
    procedure put_any(value: Pointer); stdcall;
    procedure CreateInputStream(var value : Pointer); stdcall;
  end;

  PCallDesc = ^TCallDesc;
  TCallDesc = packed record
    CallType: Byte;
    ArgCount: Byte;
    NamedArgCount: Byte;
    ArgTypes: array[0..255] of Byte;
  end;

  ITypeCode = interface
    ['{D3D381F7-D944-11D1-AAEC-00C04FB17A72}']
    function Kind: Integer; stdcall;
    procedure ContentType(out tc: ITypeCode); stdcall;
    function DefaultIndex: Integer; stdcall;
    procedure DiscriminatorType(out tc: ITypeCode); stdcall;
    function Equal(const tc: ITypeCode): ByteBool; stdcall;
    function Id: PChar; stdcall;
    function Length: Integer; stdcall;
    function MemberCount: Integer; stdcall;
    function MemberLabel(index: Integer): Pointer; stdcall;
    function MemberName(index: Integer): PChar; stdcall;
    procedure MemberType(index: Integer; out tc: ITypeCode); stdcall;
    function Name: PChar; stdcall;
    function Parameter(index: Integer): Pointer; stdcall;
    function ParameterCount: Integer; stdcall;
  end;

  IBOA = interface
    ['{47E946E6-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure ObjIsReady(const Proxy: PCorbaObject); stdcall;
    procedure ImplIsReady; stdcall;
    procedure Deactivate(const Proxy: PCorbaObject); stdcall;
    function GetPrincipalLength(const Proxy: PCorbaObject): CorbaULong; stdcall;
    procedure GetPrincipal(const Proxy: PCorbaObject; out ByteBuf);
    procedure SetScope(const Val : _RegistrationScope); stdcall;
    function GetScope : _RegistrationScope; stdcall;
    procedure ExitImplReady; stdcall;
  end;

  IPOA = interface
    ['{47E946EB-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure ActivateObject(ObjectID : PChar; const Proxy : PCorbaObject); stdcall;
  end;

  TStructMember = record
    Name: string;
    TC: ITypeCode;
  end;

  TStructMembers = array of TStructMember;

  TUnionMember = record
    Member_Name : string;
    Member_Label : Any;
    Member_TC : ITypeCode;
  end;

  TUnionMembers = array of TUnionMember;

  ORBProxy = interface
    ['{47E946E7-BEA1-11D1-AA8A-00C04FB16F42}']
    procedure boa_init(argc: Integer; const argv: TArgv; out boa: IBOA); stdcall;
    procedure poa_init(out IPOA); stdcall;
    procedure bind(rep_id, instance_id, host_name: PChar; opt: PBindOptions;
      out obj: ObjectProxy); stdcall;
    function object_to_string(const obj: ObjectProxy): PChar; stdcall;
    procedure string_to_object(str: PChar; out obj: ObjectProxy); stdcall;
    procedure shutdown; stdcall;
    procedure resolve_initial_references(str : PChar; out obj : ObjectProxy); stdcall;
    procedure create_marshaloutbuffer(out result: MarshalOutBufferProxy); stdcall;
    {TypeCode support for Anys}
    procedure CreateTC(Kind: integer; out TC: ITypeCode); stdcall;
    procedure CreateArrayTC(Bound: CorbaULong; const TC: ITypeCode;
      out Result: ITypeCode); stdcall;
    procedure CreateSequenceTC(Bound: CorbaULong; const TC: ITypeCode;
      out Result: ITypeCode); stdcall;
    procedure CreateAliasTC(RepID: PChar; TypeName: PChar; const TC: ITypeCode;
      out Result: ITypeCode); stdcall;
    procedure CreateStructTC(RepId, Name: PChar; Members: TStructMembers;
      nMember: Integer; out Result: ITypeCode); stdcall;
    procedure CreateObjRefTC(RepId, Name: PChar; out Result: ITypeCode); stdcall;
    procedure create_enum_tc(rep_id, type_name: PChar; const members: array of string;
      out result: ITypeCode); stdcall;
    procedure create_exception_tc(rep_id, type_name: PChar; const members: MarshalOutBufferProxy;
      out result: ITypeCode); stdcall;
    procedure create_interface_tc(rep_id, interface_name: PChar; out result: ITypeCode); stdcall;
    procedure create_union_tc(rep_id, type_name: PChar; descriminator_type: ITypeCode;
      const members: TUnionMembers; nMember : Integer; out result: ITypeCode); stdcall;
    procedure create_string_tc(bound: Integer; out result: ITypeCode); stdcall;
    procedure create_wstring_tc(bound: Integer; out result: ITypeCode); stdcall;
    procedure create_recursive_sequence_tc(bound, offset: Integer; out result: ITypeCode); stdcall;
    function MakeAnyObjRef(const TC: ITypeCode; const value: ObjectProxy): PCorbaAny; stdcall;
    procedure Get_Any(Value : PCorbaAny; out inbuf: MarshalInBufferProxy) stdcall;
    function GetAnyObjRef(var Value: Variant) : ObjectProxy; stdcall;
    procedure Put_Any(var A : PCorbaAny; const tc : ITypeCode;
      const outbuf: MarshalOutBufferProxy); stdcall;
  end;


type
  TCopyUserExceptionProc = procedure (const InBuf: MarshalInBufferProxy) of object; register;
  TThrowUserExceptionProc = procedure of object; register;
  TUserExceptionFactoryProc = function : PUserExceptionProxy; cdecl;

function InitORB(const CommandLine: TArgv): ORBProxy;
procedure CorbaStringFree(Str: PChar);
procedure CorbaWStringFree(Str: PWideChar);
function CorbaDuplicateAny(Any: PCorbaAny): PCorbaAny;
procedure CorbaReleaseAny(Any: PCorbaAny);
procedure CorbaAnyType(Any: PCorbaAny; out TypeCode: ITypeCode);
function VariantToAny(Value: PVariant): PCorbaAny;
function AnyToVariant(Value: PCorbaAny; OV: PVariant): Boolean;
function SequenceToVariant(Value: PCorbaAny; OV: PVariant): Boolean;
function CreateUserException(copy: TCopyUserExceptionProc;
  throw: TThrowUserExceptionProc): PUserExceptionProxy;
function RegisterUserException(Name, RepositoryID: PChar;
  Factory: TUserExceptionFactoryProc): PExceptionDescription;
procedure UnRegisterUserException(Description: PExceptionDescription);
procedure DelphiVariantToObject(Value : PVariant; var obj: ObjectProxy);
procedure CreateSkeletonProxy(InterfaceName : PChar; const Skeleton : ISkeletonObject;
  InstanceName, RepositoryID : PChar; out Proxy : ObjectProxy);

implementation

uses Sysutils, CorbCnst;

var
  OrbDll: THandle = 0;

type
  TInitOrbProc = procedure(argc: Integer; const argv: TArgv; out ORB: ORBProxy); stdcall;
  TCorbaStringFreeProc = procedure(Str: PChar); stdcall;
  TCorbaWStringFreeProc = procedure(Str: PWideChar); stdcall;
  TCorbaDuplicateAnyProc = function(Value: PCorbaAny): PCorbaAny; stdcall;
  TCorbaReleaseAnyProc = procedure(Value: PCorbaAny); stdcall;
  TCorbaAnyTypeProc = procedure (Any: PCorbaAny; out TypeCode: ITypeCode); stdcall;
  TVariantToAnyProc = function(Value: PVariant): PCorbaAny; stdcall;
  TAnyToVariantProc = function(Value: PCorbaAny; OV: PVariant): WordBool; stdcall;
  TPascalClearVariantProc = procedure (var V: Variant); stdcall;
  TPascalChangeTypeProc = function (var Dest, Source: Variant; VTCode: Integer): WordBool; stdcall;
  TInitAnyCallbacks = procedure (pcv: TPascalClearVariantProc; pct: TPascalChangeTypeProc); stdcall;
  TCreateUserExceptionProc = function (copy: TCopyUserExceptionProc;
    throw: TThrowUserExceptionProc): PUserExceptionProxy; stdcall;
  TRegisterUserExceptionProc = function (Name, RepositoryID: PChar;
    Factory: TUserExceptionFactoryProc): PExceptionDescription; stdcall;
  TUnRegisterUserExceptionProc = procedure (Description: PExceptionDescription); stdcall;
  TDelphiVariantToObjectProc = procedure(Value : PVariant; out obj: ObjectProxy); stdcall;
  TCreateSkeletonProxyProc = procedure(InterfaceName : PChar; const Skeleton : ISkeletonObject;
    InstanceName, RepositoryID : PChar; out obj : ObjectProxy); stdcall;

var
  InitOrbProc: TInitOrbProc;
  CorbaStringFreeProc: TCorbaStringFreeProc;
  CorbaWStringFreeProc: TCorbaWStringFreeProc;
  CorbaReleaseAnyProc: TCorbaReleaseAnyProc;
  CorbaAnyTypeProc: TCorbaAnyTypeProc;
  CorbaDuplicateAnyProc: TCorbaDuplicateAnyProc;
  VariantToAnyProc: TVariantToAnyProc;
  AnyToVariantProc: TAnyToVariantProc;
  SequenceToVariantProc: TAnyToVariantProc;
  CreateUserExceptionProc: TCreateUserExceptionProc;
  RegisterUserExceptionProc: TRegisterUserExceptionProc;
  UnRegisterUserExceptionProc: TUnRegisterUserExceptionProc;
  DelphiVariantToObjectProc : TDelphiVariantToObjectProc;
  CreateSkeletonProxyProc : TCreateSkeletonProxyProc;

procedure PascalClearVariantImpl(var V: Variant); stdcall;
begin
  V := Unassigned;
end;

function PascalChangeTypeImpl(var Dest, Source: Variant; VTCode: Integer): WordBool; stdcall;
begin
  Result := True;
  try
    Dest := VarAsType(Source, VTCode);
  except
    Result := False;
  end;
end;

procedure LoadOrbProcs;
const
  orbpas = 'orbpas45.dll';
var
  InitAnyCallbacks: TInitAnyCallbacks;
begin
  if OrbDll <> 0 then Exit;
  OrbDll := LoadLibrary(PChar(orbpas));
  if OrbDll = 0 then
    raise Exception.CreateFmt('%s: %s', [SysErrorMessage(GetLastError), orbpas]);

  @InitORBProc := GetProcAddress(OrbDll, 'orb_init');

  @CorbaStringFreeProc := GetProcAddress(OrbDll, 'String_Free');
  @CorbaWStringFreeProc := GetProcAddress(OrbDll, 'WString_Free');
  @CorbaDuplicateAnyProc := GetProcAddress(OrbDll, 'DuplicateAny');
  @CorbaReleaseAnyProc := GetProcAddress(OrbDll, 'ReleaseAny');
  @CorbaAnyTypeProc := GetProcAddress(OrbDll, 'AnyType');
  @VariantToAnyProc := GetProcAddress(OrbDll, 'VariantToAny');
  @AnyToVariantProc := GetProcAddress(OrbDll, 'Any2Variant');
  @SequenceToVariantProc := GetProcAddress(OrbDll, 'Sequence2Variant');
  @InitAnyCallbacks := GetProcAddress(OrbDll, 'InitAnyCallbacks');
  if Assigned(InitAnyCallbacks) then
    InitAnyCallbacks(PascalClearVariantImpl, PascalChangeTypeImpl);

  @CreateUserExceptionProc := GetProcAddress(OrbDll, 'CreateDelphiException');
  @RegisterUserExceptionProc := GetProcAddress(OrbDll, 'RegisterDelphiException');
  @UnRegisterUserExceptionProc := GetProcAddress(OrbDll, 'UnRegisterDelphiException');
  @DelphiVariantToObjectProc := GetProcAddress(OrbDll, 'DelphiVarToObject');
  @CreateSkeletonProxyProc := GetProcAddress(OrbDll, 'CreateSkeletonProxy');
end;

procedure ValidateProc(var Proc);
begin
  if Pointer(Proc) = nil then
     raise Exception.Create(sCorbaNotInitialized);
end;

function InitORB(const CommandLine: TArgv): ORBProxy;
begin
  LoadOrbProcs;
  ValidateProc(InitORBProc);
  InitORBProc(Length(CommandLine), CommandLine, Result);
end;

procedure CreateSkeletonProxy(InterfaceName : PChar; const Skeleton : ISkeletonObject;
  InstanceName, RepositoryID : PChar; out Proxy : ObjectProxy);
begin
  ValidateProc(CreateSkeletonProxyProc);
  CreateSkeletonProxyProc(InterfaceName, Skeleton, InstanceName, RepositoryID, Proxy);
end;

procedure CorbaStringFree(Str: PChar);
begin
  ValidateProc(CorbaStringFreeProc);
  CorbaStringFreeProc(Str);
end;

procedure CorbaWStringFree(Str: PWideChar);
begin
  ValidateProc(CorbaWStringFreeProc);
  CorbaWStringFreeProc(Str);
end;

function CorbaDuplicateAny(Any: PCorbaAny): PCorbaAny;
begin
  ValidateProc(CorbaDuplicateAnyProc);
  Result := CorbaDuplicateAnyProc(Any);
end;

procedure CorbaReleaseAny(Any: PCorbaAny);
begin
  ValidateProc(CorbaReleaseAnyProc);
  CorbaReleaseAnyProc(Any);
end;

procedure CorbaAnyType(Any: PCorbaAny; out TypeCode: ITypeCode);
begin
  ValidateProc(CorbaAnyTypeProc);
  CorbaAnyTypeProc(Any, TypeCode);
end;

function VariantToAny(Value: PVariant): PCorbaAny;
begin
  ValidateProc(VariantToAnyProc);
  Result := VariantToAnyProc(Value);
end;

function AnyToVariant(Value: PCorbaAny; OV: PVariant): Boolean;
begin
  ValidateProc(AnyToVariantProc);
  Result := AnyToVariantProc(Value, OV);
end;

function SequenceToVariant(Value: PCorbaAny; OV: PVariant): Boolean;
begin
  ValidateProc(SequenceToVariantProc);
  Result := SequenceToVariantProc(Value, OV);
end;

function CreateUserException(copy: TCopyUserExceptionProc; throw: TThrowUserExceptionProc): PUserExceptionProxy;
begin
  ValidateProc(CreateUserExceptionProc);
  Result := CreateUserExceptionProc(copy, throw);
end;

function RegisterUserException(Name, RepositoryID: PChar; Factory: TUserExceptionFactoryProc): PExceptionDescription;
begin
  ValidateProc(RegisterUserExceptionProc);
  Result := RegisterUserExceptionProc(Name, RepositoryID, Factory);
end;

procedure UnRegisterUserException(Description: PExceptionDescription);
begin
  ValidateProc(UnRegisterUserExceptionProc);
  UnRegisterUserExceptionProc(Description);
end;

procedure DelphiVariantToObject(Value : PVariant; var obj: ObjectProxy);
begin
  ValidateProc(DelphiVariantToObjectProc);
  DelphiVariantToObjectProc(Value, obj);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Corba45\OrbPas45.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Corba45\OrbPas45.pas initialization leave'); {$EndIf}
end.
