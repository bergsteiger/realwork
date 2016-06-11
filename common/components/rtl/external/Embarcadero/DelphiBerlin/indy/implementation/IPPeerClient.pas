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

unit IPPeerClient;

interface

//This uses must be here to force a correct finalization order
uses
  System.Classes, System.SysUtils,
  IdIOHandlerSocket, IdIOHandler, IdHTTP, IdAuthentication, IdURI,
  IdHTTPHeaderInfo,
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
  IdSSLOpenSSL,
{$ENDIF}
  IdTCPClient, IdStack, IdGlobal,
  IdHashMessageDigest,
  IdCookieManager,
  IdIPMCastClient,
  IdSocketHandle,

  IPPeerCommon, IPPeerResStrs,
  IPPeerAPI; //put last because we have some type names identical to indy ones in here

function IPImpId: string;

implementation

type
  TIdTCPClientIP = class(TIdTCPClient)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdTCPClientPeerIP = class(TIdClassIP, IIPTCPClient, IIPObject)
  private
    FTCPClient: TIdTCPClientIP;
    FIOHandler: IIPIOHandler;
    FSocket: IIPIOHandlerSocket;
  protected
    function Connected: Boolean;
    function GetSocket: IIPIOHandlerSocket;
    procedure SetIOHandler(Handler: IIPIOHandler);
    function GetIOHandler: IIPIOHandler;
    function GetBoundIP: string;
    procedure SetBoundIP(IP: string);
    function GetHost: string;
    procedure SetHost(LHost: string);
    function GetPort: TIPPortPeer;
    procedure SetPort(LPort: TIPPortPeer);
    procedure SetIPVersion(const AValue: TIPVersionPeer);
    function GetIPVersion: TIPVersionPeer;
    function GetUseNagle: Boolean;
    procedure SetUseNagle(Use: Boolean);
    procedure Connect;
    procedure Disconnect;
    function GetManagedIOHandler: Boolean;
    procedure SetManagedIOHandler(AManagedIOHandler: Boolean);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

  TIdURIPeer = class(TInterfacedObject, IIPURI, IIPObject)
  private
    FURI: TIdURI;
    //constructor Create(AURI: TIdURI);
  protected
    function URLEncode(const ASrc: string; AByteEncoding: IIPTextEncodingPeer = nil): string;
    function GetProtocol: string;
    function GetFullURI: string;
    procedure SetURI(const AValue: string);
    function GetURI: string;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
  end;

  TIdURIPeerFactory = class(TIdURIPeer, IIPURI, IIPObject)
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TIdAuthenticationPeer = class(TInterfacedObject, IIPAuthentication, IIPObject)
  private
    FAuth: TIdAuthentication;
    //constructor Create(Auth: TIdAuthentication);
  protected
    function GetUserName: string;
    procedure SetUsername(user: string);
    function GetPassword: string;
    procedure SetPassword(pass: string);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
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

  TIdHTTPRequestPeer = class(TIdEntityHeaderInfoPeer, IIPHTTPRequest, IIPObject)
  private
    FRequest: TIdHTTPRequest;
    FAuthentication: IIPAuthentication;
  protected
    function GetAuthentication: IIPAuthentication;
    procedure SetAuthentication(const auth: IIPAuthentication);
    function GetAccept: string;
    procedure SetAccept(const Val: string);
    function GetUserAgent: string;
    procedure SetUserAgent(const Val: string);
    function GetAcceptCharSet: string;
    procedure SetAcceptCharSet(const Val: string);
    function GetAcceptEncoding: string;
    procedure SetAcceptEncoding(const Val: string);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(IndyHTTPRequest: TIdHTTPRequest);
    destructor Destroy; override;
  end;

  TIdHTTPResponsePeer = class(TIdEntityHeaderInfoPeer, IIPHTTPResponse, IIPObject)
  private
    FResponse: TIdHTTPResponse;
  protected
    function GetResponseText: string;
    procedure SetResponseText(LResponseText: string);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(IndyHTTPResponse: TIdHTTPResponse);
  end;

  TIdProxyConnectionInfoPeer = class(TInterfacedObject, IIPProxyConnectionInfo, IIPObject)
  private
    FProxyInfo: TIdProxyConnectionInfo;
  protected
    function GetProxyServer: string;
    procedure SetProxyServer(Val: string);
    function GetProxyPort: Integer;
    procedure SetProxyPort(Val: Integer);
    function GetProxyUserName: string;
    procedure SetProxyUserName(user: string);
    function GetProxyPassword: string;
    procedure SetProxyPassword(pass: string);
    function GetBasicAuthentication: Boolean;
    procedure SetBasicAuthentication(Val: Boolean);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(ProxyInfo: TIdProxyConnectionInfo);
  end;

  TIdHTTPIP = class(TIdHTTP)
  private
    FSetDestroyedProc: procedure of object;
    FProtocol: string;
  protected
    ///  <summary> Initializes the component, setting several HTTP related properties. </summary>
    procedure InitComponent; override;
    destructor Destroy; override;
  end;

  TIdHTTPPeer = class(TIdClassIP, IIPHTTP, IIPObject)
  private
    FHTTP: TIdHTTPIP;
    FIOHandler: IIPIOHandler;
    FRequest: IIPHTTPRequest;
    FResponse: IIPHTTPResponse;
    FProxyConnInfo: IIPProxyConnectionInfo;
    FSocket: IIPIOHandlerSocket;
    FURL: IIPURI;
    procedure CreateCookieManager;
  protected
    function Connected: Boolean;
    procedure Disconnect;
    procedure SetProtocol(Protocol: string);
    function GetProtocol: string;
    function GetResponseCode: Integer;
    function GetResponseText: string;
    function GetResponse: IIPHttpResponse;
    function GetRequest: IIPHTTPRequest;
    function GetIOHandler: IIPIOHandler;
    procedure SetIOHandler(Handler: IIPIOHandler);
    function GetProxyParams: IIPProxyConnectionInfo;
    procedure SetProxyParams(const Value: IIPProxyConnectionInfo);
    function GetUseNagle: Boolean;
    procedure SetUseNagle(Use: Boolean);
    procedure SetIPVersion(const AValue: TIPVersionPeer);
    function GetIPVersion: TIPVersionPeer;
    function GetHTTPOptions: TIPHTTPOptionsPeer;
    procedure SetHTTPOptions(Options: TIPHTTPOptionsPeer);
    procedure DoRequestMethod(AMethod: string; URL: string; Source, ResponseContent: TStream; AIgnoreReplies: array of SmallInt);
    procedure DoRequestHead(URL: string; Source, ResponseContent: TStream; AIgnoreReplies: array of SmallInt);
    procedure DoRequestDelete(URL: string; Source, ResponseContent: TStream; AIgnoreReplies: array of SmallInt);
    function DoGet(AURL: string): string; overload;
    function DoGet(AURL: string; AResponseContent: TStream): string; overload;
    function DoPost(AURL: string; Source: TStream): string; overload;
    function DoPost(AURL: string; Source: TStrings): string; overload;
    procedure DoPost(AURL: string; ASource, AResponseContent: TStream); overload;
    function DoPut(AURL: string; Source: TStream): string; overload;
    procedure DoPut(AURL: string; ASource, AResponseContent: TStream); overload;
    function DoPatch(AURL: string; Source: TStream): string; overload;
    procedure DoPatch(AURL: string; ASource, AResponseContent: TStream); overload;
    function GetConnectTimeout: Integer;
    procedure SetConnectTimeout(timeout: Integer);
    function GetReadTimeout: Integer;
    procedure SetReadTimeout(timeout: Integer);
    function GetURL: IIPURI;
    function GetSocket: IIPIOHandlerSocket;
    function GetManagedIOHandler: Boolean;
    procedure SetManagedIOHandler(AManagedIOHandler: Boolean);
    function GetHandleRedirects: Boolean;
    procedure SetHandleRedirects(AValue: Boolean);
    function GetAllowCookies: Boolean;
    procedure SetAllowCookies(AValue: Boolean);
    function GetCookieManager: IIPCookieManager;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure FreeIOHandler;
  end;

  TIdCookieManagerPeer = class(TInterfacedObject, IIPCookieManager, IIPObject)
  private
    FIdHTTPPeer: TIdHTTPPeer;
  protected
    procedure AddServerCookie(const ACookie, AURL: string);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AIdHTTPPeer: TIdHTTPPeer);
  end;

  TIdBasicAuthenticationIP = class(TIdBasicAuthentication)
  private
    FSetDestroyedProc: procedure of object;
  public
    destructor Destroy; override;
  end;

  TIdHashMessageDigest5Peer = class(TIdClassIP, IIPHashMessageDigest5, IIPObject)
  private
    FHash: TIdHashMessageDigest5;
  protected
    function GetObject: TObject;
    function GetIPImplementationID: string;
    function HashBytesAsHex(const ASrc: TIPBytesPeer): String;
    function HashStringAsHex(const ASrc: string): String;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TIdBasicAuthenticationPeer = class(TIdClassIP, IIPBasicAuthentication, IIPObject)
  private
    FObj: TIdBasicAuthenticationIP;
  protected
    function GetUserName: string;
    procedure SetUsername(user: string);
    function GetPassword: string;
    procedure SetPassword(pass: string);
    function GetAuthentication: string;
  public
    constructor Create;
    destructor Destroy; override;
    function GetObject: TObject;
    function GetIPImplementationID: string;
  end;

  TIPMulticastClientPeer = class(TInterfacedObject, IIPMulticastClient, IIPObject)
  private
    FMulticastClient: TIdIPMCastClient;
    FOnIPMCastRead: TIPMCastReadEventPeer;
    FSocketHandles: IIPSocketHandles;

    procedure DoOnIPMCastRead(Sender: TObject; const AData: TIdBytes; ABinding: TIdSocketHandle);
  protected

    function GetBinding: IIPSocketHandle;

    function GetActive: Boolean;
    procedure SetActive(const AValue: Boolean);
    function GetMulticastGroup: string;
    procedure SetMulticastGroup(const AValue: string);
    function GetPort: TIPPortPeer;
    procedure SetPort(const APort: TIPPortPeer);
    function GetIPVersion: TIPVersionPeer;
    procedure SetIPVersion(const AValue: TIPVersionPeer);

    function GetOnMulticast: TIPMCastReadEventPeer;
    procedure SetOnMulticast(const AEvent: TIPMCastReadEventPeer);

    function GetThreadedEvent: boolean;
    procedure SetThreadedEvent(const AValue: boolean);

    function GetDefaultPort: TIPPortPeer;
    procedure SetDefaultPort(const APort: TIPPortPeer);

    function GetBindings: IIPSocketHandles;
    procedure SetBindings(ABindings: IIPSocketHandles);

  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
  end;

