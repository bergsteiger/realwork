{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.PushDevice;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,
  System.Json,
  REST.Client,
  REST.BindSource,
  Data.Bind.ObjectScope,
  Data.Bind.Components,
  REST.Backend.PushTypes,
  REST.Backend.BindSource,
  REST.Backend.Providers,
  REST.Backend.MetaTypes,
  //REST.Backend.ServiceComponents,
  //REST.Backend.Providers,
{$IFDEF LOGGING}                
  FMX.Types,
{$ENDIF}
  System.PushNotification;

type

  TSubPushEventsBindSource = class;

  TCustomPushEvents = class(TBackendBindSourceComponentAuth<IBackendPushDeviceService, TBackendPushDeviceApi>, IRESTResponseJSON, IRESTIPComponent)
  public type
    TDeviceTokenEvent = procedure(Sender: TObject) of object;
    TPushReceivedEvent = procedure(Sender: TObject; const AData: TPushData) of object;
    TDeviceTokenFailedEvent = procedure(Sender: TObject; const AErrorMessage: string) of object;
    TDeviceRegisteredEvent = procedure(Sender: TObject) of object;
  private type
    TNotify = TRESTComponentNotify;

    TNotifyList = TRESTComponentNotifyList<TNotify>;
    TProviderStates = (DeviceRegister, Updated, ConnectionError, RegistrationError);
    TProviderState = set of TProviderStates;
  private
    FNotifyList: TNotifyList;
    FBindSource: TSubPushEventsBindSource;
    FJSONNotifyList: TList<TNotifyEvent>;
    FJSONResult: TJSONArray;
    FProviderState: TProviderState;
    FOnPushReceived: TPushReceivedEvent;
    FOnDeviceRegistered: TDeviceRegisteredEvent;
    FOnDeviceTokenReceived: TDeviceTokenEvent;
    FOnDeviceTokenRequestFailed: TDeviceTokenFailedEvent;
    FActive: Boolean;
    FDeferActive: Boolean;
    FPushServiceConnection: TPushServiceConnection;
    FAutoRegisterDevice: Boolean;
    FAutoActivate: Boolean;
    FStartupNotification: TPushData;
    FDeviceProperties: TJSONObject;
    procedure PropertyValueChanged;
    procedure JSONValueChanged;
    procedure SetActive(const Value: Boolean);
    function IsDesigning: Boolean;
    procedure PushServiceOnChange(Sender: TObject; AChanges: TPushService.TChanges);
    procedure PushServiceOnReceiveNotification(Sender: TObject;
      const ANotification: System.PushNotification.TPushServiceNotification);
    procedure OnPushDeviceRegisterDevice(const AService: TPushService);
    procedure UpdateConnection;
    procedure ActivatePushServiceConnection;
    function GetDeviceRegistered: Boolean;
    procedure CheckAPI;
    function GetPushDeviceApi: TBackendPushDeviceApi;
    function GetStartupNotification: TPushData;
    function GetPushServiceConnection: TPushServiceConnection;
    function GetDeviceID: string;
    function GetDeviceToken: string;
    procedure SetDeviceProperties(const Value: TJSONObject);
    function GetInstallationValue: TBackendEntityValue;
  protected
    { IRESTResponseJSON }   // Support ResponseAdapter
    procedure AddJSONChangedEvent(const ANotify: TNotifyEvent);
    procedure RemoveJSONChangedEvent(const ANotify: TNotifyEvent);
    procedure GetJSONResponse(out AJSONValue: TJSONValue; out AHasOwner: Boolean);
    function HasJSONResponse: Boolean;
    function HasResponseContent: Boolean;

    function InternalCreateBackendServiceAPI: TBackendPushDeviceApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendPushDeviceApi; override;
    procedure ProviderChanged; override;
    procedure ProcessPushNotification(const ANotification: System.PushNotification.TPushServiceNotification); virtual;
    procedure DoOnDeviceRegistered; virtual;
    procedure DoPushReceived(const AData: TPushData); virtual;
    procedure DoOnDeviceTokenReceived; virtual;
    procedure DoOnDeviceTokenRequestFailed(const AErrorMessage: string); virtual;
    procedure Loaded; override;
    function CreateBindSource: TBaseObjectBindSource; override;
    function CreateAuthAccess: IAuthAccess; override;
//    function CreateAuthAccess: IAuthAccess; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BindSource: TSubPushEventsBindSource read FBindSource;
    procedure ClearResult;
    procedure RegisterDevice; overload;
    /// <summary>Register a device with properties such as {"channels":["a"]}</summary>
    procedure RegisterDevice(const AProperties: TJSONObject); overload;
    procedure UnregisterDevice;
    function CreatePushDeviceApi: TBackendPushDeviceApi;
                     
                    
    property Active: Boolean read FActive write SetActive;
    property JSONResult: TJSONArray read FJSONResult;
    property OnDeviceTokenReceived: TDeviceTokenEvent read FOnDeviceTokenReceived write FOnDeviceTokenReceived;
    property OnDeviceTokenRequestFailed: TDeviceTokenFailedEvent read FOnDeviceTokenRequestFailed
      write FOnDeviceTokenRequestFailed;
    property OnDeviceRegistered: TDeviceRegisteredEvent read FOnDeviceRegistered
      write FOnDeviceRegistered;
    property OnPushReceived: TPushReceivedEvent read FOnPushReceived
      write FOnPushReceived;
    // Register at provider
    property AutoRegisterDevice: Boolean read FAutoRegisterDevice write FAutoRegisterDevice default True;
    property AutoActivate: Boolean read FAutoActivate write FAutoActivate default True;
    property DeviceRegistered: Boolean read GetDeviceRegistered;
    property PushConnection: TPushServiceConnection read GetPushServiceConnection;
    property PushDeviceApi: TBackendPushDeviceApi read GetPushDeviceApi;
    property StartupNotification: TPushData read GetStartupNotification;
    property DeviceToken: string read GetDeviceToken;
    property DeviceID: string read GetDeviceID;
    /// <summary>Get the identify of the installation object after a device has been registered.  Use the TBackendEntityValue.TryGetObjectID to retrieve the object id of the installation object.
    /// </summary>
    property InstallationValue: TBackendEntityValue read GetInstallationValue;
    /// <summary>Specify properties to be written to the installation object when a device is registered.</summary>
    property DeviceProperties: TJSONObject read FDeviceProperties write SetDeviceProperties;
  end;


  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TPushEvents = class(TCustomPushEvents)
  published
    property Auth;
    property Provider;
//    property Auth;
    property BindSource;
    property AutoActivate;
    property AutoRegisterDevice;
    property OnDeviceTokenReceived;
    property OnDeviceTokenRequestFailed;
    property OnPushReceived;
    property OnDeviceRegistered;
  end;

  /// <summary>
  /// LiveBindings adapter for TCustomPushEvents. Create bindable members
  /// </summary>
  TPushEventsAdapter = class(TRESTComponentAdapter)
  public type
    TNotify = class(TRESTComponentNotify)
    private
      FAdapter: TPushEventsAdapter;
      constructor Create(const AAdapter: TPushEventsAdapter);
    public
      procedure PropertyValueChanged(Sender: TObject); override;
    end;
  private
    FComponent: TCustomPushEvents;
    FNotify: TNotify;
    procedure SetPushSender(const APushSender: TCustomPushEvents);
    procedure AddPropertyFields;
  protected
    procedure DoChangePosting; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetCanActivate: Boolean; override;
    procedure AddFields; override;
    function GetSource: TBaseLinkingBindSource; override;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
    procedure GetMemberNames(AList: TStrings); override;
    property PushSender: TCustomPushEvents read FComponent write SetPushSender;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomPushEvents. Creates adapter
  /// </summary>
  TCustomPushEventsBindSource = class(TRESTComponentBindSource)
  private
    FAdapter: TPushEventsAdapter;
    function GetComponent: TCustomPushEvents;
    procedure SetComponent(const AValue: TCustomPushEvents);
  protected
    function CreateAdapter: TRESTComponentAdapter; override;
  public
    property Component: TCustomPushEvents read GetComponent write SetComponent;
    property Adapter: TPushEventsAdapter read FAdapter;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomPushEvents.  Publishes subcomponent properties
  /// </summary>
  TSubPushEventsBindSource = class(TCustomPushEventsBindSource)
  published
    property AutoActivate;
    property AutoEdit;
    property AutoPost;
  end;

implementation

uses
  REST.JSON, REST.Backend.Consts, REST.Backend.Exception, REST.Backend.ServiceComponents, REST.Backend.ServiceTypes;

{ TCustomPushSender }

constructor TCustomPushEvents.Create(AOwner: TComponent);
begin
  /// it is important to create the notify-list before
  /// calling the inherited constructor
  FNotifyList := TNotifyList.Create;
  FJSONNotifyList := TList<TNotifyEvent>.Create;
  FAutoRegisterDevice := True;
  FAutoActivate := True;
  FProviderState := [];
  inherited;

end;

destructor TCustomPushEvents.Destroy;
begin
  FreeAndNil(FNotifyList);
  FreeAndNil(FJSONNotifyList);
  FreeAndNil(FStartupNotification);
  FDeviceProperties.Free;
  inherited;
end;

procedure TCustomPushEvents.DoOnDeviceTokenReceived;
begin
  if Assigned(FOnDeviceTokenReceived) then
    FOnDeviceTokenReceived(Self); //, Service.PushDeviceAPI.GetPushService);
end;

procedure TCustomPushEvents.CheckAPI;
begin
  if GetBackendService = nil then
    if Provider = nil then
      raise EBackendServiceError.Create(sPushEventsProviderRequired)
    else
      raise EBackendServiceError.CreateFmt(sPushEventsNotSupportByProvider, [Provider.ProviderID]);
  Assert(GetBackendService.PushDeviceAPI <> nil);
end;

procedure TCustomPushEvents.RegisterDevice;
begin
  RegisterDevice(FDeviceProperties);
end;

procedure TCustomPushEvents.RegisterDevice(const AProperties: TJSONObject);
begin

  UpdateConnection;

  if FPushServiceConnection = nil then
    raise EBackendServiceError.Create(sPushEventsPushServiceConnectionRequired);

  Exclude(FProviderState, TProviderStates.DeviceRegister);
  Exclude(FProviderState, TProviderStates.RegistrationError);
  try
    CheckApi;
    GetPushDeviceApi.RegisterDevice(AProperties, OnPushDeviceRegisterDevice);
  except
    Include(FProviderState, TProviderStates.RegistrationError);
    raise;
  end;
end;

procedure TCustomPushEvents.DoOnDeviceRegistered;
begin
  if Assigned(FOnDeviceRegistered) then
    FOnDeviceRegistered(Self); // , AService);

end;

procedure TCustomPushEvents.OnPushDeviceRegisterDevice(const AService: TPushService);
begin
  Include(FProviderState, TProviderStates.DeviceRegister);
  DoOnDeviceRegistered;
end;

procedure TCustomPushEvents.DoOnDeviceTokenRequestFailed(const AErrorMessage: string);
begin
  if Assigned(FOnDeviceTokenRequestFailed) then
    FOnDeviceTokenRequestFailed(Self, AErrorMessage)
  else
    raise EBackendServiceError.CreateFmt(sDeviceTokenRequestFailed, [AErrorMessage]);
end;

procedure TCustomPushEvents.DoPushReceived(const AData: TPushData);
begin
  if Assigned(FOnPushReceived) then
    FOnPushReceived(Self, AData);
end;

procedure TCustomPushEvents.ProcessPushNotification(const ANotification: System.PushNotification.TPushServiceNotification);
const
  sGCM = 'gcm';
  sAPS = 'aps';
  sExtras = 'extras';
  sMessage = 'message';
var
  LData: TPushData;
  LJSONObject: TJSONObject;
begin
{$IFDEF LOGGING}                 
    Log.d('ProcessPushNotification');    // Do not localize
{$ENDIF}
  LData := TPushData.Create;
  try
    LData.Load(ANotification.Json);
    DoPushReceived(LData);
    if FJSONResult = nil then
      FJSONResult := TJSONArray.Create;
    LJSONObject := TJSONObject.Create;
    try
      //LData.Save(LJSONObject);
      LData.GCM.Save(LJSONObject, sGCM);
      LData.APS.Save(LJSONObject, sAPS);
      LData.Extras.Save(LJSONObject, sExtras);
      LData.SaveMessage(LJSONObject, sMessage);
      FJSONResult.AddElement(LJSONObject);
    except
      LJSONObject.Free;
      raise;
    end;
  finally
    LData.Free;
  end;
  JSONValueChanged;
end;

procedure TCustomPushEvents.PropertyValueChanged;
begin
  if (FNotifyList <> nil) then
  begin
    FNotifyList.notify(
      procedure(ANotify: TNotify)
      begin
        ANotify.PropertyValueChanged(self);
      end);
  end;
end;

procedure TCustomPushEvents.ProviderChanged;
begin
  if AutoActivate and (Provider <> nil) then
    Active := True;
end;

procedure TCustomPushEvents.AddJSONChangedEvent(const ANotify: TNotifyEvent);
begin
  Assert(not FJSONNotifyList.Contains(ANotify));
  if not FJSONNotifyList.Contains(ANotify) then
    FJSONNotifyList.Add(ANotify);
end;

procedure TCustomPushEvents.JSONValueChanged;
var
  LNotifyEvent: TNotifyEvent;
begin
  PropertyValueChanged;
  for LNotifyEvent in  FJSONNotifyList do
    LNotifyEvent(Self);
end;

procedure TCustomPushEvents.Loaded;
begin
  try
    inherited;
    if FDeferActive then
    begin
      FDeferActive := False;
      SetActive(True)
    end
    else if AutoActivate and (Provider <> nil) then
      SetActive(True);
  except
    // Do not raise exception while loading
  end;
end;

procedure TCustomPushEvents.RemoveJSONChangedEvent(const ANotify: TNotifyEvent);
begin
  Assert(FJSONNotifyList.Contains(ANotify));
  FJSONNotifyList.Remove(ANotify);
end;

function TCustomPushEvents.GetDeviceID: string;
begin
  Result := '';
  UpdateConnection;
  if FPushServiceConnection <> nil then
    Result := FPushServiceConnection.Service.DeviceIDValue[TPushService.TDeviceIDNames.DeviceID];
end;

function TCustomPushEvents.GetDeviceRegistered: Boolean;
begin
  Result := TProviderStates.DeviceRegister in FProviderState;
end;

function TCustomPushEvents.GetDeviceToken: string;
begin
  Result := '';
  UpdateConnection;
  if FPushServiceConnection <> nil then
    Result := FPushServiceConnection.Service.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
end;

function TCustomPushEvents.GetInstallationValue: TBackendEntityValue;
begin
  if not GetPushDeviceApi.TryGetInstallationValue(Result) then
    Result := TBackendEntityValue.Create(nil); // Empty
end;

procedure TCustomPushEvents.GetJSONResponse(out AJSONValue: TJSONValue;
  out AHasOwner: Boolean);
begin
  if FJSONResult <> nil then
  begin
    AJSONValue := FJSONResult;
    AHasOwner := True;
  end
  else
  begin
    AJSONValue := nil;
    AHasOwner := False;
  end;
end;

function TCustomPushEvents.GetPushDeviceApi: TBackendPushDeviceApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomPushEvents.GetPushServiceConnection: TPushServiceConnection;
begin
  UpdateConnection;
  Result := FPushServiceConnection;
end;

function TCustomPushEvents.GetStartupNotification: TPushData;
var
  LNotifications: TArray<TPushServiceNotification>;
begin
  if FStartupNotification = nil then
  begin
    UpdateConnection;
    if FPushServiceConnection <> nil then
    begin
      LNotifications := FPushServiceConnection.Service.StartupNotifications;
      if Length(LNotifications) > 0 then
      begin
        FStartupNotification := TPushData.Create;
        FStartupNotification.Load(LNotifications[0].Json);
      end;
    end;
  end;
  Result := FStartupNotification;
end;

function TCustomPushEvents.HasJSONResponse: Boolean;
begin
  Result := FJSONResult <> nil;
end;

function TCustomPushEvents.HasResponseContent: Boolean;
begin
  Result := HasJSONResponse;
end;

procedure TCustomPushEvents.ClearResult;
begin
  if FJSONResult <> nil then
  begin
    FreeAndNil(FJSONResult);
    JSONValueChanged;
  end;
end;

function TCustomPushEvents.InternalCreateBackendServiceAPI: TBackendPushDeviceApi;
begin
  Result := TBackendPushDeviceApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomPushEvents.InternalCreateIndependentBackendServiceAPI: TBackendPushDeviceApi;
begin
  Result := TBackendPushDeviceApi.Create(GetBackendService.CreatePushDeviceApi); // Service.CreateStorageApi);
end;

function TCustomPushEvents.IsDesigning: Boolean;
begin
  Result := (csDesigning in ComponentState);
end;

procedure TCustomPushEvents.ActivatePushServiceConnection;
begin
  if not IsDesigning then
  begin
    if Active then
    begin
      if TProviderStates.ConnectionError in FProviderState then
        // Had an error last time, try again
        FProviderState := FProviderState - [TProviderStates.ConnectionError, TProviderStates.Updated];
      UpdateConnection;
      if FPushServiceConnection <> nil then
      begin
        case FPushServiceConnection.Service.Status of
           TPushService.TStatus.Stopped:
             FPushServiceConnection.Active := True;
           TPushService.TStatus.StartupError:
           begin
             FPushServiceConnection.Active := True;
             // Process error events
             PushServiceOnChange(Self,
               [TPushService.TChange.Status]);
           end;
           TPushService.TStatus.Started:
           begin
             FPushServiceConnection.Active := True;
             // Process events as if the service was not started
             PushServiceOnChange(Self,
               [TPushService.TChange.Status, TPushService.TChange.DeviceToken]);
           end;
        end;
      end;
    end
    else
    begin
      if FPushServiceConnection <> nil then
        FPushServiceConnection.Active := False;
      ClearResult;
    end;
  end;
end;

procedure TCustomPushEvents.UnregisterDevice;
begin
  if FPushServiceConnection = nil then
    raise EBackendServiceError.Create(sPushEventsPushServiceConnectionRequired);

  Exclude(FProviderState, TProviderStates.RegistrationError);
  try
    CheckApi;
    GetBackendService.PushDeviceAPI.UnregisterDevice;
  except
    Include(FProviderState, TProviderStates.RegistrationError);
    raise;
  end;

end;

procedure TCustomPushEvents.UpdateConnection;
var
  LService: TPushService;
begin
  if not (TProviderStates.Updated in FProviderState) then
  begin
    try
      FreeAndNil(FPushServiceConnection);
      FreeAndNil(FStartupNotification);
      CheckApi;
      LService := GetBackendService.PushDeviceAPI.GetPushService;
      FPushServiceConnection := LService.CreateConnection; // Raises exception
      FPushServiceConnection.OnReceiveNotification := PushServiceOnReceiveNotification;
      FPushServiceConnection.OnChange:= PushServiceOnChange;
      FProviderState := [TProviderStates.Updated];
    except
      FProviderState := [TProviderStates.ConnectionError, TProviderStates.Updated];
      raise;
    end;
  end;
end;


procedure TCustomPushEvents.PushServiceOnChange(Sender: TObject; AChanges: TPushService.TChanges);
begin
  if TPushService.TChange.Status in AChanges then
  begin
    case FPushServiceConnection.Service.Status of
      TPushService.TStatus.Stopped:;
      TPushService.TStatus.Starting:;
      TPushService.TStatus.Started:
      begin
        DoOnDeviceTokenReceived;
        if FAutoRegisterDevice then
          RegisterDevice;
      end;
      TPushService.TStatus.StartupError:
      begin
        DoOnDeviceTokenRequestFailed(
          FPushServiceConnection.Service.StartupError);
      end;
    else
      Assert(False);
    end;
  end;
end;

procedure TCustomPushEvents.PushServiceOnReceiveNotification(Sender: TObject;
  const ANotification: System.PushNotification.TPushServiceNotification);
begin
  ProcessPushNotification(ANotification);
end;

procedure TCustomPushEvents.SetActive(const Value: Boolean);
begin
  if FActive <> Value then
  begin
    if csLoading in ComponentState then
      FDeferActive := Value
    else
    begin
      FActive := Value;
      try
        ActivatePushServiceConnection;
      finally
        if FPushServiceConnection = nil then
          FActive := False;
      end;
    end;
    PropertyValueChanged;
  end;
end;

procedure TCustomPushEvents.SetDeviceProperties(const Value: TJSONObject);
begin
  FreeAndNil(FDeviceProperties);
  if Value <> nil then
    FDeviceProperties := Value.Clone as TJSONObject;
  if FDeviceProperties <> nil then
    case FPushServiceConnection.Service.Status of
      TPushService.TStatus.Started:
      begin
        if FAutoRegisterDevice then
          // Update properties
          RegisterDevice;
      end;
    end;
 end;

function TCustomPushEvents.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubPushEventsBindSource.Create(self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(true);
  FBindSource.Component := self;

  Result := FBindSource;
end;

function TCustomPushEvents.CreatePushDeviceApi: TBackendPushDeviceApi;
begin
  Result := InternalCreateIndependentBackendServiceAPI;
end;

function TCustomPushEvents.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetPushDeviceApi.AuthenticationApi;
    end);
end;


{ TCustomPushSenderBindSource }

function TCustomPushEventsBindSource.CreateAdapter: TRESTComponentAdapter;
begin
  FAdapter := TPushEventsAdapter.Create(self);
  result := FAdapter;
end;

function TCustomPushEventsBindSource.GetComponent: TCustomPushEvents;
begin
  result := FAdapter.PushSender;
end;

procedure TCustomPushEventsBindSource.SetComponent(const AValue: TCustomPushEvents);
begin
  FAdapter.PushSender := AValue;
end;

{ TPushSenderAdapter }

procedure TPushEventsAdapter.SetPushSender(const APushSender: TCustomPushEvents);
var
  LActive: Boolean;
begin
  if FComponent <> APushSender then
  begin
    if FComponent <> nil then
    begin
      if FComponent.FNotifyList <> nil then
        FComponent.FNotifyList.RemoveNotify(FNotify);
      FComponent.RemoveFreeNotification(self);
    end;
    LActive := Active;
    Active := False;
    FComponent := APushSender;
    if FComponent <> nil then
    begin
      if FComponent.FNotifyList <> nil then
        FComponent.FNotifyList.AddNotify(FNotify);
      FComponent.FreeNotification(self);
    end;
    if LActive and CanActivate then
      Active := true;
  end;
end;

procedure TPushEventsAdapter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if Operation = opRemove then
  begin
    if AComponent = FComponent then
      PushSender := nil
  end;
end;

constructor TPushEventsAdapter.Create(AComponent: TComponent);
begin
  inherited;
  FNotify := TNotify.Create(self);
end;

destructor TPushEventsAdapter.Destroy;
begin
  inherited;
  if (FComponent <> nil) then
  begin
    if FComponent.FNotifyList <> nil then
      FComponent.FNotifyList.RemoveNotify(FNotify);
  end;
  FNotify.Free;
end;

procedure TPushEventsAdapter.DoChangePosting;
begin
  inherited;

end;

procedure TPushEventsAdapter.AddFields;
begin
  AddPropertyFields;
end;

procedure TPushEventsAdapter.AddPropertyFields;
const
  sJSONResult = 'JSONResult';
  sActive = 'Active';
var
  LGetMemberObject: IGetMemberObject;
begin
  CheckInactive;
  ClearFields;
  if FComponent <> nil then
  begin
    LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);
    CreateReadOnlyField<string>(sJSONResult, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        if FComponent.JSONResult <> nil then
          result := TJSON.Format(FComponent.JSONResult)
        else
          Result := '';
      end);
    CreateReadWriteField<Boolean>(sActive, LGetMemberObject, TScopeMemberType.mtBoolean,
      function: Boolean
      begin
        Result := FComponent.Active;
      end,
      procedure(AValue: Boolean)
      begin
        FComponent.Active := AValue;
      end);
  end;
end;

function TPushEventsAdapter.GetCanActivate: Boolean;
begin
  result := (FComponent <> nil);
end;

procedure TPushEventsAdapter.GetMemberNames(AList: TStrings);
var
  LField: TBindSourceAdapterField;
begin
  for LField in Fields do
  begin
    if (LField is TReadWriteField<string>) then
      // Provide object so that LiveBindings designer can select in designer when member is clicked
      AList.AddObject(LField.MemberName, TReadWriteField<string>(LField).Persistent)
    else
      AList.Add(LField.MemberName);
  end;
end;

function TPushEventsAdapter.GetSource: TBaseLinkingBindSource;
begin
  result := FComponent;
end;

{ TPushSenderAdapter.TNotify }

constructor TPushEventsAdapter.TNotify.Create(
  const AAdapter: TPushEventsAdapter);
begin
  FAdapter := AAdapter
end;

procedure TPushEventsAdapter.TNotify.PropertyValueChanged(Sender: TObject);
begin
  if Assigned(FAdapter) then
    FAdapter.RefreshFields;
end;


end.
