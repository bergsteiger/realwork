{**********************************************************}
{                                                          }
{            Borland Visibroker for Delphi                 }
{                                                          }
{   Copyright (C) 1999-2001 Borland Software Corporation   }
{                                                          }
{**********************************************************}

unit Corba;


interface

uses 
  SysUtils, OrbPas40, Classes, VarUtils, Variants;

type
  _Object = System.IUnknown;
  Any = System.Variant;
  TypeCode = ORBPAS40.ITypeCode;
  TCommandLine = ORBPAS40.TArgv;
  StructMemberSeq = ORBPAS40.TStructMembers;
  UnionMemberSeq = ORBPAS40.TUnionMembers;
  RegistrationScope = ORBPAS40._RegistrationScope;


  PExceptionProxy = ORBPAS40.PUserExceptionProxy;
  PExceptionDescription = ORBPAS40.PExceptionDescription;

  InputStream = interface;
  OutputStream = interface;
  Principal = class;

  TCorbaThreadModel = (tmMultiThreaded, tmSingleThread);

  CompletionStatus = (COMPLETED_YES, COMPLETED_NO, COMPLETED_MAYBE);

  TCKind = (tk_null, tk_void, tk_short, tk_long, tk_ushort, tk_ulong, tk_float,
    tk_double, tk_boolean, tk_char, tk_octet, tk_any, tk_TypeCode, tk_Principal,
    tk_objref, tk_struct, tk_union, tk_enum, tk_string, tk_sequence, tk_array,
    tk_alias, tk_except, tk_longlong, tk_ulonglong, tk_longdouble, tk_wchar,
    tk_wstring, tk_fixed{not supported in Delphi});

  TAnyHelper = class
  public
    class function TypeCode(const A: Any): TypeCode;
  end;


  SystemException = class(Exception)
  private
    FMinor: Integer;
    FCompleted: CompletionStatus;
  public
    constructor Create(Minor: Integer = 0; Completed: CompletionStatus = COMPLETED_NO);
    property Minor: Integer read FMinor write FMinor;
    property Completed: CompletionStatus read FCompleted write FCompleted;
  end;

  ECorbaDispatch = class(Exception);

  UNKNOWN = class(SystemException)
  end;

  BAD_PARAM = class(SystemException)
  end;

  NO_MEMORY = class(SystemException)
  end;

  IMP_LIMIT = class(SystemException)
  end;

  COMM_FAILURE = class(SystemException)
  end;

  INV_OBJREF = class(SystemException)
  end;

  NO_PERMISSION = class(SystemException)
  end;

  INTERNAL = class(SystemException)
  end;

  MARSHAL = class(SystemException)
  end;

  INITIALIZE = class(SystemException)
  end;

  NO_IMPLEMENT = class(SystemException)
  end;

  BAD_TYPECODE = class(SystemException)
  end;

  BAD_OPERATION = class(SystemException)
  end;

  NO_RESOURCES = class(SystemException)
  end;

  NO_RESPONSE = class(SystemException)
  end;

  PERSIST_STORE = class(SystemException)
  end;

  BAD_INV_ORDER = class(SystemException)
  end;

  TRANSIENT = class(SystemException)
  end;

  FREE_MEM = class(SystemException)
  end;

  INV_IDENT = class(SystemException)
  end;

  INV_FLAG = class(SystemException)
  end;

  INTF_REPOS = class(SystemException)
  end;

  BAD_CONTEXT = class(SystemException)
  end;

  OBJ_ADAPTER = class(SystemException)
  end;

  DATA_CONVERSION = class(SystemException)
  end;

  OBJECT_NOT_EXIST = class(SystemException)
  end;

  UserException = class(Exception)
  protected
    FProxy: PExceptionProxy;
    procedure _Copy(const InBuf: ORBPAS40.MarshalInBufferProxy);
  public
    constructor Create;
    procedure Copy(const Input: InputStream); virtual; abstract;
    procedure WriteExceptionInfo(var Output : OutputStream); virtual; abstract;
    procedure Throw;
    property Proxy: PExceptionProxy read FProxy;
  end;

  BindOptions = record
    DeferBind: Boolean;
    EnableRebind: Boolean;
    MaxBindTries: Integer;
    SendTimeOut: Cardinal;
    ReceiveTimeOut: Cardinal;
    ConnectionTimeOut: Cardinal;
  end;

  CORBAObject = interface
    ['{B5467DDF-8003-11D2-AAF6-00C04FB16F42}']
    function _Clone: CORBAObject;
    procedure _CreateRequest(const Operation: string; ResponseExpected: Boolean; out Output: OutputStream);
    function _GetBindOptions: BindOptions;
    function _GetInterface: PCorbaInterfaceDef;
    function _Hash(Maximum: Cardinal): Cardinal;
    function _InterfaceName: string;
    procedure _Invoke(const Output: OutputStream; out Input: InputStream);
    function _IsA(const LogicalTypeId: string): Boolean;
    function _IsBound: Boolean;
    function _IsEquivalent(const OtherObject: CORBAObject): Boolean;
    function _IsLocal: Boolean;
    function _IsPersistent: Boolean;
    function _IsRemote: Boolean;
    function _NonExistent: Boolean;
    function _ObjectName: string;
    procedure _PrepareReply(out Output: OutputStream);
    function _RepositoryId: string;
    procedure _SetBindOptions(const Options: BindOptions);
    property _BindOptions: BindOptions read _GetBindOptions write _SetBindOptions;
  end;

  TCORBAObject = class(TInterfacedObject, CORBAObject, ProxyUser, ISkeletonObject)
  protected
    FProxy: ORBPAS40.ObjectProxy;
    function Proxy: IUnknown;
    constructor Create(const Proxy: ORBPAS40.ObjectProxy); overload;
    constructor Create(const Obj: CORBAObject); overload;
    constructor CreateSkeleton(const InstanceName, InterfaceName,
      RepositoryId: string);
    procedure GetSkeleton(out Skeleton: ISkeleton); stdcall;
    procedure GetImplementation(out Impl: IUnknown); stdcall;
    function Execute(Operation: PChar; const Strm: MarshalInBufferProxy; Cookie: Pointer): CorbaBoolean; stdcall;
    function _is_a(LogicalTypeId: PChar): ByteBool; stdcall;
    procedure GetReplyBuffer(Cookie : Pointer; out Outbuf: OutputStream);
    procedure GetExceptionReplyBuffer(Cookie : Pointer; out Outbuf: OutputStream);
  public
    function _GetInterface: PCorbaInterfaceDef;
    function _IsA(const LogicalTypeId: string): Boolean;
    function _NonExistent: Boolean;
    function _IsEquivalent(const OtherObject: CORBAObject): Boolean;
    function _Hash(Maximum: Cardinal): Cardinal;
    function _IsLocal: Boolean;
    function _IsRemote: Boolean;
    function _IsBound: Boolean;
    function _IsPersistent: Boolean;
    function _Clone: CORBAObject;
    procedure _CreateRequest(const Operation: string; ResponseExpected: Boolean; out Output: OutputStream);
    procedure _Invoke(const Output: OutputStream; out Input: InputStream);
    procedure _SetBindOptions(const Options: BindOptions);
    function _GetBindOptions: BindOptions;
    function _RepositoryId: string;
    function _ObjectName: string;
    function _InterfaceName: string;
    procedure _PrepareReply(out Output: OutputStream);
    destructor Destroy; override;
    property _BindOptions: BindOptions read _GetBindOptions write _SetBindOptions;
  end;

  InputStream = interface
    procedure ReadBoolean(out Value: Boolean);
    procedure ReadChar(out Value: Char);
    procedure ReadWChar(out Value: WideChar);
    procedure ReadOctet(out Value: Byte);
    procedure ReadShort(out Value: SmallInt);
    procedure ReadUShort(out Value: Word);
    procedure ReadLong(out Value: Integer);
    procedure ReadULong(out Value: Cardinal);
    procedure ReadLongLong(out Value: Int64);
    procedure ReadULongLong(out Value: Int64);
    procedure ReadFloat(out Value: Single);
    procedure ReadDouble(out Value: Double);
    procedure ReadLongDouble(out Value: Extended);
    procedure ReadString(out Value: string);
    procedure ReadWString(out Value: WideString);
    procedure ReadBooleanArray(out Value: array of Boolean);
    procedure ReadCharArray(out Value: array of Char);
    procedure ReadWCharArray(out Value: array of WideChar);
    procedure ReadOctetArray(out Value: array of Byte);
    procedure ReadShortArray(out Value: array of SmallInt);
    procedure ReadUShortArray(out Value: array of Word);
    procedure ReadLongArray(out Value: array of Integer);
    procedure ReadULongArray(out Value: array of Cardinal);
    procedure ReadLongLongArray(out Value: array of Int64);
    procedure ReadULongLongArray(out Value: array of Int64);
    procedure ReadFloatArray(out Value: array of Single);
    procedure ReadDoubleArray(out Value: array of Double);
    procedure ReadLongDoubleArray(out Value: array of Extended);
    procedure ReadObject(out Value: CORBAObject);
    procedure ReadTypeCode(out Value: TypeCode);
    procedure ReadAny(out Value: Any);
    procedure ReadPrincipal(out Value : Principal);  //dummy method
  end;

  OutputStream = interface
    function CreateInputStream: InputStream;
    procedure WriteBoolean(Value: Boolean);
    procedure WriteChar(Value: Char);
    procedure WriteWChar(Value: WideChar);
    procedure WriteOctet(Value: Byte);
    procedure WriteShort(Value: SmallInt);
    procedure WriteUShort(Value: Word);
    procedure WriteLong(Value: Integer);
    procedure WriteULong(Value: Cardinal);
    procedure WriteLongLong(Value: Int64);
    procedure WriteULongLong(Value: Int64);
    procedure WriteFloat(Value: Single);
    procedure WriteDouble(Value: Double);
    procedure WriteLongDouble(Value: Extended);
    procedure WriteString(const Value: string);
    procedure WriteWString(const Value: WideString);
    procedure WriteBooleanArray(const Value: array of Boolean);
    procedure WriteCharArray(const Value: array of Char);
    procedure WriteWCharArray(const Value: array of WideChar);
    procedure WriteOctetArray(const Value: array of Byte);
    procedure WriteShortArray(const Value: array of SmallInt);
    procedure WriteUShortArray(const Value: array of Word);
    procedure WriteLongArray(const Value: array of Integer);
    procedure WriteULongArray(const Value: array of Cardinal);
    procedure WriteLongLongArray(const Value: array of Int64);
    procedure WriteULongLongArray(const Value: array of Int64);
    procedure WriteFloatArray(const Value: array of Single);
    procedure WriteDoubleArray(const Value: array of Double);
    procedure WriteLongDoubleArray(const Value: array of Extended);
    procedure WriteObject(const Value: CORBAObject);
    procedure WriteTypeCode(const Value: TypeCode);
    procedure WriteAny(const Value: Any);
    procedure WritePrincipal(const Value : Principal);  //dummy method
  end;

  Identifier = string;

  TIdentifierHelper = class
    class procedure Insert(var A: Any; const Value: Identifier);
    class function Extract(const A: Any): Identifier;
    class function TypeCode: TypeCode;
    class function RepositoryId: string;
    class function Read(const Input: InputStream): Identifier;
    class procedure Write(const Output: OutputStream; const Value: Identifier);
  end;

  RepositoryId = string;

  ScopedName = string;

  DefinitionKind  = (dk_none, dk_all,	dk_Attribute, dk_Constant, dk_Exception,
    dk_Interface, dk_Module, dk_Operation, dk_Typedef, dk_Alias, dk_Struct,
    dk_Union, dk_Enum, dk_Primitive, dk_String, dk_Sequence, dk_Array,
    dk_Repository, dk_Wstring);

  TDefinitionKindHelper = class
    class procedure Insert(var A: Any; const Value: DefinitionKind);
    class function Extract(const A: Any): DefinitionKind;
    class function TypeCode: TypeCode;
    class function RepositoryId: string;
    class function Read(const Input: InputStream): DefinitionKind;
    class procedure Write(const Output: OutputStream; const Value: DefinitionKind);
  end;

  IRObject = interface
    ['{E190D1E3-A996-11D2-AB01-00C04FB16F42}']
    function _get_def_kind: DefinitionKind;
    function _get_comment: string;
    procedure _set_comment(const Value: string);
    function _get_file_name: string;
    procedure _set_file_name(const Value: string);
    procedure destroy;
    property def_kind: DefinitionKind read _get_def_kind;
    property comment: string read _get_comment write _set_comment;
    property file_name: string read _get_file_name write _set_file_name;
  end;

  TIRObjectHelper = class
    class procedure Insert(var A: Any; const Value: IRObject);
    class function Extract(var A: Any): IRObject;
    class function TypeCode: TypeCode;
    class function RepositoryId: string;
    class function Read(const Input: InputStream): IRObject;
    class procedure Write(const Output: OutputStream; const Value: IRObject);
    class function Narrow(const Obj: CORBAObject; IsA: Boolean = False): IRObject;
    class function Bind(const InstanceName: string = ''; HostName: string = ''): IRObject;
  end;

  TIRObjectStub = class(TCORBAObject, IRObject)
  public
    function _get_def_kind: DefinitionKind; virtual;
    function _get_comment: string; virtual;
    procedure _set_comment(const Value: string); virtual;
    function _get_file_name: string;  virtual;
    procedure _set_file_name(const Value: string); virtual;
    procedure destroy; virtual;
    property def_kind: DefinitionKind read _get_def_kind;
    property comment: string read _get_comment write _set_comment;
    property file_name: string read _get_file_name write _set_file_name;
  end;

  IDLType = interface(IRObject)
    ['{E190D1E4-A996-11D2-AB01-00C04FB16F42}']
    function _get_type: TypeCode;
    property _type: TypeCode read _get_type;
  end;

  TIDLTypeHelper = class
    class procedure Insert(var A: Any; const Value: IDLType);
    class function Extract(var A: Any): IDLType;
    class function TypeCode: TypeCode;
    class function RepositoryId: string;
    class function Read(const Input: InputStream): IDLType;
    class procedure Write(const Output: OutputStream; const Value: IDLType);
    class function Narrow(const Obj: CORBAObject; IsA: Boolean = False): IDLType;
    class function Bind(const InstanceName: string = ''; HostName: string = ''): IDLType;
  end;

  TIDLTypeStub = class(TIRObjectStub, IDLType)
  public
    function _get_type: TypeCode; virtual;
    property _type: TypeCode read _get_type;
  end;

  TBOA = class
  private
    BOA: IBOA;
  public
    class procedure Initialize(const CommandLine: TCommandLine = nil);
    destructor Destroy; override;
    procedure ObjIsReady(const Obj: _Object);
    procedure ImplIsReady;
    procedure Deactivate(const Obj: _Object);
    function GetPrincipalLength(const Proxy: PCorbaObject): CorbaULong; stdcall;
    procedure GetPrincipal(const Proxy: PCorbaObject; out ByteBuf);
    procedure SetScope(const Val : RegistrationScope); stdcall;
    function GetScope : RegistrationScope; stdcall;
    procedure ExitImplReady; stdcall;
  end;

  TPOA = class
  private
    POA: IPOA;
  public
    class procedure Initialize;
    destructor Destroy; override;
    procedure ActivateObject(const ObjectID : string; const Obj: _Object);
  end;

  TORB = class(TInterfacedObject, ProxyUser)
  private
    FProxy: ORBProxy;
    function Proxy: IUnknown;
    function MakeComplexAny(TypeCode: ITypeCode; const Elements: array of Any): Any;
  public
    class procedure Init(const CommandLine: TCommandLine); overload;
    class procedure Init; overload;
    destructor Destroy; override;

    { binding methods }
    function Bind(const RepositoryID: string; const ObjectName: string = '';
			const HostName: string = ''): CORBAObject; overload;
    function Bind(const RepositoryID: string; const Options: BindOptions;
      const ObjectName: string = ''; const HostName: string = ''): CORBAObject; overload;

    function ObjectToString(const Obj: CORBAObject): string;
    function StringToObject(const ObjectString: string): CORBAObject;
    function ResolveInitialReferences(const ObjectName : String) : CORBAObject;

    { utility methods }
    procedure Shutdown;
    function CreateOutputStream: OutputStream;

    { TypeCode methods }
    function CreateTC(Kind: integer): TypeCode;
    function CreateStructTC(const RepositoryID, TypeName: string;
      const Members: StructMemberSeq): TypeCode;
    function CreateUnionTC(const RepositoryID, TypeName: string;
      const DiscriminatorType: TypeCode;
      const Members: UnionMemberSeq): TypeCode;
    function CreateEnumTC(const RepositoryID, TypeName: string;
      const Members: array of string): TypeCode;
    function CreateAliasTC(const RepositoryId, TypeName: string;
      const OrginalType: TypeCode): TypeCode;
    function CreateExceptionTC(const RepositoryId, TypeName: string;
      const Members: StructMemberSeq): TypeCode;
    function CreateInterfaceTC(const RepositoryId, TypeName: string): TypeCode;
    function CreateStringTC(Length: Integer): TypeCode;
    function CreateWStringTC(Length: Integer): TypeCode;
    function CreateSequenceTC(Length: Integer; const ElementType: TypeCode): TypeCode;
    function CreateRecursiveSequenceTC(Length, Offset: Integer): TypeCode;
    function CreateArrayTC(Length: Integer; const ElementType: TypeCode): TypeCode;

    { Dynamic invocation methods }
    function MakeArray(Kind: TCKind; const Elements: array of Any): Any; overload;
    function MakeArray(TypeCode: ITypeCode; const Elements: array of Any): Any; overload;
    function MakeSequence(Kind: TCKind; const Elements: array of Any): Any; overload;
    function MakeSequence(TypeCode: ITypeCode; const Elements: array of Any): Any; overload;
    function MakeStructure(TypeCode: ITypeCode; const Elements: array of Any): Any;
    function MakeAlias(const RepositoryID, TypeName: string; Value, Test: Any): Any;

    function MakeTypeCode(Kind: TCKind): ITypeCode;
    function MakeSequenceTypeCode(Bound: CorbaULong; const TC: ITypeCode): ITypeCode;
    function MakeStructureTypeCode(const RepositoryID, Name: string; Members: TStructMembers): ITypeCode;

    function MakeAliasTypeCode(const RepositoryID, Name: string; const TC: ITypeCode): ITypeCode;
    function MakeObjectRefTypeCode(const RepositoryID, Name: string): ITypeCode;
    function MakeObjectRef(tc : ITypeCode; const Obj: CorbaObject) : Any;
    procedure GetAny(Value : Any; out Input: InputStream);
    function GetObjectRef(var A : Any) : CORBAObject;
    procedure PutAny(var A : Any; const tc : ITypeCode; const Output : OutputStream);
  end;

  TCorbaListManager = class
  private
    FSync: TMultiReadExclusiveWriteSynchronizer;
  protected
    procedure BeginRead;
    procedure BeginWrite;
    procedure EndRead;
    procedure EndWrite;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TInterfaceIDEntry = record
    RepositoryID: string;
    IID: TGUID;
  end;

  TInterfaceIDManager = class(TCorbaListManager)
  private
    FList: array of TInterfaceIDEntry;
    FUsed: Integer;
  public
    procedure RegisterInterface(const IID: TGUID; const RepositoryID: string);
    function FindIID(const RepositoryID: string; out IID: TGUID): Boolean;
    function FindRepositoryID(const IID: TGUID; out RepositoryID: string): Boolean;
    procedure GetInterfaceList(var stList : TStringList);
  end;

  //This class is depreciated by Corba 2.2
  Principal = class
  public
    procedure name;
  end;


  { CORBA helper routines }

  procedure CorbaInitialize;
  function BOA: TBOA;
  function ORB: TORB;
  function POA: TPOA;

  function RegisterUserException(const Name, RepositoryID: String;
    Factory: TUserExceptionFactoryProc): PExceptionDescription; forward;
  procedure UnRegisterUserException(Description: PExceptionDescription); forward;


  { Global variables }

