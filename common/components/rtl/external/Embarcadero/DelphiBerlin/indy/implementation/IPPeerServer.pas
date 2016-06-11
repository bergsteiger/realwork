{*******************************************************}
{                                                       }
{              Delphi Indy Implementation               }
{                                                       }
{ Copyright(c) 1995-2014 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
{$IFDEF MACOS}
  (*$HPPEMIT '#if defined(__APPLE__) && !defined(_NO_PRAGMA_LINK_INDY)' *)
  (*$HPPEMIT ' #ifndef USEPACKAGES' *)
  (*$HPPEMIT '  #pragma link "IndyCore.a"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.a"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.a"' *)
  (*$HPPEMIT ' #else' *)
  (*$HPPEMIT '  #pragma link "IndyCore.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.bpi"' *)
  (*$HPPEMIT ' #endif' *)
  (*$HPPEMIT '#endif' *)
{$ELSE} //Win32, Win64
  (*$HPPEMIT '#if !defined(_NO_PRAGMA_LINK_INDY)' *)
  (*$HPPEMIT ' #ifndef USEPACKAGES' *) //static
  {$IFDEF WIN64}
    (*$HPPEMIT '  #pragma link "IndyCore.a"' *)
    (*$HPPEMIT '  #pragma link "IndyProtocols.a"' *)
    (*$HPPEMIT '  #pragma link "IndySystem.a"' *)
  {$ELSE}
    (*$HPPEMIT '  #pragma link "IndyCore.lib"' *)
    (*$HPPEMIT '  #pragma link "IndyProtocols.lib"' *)
    (*$HPPEMIT '  #pragma link "IndySystem.lib"' *)
  {$ENDIF}
  (*$HPPEMIT ' #else' *)
  (*$HPPEMIT '  #pragma link "IndyCore.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndyProtocols.bpi"' *)
  (*$HPPEMIT '  #pragma link "IndySystem.bpi"' *)
  (*$HPPEMIT ' #endif' *)
  (*$HPPEMIT '#endif' *)
{$ENDIF}

unit IPPeerServer;

interface

//This uses must be here to force a correct finalization order
uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  IdIOHandlerSocket, IdIOHandler, IdStack, IdHTTP, IdHTTPHeaderInfo, IdServerIOHandler, IdContext,
  IdSchedulerOfThreadPool, IdScheduler,
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  IdSSLOpenSSL,
{$ENDIF}
  IdGlobalProtocols, IdHeaderList, IdSocketHandle,
  IdTCPServer, IdUDPServer, IdHTTPServer, IdCustomHTTPServer, IdTCPConnection, IdStackConsts, IdGlobal,

  IdIPMCastServer,

  IPPeerCommon, IPPeerResStrs,
  IPPeerAPI; //put last because we have some type names identical to indy ones in here


function IPImpId: string;

implementation

type
  //IPPeerAPI.GStackPeers()
  TIdStackPeer = class(TInterfacedObject, IIPStack, IIPObject)
  protected
    procedure SetKeepAliveValues(ASocket: TIPStackSocketHandlePeer; const AEnabled: Boolean;
      const ATimeMS, AInterval: Integer);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    function SupportsIPv6: Boolean;
    function ResolveHost(const AHostName: string; const AIPVersion: TIPVersionPeer = IP_IPv4): string;
  end;

  TIdSocketHandlesPeer = class(TInterfacedObject, IIPSocketHandles, IIPObject)
  private
    FHandles: TIdSocketHandles;
  protected
    function Add: IIPSocketHandle;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Handles: TIdSocketHandles);
  end;

  TIdHTTPSessionPeer = class(TInterfacedObject, IIPHTTPSession, IIPObject)
  private
    FSession: TIdHTTPSession;
  protected
    function GetSessionID: string;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(ASession: TIdHTTPSession);
  end;

  TIdEntityHeaderInfoPeer = class(TInterfacedObject, IIPEntityHeaderInfo, IIPObject)
  private
    FInfo: TIdEntityHeaderInfo;
    FRawHeaders, FCustomHeaders: IIPHeaderList;
  protected
    function GetContentType: string;
    procedure SetContentType(LContentType: string);
    function GetContentLanguage: string;
    procedure SetContentLanguage(LContentLanguage: string);
    function GetContentEncoding: string;
    procedure SetContentEncoding(LContentEncoding: string);
    function GetContentRangeEnd: Int64;
    procedure SetContentRangeEnd(LContentRangeEnd: Int64);
    function GetContentRangeStart: Int64;
    procedure SetContentRangeStart(LContentRangeStart: Int64);
    function GetContentVersion: string;
    procedure SetContentVersion(LContentVersion: string);
    function GetContentLength: Int64;
    procedure SetContentLength(LContentLength: Int64);
    function GetCustomHeaders: IIPHeaderList;
    function GetConnection: string;
    procedure SetConnection(conn: string);
    function GetPragma: string;
    procedure SetPragma(Val: string);
    function GetRawHeaders: IIPHeaderList;
    function GetCharSet: string;
    procedure SetCharSet(Val: string);
    function GetLastModified: TDateTime;
    procedure SetLastModified(dt: TDateTime);
    function GetDate: TDateTime;
    procedure SetDate(LDate: TDateTime);
    function GetETag: string;
    procedure SetETag(LETag: string);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Info: TIdEntityHeaderInfo);
  end;

  TIdHTTPRequestInfoPeer = class(TIdEntityHeaderInfoPeer, IIPHTTPRequestInfo, IIPObject)
  private
    FInfo: TIdHTTPRequestInfo;
    FSession: IIPHTTPSession;
    FTempPostStream: TStream;
  protected
    function GetSession: IIPHTTPSession;
    function GetAccept: string;
    procedure SetAccept(Val: string);
    function GetUserAgent: string;
    procedure SetUserAgent(agent: string);
    function GetAuthPassword: string;
    function GetAuthUsername: string;
    function GetCommand: string;
    function GetCommandType: THTTPCommandTypePeer;
    function GetDocument: string;
    procedure SetDocument(doc: string);
    function GetParams: TStrings;
    function GetPostStream: TStream;
    procedure SetPostStream(ps: TStream);
    function GetRemoteIP: string;
    function GetURI: string;
    function GetVersion: string;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Info: TIdHTTPRequestInfo);
    destructor Destroy; override;
  end;

  TIdHTTPResponseInfoPeer = class(TIdEntityHeaderInfoPeer, IIPHTTPResponseInfo, IIPObject)
  private
    FInfo: TIdHTTPResponseInfo;
    FWWWAuth: IIPHeaderList;
  protected
    function GetWWWAuthenticate: IIPHeaderList;
    procedure SetWWWAuthenticate(wwwAuth: IIPHeaderList);
    function GetAuthRealm: string;
    procedure SetAuthRealm(realm: string);
    function GetCloseConnection: Boolean;
    procedure SetCloseConnection(closeConn: Boolean);
    function GetContentStream: TStream;
    procedure SetContentStream(content: TStream);
    function GetContentText: string;
    procedure SetContentText(text: string);
    function GetFreeContentStream: Boolean;
    procedure SetFreeContentStream(Val: Boolean);
    function GetResponseNo: Integer;
    procedure SetResponseNo(Num: Integer);
    function GetResponseText: string;
    procedure SetResponseText(text: string);
    function GetHeaderHasBeenWritten: Boolean;
    procedure SetHeaderHasBeenWritten(Val: Boolean);
    procedure WriteHeader;
    procedure WriteContent;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Info: TIdHTTPResponseInfo);
    destructor Destroy; override;
  end;

  TIdSchedulerPeer = class(TInterfacedObject, IIPScheduler, IIPObject)
  private
    FScheduler: TIdScheduler;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Scheduler: TIdScheduler);
  end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  TIdServerIOHandlerSSLOpenSSLIP = class(TIdServerIOHandlerSSLOpenSSL)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdServerIOHandlerSSLOpenSSLPeer = class(TIdClassIP, IIPServerIOHandlerSSLOpenSSL, IIPServerIOHandlerSSLBase, IIPServerIOHandler, IIPObject)
  private
    FServerIOHandlerSSL: TIdServerIOHandlerSSLOpenSSL;
    FOnGetPassEvent: TPasswordEventPeer;
    FSSLOptions: IIPSSLOptions;
    procedure LOnGetPassEvent(var Password: string);
  protected
    function GetSSLOptions: IIPSSLOptions;
    function GetOnGetPassword: TPasswordEventPeer;
    procedure SetOnGetPassword(event: TPasswordEventPeer);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent); overload;
    constructor Create(AIdServerIOHandlerSSLOpenSSL: TIdServerIOHandlerSSLOpenSSL); overload;
    destructor Destroy; override;
  end;
{$ENDIF}  

  TIdTCPConnectionPeer = class(TInterfacedObject, IIPTCPConnection, IIPObject)
  private
    FConnection: TIdTCPConnection;
    FIOHandler: IIPIOHandler;
    FSocket: IIPIOHandlerSocket;
  protected
    function Connected: Boolean;
    function GetIOHandler: IIPIOHandler;
    procedure SetIOHandler(Handler: IIPIOHandler);
    procedure Disconnect;
    function GetSocket: IIPIOHandlerSocket;
    function GetManagedIOHandler: Boolean;
    procedure SetManagedIOHandler(AManagedIOHandler: Boolean);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Connection: TIdTCPConnection);
    destructor Destroy; override;
  end;

  TIdContextPeer = class(TInterfacedObject, IIPContext, IIPObject)
  private
    FContext: TIdContext;
    FConnection: IIPTCPConnection;
  protected
    function GetConnection: IIPTCPConnection;
    function GetData: TObject;
    procedure SetData(obj: TObject);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Context: TIdContext);
    destructor Destroy; override;
  end;

  TIdTCPServerIP = class(TIdTCPServer)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdTCPServerPeer = class(TIdClassIP, IIPTCPServer, IIPObject)
  private
    FTCPServer: TIdTCPServerIP;
    FScheduler: IIPScheduler;
    FSocketHandles: IIPSocketHandles;
    FServerIOHandler: IIPServerIOHandler;
    FContexts: TDictionary<TIdContext, IIPContext>;
    FOnConnectEvent: TIPServerThreadEventPeer;
    FOnDisconnectEvent: TIPServerThreadEventPeer;
    FOnExecuteEvent: TIPServerThreadEventPeer;
    procedure LOnConnectEvent(AContext: TIdContext);
    procedure LOnDisconnectEvent(AContext: TIdContext);
    procedure LOnExecuteEvent(AContext: TIdContext);
  protected
    function GetActive: Boolean;
    procedure SetActive(Val: Boolean);
    function GetDefaultPort: TIPPortPeer;
    procedure SetDefaultPort(port: TIPPortPeer);
    function GetIOHandler: IIPServerIOHandler;
    procedure SetIOHandler(handler: IIPServerIOHandler);
    function GetOnConnect: TIPServerThreadEventPeer;
    procedure SetOnConnect(event: TIPServerThreadEventPeer);
    function GetOnDisconnect: TIPServerThreadEventPeer;
    procedure SetOnDisconnect(event: TIPServerThreadEventPeer);
    function GetOnExecute: TIPServerThreadEventPeer;
    procedure SetOnExecute(event: TIPServerThreadEventPeer);
    function GetUseNagle: Boolean;
    procedure SetUseNagle(Use: Boolean);
    function GetBindings: IIPSocketHandles;
    procedure SetBindings(ABindings: IIPSocketHandles);
    function GetScheduler: IIPScheduler;
    procedure SetScheduler(AScheduler: IIPScheduler);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

  TIdUDPListenerThreadIP = class(TIdUDPListenerThread)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdUDPListenerThreadPeer = class(TIdClassIP, IIPUDPListenerThread, IIPObject)
    FListenerThread: TIdUDPListenerThread;
  protected
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AThread: TIdUDPListenerThread);
  end;

  TIdUDPServerIP = class(TIdUDPServer)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdUDPServerPeer = class(TIdClassIP, IIPUDPServer, IIPObject)
  private
    FUDPServer: TIdUDPServerIP;
    FSocketHandles: IIPSocketHandles;
    FCurrentBinding: IIPSocketHandle;
    FOnUDPRead: TIPUDPReadEventPeer;
    FOnUDPException: TIPUDPExceptionEventPeer;
    procedure LOnUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure LOnUDPException(AThread: TIdUDPListenerThread; ABinding: TIdSocketHandle; const AMessage: string;
        const AExceptionClass: TClass);
    function GetThreadedEvent: boolean;
    procedure SetThreadedEvent(const Value: boolean);
  protected
    function GetObject: TObject;
    function GetIPImplementationID: string;
    function GetActive: Boolean;
    procedure SetActive(Val: Boolean);
    property Active: Boolean read GetActive write SetActive;
    function GetDefaultPort: TIPPortPeer;
    procedure SetDefaultPort(APort: TIPPortPeer);
    property DefaultPort: TIPPortPeer read GetDefaultPort write SetDefaultPort;
    function GetBindings: IIPSocketHandles;
    procedure SetBindings(ABindings: IIPSocketHandles);
    property Bindings: IIPSocketHandles read GetBindings write SetBindings;
    function GetOnRead: TIPUDPReadEventPeer;
    procedure SetOnRead(AEvent: TIPUDPReadEventPeer);
    property OnRead: TIPUDPReadEventPeer read GetOnRead write SetOnRead;
    function GetOnException: TIPUDPExceptionEventPeer;
    procedure SetOnException(AEvent: TIPUDPExceptionEventPeer);
    property OnException: TIPUDPExceptionEventPeer read GetOnException write SetOnException;

    property ThreadedEvent: boolean read GetThreadedEvent write SetThreadedEvent;

    procedure Broadcast(const AData: string; const APort: TIPPortPeer; const AIP: string = '';
      AByteEncoding: IIPTextEncodingPeer = nil); overload;
    procedure Broadcast(const AData: TIPBytesPeer; const APort: TIPPortPeer; const AIP: string = ''); overload;
    procedure Send(const AHost: string; const APort: TIPPortPeer; const AData: string;
      AByteEncoding: IIPTextEncodingPeer = nil);
    procedure SendBuffer(const AHost: string; const APort: TIPPortPeer; const ABuffer: TIPBytesPeer);

    function GetIPVersion: TIPVersionPeer;
    procedure SetIPVersion(const AValue: TIPVersionPeer);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

  TIdSchedulerOfThreadPoolIP = class(TIdSchedulerOfThreadPool)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdSchedulerOfThreadPoolPeer = class(TIdClassIP, IIPSchedulerOfThreadPool, IIPObject)
  private
    FSchedulerOfThreadPool: TIdSchedulerOfThreadPoolIP;
  protected
    function GetPoolSize: Integer;
    procedure SetPoolSize(APoolSize: Integer);
    function GetMaxThreads: Integer;
    procedure SetMaxThreads(AMaxThreads: Integer);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

  TIdServerIOHandlerPeer = class(TInterfacedObject, IIPServerIOHandler)
  private
    FHandler: TIdServerIOHandler;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Handler: TIdServerIOHandler);
  end;

  //so that we can use OnExecute
  TIdHTTPServerIP = class(TIdHTTPServer)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdHTTPServerPeer = class(TIdClassIP, IIPHTTPServer, IIPObject)
  private
    FHTTPServer: TIdHTTPServerIP;
    FContexts: TDictionary<TIdContext, IIPContext>;
    FSocketHandles: IIPSocketHandles;
    FServerIOHandler: IIPServerIOHandler;
    FScheduler: IIPScheduler;
    FOnConnectEvent: TIPServerThreadEventPeer;
    FOnCommandGet: TIPHTTPCommandEventPeer;
    FOnCommandOther: TIPHTTPCommandEventPeer;
    FOnDisconnectEvent: TIPServerThreadEventPeer;
    FOnExecuteEvent: TIPServerThreadEventPeer;
    procedure LOnConnectEvent(AContext: TIdContext);
    procedure LOnDisconnectEvent(AContext: TIdContext);
    procedure LOnExecuteEvent(AContext: TIdContext);
    procedure LOnCommandGetEvent(AContext: TIdContext;
    ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure LOnCommandOtherEvent(AContext: TIdContext;
    ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
  protected
    function GetActive: Boolean;
    procedure SetActive(Val: Boolean);
    function GetDefaultPort: TIPPortPeer;
    procedure SetDefaultPort(port: TIPPortPeer);
    function GetIOHandler: IIPServerIOHandler;
    procedure SetIOHandler(handler: IIPServerIOHandler);
    function GetOnConnect: TIPServerThreadEventPeer;
    procedure SetOnConnect(event: TIPServerThreadEventPeer);
    function GetUseNagle: Boolean;
    procedure SetUseNagle(Use: Boolean);
    function GetKeepAlive: Boolean;
    procedure SetKeepAlive(keep: Boolean);
    function GetServerSoftware: string;
    procedure SetServerSoftware(software: string);
    function GetOnCommandGet: TIPHTTPCommandEventPeer;
    procedure SetOnCommandGet(commandGet: TIPHTTPCommandEventPeer);
    function GetOnCommandOther: TIPHTTPCommandEventPeer;
    procedure SetOnCommandOther(commandOther: TIPHTTPCommandEventPeer);
    function GetOnDisconnect: TIPServerThreadEventPeer;
    procedure SetOnDisconnect(event: TIPServerThreadEventPeer);
    function GetOnExecute: TIPServerThreadEventPeer;
    procedure SetOnExecute(event: TIPServerThreadEventPeer);
    function GetBindings: IIPSocketHandles;
    procedure SetBindings(ABindings: IIPSocketHandles);
    function GetScheduler: IIPScheduler;
    procedure SetScheduler(AScheduler: IIPScheduler);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

  TIPTestServerPeer = class(TInterfacedObject, IIPTestServer)
  private type
    // Provide access to protected members
    TMimeTable = class(TIdMimeTable)
    end;
    TOnGetPassword = class
    private
      FPassword: string;
      procedure OnGetPassword(var APassword: string);
      constructor Create(const APassword: string);
    end;
  protected
    function GetOpenPort: Integer;
    procedure TestOpenPort(const APort: Integer; const AOnExecute: TIPServerThreadEventPeer);
    procedure TestCertificateFiles(const APort: Integer; const ACertFileName, AKeyFileName, ARootCertFile: string;
      const AKeyFilePassword: string);
    procedure GetExtensionMimeType(const ADictionary: TDictionary<string,string>);
  End;

  TIPMulticastServerPeer = class(TInterfacedObject, IIPMulticastServer, IIPObject)
  private
    FMulticastServer: TIdIPMCastServer;
  protected
    function GetBinding: IIPSocketHandle;

    function GetActive: Boolean;
    procedure SetActive(const AValue: Boolean);
    function GetMulticastGroup: string;
    procedure SetMulticastGroup(const AValue: string);
    function GetPort: TIPPortPeer;
    procedure SetPort(const AValue: TIPPortPeer);
    function GetIPVersion: TIPVersionPeer;
    procedure SetIPVersion(const AValue: TIPVersionPeer);

    function GetBoundPort: TIPPortPeer;
    procedure SetBoundPort(const APort: TIPPortPeer);

    function GetBoundIP: string;
    procedure SetBoundIP(const ABoundIP: string);

    function GetLoopback: Boolean;
    procedure SetLoopback(const AValue: Boolean);

    function GetTTL: Byte;
    procedure SetTTL(const AValue: Byte);

    procedure Send(const AData: string; const AByteEncoding: IIPTextEncodingPeer = nil); overload;
    procedure Send(const ABuffer: TIPBytesPeer); overload;
    procedure Send(const ABuffer: TIPBytesPeer; const APort: TIPPortPeer); overload;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

{ TIdStackPeer }

function TIdStackPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdStackPeer.GetObject: TObject;
begin
  Result := GStack;
end;

procedure TIdStackPeer.SetKeepAliveValues(ASocket: TIPStackSocketHandlePeer; const AEnabled: Boolean;
  const ATimeMS, AInterval: Integer);
begin
  if IdStack.GStack <> nil then
    IdStack.GStack.SetKeepAliveValues(ASocket, AEnabled, ATimeMS, AInterval);
end;

function TIdStackPeer.SupportsIPv6: Boolean;
begin
  Result := GStack.SupportsIPv6;
end;

function TIdStackPeer.ResolveHost(const AHostName: string; const AIPVersion: TIPVersionPeer = IP_IPv4): string;
var
  LIPVersion: TIdIPVersion;
begin
  if AIPVersion = IP_IPv4 then
    LIPVersion := Id_IPv4
  else
    LIPVersion := Id_IPv6;
  Result := GStack.ResolveHost(AHostName, LIPVersion);
end;

{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
{ TIdServerIOHandlerSSLOpenSSLIP }

destructor TIdServerIOHandlerSSLOpenSSLIP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdServerIOHandlerSSLOpenSSLPeer }

constructor TIdServerIOHandlerSSLOpenSSLPeer.Create(AOwner: TComponent);
begin
  FOnGetPassEvent := nil;
  FSSLOptions := nil;
  FServerIOHandlerSSL := TIdServerIOHandlerSSLOpenSSLIP.Create(AOwner);
  TIdServerIOHandlerSSLOpenSSLIP(FServerIOHandlerSSL).FSetDestroyedProc := SetDestroyed;
end;

constructor TIdServerIOHandlerSSLOpenSSLPeer.Create(AIdServerIOHandlerSSLOpenSSL: TIdServerIOHandlerSSLOpenSSL);
begin
  FOnGetPassEvent := nil;
  FSSLOptions := nil;
  FServerIOHandlerSSL := AIdServerIOHandlerSSLOpenSSL;
end;

destructor TIdServerIOHandlerSSLOpenSSLPeer.Destroy;
begin
  if NeedToFree and Assigned(FServerIOHandlerSSL) and (FServerIOHandlerSSL is TIdServerIOHandlerSSLOpenSSLIP) then
    FServerIOHandlerSSL.Free;
  inherited;
end;

function TIdServerIOHandlerSSLOpenSSLPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdServerIOHandlerSSLOpenSSLPeer.GetObject: TObject;
begin
  Result := FServerIOHandlerSSL;
end;

function TIdServerIOHandlerSSLOpenSSLPeer.GetOnGetPassword: TPasswordEventPeer;
begin
  if Assigned(FServerIOHandlerSSL.OnGetPassword) then
    Result := FOnGetPassEvent
  else
    Result := nil;
end;

function TIdServerIOHandlerSSLOpenSSLPeer.GetSSLOptions: IIPSSLOptions;
begin
  if FServerIOHandlerSSL.SSLOptions = nil then
    Result := nil
  else if Assigned(FSSLOptions) and (FSSLOptions.GetObject = FServerIOHandlerSSL.SSLOptions) then
    Result := FSSLOptions
  else
  begin
    Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSSLOptions, FServerIOHandlerSSL.SSLOptions) as IIPSSLOptions;
    FSSLOptions := Result;
  end;
end;

procedure TIdServerIOHandlerSSLOpenSSLPeer.SetOnGetPassword(event: TPasswordEventPeer);
begin
  FOnGetPassEvent := event;
  FServerIOHandlerSSL.OnGetPassword := LOnGetPassEvent;
end;

procedure TIdServerIOHandlerSSLOpenSSLPeer.LOnGetPassEvent(var Password: string);
var
  LStringBuilder: TStringBuilder;
begin
  LStringBuilder := TStringBuilder.Create;
  try
    LStringBuilder.Append(Password);
    if Assigned(FOnGetPassEvent) then
      FOnGetPassEvent(LStringBuilder);
    Password := LStringBuilder.ToString;
  finally
    LStringBuilder.Free;
  end;
end;
{$ENDIF}

{ TIdSocketHandlesPeer }

function TIdSocketHandlesPeer.Add: IIPSocketHandle;
begin
  Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSocketHandle, FHandles.Add) as IIPSocketHandle
