{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMSHosting.EdgeService;

interface

{$HPPEMIT LINKUNIT}
uses System.SysUtils, System.Classes,
  REST.Backend.EMSProvider, REST.Backend.EMSApi,
  REST.Backend.ServiceComponents, REST.Backend.Providers,
  REST.Backend.ServiceTypes, System.JSON, EMSHosting.RequestTypes;

type

  IBackendEdgemoduleAPI = interface;
  IBackendEdgemoduleService = interface;

  // Wrapper
  TBackendEdgemoduleApi = class(TBackendAuthenticationApi)
  private
    FServiceApi: IBackendEdgemoduleAPI;
    FService: IBackendEdgemoduleService;
    function GetServiceAPI: IBackendEdgemoduleAPI;
    function GetModuleID: string;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    constructor Create(const AApi: IBackendEdgemoduleAPI); overload;
    constructor Create(const AService: IBackendEdgemoduleService); overload;
    procedure RegisterModule(const AName: string;
      const AModuleDetails: TJSONObject; const AProtocolName, AProtocolProperties: string;
      const AResources: TJSONArray);
    procedure UnregisterModule;
    property ProviderAPI: IBackendEdgemoduleAPI read FServiceAPI;
    property ModuleID: string read GetModuleID;
  end;

  IBackendEdgemoduleAPI = interface
    ['{DF5C4F53-5058-4E75-A33B-ABC5D07139B2}']
    procedure RegisterModule(const AName: string;
      const AModuleDetails: TJSONObject; const AProtocolName, AProtocolProperties: string;
      const AResources: TJSONArray);
    procedure UnregisterModule;
    function GetModuleID: string;
    property ModuleID: string read GetModuleID;
  end;

  IBackendEdgemoduleService = interface(IBackendService)
    ['{80409801-58DB-4DEF-8207-EA0E28773C89}']
    function GetModuleAPI: IBackendEdgemoduleAPI;
    function CreateModuleApi: IBackendEdgemoduleAPI;
    property ModuleAPI: IBackendEdgemoduleAPI read GetModuleAPI;
  end;

  TEMSEdgeListener = class;

  //[ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TCustomEMSEdgeService = class(TBackendServiceComponentAuth<IBackendEdgemoduleService, TBackendEdgemoduleApi>)
  public type
    THandledEvent = procedure(Sender: TObject; var AHandled: Boolean) of object;
    TRegisteringEvent = procedure(Sender: TObject; const AModuleDetail: TJSONObject; const AResources: TJSONArray; var AHandled: Boolean) of object;
  private
    FModuleName: string;
    FAutoActivate: Boolean;
    FAutoRegister: Boolean;
    FAutoUnRegister: Boolean;
    FDeferActive: Boolean;
    FListenerProtocol: string;
    FListenerService: TEMSEdgeListener;
    FOnUnregistering: THandledEvent;
    FOnRegistered: TNotifyEvent;
    FOnUnregistered: TNotifyEvent;
    FOnRegistering: TRegisteringEvent;
    FModuleVersion: string;
    function GetModuleAPI: TBackendEdgemoduleApi;
    function GetProviderService: IBackendEdgemoduleService;
    procedure SetModuleName(const Value: string);
    procedure CheckModuleName;
    function GetActive: Boolean;
    procedure SetActive(const Value: Boolean);
    procedure SetListenerProtocol(const Value: string);
    procedure CheckListenerProtocol;
    procedure SetModuleVersion(const Value: string);
    function GetModuleID: string;
  protected
    procedure Loaded; override;
    function InternalCreateBackendServiceAPI: TBackendEdgemoduleApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendEdgemoduleApi; override;
    function CreateAuthAccess: IAuthAccess; override;
    procedure DoOnRegistering(const AModuleDetails: TJSONObject; const AResources: TJSONArray; var AHandled: Boolean); virtual;
    procedure DoOnRegistered; virtual;
    procedure DoOnUnregistering(var AHandled: Boolean); virtual;
    procedure DoOnUnregistered; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ProviderChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UnregisterModule;
    procedure RegisterModule(const ADetails: TJSONObject = nil);
    property Active: Boolean read GetActive write SetActive;
    property ListenerProtocol: string read FListenerProtocol write SetListenerProtocol;
    property ListenerService: TEMSEdgeListener read FListenerService;
    property AutoActivate: Boolean read FAutoActivate write FAutoActivate default True;
    property AutoRegister: Boolean read FAutoRegister write FAutoRegister default True;
    property AutoUnRegister: Boolean read FAutoUnRegister write FAutoUnRegister default True;
    property ModuleName: string read FModuleName write SetModuleName;
    property ModuleVersion: string read FModuleVersion write SetModuleVersion;
    property ModuleAPI: TBackendEdgemoduleApi read GetModuleAPI;
    property ModuleID: string read GetModuleID;
    property ProviderService: IBackendEdgemoduleService read GetProviderService;
    property OnRegistering: TRegisteringEvent read FOnRegistering write FOnRegistering;
    property OnRegistered: TNotifyEvent read FOnRegistered write FOnRegistered;
    property OnUnregistering: THandledEvent read FOnUnregistering write FOnUnregistering;
    property OnUnregistered: TNotifyEvent read FOnUnregistered write FOnUnregistered;
    function CreateModuleAPI: TBackendEdgemoduleApi;
  end;

  TEMSEdgeService = class(TCustomEMSEdgeService)
  published
    property AutoActivate;
    property AutoRegister;
    property AutoUnRegister;
    property ModuleName;
    property ModuleVersion;
    property Provider;
    property Auth;
    property ListenerProtocol;
    property ListenerService;
    property OnRegistering;
    property OnUnregistering;
    property OnRegistered;
    property OnUnregistered;
  end;

  TEMSEdgeListener = class(TComponent)
  public type
    TModule = class abstract
    private
      FModuleName: string;
      FModuleVersion: string;
    public
      constructor Create(const AModuleName, AModuleVersion: string); 
      function GetGroupsByUser(const AUserID: string): TArray<string>; virtual; abstract;
      function UserIDOfSession(const ASessionToken: string; out AUserID: string): Boolean; virtual; abstract;
      function UserNameOfID(const AUserID: string; out AUserName: string): Boolean; virtual; abstract;
      property ModuleName: string read FModuleName;
      property ModuleVersion: string read FModuleVersion;
    end;
    TModuleContext = class(TEMSEdgeHostContext)
    private
      FModule: TEMSEdgeListener.TModule;
    protected
      function GetModuleName: string; override;
      function GetModuleVersion: string; override;
      function GetGroupsByUser(const AUserID: string): TArray<string>; override;
      function UserIDOfSession(const ASessionID: string; out AUserID: string): Boolean; override;
      function UserNameOfID(const AUserID: string; out AUserName: string): Boolean; override;
    public
      constructor Create(const AModule: TEMSEdgeListener.TModule);
    end;
    TCreateModuleEvent = reference to function: TModule;
  private
    FProtocolProps: TJSONObject;
    FOnCreateModule: TCreateModuleEvent;
    function GetProtocolProps: TJSONObject;
  protected
    function CreateModule: TModule;
    function GetActive: Boolean; virtual; abstract;
    procedure SetActive(const Value: Boolean); virtual; abstract;
    procedure AddProtocolProps(const AProperties: TJSONObject); virtual; abstract;
    function GetModule: TModule; virtual; abstract;
  public
    destructor Destroy; override;
    property Active: Boolean read GetActive write SetActive;
    property Module: TModule read GetModule;
    property ProtocolProps: TJSONObject read GetProtocolProps;
    property OnCreateModule: TCreateModuleEvent read FOnCreateModule write FOnCreateModule;
  end;


implementation

uses REST.Backend.ServiceFactory, System.Generics.Collections, REST.Backend.EMSServices,
  EMS.ResourceAPI, EMS.ResourceTypes, EMSHosting.EdgeListeners, EMSHosting.ExtensionsServices,
  EMSHosting.Consts, EMSHosting.APIDocResource, EMSHosting.APIDocConsts;

{ TCustomBackendModule }

constructor TCustomEMSEdgeService.Create(AOwner: TComponent);
begin
  inherited;
  FAutoActivate := True;
  FAutoRegister := True;
  FAutoUnRegister := True;
  FModuleVersion := '1';
end;

function TCustomEMSEdgeService.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetModuleAPI.AuthenticationApi;
    end);
