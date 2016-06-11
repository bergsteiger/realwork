{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSHTTPClient;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  Data.DBXCommon,
  System.Net.HTTPClient,
  System.Net.URLClient;

type

  /// <summary>HTTP error information exception.</summary>
  EHTTPProtocolException = class(Exception)
  private
    FErrorMessage: string;
    FErrorCode: Integer;
  public
    /// <summary>Create an exception object</summary>
    constructor Create(AErrorCode: Integer; const AErrorMessage: string; const AMessage: string);
    /// <summary>The HTTP error code</summary>
    property ErrorCode: Integer read FErrorCode;
    /// <summary>The HTTP error message</summary>
    property ErrorMessage: string read FErrorMessage;
  end;

  TDSHTTPClass = class of TDSHTTP;

  /// <summary>TDSHTTP implements HTTP functionality on the client
  /// side.</summary>
  TDSHTTP = class(TComponent)
  public type

    TValidateCertificateEvent = System.Net.URLClient.TValidateCertificateEvent;
    TAuthEvent = System.Net.URLClient.TCredentialsStorage.TCredentialAuthEvent;

    /// <summary>Proxy server connection parameters</summary>
    IProxyConnectionInfo = interface
      /// <summary>Set the port of the proxy server</summary>
      procedure SetProxyPort(Val: Integer);
      /// <summary>Get the port of the proxy server</summary>
      function GetProxyPort: Integer;
      /// <summary>Get or set the port of the proxy server</summary>
      property ProxyPort: Integer read GetProxyPort write SetProxyPort;
      /// <summary>Get the proxy server host name</summary>
      function GetProxyServer: string;
      /// <summary>Set the proxy server host name</summary>
      procedure SetProxyServer(Val: string);
      /// <summary>Get or set the proxy server host name</summary>
      property ProxyServer: string read GetProxyServer write SetProxyServer;
      /// <summary>Get the proxy server scheme</summary>
      function GetProxyScheme: string;
      /// <summary>Set the proxy server scheme</summary>
      procedure SetProxyScheme(Val: string);
      /// <summary>Get or set the proxy server scheme</summary>
      property ProxyScheme: string read GetProxyScheme write SetProxyScheme;
      /// <summary>Get a the username used to access the proxy server</summary>
      function GetProxyUserName: string;
      /// <summary>Set a the username used to access the proxy server</summary>
      procedure SetProxyUserName(user: string);
      /// <summary>Get or set the username used to access the proxy server</summary>
      property ProxyUserName: string read GetProxyUserName write SetProxyUserName;
      /// <summary>Get the password used to access the proxy server</summary>
      function GetProxyPassword: string;
      /// <summary>Set the password used to access the proxy server</summary>
      procedure SetProxyPassword(pass: string);
      /// <summary>Get or set the passwor used to access the proxy server</summary>
      property ProxyPassword: string read GetProxyPassword write SetProxyPassword;
    end;

    /// <summary>List of HTTP headers</summary>
    IHeaderList = interface
      /// <summary>Get the count of header.</summary>
      function GetCount: Integer;
      /// <summary>Get the count of header.</summary>
      property Count: Integer read GetCount;
      /// <summary>Get the name of a header.</summary>
      function GetName(Index: Integer): string;
      /// <summary>Get the name of a header.</summary>
      property Names[Index: Integer]: string read GetName;
      /// <summary>Get the value of a header.</summary>
      function GetValue(const Name: string): string;
      /// <summary>Get the value of a header.</summary>
      property Values[const Name: string]: string read GetValue;
    end;

    /// <summary>List of HTTP headers that can be modified</summary>
    IRequestHeaderList = interface(IHeaderList)
      /// <summary>Clear all headers</summary>
      procedure Clear;
      /// <summary>Add or modify a header</summary>
      procedure SetValue(const AName, AValue: string);
      /// <summary>Get or set the value of a header</summary>
      property Values[const Name: string]: string read GetValue write SetValue;
    end;

    /// <summary>Properties of an HTTP request</summary>
    IRequest = interface
      /// <summary>Get the HTTP request accept string</summary>
      function GetAccept: string;
      /// <summary>Set the HTTP request accept string</summary>
      procedure SetAccept(const Val: string);
      /// <summary>Get or set the HTTP request accept string</summary>
      property Accept: string read GetAccept write SetAccept;
      /// <summary>Get the HTTP request charset string</summary>
      function GetAcceptCharSet: string;
      /// <summary>Set the HTTP request charset string</summary>
      procedure SetAcceptCharSet(const Val: string);
      /// <summary>Get or set the HTTP request charset string</summary>
      property AcceptCharSet: string read GetAcceptCharSet write SetAcceptCharSet;
      /// <summary>Get the HTTP request custom headers.</summary>
      function GetCustomHeaders: IRequestHeaderList;
      /// <summary>Get the HTTP request custom headers.</summary>
      property CustomHeaders: IRequestHeaderList read GetCustomHeaders;
      /// <summary>Get the HTTP request acceptencoding string</summary>
      function GetAcceptEncoding: string;
      /// <summary>Set the HTTP request acceptencoding string</summary>
      procedure SetAcceptEncoding(const Val: string);
      /// <summary>Get or set the HTTP request acceptencoding string</summary>
      property AcceptEncoding: string read GetAcceptEncoding write SetAcceptEncoding;
      /// <summary>Get the HTTP request contenttype string</summary>
      function GetContentType: string;
      /// <summary>Set the HTTP request contenttype string</summary>
      procedure SetContentType(LContentType: string);
      /// <summary>Get or set the HTTP request contenttype string</summary>
      property ContentType: string read GetContentType write SetContentType;
      /// <summary>Get the HTTP request useragent string</summary>
      function GetUserAgent: string;
      /// <summary>Set the HTTP request useragent string</summary>
      procedure SetUserAgent(const Val: string);
      /// <summary>Get or set the HTTP request useragent string</summary>
      property UserAgent: string read GetUserAgent write SetUserAgent;
      /// <summary>Get the HTTP request Username string</summary>
      function GetUserName: string;
      /// <summary>Get the HTTP request password string</summary>
      function GetPassword: string;
      /// <summary>Set the HTTP request username and password</summary>
      procedure SetAuthentication(const AUserName, APassword: string);
    end;

    /// <summary>Properties of an HTTP response</summary>
    IResponse = interface
      /// <summary>Get the HTTP response character set string</summary>
      function GetCharSet: string;
      /// <summary>Get the HTTP response character set string</summary>
      property CharSet: string read GetCharSet;
      /// <summary>Get the HTTP response content type string</summary>
      function GetContentType: string;
      /// <summary>Get the HTTP response content type string</summary>
      property ContentType: string read GetContentType;
      /// <summary>Get the HTTP response content encoding string</summary>
      function GetContentEncoding: string;
      /// <summary>Get the HTTP response content encoding string</summary>
      property ContentEncoding: string read GetContentEncoding;
      /// <summary>Get the HTTP response headers</summary>
      function GetHeaders: IHeaderList;
      /// <summary>Get the HTTP response headers</summary>
      property Headers: IHeaderList read GetHeaders;
    end;

  private
    FHTTPClient: THTTPClient;
    FHTTPResponse: IHTTPResponse;
    FIPHTTPRequestIntf: TDSHTTP.IRequest;
    FProxyConnectionInfo: IProxyConnectionInfo;
    FOnValidateCertificate: TValidateCertificateEvent;
    FOnValidatePeerCertificate: TValidateCertificate;
    FOnValidatePeerCertificateErr: TValidateCertificateErr;
    FOnAuthEvent: TCredentialsStorage.TCredentialAuthEvent;
    FOnSelectCertificate: TNeedClientCertificateEvent;
    FIPImplementationID: string;
    FProtocol: string;
    function GetRequest: IRequest;
    function GetResponse: IResponse;
    function GetProxyParams: IProxyConnectionInfo;
    function GetResponseCode: Integer;
    function GetResponseText: string;
    function GetHandleRedirects: Boolean;
    procedure SetHandleRedirects(AValue: Boolean);
    function GetAllowCookies: Boolean;
    procedure SetAllowCookies(AValue: Boolean);
    function GetConnectTimeout: Integer;
    procedure SetConnectTimeout(const Value: Integer);
    function GetReadTimeout: Integer;
    procedure SetReadTimeout(const Value: Integer);
    procedure CheckResponse;
    procedure PrepareRequest(const ARequest: IHTTPRequest);
    procedure Execute(const AMethod: string; AURL: string; ASource, AResponseContent: TStream); overload;
    procedure Execute(const AMethod: string; AURL: string; AResponseContent: TStream); overload;
    procedure RaiseProtocolException(const AResponse: IHTTPResponse);
    procedure DoCustomAuthentication(const Sender: TObject; AnAuthTarget: TAuthTargetType;
      const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean;
      var Persistence: TAuthPersistenceType);
    procedure DoValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest;
      const Certificate: TCertificate; var Accepted: Boolean);
    function GetProtocol: string;
    procedure SetProtocol(const protocol: string);
  public
    class constructor Create;
    class destructor Destroy;
    constructor Create; reintroduce; overload; virtual;
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create(const AIPImplementationID: string); reintroduce; overload; virtual;
    constructor Create(AOwner: TComponent; const AIPImplementationID: string); reintroduce; overload; virtual;
    destructor Destroy; override;
    // For backwards compatibility
    class function HasPeerCertificate: Boolean; virtual;
    // For backwards compatibility
    class function RegisteredProtocolList: TArray<string>; static;
    // For backwards compatibility
    class function ProtocolClass(const AName: string): TDSHTTPClass; static;

    /// <summary>Execute HTTP DELETE</summary>
    procedure Delete(const AURL: string; AResponseStream: TStream = nil);
    /// <summary>Execute HTTP MERGE</summary>
    procedure Merge(const AURL: string; ARequestStream: TStream = nil);
    /// <summary>Execute HTTP HEAD</summary>
    procedure Head(const AURL: string);
    /// <summary>Execute HTTP PATCH</summary>
    procedure Patch(const AURL: string; ASource: TStream; AResponseContent: TStream = nil);
    /// <summary>Execute HTTP PUT</summary>
    procedure Put(const AURL: string; ASource: TStream; AResponseContent: TStream = nil);
    /// <summary>Execute HTTP POST</summary>
    procedure Post(const AURL: string; ASource: TStream; AResponseContent: TStream = nil);
    /// <summary>Execute HTTP GET</summary>
    procedure Get(const AURL: string; AResponseContent: TStream = nil);
    /// <summary>Uses HTTP standard authentication protocols with the given credentials.</summary>
    procedure SetAuthentication(const user: string; const password: string);
    /// <summary>clear all client credentials.</summary>
    procedure ClearClientCredentials;
    /// <summary>Get all Client credentials.</summary>
    function GetClientCredentials: TCredentialsStorage.TCredentialArray;
    /// <summary>Add a cookie that will be passed to the server with each request</summary>
    procedure AddServerCookie(const ACookie: string; const AURL: string);

    /// <summary>Get the HTTP request properties</summary>
    property Request: IRequest read GetRequest;
    property Response: IResponse read GetResponse;

    /// <summary>Get the proxy server connection properties</summary>
    property ProxyParams: IProxyConnectionInfo read GetProxyParams;
    /// <summary>Get the HTTP ResponseCode</summary>
    property ResponseCode: Integer read GetResponseCode;
    /// <summary>Get the HTTP Response text</summary>
    property ResponseText: string read GetResponseText;
    /// <summary>Indicate whether redirect responses are handled automatically by making an additional request.</summary>
    property HandleRedirects: Boolean read GetHandleRedirects write SetHandleRedirects;
    /// <summary>Allow the client to set server side cookies</summary>
    property AllowCookies: Boolean read GetAllowCookies write SetAllowCookies;
    /// <summary>Get or set the timeout when making an HTTP connection</summary>
    property ConnectTimeout: Integer read GetConnectTimeout write SetConnectTimeout;
    /// <summary>Get or set the timeout when reading a HTTP response</summary>
    property ReadTimeout: Integer read GetReadTimeout write SetReadTimeout;
    /// <summary>Event is fired when errors exist in the SSL certificates, that require user validation </summary>
    property OnValidateCertificate: TValidateCertificateEvent read FOnValidateCertificate write FOnValidateCertificate;
    /// <summary>Event is fired when Server requires the user to select the from OS installed certificates</summary>
    property OnSelectClientCertificate: TNeedClientCertificateEvent read FOnSelectCertificate write FOnSelectCertificate;
    // for backward compatibility
    /// <summary>Occurs when the peer SSL certificate is about to be validated.</summary>
    property OnValidatePeerCertificate: TValidateCertificate read FOnValidatePeerCertificate
      write FOnValidatePeerCertificate;
    /// <summary>Event is fired when errors exist in the SSL certificates, that require user validation </summary>
    property OnValidatePeerCertificateErr: TValidateCertificateErr read FOnValidatePeerCertificateErr
      write FOnValidatePeerCertificateErr;
    /// <summary>Method is called when Server fires an authentication event </summary>
    property OnCustomAuthentication: TCredentialsStorage.TCredentialAuthEvent read FOnAuthEvent write FOnAuthEvent;
    /// <summary>Implementation ID </summary>
    property IPImplementationID: string read FIPImplementationID;
    /// <summary>sets connection header to close </summary>
    procedure Disconnect;
    /// <summary>Get Protocol in use </summary>
    property protocol: string read GetProtocol write SetProtocol;
  end;

  TDSHTTPS = class(TDSHTTP)
  public
    // For backwards compatibility
    class function HasPeerCertificate: Boolean; override;
  end;