{ TIdHTTPIP }

destructor TIdHTTPIP.Destroy;
begin
  //Let Peer know that object is destroyed
  FSetDestroyedProc();
  inherited;
end;

procedure TIdHTTPIP.InitComponent;
begin
  inherited;
  FProtocol := 'http';

  HandleRedirects := True;
end;

{ TIdHTTPPeer }

procedure TIdHTTPPeer.DoRequestMethod(AMethod, URL: string; Source,
  ResponseContent: TStream; AIgnoreReplies: array of SmallInt);
begin
  try
    FHTTP.DoRequest(AMethod, URL, Source, ResponseContent, AIgnoreReplies);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

procedure TIdHTTPPeer.DoRequestDelete(URL: string; Source,
  ResponseContent: TStream; AIgnoreReplies: array of SmallInt);
begin
  try
    FHTTP.DoRequest(Id_HTTPMethodDelete, URL, Source, ResponseContent, AIgnoreReplies);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

procedure TIdHTTPPeer.DoRequestHead(URL: string; Source,
  ResponseContent: TStream; AIgnoreReplies: array of SmallInt);
begin
  try
    FHTTP.DoRequest(Id_HTTPMethodHead, URL, Source, ResponseContent, AIgnoreReplies);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

procedure TIdHTTPPeer.FreeIOHandler;
begin
  if Assigned(FHTTP.FIOHandler) then
    {$IFDEF NEXTGEN}
    FHTTP.FIOHandler := nil;
    {$ELSE}
    FreeAndNil(FHTTP.FIOHandler);
    {$ENDIF}
  FIOHandler := nil;