var
  InterfaceIDManager: TInterfaceIDManager;

implementation

uses Windows, CorbCnst;

type
  TInputStream = class(TInterfacedObject, InputStream, ProxyUser)
  private
    FProxy : ORBPAS40.MarshalInBufferProxy;
    function Proxy: IUnknown;
  public
    procedure ReadBoolean(out Value: Boolean);
    procedure ReadChar(out Value: Char);
    procedure ReadWChar(out Value: WideChar);
    procedure ReadOctet(out Value: Byte);
    procedure ReadShort(out Value: SmallInt);
    procedure ReadUShort(out Value: Word);
    procedure ReadLong(out Value: Integer);
    procedure ReadULong(out Value: Cardinal);
    procedure ReadLongLong(out Value: Int64);
    procedure ReadULongLong(out Value: Int64);
    procedure ReadFloat(out Value: Single);
    procedure ReadDouble(out Value: Double);
    procedure ReadLongDouble(out Value: Extended);
    procedure ReadString(out Value: string);
    procedure ReadWString(out Value: WideString);
    procedure ReadBooleanArray(out Value: array of Boolean);
    procedure ReadCharArray(out Value: array of Char);
    procedure ReadWCharArray(out Value: array of WideChar);
    procedure ReadOctetArray(out Value: array of Byte);
    procedure ReadShortArray(out Value: array of SmallInt);
    procedure ReadUShortArray(out Value: array of Word);
    procedure ReadLongArray(out Value: array of Integer);
    procedure ReadULongArray(out Value: array of Cardinal);
    procedure ReadLongLongArray(out Value: array of Int64);
    procedure ReadULongLongArray(out Value: array of Int64);
    procedure ReadFloatArray(out Value: array of Single);
    procedure ReadDoubleArray(out Value: array of Double);
    procedure ReadLongDoubleArray(out Value: array of Extended);
    procedure ReadObject(out Value: CORBAObject);
    procedure ReadTypeCode(out Value: TypeCode);
    procedure ReadAny(out Value: Any);
    procedure ReadPrincipal(out Value : Principal);
    constructor Create(Proxy: ORBPAS40.MarshalInBufferProxy);
    destructor Destroy; override;
  end;

  TOutputStream = class(TInterfacedObject, OutputStream, ProxyUser)
  private
    FProxy : ORBPAS40.MarshalOutBufferProxy;
    function Proxy: IUnknown;
  public
    function CreateInputStream: InputStream;
    procedure WriteBoolean(Value: Boolean);
    procedure WriteChar(Value: Char);
    procedure WriteWChar(Value: WideChar);
    procedure WriteOctet(Value: Byte);
    procedure WriteShort(Value: SmallInt);
    procedure WriteUShort(Value: Word);
    procedure WriteLong(Value: Integer);
    procedure WriteULong(Value: Cardinal);
    procedure WriteLongLong(Value: Int64);
    procedure WriteULongLong(Value: Int64);
    procedure WriteFloat(Value: Single);
    procedure WriteDouble(Value: Double);
    procedure WriteLongDouble(Value: Extended);
    procedure WriteString(const Value: string);
    procedure WriteWString(const Value: WideString);
    procedure WriteBooleanArray(const Value: array of Boolean);
    procedure WriteCharArray(const Value: array of Char);
    procedure WriteWCharArray(const Value: array of WideChar);
    procedure WriteOctetArray(const Value: array of Byte);
    procedure WriteShortArray(const Value: array of SmallInt);
    procedure WriteUShortArray(const Value: array of Word);
    procedure WriteLongArray(const Value: array of Integer);
    procedure WriteULongArray(const Value: array of Cardinal);
    procedure WriteLongLongArray(const Value: array of Int64);
    procedure WriteULongLongArray(const Value: array of Int64);
    procedure WriteFloatArray(const Value: array of Single);
    procedure WriteDoubleArray(const Value: array of Double);
    procedure WriteLongDoubleArray(const Value: array of Extended);
    procedure WriteObject(const Value: CORBAObject);
    procedure WriteTypeCode(const Value: TypeCode);
    procedure WriteAny(const Value: Any);
    procedure WritePrincipal(const Value : Principal);
    constructor Create(Proxy: ORBPAS40.MarshalOutBufferProxy);
    destructor Destroy; override;
  end;