implementation

uses
  System.Hash,
  System.NetEncoding,
  Data.DBXClientResStrs,
  DataSnap.DSClientResStrs;

type
  TIPHTTPRequest = class(TInterfacedObject, TDSHTTP.IRequest)
  private
    FAccept: string;
    FAcceptCharSet: string;
    FUserAgent: string;
    FContentType: string;
    FAcceptEncoding: string;
    FCustomHeaders: TStrings;
    FUserName: string;
    FPassword: string;
    function GetAccept: string;
    procedure SetAccept(const Val: string);
    function GetAcceptCharSet: string;
    procedure SetAcceptCharSet(const Val: string);
    function GetCustomHeaders: TDSHTTP.IRequestHeaderList;
    function GetAcceptEncoding: string;
    procedure SetAcceptEncoding(const Val: string);
    function GetContentType: string;
    procedure SetContentType(LContentType: string);
    function GetUserAgent: string;
    procedure SetUserAgent(const Val: string);
    function GetUserName: string;
    function GetPassword: string;
    procedure SetAuthentication(const AUserName, APassword: string);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TIPHTTPResponse = class(TInterfacedObject, TDSHTTP.IResponse)
  private
    FResponse: IHTTPResponse;
    function GetCharSet: string;
    function GetContentType: string;
    function GetContentEncoding: string;
    function GetHeaders: TDSHTTP.IHeaderList;
  public
    constructor Create(const AResponse: IHTTPResponse);
  end;

  TIPProxyConnectionInfo = class(TInterfacedObject, TDSHTTP.IProxyConnectionInfo)
  private
    FProxySettings: TProxySettings;
    procedure SetProxyPort(Val: Integer);
    function GetProxyPort: Integer;
    function GetProxyServer: string;
    procedure SetProxyServer(Val: string);
    function GetProxyScheme: string;
    procedure SetProxyScheme(Val: string);
    function GetProxyUserName: string;
    procedure SetProxyUserName(user: string);
    function GetProxyPassword: string;
    procedure SetProxyPassword(pass: string);
  end;

  TIPResponseHeaderList = class(TInterfacedObject, TDSHTTP.IHeaderList)
  private
    FStrings: TStrings;
    function GetCount: Integer;
    function GetName(Index: Integer): string;
    function GetValue(const Name: string): string;
    procedure Populate(const AResponse: IHTTPResponse);
  public
    constructor Create(const AResponse: IHTTPResponse);
    destructor Destroy; override;
  end;

  TIPRequestHeaderList = class(TInterfacedObject, TDSHTTP.IHeaderList, TDSHTTP.IRequestHeaderList)
  private
    FStrings: TStrings;
    function GetCount: Integer;
    function GetName(Index: Integer): string;
    function GetValue(const Name: string): string;
    procedure Clear;
    procedure SetValue(const AName, AValue: string);
  public
    constructor Create(const AStrings: TStrings);
  end;

  /// <summary> wrapper implementation of TX500Principal</summary>
  TX500NETPrincipal = class(TX500Principal)
  protected
    FName: string;
  public
    constructor Create(const AName: string); virtual;
    function GetName: string; override;
    function GetEncoded: Longint; override;
  end;

  TX509NETPublicKey = class(TPublicKey)
  private
    FAlgorithm: string;
    FFormat: string;
  public
    constructor Create(const PKAlgorithm, PKFormat: string);
    function GetAlgorithm: string; override;
    function GetFormat: string; override;
    function GetEncoded: TArray<Byte>; override;
  end;

  TX509NetWrapperCertificate = class(TX509Certificate)
  private
    FExpiry: TDateTime;
    /// <summary> Start date of the certificate</summary>
    FStart: TDateTime;
    /// <summary> Subject of the certificate</summary>
    FSubject: string;
    /// <summary> Issuer of the certificate</summary>
    FIssuer: string;
    /// <summary> ProtocolName of the certificate eg RSAEncryption</summary>
    FProtocolName: string;
    /// <summary> Algorithm Signature of the certificate eg.  00:d3:a4:50:6e:c8:ff:56:6b:e6:cf:5d:b6:... </summary>
    FAlgSignature: string;
    /// <summary> Algorithm Encryption of the certificate eg md5WithRSAEncryption</summary>
    FAlgEncryption: string;
    /// <summary> Encryption's KeySize of the certificate eg 128</summary>
    FKeySize: Integer;
    /// <summary> subject Principle information</summary>
    FSubjectPrincipal: TX500NETPrincipal;
    /// <summary> Issuer Principle information</summary>
    FIssuerPrincipal: TX500NETPrincipal;
    /// <summary> Public key information</summary>
    FPublicKey: TX509NETPublicKey;
  public
    constructor Create(const ACert: System.Net.URLClient.TCertificate);
    destructor Destroy; override;
    { Inherited from the base Certificate class }
    function GetEncoded: TArray<Byte>; override;
    function GetPublicKey: TPublicKey; override;
    function Verify(key: TPublicKey): Boolean; override;

    { Inherited from the X.509 Certificate class }
    procedure CheckValidity; overload; override;
    procedure CheckValidity(ADate: TDateTime); overload; override;
    function GetNotAfter: TDateTime; override;
    function GetNotBefore: TDateTime; override;

    function GetBasicConstraints: Integer; override;

    function GetSerialNumber: string; override;
    function GetVersion: Longint; override;

    function GetSigAlgName: string; override;
    function GetSignature: string; override;

    function GetIssuerX500Principal: TX500Principal; override;
    function GetSubjectX500Principal: TX500Principal; override;
    property Expiry: TDateTime read FExpiry;
    property Start: TDateTime read FStart;
  end;

  { TDSHTTPS }

