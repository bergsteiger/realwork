{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
{$HPPEMIT LINKUNIT}
unit REST.Backend.ParseServices;

interface

uses
  System.Classes,
  System.SysUtils,
  System.JSON,
  REST.Json.Types,
  REST.Backend.Providers,
  REST.Backend.PushTypes,
  REST.Backend.ServiceTypes,
  REST.Backend.MetaTypes,
  REST.Backend.ParseProvider,
  REST.Backend.ParseApi;

type
  // Files service

  TParseFilesAPI = class(TParseServiceAPIAuth, IBackendFilesApi)
  protected
    { IBackendFilesAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure UploadFile(const AFileName: string; const AContentType: string;
      out AFile: TBackendEntityValue); overload;
    procedure UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string;
      out AFile: TBackendEntityValue); overload;
    function DeleteFile(const AFile: TBackendEntityValue): Boolean;
  end;

  TParseFilesService = class(TParseBackendService<TParseFilesAPI>, IBackendService, IBackendFilesService)
  protected
    { IBackendFilesService }
    function CreateFilesApi: IBackendFilesApi;
    function GetFilesApi: IBackendFilesApi;
  end;

  // Push service

  TParsePushAPI = class(TParseServiceAPIAuth, IBackendPushApi, IBackendPushApi2, IBackendPushApi3)
  protected
    { IBackendPushAPI }
    procedure PushBroadcast(const AData: TPushData); overload;
    { IBackendPushApi2 }
    procedure PushBroadcast(const AData: TJSONObject); overload;
    /// <summary>Create a json object that represents push data.  The JSON format is provider-specific</summary>
    function PushDataAsJSON(const AData: TPushData): TJSONObject;
    { IBackendPushApi3 }
    /// <summary>Send a push notification to a target.  The format of the target JSON is provider-specific</summary>
    procedure PushToTarget(const AData: TPushData; const ATarget: TJSONObject); overload;
    procedure PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject); overload;
  end;

  TParsePushService = class(TParseBackendService<TParsePushAPI>, IBackendService, IBackendPushService)
  protected
    { IBackendPushService }
    function CreatePushApi: IBackendPushApi;
    function GetPushApi: IBackendPushApi;
  end;

  // Query service

  TParseQueryAPI = class(TParseServiceAPIAuth, IBackendQueryApi)
  protected
    { IBackendQueryAPI }
    procedure GetServiceNames(out ANames: TArray<string>);
    function GetMetaFactory: IBackendMetaFactory;
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
  end;

  TParseQueryService = class(TParseBackendService<TParseQueryAPI>, IBackendService, IBackendQueryService)
  protected
    { IBackendQueryService }
    function CreateQueryApi: IBackendQueryApi;
    function GetQueryApi: IBackendQueryApi;
  end;

  // Users service

  TParseLoginAPI = class(TParseServiceAPIAuth, IBackendAuthApi)
  protected
    { IBackendLoginAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure SignupUser(const AUserName, APassword: string; const AUserData: TJSONObject;
      out ACreatedObject: TBackendEntityValue);
    procedure LoginUser(const AUserName, APassword: string; AProc: TFindObjectProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray); overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure UpdateUser(const AObject: TBackendEntityValue; const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
  end;

  TParseLoginService = class(TParseBackendService<TParseLoginAPI>, IBackendService, IBackendAuthService)
  protected
    { IBackendAuthService }
    function CreateAuthApi: IBackendAuthApi;
    function GetAuthApi: IBackendAuthApi;
  end;


  // Users service

  TParseUsersAPI = class(TParseLoginApi, IBackendUsersApi)
  protected
                                                                         
    function DeleteUser(const AObject: TBackendEntityValue): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure UpdateUser(const AObject: TBackendEntityValue; const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
    function QueryUserName(const AUserName: string; AProc: TFindObjectProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>); overload;
  end;

  TParseUsersService = class(TParseBackendService<TParseUsersAPI>, IBackendService, IBackendUsersService)
  protected
    { IBackendUsersService }
    function CreateUsersApi: IBackendUsersApi;
    function GetUsersApi: IBackendUsersApi;
  end;

  // Storage service

  TParseStorageAPI = class(TParseServiceAPIAuth, IBackendStorageAPI, IBackendStorageAPI2)
  protected
    { IBackendStorageAPI }
    function GetMetaFactory: IBackendMetaFactory;
    procedure CreateObject(const AClass: TBackendMetaClass; const AACL, AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    function DeleteObject(const AObject: TBackendEntityValue): Boolean;
    function FindObject(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean;
    procedure UpdateObject(const AObject: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
     /// <summary>Returns Json date format for Parse</summary>
    function GetJsonDateFormat : TJsonDateFormat;
  end;

  TParseStorageService = class(TParseBackendService<TParseStorageAPI>, IBackendService, IBackendStorageService)
  protected
    { IBackendStorageService }
    function CreateStorageApi: IBackendStorageApi;
    function GetStorageApi: IBackendStorageApi;
  end;

implementation

uses
  System.TypInfo, System.Generics.Collections, REST.Backend.ServiceFactory,
  REST.Backend.ParseMetaTypes, REST.Backend.Consts, REST.Backend.Exception;

type
  TParseProviderServiceFactory<T: IBackendService> = class(TProviderServiceFactory<T>)
  var
    FMethod: TFunc<IBackendProvider, IBackendService>;
  protected
    function CreateService(const AProvider: IBackendProvider; const IID: TGUID): IBackendService; override;
  public
    constructor Create(const AMethod: TFunc<IBackendProvider, IBackendService>);
  end;

{ TParseProviderServiceFactory<T> }

constructor TParseProviderServiceFactory<T>.Create(const AMethod: TFunc<IBackendProvider, IBackendService>);
begin
  inherited Create(TCustomParseProvider.ProviderID, 'REST.Backend.ParseServices');
  FMethod := AMethod;
end;

function TParseProviderServiceFactory<T>.CreateService(
  const AProvider: IBackendProvider; const IID: TGUID): IBackendService;
begin
  Result := FMethod(AProvider);
end;

{ TParseFilesService }

function TParseFilesService.CreateFilesApi: IBackendFilesApi;
begin
  Result := CreateBackendApi;
end;

function TParseFilesService.GetFilesApi: IBackendFilesApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TParsePushAPI }

procedure TParsePushAPI.PushBroadcast(
  const AData: TPushData);
begin
  PushToTarget(AData, nil);
end;

procedure TParsePushAPI.PushBroadcast(
  const AData: TJSONObject);
begin
  PushToTarget(AData, nil);
end;

function TParsePushAPI.PushDataAsJSON(
  const AData: TPushData): TJSONObject;
var
  LJSONData: TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    LJSONData := TJSONObject.Create;
    Result.AddPair('data', LJSONData);
    if AData <> nil then
    begin
      // Flat object
      AData.Extras.Save(LJSONData, '');
      AData.GCM.Save(LJSONData, '');
      AData.APS.Save(LJSONData, '');
      if (AData.APS.Alert = '') and (AData.Message <> '') then
        AData.SaveMessage(LJSONData, TPushData.TAPS.TNames.Alert);
      if (AData.GCM.Message = '') and (AData.GCM.Msg = '') and (AData.Message <> '') then
        AData.SaveMessage(LJSONData, TPushData.TGCM.TNames.Message);
    end;
  except
    Result.Free;
    raise;
  end;
end;

procedure TParsePushAPI.PushToTarget(
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

procedure TParsePushAPI.PushToTarget(
  const AData: TJSONObject; const ATarget: TJSONObject);
var
  LJSON: TJSONObject;
  LPair: TJSONPair;
begin
  if AData <> nil then
    LJSON := AData.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    if ATarget <> nil then
      for LPair in ATarget do
        LJSON.AddPair(LPair.Clone as TJSONPair);
    ParseAPI.PushBody(LJSON)
  finally
    LJSON.Free;
  end;
end;

{ TParsePushService }

function TParsePushService.CreatePushApi: IBackendPushApi;
begin
  Result := CreateBackendApi;
end;

function TParsePushService.GetPushApi: IBackendPushApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TParseQueryAPI }

procedure TParseQueryAPI.GetServiceNames(out ANames: TArray<string>);
begin
  ANames := TArray<string>.Create(
    TBackendQueryServiceNames.Storage,
    TBackendQueryServiceNames.Users,
    TBackendQueryServiceNames.Installations);
end;

function TParseQueryAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TParseQueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Storage) then
    ParseAPI.QueryClass(
      AClass.BackendClassName, AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    ParseAPI.QueryUsers(
      AQuery, AJSONArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Installations) then
    ParseAPI.QueryInstallation(
      AQuery, AJSONArray)
  else
    raise EBackendServiceError.CreateFmt(sUnsupportedBackendQueryType, [AClass.BackendDataType]);
end;

procedure TParseQueryAPI.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>);
var
  LObjectIDArray: TArray<TParseAPI.TObjectID>;
  LUsersArray: TArray<TParseAPI.TUser>;
  LObjectID: TParseAPI.TObjectID;
  LList: TList<TBackendEntityValue>;
  LUser: TParseAPI.TUser;
begin

  if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Storage) then
    ParseAPI.QueryClass(
      AClass.BackendClassName, AQuery, AJSONArray, LObjectIDArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Users) then
    ParseAPI.QueryUsers(
      AQuery, AJSONArray, LUsersArray)
  else if SameText(AClass.BackendDataType, TBackendQueryServiceNames.Installations) then
    ParseAPI.QueryInstallation(
      AQuery, AJSONArray, LObjectIDArray)
  else
    raise EBackendServiceError.CreateFmt(sUnsupportedBackendQueryType, [AClass.BackendDataType]);

  if Length(LUsersArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUsersArray do
        LList.Add(TParseMetaFactory.CreateMetaFoundUser(LUser));
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
        LList.Add(TParseMetaFactory.CreateMetaClassObject(LObjectID));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

end;

{ TParseQueryService }

function TParseQueryService.CreateQueryApi: IBackendQueryApi;
begin
  Result := CreateBackendApi;
end;

function TParseQueryService.GetQueryApi: IBackendQueryApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TParseUsersService }

function TParseUsersService.CreateUsersApi: IBackendUsersApi;
begin
  Result := CreateBackendApi;
end;

function TParseUsersService.GetUsersApi: IBackendUsersApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TParseLoginService }

function TParseLoginService.CreateAuthApi: IBackendAuthApi;
begin
  Result := CreateBackendApi;
end;

function TParseLoginService.GetAuthApi: IBackendAuthApi;
begin
  EnsureBackendApi;
  Result := BackendAPI;
end;

{ TParseStorageAPI }

                                              
procedure TParseStorageAPI.CreateObject(const AClass: TBackendMetaClass;
  const AACL, AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LNewObject: TParseAPI.TObjectID;
begin
  ParseAPI.CreateClass(AClass.BackendClassName, AACL, AJSON, LNewObject);
  ACreatedObject := TParseMetaFactory.CreateMetaCreatedObject(LNewObject)
end;

function TParseStorageAPI.DeleteObject(
  const AObject: TBackendEntityValue): Boolean;
begin
  if AObject.Data is TMetaObject then
    Result := ParseAPI.DeleteClass((AObject.Data as TMetaObject).ObjectID)
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TParseStorageAPI.FindObject(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaObject: TMetaObject;
begin
  if AObject.Data is TMetaObject then
  begin
    LMetaObject := TMetaObject(AObject.Data);
    Result := ParseAPI.FindClass(LMetaObject.ObjectID,
      procedure(const AID: TParseAPI.TObjectID; const AObj: TJSONObject)
      begin
        AProc(TParseMetaFactory.CreateMetaFoundObject(AID), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TParseStorageAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TParseStorageAPI.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  ParseAPI.QueryClass(AClass.BackendClassName, AQuery, AJSONArray);
end;

procedure TParseStorageAPI.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AObjects: TArray<TBackendEntityValue>);
var
  LObjectIDArray: TArray<TParseAPI.TObjectID>;
  LObjectID: TParseAPI.TObjectID;
  LList: TList<TBackendEntityValue>;
begin
  ParseAPI.QueryClass(AClass.BackendClassName, AQuery, AJSONArray, LObjectIDArray);
  if Length(LObjectIDArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LObjectID in LObjectIDArray do
        LList.Add(TParseMetaFactory.CreateMetaClassObject(LObjectID));
      AObjects := LList.ToArray;
    finally
      LList.Free;
    end;
  end;
end;

procedure TParseStorageAPI.UpdateObject(const AObject: TBackendEntityValue;
  const AJSONObject: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LObjectID: TParseAPI.TUpdatedAt;
  LMetaObject: TMetaObject;
begin
  if AObject.Data is TMetaObject then
  begin
    LMetaObject := TMetaObject(AObject.Data);
    ParseAPI.UpdateClass(LMetaObject.ObjectID, AJSONObject, LObjectID);
    AUpdatedObject := TParseMetaFactory.CreateMetaUpdatedObject(LObjectID);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TParseStorageAPI.GetJsonDateFormat : TJsonDateFormat;
begin
  Result := jdfParse;
end;

{ TParseStorageService }

function TParseStorageService.CreateStorageApi: IBackendStorageApi;
begin
  Result := CreateBackendApi;
end;

function TParseStorageService.GetStorageApi: IBackendStorageApi;
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
  LFactory := TParseProviderServiceFactory<IBackendFilesService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TParseFilesService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Users
  LFactory := TParseProviderServiceFactory<IBackendUsersService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TParseUsersService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Login
  LFactory := TParseProviderServiceFactory<IBackendAuthService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TParseLoginService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Storage
  LFactory := TParseProviderServiceFactory<IBackendStorageService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TParseStorageService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Query
  LFactory := TParseProviderServiceFactory<IBackendQueryService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TParseQueryService.Create(AProvider);
    end);
  FFactories.Add(LFactory);

  // Push
  LFactory := TParseProviderServiceFactory<IBackendPushService>.Create(
    function(AProvider: IBackendProvider): IBackendService
    begin
      Result := TParsePushService.Create(AProvider);
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

{ TParseLoginAPI }

function TParseLoginAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

function TParseLoginAPI.FindCurrentUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
var
  LMetaLogin: TMetaLogin;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    ParseAPI.Login(LMetaLogin.Login);
    try
      Result := ParseAPI.RetrieveCurrentUser(
        procedure(const AUser: TParseAPI.TUser; const AObj: TJSONObject)
        begin
          AProc(TParseMetaFactory.CreateMetaFoundUser(AUser), AObj);
        end);
    finally
      ParseAPI.Logout;
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TParseLoginAPI.FindCurrentUser(const AObject: TBackendEntityValue;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LMetaLogin: TMetaLogin;
  LUser: TParseAPI.TUser;
begin
  if AObject.Data is TMetaLogin then
  begin
    LMetaLogin := TMetaLogin(AObject.Data);
    ParseAPI.Login(LMetaLogin.Login);
    try
      Result := ParseAPI.RetrieveCurrentUser(LUser, AJSON);
      AUser := TParseMetaFactory.CreateMetaFoundUser(LUser);
    finally
      ParseAPI.Logout;
    end;
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

procedure TParseLoginAPI.LoginUser(const AUserName, APassword: string;
  AProc: TFindObjectProc);
begin
  ParseAPI.LoginUser(AUserName, APassword,
   procedure(const ALogin: TParseAPI.TLogin; const AUserObject: TJSONObject)
   begin
      AProc(TParseMetaFactory.CreateMetaLoginUser(ALogin), AUserObject);
   end);
end;

procedure TParseLoginAPI.LoginUser(const AUserName, APassword: string;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray);
var
  LLogin: TParseAPI.TLogin;
begin
  ParseAPI.LoginUser(AUserName, APassword, LLogin, AJSON);
  AUser := TParseMetaFactory.CreateMetaLoginUser(LLogin);
end;


procedure TParseLoginAPI.SignupUser(const AUserName, APassword: string;
  const AUserData: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LLogin: TParseAPI.TLogin;
begin
  ParseAPI.SignupUser(AUserName, APassword, AUserData, LLogin);
  ACreatedObject := TParseMetaFactory.CreateMetaSignupUser(LLogin);
end;

procedure TParseLoginAPI.UpdateUser(const AObject: TBackendEntityValue;
  const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TParseAPI.TUpdatedAt;
begin
  if AObject.Data is TMetaLogin then
  begin
    ParseAPI.UpdateUser(TMetaLogin(AObject.Data).Login, AUserData, LUpdated);
    AUpdatedObject := TParseMetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else if AObject.Data is TMetaUser then
  begin
    ParseAPI.UpdateUser(TMetaUser(AObject.Data).User.ObjectID, AUserData, LUpdated);
    AUpdatedObject := TParseMetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TParseUsersAPI }

function TParseUsersAPI.DeleteUser(const AObject: TBackendEntityValue): Boolean;
begin
  if AObject.Data is TMetaLogin then
    Result := ParseAPI.DeleteUser((AObject.Data as TMetaLogin).Login)
  else if AObject.Data is TMetaUser then
    Result := ParseAPI.DeleteUser((AObject.Data as TMetaUser).User.ObjectID)
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TParseUsersAPI.FindUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
begin
  if AObject.Data is TMetaLogin then
  begin
    Result := ParseAPI.RetrieveUser(TMetaLogin(AObject.Data).Login,
      procedure(const AUser: TParseAPI.TUser; const AObj: TJSONObject)
      begin
        AProc(TParseMetaFactory.CreateMetaFoundUser(AUser), AObj);
      end);
  end
  else if AObject.Data is TMetaUser then
  begin
    Result := ParseAPI.RetrieveUser(TMetaUser(AObject.Data).User.ObjectID,
      procedure(const AUser: TParseAPI.TUser; const AObj: TJSONObject)
      begin
        AProc(TParseMetaFactory.CreateMetaFoundUser(AUser), AObj);
      end);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TParseUsersAPI.FindUser(const AObject: TBackendEntityValue;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LUser: TParseAPI.TUser;
begin
  if AObject.Data is TMetaLogin then
    Result := ParseAPI.RetrieveUser(TMetaLogin(AObject.Data).Login, LUser, AJSON)
  else if AObject.Data is TMetaUser then
    Result := ParseAPI.RetrieveUser(TMetaUser(AObject.Data).User.ObjectID, LUser, AJSON)
  else
    raise EArgumentException.Create(sParameterNotMetaType);

  AUser := TParseMetaFactory.CreateMetaFoundUser(LUser);
end;


function TParseUsersAPI.QueryUserName(const AUserName: string;
  AProc: TFindObjectProc): Boolean;
begin
  Result := ParseAPI.QueryUserName(AUserName,
    procedure(const AUser: TParseAPI.TUser; const AObj: TJSONObject)
    begin
      AProc(TParseMetaFactory.CreateMetaFoundUser(AUser), AObj);
    end);
end;

function TParseUsersAPI.QueryUserName(const AUserName: string;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LUser: TParseAPI.TUser;
begin
  Result := ParseAPI.QueryUserName(AUserName, LUser, AJSON);
  AUser := TParseMetaFactory.CreateMetaFoundUser(LUser);
end;


procedure TParseUsersAPI.QueryUsers(
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  ParseAPI.QueryUsers(
    AQuery, AJSONArray);
end;

procedure TParseUsersAPI.QueryUsers(
  const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>);
var
  LUserArray: TArray<TParseAPI.TUser>;
  LUser: TParseAPI.TUser;
  LList: TList<TBackendEntityValue>;
begin
  ParseAPI.QueryUsers(
    AQuery, AJSONArray, LUserArray);
  if Length(LUserArray) > 0 then
  begin
    LList := TList<TBackendEntityValue>.Create;
    try
      for LUser in LUserArray do
        LList.Add(TParseMetaFactory.CreateMetaFoundUser(LUser));
      AMetaArray := LList.ToArray;
    finally
      LList.Free;
    end;
  end;

end;

procedure TParseUsersAPI.UpdateUser(const AObject: TBackendEntityValue;
  const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LUpdated: TParseAPI.TUpdatedAt;
begin
  if AObject.Data is TMetaLogin then
  begin
    ParseAPI.UpdateUser(TMetaLogin(AObject.Data).Login, AUserData, LUpdated);
    AUpdatedObject := TParseMetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else if AObject.Data is TMetaUser then
  begin
    ParseAPI.UpdateUser(TMetaUser(AObject.Data).User.ObjectID, AUserData, LUpdated);
    AUpdatedObject := TParseMetaFactory.CreateMetaUpdatedUser(LUpdated);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

{ TParseFilesAPI }


procedure TParseFilesAPI.UploadFile(const AFileName, AContentType: string;
  out AFile: TBackendEntityValue);
var
  LFile: TParseAPI.TFile;
begin
  // Upload public file
  ParseAPI.UploadFile(AFileName, AContentType,LFile);
  AFile :=  TParseMetaFactory.CreateMetaUploadedFile(LFile);
end;

function TParseFilesAPI.DeleteFile(const AFile: TBackendEntityValue): Boolean;
var
  LMetaFile: TMetaFile;
begin
  if AFile.Data is TMetaFile then
  begin
    LMetaFile := TMetaFile(AFile.Data);
    Result := ParseAPI.DeleteFile(LMetaFile.FileValue);
  end
  else
    raise EArgumentException.Create(sParameterNotMetaType);
end;

function TParseFilesAPI.GetMetaFactory: IBackendMetaFactory;
begin
  Result := TMetaFactory.Create;
end;

procedure TParseFilesAPI.UploadFile(const AFileName: string;
  const AStream: TStream; const AContentType: string;
  out AFile: TBackendEntityValue);
var
  LFile: TParseAPI.TFile;
begin
  // Upload public file
  ParseAPI.UploadFile(AFileName, AStream, AContentType, LFile);
  AFile :=  TParseMetaFactory.CreateMetaUploadedFile(LFile);
end;

initialization
  RegisterServices;
finalization
  UnregisterServices;

end.