var
  BOAVar: TBOA;
  POAVar: TPOA;
  ORBVar: TORB;

procedure CorbaHookDispatch; forward;
procedure CorbaHookExceptions; forward;

procedure PBindOptionsToBindOptions(Source: ORBPAS40.PBindOptions; var Dest: BindOptions);
begin
  Dest.DeferBind := Source.defer_bind;
  Dest.EnableRebind := Source.enable_rebind;
  Dest.MaxBindTries := Source.max_bind_tries;
  Dest.SendTimeOut := Source.send_timeout;
  Dest.ReceiveTimeOut := Source.receive_timeout;
  Dest.ConnectionTimeOut := Source.connection_timeout;
end;

procedure BindOptionsToPBindOptions(const Source: BindOptions; var Dest: ORBPAS40.BindOptions);
begin
  Dest.defer_bind := Source.DeferBind;
  Dest.enable_rebind := Source.EnableRebind;
  Dest.max_bind_tries := Source.MaxBindTries;
  Dest.send_timeout := Source.SendTimeOut;
  Dest.receive_timeout := Source.ReceiveTimeOut;
  Dest.connection_timeout := Source.ConnectionTimeOut;
end;


{ TCORBAObject }

constructor TCORBAObject.Create(const Proxy: ORBPAS40.ObjectProxy);
begin
  FProxy := Proxy;
  FProxy.set_proxy_user(Self);
end;

constructor TCORBAObject.Create(const Obj: CORBAObject);
begin
  with Obj as ProxyUser do
     Create(Proxy as ORBPAS40.ObjectProxy);
end;

constructor TCORBAObject.CreateSkeleton(const InstanceName, InterfaceName, RepositoryId: string);
var Proxy : ORBPAS40.ObjectProxy;
begin
  ORBPAS40.CreateSkeletonProxy(PChar(Pointer(InterfaceName)), Self,
    PChar(Pointer(InstanceName)), PChar(Pointer(RepositoryID)), Proxy);
  Create(Proxy);
end;

destructor TCORBAObject.Destroy;
begin
  try
    FProxy := nil;
  except
    // Ignore exceptions when disconnecting
  end;
  inherited Destroy;
end;

function TCORBAObject.Proxy: IUnknown;
begin
  Result := FProxy;
end;

function TCORBAObject._Clone: CORBAObject;
begin
  Result := Self;
end;

procedure TCORBAObject._CreateRequest(const Operation: string;
  ResponseExpected: Boolean; out Output: OutputStream);
var
  Proxy: ORBPAS40.MarshalOutBufferProxy;
begin
  FProxy.create_request(PChar(Pointer(Operation)), ResponseExpected, Proxy);
  Output := TOutputStream.Create(Proxy);
end;

{ISkeletonObject}

function TCORBAObject.Execute(Operation: PChar; const Strm: MarshalInBufferProxy; Cookie: Pointer): CorbaBoolean;
type
  TUnmarshalProc = procedure (const Input: InputStream; Cookie: Pointer) of object;
var
  M: TUnmarshalProc;
  inBuf : TInputStream;
begin
  Result := False;
  try
    TMethod(M).Code := Self.MethodAddress('_' + Operation);
    if TMethod(M).Code = nil then Exit;
    TMethod(M).Data := Self;
    inBuf := TInputStream.Create(Strm);
    try
      M(inBuf, Cookie);
    finally
      inBuf.free;
    end;
  except
    Exit;
  end;
  Result := True;