end;

function TIdHTTPPeer.DoGet(AURL: string): string;
begin
  try
    Result := FHTTP.Get(AURL);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

function TIdHTTPPeer.Connected: Boolean;
begin
  Result := FHTTP.Connected
end;

constructor TIdHTTPPeer.Create(AOwner: TComponent);
begin
  FIOHandler := nil;
  FRequest := nil;
  FResponse := nil;
  FProxyConnInfo := nil;
  FSocket := nil;
  FURL := nil;
  FHTTP := TIdHTTPIP.Create(AOwner);
  FHTTP.FSetDestroyedProc := SetDestroyed;
end;

procedure TIdHTTPPeer.CreateCookieManager;
begin
  if FHTTP.CookieManager = nil then
    FHTTP.CookieManager := TIdCookieManager.Create(FHTTP);
end;

destructor TIdHTTPPeer.Destroy;
begin
  //Clear interface references (TODO: check order of nil'ing)
  FIOHandler := nil;
  FProxyConnInfo := nil;

  if NeedToFree then
    FHTTP.Free;
  inherited;
end;

procedure TIdHTTPPeer.Disconnect;
begin
  FHTTP.Disconnect;
end;

function TIdHTTPPeer.DoGet(AURL: string; AResponseContent: TStream): string;
begin
  try
    FHTTP.Get(AURL, AResponseContent);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

function TIdHTTPPeer.DoPost(AURL: string; Source: TStream): string;
begin
  try
    Result := FHTTP.Post(AURL, Source)
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

function TIdHTTPPeer.DoPost(AURL: string; Source: TStrings): string;
begin
  try
    Result := FHTTP.Post(AURL, Source)
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

procedure TIdHTTPPeer.DoPost(AURL: string; ASource, AResponseContent: TStream);
begin
  try
    FHTTP.Post(AURL, ASource, AResponseContent)
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

procedure TIdHTTPPeer.DoPut(AURL: string; ASource, AResponseContent: TStream);
begin
  try
    FHTTP.Put(AURL, ASource, AResponseContent);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

function TIdHTTPPeer.DoPut(AURL: string; Source: TStream): string;
begin
  try
    Result := FHTTP.Put(AURL, Source);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

function TIdHTTPPeer.DoPatch(AURL: string; Source: TStream): string;
begin
  try
    Result := FHTTP.Patch(AURL, Source);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

procedure TIdHTTPPeer.DoPatch(AURL: string; ASource, AResponseContent: TStream);
begin
  try
    FHTTP.Patch(AURL, ASource, AResponseContent);
  except
    on E: EIdHTTPProtocolException do
      raise EIPHTTPProtocolExceptionPeer.Create(E, E.ErrorMessage, E.Message, E.ErrorCode)
  end;
end;

function TIdHTTPPeer.GetAllowCookies: Boolean;
begin
  Result := FHTTP.AllowCookies;
end;

function TIdHTTPPeer.GetConnectTimeout: Integer;
begin
  Result := FHTTP.ConnectTimeout;
end;

function TIdHTTPPeer.GetCookieManager: IIPCookieManager;
begin
  CreateCookieManager;
  Result := TIdCookieManagerPeer.Create(Self);
end;

function TIdHTTPPeer.GetHandleRedirects: Boolean;
begin
  Result := FHTTP.AllowCookies;
end;

function TIdHTTPPeer.GetHTTPOptions: TIPHTTPOptionsPeer;
begin
  Result := [];
  if TIdHTTPOption.hoInProcessAuth in FHTTP.HTTPOptions then
    Result := Result + [TIPHTTPOptionPeer.hoInProcessAuth];
  if TIdHTTPOption.hoKeepOrigProtocol in FHTTP.HTTPOptions then
    Result := Result + [TIPHTTPOptionPeer.hoKeepOrigProtocol];
  if TIdHTTPOption.hoForceEncodeParams in FHTTP.HTTPOptions then
    Result := Result + [TIPHTTPOptionPeer.hoForceEncodeParams];
  if TIdHTTPOption.hoNonSSLProxyUseConnectVerb in FHTTP.HTTPOptions then
    Result := Result + [TIPHTTPOptionPeer.hoNonSSLProxyUseConnectVerb];
  if TIdHTTPOption.hoNoParseMetaHTTPEquiv in FHTTP.HTTPOptions then
    Result := Result + [TIPHTTPOptionPeer.hoNoParseMetaHTTPEquiv];
  if TIdHTTPOption.hoWaitForUnexpectedData in FHTTP.HTTPOptions then
    Result := Result + [TIPHTTPOptionPeer.hoWaitForUnexpectedData];