class function TDSHTTPS.HasPeerCertificate: Boolean;
begin
  Result := True;
end;

{ TDSHTTP }

constructor TDSHTTP.Create;
begin
  Create(nil);
end;

constructor TDSHTTP.Create(AOwner: TComponent);
begin
  Create(AOwner, '');
end;

constructor TDSHTTP.Create(const AIPImplementationID: string);
begin
  Create(nil, AIPImplementationID);
end;

constructor TDSHTTP.Create(AOwner: TComponent; const AIPImplementationID: string);
begin
  inherited Create(AOwner);
  FIPImplementationID := AIPImplementationID;
  FHTTPClient := THTTPClient.Create;
  FHTTPClient.AuthEvent := DoCustomAuthentication;
  FHTTPClient.OnValidateServerCertificate := DoValidateServerCertificate;
  FIPHTTPRequestIntf := TIPHTTPRequest.Create; // Reference count
  AllowCookies := True;
end;

destructor TDSHTTP.Destroy;
begin
  FHTTPClient.Free;
  inherited;
end;

// public static class methods, for backward support

class constructor TDSHTTP.Create;
begin
  // FProtocols := TDictionary<string, TDSHTTPClass>.Create;
end;

class destructor TDSHTTP.Destroy;
begin
  // FreeAndNil(FProtocols);