end;

procedure TCORBAObject.GetSkeleton(out Skeleton: ISkeleton);
begin
  Skeleton := FProxy as ISkeleton;
end;

procedure TCORBAObject.GetImplementation(out Impl: _Object);
begin
  Impl := nil;
end;

function TCORBAObject._is_a(LogicalTypeId: PChar): ByteBool;
begin
  Result := _ISA(LogicalTypeId);
end;

procedure TCORBAObject.GetReplyBuffer(Cookie : Pointer; out Outbuf: OutputStream);
var
  Proxy: ORBPAS40.MarshalOutBufferProxy;
begin
  (FProxy as ObjectProxy).GetReplyBuffer(Cookie, Proxy);
  Outbuf := TOutputStream.Create(Proxy);
end;

procedure TCORBAObject.GetExceptionReplyBuffer(Cookie : Pointer; out Outbuf: OutputStream);
var
  Proxy: ORBPAS40.MarshalOutBufferProxy;
begin
  (FProxy as ObjectProxy).GetExceptionReplyBuffer(Cookie, Proxy);
  Outbuf := TOutputStream.Create(Proxy);
end;

function TCORBAObject._GetBindOptions: BindOptions;
begin
  PBindOptionsToBindOptions(FProxy.get_bind_options, Result);
end;

function TCORBAObject._GetInterface: PCorbaInterfaceDef;
begin
  Result := FProxy.get_interface;
end;

procedure TCORBAObject._Invoke(const Output: OutputStream; out Input: InputStream);
var
  Proxy: ORBPAS40.MarshalInBufferProxy;
begin
  FProxy.invoke((Output as ProxyUser).Proxy as ORBPAS40.MarshalOutBufferProxy, Proxy);
  Input := TInputStream.Create(Proxy);
end;

function TCORBAObject._IsA(const LogicalTypeId: string): Boolean;
var
  IID: TGUID;
  Obj: _Object;
begin
  Result := False;
  if InterfaceIDManager.FindIID(LogicalTypeId, IID) then
    Result := inherited QueryInterface(IID, Obj) = 0;
  if not Result and _IsRemote then
    Result := FProxy.is_a(PChar(Pointer(LogicalTypeId)));
end;

function TCORBAObject._IsBound: Boolean;
begin
  Result := FProxy.is_bound;
end;

function TCORBAObject._IsEquivalent(const OtherObject: CORBAObject): Boolean;
begin
  Result := FProxy.is_equivalent((OtherObject as ProxyUser).Proxy as ORBPAS40.ObjectProxy);
end;

function TCORBAObject._IsLocal: Boolean;
begin
  Result := FProxy.is_local;
end;

function TCORBAObject._IsPersistent: Boolean;
begin
  Result := FProxy.is_persistent;
end;

function TCORBAObject._IsRemote: Boolean;
begin
  Result := not FProxy.is_local;
end;

function TCORBAObject._Hash(Maximum: Cardinal): Cardinal;
begin
  Result := FProxy.hash(Maximum);
end;

function TCORBAObject._NonExistent: Boolean;
begin
  Result := FProxy.non_existent;
end;

function TCORBAObject._ObjectName: string;
begin
  Result := FProxy.object_name;
end;

function TCORBAObject._InterfaceName: string;
begin
  Result := FProxy.interface_name;
end;

procedure TCORBAObject._PrepareReply(out Output: OutputStream);
var
  Proxy: ORBPAS40.MarshalOutBufferProxy;
begin
  FProxy.prepare_reply(Proxy);
  Output := TOutputStream.Create(Proxy);
end;

function TCORBAObject._RepositoryId: string;
begin
  Result := FProxy.repository_id;
end;

procedure TCORBAObject._SetBindOptions(const Options: BindOptions);
var
  Temp: ORBPAS40.BindOptions;
begin
   BindOptionsToPBindOptions(Options, Temp);
   FProxy.set_bind_options(@Temp);
end;


{ TInputStream }

constructor TInputStream.Create(Proxy: ORBPAS40.MarshalInBufferProxy);
begin
  FProxy := Proxy;
end;

destructor TInputStream.Destroy;
begin
  inherited Destroy;
  FProxy := nil;
end;

function TInputStream.Proxy: IUnknown;
begin
  Result := FProxy;
end;

procedure TInputStream.ReadBoolean(out Value: Boolean);
var
  Temp: Byte;
begin
  FProxy.get_unsigned_char(Temp);
  Value := Temp <> $00;
end;

procedure TInputStream.ReadChar(out Value: Char);
begin
  FProxy.get_char(Value);
end;

procedure TInputStream.ReadWChar(out Value: WideChar);
begin
  FProxy.get_wchar(Value);
end;

procedure TInputStream.ReadOctet(out Value: Byte);
begin
  FProxy.get_unsigned_char(Value);
end;

procedure TInputStream.ReadShort(out Value: SmallInt);
begin
  FProxy.get_short(Value);
end;

procedure TInputStream.ReadUShort(out Value: Word);
begin
  FProxy.get_unsigned_short(Value);
end;

procedure TInputStream.ReadLong(out Value: Integer);
begin
  FProxy.get_long(Value);
end;

procedure TInputStream.ReadULong(out Value: Cardinal);
begin
  FProxy.get_unsigned_long(Value);
end;

procedure TInputStream.ReadLongLong(out Value: Int64);
begin
  FProxy.get_long_long(Value);
end;

procedure TInputStream.ReadULongLong(out Value: Int64);
begin
  FProxy.get_unsigned_long_long(Value);
end;

procedure TInputStream.ReadFloat(out Value: Single);
begin
  FProxy.get_float(Value);
end;

procedure TInputStream.ReadDouble(out Value: Double);
begin
  FProxy.get_double(Value);
end;

procedure TInputStream.ReadLongDouble(out Value: Extended);
begin
  FProxy.get_long_double(Value);
end;

procedure TInputStream.ReadString(out Value: string);
var
  L: Cardinal;
  temp : Char;
begin
  FProxy.get_unsigned_long(L);
  SetLength(Value, L-1);
  if L = 1 then
    FProxy.get_char(temp)
  else
    FProxy.get_char_ptr(PChar(Pointer(Value)), L);
end;

procedure TInputStream.ReadWString(out Value: WideString);
var
  L: Cardinal;
  temp : wChar;
begin
  FProxy.get_unsigned_long(L);
  SetLength(Value, L-1);
  if L = 1 then
    FProxy.get_wchar(temp)
  else
    FProxy.get_wchar_ptr(PWideChar(Pointer(Value)), L);
end;

procedure TInputStream.ReadBooleanArray(out Value: array of Boolean);
var
  I: Integer;
  Temp: array of Byte;
begin
  SetLength(Temp, Length(Value));
  FProxy.get_unsigned_char_array(Temp);
  for I := Low(Temp) to High(Temp) do
    Value[I] := Temp[I] <> $00;
end;

procedure TInputStream.ReadCharArray(out Value: array of Char);
begin
  FProxy.get_char_ptr(Value, Length(Value));
end;

procedure TInputStream.ReadWCharArray(out Value: array of WideChar);
begin
  FProxy.get_wchar_ptr(Value, Length(Value));
end;

procedure TInputStream.ReadOctetArray(out Value: array of Byte);
begin
  FProxy.get_unsigned_char_array(Value);
end;

procedure TInputStream.ReadShortArray(out Value: array of SmallInt);
begin
  FProxy.get_short_array(Value);
end;

procedure TInputStream.ReadUShortArray(out Value: array of Word);
begin
  FProxy.get_unsigned_short_array(Value);
end;

procedure TInputStream.ReadLongArray(out Value: array of Integer);
begin
  FProxy.get_long_array(Value);
end;

procedure TInputStream.ReadULongArray(out Value: array of Cardinal);
begin
  FProxy.get_unsigned_long_array(Value);
end;

procedure TInputStream.ReadLongLongArray(out Value: array of Int64);
begin
  FProxy.get_long_long_array(Value);
end;

procedure TInputStream.ReadULongLongArray(out Value: array of Int64);
begin
  FProxy.get_unsigned_long_long_array(Value);
end;

procedure TInputStream.ReadFloatArray(out Value: array of Single);
begin
  FProxy.get_float_array(Value);
end;

procedure TInputStream.ReadDoubleArray(out Value: array of Double);
begin
  FProxy.get_double_array(Value);
end;

procedure TInputStream.ReadLongDoubleArray(out Value: array of Extended);
begin
  FProxy.get_long_double_array(Value);
end;

procedure TInputStream.ReadObject(out Value: CORBAObject);
var
  Proxy, tempProxy: ORBPAS40.ObjectProxy;
begin
  FProxy.get_object(Proxy);
  if (Proxy <> nil) then
  begin
    if Proxy.QueryInterface(CORBAObject, Value) = 0 then
      Exit
    else if Proxy.QueryInterface(ObjectProxy, tempProxy) = 0 then
      Value := TCorbaObject.Create(tempProxy);
  end
  else
    Value := nil;
end;

procedure TInputStream.ReadTypeCode(out Value: TypeCode);
begin
  FProxy.get_typecode(Value);