end;

function TCustomEMSEdgeService.CreateModuleAPI: TBackendEdgemoduleApi;
begin
  Result := InternalCreateIndependentBackendServiceAPI;
end;

procedure TCustomEMSEdgeService.DoOnRegistering(const AModuleDetails: TJSONObject; const AResources: TJSONArray; var AHandled: Boolean);

begin
  if Assigned(FOnRegistering) then
    FOnRegistering(Self, AModuleDetails, AResources, AHandled);
end;

procedure TCustomEMSEdgeService.DoOnRegistered;
begin
  if Assigned(FOnRegistered) then
    FOnRegistered(Self);
end;

procedure TCustomEMSEdgeService.DoOnUnregistering(var AHandled: Boolean);
begin
  if Assigned(FOnUnregistering) then
    FOnUnregistering(Self, AHandled);
end;

procedure TCustomEMSEdgeService.DoOnUnregistered;
begin
  if Assigned(FOnUnregistered) then
    FOnUnregistered(Self);
end;

function TCustomEMSEdgeService.GetProviderService: IBackendEdgemoduleService;
begin
  Result := GetBackendService;
end;

function TCustomEMSEdgeService.GetActive: Boolean;
begin
  Result := (FListenerService <> nil) and FListenerService.Active;
end;

function TCustomEMSEdgeService.GetModuleAPI: TBackendEdgemoduleApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomEMSEdgeService.GetModuleID: string;
begin
  Result := ModuleAPI.ModuleID;
