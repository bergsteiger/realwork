{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit REST.Backend.EMSServices;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Client,
  REST.Backend.Providers,
  REST.Backend.PushTypes,
  REST.Backend.ServiceTypes,
  REST.Backend.MetaTypes,
  REST.Backend.EMSApi,
  REST.Backend.EMSProvider,
  REST.Backend.ServiceFactory;

type

  // Push service

  TEMSPushAPI = class(TEMSServiceAPIAuth, IBackendPushApi, IBackendPushApi2, IBackendPushApi3)
  protected
    { IBackendPushAPI }
    procedure PushBroadcast(const AData: TPushData); overload;
    { IBackendPushApi2 }
    procedure PushBroadcast(const AData: TJSONObject); overload;
    function PushDataAsJSON(const AData: TPushData): TJSONObject;
    { IBackendPushApi3 }
    procedure PushToTarget(const AData: TPushData; const ATarget: TJSONObject); overload;
    procedure PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject); overload;
  end;

  TEMSPushService = class(TEMSBackendService<TEMSPushAPI>, IBackendService, IBackendPushService)
  protected
    { IBackendPushService }
    function CreatePushApi: IBackendPushApi;
    function GetPushApi: IBackendPushApi;
  end;

  // Query service

  TEMSQueryAPI = class(TEMSServiceAPIAuth, IBackendQueryApi)
  protected
    { IBackendQueryAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure GetServiceNames(out ANames: TArray<string>);
    procedure Query(const AClass: TBackendMetaClass;
      const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure Query(const AClass: TBackendMetaClass;
      const AQuery: array of string; const AJSONArray: TJSONArray;
      out AObjects: TArray<TBackendEntityValue>); overload;
  end;

  TEMSQueryService = class(TEMSBackendService<TEMSQueryAPI>, IBackendService,
    IBackendQueryService)
  protected
    { IBackendQueryService }
    function CreateQueryApi: IBackendQueryApi;
    function GetQueryApi: IBackendQueryApi;
  end;
  
  // Login service

  TEMSLoginAPI = class(TEMSServiceAPIAuth, IBackendAuthApi)
  private
  protected
    { IBackendLoginAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure SignupUser(const AUserName, APassword: string;
      const AUserData: TJSONObject; out ACreatedObject: TBackendEntityValue);
    procedure LoginUser(const AUserName, APassword: string;
      AProc: TFindObjectProc); overload;
    procedure LoginUser(const AUserName, APassword: string;
      out AUser: TBackendEntityValue; const AJSON: TJSONArray); overload;
    function FindCurrentUser(const AObject: TBackendEntityValue;
      AProc: TFindObjectProc): Boolean; overload;
    function FindCurrentUser(const AObject: TBackendEntityValue;
      out AUser: TBackendEntityValue; const AJSON: TJSONArray)
      : Boolean; overload;
    procedure UpdateUser(const AObject: TBackendEntityValue;
      const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
  end;

  TEMSLoginService = class(TEMSBackendService<TEMSLoginAPI>, IBackendService,
    IBackendAuthService)
  protected
    { IBackendLoginService }
    function CreateAuthApi: IBackendAuthApi;
    function GetAuthApi: IBackendAuthApi;
  end;


  // Users service

  TEMSUsersAPI = class(TEMSLoginAPI, IBackendUsersApi)
  private
  protected
    { IBackendUsersAPI }
                                                                         
    function DeleteUser(const AObject: TBackendEntityValue): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue;
      AProc: TFindObjectProc): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue;
      out AUser: TBackendEntityValue; const AJSON: TJSONArray)
      : Boolean; overload;
    procedure UpdateUser(const AObject: TBackendEntityValue;
      const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
    function QueryUserName(const AUserName: string; AProc: TFindObjectProc)
      : Boolean; overload;
    function QueryUserName(const AUserName: string;
      out AUser: TBackendEntityValue; const AJSON: TJSONArray)
      : Boolean; overload;
    procedure QueryUsers(const AQuery: array of string;
      const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string;
      const AJSONArray: TJSONArray;
      out AMetaArray: TArray<TBackendEntityValue>); overload;
  end;

  TEMSUsersService = class(TEMSBackendService<TEMSUsersAPI>, IBackendService,
    IBackendUsersService)
  protected
    { IBackendUsersService }
    function CreateUsersApi: IBackendUsersApi;
    function GetUsersApi: IBackendUsersApi;
  end;

  // Groups service

  TEMSGroupsAPI = class(TEMSServiceAPIAuth, IBackendGroupsApi)
  private
  protected
    { IBackendGroupsAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure AddUsers(const AGroupName: string; const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue);
    function RemoveUsers(const AGroupName: string; const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue): Boolean;
    procedure CreateGroup(const AGroup: string; AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    function DeleteGroup(const AObject: TBackendEntityValue): Boolean; overload;
    function FindGroup(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean;
    procedure UpdateGroup(const AObject: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
  end;

  TEMSGroupsService = class(TEMSBackendService<TEMSGroupsAPI>, IBackendService,
    IBackendGroupsService)
  protected
    { IBackendUsersService }
    function CreateGroupsApi: IBackendGroupsApi;
    function GetGroupsApi: IBackendGroupsApi;
  end;

  TEMSCustomEndpointAPI = class(TEMSServiceAPIAuth, IBackendCustomEndpointApi)
  protected
    { IBackendCustomEndpointApi }
    procedure PrepareClient(const AClient: TCustomRESTClient);
    procedure PrepareRequest(const ARequest: TCustomRESTRequest);
    procedure CheckForResponseErrors(const AResponse: TCustomRESTResponse; AValidStatusCodes: array of Integer);
  end;

  TEMSCustomEndpointService = class(TEMSBackendService<TEMSCustomEndpointAPI>, IBackendService,
    IBackendCustomEndpointService)
  protected
    { IBackendCustomEndpointService }
    function GetCustomEndpointAPI: IBackendCustomEndpointApi;
    function CreateCustomEndpointApi: IBackendCustomEndpointApi;
  end;

  TEMSProviderServiceFactory<T: IBackendService> = class
    (TProviderServiceFactory<T>)
  var
    FMethod: TFunc<IBackendProvider, IBackendService>;
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID)
      : IBackendService; override;
  public
    constructor Create(const AMethod: TFunc<IBackendProvider, IBackendService>);
  end;

implementation

uses
  System.TypInfo, System.Generics.Collections,
  REST.Backend.Exception,
  REST.Backend.EMSMetaTypes,
  REST.Backend.Consts;

  { TEMSProviderServiceFactory<T> }

constructor TEMSProviderServiceFactory<T>.Create(const AMethod
  : TFunc<IBackendProvider, IBackendService>);
begin
  inherited Create(TCustomEMSProvider.ProviderID,
    'REST.Backend.EMSServices');
  FMethod := AMethod;
end;

function TEMSProviderServiceFactory<T>.CreateService(const AProvider
  : IBackendProvider; const IID: TGUID): IBackendService;
begin
  Result := FMethod(AProvider);
end;

{ TEMSPushAPI }

procedure TEMSPushAPI.PushBroadcast(
  const AData: TPushData);
begin
  PushToTarget(AData, nil);
end;

procedure TEMSPushAPI.PushBroadcast(
  const AData: TJSONObject);
begin
  PushToTarget(AData, nil);
end;

procedure TEMSPushAPI.PushToTarget(
  const AData: TPushData; const ATarget: TJSONObject);
var
  LJSON: TJSONObject;
begin
  LJSON := PushDataAsJSON(AData);
  try
    PushToTarget(LJSON, ATarget);
  finally
    LJSON.Free;
  end;
end;

procedure TEMSPushAPI.PushToTarget(
  const AData: TJSONObject; const ATarget: TJSONObject);
var
  LJSON: TJSONObject;
begin
  if AData is TJSONObject then
    LJSON := AData.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    EMSAPI.PushToTarget(LJSON, ATarget);
  finally
    LJSON.Free;
  end;
end;

function TEMSPushAPI.PushDataAsJSON(
  const AData: TPushData): TJSONObject;
const
  sGCM = 'gcm';
  sAPS = 'aps';
  sExtras = 'extras';
var
  LGCM: TJSONObject;
  LAPS: TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    LGCM := TJSONObject.Create;
    Result.AddPair(sGCM, LGCM);
    LAPS := TJSONObject.Create;
    Result.AddPair(sAps, LAPS);
    if AData <> nil then
    begin
      AData.Extras.Save(Result, sExtras);
      AData.GCM.Save(LGCM, '');
      AData.APS.Save(LAPS, '');
      if (AData.APS.Alert = '') and (AData.Message <> '') then
        AData.SaveMessage(LAPS, TPushData.TAPS.TNames.Alert);
      if (AData.GCM.Message = '') and (AData.GCM.Msg = '') and (AData.Message <> '') then
        AData.SaveMessage(LGCM, TPushData.TGCM.TNames.Message);
    end;
  except
    Result.Free;
    raise;
  end;
end;

{ TEMSPushService }

function TEMSPushService.CreatePushApi: IBackendPushApi;
begin
  Result := CreateBackendApi;
end;

function TEMSPushService.GetPushApi: IBackendPushApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TEMSQueryAPI }

procedure TEMSQueryAPI.GetServiceNames(out ANames: TArray<string>);
begin
                                       
  ANames := TArray<string>.Create(
    TBackendQueryServiceNames.Users, TBackendQueryServiceNames.Groups, TBackendQueryServiceNames.Installations,
    TBackendQueryServiceNames.Modules, TBackendQueryServiceNames.ModulesResources);
end;

function TEMSQueryAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TEMSQueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    EMSAPI.QueryUsers(AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Groups) then
    EMSAPI.QueryGroups(AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Installations) then
    EMSAPI.QueryInstallations(
      AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Modules) then
    EMSAPI.QueryModules(
      AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.ModulesResources) then
    if AClass.BackendClassName <> '' then
      EMSAPI.QueryModuleResources(AClass.BackendClassName,
        AQuery, AJSONArray)
    else
      EMSAPI.QueryModuleResources('', // All
        AQuery, AJSONArray)
  else
                                 
    raise EEMSClientAPIError.CreateFmt(sUnsupportedBackendQueryType,
      [AClass.BackendDataType]);
end;

procedure TEMSQueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AObjects: TArray<TBackendEntityValue>);
var
  // LObjectIDArray: TArray<TEMSClientAPI.TObjectID>;
  LUsersArray: TArray<TEMSClientAPI.TUser>;
  LGroupsArray: TArray<TEMSClientAPI.TGroup>;
  LInstallationsArray: TArray<TEMSClientAPI.TInstallation>;
  LModulesArray: TArray<TEMSClientAPI.TModule>;
  LModuleResourcesArray: TArray<TEMSClientAPI.TModuleResource>;
  // LObjectID: TEMSClientAPI.TObjectID;
  LList: TList<TBackendEntityValue>;
  LUser: TEMSClientAPI.TUser;
  LGroup: TEMSClientAPI.TGroup;
  LInstallation: TEMSClientAPI.TInstallation;
  LModule: TEMSClientAPI.TModule;
  LModuleResource: TEMSClientAPI.TModuleResource;
begin

  // if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Storage) then
  // KinveyAPI.QueryAppData(
  // AClass.BackendClassName, AQuery, AJSONArray, LObjectIDArray)
  // else
  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    EMSAPI.QueryUsers(AQuery, AJSONArray, LUsersArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Groups) then
    EMSAPI.QueryGroups(AQuery, AJSONArray, LGroupsArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Installations) then
    EMSAPI.QueryInstallations(
      AQuery, AJSONArray, LInstallationsArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Modules) then
    EMSAPI.QueryModules(
      AQuery, AJSONArray, LModulesArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.ModulesResources) then
    if AClass.BackendClassName <> '' then
      EMSAPI.QueryModuleResources(AClass.BackendClassName,
        AQuery, AJSONArray, LModuleResourcesArray)
    else
      EMSAPI.QueryModuleResources('', // All
        AQuery, AJSONArray, LModuleResourcesArray)
  else
    raise EEMSClientAPIError.CreateFmt(sUnsupportedBackendQueryType,
      [AClass.BackendDataType]);

  if Length(LUsersArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUsersArray do
        LList.Add(TEMSMetaFactory.CreateMetaFoundUser(LUser));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

  if Length(LGroupsArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LGroup in LGroupsArray do
        LList.Add(TEMSMetaFactory.CreateMetaFoundGroup(LGroup));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

  if Length(LInstallationsArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LInstallation in LInstallationsArray do
        LList.Add(TEMSMetaFactory.CreateMetaFoundInstallation(LInstallation));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

  if Length(LModulesArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LModule in LModulesArray do
        LList.Add(TEMSMetaFactory.CreateMetaFoundModule(LModule));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

  if Length(LModuleResourcesArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LModuleResource in LModuleResourcesArray do
        LList.Add(TEMSMetaFactory.CreateMetaFoundModuleResource(LModuleResource));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;
end;

{ TKinveyQueryService }

function TEMSQueryService.CreateQueryApi: IBackendQueryApi;
begin
  Result := CreateBackendApi;
end;

function TEMSQueryService.GetQueryApi: IBackendQueryApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TEMSUsersService }

function TEMSUsersService.CreateUsersApi: IBackendUsersApi;
begin
  Result := CreateBackendApi;
end;

function TEMSUsersService.GetUsersApi: IBackendUsersApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TEMSGroupsService }

function TEMSGroupsService.CreateGroupsApi: IBackendGroupsApi;
begin
  Result := CreateBackendApi;
end;

function TEMSGroupsService.GetGroupsApi: IBackendGroupsApi;
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

  // Users
  LFactory := TEMSProviderServiceFactory<IBackendUsersService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TEMSUsersService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Groups
  LFactory := TEMSProviderServiceFactory<IBackendGroupsService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TEMSGroupsService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Query
  LFactory := TEMSProviderServiceFactory<IBackendQueryService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TEMSQueryService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Endpoint
  LFactory := TEMSProviderServiceFactory<IBackendCustomEndpointService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TEMSCustomEndpointService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Login
  LFactory := TEMSProviderServiceFactory<IBackendAuthService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TEMSLoginService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

   // Push
   LFactory := TEMSProviderServiceFactory<IBackendPushService>.Create(
   function(AProvider: IBackendProvider): IBackendService
   begin
     Result := TEMSPushService.Create(AProvider);
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

{ TEMSUsersAPI }

function TEMSUsersAPI.DeleteUser(const AObject: TBackendEntityValue): Boolean;
begin
  if AObject.Data is TMetaUser then
    Result := EMSAPI.DeleteUser((AObject.Data as TMetaUser).User)
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TEMSUsersAPI.FindUser(const AObject: TBackendEntityValue;
AProc: TFindObjectProc): Boolean;
var
  LMetaUser: TMetaUser;
begin
  if AObject.Data is TMetaUser then
  begin
    LMetaUser := TMetaUser(AObject.Data);
    Result := EMSAPI.RetrieveUser(LMetaUser.User,
      procedure(const AUser: TEMSClientAPI.TUser; const AObj: TJSONObject)
      begin
        AProc(TEMSMetaFactory.CreateMetaFoundUser(AUser), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TEMSUsersAPI.FindUser(const AObject: TBackendEntityValue;
out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LMetaUser: TMetaUser;
  LUser: TEMSClientAPI.TUser;
begin
  if AObject.Data is TMetaUser then
  begin
    LMetaUser := TMetaUser(AObject.Data);
    Result := EMSAPI.RetrieveUser(LMetaUser.User, LUser, AJSON);
    AUser := TEMSMetaFactory.CreateMetaFoundUser(LUser);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TEMSUsersAPI.QueryUserName(const AUserName: string;
AProc: TFindObjectProc): Boolean;
begin
  Result := EMSAPI.QueryUserName(AUserName,
    procedure(const AUser: TEMSClientAPI.TUser; const AObj: TJSONObject)
    begin
      AProc(TEMSMetaFactory.CreateMetaFoundUser(AUser), AObj);
    end);
end;

function TEMSUsersAPI.QueryUserName(const AUserName: string;
out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LUser: TEMSClientAPI.TUser;
begin
  Result := EMSAPI.QueryUserName(AUserName, LUser, AJSON);
  AUser := TEMSMetaFactory.CreateMetaFoundUser(LUser);
end;

procedure TEMSUsersAPI.QueryUsers(const AQuery: array of string;
const AJSONArray: TJSONArray);
begin
  EMSAPI.QueryUsers(AQuery, AJSONArray);
end;

procedure TEMSUsersAPI.QueryUsers(const AQuery: array of string;
const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>);
var
  LUserArray: TArray<TEMSClientAPI.TUser>;
  LUser: TEMSClientAPI.TUser;
  LList: TList<TBackendEntityValue>;
begin
  EMSAPI.QueryUsers(AQuery, AJSONArray, LUserArray);
  if Length(LUserArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUserArray do
        LList.Add(TEMSMetaFactory.CreateMetaUserObject(LUser));
      AMetaArray := LList.ToArray;
    finally
      LList.Free;
    end;
  end;
end;

procedure TEMSUsersAPI.UpdateUser(const AObject: TBackendEntityValue;
const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TEMSClientAPI.TUpdatedAt;
  LMetaUser: TMetaUser;
begin
  if AObject.Data is TMetaUser then
  begin
    LMetaUser := TMetaUser(AObject.Data);
    EMSAPI.UpdateUser(LMetaUser.User, AUserData, LUpdated);
    AUpdatedObject := TEMSMetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TEMSCustomEndpointService }

function TEMSCustomEndpointService.CreateCustomEndpointApi: IBackendCustomEndpointApi;
begin
  Result := CreateBackendApi;
end;

function TEMSCustomEndpointService.GetCustomEndpointAPI: IBackendCustomEndpointApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TEMSCustomEndpointAPI }

procedure TEMSCustomEndpointAPI.CheckForResponseErrors(
  const AResponse: TCustomRESTResponse; AValidStatusCodes: array of Integer);
begin
  EMSAPI.CheckForResponseError(AResponse, AValidStatusCodes);
end;

procedure TEMSCustomEndpointAPI.PrepareClient(const AClient: TCustomRESTClient);
begin
  EMSAPI.ApplyConnectionInfo(AClient);
end;

procedure TEMSCustomEndpointAPI.PrepareRequest(const ARequest: TCustomRESTRequest);
begin
  ARequest.TransientParams.Clear;
  EMSAPI.AddAuthParameters(ARequest);
end;

{ TEMSCustomLoginService }

function TEMSLoginService.CreateAuthApi: IBackendAuthApi;
begin
  Result := CreateBackendApi;
end;

function TEMSLoginService.GetAuthApi: IBackendAuthApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TEMSLoginAPI }

function TEMSLoginAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

function TEMSLoginAPI.FindCurrentUser(const AObject: TBackendEntityValue;
AProc: TFindObjectProc): Boolean;
var
  LMetaLogin: TMetaLogin;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    EMSAPI.Login(LMetaLogin.Login);
    try
      Result := EMSAPI.RetrieveCurrentUser(
        procedure(const AUser: TEMSClientAPI.TUser; const AObj: TJSONObject)
        begin
          AProc(TEMSMetaFactory.CreateMetaFoundUser(AUser), AObj);
        end);
    finally
      EMSAPI.Logout;
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TEMSLoginAPI.FindCurrentUser(const AObject: TBackendEntityValue;
out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LMetaLogin: TMetaLogin;
  LUser: TEMSClientAPI.TUser;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    EMSAPI.Login(LMetaLogin.Login);
    try
      Result := EMSAPI.RetrieveCurrentUser(LUser, AJSON);
      AUser := TEMSMetaFactory.CreateMetaFoundUser(LUser)
    finally
      EMSAPI.Logout;                                           
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

procedure TEMSLoginAPI.LoginUser(const AUserName, APassword: string;
AProc: TFindObjectProc);
begin
  EMSAPI.LoginUser(AUserName, APassword,
    procedure(const ALogin: TEMSClientAPI.TLogin;
      const AUserObject: TJSONObject)
    begin
      if Assigned(Aproc) then
        AProc(TEMSMetaFactory.CreateMetaLoginUser(ALogin), AUserObject);
    end);
end;

procedure TEMSLoginAPI.LoginUser(const AUserName, APassword: string;
out AUser: TBackendEntityValue; const AJSON: TJSONArray);
var
  LLogin: TEMSClientAPI.TLogin;
begin
  EMSAPI.LoginUser(AUserName, APassword, LLogin, AJSON);
  AUser := TEMSMetaFactory.CreateMetaLoginUser(LLogin);
end;

procedure TEMSLoginAPI.SignupUser(const AUserName, APassword: string;
const AUserData: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LLogin: TEMSClientAPI.TLogin;
begin
  EMSAPI.SignupUser(AUserName, APassword, AUserData, LLogin);
  ACreatedObject := TEMSMetaFactory.CreateMetaSignupUser(LLogin);
end;

procedure TEMSLoginAPI.UpdateUser(const AObject: TBackendEntityValue;
const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TEMSClientAPI.TUpdatedAt;
  LMetaUser: TMetaUser;
begin
  if AObject.Data is TMetaUser then
  begin
    LMetaUser := TMetaUser(AObject.Data);
    EMSAPI.UpdateUser(LMetaUser.User, AUserData, LUpdated);
    AUpdatedObject := TEMSMetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TEMSGroupsAPI }

procedure TEMSGroupsAPI.AddUsers(const AGroupName: string;
  const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TEMSClientAPI.TUpdatedAt;
begin
  EMSAPI.AddUsersToGroup(AGroupName, AUsers, LUpdated);
  AUpdatedObject := TEMSMetaFactory.CreateMetaUpdatedGroup(LUpdated);
end;

function TEMSGroupsAPI.RemoveUsers(const AGroupName: string;
  const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue): Boolean;
var
  LUpdated: TEMSClientAPI.TUpdatedAt;
begin
  Result := EMSAPI.RemoveUsersFromGroup(AGroupName, AUsers, LUpdated);
  AUpdatedObject := TEMSMetaFactory.CreateMetaUpdatedGroup(LUpdated);
end;

procedure TEMSGroupsAPI.CreateGroup(const AGroup: string; AJSON: TJSONObject;
  out ACreatedObject: TBackendEntityValue);
var
  LGroup: TEMSClientAPI.TGroup;
begin
  EMSAPI.CreateGroup(AGroup, AJSON, LGroup);
  ACreatedObject := TEMSMetaFactory.CreateMetaGroupObject(LGroup);
end;

function TEMSGroupsAPI.DeleteGroup(const AObject: TBackendEntityValue): Boolean;
begin
  if AObject.Data is TMetaGroup then
    Result := EMSAPI.DeleteGroup((AObject.Data as TMetaGroup).Group)
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TEMSGroupsAPI.FindGroup(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaGroup: TMetaGroup;
begin
  if AObject.Data is TMetaGroup then
  begin
    LMetaGroup := TMetaGroup(AObject.Data);
    Result := EMSAPI.RetrieveGroup(LMetaGroup.Group,
      procedure(const AGroup: TEMSClientAPI.TGroup; const AObj: TJSONObject)
      begin
        AProc(TEMSMetaFactory.CreateMetaFoundGroup(AGroup), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;


procedure TEMSGroupsAPI.UpdateGroup(const AObject: TBackendEntityValue;
  const AJSONObject: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TEMSClientAPI.TUpdatedAt;
  LMetaGroup: TMetaGroup;
begin
  if AObject.Data is TMetaGroup then
  begin
    LMetaGroup := TMetaGroup(AObject.Data);
    EMSAPI.UpdateGroup(LMetaGroup.Group, AJSONObject, LUpdated);
    AUpdatedObject := TEMSMetaFactory.CreateMetaUpdatedGroup(LUpdated);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TEMSGroupsAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

initialization
  RegisterServices;
finalization
  UnregisterServices;

end.
