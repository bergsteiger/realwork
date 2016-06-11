{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Web.Win.IsapiHTTP;

interface

{$WARN IMPLICIT_STRING_CAST OFF}

uses System.SysUtils, Winapi.Windows, System.Classes, Web.HTTPApp, Winapi.Isapi2;

type
  TISAPIRequest = class(TWebRequest)
  private
    FBytesContent: TBytes;
    FECB: PEXTENSION_CONTROL_BLOCK;
    function GetHost: UTF8String;
    function GetFieldByNameA(const Name: string): UTF8String;
  protected
    function GetStringVariable(Index: Integer): string; override;
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetRawPathInfo: string; override;
    /// <summary>Reads the total content returned by the server.</summary>
    /// <remarks>
    /// ECB only contains a chunk part of the server response.
    /// DoReadTotalContent force to read the whole response.
    /// </remarks>
    procedure DoReadTotalContent; override;
    function GetRawContent: TBytes; override;
  public
    constructor Create(AECB: PEXTENSION_CONTROL_BLOCK);
    function GetFieldByName(const Name: string): string; override;
    function ReadClient(var Buffer; Count: Integer): Integer; override;
    function ReadString(Count: Integer): string; override;
    function TranslateURI(const URI: string): string; override;
    function WriteClient(var Buffer; Count: Integer): Integer; override;
    function WriteString(const AString: string): Boolean; override;
    function WriteHeaders(StatusCode: Integer; const StatusString, Headers: string): Boolean; override;
    property ECB: PEXTENSION_CONTROL_BLOCK read FECB;
  end;

  TISAPIResponse = class(TWebResponse)
  private
    FStatusCode: Integer;
    FStringVariables: array[0..MAX_STRINGS - 1] of UTF8String;
    FIntegerVariables: array[0..MAX_INTEGERS - 1] of Integer;
    FDateVariables: array[0..MAX_DATETIMES - 1] of TDateTime;
    FBytesContent: TBytes;
    FSent: Boolean;
  protected
    function GetContent: string; override;
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetLogMessage: string; override;
    function GetStatusCode: Integer; override;
    function GetStringVariable(Index: Integer): string; override;
    procedure SetContent(const Value: string); override;
    procedure SetDateVariable(Index: Integer; const Value: TDateTime); override;
    procedure SetIntegerVariable(Index: Integer; Value: Integer); override;
    procedure SetLogMessage(const Value: string); override;
    procedure SetStatusCode(Value: Integer); override;
    procedure SetStringVariable(Index: Integer; const Value: string); override;
    procedure InitResponse; virtual;
  public
    constructor Create(HTTPRequest: TWebRequest);
    procedure SendResponse; override;
    procedure SendRedirect(const URI: string); override;
    procedure SendStream(AStream: TStream); override;
    function Sent: Boolean; override;
  end;

implementation

uses System.Math, Web.BrkrConst, System.AnsiStrings;

const
  ServerVariables: array[0..28] of string = (
    '',
    'SERVER_PROTOCOL',
    'URL',
    '',
    '',
    '',
    'HTTP_CACHE_CONTROL',
    'HTTP_DATE',
    'HTTP_ACCEPT',
    'HTTP_FROM',
    'HTTP_HOST',
    'HTTP_IF_MODIFIED_SINCE',
    'HTTP_REFERER',
    'HTTP_USER_AGENT',
    'HTTP_CONTENT_ENCODING',
    'CONTENT_TYPE',
    'CONTENT_LENGTH',
    'HTTP_CONTENT_VERSION',
    'HTTP_DERIVED_FROM',
    'HTTP_EXPIRES',
    'HTTP_TITLE',
    'REMOTE_ADDR',
    'REMOTE_HOST',
    'SCRIPT_NAME',
    'SERVER_PORT',
    '',
    'HTTP_CONNECTION',
    'HTTP_COOKIE',
    'HTTP_AUTHORIZATION');

{ TISAPIRequest }

constructor TISAPIRequest.Create(AECB: PEXTENSION_CONTROL_BLOCK);
begin
  FECB := AECB;
  inherited Create;
end;

procedure TISAPIRequest.DoReadTotalContent;
var
  LChunkSize: Integer;
  LOffset: Cardinal;
  LMaxRead: Cardinal;
  LRead: Integer;
begin
  if Cardinal(Length(FBytesContent)) < ECB.cbTotalBytes then
  begin
    if ECB.cbAvailable > 0 then
    begin
      SetLength(FBytesContent, ECB.cbTotalBytes);
      System.Move(PByte(ECB.lpbData)[0], FBytesContent[0], ECB.cbAvailable);
      LOffset := ECB.cbAvailable;
      LMaxRead := ECB.cbAvailable;
      while LOffset < ECB.cbTotalBytes do
      begin
        LChunkSize := Min(LMaxRead, ECB.cbTotalBytes - LOffset);
        LRead := ReadClient(FBytesContent[LOffset], LChunkSize);
        if LRead <= 0 then
          break;
        Inc(LOffset, LRead);
      end;
    end;
  end;
end;


function TISAPIRequest.GetFieldByName(const Name: string): string;
begin
  Result := GetFieldByNameA(Name);
end;

function TISAPIRequest.GetFieldByNameA(const Name: string): UTF8String;
var
  Buffer: array[0..4095] of UTF8Char;
  Size: DWORD;
begin
  Size := SizeOf(Buffer);
  if ECB.GetServerVariable(ECB.ConnID, PUTF8Char(UTF8String(Name)), @Buffer, Size) or
     ECB.GetServerVariable(ECB.ConnID, PUTF8Char(UTF8String('HTTP_' + Name)), @Buffer, Size) then  { do not localize }
  begin
    if Size > 0 then Dec(Size);
    SetString(Result, Buffer, Size);
  end else Result := '';
end;

function TISAPIRequest.GetStringVariable(Index: Integer): string;
var
  LResult: UTF8String;
begin
  if Index = 25 then
  begin
    if (Length(FBytesContent) = 0) and (ECB.cbAvailable > 0) then
    begin
      SetLength(FBytesContent, ECB.cbAvailable);
      ReadClient(FBytesContent[0], ECB.cbAvailable);
    end;
                                          
    Result := DefaultCharSetEncoding.GetString(FBytesContent);
  end
  else
  begin
    case Index of
      0: LResult := ECB.lpszMethod;
      3: LResult := ECB.lpszQueryString;
      4: LResult := ECB.lpszPathInfo;
      5: LResult := ECB.lpszPathTranslated;
      10: LResult  := GetHost;
      1..2, 6..9, 11..24, 26..28: LResult := GetFieldByNameA(ServerVariables[Index]);
    end;
    Result := LResult;
  end;
end;

// Get untranslated URL so that application can support URL's with encoded characters (e.g.; encoded '/' = %2F).
function TISAPIRequest.GetRawContent: TBytes;
begin
  Result := FBytesContent;
end;

function TISAPIRequest.GetRawPathInfo: string;
var
  LHttpURL: UTF8String;
  LURL: UTF8String;
  LIndex: Integer;
  LResult: UTF8String;
begin
  LHttpUrl := GetFieldByNameA('HTTP_URL');
  LUrl := GetFieldByNameA('URL');
  LIndex := Pos(LUrl, LHttpUrl);
  if LIndex > 0 then
  begin
    LResult := Copy(LHttpUrl, LIndex + Length(LUrl), MaxInt);
    // Strip the query string
    if ECB.lpszQueryString <> '' then
    begin
      LIndex := Pos(UTF8String('?'), LResult);
      if LIndex > 0 then
         Delete(LResult, LIndex, MaxInt);
    end;
  end
  else
    LResult := ECB.lpszPathInfo; // Revert to non-raw
  Result := LResult;
end;

// Strip the port from the host name
function TISAPIRequest.GetHost: UTF8String;
var
  I: Integer;
begin
  Result := GetFieldByNameA('HTTP_HOST');
  I := Pos(UTF8String(':'), Result);
  if I > 0 then
    Delete(Result, I, MaxInt);
end;

function TISAPIRequest.GetDateVariable(Index: Integer): TDateTime;
var
  Value: string;
begin
  Value := GetStringVariable(Index);
  if Value <> '' then
    Result := ParseDate(Value)
  else Result := -1;
end;

function TISAPIRequest.GetIntegerVariable(Index: Integer): Integer;
var
  Value: string;
begin
  Value := GetStringVariable(Index);
  if Value <> '' then
    Result := StrToInt(Value)
  else Result := -1;
end;

function TISAPIRequest.ReadClient(var Buffer; Count: Integer): Integer;
begin
  Result := Count;
  if not ECB.ReadClient(ECB.ConnID, @Buffer, DWORD(Result)) then
    Result := -1;
end;

function TISAPIRequest.ReadString(Count: Integer): string;
var
  Len: Integer;
  LResult: TBytes;
begin
                                  
  SetLength(LResult, Count);
  Len := ReadClient(LResult[0], Count);
  if Len > 0 then
    SetLength(LResult, Len)
  else SetLength(LResult, 0);
                                        
  Result := DefaultCharSetEncoding.GetString(LResult);
end;

function TISAPIRequest.TranslateURI(const URI: string): string;
var
  PathBuffer: array[0..1023] of Byte;
  Size: Integer;
  LBytes: TBytes;
begin
  LBytes := DefaultCharSetEncoding.GetBytes(URI);
  Size := Length(LBytes);
  SetLength(LBytes, 1024);
  LBytes[Min(Size, Length(LBytes)-1)] := 0;  // null terminator
  Size := Length(LBytes);
  if ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_MAP_URL_TO_PATH,
    @PathBuffer, @Size, nil) then
      Result := DefaultCharSetEncoding.GetString(LBytes, 0, Size);
