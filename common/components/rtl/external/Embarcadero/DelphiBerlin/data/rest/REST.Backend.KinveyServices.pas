{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$HPPEMIT LINKUNIT}
unit REST.Backend.KinveyServices;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Backend.Providers,
  REST.Backend.PushTypes,
  REST.Backend.ServiceTypes,
  REST.Backend.MetaTypes,
  REST.Backend.KinveyApi,
  REST.Backend.KinveyProvider;

type

  // Files service

  TKinveyFilesAPI = class(TKinveyServiceAPIAuth, IBackendFilesApi)
  protected
    { IBackendFilesAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure UploadFile(const AFileName: string; const AContentType: string; out AFile: TBackendEntityValue); overload;
    procedure UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string; out AFile: TBackendEntityValue); overload;
    function DeleteFile(const AFile: TBackendEntityValue): Boolean;
  end;

  TKinveyFilesService = class(TKinveyBackendService<TKinveyFilesAPI>, IBackendService, IBackendFilesService)
  protected
    { IBackendFilesService }
    function CreateFilesApi: IBackendFilesApi;
    function GetFilesApi: IBackendFilesApi;
  end;

  // Push service

  TKinveyPushAPI = class(TKinveyServiceAPIAuth, IBackendPushApi)
  private
    FPushEndpoint: string;
  protected
    { IBackendPushAPI }
    procedure PushBroadcast(const AData: TPushData);
  end;

  TKinveyPushService = class(TKinveyBackendService<TKinveyPushAPI>, IBackendService, IBackendPushService)
  private
    FPushEndpoint: string;
  protected
    function CreateBackendApi: TKinveyPushAPI; override;
    { IBackendPushService }
    function CreatePushApi: IBackendPushApi;
    function GetPushApi: IBackendPushApi;
  public
    constructor Create(const AProvider: IBackendProvider); override;
  end;

  // Query service

  TKinveyQueryAPI = class(TKinveyServiceAPIAuth, IBackendQueryApi)
  protected
    { IBackendQueryAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure GetServiceNames(out ANames: TArray<string>);
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
  end;

  TKinveyQueryService = class(TKinveyBackendService<TKinveyQueryAPI>, IBackendService, IBackendQueryService)
  protected
    { IBackendQueryService }
    function CreateQueryApi: IBackendQueryApi;
    function GetQueryApi: IBackendQueryApi;
  end;

  // Login service

  TKinveyLoginAPI = class(TKinveyServiceAPIAuth, IBackendAuthApi)
  protected
    { IBackendAuthApi }
    function GetMetaFactory: IBackendMetaFactory;
    procedure SignupUser(const AUserName, APassword: string; const AUserData: TJSONObject;
      out ACreatedObject: TBackendEntityValue);
    procedure LoginUser(const AUserName, APassword: string; AProc: TFindObjectProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray); overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure UpdateUser(const AObject: TBackendEntityValue; const AUserData: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
  end;

  TKinveyLoginService = class(TKinveyBackendService<TKinveyLoginAPI>, IBackendService, IBackendAuthService)
  protected
    { IBackendAuthService }
    function CreateAuthApi: IBackendAuthApi;
    function GetAuthApi: IBackendAuthApi;
  end;

  // Users service

  TKinveyUsersAPI = class(TKinveyLoginApi, IBackendUsersApi)
  private
  protected
    { IBackendUsersAPI }
                                                                         
    function DeleteUser(const AObject: TBackendEntityValue): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    function QueryUserName(const AUserName: string; AProc: TFindObjectProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>); overload;
  end;

  TKinveyUsersService = class(TKinveyBackendService<TKinveyUsersAPI>, IBackendService, IBackendUsersService)
  protected
    { IBackendUsersService }
    function CreateUsersApi: IBackendUsersApi;
    function GetUsersApi: IBackendUsersApi;
  end;

  // Storage service

  TKinveyStorageAPI = class(TKinveyServiceAPIAuth, IBackendStorageApi)
  protected
    { IBackendStorageAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure CreateObject(const AClass: TBackendMetaClass; const AACL, AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue);
    function DeleteObject(const AObject: TBackendEntityValue): Boolean;
    function FindObject(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean;
    procedure UpdateObject(const AObject: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray); overload;
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
  end;

  TKinveyStorageService = class(TKinveyBackendService<TKinveyStorageAPI>, IBackendService, IBackendStorageService)
  protected
    { IBackendStorageService }
    function CreateStorageApi: IBackendStorageApi;
    function GetStorageApi: IBackendStorageApi;
  end;

implementation

uses
  System.TypInfo, System.Generics.Collections,
  REST.Backend.ServiceFactory, REST.Backend.Exception,
  REST.Backend.KinveyMetaTypes,
  REST.Backend.Consts;

type
  TKinveyProviderServiceFactory<T: IBackendService> = class(TProviderServiceFactory<T>)
  var
    FMethod: TFunc<IBackendProvider, IBackendService>;
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID): IBackendService; override;
  public
    constructor Create(const AMethod: TFunc<IBackendProvider, IBackendService>);
  end;

{ TKinveyProviderServiceFactory<T> }

constructor TKinveyProviderServiceFactory<T>.Create(const AMethod: TFunc<IBackendProvider, IBackendService>);
begin
  inherited Create(TCustomKinveyProvider.ProviderID, 'REST.Backend.KinveyServices');
  FMethod := AMethod;
end;

function TKinveyProviderServiceFactory<T>.CreateService(
  const AProvider: IBackendProvider; const IID: TGUID): IBackendService;
begin
  Result := FMethod(AProvider);
end;

{ TKinveyFilesService }

function TKinveyFilesService.CreateFilesApi: IBackendFilesApi;
begin
  Result := CreateBackendApi;
end;

function TKinveyFilesService.GetFilesApi: IBackendFilesApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TKinveyPushAPI }

procedure TKinveyPushAPI.PushBroadcast(
  const AData: TPushData);
var
  LArray: TJSONArray;
  LIOSAPS: TJSONObject;
  LIOSExtras: TJSONObject;
  LAndroidPayload: TJSONObject;
begin
  if FPushEndPoint = '' then
    raise EKinveyAPIError.Create(sKinveyRequiresCustomEndpoint);
  if AData <> nil then
  begin
    LArray := TJSONArray.Create;
    try
      LIOSAPS := TJSONObject.Create;
      LArray.AddElement(LIOSAPS);
      AData.APS.Save(LIOSAPS, '');
      if (AData.APS.Alert = '') and (AData.Message <> '') then
        AData.SaveMessage(LIOSAPS, TPushData.TAPS.TNames.Alert);

      LIOSExtras := TJSONObject.Create;
      LArray.AddElement(LIOSExtras);
      AData.Extras.Save(LIOSExtras, '');

      LAndroidPayload := TJSONObject.Create;
      LArray.AddElement(LAndroidPayload);
      AData.Extras.Save(LAndroidPayload, '');
      AData.GCM.Save(LAndroidPayload, '');
      if (AData.GCM.Message = '') and (AData.GCM.Msg = '') and (AData.Message <> '') then
        AData.SaveMessage(LAndroidPayload, TPushData.TGCM.TNames.Message);

      KinveyAPI.BroadcastPayload(FPushEndPoint,
        LIOSAPS, LIOSExtras, LAndroidPayload);
    finally
      LArray.Free;
    end;
  end
  else
    KinveyAPI.InvokeCustomEndpoint(FPushEndPoint, nil, nil)
end;

{ TKinveyPushService }

constructor TKinveyPushService.Create(const AProvider: IBackendProvider);
begin
  inherited;
  if AProvider is TCustomKinveyProvider then
    FPushendPoint := TCustomKinveyProvider(AProvider).PushEndpoint
  else
    FPushendpoint := '';
end;

function TKinveyPushService.CreateBackendApi: TKinveyPushAPI;
begin
  Result := inherited;
  if ConnectionInfo <> nil then
    Result.FPushEndpoint := ConnectionInfo.PushEndpoint
  else
    Result.FPushEndpoint := ''
end;

function TKinveyPushService.CreatePushApi: IBackendPushApi;
begin
  Result := CreateBackendApi;
  if Result is TKinveyPushAPI then
    TKinveyPushAPI(Result).FPushEndpoint := FPushendpoint;
end;

function TKinveyPushService.GetPushApi: IBackendPushApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TKinveyQueryAPI }

procedure TKinveyQueryAPI.GetServiceNames(out ANames: TArray<string>);
begin
                                       
  ANames := TArray<string>.Create(
    TBackendQueryServiceNames.Storage,
    TBackendQueryServiceNames.Users);
    // Kinvey REST API does not support query of installations
    //TBackendQueryServiceNames.Installation);

end;

function TKinveyQueryAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TKinveyQueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Storage) then
    KinveyAPI.QueryAppData(
      AClass.BackendClassName, AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    KinveyAPI.QueryUsers(
      AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Files) then
    KinveyAPI.QueryFiles(
      AQuery, AJSONArray)
  else
    raise EKinveyAPIError.CreateFmt(sUnsupportedBackendQueryType, [AClass.BackendDataType]);
end;

procedure TKinveyQueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>);
var
  LObjectIDArray: TArray<TKinveyAPI.TObjectID>;
  LUsersArray: TArray<TKinveyAPI.TUser>;
  LObjectID: TKinveyAPI.TObjectID;
  LList: TList<TBackendEntityValue>;
  LUser: TKinveyAPI.TUser;