end;

procedure TInputStream.ReadAny(out Value: Any);
var pTempCorbaAny : PCorbaAny;
    temp : Any;
begin
  FProxy.Get_Any(pTempCorbaAny);
  if AnyToVariant(pTempCorbaAny, @temp) then
     Value := temp;
end;

procedure TInputStream.ReadPrincipal(out Value : Principal);
begin
  Value := nil;
end;


{ TOutputStream }

constructor TOutputStream.Create(Proxy: ORBPAS40.MarshalOutBufferProxy);
begin
  FProxy := Proxy;
end;

destructor TOutputStream.Destroy;
begin
  inherited Destroy;
  FProxy := nil
end;

function TOutputStream.Proxy: _Object;
begin
  Result := FProxy;
end;

function TOutputStream.CreateInputStream: InputStream;
var inBuf : MarshalInBufferProxy;
begin
  FProxy.CreateInputStream(Pointer(inBuf));
  result := TInputStream.Create(inbuf);
end;

procedure TOutputStream.WriteBoolean(Value: Boolean);
begin
  if Value then
    FProxy.put_unsigned_char($01)
  else
    FProxy.put_unsigned_char($00)
end;

procedure TOutputStream.WriteChar(Value: Char);
begin
  FProxy.put_char(Value);
end;

procedure TOutputStream.WriteWChar(Value: WideChar);
begin
  FProxy.put_wchar(Value);
end;

procedure TOutputStream.WriteOctet(Value: Byte);
begin
  FProxy.put_unsigned_char(Value);
end;

procedure TOutputStream.WriteShort(Value: SmallInt);
begin
  FProxy.put_short(Value);
end;

procedure TOutputStream.WriteUShort(Value: Word);
begin
  FProxy.put_unsigned_short(Value);
end;

procedure TOutputStream.WriteLong(Value: Integer);
begin
  FProxy.put_long(Value);
end;

procedure TOutputStream.WriteULong(Value: Cardinal);
begin
  FProxy.put_unsigned_long(Value);
end;

procedure TOutputStream.WriteLongLong(Value: Int64);
begin
  FProxy.put_long_long(Value);
end;

procedure TOutputStream.WriteULongLong(Value: Int64);
begin
  FProxy.put_unsigned_long_long(Value);
end;

procedure TOutputStream.WriteFloat(Value: Single);
begin
  FProxy.put_float(Value);
end;

procedure TOutputStream.WriteDouble(Value: Double);
begin
  FProxy.put_double(Value);
end;

procedure TOutputStream.WriteLongDouble(Value: Extended);
begin
  FProxy.put_long_double(Value);
end;

procedure TOutputStream.WriteString(const Value: string);
var
  L: Cardinal;
begin
  L := Length(Value) + 1;
  FProxy.put_unsigned_long(L);
  if L = 1 then
    FProxy.put_char_ptr('', L)
  else
    FProxy.put_char_ptr(PChar(Pointer(Value)), L);
end;

procedure TOutputStream.WriteWString(const Value: WideString);
var
  L: Cardinal;
begin
  L := Length(Value) + 1;
  FProxy.put_unsigned_long(L);
  if L = 1 then
    FProxy.put_wchar_ptr('', L)
  else
    FProxy.put_wchar_ptr(PWideChar(Pointer(Value)), L);
end;

procedure TOutputStream.WriteBooleanArray(const Value: array of Boolean);
begin
  if Length(Value) < 1 then Exit;
// need impl
// FProxy.put_unsigned_char_array(Value);
end;

procedure TOutputStream.WriteCharArray(const Value: array of Char);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_char_array(Value);
end;

procedure TOutputStream.WriteWCharArray(const Value: array of WideChar);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_wchar_array(Value);
end;

procedure TOutputStream.WriteOctetArray(const Value: array of Byte);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_unsigned_char_array(Value);
end;

procedure TOutputStream.WriteShortArray(const Value: array of SmallInt);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_short_array(Value);
end;

procedure TOutputStream.WriteUShortArray(const Value: array of Word);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_unsigned_short_array(Value);
end;

procedure TOutputStream.WriteLongArray(const Value: array of Integer);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_long_array(Value);
end;

procedure TOutputStream.WriteULongArray(const Value: array of Cardinal);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_unsigned_long_array(Value);
end;

procedure TOutputStream.WriteLongLongArray(const Value: array of Int64);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_long_long_array(Value);
end;

procedure TOutputStream.WriteULongLongArray(const Value: array of Int64);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_unsigned_long_long_array(Value);
end;

procedure TOutputStream.WriteFloatArray(const Value: array of Single);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_float_array(Value);
end;

procedure TOutputStream.WriteDoubleArray(const Value: array of Double);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_double_array(Value);
end;

procedure TOutputStream.WriteLongDoubleArray(const Value: array of Extended);
begin
  if Length(Value) < 1 then Exit;
  FProxy.put_long_double_array(Value);
end;

procedure TOutputStream.WriteObject(const Value: CORBAObject);
begin
  if Value = nil then
  begin
    FProxy.put_object(nil);
    Exit;
  end;
  FProxy.put_object((Value as ProxyUser).Proxy as ORBPAS40.ObjectProxy);
end;

procedure TOutputStream.WriteTypeCode(const Value: TypeCode);
begin
  FProxy.put_typecode(Value);
end;

procedure TOutputStream.WriteAny(const Value: Any);
var
  Temp: PCorbaAny;
begin
  Temp := VariantToAny(@Value);
  try
    FProxy.Put_Any(Temp);
  finally
    CorbaReleaseAny(Temp)
  end;
end;

procedure TOutputStream.WritePrincipal(const Value : Principal);
begin
  //dummy method  Principal is depreciated in Corba 2.1 spec
end;

{ TIdentifierHelper }

class procedure TIdentifierHelper.Insert(var A: Any; const Value: Identifier);
begin
   A := Value;
end;

class function TIdentifierHelper.Extract(const A: Any): Identifier;
begin
    Result := Identifier(A)
end;
                                                       
class function TIdentifierHelper.TypeCode: TypeCode;
begin
  Result := ORB.CreateAliasTC(RepositoryId, 'Identifier', ORB.CreateTC( Integer(tk_string)));
end;

class function TIdentifierHelper.RepositoryId: string;
begin
  Result := 'IDL:omg.org.CORBA/Identifier:1.0';
end;

class function TIdentifierHelper.Read(const Input: InputStream): Identifier;
begin
  Input.ReadString(Result);
end;

class procedure TIdentifierHelper.Write(const Output: OutputStream;
  const Value: Identifier);
begin
  OutPut.WriteString(Value);
end;

{ TDefinitionKindHelper }

class procedure TDefinitionKindHelper.Insert(var A: Any; const Value: DefinitionKind);
begin
  A := Value;
end;

class function TDefinitionKindHelper.Extract(const A: Any): DefinitionKind;
begin
  if TypeCode.Equal(TAnyHelper.TypeCode(A)) then
    Result := DefinitionKind(A)
  else
    raise BAD_TYPECODE.Create;
end;

class function TDefinitionKindHelper.TypeCode: TypeCode;
begin
  Result := ORB.CreateEnumTC(RepositoryId, 'DefinitionKind', ['dk_none', 'dk_all',
    'dk_Attribute', 'dk_Constant', 'dk_Exception', 'dk_Interface', 'dk_Module',
    'dk_Operation', 'dk_Typedef', 'dk_Alias', 'dk_Struct', 'dk_Union', 'dk_Enum',
    'dk_Primitive', 'dk_String', 'dk_Sequence', 'dk_Array', 'dk_Repository',
    'dk_Wstring']);
end;

class function TDefinitionKindHelper.RepositoryId: string;
begin
  Result := 'IDL:omg.org.CORBA/DefinitionKind:1.0';
end;

class function TDefinitionKindHelper.Read(const Input: InputStream): DefinitionKind;
var
  Temp: Cardinal;
begin
  Input.ReadULong(Temp);
  Result := DefinitionKind(Temp);
end;

class procedure TDefinitionKindHelper.Write(const Output: OutputStream;
  const Value: DefinitionKind);
begin
  OutPut.WriteULong(Cardinal(Value));
end;

{ TIRObjectHelper }

class procedure TIRObjectHelper.Insert(var A: Any; const Value: IRObject);
begin
   A := Orb.MakeObjectRef(TIRObjectHelper.TypeCode, Value as CorbaObject);
end;

class function TIRObjectHelper.Extract(var A: Any): IRObject;
var _obj : CorbaObject;
begin
  _obj := Orb.GetObjectRef(A);
  result := TIRObjectHelper.Narrow(_obj, True);
end;

class function TIRObjectHelper.TypeCode: TypeCode;
begin
  Result := ORB.CreateInterfaceTC(RepositoryId, 'IRObject');
end;

class function TIRObjectHelper.RepositoryId: string;
begin
  Result := 'IDL:omg.org.CORBA/IRObject:1.0';
end;

class function TIRObjectHelper.Read(const Input: InputStream): IRObject;
var
  Obj: CORBAObject;
begin
  Input.ReadObject(Obj);
  Result := Narrow(Obj, True)
end;

class procedure TIRObjectHelper.Write(const Output: OutputStream;
  const Value: IRObject);
