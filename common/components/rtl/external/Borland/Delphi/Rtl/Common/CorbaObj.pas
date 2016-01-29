{ *********************************************************************** }
{                                                                         }
{ Delphi Runtime Library                                                  }
{                                                                         }
{ Copyright (c) 1999-2001 Borland Software Corporation                    }
{                                                                         }
{ *********************************************************************** }

unit CorbaObj;

{$T-,H+,X+}

interface

uses Variants, SysUtils, OrbPas, ActiveX;

type
  CorbaBoolean = ORBPAS.CorbaBoolean;
  CorbaULong = ORBPAS.CorbaULong;
  IObject = System.IUnknown;
  TCorbaPrincipal = array of Byte;
  TCommandLine = ORBPAS.TArgv;
  TCKind = ORBPAS.TCKind;
  TAny = Variant;
  ITypeCode = ORBPAS.ITypeCode;
  
  ICorbaObject = interface
    ['{0BAF8E01-CE38-11D1-AADC-00C04FB17A72}']
    function NonExistent: Boolean;
    function Hash(Maximum: Integer): Integer;
    function IsA(const LogicalTypeId: string): Boolean;
    procedure SetPrincipal(const Prinicpal: TCorbaPrincipal);
  end;

  ECorbaException = class(Exception)
  protected
    function GetMessage: string;
  public
    property Name: string read GetMessage;
  end;

  ECorbaDispatch = class(Exception);

  ECorbaUserException = class(ECorbaException)
  private
   FProxy: PUserExceptionProxy;
  public
    constructor Create(const Name: string);
    procedure Copy(const InBuf: IMarshalInBuffer); virtual; abstract;
    procedure Throw;
    property Proxy: PUserExceptionProxy read FProxy;
  end;

  TCorbaThreadModel = (tmMultiThreaded, tmSingleThread);

  TCorbaInstancing = (iSingleInstance, iMultiInstance);

