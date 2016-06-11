{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.EndPoint;

interface

uses System.Classes, System.SysUtils, System.Generics.Collections, REST.Backend.Providers,
  REST.Client, REST.Backend.ServiceTypes, System.JSON;

type

  // Base class for provider components derived from TCustomRESTRequest

  TBackendRequestComponent = class(TCustomRESTRequest, IBackendServiceComponent)
  private
    FProvider: IBackendProvider;
    FRESTClient: TRESTClient;
    function GetProvider: IBackendProvider; // IBackendServiceComponent
    function IBackendServiceComponent.GetServiceIID = GetBackendServiceIID;
  protected
    procedure ProviderChanged; virtual;
    function CreateService(const AProvider: IBackendProvider): IBackendService;
    procedure SetProvider(const Value: IBackendProvider);
    function GetBackendServiceIID: TGUID; virtual; abstract;
    procedure UpdateProvider(const AProvider: IBackendProvider); virtual; abstract;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ClearProvider; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ServiceIID: TGUID read GetBackendServiceIID;
    property Provider: IBackendProvider read GetProvider write SetProvider;
  end;

  TBackendRequestComponent<TI: IBackendService; T: Class> = class(TBackendRequestComponent)
  public type
    TExecuteProc = TProc<T>;
    TExecuteEvent = procedure(Sender: TObject; AAPI: T) of object;
    TAPIThread = TBackendAPIThread<T>;
  private
    FBackendService: TI;
    FBackendServiceAPI: T;
    FAPIThread: TAPIThread;
    function CreateService(const AProvider: IBackendProvider): TI;
    procedure SetAPIThread(
      const AValue: TAPIThread);
  protected
    function GetBackendServiceAPI: T;
    function GetBackendService: TI;
    procedure ClearProvider; override;
    function GetBackendServiceIID: TGUID; override;
    procedure UpdateProvider(const AValue: IBackendProvider); override;
    function InternalCreateBackendServiceAPI: T; virtual; abstract;
    function InternalCreateIndependentBackendServiceAPI: T; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property APIThread: TAPIThread read FAPIThread write SetAPIThread;
  end;

  TBackendRequestComponentAuth<TI: IBackendService; T: Class> = class(TBackendRequestComponent<TI, T>)
  private
    FAuth: IBackendAuthReg;
    FAuthAccess: IAuthAccess;
    procedure SetAuth(const Value: IBackendAuthReg);
  protected
    function CreateAuthAccess: IAuthAccess; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    destructor Destroy; override;
    property Auth: IBackendAuthReg read FAuth write SetAuth;
  end;

  TCustomBackendEndpoint = class(TBackendRequestComponentAuth<IBackendCustomEndpointService, TBackendCustomEndpointAPI>, IRESTResponseJSON)
  public type
    TAllowHTTPErrors = (None, Any, ClientErrors, ClientErrorNotFound_404);
  private
    FJSONNotifyList: TList<TNotifyEvent>;
    FAllowHTTPErrors: TAllowHTTPErrors;
    function GetEndpointAPI: TBackendCustomEndpointApi;
    procedure JSONValueChanged(Sender: TObject);
  protected
    { IRESTResponseJSON }   // Support ResponseAdapter
    procedure AddJSONChangedEvent(const ANotify: TNotifyEvent);
    procedure RemoveJSONChangedEvent(const ANotify: TNotifyEvent);
    procedure GetJSONResponse(out AJSONValue: TJSONValue; out AHasOwner: Boolean);
    function HasJSONResponse: Boolean;
    function HasResponseContent: Boolean;

    procedure DoResponseChanged;  override;
    procedure DoResponseChanging; override;
    function InternalCreateBackendServiceAPI: TBackendCustomEndpointAPI; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendCustomEndpointAPI; override;
    procedure DoBeforeExecute; override;
    procedure DoAfterExecute; override;
    function CreateAuthAccess: IAuthAccess; override;
    function CreateRequestBindSource: TSubRESTRequestBindSource; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property EndpointApi: TBackendCustomEndpointAPI read GetEndpointAPI;
    property AllowHTTPErrors: TAllowHTTPErrors read FAllowHTTPErrors write FAllowHTTPErrors default TAllowHTTPErrors.None;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendEndpoint = class(TCustomBackendEndPoint)
  published
    property Provider;
    property Auth;

//    property Accept;
//    property AcceptCharset;
//    property AcceptEncoding;
    property AutoCreateParams;
//    property HandleRedirects;
//    property Client;
    property Method;
    property Params;
    property Resource;
    property ResourceSuffix;
    property Response;
    property Timeout;
    property OnAfterExecute;
//    property ExecutionPerformance;
//    property SynchronizedEvents;
//    property OnHTTPProtocolError;
    property BindSource;
    property AllowHTTPErrors;

  end;

implementation

uses System.TypInfo, REST.Utils, REST.Backend.Exception, REST.Backend.Consts,
  REST.Backend.ServiceComponents, Data.Bind.Components, REST.JSON;

{ TCustomBackendEndpoint }

procedure TCustomBackendEndpoint.AddJSONChangedEvent(
  const ANotify: TNotifyEvent);
begin
  Assert(not FJSONNotifyList.Contains(ANotify));
  if not FJSONNotifyList.Contains(ANotify) then
    FJSONNotifyList.Add(ANotify);
end;

constructor TCustomBackendEndpoint.Create(AOwner: TComponent);
begin
  /// it is important to create the notify-list before
  /// calling the inherited constructor
  FJSONNotifyList := TList<TNotifyEvent>.Create;
  inherited;
end;

function TCustomBackendEndpoint.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetEndpointAPI.AuthenticationApi;
    end);