end;

constructor TIdSocketHandlesPeer.Create(Handles: TIdSocketHandles);
begin
  FHandles := Handles;
end;

function TIdSocketHandlesPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdSocketHandlesPeer.GetObject: TObject;
begin
  Result := FHandles;
end;

{ TIdHTTPSessionPeer }

constructor TIdHTTPSessionPeer.Create(ASession: TIdHTTPSession);
begin
  FSession := ASession;
end;

function TIdHTTPSessionPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHTTPSessionPeer.GetObject: TObject;
begin
  Result := FSession;
end;

function TIdHTTPSessionPeer.GetSessionID: string;
begin
  Result := FSession.SessionID;
end;

{ TIdSchedulerPeer }

constructor TIdSchedulerPeer.Create(Scheduler: TIdScheduler);
begin
  FScheduler := Scheduler;
end;

function TIdSchedulerPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdSchedulerPeer.GetObject: TObject;
begin
  Result := FScheduler;
end;

{ TIdSchedulerOfThreadPoolIP }

destructor TIdSchedulerOfThreadPoolIP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdSchedulerOfThreadPoolPeer }

constructor TIdSchedulerOfThreadPoolPeer.Create(AOwner: TComponent);
begin
  FSchedulerOfThreadPool := TIdSchedulerOfThreadPoolIP.Create(AOwner);
  FSchedulerOfThreadPool.FSetDestroyedProc := SetDestroyed;