end;

function TIdHTTPPeer.GetIOHandler: IIPIOHandler;
begin
  if FHTTP.IOHandler = nil then
    Result := nil
  else if Assigned(FIOHandler) and (FIOHandler.GetObject = FHTTP.IOHandler) then
   Result := FIOHandler
  else
  begin
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
    if FHTTP.IOHandler is TIdSSLIOHandlerSocketOpenSSL then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSSLIOHandlerSocketOpenSSL, FHTTP.IOHandler) as IIPSSLIOHandlerSocketOpenSSL
      //Result := TIdSSLIOHandlerSocketOpenSSLPeer.Create(FHTTP.IOHandler as TIdSSLIOHandlerSocketOpenSSL)
    else 
{$ENDIF}	
	if FHTTP.IOHandler is TIdIOHandlerSocket then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandlerSocket, FHTTP.IOHandler) as IIPIOHandlerSocket
      //Result := TIdIOHandlerSocketPeer.Create(FHTTP.IOHandler as TIdIOHandlerSocket)
    else
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandler, FHTTP.IOHandler) as IIPIOHandler;
      //Result := TIdIOHandlerPeerIP.Create(FHTTP.IOHandler);
    FIOHandler := Result;
  end;
end;

function TIdHTTPPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHTTPPeer.GetIPVersion: TIPVersionPeer;
begin
  if FHTTP.IPVersion = TIdIPVersion.Id_IPv6 then
    Result := TIPVersionPeer.IP_IPv6
  else
    Result := TIPVersionPeer.IP_IPv4;
end;

function TIdHTTPPeer.GetObject: TObject;
begin
  Result := FHTTP;
end;

function TIdHTTPPeer.GetProtocol: string;
begin
  Result := FHTTP.FProtocol;
end;

function TIdHTTPPeer.GetProxyParams: IIPProxyConnectionInfo;
begin
  if FHTTP.ProxyParams = nil then
    Result := nil
  else if Assigned(FProxyConnInfo) and (FProxyConnInfo.GetObject = FHTTP.ProxyParams) then
    Result := FProxyConnInfo
  else
  begin
    Result := TIdProxyConnectionInfoPeer.Create(FHTTP.ProxyParams);
    FProxyConnInfo := Result;
  end;
end;

procedure TIdHTTPPeer.SetAllowCookies(AValue: Boolean);
begin
  FHTTP.AllowCookies := AValue;
  if AValue then
    CreateCookieManager;
end;

procedure TIdHTTPPeer.SetConnectTimeout(timeout: Integer);
begin
  FHTTP.ConnectTimeout := timeout;
end;

procedure TIdHTTPPeer.SetHandleRedirects(AValue: Boolean);
begin
  FHTTP.HandleRedirects := AValue;
end;

procedure TIdHTTPPeer.SetHTTPOptions(Options: TIPHTTPOptionsPeer);
begin
  FHTTP.HTTPOptions := [];
  if TIPHTTPOptionPeer.hoInProcessAuth in Options then
    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [TIdHTTPOption.hoInProcessAuth];
  if TIPHTTPOptionPeer.hoKeepOrigProtocol in Options then
    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [TIdHTTPOption.hoKeepOrigProtocol];
  if TIPHTTPOptionPeer.hoForceEncodeParams in Options then
    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [TIdHTTPOption.hoForceEncodeParams];
  if TIPHTTPOptionPeer.hoNonSSLProxyUseConnectVerb in Options then
    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [TIdHTTPOption.hoNonSSLProxyUseConnectVerb];
  if TIPHTTPOptionPeer.hoNoParseMetaHTTPEquiv in Options then
    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [TIdHTTPOption.hoNoParseMetaHTTPEquiv];
  if TIPHTTPOptionPeer.hoWaitForUnexpectedData in Options then
    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [TIdHTTPOption.hoWaitForUnexpectedData];
end;

procedure TIdHTTPPeer.SetIOHandler(Handler: IIPIOHandler);
begin
  FHTTP.IOHandler := Handler.GetObject as TIdIOHandler;
  FIOHandler := Handler;
end;

procedure TIdHTTPPeer.SetIPVersion(const AValue: TIPVersionPeer);
begin
  if AValue = TIPVersionPeer.IP_IPv6 then
    FHTTP.IPVersion := TIdIPVersion.Id_IPv6
  else if AValue = TIPVersionPeer.IP_IPv4 then
    FHTTP.IPVersion := TIdIPVersion.Id_IPv4;
end;

procedure TIdHTTPPeer.SetProtocol(Protocol: string);
begin
  FHTTP.FProtocol := Protocol;
end;

procedure TIdHTTPPeer.SetProxyParams(const Value: IIPProxyConnectionInfo);
begin
  FHTTP.ProxyParams := Value.GetObject as TIdProxyConnectionInfo;
  FProxyConnInfo := Value;
end;

procedure TIdHTTPPeer.SetReadTimeout(timeout: Integer);
begin
  FHTTP.ReadTimeout := timeout;
end;

procedure TIdHTTPPeer.SetUseNagle(Use: Boolean);
begin
  FHTTP.UseNagle := Use;
end;

procedure TIdHTTPPeer.SetManagedIOHandler(AManagedIOHandler: Boolean);
begin
  FHTTP.ManagedIOHandler := AManagedIOHandler;
end;

function TIdHTTPPeer.GetReadTimeout: Integer;
begin
  Result := FHTTP.ReadTimeout;
end;

function TIdHTTPPeer.GetRequest: IIPHTTPRequest;
begin
  if FHTTP.Request = nil then
    Result := nil
  else if Assigned(FRequest) and (FRequest.GetObject = FHTTP.Request) then
    Result := FRequest
  else
  begin
    Result := TIdHTTPRequestPeer.Create(FHTTP.Request);
    FRequest := Result;
  end;