end;

type
  TSubBackendEndpointBindSource = class(TSubRESTRequestBindSource)
  protected
    function CreateRequestAdapter: TRESTRequestAdapter; override;
  end;

function TCustomBackendEndpoint.CreateRequestBindSource: TSubRESTRequestBindSource;
begin
  Result := TSubBackendEndpointBindSource.Create(self);
end;

procedure TCustomBackendEndpoint.JSONValueChanged(Sender: TObject);
var
  LNotifyEvent: TNotifyEvent;
begin
  PropertyValueChanged;
  for LNotifyEvent in  FJSONNotifyList do
    LNotifyEvent(Self);
end;

procedure TCustomBackendEndpoint.RemoveJSONChangedEvent(
  const ANotify: TNotifyEvent);
begin
  Assert(FJSONNotifyList.Contains(ANotify));
  FJSONNotifyList.Remove(ANotify);
end;

destructor TCustomBackendEndpoint.Destroy;
begin
  FJSONNotifyList.Free;
  inherited;
end;

procedure TCustomBackendEndpoint.DoAfterExecute;
begin
  inherited;
  case AllowHTTPErrors of
    None:
      GetBackendServiceApi.CheckForResponseErrors(Self.Response, []);
    Any: ; // No error checking
    ClientErrors:
      if not Self.Response.Status.ClientError then
        GetBackendServiceApi.CheckForResponseErrors(Self.Response, []);
    ClientErrorNotFound_404:
      GetBackendServiceApi.CheckForResponseErrors(Self.Response,
        TArray<Integer>.Create(404));
  end;
end;

procedure TCustomBackendEndpoint.DoBeforeExecute;
begin
                                                                                 
  GetBackendServiceApi.PrepareClient(FRESTClient);
  GetBackendServiceApi.PrepareRequest(Self);
  inherited;
end;

procedure TCustomBackendEndpoint.DoResponseChanged;
var
  Intf: IRESTResponseJSON;
begin
  if Supports(Response, IRESTResponseJSON, Intf) then
  begin
    Intf.AddJSONChangedEvent(JSONValueChanged);
    if ([csLoading, csDestroying] * ComponentState) = [] then
      JSONValueChanged(Self);
  end;
end;

procedure TCustomBackendEndpoint.DoResponseChanging;
var
  Intf: IRESTResponseJSON;
begin
  if Supports(Response, IRESTResponseJSON, Intf) then
    Intf.RemoveJSONChangedEvent(JSONValueChanged);
end;