end;

class function TDSHTTP.HasPeerCertificate: Boolean;
begin
  Result := False;
end;

class function TDSHTTP.RegisteredProtocolList: TArray<string>;
begin
  SetLength(Result, 2);
  Result[0] := 'http';
  Result[1] := 'https';
end;

class function TDSHTTP.ProtocolClass(const AName: string): TDSHTTPClass;
begin
  if SameText(AName, 'https') then
    Result := TDSHTTPS
  else
    Result := TDSHTTP;
end;

// public methods

procedure TDSHTTP.Execute(const AMethod: string; AURL: string; ASource, AResponseContent: TStream);
var
  LRequest: IHTTPRequest;
  LResponse: IHTTPResponse;
begin
  LRequest := FHTTPClient.GetRequest(AMethod, AURL);
  PrepareRequest(LRequest);
  ASource.Seek(Longint(0), soFromBeginning);
  LRequest.SourceStream := ASource;
  LResponse := FHTTPClient.Execute(LRequest, AResponseContent);
  FHTTPResponse := LResponse;
  if LResponse.StatusCode >= 300 then
    RaiseProtocolException(LResponse);
end;

procedure TDSHTTP.Execute(const AMethod: string; AURL: string; AResponseContent: TStream);
var
  LRequest: IHTTPRequest;
  LResponse: IHTTPResponse;