end;

function TCustomEMSEdgeService.InternalCreateBackendServiceAPI: TBackendEdgemoduleApi;
begin
  Result := TBackendEdgemoduleApi.Create(GetBackendService); // Service.CreateModuleAPI);
end;

function TCustomEMSEdgeService.InternalCreateIndependentBackendServiceAPI: TBackendEdgemoduleApi;
begin
  Result := TBackendEdgemoduleApi.Create(GetBackendService.CreateModuleAPI); // Service.CreateModuleAPI);
end;

procedure TCustomEMSEdgeService.Loaded;
begin
  try
    inherited;
    if FDeferActive then
    begin
      FDeferActive := False;
      SetActive(True)
    end
    else if AutoActivate and (Provider <> nil)  then
      SetActive(True);
  except
    // Do not raise exception while loading
  end;
end;

procedure TCustomEMSEdgeService.ProviderChanged;
begin
  if AutoActivate and (Provider <> nil) then
    Active := True;
end;

procedure TCustomEMSEdgeService.CheckModuleName;
begin
  if ModuleName = '' then
    raise Exception.Create(sEdgeModuleNameBlank);
end;

procedure TCustomEMSEdgeService.CheckListenerProtocol;
begin
  if ListenerProtocol = '' then
    raise Exception.Create(sEdgeProtocolBlank);
end;

procedure TCustomEMSEdgeService.RegisterModule(const ADetails: TJSONObject);
var
  LProtocolProperties: string;
  LResource: TEMSResource;
  LJSONResources: TJSONArray;
  LJSONResource: TJSONObject;
  LHandled: Boolean;
  LDetails: TJSONObject;
begin
  LJSONResources := nil;
  LDetails := ADetails;
  try
    for LResource in TEMSEndpointManager.Instance.Resources do
    begin
      if LJSONResources = nil then
        LJSONResources := TJSONArray.Create;
      LJSONResource := TJSONObject.Create;
      LJSONResources.AddElement(LJSONResource);
      LJSONResource.AddPair('resourcename', LResource.Name); // Do not localize
    end;
    LHandled := False;
    if ADetails <> nil then
      // Make a copy for event handler to modify
      LDetails := ADetails.Clone as TJSONObject
    else
      LDetails := TJSONObject.Create;
    DoOnRegistering(LDetails, LJSONResources, LHandled);
    if not LHandled then
    begin
      CheckModuleName;
      CheckListenerProtocol;
      if ListenerService <> nil then
        LProtocolProperties := ListenerService.ProtocolProps.ToJSON;

      ModuleAPI.RegisterModule(
        ModuleName, LDetails, Self.ListenerProtocol, LProtocolProperties, LJSONResources);
      DoOnRegistered;
    end;
  finally
    LJSONResources.Free;
    if LDetails <> ADetails then
      LDetails.Free;
  end;
end;


