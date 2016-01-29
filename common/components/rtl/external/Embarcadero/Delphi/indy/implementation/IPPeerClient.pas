{*******************************************************}
{                                                       }
{              Delphi Indy Implementation               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "IPPeerClient"'}    {Do not Localize}
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

function IPImpId: string;

implementation

uses
  System.Classes, System.SysUtils,
  IdIOHandlerSocket, IdIOHandler, IdHTTP, IdAuthentication, IdURI,
  IdHTTPHeaderInfo, IdSSLOpenSSL, IdTCPClient, IdStack, IdGlobal,

  IPPeerCommon, IPPeerResStrs,
  IPPeerAPI; //put last because we have some type names identical to indy ones in here

type
  TIdTCPClientIP = class(TIdTCPClient)
  private
    FSetDestroyedProc: TProc;
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
  protected
    function URLEncode(const ASrc: string; AByteEncoding: IIPTextEncodingPeer = nil): string;
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(URI: TIdURI);
  end;

  TIdAuthenticationPeer = class(TInterfacedObject, IIPAuthentication, IIPObject)
  private
    FAuth: TIdAuthentication;
  protected
    function GetUserName: string;
    procedure SetUsername(user: string);
    function GetPassword: string;
    procedure SetPassword(pass: string);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(Auth: TIdAuthentication);
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
    procedure SetAuthentication(auth: IIPAuthentication);
    function GetAccept: string;
    procedure SetAccept(Val: string);
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
    FSetDestroyedProc: TProc;
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
    function GetConnectTimeout: Integer;
    procedure SetConnectTimeout(timeout: Integer);
    function GetReadTimeout: Integer;
    procedure SetReadTimeout(timeout: Integer);
    function GetURL: IIPURI;
    function GetSocket: IIPIOHandlerSocket;
    function GetManagedIOHandler: Boolean;
    procedure SetManagedIOHandler(AManagedIOHandler: Boolean);
  public
    function GetObject: TObject;
    function GetIPImplementationID: string;
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    procedure FreeIOHandler;
  end;

  TIdBasicAuthenticationIP = class(TIdBasicAuthentication)
  private
    FSetDestroyedProc: TProc;
  public
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
  public
    constructor Create;
    destructor Destroy; override;
    function GetObject: TObject;
    function GetIPImplementationID: string;
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

function TIdHTTPPeer.GetConnectTimeout: Integer;
begin
  Result := FHTTP.ConnectTimeout;
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
    if FHTTP.IOHandler is TIdSSLIOHandlerSocketOpenSSL then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSSLIOHandlerSocketOpenSSL, FHTTP.IOHandler) as IIPSSLIOHandlerSocketOpenSSL
      //Result := TIdSSLIOHandlerSocketOpenSSLPeer.Create(FHTTP.IOHandler as TIdSSLIOHandlerSocketOpenSSL)
    else if FHTTP.IOHandler is TIdIOHandlerSocket then
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

procedure TIdHTTPPeer.SetConnectTimeout(timeout: Integer);
begin
  FHTTP.ConnectTimeout := timeout;
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
begin
  if FHTTP.URL = nil then
    Result := nil
  else if Assigned(FURL) and (FURL.GetObject = FHTTP.URL) then
    Result := FURL
  else
  begin
    Result := TIdURIPeer.Create(FHTTP.URL);
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

function TIdHTTPRequestPeer.GetAuthentication: IIPAuthentication;
begin
  if FRequest.Authentication = nil then
    Result := nil
  else if Assigned(FAuthentication) and (FAuthentication.GetObject = FRequest.Authentication) then
    Result := FAuthentication
  else
  begin
    Result := TIdAuthenticationPeer.Create(FRequest.Authentication);
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

procedure TIdHTTPRequestPeer.SetAccept(Val: string);
begin
  FRequest.Accept := Val;
end;

procedure TIdHTTPRequestPeer.SetAuthentication(auth: IIPAuthentication);
begin
  FRequest.Authentication := auth.GetObject as TIdAuthentication;
  FAuthentication := auth;
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
    if FTCPClient.IOHandler is TIdSSLIOHandlerSocketOpenSSL then
      Result := PeerFactory.CreatePeer(GetIPImplementationID, IIPSSLIOHandlerSocketOpenSSL, FTCPClient.IOHandler) as IIPSSLIOHandlerSocketOpenSSL
      //Result := TIdSSLIOHandlerSocketOpenSSLPeer.Create(FTCPClient.IOHandler as TIdSSLIOHandlerSocketOpenSSL)
    else if FTCPClient.IOHandler is TIdIOHandlerSocket then
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

constructor TIdAuthenticationPeer.Create(Auth: TIdAuthentication);
begin
  FAuth := Auth;
end;

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

constructor TIdURIPeer.Create(URI: TIdURI);
begin
  FURI := URI;
end;

function TIdURIPeer.GetIPImplementationID: string;
begin
  Result := IPImpId;
end;

function TIdURIPeer.GetObject: TObject;
begin
  Result := FURI;
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

initialization
  PeerFactory.RegisterPeer(IPImpId, IIPHTTP, TIdHTTPPeer);
  PeerFactory.RegisterPeer(IPImpId, IIPTCPClient, TIdTCPClientPeerIP);
  PeerFactory.RegisterPeer(IPImpId, IIPBasicAuthentication, TIdBasicAuthenticationPeer);

finalization
  PeerFactory.UnregisterPeerClass(IPImpId, TIdHTTPPeer);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdTCPClientPeerIP);
  PeerFactory.UnregisterPeerClass(IPImpId, TIdBasicAuthenticationPeer);

end.