end;

function TISAPIRequest.WriteClient(var Buffer; Count: Integer): Integer;
begin
  Result := Count;
  if not ECB.WriteClient(ECB.ConnID, @Buffer, DWORD(Result), 0) then
    Result := -1;
end;

function TISAPIRequest.WriteString(const AString: string): Boolean;
begin
  Result := WriteClient(Pointer(AString)^, Length(AString)) = Length(AString);
end;

function TISAPIRequest.WriteHeaders(StatusCode: Integer;
  const StatusString, Headers: string): Boolean;
var
  LStatusString: UTF8String;
  LHeaders: UTF8String;
begin
  LStatusString := StatusString;
  LHeaders :=  Headers;
  TISAPIRequest(Self).ECB.dwHttpStatusCode := StatusCode;
  with TISAPIRequest(Self) do
    ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_RESPONSE_HEADER,
      PUTF8Char(LStatusString), nil, LPDWORD(LHeaders));
  Result := True;
end;

{ TISAPIResponse }

constructor TISAPIResponse.Create(HTTPRequest: TWebRequest);
begin
  inherited Create(HTTPRequest);
  InitResponse;
end;

procedure TISAPIResponse.InitResponse;
var
  LCharSet: string;
begin
  if FHTTPRequest.ProtocolVersion = '' then
    Version := '1.0'; 
  StatusCode := 200;
  LastModified := -1;
  Expires := -1;
  Date := -1;
  LCharSet := DefaultCharSet;
  if LCharSet <> '' then
    ContentType := Format('text/html; charset=%s', [LCharSet])  { do not localize }
  else
    ContentType := 'text/html';  { do not localize }
