{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{*******************************************************}
{       COM object support                              }
{*******************************************************}

unit System.Win.ComObj;

interface
{$HPPEMIT LEGACYHPP}

uses
{$IFDEF LINUX}
  WinUtils,
{$ENDIF}
  Winapi.Windows, Winapi.ActiveX, System.SysUtils, System.Classes;

type
{ Forward declarations }

  TComObjectFactory = class;

{ COM server abstract base class }

  TComServerObject = class(TObject)
  strict private
    class var FPerUserRegistration: Boolean;
  protected
    function CountObject(Created: Boolean): Integer; virtual; abstract;
    function CountFactory(Created: Boolean): Integer; virtual; abstract;
    function GetHelpFileName: string; virtual; abstract;
    function GetServerFileName: string; virtual; abstract;
    function GetServerKey: string; virtual; abstract;
    function GetServerName: string; virtual; abstract;
    function GetStartSuspended: Boolean; virtual; abstract;
    function GetTypeLib: ITypeLib; virtual; abstract;
    procedure SetHelpFileName(const Value: string); virtual; abstract;
  public
    class constructor Create;
    class procedure GetRegRootAndPrefix(var RootKey: HKEY; var RootPrefix: string);
    property HelpFileName: string read GetHelpFileName write SetHelpFileName;
    property ServerFileName: string read GetServerFileName;
    property ServerKey: string read GetServerKey;
    property ServerName: string read GetServerName;
    property TypeLib: ITypeLib read GetTypeLib;
    property StartSuspended: Boolean read GetStartSuspended;
    class property PerUserRegistration: Boolean read FPerUserRegistration write FPerUserRegistration;
  end;

{ COM class manager }

  TFactoryProc = procedure(Factory: TComObjectFactory) of object;


  TComClassManager = class(TObject)
  private
    FFactoryList: TComObjectFactory;
    FLock: TMultiReadExclusiveWriteSynchronizer;
    procedure AddObjectFactory(Factory: TComObjectFactory);
    procedure RemoveObjectFactory(Factory: TComObjectFactory);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ForEachFactory(ComServer: TComServerObject;
      FactoryProc: TFactoryProc);
    function GetFactoryFromClass(ComClass: TClass): TComObjectFactory;
    function GetFactoryFromClassID(const ClassID: TGUID): TComObjectFactory;
  end;

{ IServerExceptionHandler }

{ This interface allows you to report safecall exceptions that occur in a
  TComObject server to a third party, such as an object that logs errors into
  the system event log or a server monitor residing on another machine.
  Obtain an interface from the error logger implementation and assign it
  to your TComObject's ServerExceptionHandler property.  Each TComObject
  instance can have its own server exception handler, or all instances can
  share the same handler.  The server exception handler can override the
  TComObject's default exception handling by setting Handled to True and
  assigning an OLE HResult code to the HResult parameter. }


  IServerExceptionHandler = interface
    ['{6A8D432B-EB81-11D1-AAB1-00C04FB16FBC}']
    procedure OnException(
      const ServerClass, ExceptionClass, ErrorMessage: WideString;
      ExceptAddr: NativeInt; const ErrorIID, ProgID: WideString;
      var Handled: Integer; var Result: HResult); dispid 2;
  end;

{ COM object }

  TComObject = class(TObject, IUnknown, ISupportErrorInfo)
  private
    FController: Pointer;
    FFactory: TComObjectFactory;
    FNonCountedObject: Boolean;
    FRefCount: Integer;
    FServerExceptionHandler: IServerExceptionHandler;
    function GetController: IUnknown;
  protected
    { IUnknown }
    function IUnknown.QueryInterface = ObjQueryInterface;
    function IUnknown._AddRef = ObjAddRef;
    function IUnknown._Release = ObjRelease;
    { IUnknown methods for other interfaces }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { ISupportErrorInfo }
    function InterfaceSupportsErrorInfo(const iid: TIID): HResult; stdcall;
  public
    constructor Create;
    constructor CreateAggregated(const Controller: IUnknown);
    constructor CreateFromFactory(Factory: TComObjectFactory;
                                  const Controller: IUnknown);
    destructor Destroy; override;
    procedure Initialize; virtual;
    function ObjAddRef: Integer; virtual; stdcall;
    function ObjQueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function ObjRelease: Integer; virtual; stdcall;
{$IFDEF MSWINDOWS}
    function SafeCallException(ExceptObject: TObject;
      ExceptAddr: Pointer): HResult; override;

    function Error(const Msg: string): HResult; overload; stdcall;
    function Error(const Msg: string; const IID: TGUID;
                   hRes: HRESULT = DISP_E_EXCEPTION): HResult; overload; stdcall;
    class function Error(const Msg: string; HelpID: DWORD;
                         const HelpFile: string;
                         const IID: TGUID;
                         hRes: HResult = DISP_E_EXCEPTION): HResult; overload; static; stdcall;
{$ENDIF}

    property Controller: IUnknown read GetController;
    property Factory: TComObjectFactory read FFactory;
    property RefCount: Integer read FRefCount;
    property ServerExceptionHandler: IServerExceptionHandler
      read FServerExceptionHandler write FServerExceptionHandler;
  end;

{ COM class }

  TComClass = class of TComObject;

{ Instancing mode for COM classes }

  TClassInstancing = (ciInternal, ciSingleInstance, ciMultiInstance);

{ Threading model supported by COM classes }

  TThreadingModel = (tmSingle, tmApartment, tmFree, tmBoth, tmNeutral);

{ COM object factory }

  TComObjectFactory = class(TObject, IUnknown, IClassFactory, IClassFactory2)
  private
    FNext: TComObjectFactory;
    FComServer: TComServerObject;
    FComClass: TClass;
    FClassID: TGUID;
    FClassName: string;
    FDescription: string;
    FErrorIID: TGUID;
    FInstancing: TClassInstancing;
    FLicString: WideString;
    FRegister: Longint;
    FShowErrors: Boolean;
    FSupportsLicensing: Boolean;
    FThreadingModel: TThreadingModel;
  protected
    function GetProgID: string; virtual;
    function GetLicenseString: WideString; virtual;
    function HasMachineLicense: Boolean; virtual;
    function ValidateUserLicense(const LicStr: WideString): Boolean; virtual;
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    { IClassFactory }
    function CreateInstance(const UnkOuter: IUnknown; const IID: TGUID;
      out Obj): HResult; stdcall;
    function LockServer(fLock: BOOL): HResult; stdcall;
    { IClassFactory2 }
    function GetLicInfo(var licInfo: TLicInfo): HResult; stdcall;
    function RequestLicKey(dwResrved: Longint; out bstrKey: WideString): HResult; stdcall;
    function CreateInstanceLic(const unkOuter: IUnknown; const unkReserved: IUnknown;
      const iid: TIID; const bstrKey: WideString; out vObject): HResult; stdcall;
  public
    constructor Create(ComServer: TComServerObject; ComClass: TComClass;
      const ClassID: TGUID; const ClassName, Description: string;
      Instancing: TClassInstancing; ThreadingModel: TThreadingModel = tmSingle);
    destructor Destroy; override;
    function CreateComObject(const Controller: IUnknown): TComObject; virtual;
    procedure RegisterClassObject;
    procedure UpdateRegistry(Register: Boolean); virtual;
    property ClassID: TGUID read FClassID;
    {$WARN HIDING_MEMBER OFF}
    property ClassName: string read FClassName;
    {$WARN HIDING_MEMBER ON}
    property ComClass: TClass read FComClass;
    property ComServer: TComServerObject read FComServer;
    property Description: string read FDescription;
    property ErrorIID: TGUID read FErrorIID write FErrorIID;
    property LicString: WideString read FLicString write FLicString;
    property ProgID: string read GetProgID;
    property Instancing: TClassInstancing read FInstancing;
    property ShowErrors: Boolean read FShowErrors write FShowErrors;
    property SupportsLicensing: Boolean read FSupportsLicensing write FSupportsLicensing;
    property ThreadingModel: TThreadingModel read FThreadingModel;
  end;

  { NOTE: TAggregatedObject and TContainedObject have been moved into the System unit. }

  TTypedComObject = class(TComObject, IProvideClassInfo)
  protected
    { IProvideClassInfo }
    function GetClassInfo(out TypeInfo: ITypeInfo): HResult; stdcall;
  public
    constructor Create;
    constructor CreateAggregated(const Controller: IUnknown);
    constructor CreateFromFactory(Factory: TComObjectFactory;
                                  const Controller: IUnknown);
  end;

  TTypedComClass = class of TTypedComObject;

  TTypedComObjectFactory = class(TComObjectFactory)
  private
    FClassInfo: ITypeInfo;
  public
    constructor Create(ComServer: TComServerObject;
      TypedComClass: TTypedComClass; const ClassID: TGUID;
      Instancing: TClassInstancing; ThreadingModel: TThreadingModel = tmSingle);
    function GetInterfaceTypeInfo(TypeFlags: Integer): ITypeInfo;
    procedure UpdateRegistry(Register: Boolean); override;
    {$WARN HIDING_MEMBER OFF}
    property ClassInfo: ITypeInfo read FClassInfo;
    {$WARN HIDING_MEMBER ON}
  end;

{ OLE Automation object }

  TConnectEvent = procedure (const Sink: IUnknown; Connecting: Boolean) of object;

  TAutoObjectFactory = class;

  TAutoObject = class(TTypedComObject, IDispatch)
  private
    FEventSink: IUnknown;
    FAutoFactory: TAutoObjectFactory;
  protected
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; virtual; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; virtual; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; virtual; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; virtual; stdcall;
    { Other methods }
    procedure EventConnect(const Sink: IUnknown; Connecting: Boolean);
    procedure EventSinkChanged(const EventSink: IUnknown); virtual;
    property AutoFactory: TAutoObjectFactory read FAutoFactory;
    property EventSink: IUnknown read FEventSink write FEventSink;
  public
    constructor Create;
    constructor CreateAggregated(const Controller: IUnknown);
    constructor CreateFromFactory(Factory: TComObjectFactory;
                                  const Controller: IUnknown);
    procedure Initialize; override;
  end;

{ OLE Automation class }

  TAutoClass = class of TAutoObject;

{ OLE Automation object factory }

  TAutoObjectFactory = class(TTypedComObjectFactory)
  private
    FDispTypeInfo: ITypeInfo;
    FDispIntfEntry: PInterfaceEntry;
    FEventIID: TGUID;
    FEventTypeInfo: ITypeInfo;
  public
    constructor Create(ComServer: TComServerObject; AutoClass: TAutoClass;
      const ClassID: TGUID; Instancing: TClassInstancing;
      ThreadingModel: TThreadingModel = tmSingle);
    function GetIntfEntry(Guid: TGUID): PInterfaceEntry; virtual;
    property DispIntfEntry: PInterfaceEntry read FDispIntfEntry;
    property DispTypeInfo: ITypeInfo read FDispTypeInfo;
    property EventIID: TGUID read FEventIID;
    property EventTypeInfo: ITypeInfo read FEventTypeInfo;
  end;

  TAutoIntfObject = class(TInterfacedObject, IDispatch, ISupportErrorInfo)
  private
    FDispTypeInfo: ITypeInfo;
    FDispIntfEntry: PInterfaceEntry;
    FDispIID: TGUID;
  protected
    { IDispatch }
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
    { ISupportErrorInfo }
    function InterfaceSupportsErrorInfo(const iid: TIID): HResult; stdcall;
  public
    constructor Create(const TypeLib: ITypeLib; const DispIntf: TGUID);
{$IFDEF MSWINDOWS}
    function SafeCallException(ExceptObject: TObject;
      ExceptAddr: Pointer): HResult; override;
{$ENDIF}
    property DispIntfEntry: PInterfaceEntry read FDispIntfEntry;
    property DispTypeInfo: ITypeInfo read FDispTypeInfo;
    property DispIID: TGUID read FDispIID;
  end;
  
  
  TConnectionPoints = class;

  TConnectionKind = (ckSingle, ckMulti);

  TConnectionPoint = class(TContainedObject, IConnectionPoint)
  private
    FContainer: TConnectionPoints;
    FIID: TGUID;
    FSinkList: TList;
    FOnConnect: TConnectEvent;
    FKind: TConnectionKind;
    function AddSink(const Sink: IUnknown): Integer;
    procedure RemoveSink(Cookie: Longint);
  protected
    { IConnectionPoint }
    function GetConnectionInterface(out iid: TIID): HResult; stdcall;
    function GetConnectionPointContainer(
      out cpc: IConnectionPointContainer): HResult; stdcall;
    function Advise(const unkSink: IUnknown; out dwCookie: Longint): HResult; stdcall;
    function Unadvise(dwCookie: Longint): HResult; stdcall;
  public    
    function EnumConnections(out enumconn: IEnumConnections): HResult; stdcall;

    constructor Create(Container: TConnectionPoints;
      const IID: TGUID; Kind: TConnectionKind; OnConnect: TConnectEvent);
    function GetSink(Index: Integer; var punk: IUnknown): Boolean;
    function GetCount: Integer;

    property Count: Integer read GetCount;
    property SinkList : TList read FSinkList;
    destructor Destroy; override;
  end;

  // IConnectionPointContainer
  TConnectionPoints = class
  private
    FController: Pointer;  // weak reference to controller - don't keep it alive
    FConnectionPoints: TList;
    function GetController: IUnknown;
  protected
    { IConnectionPointContainer }
    function EnumConnectionPoints(
      out enumconn: IEnumConnectionPoints): HResult; stdcall;
    function FindConnectionPoint(const iid: TIID;
      out cp: IConnectionPoint): HResult; stdcall;
  public
    constructor Create(const AController: IUnknown);
    destructor Destroy; override;
    function CreateConnectionPoint(const IID: TGUID; Kind: TConnectionKind;
      OnConnect: TConnectEvent): TConnectionPoint;
    property Controller: IUnknown read GetController;
  end;

  TAutoObjectEvent = class(TAutoObject, IConnectionPointContainer)
  private
    FConnectionPoints: TConnectionPoints;
    FConnectionPoint: TConnectionPoint;
  protected
    property ConnectionPoints: TConnectionPoints read FConnectionPoints
      implements IConnectionPointContainer;
  public
    constructor Create;
    destructor Destroy; override;
    constructor CreateAggregated(const Controller: IUnknown);
    constructor CreateFromFactory(Factory: TComObjectFactory; const Controller: IUnknown);
    procedure Initialize; override;
    
    property ConnectionPoint: TConnectionPoint read FConnectionPoint;
  end;
  

{ OLE exception classes }

  EOleError = class(Exception);

  EOleSysError = class(EOleError)
  private
    FErrorCode: HRESULT;
  public
    constructor Create(const Message: UnicodeString; ErrorCode: HRESULT;
      HelpContext: Integer);
    property ErrorCode: HRESULT read FErrorCode write FErrorCode;
  end;

  EOleException = class(EOleSysError)
  private
    FSource: string;
    FHelpFile: string;
  public
    constructor Create(const Message: string; ErrorCode: HRESULT;
      const Source, HelpFile: string; HelpContext: Integer);
    property HelpFile: string read FHelpFile write FHelpFile;
    property Source: string read FSource write FSource;
  end;

  EOleRegistrationError = class(EOleSysError);

  TOleVariantArray = array of OleVariant;
  TEventDispatchInvoker = reference to procedure(DispId: Integer;
                                                 var Params: TOleVariantArray);

procedure DispatchInvoke(const Dispatch: IDispatch; CallDesc: PCallDesc;
  DispIDs: PDispIDList; Params: Pointer; Result: PVariant);
procedure DispatchInvokeError(Status: Integer; const ExcepInfo: TExcepInfo);

function HandleSafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer; const ErrorIID: TGUID; const ProgID,
  HelpFileName: WideString): HResult;