function TCustomBackendEndpoint.InternalCreateBackendServiceAPI: TBackendCustomEndpointApi;
begin
  Result := TBackendCustomEndpointApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendEndpoint.InternalCreateIndependentBackendServiceAPI: TBackendCustomEndpointApi;
begin
  Result := TBackendCustomEndpointApi.Create(GetBackendService.CreateCustomEndpointApi); // Service.CreateStorageApi);
end;

function TCustomBackendEndpoint.GetEndpointAPI: TBackendCustomEndpointApi;
begin
  Result := GetBackendServiceAPI;
end;

procedure TCustomBackendEndpoint.GetJSONResponse(out AJSONValue: TJSONValue;
  out AHasOwner: Boolean);
begin
  if (Response <> nil) and (Response.JSONValue <> nil) then
  begin
    AJSONValue := Response.JSONValue;
    AHasOwner := True;
  end
  else
  begin
    AJSONValue := nil;
    AHasOwner := False;
  end;
end;

function TCustomBackendEndpoint.HasJSONResponse: Boolean;
begin
  Result := (Response <> nil) and (Response.JSONValue <> nil);
end;

function TCustomBackendEndpoint.HasResponseContent: Boolean;
begin
  Result := (Response <> nil) and (Response.ContentLength > 0);
end;

{ TBackendServiceComponent }

procedure TBackendRequestComponent.SetProvider(const Value: IBackendProvider);
begin
  if FProvider <> Value then
  begin
    if FProvider <> nil then
    begin
      if FProvider is TComponent then
        TComponent(FProvider).RemoveFreeNotification(Self);
    end;
    UpdateProvider(Value);
    FProvider := Value;
    if FProvider <> nil then
    begin
      if FProvider is TComponent then
        TComponent(FProvider).FreeNotification(Self);
    end;
    ProviderChanged;
  end;
end;

procedure TBackendRequestComponent.ProviderChanged;
begin
end;

procedure TBackendRequestComponent.ClearProvider;
begin
  FProvider := nil;
end;

constructor TBackendRequestComponent.Create(AOwner: TComponent);
var
  LProvider: IBackendProvider;
begin
  inherited;
  FRESTClient := TRESTClient.Create(nil);
  Client := FRESTClient;
  SynchronizedEvents := False;
  Client.SynchronizedEvents := False;
  Client.RaiseExceptionOn500 := False;
  // Find a default provider
  if not Supports(AOwner, IBackendProvider, LProvider) then
    if csDesigning in ComponentState then
      LProvider := TRESTFindDefaultComponent.FindDefaultIntfT<IBackendProvider>(Self);
  if LProvider <> nil then
    if TBackendProviders.Instance.FindService(LProvider.ProviderID, ServiceIID) <> nil then
      // Valid provider
      Provider := LProvider;
end;

function TBackendRequestComponent.CreateService(
  const AProvider: IBackendProvider): IBackendService;
var
  LService: TBackendProviders.TService;
begin
  LService := TBackendProviders.Instance.FindService(AProvider.ProviderID, ServiceIID);
  if LService <> nil then
  begin
    Result := LService.FactoryProc(AProvider, ServiceIID) as IBackendService;
  end
  else
    raise EBackendServiceError.CreateFmt(sServiceNotSupportedByProvider, [AProvider.ProviderID]);

end;

destructor TBackendRequestComponent.Destroy;
begin
  FRESTClient.Free;
  inherited;
end;

function TBackendRequestComponent.GetProvider: IBackendProvider;
begin
  Result := FProvider;
end;

procedure TBackendRequestComponent.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if (Operation = opRemove) then
  begin
    if (FProvider is TComponent) and (TComponent(FProvider) = AComponent) then
      ClearProvider;
  end;
end;

{ TBackendServiceComponent<TService: IBackendService; TApi: Class> }

destructor TBackendRequestComponent<TI, T>.Destroy;
begin
  FAPIThread.Free;
  ClearProvider;
  inherited;
end;