{$M+}
  TCorbaSkeleton = class(TInterfacedObject, ISkeletonObject)
  protected
    FSkeleton: ISkeleton;
    procedure InitSkeleton(const InterfaceName, InstanceName, RepositoryID: string;
      ThreadModel: TCorbaThreadModel; ClientRefCount: Boolean);
  protected
    { ISkeletonObject }
    procedure GetSkeleton(out Skeleton: ISkeleton); stdcall;
    procedure GetImplementation(out Impl: IObject); virtual; stdcall;
    function Execute(Operation: PChar; const Strm: IMarshalInBuffer;
      Cookie: Pointer): CorbaBoolean; stdcall;
  public
    constructor Create(const InstanceName: string; const Impl: IObject); virtual;
    destructor Destroy; override;
  end;
{$M-}

  TCorbaStub = class(TInterfacedObject, IStubObject, ICorbaObject)
  protected
    FStub: IStub;
  protected
    { IStubObject }
    procedure GetStub(out Stub: IStub); stdcall;
    { ICorbaObject }
    function NonExistent: Boolean;
    function Hash(Maximum: Integer): Integer;
    function IsA(const LogicalTypeId: string): Boolean;
    procedure SetPrincipal(const Prinicpal: TCorbaPrincipal);
  public
    constructor Create(const Stub: IStub); virtual;
    destructor Destroy; override;
  end;

  TCorbaDispatchStub = class(TCorbaStub, IDispatch)
  protected
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; virtual; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; virtual; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;
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

  TInterfaceIDEntryDesc = record
    RepositoryID: string;
    IID: TGUID;
  end;
  TInterfaceIDList = array of TInterfaceIDEntryDesc;

  TCorbaInterfaceIDManager = class(TCorbaListManager)
  private
    FList: TInterfaceIDList;
    FUsed: Integer;
  public
    procedure RegisterInterface( const IID: TGUID; const RepositoryID: string);
    function SearchGUID(const RepositoryID: string; out IID: TGUID): Boolean;
    function SearchID(const IID: TGUID; out RepositoryID: string): Boolean;
    function FindGUID(const RepositoryID: string): TGUID;
    function FindID(const IID: TGUID): string;
  end;

  TCorbaSkeletonClass = class of TCorbaSkeleton;

  TSkeletonEntryDesc = record
    IID: TGUID;
    SkeletonClass: TCorbaSkeletonClass;
  end;
  TSkeletonList = array of TSkeletonEntryDesc;

  TCorbaSkeletonManager = class(TCorbaListManager)
  private
    FList: TSkeletonList;
    FUsed: Integer;
  public
    procedure RegisterSkeleton(IID: TGUID; Skeleton: TCorbaSkeletonClass);
    function CreateSkeleton(IID: TGUID; const InstanceName: string;
      const Impl: IObject): ISkeletonObject;
  end;

  TCorbaStubClass = class of TCorbaStub;

  TStubEntryDesc = record
    IID: TGUID;
    StubClass: TCorbaStubClass;
  end;
  TStubList = array of TStubEntryDesc;

  TCorbaStubManager = class(TCorbaListManager)
  private
    FList: TStubList;
    FUsed: Integer;
  public
    procedure RegisterStub(IID: TGUID; Stub: TCorbaStubClass);
    function CreateStub(IID: TGUID; const Stub: IStub): IObject;
  end;

  TCorbaFactory = class;

  TCorbaImplementation = class(TObject, IUnknown)
  protected
    FRefCount: Integer;
    FController: Pointer;
    FFactory: TCorbaFactory;
    { IUnknown }
    function IUnknown.QueryInterface = ObjQueryInterface;
    function IUnknown._AddRef = ObjAddRef;
    function IUnknown._Release = ObjRelease;
    function ObjAddRef: Integer; virtual; stdcall;
    function ObjQueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function ObjRelease: Integer; virtual; stdcall;
    { IUnknown methods for other interfaces }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { Stub implementation for IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  public
    constructor Create(Controller: IObject; AFactory: TCorbaFactory); virtual;
  end;

  TCorbaImplementationClass = class of TCorbaImplementation;

  TCorbaFactory = class(TInterfacedObject, ISkeletonObject)
  private
    FInterfaceName: string;
    FInstanceName: string;
    FRepositoryID: string;
    FInstancing: TCorbaInstancing;
    FThreadModel: TCorbaThreadModel;
    FIID: TGUID;
    FSkeleton: ISkeleton;
    FSingleInstanceSkelton: ISkeletonObject;
    FTypeInfo: ITypeInfo;
  protected
    { ISkeletonObject }
    procedure GetSkeleton(out Skeleton: ISkeleton); stdcall;
    procedure GetImplementation(out Impl: IObject); stdcall;
    function Execute(Operation: PChar; const Strm: IMarshalInBuffer;
      Cookie: Pointer): CorbaBoolean; stdcall;
    function GetTypeInfo(out TypeInfo): HRESULT;
  protected
    function CreateInstance(const InstanceName: string): ISkeletonObject; virtual;
    function CreateInterface(const InstanceName: string): IObject; virtual;
    procedure RegisterFactory;
  public
    constructor Create(const InterfaceName, InstanceName, RepositoryId: string;
      const ImplGUID: TGUID; Instancing: TCorbaInstancing = iMultiInstance;
      ThreadModel: TCorbaThreadModel = tmSingleThread);
    destructor Destroy; override;
    property InterfaceName: string read FInterfaceName;
    property InstanceName: string read FInstanceName;
    property RepositoryID: string read FRepositoryID;
    property Instancing: TCorbaInstancing read FInstancing;
    property ThreadModel: TCorbaThreadModel read FThreadModel;
  end;

  TCorbaObjectFactory = class(TCorbaFactory)
  private
    FImplementationClass: TCorbaImplementationClass;
  protected
    function CreateInterface(const InstanceName: string): IObject; override;
  public
    constructor Create(const InterfaceName, InstanceName, RepositoryId: string;
      const ImplGUID: TGUID; ImplementationClass: TCorbaImplementationClass;
      Instancing: TCorbaInstancing = iMultiInstance;
      ThreadModel: TCorbaThreadModel = tmSingleThread);
    property ImplementationClass: TCorbaImplementationClass read FImplementationClass;
  end;

  TFactoryList = array of TCorbaFactory;

  TCorbaFactoryManager = class(TCorbaListManager)
  private
    FList: TFactoryList;
    FUsed: Integer;
    FRegistered: Boolean;
  public
    destructor Destroy; override;
    procedure AddFactory(Factory: TCorbaFactory);
    procedure RegisterFactories;
    function Find(const RepositoryID, InterfaceName, InstanceName: string): TCorbaFactory;
  end;

  TBOA = class
  private
    BOA: IBOA;
  public
    class procedure Initialize(const CommandLine: TCommandLine);
    procedure ObjIsReady(const Obj: IObject);
    procedure ImplIsReady;
    procedure Deactivate(const Obj: IObject);
    function GetPrincipal(const Obj: IObject): TCorbaPrincipal;
  end;

  TORB = class
  private
    ORB: IORB;
    function MakeComplexAny(TypeCode: ITypeCode; const Elements: array of TAny): TAny;
  public
    class procedure Initialize; overload;
    class procedure Initialize(const CommandLine: TCommandLine); overload;
    function StringToObject(const ObjectString: string): IObject;
    function ObjectToString(const Obj: IObject): string;
    procedure Shutdown;

    { Binding methods }
    function Bind(const RepositoryID: string; const ObjectName: string = '';
      const HostName: string = ''): IObject; overload;
    function Bind(const InterfaceID: TGUID; const ObjectName: string = '';
      const HostName: string = ''): IObject; overload;

    { Dynamic invocation methods }
    function FindTypeCode(const RepositoryID: string): ITypeCode;
    function MakeArray(Kind: TCKind; const Elements: array of TAny): TAny; overload;
    function MakeArray(TypeCode: ITypeCode; const Elements: array of TAny): TAny; overload;
    function MakeSequence(Kind: TCKind; const Elements: array of TAny): TAny; overload;
    function MakeSequence(TypeCode: ITypeCode; const Elements: array of TAny): TAny; overload;
    function MakeStructure(TypeCode: ITypeCode; const Elements: array of TAny): TAny;
    function MakeAlias(const RepositoryID, TypeName: string; Value, Test: TAny): TAny;

    function MakeTypeCode(Kind: TCKind): ITypeCode;
    function MakeSequenceTypeCode(Bound: CorbaULong; const TC: ITypeCode): ITypeCode;
    function MakeStructureTypeCode(const RepositoryID, Name: string; Members: TStructMembers): ITypeCode;
    function MakeAliasTypeCode(const RepositoryID, Name: string; const TC: ITypeCode): ITypeCode;
    function MakeObjectRefTypeCode(const RepositoryID, Name: string): ITypeCode;
  end;

{ CORBA helper routines }

procedure CorbaInitialize;
function CorbaBind(const RepositoryID: string; const ObjectName: string = '';
  const HostName: string = ''): IObject; overload;
function CorbaBind(const InterfaceID: TGUID; const ObjectName: string = '';
  const HostName: string = ''): IObject; overload;
function MakePrincipal(const Bytes: array of Byte): TCorbaPrincipal;
function BOA: TBOA;
function ORB: TORB;

{ Any helpers }

function VariantArrayToSequence(TypeCode: ITypeCode; const VariantArray: Variant): TAny;
function SequenceToVariantArray(Sequence: TAny): Variant;
function AnyToObject(Any: TAny; IID: TGUID): IObject;

{ Global variables }

var
  CorbaSkeletonManager: TCorbaSkeletonManager;
  CorbaStubManager: TCorbaStubManager;
  CorbaInterfaceIDManager: TCorbaInterfaceIDManager;

{ Internal marshalling routines }

procedure MarshalObject(const OutBuf: IMarshalOutBuffer; IID: TGUID;
  const Intf: IObject);
function UnmarshalObject(const InBuf: IMarshalInBuffer; IID: TGUID): IObject;
procedure MarshalAny(const OutBuf: IMarshalOutBuffer; const OV: Variant);
function UnmarshalAny(const InBuf: IMarshalInBuffer): Variant;
function UnmarshalText(const InBuf: IMarshalInBuffer): string;
function UnmarshalWideText(const InBuf: IMarshalInBuffer): WideString;
procedure MarshalWordBool(const OutBuf: IMarshalOutBuffer; Value: WordBool);
function UnmarshalWordBool(const InBuf: IMarshalInBuffer): WordBool;
function CorbaFactoryCreateStub(const RepId, FactoryId, InstanceName, HostName: string;
  IID: TGUID): IObject;

implementation

uses Windows, CorbCnst;

var
  CorbaFactoryManager: TCorbaFactoryManager;
  BOAVar: TBOA;
  ORBVar: TORB;

type
  TUnmarshalProc =  procedure (const Strm: IMarshalInBuffer; Cookie: Pointer) of object;

{ ECorbaException }

function ECorbaException.GetMessage: string;
begin
  Result := Message;
end;

{ ECorbaUserException }

constructor ECorbaUserException.Create(const Name: string);
begin
  inherited Create(Name);
  FProxy := CreateUserException(Copy, Throw);
end;

procedure ECorbaUserException.Throw;
begin
  raise Self;
end;

{ TCorbaSkeleton }

constructor TCorbaSkeleton.Create(const InstanceName: string;
  const Impl: IObject);
begin
  inherited Create;
end;

destructor TCorbaSkeleton.Destroy;
begin
  FSkeleton := nil;
  inherited Destroy;
end;

procedure TCorbaSkeleton.InitSkeleton(const InterfaceName, InstanceName,
  RepositoryID: string; ThreadModel: TCorbaThreadModel; ClientRefCount: Boolean);
var
  Factory: TCorbaFactory;
  Serialize: Boolean;
begin
  Factory := CorbaFactoryManager.Find(RepositoryID, InterfaceName, InstanceName);
  if Factory <> nil then
    Serialize := Factory.ThreadModel = tmSingleThread
  else
    Serialize := ThreadModel = tmSingleThread;
  CreateSkeleton(PChar(Pointer(InterfaceName)), Self, Serialize,
    PChar(Pointer(InstanceName)),  PChar(Pointer(RepositoryID)),
      ClientRefCount, FSkeleton);
end;

procedure TCorbaSkeleton.GetSkeleton(out Skeleton: ISkeleton);
begin
  Skeleton := FSkeleton;
end;

procedure TCorbaSkeleton.GetImplementation(out Impl: IObject);
begin
  Impl := nil;
end;

function TCorbaSkeleton.Execute(Operation: PChar; const Strm: IMarshalInBuffer;
 Cookie: Pointer): CorbaBoolean;
var
  M: TUnmarshalProc;
begin
  Result := False;
  try
    TMethod(M).Code := Self.MethodAddress(Operation);
    if TMethod(M).Code = nil then Exit;
    TMethod(M).Data := Self;
    M(Strm, Cookie);
  except
    Exit;
  end;
  Result := True;
end;

{ TCorbaStub }

constructor TCorbaStub.Create(const Stub: IStub);
begin
  inherited Create;
  FStub := Stub;
end;

destructor TCorbaStub.Destroy;
begin
  try
    FStub := nil;
  except
    // Ignore exceptions when disconnecting
  end;
  inherited Destroy;
end;

procedure TCorbaStub.GetStub(out Stub :IStub); stdcall;
begin
  Stub := FStub;
end;

function TCorbaStub.Hash(Maximum: Integer): Integer;
begin
  Result := Integer(FStub.Hash(CorbaULong(Maximum)));
end;

function TCorbaStub.IsA(const LogicalTypeId: string): Boolean;
begin
  Result := FStub.IsA(Pointer(LogicalTypeId));
end;

function TCorbaStub.NonExistent: Boolean;
begin
  Result := FStub.NonExistent;
end;

procedure TCorbaStub.SetPrincipal(const Prinicpal: TCorbaPrincipal);
begin
  FStub.SetPrincipal(@Prinicpal[0], High(Prinicpal) + 1);
end;

{ TCorbaDispatchStub }

const
  E_NOTIMPL = HResult($80004001);

function TCorbaDispatchStub.GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TCorbaDispatchStub.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := E_NOTIMPL;
end;

function TCorbaDispatchStub.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TCorbaDispatchStub.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  Result := E_NOTIMPL;
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

{ TCorbaInterfaceIDManager }

function TCorbaInterfaceIDManager.FindID(const IID: TGUID): string;
begin
  if not SearchID(IID, Result) then
    raise ECorbaException.CreateRes(@SCorbaInterfaceIDNotRegister);
end;

function TCorbaInterfaceIDManager.FindGUID(const RepositoryID: string): TGUID;
begin
  if not SearchGUID(RepositoryID, Result) then
    raise ECorbaException.CreateResFmt(@SCorbaRepositoryIDNotRegistered, [RepositoryID]);
end;

procedure TCorbaInterfaceIDManager.RegisterInterface(const IID: TGUID;
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

function TCorbaInterfaceIDManager.SearchGUID(const RepositoryID: string;
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

function TCorbaInterfaceIDManager.SearchID(const IID: TGUID;
  out RepositoryID: string): Boolean;
var
  I: Integer;
begin
  BeginRead;
  try
    for I := 0 to FUsed - 1 do
      if IsEqualGUID(FList[I].IID, IID) then
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

{ TCorbaSkeletonManager }

procedure TCorbaSkeletonManager.RegisterSkeleton(IID: TGUID;
  Skeleton: TCorbaSkeletonClass);
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
    FList[FUsed].SkeletonClass := Skeleton;
    Inc(FUsed);
  finally
    EndWrite;
  end;
end;

function TCorbaSkeletonManager.CreateSkeleton(IID: TGUID;
  const InstanceName: string; const Impl: IObject): ISkeletonObject;
var
  I: Integer;
begin
  BeginRead;
  try
    for I := 0 to FUsed - 1 do
      if IsEqualGUID(FList[I].IID, IID) then
      begin
        Result := FList[I].SkeletonClass.Create(InstanceName, Impl);
        Exit;
      end;
  finally
    EndRead;
  end;
  raise Exception.CreateResFmt(@SCorbaSkeletonNotRegistered, [InstanceName]);
end;

{ TCorbaStubManager }

procedure TCorbaStubManager.RegisterStub(IID: TGUID; Stub: TCorbaStubClass);
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
    FList[FUsed].StubClass := Stub;
    Inc(FUsed);
  finally
    EndWrite;
  end;
end;

function TCorbaStubManager.CreateStub(IID: TGUID; const Stub: IStub): IObject;
var
  I: Integer;
begin
  BeginRead;
  try
    for I := 0 to FUsed - 1 do
      if IsEqualGUID(FList[I].IID, IID) then
      begin
        Result := FList[I].StubClass.Create(Stub);
        Exit;
      end;
  finally
    EndRead;
  end;
  raise Exception.CreateRes(@SCorbaStubNotRegistered);
end;

{ TCorbaImplementation }

constructor TCorbaImplementation.Create(Controller: IObject; AFactory: TCorbaFactory);
begin
  inherited Create;
  FFactory := AFactory;
  FController := Pointer(Controller);
end;

function TCorbaImplementation._AddRef: Integer;
begin
  if Assigned(FController) then
    Result := IObject(FController)._AddRef else
    Result := ObjAddRef;
end;

function TCorbaImplementation._Release: Integer;
begin
  if Assigned(FController) then
    Result := IObject(FController)._Release else
    Result := ObjRelease;
end;

function TCorbaImplementation.ObjAddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TCorbaImplementation.ObjQueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TCorbaImplementation.ObjRelease: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
  if Result = 0 then Destroy;
end;

function TCorbaImplementation.QueryInterface(const IID: TGUID;
  out Obj): HResult;
begin
  if Assigned(FController) then
    Result := IObject(FController).QueryInterface(IID, Obj) else
    Result := ObjQueryInterface(IID, Obj);
end;

function TCorbaImplementation.GetIDsOfNames(const IID: TGUID;
  Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TCorbaImplementation.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Result := FFactory.GetTypeInfo(TypeInfo);
end;

function TCorbaImplementation.GetTypeInfoCount(
  out Count: Integer): HResult;
begin
  Count := 1;
  Result := S_OK;
end;

function TCorbaImplementation.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

{ TCorbaFactory }

constructor TCorbaFactory.Create(const InterfaceName, InstanceName,
  RepositoryId: string; const ImplGUID: TGUID;
  Instancing: TCorbaInstancing;
  ThreadModel: TCorbaThreadModel);
begin
  inherited Create;
  FIID := ImplGUID;
  FInterfaceName := InterfaceName;
  FInstanceName := InstanceName;
  FRepositoryId := RepositoryId;
  FInstancing := Instancing;
  FThreadModel := ThreadModel;
  CorbaFactoryManager.AddFactory(Self);
end;

destructor TCorbaFactory.Destroy;
begin
  FSkeleton := nil;
  inherited Destroy;
end;

procedure TCorbaFactory.GetSkeleton(out Skeleton: ISkeleton);
begin
  Skeleton := FSkeleton;
end;

procedure TCorbaFactory.GetImplementation(out Impl: IObject);
begin
  impl := nil;
end;

function TCorbaFactory.Execute(Operation: PChar; const Strm: IMarshalInBuffer;
 Cookie: Pointer): CorbaBoolean;
var
  InstanceName: string;
  OutBuff: IMarshalOutBuffer;
  Skeleton: ISkeleton;
begin
  Result := False;
  if CompareStr(Operation, 'CreateInstance') <> 0 then Exit;
  InstanceName := UnmarshalText(Strm);
  if FSingleInstanceSkelton <> nil then
    with FSingleInstanceSkelton do
    begin
      _AddRef;
      GetSkeleton(Skeleton);
    end
  else
    with CreateInstance(InstanceName) do
      GetSkeleton(Skeleton);
  FSkeleton.GetReplyBuffer(Cookie, OutBuff);
  OutBuff.PutObject(Skeleton);
  Result := True;
end;

procedure TCorbaFactory.RegisterFactory;
begin
  CreateSkeleton(PChar(Pointer(FInterfaceName)), Self, True,
    PChar(Pointer(FInstanceName)), PChar(Pointer(FRepositoryId)), False,
    FSkeleton);
  BOA.ObjIsReady(FSkeleton);
  if FInstancing = iSingleInstance then
    FSingleInstanceSkelton := CreateInstance('');
end;

function TCorbaFactory.CreateInstance(const InstanceName: string): ISkeletonObject;
var
  Intf: IObject;
begin
  Intf := CreateInterface(InstanceName);
  Result := CorbaSkeletonManager.CreateSkeleton(FIID, InstanceName, Intf);
  if Assigned(Result) then Result._AddRef;
end;

function TCorbaFactory.CreateInterface(const InstanceName: string): IObject;
begin
  raise ECorbaException.CreateRes(@SCorbaIncompleteFactory);
end;

function TCorbaFactory.GetTypeInfo(out TypeInfo): HRESULT;
var
  TypeLib: ITypeLib;
  Buffer: array[0..261] of Char;
begin
  if not Assigned(FTypeInfo) then
  begin
    Windows.GetModuleFileName(HInstance, Buffer, SizeOf(Buffer));
    Result := LoadTypeLib(PWideChar(WideString(Buffer)), TypeLib);
    if Result <> S_OK then Exit;
    Result := TypeLib.GetTypeInfoOfGUID(FIID, FTypeInfo);
    if Result <> S_OK then Exit;
  end;
  ITypeInfo(TypeInfo) := FTypeInfo;
  Result := S_OK;
end;

{ TCorbaFactoryManager }

destructor TCorbaFactoryManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to FUsed - 1 do FList[I].Free;
  inherited Destroy;
end;

procedure TCorbaFactoryManager.AddFactory(Factory: TCorbaFactory);
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
    FList[FUsed] := Factory;
    Inc(FUsed);
  finally
    EndWrite;
  end;
  if FRegistered then Factory.RegisterFactory;
end;

procedure TCorbaFactoryManager.RegisterFactories;
var
  DoRegister: Boolean;
  Used: Integer;
  I: Integer;
begin
  if not FRegistered then
  begin
    // Assumes only adding of factories are possible.
    // If removing is possilbe the Read/Write blocks need to be nested.
    BeginWrite;
    try
      Used := FUsed;
      DoRegister := not FRegistered;
      FRegistered := True;
    finally
      EndWrite;
    end;
    if DoRegister then
    begin
      BeginRead;
      try
        for I := 0 to Used - 1 do FList[I].RegisterFactory;
      finally
        EndRead;
      end;
    end;
  end;
end;

function TCorbaFactoryManager.Find(const RepositoryID, InterfaceName,
  InstanceName: string): TCorbaFactory;
var
  I: Integer;
begin
  if (InterfaceName <> '') or (RepositoryID <> '') then
  begin
    BeginRead;
    try
      for I := 0 to FUsed - 1 do
      begin
        Result := FList[I];
        if ((RepositoryID = '') or (RepositoryID = Result.RepositoryID)) and
          ((InterfaceName = '') or (InterfaceName = Result.InterfaceName)) and
          ((InstanceName = '') or (InstanceName = Result.InstanceName)) then
          Exit;
      end;
      Result := nil;
    finally
      EndRead;
    end;
  end
  else Result := nil;
end;

{ TCorbaObjectFactory }

constructor TCorbaObjectFactory.Create(const InterfaceName, InstanceName,
  RepositoryId: string; const ImplGUID: TGUID;
  ImplementationClass: TCorbaImplementationClass;
  Instancing: TCorbaInstancing; ThreadModel: TCorbaThreadModel);
begin
  inherited Create(InterfaceName, InstanceName, RepositoryID, ImplGUID,
    Instancing, ThreadModel);
  FImplementationClass := ImplementationClass;
end;

function TCorbaObjectFactory.CreateInterface(const InstanceName: string): IObject;
begin
  Result := FImplementationClass.Create(nil, Self);
end;

{ TBOA }

class procedure TBOA.Initialize(const CommandLine: TCommandLine);
begin
  if CorbaObj.BOAVar = nil then
  begin
    CorbaObj.BOAVar := TBOA.Create;
    CorbaObj.ORBVar.ORB.BOAInit(Length(CommandLine), CommandLine, CorbaObj.BOAVar.BOA);
  end;
end;

function TBOA.GetPrincipal(const Obj: IObject): TCorbaPrincipal;
var
  Length: Integer;
  Skeleton: ISkeleton;
begin
  if Obj.QueryInterface(ISkeleton, Skeleton) <> S_OK then
    (Obj as ISkeletonObject).GetSkeleton(Skeleton);
  Length := BOA.GetPrincipalLength(Skeleton);
  SetLength(Result, Length);
  BOA.GetPrincipal(Skeleton, @Result[0]);
end;

procedure TBOA.Deactivate(const Obj: IObject);
begin
  BOA.Deactivate(Obj as ISkeleton);
end;

procedure TBOA.ImplIsReady;
begin
  BOA.ImplIsReady;
end;

procedure TBOA.ObjIsReady(const Obj: IObject);
begin
  BOA.ObjIsReady(Obj as ISkeleton);
end;

{ TORB }
class procedure TORB.Initialize(const CommandLine: TCommandLine);
begin
  CorbaObj.ORBVar := TORB.Create;
  InitORB(CommandLine, CorbaObj.ORBVar.ORB);
end;

class procedure TORB.Initialize;
var
  CommandLine: TCommandLine;
  I: Integer;
begin
  if CorbaObj.ORBVar = nil then
  begin
    SetLength(CommandLine, ParamCount + 1);
    for I := 0 to ParamCount do CommandLine[I] := ParamStr(I);
    Initialize(CommandLine);
    if BOAVar = nil then TBOA.Initialize(CommandLine);
  end;
end;

function InternalBind(const RepositoryID, ObjectName, HostName: string): IStub;
begin
  BindStub(PChar(Pointer(RepositoryID)), PChar(Pointer(ObjectName)),
    PChar(Pointer(HostName)), ORB.ORB,
    False, Result)
end;

function TORB.Bind(const InterfaceID: TGUID; const ObjectName,
  HostName: string): IObject;
begin
  Result := CorbaStubManager.CreateStub(InterfaceID,
    InternalBind(CorbaInterfaceIDManager.FindID(InterfaceID),
    ObjectName, HostName));
end;

function TORB.Bind(const RepositoryID, ObjectName, HostName: string): IObject;
var
  Stub: IStub;
  IID: TGUID;
begin
  Stub := InternalBind(RepositoryID, ObjectName, HostName);
  if not CorbaInterfaceIDManager.SearchGUID(RepositoryID, IID) then
    IID := IStub;
  Result := CorbaStubManager.CreateStub(IID, Stub);
end;

function TORB.ObjectToString(const Obj: IObject): string;
var
  Stub: IStub;
  P: PChar;
begin
  if Obj.QueryInterface(IStub, Stub) <> S_OK then
    (Obj as IStubObject).GetStub(Stub);
  P := ORB.ObjectToString(Stub);
  Result := P;
  CorbaStringFree(P);
end;

function TORB.StringToObject(const ObjectString: string): IObject;
var
  Stub: IStub;
  ID: PChar;
begin
  ORB.StringToObject(PChar(Pointer(ObjectString)), Stub);
  if Stub = nil then
    Result := nil
  else
  begin
    ID := Stub.RepositoryID;
    try
      Result := CorbaStubManager.CreateStub(CorbaInterfaceIDManager.FindGUID(ID), Stub);
    finally
      CorbaStringFree(ID);
    end;
  end;
end;

procedure TORB.Shutdown;
begin
  ORB.Shutdown;
end;

{ Dynamic invocation helper methods }

function TORB.FindTypeCode(const RepositoryID: string): ITypeCode;
begin
  ORB.FindRepositoryTC(PChar(RepositoryID), Result);
end;

function TORB.MakeArray(Kind: TCKind; const Elements: array of TAny): TAny;
var
  TC: ITypeCode;
begin
  ORB.CreateTC(Kind, TC);
  Result := MakeArray(TC, Elements);
end;

function TORB.MakeArray(TypeCode: ITypeCode; const Elements: array of TAny): TAny;
begin
  Result := MakeComplexAny(TypeCode, Elements);
end;

function TORB.MakeSequence(Kind: TCKind; const Elements: array of TAny): TAny;
var
  TC: ITypeCode;
begin
  ORB.CreateTC(Kind, TC);
  Result := MakeSequence(TC, Elements);
end;

function TORB.MakeSequence(TypeCode: ITypeCode; const Elements: array of TAny): TAny;
begin
  Result := MakeComplexAny(TypeCode, Elements);
end;

const
  reVarNotArray       = 19;

function GetVarArray(const A: Variant): PSafeArray;
begin
  if TVarData(A).VType and varArray = 0 then RunError(reVarNotArray);
  if TVarData(A).VType and varByRef <> 0 then
    Result := PSafeArray(TVarData(A).VPointer^) else
    Result := PSafeArray(TVarData(A).VArray);
end;

function TORB.MakeStructure(TypeCode: ITypeCode; const Elements: array of TAny): TAny;
begin
  Result := MakeComplexAny(TypeCode, Elements);
end;

function TORB.MakeAlias(const RepositoryID, TypeName: string; Value, Test: TAny): TAny;
var
  Temp: Variant;
  TC, TC2: ITypeCode;
begin
  TVarData(Temp).VAny := CorbaDuplicateAny(VariantToAny(@Value));
  TVarData(Temp).VType := varAny;
  CorbaAnyType(TVarData(Temp).VAny, TC);
  ORB.CreateAliasTC(PChar(Pointer(RepositoryID)), PChar(Pointer(TypeName)),
    TC, TC2);
  TVarData(Result).VAny := ORB.MakeAny(TC2, [Temp]);
  TVarData(Result).VType := varAny;
end;

function TORB.MakeTypeCode(Kind: TCKind): ITypeCode;
begin
  ORB.CreateTC(Kind, Result);
end;

function TORB.MakeSequenceTypeCode(Bound: CorbaULong; const TC: ITypeCode): ITypeCode;
begin
  ORB.CreateSequenceTC(Bound, TC, Result);
end;

function TORB.MakeStructureTypeCode(const RepositoryID, Name: string; Members: TStructMembers): ITypeCode;
begin
  ORB.CreateStructTC(tk_struct, PChar(Pointer(RepositoryID)), PChar(Pointer(Name)),
    Members, Length(Members), Result);
end;

function TORB.MakeAliasTypeCode(const RepositoryID, Name: string; const TC: ITypeCode): ITypeCode;
begin
  ORB.CreateAliasTC(PChar(Pointer(RepositoryID)), PChar(Pointer(Name)), TC, Result);
end;

function TORB.MakeObjectRefTypeCode(const RepositoryID, Name: string): ITypeCode;
begin
  ORB.CreateObjRefTC(PChar(Pointer(RepositoryID)), PChar(Pointer(Name)), Result);
end;

function TORB.MakeComplexAny(TypeCode: ITypeCode; const Elements: array of TAny): TAny;
begin
  TVarData(Result).VType := varAny;
  TVarData(Result).VAny := ORB.MakeAny(TypeCode, Elements);
end;

function VariantArrayToSequence(TypeCode: ITypeCode; const VariantArray: Variant): TAny;
type
  PAnyArray = ^TAnyArray;
  TAnyArray = array[0..100] of TAny;
var
  P: PAnyArray;
  I, C: Integer;
begin
  if TVarData(VariantArray).VType <> varVariant or varArray then
    raise ECorbaDispatch.Create(sInvalidTypeCast)
  else
  begin
    I := VarArrayLowBound(VariantArray, 1);
    C := VarArrayHighBound(VariantArray, 1) - I + 1;
    if SafeArrayPtrOfIndex(GetVarArray(VariantArray), I, Pointer(P)) <> 0 then
      raise ECorbaDispatch.Create(sInvalidTypeCast);
    Result := ORB.MakeComplexAny(TypeCode, Slice(PAnyArray(P)^, C));
  end;
end;

function SequenceToVariantArray(Sequence: TAny): Variant;
begin
  if (TVarData(Sequence).VType and varArray <> 0) then
    Result := Sequence
  else if (TVarData(Sequence).VType <> varAny) or
    not SequenceToVariant(PCorbaAny(TVarData(Sequence).VPointer), @Result) then
    raise ECorbaDispatch.Create(sInvalidTypeCast);
end;

function AnyToObject(Any: TAny; IID: TGUID): IObject;
var
  Unk: IUnknown;
  Obj: ICorbaObj;
begin
  Unk := Any;
  Obj := Unk as ICorbaObj;
  if Obj.IsLocal then
    with Obj as ISkeleton do
      GetImplementation(Result)
  else
    Result := CorbaStubManager.CreateStub(IID, Obj as IStub);
end;

{ Marshalling methods }

procedure MarshalObject(const OutBuf: IMarshalOutBuffer; IID: TGUID;
  const Intf: IObject);
var
  StubObject: IStubObject;
  Stub: IStub;
  Skeleton: ISkeleton;
begin
  if Intf = nil then
  begin
    OutBuf.PutObject(nil);
    Exit;
  end;
  if Intf.QueryInterface(IStubObject, StubObject) = 0 then
  begin
    StubObject.GetStub(Stub);
    OutBuf.PutObject(Stub);
  end
  else
  begin
    with CorbaSkeletonManager.CreateSkeleton(IID, '', Intf) do
    begin
      _AddRef;
      GetSkeleton(Skeleton);
    end;
    OutBuf.PutObject(Skeleton);
  end;
end;

function UnmarshalObject(const InBuf: IMarshalInBuffer; IID: TGUID): IObject;
var
  Obj: ICorbaObj;
begin
  InBuf.GetObject(Obj);
  if Obj = nil then
  begin
    Result := nil;
    Exit;
  end;
  if Obj.IsLocal then
    with Obj as ISkeleton do
      GetImplementation(Result)
  else
    Result := CorbaStubManager.CreateStub(IID, Obj as IStub);
end;

procedure MarshalAny(const OutBuf: IMarshalOutBuffer; const OV: Variant);
var
  Temp: PCorbaAny;
begin
  Temp := VariantToAny(@OV);
  try
    OutBuf.PutAny(Temp);
  finally
    CorbaReleaseAny(Temp)
  end;
end;

function UnmarshalAny(const InBuf: IMarshalInBuffer): Variant;
var
  Temp: PCorbaAny;
begin
  Temp := InBuf.GetAny;
  try
    if not AnyToVariant(Temp, @Result) then
    begin
      TVarData(Result).VType := varAny;
      TVarData(Result).VAny := CorbaDuplicateAny(Temp);
      Exit;
    end
  finally
    CorbaReleaseAny(Temp);
  end;
end;

function UnmarshalText(const InBuf: IMarshalInBuffer): string;
var
  Temp: PChar;
begin
  Temp := InBuf.GetText;
  if (Temp <> nil) and (Temp[0] = #0) then
    Result := ''
  else
    Result := Temp;
  CorbaStringFree(Temp);
end;

function UnmarshalWideText(const InBuf: IMarshalInBuffer): WideString;
var
  Temp: PWideChar;
begin
  Temp := InBuf.GetWideText;
  Result := Temp;
  CorbaWStringFree(Temp);
end;

procedure MarshalWordBool(const OutBuf: IMarshalOutBuffer; Value: WordBool);
begin
  if Value then
    OutBuf.PutUnsignedChar(1)
  else
    OutBuf.PutUnsignedChar(0);
end;

function UnmarshalWordBool(const InBuf: IMarshalInBuffer): WordBool;
begin
  Result := InBuf.GetUnsignedChar <> 0;
end;

function CorbaFactoryCreateStub(const RepId, FactoryId, InstanceName, HostName: string;
  IID: TGUID): IObject;
var
  Factory: IStub;
  OutBuf: IMarshalOutBuffer;
  InBuf: IMarshalInBuffer;
  Obj: ICorbaObj;
begin
  BindStub(PChar(Pointer(RepId)), PChar(Pointer(FactoryId)),
    PChar(Pointer(HostName)), ORB.ORB, False, Factory);
  Factory.CreateRequest('CreateInstance', True, OutBuf);
  OutBuf.PutText(PChar(Pointer(InstanceName)));
  Factory.Invoke(OutBuf, InBuf);
  InBuf.GetObject(Obj);
  Result := CorbaStubManager.CreateStub(IID, Obj as IStub);
end;

procedure CorbaHookDispatch; forward;
procedure CorbaHookExceptions; forward;

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

var
  Initialized: Boolean = False;
  
procedure CorbaInitialize;
begin
  if Initialized then Exit;
  Initialized := True;
  TORB.Initialize;
  CorbaFactoryManager.RegisterFactories;
  CorbaHookDispatch;
  CorbaHookExceptions;
end;

function CorbaBind(const RepositoryID: string; const ObjectName: string = '';
  const HostName: string = ''): IObject;
begin
  Result := ORB.Bind(RepositoryID, ObjectName, HostName);
end;

function CorbaBind(const InterfaceID: TGUID; const ObjectName: string = '';
  const HostName: string = ''): IObject;
begin
  Result := ORB.Bind(InterfaceID, ObjectName, HostName);
end;

function MakePrincipal(const Bytes: array of Byte): TCorbaPrincipal;
begin
  SetLength(Result, High(Bytes) + 1);
  Move(Bytes[0], Result[0], High(Bytes) + 1);
end;

{ CORBA Dispatch }

var
  OldVarDispProc: TVarDispProc;

procedure ClearAnyImpl(var V: Variant);
var
  P: Pointer;
begin
  if TVarData(V).VType = varAny then
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

procedure CorbaStructDispatch(Result: PVariant; const Instance: Variant;
  CallDesc: PCallDesc; Params: Pointer); cdecl; forward;
procedure CorbaObjectDispatch(Result: PVariant; const Instance: Variant;
  CallDesc: PCallDesc; Params: Pointer); cdecl; forward;

{$W-}
procedure CorbaDispProc;
asm
    MOV     EAX,[ESP+$8]
    CMP     [EAX].TVarData.VType,varAny
    JE      CorbaStructDispatch
    CMP     [EAX].TVarData.VType,varUnknown
    JE      CorbaObjectDispatch
    JMP     OldVarDispProc
end;

procedure CorbaDispatchError(Result: Integer; CallDesc: PCallDesc);
const
  NotCorbaObject = 0;
  InvalidParamCount = $1FFF;
  MethodNotFound = $1FFE;
  NoRepository = $1FFD;
var
  Msg: string;

  function MethodName: string;
  begin
    Result := PChar(@CallDesc^.ArgTypes[CallDesc^.ArgCount]);
  end;

begin
  case Result of
    InvalidParamCount: Msg := Format(sInvalidParameterCount, [MethodName]);
    MethodNotFound: Msg := Format(sMethodNotFound, [MethodName]);
    NoRepository: Msg := sNoRepository;
    NotCorbaObject: Msg := sNotCorbaObject;
  else
    if Result < 0 then
      Msg := Format(sParamOut, [-Result, MethodName]) else
      Msg := Format(sParamTypeCast, [Result, MethodName]);
  end;
  raise ECorbaDispatch.Create(Msg);
end;

procedure CorbaStructDispatch(Result: PVariant; const Instance: Variant;
  CallDesc: PCallDesc; Params: Pointer); cdecl;
var
  R: Integer;
  ProcResult: Variant;
begin
  if Result = nil then Result := @ProcResult;
  R := ORB.ORB.DispatchStruct(TVarData(Instance).VAny, CallDesc,
    Params, Result^);
  if R <> 0 then
    CorbaDispatchError(R, CallDesc)
  else if CallDesc.CallType = DISPATCH_PROPERTYPUT then
    PVariant(@Instance)^ := Result^;
end;

procedure CorbaObjectDispatch(Result: PVariant; const Instance: Variant;
  CallDesc: PCallDesc; Params: Pointer); cdecl;
var
  U: IUnknown;
  StubObject: IStubObject;
  Stub: IStub;
  R: Integer;
  ProcResult: Variant;
begin
  if Result = nil then Result := @ProcResult;
  U := IUnknown(Instance);
  if U.QueryInterface(IStubObject, StubObject) = 0 then
    StubObject.GetStub(Stub)
  else if U.QueryInterface(IStub, Stub) <> 0 then
    CorbaDispatchError(0, CallDesc);
  R := Stub.Dispatch(CallDesc, Params, Result^);
  if R <> 0 then CorbaDispatchError(R, CallDesc);
end;

procedure CorbaHookDispatch;
begin
  ClearAnyProc := @ClearAnyImpl;
  ChangeAnyProc := @ChangeAnyImpl;
  RefAnyProc := @RefAnyImpl;
  OldVarDispProc := VarDispProc;
  VarDispProc := @CorbaDispProc;
end;

procedure CorbaUnhookDispatch;
begin
  if @ClearAnyProc = @ClearAnyImpl then
  begin
    ClearAnyProc := nil;
    ChangeAnyProc := nil;
    RefAnyProc := nil;
  end;
  if @VarDispProc = @CorbaDispProc then
    VarDispProc := OldVarDispProc;
end;

{ Corba exception mapper }
type
  TExceptClassProc = function (P: PExceptionRecord): ExceptClass;
  TExceptObjectProc = function (P: PExceptionRecord): Exception;

var
  OldExceptClassProc: TExceptClassProc;
  OldExceptObjectProc: TExceptObjectProc;

const
  cCPPException = $EEFFACE;

function IsCorba(P: PChar): Boolean;
begin
  Result := (P <> nil) and (StrLComp('CORBA_', P, 6) = 0);
end;

function CorbaGetExceptClass(P: PExceptionRecord): ExceptClass;
begin
  if (P.ExceptionCode = cCPPException) and
    IsCorba(PChar(P.ExceptionInformation[0])) then
    Result := ECorbaException else
    Result := OldExceptClassProc(P);
end;

function CorbaGetExceptObject(P: PExceptionRecord): Exception;
begin
  if (P.ExceptionCode = cCPPException) and
    IsCorba(PChar(P.ExceptionInformation[0])) then
    Result := ECorbaException.Create(PChar(@PChar(P.ExceptionInformation[0])[6])) else
    Result := OldExceptObjectProc(P);
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
    ExceptObjProc := @OldExceptObjectProc;
  end;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Common\CorbaObj.pas initialization enter'); {$EndIf}
  CorbaSkeletonManager := TCorbaSkeletonManager.Create;
  CorbaStubManager := TCorbaStubManager.Create;
  CorbaFactoryManager := TCorbaFactoryManager.Create;
  CorbaInterfaceIDManager := TCorbaInterfaceIDManager.Create;
  CorbaStubManager.RegisterStub(IStub, TCorbaStub);

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Rtl\Common\CorbaObj.pas initialization leave'); {$EndIf}
finalization
  CorbaSkeletonManager.Free;
  CorbaStubManager.Free;
  CorbaFactoryManager.Free;
  CorbaInterfaceIDManager.Free;
  BOAVar.Free;
  ORBVar.Free;
  CorbaUnhookDispatch;
  CorbaUnhookExceptions;

end.