function CreateComObject(const ClassID: TGUID): IUnknown;
function CreateRemoteComObject(const MachineName: WideString; const ClassID: TGUID): IUnknown;
function CreateOleObject(const ClassName: string): IDispatch;
function GetActiveOleObject(const ClassName: string): IDispatch;

procedure OleError(ErrorCode: HResult);
procedure OleCheck(Result: HResult);

function StringToGUID(const S: string): TGUID;
function GUIDToString(const ClassID: TGUID): string;

function ProgIDToClassID(const ProgID: string): TGUID;
function ClassIDToProgID(const ClassID: TGUID): string;

procedure CreateRegKey(const Key, ValueName, Value: string; RootKey: HKEY = HKEY_CLASSES_ROOT);
procedure DeleteRegKey(const Key: string; RootKey: HKEY = HKEY_CLASSES_ROOT);
function GetRegStringValue(const Key, ValueName: string; RootKey: HKEY = HKEY_CLASSES_ROOT): string;

function StringToLPOLESTR(const Source: string): POleStr;

procedure RegisterComServer(const DLLName: string);
procedure RegisterAsService(const ClassID, ServiceName: string);

function CreateClassID: string;

procedure InterfaceConnect(const Source: IUnknown; const IID: TIID;
  const Sink: IUnknown; var Connection: Longint);
procedure InterfaceDisconnect(const Source: IUnknown; const IID: TIID;
  var Connection: Longint);

function GetDispatchPropValue(const Disp: IDispatch; DispID: Integer): OleVariant; overload;
function GetDispatchPropValue(const Disp: IDispatch; Name: WideString): OleVariant; overload;
procedure SetDispatchPropValue(const Disp: IDispatch; DispID: Integer;
  const Value: OleVariant); overload;
procedure SetDispatchPropValue(const Disp: IDispatch; Name: WideString;
  const Value: OleVariant); overload;

function EventDispatchInvoke(DispId: Integer; var ADispParams: TDispParams;
                             Invoker: TEventDispatchInvoker): HResult;

type
  TCoCreateInstanceExProc = function (const clsid: TCLSID;
    unkOuter: IUnknown; dwClsCtx: Longint; ServerInfo: PCoServerInfo;
    dwCount: Longint; rgmqResults: PMultiQIArray): HResult stdcall;
  {$EXTERNALSYM TCoCreateInstanceExProc}
  TCoInitializeExProc = function (pvReserved: Pointer;
    coInit: Longint): HResult; stdcall;
  {$EXTERNALSYM TCoInitializeExProc}
  TCoAddRefServerProcessProc = function :Longint; stdcall;
  {$EXTERNALSYM TCoAddRefServerProcessProc}
  TCoReleaseServerProcessProc = function :Longint; stdcall;
  {$EXTERNALSYM TCoReleaseServerProcessProc}
  TCoResumeClassObjectsProc = function :HResult; stdcall;
  {$EXTERNALSYM TCoResumeClassObjectsProc}
  TCoSuspendClassObjectsProc = function :HResult; stdcall;
  {$EXTERNALSYM TCoSuspendClassObjectsProc}

// COM functions that are only available on DCOM updated OSs
// These pointers may be nil on Win95 or Win NT 3.51 systems
var
  CoCreateInstanceEx: TCoCreateInstanceExProc = nil;
  {$EXTERNALSYM CoCreateInstanceEx}
  CoInitializeEx: TCoInitializeExProc = nil;
  {$EXTERNALSYM CoInitializeEx}
  CoAddRefServerProcess: TCoAddRefServerProcessProc = nil;
  {$EXTERNALSYM CoAddRefServerProcess}
  CoReleaseServerProcess: TCoReleaseServerProcessProc = nil;
  {$EXTERNALSYM CoReleaseServerProcess}
  CoResumeClassObjects: TCoResumeClassObjectsProc = nil;
  {$EXTERNALSYM CoResumeClassObjects}
  CoSuspendClassObjects: TCoSuspendClassObjectsProc = nil;
  {$EXTERNALSYM CoSuspendClassObjects}


{ CoInitFlags determines the COM threading model of the application or current
  thread. This bitflag value is passed to CoInitializeEx in ComServ initialization.
  Assign COINIT_APARTMENTTHREADED or COINIT_MULTITHREADED to this variable before
  Application.Initialize is called by the project source file to select a
  threading model.  Other CoInitializeEx flags (such as COINIT_SPEED_OVER_MEMORY)
  can be OR'd in also.  }
var
  CoInitFlags: Integer = -1;  // defaults to no threading model, call CoInitialize()

function ComClassManager: TComClassManager;

implementation

uses
  System.AnsiStrings,
  System.Types, System.Variants, System.VarUtils, System.Win.ComConst;

var
  OleUninitializing: Boolean;

const
  EAbortRaisedHRESULT =  HRESULT(E_ABORT or (1 shl 29)); // turn on customer bit

{ Handle a safe call exception }

function DoSetErrorInfo(const Description: WideString;
                        HelpContext: Integer;
                        ErrorCode: HResult;
                        const ErrorIID: TGUID;
                        const ProgID, HelpFileName: WideString): HResult;
var
  CreateError: ICreateErrorInfo;
  ErrorInfo: IErrorInfo;
begin
  Result := E_UNEXPECTED;
  if Succeeded(CreateErrorInfo(CreateError)) then
  begin
    CreateError.SetGUID(ErrorIID);
    if (ProgID <> '') then
      CreateError.SetSource(PWideChar(ProgID));
    if (HelpFileName <> '') then
      CreateError.SetHelpFile(PWideChar(HelpFileName));
    if (Description <> '') then
      CreateError.SetDescription(PWideChar(Description));
    if (HelpContext <> 0) then
      CreateError.SetHelpContext(HelpContext);
    if (ErrorCode <> 0) then
      Result := ErrorCode;
    if CreateError.QueryInterface(IErrorInfo, ErrorInfo) = S_OK then
      SetErrorInfo(0, ErrorInfo);
  end;
end;

function HandleSafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer; const ErrorIID: TGUID; const ProgID,
  HelpFileName: WideString): HResult;