begin

  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Storage) then
    KinveyAPI.QueryAppData(
      AClass.BackendClassName, AQuery, AJSONArray, LObjectIDArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    KinveyAPI.QueryUsers(
      AQuery, AJSONArray, LUsersArray)
  else
    raise EKinveyAPIError.CreateFmt(sUnsupportedBackendQueryType, [AClass.BackendDataType]);

  if Length(LUsersArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUsersArray do
        LList.Add(TKinveyMetaFactory.CreateMetaFoundUser(LUser));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

  if Length(LObjectIDArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LObjectID in LObjectIDArray do
        LList.Add(TKinveyMetaFactory.CreateMetaClassObject(LObjectID));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;
end;

{ TKinveyQueryService }

function TKinveyQueryService.CreateQueryApi: IBackendQueryApi;
begin
  Result := CreateBackendApi;
end;

function TKinveyQueryService.GetQueryApi: IBackendQueryApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TKinveyUsersService }

function TKinveyUsersService.CreateUsersApi: IBackendUsersApi;
begin
  Result := CreateBackendApi;
end;

function TKinveyUsersService.GetUsersApi: IBackendUsersApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TKinveyLoginService }

function TKinveyLoginService.CreateAuthApi: IBackendAuthApi;
begin
  Result := CreateBackendApi;
end;

function TKinveyLoginService.GetAuthApi: IBackendAuthApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TKinveyStorageAPI }

