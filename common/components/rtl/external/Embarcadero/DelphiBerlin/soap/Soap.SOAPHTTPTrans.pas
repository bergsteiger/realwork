{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{         SOAP Transports                               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Soap.SOAPHTTPTrans;

{$IF CompilerVersion >= 24.0}
{$LEGACYIFEND ON}
{$IFEND}

{$IFDEF POSIX}
  {$DEFINE USE_INDY}
{$ENDIF}
{$IFDEF MSWINDOWS}
 {$IFDEF NEXTGEN}
  {$DEFINE USE_INDY}
 {$ENDIF} 
{$ENDIF}

{$IFNDEF VER150}
{$INCLUDE 'CompVer.inc'}
{$ENDIF}

{$IFDEF HIGHLANDER_UP}
  {$DEFINE INDY_CUSTOM_IOHANDLER}
{$ENDIF}

{$IFDEF TIBURON_UP}
  // Default to v10 of Indy for Tiburon and up unless INDY_9 is defined
  {$IFNDEF INDY_9}
    {$DEFINE INDY_10}
  {$ENDIF}
{$ENDIF}

{$IFDEF WEAVER_UP}
  {$IFDEF MSWINDOWS}
    {$DEFINE CLIENT_CERTIFICATE_SUPPORT}
  {$ENDIF}
{$ENDIF}


// C++ must explicitly link to crypt32.lib as the crypto API entry-points
// are not currently in import32.lib
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
 {$IFDEF WIN32}
  (*$HPPEMIT '#pragma link "crypt32.lib"' *)
 {$ENDIF}
{$ENDIF}

{$IFDEF USE_INDY}
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
 {$ENDIF}
{$ENDIF}

interface

uses
{$IFDEF USE_INDY}
  IdAuthentication, IdHTTP, IdIOHandler,
{$ELSE}
  Winapi.WinSock, Winapi.WinInet,
{$ENDIF}
  System.Classes, System.SysUtils, System.Types,
  Soap.IntfInfo, Soap.SOAPAttachIntf, Soap.WebNode, Soap.WSDLIntf, Soap.WSDLNode;

{$IFNDEF USE_INDY}
 {$IFDEF WIN32}
  (*$HPPEMIT '#pragma link "wininet.lib"' *)
 {$ENDIF}
{$ENDIF}

type

  ESOAPHTTPException = class(Exception)
  private
    FStatusCode: Integer;
  public
{$IF CompilerVersion <= 15.0}
    constructor Create(const Msg: string; SCode: Integer = 0);
{$ELSE}
    constructor Create(const Msg: string; SCode: Integer = 0; Dummy: Integer = 0);
{$IFEND}
    constructor CreateFmt(const Msg: string; const Args: array of const; SCode: Integer = 0; Dummy: Integer = 0);

    property StatusCode: Integer read FStatusCode write FStatusCode;
  end;

  SOAPInvokeOptions = (soNoValueForEmptySOAPAction,   { Send "" or absolutely no value for empty SOAPAction }
                       soIgnoreInvalidCerts,          { Handle Invalid Server Cert and ask HTTP runtime to ignore }
                       soNoSOAPActionHeader,          { Don't send SOAPAction - use very very carefully!! }
                       soAutoCheckAccessPointViaUDDI, { if we get a status code 404/405/410 - contact UDDI }
                       soPickFirstClientCertificate   { WinInet Only }
                       );
  TSOAPInvokeOptions= set of SOAPInvokeOptions;

  THTTPReqResp = class;

  { Provides access to HTTPReqResp component }
  IHTTPReqResp = interface
  ['{5FA6A197-32DE-4225-BC85-216CB80D1561}']
    function GetHTTPReqResp: THTTPReqResp;
  end;

  { Data is TIdHttp when using Indy and the WinInet Handle when using WinInet}
  TBeforePostEvent = procedure(const HTTPReqResp: THTTPReqResp; Data: Pointer) of object;
  TPostingDataEvent = procedure(Sent: Integer; Total: Integer) of object;
  TReceivingDataEvent = procedure(Read: Integer; Total: Integer) of object;
  TWinInetErrorEvent = function(LastError: DWord; Request: Pointer): DWord of object;

{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
  TClientCert = class(TComponent)
  private
    FCertName: string;
    FIssuer: string;
    FSerialNum: string;
  published
    property CertName: string read FCertName write FCertName;
    property Issuer: string read FIssuer write FIssuer;
    property SerialNum: string read FSerialNum write FSerialNum;
  end;
  
  IClientCertInfo = interface
  ['{4EA73902-DD19-4952-A94D-CCCE7B995F5C}']
    function GetCertSerialNumber: string;
    procedure SetCertSerialNumber(const ASerialNum: string);
    function GetCertName: string;
    procedure SetCertName(const AName: string);
    function GetCertIssuer: string;
    procedure SetCertIssuer(const AIssuer: string);
    function GetCertStore: Pointer;
    procedure SetCertStore(APointer: Pointer);
    function GetCertContext: Pointer;
    procedure SetCertContext(AContext: Pointer);
  end; 
{$ENDIF}

  THTTPReqResp = class(TComponent, IInterface, IWebNode, IHTTPReqResp
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
                      , IClientCertInfo
{$ENDIF}
                      )
  private
    FUserSetURL: Boolean;
{$IFNDEF AUTOREFCOUNT}
    FRefCount: Integer;
{$ENDIF !AUTOREFCOUNT}
    FOwnerIsComponent: Boolean;
    FConnected: Boolean;
    FURL: string;
    FAgent: string;
    FBindingType: TWebServiceBindingType;
    FMimeBoundary: string;
    FWebNodeOptions: WebNodeOptions;
    FContentType: string;
    FUserName: string;
    FPassword: string;
    FURLHost: string;
    FURLSite: string;
    FURLPort: Integer;
    FURLScheme: Integer;
    FProxy: string;
    FProxyByPass: string;
{$IFNDEF USE_INDY}
    FInetRoot: HINTERNET;
    FInetConnect: HINTERNET;
{$ENDIF}
    FConnectTimeout: Integer;
    FSendTimeout: Integer;
    FReceiveTimeout: Integer;
    FWSDLView: TWSDLView;
    FSoapAction: string;
    FUseUTF8InHeader: Boolean;
    FInvokeOptions: TSOAPInvokeOptions;
    FUDDIBindingKey: string;
    FUDDIOperator: String;
    FOnBeforePost: TBeforePostEvent;
    FOnPostingData: TPostingDataEvent;
    FOnReceivingData: TReceivingDataEvent;
    FMaxSinglePostSize: Integer;
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
    FCertStore: Pointer;
    FCertContext: Pointer;
    FClientCertificate: TClientCert;
{$ENDIF}
{$IFNDEF USE_INDY}
    FOnWinInetError: TWinInetErrorEvent;
{$ENDIF}
{$IFDEF USE_INDY}
  {$IFDEF INDY_CUSTOM_IOHANDLER}
    FIOHandler: TIdIOHandler;
  {$ENDIF}

    procedure IndyProxyAuthorization(Sender: TObject;
                                     Authentication: TIdAuthentication;
                                     var Handled: Boolean);
{$ENDIF}

    procedure SetURL(const Value: string);
    function  GetSOAPAction: string;
    procedure SetSOAPAction(const SOAPAction: string);
    procedure SetWSDLView(const WSDLVIew: TWSDLView);
    function  GetContentType: string;
    function  GetSOAPActionHeader: string;
    procedure InitURL(const Value: string);
    procedure SetUsername(const NameValue: string);
    procedure SetPassword(const PasswordValue: string);
    procedure SetProxy(const ProxyValue: string);
{$IFDEF DEXTER_UP}
    function  GetAgentIsStored:Boolean;
{$ENDIF}
  protected
{$IFNDEF AUTOREFCOUNT}
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
{$ENDIF !AUTOREFCOUNT}
    function GetMimeBoundary: string;
    procedure SetMimeBoundary(const Value: string);
    function  GetWebNodeOptions: WebNodeOptions;
    procedure SetWebNodeOptions(Value: WebNodeOptions);
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
    function GetCertSerialNumber: string;
    procedure SetCertSerialNumber(const ASerialNum: string);
    function GetCertName: string;
    procedure SetCertName(const AName: string);
    function GetCertIssuer: string;
    procedure SetCertIssuer(const AIssuer: string);
    function GetCertStore: Pointer;
    procedure SetCertStore(APointer: Pointer);
    function GetCertContext: Pointer;
    procedure SetCertContext(AContext: Pointer);
{$ENDIF}
  public
    constructor Create(Owner: TComponent); override;
{$IFNDEF AUTOREFCOUNT}
    class function NewInstance: TObject; override;
{$ENDIF !AUTOREFCOUNT}
    procedure AfterConstruction; override;
    destructor Destroy; override;
    function  GetHTTPReqResp: THTTPReqResp;
    procedure CheckContentType;
{$IFNDEF USE_INDY}
    procedure Check(Error: Boolean; ShowSOAPAction: Boolean = False);
    procedure RaiseCheck(ErrCode: DWORD; ShowSOAPAction: Boolean = False);
    procedure Connect(Value: Boolean);
    function  Send(const ASrc: TStream): HINTERNET; virtual;
    function  SendGet: HINTERNET; virtual;
    procedure Receive(Context: HINTERNET; Resp: TStream; IsGet: Boolean = False); virtual;
    function  HandleWinInetError(LastError: DWord; Request: HINTERNET; RaiseError: Boolean = False): DWord;
{$ELSE}
    procedure SetupIndy(IndyHttp: TIDHttp; Request: TStream);
{$ENDIF}
    procedure Get(Resp: TStream); virtual;
    {IWebNode}
    procedure BeforeExecute(const IntfMD: TIntfMetaData;
                            const MethMD: TIntfMethEntry;
                            MethodIndex: Integer;
                            AttachHandler: IMimeAttachmentHandler);
    procedure Execute(const DataMsg: String; Resp: TStream); overload; virtual;
    procedure Execute(const Request: TStream; Response: TStream); overload; virtual;
    function  Execute(const Request: TStream): TStream; overload; virtual;
    property  URL: string read FURL write SetURL;
    property  SoapAction: string read GetSOAPAction write SetSOAPAction;
    { Can these be exposed when using Indy too?? }
    property  ConnectTimeout: Integer read FConnectTimeout write FConnectTimeout;
    property  SendTimeout: Integer read FSendTimeout write FSendTimeout;
    property  ReceiveTimeout: Integer read FReceiveTimeout write FReceiveTimeout;
    property  MaxSinglePostSize: Integer read FMaxSinglePostSize write FMaxSinglePostSize;

{$IFDEF USE_INDY}
  {$IFDEF INDY_CUSTOM_IOHANDLER}
    property IOHandler: TIdIOHandler read FIOHandler write FIOHandler;
  {$ENDIF}
{$ENDIF}

  published
    property  WSDLView: TWSDLView read FWSDLView write SetWSDLView;
{$IFDEF DEXTER_UP}
    property  Agent: string read FAgent write FAgent stored GetAgentIsStored;
{$ELSE}
    property  Agent: string read FAgent write FAgent;
{$ENDIF}
    property  UserName: string read FUserName write SetUserName;
    property  Password: string read FPassword write SetPassword;
    property  Proxy: string read FProxy write SetProxy;
    property  ProxyByPass: string read FProxyByPass write FProxyByPass;
{$IFDEF DEXTER_UP}
    property  UseUTF8InHeader: Boolean read FUseUTF8InHeader write FUseUTF8InHeader default False;
{$ELSE}
    property  UseUTF8InHeader: Boolean read FUseUTF8InHeader write FUseUTF8InHeader;
{$ENDIF}
    property  InvokeOptions: TSOAPInvokeOptions read FInvokeOptions write FInvokeOptions;
    property  WebNodeOptions: WebNodeOptions read FWebNodeOptions write FWebNodeOptions;
    property  UDDIBindingKey: string read FUDDIBindingKey write FUDDIBindingKey;
    property  UDDIOperator: string read FUDDIOperator write FUDDIOperator;
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
    property  ClientCertificate: TClientCert read FClientCertificate;
{$ENDIF}

    { Events }
    property  OnBeforePost: TBeforePostEvent read FOnBeforePost write FOnBeforePost;
    property  OnPostingData: TPostingDataEvent read FOnPostingData write FOnPostingData;
    property  OnReceivingData: TReceivingDataEvent read FOnReceivingData write FOnReceivingData;
{$IFNDEF USE_INDY}
    property  OnWinInetError: TWinInetErrorEvent read FOnWinInetError write FOnWinInetError;
{$ENDIF}
  end;


implementation


uses 
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF}
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
  Soap.Win.CertHelper,
{$ENDIF}
{$IFNDEF USE_INDY}
  Xml.xmldom,
{$ELSE}
  {$IFDEF INDY_10}
     IdAssignedNumbers,
  {$ENDIF}
     IdIntercept, IdException, IdURI, IdGlobal, IdHeaderList,
     IdHTTPHeaderInfo, IdAuthenticationDigest, IdSSLOpenSSL,
{$ENDIF}
  {$IFNDEF AUTOREFCOUNT} System.SyncObjs, {$ENDIF !AUTOREFCOUNT}
  Soap.InvokeRegistry, Soap.SOAPAttach, Soap.SOAPConst, Soap.UDDIHelper, Soap.WSDLItems;



const
  SOAP_AGENT = 'CodeGear SOAP 1.3'; { Do not localize }

{$IFDEF USE_INDY}
procedure ParseURI(AURI: string; var VProtocol, VHost, VPath, VDocument,
                       VPort, VBookmark : string);
var
  URI: TIdURI;
begin
  URI := TIdURI.Create(AURI);
  try
    VProtocol := URI.Protocol;
    VHost := URI.Host;
    VPath := URI.Path;
    VDocument := URI.Document;
    VPort := URI.Port;
    VBookmark := URI.Bookmark;
  finally
    URI.Free;
  end;
end;
{$ENDIF}

{$IF CompilerVersion <= 15.0}
constructor ESOAPHTTPException.Create(const Msg: string; SCode: Integer = 0);
{$ELSE}
constructor ESOAPHTTPException.Create(const Msg: string; SCode: Integer = 0; Dummy: Integer = 0);
{$IFEND}
begin
  inherited Create(Msg);
  FStatusCode := SCode;
end;

constructor ESOAPHTTPException.CreateFmt(const Msg: string; const Args: array of const; SCode: Integer; Dummy: Integer);
begin
  inherited CreateFmt(Msg, Args);
  FStatusCode := SCode;
end;

constructor THTTPReqResp.Create(Owner: TComponent);
begin
  inherited;
{$IFNDEF USE_INDY}
  FInetRoot := nil;
  FInetConnect := nil;
{$ENDIF}
  FUserSetURL := False;
  FInvokeOptions := [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI];
  FAgent := SOAP_AGENT;
  FMaxSinglePostSize := $8000;
  { Default this to true to allow Clients to send International Characters without having to
    explicit set this. 
    NOTE: This is a change from previous versions but it seems better based on the number of
          reports whose ultimate solution is related to not having enabled this property 
          The property still specifies the default as False as we cannot break interfaces for
          this release. We'll reconsider the 'default' in a subsequent release. }
  FUseUTF8InHeader := True;
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
  FClientCertificate := TClientCert.Create(Self);
  FClientCertificate.Name := 'ClientCert1'; {Do not localize }
  FClientCertificate.SetSubComponent(True);
{$ENDIF}
end;

destructor THTTPReqResp.Destroy;
begin
{$IFNDEF USE_INDY}
  if Assigned(FInetConnect) then
    InternetCloseHandle(FInetConnect);
  FInetConnect := nil;
  if Assigned(FInetRoot) then
    InternetCloseHandle(FInetRoot);
  FInetRoot := nil;
{$ENDIF}
  FConnected := False;
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
  FreeAndNil(FClientCertificate);
{$ENDIF}
  inherited;
end;

{$IFNDEF AUTOREFCOUNT}
class function THTTPReqResp.NewInstance: TObject;
begin
  Result := inherited NewInstance;
  THTTPReqResp(Result).FRefCount := 1;
end;
{$ENDIF !AUTOREFCOUNT}

{ $IFNDEF AUTOREFCOUNT}
procedure THTTPReqResp.AfterConstruction;
begin
  inherited;
  FOwnerIsComponent := Assigned(Owner) and (Owner is TComponent);
{$IFNDEF AUTOREFCOUNT}
  TInterlocked.Decrement(FRefCount);
{$ENDIF !AUTOREFCOUNT}
end;
{ $ENDIF !AUTOREFCOUNT}

{ IInterface }

{$IFNDEF AUTOREFCOUNT}
function THTTPReqResp._AddRef: Integer;
begin
  Result := TInterlocked.Increment(FRefCount)
end;

function THTTPReqResp._Release: Integer;
begin
  Result := TInterlocked.Decrement(FRefCount);
  { If we are not being used as a TComponent, then use refcount to manage our
    lifetime as with TInterfacedObject. }
  if (Result = 0) and not FOwnerIsComponent then
    Destroy;
end;
{$ENDIF !AUTOREFCOUNT}

{$IFNDEF USE_INDY}

procedure THTTPReqResp.Check(Error: Boolean; ShowSOAPAction: Boolean);
var
  ErrCode: Integer;
begin
  if Error then
  begin
    ErrCode := GetLastError;
    if (ErrCode <> 0) then
    begin
      RaiseCheck(ErrCode, ShowSOAPAction);
    end;
  end;
end;

procedure THTTPReqResp.RaiseCheck(ErrCode: DWORD; ShowSOAPAction: Boolean);
var
  S: string;
begin
  if (ErrCode <> 0) then
  begin
    SetLength(S, 256);
    FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM or FORMAT_MESSAGE_FROM_HMODULE, Pointer(GetModuleHandle('wininet.dll')),
      ErrCode, 0, PChar(S), Length(S), nil);
    SetLength(S, StrLen(PChar(S)));
    while (Length(S) > 0) and CharInSet(S[High(S)], [#10, #13]) do
      SetLength(S, Length(S) - 1);
    raise ESOAPHTTPException.CreateFmt('%s - URL:%s - SOAPAction:%s', [S, FURL, SoapAction], ErrCode);      { Do not localize }
  end;
end;

{$ELSE}
procedure THTTPReqResp.IndyProxyAuthorization(Sender: TObject;
                                              Authentication: TIdAuthentication;
                                              var Handled: Boolean);
begin
  Authentication.UserName := FUserName;
  Authentication.Password := FPassword;
  Handled := True;
end;
{$ENDIF}

function THTTPReqResp.GetHTTPReqResp: THTTPReqResp;
begin
  Result := Self;
end;

function THTTPReqResp.GetSOAPAction: string;
begin
  if (FSoapAction = '') and not (soNoValueForEmptySOAPAction in FInvokeOptions) then
    Result := '""'
  else
    Result := FSoapAction;
end;

procedure THTTPReqResp.SetSOAPAction(const SOAPAction: string);
begin
  FSoapAction := SOAPAction;
end;

procedure THTTPReqResp.SetWSDLView(const WSDLVIew: TWSDLView);
begin
  FWSDLView := WSDLView;
end;

procedure THTTPReqResp.SetURL(const Value: string);
begin
  if Value <> '' then
    FUserSetURL := True
  else
    FUserSetURL := False;
  InitURL(Value);
{$IFNDEF USE_INDY}
  { Here we always disconnect if a new URL comes in...
    this ensures that we don't keep a connection to
    a wrong host }
  Connect(False);
{$ENDIF}  
end;

procedure THTTPReqResp.InitURL(const Value: string);
{$IFNDEF USE_INDY}
var
  URLComp: TURLComponents;
  P: PChar;
{$ELSE}
const
  http = 'http://';
var
  IndyHTTP: TIDHttp;
  URI, Protocol, Host, path, Document, Port, Bookmark: string;
{$ENDIF}
begin
  if Value <> '' then
  begin
{$IFNDEF USE_INDY}
    FillChar(URLComp, SizeOf(URLComp), 0);
    URLComp.dwStructSize := SizeOf(URLComp);
    URLComp.dwSchemeLength := 1;
    URLComp.dwHostNameLength := 1;
    URLComp.dwURLPathLength := 1;
    P := PChar(Value);
    InternetCrackUrl(P, 0, 0, URLComp);
    if not (URLComp.nScheme in [INTERNET_SCHEME_HTTP, INTERNET_SCHEME_HTTPS]) then
      raise ESOAPHTTPException.CreateFmt(SInvalidURL, [Value]);
    FURLScheme := URLComp.nScheme;
    FURLPort := URLComp.nPort;
    FURLHost := Copy(Value, URLComp.lpszHostName - P + 1, URLComp.dwHostNameLength);
    FURLSite := Copy(Value, URLComp.lpszUrlPath - P + 1, URLComp.dwUrlPathLength);
{$ELSE}
    IndyHTTP := TIDHttp.Create(Nil);
    try
      URI := Value;
      ParseURI(URI, Protocol, Host, Path, Document, Port, Bookmark);
      if Port <> '' then
        FURLPort := StrToInt(Port)
      else
{$IFDEF INDY_10}
        FURLPort := IdPORT_HTTP;
{$ELSE}
        FURLPort := IndyHTTP.Port;
{$ENDIF}        
      if Host <> '' then
        FURLHost := Host
      else
        FURLHost := Copy(Value, Length(http)+1,
              Pos(':' + IntToStr(FURLPort), Value) - (Length(http)+1));
    finally
      IndyHTTP.Free;
    end;
{$ENDIF}
  end else
  begin
    FURLPort := 0;
    FURLHost := '';
    FURLSite := '';
    FURLScheme := 0;
  end;
  FURL := Value;
end;

procedure THTTPReqResp.SetMimeBoundary(const Value: string);
begin
  FMimeBoundary := Value;
end;

function THTTPReqResp.GetMimeBoundary: string;
begin
  Result := FMimeBoundary;
end;

function THTTPReqResp.GetWebNodeOptions: WebNodeOptions;
begin
  Result := FWebNodeOptions;
end;

procedure THTTPReqResp.SetWebNodeOptions(Value: WebNodeOptions);
begin
  FWebNodeOptions := Value;
end;

{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
function THTTPReqResp.GetCertSerialNumber: string;
begin
  Result := FClientCertificate.SerialNum;
end;

procedure THTTPReqResp.SetCertSerialNumber(const ASerialNum: string);
begin
  FClientCertificate.SerialNum := ASerialNum;
end;

function THTTPReqResp.GetCertName: string;
begin
  Result := FClientCertificate.CertName;
end;

procedure THTTPReqResp.SetCertName(const AName: string);
begin
  FClientCertificate.CertName := AName;
end;

function THTTPReqResp.GetCertIssuer: string;
begin
  Result := FClientCertificate.Issuer;
end;

procedure THTTPReqResp.SetCertIssuer(const AIssuer: string);
begin
  FClientCertificate.Issuer := AIssuer;
end;

function THTTPReqResp.GetCertStore: Pointer;
begin
  Result := FCertStore;
end;

procedure THTTPReqResp.SetCertStore(APointer: Pointer);
begin
  if FCertStore <> nil then
    CertCloseStore(FCertStore, CERT_CLOSE_STORE_FORCE_FLAG);
  FCertStore := APointer;
end;

function THTTPReqResp.GetCertContext: Pointer;
begin
  Result := FCertContext;
end;

procedure THTTPReqResp.SetCertContext(AContext: Pointer);
begin
  if FCertContext <> nil then
    CertFreeCertificateContext(FCertContext);
  FCertContext := AContext;
end;
{$ENDIF}

procedure THTTPReqResp.SetUsername(const NameValue: string);
begin
  FUserName := NameValue;
  if Assigned(WSDLView) then
    WSDLView.UserName := NameValue;
end;

procedure THTTPReqResp.SetPassword(const PasswordValue: string);
begin
  FPassword := PasswordValue;
  if Assigned(WSDLView) then
    WSDLView.Password := PasswordValue;
end;

procedure THTTPReqResp.SetProxy(const ProxyValue: string);
begin
  FProxy := ProxyValue;
  if Assigned(WSDLView) then
    WSDLView.Proxy := ProxyValue;
end;

function THTTPReqResp.GetSOAPActionHeader: string;
begin
  if (SoapAction = '') then
    Result := SHTTPSoapAction + ':'
  else if (SoapAction = '""') then
    Result := SHTTPSoapAction + ': ""'
  else
    Result := SHTTPSoapAction + ': ' + '"' + SoapAction + '"';
end;

function THTTPReqResp.GetContentType: string;
begin
  Result := '';
  if not (wnoSOAP12 in GetWebNodeOptions) then
  begin
    if UseUTF8InHeader then
      Result := ContentTypeUTF8
    else
      Result := ContentTypeNoUTF8;
  end
  else
  begin
    if UseUTF8InHeader then
      Result := Format(ContentTypeWithActionNoLabelFmt, [ContentType12UTF8, GetSOAPAction])
    else
      Result := Format(ContentTypeWithActionNoLabelFmt, [ContentType12NoUTF8, GetSOAPAction]);
  end;
end;

{$IFNDEF USE_INDY}

procedure THTTPReqResp.Connect(Value: Boolean);
var
  AccessType: Integer;
begin
  if Value then
  begin
    { Yes, but what if we're connected to a different Host/Port?? }
    { So take advantage of a cached handle, we'll assume that
      Connect(False) will be called explicitly when we're switching
      Host. To that end, SetURL always disconnects }
    if (FConnected) then
      Exit;

    { Proxy?? }
    if Length(FProxy) > 0 then
      AccessType := INTERNET_OPEN_TYPE_PROXY
    else
      AccessType := INTERNET_OPEN_TYPE_PRECONFIG;

    { Also, could switch to new API introduced in IE4/Preview2}
    if InternetAttemptConnect(0) <> ERROR_SUCCESS then
      System.SysUtils.Abort;

    FInetRoot := InternetOpen(PChar(FAgent), AccessType, PChar(FProxy), PChar(FProxyByPass), 0);
    Check(not Assigned(FInetRoot));
    try
      FInetConnect := InternetConnect(FInetRoot, PChar(FURLHost), FURLPort, PChar(FUserName),
        PChar(FPassword), INTERNET_SERVICE_HTTP, 0, NativeUInt(Self));
      Check(not Assigned(FInetConnect));
      FConnected := True;
    except
      InternetCloseHandle(FInetRoot);
      FInetRoot := nil;
      raise;
    end;
  end
  else
  begin
    if Assigned(FInetConnect) then
      InternetCloseHandle(FInetConnect);
    FInetConnect := nil;
    if Assigned(FInetRoot) then
      InternetCloseHandle(FInetRoot);
    FInetRoot := nil;
    FConnected := False;
  end;
end;

procedure THTTPReqResp.Receive(Context: HINTERNET; Resp: TStream; IsGet: Boolean);
const
  MaxStatusTest = 4096;
  MaxContentType= 1024;
var
  Size, Downloaded, Status, Len, Index: DWord;
  S: string;
{$IFDEF UNICODE}
  Bytes: TBytes;
{$ENDIF}
begin
  Len := SizeOf(Status);
  Index := 0;

  { Handle error }
  if HttpQueryInfo(Context, HTTP_QUERY_STATUS_CODE or HTTP_QUERY_FLAG_NUMBER,
    @Status, Len, Index) and (Status >= 300) and (Status <> 500) then
  begin
    Index := 0;
    Size := MaxStatusTest;
    SetLength(S, Size);
    if HttpQueryInfo(Context, HTTP_QUERY_STATUS_TEXT, @S[Low(string)], Size, Index) then
    begin
      SetLength(S, Size div sizeof(Char));
      raise ESOAPHTTPException.CreateFmt('%s (%d) - ''%s''', [S, Status, FURL], Status);
    end;
  end;

  { Ask for Content-Type }
  Size := MaxContentType;
  SetLength(FContentType, MaxContentType);
  if (HttpQueryInfo(Context, HTTP_QUERY_CONTENT_TYPE, @FContentType[Low(string)], Size, Index)) then
    SetLength(FContentType, Size div sizeof(Char))
  else
    // Raise GetLastError!
    Check(True);

  { Extract Mime-Boundary }
  FMimeBoundary := GetMimeBoundaryFromType(FContentType);

  { Read data }
  Len := 0;
  repeat
    Check(not InternetQueryDataAvailable(Context, Size, 0, 0));
    if Size > 0 then
    begin
{$IFDEF UNICODE}
      SetLength(bytes, Size);
      Check(not InternetReadFile(Context, Bytes, Size, Downloaded));
      Resp.Write(bytes[0], Size);
{$ELSE}
      SetLength(S, Size);
      Check(not InternetReadFile(Context, @S[Low(string)], Size, Downloaded));
      Resp.Write(S[Low(string)], Size);
{$ENDIF}

      { Receiving Data event }
      if Assigned(FOnReceivingData) then
        FOnReceivingData(Size, Downloaded)
    end;
  until Size = 0;

  { Check that we have a valid content type}
  { Ideally, we would always check but there are several WebServers out there
    that send files with .wsdl extension with the content type 'text/plain' or
    'text/html' ?? }
  if not IsGet then
    CheckContentType;
end;


function THTTPReqResp.HandleWinInetError(LastError: DWord; 
                                         Request: HINTERNET;
                                         RaiseError: Boolean): DWord;

  function CallInternetErrorDlg: DWord;
  var
    P: Pointer;
  begin
    Result := InternetErrorDlg(GetDesktopWindow(), Request, LastError,
                               FLAGS_ERROR_UI_FILTER_FOR_ERRORS or
                               FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS or
                               FLAGS_ERROR_UI_FLAGS_GENERATE_DATA, P);

    { After selecting client certificate send request again,
      Note: InternetErrorDlg always returns ERROR_SUCCESS when called with
            ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED }
    if LastError = ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED then
      Result := ERROR_INTERNET_FORCE_RETRY;
  end;

const
  { Missing from our WinInet currently }
  INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84;

var
  Flags, FlagsLen, DWCert, DWCertLen: DWord;
  ClientCertInfo: IClientCertInfo;
  CertSerialNum: string;
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
  hStore: HCERTSTORE;
  CertContext: PCERT_CONTEXT;
{$ENDIF}
begin
  { Dispatch to custom handler, if there's one }
  if Assigned(FOnWinInetError) then
    Result := FOnWinInetError(LastError, Request)
  else
  begin
    Result := ERROR_INTERNET_FORCE_RETRY;
    { Handle INVALID_CA discreetly }
    if (LastError = ERROR_INTERNET_INVALID_CA) and (soIgnoreInvalidCerts in InvokeOptions) then
    begin
      FlagsLen := SizeOf(Flags);
      InternetQueryOption(Request, INTERNET_OPTION_SECURITY_FLAGS, Pointer(@Flags), FlagsLen);
      Flags := Flags or SECURITY_FLAG_IGNORE_UNKNOWN_CA;
      InternetSetOption(Request, INTERNET_OPTION_SECURITY_FLAGS, Pointer(@Flags), FlagsLen);
    end
    else if (LastError = ERROR_INTERNET_SEC_CERT_REV_FAILED) and (soIgnoreInvalidCerts in InvokeOptions) then
    begin
      FlagsLen := SizeOf(Flags);
      InternetQueryOption(Request, INTERNET_OPTION_SECURITY_FLAGS, Pointer(@Flags), FlagsLen);
      Flags := Flags or SECURITY_FLAG_IGNORE_REVOCATION;
      InternetSetOption(Request, INTERNET_OPTION_SECURITY_FLAGS, Pointer(@Flags), FlagsLen);
    end
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
    else if (LastError = ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED) and
             Supports(Self, IClientCertInfo, ClientCertInfo) and
             (ClientCertInfo.GetCertSerialNumber <> '') then
    begin
      CertSerialNum := ClientCertInfo.GetCertSerialNumber();
      hStore := ClientCertInfo.GetCertStore();
      if hStore = nil then
      begin
        hStore := CertOpenSystemStore(0, PChar('MY'));
        ClientCertInfo.SetCertStore(hStore);
      end;
      CertContext := FindCertWithSerialNumber(hStore, CertSerialNum);
      if CertContext <> nil then
      begin
        ClientCertInfo.SetCertContext(CertContext);
        InternetSetOption(Request, INTERNET_OPTION_CLIENT_CERT_CONTEXT,
                          CertContext, SizeOf(CERT_CONTEXT));
      end
      else
      begin
        if RaiseError then
          RaiseCheck(LastError);   
        Result := CallInternetErrorDlg;
      end;
    end
{$ENDIF}
    else if (LastError = ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED) and (soPickFirstClientCertificate in InvokeOptions) then
    begin
      { This instructs WinInet to pick the first (a random?) client cerficate }
      DWCertLen := SizeOf(DWCert);
      DWCert := 0;
      InternetSetOption(Request, INTERNET_OPTION_SECURITY_SELECT_CLIENT_CERT,
                        Pointer(@DWCert), DWCertLen);
    end
    else
    begin
      if RaiseError then
        RaiseCheck(LastError);   
      Result := CallInternetErrorDlg;
    end;
  end;
end;


function THTTPReqResp.Send(const ASrc: TStream): HINTERNET;
const
  ContentTypeFormat: array[Boolean] of string = (ContentTypeTemplate, ContentTypeWithActionFmt);
var
  Request: HINTERNET;
  RetVal, Flags, BytesWritten: DWord;
  ActionHeader: string;
  ContentHeader: string;
  BuffSize, Len: Integer;
  INBuffer: INTERNET_BUFFERS;
  Buffer: TMemoryStream;
{$IFDEF UNICODE}
  DatStr: TBytesStream;
{$ELSE}
  DatStr: TStringStream;
{$ENDIF}
  UseSendRequestEx: Boolean;
  WinInetResult: Boolean;
begin
  { Connect }
  Connect(True);

  Flags := INTERNET_FLAG_KEEP_CONNECTION or INTERNET_FLAG_NO_CACHE_WRITE;
  if FURLScheme = INTERNET_SCHEME_HTTPS then
  begin
    Flags := Flags or INTERNET_FLAG_SECURE;
    if (soIgnoreInvalidCerts in InvokeOptions) then
      Flags := Flags or (INTERNET_FLAG_IGNORE_CERT_CN_INVALID or
                         INTERNET_FLAG_IGNORE_CERT_DATE_INVALID);
  end;

  Request := nil;
  try
    Request := HttpOpenRequest(FInetConnect, 'POST', PChar(FURLSite), nil,
                               nil, nil, Flags, 0{Integer(Self)});
    Check(not Assigned(Request));

    { Timeouts }
    if FConnectTimeout > 0 then
      Check(not InternetSetOption(Request, INTERNET_OPTION_CONNECT_TIMEOUT, Pointer(@FConnectTimeout), SizeOf(FConnectTimeout)));
    if FSendTimeout > 0 then
      Check(not InternetSetOption(Request, INTERNET_OPTION_SEND_TIMEOUT, Pointer(@FSendTimeout), SizeOf(FSendTimeout)));
    if FReceiveTimeout > 0 then
      Check(not InternetSetOption(Request, INTERNET_OPTION_RECEIVE_TIMEOUT, Pointer(@FReceiveTimeout), SizeOf(FReceiveTimeout)));

    if (soIgnoreInvalidCerts in InvokeOptions) then
    begin
      Flags := SECURITY_FLAG_IGNORE_UNKNOWN_CA or SECURITY_FLAG_IGNORE_REVOCATION;
      InternetSetOption(Request, INTERNET_OPTION_SECURITY_FLAGS, Pointer(@Flags), Sizeof(Flags));
    end;

    { Setup packet based on Content-Type/Binding }
    if FBindingType = btMIME then
    begin
      ContentHeader := Format(ContentHeaderMIME, [FMimeBoundary]);
      ContentHeader := Format(ContentTypeTemplate, [ContentHeader]);
      HttpAddRequestHeaders(Request, PChar(MIMEVersion), Length(MIMEVersion), HTTP_ADDREQ_FLAG_ADD);
    end
    else { Assume btSOAP }
      ContentHeader := Format(ContentTypeTemplate, [GetContentType]);

    { Action header }
    if (FBindingType = btMIME) or
       (not (soNoSOAPActionHeader in FInvokeOptions) and not (wnoSOAP12 in GetWebNodeOptions)) then
    begin
      { NOTE: It's not really clear whether this should be sent in the case
              of MIME Binding. Investigate interoperability ?? }
      ActionHeader := GetSOAPActionHeader;
      HttpAddRequestHeaders(Request, PChar(ActionHeader), Length(ActionHeader), HTTP_ADDREQ_FLAG_ADD);
    end;


    { Content-Type }
    HttpAddRequestHeaders(Request, PChar(ContentHeader), Length(ContentHeader), HTTP_ADDREQ_FLAG_ADD);

    { Before we pump data, see if user wants to handle something - like set Basic-Auth data?? }
    if Assigned(FOnBeforePost) then
      FOnBeforePost(Self, Request);

    ASrc.Position := 0;
    BuffSize := ASrc.Size;
    if BuffSize > FMaxSinglePostSize then
    begin
      UseSendRequestEx := True;

      Buffer := TMemoryStream.Create;
      try
        Buffer.SetSize(FMaxSinglePostSize);

        { Init Input Buffer }
        INBuffer.dwStructSize := SizeOf(INBuffer);
        INBuffer.Next := nil;
        INBuffer.lpcszHeader := nil;
        INBuffer.dwHeadersLength := 0;
        INBuffer.dwHeadersTotal := 0;
        INBuffer.lpvBuffer := nil;
        INBuffer.dwBufferLength := 0;
        INBuffer.dwBufferTotal := BuffSize;
        INBuffer.dwOffsetLow := 0;
        INBuffer.dwOffsetHigh := 0;

        while UseSendRequestEx do
        begin
          ASrc.Position := 0;

          { Don't assume we're coming back }
          UseSendRequestEx := False;

          { Start POST }
          Check(not HttpSendRequestEx(Request, @INBuffer, nil,
                                      0(*HSR_INITIATE or HSR_SYNC*), 0));
          try
            while True do
            begin
              { Calc length of data to send }
              Len := BuffSize - ASrc.Position;
              if Len > FMaxSinglePostSize then
                Len := FMaxSinglePostSize;
              { Bail out if zip.. }
              if Len = 0 then
                break;
              { Read data in buffer and write out}
              Len := ASrc.Read(Buffer.Memory^, Len);
              if Len = 0 then
                raise ESOAPHTTPException.Create(SInvalidHTTPRequest);

              RetVal := ERROR_SUCCESS;
              if not InternetWriteFile(Request, @Buffer.Memory^, Len, BytesWritten) then
                RetVal := HandleWinInetError(GetLastError, Request, True);

              case RetVal of
                ERROR_SUCCESS:;
                ERROR_CANCELLED: System.SysUtils.Abort;
                ERROR_INTERNET_FORCE_RETRY: {Retry the operation};
              end;

              { Posting Data Event }
              if Assigned(FOnPostingData) then
                FOnPostingData(ASrc.Position, BuffSize);
            end;
          finally
            RetVal := ERROR_SUCCESS;
            WinInetResult := HttpEndRequest(Request, nil, 0, 0);
            RetVal := HandleWinInetError(GetLastError, Request, not WinInetResult);

            case RetVal of
              ERROR_SUCCESS: ;
              ERROR_CANCELLED: System.SysUtils.Abort;
              ERROR_INTERNET_FORCE_RETRY:
                { We're going back again pal:( }
                { See the following URL:
                http://www.archivum.info/microsoft.public.inetsdk.programming.wininet/2006-08/00013/Re:_ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED_from_HttpEndRequest
                }
                UseSendRequestEx := True;
            end;
          end;
        end;
      finally
        Buffer.Free;
      end;
    end else
    begin
{$IFDEF UNICODE}
      DatStr := TBytesStream.Create;
{$ELSE}
      DatStr := TStringStream.Create('');
{$ENDIF}
      try
        DatStr.CopyFrom(ASrc, 0);
        while True do
        begin

          { Posting Data Event }
          if Assigned(FOnPostingData) then
            FOnPostingData(DatStr.Size, BuffSize);

          RetVal := ERROR_SUCCESS;
{$IFDEF UNICODE}
          WinInetResult := HttpSendRequest(Request, nil, 0, DatStr.Bytes, DatStr.Size);
{$ELSE}
          WinInetResult := HttpSendRequest(Request, nil, 0, @DatStr.DataString[1], Length(DatStr.DataString));
{$ENDIF}
          RetVal := HandleWinInetError(GetLastError, Request, not WinInetResult);

          case RetVal of
            ERROR_SUCCESS: break;
            ERROR_CANCELLED: System.SysUtils.Abort;
            ERROR_INTERNET_FORCE_RETRY: {Retry the operation};
          end;
        end;
      finally
        DatStr.Free;
      end;
    end;
  except
    if (Request <> nil) then
      InternetCloseHandle(Request);
    Connect(False);
    raise;
  end;
  Result := Request;
end;

function THTTPReqResp.SendGet: HINTERNET;
var
  Request: HINTERNET;
  RetVal, Flags : DWord;
  AcceptTypes: array of PChar;
begin
  { Connect }
  Connect(True);

  SetLength(AcceptTypes, 2);
  AcceptTypes[0] := PChar('*/*');  { Do not localize }
  AcceptTypes[1] := nil;
  Flags := INTERNET_FLAG_DONT_CACHE;
  if FURLScheme = INTERNET_SCHEME_HTTPS then
  begin
    Flags := Flags or INTERNET_FLAG_SECURE;
    if (soIgnoreInvalidCerts in InvokeOptions) then
      Flags := Flags or (INTERNET_FLAG_IGNORE_CERT_CN_INVALID or
                         INTERNET_FLAG_IGNORE_CERT_DATE_INVALID);
  end;

  Request := nil;
  try
    Request := HttpOpenRequest(FInetConnect, 'GET', PChar(FURLSite), nil, { Do not localize }
      nil, Pointer(AcceptTypes), Flags, NativeUInt(Self));
    Check(not Assigned(Request), False);

    while True do
    begin
      HttpSendRequest(Request, nil, 0, nil, 0);
      RetVal := HandleWinInetError(GetLastError, Request);
      case RetVal of
        ERROR_CANCELLED: System.SysUtils.Abort;
        ERROR_SUCCESS: Break;
        ERROR_INTERNET_FORCE_RETRY: {Retry the operation};
      end;
    end;
  except
    if (Request <> nil) then
      InternetCloseHandle(Request);
    Connect(False);
    raise;
  end;
  Result := Request;
end;
{$ENDIF}

{$IFDEF USE_INDY}
procedure THTTPReqResp.SetupIndy(IndyHttp: TIDHttp; Request: TStream);

  procedure GetHostAndPort(const AURL: string; var AHost, APort: string);
  var
    Index: Integer;
  begin
    Index := Pos(':', AURL);
    if Index > 0 then
    begin
      AHost := Copy(AURL, 1, Index-1);
      APort := Copy(AURL, Index+1, MaxInt);
    end;
end;

  function IsHTTPS: Boolean;
  var
    Protocol, Host, path, Document, Port, Bookmark: string;
  begin
    ParseURI(FUrl, Protocol, Host, path, Document, Port, Bookmark);
    Result := AnsiSameText(Protocol, 'HTTPS');
  end;

var
  Protocol, Host, Path, Document, Port, Bookmark: string;
begin
{$IFDEF INDY_CUSTOM_IOHANDLER}
  if FIOHandler <> nil then
    IndyHttp.IOHandler := FIOHandler
  else
{$ENDIF}
  begin
    if IsHttps then
    begin
{$IFDEF INDY_10}
      IndyHttp.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(IndyHttp);
{$ELSE}
      IndyHttp.IOHandler := TIdSSLIOHandlerSocket.Create(IndyHttp);
{$ENDIF}
    end;
  end;

{  if Request is TMimeAttachmentHandler then }
  if FBindingType = btMIME then
  begin
    IndyHttp.Request.ContentType := Format(ContentHeaderMIME, [FMimeBoundary]);
    IndyHttp.Request.CustomHeaders.Add(MimeVersion);
  end else { Assume btSOAP }
  begin
    IndyHttp.Request.ContentType := GetContentType;
    if not (soNoSOAPActionHeader in FInvokeOptions) then
      IndyHttp.Request.CustomHeaders.Add(GetSOAPActionHeader);
  end;

  IndyHttp.Request.Accept := '*/*';
  IndyHttp.Request.UserAgent := Self.FAgent;

  { Proxy support configuration }
  if FProxy <> '' then
  begin
    { first check for 'http://localhost:####' }
    ParseURI(FProxy, Protocol, Host, Path, Document, Port, Bookmark);
    { if fail then check for 'localhost:####' }
    if Host = '' then
      GetHostAndPort(FProxy, Host, Port);
    IndyHttp.ProxyParams.ProxyServer := Host;
    if Port <> '' then
      IndyHttp.ProxyParams.ProxyPort := StrToInt(Port);

    { If name/password is used in conjunction with proxy, it's passed
      along for proxy authentication }
    IndyHttp.ProxyParams.ProxyUsername := FUserName;
    IndyHttp.ProxyParams.ProxyPassword := FPassword;
  end else
  begin
    { no proxy with Username/Password implies basic authentication }
    IndyHttp.Request.BasicAuthentication := true;
    IndyHttp.Request.Username := FUserName;
    IndyHttp.Request.Password := FPassword;
  end;
{$IFNDEF INDY_10}
  IndyHttp.Host := FUrlHost;
  IndyHttp.Port := FUrlPort;
{$ENDIF}
end;
{$ENDIF}

procedure THTTPReqResp.Get(Resp: TStream);
{$IFNDEF USE_INDY}
var
  Context: HINTERNET;
{$ENDIF}
{$IFDEF USE_INDY}
  procedure LoadFromURL(URL: string; Stream: TStream);
  var
    IndyHTTP: TIDHttp;
    Protocol, Host, Path, Document, Port, Bookmark: string;
  begin
    IndyHTTP := TIDHttp.Create(Nil);
    try
      IndyHttp.Request.Accept := '*/*';
      IndyHttp.Request.UserAgent := Self.FAgent;
      IndyHttp.Request.ContentType := sTextXml;
      if FProxy <> '' then
      begin
        ParseURI(FProxy, Protocol, Host, Path, Document, Port, Bookmark);
        IndyHttp.ProxyParams.ProxyServer := Host;
        IndyHttp.ProxyParams.ProxyPort := StrToInt(Port);
        IndyHttp.ProxyParams.ProxyUsername := FUserName;
        IndyHttp.ProxyParams.ProxyPassword := FPassword;
      end else
      begin
        { no proxy with Username/Password implies basic authentication }
        IndyHttp.Request.Username := FUserName;
        IndyHttp.Request.Password := FPassword;
      end;
      if (FUserName <> '') and (FPassword <> '') and (FProxy = '') then
        IndyHttp.OnProxyAuthorization := IndyProxyAuthorization;

      { IndyHttp.Intercept := FIntercept; }
      IndyHttp.Get(URL, Stream);
    finally
      IndyHTTP.Free;
    end;
  end;
{$ENDIF}
begin
  { GETs require a URL }
  if URL = '' then
    raise ESOAPHTTPException.Create(SEmptyURL);
{$IFDEF USE_INDY}
  { GET with INDY }
  LoadFromURL(URL, Resp);
{$ELSE}
  Context := SendGet;
  try
    Receive(Context, Resp, True);
  finally
    if Context <> nil  then
      InternetCloseHandle(Context);
    Connect(False);
  end;
{$ENDIF}
end;

{ Here the RIO can perform any transports specific setup before call - XML serialization is done }
procedure THTTPReqResp.BeforeExecute(const IntfMD: TIntfMetaData;
                                     const MethMD: TIntfMethEntry;
                                     MethodIndex: Integer;
                                     AttachHandler: IMimeAttachmentHandler);
var
  MethName: InvString;
  Binding: InvString;
  QBinding: IQualifiedName;
  SOAPVersion: TSOAPVersion;
begin
  if FUserSetURL then
  begin
    MethName := InvRegistry.GetMethExternalName(IntfMD.Info, MethMD.Name);
    FSoapAction := InvRegistry.GetActionURIOfInfo(IntfMD.Info, MethName, MethodIndex);
  end
  else
  begin
    { User did *NOT* set a URL }
    if WSDLView <> nil then
    begin
      if ioSOAP12 in InvRegistry.GetIntfInvokeOptions(IntfMD.Info) then
        SOAPVersion := svSOAP12
      else
        SOAPVersion := svSOAP11;

      { Make sure WSDL is active }
      WSDLView.Activate;
      QBinding := WSDLView.WSDL.GetBindingForServicePort(WSDLView.Service, WSDLView.Port);
      if QBinding <> nil then
      begin
        Binding := QBinding.Name;
        MethName:= InvRegistry.GetMethExternalName(WSDLView.IntfInfo, WSDLView.Operation);
                                                                                                    
        FSoapAction := WSDLView.WSDL.GetSoapAction(Binding, MethName, 0, SOAPVersion);
      end;

      {NOTE: In case we can't get the SOAPAction - see if we have something in the registry }
      {      It can't hurt:) }
      if FSoapAction = '' then
        InvRegistry.GetActionURIOfInfo(IntfMD.Info, MethName, MethodIndex);

      { Retrieve URL }
      FURL := WSDLView.WSDL.GetSoapAddressForServicePort(WSDLView.Service, WSDLView.Port, SOAPVersion);
      if (FURL = '') then
        raise ESOAPHTTPException.CreateFmt(sCantGetURL,
                                           [WSDLView.Service, WSDLView.Port, WSDLView.WSDL.FileName]);
      InitURL(FURL);
    end
    else
      raise ESOAPHTTPException.Create(sNoWSDLURL);
  end;

  { Are we sending attachments?? }
  if AttachHandler <> nil then
  begin
    FBindingType := btMIME;
    { If yes, ask MIME handler what MIME boundary it's using to build the Multipart
      packet }
    FMimeBoundary := AttachHandler.MIMEBoundary;

    { Also customize the MIME packet for transport specific items }
    if UseUTF8InHeader then
      AttachHandler.AddSoapHeader(Format(ContentTypeTemplate, [ContentTypeUTF8]))
    else
      AttachHandler.AddSoapHeader(Format(ContentTypeTemplate, [ContentTypeNoUTF8]));
    AttachHandler.AddSoapHeader(GetSOAPActionHeader);
  end else
    FBindingType := btSOAP;
end;

procedure THTTPReqResp.Execute(const DataMsg: String; Resp: TStream);
var
  Stream: TMemoryStream;
{$IFDEF UNICODE}
{$IFDEF NEXTGEN}
  ABytes: TBytes;
{$ELSE !NEXTGEN}
  AStr: AnsiString;
{$ENDIF NEXTGEN}
{$ENDIF}
begin
{$IFDEF UNICODE}
{$IFDEF NEXTGEN}
  ABytes := TEncoding.UTF8.GetBytes(DataMsg);
{$ELSE !NEXTGEN}
  AStr := UTF8Encode(DataMsg);
{$ENDIF NEXTGEN}
{$ENDIF}
  Stream := TMemoryStream.Create;
  try
{$IFDEF UNICODE}
{$IFDEF NEXTGEN}
    Stream.SetSize(Longint(Length(ABytes)));
    Stream.Write(ABytes, 0, Length(ABytes));
{$ELSE !NEXTGEN}
    Stream.SetSize(Length(AStr));
    Stream.Write(AStr[Low(string)], Length(AStr));
{$ENDIF NEXTGEN}
{$ELSE}
    Stream.SetSize(Length(DataMsg));
    Stream.Write(DataMsg[1], Length(DataMsg));
{$ENDIF}
    Execute(Stream, Resp);
  finally
    Stream.Free;
  end;
end;

function THTTPReqResp.Execute(const Request: TStream): TStream;
begin
  Result := TMemoryStream.Create;
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
  try
{$ENDIF}
    Execute(Request, Result);
{$IFDEF CLIENT_CERTIFICATE_SUPPORT}
  finally
    SetCertContext(nil);
    SetCertStore(nil);
  end;
{$ENDIF}
end;

procedure THTTPReqResp.CheckContentType;
begin
  { NOTE: Content-Types are case insensitive! }
  {       And here we're not validating that we
          have a valid content-type; rather
          we're checking for some common invalid
          ones }
  if SameText(FContentType, ContentTypeTextPlain) or
     SameText(FContentType, STextHtml) then
    raise ESOAPHTTPException.CreateFmt(SInvalidContentType, [FContentType]);
end;

procedure THTTPReqResp.Execute(const Request: TStream; Response: TStream);

  function IsErrorStatusCode(Code: Integer): Boolean;
  begin
    case Code of
      404, 405, 410:
        Result := True;
      else
        Result := False;
    end;
  end;

{$IFDEF USE_INDY}
  procedure PostData(const Request: TStream; Response: TStream);
  var
    IndyHTTP: TIDHttp;
  begin
    IndyHTTP := TIDHttp.Create(Nil);
    try
      SetupIndy(IndyHTTP, Request);
      if Assigned(FOnBeforePost) then
        FOnBeforePost(Self, Pointer(IndyHTTP));
      if (FUserName <> '') and (FPassword <> '') and (FProxy = '') then
        IndyHttp.OnProxyAuthorization := IndyProxyAuthorization;

      IndyHttp.Post(FURL, Request, Response);
      FContentType := IndyHttp.Response.RawHeaders.Values[SContentType];
      FMimeBoundary := GetMimeBoundaryFromType(FContentType);
      if Response.Size = 0 then
        raise ESOAPHTTPException.Create(SInvalidHTTPResponse);
      CheckContentType;
    finally
      if Assigned(IndyHttp.IOHandler) then
{$IFDEF INDY_CUSTOM_IOHANDLER}
        { Don't free the IOHandler if we did not create it }
        if FIOHandler = nil then
{$ENDIF}
{$IFDEF AUTOREFCOUNT}
        IndyHttp.IOHandler := nil;
{$ELSE !AUTOREFCOUNT}
        IndyHttp.IOHandler.Free;
{$ENDIF AUTOREFCOUNT}
      FreeAndNil(IndyHTTP);
    end;
  end;


{$ELSE}
var
  Context: HINTERNET;
  CanRetry: Boolean;
  LookUpUDDI: Boolean;
  AccessPoint: String;
  PrevError: String;
{$ENDIF}
begin
{$IFNDEF USE_INDY}
  LookUpUDDI := False;
  CanRetry := (soAutoCheckAccessPointViaUDDI in FInvokeOptions) and
              (Length(FUDDIBindingKey) > 0) and
              (Length(FUDDIOperator) > 0);
{$ENDIF}
{$IFDEF USE_INDY}
  PostData(Request, Response);
{$ELSE}
  while (True) do
  begin
    { Look up URL from UDDI?? }
    if LookUpUDDI and CanRetry then
    begin
      try
        CanRetry := False;
        AccessPoint := '';
        AccessPoint := GetBindingkeyAccessPoint(FUDDIOperator, FUDDIBindingKey);
      except
        { Ignore UDDI lookup error }
      end;
      { If UDDI lookup failed or we got back the same URL we used...
        raise the previous execption message }
      if (AccessPoint = '') or SameText(AccessPoint, FURL) then
        raise ESOAPHTTPException.Create(PrevError);
      SetURL(AccessPoint);
    end;

    Context := Send(Request);
    try
      try
        Receive(Context, Response);
        Exit;
      except
        on Ex: ESOAPHTTPException do
        begin
          Connect(False);
          if not CanRetry or not IsErrorStatusCode(Ex.StatusCode) then
            raise;
          { Trigger UDDI Lookup }
          LookUpUDDI := True;
          PrevError := Ex.Message;
        end;
        else
        begin
          Connect(False);
          raise;
        end;
      end;
    finally
      if Context <> nil  then
        InternetCloseHandle(Context);
    end;
  end;
{$ENDIF}
end;

{$IFDEF DEXTER_UP}
function THTTPReqResp.GetAgentIsStored: Boolean;
begin
  Result := FAgent <> SOAP_AGENT;
end;
{$ENDIF}


end.
