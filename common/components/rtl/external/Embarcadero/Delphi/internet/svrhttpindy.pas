{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SvrHTTPIndy;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.Windows, System.Win.Registry,
{$ENDIF}
  System.SysUtils, System.Classes, System.SyncObjs,
  Web.WebBroker, Web.HTTPApp, SvrLog, IdHTTPServer, IdCustomHTTPServer, IdTCPServer, IdIntercept,
  IdSocketHandle, System.IniFiles, SockAppNotify, IdStackConsts, IdGlobal, IdGlobalProtocols,
  IdContext;


type
  TCustomWebServer = class;
  TWebServerRequest = class;

{ EWebServerException }

  EWebServerException = class(Exception)
  private
    FRequest: TWebServerRequest;
  public
    constructor Create(const Message: string; ARequest: TWebServerRequest);
    property Request: TWebServerRequest read FRequest;
  end;

{$IFDEF MSWINDOWS}
  EFailedToRetreiveTimeZoneInfo = class(Exception);
{$ENDIF}

{ TWebServerRequest }

  TConnectionIntercept = class(TIdConnectionIntercept)
  public
    constructor Create(AOwner: TComponent); 
    destructor Destroy; override;
{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
    procedure DataReceived(var ABuffer; const AByteCount: integer); override;
    procedure DataSent(var ABuffer; const AByteCount: integer); override;
{$ELSE}
    procedure Receive(var ABuffer: TIdBytes); override;
    procedure Send(var ABuffer: TIdBytes); override;
{$ENDIF}
  end;

  TServerIntercept = class(TIdServerIntercept)
  public
    procedure Init; override;
{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
    function Accept(ABinding: TIdSocketHandle): TIdConnectionIntercept; override;
{$ELSE}
    function Accept(AConnection: TComponent): TIdConnectionIntercept; override;
{$ENDIF}
  end;

  TRequestLogBuffers = class(TObject)
  private
    FRequestLogBuffer: AnsiString;
    FResponseLogBuffer: AnsiString;
  end;

  TWebServerRequest = class(TWebRequest)
  private
    FContext: TIdContext;
    FIdHTTPRequestInfo: TIdHTTPRequestInfo;
    FIdHTTPResponseInfo: TIdHTTPResponseInfo;
    FReadClientIndex: Integer;
    procedure SetStringVariable(Index: Integer; const Value: AnsiString);
    procedure SetIntegerVariable(Index: Integer; Value: Integer);
    procedure SetDateVariable(Index: Integer; Value: TDateTime);
  protected
    function GetStringVariable(Index: Integer): AnsiString; override;
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
  public
    constructor Create(APort: Integer;
      ARemoteAddress, ARemoteHost: string;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; AContext: TIdContext);
    function GetFieldByName(const Name: AnsiString): AnsiString; override;
    function ReadClient(var Buffer; Count: Integer): Integer; override;
    function ReadString(Count: Integer): AnsiString; override;
    function TranslateURI(const URI: string): string; override;
    function WriteClient(var Buffer; Count: Integer): Integer; override;
    function WriteString(const AString: AnsiString): Boolean; override;
    function WriteHeaders(StatusCode: Integer; const StatusString, Headers: AnsiString): Boolean; override;
    property RequestInfo: TIdHTTPRequestInfo read FIdHTTPRequestInfo;
    property Context: TIdContext read FContext;
  end;

  TServerLog = class;

{ TWebServerResponse }

  TWebServerResponse = class(TWebResponse)
  private
    FIdHTTPResponseInfo: TIdHTTPResponseInfo;
    FRequest: TWebServerRequest;
    FSent: Boolean;
  protected
    procedure SetStatusCode(Value: Integer); override;
    procedure SetContent(const Value: AnsiString); override;
    procedure SetContentStream(Value: TStream); override;
    function GetStringVariable(Index: Integer): AnsiString;  override;
    procedure SetStringVariable(Index: Integer; const Value: AnsiString);  override;
    function GetDateVariable(Index: Integer): TDateTime;  override;
    procedure SetDateVariable(Index: Integer; const Value: TDateTime);  override;
    function GetIntegerVariable(Index: Integer): Integer;  override;
    procedure SetIntegerVariable(Index: Integer; Value: Integer);  override;
    function GetContent: AnsiString;  override;
    function GetStatusCode: Integer;  override;
    function GetLogMessage: string; override;
    procedure SetLogMessage(const Value: string); override;
  public
    procedure SendResponse;  override;
    procedure SendRedirect(const URI: AnsiString);  override;
    procedure SendStream(AStream: TStream);  override;
    function Sent: Boolean; override;
    property Request: TWebServerRequest read FRequest;
    constructor Create(ARequest: TWebServerRequest; AResponseInfo: TIdHTTPResponseInfo);
    destructor Destroy; override;
  end;

  TSocketArray = array of TIdStackSocketHandle;

{ TCustomWebServer }
  TErrorCode = (ecTimeout, ecExecFail, ecTokenMismatch, ecOK);

  TCustomWebServer = class(TComponent)
  private
    FMimeTable: TIdMimeTable;
    FHTTPServer: TIdHTTPServer;
    FLog: TServerLog;
    FOnLog: THTTPLogEvent;
    FSearchPath: string;
    FDefaultURL: string;
    FExpandedSearchPath: string;
    FRunningWebAppListener: TRunningWebAppListener;
    function GetTranslatedDefaultURL: string;
    function GetExpandedSearchPath: string;
    procedure SetSearchPath(const Value: string);
    procedure HTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure HTTPServerCommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure ExecuteHTTPRequest(AContext: TIdContext; RequestInfo: TIdHTTPRequestInfo;
      ResponseInfo: TIdHTTPResponseInfo);
    function DoFileAccess(Request: TWebServerRequest;
      IsHeadMethod: Boolean; ResponseInfo: TIdHTTPResponseInfo): Boolean;
    function GetMIMEType(const FileName: string): string;
    procedure URLNotFound(Request: TWebServerRequest; ResponseInfo: TIdHTTPResponseInfo);
    procedure HandleException(Request: TWebServerRequest; ResponseInfo: TIdHTTPResponseInfo);
    procedure ServerError(Request: TWebServerRequest;
      ResponseInfo: TIdHTTPResponseInfo; const ErrorMsg: string);
    procedure LogRequest(Request: TWebServerRequest);
    procedure LogResponse;
    property ExpandedSearchPath: string read GetExpandedSearchPath;
    function GetPort: Integer;
    procedure SetPort(const Value: Integer);
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    {$IFDEF LINUX}
    function ExecWaitForToken(const AFileName, AToken: string;
      AWaitSecs: Integer; out ErrorCode: TErrorCode): Boolean;
    {$ENDIF LINUX}
  public
{$IFDEF LINUX}
    procedure GetOpenSockets(var Sockets: TSocketArray);
{$ENDIF}
    property TranslatedDefaultURL: string read GetTranslatedDefaultURL;
    property Active: Boolean read GetActive write SetActive;
    property SearchPath: string read FSearchPath write SetSearchPath;
    property DefaultURL: string read FDefaultURL write FDefaultURL;
    property Port: Integer read GetPort write SetPort;
    property OnLog: THTTPLogEvent read FOnLog write FOnLog;
    property RunningWebAppListener: TRunningWebAppListener read FRunningWebAppListener;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TServerLog = class(TCustomServerLog)
  private
    FWebServer: TCustomWebServer;
  protected
    procedure DoOnLog(Transaction: TTransactionLogEntry;
      var Release: Boolean); override;
  public
    constructor Create(AServer: TCustomWebServer);
  end;

{$IFDEF LINUX}
  procedure CloseOpenSockets(Sockets: array of TIdStackSocketHandle);
{$ENDIF}

implementation

uses Web.BrkrConst, SvrConst,
  SockAppReg, SvrSockRequest, SockConst, System.Math {$IFDEF LINUX} ,libc {$ENDIF};

threadvar ThreadRequestLogBuffer: TRequestLogBuffers;

function LocalTimeToUTCTime(DateTime: TDateTime): TDateTime; forward;

const
  viMethod = 0;
  viProtocolVersion = 1;
  viURL = 2;
  viQuery = 3;
  viPathInfo = 4;
  viPathTranslated = 5;
  viCacheControl = 6;
  viDate = 7;
  viAccept = 8;
  viFrom = 9;
  viHost = 10;
  viIfModified = 11;
  viReferer = 12;
  viUserAgent = 13;
  viContentEncoding = 14;
  viContentType = 15;
  viContentLength = 16;
  viContentVersion = 17;
  viDerivedFrom = 18;
  viExpires = 19;
  viTitle = 20;
  viRemoteAddr = 21;
  viRemoteHost = 22;
  viScriptName = 23;
  viServerPort = 24;
  viContent = 25;
  viConnection = 26;
  viCookie = 27;
  viAuthorization = 28;

  CGIServerVariables: array[viMethod..viAuthorization] of AnsiString = (
    'REQUEST_METHOD',                          { Do not localize }
    'SERVER_PROTOCOL',                         { Do not localize }
    'URL',                                     { Do not localize }
    'QUERY_STRING',                            { Do not localize }
    'PATH_INFO',                               { Do not localize }
    'PATH_TRANSLATED',                         { Do not localize }
    'HTTP_CACHE_CONTROL',                      { Do not localize }
    'HTTP_DATE',                               { Do not localize }
    'HTTP_ACCEPT',                             { Do not localize }
    'HTTP_FROM',                               { Do not localize }
    'HTTP_HOST',                               { Do not localize }
    'HTTP_IF_MODIFIED_SINCE',                  { Do not localize }
    'HTTP_REFERER',                            { Do not localize }
    'HTTP_USER_AGENT',                         { Do not localize }
    'HTTP_CONTENT_ENCODING',                   { Do not localize }
    'HTTP_CONTENT_TYPE',                       { Do not localize }
    'HTTP_CONTENT_LENGTH',                     { Do not localize }
    'HTTP_CONTENT_VERSION',                    { Do not localize }
    'HTTP_DERIVED_FROM',                       { Do not localize }
    'HTTP_EXPIRES',                            { Do not localize }
    'HTTP_TITLE',                              { Do not localize }
    'REMOTE_ADDR',                             { Do not localize }
    'REMOTE_HOST',                             { Do not localize }
    'SCRIPT_NAME',                             { Do not localize }
    'SERVER_PORT',                             { Do not localize }
    '',                                        { Do not localize }
    'HTTP_CONNECTION',                         { Do not localize }
    'HTTP_COOKIE',                             { Do not localize }
    'HTTP_AUTHORIZATION');
                         { Do not localize }
  HTTPHeaderNames: array[viMethod..viAuthorization] of string = (
    '',                          { Method }
    '',                          { Protocol }
    '',                          { URL }
    '',                          { Query String }
    '',                          { PathInfo }
    '',                          { PathTranslated }
    'Cache-Control',                      { Do not localize }
    'Date',                               { Do not localize }
    'Accept',                             { Do not localize }
    'From',                               { Do not localize }
    'Host',                               { Do not localize }
    'If-Modified-Since',                  { Do not localize }
    'Referer',                            { Do not localize }
    'User-Agent',                         { Do not localize }
    'Content-Encoding',                   { Do not localize }
    'Content-Type',                       { Do not localize }
    'Content-Length',                     { Do not localize }
    'Content-Version',                    { Do not localize }
    '',                          { DerivedFrom }
    'Expires',                   { Do not localize }
    '',                          { Title }
    '',                          { RemoteAddr }
    '',                          { RemoteHost }
    '',                          { ScriptName }
    '',                          { ServerPort }
    '',                                   { Do not localize }
    'Connection',                         { Do not localize }
    'Cookie',                             { Do not localize }
    'Authorization');                     { Do not localize }

{ EWebServerException }

constructor EWebServerException.Create(const Message: string;
  ARequest: TWebServerRequest);
begin
  inherited Create(Message);
  FRequest := ARequest;
end;

{ TWebServerRequest}

type
  TIdHTTPResponseInfoCracker = class(TIdHTTPResponseInfo)
  end;

constructor TWebServerRequest.Create(APort: Integer;
  ARemoteAddress, ARemoteHost: string;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo; AContext: TIdContext);
begin
  FIdHTTPRequestInfo := ARequestInfo;
  FIdHTTPResponseInfo := AResponseInfo;
  FContext := AContext;
  inherited Create;
end;

function NameToIndex(const AName: AnsiString): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(CGIServerVariables) to High(CGIServerVariables) do
  begin
    if AnsiStrComp(PAnsiChar(CGIServerVariables[I]), PAnsiChar(AName)) = 0 then
    begin
      Result := I;
      Exit;
    end;
  end;
end;

function StripHTTP(const Name: AnsiString): AnsiString;
begin
  if AnsiStrPos(PAnsiChar('HTTP_'), PAnsiChar(Name)) = PAnsiChar(Name) then
    Result := Copy(Name, 6, MaxInt)
  else Result := Name;
end;

function TWebServerRequest.GetFieldByName(const Name: AnsiString): AnsiString;
var
  Index: Integer;
begin
  Index := NameToIndex(Name);
  if Index = -1 then
    Index := NameToIndex(StripHTTP(Name));
  if Index <> -1 then
    Result := GetStringVariable(Index)
  else
{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
    Result := FIdHTTPRequestInfo.Headers.Values[StripHTTP(Name)];
{$ELSE}
    Result := AnsiString(FIdHTTPRequestInfo.RawHeaders.Values[string(StripHTTP(Name))]);
{$ENDIF}
end;

function TWebServerRequest.GetStringVariable(Index: Integer): AnsiString;

  function HeaderValue(Index: Integer): AnsiString;
  begin
    Assert(HTTPHeaderNames[Index] <> '');
    {$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
    Result := FIdHTTPRequestInfo.Headers.Values[HTTPHeaderNames[Index]];
    {$ELSE}
    Result := AnsiString(FIdHTTPRequestInfo.RawHeaders.Values[HTTPHeaderNames[Index]]);
    {$ENDIF}
  end;

  function GetScriptName: AnsiString;
  var
    SlashPos: Integer;
    S: string;
  begin
    S := FIdHTTPRequestInfo.Document;
    if Length(S) > 0 then
    begin
      Delete(S, 1, 1); // delete the first /
      SlashPos := Pos('/', S);
      if SlashPos <> 0 then
        Delete(S, SlashPos, MaxInt); // delete everything after the next /
      // Add back in the starting slash
	    S := '/' + S;
    end;
    Result := AnsiString(S);
  end;

  function ReadPostStream: AnsiString;
  var
    SavePosition: Integer;
  begin
    SavePosition := FIdHTTPRequestINfo.PostStream.Position;
    try
      SetLength(Result, FIdHTTPRequestInfo.PostStream.Size);
      FIdHTTPRequestINfo.PostStream.Position := 0;
      FIdHTTPRequestInfo.PostStream.Read(Result[1], Length(Result));
    finally
      FIdHTTPRequestINfo.PostStream.Position := SavePosition;
    end;
  end;

  function GetContentString: AnsiString;
  begin
    // Get the 8bit characters directly, rather than Indys translated string in  FIdHTTPRequestInfo.UnparsedParams
    // This solves a problem with multipart forms (which may contain binary data).
    if FIdHTTPRequestINfo.PostStream <> nil then
      Result := ReadPostStream
    else
      // Does a conversion
      Result := AnsiString(FIdHTTPRequestINfo.FormParams);
  end;

begin
  case Index of
    viMethod:          Result := AnsiString(FIdHTTPRequestInfo.Command);
    viProtocolVersion: Result := AnsiString(FIdHTTPRequestInfo.Version);
    viURL:             Result := '';  // Not implemented
    viQuery:           Result := AnsiString(FIdHTTPRequestInfo.UnparsedParams);
    viPathInfo:        Result := AnsiString(FIdHTTPRequestInfo.Document);
    viPathTranslated:  Result := AnsiString(FIdHTTPRequestInfo.Document);  
    viCacheControl:    Result := HeaderValue(Index);
    viDate:            Result := HeaderValue(Index);
    viAccept:          Result := HeaderValue(Index);
    viFrom:            Result := HeaderValue(Index);
    viHost:            Result := HeaderValue(Index);
    viIfModified:      Result := HeaderValue(Index);
    viReferer:         Result := HeaderValue(Index);
    viUserAgent:       Result := HeaderValue(Index);
    viContentEncoding: Result := HeaderValue(Index);
    viContentType:     Result := HeaderValue(Index);
    viContentLength:   Result := HeaderValue(Index);
    viContentVersion:  Result := HeaderValue(Index);
    viDerivedFrom:     Result := ''; // Not implemented
    viExpires:         Result := HeaderValue(Index);
    viTitle:           Result := ''; // Not implemented
    viRemoteAddr:      Result := AnsiString(FIdHTTPRequestInfo.RemoteIP);
    viRemoteHost:      Result := AnsiString(FIdHTTPRequestInfo.Host);
    viScriptName:      Result := GetScriptName;
    viServerPort:      Result := ''; // Not implemented
    viContent:         Result := GetContentString;
    viConnection:      Result := HeaderValue(Index);
    viCookie:          Result := HeaderValue(Index);
    viAuthorization:   Result := HeaderValue(Index);
  else
    Result := '';
  end;
end;

function TWebServerRequest.GetDateVariable(Index: Integer): TDateTime;
var
  Value: AnsiString;
begin
  Value := GetStringVariable(Index);
  if Value <> '' then
    Result := ParseDate(string(Value))
  else Result := -1;
end;

function TWebServerRequest.GetIntegerVariable(Index: Integer): Integer;
var
  Value: AnsiString;
begin
  Value := GetStringVariable(Index);
  if Value <> '' then
    Result := StrToInt(string(Value))
  else Result := -1;
end;

function TWebServerRequest.ReadClient(var Buffer; Count: Integer): Integer;
begin
  Count := Min(FIdHTTPRequestINfo.PostStream.Size - FReadClientIndex, Count);
  if Count > 0 then
  begin
    FIdHTTPRequestINfo.PostStream.Position := FReadClientIndex;
    FIdHTTPRequestInfo.PostStream.Read(Buffer, Count);
    Inc(FReadClientIndex, Count);
    Result := Count;
  end
  else
    Result := 0;
end;

function TWebServerRequest.ReadString(Count: Integer): AnsiString;
var
  Len: Integer;
begin
  SetLength(Result, Count);
  Len := ReadClient(Pointer(Result)^, Count);
  if Len > 0 then
    SetLength(Result, Len)
  else Result := '';
end;

function TWebServerRequest.TranslateURI(const URI: string): string;
begin
  // Not implemented
  Result := URI;
end;

function TWebServerRequest.WriteClient(var Buffer; Count: Integer): Integer;
begin
  Result := Count;
  try
    if FIdHTTPResponseInfo.ContentStream = nil then
    begin
      FIdHTTPResponseInfo.ContentStream := TBytesStream.Create;
      FIdHTTPResponseInfo.FreeContentStream := True;
    end;
    FIdHTTPResponseInfo.ContentStream.Write(Buffer, Count);
 except
    Result := 0;
  end;
end;

function TWebServerRequest.WriteString(const AString: AnsiString): Boolean;
begin
  Result := WriteClient(Pointer(AString)^, Length(AString)) = Length(AString);
end;

function TWebServerRequest.WriteHeaders(StatusCode: Integer;
  const StatusString, Headers: AnsiString): Boolean;
var
  S: TStrings;
  I, J: Integer;
  H, Name, Value: string;
  CRange, ILength: string;
begin
  FIdHTTPResponseInfo.ResponseNo := StatusCode;
  FIdHTTPResponseInfo.ResponseText := string(StatusString);
  S := TStringList.Create;
  S.Text := string(Headers);
  for I  := 0 to S.Count - 1 do
  begin
    H := S[0];
    J := Pos(':', H);
    if J <> 0 then
    begin
      Name := Copy(H, 1, J - 1);
      Value := Copy(H, J + 1, Length(H));
      if AnsiSameText(Name, 'Connection') then
        FIdHTTPResponseInfo.Connection := Value
      else if AnsiSameText(Name, 'Content-Version') then
        FIdHTTPResponseInfo.ContentVersion := Value
      else
      if AnsiSameText(Name, 'Content-Disposition') then
        FIdHTTPResponseInfo.ContentDisposition := Value
      else
      if AnsiSameText(Name, 'Content-Encoding') then
        FIdHTTPResponseInfo.ContentEncoding := Value
      else
      if AnsiSameText(Name, 'Content-Language') then
        FIdHTTPResponseInfo.ContentLanguage := Value
      else
      if AnsiSameText(Name, 'Content-Type') then
        FIdHTTPResponseInfo.ContentType := Value
      else
      if AnsiSameText(Name, 'Content-Range') then
      begin
        Fetch(Value);
        CRange := Fetch(Value, '/');
        ILength := Fetch(Value);

        FIdHTTPResponseInfo.ContentRangeStart := IndyStrToInt64(Fetch(CRange, '-'), 0);
        FIdHTTPResponseInfo.ContentRangeEnd := IndyStrToInt64(CRange, 0);
        FIdHTTPResponseInfo.ContentRangeInstanceLength := IndyStrToInt64(ILength, 0);
      end
      else
      // Set based on size of content
      // if Name = 'Content-Length' then
      //  FIdHTTPResponseInfo.ContentLength := Value;
      if AnsiSameText(Name, 'Cache-control') then
        FIdHTTPResponseInfo.CacheControl := Value
      else
      if AnsiSameText(Name, 'Date') then
        try
          FIdHTTPResponseInfo.Date := GMTToLocalDateTime(Value);
        except
        end
      else
      if AnsiSameText(Name, 'ETag') then
        FIdHTTPResponseInfo.ETag := Value
      else
      if AnsiSameText(Name, 'Expires') then
        try
          FIdHTTPResponseInfo.Expires := GMTToLocalDateTime(Value);
        except
          FIdHTTPResponseInfo.Expires := Now - (1 / SecsPerDay);
        end
      else
      if AnsiSameText(Name, 'Pragma') then
        FIdHTTPResponseInfo.Pragma := Value
      else
        if (Length(Name) > 0) and (Length(Value) > 0) then
           FIdHTTPResponseInfo.CustomHeaders.Values[Name] := Value;
    end;
  end;
  Result := True;                                                                     
end;

procedure TWebServerRequest.SetStringVariable(
  Index: Integer; const Value: AnsiString);
begin
{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
  if HTTPHeaderNames[Index] <> '' then
    FIdHTTPResponseInfo.Headers.Values[HTTPHeaderNames[Index]] := Value
  else
    FIdHTTPResponseINfo.Headers.Values[StripHTTP(CGIServerVariables[Index])];
{$ELSE}
  if HTTPHeaderNames[Index] <> '' then
    FIdHTTPResponseInfo.RawHeaders.Values[HTTPHeaderNames[Index]] := string(Value)
  else
    FIdHTTPResponseINfo.RawHeaders.Values[string(StripHTTP(CGIServerVariables[Index]))] := string(Value);
{$ENDIF}
end;

procedure TWebServerRequest.SetDateVariable(Index: Integer;
  Value: TDateTime);
begin
  SetStringVariable(Index, 
   AnsiString(Format(FormatDateTime('"%s", dd "%s" yyyy hh:mm:ss "GMT"', Value),  { do not localize }
   [DayOfWeekStr(Value), MonthStr(Value)])));
end;

procedure TWebServerRequest.SetIntegerVariable(Index, Value: Integer);
begin
  SetStringVariable(Index, AnsiString(IntToStr(Value)));
end;

{ TWebServerResponse }

constructor TWebServerResponse.Create(ARequest: TWebServerRequest;
  AResponseInfo: TIdHTTPResponseInfo);
begin
  inherited Create(ARequest);
  FRequest := ARequest;
  FIdHTTPResponseInfo := AResponseInfo;
  FIdHTTPResponseInfo.ResponseNo := 200;
end;

destructor TWebServerResponse.Destroy;
begin
//  Freed by Indy
//  FIdHTTPResponseInfo.ContentStream.Free;
//  FIdHTTPResponseInfo.ContentStream := nil;
  inherited Destroy;
end;

function TWebServerResponse.GetStringVariable(Index: Integer): AnsiString;
begin
  Result := FRequest.GetStringVariable(Index);
end;

procedure TWebServerResponse.SetStringVariable(Index: Integer; const Value: AnsiString);
begin
  FRequest.SetStringVariable(Index, Value);
end;

procedure TWebServerResponse.SetDateVariable(Index: Integer; const Value: TDateTime);
begin
  FRequest.SetDateVariable(Index, Value);
end;

procedure TWebServerResponse.SetIntegerVariable(Index: Integer; Value: Integer);
begin
  FRequest.SetIntegerVariable(Index, Value);
end;

function TWebServerResponse.GetContent: AnsiString;
begin
  Result := AnsiString(FIdHTTPResponseInfo.ContentText);
end;

function TWebServerResponse.GetDateVariable(Index: Integer): TDateTime;
begin
  Result := FRequest.GetDateVariable(Index);
end;

function TWebServerResponse.GetIntegerVariable(Index: Integer): Integer;
begin
  Result := FRequest.GetIntegerVariable(Index);
end;

function TWebServerResponse.GetStatusCode: Integer;
begin
  Result := FIdHTTPResponseInfo.ResponseNo;
end;

procedure TWebServerResponse.SetStatusCode(Value: Integer);
begin
  FIdHTTPResponseInfo.ResponseNo := Value;
end;

function TWebServerResponse.GetLogMessage: string;
begin
                                           
  // Service not available
  Result := '';
end;

procedure TWebServerResponse.SetLogMessage(const Value: string);
begin
                                           
  // Service not available
end;

procedure TWebServerResponse.SetContent(const Value: AnsiString);
begin
  FIdHTTPResponseInfo.ContentText := string(Value);
  FIdHTTPResponseInfo.ContentLength := Length(Value);
end;

procedure TWebServerResponse.SetContentStream(Value: TStream);
begin
  FIdHTTPResponseInfo.ContentStream := Value;
  FIdHTTPResponseInfo.ContentLength := Value.Size;
end;

procedure TWebServerResponse.SendResponse;
begin
  FIdHTTPResponseINfo.WriteHeader;
  FIdHTTPResponseInfo.WriteContent;
  FSent := True;
end;

procedure TWebServerResponse.SendStream(AStream: TStream);
begin
  FIdHTTPResponseInfo.ContentStream := AStream;
  try
    FIdHTTPResponseInfo.WriteContent;
  finally
    FIdHTTPResponseInfo.ContentStream := nil;
  end;
end;

procedure TWebServerResponse.SendRedirect(const URI: AnsiString);
begin
  FIdHTTPResponseINfo.Redirect(string(URI));
  SendResponse;
end;

function TWebServerResponse.Sent: Boolean;
begin
  Result := FSent;
end;

procedure InitializeRootDirVariable(const AMacro: string); forward;

{ TCustomWebServer }

constructor TCustomWebServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMimeTable := TIdMimeTable.Create;
  FHTTPServer := TIdHTTPServer.Create(nil);
  FHTTPServer.ParseParams := False;  // Don't parse content fields or query fields
{$IFDEF KEEPALIVE}
  FHTTPServer.KeepAlive := True;
{$ENDIF}
  FHTTPServer.OnCommandGet := HTTPServerCommandGet;
  FHTTPServer.OnCommandOther := HTTPServerCommandOther;
  FHTTPServer.Intercept := TServerIntercept.Create(nil);
  FLog := TServerLog.Create(Self);
  try
    FRunningWebAppListener := TRunningWebAppListener.Create;
  except
    FRunningWebAppListener := nil;
  end;
  InitializeRootDirVariable('BDS');
  InitializeRootDirVariable('BCB');
  InitializeRootDirVariable('DELPHI');
end;

destructor TCustomWebServer.Destroy;
begin
  inherited Destroy;
  FMimeTable.Free;
  FHTTPServer.Free;
  FLog.Free;
  FRunningWebAppListener.Free;
end;

procedure TCustomWebServer.LogRequest(Request: TWebServerRequest);
begin
  if ThreadRequestLogBuffer <> nil then
    FLog.LogRequest(Request, ThreadRequestLogBuffer.FRequestLogBuffer)
  else
    FLog.LogRequest(Request, '');
end;

procedure TCustomWebServer.LogResponse;
begin
  if ThreadRequestLogBuffer <> nil then
    FLog.LogResponse(ThreadRequestLogBuffer.FResponseLogBuffer)
  else
    FLog.LogResponse('');
end;

function TCustomWebServer.GetTranslatedDefaultURL: string;
var
  S: string;
begin
  S := FDefaultURL;
  Result := S;
  if S <> '' then
  begin
    if (CompareText(Copy(S, 1, 4), 'http') <> 0) and
      (CompareText(Copy(S, 1, 2), '//') <> 0) then
    begin
      Result := 'http:';
      if Copy(S, 1, 2) = '//' then
        Result := Result + S
      else
      begin
        Result := Result + '//';
        if S[1] = '/' then
          Delete(S, 1, 1);
        Result := Format('%slocalhost:%d/%s', [Result, Port, S])
      end;
    end;
  end;
end;

procedure TCustomWebServer.HTTPServerCommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  ExecuteHTTPRequest(AContext, ARequestInfo, AResponseInfo);
end;

procedure TCustomWebServer.HTTPServerCommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  ExecuteHTTPRequest(AContext, ARequestInfo, AResponseInfo);
end;

function TCustomWebServer.GetMIMEType(const FileName: string): string;
var
  Ext: string;
begin
  Result := 'application/octet-stream';
  Ext := ExtractFileExt(FileName);
{$IFDEF MSWINDOWS}
  if (CompareText(Ext, '.exe') = 0) or (CompareText(Ext, '.dll') = 0) then
    Exit;
{$ENDIF}
  Result := FMimeTable.GetFileMIMEType(FileName);
end;

{$IFDEF LINUX}
procedure TCustomWebServer.GetOpenSockets(var Sockets: TSocketArray);

  procedure Add(Handle: TIdStackSocketHandle);
  begin
    SetLength(Sockets, Length(Sockets) + 1);
    Sockets[High(Sockets)] := Handle;
  end;
var
  I: Integer;
begin
  SetLength(Sockets, 0);
  for I := 0 to FHTTPServer.Bindings.Count do
    Add(FHTTPServer.Bindings.Items[0].Handle);
  if FRunningWebAppListener <> nil then
    for I := 0 to FRunningWebAppListener.Connection.Bindings.Count do
      Add(FRunningWebAppListener.Connection.Bindings.Items[0].Handle);
end;
{$ENDIF}

{$IFDEF LINUX}
procedure CloseOpenSockets(Sockets: array of TIdStackSocketHandle);
var
  I: Integer;
begin
  for I := 0 to Length(Sockets) - 1 do
    Libc.__close(Sockets[I]);
end;
{$ENDIF}

{$IFDEF LINUX}

function TCustomWebServer.ExecWaitForToken(const AFileName, AToken: string; AWaitSecs: Integer; out ErrorCode: TErrorCode): Boolean;
const
  FailToken = '!!Fail!!';
  MaxToken = 256;
var
  Argv: array of PChar;
  PID: Integer;
  Descr: TPipeDescriptors;
  { variables used when execing }
  fd, BytesRead: Integer;
  DescriptorSet: TFDSet;
  WaitTime: TTimeVal;
  { variables used to read from the socket }
  PipeStream : THandleStream;
  Buffer: string;
  Sockets: TSocketArray;
begin
  SetLength(Sockets, 0);
  GetOpenSockets(Sockets);
  pipe(Descr);
  SetLength(Argv, 4);
  Argv[0] := PChar(AFileName);
  Argv[1] := PChar(AToken);
  Argv[2] := PChar(IntToStr(Descr.WriteDes));
  Argv[3] := nil;
  PID := fork;
  if PID = 0 then
  begin
    CloseOpenSockets(Sockets);
    __close(Descr.ReadDes);
    if execv(PChar(Argv[0]), @Argv[0]) = -1 then
    begin
      PipeStream := THandleStream.Create(Descr.WriteDes);
      try
        PipeStream.Write(FailToken, Length(FailToken));
      finally
        PipeStream.Free;
      end;
    end;
    _exit(1);
  end
  else
  begin
    __close(Descr.WriteDes);
    { set up information about file descriptors }
    WaitTime.tv_sec := AWaitSecs;
    WaitTime.tv_usec := 0;

    { cast the descriptors to TSocket, because the pascal declaration
      of the function demands that --- but note that since TSocket is
      an integer, and the file descriptor is an integer, this is OK. }
    FD_ZERO(DescriptorSet);
    FD_SET(TSocket(Descr.ReadDes), DescriptorSet);

    { check and see which file descriptor has been written to. }
    fd := select(__FD_SETSIZE, @DescriptorSet, nil, nil, @WaitTime);
    if(fd = 0) then
      ErrorCode := ecTimeout
    else if FD_ISSET(TSocket(Descr.ReadDes), DescriptorSet) then
    begin
      fd := Descr.ReadDes;
      PipeStream := THandleStream.Create(fd);
      try
        Assert(Length(AToken) <= MaxToken);
        { read the input stream }
        SetLength(Buffer, MaxToken);
        try
          BytesRead := PipeStream.Read(Buffer[1], MaxToken);
          SetLength(Buffer, BytesRead);
        except
          SetLength(Buffer, 0);
          raise;
        end;
      finally
        PipeStream.Free;
      end;
      if CompareText(Buffer, AToken) = 0 then
        ErrorCode := ecOK
      else if CompareText(Buffer, FailToken) = 0 then
        ErrorCode := ecExecFail
      else
        ErrorCode := ecTokenMismatch;
    end
    else
      ErrorCode := ecTimeout;
  end;
  Result := ErrorCode = ecOK;
end;
{$ENDIF}

function TCustomWebServer.DoFileAccess(Request: TWebServerRequest;
  IsHeadMethod: Boolean; ResponseInfo: TIdHTTPResponseInfo): Boolean;

  function CheckFileExists(const AFileName: string): Boolean;
  begin
    Result := FileExists(PChar(AFileName));
  end;

  function SearchForFile(ADirList: string): string;
  var
    I, P, L: Integer;
    FileName: string;
  begin
    FileName := string(Request.PathInfo);
    P := Pos('/', FileName);
    while P <> 0 do
    begin
      if P = Length(FileName) then
        Delete(FileName, P, 1)
      else
        Delete(FileName, 1, P);
      P := Pos('/', FileName);
    end;
    if (FileName <> '') then
    begin
      P := 1;
      L := Length(ADirList);
      while P <= L do
      begin
        I := P;
        while (P <= L) and (ADirList[P] <> ';') do Inc(P);
        Result := Copy(ADirList, I, P - I);
        if (Result <> '') and not IsDelimiter(DriveDelim + PathDelim, Result, Length(Result)) then
          Result := Result + PathDelim;
        Result := ExpandFileName(Result + FileName);
        if CheckFileExists(Result) then Exit;
        Inc(P);
      end;
    end;
    Result := '';
  end;

  function ExtractProgID(Request: TWebRequest; var ID: string): Boolean;
  var
    P: Integer;
  begin
    ID := string(Request.PathInfo);
    if (Length(ID) > 0) and (ID[1] = '/') then
      Delete(ID, 1, 1);
    P := Pos('/', ID);
    if P > 0 then
      Delete(ID, P, MaxInt);
    Result := False;
    if ID <> '' then
    begin
      if not Result and (ID[1] = '{') then
      begin
        Assert(False, 'Guids not supported');
      end;
      if not Result and (CompareText(ExtractFileExt(ID), '.js') <> 0) then
      begin
        Result := True;
      end;
    end;
  end;

  procedure StartWebApp(const AFileName: string);
{$IFDEF MSWINDOWS}
  var
    ProcessInfo: TProcessInformation;
    StartupInfo: TStartupInfo;
    TargetName: TFileName;
  begin
    begin
      FillChar(StartupInfo, SizeOf(StartupInfo), 0);
      StartupInfo.cb := SizeOf(StartupInfo);
      TargetName := AFileName;
      if not CreateProcess(nil, PChar(TargetName),
        nil, nil, False, 0, nil, nil, StartupInfo, ProcessInfo) then
        raise Exception.CreateFmt(sErrorExec, [TargetName, GetLastError])
      else
      try
        case WaitForInputIdle(ProcessInfo.hProcess, 2000) of
          0: ;
          WAIT_TIMEOUT:
            raise Exception.CreateFmt(sErrorExec, [TargetName, GetLastError]);
          WAIT_FAILED:
            raise Exception.CreateFmt(sErrorExec, [TargetName, GetLastError]);
        else
          Assert(False); // Unexpected value
        end
      finally
        { Always close the handles right away, since we don't use them }
        CloseHandle(ProcessInfo.hProcess);
        CloseHandle(ProcessInfo.hThread);
      end;
    end;
  end;
{$ENDIF}
{$IFDEF LINUX}
  const
    Token = sExecWaitToken;
    WaitSecs = 10;
  var
    ErrorCode: TErrorCode;
  begin
    if not ExecWaitForToken(AFileName, Token, WaitSecs, ErrorCode) then
      case ErrorCode of
        ecTimeout: raise Exception.CreateFmt(sErrorExecTimeout, [AFileName]);
        ecExecFail: raise Exception.CreateFmt(sErrorExecFail, [AFileName]);
        ecTokenMismatch: raise Exception.CreateFmt(sErrorExecUnexpected, [AFileName]);
      else
        Assert(False); // Unexpected value
      end;
  end;
{$ENDIF}

const
  MaxRetry = 1;
var
  FileDate: TDateTime;
  Response: TWebServerResponse;
  FileName: string;
  DefaultURL: string;
  ProgID: string;
  Port: Integer;
  ExeName: string;
  RetryCount: Integer;
  Connection: TRequestConnection;
begin
  Result := False;
  if (Request.PathInfo = '') or (Request.PathInfo = '/') then
  begin
    DefaultURL := GetTranslatedDefaultURL;
    if DefaultURL <> '' then
    begin
      Response := TWebServerResponse.Create(Request, ResponseInfo);
      with Response do
      try
        Response.SendRedirect(AnsiString(DefaultURL));
      finally
        Free;
      end;
      Result := True;
    end;
  end
  else
  begin
    Port := -1;
    if ExtractProgID(Request, ProgID) then
    begin
      ExeName := FindRegisteredWebApp(ProgID);
      Port := FRunningWebAppListener.GetPortOfFileName(ExeName);
      if (Port = -1) and FileExists(ExeName) then
      begin
        StartWebApp(ExeName);
        Port := FRunningWebAppListener.GetPortOfFileName(ExeName);
      end;
    end;
    RetryCount := 0;
    while Port > 0 do
    begin
      Connection := TRequestConnection.Create(Port);
      try
        if not Connection.Connect then
        begin
          FRunningWebAppListener.RemovePort(Port);
          if RetryCount < MaxRetry then
          begin
            Inc(RetryCount);
            if FileExists(ExeName) then
            begin
              StartWebApp(ExeName);
              Port := FRunningWebAppListener.GetPortOfFileName(ExeName);
              Continue;
            end;
          end;
        end
        else
        begin
          Response := TWebServerResponse.Create(Request, ResponseInfo);
          try
            Connection.Request(Request, Response, True);
            Result := True;
            break;
          finally
            Response.Free;
          end;
        end;
      finally
        Connection.Disconnect;
        Connection.Free;
      end;
    end;
    if Port <= 0 then
    begin
      FileName := SearchForFile(
        ExpandedSearchpath);
      if FileName <> '' then
      begin
        with TWebServerResponse.Create(Request, ResponseINfo) do
        try
          FileDate := LocalTimeToUTCTime(FileDateToDateTime(FileAge(FileName)));
          if (Request.IfModifiedSince > -1) and (FileDate <= Request.IfModifiedSince) then
          begin
            StatusCode := 304;
          end else
          begin
            LastModified := FileDate;
            ContentType := AnsiString(GetMIMEType(FileName));
            if not IsHeadMethod then
              ContentStream := TFileStream.Create(FileName, fmOpenRead or
                fmShareDenyWrite);
          end;
          SendResponse;
        finally
          Free;
        end;
        Result := True;
      end
    end;
  end;

  if not Result then URLNotFound(Request, ResponseInfo);
end;

procedure TCustomWebServer.URLNotFound(Request: TWebServerRequest; ResponseInfo: TIdHTTPResponseInfo );
var
  Response: TWebServerResponse;
begin
  Response := TWebServerResponse.Create(Request, ResponseInfo);
  with Response do
  try
    ContentType := 'text/html';
    StatusCode := 404;
    Content := sNotFound;
    SendResponse;
  finally
    Response.Free;
  end;
end;

procedure TCustomWebServer.HandleException(Request: TWebServerRequest; ResponseInfo: TIdHTTPResponseInfo);
var
  ExceptObj: Exception;
begin
  ExceptObj := Exception(ExceptObject);
  ServerError(Request, ResponseInfo, ExceptObj.Message);
end;

procedure TCustomWebServer.ExecuteHTTPRequest(AContext: TIdContext; RequestInfo: TIdHTTPRequestInfo;
  ResponseInfo: TIdHTTPResponseInfo);
var
  Request: TWebServerRequest;
begin
  Request :=
    TWebServerRequest.Create(FHTTPServer.Bindings[0].Port,
      // ClientSocket.RemoteAddress,
      '',
      // ClientSocket.RemoteHost
      '', RequestInfo, ResponseInfo, AContext);
  try
    try
      LogRequest(Request);
      DoFileAccess(Request, False{ IsHeader flag},  ResponseInfo);
    except
      HandleException(Request, ResponseInfo);
    end;
    ResponseInfo.WriteHeader;
    ResponseInfo.WriteContent;
    LogResponse;
  finally
    FreeAndNil(ThreadRequestLogBuffer);
    Request.Free;
  end;
end;

procedure TCustomWebServer.ServerError(Request: TWebServerRequest; ResponseInfo: TIdHTTPResponseInfo;
  const ErrorMsg: string);
var
  Response: TWebServerResponse;
begin
  Response := TWebServerResponse.Create(Request, ResponseInfo);
  with Response do
  try
    ContentType := 'text/html';
    // StatusCode := 500;
    // 200 Let's browser display content
    StatusCode := 200;
    ReasonString := AnsiString(ErrorMsg);
    Content := Format(sInternalServerError, [ErrorMsg]);
    SendResponse;
  finally
    Response.Free;
  end;
end;

{ Utility functions }

function OffsetFromUTC: TDateTime;
{$IFDEF LINUX}
var
  T: TTime_T;
  TV: TTimeVal;
  UT: TUnixTime;
begin
  gettimeofday(TV, nil);
  T := TV.tv_sec;
  localtime_r(@T, UT);
  // __tm_gmtoff is the bias in seconds from the UTC to the current time.
  // so I multiply by -1 to compensate for this.
  Result := -1*(UT.__tm_gmtoff / 60 / 60 / 24);
end;
{$ENDIF}
{$IFDEF MSWINDOWS}
var
  iBias: Integer;
  tmez: TTimeZoneInformation;
begin
  // Copied from IdGlobal.pas
  case GetTimeZoneInformation(tmez) of
    TIME_ZONE_ID_INVALID:
      raise EFailedToRetreiveTimeZoneInfo.Create(sFailedTimeZoneInfo);
    TIME_ZONE_ID_UNKNOWN  :
       iBias := tmez.Bias;
    TIME_ZONE_ID_DAYLIGHT :
      iBias := tmez.Bias + tmez.DaylightBias;
    TIME_ZONE_ID_STANDARD :
      iBias := tmez.Bias + tmez.StandardBias;
    else
      raise EFailedToRetreiveTimeZoneInfo.Create(sFailedTimeZoneInfo);
  end;
  {We use ABS because EncodeTime will only accept positve values}
  Result := EncodeTime(Abs(iBias) div 60, Abs(iBias) mod 60, 0, 0);
end;
{$ENDIF}

function LocalTimeToUTCTime(DateTime: TDateTime): TDateTime;
begin
  Result := DateTime + OffsetFromUTC;
end;

function TCustomWebServer.GetPort: Integer;
begin
  Result := FHTTPServer.DefaultPort;
end;

procedure TCustomWebServer.SetPort(const Value: Integer);
begin
  FHTTPServer.DefaultPort := Value;
end;

function TCustomWebServer.GetActive: Boolean;
begin
  Result := FHTTPServer.Active;
end;

procedure TCustomWebServer.SetActive(const Value: Boolean);
begin
  try
    FHTTPServer.Active := Value;
    if Value = False then
      FHTTPServer.Bindings.Clear;
  except
    FHTTPServer.Active := False;
    FHTTPServer.Bindings.Clear;
    raise;
  end;
end;


{ TServerLog }

constructor TServerLog.Create(AServer: TCustomWebServer);
begin
  inherited Create;
  FWebServer := AServer;
end;

procedure TServerLog.DoOnLog(Transaction: TTransactionLogEntry; var Release: Boolean);
begin
  if Assigned(FWebServer.FOnLog) then FWebServer.FOnLog(Self, Transaction, Release);
end;

function ExpandEnvStrings(InString: string): string;
var
  DollarPos, EndEnvVarPos: Integer;
  OrigStr: string;
  Depth: Integer;  //depth is used to avoid infinite looping (only 1000 levels deep allowed)
{$IFDEF MSWINDOWS}
  P: array[0..4096] of char;
{$ENDIF}
{$IFDEF LINUX}
  ReplaceStr: string;
{$ENDIF}
begin
  Result := Instring;
  DollarPos := AnsiPos('$(', Result);
  EndEnvVarPos := AnsiPos(')', Result);
  Depth := 0;
  while (DollarPos <> 0) and (EndEnvVarPos > DollarPos) and (Depth < 1000) do
  begin
    if EndEnvVarPos > DollarPos then
    begin
      OrigStr := Copy(Result, DollarPos, EndEnvVarPos - DollarPos + 1);
{$IFDEF LINUX}
      ReplaceStr := Libc.getenv(PChar(Copy(Result, DollarPos + 2, EndEnvVarPos - DollarPos - 2)));
      Result := StringReplace(Result, OrigStr, ReplaceStr, [rfReplaceAll]);
{$ENDIF}
{$IFDEF MSWINDOWS}
      ExpandEnvironmentStrings(PChar('%' + Copy(Result, DollarPos + 2, EndEnvVarPos - DollarPos - 2) + '%'), P, SizeOf(P));
      Result := StringReplace(Result, OrigStr, P, [rfReplaceAll]);
{$ENDIF}
      DollarPos := AnsiPos('$(', Result);
      EndEnvVarPos := AnsiPos(')', Result);
      Inc(Depth);
    end;
  end;
end;

function TCustomWebServer.GetExpandedSearchPath: string;
begin
  if (FExpandedSearchPath = '') and (SearchPath <> '') then
    FExpandedSearchPath := ExpandEnvStrings(SearchPath);
  Result := FExpandedSearchPath;
end;

procedure TCustomWebServer.SetSearchPath(const Value: string);
begin
  FSearchPath := Value;
  FExpandedSearchPath := '';
end;

function GetBaseExePath: string;
var
  ModuleName: array[0..255] of Char;
begin
  GetModuleFileName(hInstance, ModuleName, sizeof(ModuleName));
  Result := ExtractFilePath(ModuleName);
end;

function GetRootDir: string;
var
  LongPath: string;
begin
  LongPath := GetBaseExePath;
  //---- remove trailing slash if present ----
  if IsPathDelimiter(LongPath, Length(LongPath)) then
    Delete(LongPath, Length(LongPath), 1);
  //---- remove last "bin" type dir to get product root dir ----
  Result := ExtractFilePath(LongPath);
  if Result = '' then Result := LongPath; // no subdir present (this is an outer dir)
  //---- remove trailing slash if present ----
  if IsPathDelimiter(Result, Length(Result)) then
    Delete(Result, Length(Result), 1);
end;

procedure InitializeRootDirVariable(const AMacro: string);
{$IFDEF MSWINDOWS}
var
  EnvVar: array[0..4096] of char;
begin
  if GetEnvironmentVariable(PChar(AMacro), EnvVar, Sizeof(EnvVar)) = 0 then
    SetEnvironmentVariable(PChar(AMacro), PChar(GetRootDir));
end;
{$ENDIF}
{$IFDEF LINUX}
begin
  if getenv('HOME') = nil then
    setenv('HOME', PChar(GetRootDir), True)
end;
{$ENDIF}

{ TServerIntercept }
{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
function TServerIntercept.Accept(
  ABinding: TIdSocketHandle): TIdConnectionIntercept;
begin
  Result := TConnectionIntercept.Create(nil);
end;
{$ELSE}
function TServerIntercept.Accept(
  AConnection: TComponent): TIdConnectionIntercept;
begin
  Result := TConnectionIntercept.Create(nil);
end;
{$ENDIF}

procedure TServerIntercept.Init;
begin
  // Do nothing.   Must implement (abstract).

end;

{ TConnectionIntercept }

constructor TConnectionIntercept.Create(AOwner: TComponent);
begin
  inherited;
{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
  FRecvHandling := False;
  FSendHandling := False;
{$ENDIF}
end;

{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
procedure TConnectionIntercept.DataReceived(var ABuffer;
  const AByteCount: integer);
var
  I: Integer;
begin
  if ThreadRequestLogBuffer = nil then
    ThreadRequestLogBuffer := TRequestLogBuffer.Create;
  I := Length(ThreadRequestLogBuffer.FLogBuffer);
  SetLength(ThreadRequestLogBuffer.FLogBuffer, I + AByteCount);
  Move(ABuffer, ThreadRequestLogBuffer.FLogBuffer[I + 1], AByteCount);
end;
{$ELSE}
procedure TConnectionIntercept.Receive(var ABuffer: TIdBytes);
var
  I: Integer;
  Count: Integer;
begin
  Count := Length(ABuffer);
  if ThreadRequestLogBuffer = nil then
    ThreadRequestLogBuffer := TRequestLogBuffers.Create;
  I := Length(ThreadRequestLogBuffer.FRequestLogBuffer);
  SetLength(ThreadRequestLogBuffer.FRequestLogBuffer, I + Count);
  Move(ABuffer[0], ThreadRequestLogBuffer.FRequestLogBuffer[I + 1], Count);
end;
{$ENDIF}

{$IF gsIdVersion = '8.0.25'} // D6, K2 compatible
procedure TConnectionIntercept.DataSent(var ABuffer;
  const AByteCount: integer);
var
  I: Integer;
begin
  if ThreadResponse <> nil then
  begin
    I := Length(ThreadResponse.FLogBuffer);
    SetLength(ThreadResponse.FLogBuffer, I + AByteCount);
    Move(ABuffer, ThreadResponse.FLogBuffer[I + 1], AByteCount);
  end;
end;
{$ELSE}
procedure TConnectionIntercept.Send(var ABuffer: TIdBytes);
var
  I: Integer;
  Count: Integer;
begin
  Count := Length(ABuffer);
  if ThreadRequestLogBuffer = nil then
    ThreadRequestLogBuffer := TRequestLogBuffers.Create;
  I := Length(ThreadRequestLogBuffer.FResponseLogBuffer);
  SetLength(ThreadRequestLogBuffer.FResponseLogBuffer, I + Count);
  Move(ABuffer[0], ThreadRequestLogBuffer.FResponseLogBuffer[I + 1], Count);
end;
{$ENDIF}

destructor TConnectionIntercept.Destroy;
begin
  // Testing
  inherited;
end;

end.