var
  E: TObject;
  Description: WideString;
  HelpContext: Integer;
  ErrorCode: HResult;
begin
  E := ExceptObject;
  if E is Exception then
  begin
    Description := Exception(E).Message;
    HelpContext := Exception(E).HelpContext;
    if (E is EOleSysError) and (EOleSysError(E).ErrorCode < 0) then
      ErrorCode := EOleSysError(E).ErrorCode
    else if E is EAbort then
      ErrorCode := EAbortRaisedHRESULT
    else
      ErrorCode := 0;
  end
  else
  begin
    Description := '';
    HelpContext := -1;
    ErrorCode := 0;
  end;
  Result := DoSetErrorInfo(Description, HelpContext, ErrorCode, ErrorIID,
                           ProgID, HelpFileName);
end;

{ TDispatchSilencer }

type
  TDispatchSilencer = class(TInterfacedObject, IUnknown, IDispatch)
  private
    Dispatch: IDispatch;
    DispIntfIID: TGUID;
  public
    constructor Create(ADispatch: IUnknown; const ADispIntfIID: TGUID);
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    { IDispatch }
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer;
      NameCount, LocaleID: Integer; DispIDs: Pointer): HResult; stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
      Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult; stdcall;
  end;

constructor TDispatchSilencer.Create(ADispatch: IUnknown;
  const ADispIntfIID: TGUID);
begin
  inherited Create;
  DispIntfIID := ADispIntfIID;
  OleCheck(ADispatch.QueryInterface(ADispIntfIID, Dispatch));
end;

function TDispatchSilencer.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  Result := inherited QueryInterface(IID, Obj);
  if Result = E_NOINTERFACE then
    if IsEqualGUID(IID, DispIntfIID) then
    begin
      IDispatch(Obj) := Self;
      Result := S_OK;
    end
    else
      Result := Dispatch.QueryInterface(IID, Obj);
end;

function TDispatchSilencer.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Result := Dispatch.GetTypeInfoCount(Count);
end;

function TDispatchSilencer.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Result := Dispatch.GetTypeInfo(Index, LocaleID, TypeInfo);
end;

function TDispatchSilencer.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
  Result := Dispatch.GetIDsOfNames(IID, Names, NameCount, LocaleID, DispIDs);
end;

function TDispatchSilencer.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  { Ignore error since some containers, such as Internet Explorer 3.0x, will
    return error when the method was not handled, or scripting errors occur }
  Dispatch.Invoke(DispID, IID, LocaleID, Flags, Params, VarResult, ExcepInfo,
    ArgErr);
  Result := S_OK;
end;

{ TComClassManager }
constructor TComClassManager.Create;
begin
  inherited Create;
  FLock := TMultiReadExclusiveWriteSynchronizer.Create;
end;

destructor TComClassManager.Destroy;
begin
  FLock.Free;
  inherited Destroy;
end;

procedure TComClassManager.AddObjectFactory(Factory: TComObjectFactory);
begin
  FLock.BeginWrite;
  try
    Factory.FNext := FFactoryList;
    FFactoryList := Factory;
  finally
    FLock.EndWrite;
  end;
end;

procedure TComClassManager.ForEachFactory(ComServer: TComServerObject;
  FactoryProc: TFactoryProc);
var
  Factory, Next: TComObjectFactory;
begin
  FLock.BeginWrite;  // FactoryProc could add or delete factories from list
  try
    Factory := FFactoryList;
    while Factory <> nil do
    begin
      Next := Factory.FNext;
      if Factory.ComServer = ComServer then FactoryProc(Factory);
      Factory := Next;
    end;
  finally
    FLock.EndWrite;
  end;
end;

function TComClassManager.GetFactoryFromClass(ComClass: TClass): TComObjectFactory;
begin
  FLock.BeginRead;
  try
    Result := FFactoryList;
    while Result <> nil do
    begin
      if Result.ComClass = ComClass then Exit;
      Result := Result.FNext;
    end;
    raise EOleError.CreateResFmt(@SObjectFactoryMissing, [ComClass.ClassName]);
  finally
    FLock.EndRead;
  end;
end;

function TComClassManager.GetFactoryFromClassID(const ClassID: TGUID): TComObjectFactory;
begin
  FLock.BeginRead;
  try
    Result := FFactoryList;
    while Result <> nil do
    begin
      if IsEqualGUID(Result.ClassID, ClassID) then Exit;
      Result := Result.FNext;
    end;
  finally
    FLock.EndRead;
  end;
end;

procedure TComClassManager.RemoveObjectFactory(Factory: TComObjectFactory);
var
  F, P: TComObjectFactory;
begin
  FLock.BeginWrite;
  try
    P := nil;
    F := FFactoryList;
    while F <> nil do
    begin
      if F = Factory then
      begin
        if P <> nil then P.FNext := F.FNext else FFactoryList := F.FNext;
        Exit;
      end;
      P := F;
      F := F.FNext;
    end;
  finally
    FLock.EndWrite;
  end;
end;

{ TComObject }

constructor TComObject.Create;
begin
  FNonCountedObject := True;
  CreateFromFactory(ComClassManager.GetFactoryFromClass(ClassType), nil);
end;

constructor TComObject.CreateAggregated(const Controller: IUnknown);
begin
  FNonCountedObject := True;
  CreateFromFactory(ComClassManager.GetFactoryFromClass(ClassType), Controller);
end;

constructor TComObject.CreateFromFactory(Factory: TComObjectFactory;
  const Controller: IUnknown);
begin
  FRefCount := 1;
  FFactory := Factory;
  FController := Pointer(Controller);
  if not FNonCountedObject then FFactory.ComServer.CountObject(True);
  Initialize;
  Dec(FRefCount);
end;

destructor TComObject.Destroy;
begin
  if not OleUninitializing then
  begin
    if (FFactory <> nil) and not FNonCountedObject then
      FFactory.ComServer.CountObject(False);
    if FRefCount > 0 then CoDisconnectObject(Self, 0);
  end;
end;

function TComObject.GetController: IUnknown;
begin
  Result := IUnknown(FController);
end;

procedure TComObject.Initialize;
begin
end;

{$IFDEF MSWINDOWS}
function TComObject.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HResult;
var
  Msg: string;
  Handled: Integer;
begin
  Handled := 0;
  if ServerExceptionHandler <> nil then
  begin
    if ExceptObject is Exception then
      Msg := Exception(ExceptObject).Message;
    Result := 0;
    ServerExceptionHandler.OnException(ClassName,
      ExceptObject.ClassName, Msg, IntPtr(ExceptAddr),
      WideString(GUIDToString(FFactory.ErrorIID)),
      FFactory.ProgID, Handled, Result);
  end;
  if Handled = 0 then
    Result := HandleSafeCallException(ExceptObject, ExceptAddr,
      FFactory.ErrorIID, FFactory.ProgID, FFactory.ComServer.HelpFileName);
end;

function TComObject.Error(const Msg: string): HResult;
begin
  Result := DoSetErrorInfo(Msg, 0, DISP_E_EXCEPTION,
                           FFactory.ErrorIID,
                           FFactory.ProgID,
                           FFactory.ComServer.HelpFileName);
end;

function TComObject.Error(const Msg: string; const IID: TGUID; hRes: HRESULT): HResult;
begin
  Result := DoSetErrorInfo(Msg, 0, hRes, IID, FFactory.ProgID,
                           FFactory.ComServer.HelpFileName);
end;

class function TComObject.Error(const Msg: string; HelpID: DWORD;
                          const HelpFile: string;
                          const IID: TGUID;
                          hRes: HResult = DISP_E_EXCEPTION): HResult;
begin
  Result := DoSetErrorInfo(Msg, HelpID, hRes, IID, '', HelpFile);
end;
{$ENDIF}



{ TComObject.IUnknown }

function TComObject.ObjQueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TComObject.ObjAddRef: Integer;
begin
  Result := AtomicIncrement(FRefCount);
end;

function TComObject.ObjRelease: Integer;
begin
  // InterlockedDecrement returns only 0 or 1 on Win95 and NT 3.51
  // returns actual result on NT 4.0
  Result := AtomicDecrement(FRefCount);
  if Result = 0 then Destroy;
end;

{ TComObject.IUnknown for other interfaces }

function TComObject.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if FController <> nil then
    Result := IUnknown(FController).QueryInterface(IID, Obj) else
    Result := ObjQueryInterface(IID, Obj);
end;

function TComObject._AddRef: Integer;
begin
  if FController <> nil then
    Result := IUnknown(FController)._AddRef else
    Result := ObjAddRef;
end;

function TComObject._Release: Integer;
begin
  if FController <> nil then
    Result := IUnknown(FController)._Release else
    Result := ObjRelease;
end;

{ TComObject.ISupportErrorInfo }

function TComObject.InterfaceSupportsErrorInfo(const iid: TIID): HResult;
begin
  if GetInterfaceEntry(iid) <> nil then
    Result := S_OK else
    Result := S_FALSE;
end;

{ TComObjectFactory }

constructor TComObjectFactory.Create(ComServer: TComServerObject;
  ComClass: TComClass; const ClassID: TGUID; const ClassName,
  Description: string; Instancing: TClassInstancing;
  ThreadingModel: TThreadingModel);
begin
  IsMultiThread := IsMultiThread or (ThreadingModel <> tmSingle);
  if ThreadingModel in [tmFree, tmBoth] then
    CoInitFlags := COINIT_MULTITHREADED else
  if (ThreadingModel = tmApartment) and (CoInitFlags <> COINIT_MULTITHREADED) then
    CoInitFlags := COINIT_APARTMENTTHREADED;
  ComClassManager.AddObjectFactory(Self);
  FComServer := ComServer;
  FComClass := ComClass;
  FClassID := ClassID;
  FClassName := ClassName;
  FDescription := Description;
  FInstancing := Instancing;
  FErrorIID := IUnknown;
  FShowErrors := True;
  FThreadingModel := ThreadingModel;
  FRegister := -1;
end;

destructor TComObjectFactory.Destroy;
begin
  if FRegister <> -1 then CoRevokeClassObject(FRegister);
  ComClassManager.RemoveObjectFactory(Self);
end;

function TComObjectFactory.CreateComObject(const Controller: IUnknown): TComObject;
begin
  Result := TComClass(FComClass).CreateFromFactory(Self, Controller);
end;

function TComObjectFactory.GetProgID: string;
begin
  if FClassName <> '' then
    Result := FComServer.ServerName + '.' + FClassName else
    Result := '';
end;

procedure TComObjectFactory.RegisterClassObject;
const
  RegFlags: array[ciSingleInstance..ciMultiInstance] of Integer = (
    REGCLS_SINGLEUSE, REGCLS_MULTIPLEUSE);
  SuspendedFlag: array[Boolean] of Integer = (0, REGCLS_SUSPENDED);