end;

function TIdHTTPPeer.GetResponse: IIPHttpResponse;
begin
  if FHTTP.Response = nil then
    Result := nil
  else if Assigned(FResponse) and (FResponse.GetObject = FHTTP.Response) then
    Result := FResponse
  else
  begin
    Result := TIdHTTPResponsePeer.Create(FHTTP.Response);
    FResponse := Result;
  end;
end;

function TIdHTTPPeer.GetResponseCode: Integer;
begin
  Result := FHTTP.ResponseCode;
end;

function TIdHTTPPeer.GetResponseText: string;
begin
  Result := FHTTP.ResponseText;
end;

function TIdHTTPPeer.GetSocket: IIPIOHandlerSocket;
begin
  if FHTTP.Socket = nil then
    Result := nil
  else if Assigned(FSocket) and (FSocket.GetObject = FHTTP.Socket) then
    Result := FSocket
  else
  begin
    Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandlerSocket, FHTTP.Socket) as IIPIOHandlerSocket;
    //Result := TIdIOHandlerSocketPeer.Create(FHTTP.Socket);
    FSocket := Result;
  end;
end;

function TIdHTTPPeer.GetManagedIOHandler: Boolean;
begin
  Result := FHTTP.ManagedIOHandler;
end;

function TIdHTTPPeer.GetURL: IIPURI;
var
  LPeer: TIdURIPeer;
begin
  if FHTTP.URL = nil then
    Result := nil
  else if Assigned(FURL) and (FURL.GetObject = FHTTP.URL) then
    Result := FURL
  else
  begin
    LPeer := TIdURIPeer.Create;
    LPeer.FURI := FHTTP.URL;
    Result := LPeer;
    FURL := Result;
  end;
end;

function TIdHTTPPeer.GetUseNagle: Boolean;
begin
  Result := FHTTP.UseNagle;
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

procedure TIdEntityHeaderInfoPeer.SetContentRangeStart(
  LContentRangeStart: Int64);
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

{ TIdHTTPResponsePeer }

constructor TIdHTTPResponsePeer.Create(IndyHTTPResponse: TIdHTTPResponse);
begin
  inherited Create(IndyHTTPResponse);
  FResponse := IndyHTTPResponse;
end;

function TIdHTTPResponsePeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHTTPResponsePeer.GetObject: TObject;
begin
  Result := FResponse;
end;

function TIdHTTPResponsePeer.GetResponseText: string;
begin
  Result := FResponse.ResponseText;
end;

procedure TIdHTTPResponsePeer.SetResponseText(LResponseText: string);
begin
  FResponse.ResponseText := LResponseText;
end;

{ TIdHTTPRequestPeer }

constructor TIdHTTPRequestPeer.Create(IndyHTTPRequest: TIdHTTPRequest);
begin
  inherited Create(IndyHTTPRequest);
  FAuthentication := nil;
  FRequest := IndyHTTPRequest;
end;

destructor TIdHTTPRequestPeer.Destroy;
begin
  FAuthentication := nil;
  inherited;
end;

function TIdHTTPRequestPeer.GetAccept: string;
begin
  Result := FRequest.Accept;
end;

function TIdHTTPRequestPeer.GetAcceptCharSet: string;
begin
  Result := FRequest.AcceptCharSet;
end;

function TIdHTTPRequestPeer.GetAcceptEncoding: string;
begin
  Result := FRequest.AcceptEncoding;
end;

function TIdHTTPRequestPeer.GetAuthentication: IIPAuthentication;
var
  LPeer: TIdAuthenticationPeer;
begin
  if FRequest.Authentication = nil then
    Result := nil
  else if Assigned(FAuthentication) and (FAuthentication.GetObject = FRequest.Authentication) then
    Result := FAuthentication
  else
  begin
    LPeer := TIdAuthenticationPeer.Create;
    LPeer.FAuth := FRequest.Authentication;
    Result := LPeer;
    FAuthentication := Result;
  end;
end;

function TIdHTTPRequestPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHTTPRequestPeer.GetObject: TObject;
begin
  Result := FRequest;
end;

function TIdHTTPRequestPeer.GetUserAgent: string;
begin
  Result := FRequest.UserAgent;
end;


procedure TIdHTTPRequestPeer.SetAccept(const Val: string);
begin
  FRequest.Accept := Val;
end;

procedure TIdHTTPRequestPeer.SetAcceptCharSet(const Val: string);
begin
  FRequest.AcceptCharSet := Val;
end;

procedure TIdHTTPRequestPeer.SetAcceptEncoding(const Val: string);
begin
  FRequest.AcceptEncoding := Val;
end;

procedure TIdHTTPRequestPeer.SetAuthentication(const auth: IIPAuthentication);
begin
  if auth = nil then
  begin
{$IFNDEF AUTOREFCOUNT}
    if (FAuthentication <> nil) and (FAuthentication.GetObject <> FRequest.Authentication) then
      FRequest.Authentication.Free;
{$ENDIF !AUTOREFCOUNT}
    FRequest.Authentication := nil
  end
  else
    FRequest.Authentication := auth.GetObject as TIdAuthentication;
  FAuthentication := auth;
end;

procedure TIdHTTPRequestPeer.SetUserAgent(const Val: string);
begin
  FRequest.UserAgent := Val;
end;


{ TIdProxyConnectionInfoPeer }

constructor TIdProxyConnectionInfoPeer.Create(
  ProxyInfo: TIdProxyConnectionInfo);
begin
  FProxyInfo := ProxyInfo;
end;