end;

function TISAPIResponse.GetContent: string;
begin
                                        
  Result := DefaultCharSetEncoding.GetString(FBytesContent);
end;

function TISAPIResponse.GetDateVariable(Index: Integer): TDateTime;
begin
  if (Index >= Low(FDateVariables)) and (Index <= High(FDateVariables)) then
    Result := FDateVariables[Index]
  else Result := 0.0;
end;

function TISAPIResponse.GetIntegerVariable(Index: Integer): Integer;
begin
  if (Index >= Low(FIntegerVariables)) and (Index <= High(FIntegerVariables)) then
    Result := FIntegerVariables[Index]
  else Result := -1;
end;

function TISAPIResponse.GetLogMessage: string;
begin
  Result := string(TISAPIRequest(HTTPRequest).ECB.lpszLogData);
end;

function TISAPIResponse.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

function TISAPIResponse.GetStringVariable(Index: Integer): string;
begin
  if (Index >= Low(FStringVariables)) and (Index <= High(FStringVariables)) then
    Result := FStringVariables[Index];
end;

function TISAPIResponse.Sent: Boolean;
begin
  Result := FSent;
end;

procedure TISAPIResponse.SetContent(const Value: string);
begin
                                        
  FBytesContent := DefaultCharSetEncoding.GetBytes(Value);
  if ContentStream = nil then
    ContentLength := Length(FBytesContent);
end;

procedure TISAPIResponse.SetDateVariable(Index: Integer; const Value: TDateTime);
begin
  if (Index >= Low(FDateVariables)) and (Index <= High(FDateVariables)) then
    if Value <> FDateVariables[Index] then
      FDateVariables[Index] := Value;
end;

procedure TISAPIResponse.SetIntegerVariable(Index: Integer; Value: Integer);
begin
  if (Index >= Low(FIntegerVariables)) and (Index <= High(FIntegerVariables)) then
    if Value <> FIntegerVariables[Index] then
      FIntegerVariables[Index] := Value;
end;

procedure TISAPIResponse.SetLogMessage(const Value: string);
var
  LValue: UTF8String;
  LLen: Integer;
