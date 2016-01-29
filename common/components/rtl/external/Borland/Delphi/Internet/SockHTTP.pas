{*******************************************************}
{                                                       }
{       Borland Delphi Visual Component Library         }
{       COM Web server application components           }
{                                                       }
{       Copyright (c) 1997-2001 Borland Software Corp   }
{                                                       }
{*******************************************************}

unit SockHTTP;

interface

uses Classes, HTTPApp, WebReq,
  SysUtils, SockRequestInterpreter;

type

  // Interface to access information about the web request
  ISockWebRequestAccess = interface(IUnknown)
    ['{E72A0846-8C34-11D3-AAF7-A0AC2E78CD57}']
    function  GetFieldByName(const Name: string): string;
    function  ReadClient(var Buffer: string; Count: Integer): Integer;
    function  TranslateURI(const Value: string): string;
    function  WriteClient(const Buffer: string): Integer;
    function  GetStringVariable(Index: Integer): string;
    function  WriteHeaders(StatusCode: Integer;
      StatusText: string; Headers: string): Boolean;
    function  UsingStub: Boolean;
    function  ReadString(var Buffer: string; Count: Integer): Integer;
  end;

  TSockWebRequest = class(TWebRequest)
  private
    FIntf: ISockWebRequestAccess;
    function UsingStub: Boolean;
  protected
    function GetStringVariable(Index: Integer): string; override;
    function GetDateVariable(Index: Integer): TDateTime; override;
    function GetIntegerVariable(Index: Integer): Integer; override;
    function GetInternalPathInfo: string; override;
  public
    constructor Create(AIntf: ISockWebRequestAccess);
    function GetFieldByName(const Name: string): string; override;
    function ReadClient(var Buffer; Count: Integer): Integer; override;
    function ReadString(Count: Integer): string; override;
    function TranslateURI(const URI: string): string; override;
    function WriteClient(var Buffer; Count: Integer): Integer; override;
    function WriteString(const AString: string): Boolean; override;
    function WriteHeaders(StatusCode: Integer; const StatusString, Headers: string): Boolean; override;
  end;

  TSockWebResponse = class(TWebResponse)
  private
    FStatusCode: Integer;
    FStringVariables: array[0..MAX_STRINGS - 1] of string;
    FIntegerVariables: array[0..MAX_INTEGERS - 1] of Integer;
    FDateVariables: array[0..MAX_DATETIMES - 1] of TDateTime;
    FContent: string;
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
  public
    constructor Create(HTTPRequest: TWebRequest);
    procedure SendResponse; override;
    procedure SendRedirect(const URI: string); override;
    procedure SendStream(AStream: TStream); override;
    function Sent: Boolean; override;
  end;

  TSockWebRequestHandler = class(TWebRequestHandler)
  private
    function NewRequest(AIntf: ISockWebRequestAccess): TSockWebRequest;
    function NewResponse(SockWebRequest: TSockWebRequest): TSockWebResponse;
    procedure HandleServerException(E: Exception;
      AIntf: ISockWebRequestAccess);
    procedure HandleException(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Run(AIntf: ISockWebRequestAccess);
  end;

implementation

uses BrkrConst, Variants;

{ TSockWebRequest }

constructor TSockWebRequest.Create(AIntf: ISockWebRequestAccess);
begin
  FIntf := AIntf;
  inherited Create;
end;

function TSockWebRequest.GetFieldByName(const Name: string): string;
begin
  Result := FIntf.GetFieldByName(Name);
end;

function VariantArrayToString(const V: OleVariant): string;
var
  P: Pointer;
  Size: Integer;
begin
  Result := '';
  if VarIsArray(V) and (VarType(V) and varTypeMask = varByte) then
  begin
    Size := VarArrayHighBound(V, 1) - VarArrayLowBound(V, 1) + 1;
    if Size > 0 then
    begin
      SetLength(Result, Size);
      P := VarArrayLock(V);
      try
        Move(P^, Result[1], Size);
      finally
        VarArrayUnlock(V);
      end;
    end;
  end;
end;

function TSockWebRequest.GetStringVariable(Index: Integer): string;
begin
  Result := FIntf.GetStringVariable(Index);
end;

function TSockWebRequest.GetDateVariable(Index: Integer): TDateTime;
var
  Value: string;
begin
  Value := GetStringVariable(Index);
  if Value <> '' then
    Result := ParseDate(Value)
  else Result := -1;
end;

function TSockWebRequest.GetIntegerVariable(Index: Integer): Integer;
var
  Value: string;
begin
  Value := GetStringVariable(Index);
  Result := StrToIntDef(Value, -1)
end;

function TSockWebRequest.ReadClient(var Buffer; Count: Integer): Integer;
var
  V: string;
begin
  Result := FIntf.ReadClient(V, Count);
  Move(V[1], Buffer, Result);
end;

function TSockWebRequest.ReadString(Count: Integer): string;
begin
  FIntf.ReadString(Result, Count);
end;

function TSockWebRequest.TranslateURI(const URI: string): string;
begin
end;

function TSockWebRequest.WriteClient(var Buffer; Count: Integer): Integer;
var
  S: string;
begin       
  SetString(S, PChar(@Buffer), Count);
  Result := FIntf.WriteClient(S);
end;

function TSockWebRequest.WriteString(const AString: string): Boolean;
begin
  if AString <> '' then
    Result := FIntf.WriteClient(AString) = Length(AString)
  else Result := False;
end;

function TSockWebRequest.WriteHeaders(StatusCode: Integer; const StatusString,
  Headers: string): Boolean;
begin
  Result := FIntf.WriteHeaders(StatusCode, StatusString,
    Headers);
end;

{ TCGIResponse }

constructor TSockWebResponse.Create(HTTPRequest: TWebRequest);
begin
  inherited Create(HTTPRequest);
  if FHTTPRequest.ProtocolVersion = '' then
    Version := '1.0';   {do not localize}
  StatusCode := 200;
  LastModified := -1;
  Expires := -1;
  Date := -1;
  ContentType := 'text/html';  {do not localize}
end;

function TSockWebResponse.GetContent: string;
begin
  Result := FContent;
end;

function TSockWebResponse.GetDateVariable(Index: Integer): TDateTime;
begin
  if (Index >= 0) and (Index < 3) then
    Result := FDateVariables[Index]
  else Result := -1;
end;

function TSockWebResponse.GetIntegerVariable(Index: Integer): Integer;
begin
  if (Index >= 0) and (Index < 2) then
    Result := FIntegerVariables[Index]
  else Result := -1;
end;

function TSockWebResponse.GetLogMessage: string;
begin
//  Result := TCGIRequest(HTTPRequest).ECB.lpszLogData;
end;

function TSockWebResponse.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

function TSockWebResponse.GetStringVariable(Index: Integer): string;
begin
  if (Index >= 0) and (Index < 12) then
    Result := FStringVariables[Index];
end;

function TSockWebResponse.Sent: Boolean;
begin
  Result := FSent;
end;

procedure TSockWebResponse.SetContent(const Value: string);
begin
  FContent := Value;
  if ContentStream = nil then
    ContentLength := Length(FContent);
end;

procedure TSockWebResponse.SetDateVariable(Index: Integer; const Value: TDateTime);
begin
  if (Index >= Low(FDateVariables)) and (Index <= High(FDateVariables)) then
    if Value <> FDateVariables[Index] then
      FDateVariables[Index] := Value;
end;

procedure TSockWebResponse.SetIntegerVariable(Index: Integer; Value: Integer);
begin
  if (Index >= Low(FIntegerVariables)) and (Index <= High(FIntegerVariables)) then
    if Value <> FDateVariables[Index] then
      FIntegerVariables[Index] := Value;
end;

procedure TSockWebResponse.SetLogMessage(const Value: string);
begin
//  StrPLCopy(TCGIRequest(HTTPRequest).ECB.lpszLogData, Value, HSE_LOG_BUFFER_LEN);
end;

procedure TSockWebResponse.SetStatusCode(Value: Integer);
begin
  if FStatusCode <> Value then
  begin
    FStatusCode := Value;
    ReasonString := StatusString(Value);
  end;
end;

procedure TSockWebResponse.SetStringVariable(Index: Integer; const Value: string);
begin
  if (Index >= Low(FStringVariables)) and (Index <= High(FStringVariables)) then
    FStringVariables[Index] := Value;
end;

procedure TSockWebResponse.SendResponse;
var
  StatusString: string;
  Headers: string;
  I: Integer;

  procedure AddHeaderItem(const Item, FormatStr: string);
  begin
    if Item <> '' then
      Headers := Headers + Format(FormatStr, [Item]);
  end;

begin
  if HTTPRequest.ProtocolVersion <> '' then
  begin
    if (ReasonString <> '') and (StatusCode > 0) then
      StatusString := Format('%d %s', [StatusCode, ReasonString]) {do not localize}
    else StatusString := '200 OK';  {do not localize}
    AddHeaderItem(Location, 'Location: %s'#13#10);  {do not localize}
    AddHeaderItem(Allow, 'Allow: %s'#13#10);  {do not localize}
    for I := 0 to Cookies.Count - 1 do
      AddHeaderItem(Cookies[I].HeaderValue, 'Set-Cookie: %s'#13#10); {do not localize}
    AddHeaderItem(DerivedFrom, 'Derived-From: %s'#13#10); {do not localize}
    if Expires > 0 then
      Format(FormatDateTime('"Expires: "' + sDateFormat + ' "GMT"'#13#10, Expires), {do not localize}
        [DayOfWeekStr(Expires), MonthStr(Expires)]);
    if LastModified > 0 then
      Format(FormatDateTime('"Last-Modified: "' + sDateFormat + ' "GMT"'#13#10, {do not localize}
        LastModified), [DayOfWeekStr(LastModified), MonthStr(LastModified)]);
    AddHeaderItem(Title, 'Title: %s'#13#10); {do not localize}
    AddHeaderItem(FormatAuthenticate, 'WWW-Authenticate: %s'#13#10); {do not localize}
    AddCustomHeaders(Headers);
    AddHeaderItem(ContentVersion, 'Content-Version: %s'#13#10); {do not localize}
    AddHeaderItem(ContentEncoding, 'Content-Encoding: %s'#13#10);  {do not localize}
    AddHeaderItem(ContentType, 'Content-Type: %s'#13#10);
    if (Content <> '') or (ContentStream <> nil) then
      AddHeaderItem(IntToStr(ContentLength), 'Content-Length: %s'#13#10); {do not localize}
    Headers := Headers + 'Content:'#13#10#13#10;  {do not localize}
    HTTPRequest.WriteHeaders(StatusCode, StatusString, Headers);
  end;
  if ContentStream = nil then
    HTTPRequest.WriteString(Content)
  else if ContentStream <> nil then
  begin
    SendStream(ContentStream);
    ContentStream := nil; // Drop the stream
  end;
  FSent := True;
end;

procedure TSockWebResponse.SendRedirect(const URI: string);
begin
  Location := URI;
  StatusCode := 302;
  ContentType := 'text/html';  {do not localize}
  Content := Format(sDocumentMoved, [URI]);
  SendResponse;
end;

procedure TSockWebResponse.SendStream(AStream: TStream);
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

{ TSockWebRequestHandler }

procedure TSockWebRequestHandler.HandleServerException(E: Exception; AIntf: ISockWebRequestAccess);
var
  ResultText, ResultHeaders, StatusString: string;
begin
  ResultText := Format(sInternalServerError, [E.ClassName, E.Message]);
  StatusString := Format('500 %s', [E.Message]);  {do not localize}
  ResultHeaders := Format(
    'Status: 500'#13#10+               //Not resourced
    'Content-Type: text/html'#13#10 +     //Not resourced
    'Content-Length: %d'#13#10 +          //Not resourced
    'Content:'#13#10#13#10, [Length(ResultText)]); //Not resourced
  AIntf.WriteHeaders(500, StatusString, ResultHeaders);
  AIntf.WriteClient(WideString(ResultText));
  { Socket web modules don't have a way to mark as sent }
  // ARequest.Sent;

end;

function TSockWebRequestHandler.NewRequest(AIntf: ISockWebRequestAccess): TSockWebRequest;
begin
  Result := TSockWebRequest.Create(AIntf);
end;

procedure TSockWebRequestHandler.Run(
  AIntf: ISockWebRequestAccess);
var
  HTTPRequest: TSockWebRequest;
  HTTPResponse: TSockWebResponse;
begin
  try
    HTTPRequest := NewRequest(AIntf);
    try
      HTTPResponse := NewResponse(HTTPRequest);
      try
        HandleRequest(HTTPRequest, HTTPResponse);
      finally
        HTTPResponse.Free;
      end;
    finally
      HTTPRequest.Free;
    end;
  except
    HandleServerException(Exception(ExceptObject), AIntf);
  end;
end;

function TSockWebRequestHandler.NewResponse(SockWebRequest: TSockWebRequest): TSockWebResponse;
begin
  Result := TSockWebResponse.Create(SockWebRequest)
end;

function TSockWebRequest.GetInternalPathInfo: string;
var
  P: Integer;
begin
  if UsingStub then
  begin
    Result := PathInfo;
    Assert(Length(Result) > 0, 'Unexpected length');
    Assert(Result[1] = '/', 'Unexpected value');
    Delete(Result, 1, 1);
    // Remove first section of path.  This is a reference
    // to the progid.
    P := Pos('/', Result);   {do not localize}
    if P > 0 then
      Delete(Result, 1, P-1)
    else
      Result := '/';
  end
  else
    Result := inherited GetInternalPathInfo;
end;

function TSockWebRequest.UsingStub: Boolean;
begin
  Result := FIntf.UsingStub;
end;

constructor TSockWebRequestHandler.Create(AOwner: TComponent);
begin
  inherited;
  Classes.ApplicationHandleException := HandleException;
end;

destructor TSockWebRequestHandler.Destroy;
begin
  Classes.ApplicationHandleException := nil;
  inherited;
end;

procedure TSockWebRequestHandler.HandleException(Sender: TObject);
var
  Handled: Boolean;
  Intf: IWebExceptionHandler;
begin
  Handled := False;
  if (ExceptObject is Exception) and
    not (ExceptObject is EAbort) and
    Supports(Sender, IWebExceptionHandler, Intf) then
      Intf.HandleException(Exception(ExceptObject), Handled);
  if not Handled then
    SysUtils.ShowException(ExceptObject, ExceptAddr);
end;

end.