procedure TCustomEMSEdgeService.SetActive(const Value: Boolean);
begin
  if Active <> Value then
  begin
    if csLoading in ComponentState then
      FDeferActive := Value
    else
    begin
      if not (csDesigning in ComponentState)  then
      begin
        if FListenerService <> nil then
          FListenerService.Active := Value;
        if Active then
        begin
          if FAutoRegister then
            RegisterModule;
        end
        else
          if FAutoUnRegister then
            if ModuleID <> '' then
              UnregisterModule;
      end;
    end;
  end;
end;

procedure TCustomEMSEdgeService.Notification(
  AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if Operation = opRemove then
  begin
    if FListenerService = AComponent then
      FListenerService := nil;
  end;
end;

procedure TCustomEMSEdgeService.SetModuleName(const Value: string);
begin
  FModuleName := Value;
end;

procedure TCustomEMSEdgeService.SetModuleVersion(const Value: string);
begin
  FModuleVersion := Value;
end;

type
  TCustomModule = class(TEMSEdgeListener.TModule)
  private
    FAPI: TEMSClientAPI;
  protected
    function GetGroupsByUser(const AUserID: string): TArray<string>; override;
    function UserIDOfSession(const SessionToken: string; out AUserID: string): Boolean; override;
    function UserNameOfID(const AUserID: string; out AUserName: string): Boolean; override;
  public
    constructor Create(const AModuleName, AModuleVersion: string);
    destructor Destroy; override;
    procedure UpdateAPI(const AProvider: TEMSProvider);
  end;

constructor TCustomModule.Create(const AModuleName, AModuleVersion: string);
begin
  inherited Create(AModuleName, AModuleVersion);
  FAPI := TEMSClientAPI.Create;
end;

procedure TCustomModule.UpdateAPI(const AProvider: TEMSProvider);
begin
  AProvider.UpdateApi(FAPI);
end;


destructor TCustomModule.Destroy;
begin
  FAPI.Free;
  inherited;
end;

function TCustomModule.GetGroupsByUser(const AUserID: string): TArray<string>;
begin
  Result := FAPI.RetrieveUserGroups(AUserID);
end;

function TCustomModule.UserIDOfSession(const SessionToken: string; out AUserID: string): Boolean;
var
  LUserID: string;
begin
  FAPI.Login(SessionToken);
  try
    Result := FAPI.RetrieveCurrentUser(
      procedure(const AUser: TEMSClientAPI.TUser; const AObj: TJSONObject)
      begin
        LUserID := AUser.UserID;
      end);
    if Result then
      AUserID := LUserID;
  finally
    FAPI.Logout;
  end;
end;

function TCustomModule.UserNameOfID(const AUserID: string; out AUserName: string): Boolean;
var
  LUserName: string;
begin
  Result := FAPI.RetrieveUser(AUserID,
    procedure(const AUser: TEMSClientAPI.TUser;
      const AObj: TJSONObject)
    begin
      LUserName := AUser.UserName;
    end);
  if Result then
    AUserName := LUserName;
end;

procedure TCustomEMSEdgeService.SetListenerProtocol(const Value: string);
var
  LFactory: TEMSEdgeListenerFactory;
begin
  if FListenerProtocol <> Value then
  begin
    FreeAndNil(FListenerService);
    FListenerProtocol := '';
    if Value <> '' then
    begin
      if TEMSEdgeListenerFactories.Instance.TryGetFactory(Value, LFactory) then
      begin
        FListenerService := LFactory.CreateListener(Self, Value);
        FListenerService.OnCreateModule :=
          function: TEMSEdgeListener.TModule
          var
            LModule: TCustomModule;
          begin
            LModule := TCustomModule.Create(Self.ModuleName, Self.ModuleVersion);
            try
              if Provider is TEMSProvider then
                LModule.UpdateAPI(TEMSProvider(Provider));
              Result := LModule;
            except
              LModule.Free;
              raise;
            end;

          end;
      end
      else
        raise Exception.CreateFmt(sEdgeUnknownListenerProtocol, [Value]);

      FListenerProtocol := Value;
      if FListenerService <> nil then
      begin
        FListenerService.Name := 'ListenerService';  // Do not localize
        FListenerService.SetSubComponent(True);
      end;
    end;
  end;
end;

procedure TCustomEMSEdgeService.UnregisterModule;
var
  LHandled: Boolean;
begin
  LHandled := False;
  if Assigned(OnUnregistering) then
    OnUnregistering(Self, LHandled);
  if not LHandled then
  begin
    ModuleAPI.UnregisterModule;
    if Assigned(OnUnregistered) then
      OnUnregistered(Self);
  end;
end;

function TBackendEdgemoduleApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendEdgemoduleApi.GetModuleID: string;
begin
  Result := GetServiceApi.ModuleID;
end;

function TBackendEdgemoduleApi.GetServiceAPI: IBackendEdgemoduleAPI;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetModuleApi
end;

procedure TBackendEdgemoduleApi.RegisterModule(const AName: string;
  const AModuleDetails: TJSONObject; const AProtocolName, AProtocolProperties: string;
  const AResources: TJSONArray);
begin
  GetServiceApi.RegisterModule(AName, AModuleDetails,
    AProtocolName, AProtocolProperties, AResources);
end;

procedure TBackendEdgemoduleApi.UnregisterModule;
begin
  GetServiceApi.UnRegisterModule;
end;

constructor TBackendEdgemoduleApi.Create(const AApi: IBackendEdgemoduleAPI);
begin
  FServiceApi := AApi;
end;

constructor TBackendEdgemoduleApi.Create(const AService: IBackendEdgemoduleService);
begin
  FService := AService;
end;

type

  TEMSModuleAPI = class(TEMSLoginAPI, IBackendEdgemoduleAPI)
  private
    FModuleID: string;
  protected
    procedure RegisterModule(const AName: string;
      const AModuleDetails: TJSONObject; const AProtocolName, AProtocolProperties: string;
      const AResources: TJSONArray);
    procedure UnregisterModule;
    function GetModuleID: string;
  end;

  TEMSModuleService = class(TEMSBackendService<TEMSModuleAPI>, IBackendService,
    IBackendEdgemoduleService)
  protected
    { IBackendModuleService }
    function CreateModuleApi: IBackendEdgemoduleAPI;
    function GetModuleApi: IBackendEdgemoduleAPI;
  end;


{ TEMSModuleAPI }

function TEMSModuleAPI.GetModuleID: string;
begin
  Result := FModuleID;
end;

procedure TEMSModuleAPI.RegisterModule(const AName: string;
  const AModuleDetails: TJSONObject; const AProtocolName, AProtocolProperties: string;
  const AResources: TJSONArray);
var
  LModule: TEMSClientAPI.TModule;
  LUpdatedAt: TEMSClientAPI.TUpdatedAt;
begin
  if FModuleID <> '' then
  begin
    try
      EMSAPI.UpdateModule(FModuleID, AName, AProtocolName, AProtocolProperties, AModuleDetails, AResources, LUpdatedAt)
    except
      FModuleID := '';
      raise;
    end;
  end
  else
  begin
    EMSAPI.RegisterModule(AName, AProtocolName, AProtocolProperties, AModuleDetails, AResources, LModule);
    FModuleID := LModule.ModuleID;
  end;
end;

procedure TEMSModuleAPI.UnregisterModule;
begin
  if FModuleID = '' then
    raise Exception.Create('Can''t unregister module.  ModuleID is blank.');
  try
     EMSAPI.UnregisterModule(FModuleID);
  finally
     FModuleID := '';
  end;
end;

{ TEMSModuleService }

function TEMSModuleService.CreateModuleApi: IBackendEdgemoduleAPI;
begin
  Result := CreateBackendApi;
end;

function TEMSModuleService.GetModuleApi: IBackendEdgemoduleAPI;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

var
  FFactories: TList<TProviderServiceFactory>;

procedure RegisterServices;
var
  LFactory: TProviderServiceFactory;
begin
  FFactories := TObjectList<TProviderServiceFactory>.Create;
  LFactory := TEMSProviderServiceFactory<IBackendEdgemoduleService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TEMSModuleService.Create(AProvider);
    end);
  FFactories.Add(LFactory);


  for LFactory in FFactories do
     LFactory.Register;