begin
  if FInstancing <> ciInternal then
    OleCheck(CoRegisterClassObject(FClassID, Self, CLSCTX_LOCAL_SERVER,
      RegFlags[FInstancing] or SuspendedFlag[FComServer.StartSuspended], FRegister));
end;

procedure TComObjectFactory.UpdateRegistry(Register: Boolean);
const
  ThreadStrs: array[TThreadingModel] of string =
    ('', 'Apartment', 'Free', 'Both', 'Neutral');
var
  ClassID, ProgID, ServerKeyName, ShortFileName, RegPrefix: string;
  RootKey: HKEY;
begin
  if FInstancing = ciInternal then
    Exit;

  ComServer.GetRegRootAndPrefix(RootKey, RegPrefix);

  ClassID := GUIDToString(FClassID);
  ProgID := GetProgID;
  ServerKeyName := RegPrefix + 'CLSID\' + ClassID + '\' + FComServer.ServerKey;
  if Register then
  begin
    CreateRegKey(RegPrefix + 'CLSID\' + ClassID, '', Description, RootKey);
    ShortFileName := FComServer.ServerFileName;
    if AnsiPos(' ', ShortFileName) <> 0 then
      ShortFileName := ExtractShortPathName(ShortFileName);
    CreateRegKey(ServerKeyName, '', ShortFileName, RootKey);
    if (FThreadingModel <> tmSingle) and IsLibrary then
      CreateRegKey(ServerKeyName, 'ThreadingModel', ThreadStrs[FThreadingModel], RootKey);
    if ProgID <> '' then
    begin
      CreateRegKey(RegPrefix + ProgID, '', Description, RootKey);
      CreateRegKey(RegPrefix + ProgID + '\Clsid', '', ClassID, RootKey);
      CreateRegKey(RegPrefix + 'CLSID\' + ClassID + '\ProgID', '', ProgID, RootKey);
    end;
  end
  else
  begin
    if ProgID <> '' then
    begin
      DeleteRegKey(RegPrefix + 'CLSID\' + ClassID + '\ProgID', RootKey);
      DeleteRegKey(RegPrefix + ProgID + '\Clsid', RootKey);
      DeleteRegKey(RegPrefix + ProgID, RootKey);
    end;
    DeleteRegKey(ServerKeyName, RootKey);
    DeleteRegKey(RegPrefix + 'CLSID\' + ClassID, RootKey);
  end;
end;

function TComObjectFactory.GetLicenseString: WideString;
begin
  if FSupportsLicensing then Result := FLicString
  else Result := '';
end;

function TComObjectFactory.HasMachineLicense: Boolean;
begin
  Result := True;
end;

function TComObjectFactory.ValidateUserLicense(const LicStr: WideString): Boolean;
begin
  Result := AnsiCompareText(LicStr, FLicString) = 0;
end;

{ TComObjectFactory.IUnknown }

function TComObjectFactory.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TComObjectFactory._AddRef: Integer;
begin
  Result := ComServer.CountFactory(True);
end;

function TComObjectFactory._Release: Integer;
begin
  Result := ComServer.CountFactory(False);
end;

{ TComObjectFactory.IClassFactory }

function TComObjectFactory.CreateInstance(const UnkOuter: IUnknown;
  const IID: TGUID; out Obj): HResult;
begin
  Result := CreateInstanceLic(UnkOuter, nil, IID, '', Obj);
end;

function TComObjectFactory.LockServer(fLock: BOOL): HResult;
begin
  Result := CoLockObjectExternal(Self, fLock, True);
  // Keep com server alive until this class factory is unlocked
  ComServer.CountObject(fLock);
end;

{ TComObjectFactory.IClassFactory2 }

function TComObjectFactory.GetLicInfo(var licInfo: TLicInfo): HResult;
begin
  Result := S_OK;
  try
    with licInfo do
    begin
      cbLicInfo := SizeOf(licInfo);
      fRuntimeKeyAvail := (not FSupportsLicensing) or (GetLicenseString <> '');
      fLicVerified := (not FSupportsLicensing) or HasMachineLicense;
    end;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TComObjectFactory.RequestLicKey(dwResrved: Longint; out bstrKey: WideString): HResult;
begin
  // Can't give away a license key on an unlicensed machine
  if not HasMachineLicense then
  begin
    Result := CLASS_E_NOTLICENSED;
    Exit;
  end;
  bstrKey := FLicString;
  Result := NOERROR;
end;

function TComObjectFactory.CreateInstanceLic(const unkOuter: IUnknown;
  const unkReserved: IUnknown; const iid: TIID; const bstrKey: WideString;
  out vObject): HResult; stdcall;
var
  ComObject: TComObject;
begin
  // We can't write to a nil pointer.  Duh.
  if @vObject = nil then
  begin
    Result := E_POINTER;
    Exit;
  end;
  // In case of failure, make sure we return at least a nil interface.
  Pointer(vObject) := nil;
  // Check for licensing.
  if FSupportsLicensing and
    ((bstrKey <> '') and (not ValidateUserLicense(bstrKey))) or
    ((bstrKey = '') and (not HasMachineLicense)) then
  begin
    Result := CLASS_E_NOTLICENSED;
    Exit;
  end;
  // We can only aggregate if they are requesting our IUnknown.
  if (unkOuter <> nil) and not (IsEqualIID(iid, IUnknown)) then
  begin
    Result := CLASS_E_NOAGGREGATION;
    Exit;
  end;
  try
    ComObject := CreateComObject(UnkOuter);
  except
    if FShowErrors and (ExceptObject is Exception) then
      with Exception(ExceptObject) do
      begin
        if (Message <> '') and (AnsiLastChar(Message) > '.') then
          Message := Message + '.';
        MessageBox(0, PChar(Message), PChar(SDAXError), MB_OK or MB_ICONSTOP or MB_SETFOREGROUND);
      end;
    Result := E_UNEXPECTED;
    Exit;
  end;
  Result := ComObject.ObjQueryInterface(IID, vObject);
  if ComObject.RefCount = 0 then ComObject.Free;
end;

{ TTypedComObject }

constructor TTypedComObject.Create;
begin
  inherited;
end;

constructor TTypedComObject.CreateAggregated(const Controller: IInterface);
begin
  inherited;
end;

constructor TTypedComObject.CreateFromFactory(Factory: TComObjectFactory;
  const Controller: IInterface);
begin
  inherited;
end;

function TTypedComObject.GetClassInfo(out TypeInfo: ITypeInfo): HResult;
begin
  TypeInfo := TTypedComObjectFactory(FFactory).FClassInfo;
  Result := S_OK;
end;

{ TTypedComObjectFactory }

constructor TTypedComObjectFactory.Create(ComServer: TComServerObject;
  TypedComClass: TTypedComClass; const ClassID: TGUID;
  Instancing: TClassInstancing; ThreadingModel: TThreadingModel);
var
  ClassName, Description: WideString;
begin
  if ComServer.TypeLib.GetTypeInfoOfGUID(ClassID, FClassInfo) <> S_OK then
    raise EOleError.CreateResFmt(@STypeInfoMissing, [TypedComClass.ClassName]);
  OleCheck(FClassInfo.GetDocumentation(MEMBERID_NIL, @ClassName,
    @Description, nil, nil));
  inherited Create(ComServer, TypedComClass, ClassID,
    ClassName, Description, Instancing, ThreadingModel);
end;

function TTypedComObjectFactory.GetInterfaceTypeInfo(
  TypeFlags: Integer): ITypeInfo;
const
  FlagsMask = IMPLTYPEFLAG_FDEFAULT or IMPLTYPEFLAG_FSOURCE;
var
  ClassAttr: PTypeAttr;
  I, TypeInfoCount, Flags: Integer;
  RefType: HRefType;
begin
  OleCheck(FClassInfo.GetTypeAttr(ClassAttr));
  TypeInfoCount := ClassAttr^.cImplTypes;
  ClassInfo.ReleaseTypeAttr(ClassAttr);
  for I := 0 to TypeInfoCount - 1 do
  begin
    OleCheck(ClassInfo.GetImplTypeFlags(I, Flags));
    if Flags and FlagsMask = TypeFlags then
    begin
      OleCheck(ClassInfo.GetRefTypeOfImplType(I, RefType));
      OleCheck(ClassInfo.GetRefTypeInfo(RefType, Result));
      Exit;
    end;
  end;
  Result := nil;
end;

procedure TTypedComObjectFactory.UpdateRegistry(Register: Boolean);
var
  ClassKey: string;
  TypeLib: ITypeLib;
  TLibAttr: PTLibAttr;
  RegPrefix: string;
  RootKey: HKEY;
begin
  ComServer.GetRegRootAndPrefix(RootKey, RegPrefix);

  ClassKey := RegPrefix + 'CLSID\' + GUIDToString(FClassID);
  if Register then
  begin
    inherited UpdateRegistry(Register);
    TypeLib := FComServer.TypeLib;
    OleCheck(TypeLib.GetLibAttr(TLibAttr));
    try
      CreateRegKey(ClassKey + '\Version', '', Format('%d.%d',
        [TLibAttr.wMajorVerNum, TLibAttr.wMinorVerNum]), RootKey);
      CreateRegKey(ClassKey + '\TypeLib', '', GUIDToString(TLibAttr.guid), RootKey);
    finally
      TypeLib.ReleaseTLibAttr(TLibAttr);
    end;
  end else
  begin
    DeleteRegKey(ClassKey + '\TypeLib', RootKey);
    DeleteRegKey(ClassKey + '\Version', RootKey);
    inherited UpdateRegistry(Register);
  end;
end;

{ TAutoObject }

constructor TAutoObject.Create;
begin
  inherited;
end;

constructor TAutoObject.CreateAggregated(const Controller: IInterface);
begin
  inherited;
end;

constructor TAutoObject.CreateFromFactory(Factory: TComObjectFactory;
  const Controller: IInterface);
begin
  inherited;
end;

procedure TAutoObject.EventConnect(const Sink: IUnknown;
  Connecting: Boolean);
begin
  if Connecting then
  begin
    OleCheck(Sink.QueryInterface(FAutoFactory.FEventIID, FEventSink));
    EventSinkChanged(TDispatchSilencer.Create(Sink, FAutoFactory.FEventIID));
  end
  else
  begin
    FEventSink := nil;
    EventSinkChanged(nil);
  end;
end;

procedure TAutoObject.EventSinkChanged(const EventSink: IUnknown);
begin
end;

procedure TAutoObject.Initialize;
begin
  FAutoFactory := Factory as TAutoObjectFactory;
  inherited Initialize;
end;

{ TAutoObject.IDispatch }

function TAutoObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
{$IFDEF MSWINDOWS}
  Result := DispGetIDsOfNames(FAutoFactory.DispTypeInfo,
    Names, NameCount, DispIDs);
{$ENDIF}
{$IFDEF LINUX}
  Result := E_NOTIMPL;
{$ENDIF}
end;

function TAutoObject.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  if Index <> 0 then
  begin
    Result := DISP_E_BADINDEX;
    Exit;
  end;
  ITypeInfo(TypeInfo) := TAutoObjectFactory(Factory).DispTypeInfo;
  Result := S_OK;
end;

function TAutoObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 1;
  Result := S_OK;
end;

function TAutoObject.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer;
  Flags: Word; var Params; VarResult, ExcepInfo, ArgErr: Pointer): HResult;
const
  INVOKE_PROPERTYSET = INVOKE_PROPERTYPUT or INVOKE_PROPERTYPUTREF;
begin
  if Flags and INVOKE_PROPERTYSET <> 0 then Flags := INVOKE_PROPERTYSET;
  Result := TAutoObjectFactory(Factory).DispTypeInfo.Invoke(Pointer(
    IntPtr(Self) + TAutoObjectFactory(Factory).DispIntfEntry.IOffset),
    DispID, Flags, TDispParams(Params), VarResult, ExcepInfo, ArgErr);
end;

{ TAutoObjectFactory }

constructor TAutoObjectFactory.Create(ComServer: TComServerObject;
  AutoClass: TAutoClass; const ClassID: TGUID;
  Instancing: TClassInstancing; ThreadingModel: TThreadingModel);
var
  TypeAttr: PTypeAttr;
begin
  inherited Create(ComServer, AutoClass, ClassID, Instancing, ThreadingModel);
  FDispTypeInfo := GetInterfaceTypeInfo(IMPLTYPEFLAG_FDEFAULT);
  if FDispTypeInfo = nil then
    raise EOleError.CreateResFmt(@SBadTypeInfo, [AutoClass.ClassName]);
  OleCheck(FDispTypeInfo.GetTypeAttr(TypeAttr));
  FDispIntfEntry := GetIntfEntry(TypeAttr^.guid);
  FDispTypeInfo.ReleaseTypeAttr(TypeAttr);
  if FDispIntfEntry = nil then
    raise EOleError.CreateResFmt(@SDispIntfMissing, [AutoClass.ClassName]);
  FErrorIID := FDispIntfEntry^.IID;
  FEventTypeInfo := GetInterfaceTypeInfo(IMPLTYPEFLAG_FDEFAULT or
    IMPLTYPEFLAG_FSOURCE);
  if FEventTypeInfo <> nil then
  begin
    OleCheck(FEventTypeInfo.GetTypeAttr(TypeAttr));
    FEventIID := TypeAttr.guid;
    FEventTypeInfo.ReleaseTypeAttr(TypeAttr);
  end;
end;

function TAutoObjectFactory.GetIntfEntry(Guid: TGUID): PInterfaceEntry;
begin
  Result := FComClass.GetInterfaceEntry(Guid);
end;

{ TAutoIntfObject }

constructor TAutoIntfObject.Create(const TypeLib: ITypeLib; const DispIntf: TGUID);
begin
  inherited Create;
  OleCheck(TypeLib.GetTypeInfoOfGuid(DispIntf, FDispTypeInfo));
  FDispIntfEntry := GetInterfaceEntry(DispIntf);
  FDispIID := DispIntf;  
end;

{ TAutoIntfObject.IDispatch }

function TAutoIntfObject.GetIDsOfNames(const IID: TGUID; Names: Pointer;
  NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
begin
{$IFDEF MSWINDOWS}
  Result := DispGetIDsOfNames(FDispTypeInfo, Names, NameCount, DispIDs);
{$ENDIF}
{$IFDEF LINUX}
  Result := E_NOTIMPL;
{$ENDIF}
end;

function TAutoIntfObject.GetTypeInfo(Index, LocaleID: Integer;
  out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  if Index <> 0 then
  begin
    Result := DISP_E_BADINDEX;
    Exit;
  end;
  ITypeInfo(TypeInfo) := FDispTypeInfo;
  Result := S_OK;
end;

function TAutoIntfObject.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 1;
  Result := S_OK;
end;

function TAutoIntfObject.Invoke(DispID: Integer; const IID: TGUID;
  LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
  ArgErr: Pointer): HResult;
const
  INVOKE_PROPERTYSET = INVOKE_PROPERTYPUT or INVOKE_PROPERTYPUTREF;
begin
  if Flags and INVOKE_PROPERTYSET <> 0 then Flags := INVOKE_PROPERTYSET;
  Result := FDispTypeInfo.Invoke(Pointer(PByte(Self) +
    FDispIntfEntry.IOffset), DispID, Flags, TDispParams(Params), VarResult,
    ExcepInfo, ArgErr);
end;

function TAutoIntfObject.InterfaceSupportsErrorInfo(const iid: TIID): HResult;
begin
  if IsEqualGUID(DispIID, iid) then
    Result := S_OK else
    Result := S_FALSE;
end;

{$IFDEF MSWINDOWS}
function TAutoIntfObject.SafeCallException(ExceptObject: TObject;
  ExceptAddr: Pointer): HResult;
begin
  Result := HandleSafeCallException(ExceptObject, ExceptAddr, DispIID, '', '');
end;
{$ENDIF}

const
{ Maximum number of dispatch arguments }

  MaxDispArgs = 64; {+ !!}

{ Parameter type masks }

  atVarMask  = $3F;
  atTypeMask = $7F;
  atByRef    = $80;

function TrimPunctuation(const S: string): string;
var
  P: PChar;
begin
  Result := S;
  P := AnsiLastChar(Result);
  while (Length(Result) > 0) and CharInSet(P^, [#0..#32, '.']) do
  begin
    SetLength(Result, P - PChar(Result));
    P := AnsiLastChar(Result);
  end;
end;

{ EOleSysError }

constructor EOleSysError.Create(const Message: UnicodeString;
  ErrorCode: HRESULT; HelpContext: Integer);
var
  S: string;
begin
  S := Message;
  if S = '' then
  begin
    S := SysErrorMessage(Cardinal(ErrorCode));
    if S = '' then 
      FmtStr(S, SOleError, [ErrorCode]);
  end;
  inherited CreateHelp(S, HelpContext);
  FErrorCode := ErrorCode;
end;

{ EOleException }

constructor EOleException.Create(const Message: string; ErrorCode: HRESULT;
  const Source, HelpFile: string; HelpContext: Integer);
begin
  inherited Create(TrimPunctuation(Message), ErrorCode, HelpContext);
  FSource := Source;
  FHelpFile := HelpFile;
end;


{ Raise EOleSysError exception from an error code }

procedure OleError(ErrorCode: HResult);
begin
  raise EOleSysError.Create('', ErrorCode, 0);
end;

{ Raise EOleSysError exception if result code indicates an error }

procedure OleCheck(Result: HResult);
begin
  if not Succeeded(Result) then OleError(Result);
end;

{ Convert a string to a GUID }

function StringToGUID(const S: string): TGUID;
begin
  OleCheck(CLSIDFromString(PWideChar(WideString(S)), Result));
end;

{ Convert a GUID to a string }

function GUIDToString(const ClassID: TGUID): string;
var
  P: PWideChar;
begin
  OleCheck(StringFromCLSID(ClassID, P));
  Result := P;
  CoTaskMemFree(P);
end;

{ Convert a programmatic ID to a class ID }

function ProgIDToClassID(const ProgID: string): TGUID;
begin
  OleCheck(CLSIDFromProgID(PWideChar(WideString(ProgID)), Result));
end;

{ Convert a class ID to a programmatic ID }

function ClassIDToProgID(const ClassID: TGUID): string;
var
  P: PWideChar;
begin
  OleCheck(ProgIDFromCLSID(ClassID, P));
  Result := P;
  CoTaskMemFree(P);
end;

{ Create registry key }

procedure CreateRegKey(const Key, ValueName, Value: string; RootKey: HKEY);
var
  Handle: HKey;
  Status, Disposition: Integer;
begin
  Status := RegCreateKeyEx(RootKey, PChar(Key), 0, '',
    REG_OPTION_NON_VOLATILE, KEY_READ or KEY_WRITE, nil, Handle,
    @Disposition);
  if Status = 0 then
  begin
    Status := RegSetValueEx(Handle, PChar(ValueName), 0, REG_SZ,
      PChar(Value), (Length(Value) + 1)* sizeof(char));
    RegCloseKey(Handle);
  end;
  if Status <> 0 then raise EOleRegistrationError.CreateRes(@SCreateRegKeyError);
end;

{ Delete registry key }

procedure DeleteRegKey(const Key: string; RootKey: HKEY);
begin
  RegDeleteKey(RootKey, PChar(Key));
end;

{ Get registry value }

function GetRegStringValue(const Key, ValueName: string; RootKey: HKEY): string;
var
  Size: DWord;
  RegKey: HKEY;
begin
  Result := '';
  if RegOpenKeyEx(RootKey, PChar(Key), 0, KEY_READ, RegKey) = ERROR_SUCCESS then
  try
    Size := 256;
    SetLength(Result, Size);
    Size := Size * SizeOf(Char);
    if RegQueryValueEx(RegKey, PChar(ValueName), nil, nil, PByte(PChar(Result)), @Size) = ERROR_SUCCESS then
      SetLength(Result, (Size div SizeOf(Char)) - 1) else
      Result := '';
  finally
    RegCloseKey(RegKey);
  end;
end;

function CreateComObject(const ClassID: TGUID): IUnknown;
begin
  try
{$IFDEF CPUX86}
    try
      Set8087CW( Default8087CW or $08);
{$ENDIF CPUX86}
      OleCheck(CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
        CLSCTX_LOCAL_SERVER, IUnknown, Result));
{$IFDEF CPUX86}
    finally
      Reset8087CW;
    end;
{$ENDIF CPUX86}
  except
    on E: EOleSysError do
      raise EOleSysError.Create(Format('%s, ClassID: %s',[E.Message, GuidToString(ClassID)]),E.ErrorCode,0) { Do not localize }
  end;    
end;

function CreateRemoteComObject(const MachineName: WideString;
  const ClassID: TGUID): IUnknown;
const
  LocalFlags = CLSCTX_LOCAL_SERVER or CLSCTX_REMOTE_SERVER or CLSCTX_INPROC_SERVER;
  RemoteFlags = CLSCTX_REMOTE_SERVER;
var
  MQI: TMultiQI;
  ServerInfo: TCoServerInfo;
  IID_IUnknown: TGuid;
  Flags, Size: DWORD;
  LocalMachine: array [0..MAX_COMPUTERNAME_LENGTH] of char;
begin
  if @CoCreateInstanceEx = nil then
    raise Exception.CreateRes(@SDCOMNotInstalled);
  FillChar(ServerInfo, sizeof(ServerInfo), 0);
  ServerInfo.pwszName := PWideChar(MachineName);
  IID_IUnknown := IUnknown;
  MQI.IID := @IID_IUnknown;
  MQI.itf := nil;
  MQI.hr := 0;
  { If a MachineName is specified check to see if it the local machine.
    If it isn't, do not allow LocalServers to be used. }
  if Length(MachineName) > 0 then
  begin
    Size := Sizeof(LocalMachine);  // Win95 is hypersensitive to size
    if GetComputerName(LocalMachine, Size) and
       (AnsiCompareText(LocalMachine, MachineName) = 0) then
      Flags := LocalFlags else
      Flags := RemoteFlags;
  end else
    Flags := LocalFlags;
{$IFDEF CPUX86}
  try
    Set8087CW( Default8087CW or $08);
{$ENDIF CPUX86}
    OleCheck(CoCreateInstanceEx(ClassID, nil, Flags, @ServerInfo, 1, @MQI));
{$IFDEF CPUX86}
  finally
    Reset8087CW;
  end;
{$ENDIF CPUX86}
  OleCheck(MQI.HR);
  Result := MQI.itf;
end;

function CreateOleObject(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
begin
  try
    ClassID := ProgIDToClassID(ClassName);
{$IFDEF CPUX86}
    try
      Set8087CW( Default8087CW or $08);
{$ENDIF CPUX86}
      OleCheck(CoCreateInstance(ClassID, nil, CLSCTX_INPROC_SERVER or
        CLSCTX_LOCAL_SERVER, IDispatch, Result));
{$IFDEF CPUX86}
    finally
      Reset8087CW;
    end;
{$ENDIF CPUX86}
  except
    on E: EOleSysError do
      raise EOleSysError.Create(Format('%s, ProgID: "%s"',[E.Message, ClassName]),E.ErrorCode,0) { Do not localize }
  end;    
end;

function GetActiveOleObject(const ClassName: string): IDispatch;
var
  ClassID: TCLSID;
  Unknown: IUnknown;
begin
  ClassID := ProgIDToClassID(ClassName);
  OleCheck(GetActiveObject(ClassID, nil, Unknown));
  OleCheck(Unknown.QueryInterface(IDispatch, Result));
end;

function StringToLPOLESTR(const Source: string): POleStr;
var
  SourceLen: Integer;
  Buffer: PWideChar;
begin
  SourceLen := Length(Source);
  Buffer  := CoTaskMemAlloc((SourceLen+1) * sizeof(Char));
  StringToWideChar( Source, Buffer, SourceLen+1 );
  Result := POleStr( Buffer );
end;

function CreateClassID: string;
var
  ClassID: TCLSID;
  P: PWideChar;
begin
  CoCreateGuid(ClassID);
  StringFromCLSID(ClassID, P);
  Result := P;
  CoTaskMemFree(P);
end;

procedure RegisterComServer(const DLLName: string);
type
  TRegProc = function: HResult; stdcall;
const
  RegProcName = 'DllRegisterServer'; { Do not localize }
var
  Handle: THandle;
  RegProc: TRegProc;
begin
  Handle := SafeLoadLibrary(DLLName);
  if Handle <= HINSTANCE_ERROR then
    raise Exception.CreateFmt('%s: %s', [SysErrorMessage(GetLastError), DLLName]);
  try
    RegProc := GetProcAddress(Handle, RegProcName);
    if Assigned(RegProc) then OleCheck(RegProc) else RaiseLastOSError;
  finally
    FreeLibrary(Handle);
  end;
end;

procedure RegisterAsService(const ClassID, ServiceName: string);
begin
  CreateRegKey('AppID\' + ClassID, 'LocalService', ServiceName);
  CreateRegKey('CLSID\' + ClassID, 'AppID', ClassID);
end;

{ Connect an IConnectionPoint interface }

procedure InterfaceConnect(const Source: IUnknown; const IID: TIID;
  const Sink: IUnknown; var Connection: Longint);
var
  CPC: IConnectionPointContainer;
  CP: IConnectionPoint;
begin
  Connection := 0;
  if Succeeded(Source.QueryInterface(IConnectionPointContainer, CPC)) then
    if Succeeded(CPC.FindConnectionPoint(IID, CP)) then
      CP.Advise(Sink, Connection);
end;

{ Disconnect an IConnectionPoint interface }

procedure InterfaceDisconnect(const Source: IUnknown; const IID: TIID;
  var Connection: Longint);
var
  CPC: IConnectionPointContainer;
  CP: IConnectionPoint;
begin
  if Connection <> 0 then
    if Succeeded(Source.QueryInterface(IConnectionPointContainer, CPC)) then
      if Succeeded(CPC.FindConnectionPoint(IID, CP)) then
        if Succeeded(CP.Unadvise(Connection)) then Connection := 0;
end;

procedure LoadComExProcs;
var
  Ole32: HModule;
begin
  Ole32 := Winapi.Windows.GetModuleHandle('ole32.dll');
  if Ole32 <> 0 then
  begin
    @CoCreateInstanceEx := Winapi.Windows.GetProcAddress(Ole32, 'CoCreateInstanceEx');
    @CoInitializeEx := Winapi.Windows.GetProcAddress(Ole32, 'CoInitializeEx');
    @CoAddRefServerProcess := Winapi.Windows.GetProcAddress(Ole32, 'CoAddRefServerProcess');
    @CoReleaseServerProcess := Winapi.Windows.GetProcAddress(Ole32, 'CoReleaseServerProcess');
    @CoResumeClassObjects := Winapi.Windows.GetProcAddress(Ole32, 'CoResumeClassObjects');
    @CoSuspendClassObjects := Winapi.Windows.GetProcAddress(Ole32, 'CoSuspendClassObjects');
  end;
end;

{$IFDEF MSWINDOWS}
procedure SafeCallError(ErrorCode: Integer; ErrorAddr: Pointer);
  function CreateSafeCallErrorExceptionObject(ErrorCode: Integer): Exception;
  var
    ErrorInfo: IErrorInfo;
    Source, Description, HelpFile: WideString;
    HelpContext: Longint;
  begin
    HelpContext := 0;
    if GetErrorInfo(0, ErrorInfo) = S_OK then
    begin
      ErrorInfo.GetSource(Source);
      ErrorInfo.GetDescription(Description);
      ErrorInfo.GetHelpFile(HelpFile);
      ErrorInfo.GetHelpContext(HelpContext);
    end;
    if ErrorCode = EAbortRaisedHRESULT then
      Result := EAbort.CreateHelp(Description, HelpContext)
    else
      Result := EOleException.Create(Description, ErrorCode, Source, HelpFile, HelpContext);
  end;
var
  E: Exception;
begin
  E := CreateSafeCallErrorExceptionObject(ErrorCode);
  raise E at ErrorAddr;
end;
{$ENDIF MSWINDOWS}

{ Call Invoke method on the given IDispatch interface using the given
  call descriptor, dispatch IDs, parameters, and result }

                                                                   
                                                    
procedure DispatchInvoke(const Dispatch: IDispatch; CallDesc: PCallDesc;
  DispIDs: PDispIDList; Params: Pointer; Result: PVariant);
var
  I, DispID, InvKind: Integer;
  DispParams: TDispParams;
  ExcepInfo: TExcepInfo;
  VarParams: TVarDataArray;
  Status: HRESULT;
  Strings: TStringRefList;
begin
  FillChar(Strings, SizeOf(Strings), 0);
  VarParams := GetDispatchInvokeArgs(CallDesc, Params, Strings, false);
  try
    DispParams.cArgs := CallDesc^.ArgCount;
    if CallDesc^.ArgCount > 0 then
      DispParams.rgvarg := @VarParams[0]
    else
      DispParams.rgvarg := nil;
    if CallDesc^.NamedArgCount > 0 then
      DispParams.rgdispidNamedArgs := @DispIDs[1]
    else
      DispParams.rgdispidNamedArgs := nil;
    DispParams.cNamedArgs := CallDesc^.NamedArgCount;
    DispID := DispIDs[0];
    InvKind := CallDesc^.CallType;
    if InvKind = DISPATCH_PROPERTYPUT then
    begin
      if ((VarParams[0].VType and varTypeMask) = varDispatch) or
          ((VarParams[0].VType and varTypeMask) = varUnknown) then
        InvKind := DISPATCH_PROPERTYPUTREF or DISPATCH_PROPERTYPUT;
      DispIDs[0] := DISPID_PROPERTYPUT;
      DispParams.rgdispidNamedArgs := @DispIDs[0];
      Inc(DispParams.cNamedArgs);
    end
    else if (InvKind = DISPATCH_METHOD) and (CallDesc^.ArgCount = 0) and (Result <> nil) then
        InvKind := DISPATCH_METHOD or DISPATCH_PROPERTYGET
    else if (InvKind = DISPATCH_PROPERTYGET) and (CallDesc^.ArgCount <> 0) then
        InvKind := DISPATCH_METHOD or DISPATCH_PROPERTYGET;

    FillChar(ExcepInfo, SizeOf(ExcepInfo), 0);
    Status := Dispatch.Invoke(DispID, GUID_NULL, 0, InvKind, DispParams,
                              Result, @ExcepInfo, nil);
    if Status <> 0 then
      DispatchInvokeError(Status, ExcepInfo);
  finally
    FinalizeDispatchInvokeArgs(CallDesc, VarParams, false);
  end;

  for I := 0 to Length(Strings) -1 do
  begin
    if Pointer(Strings[I].Wide) = nil then
      Break;
    if Strings[I].Ansi <> nil then
      Strings[I].Ansi^ := AnsiString(Strings[I].Wide)
    else if Strings[I].Unicode <> nil then
      Strings[I].Unicode^ := UnicodeString(Strings[I].Wide)
  end;
end;

{ Call GetIDsOfNames method on the given IDispatch interface }
                                                                                                                                                                  
procedure GetIDsOfNames(const Dispatch: IDispatch; Names: PAnsiChar;
                        NameCount: Integer; DispIDs: PDispIDList); overload;
var
  WideNames: array of WideString;
  I: Integer;
  Src: PAnsiChar;
  Temp: HResult;
begin
  SetLength(WideNames, NameCount);
  Src := Names;
  for I := 0 to NameCount-1 do
  begin
    if I = 0 then
      WideNames[I] := UTF8ToWideString(Src)
    else
      WideNames[NameCount-I] := UTF8ToWideString(Src);
    Inc(Src, System.AnsiStrings.StrLen(Src)+1);
  end;
  Temp := Dispatch.GetIDsOfNames(GUID_NULL, WideNames, NameCount,
                                 GetThreadLocale, DispIDs);
  if Temp = Integer(DISP_E_UNKNOWNNAME) then
    raise EOleError.CreateResFmt(@SNoMethod, [Names])                                                                  
  else
    OleCheck(Temp);
end;

procedure GetIDsOfNames(const Dispatch: IDispatch; Names: PWideChar;
  NameCount: Integer; DispIDs: PDispIDList); overload;
begin
  GetIDsOfNames(Dispatch, PAnsiChar(AnsiString(Names)), NameCount, DispIDs);
end;

{ Central call dispatcher }

procedure VarDispInvoke(Result: PVariant; const Instance: Variant;
  CallDesc: PCallDesc; Params: Pointer); cdecl;

  procedure RaiseException;
  begin
    raise EOleError.CreateRes(@SVarNotObject);
  end;

var
  Dispatch: Pointer;
  DispIDs: array[0..MaxDispArgs - 1] of Integer;
begin
  if (CallDesc^.ArgCount) > MaxDispArgs then raise EOleError.CreateRes(@STooManyParams);
  if TVarData(Instance).VType = varDispatch then
    Dispatch := TVarData(Instance).VDispatch
  else if TVarData(Instance).VType = (varDispatch or varByRef) then
    Dispatch := Pointer(TVarData(Instance).VPointer^)
  else RaiseException;
  GetIDsOfNames(IDispatch(Dispatch), PAnsiChar(@CallDesc^.ArgTypes[CallDesc^.ArgCount]),
    CallDesc^.NamedArgCount + 1, @DispIDs);
  if Result <> nil then VarClear(Result^);
  DispatchInvoke(IDispatch(Dispatch), CallDesc, @DispIDs, Params, Result);
end;

{ Raise exception given an OLE return code and TExcepInfo structure }
procedure DispatchInvokeError(Status: Integer; const ExcepInfo: TExcepInfo);
var
  E: Exception;
begin
  if Status = Integer(DISP_E_EXCEPTION) then
  begin
    with ExcepInfo do
      E := EOleException.Create(bstrDescription, scode, bstrSource,
        bstrHelpFile, dwHelpContext);
  end else
    E := EOleSysError.Create('', Status, 0);
  raise E;
end;

function _DispReturnPointer(Val:Pointer): Pointer; begin  Result := val; end;
function _DispReturnInteger(Val:Integer): Integer; begin  Result := val; end;
function _DispReturnInt64  (Val:Int64  ): Int64;   begin  Result := val; end;
{$IFNDEF CPUX86}
function _DispReturnDouble (Val: Double): Double;  begin  Result := val; end;
function _DispReturnSingle (Val: Single): Single;  begin  Result := val; end;
{$ENDIF !CPUX86}

                                                                                                                                                         
procedure DispCallByID(Result: Pointer; const Dispatch: IDispatch;
  DispDesc: PDispDesc; Params: Pointer); cdecl;
var
  Res: TVarData;
  DispIDS: array[0..1] of TDispID;
begin
  System.VarUtils.VariantInit(Res);
  DispIDs[0] := DispDesc.DispID;  
{$IFDEF CPUX86}
  DispatchInvoke(Dispatch, @DispDesc.CallDesc,
                 @DispIDs, @Params, @Res);
{$ELSE}
  DispatchInvoke(Dispatch, @DispDesc.CallDesc,
                 @DispIDs, Params, @Res);
{$ENDIF}
  if (Result <> nil) then
  begin
    case DispDesc.ResType of
      varSmallint:  PSmallInt(Result)^ := Res.VSmallInt;
      varInteger:   PLongInt(Result)^  := Res.VInteger;
      varSingle:    PSingle(Result)^   := Res.VSingle;
      varDouble:    PDouble(Result)^   := Res.VDouble;
      varCurrency:  PCurrency(Result)^ := Res.VCurrency;
      varDate:      PDate(Result)^     := Res.VDate;
      varBoolean:   PWordBool(Result)^ := Res.VBoolean;
      varShortInt:  PShortInt(Result)^ := Res.VShortInt;
      varByte:      PByte(Result)^     := Res.VByte;
      varWord:      PWord(Result)^     := Res.VWord;
      varLongWord:  PLongWord(Result)^ := Res.VLongWord;
      varInt64:     PInt64(Result)^    := Res.VInt64;
      varUInt64:    PUInt64(Result)^   := Res.VUInt64;
      varOleStr:
        begin
          if PPointer(Result)^ <> nil then
            SysFreeString(PWideChar(Result^));
          PPointer(Result)^ := Res.VOleStr;
        end;
      varDispatch, varUnknown:
        begin
          if PPointer(Result)^ <> nil then
            IDispatch(Result^)._Release;
          PPointer(Result)^ := Res.VDispatch;
        end;
      varVariant:
        begin
          VarClear(PVariant(Result)^);
          Move(Res, Result^, SizeOf(Res));
        end;
    end;
  end
  else
  begin
    case DispDesc.ResType of
      varSmallint:  _DispReturnInteger(Res.VSmallInt);
      varInteger:   _DispReturnInteger(Res.VInteger);
{$IFDEF CPUX86}
      varSingle:
        asm 
          FLD Res.VSingle 
        end;
      varDouble:
        asm 
          FLD Res.VDouble 
        end;
      varCurrency:
        asm 
          FILD res.VCurrency 
        end;
      varDate:
        asm 
          FLD res.VDate 
        end;
{$ELSE}
      varSingle:    _DispReturnSingle(Res.VSingle);
      varDouble:    _DispReturnDouble(Res.VDouble);
      varCurrency:  _DispReturnInt64(PInt64(@Res.VCurrency)^);
      varDate:      _DIspReturnDouble(Res.VDate);
{$ENDIF}
      varBoolean:   _DispReturnInteger(Integer(Res.VBoolean));
      varShortInt:  _DispReturnInteger(Res.VShortInt);
      varByte:      _DispReturnInteger(Res.VByte);
      varWord:      _DispReturnInteger(Res.VWord);
      varLongWord:  _DispReturnInteger(Res.VLongWord);
      varInt64:     _DispReturnInt64(Res.VInt64);
      varUInt64:    _DispReturnInt64(Res.VUInt64);
      varOleStr:
        begin
          _DispReturnPointer(Res.VOleStr);
        end;
      varDispatch, varUnknown:
        begin
          _DispReturnPointer(Res.VDispatch);
        end;
    end;
  end;
end;

const
  DispIDArgs: Longint = DISPID_PROPERTYPUT;

function GetDispatchPropValue(const Disp: IDispatch; DispID: Integer): OleVariant;
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  Status: HResult;
begin
  FillChar(DispParams, SizeOf(DispParams), 0);
  Status := Disp.Invoke(DispID, GUID_NULL, 0, DISPATCH_PROPERTYGET, DispParams,
    @Result, @ExcepInfo, nil);
  if Status <> S_OK then DispatchInvokeError(Status, ExcepInfo);
end;

function GetDispatchPropValue(const Disp: IDispatch; Name: WideString): OleVariant;
var
  ID: Integer;
begin
  OleCheck(Disp.GetIDsOfNames(GUID_NULL, @Name, 1, 0, @ID));
  Result := GetDispatchPropValue(Disp, ID);
end;

procedure SetDispatchPropValue(const Disp: IDispatch; DispID: Integer;
  const Value: OleVariant);
var
  ExcepInfo: TExcepInfo;
  DispParams: TDispParams;
  Status: HResult;
begin
  with DispParams do
  begin
    rgvarg := @Value;
    rgdispidNamedArgs := @DispIDArgs;
    cArgs := 1;
    cNamedArgs := 1;
  end;
  Status := Disp.Invoke(DispId, GUID_NULL, 0, DISPATCH_PROPERTYPUT, DispParams,
    nil, @ExcepInfo, nil);
  if Status <> S_OK then DispatchInvokeError(Status, ExcepInfo);
end;

procedure SetDispatchPropValue(const Disp: IDispatch; Name: WideString;
  const Value: OleVariant); overload;
var
  ID: Integer;
begin
  OleCheck(Disp.GetIDsOfNames(GUID_NULL, @Name, 1, 0, @ID));
  SetDispatchPropValue(Disp, ID, Value);
end;

function EventDispatchInvoke(DispId: Integer; var ADispParams: TDispParams;
                             Invoker: TEventDispatchInvoker): HResult;
var
  LVarArray : TOleVariantArray;
  I, LFistArrItem, LLastArrItem: Integer;
  LPVarArgIn: PVariantArg;
begin
  SetLength(LVarArray, ADispParams.cArgs);
  LFistArrItem := Low(LVarArray);
  LLastArrItem := High(LVarArray);

  if ADispParams.cNamedArgs > 0 then
    // Copy over data from Params in NamedArgs order
    for I := LFistArrItem to LLastArrItem do
    begin
      LPVarArgIn := @ADispParams.rgvarg[i];
      LVarArray[ADispParams.rgdispidNamedArgs[i]] := POleVariant(LPVarArgIn)^;
    end
  else
    // Copy in reverse order
    for I := LFistArrItem to LLastArrItem do
    begin
      LPVarArgIn := @ADispParams.rgvarg[I];
      LVarArray[LLastArrItem - I] := POleVariant(LPVarArgIn)^;
    end;

  Invoker(DispId, LVarArray);

  SetLength(LVarArray, 0);
  Result := S_OK;
end;


var
  ComClassManagerVar: TObject;
  SaveInitProc: Pointer;
  InitComObjCalled: Boolean = False;
  NeedToUninitialize: Boolean = False;

function ComClassManager: TComClassManager;
begin
  if ComClassManagerVar = nil then
    ComClassManagerVar := TComClassManager.Create;
  Result := TComClassManager(ComClassManagerVar);
end;

procedure InitComObj;
begin
  if InitComObjCalled then Exit;
  if SaveInitProc <> nil then
    TProcedure(SaveInitProc);
  if (CoInitFlags <> -1) and Assigned(System.Win.ComObj.CoInitializeEx) then
  begin
    NeedToUninitialize := Succeeded(System.Win.ComObj.CoInitializeEx(nil, CoInitFlags));
    IsMultiThread := IsMultiThread or
      ((CoInitFlags and COINIT_APARTMENTTHREADED) <> 0) or
      (CoInitFlags = COINIT_MULTITHREADED);  // this flag has value zero
  end
  else
    NeedToUninitialize := Succeeded(CoInitialize(nil));
  InitComObjCalled := True;
end;


function HandleException: HResult;
var
  E: TObject;
begin
  E := ExceptObject;
  if (E is EOleSysError) and (EOleSysError(E).ErrorCode < 0) then
    Result := EOleSysError(E).ErrorCode else
    Result := E_UNEXPECTED;
end;

procedure FreeObjects(List: TList);
var
  I: Integer;
begin
  for I := List.Count - 1 downto 0 do TObject(List[I]).Free;
end;

procedure FreeObjectList(List: TList);
begin
  if List <> nil then
  begin
    FreeObjects(List);
    List.Free;
  end;
end;

{ TEnumConnections }

type
  TEnumConnections = class(TInterfacedObject, IEnumConnections)
  private
    FConnectionPoint: TConnectionPoint;
    FController: IUnknown;
    FIndex: Integer;
    FCount: Integer;
  protected
    { IEnumConnections }
    function Next(celt: Longint; out elt; pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out enumconn: IEnumConnections): HResult; stdcall;
  public
    constructor Create(ConnectionPoint: TConnectionPoint; Index: Integer);
  end;

constructor TEnumConnections.Create(ConnectionPoint: TConnectionPoint;
  Index: Integer);
begin
  inherited Create;
  FConnectionPoint := ConnectionPoint;
  // keep ConnectionPoint's controller alive as long as we're in use
  FController := FConnectionPoint.Controller;
  FIndex := Index;
  FCount := ConnectionPoint.FSinkList.Count;
end;

{ TEnumConnections.IEnumConnections }

function TEnumConnections.Next(celt: Longint; out elt;
  pceltFetched: PLongint): HResult;
type
  TConnectDatas = array[0..1023] of TConnectData;
var
  I: Integer;
  P: Pointer;
begin
  I := 0;
  while (I < celt) and (FIndex < FCount) do
  begin
    P := FConnectionPoint.FSinkList[FIndex];
    if P <> nil then
    begin
      Pointer(TConnectDatas(elt)[I].pUnk) := nil;
      TConnectDatas(elt)[I].pUnk := IUnknown(P);
      TConnectDatas(elt)[I].dwCookie := FIndex + 1;
      Inc(I);
    end;
    Inc(FIndex);
  end;
  if pceltFetched <> nil then pceltFetched^ := I;
  if I = celt then Result := S_OK else Result := S_FALSE;
end;

function TEnumConnections.Skip(celt: Longint): HResult; stdcall;
begin
  Result := S_FALSE;
  while (celt > 0) and (FIndex < FCount) do
  begin
    if FConnectionPoint.FSinkList[FIndex] <> nil then Dec(celt);
    Inc(FIndex);
  end;
  if celt = 0 then Result := S_OK;
end;

function TEnumConnections.Reset: HResult; stdcall;
begin
  FIndex := 0;
  Result := S_OK;
end;

function TEnumConnections.Clone(out enumconn: IEnumConnections): HResult; stdcall;
begin
  try
    enumconn := TEnumConnections.Create(FConnectionPoint, FIndex);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

{ TConnectionPoint }

constructor TConnectionPoint.Create(Container: TConnectionPoints;
  const IID: TGUID; Kind: TConnectionKind;
  OnConnect: TConnectEvent);
begin
  inherited Create(IUnknown(Container.FController));
  FContainer := Container;
  FContainer.FConnectionPoints.Add(Self);
  FSinkList := TList.Create;
  FIID := IID;
  FKind := Kind;
  FOnConnect := OnConnect;
end;

destructor TConnectionPoint.Destroy;
var
  I: Integer;
begin
  if FContainer <> nil then FContainer.FConnectionPoints.Remove(Self);
  if FSinkList <> nil then
  begin
    for I := 0 to FSinkList.Count - 1 do
      if FSinkList[I] <> nil then RemoveSink(I);
    FSinkList.Free;
  end;
  inherited Destroy;
end;

function TConnectionPoint.GetSink(Index: Integer; var punk: IUnknown): Boolean;
begin
  if Assigned(FSinkList[Index]) then
  begin
    punk := IUnknown(FSinkList[Index]);
    Result := True;
  end else
    Result := False;
end;

function TConnectionPoint.GetCount: Integer;
begin
  Result := FSinkList.Count;
end;

function TConnectionPoint.AddSink(const Sink: IUnknown): Integer;
var
  I: Integer;
begin
  I := 0;

  while I < FSinkList.Count do
  begin
    if FSinkList[I] = nil then
      Break
    else
      Inc(I);
  end;

  if I >= FSinkList.Count then
    FSinkList.Add(Pointer(Sink))
  else
    FSinkList[I] := Pointer(Sink);

  Sink._AddRef;
  Result := I;
end;

procedure TConnectionPoint.RemoveSink(Cookie: Longint);
var
  Sink: Pointer;
begin
  Sink := FSinkList[Cookie];
  FSinkList[Cookie] := nil;
  IUnknown(Sink)._Release;
end;

{ TConnectionPoint.IConnectionPoint }

function TConnectionPoint.GetConnectionInterface(out iid: TIID): HResult;
begin
  iid := FIID;
  Result := S_OK;
end;

function TConnectionPoint.GetConnectionPointContainer(
  out cpc: IConnectionPointContainer): HResult;
begin
  cpc := IUnknown(FContainer.FController) as IConnectionPointContainer;
  Result := S_OK;
end;

function TConnectionPoint.Advise(const unkSink: IUnknown;
  out dwCookie: Longint): HResult;
begin
  if (FKind = ckSingle) and (FSinkList.Count > 0) and
    (FSinkList[0] <> nil) then
  begin
    Result := CONNECT_E_CANNOTCONNECT;
    Exit;
  end;
  try
    if Assigned(FOnConnect) then FOnConnect(unkSink, True);
    dwCookie := AddSink(unkSink) + 1;
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TConnectionPoint.Unadvise(dwCookie: Longint): HResult;
begin
  Dec(dwCookie);
  if (dwCookie < 0) or (dwCookie >= FSinkList.Count) or
    (FSinkList[dwCookie] = nil) then
  begin
    Result := CONNECT_E_NOCONNECTION;
    Exit;
  end;
  try
    if Assigned(FOnConnect) then
      FOnConnect(IUnknown(FSinkList[dwCookie]), False);
    RemoveSink(dwCookie);
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TConnectionPoint.EnumConnections(out enumconn: IEnumConnections): HResult;
begin
  try
    enumconn := TEnumConnections.Create(Self, 0);
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

{ TEnumConnectionPoints }

type
  TEnumConnectionPoints = class(TContainedObject, IEnumConnectionPoints)
  private
    FContainer: TConnectionPoints;
    FIndex: Integer;
  protected
    { IEnumConnectionPoints }
    function Next(celt: Longint; out elt;
      pceltFetched: PLongint): HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Clone(out enumconn: IEnumConnectionPoints): HResult; stdcall;
  public
    constructor Create(Container: TConnectionPoints;
      Index: Integer);
  end;

constructor TEnumConnectionPoints.Create(Container: TConnectionPoints;
  Index: Integer);
begin
  inherited Create(IUnknown(Container.FController));
  FContainer := Container;
  FIndex := Index;
end;

{ TEnumConnectionPoints.IEnumConnectionPoints }

type
  TPointerList = array[0..0] of Pointer;

function TEnumConnectionPoints.Next(celt: Longint; out elt;
  pceltFetched: PLongint): HResult;
var
  I: Integer;
  P: Pointer;
begin
  I := 0;
  while (I < celt) and (FIndex < FContainer.FConnectionPoints.Count) do
  begin
    P := Pointer(IConnectionPoint(TConnectionPoint(
      FContainer.FConnectionPoints[FIndex])));
    IConnectionPoint(P)._AddRef;
    TPointerList(elt)[I] := P;
    Inc(I);
    Inc(FIndex);
  end;
  if pceltFetched <> nil then pceltFetched^ := I;
  if I = celt then Result := S_OK else Result := S_FALSE;
end;

function TEnumConnectionPoints.Skip(celt: Longint): HResult; stdcall;
begin
  if FIndex + celt <= FContainer.FConnectionPoints.Count then
  begin
    FIndex := FIndex + celt;
    Result := S_OK;
  end else
  begin
    FIndex := FContainer.FConnectionPoints.Count;
    Result := S_FALSE;
  end;
end;

function TEnumConnectionPoints.Reset: HResult; stdcall;
begin
  FIndex := 0;
  Result := S_OK;
end;

function TEnumConnectionPoints.Clone(
  out enumconn: IEnumConnectionPoints): HResult; stdcall;
begin
  try
    enumconn := TEnumConnectionPoints.Create(FContainer, FIndex);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

{ TConnectionPoints }

constructor TConnectionPoints.Create(const AController: IUnknown);
begin
  // weak reference to controller - don't keep it alive
  FController := Pointer(AController);
  FConnectionPoints := TList.Create;
end;

destructor TConnectionPoints.Destroy;
begin
  FreeObjectList(FConnectionPoints);
  inherited Destroy;
end;

function TConnectionPoints.CreateConnectionPoint(const IID: TGUID;
  Kind: TConnectionKind; OnConnect: TConnectEvent): TConnectionPoint;
begin
  Result := TConnectionPoint.Create(Self, IID, Kind, OnConnect);
end;

{ TConnectionPoints.IConnectionPointContainer }

function TConnectionPoints.EnumConnectionPoints(
  out enumconn: IEnumConnectionPoints): HResult;
begin
  try
    enumconn := TEnumConnectionPoints.Create(Self, 0);
    Result := S_OK;
  except
    Result := E_UNEXPECTED;
  end;
end;

function TConnectionPoints.FindConnectionPoint(const iid: TIID;
  out cp: IConnectionPoint): HResult;
var
  I: Integer;
  ConnectionPoint: TConnectionPoint;
begin
  for I := 0 to FConnectionPoints.Count - 1 do
  begin
    ConnectionPoint := FConnectionPoints[I];
    if IsEqualGUID(ConnectionPoint.FIID, iid) then
    begin
      cp := ConnectionPoint;
      Result := S_OK;
      Exit;
    end;
  end;
  Result := CONNECT_E_NOCONNECTION;
end;

function TConnectionPoints.GetController: IUnknown;
begin
  Result := IUnknown(FController);
end;

{ TAutoObjectEvent }

constructor TAutoObjectEvent.Create;
begin
  inherited;
end;

destructor TAutoObjectEvent.Destroy;
begin
  FConnectionPoints.Free;
  inherited;
end;

constructor TAutoObjectEvent.CreateAggregated(const Controller: IInterface);
begin
  inherited;
end;

constructor TAutoObjectEvent.CreateFromFactory(Factory: TComObjectFactory;
  const Controller: IInterface);
begin
  inherited;
end;

procedure TAutoObjectEvent.Initialize;
begin
  inherited Initialize;
  FConnectionPoints := TConnectionPoints.Create(Self);
  if AutoFactory.EventTypeInfo <> nil then
    FConnectionPoint := FConnectionPoints.CreateConnectionPoint(AutoFactory.EventIID,
                                                                ckMulti, EventConnect)
  else
    FConnectionPoint := nil;
end;


{ TComServerObject }

class constructor TComServerObject.Create;
begin
  FPerUserRegistration := False;
end;

class procedure TComServerObject.GetRegRootAndPrefix(var RootKey: HKEY;
                                                     var RootPrefix: string);
begin
  if (FPerUserRegistration) then
  begin
    RootKey := HKEY_CURRENT_USER;
    RootPrefix := 'Software\Classes\';
  end
  else
  begin
    RootKey := HKEY_CLASSES_ROOT;
    RootPrefix := '';
  end;
end;

initialization
begin
  LoadComExProcs;
  VarDispProc := @VarDispInvoke;
  DispCallByIDProc := @DispCallByID;
{$IFDEF MSWINDOWS}
  SafeCallErrorProc := @SafeCallError;
{$ENDIF}
  if not IsLibrary then
  begin
    SaveInitProc := InitProc;
    InitProc := @InitComObj;
  end;
end;

finalization
begin
  OleUninitializing := True;
  ComClassManagerVar.Free;
  SafeCallErrorProc := nil;
  DispCallByIDProc := nil;
  VarDispProc := nil;
  if NeedToUninitialize then CoUninitialize;
end;

end.