function TIdProxyConnectionInfoPeer.GetBasicAuthentication: Boolean;
begin
  Result := FProxyInfo.BasicAuthentication;
end;

function TIdProxyConnectionInfoPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdProxyConnectionInfoPeer.GetObject: TObject;
begin
  Result := FProxyInfo;
end;

function TIdProxyConnectionInfoPeer.GetProxyPassword: string;
begin
  Result := FProxyInfo.ProxyPassword;
end;

function TIdProxyConnectionInfoPeer.GetProxyPort: Integer;
begin
  Result := FProxyInfo.ProxyPort;
end;

function TIdProxyConnectionInfoPeer.GetProxyServer: string;
begin
  Result := FProxyInfo.ProxyServer;
end;

function TIdProxyConnectionInfoPeer.GetProxyUserName: string;
begin
  Result := FProxyInfo.ProxyUsername;
end;

procedure TIdProxyConnectionInfoPeer.SetBasicAuthentication(Val: Boolean);
begin
  FProxyInfo.BasicAuthentication := Val;
end;

procedure TIdProxyConnectionInfoPeer.SetProxyPassword(pass: string);
begin
  FProxyInfo.ProxyPassword := pass;
end;

procedure TIdProxyConnectionInfoPeer.SetProxyPort(Val: Integer);
begin
  FProxyInfo.ProxyPort := Val;
end;

procedure TIdProxyConnectionInfoPeer.SetProxyServer(Val: string);
begin
  FProxyInfo.ProxyServer := Val;
end;

procedure TIdProxyConnectionInfoPeer.SetProxyUserName(user: string);
begin
  FProxyInfo.ProxyUsername := user;
end;

{ TIdTCPClientIP }

destructor TIdTCPClientIP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdTCPClientPeerIP }

constructor TIdTCPClientPeerIP.Create(AOwner: TComponent);
begin
  FIOHandler := nil;
  FTCPClient := TIdTCPClientIP.Create(AOwner);
  FTCPClient.FSetDestroyedProc := SetDestroyed;
end;

destructor TIdTCPClientPeerIP.Destroy;
begin
  FIOHandler := nil;

  if NeedToFree then
    FTCPClient.Free;
  inherited;
end;

procedure TIdTCPClientPeerIP.Connect;
begin
  FTCPClient.Connect;
end;

procedure TIdTCPClientPeerIP.Disconnect;
begin
  FTCPClient.Disconnect;
end;

function TIdTCPClientPeerIP.Connected: Boolean;
begin
  Result := FTCPClient.Connected;
end;

function TIdTCPClientPeerIP.GetManagedIOHandler: Boolean;
begin
  Result := FTCPClient.ManagedIOHandler;
end;

function TIdTCPClientPeerIP.GetBoundIP: string;
begin
  Result := FTCPClient.BoundIP;
end;

function TIdTCPClientPeerIP.GetHost: string;
begin
  Result := FTCPClient.Host;
end;

function TIdTCPClientPeerIP.GetSocket: IIPIOHandlerSocket;
begin
  if FTCPClient.Socket = nil then
    Result := nil
  else if Assigned(FSocket) and (FSocket.GetObject = FTCPClient.Socket) then
    Result := FSocket
  else
  begin
    Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandlerSocket, FTCPClient.Socket) as IIPIOHandlerSocket;
    //Result := TIdIOHandlerSocketPeer.Create(FTCPClient.Socket);
    FSocket := Result;
  end;
end;

function TIdTCPClientPeerIP.GetIOHandler: IIPIOHandler;
begin
  if FTCPClient.IOHandler = nil then
    Result := nil
  else if Assigned(FIOHandler) and (FIOHandler.GetObject = FTCPClient.IOHandler) then
    Result := FIOHandler
  else
  begin
{$IF not Defined(NEXTGEN) or not Defined(MSWINDOWS)}
    if FTCPClient.IOHandler is TIdSSLIOHandlerSocketOpenSSL then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSSLIOHandlerSocketOpenSSL, FTCPClient.IOHandler) as IIPSSLIOHandlerSocketOpenSSL
      //Result := TIdSSLIOHandlerSocketOpenSSLPeer.Create(FTCPClient.IOHandler as TIdSSLIOHandlerSocketOpenSSL)
    else 
{$ENDIF}	
	if FTCPClient.IOHandler is TIdIOHandlerSocket then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandlerSocket, FTCPClient.IOHandler) as IIPIOHandlerSocket
      //Result := TIdIOHandlerSocketPeer.Create(FTCPClient.IOHandler as TIdIOHandlerSocket)
    else
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPIOHandler, FTCPClient.IOHandler) as IIPIOHandler;
      //Result := TIdIOHandlerPeerIP.Create(FTCPClient.IOHandler);
    FIOHandler := Result;
  end;
end;

function TIdTCPClientPeerIP.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdTCPClientPeerIP.GetIPVersion: TIPVersionPeer;
begin
  if FTCPClient.IPVersion = TIdIPVersion.Id_IPv6 then
    Result := TIPVersionPeer.IP_IPv6
  else
    Result := TIPVersionPeer.IP_IPv4;
end;

function TIdTCPClientPeerIP.GetObject: TObject;
begin
  Result := FTCPClient;
end;

function TIdTCPClientPeerIP.GetPort: TIPPortPeer;
begin
  assert(Sizeof(Result) = sizeOf(FTCPClient.Port), 'Size mismatch');
  Result := FTCPClient.Port;
end;

function TIdTCPClientPeerIP.GetUseNagle: Boolean;
begin
  Result := FTCPClient.UseNagle;
end;

procedure TIdTCPClientPeerIP.SetManagedIOHandler(AManagedIOHandler: Boolean);
begin
  FTCPClient.ManagedIOHandler := AManagedIOHandler;