begin
  OutPut.WriteObject(Value as CORBAObject);
end;

class function TIRObjectHelper.Narrow(const Obj: CORBAObject;
  IsA: Boolean): IRObject;
begin
  Result := nil;
  if (Obj = nil) or (Obj.QueryInterface(IRObject, Result) = 0) then Exit;
  if IsA and Obj._IsA(RepositoryId) then
    Result := TIRObjectStub.Create(Obj);
end;

class function TIRObjectHelper.Bind(const InstanceName: string;
  HostName: string): IRObject;
begin
  Result := Narrow(ORB.Bind(RepositoryId, InstanceName, HostName), True);
end;

{ TIRObjectStub }

function TIRObjectStub._get_def_kind: DefinitionKind;
var
  Output: OutputStream;
  Input: InputStream;
begin
  inherited _CreateRequest('_get_def_kind', True, Output);
  inherited _Invoke(Output, Input);
  Result := TDefinitionKindHelper.Read(Input);
end;

function TIRObjectStub._get_comment: string;
var
  Output: OutputStream;
  Input: InputStream;
begin
  inherited _CreateRequest('_get_comment', True, Output);
  inherited _Invoke(Output, Input);
  Input.ReadString(Result);
end;

procedure TIRObjectStub._set_comment(const Value: string);
var
  Output: OutputStream;
  Input: InputStream;
begin
  inherited _CreateRequest('_set_comment', True, Output);
  Output.WriteString(Value);
  inherited _Invoke(Output, Input);
end;

function TIRObjectStub._get_file_name: string;
var
  Output: OutputStream;
  Input: InputStream;
begin
  inherited _CreateRequest('_get_file_name', True, Output);
  inherited _Invoke(Output, Input);
  Input.ReadString(Result);
end;

procedure TIRObjectStub._set_file_name(const Value: string);
var
  Output: OutputStream;
  Input: InputStream;
begin
  inherited _CreateRequest('_set_file_name', True, Output);
  Output.WriteString(Value);
  inherited _Invoke(Output, Input);
end;

procedure TIRObjectStub.destroy;
var
  Output: OutputStream;
  Input: InputStream;
begin
  inherited _CreateRequest('destroy', True, Output);
  inherited _Invoke(Output, Input);
end;

{ TIDLTypeHelper }

class procedure TIDLTypeHelper.Insert(var A: Any; const Value: IDLType);
begin
   A := Orb.MakeObjectRef(TIDLTypeHelper.TypeCode, Value as CorbaObject);
end;

class function TIDLTypeHelper.Extract(var A: Any): IDLType;
var _obj : CorbaObject;
begin
  _obj := Orb.GetObjectRef(A);
  result := TIDLTypeHelper.Narrow(_obj, True);
end;

class function TIDLTypeHelper.TypeCode: TypeCode;
begin
  Result := ORB.CreateInterfaceTC(RepositoryId, 'IDLType');
end;

class function TIDLTypeHelper.RepositoryId: string;
begin
    Result := 'IDL:omg.org.CORBA/IDLType:1.0';
end;

class function TIDLTypeHelper.Read(const Input: InputStream): IDLType;
var
  Obj: CORBAObject;
begin
  Input.ReadObject(Obj);
  Result := Narrow(Obj, True)
end;

class procedure TIDLTypeHelper.Write(const Output: OutputStream;
  const Value: IDLType);
begin
  OutPut.WriteObject(Value as CORBAObject);
end;

class function TIDLTypeHelper.Narrow(const Obj: CORBAObject;
  IsA: Boolean): IDLType;
begin
  Result := nil;
  if (Obj = nil) or (Obj.QueryInterface(IDLType, Result) = 0) then Exit;
  if IsA and Obj._IsA(RepositoryId) then 
    Result := TIDLTypeStub.Create(Obj);
end;

class function TIDLTypeHelper.Bind(const InstanceName: string;
  HostName: string): IDLType;
begin
  Result := Narrow(ORB.Bind(RepositoryId, InstanceName, HostName), True);
end;

{ TIDLTypeStub }

function TIDLTypeStub._get_type: TypeCode;
var
  Output: OutputStream;
  Input: InputStream;
begin
  inherited _CreateRequest('_get_type', True, Output);
  inherited _Invoke(Output, Input);
  Input.ReadTypeCode(Result);
end;

{ SystemException }

constructor SystemException.Create(Minor: Integer; Completed: CompletionStatus);
begin
  FMinor := Minor;
  FCompleted := Completed;
  inherited Create(ClassName);
end;

{ UserException }

constructor UserException.Create;
begin
  inherited Create(ClassName);
  FProxy := ORBPAS40.CreateUserException(_Copy, Throw)
end;

procedure UserException._Copy(const InBuf: ORBPAS40.MarshalInBufferProxy);
begin
  Copy(TInputStream.Create(InBuf));
end;

procedure UserException.Throw;
begin
  raise Self;
end;

{ TPOA }

class procedure TPOA.Initialize;
begin
  if POAVar = nil then
  begin
    POAVar := TPOA.Create;
    ORBVar.FProxy.poa_init(POAVar.POA);
  end;
end;

destructor TPOA.Destroy;
begin
  if POA <> nil then POA := nil;
  inherited;
end;

procedure TPOA.ActivateObject(const ObjectID : string; const Obj: _Object);
begin
  // This activates the root POA with an object name and Impl Pascal object
  POA.ActivateObject(PChar(Pointer(ObjectID)),
    ((Obj as ProxyUser).Proxy as ORBPAS40.ObjectProxy).CorbaObject);
end;

{ TBOA }

class procedure TBOA.Initialize(const CommandLine: TCommandLine);
begin
  if BOAVar = nil then
  begin
    BOAVar := TBOA.Create;
    ORBVar.FProxy.boa_init(Length(CommandLine), CommandLine, BOAVar.BOA);
  end;
end;

destructor TBOA.Destroy;
begin
  if BOA <> nil then BOA := nil;
  inherited Destroy;
end;

procedure TBOA.Deactivate(const Obj: _Object);
begin
  BOA.ObjIsReady( ((Obj as ProxyUser).Proxy as ObjectProxy).CorbaObject);
end;

procedure TBOA.ImplIsReady;
begin
  BOA.ImplIsReady;
end;

procedure TBOA.ObjIsReady(const Obj : _Object);
begin
  BOA.ObjIsReady( ((Obj as ProxyUser).Proxy as ORBPAS40.ObjectProxy).CorbaObject);
end;

function TBOA.GetPrincipalLength(const Proxy: PCorbaObject): CorbaULong;
begin
  result := BOA.GetPrincipalLength(Proxy);
end;

procedure TBOA.GetPrincipal(const Proxy: PCorbaObject; out ByteBuf);
begin
  BOA.GetPrincipal(Proxy, ByteBuf);
end;

procedure TBOA.SetScope(const Val : RegistrationScope);
begin
  BOA.SetScope(Val);
end;

function TBOA.GetScope : RegistrationScope;
begin
  result := BOA.GetScope;
end;

procedure TBOA.ExitImplReady;
begin
  BOA.ExitImplReady;
end;


{ TORB }

class procedure TORB.Init(const CommandLine: TCommandLine);
begin
  ORBVar := TORB.Create();
  ORBVar.FProxy := InitORB(CommandLine);
end;

class procedure TORB.Init;
var
  CommandLine: TCommandLine;
  I: Integer;
begin
  if ORBVar = nil then
  begin
    SetLength(CommandLine, ParamCount + 1);
    for I := 0 to ParamCount do CommandLine[I] := ParamStr(I);
    init(CommandLine);
    if BOAVar = nil then TBOA.Initialize(CommandLine);
    if POAVar = nil then TPOA.Initialize;
  end;
end;

function TORB.Proxy: IUnknown;
begin
  Result := FProxy;
end;

destructor TORB.Destroy;
begin
  if FProxy <> nil then FProxy := nil;
  inherited;
end;

function TORB.Bind(const RepositoryId, ObjectName, HostName: string): CORBAObject;
var
  Proxy: ORBPAS40.ObjectProxy;
begin
  FProxy.bind(PChar(Pointer(RepositoryId)), PChar(Pointer(ObjectName)),
    PChar(Pointer(HostName)), nil, Proxy);
  Result := TCorbaObject.Create(Proxy);
end;

function TORB.Bind(const RepositoryID: string;  const Options: BindOptions;
  const ObjectName: string = ''; const HostName: string = ''): CORBAObject;
var
  Proxy: ORBPAS40.ObjectProxy;
  Opt: ORBPAS40.BindOptions;
begin
  BindOptionsToPBindOptions(Options, Opt);
  FProxy.bind(PChar(Pointer(RepositoryId)), PChar(Pointer(ObjectName)),
    PChar(Pointer(HostName)), @Opt, Proxy);
  Result := TCorbaObject.Create(Proxy);
end;

function TORB.ObjectToString(const Obj: CORBAObject): string;
var
  P: PChar;
begin
  P := FProxy.object_to_string((Obj as ProxyUser).Proxy as ORBPAS40.ObjectProxy);
  Result := P;
end;

function TORB.StringToObject(const ObjectString: string): CORBAObject;
var
  Proxy: ORBPAS40.ObjectProxy;