end;

destructor TIdSchedulerOfThreadPoolPeer.Destroy;
begin
  if NeedToFree then
    FSchedulerOfThreadPool.Free;
  inherited;
end;

function TIdSchedulerOfThreadPoolPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdSchedulerOfThreadPoolPeer.GetMaxThreads: Integer;
begin
  Result := FSchedulerOfThreadPool.MaxThreads;
end;

function TIdSchedulerOfThreadPoolPeer.GetObject: TObject;
begin
  Result := FSchedulerOfThreadPool;
end;

function TIdSchedulerOfThreadPoolPeer.GetPoolSize: Integer;
begin
  Result := FSchedulerOfThreadPool.PoolSize;
end;

procedure TIdSchedulerOfThreadPoolPeer.SetMaxThreads(AMaxThreads: Integer);
begin
  FSchedulerOfThreadPool.MaxThreads := AMaxThreads;
end;

procedure TIdSchedulerOfThreadPoolPeer.SetPoolSize(APoolSize: Integer);
begin
  FSchedulerOfThreadPool.PoolSize := APoolSize;
end;

{ TIdEntityHeaderInfoPeer }

function TIdEntityHeaderInfoPeer.GetRawHeaders: IIPHeaderList;
begin
  if FInfo.RawHeaders = nil then
    Result := nil
  else if Assigned(FRawHeaders) and (FRawHeaders.GetObject = FInfo.RawHeaders) then
    Result := FRawHeaders
  else
  begin
    Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPHeaderList, FInfo.RawHeaders) as IIPHeaderList;
    FRawHeaders := Result;
  end;
end;

function TIdEntityHeaderInfoPeer.GetCustomHeaders: IIPHeaderList;
begin
  if FInfo.CustomHeaders = nil then
    Result := nil
  else if Assigned(FCustomHeaders) and (FCustomHeaders.GetObject = FInfo.CustomHeaders) then
    Result := FCustomHeaders
  else
  begin
    Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPHeaderList, FInfo.CustomHeaders) as IIPHeaderList;
    FCustomHeaders := Result;
  end;
end;

function TIdEntityHeaderInfoPeer.GetDate: TDateTime;
begin
  Result := FInfo.Date;
end;

function TIdEntityHeaderInfoPeer.GetETag: string;
begin
  Result := FInfo.ETag;
end;

function TIdEntityHeaderInfoPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdEntityHeaderInfoPeer.GetLastModified: TDateTime;
begin
  Result := FInfo.LastModified;
end;

function TIdEntityHeaderInfoPeer.GetObject: TObject;
begin
  Result := FInfo;
end;

constructor TIdEntityHeaderInfoPeer.Create(Info: TIdEntityHeaderInfo);
begin
  FRawHeaders := nil;
  FCustomHeaders := nil;
  FInfo := Info;
end;

function TIdEntityHeaderInfoPeer.GetCharSet: string;
begin
  Result := FInfo.CharSet;
end;

function TIdEntityHeaderInfoPeer.GetConnection: string;
begin
  Result := FInfo.Connection;
end;

function TIdEntityHeaderInfoPeer.GetContentEncoding: string;
begin
  Result := FInfo.ContentEncoding;
end;

function TIdEntityHeaderInfoPeer.GetContentLanguage: string;
begin
  Result := FInfo.ContentLanguage;
end;

function TIdEntityHeaderInfoPeer.GetContentLength: Int64;
begin
  Result := FInfo.ContentLength;
end;

function TIdEntityHeaderInfoPeer.GetContentRangeEnd: Int64;
begin
  Result := FInfo.ContentRangeEnd;
end;

function TIdEntityHeaderInfoPeer.GetContentRangeStart: Int64;
begin
  Result := FInfo.ContentRangeStart;
end;

function TIdEntityHeaderInfoPeer.GetContentType: string;
begin
  Result := FInfo.ContentType;