end;

procedure TIdTCPClientPeerIP.SetBoundIP(IP: string);
begin
  FTCPClient.BoundIP := IP;
end;

procedure TIdTCPClientPeerIP.SetHost(LHost: string);
begin
  FTCPClient.Host := LHost;
end;

procedure TIdTCPClientPeerIP.SetIOHandler(Handler: IIPIOHandler);
begin
  FTCPClient.IOHandler := Handler.GetObject as TIdIOHandler;
  FIOHandler := Handler;
end;

procedure TIdTCPClientPeerIP.SetIPVersion(const AValue: TIPVersionPeer);
begin
  if AValue = TIPVersionPeer.IP_IPv6 then
    FTCPClient.IPVersion := TIdIPVersion.Id_IPv6
  else if AValue = TIPVersionPeer.IP_IPv4 then
    FTCPClient.IPVersion := TIdIPVersion.Id_IPv4;
end;

procedure TIdTCPClientPeerIP.SetPort(LPort: TIPPortPeer);
begin
  assert(SizeOf(LPort) = SizeOf(FTCPClient.Port), 'Size mismatch');
  FTCPClient.Port := LPort;
end;

procedure TIdTCPClientPeerIP.SetUseNagle(Use: Boolean);
begin
  FTCPClient.UseNagle := Use;
end;

{ TIdBasicAuthenticationIP }

destructor TIdBasicAuthenticationIP.Destroy;
begin
  //Let Peer know that object is destroyed
  if Assigned(FSetDestroyedProc) then
    FSetDestroyedProc();
  inherited;
end;

{ TIdBasicAuthenticationPeer }

constructor TIdBasicAuthenticationPeer.Create;
begin
  FObj := TIdBasicAuthenticationIP.Create;
  FObj.FSetDestroyedProc := SetDestroyed;
end;

destructor TIdBasicAuthenticationPeer.Destroy;
begin
  if NeedToFree then
    FObj.Free;
  inherited;
end;

function TIdBasicAuthenticationPeer.GetAuthentication: string;
begin
  Result := FObj.Authentication;
end;

function TIdBasicAuthenticationPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdBasicAuthenticationPeer.GetObject: TObject;
begin
  Result := FObj;
end;

function TIdBasicAuthenticationPeer.GetPassword: string;
begin
  Result := FObj.Password;
end;

function TIdBasicAuthenticationPeer.GetUserName: string;
begin
  Result := FObj.Username;
end;

procedure TIdBasicAuthenticationPeer.SetPassword(pass: string);
begin
  FObj.Password := pass;
end;

procedure TIdBasicAuthenticationPeer.SetUsername(user: string);
begin
  FObj.Username := user;
end;

{ TIdAuthenticationPeer }

function TIdAuthenticationPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdAuthenticationPeer.GetObject: TObject;
begin
  Result := FAuth;
end;

function TIdAuthenticationPeer.GetPassword: string;
begin
  Result := FAuth.Password;
end;

function TIdAuthenticationPeer.GetUserName: string;
begin
  Result := FAuth.Username;
end;

procedure TIdAuthenticationPeer.SetPassword(pass: string);
begin
  FAuth.Password := pass;
end;

procedure TIdAuthenticationPeer.SetUsername(user: string);
begin
  FAuth.Username := user;
end;

{ TIdURIPeer }

function TIdURIPeer.GetFullURI: string;
begin
  Result := FURI.GetFullURI();
end;

function TIdURIPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdURIPeer.GetObject: TObject;
begin
  Result := FURI;
end;

function TIdURIPeer.GetProtocol: string;
begin
  Result := FURI.Protocol;
end;

function TIdURIPeer.GetURI: string;
begin
  Result := FURI.URI;
end;

procedure TIdURIPeer.SetURI(const AValue: string);
begin
  FURI.URI := AValue;
end;

function TIdURIPeer.URLEncode(const ASrc: string;
  AByteEncoding: IIPTextEncodingPeer): string;
var
  LEncoding: IIdTextEncoding;
begin
  if (AByteEncoding = nil) or Supports(AByteEncoding, IIdTextEncoding, LEncoding) then
    Result := FURI.URLEncode(ASrc, LEncoding)
  else
    raise EIPPeerException.Create(sNotIdEncodingIntf)
end;

function IPImpId: string;
begin
  Result := IPPeerCommon.IPImpId;
end;

{ TIdCookieManagerPeer }

procedure TIdCookieManagerPeer.AddServerCookie(const ACookie, AURL: string);
var
  LURI: TIdURI;
begin
  FIdHTTPPeer.CreateCookieManager;
  LURI := TIdURI.Create(AURL);
  try
    FIdHTTPPeer.FHTTP.CookieManager.AddServerCookie(ACookie, LURI);
  finally
     LURI.Free;
  end;
end;

constructor TIdCookieManagerPeer.Create(AIdHTTPPeer: TIdHTTPPeer);
begin
  FIdHTTPPeer := AIdHTTPPeer;
end;

function TIdCookieManagerPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdCookieManagerPeer.GetObject: TObject;
begin
  FIdHTTPPeer.CreateCookieManager;
  Result := FIdHTTPPeer.FHTTP.CookieManager;
end;

{ TIdURIPeerFactory }

constructor TIdURIPeerFactory.Create;
begin
  FURI := TIdURI.Create;
end;

destructor TIdURIPeerFactory.Destroy;
begin
  FURI.Free;
  inherited;
end;

{ TIdHashMessageDigest5Peer }

constructor TIdHashMessageDigest5Peer.Create;
begin
  FHash := TIdHashMessageDigest5.Create;
end;

destructor TIdHashMessageDigest5Peer.Destroy;
begin
  FHash.Free;
  inherited;
