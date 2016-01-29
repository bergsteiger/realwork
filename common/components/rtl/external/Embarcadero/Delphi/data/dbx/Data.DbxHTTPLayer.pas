{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Data.DbxHTTPLayer"'}    {Do not Localize}
unit Data.DbxHTTPLayer;

interface

uses
  System.Classes,
  Data.DBXCommon,
  System.SysUtils;

type

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
  System.TypInfo,
  Data.DBXCommonIndy,
  IPPeerAPI,
  Data.DBXClientResStrs,
  Data.DBXJSON,
  Data.DBXJSONReflect,
  Data.DBXTransport;

type
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
  protected
   FHttp: IIPHTTP;
   FAuthentication: IIPAuthentication;
   FIPImplementationID: string;
  protected
    function GetResponseCode: Integer; override;
    function GetResponseText: string; override;
  public
    constructor Create(const AIPImplementationID: string); virtual;
    destructor Destroy; override;
    function Post(AURL: string; ASource: TStrings): string; override;
    function Put(AURL: string; ASource: TStream): string; override;
    function Get(AURL: string): TDSHTTPResponseStream; override;
    procedure SetConnectTimeout(AMilisec: Integer); override;
    procedure SetReadTimeout(AMilisec: Integer); override;
    procedure SetBasicAuthentication(const user, password: string); override;
  end;

  TDSHTTPSNativeClient = class(TDSHTTPNativeClient)
  strict private
    FValidateCertificate: TValidateCertificate;
  protected
    function IdValidateCertificate(Certificate: IIPX509; AOk: Boolean; ADepth, AError: Integer): Boolean;
  public
    constructor Create(const AIPImplementationID: string); override;
    procedure SetPeerCertificateValidation(UserValidation: TValidateCertificate); virtual;
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
        Fhttp.Post(FURITunnel, RParams);
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
  LIPVersionStr, Password, Scheme, Timeout, User: string;
  LIPVersion, LProxyPort: Integer;
begin
  Close;
  FIPImplementationID := DbxProperties[TDBXPropertyNames.IPImplementationID];

  LIPVersionStr := DbxProperties[TDBXPropertyNames.CommunicationIPVersion].Trim;
  LIPVersion := GetEnumValue(TypeInfo(TIPVersionPeer), LIPVersionStr);
  if LIPVersion > -1 then
    TDSHTTPNativeClient(Fhttp).FHttp.IPVersion := TIPVersionPeer(LIPVersion)
  else
    TDSHTTPNativeClient(Fhttp).FHttp.IPVersion := TIPVersionPeer.IP_IPv4;

  LPath := DBXProperties[TDBXPropertyNames.URLPath];
  if LPath <> '' then
    LPath := LPath + '/';
  LDatasnapPath := DBXProperties[TDBXPropertyNames.DatasnapContext];
  Assert(LDatasnapPath.Length > 0);
  if LDatasnapPath = '/' then
    LDatasnapPath := EmptyStr
  else if (LDatasnapPath.Chars[LDatasnapPath.Length - 1] <> '/') then
      LDatasnapPath := LDatasnapPath + '/';
  FURITunnel :=
        IPProcs(FIPImplementationID).URLEncode(
                    Format('%s://%s:%s/%s%stunnel', [HTTPProtocol,
                                                     DBXProperties[TDBXPropertyNames.HostName],
                                                     DBXProperties[TDBXPropertyNames.Port],
                                                     LPath, LDatasnapPath])
        )
  ;

  //set up HTTP proxy
  LProxyHost :=  DBXProperties[TDBXPropertyNames.DSProxyHost].Trim;
  if LProxyHost <> EmptyStr then
  begin
    LProxyPort := StrToIntDef(DBXProperties.Values[TDBXPropertyNames.DSProxyPort], 8888);
    if LProxyPort > 0 then
    begin
      LProxyUsername :=  DBXProperties[TDBXPropertyNames.DSProxyUsername];
      LProxyPassword :=  DBXProperties[TDBXPropertyNames.DSProxyPassword];
      TDSHTTPNativeClient(Fhttp).FHttp.ProxyParams.ProxyServer := LProxyHost;
      TDSHTTPNativeClient(Fhttp).FHttp.ProxyParams.ProxyPort := LProxyPort;
      TDSHTTPNativeClient(Fhttp).FHttp.ProxyParams.ProxyUsername := LProxyUsername;
      TDSHTTPNativeClient(Fhttp).FHttp.ProxyParams.ProxyPassword := LProxyPassword;
      TDSHTTPNativeClient(Fhttp).FHttp.ProxyParams.BasicAuthentication := LProxyUsername <> EmptyStr;
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
        raise TDBXError.Create(ex.Message);
    end;

    // parse the response, populate the session id and result
    if Fhttp.ResponseCode = 200 then
    begin
      JSONRes := TJSONObject(TJSONObject.ParseJSONValue(BytesOf(StrData), 0));
      if JSONRes = nil then
        raise TDBXError.Create(Format(SProtocolErrorJSON, [StrData]));

      try
        if JSONRes.Get(0).JsonString.Value = 'error' then
          raise TDBXError.Create(TJSONString(JSONRes.Get(0).JsonValue).Value);

        // session id
        JSONParams := TJSONArray(JSONRes.Get(0).JsonValue);
        FSessionId := TJSONString(JSONParams.Get(0)).Value;

        // bytes written
        Len := StrToInt(TJSONNumber(JSONParams.Get(1)).Value);
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

  // send session and count
  ResponseStream := Fhttp.Get(FURITunnel + '?dss=' + FSessionId + '&c=' + IntToStr(Count));
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
end;

constructor TDSHTTPNativeClient.Create(const AIPImplementationID: string);
begin
  inherited Create;
  FIPImplementationID := AIPImplementationID;
  FHTTP := PeerFactory.CreatePeer(FIPImplementationID, IIPHTTP, nil) as IIPHTTP;
  FHTTP.UseNagle := False;
end;

destructor TDSHTTPNativeClient.Destroy;
begin
  FHTTP := nil;
  inherited;
end;

function TDSHTTPNativeClient.Get(AURL: string): TDSHTTPResponseStream;
var
  Data: TStream;
begin
  Data := TMemoryStream.Create;
  try
    FHTTP.DoGet(AURL, Data);
    Data.Position := 0;
    Result := TDSHTTPNativeResponseStream.Create(Fhttp.Response.ContentLength, Data);
  except
    Data.Free;
    raise
  end;
end;

function TDSHTTPNativeClient.GetResponseCode: Integer;
begin
  Result := FHTTP.ResponseCode;
end;

function TDSHTTPNativeClient.GetResponseText: string;
begin
  Result := FHTTP.ResponseText;
end;

function TDSHTTPNativeClient.Post(AURL: string; ASource: TStrings): string;
begin
  Result := FHTTP.DoPost(AURL, ASource)
end;

function TDSHTTPNativeClient.Put(AURL: string; ASource: TStream): string;
begin
  Result := FHTTP.DoPut(AURL, ASource)
end;

procedure TDSHTTPNativeClient.SetBasicAuthentication(const user, password: string);
begin
  FAuthentication := PeerFactory.CreatePeer(FIPImplementationID, IIPBasicAuthentication) as IIPBasicAuthentication;
  FAuthentication.Password := password;
  FAuthentication.Username := user;
  FHTTP.Request.Authentication := FAuthentication;
end;

procedure TDSHTTPNativeClient.SetConnectTimeout(AMilisec: Integer);
begin
  FHTTP.ConnectTimeout := AMilisec;
end;

procedure TDSHTTPNativeClient.SetReadTimeout(AMilisec: Integer);
begin
  FHTTP.ReadTimeout := AMilisec;
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
  Count: Integer): Integer;
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
var
  LIOHandler: IIPSSLIOHandlerSocketOpenSSL;