end;

function TIdEntityHeaderInfoPeer.GetContentVersion: string;
begin
  Result := FInfo.ContentVersion;
end;

function TIdEntityHeaderInfoPeer.GetPragma: string;
begin
  Result := FInfo.Pragma;
end;

procedure TIdEntityHeaderInfoPeer.SetCharSet(Val: string);
begin
  FInfo.CharSet := Val;
end;

procedure TIdEntityHeaderInfoPeer.SetConnection(conn: string);
begin
  FInfo.Connection := conn;
end;

procedure TIdEntityHeaderInfoPeer.SetContentEncoding(LContentEncoding: string);
begin
  FInfo.ContentEncoding := LContentEncoding;
end;

procedure TIdEntityHeaderInfoPeer.SetContentLanguage(LContentLanguage: string);
begin
  FInfo.ContentLanguage := LContentLanguage;
end;

procedure TIdEntityHeaderInfoPeer.SetContentLength(LContentLength: Int64);
begin
  FInfo.ContentLength := LContentLength;
end;

procedure TIdEntityHeaderInfoPeer.SetContentRangeEnd(LContentRangeEnd: Int64);
begin
  FInfo.ContentRangeEnd := LContentRangeEnd;
end;

procedure TIdEntityHeaderInfoPeer.SetContentRangeStart(LContentRangeStart: Int64);
begin
  FInfo.ContentRangeStart := LContentRangeStart;
end;

procedure TIdEntityHeaderInfoPeer.SetContentType(LContentType: string);
begin
  FInfo.ContentType := LContentType;
end;

procedure TIdEntityHeaderInfoPeer.SetContentVersion(LContentVersion: string);
begin
  FInfo.ContentVersion := LContentVersion;
end;

procedure TIdEntityHeaderInfoPeer.SetDate(LDate: TDateTime);
begin
  FInfo.Date := LDate;
end;

procedure TIdEntityHeaderInfoPeer.SetETag(LETag: string);
begin
  FInfo.ETag := LETag;
end;

procedure TIdEntityHeaderInfoPeer.SetLastModified(dt: TDateTime);
begin
  FInfo.LastModified := dt;
end;

procedure TIdEntityHeaderInfoPeer.SetPragma(Val: string);
begin
  FInfo.Pragma := Val;
end;

{ TIdHTTPRequestInfoPeer }

constructor TIdHTTPRequestInfoPeer.Create(Info: TIdHTTPRequestInfo);
begin
  inherited Create(Info);
  FSession := nil;
  FInfo := Info;
end;

destructor TIdHTTPRequestInfoPeer.Destroy;
begin
  FTempPostStream.Free;
  inherited;
end;

function TIdHTTPRequestInfoPeer.GetAccept: string;
begin
  Result := FInfo.Accept;
end;

function TIdHTTPRequestInfoPeer.GetAuthPassword: string;
begin
  Result := FInfo.AuthPassword;
end;

function TIdHTTPRequestInfoPeer.GetAuthUsername: string;
begin
  Result := FInfo.AuthUsername;
end;

function TIdHTTPRequestInfoPeer.GetCommand: string;
begin
  Result := FInfo.Command;
end;

function TIdHTTPRequestInfoPeer.GetCommandType: THTTPCommandTypePeer;
begin
  case FInfo.CommandType of
    THTTPCommandType.hcUnknown: Result := THTTPCommandTypePeer.hcUnknown;
    THTTPCommandType.hcHEAD: Result := THTTPCommandTypePeer.hcHEAD;
    THTTPCommandType.hcGET: Result := THTTPCommandTypePeer.hcGET;
    THTTPCommandType.hcPOST: Result := THTTPCommandTypePeer.hcPOST;
    THTTPCommandType.hcDELETE: Result := THTTPCommandTypePeer.hcDELETE;
    THTTPCommandType.hcPUT: Result := THTTPCommandTypePeer.hcPUT;
    THTTPCommandType.hcTRACE: Result := THTTPCommandTypePeer.hcTRACE;
    THTTPCommandType.hcOPTION: Result := THTTPCommandTypePeer.hcOPTION;
  else raise Exception.Create('Unexpected HTTP command type');
  end;
end;

function TIdHTTPRequestInfoPeer.GetDocument: string;
begin
  Result := FInfo.Document;
end;

function TIdHTTPRequestInfoPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHTTPRequestInfoPeer.GetObject: TObject;
begin
  Result := FInfo;
end;

function TIdHTTPRequestInfoPeer.GetParams: TStrings;
begin
  Result := FInfo.Params;
end;

function TIdHTTPRequestInfoPeer.GetPostStream: TStream;
begin
  if (FInfo.PostStream = nil) and (FInfo.ContentLength > 0) and
     (FInfo.FormParams.Length > 0) then
    if FTempPostStream = nil then
    begin
      // Handle case where Indy copies post stream to FormParams
      // when content type = 'application/x-www-form-urlencoded';
      FTempPostStream := TStringStream.Create(FInfo.FormParams);
    end;
  if FTempPostStream <> nil then
    Result := FTempPostStream
  else
    Result := FInfo.PostStream;
end;

function TIdHTTPRequestInfoPeer.GetRemoteIP: string;
begin
  Result := FInfo.RemoteIP;
end;

function TIdHTTPRequestInfoPeer.GetSession: IIPHTTPSession;
var
  LObj: IIPObject;
begin
  if Assigned(FSession) then
    Supports(FSession, IIPObject, LObj)
  else
    LObj := nil;
  if FInfo.Session = nil then
    Result := nil
  else if Assigned(FSession) and Assigned(LObj) and (LObj.GetObject = FInfo.Session) then
    Result := FSession
  else
  begin
    Result := TIdHTTPSessionPeer.Create(FInfo.Session);
    FSession := Result;
  end;
end;

function TIdHTTPRequestInfoPeer.GetURI: string;
begin
  Result := FInfo.URI;
end;

function TIdHTTPRequestInfoPeer.GetUserAgent: string;
begin
  Result := FInfo.UserAgent;
end;

function TIdHTTPRequestInfoPeer.GetVersion: string;
begin
  Result := FInfo.Version;
end;

procedure TIdHTTPRequestInfoPeer.SetAccept(Val: string);
begin
  FInfo.Accept := Val;
end;

procedure TIdHTTPRequestInfoPeer.SetDocument(doc: string);
begin
  FInfo.Document := doc;
end;

procedure TIdHTTPRequestInfoPeer.SetPostStream(ps: TStream);
begin
  FInfo.PostStream := ps;
end;

procedure TIdHTTPRequestInfoPeer.SetUserAgent(agent: string);
begin
  FInfo.UserAgent := agent;
end;

{ TIdHTTPResponseInfoPeer }

constructor TIdHTTPResponseInfoPeer.Create(Info: TIdHTTPResponseInfo);
begin
  inherited Create(Info);
  FWWWAuth := nil;
  FInfo := Info;
end;

destructor TIdHTTPResponseInfoPeer.Destroy;
begin
  FWWWAuth := nil;
  inherited;
end;

function TIdHTTPResponseInfoPeer.GetAuthRealm: string;
begin
  Result := FInfo.AuthRealm;
end;

function TIdHTTPResponseInfoPeer.GetCloseConnection: Boolean;
begin
  Result := FInfo.CloseConnection;
end;

function TIdHTTPResponseInfoPeer.GetContentStream: TStream;
begin
  Result := FInfo.ContentStream;
end;

function TIdHTTPResponseInfoPeer.GetContentText: string;
begin
  Result := FInfo.ContentText;
end;

function TIdHTTPResponseInfoPeer.GetFreeContentStream: Boolean;
begin
  Result := FInfo.FreeContentStream;
end;

function TIdHTTPResponseInfoPeer.GetHeaderHasBeenWritten: Boolean;
begin
  Result := FInfo.HeaderHasBeenWritten;
end;

function TIdHTTPResponseInfoPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHTTPResponseInfoPeer.GetObject: TObject;
begin
  Result := FInfo;
end;

function TIdHTTPResponseInfoPeer.GetResponseNo: Integer;
begin
  Result := FInfo.ResponseNo;
end;

function TIdHTTPResponseInfoPeer.GetResponseText: string;
begin
  Result := FInfo.ResponseText;
end;

function TIdHTTPResponseInfoPeer.GetWWWAuthenticate: IIPHeaderList;
begin
  if FInfo.WWWAuthenticate = nil then
    Result := nil
  else if Assigned(FWWWAuth) and (FWWWAuth.GetObject = FInfo.WWWAuthenticate) then
    Result := FWWWAuth
  else
  begin
    Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPHeaderList, FInfo.WWWAuthenticate) as IIPHeaderList;
    FWWWAuth := Result;
  end;
end;

procedure TIdHTTPResponseInfoPeer.SetAuthRealm(realm: string);
begin
  FInfo.AuthRealm := realm;
end;

procedure TIdHTTPResponseInfoPeer.SetCloseConnection(closeConn: Boolean);
begin
  FInfo.CloseConnection := closeConn;
end;

procedure TIdHTTPResponseInfoPeer.SetContentStream(content: TStream);
begin
  FInfo.ContentStream := content;
end;

procedure TIdHTTPResponseInfoPeer.SetContentText(text: string);
begin
  FInfo.ContentText := text;
end;

procedure TIdHTTPResponseInfoPeer.SetFreeContentStream(Val: Boolean);
begin
  FInfo.FreeContentStream := Val;
end;

procedure TIdHTTPResponseInfoPeer.SetHeaderHasBeenWritten(Val: Boolean);
begin
  FInfo.HeaderHasBeenWritten := Val;
end;

procedure TIdHTTPResponseInfoPeer.SetResponseNo(Num: Integer);
begin
  FInfo.ResponseNo := Num;