end;

function TIdHashMessageDigest5Peer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdHashMessageDigest5Peer.GetObject: TObject;
begin
  Result := FHash;
end;

function TIdHashMessageDigest5Peer.HashBytesAsHex(
  const ASrc: TIPBytesPeer): String;
begin
  Result := FHash.HashBytesAsHex(TIdBytes(ASrc))
end;


function TIdHashMessageDigest5Peer.HashStringAsHex(const ASrc: string): String;
begin
  Result := FHash.HashStringAsHex(ASrc)
end;

{ TIPMulticastClientPeer }

constructor TIPMulticastClientPeer.Create(AOwner: TComponent);
begin
  inherited Create;
  FMulticastClient := TIdIPMCastClient.Create(AOwner);
end;

destructor TIPMulticastClientPeer.Destroy;
begin
  FMulticastClient.Free;
  FSocketHandles := nil;
  inherited;
end;

procedure TIPMulticastClientPeer.DoOnIPMCastRead(Sender: TObject; const AData: TIdBytes; ABinding: TIdSocketHandle);
var
  LBinding: IIPSocketHandle;
begin
  if Assigned(FOnIPMCastRead) then
  begin
    LBinding := PeerFactory.CreatePeer(IPImpId, IIPSocketHandle, ABinding) as IIPSocketHandle;
    FOnIPMCastRead(Sender, TIPBytesPeer(AData), LBinding);
  end;
end;

function TIPMulticastClientPeer.GetActive: Boolean;
begin
  Result := FMulticastClient.Active;
end;

function TIPMulticastClientPeer.GetBinding: IIPSocketHandle;
begin
  // Left Empty. Property Binding not present in MulticastClient.
  Result := nil;
end;

function TIPMulticastClientPeer.GetBindings: IIPSocketHandles;
begin
  if FMulticastClient.Bindings = nil then
    Result := nil
  else if (FSocketHandles <> nil) and (FSocketHandles.GetObject = FMulticastClient.Bindings) then
    Result := FSocketHandles
  else
  begin
    Result := PeerFactory.CreatePeer(IPImpId, IIPSocketHandles, FMulticastClient.Bindings) as IIPSocketHandles;
    FSocketHandles := Result;
  end;
end;

function TIPMulticastClientPeer.GetDefaultPort: TIPPortPeer;
begin
  Result := FMulticastClient.DefaultPort;
end;

function TIPMulticastClientPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIPMulticastClientPeer.GetIPVersion: TIPVersionPeer;
begin
  Result := TIPVersionPeer(FMulticastClient.IPVersion);
end;

function TIPMulticastClientPeer.GetMulticastGroup: string;
begin
  Result := FMulticastClient.MulticastGroup;
end;

function TIPMulticastClientPeer.GetObject: TObject;
begin
  Result := FMulticastClient;
end;

function TIPMulticastClientPeer.GetOnMulticast: TIPMCastReadEventPeer;
begin
  Result := FOnIPMCastRead;
end;

function TIPMulticastClientPeer.GetPort: TIPPortPeer;
begin
  Result := FMulticastClient.DefaultPort;
end;

function TIPMulticastClientPeer.GetThreadedEvent: boolean;
begin
  Result := FMulticastClient.ThreadedEvent;
end;

procedure TIPMulticastClientPeer.SetActive(const AValue: Boolean);
begin
  FMulticastClient.Active := AValue;
end;

procedure TIPMulticastClientPeer.SetBindings(ABindings: IIPSocketHandles);
begin
  FMulticastClient.Bindings := ABindings.GetObject as TIdSocketHandles;
  FSocketHandles := ABindings;
end;

procedure TIPMulticastClientPeer.SetDefaultPort(const APort: TIPPortPeer);
begin
  FMulticastClient.DefaultPort := APort;
end;

procedure TIPMulticastClientPeer.SetIPVersion(const AValue: TIPVersionPeer);
begin
  FMulticastClient.IPVersion := TIdIPVersion(AValue);
end;

procedure TIPMulticastClientPeer.SetMulticastGroup(const AValue: string);
begin
  FMulticastClient.MulticastGroup := AValue;
end;

procedure TIPMulticastClientPeer.SetOnMulticast(const AEvent: TIPMCastReadEventPeer);
begin
  FOnIPMCastRead := AEvent;
  if Assigned(FOnIPMCastRead) then
    FMulticastClient.OnIPMCastRead := DoOnIPMCastRead
  else
    FMulticastClient.OnIPMCastRead := nil;
end;

procedure TIPMulticastClientPeer.SetPort(const APort: TIPPortPeer);
begin
  FMulticastClient.DefaultPort := APort;
end;

procedure TIPMulticastClientPeer.SetThreadedEvent(const AValue: boolean);
begin
  FMulticastClient.ThreadedEvent := AValue;
end;

initialization
  PeerFactory.RegisterPeer(IPImpId, IIPHTTP, TIdHTTPPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPTCPClient, TIdTCPClientPeerIP);
  PeerFactory.RegisterPeer(IPImpId, IIPBasicAuthentication, TIdBasicAuthenticationPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPURI, TIdURIPeerFactory);
  PeerFactory.RegisterPeer(IPImpId, IIPHashMessageDigest5, TIdHashMessageDigest5Peer);
  PeerFactory.RegisterPeer(IPImpId, IIPMulticastClient, TIPMulticastClientPeer);

finalization
  PeerFactory.UnregisterPeerClass(IPImpId, TIdHTTPPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdTCPClientPeerIP);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdBasicAuthenticationPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdURIPeerFactory);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdHashMessageDigest5Peer);

  PeerFactory.UnregisterPeerClass(IPImpId, TIPMulticastClientPeer);

end.