procedure TKinveyStorageAPI.CreateObject(const AClass: TBackendMetaClass;
  const AACL, AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LNewObject: TKinveyAPI.TObjectID;
begin
  KinveyAPI.CreateAppData(AClass.BackendClassName, AACL, AJSON, LNewObject);
  ACreatedObject :=
    //TBackendEntityValue.Create(TMetaCreatedObject.Create(LNewObject));
    TKinveyMetaFactory.CreateMetaClassObject(LNewObject)
end;

                                              
function TKinveyStorageAPI.DeleteObject(
  const AObject: TBackendEntityValue): Boolean;
var
  LCount: Integer;
begin
  if AObject.Data is TMetaObject then
  begin
    LCount := KinveyAPI.DeleteAppData((AObject.Data as TMetaObject).ObjectID);
    if LCount > 1 then
      raise EBackendServiceError.CreateFmt(sUnexpectedDeleteObjectCount, [LCount])
    else
      Result := LCount > 0;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TKinveyStorageAPI.FindObject(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaObject: TMetaObject;
begin
  if AObject.Data is TMetaObject then
  begin
    LMetaObject := TMetaObject(AObject.Data);
    Result := KinveyAPI.FindAppData(LMetaObject.ObjectID,
      procedure(const AID: TKinveyAPI.TObjectID; const AObj: TJSONObject)
      begin
        AProc(TKinveyMetaFactory.CreateMetaFoundObject(AID), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TKinveyStorageAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TKinveyStorageAPI.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  KinveyAPI.QueryAppData(AClass.BackendClassName, AQuery, AJSONArray);
end;

procedure TKinveyStorageAPI.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AObjects: TArray<TBackendEntityValue>);
var
  LObjectIDArray: TArray<TKinveyAPI.TObjectID>;
  LObjectID: TKinveyAPI.TObjectID;
  LList: TList<TBackendEntityValue>;
begin
  KinveyAPI.QueryAppData(AClass.BackendClassName, AQuery, AJSONArray, LObjectIDArray);
  if Length(LObjectIDArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LObjectID in LObjectIDArray do
        LList.Add(TKinveyMetaFactory.CreateMetaClassObject(LObjectID));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;
end;

procedure TKinveyStorageAPI.UpdateObject(const AObject: TBackendEntityValue;
  const AJSONObject: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LObjectID: TKinveyAPI.TObjectID;
  LMetaObject: TMetaObject;
begin
  if AObject.Data is TMetaObject then
  begin
    LMetaObject := TMetaObject(AObject.Data);
    KinveyAPI.UpdateAppData(LMetaObject.ObjectID, AJSONObject, LObjectID);
    AUpdatedObject := TKinveyMetaFactory.CreateMetaUpdatedObject(LObjectID);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TKinveyStorageService }

function TKinveyStorageService.CreateStorageApi: IBackendStorageApi;
begin
  Result := CreateBackendApi;
end;

function TKinveyStorageService.GetStorageApi: IBackendStorageApi;
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
  // Files
  LFactory := TKinveyProviderServiceFactory<IBackendFilesService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TKinveyFilesService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Login
  LFactory := TKinveyProviderServiceFactory<IBackendAuthService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TKinveyLoginService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Users
  LFactory := TKinveyProviderServiceFactory<IBackendUsersService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TKinveyUsersService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Storage
  LFactory := TKinveyProviderServiceFactory<IBackendStorageService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TKinveyStorageService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Query
  LFactory := TKinveyProviderServiceFactory<IBackendQueryService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TKinveyQueryService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Push
  LFactory := TKinveyProviderServiceFactory<IBackendPushService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TKinveyPushService.Create(AProvider);
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

{ TKinveyLoginAPI }

function TKinveyLoginAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

function TKinveyLoginAPI.FindCurrentUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaLogin: TMetaLogin;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    KinveyAPI.Login(LMetaLogin.Login);
    try
      Result := KinveyAPI.RetrieveCurrentUser(
        procedure(const AUser: TKinveyAPI.TUser; const AObj: TJSONObject)
        begin
          AProc(TKinveyMetaFactory.CreateMetaFoundUser(AUser), AObj);
        end);
    finally
      KinveyAPI.Logout;
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TKinveyLoginAPI.FindCurrentUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LMetaLogin: TMetaLogin;
  LUser: TKinveyApi.TUser;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    KinveyAPI.Login(LMetaLogin.Login);
    try
      Result := KinveyAPI.RetrieveCurrentUser(LUser, AJSON);
      AUser := TKinveyMetaFactory.CreateMetaFoundUser(LUser)
    finally
      KinveyAPI.Logout;                                            
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

procedure TKinveyLoginAPI.LoginUser(const AUserName, APassword: string;
  AProc: TFindObjectProc);
begin
  KinveyAPI.LoginUser(AUserName, APassword,
   procedure(const ALogin: TKinveyAPI.TLogin; const AUserObject: TJSONObject)
   begin
      AProc(TKinveyMetaFactory.CreateMetaLoginUser(ALogin), AUserObject);
   end);
end;

procedure TKinveyLoginAPI.LoginUser(const AUserName, APassword: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray);
var
  LLogin: TKinveyAPI.TLogin;
begin
  KinveyAPI.LoginUser(AUserName, APassword, LLogin, AJSON);
  AUser := TKinveyMetaFactory.CreateMetaLoginUser(LLogin);
end;

procedure TKinveyLoginAPI.SignupUser(const AUserName, APassword: string;
  const AUserData: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LLogin: TKinveyAPI.TLogin;
begin
  KinveyAPI.SignupUser(AUserName, APassword, AUserData, LLogin);
  ACreatedObject := TKinveyMetaFactory.CreateMetaSignupUser(LLogin);
end;

procedure TKinveyLoginAPI.UpdateUser(const AObject: TBackendEntityValue; const AUserData: TJSONObject;
  out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TKinveyAPI.TUpdatedAt;
  LMetaUser: TMetaUser;
begin
  if AObject.Data is TMetaUser then
  begin
    LMetaUser := TMetaUser(AObject.Data);
    KinveyAPI.UpdateUser(LMetaUser.User, AUserData, LUpdated);
    AUpdatedObject := TKinveyMetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TKinveyUsersAPI }

function TKinveyUsersAPI.DeleteUser(const AObject: TBackendEntityValue): Boolean;
begin
  if AObject.Data is TMetaUser then
    Result := KinveyAPI.DeleteUser((AObject.Data as TMetaUser).User)
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TKinveyUsersAPI.FindUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaUser: TMetaUser;
begin
  if AObject.Data is TMetaUser then
  begin
    LMetaUser := TMetaUser(AObject.Data);
    Result := KinveyAPI.RetrieveUser(LMetaUser.User,
      procedure(const AUser: TKinveyAPI.TUser; const AObj: TJSONObject)
      begin
        AProc(TKinveyMetaFactory.CreateMetaFoundUser(AUser), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;


function TKinveyUsersAPI.FindUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LMetaUser: TMetaUser;
  LUser: TKinveyApi.TUser;
begin
  if AObject.Data is TMetaUser then
  begin
    LMetaUser := TMetaUser(AObject.Data);
    Result := KinveyAPI.RetrieveUser(LMetaUser.User, LUser, AJSON);
    AUser := TKinveyMetaFactory.CreateMetaFoundUser(LUser);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TKinveyUsersAPI.QueryUserName(const AUserName: string;
  AProc: TFindObjectProc): Boolean;
begin
  Result := KinveyAPI.QueryUserName(AUserName,
    procedure(const AUser: TKinveyAPI.TUser; const AObj: TJSONObject)
    begin
      AProc(TKinveyMetaFactory.CreateMetaFoundUser(AUser), AObj);
    end);
end;

function TKinveyUsersAPI.QueryUserName(const AUserName: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LUser: TKinveyAPI.TUser;
begin
  Result := KinveyAPI.QueryUserName(AUserName, LUser, AJSON);
  AUser := TKinveyMetaFactory.CreateMetaFoundUser(LUser);
end;

procedure TKinveyUsersAPI.QueryUsers(const AQuery: array of string;
  const AJSONArray: TJSONArray);
begin
  KinveyAPI.QueryUsers(AQuery, AJSONArray);
end;

procedure TKinveyUsersAPI.QueryUsers(
  const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>);
var
  LUserArray: TArray<TKinveyAPI.TUser>;
  LUser: TKinveyAPI.TUser;
  LList: TList<TBackendEntityValue>;
begin
  KinveyAPI.QueryUsers(AQuery, AJSONArray, LUserArray);
  if Length(LUserArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUserArray do
        LList.Add(TKinveyMetaFactory.CreateMetaUserObject(LUser));
      AMetaArray := LList.ToArray;
    finally
      LList.Free;
    end;
  end;
end;

{ TKinveyFilesAPI }

procedure TKinveyFilesAPI.UploadFile(const AFileName, AContentType: string;
  out AFile: TBackendEntityValue);
var
  LFile: TKinveyAPI.TFile;
  LFound: Boolean;
begin
  // Upload public file, no custom fields
  KinveyAPI.UploadFile(AFileName, AContentType, True, nil, LFile);
  LFound := KinveyAPI.RetrieveFile(LFile.ID,
    procedure(const AFile: TKinveyAPI.TFile; const AJSON: TJSONObject)
    begin
      LFile := AFile;
    end);
  Assert(LFound);
  AFile :=  TKinveyMetaFactory.CreateMetaUploadedFile(LFile);
end;

function TKinveyFilesAPI.DeleteFile(const AFile: TBackendEntityValue): Boolean;
begin
  Result := KinveyAPI.DeleteFile(AFile.FileID);
end;

function TKinveyFilesAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TKinveyFilesAPI.UploadFile(const AFileName: string;
  const AStream: TStream; const AContentType: string;
  out AFile: TBackendEntityValue);
var
  LFile: TKinveyAPI.TFile;
  LFound: Boolean;
begin
  // Upload public file, no custom fields
  KinveyAPI.UploadFile(AFileName, AStream, AContentType, True, nil, LFile);
  LFound := KinveyAPI.RetrieveFile(LFile.ID,
    procedure(const AFile: TKinveyAPI.TFile; const AJSON: TJSONObject)
    begin
      LFile := AFile;
    end);
  Assert(LFound);
  AFile :=  TKinveyMetaFactory.CreateMetaUploadedFile(LFile);
end;

initialization
  RegisterServices;
finalization
  UnregisterServices;

end.