end;

procedure TIdHTTPResponseInfoPeer.SetResponseText(text: string);
begin
  FInfo.ResponseText := text;
end;

procedure TIdHTTPResponseInfoPeer.SetWWWAuthenticate(wwwAuth: IIPHeaderList);
begin
  FInfo.WWWAuthenticate := wwwAuth.GetObject as TIdHeaderList;
  FWWWAuth := wwwAuth;
end;

procedure TIdHTTPResponseInfoPeer.WriteContent;
begin
  FInfo.WriteContent;
end;

procedure TIdHTTPResponseInfoPeer.WriteHeader;
begin
  FInfo.WriteHeader;
end;

{ TIdServerIOHandlerPeer }

constructor TIdServerIOHandlerPeer.Create(Handler: TIdServerIOHandler);
begin
  FHandler := Handler;
end;

function TIdServerIOHandlerPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdServerIOHandlerPeer.GetObject: TObject;
begin
  Result := FHandler;
end;

{ TIdHTTPServerIP }

destructor TIdHTTPServerIP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdHTTPServerPeer }

constructor TIdHTTPServerPeer.Create(AOwner: TComponent);
begin
  FContexts := TDictionary<TIdContext,IIPContext>.Create;
  FSocketHandles := nil;
  FServerIOHandler := nil;
  FScheduler := nil;
  FOnConnectEvent := nil;
  FOnCommandGet := nil;
  FOnCommandOther := nil;
  FOnDisconnectEvent := nil;
  FOnExecuteEvent := nil;
  FHTTPServer := TIdHTTPServerIP.Create(AOwner);
  FHTTPServer.FSetDestroyedProc := SetDestroyed;
end;

destructor TIdHTTPServerPeer.Destroy;
begin
  //Clear interface references (TODO: check order of nil'ing)
  FScheduler := nil;
  FSocketHandles := nil;
  FServerIOHandler := nil;
  FreeAndNil(FContexts);

  if NeedToFree then
    FHTTPServer.Free;
  inherited;
end;

function TIdHTTPServerPeer.GetActive: Boolean;
begin
  Result := FHTTPServer.Active;
end;

function TIdHTTPServerPeer.GetBindings: IIPSocketHandles;
begin
  if FHTTPServer.Bindings = nil then
    Result := nil
  else if Assigned(FSocketHandles) and (FSocketHandles.GetObject = FHTTPServer.Bindings) then
    Result := FSocketHandles
  else
  begin
    Result := TIdSocketHandlesPeer.Create(FHTTPServer.Bindings);
    FSocketHandles := Result;
  end;
end;

function TIdHTTPServerPeer.GetDefaultPort: TIPPortPeer;
begin
  Result := FHTTPServer.DefaultPort;
end;

function TIdHTTPServerPeer.GetIOHandler: IIPServerIOHandler;
begin
  if FHTTPServer.IOHandler = nil then
    Result := nil
  else if Assigned(FServerIOHandler) and (FServerIOHandler.GetObject = FHTTPServer.IOHandler) then
    Result := FServerIOHandler
  else
  begin
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
    if FHTTPServer.IOHandler is TIdServerIOHandlerSSLOpenSSL then
      Result := TIdServerIOHandlerSSLOpenSSLPeer.Create(FHTTPServer.IOHandler as TIdServerIOHandlerSSLOpenSSL)
    else
{$ENDIF}	
      Result := TIdServerIOHandlerPeer.Create(FHTTPServer.IOHandler);
    FServerIOHandler := Result;
  end;
end;

function TIdHTTPServerPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHTTPServerPeer.GetKeepAlive: Boolean;
begin
  Result := FHTTPServer.KeepAlive;
end;

function TIdHTTPServerPeer.GetObject: TObject;
begin
  Result := FHTTPServer;
end;

function TIdHTTPServerPeer.GetOnCommandGet: TIPHTTPCommandEventPeer;
begin
  if Assigned(FHTTPServer.OnCommandGet) then
    Result := FOnCommandGet
  else
    Result := nil;
end;

function TIdHTTPServerPeer.GetOnCommandOther: TIPHTTPCommandEventPeer;
begin
  if Assigned(FHTTPServer.OnCommandOther) then
    Result := FOnCommandOther
  else
    Result := nil;
end;

function TIdHTTPServerPeer.GetOnConnect: TIPServerThreadEventPeer;
begin
  if Assigned(FHTTPServer.OnConnect) then
    Result := FOnConnectEvent
  else
    Result := nil;
end;

function TIdHTTPServerPeer.GetOnDisconnect: TIPServerThreadEventPeer;
begin
  if Assigned(FHTTPServer.OnDisconnect) then
    Result := FOnDisconnectEvent
  else
    Result := nil;
end;

function TIdHTTPServerPeer.GetOnExecute: TIPServerThreadEventPeer;
begin
  if Assigned(FHTTPServer.OnExecute) then
    Result := FOnExecuteEvent
  else
    Result := nil;
end;

function TIdHTTPServerPeer.GetScheduler: IIPScheduler;
begin
  if FHTTPServer.Scheduler = nil then
    Result := nil
  else if Assigned(FScheduler) and (FScheduler.GetObject = FHTTPServer.Scheduler) then
    Result := FScheduler
  else
  begin
    Result := TIdSchedulerPeer.Create(FHTTPServer.Scheduler);
    FScheduler := Result;
  end;
end;

function TIdHTTPServerPeer.GetServerSoftware: string;
begin
  Result := FHTTPServer.ServerSoftware;
end;

function TIdHTTPServerPeer.GetUseNagle: Boolean;
begin
  Result := FHTTPServer.UseNagle;
end;

procedure TIdHTTPServerPeer.LOnCommandGetEvent(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo);
var
  LContext: IIPContext;
  LRequestInfo: IIPHTTPRequestInfo;
  LResponseInfo: IIPHTTPResponseInfo;
begin
  if Assigned(FOnCommandGet) then
  begin
    LContext := TIdContextPeer.Create(AContext);;
    LRequestInfo := TIdHTTPRequestInfoPeer.Create(ARequestInfo);
    LResponseInfo := TIdHTTPResponseInfoPeer.Create(AResponseInfo);
    FOnCommandGet(LContext, LRequestInfo, LResponseInfo);
  end;
end;

procedure TIdHTTPServerPeer.LOnCommandOtherEvent(AContext: TIdContext; ARequestInfo: TIdHTTPRequestInfo;
  AResponseInfo: TIdHTTPResponseInfo);
var
  LContext: IIPContext;
  LRequestInfo: IIPHTTPRequestInfo;
  LResponseInfo: IIPHTTPResponseInfo;
begin
  if Assigned(FOnCommandOther) then
  begin
    LContext := TIdContextPeer.Create(AContext);;
    LRequestInfo := TIdHTTPRequestInfoPeer.Create(ARequestInfo);
    LResponseInfo := TIdHTTPResponseInfoPeer.Create(AResponseInfo);
    FOnCommandOther(LContext, LRequestInfo, LResponseInfo);
  end;
end;

procedure TIdHTTPServerPeer.LOnConnectEvent(AContext: TIdContext);
var
  LContext: IIPContext;
begin
  TMonitor.Enter(FContexts);
  try
    if FContexts.ContainsKey(AContext) then
      LContext := FContexts.Items[AContext]
    else
    begin
      LContext := TIdContextPeer.Create(AContext);
      FContexts.Add(AContext, LContext);
    end;
  finally
    TMonitor.Exit(FContexts);
  end;
  if Assigned(FOnConnectEvent) then
  begin
    FOnConnectEvent(LContext);
  end;
end;

procedure TIdHTTPServerPeer.LOnDisconnectEvent(AContext: TIdContext);
var
  LContext: IIPContext;
begin
  TMonitor.Enter(FContexts);
  try
    LContext := FContexts.Items[AContext];
    FContexts.Remove(AContext);
  finally
    TMonitor.Exit(FContexts);
  end;
  if Assigned(FOnDisconnectEvent) then
  begin
    FOnDisconnectEvent(LContext);
  end;
end;

procedure TIdHTTPServerPeer.LOnExecuteEvent(AContext: TIdContext);
var
  LContext: IIPContext;
begin
  if Assigned(FOnExecuteEvent) then
  begin
    TMonitor.Enter(FContexts);
    try
      LContext := FContexts.Items[AContext];
    finally
      TMonitor.Exit(FContexts);
    end;
    FOnExecuteEvent(LContext);
  end;
end;

procedure TIdHTTPServerPeer.SetActive(Val: Boolean);
begin
  FHTTPServer.Active := Val;
end;

procedure TIdHTTPServerPeer.SetBindings(ABindings: IIPSocketHandles);
begin
  FHTTPServer.Bindings := ABindings.GetObject as TIdSocketHandles;
  FSocketHandles := ABindings;
end;

procedure TIdHTTPServerPeer.SetDefaultPort(port: TIPPortPeer);
begin
  FHTTPServer.DefaultPort := port;
end;

procedure TIdHTTPServerPeer.SetIOHandler(handler: IIPServerIOHandler);
begin
  FHTTPServer.IOHandler := handler.GetObject as TIdServerIOHandler;
  FServerIOHandler := handler;
end;

procedure TIdHTTPServerPeer.SetKeepAlive(keep: Boolean);
begin
  FHTTPServer.KeepAlive := keep;
end;

procedure TIdHTTPServerPeer.SetOnCommandGet(commandGet: TIPHTTPCommandEventPeer);
begin
  FHTTPServer.OnCommandGet := LOnCommandGetEvent;
  FOnCommandGet := commandGet;
end;

procedure TIdHTTPServerPeer.SetOnCommandOther(commandOther: TIPHTTPCommandEventPeer);
begin
  FHTTPServer.OnCommandOther := LOnCommandOtherEvent;
  FOnCommandOther := commandOther;
