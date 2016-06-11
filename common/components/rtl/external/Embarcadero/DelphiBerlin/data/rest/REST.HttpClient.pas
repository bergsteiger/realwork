{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.HttpClient;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Net.HttpClient, IPPeerAPI,
  System.Net.UrlClient;

// TRESTHTTPProcs is implemented with IPPeerAPI.  So, IPPeerClient must be used by the application in order to register
// the actual IPPeerAPI.IIPPeerProcs implementation.
// Starting with XE8, TRESTHTTP is not implemented with IPPeerAPI.

type

  /// <summary>
  /// Exception with HTTP error information.
  /// </summary>
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


  /// <summary>HTTP utility methods</summary>
  TRESTHTTPProcs = class(TObject)
  private
    FPeerProcs: IIPPeerProcs;
    FImplementationID: string;
  public
    /// <summary>Create a class and identify the ID to access IPPeerProcs</summary>
    constructor Create(const AIPImplementationID: string = '');
    /// <summary>Create an object to manage multipart content</summary>
    class function CreateMultipartFormStream(const AIPImplementationID: string): IIPMultipartFormDataStream;
      overload; static;
    /// <summary>Make sure a URL is well formed.</summary>
    class function FixupURL(const AIPImplementationID: string; const AURL: string): string; overload;
    /// <summary>Format username and password into HTTP basic authentication string</summary>
    class function CreateBasicAuthenticationString(const AIPImplementationID: string;
      const AUserName, APassword: string): string; overload;
    /// <summary>Convert each character in a string to a hexidecimal representation</summary>
    class function HashStringAsHex(const AIPImplementationID: string; const AValue: string): string; overload;
    /// <summary>Calculate a cryptographic hash from string and key</summary>
    class function HashHMACSHA1(const AData, AKey: string): string; overload;

    /// <summary>Create an object to manage multipart content</summary>
    function CreateMultipartFormStream: IIPMultipartFormDataStream; overload;
    /// <summary>Make sure a URL is well formed.</summary>
    function FixupURL(const AURL: string): string; overload;
    /// <summary>Encode a URL escaping characters that are not allowed.</summary>
    function URLEncode(const AURL: string): string;
    /// <summary>Encode URL parameters by escaping characters that are not allowed</summary>
    function ParamsEncode(const AURL: string): string;
    /// <summary>Convert each character in a string to a hexidecimal representation</summary>
    function HashStringAsHex(const AValue: string): string; overload;
    /// <summary>Format username and password into HTTP basic authentication string</summary>
    function CreateBasicAuthenticationString(const AUserName, APassword: string): string; overload;
    /// <summary>Create a data structure that represents a URI</summary>
    function UriFromString(AUriString: string): IIPURI;
    /// <summary>Read a string from a stream, interpreting the bytes as a particular character set</summary>
    function ReadStringAsCharset(AStream: TStream; const ACharset: string): string;

  end;

  /// <summary>
  /// Provides HTTP client functionality
  /// </summary>
  TRESTHTTP = class(TObject)
  public type

    TValidateCertificateEvent = System.Net.UrlClient.TValidateCertificateEvent;

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

    end;

    /// <summary>Common interface for an URL response and all of it's related data</summary>
    IURLResponse = interface
      /// <summary>Function that transforms the ContentStream into a string</summary>
      function ContentAsString(const AnEncoding: TEncoding = nil): string;
    end;

    /// <summary>Properties of an HTTP response</summary>
    IResponse = interface(IURLResponse)
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
    FHTTPClient: System.Net.HTTPClient.THTTPClient;
    FHTTPResponse: IHTTPResponse;
    FIPHTTPRequestIntf: IRequest;
    FProxyConnectionInfo: TRESTHTTP.IProxyConnectionInfo;
    FOnValidateCertificate: TValidateCertificateEvent;
    function GetRequest: IRequest;
    function GetResponse: IResponse;
    function GetProxyParams: IProxyConnectionInfo;
    function GetResponseCode: Integer;
    function GetResponseText: string;
    function GetHandleRedirects: Boolean;
    procedure SetHandleRedirects(AValue: Boolean);
    function GetAllowCookies: Boolean;
    procedure SetAllowCookies(AValue: Boolean);
    function GetConnectTimeout: integer;
    procedure SetConnectTimeout(const Value: integer);
    function GetReadTimeout: integer;
    procedure SetReadTimeout(const Value: integer);
    procedure CheckResponse;
    procedure PrepareRequest(const ARequest: IHTTPRequest);
    procedure Execute(const AMethod: string; AURL: string; ASource,
      AResponseContent: TStream); overload;
    procedure Execute(const AMethod: string; AURL: string;
      AResponseContent: TStream); overload;
    procedure RaiseProtocolException(const AResponse: IHTTPResponse);
    procedure DoValidateServerCertificate(const Sender: TObject;
      const ARequest: TURLRequest; const Certificate: TCertificate;
      var Accepted: Boolean);
  public
    /// <summary>Create an HTTP client</summary>
    constructor Create;
    destructor Destroy; override;

    /// <summary>Execute HTTP DELETE</summary>
    procedure Delete(const AURL: string; AResponseStream: TStream);
    /// <summary>Execute HTTP PATCH</summary>
    procedure Patch(const AURL: string; ASource, AResponseContent: TStream);
    /// <summary>Execute HTTP PUT</summary>
    procedure Put(const AURL: string; ASource, AResponseContent: TStream);
    /// <summary>Execute HTTP POST</summary>
    procedure Post(const AURL: string; ASource, AResponseContent: TStream);
    /// <summary>Execute HTTP GET</summary>
    procedure Get(const AURL: string; AResponseContent: TStream);
    /// <summary>Add a cookie that will be passed to the server with each request</summary>
    procedure AddServerCookie(const ACookie: string; const AURL: string);
    /// <summary>Get the HTTP request properties</summary>
    property Request: IRequest read GetRequest;
    /// <summary>Get the HTTP response properties</summary>
    property Response: IResponse read GetResponse;
    /// <summary>Get the proxy server connection properties</summary>
    property ProxyParams: IProxyConnectionInfo read GetProxyParams;
    /// <summary>Get the HTTP status code of the last request</summary>
    property ResponseCode: Integer read GetResponseCode;
    /// <summary>Get the HTTP status test of the last request</summary>
    property ResponseText: string read GetResponseText;
    /// <summary>Indicate whether redirect responses are handled automatically by making an additional request.</summary>
    property HandleRedirects: Boolean read GetHandleRedirects write SetHandleRedirects;
    /// <summary>Allow the client to set server side cookies</summary>
    property AllowCookies: Boolean read GetAllowCookies write SetAllowCookies;
    /// <summary>Get or set the timeout when making an HTTP connection</summary>
    property ConnectTimeout: integer read GetConnectTimeout write SetConnectTimeout;
    /// <summary>Get or set the timeout when reading a HTTP response</summary>
    property ReadTimeout: integer read GetReadTimeout write SetReadTimeout;

    /// <summary>Validate the certificate provided by a secure (HTTPS) server</summary>
    property OnValidateCertificate: TValidateCertificateEvent read FOnValidateCertificate write FOnValidateCertificate;

  end;

implementation

uses
  System.Hash,
  System.NetEncoding;

resourcestring
  sUnsupportedProtocol = 'Unsupported protocol: %s';

type
  TIPHTTPRequest = class (TInterfacedObject, TRESTHTTP.IRequest)
  private
    FAccept: string;
    FAcceptCharSet: string;
    FUserAgent: string;
    FContentType: string;
    FAcceptEncoding: string;
    FCustomHeaders: TStrings;
    function GetAccept: string;
    procedure SetAccept(const Val: string);
    function GetAcceptCharSet: string;
    procedure SetAcceptCharSet(const Val: string);
    function GetCustomHeaders: TRESTHTTP.IRequestHeaderList;
    function GetAcceptEncoding: string;
    procedure SetAcceptEncoding(const Val: string);
    function GetContentType: string;
    procedure SetContentType(LContentType: string);
    function GetUserAgent: string;
    procedure SetUserAgent(const Val: string);
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TIPHTTPResponse = class (TInterfacedObject, TRESTHTTP.IResponse)
  private
    FResponse: IHTTPResponse;
    function GetCharSet: string;
    function GetContentType: string;
    function GetContentEncoding: string;
    function GetHeaders: TRESTHTTP.IHeaderList;
  public
    constructor Create(const AResponse: IHTTPResponse);

    /// <summary>Implementation of IURLResponse ContentAsString</summary>
    function ContentAsString(const AnEncoding: TEncoding = nil): string;
  end;

  TIPProxyConnectionInfo = class(TInterfacedObject,  TRESTHTTP.IProxyConnectionInfo)
  private
    FProxySettings: TProxySettings;
    procedure SetProxyPort(Val: Integer);
    function GetProxyPort: Integer;
    function GetProxyServer: string;
    procedure SetProxyServer(Val: string);
    function GetProxyUserName: string;
    procedure SetProxyUserName(user: string);
    function GetProxyPassword: string;
    procedure SetProxyPassword(pass: string);
  end;

  TIPResponseHeaderList = class(TInterfacedObject, TRESTHTTP.IHeaderList)
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

  TIPRequestHeaderList = class(TInterfacedObject, TRESTHTTP.IHeaderList, TRESTHTTP.IRequestHeaderList)
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

procedure TRESTHTTP.AddServerCookie(const ACookie, AURL: string);
begin
  if FHTTPClient.AllowCookies then
//    FHTTPClient.CookieManager.AddServerCookie(ACookie, AURL);
    ;       
end;

constructor TRESTHTTP.Create;
begin
  FHTTPClient := THTTPClient.Create;
  FHTTPClient.OnValidateServerCertificate := DoValidateServerCertificate;
  FIPHTTPRequestIntf := TIPHTTPRequest.Create; // Reference count
  AllowCookies := true;
end;

procedure TRESTHTTP.DoValidateServerCertificate(const Sender: TObject; const ARequest: TURLRequest; const Certificate: TCertificate; var Accepted: Boolean);
begin
  if Assigned(FOnValidateCertificate) then
    FOnValidateCertificate(Sender, ARequest, Certificate, Accepted)
  else
    // Accept by default
    Accepted := True;
end;

procedure TRESTHTTP.Delete(const AURL: string; AResponseStream: TStream);
begin
  Execute('DELETE', AURL, AResponseStream);
end;

destructor TRESTHTTP.Destroy;
begin
  FHTTPClient.Free;
  inherited;
end;

procedure TRESTHTTP.Get(const AURL: string; AResponseContent: TStream);
begin
  Execute('GET', AURL, AResponseContent);
end;

function TRESTHTTP.GetAllowCookies: Boolean;
begin
  Result := FHTTPClient.AllowCookies;
end;

function TRESTHTTP.GetConnectTimeout: integer;
begin
  Result := FHTTPClient.ConnectionTimeout;
end;

function TRESTHTTP.GetHandleRedirects: Boolean;
begin
  Result := FHTTPClient.HandleRedirects;
end;

function TRESTHTTP.GetProxyParams: IProxyConnectionInfo;
begin
  if FProxyConnectionInfo = nil then
    FProxyConnectionInfo := TIPProxyConnectionInfo.Create;
  Result := FProxyConnectionInfo;
end;

function TRESTHTTP.GetReadTimeout: integer;
begin
  Result := FHTTPClient.ResponseTimeout;
end;

function TRESTHTTP.GetRequest: IRequest;
begin
  Result := FIPHTTPRequestIntf;
end;

function TRESTHTTP.GetResponse: IResponse;
begin
  CheckResponse;
  Result := TIPHTTPResponse.Create(FHTTPResponse);
end;

procedure TRESTHTTP.CheckResponse;
begin
  if FHTTPResponse = nil then
    raise Exception.Create('No response');                         
end;

function TRESTHTTP.GetResponseCode: Integer;
begin
  CheckResponse;
  Result := FHTTPResponse.StatusCode;
end;

function TRESTHTTP.GetResponseText: string;
begin
  CheckResponse;
  Result := FHTTPResponse.StatusText;
end;

procedure TRESTHTTP.Patch(const AURL: string; ASource, AResponseContent: TStream);
begin
  Execute('PATCH', AURL, ASource, AResponseContent);
end;

procedure TRESTHTTP.SetAllowCookies(AValue: Boolean);
begin
  FHTTPClient.AllowCookies := AValue;
end;

procedure TRESTHTTP.SetConnectTimeout(const Value: integer);
begin
  FHTTPClient.ConnectionTimeout := Value;
end;

procedure TRESTHTTP.SetHandleRedirects(AValue: Boolean);
begin
  FHTTPClient.HandleRedirects := AValue;
end;

procedure TRESTHTTP.SetReadTimeout(const Value: integer);
begin
  FHTTPClient.ResponseTimeout := Value;
end;

procedure TRESTHTTP.PrepareRequest(const ARequest: IHTTPRequest);
var
  LIPRequest: TIPHTTPRequest;
  I: Integer;
begin
 if FProxyConnectionInfo <> nil then
   FHTTPClient.ProxySettings := TIPProxyConnectionInfo(FProxyConnectionInfo).FProxySettings;

 LIPRequest := TIPHTTPRequest(FIPHTTPRequestIntf);
 for I := 0 to LIPRequest.FCustomHeaders.Count - 1 do
 begin
   ARequest.AddHeader(LIPRequest.FCustomHeaders.Names[I],
     LIPRequest.FCustomHeaders.ValueFromIndex[I]);
 end;
 ARequest.Accept := LIPRequest.FAccept;
 ARequest.AcceptCharSet := LIPRequest.FAcceptCharSet;
 ARequest.UserAgent := LIPRequest.FUserAgent;
 if LIPRequest.FAcceptEncoding <> '' then
   ARequest.AcceptEncoding := LIPRequest.FAcceptEncoding;
 if LIPRequest.FContentType <> '' then
   ARequest.AddHeader('Content-type', LIPRequest.FContentType);
end;

procedure TRESTHTTP.RaiseProtocolException(const AResponse: IHTTPResponse);
const
  sHTTP10 = 'HTTP/1.0';
  sHTTP11 = 'HTTP/1.1';
  sHTTP20 = 'HTTP/2.0';
var
  LMessage: string;
begin
  case AResponse.Version of
    THTTPProtocolVersion.UNKNOWN_HTTP: LMessage := '';
    THTTPProtocolVersion.HTTP_1_0: LMessage := sHTTP10 + ' ';
    THTTPProtocolVersion.HTTP_1_1: LMessage := sHTTP11 + ' ';
    THTTPProtocolVersion.HTTP_2_0: LMessage := sHTTP20 + ' ';
  end;
  LMessage := LMessage + Format('%d %s', [AResponse.StatusCode, AResponse.StatusText]);
  raise EHTTPProtocolException.Create(AResponse.StatusCode, AResponse.ContentAsString,
    LMessage);
end;

procedure TRESTHTTP.Execute(const AMethod: string; AURL: string; ASource, AResponseContent: TStream);
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

procedure TRESTHTTP.Execute(const AMethod: string; AURL: string; AResponseContent: TStream);
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

procedure TRESTHTTP.Post(const AURL: string; ASource, AResponseContent: TStream);
begin
  Execute('POST', AURL, ASource, AResponseContent);
end;


procedure TRESTHTTP.Put(const AURL: string; ASource, AResponseContent: TStream);
begin
  Execute('PUT', AURL, ASource, AResponseContent);
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

function TIPHTTPRequest.GetCustomHeaders: TRESTHTTP.IRequestHeaderList;
begin
  Result := TIPRequestHeaderList.Create(FCustomHeaders);
end;

function TIPHTTPRequest.GetUserAgent: string;
begin
  Result := FUserAgent;
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

procedure TIPHTTPRequest.SetContentType(LContentType: string);
begin
  FContentType := LContentType;
end;

procedure TIPHTTPRequest.SetUserAgent(const Val: string);
begin
  FUserAgent := Val;
end;

{ TIPHTTPResponse }

function TIPHTTPResponse.ContentAsString(const AnEncoding: TEncoding = nil): string;
begin
  Result := FResponse.ContentAsString(AnEncoding);
end;

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

function TIPHTTPResponse.GetHeaders: TRESTHTTP.IHeaderList;
begin
  Result := TIPResponseHeaderList.Create(FResponse);
end;

{ TIPProxyConnectionInfo }

function TIPProxyConnectionInfo.GetProxyPassword: string;
begin
  Result := FProxySettings.Password;
end;

function TIPProxyConnectionInfo.GetProxyPort: Integer;
begin
  Result := FProxySettings.Port;
end;

function TIPProxyConnectionInfo.GetProxyServer: string;
begin
  Result := FProxySettings.Host;
end;

function TIPProxyConnectionInfo.GetProxyUserName: string;
begin
  Result := FProxySettings.UserName;
end;

procedure TIPProxyConnectionInfo.SetProxyPassword(pass: string);
begin
 FProxySettings.Password := pass;
end;

procedure TIPProxyConnectionInfo.SetProxyPort(Val: Integer);
begin
  FProxySettings.Port := Val;
end;

procedure TIPProxyConnectionInfo.SetProxyServer(Val: string);
begin
  FProxySettings.Host := Val;
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
  REsult := FStrings.Count;
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
  REsult := FStrings.Count;
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

{ TRESTProcs }

constructor TRESTHTTPProcs.Create(const AIPImplementationID: string);
begin
  FImplementationID := AIPImplementationID;
  FPeerProcs := IPProcs(AIPImplementationID);
end;

function TRESTHTTPProcs.ReadStringAsCharset(AStream: TStream; const ACharset: string): string;
begin
  Result := FPeerProcs.ReadStringAsCharset(AStream, ACharset);
end;

class function TRESTHTTPProcs.CreateBasicAuthenticationString(const AIPImplementationID: string; const AUserName, APassword: string): string;
var
  LBase64: TNetEncoding;
begin
  LBase64 := TBase64Encoding.Create(0, '');
  try
    Result := 'Basic ' + LBase64.Encode(AUsername + ':' + APassword);  // do not translate
  finally
    LBase64.Free;
  end;
end;

function TRESTHTTPProcs.CreateBasicAuthenticationString(const AUserName, APassword: string): string;
begin
  Result := TRESTHTTPProcs.CreateBasicAuthenticationString('', AUserName, APassword);
end;

class function TRESTHTTPProcs.CreateMultipartFormStream(const AIPImplementationID: string): IIPMultipartFormDataStream;
begin
  with TRESTHTTPProcs.Create(AIPImplementationID) do
  try
    Result := CreateMultipartFormStream;
  finally
    Free;
  end;
end;

function TRESTHTTPProcs.CreateMultipartFormStream: IIPMultipartFormDataStream;
begin
  Result := PeerFactory.CreatePeer(FImplementationID, IPPeerAPI.IIPMultipartFormDataStream)
    as IIPMultipartFormDataStream;
end;

/// <summary>
/// Clean up/fix the given URL. Add a possibly missing protocol (http is default), remove trailing white spaces.
/// Ensures no trailing slash exists.
/// </summary>
/// <example>
/// <see href="http://www.example.com">www.example.com</see> -&gt; <see href="http://www.example.com/" /><br />
/// <see href="http://www.example.com/some/path">www.example.com/some/path</see> -&gt;
/// <see href="http://www.example.com/some/path" />
/// </example>
function TRESTHTTPProcs.FixupURL(const AURL: string): string;
var
  LUri: IIPURI;
begin
  if trim(AURL) = '' then
    Result := ''
  else
  begin
    LUri := PeerFactory.CreatePeer(FImplementationID, IPPeerAPI.IIPURI) as IIPURI;
    LUri.URI := AURL;
    if LUri.GetProtocol = '' then
    begin
      LUri.URI := 'http://' + AURL;
    end;
    Result := trim(LUri.GetFullURI);
    // we don't want a trailing slash!
    if Result.Chars[Length(Result)-1] = '/' then
      System.Delete(Result, Length(Result), 1);
  end;
end;

class function TRESTHTTPProcs.FixupURL(const AIPImplementationID: string; const AURL: string): string;
begin
  with TRESTHTTPProcs.Create(AIPImplementationID) do
  try
    Result := FixupURL(AURL);
  finally
    Free;
  end;
end;

function TRESTHTTPProcs.UriFromString(AUriString: string): IIPURI;
begin
  Result := PeerFactory.CreatePeer(Self.FImplementationID, IPPeerAPI.IIPURI) as IIPURI;
  Result.URI := AUriString;
end;

function TRESTHTTPProcs.URLEncode(const AURL: string): string;
begin
  Result := FPeerProcs.URLEncode(AURL);
end;

function TRESTHTTPProcs.ParamsEncode(const AURL: string): string;
begin
  Result := FPeerProcs.ParamsEncode(AURL);
end;

class function TRESTHTTPProcs.HashStringAsHex(const AIPImplementationID, AValue: string): string;
begin
  Result := THashMD5.GetHashString(AValue);
end;

class function TRESTHTTPProcs.HashHMACSHA1(const AData, AKey: string): string;
begin
  Result := TNetEncoding.Base64.EncodeBytesToString(THashSHA1.GetHMACAsBytes(AData, AKey));
end;

function TRESTHTTPProcs.HashStringAsHex(const AValue: string): string;
begin
  Result := THashMD5.GetHashString(AValue);
end;

{ EHTTPProtocolException }

constructor  EHTTPProtocolException.Create(AErrorCode: Integer; const AErrorMessage: string; const AMessage: string);
begin
  FErrorCode := AErrorCode;
  FErrorMessage := AErrorMessage;
  inherited Create(AMessage);

end;

end.
