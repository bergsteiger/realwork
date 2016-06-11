{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMS.ResourceAPI;

interface

{$SCOPEDENUMS ON}
{$HPPEMIT LINKUNIT}

uses
  System.Generics.Collections, System.SysUtils, System.Classes, System.JSON,
  System.JSON.Writers, System.JSON.Readers;

type
  TEndpointContext = class;
  TEndpointRequest = class;
  TEndpointResponse = class;

  TEMSResource = class abstract
  protected
    function GetName: string; virtual; abstract;
    function GetEndpointNames: TArray<string>; virtual; abstract;
    procedure DoHandleRequest(const AContext: TEndpointContext); virtual; abstract;
    function DoCanHandleRequest(const AContext: TEndpointContext; out AEndpointName: string): Boolean; virtual; abstract;
  public
    property Name: string read GetName;
    property EndpointNames: TArray<string> read GetEndpointNames;
    function IsBaseURL(const ABaseURL: string): Boolean; virtual;
    procedure HandleRequest(const AContext: TEndpointContext);
    function CanHandleRequest(const AContext: TEndpointContext; out AEndpointName: string): Boolean;
  end;

  TEMSEndpointManager = class
  private
    class var FInstance: TEMSEndpointManager;
    class function GetInstance: TEMSEndpointManager; static;
  protected
    class var FEndpointManagerFactory: TFunc<TEMSEndpointManager>;
    function GetResources: TArray<TEMSResource>; virtual; abstract;
  public
    destructor Destroy; override;
    procedure RegisterResource(const AResource: TEMSResource); virtual; abstract;
    /// <summary>Retrieve endpoint resource objects as an array</summary>
    property Resources: TArray<TEMSResource> read GetResources;
    class property Instance: TEMSEndpointManager read GetInstance;
  end;


  TEMSEndpointAuthorization = class
  public type
    TACL = class abstract
    protected
      function GetPublic: Boolean; virtual; abstract;
      function GetGroups: TArray<string>; virtual; abstract;
      function GetUsers: TArray<string>; virtual; abstract;
      function GetAllowCreator: Boolean; virtual; abstract;
    public
      property IsPublic: Boolean read GetPublic;
      property Users: TArray<string> read GetUsers;
      property Groups: TArray<string> read GetGroups;
      property AllowCreator: Boolean read GetAllowCreator;
    end;
  private
    class var FInstance: TEMSEndpointAuthorization;
    class function GetInstance: TEMSEndpointAuthorization; static;
  protected
    class var FEndpointAuthorizationFactory: TFunc<TEMSEndpointAuthorization>;
  public
    destructor Destroy; override;
    procedure Authorize(const AContext: TEndpointContext; const AACL: TACL); virtual; abstract;
    function FindACL(const AName: string; out AACL: TACL): Boolean; virtual; abstract;
    class property Instance: TEMSEndpointAuthorization read GetInstance;
  end;


  TEndpointParams = class abstract
  public type
    TPairItem = TPair<string, string>;
    TEnumerator = class(TEnumerator<TPairItem>)
    private
      FParams: TEndpointParams;
      FIndex: Integer;
    protected
      function DoGetCurrent: TPairItem; override;
      function DoMoveNext: Boolean; override;
    public
      constructor Create(const AParams: TEndpointParams);
    end;
  protected
    function GetCount: Integer; virtual; abstract;
    function GetPair(const Index: Integer): TPairItem; virtual; abstract;
    function GetValue(const AName: string): string;
    procedure DoAdd(const AName, AValue: string); virtual;
  public
    /// <summary>Enumerate the parameter pairs</summary>
    function GetEnumerator: TEnumerator<TPairItem>;
    function TryGetValue(const AName: string; out AValue: string): Boolean; virtual; abstract;
    function Contains(const AName: string): Boolean; virtual; abstract;
    property Count: Integer read GetCount;
    property Pairs[const Index: Integer]: TPairItem read GetPair;
    property Values[const Name: string]: string read GetValue;
    procedure Add(const AName, AValue: string);
    /// <summary>Get the parameter pairs as an array</summary>
    function ToArray: TArray<TPairItem>;
  end;

  TEndpointSegments = class abstract
  public type
    TEnumerator = class(TEnumerator<string>)
    private
      FSegments: TEndpointSegments;
      FIndex: Integer;
    protected
      function DoGetCurrent: string; override;
      function DoMoveNext: Boolean; override;
    public
      constructor Create(const ASegments: TEndpointSegments);
    end;
  protected
    function GetCount: Integer; virtual; abstract;
    function GetItem(const AIndex: Integer): string; virtual; abstract;
    procedure DoAdd(const AName: string); virtual;
  public
    /// <summary>Enumerate the segments</summary>
    function GetEnumerator: TEnumerator<string>;
    property Count: Integer read GetCount;
    property Items[const AIndex: Integer]: string read GetItem; default;
    procedure Add(const AName: string);
    /// <summary>Get the segments as an array</summary>
    function ToArray: TArray<string>;
  end;

  TEndpointHeaders = class abstract
  protected
    procedure DoSetValue(const AName, AValue: string); virtual;
  public
    function TryGetValue(const AName: string; out AValue: string): Boolean; virtual; abstract;
    function GetValue(const AName: string): string;
    procedure SetValue(const AName, AValue: string);
  end;

  TEndpointRequestBody = class abstract
  protected
    function GetContentType: string; virtual; abstract;
    function GetJSONReader: TJsonTextReader; virtual; abstract;
  public
    function TryGetStream(out AStream: TStream): Boolean; overload; virtual; abstract;
    function TryGetStream(out AStream: TStream; out AContentType: string): Boolean; overload; virtual; abstract;
    function TryGetObject(out AJSONObject: TJSONObject): Boolean ; virtual; abstract;
    function TryGetArray(out AJSONArray: TJSONArray): Boolean ; virtual; abstract;
    function TryGetValue(out AJSONValue: TJSONValue): Boolean ; virtual; abstract;
    function TryGetBytes(out ABytes: TBytes): Boolean; virtual ; abstract;
    function GetStream: TStream;
    function GetObject: TJSONObject;
    function GetArray: TJSONArray;
    function GetValue: TJSONValue;
    function GetBytes: TBytes;
    property ContentType: string read GetContentType;
    property JSONReader: TJsonTextReader read GetJSONReader;
  end;

  TEndpointResponseBody = class abstract
  protected
    function GetJSONWriter: TJsonTextWriter; virtual; abstract;
  public
    procedure SetValue(const AJSONValue: TJSONValue; AOwnsValue: Boolean); virtual; abstract;
    procedure SetBytes(const ABytes: TBytes; const AContentType: string); virtual; abstract;
    procedure SetStream(const AStream: TStream; const AContentType: string; AOwnsValue: Boolean); virtual; abstract;
    property JSONWriter: TJsonTextWriter read GetJSONWriter;
  end;

  TEndpointContext = class
  public type
    TGroups = class(TObject)
    protected
      function GetCount: Integer; virtual; abstract;
    public
      function Contains(const AGroup: string): Boolean; virtual; abstract;
      property Count: Integer read GetCount;
    end;

    TUser = class(TObject)
    protected
      function GetUserName: string; virtual; abstract;
      function GetUserID: string; virtual; abstract;
      function GetGroups: TGroups; virtual; abstract;
    public
      property UserName: string read GetUserName;
      property UserID: string read GetUserID;
      property Groups: TGroups read GetGroups;
    end;

    TEdgemodule = class(TObject)
    protected
      function GetModuleName: string; virtual; abstract;
      function GetModuleVersion: string; virtual; abstract;
    public
      property ModuleName: string read GetModuleName;
      property ModuleVersion: string read GetModuleVersion;
    end;

    TAuthenticate = (MasterSecret, AppSecret, User);
    TAuthenticated = set of TAuthenticate;
  protected
    function GetUser: TUser; virtual; abstract;
    function GetEdgemodule: TEdgemodule; virtual; abstract;
    function GetAuthenticated: TAuthenticated; virtual; abstract;
    function GetRequest: TEndpointRequest; virtual; abstract;
    function GetResponse: TEndpointResponse; virtual; abstract;
    function GetEndpointName: string; virtual; abstract;
  public
    property User: TUser read GetUser;
    property EndpointName: string read GetEndpointName;
    property Edgemodule: TEdgemodule read GetEdgemodule;
    property Authenticated: TAuthenticated read GetAuthenticated;
    property Request: TEndpointRequest read GetRequest;
    property Response: TEndpointResponse read GetResponse;
  end;

  TEndpointRequest = class
  public type
    TMethod = (Get, Put, Post, Delete, Patch, Other);
    THeaders = TEndpointHeaders;
    TParams = TEndpointParams;
    TSegments = TEndpointSegments;
    TBody = TEndpointRequestBody;
  protected
    function GetHeaders: THeaders; virtual; abstract;
    function GetParams: TParams; virtual; abstract;
    function GetSegments: TSegments; virtual; abstract;
    function GetBody: TBody; virtual; abstract;
    function GetMethod: TMethod; virtual; abstract;
    function GetMethodString: string; virtual; abstract;
    function GetResource: string; virtual; abstract;
    function GetBasePath: string; virtual; abstract;
    function GetServerHost: string; virtual; abstract;
  public
    property Body: TBody read GetBody;
    property Headers: THeaders read GetHeaders;
    property Method: TMethod read GetMethod;
    property MethodString: string read GetMethodString;
    property Params: TParams read GetParams;
    property Segments: TSegments read GetSegments;
    property Resource: string read GetResource;
    /// <summary>Retrieve the endpoint request BasePath</summary>
    property BasePath: string read GetBasePath;
    /// <summary>Retrieve the endpoint request Host</summary>
    property ServerHost: string read GetServerHost;
  end;

  TEndpointResponse = class
  public type
    THeaders = TEndpointHeaders;
    TBody = TEndpointResponseBody;
  protected
    function GetHeaders: THeaders; virtual; abstract;
    function GetBody: TBody; virtual; abstract;
    procedure SetStatusCode(ACode: Integer); virtual; abstract;
  public
    procedure SetCreated(const ALocation: string; AStatusCode: Integer = 201); virtual; abstract;
    procedure RaiseError(ACode: Integer; const AError, ADescription: string);
    procedure RaiseNotFound(const AError: string = ''; const  ADescription: string = '');
    procedure RaiseBadRequest(const AError: string = ''; const  ADescription: string = '');
    procedure RaiseDuplicate(const AError: string = ''; const  ADescription: string = '');
    procedure RaiseForbidden(const AError: string = ''; const  ADescription: string = '');
    procedure RaiseUnauthorized(const AError: string = ''; const  ADescription: string = '');
    property Body: TBody read GetBody;
    property Headers: THeaders read GetHeaders;
    property StatusCode: Integer write SetStatusCode;
  end;

  EEMSError = class(Exception);

  EEMSHTTPError = class(EEMSError)
  public type
    TCodes = record
      const BadRequest = 400;
      const NotFound = 404;
      const Duplicate = 409;  // Duplicate
      const Unauthorized = 401;  // Don't know who you are
      const Forbidden = 403;  // I know who you are but not allowed
    end;
  private
    FCode: Integer;
    FDescription: string;
    function GetCode: Integer;
    function GetError: string;
  public
    class procedure RaiseError(ACode: Integer; const AError: string = ''; const ADescription: string = ''); static;
    class procedure RaiseDuplicate(const AError: string = ''; const ADescription: string = ''); static;
    class procedure RaiseNotFound(const AError: string = ''; const ADescription: string = ''); static;
    class procedure RaiseBadRequest(const AError: string = ''; const ADescription: string = ''); static;
    class procedure RaiseUnauthorized(const AError: string = ''; const ADescription: string = ''); static;
    class procedure RaiseForbidden(const AError: string = ''; const ADescription: string = ''); static;
  public
    constructor Create(ACode: Integer; const AError: string = ''; const ADescription: string = '');
    property Code: Integer read GetCode;
    property Description: string read FDescription;
    property Error: string read GetError;
  end;

  EEMSHTTPBadRequestError = class(EEMSHTTPError)
  public
    constructor Create(const AError: string = ''; const ADescription: string = '');
  end;

  EEMSHTTPResourceNotFoundError = class(EEMSHTTPError)
  public
    constructor Create(const AError: string = ''; const ADescription: string = '');
  end;

  EEMSHTTPDuplicateError = class(EEMSHTTPError)
  public
    constructor Create(const AError: string = ''; const ADescription: string = '');
  end;

  EEMSHTTPUnauthorizedError = class(EEMSHTTPError)
  public
    constructor Create(const AError: string = ''; const ADescription: string = '');
  end;

  EEMSHTTPForbiddenError = class(EEMSHTTPError)
  public
    constructor Create(const AError: string = ''; const ADescription: string = '');
  end;

  EEMSEndpointError = class(EEMSError);

  procedure RegisterResource(const AResource: TEMSResource); overload;

implementation

uses EMS.Consts, System.TypInfo, System.StrUtils;

procedure RegisterResource(const AResource: TEMSResource);
begin
  TEMSEndpointManager.Instance.RegisterResource(AResource);
end;

{ TEMSResource }

function TEMSResource.IsBaseURL(const ABaseURL: string): Boolean;
begin
  Result := True; // Default
end;

procedure TEMSResource.HandleRequest(const AContext: TEndpointContext);
begin
  DoHandleRequest(AContext);
end;

function TEMSResource.CanHandleRequest(const AContext: TEndpointContext; out AEndpointName: string): Boolean;
begin
  Result := DoCanHandleRequest(AContext, AEndpointName);
end;

{ TEMSEndpointManager }

destructor TEMSEndpointManager.Destroy;
begin
  if FInstance = Self then
    FInstance := nil;
  inherited;
end;

class function TEMSEndpointManager.GetInstance: TEMSEndpointManager;
begin
  if FInstance = nil then
  begin
    if Assigned(FEndpointManagerFactory) then
      FInstance := FEndpointManagerFactory;
    if FInstance = nil then
      raise EEMSError.Create(sNoEndpointImplementationFound);
  end;
  Result := FInstance;
end;

{ TEMSEndpointAuthorization }

destructor TEMSEndpointAuthorization.Destroy;
begin
  if FInstance = Self then
    FInstance := nil;
  inherited;
end;

class function TEMSEndpointAuthorization.GetInstance: TEMSEndpointAuthorization;
begin
  if FInstance = nil then
  begin
    if Assigned(FEndpointAuthorizationFactory) then
      FInstance := FEndpointAuthorizationFactory;
    if FInstance = nil then
      raise EEMSError.Create(sNoEndpointImplementationFound);
  end;
  Result := FInstance;
end;


{ TEndpointPairs }

procedure TEndpointParams.Add(const AName, AValue: string);
begin
  DoAdd(AName, AValue);
end;

procedure TEndpointParams.DoAdd(const AName, AValue: string);
begin
  raise ENotSupportedException.Create(sAddNotSupported);
end;

function TEndpointParams.GetEnumerator: TEnumerator<TPairItem>;
begin
  Result := TEnumerator.Create(Self);
end;

function TEndpointParams.GetValue(const AName: string): string;
begin
  if not TryGetValue(AName, Result) then
    raise EEMSEndpointError.CreateFmt(sNameNotFound, [AName]);
end;

function TEndpointParams.ToArray: TArray<TPairItem>;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    Result := Result + [Self.Pairs[I]];
end;

{ TEndpointSegments }

procedure TEndpointSegments.Add(const AName: string);
begin
  DoAdd(AName);
end;

procedure TEndpointSegments.DoAdd(const AName: string);
begin
  raise ENotSupportedException.Create(sAddNotSupported);
end;

function TEndpointSegments.GetEnumerator: TEnumerator<string>;
begin
  Result := TEnumerator.Create(Self);
end;

function TEndpointSegments.ToArray: TArray<string>;
var
  S: string;
begin
  for S in Self do
    Result := Result + [S];
end;

{ TEndpointBody }

function TEndpointRequestBody.GetArray: TJSONArray;
begin
  if not TryGetArray(Result) then
    raise EEMSEndpointError.CreateFmt(sBodyTypeNotFound, [TJSONArray.ClassName]);
end;

function TEndpointRequestBody.GetBytes: TBytes;
begin
  if not TryGetBytes(Result) then
    raise EEMSEndpointError.CreateFmt(sBodyTypeNotFound, ['TBytes']); // Do not localize
end;

function TEndpointRequestBody.GetObject: TJSONObject;
begin
  if not TryGetObject(Result) then
    raise EEMSEndpointError.CreateFmt(sBodyTypeNotFound, [TJSONObject.ClassName]);
end;

function TEndpointRequestBody.GetStream: TStream;
begin
  if not TryGetStream(Result) then
    raise EEMSEndpointError.CreateFmt(sBodyTypeNotFound, [TStream.ClassName]);
end;

function TEndpointRequestBody.GetValue: TJSONValue;
begin
  if not TryGetValue(Result) then
    raise EEMSEndpointError.CreateFmt(sBodyTypeNotFound, [TJSONValue.ClassName]);
end;

{ TEndpointHeaders }

procedure TEndpointHeaders.DoSetValue(const AName, AValue: string);
begin
  raise ENotSupportedException.Create(sSetValueNotSupported);
end;

function TEndpointHeaders.GetValue(const AName: string): string;
begin
  if not TryGetValue(AName, Result) then
    raise EEMSEndpointError.CreateFmt(sHeaderNotFound, [AName]);
end;

procedure TEndpointHeaders.SetValue(const AName, AValue: string);
begin
  DoSetValue(AName, AValue);
end;

{ TEndpointResponse }

procedure TEndpointResponse.RaiseBadRequest(const AError, ADescription: string);
begin
  EEMSHTTPError.RaiseBadRequest(AError, ADescription);
end;

procedure TEndpointResponse.RaiseDuplicate(const AError, ADescription: string);
begin
  EEMSHTTPError.RaiseDuplicate(AError, ADescription);
end;

procedure TEndpointResponse.RaiseError(ACode: Integer; const AError, ADescription: string);
begin
  EEMSHTTPError.RaiseError(ACode, AError, ADescription);
end;

procedure TEndpointResponse.RaiseNotFound(const AError, ADescription: string);
begin
  EEMSHTTPError.RaiseNotFound(AError, ADescription);
end;

procedure TEndpointResponse.RaiseUnauthorized(const AError, ADescription: string);
begin
  EEMSHTTPError.RaiseUnauthorized(AError, ADescription);
end;

procedure TEndpointResponse.RaiseForbidden(const AError, ADescription: string);
begin
  EEMSHTTPError.RaiseForbidden(AError, ADescription);
end;

{ EEMSHTTPError }

constructor EEMSHTTPError.Create(ACode: Integer; const AError,
  ADescription: string);
begin
  inherited Create(AError);
  FCode := ACode;
  FDescription := ADescription;
end;

function EEMSHTTPError.GetCode: Integer;
begin
  if FCode >= 300 then
    Result := FCode
  else
    Result := 500;
end;

function EEMSHTTPError.GetError: string;
begin
  Result := Self.Message;
end;

class procedure EEMSHTTPError.RaiseBadRequest(const AError, ADescription: string);
begin
  raise EEMSHTTPBadRequestError.Create(
    IfThen(AError <> '', AError, sBadRequestMessage),
    IfThen(ADescription <> '', ADescription, sBadRequestDescription));
end;

class procedure EEMSHTTPError.RaiseDuplicate(const AError, ADescription: string);
begin
  raise EEMSHTTPDuplicateError.Create(
    IfThen(AError <> '', AError, sDuplicateMessage),
    IfThen(ADescription <> '', ADescription, sDuplicateDescription));
end;

class procedure EEMSHTTPError.RaiseError(ACode: Integer; const AError, ADescription: string);
begin
  Assert(ACode >= 300);
  case ACode of
    TCodes.BadRequest: RaiseBadRequest(AError, ADescription);
    TCodes.NotFound: RaiseNotFound(AError, ADescription);
    TCodes.Duplicate: RaiseDuplicate(AError, ADescription);
    TCodes.Unauthorized: RaiseUnauthorized(AError, ADescription);
    TCodes.Forbidden: RaiseForbidden(AError, ADescription);
  else
    raise EEMSHTTPError.Create(ACode, AError, ADescription);
  end;
end;

class procedure EEMSHTTPError.RaiseNotFound(const AError, ADescription: string);
begin
  raise EEMSHTTPResourceNotFoundError.Create(
    IfThen(AError <> '', AError, sNotFoundMessage),
    IfThen(ADescription <> '', ADescription, sNotFoundDescription));
end;

class procedure EEMSHTTPError.RaiseUnauthorized(const AError, ADescription: string);
begin
  raise EEMSHTTPUnauthorizedError.Create(
    IfThen(AError <> '', AError, sUnauthorizedMessage),
    IfThen(ADescription <> '', ADescription, sUnauthorizedDescription));
end;

class procedure EEMSHTTPError.RaiseForbidden(const AError, ADescription: string);
begin
  raise EEMSHTTPForbiddenError.Create(
    IfThen(AError <> '', AError, sForbiddenMessage),
    IfThen(ADescription <> '', ADescription, sForbiddenDescription));
end;

{ EEMSHTTPBadRequestError }

constructor EEMSHTTPBadRequestError.Create(const AError, ADescription: string);
begin
  inherited Create(EEMSHTTPError.TCodes.BadRequest, AError, ADescription);
end;

{ EEMSHTTPResourceNotFoundError }

constructor EEMSHTTPResourceNotFoundError.Create(const AError,
  ADescription: string);
begin
  inherited Create(EEMSHTTPError.TCodes.NotFound, AError, ADescription);
end;

{ EEMSHTTPDuplicateError }

constructor EEMSHTTPDuplicateError.Create(const AError, ADescription: string);
begin
  inherited Create(EEMSHTTPError.TCodes.Duplicate, AError, ADescription);
end;

{ EEMSHTTPUnauthorizedError }

constructor EEMSHTTPUnauthorizedError.Create(const AError, ADescription: string);
begin
  inherited Create(EEMSHTTPError.TCodes.Unauthorized, AError, ADescription);
end;

{ EEMSHTTPForbiddenError }

constructor EEMSHTTPForbiddenError.Create(const AError, ADescription: string);
begin
  inherited Create(EEMSHTTPError.TCodes.Forbidden, AError, ADescription);
end;

{ TEndpointParams.TEnumerator }

constructor TEndpointParams.TEnumerator.Create(const AParams: TEndpointParams);
begin
  inherited Create;
  FParams := AParams;
  FIndex := -1;
end;

function TEndpointParams.TEnumerator.DoGetCurrent: TPairItem;
begin
  Result := FParams.Pairs[FIndex];
end;

function TEndpointParams.TEnumerator.DoMoveNext: Boolean;
begin
  if FIndex >= FParams.Count then
    Exit(False);
  Inc(FIndex);
  Result := FIndex < FParams.Count;
end;

{ TEndpointSegments.TEnumerator }

constructor TEndpointSegments.TEnumerator.Create(const ASegments: TEndpointSegments);
begin
  inherited Create;
  FSegments := ASegments;
  FIndex := -1;
end;

function TEndpointSegments.TEnumerator.DoGetCurrent: string;
begin
  Result := FSegments[FIndex];
end;

function TEndpointSegments.TEnumerator.DoMoveNext: Boolean;
begin
  if FIndex >= FSegments.Count then
    Exit(False);
  Inc(FIndex);
  Result := FIndex < FSegments.Count;
end;

initialization
finalization
  TEMSEndpointManager.FInstance.Free;
  TEMSEndpointAuthorization.FInstance.Free;
end.