constructor TBackendRequestComponent<TI, T>.Create(AOwner: TComponent);
begin
  inherited;
  FAPIThread := TAPIThread.Create;
  FAPIThread.OnCreateAPI :=
    function: T
    begin
      Result := InternalCreateIndependentBackendServiceAPI;
    end;
end;

function TBackendRequestComponent<TI, T>.CreateService(
  const AProvider: IBackendProvider): TI;
begin
  Result := TI(inherited CreateService(AProvider));
  Assert(Supports(Result, ServiceIID));
end;

function TBackendRequestComponent<TI, T>.GetBackendServiceAPI: T;
begin
  if FBackendServiceAPI = nil then
  begin
    if FBackendService <> nil then
      FBackendServiceAPI := InternalCreateBackendServiceAPI // TBackendQueryApi.Create(FService.CreateQueryApi)
    else
      raise EBackendServiceError.CreateFmt(sNoBackendService, [Self.ClassName]);
  end;
  Result := FBackendServiceAPI;
end;

function TBackendRequestComponent<TI, T>.GetBackendService: TI;
begin
  Result := FBackendService;
end;

function TBackendRequestComponent<TI, T>.GetBackendServiceIID: TGUID;
begin
  Result := GetTypeData(TypeInfo(TI)).Guid;
end;

function TBackendRequestComponent<TI, T>.InternalCreateIndependentBackendServiceAPI: T;
begin
  raise ENotImplemented.Create('InternalCreateIndependentBackendServiceAPI'); // do not localize
end;

procedure TBackendRequestComponent<TI, T>.SetAPIThread(const AValue: TAPIThread);
begin
  FAPIThread.Assign(AValue);
end;

procedure TBackendRequestComponent<TI, T>.ClearProvider;
begin
  inherited;
  FBackendService := nil;
  FreeAndNil(FBackendServiceAPI);
end;

procedure TBackendRequestComponent<TI, T>.UpdateProvider(const AValue: IBackendProvider);
begin
  ClearProvider;
  if AValue <> nil then
    FBackendService := CreateService(AValue);  // May raise an exception
end;

{ TBackendRequestComponentAuth<TI, T> }

function TBackendRequestComponentAuth<TI, T>.CreateAuthAccess: IAuthAccess;
begin
  Result := nil;
end;

destructor TBackendRequestComponentAuth<TI, T>.Destroy;
begin
  Auth := nil; // Unregister for auth
  inherited;
end;

procedure TBackendRequestComponentAuth<TI, T>.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if (Operation = opRemove) then
  begin
    if (FAuth is TComponent) and (TComponent(FAuth) = AComponent) then
      Auth := nil;
  end;
end;

procedure TBackendRequestComponentAuth<TI, T>.SetAuth(
  const Value: IBackendAuthReg);
begin
  if FAuth <> Value then
  begin
    if FAuth <> nil then
    begin
      if FAuth is TComponent then
        TComponent(FAuth).RemoveFreeNotification(Self);
      if FAuthAccess <> nil then
        try
          FAuth.UnregisterForAuth(FAuthAccess);
        finally
          FAuthAccess := nil;
        end;
    end;
    FAuth := Value;
    if FAuth <> nil then
    begin
      if FAuth is TComponent then
        TComponent(FAuth).FreeNotification(Self);
      FAuthAccess := CreateAuthAccess;
      if FAuthAccess <> nil then
        FAuth.RegisterForAuth(FAuthAccess);
    end;
  end;
end;

{ TBackendEndpointRequestAdapter }

type
  TBackendEndpointRequestAdapter = class(TRESTRequestAdapter)

  protected
    procedure CreatePropertyFields; override;
  end;

function TSubBackendEndpointBindSource.CreateRequestAdapter: TRESTRequestAdapter;
begin
  Result := TBackendEndpointRequestAdapter.Create(Self);
end;


procedure TBackendEndpointRequestAdapter.CreatePropertyFields;
const
  sJSONText = 'Response.JSONText';
begin
  inherited;
  CreateReadOnlyField<string>(sJSONText, nil, TScopeMemberType.mtText,
    function: string
    begin
      if Request.Response <> nil then
        result := Request.Response.JSONText
      else
        Result := '';
    end);
end;

end.
