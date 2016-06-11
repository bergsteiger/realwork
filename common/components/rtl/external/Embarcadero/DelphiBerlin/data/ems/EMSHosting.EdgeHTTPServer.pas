{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.EdgeHTTPServer;

interface

uses System.Classes, System.SysUtils,
  System.JSON, IdCustomHTTPServer,
  IdBaseComponent, IdComponent, IdCustomTCPServer,
  IdHTTPServer, IdContext, EMSHosting.EdgeService;

type

  TEMSEdgeHTTPServer = class
  public type
    TGetPasswordEvent = procedure(var APassword: string) of object;
  private
    FIdHTTPServer: TIdHTTPServer;
    FPort: Integer;
    FModule: TEMSEdgeListener.TModule;
    FThreadPool: Boolean;
    FThreadPoolSize: Integer;
    FListenQueue: Integer;
    FKeyFile: string;
    FRootCertFile: string;
    FCertFile: string;
    FOnGetSSLPassword: TGetPasswordEvent;
    FHTTPS: Boolean;
    function GetPort: Cardinal;
    procedure SetPort(const Value: Cardinal);
    procedure DoCommand(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure CommandGet(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure CommandOther(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
    procedure CommandError(AContext: TIdContext;
      ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
      AException: Exception);
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure DoOnGetSSLPassword(var APassword: String);
  public
    constructor Create;
    destructor Destroy; override;
    property Active: Boolean read GetActive write SetActive;
    property Port: Cardinal read GetPort write SetPort;
    property Module: TEMSEdgeListener.TModule write FModule;
    property ThreadPool: Boolean read FThreadPool write FThreadPool;
    property ThreadPoolSize: Integer read FThreadPoolSize write FThreadPoolSize;
    property ListenQueue: Integer read FListenQueue write FListenQueue;
    property CertFile: string read FCertFile write FCertFile;
    property RootCertFile: string read FRootCertFile write FRootCertFile;
    property KeyFile: string read FKeyFile write FKeyFile;
    property OnGetSSLPassword: TGetPasswordEvent read FOnGetSSLPassword write FOnGetSSLPassword;
    property HTTPS: Boolean read FHTTPS write FHTTPS;
  end;


implementation

uses EMS.ResourceAPI, EMSHosting.Helpers, EMSHosting.RequestTypes, EMSHosting.EdgeRequestHandler,
  EMSHosting.EdgePayload,
  IdSSLOpenSSL, IdSchedulerOfThreadPool, EMSHosting.RequestHandler;

type

  TEdgeReaderHostRequest = class(TEMSHostRequest)
  private
    FQueryFields: TStrings;
    FReader: IEdgeRequestReader;
    FEdgeRequest: IEdgeRequest;
    FContentType: string;
    FContentLength: Integer;
  private
    procedure Load;
  protected
    function GetContentType: string; override;
    function GetMethodType: TEMSHostRequest.TMethodType; override;
    function GetPathInfo: string; override;
    function GetQueryFields: TStringKeyValues; override;
    function GetRawContent: TBytes; override;
    function GetContentLength: Integer; override;
    function GetHeader(const AName: string): string; override;
    function GetBasePath: string;  override;
    function GetServerHost: string;  override;
  public
    constructor Create(const AReader: IEdgeRequestReader);
    destructor Destroy; override;
  end;

  TEdgeWriterHostResponse = class(TEMSHostResponse)
  private
    FRequest: IEMSHostRequest;
    FContentType: string;
    FContentStream: TStream;
    FStatusCode: Integer;
  protected
    function GetContentStream: TStream; override;
    function GetContentType: string; override;
    function GetStatusCode: Integer; override;
    procedure SetContentStream(const Value: TStream); override;
    procedure SetStatusCode(const Value: Integer); override;
    function GetRequest: IEMSHostRequest; override;
    procedure SetContentType(const Value: string); override;
  public
    constructor Create(const ARequest: IEMSHostRequest);
    destructor Destroy; override;
    procedure Write(const AWriter: IEdgeResponseWriter);
  end;


{ TEdgeReaderHostRequest }

constructor TEdgeReaderHostRequest.Create(const AReader: IEdgeRequestReader);
begin
  FQueryFields := TStringList.Create;
  FReader := AReader;
end;

destructor TEdgeReaderHostRequest.Destroy;
begin
  FQueryFields.Free;
  inherited;
end;

procedure TEdgeReaderHostRequest.Load;
begin
  if FEdgeRequest = nil then
  begin
    FEdgeRequest := FReader.ReadRequest;
    FReader.ReadContentType(FContentType, FContentLength);
  end;
end;

function TEdgeReaderHostRequest.GetBasePath: string;
begin
  Result := FEdgeRequest.BasePath;
end;

function TEdgeReaderHostRequest.GetServerHost: string;
begin
  Result := FEdgeRequest.ServerHost;
end;

function TEdgeReaderHostRequest.GetContentLength: Integer;
begin
  Load;
  Result := FContentLength;
end;

function TEdgeReaderHostRequest.GetContentType: string;
begin
  Load;
  Result := FContentType;
end;


// Get header
function TEdgeReaderHostRequest.GetHeader(const AName: string): string;
begin
  Load;
  if SameText(AName, TEMSHostRequestProps.THeaderNames.SessionToken) then
    Result := FEdgeRequest.SessionToken;
end;

function TEdgeReaderHostRequest.GetMethodType: TEMSHostRequest.TMethodType;
begin
  Load;
  if SameText(FEdgeRequest.Method, 'get') then
    Result := TEMSHostRequest.TMethodType.Get
  else if SameText(FEdgeRequest.Method, 'put') then
    Result := TEMSHostRequest.TMethodType.Put
  else if SameText(FEdgeRequest.Method, 'post') then
    Result := TEMSHostRequest.TMethodType.Post
  else if SameText(FEdgeRequest.Method, 'delete') then
    Result := TEMSHostRequest.TMethodType.Delete
  else if SameText(FEdgeRequest.Method, 'patch') then
    Result := TEMSHostRequest.TMethodType.Patch
  else if SameText(FEdgeRequest.Method, 'head') then
    Result := TEMSHostRequest.TMethodType.Head
  else
    raise ENotImplemented.Create('GetMethodType');
end;

function TEdgeReaderHostRequest.GetPathInfo: string;
begin
  Load;
  Result := FEdgeRequest.Path;
end;

function TEdgeReaderHostRequest.GetQueryFields: TStringKeyValues;
begin
  Load;
  Result := FEdgeRequest.Query;
end;

function TEdgeReaderHostRequest.GetRawContent: TBytes;
begin
  Load;
  SetLength(Result, FContentLength);
  FReader.ReadContent(FContentLength, Result);
end;

{ TEdgeWriterHostResponse }

constructor TEdgeWriterHostResponse.Create(const ARequest: IEMSHostRequest);
begin
  FRequest := ARequest;
end;

destructor TEdgeWriterHostResponse.Destroy;
begin
  inherited;
end;

function TEdgeWriterHostResponse.GetContentStream: TStream;
begin
  Result := FContentStream;
end;

function TEdgeWriterHostResponse.GetContentType: string;
begin
  Result := FContentType;
end;

function TEdgeWriterHostResponse.GetRequest: IEMSHostRequest;
begin
  Result := FRequest;
end;

function TEdgeWriterHostResponse.GetStatusCode: Integer;
begin
  Result := FStatusCode;
end;

procedure TEdgeWriterHostResponse.SetContentStream(const Value: TStream);
begin
  Assert(Value <> nil);
  if (Value <> nil) and (FContentStream <> nil) then
  begin
    FContentStream.Size := 0;
    FContentStream.Seek(0, soBeginning);
    FContentStream.CopyFrom(Value, Value.Size);
{$IFNDEF NEXTGEN}
    Value.Free;
{$ENDIF}
  end
  else
    FContentStream := Value;

end;

procedure TEdgeWriterHostResponse.SetContentType(const Value: string);
begin
  FContentType := Value;

end;

procedure TEdgeWriterHostResponse.SetStatusCode(const Value: Integer);
begin
  FStatusCode := Value;
end;


procedure TEdgeWriterHostResponse.Write(const AWriter: IEdgeResponseWriter);
begin
                        
  AWriter.WriteResponse(
    TEdgeResponse.Create(FStatusCode, ''));
  if FContentStream <> nil then
    AWriter.WriteContent(FContentType, FContentStream);
end;

{ TIndyHTTPListener }

constructor TEMSEdgeHTTPServer.Create;
begin
  FIdHTTPServer := TIdHTTPServer.Create(nil);
  FIdHTTPServer.UseNagle := False;
  FIdHTTPServer.KeepAlive := True;
  FIdHTTPServer.OnCommandGet := CommandGet;
  FIdHTTPServer.OnCommandOther := CommandOther;
  FIdHTTPServer.OnCommandError := CommandError;
end;

destructor TEMSEdgeHTTPServer.Destroy;
begin
  FIdHTTPServer.Free;
  inherited;
end;

function TEMSEdgeHTTPServer.GetActive: Boolean;
begin
  Result := FIdHTTPServer.Active;
end;

function TEMSEdgeHTTPServer.GetPort: Cardinal;
begin
  Result := FPort;
end;

procedure TEMSEdgeHTTPServer.SetActive(const Value: Boolean);
var
  LIOHandleSSL: TIdServerIOHandlerSSLOpenSSL;
  LScheduler: TIdSchedulerOfThreadPool;
begin
  if FIdHTTPServer.Active <> Value then
  begin
    if Value then
    begin
      FIdHTTPServer.Bindings.Clear;
      FIdHTTPServer.Bindings.Add.Port := FPort; //default IPv4
      if FThreadPool then
      begin
        LScheduler := TIdSchedulerOfThreadPool.Create(FIdHTTPServer);
        if FThreadPoolSize > 0 then
          LScheduler.PoolSize := FThreadPoolSize;
        FIdHTTPServer.Scheduler := LScheduler;
      end;
      if FListenQueue > 0 then
        FIdHTTPServer.ListenQueue:= FListenQueue;

      if FHTTPS then
      begin
        LIOHandleSSL := TIdServerIOHandlerSSLOpenSSL.Create(FIdHTTPServer);
        LIOHandleSSL.SSLOptions.CertFile :=  FCertFile;
        LIOHandleSSL.SSLOptions.RootCertFile :=  FRootCertFile;
        LIOHandleSSL.SSLOptions.KeyFile := FKeyFile;
        LIOHandleSSL.OnGetPassword := DoOnGetSSLPassword;
        FIdHTTPServer.IOHandler := LIOHandleSSL;
      end;
    end;
    FIdHTTPServer.Active := Value;
  end;
end;

procedure TEMSEdgeHTTPServer.DoOnGetSSLPassword(var APassword: String);
begin
  if Assigned(FOnGetSSLPassword) then
    FOnGetSSLPassword(APassword);
end;

procedure TEMSEdgeHTTPServer.SetPort(const Value: Cardinal);
begin
  FPort := Value;
end;

procedure TEMSEdgeHTTPServer.DoCommand(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
var
  LHandler: TEdgeRequestHandler;
  LRequestIntf: IEMSHostRequest;
  LResponseIntf: IEMSHostResponse;
  LRequest: TEdgeReaderHostRequest;
  LResponse: TEdgeWriterHostResponse;
  LHandled: Boolean;
  LEdgeRequestWriter: IEdgeRequestReader;
  LEdgeResponseWriter: IEdgeResponseWriter;
  LStream: TMemoryStream;
begin
  LHandler := TEdgeRequestHandler.Create;
  try
    if ARequestInfo.CommandType <> THTTPCommandType.hcPOST then
      raise Exception.Create('Expected post');
    LEdgeRequestWriter := TEdgeReaderWriterFactory.Instance.CreateRequestReader(ARequestInfo.PostStream);
    LStream := TMemoryStream.Create;
    try
      LEdgeResponseWriter := TEdgeReaderWriterFactory.Instance.CreateResponseWriter(LStream);
      LRequest := TEdgeReaderHostRequest.Create(LEdgeRequestWriter);
      LRequestIntf := LRequest; // Frees LRequest
      LResponse := TEdgeWriterHostResponse.Create(LRequest);
      LResponseIntf := LResponse;  // Frees LResponse
      LHandler.HandleRequest(TEMSEdgeListener.TModuleContext.Create(FModule), LRequest, LResponse, LHandled);
      LResponse.Write(LEdgeResponseWriter);
      AResponseInfo.ContentType := 'application/octet-stream';  // do not localize
      AResponseInfo.ContentStream := LStream;
      LStream := nil;
    finally
      LStream.Free;
    end;
  finally
    LHandler.Free;
  end;
end;

procedure TEMSEdgeHTTPServer.CommandGet(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  DoCommand(AContext, ARequestInfo, AResponseInfo);
end;

procedure TEMSEdgeHTTPServer.CommandOther(AContext: TIdContext;
  ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo);
begin
  DoCommand(AContext, ARequestInfo, AResponseInfo);
end;

procedure TEMSEdgeHTTPServer.CommandError(AContext: TIdContext;
    ARequestInfo: TIdHTTPRequestInfo; AResponseInfo: TIdHTTPResponseInfo;
    AException: Exception);
var
  LException: EEMSHTTPError;
  LJSON: TJSONObject;
  LWriter: IEdgeResponseWriter;
  LStream: TStream;
begin
  if AException is EEMSHTTPError then
  begin
    LStream := TMemoryStream.Create;
    try
      LWriter := TEdgeReaderWriterFactory.Instance.CreateResponseWriter(LStream);
      LException := EEMSHTTPError(AException);
      LWriter.WriteResponse(TEdgeResponse.Create(LException.Code, LException.Error));
      LJSON := TErrorHelpers.CreateJSONError('', LException.Error, LException.Description);
      try
        LWriter.WriteContent('application/json', LJSON.ToJSON);   // do not localize
      finally
        LJSON.Free;
      end;
      AResponseInfo.ResponseNo := 200;
      AResponseInfo.ContentText := '';
      AResponseInfo.ContentType := 'application/octet-stream';   // do not localize
      AResponseInfo.ContentStream := LStream;
      LStream := nil;
    finally
      LStream.Free;
    end;
  end;

end;

end.