begin
  LRequest := FHTTPClient.GetRequest(AMethod, AURL);
  PrepareRequest(LRequest);
  LResponse := FHTTPClient.Execute(LRequest, AResponseContent);
  FHTTPResponse := LResponse;
  if LResponse.StatusCode >= 300 then
    RaiseProtocolException(LResponse);
end;

procedure TDSHTTP.Delete(const AURL: string; AResponseStream: TStream);
begin
  Execute('DELETE', AURL, AResponseStream);
end;

procedure TDSHTTP.Merge(const AURL: string; ARequestStream: TStream);
begin
  Execute('MERGE', AURL, ARequestStream, nil);
end;

procedure TDSHTTP.Head(const AURL: string);
begin
  Execute('HEAD', AURL, nil);
end;

procedure TDSHTTP.Patch(const AURL: string; ASource, AResponseContent: TStream);
begin
  Execute('PATCH', AURL, ASource, AResponseContent);
end;

procedure TDSHTTP.Put(const AURL: string; ASource, AResponseContent: TStream);
begin
  Execute('PUT', AURL, ASource, AResponseContent);
end;

procedure TDSHTTP.Post(const AURL: string; ASource, AResponseContent: TStream);
begin
  Execute('POST', AURL, ASource, AResponseContent);
end;

procedure TDSHTTP.Get(const AURL: string; AResponseContent: TStream);
begin
  Execute('GET', AURL, AResponseContent);
end;

procedure TDSHTTP.SetAuthentication(const user, password: string);
begin
  FHTTPClient.CredentialsStorage.AddCredential(TCredentialsStorage.TCredential.Create(TAuthTargetType.Server, '', '',
    user, password))
end;

procedure TDSHTTP.DoCustomAuthentication(const Sender: TObject; AnAuthTarget: TAuthTargetType;
  const ARealm, AURL: string; var AUserName, APassword: string; var AbortAuth: Boolean;
  var Persistence: TAuthPersistenceType);
var
  MyCredential: TCredentialsStorage.TCredential;
begin
  if Assigned(FOnAuthEvent) then
    FOnAuthEvent(Sender, AnAuthTarget, ARealm, AURL, AUserName, APassword, AbortAuth, Persistence)
  else
    begin
    if AnAuthTarget = TAuthTargetType.Proxy then
    begin
      MyCredential := FHTTPClient.CredentialsStorage.FindAccurateCredential(AnAuthTarget, '');
      AUserName := MyCredential.UserName;
      APassword := MyCredential.password;
    end;
    if AnAuthTarget = TAuthTargetType.Server then
    begin
      MyCredential := FHTTPClient.CredentialsStorage.FindAccurateCredential(AnAuthTarget, '');
      AUserName :=  MyCredential.UserName;
      APassword :=  MyCredential.password;
      //Persistence := TAuthPersistenceType.Request;
    end;
  end;
end;

procedure TDSHTTP.DoValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest;
  const Certificate: TCertificate; var Accepted: Boolean);
var
  X509cert: TX509Certificate;
begin
  if Assigned(FOnValidateCertificate) then
    FOnValidateCertificate(Sender, ARequest, Certificate, Accepted)
  else if Assigned(FOnValidatePeerCertificate) then
  begin
    X509cert := TX509NetWrapperCertificate.Create(Certificate);
    try
      FOnValidatePeerCertificate(Sender, X509cert, 0, Accepted)
    finally
      X509cert.Free;
    end;
  end
  else if Assigned(FOnValidatePeerCertificateErr) then
  begin
    X509cert := TX509NetWrapperCertificate.Create(Certificate);
    try
      FOnValidatePeerCertificateErr(Sender, X509cert, 0, 0, Accepted)
    finally
      X509cert.Free;
    end;
  end
  else
    // Accept by default
    Accepted := True;
end;