end;

procedure TIdHTTPServerPeer.SetOnConnect(event: TIPServerThreadEventPeer);
begin
  FHTTPServer.OnConnect := LOnConnectEvent;
  FOnConnectEvent := event;
end;

procedure TIdHTTPServerPeer.SetOnDisconnect(event: TIPServerThreadEventPeer);
begin
  FHTTPServer.OnDisconnect := LOnDisconnectEvent;
  FOnDisconnectEvent := event;
end;

procedure TIdHTTPServerPeer.SetOnExecute(event: TIPServerThreadEventPeer);
begin
  FHTTPServer.OnExecute := LOnExecuteEvent;
  FOnExecuteEvent := event;
end;

procedure TIdHTTPServerPeer.SetScheduler(AScheduler: IIPScheduler);
begin
  FHTTPServer.Scheduler := AScheduler.GetObject as TIdScheduler;
  FScheduler := AScheduler;
end;

procedure TIdHTTPServerPeer.SetServerSoftware(software: string);
begin
  FHTTPServer.ServerSoftware := software;
end;

procedure TIdHTTPServerPeer.SetUseNagle(Use: Boolean);
begin
  FHTTPServer.UseNagle := Use;
end;

{ TIdTCPConnectionPeer }

function TIdTCPConnectionPeer.Connected: Boolean;
begin
  Result := FConnection.Connected;
end;

constructor TIdTCPConnectionPeer.Create(Connection: TIdTCPConnection);
begin
  FIOHandler := nil;
  FSocket := nil;
  FConnection := Connection;
end;

destructor TIdTCPConnectionPeer.Destroy;
begin
  FIOHandler := nil;
  inherited;
end;

procedure TIdTCPConnectionPeer.Disconnect;
begin
  FConnection.Disconnect;
end;

function TIdTCPConnectionPeer.GetIOHandler: IIPIOHandler;
begin
  if FConnection.IOHandler = nil then
    Result := nil
  else if Assigned(FIOHandler) and (FIOHandler.GetObject = FConnection.IOHandler) then
    Result := FIOHandler
  else
  begin
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
    if FConnection.IOHandler is TIdSSLIOHandlerSocketOpenSSL then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSSLIOHandlerSocketOpenSSL, FConnection.IOHandler) as IIPSSLIOHandlerSocketOpenSSL
      //Result := TIdSSLIOHandlerSocketOpenSSLPeer.Create(FConnection.IOHandler as TIdSSLIOHandlerSocketOpenSSL)
    else 
{$ENDIF}	
	if FConnection.IOHandler is TIdIOHandlerSocket then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandlerSocket, FConnection.IOHandler) as IIPIOHandlerSocket
      //Result := TIdIOHandlerSocketPeer.Create(FConnection.IOHandler as TIdIOHandlerSocket)
    else
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandler, FConnection.IOHandler) as IIPIOHandler;
      //Result := TIdIOHandlerPeerIP.Create(FConnection.IOHandler);
    FIOHandler := Result;
  end;
end;

function TIdTCPConnectionPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdTCPConnectionPeer.GetObject: TObject;
begin
  Result := FConnection;
end;

function TIdTCPConnectionPeer.GetSocket: IIPIOHandlerSocket;
begin
  if FConnection.Socket = nil then
    Result := nil
  else if Assigned(FSocket) and (FSocket.GetObject = FConnection.Socket) then
    Result := FSocket
  else
  begin
    Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandlerSocket, FConnection.Socket) as IIPIOHandlerSocket;
    //Result := TIdIOHandlerSocketPeer.Create(FConnection.Socket);
    FSocket := Result;
  end;
end;

function TIdTCPConnectionPeer.GetManagedIOHandler: Boolean;
begin
  Result := FConnection.ManagedIOHandler;
end;

procedure TIdTCPConnectionPeer.SetManagedIOHandler(AManagedIOHandler: Boolean);
begin
  FConnection.ManagedIOHandler := AManagedIOHandler;
end;

procedure TIdTCPConnectionPeer.SetIOHandler(Handler: IIPIOHandler);
begin
  FConnection.IOHandler := Handler.GetObject as TIdIOHandler;
  FIOHandler := Handler;
end;

{ TIdContextPeer }

constructor TIdContextPeer.Create(Context: TIdContext);
begin
  FConnection := nil;
  FContext := Context;
end;

destructor TIdContextPeer.Destroy;
begin
  inherited;
end;

function TIdContextPeer.GetConnection: IIPTCPConnection;
begin
  if FContext.Connection = nil then
    Result := nil
  else if Assigned(FConnection) and (FConnection.GetObject = FContext.Connection) then
    Result := FConnection
  else
  begin
    Result := TIdTCPConnectionPeer.Create(FContext.Connection);
    FConnection := Result;
  end;
end;

function TIdContextPeer.GetData: TObject;
begin
{$IFDEF AUTOREFCOUNT}
  Result := FContext.DataObject;
{$ELSE}
  Result := FContext.Data;
{$ENDIF}
end;

function TIdContextPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdContextPeer.GetObject: TObject;
begin
  Result := FContext;
end;

procedure TIdContextPeer.SetData(obj: TObject);
begin
{$IFDEF AUTOREFCOUNT}
  FContext.DataObject := obj;
{$ELSE}
  FContext.Data := obj;
{$ENDIF}
end;

{ TIdTCPServerIP }

destructor TIdTCPServerIP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdTCPServerPeer }

procedure TIdTCPServerPeer.LOnConnectEvent(AContext: TIdContext);
var
  LContext: IIPContext;
begin
  TMonitor.Enter(FContexts);
  try
    if FContexts.ContainsKey(AContext) then
      LContext := FContexts.Items[AContext]
    else
    begin
      LContext := TIdContextPeer.Create(AContext);
      FContexts.Add(AContext, LContext);
    end;
  finally
    TMonitor.Exit(FContexts);
  end;

  if Assigned(FOnConnectEvent) then
  begin
    FOnConnectEvent(LContext);
  end;
end;

procedure TIdTCPServerPeer.LOnDisconnectEvent(AContext: TIdContext);
var
  LContext: IIPContext;
begin
  TMonitor.Enter(FContexts);
  try
    LContext := FContexts.Items[AContext];
    FContexts.Remove(AContext);
  finally
    TMonitor.Exit(FContexts);
  end;

  if Assigned(FOnDisconnectEvent) then
  begin
    FOnDisconnectEvent(LContext);
  end;
end;

procedure TIdTCPServerPeer.LOnExecuteEvent(AContext: TIdContext);
var
  LContext: IIPContext;
begin
  if Assigned(FOnExecuteEvent) then
  begin
    TMonitor.Enter(FContexts);
    try
      LContext := FContexts.Items[AContext];
    finally
      TMonitor.Exit(FContexts);
    end;
    FOnExecuteEvent(LContext);
  end;
end;

constructor TIdTCPServerPeer.Create(AOwner: TComponent);
begin
  FScheduler := nil;
  FSocketHandles := nil;
  FServerIOHandler := nil;
  FContexts := TDictionary<TIdContext,IIPContext>.Create;
  FOnConnectEvent := nil;
  FOnDisconnectEvent := nil;
  FOnExecuteEvent := nil;
  FTCPServer := TIdTCPServerIP.Create(AOwner);
  FTCPServer.FSetDestroyedProc := SetDestroyed;
end;

destructor TIdTCPServerPeer.Destroy;
begin
  //Clear interface references (TODO: check order of nil'ing)
  FScheduler := nil;
  FSocketHandles := nil;
  FServerIOHandler := nil;
  FreeAndNil(FContexts);

  if NeedToFree then
    FTCPServer.DisposeOf;
  inherited;
end;

function TIdTCPServerPeer.GetActive: Boolean;
begin
  Result := FTCPServer.Active;
end;

function TIdTCPServerPeer.GetBindings: IIPSocketHandles;
begin
  if FTCPServer.Bindings = nil then
    Result := nil
  else if Assigned(FSocketHandles) and (FSocketHandles.GetObject = FTCPServer.Bindings) then
    Result := FSocketHandles
  else
  begin
    Result := TIdSocketHandlesPeer.Create(FTCPServer.Bindings);
    FSocketHandles := Result;
  end;
end;

function TIdTCPServerPeer.GetDefaultPort: TIPPortPeer;
begin
  Result := FTCPServer.DefaultPort;
end;

function TIdTCPServerPeer.GetIOHandler: IIPServerIOHandler;
begin
  if FTCPServer.IOHandler = nil then
    Result := nil
  else if Assigned(FServerIOHandler) and (FServerIOHandler.GetObject = FTCPServer.IOHandler) then
    Result := FServerIOHandler
  else
  begin
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
    if FTCPServer.IOHandler is TIdServerIOHandlerSSLOpenSSL then
      Result := TIdServerIOHandlerSSLOpenSSLPeer.Create(FTCPServer.IOHandler as TIdServerIOHandlerSSLOpenSSL)
    else
{$ENDIF}	
      Result := TIdServerIOHandlerPeer.Create(FTCPServer.IOHandler);
    FServerIOHandler := Result;
  end;
end;

function TIdTCPServerPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdTCPServerPeer.GetObject: TObject;
begin
  Result := FTCPServer;
end;

function TIdTCPServerPeer.GetOnConnect: TIPServerThreadEventPeer;
begin
  if Assigned(FTCPServer.OnConnect) then
    Result := FOnConnectEvent
  else
    Result := nil;
end;

function TIdTCPServerPeer.GetOnDisconnect: TIPServerThreadEventPeer;
begin
  if Assigned(FTCPServer.OnDisconnect) then
    Result := FOnDisconnectEvent
  else
    Result := nil;
end;