begin
  FProxy.string_to_object(PChar(Pointer(ObjectString)), Proxy);
  Result := TCorbaObject.Create(Proxy);
end;

procedure TORB.Shutdown;
begin
  FProxy.Shutdown;
end;

function TORB.ResolveInitialReferences(const ObjectName : String) : CORBAObject;
var
   Proxy : ORBPAS40.ObjectProxy;
begin
   FProxy.resolve_initial_references(PChar(Pointer(ObjectName)), Proxy);
   result := TCorbaObject.Create(Proxy);
end;

function TORB.CreateOutputStream: OutputStream;
var
  Proxy: ORBPAS40.MarshalOutBufferProxy;
begin
  FProxy.create_marshaloutbuffer(Proxy);
  Result := TOutputStream.Create(Proxy);
end;


procedure TOrb.PutAny(var A : Any; const tc : ITypeCode; const Output : OutputStream);
var CorbaAny : PCorbaAny;
		 temp : Any;
begin
  CorbaAny := nil;
  FProxy.Put_Any(CorbaAny, tc,
    (Output as ProxyUser).Proxy as ORBPAS40.MarshalOutBufferProxy);
  if AnyToVariant(CorbaAny, @temp) then
    A := temp
end;

{ ORB TypeCode methods }

function TORB.CreateTC(Kind: integer): TypeCode;
begin
  FProxy.createTC(Kind, Result);
end;


function TORB.CreateStructTC(const RepositoryID, TypeName: string;
            const Members: StructMemberSeq): TypeCode;
begin
  FProxy.CreateStructTC(PChar(Pointer(RepositoryID)), PChar(Pointer(TypeName)),
    Members, Length(Members), Result);
end;

function TORB.CreateUnionTC(const RepositoryID, TypeName: string;
                            const DiscriminatorType: TypeCode;
                            const Members: UnionMemberSeq): TypeCode;
begin
  FProxy.create_union_tc(PChar(Pointer(RepositoryID)),
    PChar(Pointer(TypeName)), DiscriminatorType,
    Members, Length(Members), Result);
end;

function TORB.CreateEnumTC(const RepositoryID, TypeName: string;
                           const Members: array of string): TypeCode;
begin
  FProxy.create_enum_tc(PChar(Pointer(RepositoryID)), PChar(Pointer(TypeName)),
    Members, Result);
end;

function TORB.CreateAliasTC(const RepositoryId, TypeName: string;
                            const OrginalType: TypeCode): TypeCode;
begin
  FProxy.CreateAliasTC(PChar(Pointer(RepositoryId)), PChar(Pointer(TypeName)),
    OrginalType, Result);
end;

function TORB.CreateExceptionTC(const RepositoryId, TypeName: string;
                                const Members: StructMemberSeq): TypeCode;
begin
//  result := FProxy.create_exception_tc(PChar(Pointer(RepositoryID)), PChar(Pointer(TypeName)),
//            (Output as ProxyUser).Proxy as ORBPAS40.MarshalOutBufferProxy, Result);
end;

function TORB.CreateInterfaceTC(const RepositoryID, TypeName: string): TypeCode;
begin
  FProxy.create_interface_tc(PChar(Pointer(RepositoryID)), PChar(Pointer(TypeName)), Result);
end;

function TORB.CreateStringTC(Length: Integer): TypeCode;
begin
  FProxy.create_string_tc(Length, Result);
end;

function TORB.CreateWStringTC(Length: Integer): TypeCode;
begin
  FProxy.create_wstring_tc(Length, Result);
end;

function TORB.CreateSequenceTC(Length: Integer; const ElementType: TypeCode): TypeCode;
begin
  FProxy.CreateSequenceTC(Length, ElementType, Result);
end;

function TORB.CreateRecursiveSequenceTC(Length, Offset: Integer): TypeCode;
begin
  FProxy.create_recursive_sequence_tc(Length, Offset, Result);
end;

function TORB.CreateArrayTC(Length: Integer; const ElementType: TypeCode): TypeCode;
begin
  FProxy.CreateArrayTC(Length, ElementType, Result);
end;


procedure TOrb.GetAny(Value : Any; out Input : InputStream);
var pTempCorbaAny : PCorbaAny;
  Proxy: ORBPAS40.MarshalInBufferProxy;
begin
  pTempCorbaAny := VariantToAny(@Value);
  FProxy.Get_Any(pTempCorbaAny, Proxy);
  Input := TInputStream.Create(Proxy);
end;

{ Dynamic invocation helper methods }

(*

function TORB.FindTypeCode(const RepositoryID: string): ITypeCode;
begin
  FProxy.FindRepositoryTC(PChar(RepositoryID), Result);
end;
*)

function TORB.MakeArray(Kind: TCKind; const Elements: array of Any): Any;
var
  TC: ITypeCode;
begin
  FProxy.CreateTC(Integer(Kind), TC);
  Result := MakeArray(TC, Elements);
end;

function TORB.MakeArray(TypeCode: ITypeCode; const Elements: array of Any): Any;
begin
  Result := MakeComplexAny(TypeCode, Elements);
end;

function TORB.MakeSequence(Kind: TCKind; const Elements: array of Any): Any;
var
  TC: ITypeCode;
begin
  FProxy.CreateTC(Integer(Kind), TC);
  Result := MakeSequence(TC, Elements);
end;

function TORB.MakeSequence(TypeCode: ITypeCode; const Elements: array of Any): Any;
begin
  Result := MakeComplexAny(TypeCode, Elements);
end;

function TORB.MakeStructure(TypeCode: ITypeCode; const Elements: array of Any): Any;
begin
  Result := MakeComplexAny(TypeCode, Elements);
end;

function TORB.MakeAlias(const RepositoryID, TypeName: string; Value, Test: Any): Any;
var
  Temp: Variant;
  TC, TC2: ITypeCode;
begin
  TVarData(Temp).VAny := CorbaDuplicateAny(VariantToAny(@Value));
  TVarData(Temp).VType := varAny;
  CorbaAnyType(TVarData(Temp).VAny, TC);
  FProxy.CreateAliasTC(PChar(Pointer(RepositoryID)), PChar(Pointer(TypeName)),
    TC, TC2);
//  TVarData(Result).VAny := FProxy.MakeAny(TC2, [Temp]);
  TVarData(Result).VType := varAny;
end;

function TORB.MakeTypeCode(Kind: TCKind): ITypeCode;
begin
  FProxy.CreateTC(Integer(Kind), Result);
end;

function TORB.MakeSequenceTypeCode(Bound: CorbaULong; const TC: ITypeCode): ITypeCode;
begin
  FProxy.CreateSequenceTC(Bound, TC, Result);
end;

function TORB.MakeStructureTypeCode(const RepositoryID, Name: string; Members: TStructMembers): ITypeCode;
begin
  FProxy.CreateStructTC(PChar(Pointer(RepositoryID)), PChar(Pointer(Name)),
    Members, Length(Members), Result);
end;

function TORB.MakeAliasTypeCode(const RepositoryID, Name: string; const TC: ITypeCode): ITypeCode;
begin
  FProxy.CreateAliasTC(PChar(Pointer(RepositoryID)), PChar(Pointer(Name)), TC, Result);
end;

function TORB.MakeObjectRefTypeCode(const RepositoryID, Name: string): ITypeCode;
begin
  FProxy.CreateObjRefTC(PChar(Pointer(RepositoryID)), PChar(Pointer(Name)), Result);
end;

function TORB.MakeComplexAny(TypeCode: ITypeCode; const Elements: array of Any): Any;
var pTempCorbaAny : PCorbaAny;
    temp : Any;
begin
//  pTempCorbaAny := FProxy.MakeAny(TypeCode, Elements);
  try
    if AnyToVariant( pTempCorbaAny, @temp ) then
      result := temp;
  finally
    CorbaReleaseAny(pTempCorbaAny)
  end;
end;

function TORB.MakeObjectRef(tc : ITypeCode; const Obj: CorbaObject) : Any;
var
  pTempCorbaAny : PCorbaAny;
  temp : Any;
begin
  pTempCorbaAny := FProxy.MakeAnyObjRef(tc, (Obj as ProxyUser).Proxy as ORBPAS40.ObjectProxy);

  if AnyToVariant( pTempCorbaAny, @temp ) then
    result := temp
  else
    raise BAD_OPERATION.Create;
end;

function TORB.GetObjectRef(var A : Any) : CORBAObject;
var
  Proxy: ORBPAS40.ObjectProxy;
begin
  DelphiVariantToObject(@A, Proxy);
  result := TCorbaObject.Create(Proxy);
end;


function ORB: TORB;
begin
  if not Assigned(ORBVar) then
    CorbaInitialize;
  Result := ORBVar;
end;

function BOA: TBOA;
begin
  if not Assigned(BOAVar) then
    CorbaInitialize;
  Result := BOAVar;
end;

function POA : TPOA;
begin
  if not Assigned(POAVar) then
    CorbaInitialize;
  result := POAVar;
end;
    
{ TCorbaListManager }

constructor TCorbaListManager.Create;
begin
  FSync := TMultiReadExclusiveWriteSynchronizer.Create;
end;

destructor TCorbaListManager.Destroy;
begin
  FSync.Free;
end;

procedure TCorbaListManager.BeginRead;
begin
  FSync.BeginRead;
end;

