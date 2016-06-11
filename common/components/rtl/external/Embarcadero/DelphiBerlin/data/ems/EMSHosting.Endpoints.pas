{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.Endpoints;

{$SCOPEDENUMS ON}

interface

uses System.SysUtils, System.Classes, System.Generics.Collections, System.JSON,
 EMS.ResourceAPI, EMSHosting.RequestTypes, System.JSON.Writers, System.JSON.Readers;

type

  TEndpointParamsImpl = class(TEndpointParams)
  private type
    TPairItem = TEndpointParams.TPairItem;
    TPairs = TArray<TPairItem>;
  private
    FList: TList<TPairItem>;
  protected
    function GetCount: Integer; override;
    function GetPair(const Index: Integer): TPairItem; override;
    procedure DoAdd(const AName, AValue: string); override;
  public
    constructor Create; overload;
    constructor Create(const APairs: TArray<TPairItem>); overload;
    destructor Destroy; override;
    function TryGetValue(const AName: string; out AValue: string): Boolean; override;
    function Contains(const AName: string): Boolean; override;
  end;

  TEndpointSegmentsImpl = class(TEndpointSegments)
  private
    FList: TList<string>;
  protected
    function GetCount: Integer; override;
    function GetItem(const AIndex: Integer): string; override;
  public
    constructor Create; overload;
    constructor Create(const ASegments: TArray<string>); overload;
    destructor Destroy; override;
  end;

  TEndpointRequestHeadersImpl = class(TEndpointHeaders)
  private
    FRequest: IEMSHostRequest;
  public
    constructor Create(const ARequest: IEMSHostRequest);
    function TryGetValue(const AName: string; out AValue: string): Boolean; override;
  end;

  TEndpointResponseHeadersRWImpl = class(TEndpointHeaders)
  private
    FResponse: IEMSHostResponse;
  protected
    procedure DoSetValue(const AName, AValue: string); override;
  public
    constructor Create(const AResponse: IEMSHostResponse);
    function TryGetValue(const AName: string; out AValue: string): Boolean; override;
  end;

  TEndpointParamsImplW = class abstract(TEndpointParamsImpl)
  private type
    TPairItem = TEndpointParams.TPairItem;
  protected
    procedure DoAdd(const AName, AValue: string); override;
  end;

  TEndpointSegmentsImplW = class abstract(TEndpointSegmentsImpl)
  protected
    procedure DoAdd(const AValue: string); override;
  end;

  TEndpointRequestParams = TEndpointParamsImpl;

  TEndpontResponseParams = TEndpointParamsImplW;

  TBodyReader = class
  private
    FContentType: string;
    FRawContent: TBytes;
    FContentLength: Integer;
    FStream: TStream;
    FValue: TJSONValue;
    FJSONReader: TJSONTextReader;
    FStreamReader: TTextReader;
    function GetJSONReader: TJSONTextReader;
  public
    constructor Create(const AContentType: string; AContentLength: Integer;
      const ARawContent: TBytes); overload;
    constructor Create(const AContentType: string; const AContentStream: TStream); overload;
    destructor Destroy; override;
    function GetContentType: string;
    function TryGetArray(out AJSONArray: TJSONArray): Boolean;
    function TryGetBytes(out ABytes: TBytes): Boolean;
    function TryGetObject(out AJSONObject: TJSONObject): Boolean;
    function TryGetStream(out AStream: TStream): Boolean; overload;
    function TryGetStream(out AStream: TStream; out AContentType: string): Boolean; overload;
    function TryGetValue(out AJSONValue: TJSONValue): Boolean;
    property JSONReader: TJSONTextReader read GetJSONReader;
    property ContentType: string read GetContentType;
  end;

  TEndpointRequestBodyImpl = class(TEndpointRequestBody)
  private
    FBodyReader: TBodyReader;
  protected
    function GetContentType: string; override;
    function GetJSONReader: TJsonTextReader; override;
  public
    constructor Create(const ARequest: IEMSHostRequest);
    destructor Destroy; override;
    function TryGetStream(out AStream: TStream): Boolean; overload; override;
    function TryGetStream(out AStream: TStream; out AContentType: string): Boolean; overload; override;
    function TryGetObject(out AJSONObject: TJSONObject): Boolean; override;
    function TryGetArray(out AJSONArray: TJSONArray): Boolean; override;
    function TryGetValue(out AJSONValue: TJSONValue): Boolean; override;
    function TryGetBytes(out ABytes: TBytes): Boolean; override;
  end;

  TEndpointResponseBodyImpl = class(TEndpointResponseBody)
  private
    FHostResponse: IEMSHostResponse;
    FJSONWriter: TJSONTextWriter;
    FWriterStream: TStream;
    FTextWriter: TTextWriter;
  protected
    function GetJSONWriter: TJsonTextWriter; override;
  public
    procedure SetValue(const AJSONValue: TJSONValue; AOwnsValue: Boolean); override;
    procedure SetBytes(const ABytes: TBytes; const AContentType: string); override;
    procedure SetStream(const AStream: TStream; const AContentType: string; AOwnsValue: Boolean); override;
  public
    constructor Create(const AHostResponse: IEMSHostResponse);
    destructor Destroy; override;
    procedure Write;
  end;

  TEndpointContextImpl = class(TEndpointContext)
  public type
    TUser = TEndpointContext.TUser;
    TGroups = TEndpointContext.TGroups;
    TEdgemodule = TEndpointContext.TEdgemodule;
    TGetEndpointNameCallback = reference to function: string;
    TCreateUserCallback = reference to procedure(const AContext: TEndpointContextImpl; out AUser: TUser);
    TCreateEdgemoduleCallback = reference to procedure(const AContext: TEndpointContextImpl; out AEdgemodule: TEdgemodule);
    TGetRequestCallback = reference to function: TEndpointRequest;
    TGetResponseCallback = reference to function: TEndpointResponse;
    TGetAuthenticatedCallback = reference to function: TEndpointContext.TAuthenticated;
    TEndpointDataType = (None, AddUser, DeletedUser, LoginUser);
  private
    FEndpontDataValue: string;
    FEndpointDataType: TEndpointDataType;
    FUser: TUser;
    FEdgemodule: TEdgemodule;
    FUserCreated: Boolean;
    FEdgemoduleCreated: Boolean;
    FOnCreateUser: TCreateUserCallback;
    FOnCreateEdgemodule: TCreateEdgemoduleCallback;
    FOnGetResponse: TGetResponseCallback;
    FOnGetRequest: TGetRequestCallback;
    FOnGetAuthenticated: TGetAuthenticatedCallback;
    FOnGetEndpointName: TGetEndpointNameCallback;
    FCreatorRequired: Boolean;
  protected
    function GetUser: TUser; override;
    function GetEdgemodule: TEdgemodule; override;
    function GetAuthenticated: TEndpointContext.TAuthenticated; override;
    function GetRequest: TEndpointRequest; override;
    function GetResponse: TEndpointResponse; override;
    function GetEndpointName: string; override;
  public
    destructor Destroy; override;
    property OnCreateUser: TCreateUserCallback read FOnCreateUser write FOnCreateUser;
    property OnCreateEdgemodule: TCreateEdgemoduleCallback read FOnCreateEdgemodule write FOnCreateEdgemodule;
    property OnGetRequest: TGetRequestCallback read FOnGetRequest write FOnGetRequest;
    property OnGetResponse: TGetResponseCallback read FOnGetResponse write FOnGetResponse;
    property OnGetAuthenticated: TGetAuthenticatedCallback read FOnGetAuthenticated write FOnGetAuthenticated;
    property OnGetEndpointName: TGetEndpointNameCallback read FOnGetEndpointName write FOnGetEndpointName;
    // Internal use
    procedure SetEndpointData(AStatus: TEndpointDataType; const AValue: string);
    procedure SetCreatorRequired;
    property EndpointDataType: TEndpointDataType read FEndpointDataType;
    property EndpointDataValue: string read FEndpontDataValue;
    property CreatorRequired: Boolean read FCreatorRequired;
  end;

  TEndpointRequestImpl = class(TEndpointRequest)
  private type
    THeaders = TEndpointRequest.THeaders;
    TParams = TEndpointRequest.TParams;
    TBody = TEndpointRequest.TBody;
    TMethod = TEndpointRequest.TMethod;
    TSegments = TEndpointRequest.TSegments;
  private
    FHostRequest: IEMSHostRequest;
    FParams: TParams;
    FHeaders: THeaders;
    FBody: TBody;
    FSegments: TSegments;
  protected
    function GetHeaders: THeaders; override;
    function GetParams: TParams; override;
    function GetSegments: TSegments; override;
    function GetBody: TBody; override;
    function GetMethod: TMethod; override;
    function GetMethodString: string; override;
    function GetResource: string; override;
    function GetBasePath: string; override;
    function GetServerHost: string; override;
  public
    constructor Create(const AHostRequest: IEMSHostRequest);
    destructor Destroy; override;
    property HostRequest: IEMSHostRequest read FHostRequest;
  end;

  TEndpointResponseImpl = class(TEndpointResponse)
  public type
    THeaders = TEndpointResponse.THeaders;
    TBody = TEndpointResponse.TBody;
  private
    FHostResponse: IEMSHostResponse;
    FHeaders: THeaders;
    FBody: TBody;
  protected
    function GetHeaders: THeaders; override;
    function GetBody: TBody; override;
    procedure SetStatusCode(ACode: Integer); override;
  public
    constructor Create(const AHostResponse: IEMSHostResponse);
    destructor Destroy; override;
    procedure SetCreated(const ALocation: string; AStatusCode: Integer = 201); override;
    procedure Write;
    property HostResponse: IEMSHostResponse read FHostResponse;
  end;

implementation


uses EMSHosting.Utility, System.JSON.Types;

{ TEndpointParamsImpl }

constructor TEndpointParamsImpl.Create(const APairs: TArray<TPairItem>);
begin
  Create;
  FList.AddRange(APairs);
end;

destructor TEndpointParamsImpl.Destroy;
begin
  FList.Free;
  inherited;
end;

procedure TEndpointParamsImpl.DoAdd(const AName, AValue: string);
begin
  FList.Add(TPairItem.Create(AName, AValue));
end;

constructor TEndpointParamsImpl.Create;
begin
  FList := TList<TPairItem>.Create;
end;

function TEndpointParamsImpl.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TEndpointParamsImpl.GetPair(const Index: Integer): TPairItem;
begin
  Result := FList[Index];
end;

function TEndpointParamsImpl.TryGetValue(const AName: string; out AValue: string): Boolean;
var
  LPair: TPairItem;
begin
  Result := False;
  for LPair in FList do
    if SameText(LPair.Key, AName) then
    begin
      Result := True;
      AValue := LPair.Value;
      break;
    end;
end;

function TEndpointParamsImpl.Contains(const AName: string): Boolean;
var
  LPair: TPairItem;
begin
  Result := False;
  for LPair in FList do
    if LPair.Key = AName then
    begin
      Result := True;
      break;
    end;
end;

{ TEndpointParamsImplW }

procedure TEndpointParamsImplW.DoAdd(const AName, AValue: string);
begin
  FList.Add(TPair<string, string>.Create(AName, AValue))
end;

{ TEndpointSegmentsImpl }

constructor TEndpointSegmentsImpl.Create(const ASegments: TArray<string>);
begin
  Create;
  FList.AddRange(ASegments);
end;

destructor TEndpointSegmentsImpl.Destroy;
begin
  FList.Free;
  inherited;
end;

constructor TEndpointSegmentsImpl.Create;
begin
  FList := TList<string>.Create;
end;

function TEndpointSegmentsImpl.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TEndpointSegmentsImpl.GetItem(const AIndex: Integer): string;
begin
  Result := FList[AIndex];
end;

{ TEndpointSegmentsImplW }

procedure TEndpointSegmentsImplW.DoAdd(const AValue: string);
begin
  FList.Add(AValue);
end;

{ TBodyReader }

constructor TBodyReader.Create(const AContentType: string; AContentLength: Integer; const ARawContent: TBytes);
begin
  FContentType := AContentType;
  FRawContent := ARawContent;
  FContentLength := AContentLength;
end;

constructor TBodyReader.Create(const AContentType: string;
  const AContentStream: TStream);
var
  LBytes: TBytes;
begin
  if AContentStream <> nil then
  begin
    SetLength(LBytes, AContentStream.Size);
    AContentStream.Seek(0, TSeekOrigin.soBeginning);
    AContentStream.Read(LBytes, AContentStream.Size);
  end;
  Create(AContentType, Length(LBytes), LBytes);
end;

destructor TBodyReader.Destroy;
begin
  FJSONReader.Free;
  FStreamReader.Free;
  FStream.Free;
  FValue.Free;
  inherited;
end;

function TBodyReader.GetContentType: string;
begin
  Result := FContentType;
end;

function TBodyReader.GetJSONReader: TJSONTextReader;
var
  LStream: TStream;
begin
  if FJSONReader = nil then
  begin
    if not TryGetStream(LStream) then
      FStream := TMemoryStream.Create; // Empty stream
                          
    FStreamReader := TStreamReader.Create(FStream);
    FJSONReader := TJsonTextReader.Create(FStreamReader);
  end;
  Result := FJSONReader;
end;

function TBodyReader.TryGetArray(
  out AJSONArray: TJSONArray): Boolean;
var
  LValue: TJSONValue;
begin
  Result := TryGetValue(LValue) and (LValue is TJSONArray);
  if Result then
    AJSONArray := TJSONArray(LValue);
end;

function TBodyReader.TryGetBytes(out ABytes: TBytes): Boolean;
begin
  Result := FContentLength > 0;
  if Result then
    ABytes := FRawContent;
end;

function TBodyReader.TryGetObject(
  out AJSONObject: TJSONObject): Boolean;
var
  LValue: TJSONValue;
begin
  Result := TryGetValue(LValue) and (LValue is TJSONObject);
  if Result then
    AJSONObject := TJSONObject(LValue);
end;

function TBodyReader.TryGetStream(
  out AStream: TStream): Boolean;
begin
  if (FStream = nil) and (FContentLength > 0) then
    FStream := TBytesStream.Create(FRawContent);
  AStream := FStream;
  Result := AStream <> nil;
end;

function TBodyReader.TryGetStream(
  out AStream: TStream; out AContentType: string): Boolean;
begin
  Result := Self.TryGetStream(AStream);
  if Result then
    AContentType := FContentType;
end;

function TBodyReader.TryGetValue(
  out AJSONValue: TJSONValue): Boolean;
var
  LBytes: TBytes;
  LUTF8: Boolean;
begin
  if (FValue = nil) and (FContentLength > 0) then
  begin
    LUTF8 := True;        
    Result := TryGetBytes(LBytes);
    if Result then
    begin
      FValue := TJSONObject.ParseJSONValue(LBytes, 0, LUTF8);
    end;
  end;
  AJSONValue := FValue;
  Result := FValue <> nil;
end;


{ TEndpointRequestBodyImpl }

constructor TEndpointRequestBodyImpl.Create(
  const ARequest: IEMSHostRequest);
begin
                                         
  FBodyReader := TBodyReader.Create(ARequest.ContentType, ARequest.ContentLength, ARequest.RawContent);
end;

destructor TEndpointRequestBodyImpl.Destroy;
begin
  FBodyReader.Free;
  inherited;
end;

function TEndpointRequestBodyImpl.GetContentType: string;
begin
  Result := FBodyReader.ContentType;
end;

function TEndpointRequestBodyImpl.GetJSONReader: TJsonTextReader;
begin
  Result := FBodyReader.GetJSONReader;
end;

function TEndpointRequestBodyImpl.TryGetArray(
  out AJSONArray: TJSONArray): Boolean;
begin
  Result := FBodyReader.TryGetArray(AJSONArray);
end;

function TEndpointRequestBodyImpl.TryGetBytes(out ABytes: TBytes): Boolean;
begin
  Result := FBodyReader.TryGetBytes(ABytes);
end;

function TEndpointRequestBodyImpl.TryGetObject(
  out AJSONObject: TJSONObject): Boolean;
begin
  Result := FBodyReader.TryGetObject(AJSONObject);
end;

function TEndpointRequestBodyImpl.TryGetStream(
  out AStream: TStream): Boolean;
begin
  Result := FBodyReader.TryGetStream(AStream);
end;

function TEndpointRequestBodyImpl.TryGetStream(
  out AStream: TStream; out AContentType: string): Boolean;
begin
  Result := FBodyReader.TryGetStream(AStream, AContentType);
end;

function TEndpointRequestBodyImpl.TryGetValue(
  out AJSONValue: TJSONValue): Boolean;
begin
  Result := FBodyReader.TryGetValue(AJSONValue);
end;

{ TEndpointResponseBodyImpl }

constructor TEndpointResponseBodyImpl.Create(
  const AHostResponse: IEMSHostResponse);
begin
  FHostResponse := AHostResponse;
end;

destructor TEndpointResponseBodyImpl.Destroy;
begin
  inherited;
  FJSONWriter.Free;
  FTextWriter.Free;
  FWriterStream.Free;
end;

function TEndpointResponseBodyImpl.GetJSONWriter: TJsonTextWriter;
begin
  if FJSONWriter = nil then
  begin
    FWriterStream := TBytesStream.Create;
    FTextWriter := TStreamWriter.Create(FWriterStream);
    FJSONWriter := TJsonTextWriter.Create(FTextWriter);
    FJSONWriter.StringEscapeHandling :=  TJsonStringEscapeHandling.EscapeNonAscii;
  end;
  Result := FJSONWriter;
end;

procedure TEndpointResponseBodyImpl.SetBytes(const ABytes: TBytes;
  const AContentType: string);
var
  LStream: TMemoryStream;
begin
  LStream := TMemoryStream.Create;
  try
    LStream.WriteData(ABytes, Length(ABytes));
    LStream.Seek(0, TSeekOrigin.soBeginning);
    SetStream(LStream, AContentType, True);  // Do not localize
  except
    LStream.Free;
    raise;
  end;
end;

procedure TEndpointResponseBodyImpl.SetStream(const AStream: TStream;
  const AContentType: string; AOwnsValue: Boolean);
var
  LStream: TStream;
begin
  FHostResponse.ContentType := AContentType; // AnsiString(AContentType);
  AStream.Seek(0, TSeekOrigin.soBeginning);
  if AOwnsValue then
    FHostResponse.ContentStream := AStream
  else
  begin
    LStream := TMemoryStream.Create;
    LStream.CopyFrom(AStream, AStream.Size);
    FHostResponse.ContentStream := LStream;
  end;
end;


procedure TEndpointResponseBodyImpl.SetValue(const AJSONValue: TJSONValue; AOwnsValue: Boolean);
var
  LStream: TStringStream;
begin
  LStream := TStringStream.Create;
  try
    LStream.WriteString(AJSONValue.ToJSON);
    LStream.Seek(0, TSeekOrigin.soBeginning);
    SetStream(LStream, 'application/json', True);  // Do not localize
  except
    LStream.Free;
    raise;
  end;
{$IFNDEF NEXTGEN} // Prevent warning
  if AOwnsValue then
    AJSONValue.Free;
{$ENDIF}

end;

procedure TEndpointResponseBodyImpl.Write;
begin
  if FWriterStream <> nil then
  begin
    FreeAndNil(FJSONWriter);
    SetStream(FWriterStream, 'application/json', True);
    FreeAndNil(FTextWriter);
    FWriterStream := nil;
  end;
 end;

{ TEndpointRequestImpl }

constructor TEndpointRequestImpl.Create(const AHostRequest: IEMSHostRequest);
begin
  FHostRequest := AHostRequest;
end;

destructor TEndpointRequestImpl.Destroy;
begin
  FHeaders.Free;
  FParams.Free;
  FBody.Free;
  FSegments.Free;
  inherited;
end;

function TEndpointRequestImpl.GetBasePath: string;
begin
  Result := string(FHostRequest.GetBasePath);
end;

function TEndpointRequestImpl.GetServerHost: string;
begin
  Result := string(FHostRequest.GetServerHost);
end;

function TEndpointRequestImpl.GetBody: TBody;
begin
  if FBody = nil then
    FBody := TEndpointRequestBodyImpl.Create(FHostRequest);
  Result := FBody;
end;

function TEndpointRequestImpl.GetResource: string;
begin

  if (Segments.Count > 0) and (Segments[0] <> '/') then
    Result := Segments[0]
  else if (Segments.Count > 1) then
    Result := Segments[1];
  if Result.EndsWith('/') then
    Result := Result.Substring(0, Result.Length - 1);
end;

function TEndpointRequestImpl.GetHeaders: THeaders;
begin
  if FHeaders = nil then
  begin
    FHeaders := TEndpointRequestHeadersImpl.Create(FHostRequest);
  end;
  Result := FHeaders;
end;

function TEndpointRequestImpl.GetMethod: TMethod;
begin
  case FHostRequest.MethodType of
    TEMSHostMethodType.Get: Result := TMethod.Get;
    TEMSHostMethodType.Put: Result := TMethod.Put;
    TEMSHostMethodType.Post: Result := TMethod.Post;
    TEMSHostMethodType.Delete: Result := TMethod.Delete;
    TEMSHostMethodType.Patch: Result := TMethod.Patch;
  else
    Assert(False);
    Result := TMethod.Get;
  end;
end;

function TEndpointRequestImpl.GetMethodString: string;
begin
  Result := String(FHostRequest.Method);
end;

function TEndpointRequestImpl.GetParams: TParams;
begin
  if FParams = nil then
    FParams := TEndpointRequestParams.Create(FHostRequest.QueryFields);
  Result := FParams;
end;

function TEndpointRequestImpl.GetSegments: TSegments;
var
  LStrings: TStrings;
  LPathSegments: string;
begin
  if FSegments = nil then
  begin
    LPathSegments := string(FHostRequest.PathInfo);                         
    if LPathSegments.StartsWith('/') then
      LPathSegments := LPathSegments.Substring(1);

    LStrings := ParseURLPath(LPathSegments);
    try
      FSegments := TEndpointSegmentsImpl.Create(LStrings.ToStringArray);
    finally
      LStrings.Free;
    end;
  end;
  Result := FSegments;
end;

{ TEndpointResponseImpl }

constructor TEndpointResponseImpl.Create(const AHostResponse: IEMSHostResponse);
begin
  FHostResponse := AHostResponse;
end;

destructor TEndpointResponseImpl.Destroy;
begin
  FHeaders.Free;
  FBody.Free;
  inherited;
end;

function TEndpointResponseImpl.GetBody: TBody;
begin
  if FBody = nil then
    FBody := TEndpointResponseBodyImpl.Create(FHostResponse);
  Result := FBody;
end;

function TEndpointResponseImpl.GetHeaders: THeaders;
begin
  if FHeaders = nil then
    FHeaders := TEndpointResponseHeadersRWImpl.Create(FHostResponse);
  Result := FHeaders;
end;

procedure TEndpointResponseImpl.SetCreated(const ALocation: string;
  AStatusCode: Integer);
var
  IntfRequest: IEMSHostRequestLocation;
  IntfResponse: IEMSHostResponseLocation;
begin
  FHostResponse.StatusCode := AStatusCode;
  if Supports(FHostResponse.Request, IEMSHostRequestLocation, IntfRequest) and
    Supports(FHostResponse, IEMSHostResponseLocation, IntfResponse) then
    IntfResponse.Location := IntfRequest.MakeAbsoluteLocation(ALocation);
end;

procedure TEndpointResponseImpl.SetStatusCode(ACode: Integer);
begin
  FHostResponse.StatusCode := ACode;
end;

procedure TEndpointResponseImpl.Write;
begin
  if FBody is TEndpointResponseBodyImpl then
    TEndpointResponseBodyImpl(FBody).Write;
end;

{ TEndpointRequestHeadersImpl }

constructor TEndpointRequestHeadersImpl.Create(
  const ARequest: IEMSHostRequest);
begin
  FRequest := ARequest;
end;

function TEndpointRequestHeadersImpl.TryGetValue(const AName: string;
  out AValue: string): Boolean;
begin
  AValue := FRequest.Headers[AName];
  Result := AValue <> '';
end;

{ TEndpointResponseHeadersRWImpl }

constructor TEndpointResponseHeadersRWImpl.Create(
  const AResponse: IEMSHostResponse);
begin
  FResponse := AResponse;
end;

procedure TEndpointResponseHeadersRWImpl.DoSetValue(const AName,
  AValue: string);
var
  LIntf: IEMSHostResponseHeaders;
begin
  if Supports(FResponse, IEMSHostResponseHeaders, LIntf) then
    LIntf.SetHeader(AName, AValue)
  else
    raise ENotSupportedException.Create('CustomHeaders');
end;

function TEndpointResponseHeadersRWImpl.TryGetValue(const AName: string;
  out AValue: string): Boolean;
var
  LIntf: IEMSHostResponseHeaders;
begin
  Result := False;
  if Supports(FResponse, IEMSHostResponseHeaders, LIntf) then
  begin
    AValue := LIntf.GetHeader(AName);
    Result := AValue <> '';
  end
end;

{ TEndpointContextImpl }

destructor TEndpointContextImpl.Destroy;
begin
  FUser.Free;
  inherited;
end;

function TEndpointContextImpl.GetUser: TUser;
begin
  if not FUserCreated then
  begin
    FUserCreated := True;
    FOnCreateUser(Self, FUser);
  end;
  Result := FUser;
end;

function TEndpointContextImpl.GetEdgemodule: TEdgemodule;
begin
  if not FEdgemoduleCreated then
  begin
    FEdgemoduleCreated := True;
    FOnCreateEdgemodule(Self, FEdgemodule);
  end;
  Result := FEdgemodule;
end;

procedure TEndpointContextImpl.SetCreatorRequired;
begin
  FCreatorRequired := True;
end;

procedure TEndpointContextImpl.SetEndpointData(AStatus: TEndpointDataType;
  const AValue: string);
begin
  FEndpointDataType := AStatus;
  FEndpontDataValue := AValue;
end;

function TEndpointContextImpl.GetEndpointName: string;
begin
  Assert(Assigned(FOnGetEndpointName));
  if Assigned(FOnGetEndpointName) then
    Result := FOnGetEndpointName
end;

function TEndpointContextImpl.GetAuthenticated: TEndpointContext.TAuthenticated;
begin
  Assert(Assigned(FOnGetAuthenticated));
  if Assigned(FOnGetAuthenticated) then
    Result := FOnGetAuthenticated
  else
    Result := [];
end;

function TEndpointContextImpl.GetRequest: TEndpointRequest;
begin
  Assert(Assigned(FOnGetRequest));
  if Assigned(FOnGetRequest) then
    Result := FOnGetRequest
  else
    Result := nil;
end;

function TEndpointContextImpl.GetResponse: TEndpointResponse;
begin
  Assert(Assigned(FOnGetResponse));
  if Assigned(FOnGetResponse) then
    Result := FOnGetResponse
  else
    Result := nil;
end;

end.