begin
  inherited Create(AIPImplementationID);

  FValidateCertificate := nil;
  LIOHandler := PeerFactory.CreatePeer(AIPImplementationID, IIPSSLIOHandlerSocketOpenSSL, FHTTP.GetObject as TComponent) as IIPSSLIOHandlerSocketOpenSSL;
  LIOHandler.OnVerifyPeer := IdValidateCertificate;
  LIOHandler.SSLOptions.VerifyMode := [sslvrfClientOnce];
  FHTTP.IOHandler := LIOHandler;
end;

function TDSHTTPSNativeClient.IdValidateCertificate(Certificate: IIPX509;
  AOk: Boolean; ADepth, AError: Integer): Boolean;
var
  Cert: TX509Certificate;
begin
  Result := true;
  if Assigned(FValidateCertificate) then
  begin
    Cert := TX509CertificateIndy.Create(Certificate);
    try
      // prepare the TX509Ceritifcate and invoke user method
      FValidateCertificate(Self, Cert, ADepth, Result);
    finally
      Cert.Free;
    end;
  end;
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

initialization
  TDBXCommunicationLayerFactory.RegisterLayer('http', TDBXHTTPLayer);
  TDBXCommunicationLayerFactory.RegisterLayer('https', TDBXHTTPSLayer);

finalization
  TDBXCommunicationLayerFactory.UnregisterLayer('http');
  TDBXCommunicationLayerFactory.UnregisterLayer('https');

end.