begin
  LValue := Value;
  LLen := Length(TISAPIRequest(HTTPRequest).ECB.lpszLogData);
  LLen := Min(LLen, Length(LValue) + 1);    // + 1 to include null terminator
  Move(LValue[Low(LValue)], TISAPIRequest(HTTPRequest).ECB.lpszLogData[0], LLen);
  TISAPIRequest(HTTPRequest).ECB.lpszLogData[LLen-1] := Char(0);
end;

{+ ! Strings not to be resourced !!}
procedure TISAPIResponse.SetStatusCode(Value: Integer);
begin
  if FStatusCode <> Value then
  begin
    FStatusCode := Value;
    ReasonString := StatusString(Value);
  end;
end;

procedure TISAPIResponse.SetStringVariable(Index: Integer; const Value: string);
begin
  if (Index >= Low(FStringVariables)) and (Index <= High(FStringVariables)) then
    FStringVariables[Index] := Value;
end;

procedure TISAPIResponse.SendResponse;
var
  StatusString: string;
  Headers: string;
  I: Integer;

  procedure AddHeaderItem(const Item: UnicodeString; FormatStr: string); overload;
  begin
    if Item <> '' then
      Headers := Headers + Format(FormatStr, [Item]);
  end;

begin
  if HTTPRequest.ProtocolVersion <> '' then
  begin
    if (ReasonString <> '') and (StatusCode > 0) then
      StatusString := Format('%d %s', [StatusCode, ReasonString])
    else StatusString := '200 OK';                                              {do not localize }
    AddHeaderItem(Location, 'Location: %s'#13#10);                              {do not localize }
    AddHeaderItem(Allow, 'Allow: %s'#13#10);                                    {do not localize }
    for I := 0 to Cookies.Count - 1 do
      AddHeaderItem(Cookies[I].HeaderValue, 'Set-Cookie: %s'#13#10);            {do not localize }
    AddHeaderItem(DerivedFrom, 'Derived-From: %s'#13#10);                       {do not localize }
    if Expires > 0 then
      AddHeaderItem(Format(FormatDateTime(sDateFormat + ' "GMT"',               {do not localize}
        Expires), [DayOfWeekStr(Expires), MonthStr(Expires)]), 'Expires: %s'#13#10);  {do not localize}

    if LastModified > 0 then
      AddHeaderItem(Format(FormatDateTime(sDateFormat +
        ' "GMT"', LastModified), [DayOfWeekStr(LastModified),                   {do not localize}
        MonthStr(LastModified)]), 'Last-Modified: %s'#13#10);                         {do not localize}
    AddHeaderItem(Title, 'Title: %s'#13#10);                                    {do not localize }
    AddHeaderItem(FormatAuthenticate, 'WWW-Authenticate: %s'#13#10);               {do not localize }
    AddCustomHeaders(Headers);
    AddHeaderItem(ContentVersion, 'Content-Version: %s'#13#10);                 {do not localize }
    AddHeaderItem(ContentEncoding, 'Content-Encoding: %s'#13#10);               {do not localize }
    AddHeaderItem(ContentType, 'Content-Type: %s'#13#10);                       {do not localize }
    if (Length(FBytesContent) > 0) or (ContentStream <> nil) then
      AddHeaderItem(IntToStr(ContentLength), 'Content-Length: %s'#13#10);       {do not localize }
    Headers := Headers + #13#10;
    HTTPRequest.WriteHeaders(StatusCode, StatusString, Headers);
  end;
  if ContentStream = nil then
    HTTPRequest.WriteClient(FBytesContent[Low(FBytesContent)], ContentLength)
  else if ContentStream <> nil then
  begin
    SendStream(ContentStream);
    ContentStream := nil; // Drop the stream
  end;
  FSent := True;
end;

procedure TISAPIResponse.SendRedirect(const URI: string);
var
  LValue: UTF8String;
begin
  LValue := URI;
  with TISAPIRequest(FHTTPRequest) do
    ECB.ServerSupportFunction(ECB.ConnID, HSE_REQ_SEND_URL_REDIRECT_RESP,
      PUTF8Char(LValue), nil, nil);
  FSent := True;
end;

procedure TISAPIResponse.SendStream(AStream: TStream);
var
  Buffer: array[0..8191] of Byte;
  BytesToSend: Integer;
begin
  while AStream.Position < AStream.Size do
  begin
    BytesToSend := AStream.Read(Buffer, SizeOf(Buffer));
    FHTTPRequest.WriteClient(Buffer, BytesToSend);
  end;
end;

end.