// properties

function TDSHTTP.GetRequest: IRequest;
begin
  Result := FIPHTTPRequestIntf;
end;

function TDSHTTP.GetResponse: IResponse;
begin
  CheckResponse;
  Result := TIPHTTPResponse.Create(FHTTPResponse);
end;

procedure TDSHTTP.CheckResponse;
begin
  if FHTTPResponse = nil then
    raise Exception.Create(sResponseObjectNotFound);
end;

procedure TDSHTTP.ClearClientCredentials;
begin
  FHTTPClient.CredentialsStorage.ClearCredentials;
end;

function TDSHTTP.GetClientCredentials;
begin
  Result := FHTTPClient.CredentialsStorage.Credentials;
end;

function TDSHTTP.GetProxyParams: IProxyConnectionInfo;
begin
  if FProxyConnectionInfo = nil then
    FProxyConnectionInfo := TIPProxyConnectionInfo.Create;
  Result := FProxyConnectionInfo;
end;

procedure TDSHTTP.AddServerCookie(const ACookie, AURL: string);
begin
  if FHTTPClient.AllowCookies then
    FHTTPClient.CookieManager.AddServerCookie(ACookie, AURL);
end;

function TDSHTTP.GetAllowCookies: Boolean;
begin
  Result := FHTTPClient.AllowCookies;
end;

function TDSHTTP.GetConnectTimeout: Integer;
begin
  Result := FHTTPClient.ConnectionTimeout;
end;

function TDSHTTP.GetHandleRedirects: Boolean;
begin
  Result := FHTTPClient.HandleRedirects;
end;

function TDSHTTP.GetReadTimeout: Integer;
begin
  Result := FHTTPClient.ResponseTimeout;
end;

function TDSHTTP.GetResponseCode: Integer;
begin
  CheckResponse;
  Result := FHTTPResponse.StatusCode;
end;

function TDSHTTP.GetResponseText: string;
begin
  CheckResponse;
  Result := FHTTPResponse.StatusText;
end;

procedure TDSHTTP.SetAllowCookies(AValue: Boolean);
begin
  FHTTPClient.AllowCookies := AValue;
end;

procedure TDSHTTP.SetConnectTimeout(const Value: Integer);
begin
  FHTTPClient.ConnectionTimeout := Value;
end;

procedure TDSHTTP.SetHandleRedirects(AValue: Boolean);
begin
  FHTTPClient.HandleRedirects := AValue;
end;

procedure TDSHTTP.SetReadTimeout(const Value: Integer);
begin
  FHTTPClient.ResponseTimeout := Value;
end;

procedure TDSHTTP.PrepareRequest(const ARequest: IHTTPRequest);
var
  LIPRequest: TIPHTTPRequest;
  I: Integer;
  Lprox: TProxySettings;
begin
  if FProxyConnectionInfo <> nil then
  begin
    Lprox := TIPProxyConnectionInfo(FProxyConnectionInfo).FProxySettings;
    if Lprox.UserName <> emptystr then
      FHTTPClient.ProxySettings := TProxySettings.Create(Lprox.Host, Lprox.Port, Lprox.UserName, Lprox.password,
        Lprox.Scheme);
  end;
  LIPRequest := TIPHTTPRequest(FIPHTTPRequestIntf);
  for I := 0 to LIPRequest.FCustomHeaders.Count - 1 do
  begin
    ARequest.AddHeader(LIPRequest.FCustomHeaders.Names[I], LIPRequest.FCustomHeaders.ValueFromIndex[I]);
  end;
  ARequest.Accept := LIPRequest.FAccept;
  if LIPRequest.FAcceptCharSet <> emptystr then
    ARequest.AcceptCharSet := LIPRequest.FAcceptCharSet;
  if LIPRequest.FUserAgent <> emptystr then
    ARequest.UserAgent := LIPRequest.FUserAgent;
  if LIPRequest.FAcceptEncoding <> '' then
    ARequest.AcceptEncoding := LIPRequest.FAcceptEncoding;
  if LIPRequest.FContentType <> '' then
    ARequest.AddHeader('Content-type', LIPRequest.FContentType);
  if LIPRequest.FUserName <> '' then
    ARequest.SetCredential(LIPRequest.FUserName, LIPRequest.FPassword);
end;

procedure TDSHTTP.RaiseProtocolException(const AResponse: IHTTPResponse);
const
  sHTTP10 = 'HTTP/1.0';
  sHTTP11 = 'HTTP/1.1';
  sHTTP20 = 'HTTP/2.0';
var
  LMessage: string;
begin
  case AResponse.Version of
    THTTPProtocolVersion.UNKNOWN_HTTP:
      LMessage := '';
    THTTPProtocolVersion.HTTP_1_0:
      LMessage := sHTTP10 + ' ';
    THTTPProtocolVersion.HTTP_1_1:
      LMessage := sHTTP11 + ' ';
    THTTPProtocolVersion.HTTP_2_0:
      LMessage := sHTTP20 + ' ';
  end;
  LMessage := LMessage + Format('%d %s', [AResponse.StatusCode, AResponse.StatusText]);
  raise EHTTPProtocolException.Create(AResponse.StatusCode, AResponse.ContentAsString, LMessage);