procedure TCorbaListManager.BeginWrite;
begin
  FSync.BeginWrite;
end;

procedure TCorbaListManager.EndRead;
begin
  FSync.EndRead;
end;

procedure TCorbaListManager.EndWrite;
begin
  FSync.EndWrite;
end;

{ TInterfaceIDManager }

procedure TInterfaceIDManager.RegisterInterface(const IID: TGUID;
  const RepositoryID: string);
var
  L: Integer;
begin
  BeginWrite;
  try
    L := Length(FList);
    if FUsed = L then
    begin
      if L = 0 then L := 8 else L := L * 2;
      SetLength(FList, L);
    end;
    FList[FUsed].IID := IID;
    FList[FUsed].RepositoryID := RepositoryID;
    Inc(FUsed);
  finally
    EndWrite;
  end;
end;

function TInterfaceIDManager.FindIID(const RepositoryID: string;
  out IID: TGUID): Boolean;
var
  I: Integer;
begin
  BeginRead;
  try
    for I := 0 to FUsed - 1 do
      if FList[I].RepositoryID = RepositoryID then
      begin
        IID := FList[I].IID;
        Result := True;
        Exit;
      end;
  finally
    EndRead;
  end;
  Result := False;
end;

function TInterfaceIDManager.FindRepositoryID(const IID: TGUID;
  out RepositoryID: string): Boolean;
var
  I: Integer;
begin
  BeginRead;
  try
    for I := 0 to FUsed - 1 do
      if CompareMem(@FList[I].IID, @IID, SizeOf(TGUID)) then
      begin
        RepositoryID := FList[I].RepositoryID;
        Result := True;
        Exit;
      end;
  finally
    EndRead;
  end;
  Result := False;
end;

procedure TInterfaceIDManager.GetInterfaceList(var stList : TStringList);
var
  I: Integer;
begin
  BeginRead;
  try
    for I := 0 to FUsed - 1 do
      stList.Add(FList[I].RepositoryID);
  finally
    EndRead;
  end;
end;

//depreciated by Corba 2.2
procedure Principal.name;
begin
  raise NO_IMPLEMENT.Create;
end;

{ TAnyHelper }

class function TAnyHelper.TypeCode(const A: Any): TypeCode;
begin
  case TVarData(A).VType of
    varEmpty    : Result := ORB.CreateTC(Integer(tk_void));
    varNull     : Result := ORB.CreateTC(Integer(tk_null));
    varSmallInt : Result := ORB.CreateTC(Integer(tk_short));
    varInteger  : Result := ORB.CreateTC(Integer(tk_long));
    varSingle   : Result := ORB.CreateTC(Integer(tk_float));
    varDouble   : Result := ORB.CreateTC(Integer(tk_double));
    varBoolean  : Result := ORB.CreateTC(Integer(tk_boolean));
    varByte     : Result := ORB.CreateTC(Integer(tk_octet));
    varAny      : Result := ORB.CreateTC(Integer(tk_any));
    varUnknown  : Result := ORB.CreateTC(Integer(tk_objref));
  else
    raise BAD_TYPECODE.Create;
  end;
end;

{ CORBA Dispatch }

var
  OldVarDispProc: TVarDispProc;

procedure ClearAnyImpl(var V: Variant);
var
  P: Pointer;
begin
  if (TVarData(V).VType = varAny) then
  begin
    TVarData(V).VType := varEmpty;
    P := TVarData(V).VAny;
    if P <> nil then CorbaReleaseAny(P);
  end;
end;

procedure ChangeAnyImpl(var V: Variant);
var
  Tmp: Variant;
begin
  if TVarData(V).VType = varAny then
  begin
    if not AnyToVariant(PCorbaAny(TVarData(V).VAny), @Tmp) then
      raise ECorbaDispatch.Create(sInvalidTypeCast);
    V := Tmp;
  end;
end;

procedure RefAnyImpl(var V: Variant);
begin
  CorbaDuplicateAny(TVarData(V).VAny);
end;

{ Corba exception mapper }

type
  TExceptClassProc = function (P: PExceptionRecord): ExceptClass;
  TExceptObjectProc = function (P: PExceptionRecord): Exception;

var
  OldExceptClassProc: TExceptClassProc;
  OldExceptObjectProc: TExceptObjectProc;

function IsSystemException(P: PExceptionRecord;
  out SystemExceptionClass: ExceptClass): Boolean;
const
  cCPPException = $EEFFACE;
  SystemExceptionClasses: array[0..25] of ExceptClass = (
    BAD_CONTEXT,
    BAD_INV_ORDER,
    BAD_OPERATION,
    BAD_PARAM,
    BAD_TYPECODE,
    COMM_FAILURE,
    DATA_CONVERSION,
    FREE_MEM,
    IMP_LIMIT,
    INITIALIZE,
    INTERNAL,
    INTF_REPOS,
    INV_FLAG,
    INV_IDENT,
    INV_OBJREF,
    MARSHAL,
    NO_IMPLEMENT,
    NO_MEMORY,
    NO_PERMISSION,
    NO_RESOURCES,
    NO_RESPONSE,
    OBJ_ADAPTER,
    OBJECT_NOT_EXIST,
    PERSIST_STORE,
    TRANSIENT,
    UNKNOWN);
var
  I: Integer;
  Name: PChar;
begin
  Result := False;
  Name := PChar(P.ExceptionInformation[0]);
  if (P.ExceptionCode <> cCPPException) or
    (Name = nil) or
    (StrLComp('CORBA_', Name, 6) <> 0) then
    Exit;
  Inc(Name, 6);
  for I := Low(SystemExceptionClasses) to High(SystemExceptionClasses) do
    if CompareStr(SystemExceptionClasses[I].ClassName, Name) = 0 then
    begin
      Result := True;
      SystemExceptionClass := SystemExceptionClasses[I];
    end;
end;

function CreateSystemException(P: PExceptionRecord; out E: Exception): Boolean;
type
  SystemExceptionClass = class of SystemException;
  XD = packed record
    A: array[0..5] of LongInt;
    B1: Word;
    B2: Word;
    C: array[0..9] of LongInt;
    D1: Char;
    D2: Char;
    D: Integer;
    Minor: Integer;   // Minor
    Status: Byte;     // Complete
  end;
  XDP = ^XD;
var
  EC: ExceptClass;
begin
  Result := IsSystemException(P, EC);
  if Result then
    E := SystemExceptionClass(EC).Create(
      XDP(P.ExceptionInformation[2]).Minor,
      CompletionStatus(XDP(P.ExceptionInformation[2]).Status));
end;

function CorbaGetExceptClass(P: PExceptionRecord): ExceptClass;
begin
  if not IsSystemException(P, Result) then
    Result := OldExceptClassProc(P);
end;

function CorbaGetExceptObject(P: PExceptionRecord): Exception;
begin
  if not CreateSystemException(P, Result) then
    Result := OldExceptObjectProc(P)
end;

procedure CorbaHookExceptions;
begin
  OldExceptClassProc := ExceptClsProc;
  OldExceptObjectProc := ExceptObjProc;
  ExceptClsProc := @CorbaGetExceptClass;
  ExceptObjProc := @CorbaGetExceptObject;
end;

procedure CorbaUnhookExceptions;
begin
  if ExceptClsProc = @CorbaGetExceptClass then
  begin
    ExceptClsProc := @OldExceptClassProc;
    if ExceptObjProc = @CorbaGetExceptObject then
       ExceptObjProc := @OldExceptObjectProc;
  end;
end;

procedure CorbaHookDispatch;
begin
  ClearAnyProc := @ClearAnyImpl;
  ChangeAnyProc := @ChangeAnyImpl;
  RefAnyProc := @RefAnyImpl;
  OldVarDispProc := VarDispProc;
//  VarDispProc := @CorbaDispProc;
end;

procedure CorbaUnhookDispatch;
begin
  if @ClearAnyProc = @ClearAnyImpl then
  begin
    ClearAnyProc := nil;
    ChangeAnyProc := nil;
    RefAnyProc := nil;
  end;
//  if @VarDispProc = @CorbaDispProc then
//    VarDispProc := OldVarDispProc;
end;

var
  Initialized: Boolean = False;

procedure CorbaInitialize;
begin
  if not Initialized then
  begin
    Initialized := True;
    TORB.init;
    CorbaHookDispatch;
    CorbaHookExceptions;
  end;
end;

function RegisterUserException(const Name, RepositoryID: String; Factory: TUserExceptionFactoryProc): PExceptionDescription;
begin
   CorbaInitialize;   //makes sure orb is ready when exceptions are registered
   result := ORBPAS40.RegisterUserException( PChar(Pointer (Name)), PChar(Pointer (RepositoryID)), Factory);
end;

procedure UnRegisterUserException(Description: PExceptionDescription);
begin
   ORBPAS40.UnRegisterUserException(Description);
end;


initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Corba40\Corba.pas initialization enter'); {$EndIf}
  InterfaceIDManager := TInterfaceIDManager.Create;

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Corba40\Corba.pas initialization leave'); {$EndIf}
finalization
  InterfaceIDManager.Free;
  BOAVar.Free;
  POAVar.Free;
  ORBVar.Free;
  CorbaUnhookDispatch;
  CorbaUnhookExceptions;

end.