function TIdTCPServerPeer.GetOnExecute: TIPServerThreadEventPeer;
begin
  if Assigned(FTCPServer.OnExecute) then
    Result := FOnExecuteEvent
  else
    Result := nil;
end;

function TIdTCPServerPeer.GetScheduler: IIPScheduler;
begin
  if FTCPServer.Scheduler = nil then
    Result := nil
  else if Assigned(FScheduler) and (FScheduler.GetObject = FTCPServer.Scheduler) then
    Result := FScheduler
  else
  begin
    Result := TIdSchedulerPeer.Create(FTCPServer.Scheduler);
    FScheduler := Result;
  end;
end;

function TIdTCPServerPeer.GetUseNagle: Boolean;
begin
  Result := FTCPServer.UseNagle;
end;

procedure TIdTCPServerPeer.SetActive(Val: Boolean);
begin
  FTCPServer.Active := Val;
end;

procedure TIdTCPServerPeer.SetBindings(ABindings: IIPSocketHandles);
begin
  FTCPServer.Bindings := ABindings.GetObject as TIdSocketHandles;
  FSocketHandles := ABindings;
end;

procedure TIdTCPServerPeer.SetDefaultPort(port: TIPPortPeer);
begin
  FTCPServer.DefaultPort := port;
end;

procedure TIdTCPServerPeer.SetIOHandler(handler: IIPServerIOHandler);
begin
  FTCPServer.IOHandler := handler.GetObject as TIdServerIOHandler;
  FServerIOHandler := handler;
end;

procedure TIdTCPServerPeer.SetOnConnect(event: TIPServerThreadEventPeer);
begin
  FTCPServer.OnConnect := LOnConnectEvent;
  FOnConnectEvent := event;
end;

procedure TIdTCPServerPeer.SetOnDisconnect(event: TIPServerThreadEventPeer);
begin
  FTCPServer.OnDisconnect := LOnDisconnectEvent;
  FOnDisconnectEvent := event;
end;

procedure TIdTCPServerPeer.SetOnExecute(event: TIPServerThreadEventPeer);
begin
  FTCPServer.OnExecute := LOnExecuteEvent;
  FOnExecuteEvent := event;
end;

procedure TIdTCPServerPeer.SetScheduler(AScheduler: IIPScheduler);
begin
  FTCPServer.Scheduler := AScheduler.GetObject as TIdScheduler;
  FScheduler := AScheduler;
end;

procedure TIdTCPServerPeer.SetUseNagle(Use: Boolean);
begin
  FTCPServer.UseNagle := Use;
end;

{ TIPTestServerPeer }

constructor TIPTestServerPeer.TOnGetPassword.Create(const APassword: string);
begin
  FPassword := APassword;
end;

procedure TIPTestServerPeer.TOnGetPassword.OnGetPassword(var APassword: string);
begin
  APassword := FPassword;
end;

procedure TIPTestServerPeer.GetExtensionMimeType(const ADictionary: TDictionary<string, string>);
var
  LMimeTable: TMimeTable;
  I: Integer;
  LContentType, LExtension: string;
begin
  if ADictionary <> nil then
  begin
    LMimeTable := TMimeTable.Create(False);
    try
      LMimeTable.LoadTypesFromOS := False;
      LMimeTable.BuildCache;
      Assert(LMimeTable.FMIMEList.Count = LMimeTable.FFileExt.Count);
      for I := 0 to LMimeTable.FFileExt.Count - 1 do
      begin
        LExtension := LowerCase(Copy(LMimeTable.FFileExt[I], 2));
        LContentType := LowerCase(LMimeTable.FMIMEList[I]);
        if ADictionary.ContainsKey(LExtension) then
        begin
          // Ignore Duplicates
        end
        else
          ADictionary.Add(LExtension, LContentType);
      end;
    finally
      LMimeTable.Free;
    end;
  end;
end;

function TIPTestServerPeer.GetOpenPort: Integer;
var
  ServerSocket: TIdSocketHandle;
begin
  Result := 0;

  ServerSocket := TIdSocketHandle.Create(nil);
  ServerSocket.IP := '0.0.0.0';  { Id_INADDR_ANY }
  ServerSocket.Port := 0;
  try
    TIdStack.IncUsage;
    try
      ServerSocket.AllocateSocket;
      try
{$IFDEF POSIX}
        ServerSocket.SetSockOpt(Id_SOL_SOCKET, Id_SO_REUSEADDR, Id_SO_True);
{$ENDIF}
        ServerSocket.Bind;
        Result := ServerSocket.Port;
      finally
        ServerSocket.CloseSocket;
      end;
    finally
      TIdStack.DecUsage;
    end;
  except
  end;
end;

procedure TIPTestServerPeer.TestCertificateFiles(const APort: Integer;
  const ACertFileName, AKeyFileName, ARootCertFile: string; const AKeyFilePassword: string);
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
var
  IdHTTPServer1: TIdHTTPServer;
  IdServerIOHandlerSSLOpenSSL1: TIdServerIOHandlerSSLOpenSSL;
  IdHTTP1: TIdHTTP;
  IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
  LOnGetPassword: TOnGetPassword;
  LStrings: TStrings;
begin
  IdHTTPServer1 :=nil;
  IdServerIOHandlerSSLOpenSSL1 :=nil;
  IdHTTP1 := nil;
  IdSSLIOHandlerSocketOpenSSL1 := nil;
  LOnGetPassword := nil;
  LStrings := nil;
  try
    IdHTTPServer1 := TIdHTTPServer.Create(nil);
    IdServerIOHandlerSSLOpenSSL1 := TIdServerIOHandlerSSLOpenSSL.Create(nil);
    IdHTTP1 := TIdHTTP.Create(nil);
    IdSSLIOHandlerSocketOpenSSL1 := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    LOnGetPassword := TOnGetPassword.Create(AKeyFilePassword);
    LStrings := TStringList.Create;

    IdHTTPServer1.IOHandler := IdServerIOHandlerSSLOpenSSL1;
    IdServerIOHandlerSSLOpenSSL1.SSLOptions.CertFile := ACertFileName;
    IdServerIOHandlerSSLOpenSSL1.SSLOptions.RootCertFile := ARootCertFile;
    IdServerIOHandlerSSLOpenSSL1.SSLOptions.KeyFile := AKeyFileName;
    IdServerIOHandlerSSLOpenSSL1.OnGetPassword := LOnGetPassword.OnGetPassword;
    IdHTTPServer1.DefaultPort := APort;
    IdHTTPServer1.Active := True;

    IdHTTP1.IOHandler := IdSSLIOHandlerSocketOpenSSL1;
    IdHTTP1.IOHandler.Port := APort;
    IdHTTP1.Post(Format('https://localhost:%d/abc', [APort]), LStrings)    // Do not localize
  finally
    IdHTTPServer1.Free;
    IdServerIOHandlerSSLOpenSSL1.Free;
    IdHTTP1.Free;
    IdSSLIOHandlerSocketOpenSSL1.Free;
    LStrings.Free;
    LOnGetPassword.Free;
  end;
end;
{$ELSE}
begin
end;
{$ENDIF}

procedure TIPTestServerPeer.TestOpenPort(const APort: Integer; const AOnExecute: TIPServerThreadEventPeer);
var
  LPeer: IIPTCPServer;
  LServer: TIdTCPServer;
begin
  LPeer := TIdTCPServerPeer.Create(nil);
  LPeer.SetOnExecute(AOnExecute);
  LServer := LPeer.GetObject as TIdTCPServer;
  LServer.Bindings.DefaultPort := APort;
  LServer.Active := True;
  LServer.StartListening;
end;

function IPImpId: string;
begin
  Result := IPPeerCommon.IPImpId;
end;

{ TIdUDPServerIP }

destructor TIdUDPServerIP.Destroy;
begin
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdUDPServerPeer }

procedure TIdUDPServerPeer.Broadcast(const AData: string; const APort: TIPPortPeer; const AIP: string;
  AByteEncoding: IIPTextEncodingPeer);
var
  LEncoding: IIdTextEncoding;
begin
  if (AByteEncoding = nil) or Supports(AByteEncoding, IIdTextEncoding, LEncoding) then
    FUDPServer.Broadcast(AData, APort, AIP, LEncoding)
  else
    raise EIPPeerException.Create(sNotIdEncodingIntf)
end;

procedure TIdUDPServerPeer.Broadcast(const AData: TIPBytesPeer; const APort: TIPPortPeer; const AIP: string);
begin
  FUDPServer.Broadcast(TIdBytes(AData), APort, AIP);
end;

constructor TIdUDPServerPeer.Create(AOwner: TComponent);
begin
  FUDPServer := TIdUDPServerIP.Create(AOwner);
  FUDPServer.FSetDestroyedProc := SetDestroyed;
end;

destructor TIdUDPServerPeer.Destroy;
begin
  FUDPServer.Active := False;
  FSocketHandles := nil;
  FCurrentBinding := nil;

  if NeedToFree then
    FUDPServer.Free;
  inherited;
end;

function TIdUDPServerPeer.GetActive: Boolean;
begin
  Result := FUDPServer.Active;
end;

function TIdUDPServerPeer.GetBindings: IIPSocketHandles;
begin
  if FUDPServer.Bindings = nil then
    Result := nil
  else if Assigned(FSocketHandles) and (FSocketHandles.GetObject = FUDPServer.Bindings) then
    Result := FSocketHandles
  else
  begin
    Result := TIdSocketHandlesPeer.Create(FUDPServer.Bindings);
    FSocketHandles := Result;
  end;
end;

function TIdUDPServerPeer.GetDefaultPort: TIPPortPeer;
begin
  Result := FUDPServer.DefaultPort;
end;

function TIdUDPServerPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdUDPServerPeer.GetIPVersion: TIPVersionPeer;
begin
  Result := TIPVersionPeer(FUDPServer.IPVersion);
end;

function TIdUDPServerPeer.GetObject: TObject;
begin
  Result := FUDPServer;
end;

function TIdUDPServerPeer.GetOnException: TIPUDPExceptionEventPeer;
begin
  if Assigned(FUDPServer.OnUDPException) then
    Result := FOnUDPException
  else
    Result := nil;
end;

function TIdUDPServerPeer.GetOnRead: TIPUDPReadEventPeer;
begin
  if Assigned(FUDPServer.OnUDPRead) then
    Result := FOnUDPRead
  else
    Result := nil;
end;

function TIdUDPServerPeer.GetThreadedEvent: boolean;
begin
  Result := FUDPServer.ThreadedEvent;
end;

procedure TIdUDPServerPeer.LOnUDPException(AThread: TIdUDPListenerThread; ABinding: TIdSocketHandle;
  const AMessage: string; const AExceptionClass: TClass);
var
  LThread: IIPUDPListenerThread;
  LBinding: IIPSocketHandle;
begin
  if Assigned(FOnUDPException) then
  begin
    LThread := TIdUDPListenerThreadPeer.Create(AThread);
    LBinding := PeerFactory.CreatePeer(IPImpId, IIPSocketHandle, ABinding) as IIPSocketHandle;
    FOnUDPException(LThread, LBinding, AMessage, AExceptionClass);
  end;
end;

procedure TIdUDPServerPeer.LOnUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  LThread: IIPUDPListenerThread;
  LBinding: IIPSocketHandle;
begin
  if Assigned(FOnUDPRead) then
  begin
    LThread := TIdUDPListenerThreadPeer.Create(AThread);
    LBinding := PeerFactory.CreatePeer(IPImpId, IIPSocketHandle, ABinding) as IIPSocketHandle;
    FOnUDPRead(LThread, TIPBytesPeer(AData), LBinding);
  end;
end;

procedure TIdUDPServerPeer.Send(const AHost: string; const APort: TIPPortPeer; const AData: string;
  AByteEncoding: IIPTextEncodingPeer);
var
  LEncoding: IIdTextEncoding;
begin
  if (AByteEncoding = nil) or Supports(AByteEncoding, IIdTextEncoding, LEncoding) then
    FUDPServer.Send(AHost, APort, AData, LEncoding)
  else
    raise EIPPeerException.Create(sNotIdEncodingIntf)
end;

procedure TIdUDPServerPeer.SendBuffer(const AHost: string; const APort: TIPPortPeer; const ABuffer: TIPBytesPeer);
begin
  FUDPServer.SendBuffer(AHost, APort, TIdBytes(ABuffer));
end;

procedure TIdUDPServerPeer.SetActive(Val: Boolean);
begin
  FUDPServer.SetActive(Val);
end;

procedure TIdUDPServerPeer.SetBindings(ABindings: IIPSocketHandles);
begin
  FUDPServer.Bindings := ABindings.GetObject as TIdSocketHandles;
  FSocketHandles := ABindings;
end;

procedure TIdUDPServerPeer.SetDefaultPort(APort: TIPPortPeer);
begin
  FUDPServer.SetDefaultPort(APort);
end;


procedure TIdUDPServerPeer.SetIPVersion(const AValue: TIPVersionPeer);
begin
  FUDPServer.IPVersion := TIdIPVersion(AValue);
end;

procedure TIdUDPServerPeer.SetOnException(AEvent: TIPUDPExceptionEventPeer);
begin
  FUDPServer.OnUDPException := LOnUDPException;
  FOnUDPException := AEvent;
end;

procedure TIdUDPServerPeer.SetOnRead(AEvent: TIPUDPReadEventPeer);
begin
  FUDPServer.OnUDPRead := LOnUDPRead;
  FOnUDPRead := AEvent;
end;

procedure TIdUDPServerPeer.SetThreadedEvent(const Value: boolean);
begin
  FUDPServer.ThreadedEvent := Value;
end;

{ TIdUDPListenerThreadIP }

destructor TIdUDPListenerThreadIP.Destroy;
begin
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdUDPListenerThreadPeer }

constructor TIdUDPListenerThreadPeer.Create(AThread: TIdUDPListenerThread);
begin
  FListenerThread := AThread;
end;

function TIdUDPListenerThreadPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdUDPListenerThreadPeer.GetObject: TObject;
begin
  Result := FListenerThread;
end;

{ TIPMulticastServerPeer }

constructor TIPMulticastServerPeer.Create(AOwner: TComponent);
begin
  inherited Create;
  FMulticastServer := TIdIPMCastServer.Create(AOwner);
end;

destructor TIPMulticastServerPeer.Destroy;
begin
  FMulticastServer.Free;
  inherited;
end;

function TIPMulticastServerPeer.GetActive: Boolean;
begin
  Result := FMulticastServer.Active;
end;

function TIPMulticastServerPeer.GetBinding: IIPSocketHandle;
begin
  Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSocketHandle, FMulticastServer.Binding) as IIPSocketHandle
//  Result := FMulticastServer.Binding;
end;

function TIPMulticastServerPeer.GetBoundIP: string;
begin
  Result := FMulticastServer.BoundIP;
end;

function TIPMulticastServerPeer.GetBoundPort: TIPPortPeer;
begin
  Result := FMulticastServer.BoundPort;
end;

function TIPMulticastServerPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIPMulticastServerPeer.GetIPVersion: TIPVersionPeer;
begin
  Result := TIPVersionPeer(FMulticastServer.IPVersion);
end;

function TIPMulticastServerPeer.GetLoopback: Boolean;
begin
  Result := FMulticastServer.Loopback;
end;

function TIPMulticastServerPeer.GetMulticastGroup: string;
begin
  Result := FMulticastServer.MulticastGroup;
end;

function TIPMulticastServerPeer.GetObject: TObject;
begin
  Result := FMulticastServer;
end;

function TIPMulticastServerPeer.GetPort: TIPPortPeer;
begin
  Result := TIPPortPeer(FMulticastServer.Port);
end;

function TIPMulticastServerPeer.GetTTL: Byte;
begin
  Result := FMulticastServer.TimeToLive;
end;

procedure TIPMulticastServerPeer.Send(const ABuffer: TIPBytesPeer);
begin
  FMulticastServer.Send(TIdBytes(ABuffer));
end;

procedure TIPMulticastServerPeer.Send(const ABuffer: TIPBytesPeer; const APort: TIPPortPeer);
var
  oldPort: TIdPort;
begin
  oldPort := FMulticastServer.Port;
  FMulticastServer.Port := TIdPort(APort);
  FMulticastServer.Send(TIdBytes(ABuffer));
  FMulticastServer.Port := oldPort;
end;

procedure TIPMulticastServerPeer.Send(const AData: string; const AByteEncoding: IIPTextEncodingPeer);
var
  LEncoding: IIdTextEncoding;
begin
  if (AByteEncoding = nil) or Supports(AByteEncoding, IIdTextEncoding, LEncoding) then
    FMulticastServer.Send(AData, LEncoding)
  else
    raise EIPPeerException.Create(sNotIdEncodingIntf)
end;

procedure TIPMulticastServerPeer.SetActive(const AValue: Boolean);
begin
  FMulticastServer.Active := AValue;
end;

procedure TIPMulticastServerPeer.SetBoundIP(const ABoundIP: string);
begin
  FMulticastServer.BoundIP := ABoundIP;
end;

procedure TIPMulticastServerPeer.SetBoundPort(const APort: TIPPortPeer);
begin
  FMulticastServer.BoundPort := Word(APort);
end;

procedure TIPMulticastServerPeer.SetIPVersion(const AValue: TIPVersionPeer);
begin
  FMulticastServer.IPVersion := TIdIPVersion(AValue);
end;

procedure TIPMulticastServerPeer.SetLoopback(const AValue: Boolean);
begin
  FMulticastServer.Loopback := AValue;
end;

procedure TIPMulticastServerPeer.SetMulticastGroup(const AValue: string);
begin
  FMulticastServer.MulticastGroup := AValue;
end;

procedure TIPMulticastServerPeer.SetPort(const AValue: TIPPortPeer);
begin
  FMulticastServer.Port := Word(AValue);
end;

procedure TIPMulticastServerPeer.SetTTL(const AValue: Byte);
begin
  FMulticastServer.TimeToLive := AValue;
end;

initialization
  //server specific peers
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  PeerFactory.RegisterPeer(IPImpId, IIPServerIOHandlerSSLOpenSSL, TIdServerIOHandlerSSLOpenSSLPeer);
{$ENDIF}
  PeerFactory.RegisterPeer(IPImpId, IIPStack, TIdStackPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPHTTPServer, TIdHTTPServerPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPSchedulerOfThreadPool, TIdSchedulerOfThreadPoolPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPTCPServer, TIdTCPServerPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPTestServer, TIPTestServerPeer);

  PeerFactory.RegisterPeer(IPImpId, IIPUDPServer, TIdUDPServerPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPUDPListenerThread, TIdUDPListenerThreadPeer);

  PeerFactory.RegisterPeer(IPImpId, IIPMulticastServer, TIPMulticastServerPeer);

finalization
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  PeerFactory.UnregisterPeerClass(IPImpId, TIdServerIOHandlerSSLOpenSSLPeer);
{$ENDIF}
  PeerFactory.UnregisterPeerClass(IPImpId, TIdStackPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdHTTPServerPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdSchedulerOfThreadPoolPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdTCPServerPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIPTestServerPeer);

  PeerFactory.UnregisterPeerClass(IPImpId, TIdUDPServerPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdUDPListenerThreadPeer);

  PeerFactory.UnregisterPeerClass(IPImpId, TIPMulticastServerPeer);

end.