end;

{ TIPHTTPRequest }

constructor TIPHTTPRequest.Create;
begin
  FCustomHeaders := TStringList.Create;
end;

destructor TIPHTTPRequest.Destroy;
begin
  FCustomHeaders.Free;
  inherited;
end;

function TIPHTTPRequest.GetAccept: string;
begin
  Result := FAccept;
end;

function TIPHTTPRequest.GetAcceptCharSet: string;
begin
  Result := FAcceptCharSet;
end;

function TIPHTTPRequest.GetAcceptEncoding: string;
begin
  Result := FAcceptEncoding;
end;

function TIPHTTPRequest.GetContentType: string;
begin
  Result := FContentType;
end;

function TIPHTTPRequest.GetCustomHeaders: TDSHTTP.IRequestHeaderList;
begin
  Result := TIPRequestHeaderList.Create(FCustomHeaders);
end;

function TIPHTTPRequest.GetPassword: string;
begin
  Result := FPassword;
end;

function TIPHTTPRequest.GetUserAgent: string;
begin
  Result := FUserAgent;
end;

function TIPHTTPRequest.GetUserName: string;
begin
  Result := FUserName;
end;

procedure TIPHTTPRequest.SetAccept(const Val: string);
begin
  FAccept := Val;
end;

procedure TIPHTTPRequest.SetAcceptCharSet(const Val: string);
begin
  FAcceptCharSet := Val;
end;

procedure TIPHTTPRequest.SetAcceptEncoding(const Val: string);
begin
  FAcceptEncoding := Val;
end;

procedure TIPHTTPRequest.SetAuthentication(const AUserName, APassword: string);
begin
  if AUserName <> emptystr then
  begin
    FUserName := AUserName;
    FPassword := APassword;
  end;
end;

procedure TIPHTTPRequest.SetContentType(LContentType: string);
begin
  FContentType := LContentType;
end;

procedure TIPHTTPRequest.SetUserAgent(const Val: string);
begin
  FUserAgent := Val;
end;

{ TIPHTTPResponse }

constructor TIPHTTPResponse.Create(const AResponse: IHTTPResponse);
begin
  FResponse := AResponse;
end;

function TIPHTTPResponse.GetCharSet: string;
begin
  Result := FResponse.ContentCharSet;
end;

function TIPHTTPResponse.GetContentEncoding: string;
begin
  Result := FResponse.ContentEncoding;
end;

function TIPHTTPResponse.GetContentType: string;
var
  LSplitted: TArray<string>;
  LResultValues: TArray<string>;
  S: string;
begin
  Result := FResponse.MimeType;
  LSplitted := Result.Split([';']);
  // Remove charset
  for S in LSplitted do
    if not S.TrimLeft.StartsWith('charset', True) then // do not translate
      LResultValues := LResultValues + [S];
  if Length(LResultValues) <> Length(LSplitted) then
  begin
    Result := '';
    // Rebuild
    for S in LResultValues do
    begin
      if Result <> '' then
        Result := Result + ';';
      Result := Result + S;
    end;
  end;
end;

function TIPHTTPResponse.GetHeaders: TDSHTTP.IHeaderList;
begin
  Result := TIPResponseHeaderList.Create(FResponse);
end;

{ TIPProxyConnectionInfo }

function TIPProxyConnectionInfo.GetProxyPassword: string;
begin
  Result := FProxySettings.password;
end;

function TIPProxyConnectionInfo.GetProxyPort: Integer;
begin
  Result := FProxySettings.Port;
end;

function TIPProxyConnectionInfo.GetProxyServer: string;
begin
  Result := FProxySettings.Host;
end;

function TIPProxyConnectionInfo.GetProxyScheme: string;
begin
  Result := FProxySettings.Scheme;
end;

function TIPProxyConnectionInfo.GetProxyUserName: string;
begin
  Result := FProxySettings.UserName;
end;

procedure TIPProxyConnectionInfo.SetProxyPassword(pass: string);
begin
  FProxySettings.password := pass;
end;

procedure TIPProxyConnectionInfo.SetProxyPort(Val: Integer);
begin
  FProxySettings.Port := Val;
end;

procedure TIPProxyConnectionInfo.SetProxyServer(Val: string);
begin
  FProxySettings.Host := Val;
end;

procedure TIPProxyConnectionInfo.SetProxyScheme(Val: string);
begin
  FProxySettings.Scheme := Val;
end;

procedure TIPProxyConnectionInfo.SetProxyUserName(user: string);
begin
  FProxySettings.UserName := user;
end;

{ TIPResponseHeaderList }

destructor TIPResponseHeaderList.Destroy;
begin
  FStrings.Free;
  inherited;
end;

function TIPResponseHeaderList.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TIPResponseHeaderList.GetName(Index: Integer): string;
begin
  Result := FStrings.Names[Index];
end;

function TIPResponseHeaderList.GetValue(const Name: string): string;
begin
  Result := FStrings.Values[Name];
end;

constructor TIPResponseHeaderList.Create(const AResponse: IHTTPResponse);
begin
  FStrings := TStringList.Create;
  Populate(AResponse);
end;

procedure TIPResponseHeaderList.Populate(const AResponse: IHTTPResponse);
var
  LHeader: TNetHeader;
