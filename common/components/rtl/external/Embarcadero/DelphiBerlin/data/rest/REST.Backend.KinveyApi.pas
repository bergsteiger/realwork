{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.KinveyApi;

{$SCOPEDENUMS ON}

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.JSON,
  REST.Client, REST.Types, REST.Backend.Exception;

type

  EKinveyAPIError = class(EBackendAPIError)
  private
    FError: string;
    FDescription: string;
  public
    constructor Create(const AError, ADescription: string); overload;
    property Error: string read FError;
    property Description: string read FDescription;
  end;

  TKinveyAPIErrorClass = class of EKinveyAPIError;

  /// <summary>
  /// <para>
  /// TKinveyApi implements REST requests based on Kinvey's REST API. See
  /// <see href="http://devcenter.kinvey.com/rest/" />
  /// </para>
  /// </summary>
  TKinveyApi = class(TComponent)
  public type
    TPlatformType = (IOS, Android);


    TConnectionInfo = record
    private
    public
      ApiVersion: string;
      AppKey: string;
      AppSecret: string;
      MasterSecret: string;
      UserName: string;
      Password: string;
      ProxyPassword: string;
      ProxyPort: Integer;
      ProxyServer: string;
      ProxyUsername: string;
      constructor Create(const AApiVersion, AAppKey: String); overload;
    end;

    TUpdatedAt = record
    private
      FUpdatedAt: TDateTime;
    public
      constructor Create(AUpdatedAt: TDateTime);
      property UpdatedAt: TDateTime read FUpdatedAt;
    end;


    TObjectID = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FObjectID: string;
      FBackendCollectionName: string;
    public
      constructor Create(const ABackendCollectionName: string; AObjectID: string);
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property ObjectID: string read FObjectID;
      property BackendCollectionName: string read FBackendCollectionName;
    end;

    TFile = record
    private
      FID: string;
      FFileName: string;
      FDownloadURL: string;
      FExpiresAt: TDateTime;
    public
      constructor Create(const AID: string);
      property FileName: string read FFileName;
      property DownloadURL: string read FDownloadURL;
      property ID: string read FID;
      property ExpiresAt: TDateTime read FExpiresAt;
    end;

    TUser = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FObjectID: string;
      FUserName: string;
    public
      constructor Create(const AUserName: string);
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property ObjectID: string read FObjectID;
      property UserName: string read FUserName;
    end;

    TUserGroup = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FObjectID: string;
    public
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property ObjectID: string read FObjectID;
    end;

    TLogin = record
    private
      FAuthToken: string;
      FUser: TUser;
    public
      constructor Create(const AAuthToken: string; const AUser: TUser);
      property AuthToken: string read FAuthToken;
      property User: TUser read FUser;
    end;

    TAuthentication = (Default, MasterSecret, AppSecret, UserName, Session, None);
    TDefaultAuthentication = (MasterSecret, AppSecret, UserName, Session, None);

    TFindObjectProc = reference to procedure(const AID: TObjectID; const AObj: TJSONObject);
    TQueryUserNameProc = reference to procedure(const AUser: TUser; const AObj: TJSONObject);
    TLoginProc = reference to procedure(const ALogin: TLogin; const AObj: TJSONObject);
    TRetrieveUserProc = reference to procedure(const AUser: TUser; const AObj: TJSONObject);
    TRetrieveFileProc = reference to procedure(const AFile: TFile; const AObj: TJSONObject);
    TRetrieveUserGroupProc = reference to procedure(const AUserGroup: TUserGroup; const AObj: TJSONObject);

  public
    const
      DateTimeIsUTC = True;
  public
    class var
      EmptyConnectionInfo: TConnectionInfo;
  private
    const
      sAppKey = 'appKey';
      sDateCreated = 'ect';
      sDateUpdated = 'lmt';
      cDateTimeIsUTC = True;
      sDataStore = 'appdata';
      sUserGroup = 'group';
      sBlob = 'blob';
      sUser = 'user';
      sLogin = 'login';
      sPush = 'push';
      sRpc = 'rpc';
      sRegisterDevice = 'register-device';
      sUnregisterDevice = 'unregister-device';
      sAppKeySegment = '/{' + sAppKey + '}';
      sUserAppKey = sUser + sAppKeySegment;
      sDataStoreAppKey = sDataStore + sAppKeySegment;
      sUserGroupAppKey = sUserGroup + sAppKeySegment;
      sPushAppKey = sPush + sAppKeySegment;
      sBlobAppKey = sBlob + sAppKeySegment;
      sRpcAppKey = sRpc + sAppKeySegment;
      sMessageElement = 'message';
      sIOSApsElement = 'iosaps';
      sIOSExtrasElement = 'iosextras';
      sAndroidPayloadElement = 'androidpayload';
      sUsersElement = 'users';
  public
    const
      cDefaultApiVersion = '3';
      cDefaultBaseURL = 'https://baas.kinvey.com/'; // do not localize
  private
    FRESTClient: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
    FBaseURL: string;
    FOwnsResponse: Boolean;
    FConnectionInfo: TConnectionInfo;
    FSessionAuthToken: string;
    FAuthentication: TAuthentication;
    FDefaultAuthentication: TDefaultAuthentication;
    procedure SetBaseURL(const Value: string);
    procedure SetConnectionInfo(const Value: TConnectionInfo);
    function GetLoggedIn: Boolean;
  protected
    function GetActualAuthentication: TAuthentication;
    function CreateException(const ARequest: TRESTRequest; const AClass: TKinveyAPIErrorClass):
      EKInveyAPIError;
    procedure AddAuthParameter; overload;
    procedure AddAuthParameter(Authentication: TAuthentication); overload;
    procedure ApplyConnectionInfo;
    procedure CheckForResponseError(const ARequest: TRESTRequest); overload;
    procedure CheckForResponseError; overload;
    procedure CheckForResponseError(AValidStatusCodes: array of Integer); overload;
    procedure PostObject(const AResource, ABackendCollectionName: string; const AACL, AJSON: TJSONObject; out ANewObject: TObjectID; AReset: Boolean); overload;
    procedure PostObject(const AResource, ABackendCollectionName: string; const AJSON: TJSONObject; out ANewObject: TObjectID; AReset: Boolean); overload;
    procedure PutObject(const AResource, ABackendCollectionName, AObjectID: string; const AJSON: TJSONObject; out AObject: TObjectID; AReset: Boolean); overload;
    procedure PutObject(const AResource, ABackendCollectionName, AObjectID: string; const AACL, AJSON: TJSONObject; out AObject: TObjectID; AReset: Boolean); overload;
    //function ObjectIDFromObject(const ABackendCollectionName: string; const AJSONObject: TJSONObject): TObjectID; overload;
    function ObjectIDFromObject(const ABackendCollectionName, AObjectID: string; const AJSONObject: TJSONObject): TObjectID; overload;
    function FileFromObject(const AFileName: string; const AJSONObject: TJSONObject): TFile; overload;
    function FileFromObject(const AJSONObject: TJSONObject): TFile; overload;
    function DeleteObject(const AResource: string; AReset: Boolean): Integer;
    function FindAppData(const ABackendCollectionName, AObjectID: string; out AFoundObject: TObjectID; const AJSON: TJSONArray; AProc: TFindObjectProc): Boolean; overload;
    function LoginFromObject(const AUserName: string; const AJSONObject: TJSONObject): TLogin;
    procedure LoginUser(const AUserName, APassword: string; out ALogin: TLogin; const AJSON: TJSONArray; AProc: TLoginProc); overload;
    function QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean; overload;
    function UpdatedAtFromObject(const AJSONObject: TJSONObject): TUpdatedAt;
    function UserFromObject(const AUserName: string; const AJSONObject: TJSONObject): TUser; overload;
    function UserGroupFromObject(const AUserGroupName: string; const AJSONObject: TJSONObject): TUserGroup; overload;
    function DeleteOrSuspendUser(const AObjectID: string; ADelete: Boolean): Boolean;
    function RetrieveUser(const AObjectID: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TRetrieveUserProc): Boolean; overload;
    procedure QueryResource(const AResource: string; const AQuery: array of string; const AJSONArray: TJSONArray; AReset: Boolean);
    function RetrieveFile(const AFileID: string; out AFile: TFile; const AJSON: TJSONArray; AProc: TRetrieveFileProc): Boolean; overload;
    function RetrieveUserGroup(const AObjectID: string; out AUserGroup: TUserGroup; const AJSON: TJSONArray; AProc: TRetrieveUserGroupProc): Boolean; overload;
    function RetrieveUserGroup(const AObjectID: string; AProc: TRetrieveUserGroupProc): Boolean; overload;
    procedure InvokeEndpoint(const AEndpointName: string; const AJSONParameters: TJSONObject; AReset: Boolean; ACheckError: Boolean); overload;
    property RestClient: TRESTClient read FRESTClient;
    property Request: TRESTRequest read FRequest;
  public
    constructor Create(AOwner: TComponent; const AResponse: TRESTResponse = nil); reintroduce; overload;
    destructor Destroy; override;
    // Utilities
    function UserFromObject(const AJSONObject: TJSONObject): TUser; overload;
    function ObjectIDFromObject(const ABackendCollectionName: string;
      const AJSONObject: TJSONObject): TObjectID; overload;
    // Handshake
    procedure AppHandshake(const AJSONArray: TJSONArray);
    // Installations
    procedure PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID, AUserID: string); overload;
    procedure PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string); overload;
    procedure PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string; const AUser: TUser); overload;
    procedure PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID, AUserID: string); overload;
    procedure PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string; const AUser: TUser); overload;
    procedure PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string); overload;
    // AppData
    procedure CreateAppData(const ABackendCollectionName: string; const AACL, AJSON: TJSONObject; out ANewObject: TObjectID);  overload;
    procedure CreateAppData(const ABackendCollectionName: string; const AJSON: TJSONObject; out ANewObject: TObjectID);  overload;
    function FindAppData(const AObject: TObjectID; AProc: TFindObjectProc): Boolean; overload;
    function FindAppData(const AObject: TObjectID; out AFoundObject: TObjectID; const AJSON: TJSONArray = nil): Boolean; overload;
    function FindAppData(const ABackendCollectionName, AObjectID: string; AProc: TFindObjectProc): Boolean; overload;
    function FindAppData(const ABackendCollectionName, AObjectID: string; out AFoundObject: TObjectID; const AJSON: TJSONArray = nil): Boolean; overload;
    function DeleteAppData(const AObject: TObjectID): Integer; overload;
    function DeleteAppData(const ABackendCollectionName: string; const AObjectID: string): Integer ;overload;
    function DeleteAppDataCollection(const ABackendCollectionName: string): Integer;
    procedure UpdateAppData(const AObject: TObjectID; const AJSONObject: TJSONObject; out AUpdateObject: TObjectID); overload;
    procedure UpdateAppData(const ABackendCollectionName, AObjectID: string; const AJSONObject: TJSONObject; out AUpdateObject: TObjectID); overload;
    procedure QueryAppData(const ABackendCollectionName: string;
      const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryAppData(const ABackendCollectionName: string;
      const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TObjectID>); overload;
    // Files
    function DeleteFile(const AFile: TFile): Boolean; overload;
    function DeleteFile(const AFileID: string): Boolean; overload;
    procedure UploadFile(const AFileName: string; AContentType: string; APublic: Boolean; const AUserFields: TJSONObject; out ANewFile: TFile); overload;
    procedure UploadFile(const AFileName: string; const AStream: TStream; AContentType: string; APublic: Boolean; const AUserFields: TJSONObject; out ANewFile: TFile); overload;
    procedure DownloadFile(const AFile: TFile; const AStream: TStream);
    procedure QueryFiles(const AQuery: array of string;
      const AJSONArray: TJSONArray); overload;
    procedure QueryFiles(const AQuery: array of string;
      const AJSONArray: TJSONArray; out AFiles: TArray<TFile>); overload;
    function RetrieveFile(const AFile: TFile; AProc: TRetrieveFileProc): Boolean; overload;
    function RetrieveFile(const AFile: TFile; out AFoundFile: TFile; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveFile(const AFileID: string; out AFile: TFile; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveFile(const AFileID: string; AProc: TRetrieveFileProc): Boolean; overload;
    // User groups
    procedure CreateUserGroup(const AID: string; const AACL, AUsersAndGroups: TJSONObject; out ANewUserGroup: TUserGroup); overload;
    procedure CreateUserGroup(const AID: string; const AUsersAndGroups: TJSONObject; out ANewUserGroup: TUserGroup); overload;
    procedure UpdateUserGroup(const AID: string; const AUsersAndGroups: TJSONObject; out AUpdateObject: TObjectID); overload;
    procedure UpdateUserGroup(const AUserGroup: TUserGroup; const AUsersAndGroups: TJSONObject; out AUpdateObject: TObjectID); overload;
    function DeleteUserGroup(const AUserGroup: TUserGroup): Boolean; overload;
    function DeleteUserGroup(const AID: string): Boolean; overload;
    function RetrieveUserGroup(const AUserGroup: TUserGroup; AProc: TRetrieveUserGroupProc): Boolean; overload;
    function RetrieveUserGroup(const AUserGroup: TUserGroup; out AFoundUserGroup: TUserGroup; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUserGroup(const AObjectID: string; out AUserGroup: TUserGroup; const AJSON: TJSONArray = nil): Boolean; overload;
    // Users
    function QueryUserName(const AUserName: string; AProc: TQueryUserNameProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const AUser: TUser; AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveUser(const AUser: TUser; out AFoundUser: TUser; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const AObjectID: string; out AUser: TUser; const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const AObjectID: string; AProc: TRetrieveUserProc): Boolean; overload;
    procedure SignupUser(const AUserName, APassword: string; const AUserFields: TJSONObject; out ALogin: TLogin);
    procedure LoginUser(const AUserName, APassword: string; AProc: TLoginProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out ALogin: TLogin; const AJSON: TJSONArray = nil); overload;
    procedure LogoutUser;
    procedure RestoreSuspendedUser(const AObjectID: string);  overload;
    procedure RestoreSuspendedUser(const AUser: TUser); overload;
    function RetrieveCurrentUser(AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveCurrentUser(out AUser: TUser; const AJSON: TJSONArray = nil): Boolean; overload;
    procedure UpdateUser(const AObjectID: string; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    procedure UpdateUser(const AUser: TUser; const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    function DeleteUser(const AObjectID: string): Boolean; overload;
    function DeleteUser(const AUser: TUser): Boolean; overload;
    function SuspendUser(const AObjectID: string): Boolean; overload;
    function SuspendUser(const AUser: TUser): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AUsers: TArray<TUser>); overload;
    { Endpoints }
    procedure InvokeCustomEndpoint(const AEndpointName: string; const AJSONParameters: TJSONObject; const AJSONResult: TJSONArray);
    procedure InvokeEndpoint(const AEndpointName: string; const AJSONParameters: TJSONObject; const AJSONResult: TJSONArray); overload;
    { Messaging }
    procedure BroadcastMessage(const AEndpointName: string; const AMessage: string);
    procedure SendMessage(const AEndpointName: string; AUsers: array of TUser; const AMessage: string);
    procedure BroadcastPayload(const AEndpointName: string; const AIOSAps, AIOSExtras, AAndroidPayload: TJSONObject);
    procedure SendPayload(const AEndpointName: string; AUsers: array of TUser; const AIOSAps, AIOSExtras, AAndroidPayload: TJSONObject); overload;
    procedure SendPayload(const AEndpointName: string; AUsers: array of string; const AIOSAps, AIOSExtras, AAndroidPayload: TJSONObject); overload;

    procedure Login(const ASessionAuthToken: string); overload;
    procedure Login(const ALogin: TLogin); overload;
    procedure Logout;
    property LoggedIn: Boolean read GetLoggedIn;
    property Authentication: TAuthentication read FAuthentication write FAuthentication;
    property DefaultAuthentication: TDefaultAuthentication read FDefaultAuthentication write FDefaultAuthentication;
    property Response: TRESTResponse read FResponse;
    property BaseURL: string read FBaseURL write SetBaseURL;
    property ConnectionInfo: TConnectionInfo read FConnectionInfo write SetConnectionInfo;
  end;


  EKinveyDuplicateUser = class(EKinveyAPIError);

  EKinveyFileNotFound = class(EKinveyAPIError);

implementation

uses
  System.Rtti,
  REST.JSON.Types,
  REST.Consts, REST.Backend.Consts, System.TypInfo;

procedure CheckObjectID(const AObjectID: string);
begin
  if AObjectID = '' then
    raise EKinveyAPIError.Create(sObjectIDRequired);
end;

procedure CheckAuthToken(const AAuthToken: string);
begin
  if AAuthToken = '' then
    raise EKinveyAPIError.Create(sAuthTokenRequired);
end;

procedure CheckBackendCollectionName(const ABackendCollectionName: string);
begin
  if ABackendCollectionName = '' then
    raise EKinveyAPIError.Create(sBackendCollectionNameRequired);
end;

procedure CheckJSONObject(const AJSON: TJSONObject);
begin
  if AJSON = nil then
    raise EKinveyAPIError.Create(sJSONObjectRequired);
end;

{ TKinveyApi }

// GET /appdata/:appKey
// Host: baas.kinvey.com
// Authorization: [Basic Auth with app credentials]
procedure TKinveyApi.AppHandshake(const AJSONArray: TJSONArray);
begin
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sDataStoreAppKey;

  AddAuthParameter(TAuthentication.AppSecret);
  FRequest.Execute;
  CheckForResponseError;

  if Assigned(AJSONArray) then
    AJSONArray.AddElement(FRequest.Response.JSONValue.Clone as TJSONObject);
end;

                            
const
  Codes64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  Pad = '=';

function EncodeBytes64(asBytes: TArray<Byte>): string;
var
  bitIdx, Count, Data, I, Remainder: Integer;
begin
  bitIdx := 0;
  Remainder := 0;
  Count := Length(asBytes);
  for I := 0 to Count - 1 do
  begin
    Data := Ord(asBytes[I]);
    Remainder := (Remainder shl 8) or Data;
    bitIdx := bitIdx + 8;
    while bitIdx >= 6 do
    begin
      bitIdx := bitIdx - 6;
      Data := Remainder div (1 shl bitIdx);
      Remainder := Remainder mod (1 shl bitIdx);
      Result := Result + Codes64.Chars[Data];
    end;
  end;
  if bitIdx > 0 then
  begin
    Data := Remainder shl (6 - bitIdx);
    Result := Result + Codes64.Chars[Data];
  end;
  case Count mod 3 of
    1: Result := Result + Pad + Pad;
    2: Result := Result + Pad;
  end;
end;

function Encode64(Str: string): string;
begin
  Result := EncodeBytes64(TEncoding.UTF8.GetBytes(Str));
end;

procedure TKinveyApi.ApplyConnectionInfo;
begin
  FRESTClient.Params.AddHeader('X-Kinvey-API-Version', FConnectionInfo.ApiVersion);  // do not localize
  FRESTClient.Params.AddUrlSegment(sAppKey, FConnectionInfo.AppKey);
  FRESTClient.ProxyPort := FConnectionInfo.ProxyPort;
  FRESTClient.ProxyPassword := FConnectionInfo.ProxyPassword;
  FRESTClient.ProxyUsername := FConnectionInfo.ProxyUsername;
  FRESTClient.ProxyServer := FConnectionInfo.ProxyServer;
end;

// Invoke custom endpoint to broadcast a message, such as:
(*
function onRequest(request, response, modules){
  var message = request.body.message;
  var push = modules.push;
  push.broadcastMessage(message);
  response.complete( 200 );
}
*)
procedure TKinveyApi.BroadcastMessage(const AEndpointName, AMessage: string);
var
  LJSONObject: TJSONObject;
begin
  LJSONObject := TJSONObject.Create;
  try
    LJSONObject.AddPair(sMessageElement, AMessage);
    InvokeCustomEndPoint(AEndpointName, LJSONObject, nil);
  finally
    LJSONObject.Free;
  end;
end;

// Invoke custom endpoint to broadcast a payload, such as:
(*
function onRequest(request, response, modules){
  var iosaps = request.body.iosaps;
  var iosextras = request.body.iosextras;
  var androidpayload = request.body.androidpayload;
  var push = modules.push;
  push.broadcastPayload(iosaps, iosextras, androidpayload);
  response.complete( 200 );
}
*)
procedure TKinveyApi.BroadcastPayload(const AEndpointName: string;
  const AIOSAps, AIOSExtras, AAndroidPayload: TJSONObject);
var
  LJSONObject: TJSONObject;
begin
  LJSONObject := TJSONObject.Create;
  try
    if AIOSAps <> nil then
      LJSONObject.AddPair(sIOSApsElement, AIOSAps.Clone as TJSONObject);
    if AIOSExtras <> nil then
      LJSONObject.AddPair(sIOSExtrasElement, AIOSExtras.Clone as TJSONObject);
    if AAndroidPayload <> nil then
      LJSONObject.AddPair(sAndroidPayloadElement, AAndroidPayload.Clone as TJSONObject);
    InvokeCustomEndPoint(AEndpointName, LJSONObject, nil);
  finally
    LJSONObject.Free;
  end;
end;

// Invoke custom endpoint to send a message, such as:
(*
function onRequest(request, response, modules){
  var users = request.body.users;
  var message = request.body.message;
  var push = modules.push;
  push.sendMessage(users, message);
  response.complete( 200 );
}
*)
procedure TKinveyApi.SendMessage(const AEndpointName: string;
  AUsers: array of TUser; const AMessage: string);
var
  LJSONObject: TJSONObject;
  LJSONArray: TJSONArray;
  LUser: TUser;
begin
  LJSONObject := TJSONObject.Create;
  try
    LJSONArray := TJSONArray.Create;
    LJSONObject.AddPair(sUsersElement, LJSONArray);
    for LUser in AUsers do
    begin
      Assert(LUser.FObjectID <> '');
      if LUser.FObjectID <> '' then
        LJSONArray.Add(LUser.FObjectID);
    end;
    LJSONObject.AddPair(sMessageElement, AMessage);
    InvokeCustomEndPoint(AEndpointName, LJSONObject, nil);
  finally
    LJSONObject.Free;
  end;
end;

// Invoke custom endpoint to send a payload, such as:
(*
function onRequest(request, response, modules){
  var users = request.body.users;
  var iosaps = request.body.iosaps;
  var iosextras = request.body.iosextras;
  var androidpayload = request.body.androidpayload;
  var push = modules.push;
  push.sendPayload(users, iosaps, iosextras, androidpayload);
  response.complete( 200 );
}
*)
procedure TKinveyApi.SendPayload(const AEndpointName: string;
  AUsers: array of TUser; const AIOSAps, AIOSExtras,
  AAndroidPayload: TJSONObject);
var
  LUsers: TStrings;
  LUser: TUser;
begin
  LUsers := TStringList.Create;
  try
    for LUser in AUsers do
    begin
      Assert(LUser.FObjectID <> '');
      if LUser.FObjectID <> '' then
        LUsers.Add(LUser.FObjectID);
    end;
    SendPayload(AEndpointName,
      LUsers.ToStringArray, AIOSAps, AIOSExtras,
      AAndroidPayload);
  finally
    LUsers.Free;
  end;
end;

procedure TKinveyApi.SendPayload(const AEndpointName: string;
  AUsers: array of string; const AIOSAps, AIOSExtras,
  AAndroidPayload: TJSONObject);
var
  LJSONObject: TJSONObject;
  LJSONArray: TJSONArray;
  LUser: string;
begin
  LJSONObject := TJSONObject.Create;
  try
    LJSONArray := TJSONArray.Create;
    LJSONObject.AddPair(sUsersElement, LJSONArray);
    for LUser in AUsers do
    begin
      Assert(LUser <> '');
      if LUser <> '' then
        LJSONArray.Add(LUser);
    end;
    if AIOSAps <> nil then
      LJSONObject.AddPair(sIOSApsElement, AIOSAps.Clone as TJSONObject);
    if AIOSExtras <> nil then
      LJSONObject.AddPair(sIOSExtrasElement, AIOSExtras.Clone as TJSONObject);
    if AAndroidPayload <> nil then
      LJSONObject.AddPair(sAndroidPayloadElement, AAndroidPayload.Clone as TJSONObject);
    InvokeCustomEndPoint(AEndpointName, LJSONObject, nil);
  finally
    LJSONObject.Free;
  end;
end;

function TKinveyApi.GetActualAuthentication: TAuthentication;
var
  LAuthentication: TAuthentication;
begin
  LAuthentication := FAuthentication;
  if LAuthentication = TAuthentication.Default then
    case FDefaultAuthentication of
      TDefaultAuthentication.MasterSecret:
        LAuthentication := TAuthentication.MasterSecret;
      TDefaultAuthentication.UserName:
        LAuthentication := TAuthentication.UserName;
      TKinveyApi.TDefaultAuthentication.Session:
        LAuthentication := TAuthentication.Session;
      TKinveyApi.TDefaultAuthentication.None:
        LAuthentication := TAuthentication.None;
    else
      Assert(False);
    end;
  Result := LAuthentication;
end;

procedure TKinveyApi.AddAuthParameter;
var
  LAuthentication: TAuthentication;
begin
  LAuthentication := GetActualAuthentication;
  case LAuthentication of
    TKinveyApi.TAuthentication.UserName,
    TKinveyApi.TAuthentication.MasterSecret,
    TKinveyApi.TAuthentication.AppSecret,
    TKinveyApi.TAuthentication.Session:
      AddAuthParameter(LAuthentication);
    TKinveyApi.TAuthentication.None:
      ;
  else
    Assert(False);
  end;
end;

procedure TKinveyApi.AddAuthParameter(Authentication: TAuthentication);
var
  LCredentials: String;
begin
  case Authentication of
    TAuthentication.AppSecret:
    begin
      if FConnectionInfo.AppKey = '' then
        raise EKinveyAPIError.Create(sAppKeyRequired);
      if FConnectionInfo.AppSecret = '' then
        raise EKinveyAPIError.Create(sAppSecretRequired);
      LCredentials := 'Basic ' + Encode64(FConnectionInfo.AppKey + ':' + FConnectionInfo.AppSecret);   // Do not localize
    end;
    TAuthentication.MasterSecret:
    begin
      if FConnectionInfo.AppKey = '' then
        raise EKinveyAPIError.Create(sAppKeyRequired);
      if FConnectionInfo.MasterSecret = '' then
        raise EKinveyAPIError.Create(sMasterSecretRequired);
      LCredentials := 'Basic ' + Encode64(FConnectionInfo.AppKey + ':' + FConnectionInfo.MasterSecret);     // Do not localize
    end;
    TAuthentication.UserName:
    begin
      if FConnectionInfo.UserName = '' then
        raise EKinveyAPIError.Create(sUserNameRequired);
      LCredentials := 'Basic ' + Encode64(FConnectionInfo.UserName + ':' + FConnectionInfo.Password);         // Do not localize
    end;
    TAuthentication.Session:
    begin
      if FSessionAuthToken = '' then
        raise EKinveyAPIError.Create(sAuthTokenRequired);
      LCredentials := 'Kinvey ' + FSessionAuthToken;              // Do not localize
    end;
  else
    Assert(False);
  end;
  if LCredentials <> '' then
    FRequest.AddAuthParameter(HTTP_HEADERFIELD_AUTH, LCredentials, TRESTRequestParameterKind.pkHTTPHEADER,
      [TRESTRequestParameterOption.poDoNotEncode]);
end;

procedure TKinveyApi.CheckForResponseError;
begin
  CheckForResponseError(FRequest);
end;


function TKinveyApi.CreateException(const ARequest: TRESTRequest;
  const AClass: TKinveyAPIErrorClass): EKinveyAPIError;
var
  LError: string;
  LDescription: string;
  LJSONError: TJSONValue;
  LJSONDescription: TJSONValue;
begin
  if ARequest.Response.JSONValue <> nil then
  begin
    LJSONError := (ARequest.Response.JSONValue as TJSONObject).GetValue('error');     // Do not localize
    if LJSONError <> nil then
      LError := LJSONError.Value;
    LJSONDescription := (ARequest.Response.JSONValue as TJSONObject).GetValue('description');     // Do not localize
    if LJSONDescription <> nil then
      LDescription := LJSONDescription.Value;
    if (LJSONError <> nil) and (LJSONDescription <> nil) then
      Result := AClass.Create(LError, LDescription)
    else if LJSONDescription <> nil then
      Result := AClass.Create(LDescription)
    else if LJSONError <> nil then
      Result := AClass.Create(LError)
    else
      Result := AClass.Create(ARequest.Response.Content);
  end
  else
    Result := AClass.Create(ARequest.Response.Content);
end;


procedure TKinveyApi.CheckForResponseError(const ARequest: TRESTRequest);
begin
  if ARequest.Response.StatusCode >= 300 then
     raise CreateException(ARequest, EKinveyAPIError);
end;

procedure TKinveyApi.CheckForResponseError(AValidStatusCodes: array of Integer);
var
  LCode: Integer;
  LResponseCode: Integer;
begin
  LResponseCode := FRequest.Response.StatusCode;

  for LCode in AValidStatusCodes do
    if LResponseCode = LCode then
      Exit; // Code is valid, exit with no exception
  CheckForResponseError;
end;

constructor TKinveyApi.Create(AOwner: TComponent; const AResponse: TRESTResponse);
begin
  inherited Create(AOwner);
  FRESTClient := TRESTClient.Create(nil);
  FRESTClient.SynchronizedEvents := False;
  FRequest := TRESTRequest.Create(nil);
  FRequest.SynchronizedEvents := False;
  FRequest.Client := FRESTClient;
  FOwnsResponse := AResponse = nil;
  if FOwnsResponse then
    FResponse := TRESTResponse.Create(nil)
  else
    FResponse := AResponse;
  FRequest.Response := FResponse;
  SetBaseURL(cDefaultBaseURL);
  FConnectionInfo := TConnectionInfo.Create(cDefaultApiVersion, '');
  ApplyConnectionInfo;
end;

//  POST /appdata/:appKey/:collectionName HTTP/1.1
//  Host: baas.kinvey.com
//  Authorization: [user credentials]
//  Content-Type: application/json
//
//  <JSON-Document-representing-Entity>
procedure TKinveyApi.CreateAppData(const ABackendCollectionName: string; const AJSON: TJSONObject; out ANewObject: TObjectID);
begin
  CreateAppData(ABackendCollectionName, nil, AJSON, ANewObject);
end;

procedure TKinveyApi.CreateAppData(const ABackendCollectionName: string;
  const AACL, AJSON: TJSONObject; out ANewObject: TObjectID);
begin
  PostObject(sDataStoreAppKey, ABackendCollectionName, AACL, AJSON, ANewObject, True)
end;


function TKinveyApi.DeleteAppData(const AObject: TObjectID): Integer;
begin
  Result := DeleteAppData(AObject.BackendCollectionName, AObject.ObjectID);
end;

//  DELETE /appdata/:appKey/:collectionName/?query=... HTTP/1.1
//  Host: baas.kinvey.com
//  X-Kinvey-API-Version: 2
//  Authorization: [user credentials]
//  HTTP/1.1 200 OK
//  Content-Type: application/json
//
//  {
//    "count": 5
//  }
function TKinveyApi.DeleteAppData(const ABackendCollectionName, AObjectID: string): Integer;
begin
  CheckBackendCollectionName(ABackendCollectionName);
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameter;
  Result := DeleteObject(sDataStoreAppKey + '/' + ABackendCollectionName + '/' + AObjectID, False);
end;

//  POST /rpc/:appKey/remove-collection HTTP/1.1
//  Host: baas.kinvey.com
//  Content-Type: application/json
//  Authorization: [master credentials]
//  X-Kinvey-API-Version: 2
//  X-Kinvey-Delete-Entire-Collection: true
//
//  {
//    "collectionName": "your-collection-name"
//  }
function TKinveyApi.DeleteAppDataCollection(const ABackendCollectionName: string): Integer;
var
  LJSON: TJSONObject;
  LDeleted: Boolean;
  LResponse: TJSONObject;
begin
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('collectionName', ABackendCollectionName); // Do not localize
    FRequest.ResetToDefaults;
    AddAuthParameter(TAuthentication.MasterSecret);
    FRequest.Params.AddHeader('X-Kinvey-Delete-Entire-Collection', 'true');  // Do not localize
    InvokeEndpoint('remove-collection', LJSON, False, False);                       // Do not localize
    CheckForResponseError([404]);
    LDeleted := FRequest.Response.StatusCode <> 404;
    if LDeleted then
    begin
      LResponse := FRequest.Response.JSONValue as TJSONObject;
      Result := StrToInt(LResponse.GetValue('count').Value)   // Do not localize
    end
    else
      Result := -1;
  finally
    LJSON.Free;
  end;
end;

function TKinveyApi.DeleteObject(const AResource: string; AReset: Boolean): Integer;
var
  ObjectDeleted: Boolean;
  LResponse: TJSONObject;
begin
  Assert(AResource <> '');
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameter; 
  end;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource :=  AResource;
  FRequest.Execute;
  CheckForResponseError([404]);
  ObjectDeleted := FRequest.Response.StatusCode <> 404;
  if ObjectDeleted then
  begin
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    Result := StrToInt(LResponse.GetValue('count').Value)          // Do not localize
  end
  else
    Result := -1;
end;

destructor TKinveyApi.Destroy;
begin
  FRESTClient.Free;
  FRequest.Free;
  if FOwnsResponse then
    FResponse.Free;
  inherited;
end;

function TKinveyApi.FindAppData(const AObject: TObjectID; AProc: TFindObjectProc): Boolean;
begin
  Result := FindAppData(AObject.BackendCollectionName, AObject.ObjectID, AProc);
end;

function TKinveyApi.FindAppData(const AObject: TObjectID; out AFoundObject: TObjectID; const AJSON: TJSONArray = nil): Boolean;
begin
  Result := FindAppData(AObject.BackendCollectionName, AObject.ObjectID, AFoundObject, AJSON, nil);
end;

function TKinveyApi.FindAppData(const ABackendCollectionName, AObjectID: string; out AFoundObject: TObjectID; const AJSON: TJSONArray = nil): Boolean;
begin
  Result := FindAppData(ABackendCollectionName, AObjectID, AFoundObject, AJSON, nil);
end;

function TKinveyApi.FindAppData(const ABackendCollectionName, AObjectID: string; AProc: TFindObjectProc): Boolean;
var
  LObject: TObjectID;
begin
  Result := FindAppData(ABackendCollectionName, AObjectID, LObject, nil, AProc);
end;


//  GET /appdata/:appKey/:collectionName/:id HTTP/1.1
//  Host: baas.kinvey.com
//  Authorization: [user credentials]
function TKinveyApi.FindAppData(const ABackendCollectionName, AObjectID: string; out AFoundObject: TObjectID; const AJSON: TJSONArray; AProc: TFindObjectProc): Boolean;
var
  LResponse: TJSONObject;
begin
  CheckBackendCollectionName(ABackendCollectionName);
  CheckObjectID(AObjectID);
  Assert(Assigned(AProc));
  Result := False;
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource :=  sDataStoreAppKey + '/'  + ABackendCollectionName + '/' + AObjectID;
  AddAuthParameter;
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AFoundObject := ObjectIDFromObject(ABackendCollectionName, LResponse);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AFoundObject, LResponse);
  end;
end;

function TKinveyApi.GetLoggedIn: Boolean;
begin
  Result := FSessionAuthToken <> '';
end;

procedure TKinveyApi.InvokeCustomEndpoint(const AEndpointName: string;
  const AJSONParameters: TJSONObject; const AJSONResult: TJSONArray);
begin
  InvokeEndPoint('custom/' + AEndpointName, AJSONParameters, AJSONResult); // Do not localize
end;

procedure TKinveyApi.InvokeEndpoint(const AEndpointName: string;
  const AJSONParameters: TJSONObject; const AJSONResult: TJSONArray);
begin
  InvokeEndPoint(AEndpointName, AJSONParameters, True, True);
  if AJSONResult <> nil then
    AJSONResult.AddElement((FRequest.Response.JSONValue as TJSONObject).Clone as TJSONObject);
end;

procedure TKinveyApi.InvokeEndpoint(const AEndpointName: string;
  const AJSONParameters: TJSONObject; AReset: Boolean; ACheckError: Boolean);
begin
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameter;
  end;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sRpcAppKey + '/' + AEndpointName;
  if AJSONParameters <> nil then
    FRequest.AddBody(AJSONParameters);
  FRequest.Execute;
  if ACheckError then
    CheckForResponseError;
end;

function TKinveyApi.ObjectIDFromObject(const ABackendCollectionName: string; const AJSONObject: TJSONObject): TObjectID;
begin
  Result := ObjectIDFromObject(ABackendCollectionName, AJSONObject.GetValue('_id').Value, AJSONObject);    // Do not localize
end;

function TKinveyApi.ObjectIDFromObject(const ABackendCollectionName, AObjectID: string;
  const AJSONObject: TJSONObject): TObjectID;
var
  LInnerJSONObject: TJSONObject;
begin
  Result := TObjectID.Create(ABackendCollectionName, AObjectID);
  LInnerJSONObject := AJSONObject.GetValue('_kmd') as TJSONObject;        // Do not localize
  if LInnerJSONObject.GetValue(sDateCreated) <> nil then
    Result.FCreatedAt := TJSONDates.AsDateTime(LInnerJSONObject.GetValue(sDateCreated), TJSONDates.TFormat.ISO8601, cDateTimeIsUTC);
  if LInnerJSONObject.GetValue(sDateUpdated) <> nil then
    Result.FUpdatedAt := TJSONDates.AsDateTime(LInnerJSONObject.GetValue(sDateUpdated), TJSONDates.TFormat.ISO8601, cDateTimeIsUTC);
end;

function TKinveyApi.FileFromObject(const AFileName: string; const AJSONObject: TJSONObject): TFile;
var
  LJSONValue: TJSONValue;
  LID: string;
begin
  LJSONValue := AJSONObject.GetValue('_id');          // Do not localize
  if LJSONValue <> nil then
    LID := LJSONValue.Value;
  Result := TFile.Create(LID);
  Result.FFileName := AFileName;
  LJSONValue := AJSONObject.GetValue('_downloadURL');    // Do not localize
  if LJSONValue <> nil then
    Result.FDownloadURL := LJSONValue.Value;
  LJSONValue := AJSONObject.GetValue('_expiresAt');      // Do not localize
  if LJSONValue <> nil then
    Result.FExpiresAt := TJSONDates.AsDateTime(LJSONValue, TJSONDates.TFormat.ISO8601, cDateTimeIsUTC);
end;

function TKinveyApi.FileFromObject(const AJSONObject: TJSONObject): TFile;
var
  LJSONValue: TJSONValue;
  LFileName: string;
begin
  LJSONValue := AJSONObject.GetValue('_filename');     // Do not localize
  if LJSONValue <> nil then
    LFileName := LJSONValue.Value;
  Result := FileFromObject(LFileName, AJSONObject);
end;

procedure TKinveyApi.Login(const ASessionAuthToken: string);
begin
  FSessionAuthToken := ASessionAuthToken;
  FAuthentication := TAuthentication.Session;
end;

procedure TKinveyApi.Login(const ALogin: TLogin);
begin
  Login(ALogin.AuthToken);
end;

function TKinveyApi.LoginFromObject(const AUserName: string; const AJSONObject: TJSONObject): TLogin;
var
  LUser: TUser;
  LAuthToken: string;
  LInnerJSONObject: TJSONObject;
  LJSONValue: TJSONValue;
begin
  LUser := UserFromObject(AUserName, AJSONObject);
  LInnerJSONObject := AJSONObject.GetValue('_kmd') as TJSONObject;    // Do not localize
  Assert(LInnerJSONObject <> nil);
  LJSONValue := nil;
  if LInnerJSONObject <> nil then
    LJSONValue := LInnerJSONObject.GetValue('authtoken');             // Do not localize
  Assert(LJSONValue <> nil);
  if LJSONValue <> nil then
    LAuthToken := LJSONValue.Value;
  Assert(LAuthToken <> '');
  Result := TLogin.Create(LAuthToken, LUser);
end;

function TKinveyApi.UpdatedAtFromObject(const AJSONObject: TJSONObject): TUpdatedAt;
var
  LUpdatedAt: TDateTime;
begin
  if AJSONObject.GetValue(sDateUpdated) <> nil then
    LUpdatedAt := TJSONDates.AsDateTime(AJSONObject.GetValue(sDateUpdated), TJSONDates.TFormat.ISO8601, DateTimeIsUTC)
  else
    LUpdatedAt := 0;
  Result := TUpdatedAt.Create(LUpdatedAt);
end;

procedure TKinveyApi.UpdateUser(const AUser: TUser;
  const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
begin
  UpdateUser(AUser.ObjectID, AUserObject, AUpdatedAt);
end;

function TKinveyApi.UserFromObject(const AUserName: string; const AJSONObject: TJSONObject): TUser;
var
  LInnerJSONObject: TJSONObject;
  LJSONValue: TJSONValue;
begin
  Result := TUser.Create(AUserName);
  LJSONValue := AJSONObject.GetValue('_id');               // Do not localize
  if LJSONValue <> nil then
    Result.FObjectID := LJSONValue.Value;
  Assert(Result.FObjectID <> '');
  LInnerJSONObject := AJSONObject.GetValue('_kmd') as TJSONObject;     // Do not localize
  Assert(LInnerJSONObject <> nil);
  if LInnerJSONObject.GetValue(sDateCreated) <> nil then
    Result.FCreatedAt := TJSONDates.AsDateTime(LInnerJSONObject.GetValue(sDateCreated), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
  if LInnerJSONObject.GetValue(sDateUpdated) <> nil then
    Result.FUpdatedAt := TJSONDates.AsDateTime(LInnerJSONObject.GetValue(sDateUpdated), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
end;

function TKinveyApi.UserGroupFromObject(const AUserGroupName: string; const AJSONObject: TJSONObject): TUserGroup;
var
  LInnerJSONObject: TJSONObject;
  LJSONValue: TJSONValue;
begin
  LJSONValue := AJSONObject.GetValue('_id');               // Do not localize
  if LJSONValue <> nil then
    Result.FObjectID := LJSONValue.Value;
  Assert(Result.FObjectID <> '');
  LInnerJSONObject := AJSONObject.GetValue('_kmd') as TJSONObject;     // Do not localize
  Assert(LInnerJSONObject <> nil);
  if LInnerJSONObject.GetValue(sDateCreated) <> nil then
    Result.FCreatedAt := TJSONDates.AsDateTime(LInnerJSONObject.GetValue(sDateCreated), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
  if LInnerJSONObject.GetValue(sDateUpdated) <> nil then
    Result.FUpdatedAt := TJSONDates.AsDateTime(LInnerJSONObject.GetValue(sDateUpdated), TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
end;


function TKinveyApi.UserFromObject(const AJSONObject: TJSONObject): TUser;
var
  LUserName: string;
begin
  if AJSONObject.GetValue('username') <> nil then                    // Do not localize
    LUserName := AJSONObject.GetValue('username').Value;             // Do not localize
  Assert(LUserName <> '');
  Result := UserFromObject(LUserName, AJSONObject);
end;

procedure TKinveyApi.PostObject(const AResource, ABackendCollectionName: string; const AJSON: TJSONObject;
  out ANewObject: TObjectID; AReset: Boolean);
begin
  PostObject(AResource, ABackendCollectionName, nil, AJSON, ANewObject, AReset);
end;

procedure TKinveyApi.PostObject(const AResource, ABackendCollectionName: string; const AACL, AJSON: TJSONObject;
  out ANewObject: TObjectID; AReset: Boolean);
var
  LResponse: TJSONObject;
  LJSON: TJSONObject;
begin
  CheckJSONObject(AJSON);
  // NEW : POST
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameter;
  end;

  LJSON := nil;
  try
    if (AACL <> nil) and (AJSON <> nil) then
    begin
      LJSON := AJSON.Clone as TJSONObject;
      LJSON.AddPair('_acl', AACL.Clone as TJSONObject);              // Do not localize
    end
    else if AACL <> nil then
      LJSON := AACL
    else
      LJSON := AJSON;
    FRequest.Method := TRESTRequestMethod.rmPOST;
    if ABackendCollectionName <> '' then
      FRequest.Resource := AResource + '/' + ABackendCollectionName
    else
      FRequest.Resource := AResource;

    FRequest.AddBody(LJSON);
    FRequest.Execute;
    CheckForResponseError;

    LResponse := FRequest.Response.JSONValue as TJSONObject;
    ANewObject := ObjectIDFromObject(ABackendCollectionName, LResponse);
  finally
    if (LJSON <> AACL) and (LJSON <> AJSON) then
      LJSON.Free;
  end;
end;

procedure TKinveyApi.PutObject(const AResource, ABackendCollectionName, AObjectID: string; const AJSON: TJSONObject; out AObject: TObjectID; AReset: Boolean);
begin
  PutObject(AResource, ABackendCollectionName, AObjectID, nil, AJSON, AObject, AReset);
end;

procedure TKinveyApi.PutObject(const AResource, ABackendCollectionName, AObjectID: string; const AACL, AJSON: TJSONObject; out AObject: TObjectID; AReset: Boolean);
var
  LResponse: TJSONObject;
  LJSON: TJSONObject;
begin
  CheckJSONObject(AJSON);
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameter;
  end;

  LJSON := nil;
  try
    if (AACL <> nil) and (AJSON <> nil) then
    begin
      LJSON := AJSON.Clone as TJSONObject;
      LJSON.AddPair('_acl', AACL.Clone as TJSONObject);             // Do not localize
    end
    else if AACL <> nil then
      LJSON := AACL
    else
      LJSON := AJSON;
    FRequest.Method := TRESTRequestMethod.rmPUT;
    if ABackendCollectionName <> '' then
      FRequest.Resource := AResource+ '/' + ABackendCollectionName + '/' + AObjectID
    else
      FRequest.Resource := AResource+ '/' + AObjectID;

    FRequest.AddBody(LJSON);
    FRequest.Execute;
    CheckForResponseError;

    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AObject := ObjectIDFromObject(ABackendCollectionName, AObjectID, LResponse);
  finally
    if (LJSON <> AACL) and (LJSON <> AJSON) then
      LJSON.Free;
  end;
end;

procedure TKinveyApi.SetBaseURL(const Value: string);
begin
  FBaseURL := Value;
  FRESTClient.BaseURL := Value;
end;

procedure TKinveyApi.SetConnectionInfo(const Value: TConnectionInfo);
begin
  FConnectionInfo := Value;
  ApplyConnectionInfo;
end;

procedure TKinveyApi.UpdateAppData(const AObject: TObjectID; const AJSONObject: TJSONObject; out AUpdateObject: TObjectID);
begin
  UpdateAppData(AObject.BackendCollectionName, AObject.ObjectID, AJSONObject, AUpdateObject);
end;

//  PUT /appdata/:appKey/:collectionName/:id HTTP/1.1
//  Host: baas.kinvey.com
//  Authorization: [user credentials]
//  Content-Type: application/json
//
//  <JSON-Document-representing-Entity>
procedure TKinveyApi.UpdateAppData(const ABackendCollectionName, AObjectID: string; const AJSONObject: TJSONObject; out AUpdateObject: TObjectID);
begin
  CheckBackendCollectionName(ABackendCollectionName);
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameter;
  PutObject(sDataStoreAppKey, ABackendCollectionName, AObjectID, AJSONObject, AUpdateObject, False);
end;

function PlatformTypeToString(ADeviceType: TKinveyAPI.TPlatformType): string;
begin
  case ADeviceType of
    TKinveyAPI.TPlatformType.Android:
      Result := 'android';               // Do not localize
    TKinveyAPI.TPlatformType.IOS:
      Result := 'ios';                   // Do not localize
  else
    Assert(False);
  end;
end;


//POST /push/:appKey/register-device HTTP/1.1
//Host: baas.kinvey.com
//Authorization: [master credentials]
//Content-Type: application/json
//
//{
//  'platform': 'ios',
//  'deviceId': 'device ID goes here',
//  'userId': '5058c666474f050906000001'
//}
procedure TKinveyApi.PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID,
  AUserID: string);
var
  LJSONObject : TJSONObject;
begin
  FRequest.ResetToDefaults;
  if AUserId <> '' then
    AddAuthParameter(TAuthentication.MasterSecret)
  else
    AddAuthParameter(TAuthentication.UserName);
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sPushAppKey + '/' + sRegisterDevice;

  LJSONObject:= TJSONObject.Create;
  try
    LJSONObject.AddPair( 'platform', PlatformTypeToString(APlatformType));       // Do not localize
    LJSONObject.AddPair( 'deviceId', ADeviceID );                                // Do not localize
    if AUserId <> '' then
      LJSONObject.AddPair( 'userId', AUserId );                                  // Do not localize
    FRequest.AddBody(LJSONObject);
  finally
    LJSONObject.Free;
  end;

  FRequest.Execute;
  if FRequest.Response.StatusCode >= 300 then
    raise EKinveyAPIError.Create(FRequest.Response.StatusText);
end;

procedure TKinveyApi.PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string);
begin
  PushRegisterDevice(APlatformType, ADeviceID, '');
end;

procedure TKinveyApi.PushRegisterDevice(APlatformType: TPlatformType; const ADeviceID: string;
  const AUser: TUser);
begin
  PushRegisterDevice(APlatformType, ADeviceID, AUser.ObjectID);
end;

//
//POST /push/:appKey/unregister-device HTTP/1.1
//Host: baas.kinvey.com
//Authorization: [master credentials]
//Content-Type: application/json
//
//{
//  'platform': 'ios',
//  'deviceId': 'device ID goes here',
//  'userId': '5058c666474f050906000001'
//}
procedure TKinveyApi.PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID,
  AUserID: string);
var
  LJSONObject : TJSONObject;
begin
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sPushAppKey + '/' + sUnRegisterDevice;
  if AUserId <> '' then
    AddAuthParameter(TAuthentication.MasterSecret)
  else
    AddAuthParameter(TAuthentication.UserName);

  LJSONObject:= TJSONObject.Create;
  try
    LJSONObject.AddPair( 'platform', PlatformTypeToString(APlatformType));       // Do not localize
    LJSONObject.AddPair( 'deviceId', ADeviceID );                                // Do not localize
    if AUserId <> '' then
      LJSONObject.AddPair( 'userId', AUserId );                                  // Do not localize

    FRequest.AddBody(LJSONObject);
  finally
    LJSONObject.Free;
  end;

  FRequest.Execute;
  if FRequest.Response.StatusCode >= 300 then
    raise EKinveyAPIError.Create(FRequest.Response.StatusText);
end;

procedure TKinveyApi.PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string);
begin
  PushUnregisterDevice(APlatformType, ADeviceID, '');
end;

procedure TKinveyApi.PushUnregisterDevice(APlatformType: TPlatformType; const ADeviceID: string;
  const AUser: TUser);
begin
  PushUnregisterDevice(APlatformType, ADeviceID, AUser.ObjectID);
end;

procedure TKinveyApi.QueryAppData(const ABackendCollectionName: string; const AQuery: array of string; const AJSONArray: TJSONArray;
  out AObjects: TArray<TObjectID>);
var
  LJSONValue: TJSONValue;
  LList: TList<TObjectID>;
  LObjectID: TObjectID;
begin
  QueryAppData(ABackendCollectionName, AQuery, AJSONArray);
  LList := TList<TObjectID>.Create;
  try
    for LJSONValue in AJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LObjectID := ObjectIDFromObject(ABackendCollectionName, TJSONObject(LJSONValue));
        LList.Add(LObjectID);
      end
      else
        raise EKinveyAPIError.Create(sJSONObjectExpected);
    end;
    AObjects := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure TKinveyApi.QueryResource(const AResource: string; const AQuery: array of string; const AJSONArray: TJSONArray;
  AReset: Boolean);
var
  LRoot: TJSONArray;
  S: String;
  I: Integer;
  LTrim: string;
  LJSONValue: TJSONValue;
begin
  if AReset then
  begin
    FRequest.ResetToDefaults;
    AddAuthParameter;
  end;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := AResource;

  for S in AQuery do
  begin
    LTrim := Trim(S);
    if LTrim = '' then
      continue;
    I := LTrim.IndexOf('=');
    if I > 0 then
      FRequest.AddParameter(S.Substring(0, I).Trim, S.Substring(I+1).Trim);
  end;

  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if AJSONArray <> nil then
    if FRequest.Response.StatusCode <> 404 then
    begin
      LRoot := FRequest.Response.JSONValue as TJSONArray;
      for LJSONValue in LRoot do
        AJSONArray.AddElement(TJSONValue(LJSONValue.Clone))
    end;
end;

procedure TKinveyApi.QueryAppData(const ABackendCollectionName: string; const AQuery: array of string; const AJSONArray: TJSONArray);
var
  LResource: string;
begin
  CheckBackendCollectionName(ABackendCollectionName);
  FRequest.ResetToDefaults;
  AddAuthParameter;
  LResource := sDataStoreAppKey + '/' + ABackendCollectionName + '/';
  QueryResource(LResource, AQuery, AJSONArray, False);
end;

function TKinveyApi.DeleteFile(const AFile: TFile): Boolean;
begin
  Result := DeleteFile(AFile.ID);
end;

function TKinveyApi.DeleteFile(const AFileID: string): Boolean;
begin
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := sBlob + '/' + FConnectionInfo.AppKey + '/{fileId}';                         // Do not localize
  FRequest.AddParameter( 'fileId', AFileID, TRESTRequestParameterKind.pkURLSEGMENT );              // Do not localize

  AddAuthParameter;
  FRequest.Execute;
  CheckForResponseError([404]);
  Result := FRequest.Response.StatusCode <> 404
end;

procedure TKinveyApi.DownloadFile(const AFile: TFile; const AStream: TStream);
var
  LDownloadURL : string;
  LRequest : TRESTRequest;
  LClient : TRESTClient;
  LResponseObject: TJSONObject;
  LJSONValue: TJSONValue;
begin
  /// downloading files from kiney needs two steps:
  ///
  /// (1) sending an "download-request" to kinvey
  /// this step justs requests an download-url
  /// where the actual file-content can be
  /// downloaded from. this first step /does not/
  /// contain the content of the file.
  ///
  /// (2) receiving the actual file-content from
  /// the download-url received in step #1
  ///
  /// ** please note: currently (2014) kinvey makes
  /// use of "GoogleCloudStorage" for file-storage

  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sBlobAppKey + '/{fileId}';                                               // Do not localize
  FRequest.AddParameter( 'fileId', AFile.ID, TRESTRequestParameterKind.pkURLSEGMENT );          // Do not localize

  AddAuthParameter;
  FRequest.Execute;
  // a very common exception can be "404 - file not found"
  if FRequest.Response.StatusCode = 404 then
    raise  CreateException(FRequest, EKinveyFileNotFound);

  CheckForResponseError;

  LResponseObject := FRequest.Response.JSONValue as TJSONObject;
  LJSONValue := LResponseObject.GetValue('_downloadURL');                                          // Do not localize
  if LJSONValue <> nil then
    LDownloadURL := LJSONValue.Value;

  LClient:= TRESTClient.Create( LDownloadURL );
  LRequest:= TRESTRequest.Create(LClient);
  try
    LClient.FallbackCharsetEncoding := REST_NO_FALLBACK_CHARSET;
    LRequest.URLAlreadyEncoded := true;
    LRequest.Method := TRESTRequestMethod.rmGET;
    LRequest.Params.CreateGetParamsFromUrl( LDownloadURL );
    LRequest.Execute;
    if LRequest.Response.StatusCode < 400 then
      AStream.Write(LRequest.Response.RawBytes, 0, Length(LRequest.Response.RawBytes));
  finally
    LRequest.Free;
    LClient.Free;
  end;
end;

procedure TKinveyApi.UploadFile(const AFileName: string; AContentType: string; APublic: Boolean; const AUserFields: TJSONObject; out ANewFile: TFile);
var
  LStream: TFileStream;
begin
  LStream := TFileStream.Create(AFileName, 0);
  try
    UploadFile(AFileName, LStream, AContentType, APublic, AUserFields, ANewFile);
  finally
    LStream.Free;
  end;
end;

procedure TKinveyApi.UploadFile(const AFileName: string; const AStream: TStream; AContentType: string; APublic: Boolean; const AUserFields: TJSONObject; out ANewFile: TFile);
var
  LJSONValue: TJSONValue;
  LUploadURL: string;
  LJSON: TJsonObject;
  LRequest : TRESTRequest;
  LClient : TRESTClient;
  LResponseObject: TJSONObject;
  LRequiredHeaders: TJsonObject;
  LHeader: TJSONPair;
  LContentType: TRESTContentType;
begin
  /// uploading files to kiney needs two steps:
  ///
  /// (1) sending an "upload-request" to kinvey
  /// this step justs requests an upload-url
  /// where the actual file-content can be
  /// uploaded to. this first step /does not/
  /// contain the content of the file.
  ///
  /// (2) sending the actual file-content to the
  /// upload-url received in step #1
  ///
  /// ** please note: currently (2014) kinvey makes
  /// use of "GoogleCloudStorage" for file-storage


  FRequest.ResetToDefaults;
  AddAuthParameter;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sBlob + '/' + FConnectionInfo.AppKey;  //'blob/{appKey}';
  if AContentType = '' then
    LContentType := TRESTContentType.ctAPPLICATION_OCTET_STREAM
  else
    LContentType :=  ContentTypeFromString(AContentType);
  FRequest.AddParameter('X-Kinvey-Content-Type',// Do not localize
      ContentTypeToString(LContentType),          
      TRESTRequestParameterKind.pkHTTPHEADER, [TRESTRequestParameterOption.poDoNotEncode]);
  // prepare meta-data
  if AUserFields <> nil then
    LJSON := AUserFields.Clone as TJSONObject
  else
    LJSON := TJsonObject.Create;
  try
    LJSON.AddPair('_filename', AFileName);                                             // Do not localize
    if APublic then
      LJSON.AddPair('_public', TJSONTrue.Create);                                     // Do not localize
    LJSON.AddPair('size', TJSONNumber.Create(AStream.Size));
    FRequest.AddBody(LJSON);
  finally
    LJSON.Free;
  end;
  FRequest.Execute;

  CheckForResponseError;

  LResponseObject := FRequest.Response.JSONValue as TJSONObject;
  ANewFile := FileFromObject(AFileName, LResponseObject);
  LJSONValue := LResponseObject.GetValue('_uploadURL');                                  // Do not localize
  if LJSONValue <> nil then
    LUploadURL := LJSONValue.Value;
  Assert(LUploadURL <> '');

  // Kinvey tells us what headers to send with the upload
  LJSONValue := LResponseObject.GetValue('_requiredHeaders');                          // Do not localize
  if LJSONValue <> nil then
    LRequiredHeaders := LJSONValue as TJSONObject
  else
    LRequiredHeaders := nil;

  // now send the file-content to the upload-url
  LClient:= TRESTClient.Create( LUploadURL );
  LRequest:= TRESTRequest.Create(LClient);
  try
    LClient.ProxyServer := FRESTClient.ProxyServer;
    LClient.ProxyPort := FRESTClient.ProxyPort;
    LClient.ProxyUsername := FRESTClient.ProxyUsername;
    LClient.ProxyPassword := FRESTClient.ProxyPassword;
    LRequest.URLAlreadyEncoded := true;
    LRequest.Method := TRESTRequestMethod.rmPUT;
    LRequest.AddBody(AStream, LContentType);

    if LRequiredHeaders <> nil then
      for LHeader in LRequiredHeaders do
        LRequest.AddParameter(LHeader.JsonString.Value, LHeader.JsonValue.Value, TRESTRequestParameterKind.pkHTTPHEADER);

    LRequest.Execute;
    CheckForResponseError(LRequest);
  finally
    LRequest.Free;
    LClient.Free;
  end;
end;

function TKinveyAPI.DeleteOrSuspendUser(const AObjectID: string; ADelete: Boolean): Boolean;
begin
  FRequest.ResetToDefaults;
  AddAuthParameter;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := sUserAppKey + '/{userId}';    // do not localize
  FRequest.AddParameter('userId', AObjectID, TRESTRequestParameterKind.pkURLSEGMENT);      // Do not localize

  if ADelete then
    FRequest.AddParameter('hard', 'true', TRESTRequestParameterKind.pkGETorPOST)           // Do not localize
  else
    FRequest.AddParameter('soft', 'true', TRESTRequestParameterKind.pkGETorPOST);          // Do not localize

  FRequest.Execute;

  CheckForResponseError([404]);
  Result := FRequest.Response.StatusCode <> 404
end;

function TKinveyAPI.DeleteUser(const AObjectID: string): Boolean;
begin
  Result := DeleteOrSuspendUser(AObjectID, True);
end;

function TKinveyAPI.DeleteUser(const AUser: TUser): Boolean;
begin
  Result := DeleteOrSuspendUser(AUser.FObjectID, True);
end;

function TKinveyAPI.SuspendUser(const AObjectID: string): Boolean;
begin
  Result := DeleteOrSuspendUser(AObjectID, False);
end;

function TKinveyAPI.SuspendUser(const AUser: TUser): Boolean;
begin
  Result := DeleteOrSuspendUser(AUser.FObjectID, False);
end;

procedure TKinveyApi.UpdateUser(const AObjectID: string;
  const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
begin
  FRequest.ResetToDefaults;
  AddAuthParameter;
  FRequest.Method := TRESTRequestMethod.rmPUT;
  FRequest.Resource := sUserAppKey + '/{userId}';    // do not localize                       // Do not localize
  FRequest.AddParameter('userId', AObjectID, TRESTRequestParameterKind.pkURLSEGMENT);         // Do not localize
  FRequest.AddBody(AUserObject);

  FRequest.Execute;

  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AUpdatedAt := UpdatedAtFromObject(LResponse);
end;

procedure TKinveyApi.QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray);
var
  LResource: string;
begin
  LResource := sUserAppKey + '/';
   QueryResource(LResource, AQuery, AJSONArray, True);
end;

procedure TKinveyApi.QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AUsers: TArray<TUser>);
var
  LJSONValue: TJSONValue;
  LList: TList<TUser>;
  LUser: TUser;
  LResource: string;
begin
  LResource := sUserAppKey + '/';
  QueryResource(LResource, AQuery, AJSONArray, True);
  LList := TList<TUser>.Create;
  try
    for LJSONValue in AJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LUser := UserFromObject(TJSONObject(LJSONValue));
        LList.Add(LUser);
      end
      else
        raise EKinveyAPIError.Create(sJSONObjectExpected);
    end;
    AUsers := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure TKinveyApi.LoginUser(const AUserName, APassword: string; out ALogin: TLogin; const AJSON: TJSONArray; AProc: TLoginProc);
var
  LJSON : TJSONObject;
  LResponse: TJSONObject;
begin
  FRequest.ResetToDefaults;
  AddAuthParameter(TAuthentication.AppSecret); // Always use AppSecret
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUserAppKey + '/' + sLogin;     // do not localize
  LJSON:= TJSONObject.Create;
  try
    LJSON.AddPair('username', AUsername);   // do not localize
    LJSON.AddPair('password', APassword);   // do not localize
    FRequest.AddBody(LJSON);
  finally
    LJSON.Free;
  end;

  FRequest.Execute;
  CheckForResponseError;

  LResponse := FRequest.Response.JSONValue as TJSONObject;
  ALogin :=  LoginFromObject(AUserName, LResponse);
  if Assigned(AJSON) then
    AJSON.AddElement(LResponse.Clone as TJSONObject);
  if Assigned(AProc) then
    AProc(ALogin, LResponse);
end;

procedure TKinveyApi.LoginUser(const AUserName, APassword: string; out ALogin: TLogin; const AJSON: TJSONArray);
begin
  LoginUser(AUserName, APassword, ALogin, AJSON, nil);
end;

procedure TKinveyApi.LoginUser(const AUserName, APassword: string; AProc: TLoginProc);
var
  LLogin: TLogin;
begin
  LoginUser(AUserName, APassword, LLogin, nil, AProc);
end;

procedure TKinveyApi.Logout;
begin
  FSessionAuthToken := '';
  if FAuthentication = TAuthentication.Session then
    FAuthentication := TAuthentication.Default;
end;

//POST /user/:appKey/_logout HTTP/1.1
//X-Kinvey-Api-Version: 1
//Authorization: Kinvey [auth token]
procedure TKinveyApi.LogoutUser;
begin
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUserAppKey + '/_logout';  // Do not localize
  AddAuthParameter(TAuthentication.Session); // Required

  FRequest.Execute;
  CheckForResponseError;
  FSessionAuthToken := ''; // No longer valid
end;

//POST /user/:appKey/:id/_restore HTTP/1.1
//Host: baas.kinvey.com
//Authorization: [master secret]
//X-Kinvey-API-Version: 1
procedure TKinveyApi.RestoreSuspendedUser(const AObjectID: string);
begin
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUserAppKey + '/' + AObjectID + '/_restore';  // Do not localize
  AddAuthParameter(TAuthentication.MasterSecret); // Required

  FRequest.Execute;
  CheckForResponseError;
end;

procedure TKinveyApi.RestoreSuspendedUser(const AUser: TUser);
begin
  RestoreSuspendedUser(AUser.ObjectID);
end;

//  POST /user/:appKey/ HTTP/1.1
//  Host: baas.kinvey.com
//  Authorization: [Basic Auth with app credentials]
//  Content-Type: application/json
//
//  [optional body]
procedure TKinveyApi.SignupUser(const AUserName, APassword: string;
  const AUserFields: TJSONObject; out ALogin: TLogin);
var
  LJSON : TJSONObject;
  LResponse: TJsonObject;
begin
  FRequest.ResetToDefaults;
  AddAuthParameter(TAuthentication.AppSecret);  //  Required

  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := sUserAppKey;
  if AUserFields <> nil then
    LJSON := AUserFields.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('username', AUserName);   // do not localize
    LJSON.AddPair('password', APassword);   // do not localize
    FRequest.AddBody(LJSON);
  finally
    LJSON.Free;
  end;

  FRequest.Execute;
  CheckForResponseError([409]);
  if FRequest.Response.StatusCode = 409 then
    raise CreateException(FRequest, EKinveyDuplicateUser);


  LResponse := FRequest.Response.JSONValue as TJsonObject;
  ALogin := LoginFromObject(AUserName, LResponse);
end;

function TKinveyApi.QueryUserName(const AUserName: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean;
var
  LUsers: TJSONArray;
  LUserObject: TJSONObject;
begin
  FRequest.ResetToDefaults;
  AddAuthParameter;
  FRequest.Method := TRESTRequestMethod.rmGET;
  // Closing '/' required
  FRequest.Resource := sUserAppKey + '/';
  FRequest.AddParameter('query', '{"username":"'+AUserName+'"}', TRESTRequestParameterKind.pkGETorPOST); // Do not localize

  FRequest.Execute;

  CheckForResponseError;
  LUsers := FRequest.Response.JSONValue as TJSONArray;
  if LUsers.Count > 1 then
    raise EKinveyAPIError.Create(sOneUserExpected);
  Result := LUsers.Count = 1;
  if Result then
  begin
    LUserObject := LUsers.Items[0] as TJSONObject;
    AUser := UserFromObject(LUserObject);
    if Assigned(AJSON) then
      AJSON.AddElement(LUserObject.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUser, LUserObject);
  end;
end;

function TKinveyApi.QueryUserName(const AUserName: string;
  AProc: TQueryUserNameProc): Boolean;
var
  LUser: TUser;
begin
  Result := QueryUserName(AUserName, LUser, nil, AProc);
end;

function TKinveyApi.QueryUserName(const AUserName: string; out AUser: TUser;
  const AJSON: TJSONArray): Boolean;
begin
  Result := QueryUserName(AUserName, AUser, AJSON, nil);
end;

function TKinveyApi.RetrieveUser(const AObjectID: string; out AUser: TUser; const AJSON: TJSONArray; AProc: TRetrieveUserProc): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameter;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sUserAppKey + '/{userId}';    // do not localize
  FRequest.AddParameter('userId', AObjectID, TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AUser := UserFromObject(LResponse);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUser, LResponse);
  end
end;

function TKinveyApi.RetrieveUser(const AObjectID: string; AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser(AObjectID, LUser, nil, AProc);
end;

function TKinveyApi.RetrieveUser(const AUser: TUser; out AFoundUser: TUser;
  const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser(AUser.ObjectID, AFoundUser, AJSON, nil);
end;

function TKinveyApi.RetrieveUser(const AUser: TUser; AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser(AUser.ObjectID, LUser, nil, AProc);
end;

function TKinveyApi.RetrieveUser(const AObjectID: string; out AUser: TUser; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser(AObjectID, AUser, AJSON, nil);
end;

function TKinveyAPI.RetrieveCurrentUser(AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser('_me', LUser, nil, AProc);    // Do not localize
end;


function TKinveyAPI.RetrieveCurrentUser(out AUser: TUser; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser('_me', AUser, AJSON, nil);    // Do not localize
end;


procedure TKinveyApi.QueryFiles(const AQuery: array of string; const AJSONArray: TJSONArray);
var
  LResource: string;
begin
  LResource :=  sBlobAppKey;
  QueryResource(LResource, AQuery, AJSONArray, True);
end;

procedure TKinveyApi.QueryFiles(const AQuery: array of string; const AJSONArray: TJSONArray; out AFiles: TArray<TFile>);
var
  LJSONValue: TJSONValue;
  LList: TList<TFile>;
  LFile: TFile;
  LResource: string;
begin
  LResource :=  sBlobAppKey;
  QueryResource(LResource, AQuery, AJSONArray, True);
  LList := TList<TFile>.Create;
  try
    for LJSONValue in AJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LFile := FileFromObject(TJSONObject(LJSONValue));
        LList.Add(LFile);
      end
      else
        raise EKinveyAPIError.Create(sJSONObjectExpected);
    end;
    AFiles := LList.ToArray;
  finally
    LList.Free;
  end;
end;

function TKinveyApi.RetrieveFile(const AFileID: string; out AFile: TFile; const AJSON: TJSONArray; AProc: TRetrieveFileProc): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckObjectID(AFileID);
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sBlobAppKey + '/{Id}';    // do not localize
  FRequest.AddParameter('Id', AFileID, TRESTRequestParameterKind.pkURLSEGMENT);
  AddAuthParameter;
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AFile := FileFromObject(LResponse);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AFile, LResponse);
  end
end;

function TKinveyApi.RetrieveFile(const AFileID: string; AProc: TRetrieveFileProc): Boolean;
var
  LFile: TFile;
begin
  Result := RetrieveFile(AFileID, LFile, nil, AProc);
end;

function TKinveyApi.RetrieveFile(const AFile: TFile; AProc: TRetrieveFileProc): Boolean;
var
  LFile: TFile;
begin
  Result := RetrieveFile(AFile.ID, LFile, nil, AProc);
end;

function TKinveyApi.RetrieveFile(const AFileID: string; out AFile: TFile; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveFile(AFileID, AFile, AJSON, nil);
end;

function TKinveyApi.RetrieveFile(const AFile: TFile; out AFoundFile: TFile; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveFile(AFile.ID, AFoundFile, AJSON, nil);
end;

{ User groups }

// AID may be blank, to generate id
procedure TKinveyApi.CreateUserGroup(const AID: string; const AUsersAndGroups: TJSONObject; out ANewUserGroup: TUserGroup);
begin
  CreateUserGroup(AID, nil, AUsersAndGroups, ANewUserGroup);
end;

procedure TKinveyApi.CreateUserGroup(const AID: string; const AACL, AUsersAndGroups: TJSONObject; out ANewUserGroup: TUserGroup);
var
  LNewObject: TObjectID;
  LJSON: TJSONObject;
begin
  LJSON := nil;
  try
    if AID <> '' then
    begin
      if AUsersAndGroups <> nil then
        LJSON := AUsersAndGroups.Clone as TJSONObject
      else
        LJSON := TJSONObject.Create;
      LJSON.AddPair('_id', AID);      // Do not localize
    end
    else
      LJSON := AUsersAndGroups;
    PostObject(sUserGroupAppKey, '', AACL, LJSON, LNewObject, True);
    ANewUserGroup.FObjectID := LNewObject.ObjectID;
  finally
    if LJSON <> AUsersAndGroups then
      LJSON.Free;
  end;
end;

procedure TKinveyApi.UpdateUserGroup(const AID: string; const AUsersAndGroups: TJSONObject; out AUpdateObject: TObjectID);
begin
  CheckObjectID(AID);
  FRequest.ResetToDefaults;
  AddAuthParameter;
  PutObject(sUserGroupAppKey, '', AID, AUsersAndGroups, AUpdateObject, False);
end;

procedure TKinveyApi.UpdateUserGroup(const AUserGroup: TUserGroup; const AUsersAndGroups: TJSONObject; out AUpdateObject: TObjectID);
begin
  UpdateUserGroup(AUserGroup.ObjectID, AUsersAndGroups, AUpdateObject);
end;

function TKinveyApi.DeleteUserGroup(const AUserGroup: TUserGroup): Boolean;
begin
  Result := DeleteUserGroup(AUserGroup.ObjectID);
end;

function TKinveyApi.DeleteUserGroup(const AID: string): Boolean;
begin
  FRequest.ResetToDefaults;
  AddAuthParameter;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := sUserGroupAppKey + '/{Id}';    // do not localize
  FRequest.AddParameter('Id', AID, TRESTRequestParameterKind.pkURLSEGMENT);      // Do not localize

  FRequest.Execute;

  CheckForResponseError([404]);
  Result := FRequest.Response.StatusCode <> 404
end;


function TKinveyApi.RetrieveUserGroup(const AObjectID: string; out AUserGroup: TUserGroup; const AJSON: TJSONArray; AProc: TRetrieveUserGroupProc): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckObjectID(AObjectID);
  FRequest.ResetToDefaults;
  AddAuthParameter;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := sUserGroupAppKey + '/{Id}';    // do not localize
  FRequest.AddParameter('Id', AObjectID, TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AUserGroup := UserGroupFromObject('', LResponse);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AUserGroup, LResponse);
  end
end;

function TKinveyApi.RetrieveUserGroup(const AObjectID: string; AProc: TRetrieveUserGroupProc): Boolean;
var
  LUser: TUserGroup;
begin
  Result := RetrieveUserGroup(AObjectID, LUser, nil, AProc);
end;

function TKinveyApi.RetrieveUserGroup(const AUserGroup: TUserGroup; out AFoundUserGroup: TUserGroup;
  const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUserGroup(AUserGroup.ObjectID, AFoundUserGroup, AJSON, nil);
end;

function TKinveyApi.RetrieveUserGroup(const AUserGroup: TUserGroup; AProc: TRetrieveUserGroupProc): Boolean;
var
  LUser: TUserGroup;
begin
  Result := RetrieveUserGroup(AUserGroup.ObjectID, LUser, nil, AProc);
end;

function TKinveyApi.RetrieveUserGroup(const AObjectID: string; out AUserGroup: TUserGroup; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUserGroup(AObjectID, AUserGroup, AJSON, nil);
end;

function ValueToJsonValue(AValue: TValue): TJSONValue;
begin
  if AValue.IsType<Int64> then
    Result := TJSONNumber.Create(AValue.AsInt64)
  else if AValue.IsType<Extended> then
    Result := TJSONNumber.Create(AValue.AsExtended)
  else if AValue.IsType<string> then
    Result := TJSONString.Create(AValue.AsString)
  else
    Result := TJSONString.Create(AValue.ToString)
end;


{ TKinveyAPI.TKinveyConnectionInfo }

constructor TKinveyAPI.TConnectionInfo.Create(const AApiVersion, AAppKey: string);
begin
  ApiVersion := AApiVersion;
  AppKey := AAppKey;
end;

{ TObjectID }

constructor TKinveyAPI.TObjectID.Create(const ABackendCollectionName: string; AObjectID: string);
begin
  FBackendCollectionName := ABackendCollectionName;
  FObjectID := AObjectID;
end;

{ TKinveyApi.TFile}

constructor TKinveyApi.TFile.Create(const AID: string);
begin
  FID := AID;
end;

{ TKinveyApi.TUserID }

constructor TKinveyApi.TUser.Create(const AUserName: string);
begin
  FUserName := AUserName;
end;

{ TKinveyApi.TLogin }

constructor TKinveyApi.TLogin.Create(const AAuthToken: string;
  const AUser: TUser);
begin
  FAuthToken := AAuthToken;
  FUser := AUser;
end;

{ TKinveyApi.TUpdatedAt }

constructor TKinveyApi.TUpdatedAt.Create(AUpdatedAt: TDateTime);
begin
  FUpdatedAt := AUpdatedAt;
end;

{ EKinveyAPIError }

constructor EKinveyAPIError.Create(const AError, ADescription: string);
begin
  FDescription := ADescription;
  FError := AError;
  inherited CreateFmt(sFormatKinveyError, [Self.Error, Self.Description]);
end;

end.
