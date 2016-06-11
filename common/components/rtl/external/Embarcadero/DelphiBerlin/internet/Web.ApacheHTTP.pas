{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{ *************************************************************************** }
{                                                                             }
{ Licensees holding a valid Borland No-Nonsense License for this Software may }
{ use this file in accordance with such license, which appears in the file    }
{ license.txt that came with this Software.                                   }
{                                                                             }
{ *************************************************************************** }


unit Web.ApacheHTTP;

interface

uses System.SysUtils, System.Classes, Web.HTTPDMethods, Web.HTTPApp;

{$WARN IMPLICIT_STRING_CAST OFF}

type
  TApacheRequest = class(TWebRequest)
  private
    FBytesContent: TBytes;
    FContentType: string;
    FRequest_rec: PHTTPDRequest;
  protected
    function GetStringVariable(Index: Integer): string; override;
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetRawContent: TBytes; override;
    procedure DoReadTotalContent; override;
  public
    constructor Create(r: PHTTPDRequest);
    function GetFieldByName(const Name: string): string; override;
    function ReadClient(var Buffer; Count: Integer): Integer; override;
    function ReadString(Count: Integer): string; override;
    function TranslateURI(const URI: string): string; override;
    function WriteClient(var Buffer; Count: Integer): Integer; override;
    function WriteString(const AString: string): Boolean; override;
    function WriteHeaders(StatusCode: Integer; const StatusString, Headers: string): Boolean; override;
  end;

  TApacheResponse = class(TWebResponse)
  private
    FStatusCode: integer;
    FReturnCode: integer;
    FStringVariables: array[0..MAX_STRINGS - 1] of string;
    FIntegerVariables: array[0..MAX_INTEGERS - 1] of Integer;
    FDateVariables: array[0..MAX_DATETIMES - 1] of TDateTime;
    FBytesContent: TBytes;
    FLogMsg: string;
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
    property ReturnCode: integer read FReturnCode write FReturnCode;
  end;

implementation

uses System.Math;

constructor TApacheRequest.Create(r: PHTTPDRequest);
begin
  FRequest_rec := r; //@r;
  FContentType := THTTPDMethods.get_ContentType(FRequest_rec);
  FBytesContent := THTTPDMethods.get_Content(FRequest_rec);

  // The ancestor's constructor must be called after fRequest_rec is initialized
  inherited Create;
end;

function TApacheRequest.GetFieldByName(const Name: string): string;
begin
  //Result := apr_table_getx(FRequest_rec^.headers_in, PUTF8Char(UTF8String(Name)));
  Result :=  THTTPDMethods.get_Field(FRequest_rec, Name)
end;

function TApacheRequest.GetStringVariable(Index: Integer): string;
var
  len: Integer;
  p: pchar;
  value: string;
begin
  case Index of
    0: value := THTTPDMethods.get_method(FRequest_rec); //FRequest_rec^.method;
    1: value := THTTPDMethods.get_protocol(FRequest_rec); //FRequest_rec^.protocol;
    2: value := THTTPDMethods.get_unparsed_uri(FRequest_rec); //FRequest_rec^.unparsed_uri;
    3: value := THTTPDMethods.get_args(FRequest_rec); //FRequest_rec^.args;
    4: value := THTTPDMethods.get_path_info(FRequest_rec); //FRequest_rec^.path_info;
    5: value := THTTPDMethods.get_filename(FRequest_rec); //FRequest_rec^.filename;
    7: value := '';       // Request Date
    8: value := THTTPDMethods.get_headers_in_Accept(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'Accept');
    9: value := THTTPDMethods.get_headers_in_From(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'From');
    10: value := THTTPDMethods.get_hostname(FRequest_rec); //FRequest_rec^.hostname;
    12: value := THTTPDMethods.get_headers_in_Referer(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'Referer');
    13: value := THTTPDMethods.get_headers_in_UserAgent(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'User-Agent');
    14: value := THTTPDMethods.get_content_encoding(FRequest_rec); //FRequest_rec^.content_encoding;
    15: value := THTTPDMethods.get_headers_in_ContentType(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'Content-Type');
    16: value := THTTPDMethods.get_headers_in_ContentLength(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'Content-Length');
    19: value := '';      // Expires
    20: value := THTTPDMethods.get_headers_in_Title(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'Title');
    21: value := THTTPDMethods.get_connection_ClientIP(FRequest_rec); //Request_Connection_ClientIP(FRequest_rec^.connection);
    22: value := THTTPDMethods.get_connection_RemoteHost(FRequest_rec); //ap_get_remote_hostx(FRequest_rec^.connection,FRequest_rec^.per_dir_config, REMOTE_HOSTx, nil);
    23: begin
          value := THTTPDMethods.get_unparsed_uri(FRequest_rec); //FRequest_rec^.unparsed_uri;
          p := StrScan(pchar(value), '?');
          if p <> nil then
            len := p - PChar(value)
          else
            len := length(value);
          value := copy(value, 1, len - length(PathInfo));
        end;
    24: value := THTTPDMethods.get_ServerPort(FRequest_rec); //string(IntToStr(ap_get_server_portx(FRequest_rec)));
    25: begin
          ReadTotalContent;
                                                
          value := DefaultCharSetEncoding.GetString(FBytesContent);
        end;
    26: value :=  THTTPDMethods.get_headers_in_Connection(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'Connection');
    27: value := THTTPDMethods.get_headers_in_Cookie(FRequest_rec); //apr_table_getx(FRequest_rec^.headers_in, 'Cookie');
    28: value := THTTPDMethods.get_headers_in_Authorization(FRequest_rec);
   else
      value := '';
  end;
  Result := value;
end;

function TApacheRequest.GetDateVariable(Index: Integer): TDateTime;
var
  Value: string;
begin
  Value := GetStringVariable(Index);
  if Value <> '' then
    Result := ParseDate(Value)
  else Result := -1;
end;

function TApacheRequest.GetIntegerVariable(Index: Integer): Integer;
var
  Value: string;
begin
  Value := GetStringVariable(Index);
  if Value <> '' then
    Result := StrToInt(Value)
  else Result := -1;
end;

function TApacheRequest.GetRawContent: TBytes;
begin
  Result := FBytesContent;
end;

procedure TApacheRequest.DoReadTotalContent;
var
  ReadNow: Integer;
  Size: Integer;
  Count: Integer;
begin
  Count := ContentLength;
  ReadNow := Length(FBytesContent);
  if ReadNow < Count then
  begin
    SetLength(FBytesContent, Count);
    Size := Count - ReadNow;
    while Size > 0 do
    begin
      ReadNow := ReadClient(FBytesContent[Count-Size], Size);
      // FileRead returns -1 when there is an error so we should break out of
      // this loop in that case as well as when there is no data left to read.
      if ReadNow <= 0 then break;
      Dec(Size, ReadNow);
    end;
  end;
end;

function TApacheRequest.ReadClient(var Buffer; Count: Integer): Integer;
begin
  Result := THTTPDMethods.get_client_block(FRequest_rec, @Buffer, Count);
end;

function TApacheRequest.ReadString(Count: Integer): string;
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

function TApacheRequest.TranslateURI(const URI: string): string;
begin
  Result := string(THTTPDMethods.server_root_relative(FRequest_rec, URI));
{$IFDEF MSWINDOWS}
  Result := UnixPathToDosPath(Result);
{$ENDIF}
end;

{buffer is void type, hence: var Buffer}
function TApacheRequest.WriteClient(var Buffer; Count: Integer): Integer;
begin
  Result := 0;
  if Count > 0 then
    //Result := ap_rwritex(Buffer, Count, FRequest_rec)
    Result := THTTPDMethods.write_buffer(FRequest_rec, Buffer, Count);
end;

function TApacheRequest.WriteHeaders(StatusCode: Integer; const StatusString, Headers: string): Boolean;
begin
  THTTPDMethods.set_status(FRequest_rec, StatusCode); // FRequest_rec.status := StatusCode;
//  ap_send_http_header(FRequest_rec); // Not needed in apache 2.0
  Result := true;
end;

function TApacheRequest.WriteString(const AString: string): Boolean;
begin
  Result:= true;
   if Astring <> '' then
     Result := THTTPDMethods.write_string(FRequest_rec, Astring) = length(Astring);
end;

// TApacheResponse methods

constructor TApacheResponse.Create(HTTPRequest: TWebRequest);
begin
  inherited Create(HTTPRequest);
  InitResponse;
end;

procedure TApacheResponse.InitResponse;
begin
  if FHTTPRequest.ProtocolVersion = '' then
    Version := '1.0';
  StatusCode := 200; // HTTP_OKx;
  ReturnCode :=  THTTPDMethods.get_AP_OK; //AP_OKx;
  LastModified := -1;
  Expires := -1;
  Date := -1;
  ContentType := 'text/html';
end;

function TApacheResponse.GetContent: string;
begin
                                        
  Result := DefaultCharSetEncoding.GetString(FBytesContent);
end;

function TApacheResponse.GetDateVariable(Index: Integer): TDateTime;
begin
  if (Index >= Low(FDateVariables)) and (Index <= High(FDateVariables)) then
    Result := FDateVariables[Index]
  else Result := 0.0;
end;

function TApacheResponse.GetIntegerVariable(Index: Integer): Integer;
begin
  if (Index >= Low(FIntegerVariables)) and (Index <= High(FIntegerVariables)) then
    Result := FIntegerVariables[Index]
  else Result := -1;
end;

function TApacheResponse.GetLogMessage: string;
begin
  Result := fLogMsg;
end;

function TApacheResponse.GetStatusCode: Integer;
begin
  result := FStatusCode;
end;

function TApacheResponse.GetStringVariable(Index: Integer): string;
begin
  if (Index >= Low(FStringVariables)) and (Index <= High(FStringVariables)) then
    Result := FStringVariables[Index];
end;

function TApacheResponse.Sent: Boolean;
begin
  Result := FSent;
end;

procedure TApacheResponse.SetContent(const Value: string);
begin
                                            
  FBytesContent := DefaultCharSetEncoding.GetBytes(Value);
  if ContentStream = nil then
    ContentLength := Length(FBytesContent);
end;

procedure TApacheResponse.SetDateVariable(Index: Integer; const Value: TDateTime);
begin
  if (Index >= Low(FDateVariables)) and (Index <= High(FDateVariables)) then
    if Value <> FDateVariables[Index] then
      FDateVariables[Index] := Value;
end;

procedure TApacheResponse.SetIntegerVariable(Index: Integer; Value: Integer);
begin
  if (Index >= Low(FIntegerVariables)) and (Index <= High(FIntegerVariables)) then
    if Value <> FIntegerVariables[Index] then
      FIntegerVariables[Index] := Value;
end;

procedure TApacheResponse.SetLogMessage(const Value: string);
begin
  FLogMsg := Value;
end;

procedure TApacheResponse.SetStatusCode(Value: Integer);
begin
  if FStatusCode <> Value then
  begin
    FStatusCode := Value;
    ReasonString := StatusString(Value);
  end;
end;

procedure TApacheResponse.SetStringVariable(Index: Integer; const Value: string);
begin
  if (Index >= Low(FStringVariables)) and (Index <= High(FStringVariables)) then
    FStringVariables[Index] := Value;
end;

procedure TApacheResponse.SendResponse;
var
  i: Integer;
  ServerMsg: string;

  //embedded
  procedure AddHeaderItem(const Key, Value: string); overload;
  begin
    if (Key <> '') and (Value <> '') then
      with TApacheRequest(FHTTPRequest) do
        THTTPDMethods.set_headers_out(FRequest_rec, Key, Value);
  end;
  //embedded
  procedure AddCustomHeaders;
  var
    i: integer;
    Name: string;
  begin
    for i := 0 to FCustomHeaders.Count - 1 do
    begin
      Name := FCustomHeaders.Names[I];
      addHeaderItem(Name, FCustomHeaders.values[Name]);
    end;
  end;

begin
  if HTTPRequest.ProtocolVersion <> '' then
  begin
    if StatusCode > 0 then
      ServerMsg := Format('%d %s', [StatusCode, ReasonString]);

    AddHeaderItem('Allow', Allow); {do not localize}

    for I := 0 to Cookies.Count - 1 do
    begin
      if (Cookies[I].HeaderValue <> '') then
        with TApacheRequest(FHTTPRequest) do
          THTTPDMethods.set_headers_out(FRequest_rec, 'Set-Cookie', {do not localize}
           PUTF8Char(UTF8String(Cookies[I].HeaderValue)));
    end;

    AddHeaderItem('Derived-From', DerivedFrom); {do not localize}

    if Expires > 0 then
      AddHeaderItem('Expires', Format(FormatDateTime(sDateFormat + ' "GMT"',               {do not localize}
        Expires), [DayOfWeekStr(Expires), MonthStr(Expires)]));  {do not localize}

    if LastModified > 0 then
      AddHeaderItem('Last-Modified', Format(FormatDateTime(sDateFormat +
        ' "GMT"', LastModified), [DayOfWeekStr(LastModified),                   {do not localize}
        MonthStr(LastModified)]));                         {do not localize}

    AddHeaderItem('Title', Title);  {do not localize}
    AddHeaderItem('WWW-Authenticate', WWWAuthenticate); {do not localize}
    AddCustomHeaders;
    AddHeaderItem('Content-Version', ContentVersion); {do not localize}

    if ContentType <> '' then
      THTTPDMethods.set_headers_out_ContentType(TApacheRequest(FHTTPRequest).FRequest_rec, ContentType);
    if ContentEncoding <> '' then
      THTTPDMethods.set_headers_out_ContentEncoding(TApacheRequest(FHTTPRequest).FRequest_rec, ContentEncoding);

    if (Length(FBytesContent) <> 0) or (ContentStream <> nil) then
    begin
      Assert((Length(FBytesContent) = 0) or (Length(FBytesContent) = ContentLength));
      AddHeaderItem('Content-Length', IntToStr(ContentLength));  {do not localize}
    end;

    HTTPRequest.WriteHeaders(StatusCode, ServerMsg, '');
  end;

  if ContentStream = nil then
    HTTPRequest.WriteClient(FBytesContent[0], Length(FBytesContent))
  else if ContentStream <> nil then
  begin
    SendStream(ContentStream);
    ContentStream := nil; // Drop the stream  - memory leak?
  end;
  //ContentStream.Free; //no need stream is destroyed in destructor TWebResponse.Destroy;
  FSent := True;
end;

procedure TApacheResponse.SendRedirect(const URI: string);
begin
  with TApacheRequest(FHTTPRequest) do
  begin
    THTTPDMethods.set_location(FRequest_rec, URI);
    FStatusCode := 302; // HTTP_MOVED_TEMPORARILYx;
  end;
  FSent := False;
end;

procedure TApacheResponse.SendStream(AStream: TStream);
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
