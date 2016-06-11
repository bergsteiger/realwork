{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSHTTPWebBroker;

interface

uses
  Web.AutoDisp,
  System.Classes,
  Datasnap.DSHTTPCommon,
  Datasnap.DSHTTP,
  Web.HTTPApp,
  System.Masks,
  System.SysUtils,
  DataSnap.DSSession;

type

  TDSHTTPContextWebBroker = class;

  TDSRESTWebDispatcher = class;
  TDSHTTPWebDispatcher = class;

  /// <summary>Base class for DataSnap dispatchers that defines their default
  /// properties.</summary>
  TDSWebDispatch = class(TWebDispatch)
  private
    FCustomPathInfo: Boolean;
    function IsPathInfoStored: Boolean; virtual;
    function GetDefaultPathInfo: string; virtual; abstract;
  protected
    procedure SetPathInfo(const Value: string); override;
    function GetPathInfo: string; override;
  public
    constructor Create(AComponent: TComponent);
  published
    property MethodType default mtAny;
    property PathInfo stored IsPathInfoStored nodefault;
  end;

  /// <summary>Base class for DataSnap dispatchers that defines their default
  /// properties.</summary>
  TDSHTTPWebDispatch = class(TDSWebDispatch)
  private
    FDispatcher: TDSHTTPWebDispatcher;
    function GetDefaultPathInfo: string; override;
  public
    constructor Create(AComponent: TDSHTTPWebDispatcher);
  end;

  /// <summary>Base class for DataSnap dispatchers that defines their default
  /// properties.</summary>
  TDSRESTWebDispatch = class(TDSWebDispatch)
  private
    FDispatcher: TDSRESTWebDispatcher;
    function GetDefaultPathInfo: string; override;
  public
    constructor Create(AComponent: TDSRESTWebDispatcher);
  end;

  ///  <summary> Webbroker component that dispatches DataSnap REST requests
  ///  </summary>
  TDSRESTWebDispatcher = class(TDSRESTServerTransport, IWebDispatch)
  private
    FWebDispatch: TDSWebDispatch;
    procedure SetWebDispatch(const Value: TDSWebDispatch);
    function GetDefaultPathInfo: string;
  protected
    function CreateRESTServer: TDSRESTServer; override;
    function DispatchEnabled: Boolean;
    function DispatchMask: TMask;
    function DispatchMethodType: TMethodType;
    function DispatchRequest(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    ///  <summary>Dispatch criteria.  Indicate the types of requests that will be processed by this dispatcher.
    ///  </summary>
    property WebDispatch: TDSWebDispatch read FWebDispatch write SetWebDispatch;
  end;

  ///  <summary> Webbroker component that dispatches DataSnap REST and HTTP tunnel requests
  ///  </summary>
  TDSHTTPWebDispatcher = class(TDSHTTPServerTransport, IWebDispatch)
  private
    FWebDispatch: TDSWebDispatch;
    procedure SetWebDispatch(const Value: TDSWebDispatch);
    function GetDefaultPathInfo: string;
  protected
    function CreateHttpServer: TDSHTTPServer; override;
    function DispatchEnabled: Boolean;
    function DispatchMask: TMask;
    function DispatchMethodType: TMethodType;
    function DispatchRequest(Sender: TObject; Request: TWebRequest;
      Response: TWebResponse): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    ///  <summary>Dispatch criteria.  Indicate the types of requests that will be processed by this dispatcher.
    ///  </summary>
    property WebDispatch: TDSWebDispatch read FWebDispatch write SetWebDispatch;
  end;


  TDSHTTPRequestWebBroker = class;
  TDSHTTPResponseWebBroker = class;

  TDSHTTPContextWebBroker = class(TDSHTTPContext)
  private
    FRequest: TDSHTTPRequestWebBroker;
    FResponse: TDSHTTPResponseWebBroker;
  public
    constructor Create(const ARequest: TWebRequest; const AResponse: TWebResponse);
    destructor Destroy; override;
    function Connected: Boolean; override;
  end;

  TDSHTTPRequestWebBroker = class(TDSHTTPRequest)
  strict private
    FRequestInfo: TWebRequest;
    FPostStream: TMemoryStream;
    FParams: TStrings;
    FAuthUserName: string;
    FAuthPassword: string;
    FHaveAuth: Boolean;
    procedure UpdateAuthStrings;
  protected
    function GetCommand: string; override;
    function GetCommandType: TDSHTTPCommandType; override;
    function GetDocument: string; override;
    function GetParams: TStrings; override;
    function GetPostStream: TStream; override;
    function GetAuthUserName: string; override;
    function GetAuthPassword: string; override;
    function GetURI: string; override;
    function GetPragma: string; override;
    function GetAccept: string; override;
    function GetRemoteIP: string; override;
    function GetUserAgent: string; override;
    function GetProtocolVersion: string; override;
  public
    constructor Create(ARequestInfo: TWebRequest);
    destructor Destroy; override;
    ///  <summary>WebBroker Request.  Provided so that event handlers can get to WebBroker specific properties.
    ///  </summary>
    property WebRequest: TWebRequest read FRequestInfo;
  end;

  TDSHTTPResponseWebBroker = class(TDSHTTPResponse)
  strict private
    FResponseInfo: TWebResponse;
    FCloseConnection: Boolean;
  strict protected
    function GetContentStream: TStream; override;
    function GetResponseNo: Integer; override;
    function GetResponseText: String; override;
    procedure SetContentStream(const Value: TStream); override;
    procedure SetResponseNo(const Value: Integer); override;
    procedure SetResponseText(const Value: String); override;
    function GetContentText: string; override;
    procedure SetContentText(const Value: string); override;
    function GetContentLength: Int64; override;
    procedure SetContentLength(const Value: Int64); override;
    function GetCloseConnection: Boolean; override;
    procedure SetCloseConnection(const Value: Boolean); override;
    function GetPragma: string; override;
    procedure SetPragma(const Value: string); override;
    function GetContentType: string; override;
    procedure SetContentType(const Value: string); override;
    function GetFreeContentStream: Boolean; override;
    procedure SetFreeContentStream(const Value: Boolean); override;
  public
    constructor Create(AResponseInfo: TWebResponse);
    procedure SetHeaderAuthentication(const Value: String; const Realm: String); override;
    ///  <summary>WebBroker Response.  Provided so that event handlers can get to WebBroker specific properties.
    ///  </summary>
    property WebResponse: TWebResponse read FResponseInfo;
  end;

///  <summary>Get the Web Module currently processing a DataSnap HTTP request.
///  </summary>
function GetDataSnapWebModule: TWebModule;


implementation

uses
  Data.DBXClientResStrs,
{$IFDEF MSWINDOWS}
  Winapi.Windows,
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  Posix.String_,
{$ENDIF POSIX}
  System.NetEncoding,
  System.Math;

type
  TDSRESTServerWebBroker = class(TDSRESTServer)
  protected
    function Decode(Data: string): string; override;

  public
    procedure DispatchDataSnap(ARequest: TWebRequest; AResponse: TWebResponse);
  end;

  TDSHTTPServerWebBroker = class(TDSHTTPServer)
  protected
    function Decode(Data: string): string; override;

  public
    procedure DispatchDataSnap(ARequest: TWebRequest; AResponse: TWebResponse);
  end;

                                                                   
threadvar
  DataSnapWebModule:  TWebModule;

function GetDataSnapWebModule: TWebModule;
begin
  Result := DataSnapWebModule;
end;

{ TDSRESTWebDispatcher }
constructor TDSRESTWebDispatcher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWebDispatch := TDSRESTWebDispatch.Create(Self);
end;

function TDSRESTWebDispatcher.CreateRESTServer: TDSRESTServer;
begin
  Result := TDSRESTServerWebBroker.Create(Self.Server);
end;

destructor TDSRESTWebDispatcher.Destroy;
begin
  FWebDispatch.Free;
  inherited Destroy;
end;

procedure TDSRESTWebDispatcher.SetWebDispatch(const Value: TDSWebDispatch);
begin
 FWebDispatch.Assign(Value);
end;

function TDSRESTWebDispatcher.DispatchEnabled: Boolean;
begin
  Result := FWebDispatch.Enabled;
end;

function TDSRESTWebDispatcher.DispatchMask: TMask;
begin
  Result := FWebDispatch.Mask;
end;

function TDSRESTWebDispatcher.DispatchMethodType: TMethodType;
begin
  Result := FWebDispatch.MethodType;
end;

function TDSRESTWebDispatcher.DispatchRequest(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse): Boolean;
begin
  try
    if Owner is TWebModule then
      DataSnapWebModule := TWebModule(Owner);
    try
      try
        RequiresServer;

        TDSRESTServerWebBroker(Self.FRESTServer).DispatchDataSnap(Request, Response);
        Result := True;
      except
        on E: Exception do
        begin
          { Default to 500, like web services. }
          Response.StatusCode := 500;
          Result := True;
        end;
      end;
    except
      { Swallow any unexpected exception, it will bring down some web servers }
      Result := False;
    end;
  finally
    { Reset current DataSnapWebModule }
    DataSnapWebModule := nil;
  end;
end;

function TDSRESTWebDispatcher.GetDefaultPathInfo: string;
begin
  Result := '';
  if DSContext <> '/' then
    Result := DSContext;
  if RestContext <> '/' then
    Result := Result + RESTContext;
  Result := Result + '*';
end;

{ TDSHTTPWebDispatcher }
constructor TDSHTTPWebDispatcher.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWebDispatch := TDSHTTPWebDispatch.Create(Self);
end;

function TDSHTTPWebDispatcher.CreateHttpServer: TDSHTTPServer;
begin
  Result := TDSHTTPServerWebBroker.Create;
end;

destructor TDSHTTPWebDispatcher.Destroy;
begin
  FWebDispatch.Free;
  inherited Destroy;
end;

procedure TDSHTTPWebDispatcher.SetWebDispatch(const Value: TDSWebDispatch);
begin
 FWebDispatch.Assign(Value);
end;

function TDSHTTPWebDispatcher.DispatchEnabled: Boolean;
begin
  Result := FWebDispatch.Enabled;
end;

function TDSHTTPWebDispatcher.DispatchMask: TMask;
begin
  Result := FWebDispatch.Mask;
end;

function TDSHTTPWebDispatcher.DispatchMethodType: TMethodType;
begin
  Result := FWebDispatch.MethodType;
end;

function TDSHTTPWebDispatcher.DispatchRequest(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse): Boolean;
begin
  try
    if Owner is TWebModule then
      DataSnapWebModule := TWebModule(Owner);
    try
      try
        RequiresServer;
        TDSHTTPServerWebBroker(Self.FHttpServer).DispatchDataSnap(Request, Response);
        Result := True;
      except
        on E: Exception do
        begin
          { Default to 500, like web services. }
          Response.StatusCode := 500;
          Result := True;
        end;
      end;
    except
      { Swallow any unexpected exception, it will bring down some web servers }
      Result := False;
    end;
  finally
    { Reset current DataSnapWebModule }
    DataSnapWebModule := nil;
  end;
end;

function TDSHTTPWebDispatcher.GetDefaultPathInfo: string;
begin
  Result := '';
  if DSContext <> '/' then
    Result := DSContext;
  Result := Result + '*';
end;

{ TDSRESTServerWebBroker }

function TDSRESTServerWebBroker.Decode(Data: string): string;
begin
  Result := Data;
end;

procedure TDSRESTServerWebBroker.DispatchDataSnap(ARequest: TWebRequest;
  AResponse: TWebResponse);
var
  LDispatch: TDSHTTPDispatch;
  LContext: TDSHTTPContextWebBroker;
begin
  LDispatch := TDSHTTPApplication.Instance.HTTPDispatch;
  if LDispatch <> nil then
    DoCommand(LDispatch.Context, LDispatch.Request, LDispatch.Response)
  else
  begin
    LContext := TDSHTTPContextWebBroker.Create(ARequest, AResponse);
    try
      DoCommand(LContext, LContext.FRequest, LContext.FResponse);
    finally
      LContext.Free;
    end;
  end;
end;

{ TDSHTTPServerWebBroker }

function TDSHTTPServerWebBroker.Decode(Data: string): string;
begin
  Result := Data;
end;

procedure TDSHTTPServerWebBroker.DispatchDataSnap(ARequest: TWebRequest;
  AResponse: TWebResponse);
var
  LDispatch: TDSHTTPDispatch;
  LContext: TDSHTTPContextWebBroker;
begin
  LDispatch := TDSHTTPApplication.Instance.HTTPDispatch;
  if LDispatch <> nil then
    DoCommand(LDispatch.Context, LDispatch.Request, LDispatch.Response)
  else
  begin
    LContext := TDSHTTPContextWebBroker.Create(ARequest, AResponse);
    try
      DoCommand(LContext, LContext.FRequest, LContext.FResponse);
    finally
      LContext.Free;
    end;
  end;
end;

{ TDSHTTPResponseWebBroker }

constructor TDSHTTPResponseWebBroker.Create(AResponseInfo: TWebResponse);
begin
  FResponseInfo := AResponseInfo;
end;

function TDSHTTPResponseWebBroker.GetCloseConnection: Boolean;
begin
  Result := FCloseConnection;
end;

function TDSHTTPResponseWebBroker.GetContentLength: Int64;
begin
  Result := FResponseInfo.ContentLength;
end;

function TDSHTTPResponseWebBroker.GetContentStream: TStream;
begin
  Result := FResponseInfo.ContentStream;
end;

function TDSHTTPResponseWebBroker.GetContentText: string;
begin
  Result := FResponseInfo.Content;
end;

function TDSHTTPResponseWebBroker.GetContentType: string;
begin
  Result := FResponseInfo.GetCustomHeader('Content-Type');
end;

function TDSHTTPResponseWebBroker.GetFreeContentStream: Boolean;
begin
  Result := FResponseInfo.FreeContentStream;
end;

function TDSHTTPResponseWebBroker.GetPragma: string;
begin
  Result := FResponseInfo.GetCustomHeader('Pragma');
end;

function TDSHTTPResponseWebBroker.GetResponseNo: Integer;
begin
  Result := FResponseInfo.StatusCode;
end;

function TDSHTTPResponseWebBroker.GetResponseText: String;
begin
  // Expect reason string to be 8 bit characters only
  Result := string(FResponseInfo.ReasonString);
end;

procedure TDSHTTPResponseWebBroker.SetCloseConnection(const Value: Boolean);
begin
  FCloseConnection := Value;
end;

procedure TDSHTTPResponseWebBroker.SetContentLength(const Value: Int64);
begin
  FResponseInfo.ContentLength := Value;
end;

procedure TDSHTTPResponseWebBroker.SetContentStream(const Value: TStream);
begin
  FResponseInfo.ContentStream := Value;
end;

procedure TDSHTTPResponseWebBroker.SetContentText(const Value: string);
begin
  FResponseInfo.Content := Value;
end;

procedure TDSHTTPResponseWebBroker.SetContentType(const Value: string);
begin
  FResponseInfo.SetCustomHeader('Content-Type', Value);
end;

procedure TDSHTTPResponseWebBroker.SetFreeContentStream(const Value: Boolean);
begin
  FResponseInfo.FreeContentStream := Value;
end;

procedure TDSHTTPResponseWebBroker.SetPragma(const Value: string);
begin
  FResponseInfo.SetCustomHeader('Pragma', Value);
end;

procedure TDSHTTPResponseWebBroker.SetHeaderAuthentication(const Value,
  Realm: String);
begin
  FResponseInfo.WWWAuthenticate := Value;
  FResponseInfo.Realm := Realm;
end;

procedure TDSHTTPResponseWebBroker.SetResponseNo(const Value: Integer);
begin
  FResponseInfo.StatusCode := Value;
end;

procedure TDSHTTPResponseWebBroker.SetResponseText(const Value: String);
begin
  // Expect reason phrase to 8 bit characters only.
  FResponseInfo.ReasonString := Value;
end;

constructor TDSHTTPRequestWebBroker.Create(ARequestInfo: TWebRequest);
begin
  FRequestInfo := ARequestInfo;
end;

destructor TDSHTTPRequestWebBroker.Destroy;
begin
  FPostStream.Free;
  FParams.Free;
  inherited;
end;

function Base64DecodeToString(const S: string): string; inline;
begin
  Result := TNetEncoding.Base64.Decode(S);
end;

procedure TDSHTTPRequestWebBroker.UpdateAuthStrings;
var
  LAuthorization: string;
  LDecodedAuthorization: string;
  LPos: NativeInt;
begin
  if not FHaveAuth then
  begin
    FHaveAuth := True;
    LAuthorization := string(FRequestInfo.Authorization);

    if LAuthorization.StartsWith('Basic') then
    begin
      LDecodedAuthorization := Base64DecodeToString(LAuthorization.SubString(5, LAuthorization.Length).Trim);
      LPos := LDecodedAuthorization.IndexOf(':');
      if LPos > 0 then
      begin
        FAuthUserName := LDecodedAuthorization.SubString(0, LPos);
        FAuthPassword := LDecodedAuthorization.SubString(LPos + 1, LDecodedAuthorization.Length);
      end;
    end;
  end;
end;

function TDSHTTPRequestWebBroker.GetAuthPassword: string;
begin
  UpdateAuthStrings;
  Result := FAuthPassword;
end;

function TDSHTTPRequestWebBroker.GetAuthUserName: string;
begin
  UpdateAuthStrings;
  Result := FAuthUserName;
end;

function TDSHTTPRequestWebBroker.GetCommand: string;
begin
  Result := string(FRequestInfo.Method);
end;

function TDSHTTPRequestWebBroker.GetCommandType: TDSHTTPCommandType;
begin
  if GetCommand.Equals('DELETE') then  { do not localize }
    // WebBroker doesn't have code for delete
    Result := TDSHTTPCommandType.hcDELETE
  else
    case FRequestInfo.MethodType of
      TMethodType.mtAny:
        Result := TDSHTTPCommandType.hcUnknown;
      TMethodType.mtHead:
        Result := TDSHTTPCommandType.hcOther;
      TMethodType.mtGet:
        Result := TDSHTTPCommandType.hcGET;
      TMethodType.mtPost:
        Result := TDSHTTPCommandType.hcPOST;
      TMethodType.mtPut:
        Result := TDSHTTPCommandType.hcPUT;
    else
      raise Exception.Create(sUnknownCommandType);
    end;
end;

function TDSHTTPRequestWebBroker.GetDocument: string;
begin
  Result := string(FRequestInfo.InternalPathInfo);
end;

function TDSHTTPRequestWebBroker.GetParams: TStrings;
var
  LField: string;
begin
  if FParams = nil then
  begin
    FParams := TStringList.Create;
    FParams.AddStrings(FRequestInfo.QueryFields);
    if (FRequestInfo.MethodType = mtPost) and
      AnsiSameText(string(FRequestInfo.ContentType), 'application/x-www-form-urlencoded') then // Do not localize
    begin
      for LField in FRequestInfo.ContentFields do
        if LField.StartsWith('dss', True) then
          FParams.Add(LField);
    end;
  end;
  Result := FParams;
end;

function TDSHTTPRequestWebBroker.GetPostStream: TStream;
begin
  if FPostStream = nil then
  begin
    FPostStream := TMemoryStream.Create;
    FRequestInfo.ReadTotalContent;
    if Length(FRequestInfo.RawContent) > 0 then
    begin
      FPostStream.Write(FRequestInfo.RawContent[Low(FRequestInfo.RawContent)], Length(FRequestInfo.RawContent));
      FPostStream.Seek(0, TSeekOrigin.soBeginning);
    end;
  end;
  Result := FPostStream;
end;

function TDSHTTPRequestWebBroker.GetPragma: string;
begin
  Result := String(FRequestInfo.GetFieldByName('Pragma'));
end;

function TDSHTTPRequestWebBroker.GetRemoteIP: string;
begin
  Result := String(FRequestInfo.RemoteIP);
end;

function TDSHTTPRequestWebBroker.GetAccept: string;
begin
  Result := String(FRequestInfo.GetFieldByName('Accept'));
end;

function TDSHTTPRequestWebBroker.GetURI: string;
begin
  Result := String(FRequestInfo.RawPathInfo);
end;

function TDSHTTPRequestWebBroker.GetUserAgent: string;
begin
  Result := String(FRequestInfo.UserAgent);
end;

function TDSHTTPRequestWebBroker.GetProtocolVersion: string;
begin
  Result := String(FRequestInfo.ProtocolVersion);
end;

{ TDSHTTPContextWebBroker }

function TDSHTTPContextWebBroker.Connected: Boolean;
begin
  Result := True;
end;

constructor TDSHTTPContextWebBroker.Create(const ARequest: TWebRequest;
  const AResponse: TWebResponse);
begin
  inherited Create;
  FRequest := TDSHTTPRequestWebBroker.Create(ARequest);
  FResponse := TDSHTTPResponseWebBroker.Create(AResponse);
end;

destructor TDSHTTPContextWebBroker.Destroy;
begin
  FRequest.Free;
  FResponse.Free;
  inherited;
end;

{ TDSWebDispatch }

constructor TDSWebDispatch.Create(AComponent: TComponent);
begin
  inherited;
  MethodType := mtAny;
  PathInfo := GetDefaultPathInfo;
end;

function TDSWebDispatch.IsPathInfoStored: Boolean;
begin
  Result := PathInfo <> GetDefaultPathInfo;
end;

procedure TDSWebDispatch.SetPathInfo(const Value: string);
begin
  FCustomPathInfo := (Value <> '') and not SameText(GetDefaultPathInfo, Value);
  if Value = '' then
    inherited SetPathInfo(GetDefaultPathInfo)
  else
    inherited SetPathInfo(Value);
end;

function TDSWebDispatch.GetPathInfo: string;
begin
  if FCustomPathInfo then
    Result := inherited
  else
    Result := GetDefaultPathInfo;
end;


{ TDSHTTPWebDispatch }

constructor TDSHTTPWebDispatch.Create(AComponent: TDSHTTPWebDispatcher);
begin
  FDispatcher := AComponent;
  inherited Create(AComponent);
end;


function TDSHTTPWebDispatch.GetDefaultPathInfo: string;
begin
  Result := FDispatcher.GetDefaultPathInfo;
end;

{ TDSRESTWebDispatch }

constructor TDSRESTWebDispatch.Create(AComponent: TDSRESTWebDispatcher);
begin
  FDispatcher := AComponent;
  inherited Create(AComponent);
end;

function TDSRESTWebDispatch.GetDefaultPathInfo: string;
begin
  Result := FDispatcher.GetDefaultPathInfo;
end;


end.
