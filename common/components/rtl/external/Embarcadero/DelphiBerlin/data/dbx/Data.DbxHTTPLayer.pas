{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Data.DbxHTTPLayer;

interface

uses
  System.Classes,
  Data.DBXCommon,
  System.SysUtils;

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

  TDSHTTPClient = class;

  TDBXHTTPLayer = class(TDBXCommunicationLayer)
  protected
    FURITunnel: string;
    FSessionId: string;
    Fhttp: TDSHTTPClient;
    FIPImplementationID: string;

    procedure InitHTTPClient; virtual;
    function HTTPProtocol: string; virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Close; override;
    procedure Open(const DBXProperties: TDBXProperties); override;
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Info: string; override;
  end;

  TDBXHTTPSLayer = class(TDBXHTTPLayer)
  protected
    procedure InitHTTPClient; override;
    function HTTPProtocol: string; override;
  public
    procedure Open(const DBXProperties: TDBXProperties); override;
  end;

  TDSHTTPResponseStream = class;

  ///<summary>
  ///  Abstract HTTP client
  ///</summary>
  TDSHTTPClient = class
  protected
    function GetResponseCode: Integer; virtual; abstract;
    function GetResponseText: string; virtual; abstract;
  public
    function Post(AURL: string; ASource: TStrings): string; virtual; abstract;
    function Put(AURL: string; ASource: TStream): string; virtual; abstract;
    function Get(AURL: string): TDSHTTPResponseStream; virtual; abstract;
    procedure SetConnectTimeout(AMilisec: Integer); virtual;
    procedure SetReadTimeout(AMilisec: Integer); virtual;
    procedure SetBasicAuthentication(const user, password: string); virtual; abstract;
    property ResponseCode: Integer read GetResponseCode;
    property ResponseText: string read GetResponseText;
  end;

  ///<summary>
  ///  Abstract HTTP response stream
  ///</summary>
  TDSHTTPResponseStream = class
  protected
    function GetContentLength: Int64; virtual; abstract;
  public
    function Read(Buffer: TArray<Byte>; Count: Longint): Integer; virtual; abstract;
    procedure Close; virtual; abstract;
    property ContentLength: Int64 read GetContentLength;
  end;

implementation

uses
  System.JSON,
  System.TypInfo,
  System.Net.HTTPClient, System.Net.URLClient,
  Data.DBXClientResStrs,
  Data.DBXJSONReflect,
  Data.DBXTransport,
  Data.DBXCommonResStrs;

type
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

  TDSHTTPNativeResponseStream = class(TDSHTTPResponseStream)
  private
    FStream: TStream;
    FContentLength: Int64;
  protected
    function GetContentLength: Int64; override;
  public
    constructor Create(AContentLength: Integer; AStream: TStream);
    destructor Destroy; override;

    function Read(Buffer: TArray<Byte>; Count: Longint): Integer; override;
    procedure Close; override;
  end;

  TDSHTTPNativeClient = class(TDSHTTPClient)
  protected type
    /// <summary>Proxy server connection parameters</summary>
    IProxyConnectionInfo = interface
      /// <summary>Set the port of the proxy server</summary>
      procedure SetProxyPort(AValue: Integer);
      /// <summary>Get the port of the proxy server</summary>
      function GetProxyPort: Integer;
      /// <summary>Get or set the port of the proxy server</summary>
      property ProxyPort: Integer read GetProxyPort write SetProxyPort;
      /// <summary>Get the proxy server host name</summary>
      function GetProxyServer: string;
      /// <summary>Set the proxy server host name</summary>
      procedure SetProxyServer(const AValue: string);
      /// <summary>Get or set the proxy server host name</summary>
      property ProxyServer: string read GetProxyServer write SetProxyServer;
      /// <summary>Get the proxy server scheme</summary>
      function GetProxyScheme: string;
      /// <summary>Set the proxy server scheme</summary>
      procedure SetProxyScheme(const AValue: string);
      /// <summary>Get or set the proxy server scheme</summary>
      property ProxyScheme: string read GetProxyScheme write SetProxyScheme;
      /// <summary>Get a the username used to access the proxy server</summary>
      function GetProxyUserName: string;
      /// <summary>Set a the username used to access the proxy server</summary>
      procedure SetProxyUserName(const AUser: string);
      /// <summary>Get or set the username used to access the proxy server</summary>
      property ProxyUserName: string read GetProxyUserName write SetProxyUserName;
      /// <summary>Get the password used to access the proxy server</summary>
      function GetProxyPassword: string;
      /// <summary>Set the password used to access the proxy server</summary>
      procedure SetProxyPassword(const APass: string);
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
      procedure SetAccept(const AValue: string);
      /// <summary>Get or set the HTTP request accept string</summary>
      property Accept: string read GetAccept write SetAccept;
      /// <summary>Get the HTTP request charset string</summary>
      function GetAcceptCharSet: string;
      /// <summary>Set the HTTP request charset string</summary>
      procedure SetAcceptCharSet(const AValue: string);
      /// <summary>Get or set the HTTP request charset string</summary>
      property AcceptCharSet: string read GetAcceptCharSet write SetAcceptCharSet;
      /// <summary>Get the HTTP request custom headers.</summary>
      function GetCustomHeaders: IRequestHeaderList;
      /// <summary>Get the HTTP request custom headers.</summary>
      property CustomHeaders: IRequestHeaderList read GetCustomHeaders;
      /// <summary>Get the HTTP request acceptencoding string</summary>
      function GetAcceptEncoding: string;
      /// <summary>Set the HTTP request acceptencoding string</summary>
      procedure SetAcceptEncoding(const AValue: string);
      /// <summary>Get or set the HTTP request acceptencoding string</summary>
      property AcceptEncoding: string read GetAcceptEncoding write SetAcceptEncoding;
      /// <summary>Get the HTTP request contenttype string</summary>
      function GetContentType: string;
      /// <summary>Set the HTTP request contenttype string</summary>
      procedure SetContentType(const AContentType: string);
      /// <summary>Get or set the HTTP request contenttype string</summary>
      property ContentType: string read GetContentType write SetContentType;
      /// <summary>Get the HTTP request useragent string</summary>
      function GetUserAgent: string;
      /// <summary>Set the HTTP request useragent string</summary>
      procedure SetUserAgent(const AValue: string);
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

    TIPProxyConnectionInfo = class(TInterfacedObject, IProxyConnectionInfo)
    private
      FProxySettings: TProxySettings;
      procedure SetProxyPort(AValue: Integer);
      function GetProxyPort: Integer;
      function GetProxyServer: string;
      procedure SetProxyServer(const AValue: string);
      function GetProxyScheme: string;
      procedure SetProxyScheme(const AValue: string);
      function GetProxyUserName: string;
      procedure SetProxyUserName(const AUser: string);
      function GetProxyPassword: string;
      procedure SetProxyPassword(const APass: string);
    end;

    TIPRequestHeaderList = class(TInterfacedObject, IHeaderList, IRequestHeaderList)
    private
      FStrings: TStrings;
      function GetCount: Integer;
      function GetName(AIndex: Integer): string;
      function GetValue(const AName: string): string;
      procedure Clear;
      procedure SetValue(const AName, AValue: string);
    public
      constructor Create(const AStrings: TStrings);
    end;

    TIPResponseHeaderList = class(TInterfacedObject, IHeaderList)
    private
      FStrings: TStrings;
      function GetCount: Integer;
      function GetName(Index: Integer): string;
      function GetValue(const AName: string): string;
      procedure Populate(const AResponse: IHTTPResponse);
    public
      constructor Create(const AResponse: IHTTPResponse);
      destructor Destroy; override;
    end;

    TIPHTTPRequest = class(TInterfacedObject, IRequest)
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
      procedure SetAccept(const AValue: string);
      function GetAcceptCharSet: string;
      procedure SetAcceptCharSet(const AValue: string);
      function GetCustomHeaders: IRequestHeaderList;
      function GetAcceptEncoding: string;
      procedure SetAcceptEncoding(const AValue: string);
      function GetContentType: string;
      procedure SetContentType(const AContentType: string);
      function GetUserAgent: string;
      procedure SetUserAgent(const AValue: string);
      function GetUserName: string;
      function GetPassword: string;
      procedure SetAuthentication(const AUserName, APassword: string);
    public
      constructor Create;
      destructor Destroy; override;
    end;

    TIPHTTPResponse = class(TInterfacedObject, IResponse)
    private
      FResponse: IHTTPResponse;
      function GetCharSet: string;
      function GetContentType: string;
      function GetContentEncoding: string;
      function GetHeaders: IHeaderList;
    public
      constructor Create(const AResponse: IHTTPResponse);
    end;
  protected
    FHTTPClient: THTTPClient;
    FHTTPResponse: IHTTPResponse;
    FIPHTTPRequestIntf: IRequest;
    FProxyConnectionInfo: IProxyConnectionInfo;
    FOnValidateCertificate: TValidateCertificateEvent;
    FOnValidatePeerCertificate: TValidateCertificate;
    FOnValidatePeerCertificateErr: TValidateCertificateErr;

    function GetRequest: IRequest;
    function GetResponse: IResponse;
    function GetProxyParams: IProxyConnectionInfo;
    procedure CheckResponse;
    function GetResponseCode: Integer; override;
    function GetResponseText: string; override;
    procedure PrepareRequest(const ARequest: IHTTPRequest);
    procedure Execute(const AMethod, AURL: string; const ASource, AResponseContent: TStream); overload;
    procedure Execute(const AMethod, AURL: string; const AResponseContent: TStream); overload;
    procedure DoValidateServerCertificate(const ASender: TObject; const ARequest: TURLRequest;
      const ACertificate: TCertificate; var Accepted: Boolean);
    procedure RaiseProtocolException(const AResponse: IHTTPResponse);
  public
    constructor Create(const AIPImplementationID: string); virtual;
    destructor Destroy; override;
    function Post(AURL: string; ASource: TStrings): string; override;
    function Put(AURL: string; ASource: TStream): string; override;
    function Get(AURL: string): TDSHTTPResponseStream; override;
    procedure SetConnectTimeout(AMilisec: Integer); override;
    procedure SetReadTimeout(AMilisec: Integer); override;
    procedure SetBasicAuthentication(const AUser, APassword: string); override;

    /// <summary>Get the HTTP request properties</summary>
    property Request: IRequest read GetRequest;
    property Response: IResponse read GetResponse;

    /// <summary>Get the proxy server connection properties</summary>
    property ProxyParams: IProxyConnectionInfo read GetProxyParams;

    /// <summary>Event is fired when errors exist in the SSL certificates, that require user validation </summary>
    property OnValidateCertificate: TValidateCertificateEvent read FOnValidateCertificate write FOnValidateCertificate;
    // for backward compatibility
    /// <summary>Event is fired when errors exist in the SSL certificates, that require user validation </summary>
    property OnValidatePeerCertificate: TValidateCertificate read FOnValidatePeerCertificate write FOnValidatePeerCertificate;
    /// <summary>Event is fired when errors exist in the SSL certificates, that require user validation </summary>
    property OnValidatePeerCertificateErr: TValidateCertificateErr read FOnValidatePeerCertificateErr write FOnValidatePeerCertificateErr;
  end;

  TDSHTTPSNativeClient = class(TDSHTTPNativeClient)
  strict private
    FValidateCertificate: TValidateCertificate;
  public
    constructor Create(const AIPImplementationID: string); override;
    procedure SetPeerCertificateValidation(UserValidation: TValidateCertificate); virtual;
  end;

{ TIPProxyConnectionInfo }

function TDSHTTPNativeClient.TIPProxyConnectionInfo.GetProxyPassword: string;
begin
  Result := FProxySettings.password;
end;

function TDSHTTPNativeClient.TIPProxyConnectionInfo.GetProxyPort: Integer;
begin
  Result := FProxySettings.Port;
end;

function TDSHTTPNativeClient.TIPProxyConnectionInfo.GetProxyServer: string;
begin
  Result := FProxySettings.Host;
end;

function TDSHTTPNativeClient.TIPProxyConnectionInfo.GetProxyScheme: string;
begin
  Result := FProxySettings.Scheme;
end;

function TDSHTTPNativeClient.TIPProxyConnectionInfo.GetProxyUserName: string;
begin
  Result := FProxySettings.UserName;
end;

procedure TDSHTTPNativeClient.TIPProxyConnectionInfo.SetProxyPassword(const APass: string);
begin
  FProxySettings.password := APass;
end;

procedure TDSHTTPNativeClient.TIPProxyConnectionInfo.SetProxyPort(AValue: Integer);
begin
  FProxySettings.Port := AValue;
end;

procedure TDSHTTPNativeClient.TIPProxyConnectionInfo.SetProxyServer(const AValue: string);
begin
  FProxySettings.Host := AValue;
end;

procedure TDSHTTPNativeClient.TIPProxyConnectionInfo.SetProxyScheme(const AValue: string);
begin
  FProxySettings.Scheme := AValue;
end;

procedure TDSHTTPNativeClient.TIPProxyConnectionInfo.SetProxyUserName(const AUser: string);
begin
  FProxySettings.UserName := AUser;
end;

{ TIPRequestHeaderList }

function TDSHTTPNativeClient.TIPRequestHeaderList.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TDSHTTPNativeClient.TIPRequestHeaderList.GetName(AIndex: Integer): string;
begin
  Result := FStrings.Names[AIndex];
end;

function TDSHTTPNativeClient.TIPRequestHeaderList.GetValue(const AName: string): string;
begin
  Result := FStrings.Values[AName];
end;

constructor TDSHTTPNativeClient.TIPRequestHeaderList.Create(const AStrings: TStrings);
begin
  FStrings := AStrings;
end;

procedure TDSHTTPNativeClient.TIPRequestHeaderList.Clear;
begin
  FStrings.Clear;
end;

procedure TDSHTTPNativeClient.TIPRequestHeaderList.SetValue(const AName, AValue: string);
begin
  FStrings.Values[AName] := AValue;
end;

{ TIPResponseHeaderList }

destructor TDSHTTPNativeClient.TIPResponseHeaderList.Destroy;
begin
  FStrings.Free;
  inherited;
end;

function TDSHTTPNativeClient.TIPResponseHeaderList.GetCount: Integer;
begin
  Result := FStrings.Count;
end;

function TDSHTTPNativeClient.TIPResponseHeaderList.GetName(Index: Integer): string;
begin
  Result := FStrings.Names[Index];
end;

function TDSHTTPNativeClient.TIPResponseHeaderList.GetValue(const AName: string): string;
begin
  Result := FStrings.Values[AName];
end;

constructor TDSHTTPNativeClient.TIPResponseHeaderList.Create(const AResponse: IHTTPResponse);
begin
  FStrings := TStringList.Create;
  Populate(AResponse);
end;

procedure TDSHTTPNativeClient.TIPResponseHeaderList.Populate(const AResponse: IHTTPResponse);
var
  LHeader: TNetHeader;
begin
  for LHeader in AResponse.Headers do
    FStrings.Values[LHeader.Name] := LHeader.Value;
end;

{ TIPHTTPRequest }

constructor TDSHTTPNativeClient.TIPHTTPRequest.Create;
begin
  FCustomHeaders := TStringList.Create;
end;

destructor TDSHTTPNativeClient.TIPHTTPRequest.Destroy;
begin
  FCustomHeaders.Free;
  inherited;
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetAccept: string;
begin
  Result := FAccept;
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetAcceptCharSet: string;
begin
  Result := FAcceptCharSet;
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetAcceptEncoding: string;
begin
  Result := FAcceptEncoding;
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetContentType: string;
begin
  Result := FContentType;
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetCustomHeaders: IRequestHeaderList;
begin
  Result := TIPRequestHeaderList.Create(FCustomHeaders);
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetPassword: string;
begin
  Result := FPassword;
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetUserAgent: string;
begin
  Result := FUserAgent;
end;

function TDSHTTPNativeClient.TIPHTTPRequest.GetUserName: string;
begin
  Result := FUserName;
end;

procedure TDSHTTPNativeClient.TIPHTTPRequest.SetAccept(const AValue: string);
begin
  FAccept := AValue;
end;

procedure TDSHTTPNativeClient.TIPHTTPRequest.SetAcceptCharSet(const AValue: string);
begin
  FAcceptCharSet := AValue;
end;

procedure TDSHTTPNativeClient.TIPHTTPRequest.SetAcceptEncoding(const AValue: string);
begin
  FAcceptEncoding := AValue;
end;

procedure TDSHTTPNativeClient.TIPHTTPRequest.SetAuthentication(const AUserName, APassword: string);
begin
  if AUserName <> emptystr then
  begin
    FUserName := AUserName;
    FPassword := APassword;
  end;
end;

procedure TDSHTTPNativeClient.TIPHTTPRequest.SetContentType(const AContentType: string);
begin
  FContentType := AContentType;
end;

procedure TDSHTTPNativeClient.TIPHTTPRequest.SetUserAgent(const AValue: string);
begin
  FUserAgent := AValue;
end;

{ TIPHTTPResponse }

constructor TDSHTTPNativeClient.TIPHTTPResponse.Create(const AResponse: IHTTPResponse);
begin
  FResponse := AResponse;
end;

function TDSHTTPNativeClient.TIPHTTPResponse.GetCharSet: string;
begin
  Result := FResponse.ContentCharSet;
end;

function TDSHTTPNativeClient.TIPHTTPResponse.GetContentEncoding: string;
begin
  Result := FResponse.ContentEncoding;
end;

function TDSHTTPNativeClient.TIPHTTPResponse.GetContentType: string;
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

function TDSHTTPNativeClient.TIPHTTPResponse.GetHeaders: IHeaderList;
begin
  Result := TIPResponseHeaderList.Create(FResponse);
end;

{TDBXHTTPLayer}

constructor TDBXHTTPLayer.Create;
begin
  inherited;
  FSessionId := '0';
  InitHTTPClient;
end;

destructor TDBXHTTPLayer.Destroy;
begin
  Close;
  FreeAndNil(Fhttp);
end;

function TDBXHTTPLayer.HTTPProtocol: string;
begin
  Result := 'http';
end;

procedure TDBXHTTPLayer.Close;
var
  RParams: TStringList;
begin
  if FSessionId <> '0' then
  begin
    RParams := TStringList.Create;
    RParams.Values['dss'] := '-' + FSessionId;
    try
      try
        Fhttp.Post(FURITunnel + '?dss=' + FSessionId, RParams);
      except
        // ignore
      end;
    finally
      RParams.Free;
    end;
    FSessionId := '0';
  end;
end;

procedure TDBXHTTPLayer.Open(const DBXProperties: TDBXProperties);
var
  LDatasnapPath, LPath, LProxyHost, LProxyPassword, LProxyUsername: string;
  Password, Scheme, Timeout, User: string;
  LProxyPort: Integer;
  LURI: TURI;
begin
  Close;
  FIPImplementationID := DbxProperties[TDBXPropertyNames.IPImplementationID];

  LPath := DBXProperties[TDBXPropertyNames.URLPath];
  if LPath <> '' then
    LPath := LPath + '/';
  LDatasnapPath := DBXProperties[TDBXPropertyNames.DatasnapContext];
  Assert(LDatasnapPath.Length > 0);
  if LDatasnapPath = '/' then
    LDatasnapPath := EmptyStr
  else if (LDatasnapPath.Chars[LDatasnapPath.Length - 1] <> '/') then
      LDatasnapPath := LDatasnapPath + '/';

  LURI.ComposeURI(HTTPProtocol, '', '', DBXProperties[TDBXPropertyNames.HostName],
    DBXProperties[TDBXPropertyNames.Port].ToInteger, '/'+LPath+LDatasnapPath+'tunnel', [], '');
  FURITunnel := LURI.ToString;

  //set up HTTP proxy
  LProxyHost := DBXProperties[TDBXPropertyNames.DSProxyHost].Trim;
  if LProxyHost <> '' then
  begin
    LProxyPort := StrToIntDef(DBXProperties.Values[TDBXPropertyNames.DSProxyPort], 8888);
    if LProxyPort > 0 then
    begin
      LProxyUsername := DBXProperties[TDBXPropertyNames.DSProxyUsername];
      LProxyPassword := DBXProperties[TDBXPropertyNames.DSProxyPassword];
      TDSHTTPNativeClient(Fhttp).ProxyParams.ProxyServer := LProxyHost;
      TDSHTTPNativeClient(Fhttp).ProxyParams.ProxyPort := LProxyPort;
      TDSHTTPNativeClient(Fhttp).ProxyParams.ProxyUserName := LProxyUsername;
      TDSHTTPNativeClient(Fhttp).ProxyParams.ProxyPassword := LProxyPassword;
      TDSHTTPNativeClient(Fhttp).ProxyParams.ProxyScheme := DBXProperties[TDBXPropertyNames.CommunicationProtocol];
    end;
  end;

  FSessionId := '0';
  Scheme := DbxProperties[TDBXPropertyNames.DSAuthenticationScheme];
  if SameText(Scheme, 'basic') then
  begin
    // Make user/password available in the HTTP headers, in addition
    // to the DBX connection string.  Allows a inter-process DataSnap
    // HTTP tunnel server to authenticate the user.
    User := DBXProperties[TDBXPropertyNames.DSAuthenticationUser];
    Password := DBXProperties[TDBXPropertyNames.DSAuthenticationPassword];
    if (User <> '') then
      Fhttp.SetBasicAuthentication(User, Password);
  end;

  Timeout := DbxProperties[TDBXPropertyNames.ConnectTimeout];
  if Timeout = '' then
    ConnectTimeout := 0
  else
  begin
    ConnectTimeout := StrToInt(Timeout);
    if ConnectTimeout < 0 then
      ConnectTimeout := 0
    else
      Fhttp.SetConnectTimeout(ConnectTimeout);
  end;
  Timeout := DbxProperties[TDBXPropertyNames.CommunicationTimeout];
  if Timeout = '' then
    CommunicationTimeout := 0
  else
  begin
    CommunicationTimeout := StrToInt(Timeout);
    if CommunicationTimeout < 0 then
      CommunicationTimeout := 0
    else
      Fhttp.SetReadTimeout(CommunicationTimeout);
  end
end;

function TDBXHTTPLayer.Write(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
var
  MemStream: TDBXBytesStream;
  StrData: string;
  JSONRes: TJSONObject;
  JSONParams: TJSONArray;
  Len: Integer;
begin
  Assert(Offset = 0);
  MemStream := TDBXBytesStream.Create(Buffer, Count);

  Result := 0;
  try
    try
      // send the query string with session and count
      StrData := Fhttp.Put(FURITunnel + '?dss=' + FSessionId + '&c=' + IntToStr(Count),
                                        MemStream);
    except
      on ex: Exception do
        Exception.RaiseOuterException(TDBXError.Create(ex.Message));
    end;

    // parse the response, populate the session id and result
    if Fhttp.ResponseCode = 200 then
    begin
      JSONRes := TJSONObject(TJSONObject.ParseJSONValue(BytesOf(StrData), 0));
      if JSONRes = nil then
        raise TDBXError.Create(Format(SProtocolErrorJSON, [StrData]));

      try
        if JSONRes.Pairs[0].JsonString.Value = 'error' then
          raise TDBXError.Create(TJSONString(JSONRes.Pairs[0].JsonValue).Value);

        // session id
        JSONParams := TJSONArray(JSONRes.Pairs[0].JsonValue);
        FSessionId := TJSONString(JSONParams.Items[0]).Value;

        // bytes written
        Len := StrToInt(TJSONNumber(JSONParams.Items[1]).Value);
        if Len < Count then
          raise TDBXError.Create(Format(SProtocolErrorWrite, [Count, Len]));

      finally
        JSONRes.Free;
      end;
    end
    else
      raise TDBXError.Create(Fhttp.ResponseText);

  finally
    MemStream.Free;
  end;
end;

function TDBXHTTPLayer.Read(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
var
  ResponseStream: TDSHTTPResponseStream;
begin
  Assert(Offset = 0);
  Result := 0;
  ResponseStream := nil;

  try
    // send session and count
    ResponseStream := Fhttp.Get(FURITunnel + '?dss=' + FSessionId + '&c=' + IntToStr(Count));
  except
    on ex: Exception do
      Exception.RaiseOuterException(TDBXError.Create(ex.Message));
  end;
  if ResponseStream <> nil then
    try
      // read from the stream the number of bytes (compare with response size)
      if ResponseStream.ContentLength > Count then
        raise TDBXError.Create(Format(SProtocolErrorSize, [ResponseStream, Count]));
      Result := ResponseStream.Read(Buffer, ResponseStream.ContentLength);
    finally
      try
        ResponseStream.Close;
      finally
        ResponseStream.Free;
    end;
  end;
end;

function TDBXHTTPLayer.Info: string;
begin
  Result := FURITunnel;
end;

procedure TDBXHTTPLayer.InitHTTPClient;
begin
  Fhttp := TDSHTTPNativeClient.Create(FIPImplementationID);
  TDSHTTPNativeClient(Fhttp).Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,/;q=0.8';
  TDSHTTPNativeClient(Fhttp).Request.AcceptEncoding := 'identity';
end;

constructor TDSHTTPNativeClient.Create(const AIPImplementationID: string);
begin
  inherited Create;
  FHTTPClient := THTTPClient.Create;
  FHTTPClient.OnValidateServerCertificate := DoValidateServerCertificate;
  FIPHTTPRequestIntf := TIPHTTPRequest.Create; // Reference count
end;

destructor TDSHTTPNativeClient.Destroy;
begin
  FHTTPClient.Free;
  inherited;
end;

procedure TDSHTTPNativeClient.Execute(const AMethod, AURL: string; const AResponseContent: TStream);
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

procedure TDSHTTPNativeClient.DoValidateServerCertificate(const ASender: TObject; const ARequest: TURLRequest;
  const ACertificate: TCertificate; var Accepted: Boolean);
var
  X509Cert: TX509Certificate;
begin
  if Assigned(FOnValidateCertificate) then
    FOnValidateCertificate(ASender, ARequest, ACertificate, Accepted)
  else if Assigned(FOnValidatePeerCertificate) then
  begin
    X509Cert := TX509NetWrapperCertificate.Create(ACertificate);
    try
      FOnValidatePeerCertificate(ASender, X509cert, 0, Accepted)
    finally
     X509Cert.Free;
    end;
  end
  else if Assigned(FOnValidatePeerCertificateErr) then
  begin
    X509Cert := TX509NetWrapperCertificate.Create(ACertificate);
    try
      FOnValidatePeerCertificateErr(ASender, X509cert, 0, 0, Accepted)
    finally
      X509Cert.Free;
    end;
  end
  else
    // Accept by default
    Accepted := True;
end;

procedure TDSHTTPNativeClient.Execute(const AMethod, AURL: string; const ASource, AResponseContent: TStream);
var
  LRequest: IHTTPRequest;
  LResponse: IHTTPResponse;
begin
  LRequest := FHTTPClient.GetRequest(AMethod, AURL);
  PrepareRequest(LRequest);   // Problem with FIPHTTPRequestIntf, not initialized
  ASource.Seek(Longint(0), soFromBeginning);
  LRequest.SourceStream := ASource;
  LResponse := FHTTPClient.Execute(LRequest, AResponseContent);
  FHTTPResponse := LResponse;
  if LResponse.StatusCode >= 300 then
    RaiseProtocolException(LResponse);
end;

function TDSHTTPNativeClient.Get(AURL: string): TDSHTTPResponseStream;
var
  Data: TStream;
begin
  Data := TMemoryStream.Create;
  try
    Execute('GET', AURL, Data);
    Data.Position := 0;
    Result := TDSHTTPNativeResponseStream.Create(Data.Size, Data);
    Data := nil;
  except
    Data.Free;
    raise;
  end;
end;

function TDSHTTPNativeClient.GetRequest: IRequest;
begin
  Result := FIPHTTPRequestIntf;
end;

function TDSHTTPNativeClient.GetResponse: IResponse;
begin
  CheckResponse;
  Result := TIPHTTPResponse.Create(FHTTPResponse);
end;

function TDSHTTPNativeClient.GetProxyParams: IProxyConnectionInfo;
begin
  if FProxyConnectionInfo = nil then
    FProxyConnectionInfo := TIPProxyConnectionInfo.Create;
  Result := FProxyConnectionInfo;
end;

procedure TDSHTTPNativeClient.CheckResponse;
begin
  if FHTTPResponse = nil then
    raise Exception.Create(sResponseObjectNotFound);
end;

function TDSHTTPNativeClient.GetResponseCode: Integer;
begin
  CheckResponse;
  Result := FHTTPResponse.StatusCode;
end;

function TDSHTTPNativeClient.GetResponseText: string;
begin
  CheckResponse;
  Result := FHTTPResponse.StatusText;
end;

function TDSHTTPNativeClient.Post(AURL: string; ASource: TStrings): string;
var
  LSource: TStream;
begin
  LSource := TMemoryStream.Create;
  try
    ASource.SaveToStream(LSource);
    Execute('POST', AURL, LSource, nil);
    Result := FHTTPResponse.ContentAsString;
  finally
    LSource.Free;
  end;
end;

procedure TDSHTTPNativeClient.PrepareRequest(const ARequest: IHTTPRequest);
var
  LIPRequest: TIPHTTPRequest;
  I: Integer;
begin
  if FProxyConnectionInfo <> nil then
    FHTTPClient.ProxySettings := TIPProxyConnectionInfo(FProxyConnectionInfo).FProxySettings;

  LIPRequest := TIPHTTPRequest(FIPHTTPRequestIntf);
  for I := 0 to LIPRequest.FCustomHeaders.Count - 1 do
    ARequest.AddHeader(LIPRequest.FCustomHeaders.Names[I], LIPRequest.FCustomHeaders.ValueFromIndex[I]);

  if LIPRequest.FAccept <> '' then
    ARequest.Accept := LIPRequest.FAccept;
  if LIPRequest.FAcceptCharSet <> '' then
    ARequest.AcceptCharSet := LIPRequest.FAcceptCharSet;
  if LIPRequest.FUserAgent <> '' then
    ARequest.UserAgent := LIPRequest.FUserAgent;
  if LIPRequest.FAcceptEncoding <> '' then
    ARequest.AcceptEncoding := LIPRequest.FAcceptEncoding;
  if LIPRequest.FContentType <> '' then
    ARequest.AddHeader('Content-type', LIPRequest.FContentType);
  if LIPRequest.FUserName <> '' then
    ARequest.SetCredential(LIPRequest.FUserName, LIPRequest.FPassword);
end;

function TDSHTTPNativeClient.Put(AURL: string; ASource: TStream): string;
begin
  try
    Execute('PUT', AURL, ASource, nil);
    Result := FHTTPResponse.ContentAsString;
  except
    raise
  end;
end;

procedure TDSHTTPNativeClient.RaiseProtocolException(const AResponse: IHTTPResponse);
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

procedure TDSHTTPNativeClient.SetBasicAuthentication(const AUser, APassword: string);
begin
  FHTTPClient.CredentialsStorage.AddCredential(
    TCredentialsStorage.TCredential.Create(TAuthTargetType.Server, '', '', AUser, APassword));
end;

procedure TDSHTTPNativeClient.SetConnectTimeout(AMilisec: Integer);
begin
                                     
  raise ENotImplemented.Create('SetConnectTimeout');
end;

procedure TDSHTTPNativeClient.SetReadTimeout(AMilisec: Integer);
begin
                                     
  raise ENotImplemented.Create('SetReadTimeout');
end;

{ TDSHTTPNativeResponseStream }

procedure TDSHTTPNativeResponseStream.Close;
begin
  // Do nothing
end;

constructor TDSHTTPNativeResponseStream.Create(AContentLength: Integer; AStream: TStream);
begin
  FStream := AStream;
  FContentLength := AContentLength;
end;

destructor TDSHTTPNativeResponseStream.Destroy;
begin
  FreeAndNil(FStream);
end;

function TDSHTTPNativeResponseStream.GetContentLength: Int64;
begin
  Result := FContentLength;
end;

function TDSHTTPNativeResponseStream.Read(Buffer: TArray<Byte>;
  Count: Longint): Integer;
begin
  Result := FStream.Read(Buffer[0], Count);
end;

{ TDBXHTTPSLayer }

function TDBXHTTPSLayer.HTTPProtocol: string;
begin
  Result := 'https';
end;

procedure TDBXHTTPSLayer.InitHTTPClient;
begin
  Fhttp := TDSHTTPSNativeClient.Create(FIPImplementationID);
  TDSHTTPNativeClient(Fhttp).Request.Accept := 'text/html,application/xhtml+xml,application/xml;q=0.9,/;q=0.8';
  TDSHTTPNativeClient(Fhttp).Request.AcceptEncoding := 'identity';
end;

procedure TDBXHTTPSLayer.Open(const DBXProperties: TDBXProperties);
var
  Proc: TEventPointer;
begin
  inherited;

  Proc := DBXProperties.Events.Events[sValidatePeerCertificate];
  if Assigned(Proc) then
    TDSHTTPSNativeClient(Fhttp).SetPeerCertificateValidation(TValidateCertificate(Proc));
end;

{ TDSHTTPSNativeClient }

constructor TDSHTTPSNativeClient.Create(const AIPImplementationID: string);
begin
  inherited Create(AIPImplementationID);

  FValidateCertificate := nil;
end;

procedure TDSHTTPSNativeClient.SetPeerCertificateValidation(
  UserValidation: TValidateCertificate);
begin
  FValidateCertificate := UserValidation;
end;

{ TDSHTTPClient }

procedure TDSHTTPClient.SetConnectTimeout(AMilisec: Integer);
begin
  // do nothing here
end;

procedure TDSHTTPClient.SetReadTimeout(AMilisec: Integer);
begin
  //do nothing here
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

constructor EHTTPProtocolException.Create(AErrorCode: Integer; const AErrorMessage, AMessage: string);
begin
  FErrorCode := AErrorCode;
  FErrorMessage := AErrorMessage;
  inherited Create(AMessage);
end;

initialization
  TDBXCommunicationLayerFactory.RegisterLayer('http', TDBXHTTPLayer);
  TDBXCommunicationLayerFactory.RegisterLayer('https', TDBXHTTPSLayer);

finalization
  TDBXCommunicationLayerFactory.UnregisterLayer('http');
  TDBXCommunicationLayerFactory.UnregisterLayer('https');

end.