begin
  for LHeader in AResponse.Headers do
    FStrings.Values[LHeader.Name] := LHeader.Value;
end;

{ TIPRequestHeaderList }

function TIPRequestHeaderList.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TIPRequestHeaderList.GetName(Index: Integer): string;
begin
  Result := FStrings.Names[Index];
end;

function TIPRequestHeaderList.GetValue(const Name: string): string;
begin
  Result := FStrings.Values[Name];
end;

constructor TIPRequestHeaderList.Create(const AStrings: TStrings);
begin
  FStrings := AStrings;
end;

procedure TIPRequestHeaderList.Clear;
begin
  FStrings.Clear;
end;

procedure TIPRequestHeaderList.SetValue(const AName, AValue: string);
begin
  FStrings.Values[AName] := AValue;
end;

function TDSHTTP.GetProtocol: string;
begin
  Result := FProtocol;
end;

procedure TDSHTTP.SetProtocol(const protocol: string);
begin
  FProtocol := protocol;
end;

procedure TDSHTTP.Disconnect;
begin
  FIPHTTPRequestIntf.CustomHeaders.Values['Connection'] := 'close'
end;

{ TX509NetAdaptorCertificate }

procedure TX509NetWrapperCertificate.CheckValidity;
begin
  CheckValidity(Now);
end;

procedure TX509NetWrapperCertificate.CheckValidity(ADate: TDateTime);
begin
  if ADate > FExpiry then
    raise ECertificateExpiredException.Create(SCertExpired);

  if ADate < FStart then
    raise ECertificateNotYetValidException.Create(SCertNotYetValid);
end;

constructor TX509NetWrapperCertificate.Create(const ACert: System.Net.URLClient.TCertificate);
begin
  FExpiry := ACert.Expiry;
  FStart := ACert.Start;
  FSubject := ACert.Subject;
  FIssuer := ACert.Issuer;
  FProtocolName := ACert.ProtocolName;
  FAlgSignature := ACert.AlgSignature;
  FAlgEncryption := ACert.AlgEncryption;
  FKeySize := ACert.KeySize;
  FSubjectPrincipal := TX500NETPrincipal.Create(ACert.Subject);
  FIssuerPrincipal := TX500NETPrincipal.Create(ACert.Issuer);
  FPublicKey := TX509NETPublicKey.Create(FProtocolName, '');
end;

destructor TX509NetWrapperCertificate.Destroy;
begin
  FIssuerPrincipal.Free;
  FSubjectPrincipal.Free;
  FPublicKey.Free;
  inherited;
end;

function TX509NetWrapperCertificate.GetBasicConstraints: Integer;
begin
  Result := 0;
end;

function TX509NetWrapperCertificate.GetEncoded: TArray<Byte>;
begin
  Result := TBytes.Create();
end;

function TX509NetWrapperCertificate.GetIssuerX500Principal: TX500Principal;
begin
  Result := FIssuerPrincipal;
end;

function TX509NetWrapperCertificate.GetNotAfter: TDateTime;
begin
  Result := FExpiry;
end;

function TX509NetWrapperCertificate.GetNotBefore: TDateTime;
begin
  Result := FStart;
end;

function TX509NetWrapperCertificate.GetPublicKey: TPublicKey;
begin
  Result := FPublicKey;
end;

function TX509NetWrapperCertificate.GetSerialNumber: string;
begin
  Result := 'not available';
end;

function TX509NetWrapperCertificate.GetSigAlgName: string;
begin
  Result := FAlgEncryption;
end;

function TX509NetWrapperCertificate.GetSignature: string;
begin
  Result := FAlgSignature;
end;

function TX509NetWrapperCertificate.GetSubjectX500Principal: TX500Principal;
begin
  Result := FSubjectPrincipal;
end;

function TX509NetWrapperCertificate.GetVersion: Longint;
begin
  Result := 0;
end;

function TX509NetWrapperCertificate.Verify(key: TPublicKey): Boolean;
begin
  Result := True;
end;

{ TX500NETPrincipal }

constructor TX500NETPrincipal.Create(const AName: string);
begin
  FName := AName;
end;

function TX500NETPrincipal.GetEncoded: Longint;
begin
  Result := 0;
end;

function TX500NETPrincipal.GetName: string;
begin
  Result := FName;
end;

{ TX509NETPublicKey }

constructor TX509NETPublicKey.Create(const PKAlgorithm, PKFormat: string);
begin
  FAlgorithm := PKAlgorithm;
  FFormat := PKFormat;
end;

function TX509NETPublicKey.GetAlgorithm: string;
begin
  Result := FAlgorithm;
end;

function TX509NETPublicKey.GetEncoded: TArray<Byte>;
begin
  Result := TBytes.Create(); // FIdX509.EncodedKey;
end;

function TX509NETPublicKey.GetFormat: string;
begin
  Result := FFormat;
end;

{ EHTTPProtocolException }

constructor EHTTPProtocolException.Create(AErrorCode: Integer; const AErrorMessage: string; const AMessage: string);
begin
  FErrorCode := AErrorCode;
  FErrorMessage := AErrorMessage;
  inherited Create(AMessage);
end;

end.