end;

procedure UnregisterServices;
var
  LFactory: TProviderServiceFactory;
begin
  for LFactory in FFactories do
    LFactory.Unregister;
  FreeAndNil(FFactories);
end;

type
  TModuleJSONNames = record
  public const
    ModuleVersion = 'moduleversion';
    ModuleName = 'modulename';
    sGetVersion = 'GetVersion';
    sVersion = 'version';
  end;

  [ResourceName(TModuleJSONNames.sVersion)]
  [EndPointObjectsYAMLDefinitions(EdgeVersionObjectsYMALDefinition)]
  [EndPointObjectsJSONDefinitions(EdgeVersionObjectsJSONDefinition)]
  {$METHODINFO ON}
  TVersionResource = class
  published
    [EndpointName(TModuleJSONNames.sGetVersion)]
    [EndPointRequestSummary(cVersionTag, cGetVersionSummaryTitle, cGetVersionSummaryDesc, cApplicationJSON, '')]
    [EndPointResponseDetails(200, cResponseOK, TAPIDoc.TPrimitiveType.spObject, TAPIDoc.TPrimitiveFormat.None, '', '#/definitions/versionEdgeObject')]
    procedure Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
  end;
  {$METHODINFO OFF}

procedure RegisterVersionResource;
begin
    RegisterResource(TypeInfo(TVersionResource));
end;


procedure TVersionResource.Get(const AContext: TEndpointContext; const ARequest: TEndpointRequest; const AResponse: TEndpointResponse);
var
  LValue: TJSONObject;
  LVersion: string;
  LModuleName: string;
begin
  if AContext.Edgemodule <> nil then
  begin
    LVersion := AContext.Edgemodule.ModuleVersion;
    LModuleName := AContext.Edgemodule.ModuleName;
  end;
  LValue := TJSONObject.Create;
  try
    LValue.AddPair(TModuleJSONNames.ModuleVersion, TJSONString.Create(LVersion));
    LValue.AddPair(TModuleJSONNames.ModuleName, TJSONString.Create(LModuleName));
    AResponse.Body.SetValue(LValue, False);
  finally
    LValue.Free;
  end;
end;


{ TEMSEdgeListener }

function TEMSEdgeListener.CreateModule: TModule;
begin
  if Assigned(FOnCreateModule) then
    Result := FOnCreateModule()
  else
    Result := nil;
end;

destructor TEMSEdgeListener.Destroy;
begin
  FProtocolProps.Free;
  inherited;
end;

function TEMSEdgeListener.GetProtocolProps: TJSONObject;
begin
  FProtocolProps.Free;
  FProtocolProps := TJSONObject.Create;
  // Refresh
  Self.AddProtocolProps(FProtocolProps);
  Result := FProtocolProps;
end;

{ TEMSEdgeListener.TModule }

constructor TEMSEdgeListener.TModule.Create(const AModuleName,
  AModuleVersion: string); 
begin
  FModuleName := AModuleName;
  FModuleVersion := AModuleVersion;
end;

{ TEMSEdgeListener.TModuleContext }

constructor TEMSEdgeListener.TModuleContext.Create(
  const AModule: TEMSEdgeListener.TModule);
begin
  FModule := AModule;
end;

function TEMSEdgeListener.TModuleContext.GetGroupsByUser(
  const AUserID: string): TArray<string>;
begin
  Result := FModule.GetGroupsByUser(AUserID);
end;

function TEMSEdgeListener.TModuleContext.GetModuleName: string;
begin
  Result := FModule.ModuleName;;
end;

function TEMSEdgeListener.TModuleContext.GetModuleVersion: string;
begin
  Result := FModule.ModuleVersion;
end;

function TEMSEdgeListener.TModuleContext.UserIDOfSession(
  const ASessionID: string; out AUserID: string): Boolean;
begin
  Result := FModule.UserIDOfSession(ASessionID, AUserID);
end;

function TEMSEdgeListener.TModuleContext.UserNameOfID(const AUserID: string;
  out AUserName: string): Boolean;
begin
  Result := FModule.UserNameOfID(AUserID, AUserName);
end;

initialization

  TResourceStringsTable.Add(cResponseOK, sResponseOK);
  TResourceStringsTable.Add(cGetVersionSummaryTitle, sGetVersionSummaryTitle);
  TResourceStringsTable.Add(cGetVersionSummaryDesc, sGetVersionSummaryDesc);

  RegisterServices;
  RegisterVersionResource;
  RegisterAPIDocResource;

finalization
  UnregisterServices;
end.
