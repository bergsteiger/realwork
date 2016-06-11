{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit REST.Backend.EMSApi;

{$SCOPEDENUMS ON}

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.JSON,
  REST.Client, REST.Types, System.Net.URLClient;

type

  EEMSClientAPIError = class;
  EEMSClientHTTPError = class;
  TEMSClientHTTPErrorClass = class of EEMSClientHTTPError;

  /// <summary>
  /// <para>
  /// TEMSClientAPI implements REST requests to the EMS server
  /// </para>
  /// </summary>
   TEMSClientAPI = class(TComponent)
   public type

    TConnectionInfo = record
    public
      ApiVersion: string;
      ApplicationId: string;
      AppSecret: string;
      MasterSecret: string;
      UserName: string;
      Password: string;
      ProxyPassword: string;
      ProxyPort: Integer;
      ProxyServer: string;
      ProxyUsername: string;
      BaseURL: string;
      LoginResource: string;
      OnValidateCertificate: TValidateCertificateEvent;
    end;

    THeaderNames = record
    public const
      ApiVersion = 'X-Embarcadero-Api-Version';
      ApplicationId = 'X-Embarcadero-Application-Id';
      SessionToken = 'X-Embarcadero-Session-Token';
      MasterSecret = 'X-Embarcadero-Master-Secret';
      AppSecret = 'X-Embarcadero-App-Secret';
    end;

    TJSONNames = record
    public const
      UserName = 'username';
      Password = 'password';
      SessionToken = 'sessionToken';
      Error = 'error';
      Description = 'description';
      UserID = '_id';
      GroupName = 'groupname';
      InstallationID = '_id';
      MetaData = '_meta';
      MetaCreated = 'created';
      MetaUpdated = 'updated';
      MetaCreator = 'creator';
      PushWhere = 'where';
      PushChannels = 'channels';
      PushData = 'data';
      PushBadge = 'badge';
      FieldName = 'name';
      FieldCustom = 'custom';
      FieldFields = 'fields';
      ModuleID = '_id';
      ResourceModuleID = 'moduleid';
      ModuleName = 'modulename';
      Protocol = 'protocol';
      ResourceName = 'resourcename';
      ProtocolProps = 'protocolprops';
      Resources = 'resources';
    end;

    TSegmentNames = record
    public const
      Users = 'users';
      UsersFields = 'users/fields';
      Groups = 'groups';
      GroupsFields = 'groups/fields';
      Installations = 'installations';
      InstallationsChannels = 'installations/channels';
      InstallationsFields = 'installations/fields';
      Login = 'login';
      Signup = 'signup';
      Logout = '_logout';
      Restore = '_restore';
      Me = 'me';
      Push = 'push';
      Modules = 'edgemodules';
      ModulesResources = 'edgemodules/resources';
      ModulesFields = 'edgemodules/fields';
      ResourcesFields = 'edgemodules/resources/fields';
      Resources = 'resources';
    end;

    TQueryParamNames = record
    public const
      Order = 'order';
      Where = 'where';
      Limit = 'limit';
      Skip = 'skip';
    end;

    TUpdatedAt = record
    private
      FUpdatedAt: TDateTime;
    public
      constructor Create(AUpdatedAt: TDateTime);
      property UpdatedAt: TDateTime read FUpdatedAt;
    end;

    TUser = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FUserID: string;
      FUserName: string;
      FCreator: string;
    public
      constructor Create(const AUserName: string; const AUserID: string = '');
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property UserID: string read FUserID;
      property UserName: string read FUserName;
      property Creator: string read FCreator;
    end;

    TGroup = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FGroupName: string;
      FCreator: string;
    public
      constructor Create(const AGroupName: string);
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property GroupName: string read FGroupName;
      property Creator: string read FCreator;
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

    TInstallation = record
    private
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FInstallationID: string;
      FCreator: string;
    public
      constructor Create(const AInstallationID: string);
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property InstallationID: string read FInstallationID;
      property Creator: string read FCreator;
    end;

    TModule = record
    private
      FModuleID: string;
      FModuleName: string;
      FProtocol: string;
      FProtocolProps: string;
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FCreator: string;
    public
      constructor Create(const AModuleID, AName: string);
      property ModuleID: string read FModuleID;
      property ModuleName: string read FModuleName;
      property Protocol: string read FProtocol;
      property ProtocolProps: string read FProtocolProps;
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property Creator: string read FCreator;
    end;

    TModuleResource = record
    private
      FResourceName: string;
      FModuleName: string;
      FModuleID: string;
      FCreatedAt: TDateTime;
      FUpdatedAt: TDateTime;
      FCreator: string;
    public
      constructor Create(const AName, AModuleID, AModuleName: string);
      property ResourceName: string read FResourceName;
      property ModuleName: string read FModuleName;
      property ModuleID: string read FModuleID;
      property CreatedAt: TDateTime read FCreatedAt;
      property UpdatedAt: TDateTime read FUpdatedAt;
      property Creator: string read FCreator;
    end;

    TResourcePair = TPair<string, TJSONObject>;
    TResourceList = TArray<TResourcePair>;

    TDeviceTypes = record
    public
      const IOS = 'ios';
      const Android = 'android';
    end;

    TPushStatus = record
    private
      FAndroid: Integer;
      FIOS: Integer;
    public
      constructor Create(AIOS, AAndroid: Integer);
      property QueuedIOS: Integer read FIOS;
      property QueuedAndroid: Integer read FAndroid;
    end;

    TCreatorNames = record
    public
      const Master = '00000000-0000-0000-0000-000000000001';
      const Null =   '00000000-0000-0000-0000-000000000000';
    end;

    TAuthentication = (Default, MasterSecret, AppSecret, Session, None);
    TDefaultAuthentication = (AppSecret, MasterSecret, Session, None);

    // TFindObjectProc = reference to procedure(const AID: TObjectID; const AObj: TJSONObject);
    TAppHandshakeProc = reference to procedure(const AObj: TJSONObject);
    TQueryUserNameProc = reference to procedure(const AUser: TUser;
      const AObj: TJSONObject);
    TLoginProc = reference to procedure(const ALogin: TLogin;
      const AObj: TJSONObject);
    TRetrieveUserProc = reference to procedure(const AUser: TUser;
      const AObj: TJSONObject);
    TRetrieveGroupProc = reference to procedure(const AGroup: TGroup;
      const AObj: TJSONObject);
    TRetrieveInstallationProc = reference to procedure(const AInstallation: TInstallation;
      const AObj: TJSONObject);
    TRetrieveModuleProc = reference to procedure(const AModule: TModule;
      const AObj: TJSONObject);
    TRetrieveModuleResourceProc = reference to procedure(const AResource: TModuleResource;
      const AObj: TJSONObject);
    TQueryModuleNameProc = reference to procedure(const AModule: TModule;
      const AObj: TJSONObject);

  public const
    DateTimeIsUTC = True;
  public
    class var EmptyConnectionInfo: TConnectionInfo;
  public const
    cDefaultApiVersion = '1';
  private
    FRESTClient: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRESTResponse;
    FOwnsResponse: Boolean;
    FConnectionInfo: TConnectionInfo;
    FSessionAuthToken: string;
    FAuthentication: TAuthentication;
    FDefaultAuthentication: TDefaultAuthentication;
    procedure SetConnectionInfo(const Value: TConnectionInfo);
    function GetLoggedIn: Boolean;
  protected
    procedure AddAuthHeader(const ARequest: TCustomRESTRequest; const AKey,
      AValue: string);
    function MakeLoginResource(const ASegmentName: string): string; inline;
    function MetaDataFromObject(const AJSONObject: TJSONObject; out ACreatedAt,
      AUpdatedAt: TDateTime; out ACreator: string): Boolean;
    function DeleteResource(const AResource, AID: string; const AAddParameters: TProc = nil): Boolean;
    procedure PutResource(const AResource, AID: string;
      const AJSON: TJSONObject; const AAddParameters: TProc = nil);
    procedure AddResource(const AResource: string; const AJSON: TJSONObject; const AAddParameters: TProc = nil);
    procedure QueryResource(const AResource: string;
      const AQuery: array of string; const AJSONArray: TJSONArray;
      AReset: Boolean; const AAddParameters: TProc = nil);
    function RetrieveInstallation(const AInstallationID: string; out AFoundInstallation: TInstallation;
      const AJSON: TJSONArray; AProc: TRetrieveInstallationProc;
      AReset: Boolean): Boolean; overload;
    procedure AddAppSecret(const ARequest: TCustomRESTRequest; const AKey: string);
     /// <summary>Gets actual Authentication and adds it to the request. </summary>
    procedure DoAddAuthParameters; overload;
    /// <summary>Adds authentication parameters to the request. </summary>
    /// <param name="AAuthentication">Authentication type: AppSecret, MasterSecret, Session, None</param>
    procedure DoAddAuthParameters(AAuthentication: TAuthentication); overload;
    /// <summary>Adds authentication parameters to the request. </summary>
    /// <param name="ARequest">The Request</param>
    /// <param name="AAuthentication">Authentication type: AppSecret, MasterSecret, Session, None</param>
    procedure DoAddAuthParameters(const ARequest: TCustomRESTRequest; AAuthentication: TAuthentication); overload;
    procedure AddMasterKey(const ARequest: TCustomRESTRequest; const AKey: string);
    procedure AddSessionToken(const ARequest: TCustomRESTRequest; const AAppSecret, ASessionToken: string);
    function GetActualAuthentication: TAuthentication;
    function CreateHTTPException(const AResponse: TCustomRESTResponse;
      const AClass: TEMSClientHTTPErrorClass): EEMSClientHTTPError; overload;
    function CreateHTTPException(const AResponse: TCustomRESTResponse): EEMSClientHTTPError; overload;
    procedure CheckForResponseError; overload;
    procedure CheckForResponseError(AValidStatusCodes: array of Integer); overload;
    function LoginFromObject(const AUserName: string;
      const AJSONObject: TJSONObject): TLogin;
    procedure LoginUser(const AUserName, APassword: string; out ALogin: TLogin;
      const AJSON: TJSONArray; AProc: TLoginProc); overload;
    function QueryUserName(const AUserName: string; out AUser: TUser;
      const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean; overload;
    function UpdatedAtFromObject(const AJSONObject: TJSONObject): TUpdatedAt;
    function UserFromObject(const AUserName: string;
      const AJSONObject: TJSONObject): TUser; overload;
    function RetrieveUser(const AObjectID: string; out AUser: TUser;
      const AJSON: TJSONArray; AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveGroup(const AGroupName: string; out AGroup: TGroup;
      const AJSON: TJSONArray; AProc: TRetrieveGroupProc): Boolean; overload;
    function RetrieveModule(const AModuleID: string; out AModule: TModule;
      const AJSON: TJSONArray; AProc: TRetrieveModuleProc): Boolean; overload;
    function RetrieveModuleResource(const AModuleID, AResourceName: string; out AResource: TModuleResource;
      const AJSON: TJSONArray; AProc: TRetrieveModuleResourceProc): Boolean; overload;
    function GroupFromObject(const AGroupName: string;
      const AJSONObject: TJSONObject): TGroup; overload;
    function GroupFromObject(const AJSONObject: TJSONObject): TGroup; overload;
    function InstallationFromObject(const AInstallationID: string;
      const AJSONObject: TJSONObject): TInstallation; overload;
    function InstallationFromObject(const AJSONObject: TJSONObject): TInstallation; overload;
    procedure ApplyConnectionInfo; overload;
    property RestClient: TRESTClient read FRESTClient;
    property Request: TRESTRequest read FRequest;
    procedure PushBody(const AMessage: TJSONObject); overload;
    procedure PushBody(const AMessage: TJSONObject; out AStatus: TPushStatus); overload;
    function PushStatusFromObject(
      const AJSONObject: TJSONObject): TPushStatus; overload;
    function CreateInstallationObject(const ADeviceType: string; const ADeviceToken: string; const AProperties: TJSONObject): TJSONObject; overload;
    function CreateInstallationObject(const ADeviceType: string; const ADeviceToken: string;  const AProperties: TJSONObject; AChannels: array of string): TJSONObject; overload;
    procedure RetrieveFields(const AResourceName: string;
      const AFields: TJSONArray);
    function ModuleFromObject(const AJSONObject: TJSONObject): TModule; overload;
    function ModuleFromObject(const AModuleID: string; const AJSONObject: TJSONObject): TModule; overload;
    function ResourceFromObject(const AJSONObject: TJSONObject): TModuleResource;
    function QueryModuleName(const AModuleName: string; out AModule: TModule;
      const AJSON: TJSONArray; AProc: TQueryModuleNameProc): Boolean; overload;
  public
    constructor Create; reintroduce; overload;
    constructor Create(AOwner: TComponent;
      const AResponse: TRESTResponse = nil); reintroduce; overload;
    destructor Destroy; override;
    procedure CheckForResponseError(const AResponse: TCustomRESTResponse; const AValidStatusCodes: array of Integer); overload;
    procedure CheckForResponseError(const AResponse: TCustomRESTResponse); overload;
    procedure ApplyConnectionInfo(const AClient: TCustomRESTClient); overload;
    procedure AddAuthParameters(const ARequest: TCustomRESTRequest); overload;
    // Utilities
    function UserFromObject(const AJSONObject: TJSONObject): TUser; overload;
    // Handshake
    procedure AppHandshake(const AJSONArray: TJSONArray); overload;
    procedure AppHandshake(const AProc: TAppHandshakeProc); overload;
    // Users
    function QueryUserName(const AUserName: string; AProc: TQueryUserNameProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TUser;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const AUser: TUser; AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveUser(const AUser: TUser; out AFoundUser: TUser;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const AObjectID: string; out AUser: TUser;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveUser(const AObjectID: string; AProc: TRetrieveUserProc): Boolean; overload;
    procedure SignupUser(const AUserName, APassword: string;
      const AUserFields: TJSONObject; out ALogin: TLogin);
    procedure AddUser(const AUserName, APassword: string;
      const AUserFields: TJSONObject; out AUser: TUser);
    procedure LoginUser(const AUserName, APassword: string;
      AProc: TLoginProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out ALogin: TLogin;
      const AJSON: TJSONArray = nil); overload;
    procedure LogoutUser;
    function RetrieveCurrentUser(AProc: TRetrieveUserProc): Boolean; overload;
    function RetrieveCurrentUser(out AUser: TUser;
      const AJSON: TJSONArray = nil): Boolean; overload;
    procedure UpdateUser(const AObjectID: string;
      const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    procedure UpdateUser(const AUser: TUser; const AUserObject: TJSONObject;
      out AUpdatedAt: TUpdatedAt); overload;
    function DeleteUser(const AObjectID: string): Boolean; overload;
    function DeleteUser(const AUser: TUser): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string;
      const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string;
      const AJSONArray: TJSONArray; out AUsers: TArray<TUser>); overload;
    procedure RetrieveUsersFields(const AFields: TJSONArray);
    function RetrieveUsersNames: TArray<string>;

    // Groups
    procedure QueryGroups(const AQuery: array of string;
      const AJSONArray: TJSONArray); overload;
    procedure QueryGroups(const AQuery: array of string;
      const AJSONArray: TJSONArray; out AGroups: TArray<TGroup>); overload;
    procedure CreateGroup(const AGroupName: string;
      const AGroupFields: TJSONObject; out AGroup: TGroup);
    procedure UpdateGroup(const AGroupName: string;
      const AGroupObject: TJSONObject; out AUpdatedAt: TUpdatedAt); overload;
    procedure UpdateGroup(const AGroup: TGroup; const AGroupObject: TJSONObject;
      out AUpdatedAt: TUpdatedAt); overload;
    function DeleteGroup(const AGroupName: string): Boolean; overload;
    function DeleteGroup(const AGroup: TGroup): Boolean; overload;
    function RetrieveGroup(const AGroupName: string; out AFoundGroup: TGroup;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveGroup(const AGroupName: string; AProc: TRetrieveGroupProc): Boolean; overload;
    function RetrieveGroup(const AGroup: TGroup; out AFoundGroup: TGroup;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveGroup(const AGroup: TGroup; AProc: TRetrieveGroupProc): Boolean; overload;
    procedure AddUsersToGroup(const AGroupName: string;
      const AUsers: TArray<string>; out AUpdatedAt: TUpdatedAt);
    function RemoveUsersFromGroup(const AGroupName: string;
      const AUsers: TArray<string>; out AUpdatedAt: TUpdatedAt): Boolean;
    procedure RetrieveGroupsFields(const AFields: TJSONArray);
    function RetrieveGroupsNames: TArray<string>;
    function RetrieveUserGroups(const AUserID: string): TArray<string>;

    // Installations
                                                            
                                                                 
    function CreateAndroidInstallationObject(const ADeviceToken: string; const AProperties: TJSONObject): TJSONObject; overload;
    function CreateAndroidInstallationObject(const ADeviceToken: string;  const AProperties: TJSONObject; AChannels: array of string): TJSONObject; overload;
    function CreateIOSInstallationObject(const ADeviceToken: string; const AProperties: TJSONObject): TJSONObject; overload;
    function CreateIOSInstallationObject(const ADeviceToken: string;  const AProperties: TJSONObject; AChannels: array of string): TJSONObject; overload;
    procedure UploadInstallation(const AJSON: TJSONObject; out ANewObject: TInstallation);
    procedure UpdateInstallation(const AInstallationID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
    function DeleteInstallation(const AInstallationID: string): Boolean; overload;
    procedure QueryInstallations(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryInstallations(const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TInstallation>); overload;
    function RetrieveInstallation(const AInstallationID: string; out AFoundInstallation: TInstallation;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveInstallation(const AInstallationID: string; AProc: TRetrieveInstallationProc): Boolean; overload;
    function RetrieveInstallation(const AInstallation: TInstallation; out AFoundInstallation: TInstallation;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveInstallation(const AInstallation: TInstallation; AProc: TRetrieveInstallationProc): Boolean; overload;
    function RetrieveInstallationsChannelNames: TArray<string>;
    procedure RetrieveInstallationsFields(const AFields: TJSONArray);
    // Push
    procedure PushBroadcast(const AData: TJSONObject); overload;
    procedure PushBroadcast(const AData: TJSONObject; out AStatus: TPushStatus); overload;
    procedure PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject); overload;
    procedure PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject; out AStatus: TPushStatus); overload;
    procedure PushToChannels(const AData: TJSONObject; const AChannels: array of string); overload;
    procedure PushToChannels(const AData: TJSONObject; const AChannels: array of string; out AStatus: TPushStatus); overload;
    procedure PushWhere(const AData: TJSONObject; const AWhere: TJSONObject); overload;
    procedure PushWhere(const AData: TJSONObject; const AWhere: TJSONObject; out AStatus: TPushStatus); overload;

    // Edgemodules
    procedure RegisterModule(const AName, AProtocol, AProtocolProps: string; const ADetails: TJSONObject;
      const AResources: TJSONArray; out AModule: TModule); overload;
    procedure RegisterModule(const AModuleName, AProtocol, AProtocolProps: string; const ADetails: TJSONObject; const Resources: TResourceList; out AModule: TModule); overload;
    function UnregisterModule(const AModuleID: string): Boolean;
    procedure QueryModules(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryModules(const AQuery: array of string;
      const AJSONArray: TJSONArray; out AModules: TArray<TModule>); overload;
    procedure UpdateModule(const AModuleID, AModuleName, AProtocol, AProtocolProps: string; const AJSONObject: TJSONObject; const AResources: TJSONArray; out AUpdatedAt: TUpdatedAt); overload;
    procedure UpdateModule(const AModuleID: string; const AJSONObject: TJSONObject; const AResources: TJSONArray; out AUpdatedAt: TUpdatedAt); overload;
    function RetrieveModule(const AModuleID: string; out AFoundModule: TModule;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveModule(const AModuleID: string; AProc: TRetrieveModuleProc): Boolean; overload;
    function RetrieveModule(const AModule: TModule; out AFoundModule: TModule;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveModule(const AModule: TModule; AProc: TRetrieveModuleProc): Boolean; overload;
    procedure RetrieveModulesFields(const AFields: TJSONArray);
    function QueryModuleName(const AModuleName: string; AProc: TQueryModuleNameProc): Boolean; overload;
    function QueryModuleName(const AModuleName: string; out AModule: TModule;
      const AJSON: TJSONArray = nil): Boolean; overload;

    // Edgemodule Resources
    function UnregisterModuleResource(const AModuleID, AName: string): Boolean;
    procedure QueryModuleResources(const AModuleID: string; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryModuleResources(const AModuleID: string; const AQuery: array of string; const AJSONArray: TJSONArray;
      out AResources: TArray<TModuleResource>); overload;
    procedure UpdateModuleResource(const AModuleID, AResourceName: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
    function RetrieveModuleResource(const AModuleID, AResourceName: string; out AFoundResource: TModuleResource;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveModuleResource(const AModuleID, AResourceName: string; AProc: TRetrieveModuleResourceProc): Boolean; overload;
    function RetrieveModuleResource(const AResource: TModuleResource; out AFoundResource: TModuleResource;
      const AJSON: TJSONArray = nil): Boolean; overload;
    function RetrieveModuleResource(const AResource: TModuleResource; AProc: TRetrieveModuleResourceProc): Boolean; overload;
    procedure RetrieveModuleResourcesFields(const AFields: TJSONArray);


    procedure Login(const ASessionAuthToken: string); overload;
    procedure Login(const ALogin: TLogin); overload;
    procedure Logout;
    property LoggedIn: Boolean read GetLoggedIn;
    property Authentication: TAuthentication read FAuthentication
      write FAuthentication;
    property DefaultAuthentication: TDefaultAuthentication
      read FDefaultAuthentication write FDefaultAuthentication;
    property Response: TRESTResponse read FResponse;
    property ConnectionInfo: TConnectionInfo read FConnectionInfo write SetConnectionInfo;
  end;

  EEMSClientAPIError = class(Exception);

  EEMSClientHTTPError = class(EEMSClientAPIError)
  public type
    TCodes = record
      const BadRequest = 400;
      const NotFound = 404;
      const Duplicate = 409;  // Duplicate
      const Unauthorized = 401;  // Don't know who you are
      const Forbidden = 403;  // I know who you are but not allowed
    end;
  private
    FError: string;
    FDescription: string;
    FCode: Integer;
  public
    constructor Create(ACode: Integer; const AError: string; const ADescription: string = ''); overload;
    property Code: Integer read FCode;
    property Error: string read FError;
    property Description: string read FDescription;
  end;

  EEMSClientHTTPBadRequest = class(EEMSClientHTTPError);
  EEMSClientHTTPNotFound = class(EEMSClientHTTPError);
  EEMSClientHTTPDuplicate = class(EEMSClientHTTPError);
  EEMSClientHTTPUnauthorized = class(EEMSClientHTTPError);
  EEMSClientHTTPForbidden = class(EEMSClientHTTPError);

implementation

uses
{$IFDEF MACOS}
  Macapi.CoreFoundation,
{$ENDIF}
  System.Rtti, System.TypInfo,
  REST.JSON.Types,
  REST.Consts, REST.Backend.EMSConsts;

procedure CheckUserID(const AObjectID: string);
begin
  if AObjectID = '' then
    raise EEMSClientAPIError.Create(sUserIDRequired);
end;

procedure CheckGroupName(const AGroupName: string);
begin
  if AGroupName = '' then
    raise EEMSClientAPIError.Create(sGroupNameRequired);
end;

procedure CheckInstallationID(const AInstallationID: string);
begin
  if AInstallationID = '' then
    raise EEMSClientAPIError.Create(sInstallationIDRequired);
end;

procedure CheckAuthToken(const AAuthToken: string);
begin
  if AAuthToken = '' then
    raise EEMSClientAPIError.Create(sAuthTokenRequired);
end;

procedure CheckJSONObject(const AJSON: TJSONObject);
begin
  if AJSON = nil then
    raise EEMSClientAPIError.Create(sJSONObjectRequired);
end;

procedure CheckMasterSecret(const AMasterKey: string);
begin
  if AMasterKey = '' then
    raise EEMSClientAPIError.Create(sMasterSecretRequired);
end;

procedure CheckSessionID(const SessionID: string);
begin
  if SessionID = '' then
    raise EEMSClientAPIError.Create(sSessionIDRequired);
end;

procedure CheckModuleID(const AModuleID: string);
begin
  if AModuleID = '' then
    raise EEMSClientAPIError.Create(sModuleIDRequired);
end;

procedure CheckResourceName(const AName: string);
begin
  if AName = '' then
    raise EEMSClientAPIError.Create(sResourceNameRequired);
end;

{ TEMSClientAPI }

// GET /version
procedure TEMSClientAPI.AppHandshake(const AJSONArray: TJSONArray);
begin
  AppHandshake(
    procedure(const AJSON: TJSONObject)
    begin
      if Assigned(AJSONArray) then
        AJSONArray.AddElement(AJSON.Clone as TJSONObject);
    end);
end;

procedure TEMSClientAPI.AppHandshake(const AProc: TAppHandshakeProc);
begin
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := 'version';

  DoAddAuthParameters;
  FRequest.Execute;
  CheckForResponseError;

  if Assigned(AProc) then
    AProc(FRequest.Response.JSONValue as TJSONObject);
end;

procedure TEMSClientAPI.ApplyConnectionInfo;
begin
  ApplyConnectionInfo(FRESTClient);
end;

procedure TEMSClientAPI.ApplyConnectionInfo(const AClient: TCustomRESTClient);
begin
  AClient.BaseURL := FConnectionInfo.BaseURL;
  AClient.Params.AddHeader(THeaderNames.ApiVersion,
    FConnectionInfo.ApiVersion);
  AClient.Params.AddHeader(THeaderNames.ApplicationId,
    FConnectionInfo.ApplicationId);
  AClient.ProxyPort := FConnectionInfo.ProxyPort;
  AClient.ProxyPassword := FConnectionInfo.ProxyPassword;
  AClient.ProxyUsername := FConnectionInfo.ProxyUsername;
  AClient.ProxyServer := FConnectionInfo.ProxyServer;
  AClient.OnValidateCertificate := FConnectionInfo.OnValidateCertificate;
end;

procedure TEMSClientAPI.AddMasterKey(const ARequest: TCustomRESTRequest; const AKey: string);
begin
  CheckMasterSecret(AKey);
  AddAuthHeader(ARequest, THeaderNames.MasterSecret, AKey);
end;

procedure TEMSClientAPI.AddSessionToken(const ARequest: TCustomRESTRequest; const AAppSecret,
  ASessionToken: string);
begin
  CheckSessionID(ASessionToken);
  AddAuthHeader(ARequest, THeaderNames.SessionToken, ASessionToken);
  AddAppSecret(ARequest, AAppSecret); // Need REST API Key with session token
end;

procedure TEMSClientApi.AddAuthHeader(const ARequest: TCustomRESTRequest; const AKey, AValue: string);
begin
  if AValue <> '' then
    ARequest.AddAuthParameter(AKey, AValue, TRESTRequestParameterKind.pkHTTPHEADER,
      [poTransient])
end;

procedure TEMSClientAPI.AddAppSecret(const ARequest: TCustomRESTRequest; const AKey: string);
begin
  AddAuthHeader(ARequest, THeaderNames.AppSecret, AKey);
end;

function TEMSClientAPI.GetActualAuthentication: TAuthentication;
var
  LAuthentication: TAuthentication;
begin
  LAuthentication := FAuthentication;
  if LAuthentication = TAuthentication.Default then
    case FDefaultAuthentication of
      TDefaultAuthentication.MasterSecret:
        LAuthentication := TAuthentication.MasterSecret;
      TDefaultAuthentication.AppSecret:
        LAuthentication := TAuthentication.AppSecret;
      TEMSClientAPI.TDefaultAuthentication.Session:
        LAuthentication := TAuthentication.Session;
      TEMSClientAPI.TDefaultAuthentication.None:
        LAuthentication := TAuthentication.None;
    else
      Assert(False);
    end;
  Result := LAuthentication;
end;

procedure TEMSClientAPI.DoAddAuthParameters;
begin
  AddAuthParameters(FRequest);
end;

procedure TEMSClientAPI.AddAuthParameters(const ARequest: TCustomRESTRequest);
var
  LAuthentication: TAuthentication;
begin
  LAuthentication := GetActualAuthentication;
  DoAddAuthParameters(ARequest, LAuthentication);
end;

procedure TEMSClientAPI.DoAddAuthParameters(AAuthentication: TAuthentication);
begin
  DoAddAuthParameters(Self.Request, AAuthentication);
end;

procedure TEMSClientAPI.DoAddAuthParameters(const ARequest: TCustomRESTRequest;
  AAuthentication: TAuthentication);
begin
  case AAuthentication of
    TEMSClientAPI.TAuthentication.AppSecret:
      AddAppSecret(ARequest, ConnectionInfo.AppSecret);
    TEMSClientAPI.TAuthentication.MasterSecret:
      AddMasterKey(ARequest, ConnectionInfo.MasterSecret);
    TEMSClientAPI.TAuthentication.Session:
    begin
      AddSessionToken(ARequest, ConnectionInfo.AppSecret, FSessionAuthToken);
      if ConnectionInfo.AppSecret <> '' then
        // Also add app secret
        AddAppSecret(ARequest, ConnectionInfo.AppSecret);
    end;
    TEMSClientAPI.TAuthentication.None:
      ;
  else
    Assert(False);
  end;
end;


procedure TEMSClientAPI.CreateGroup(const AGroupName: string;
  const AGroupFields: TJSONObject; out AGroup: TGroup);
var
  LJSON: TJSONObject;
  LResponse: TJSONObject;
begin
  if AGroupFields <> nil then
    LJSON := AGroupFields.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.GroupName, AGroupName);
    FRequest.AddBody(LJSON);
    AddResource(TSegmentNames.Groups, LJSON);
  finally
    LJSON.Free;
  end;

  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AGroup := GroupFromObject(AGroupName, LResponse);
end;

procedure TEMSClientAPI.CheckForResponseError;
begin
  CheckForResponseError(FRequest.Response);
end;

constructor TEMSClientAPI.Create;
begin
  Create(nil);
end;

function TEMSClientAPI.CreateHTTPException(const AResponse: TCustomRESTResponse): EEMSClientHTTPError;
begin
  case AResponse.StatusCode of
    EEMSClientHTTPError.TCodes.BadRequest:
      Result := CreateHTTPException(AResponse, EEMSClientHTTPBadRequest);
    EEMSClientHTTPError.TCodes.NotFound:
      Result := CreateHTTPException(AResponse, EEMSClientHTTPNotFound);
    EEMSClientHTTPError.TCodes.Duplicate:
      Result := CreateHTTPException(AResponse, EEMSClientHTTPDuplicate);
    EEMSClientHTTPError.TCodes.Unauthorized:
      Result := CreateHTTPException(AResponse, EEMSClientHTTPUnauthorized);
    EEMSClientHTTPError.TCodes.Forbidden:
      Result := CreateHTTPException(AResponse, EEMSClientHTTPForbidden);
  else
    Result := CreateHTTPException(AResponse, EEMSClientHTTPError);
  end;
end;

function TEMSClientAPI.CreateHTTPException(const AResponse: TCustomRESTResponse;
  const AClass: TEMSClientHTTPErrorClass): EEMSClientHTTPError;
var
  LError: string;
  LDescription: string;
  LJSONError: TJSONValue;
  LJSONDescription: TJSONValue;
  LCode: Integer;
begin
  LCode := AResponse.StatusCode;
  if AResponse.JSONValue <> nil then
  begin
    LJSONError := (AResponse.JSONValue as TJSONObject)
      .GetValue(TJSONNames.Error);
    if LJSONError <> nil then
      LError := LJSONError.Value;
    LJSONDescription := (AResponse.JSONValue as TJSONObject)
      .GetValue(TJSONNames.Description);
    if LJSONDescription <> nil then
      LDescription := LJSONDescription.Value;
    if (LJSONError <> nil) and (LJSONDescription <> nil) then
      Result := AClass.Create(LCode, LError, LDescription)
    else if LJSONDescription <> nil then
      Result := AClass.Create(LCode, LDescription)
    else if LJSONError <> nil then
      Result := AClass.Create(LCode, LError)
    else
      Result := AClass.Create(LCode, AResponse.Content.Substring(0, 100));
  end
  else if AResponse.Status.ClientError then
    Result := AClass.Create(AResponse.StatusCode, AResponse.StatusText)
  else
    Result := AClass.Create(LCode, AResponse.Content.Substring(0, 100));
end;

procedure TEMSClientAPI.CheckForResponseError(const AResponse: TCustomRESTResponse);
begin
  if AResponse.StatusCode >= 300 then
    raise CreateHTTPException(AResponse);
end;


procedure TEMSClientAPI.CheckForResponseError(const AResponse: TCustomRESTResponse;
  const AValidStatusCodes: array of Integer);
var
  LCode: Integer;
  LResponseCode: Integer;
begin
  LResponseCode := AResponse.StatusCode;

  for LCode in AValidStatusCodes do
    if LResponseCode = LCode then
      Exit; // Code is valid, exit with no exception
  CheckForResponseError(AResponse);
end;

procedure TEMSClientAPI.CheckForResponseError(AValidStatusCodes: array of Integer);
begin
  CheckForResponseError(FRequest.Response, AValidStatusCodes);
end;

constructor TEMSClientAPI.Create(AOwner: TComponent;
  const AResponse: TRESTResponse);
begin
  inherited Create(AOwner);
  FRESTClient := TRESTClient.Create(nil);
  FRESTClient.SynchronizedEvents := False;
  FRequest := TRESTRequest.Create(nil);
  FRequest.SynchronizedEvents := False;
  FRESTClient.RaiseExceptionOn500 := False;
  FRequest.Client := FRESTClient;
  FOwnsResponse := AResponse = nil;
  if FOwnsResponse then
    FResponse := TRESTResponse.Create(nil)
  else
    FResponse := AResponse;
  FRequest.Response := FResponse;
  ApplyConnectionInfo;
end;

destructor TEMSClientAPI.Destroy;
begin
  FRESTClient.Free;
  FRequest.Free;
  if FOwnsResponse then
    FResponse.Free;
  inherited;
end;

function TEMSClientAPI.GetLoggedIn: Boolean;
begin
  Result := FSessionAuthToken <> '';
end;

procedure TEMSClientAPI.Login(const ASessionAuthToken: string);
begin
  CheckSessionID(ASessionAuthToken);
  FSessionAuthToken := ASessionAuthToken;
  FAuthentication := TAuthentication.Session;
end;

procedure TEMSClientAPI.Login(const ALogin: TLogin);
begin
  Login(ALogin.AuthToken);
end;

function TEMSClientAPI.LoginFromObject(const AUserName: string;
  const AJSONObject: TJSONObject): TLogin;
var
  LUser: TUser;
  LSessionToken: string;
begin
  LUser := UserFromObject(AUserName, AJSONObject);
  if not AJSONObject.TryGetValue<string>(TJSONNames.SessionToken, LSessionToken) then
    raise EEMSClientAPIError.Create(sSessionTokenExpected);
  Assert(LSessionToken <> '');
  Result := TLogin.Create(LSessionToken, LUser);
end;

function TEMSClientAPI.UnregisterModule(const AModuleID: string): Boolean;
begin
  Result := DeleteResource(TSegmentNames.Modules, AModuleID);
end;

function TEMSClientAPI.UnregisterModuleResource(const AModuleID, AName: string): Boolean;
begin
                          
  Result := DeleteResource(TSegmentNames.Modules + '/{mname}/' + TSegmentNames.Resources, // do not localize
    AName,
    procedure begin FRequest.AddParameter('mname', AModuleID, TRESTRequestParameterKind.pkURLSEGMENT); end); // Do not localize

end;

function TEMSClientAPI.UpdatedAtFromObject(const AJSONObject: TJSONObject): TUpdatedAt;
var
  LUpdatedAt: TDateTime;
begin
  if AJSONObject.GetValue(TJSONNames.MetaUpdated) <> nil then
    LUpdatedAt := TJSONDates.AsDateTime
      (AJSONObject.GetValue(TJSONNames.MetaUpdated), TJSONDates.TFormat.ISO8601,
      DateTimeIsUTC)
  else
    LUpdatedAt := 0;
  Result := TUpdatedAt.Create(LUpdatedAt);
end;

procedure TEMSClientAPI.PutResource(const AResource, AID: string; const AJSON: TJSONObject; const AAddParameters: TProc);
var
  LJSON: TJSONObject;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPUT;
  FRequest.Resource := AResource + '/{id}'; // do not localize
  FRequest.AddParameter('id', AID,
    TRESTRequestParameterKind.pkURLSEGMENT); // Do not localize
  if Assigned(AAddParameters) then
    AAddParameters();
  if AJSON <> nil then
    FRequest.AddBody(AJSON)
  else
  begin
    LJSON := TJSONObject.Create;
    try
      FRequest.AddBody(LJSON);
    finally
      LJSON.Free;
    end;
  end;
  FRequest.Execute;
  CheckForResponseError;
end;

procedure TEMSClientAPI.UpdateGroup(const AGroupName: string;
  const AGroupObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
begin
  CheckGroupName(AGroupName);
  PutResource(TSegmentNames.Groups, AGroupName, AGroupObject);

  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AUpdatedAt := UpdatedAtFromObject(LResponse);
end;

procedure TEMSClientAPI.UpdateGroup(const AGroup: TGroup;
  const AGroupObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
begin
  UpdateGroup(AGroup.GroupName, AGroupObject, AUpdatedAt);
end;

procedure TEMSClientAPI.UpdateUser(const AUser: TUser;
  const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
begin
  UpdateUser(AUser.UserID, AUserObject, AUpdatedAt);
end;

function TEMSClientAPI.MetaDataFromObject(const AJSONObject: TJSONObject; out ACreatedAt, AUpdatedAt: TDateTime; out ACreator: string): Boolean;
var
  LInnerJSONObject: TJSONObject;
  LJSONValue: TJSONValue;
begin
  Result := AJSONObject.TryGetValue<TJSONObject>(TJSONNames.MetaData, LInnerJSONObject);
  if Result then
  begin
    ACreatedAt := 0;
    AUpdatedAt := 0;
    if LInnerJSONObject.TryGetValue<TJSONValue>(TJSONNames.MetaCreated, LJSONValue) then
      ACreatedAt := TJSONDates.AsDateTime
        (LJSONValue,
        TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
    if LInnerJSONObject.TryGetValue<TJSONValue>(TJSONNames.MetaUpdated, LJSONValue) then
      AUpdatedAt := TJSONDates.AsDateTime
        (LJSONValue,
        TJSONDates.TFormat.ISO8601, DateTimeIsUTC);
    ACreator := LInnerJSONObject.GetValue(TJSONNames.MetaCreator, '');
  end;
end;

function TEMSClientAPI.UserFromObject(const AUserName: string;
  const AJSONObject: TJSONObject): TUser;
var
  LCreatedAt, LUpdatedAt: TDateTime;
  LCreator: string;
begin
  Result := TUser.Create(AUserName);
  Result.FUserID := AJSONObject.GetValue<string>(TJSONNames.UserID, '');
  Assert(Result.FUserID <> '');
  if MetaDataFromObject(AJSONObject, LCreatedAt, LUpdatedAt, LCreator) then
  begin
    Result.FCreatedAt := LCreatedAt;
    Result.FUpdatedAt := LUpdatedAt;
    Result.FCreator := LCreator;
  end;
end;

function TEMSClientAPI.UserFromObject(const AJSONObject: TJSONObject): TUser;
var
  LUserName: string;
begin
  if AJSONObject.GetValue(TJSONNames.UserName) <> nil then
    LUserName := AJSONObject.GetValue(TJSONNames.UserName).Value;
  Result := UserFromObject(LUserName, AJSONObject);
end;


function TEMSClientAPI.GroupFromObject(const AJSONObject: TJSONObject): TGroup;
var
  LGroupName: string;
begin
  LGroupName := AJSONObject.GetValue<string>(TJSONNames.GroupName, '');
  Assert(LGroupName <> '');
  Result := GroupFromObject(LGroupName, AJSONObject);
end;

function TEMSClientAPI.PushStatusFromObject(const AJSONObject: TJSONObject): TPushStatus;
var
  LIOS: Integer;
  LAndroid: Integer;
begin
  LAndroid := AJSONObject.GetValue<Integer>('queued.android', 0);
  LIOS := AJSONObject.GetValue<Integer>('queued.ios', 0);
  Result := TPushStatus.Create(LIOS, LAndroid);
end;

function TEMSClientAPI.GroupFromObject(const AGroupName: string;
  const AJSONObject: TJSONObject): TGroup;
var
  LCreatedAt, LUpdatedAt: TDateTime;
  LCreator: string;
begin
  Result := TGroup.Create(AGroupName);
  if MetaDataFromObject(AJSONObject, LCreatedAt, LUpdatedAt, LCreator) then
  begin
    Result.FCreatedAt := LCreatedAt;
    Result.FUpdatedAt := LUpdatedAt;
    Result.FCreator := LCreator;
  end;
end;


function TEMSClientAPI.InstallationFromObject(const AJSONObject: TJSONObject): TInstallation;
var
  LInstallationID: string;
begin
  LInstallationID := AJSONObject.GetValue<string>(TJSONNames.InstallationID, '');
  Assert(LInstallationID <> '');
  Result := InstallationFromObject(LInstallationID, AJSONObject);
end;

function TEMSClientAPI.InstallationFromObject(const AInstallationID: string;
  const AJSONObject: TJSONObject): TInstallation;
var
  LCreatedAt, LUpdatedAt: TDateTime;
  LCreator: string;
begin
  Result := TInstallation.Create(AInstallationID);
  if MetaDataFromObject(AJSONObject, LCreatedAt, LUpdatedAt, LCreator) then
  begin
    Result.FCreatedAt := LCreatedAt;
    Result.FUpdatedAt := LUpdatedAt;
    Result.FCreator := LCreator;
  end;
end;

procedure TEMSClientAPI.PushBody(const AMessage: TJSONObject; out AStatus: TPushStatus);
var
  LResponse: TJSONObject;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := TSegmentNames.Push;
  FRequest.AddBody(AMessage);
  FRequest.Execute;
  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AStatus := PushStatusFromObject(LResponse);
end;

procedure TEMSClientAPI.PushBody(const AMessage: TJSONObject);
var
  LStatus: TPushStatus;
begin
  PushBody(AMessage, LStatus);
end;


//curl -X POST \
//  -H "Content-Type: application/json" \
//  -d '{
//        "where": {
//          "devicetype": "ios,android",
///        },
//        "data": {
//          "alert": "The Giants won against the Mets 2-3."
//        }
//      }' \
procedure TEMSClientAPI.PushBroadcast(const AData: TJSONObject);
begin
  PushToTarget(AData, nil);
end;

procedure TEMSClientAPI.PushBroadcast(const AData: TJSONObject; out AStatus: TPushStatus);
begin
  PushToTarget(AData, nil, AStatus);
end;

procedure TEMSClientAPI.PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject);
var
  LStatus: TPushStatus;
begin
  PushToTarget(AData, ATarget, LStatus);
end;

procedure TEMSClientAPI.PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject; out AStatus: TPushStatus);
var
  LJSON: TJSONObject;
  LPair: TJSONPair;
begin
  LJSON := TJSONObject.Create;
  try
    if AData <> nil then
      LJSON.AddPair(TJSONNames.PushData, AData.Clone as TJSONObject);    // Do not localize
    if ATarget <> nil then
      for LPair in ATarget do
        // such as "where" and "channels"
        LJSON.AddPair(LPair.Clone as TJSONPair);
    PushBody(LJSON, AStatus);
  finally
    LJSON.Free;
  end;
end;

//curl -X POST \
//  -H "Content-Type: application/json" \
//  -d '{
//        "channels": [
//          "Giants",
//          "Mets"
//        ],
//        "data": {
//          "alert": "The Giants won against the Mets 2-3."
//        }
//      }' \
procedure TEMSClientAPI.PushToChannels(const AData: TJSONObject; const AChannels: array of string; out AStatus: TPushStatus);
var
  LJSON: TJSONObject;
  LChannels: TJSONArray;
  S: string;
begin
  if Length(AChannels) = 0 then
    raise EEMSClientAPIError.Create(sChannelNamesExpected);
  LJSON := TJSONObject.Create;
  try
    LChannels := TJSONArray.Create;
    for S in AChannels do
      LChannels.Add(S);
    LJSON.AddPair(TJSONNames.PushChannels, LChannels);                    // Do not localize
    PushToTarget(AData, LJSON, AStatus);
  finally
    LJSON.Free;
  end;
end;

procedure TEMSClientAPI.PushToChannels(const AData: TJSONObject; const AChannels: array of string);
var
  LStatus: TPushStatus;
begin
  PushToChannels(AData, AChannels, LStatus);
end;

//curl -X POST \
//  -H "Content-Type: application/json" \
//  -d '{
//        "where": {
//          {"deviceType":{"$in":["ios", "android"]}}
//        },
//        "data": {
//          "alert": "The Giants won against the Mets 2-3."
//        }
//      }' \
procedure TEMSClientAPI.PushWhere(const AData: TJSONObject; const AWhere: TJSONObject; out AStatus: TPushStatus);
var
  LJSON: TJSONObject;
begin
  LJSON := TJSONObject.Create;
  try
    if AWhere <> nil then
      LJSON.AddPair(TJSONNames.PushWhere, AWhere.Clone as TJSONObject);  // Do not localize
    if AData <> nil then
      LJSON.AddPair(TJSONNames.PushData, AData.Clone as TJSONObject);    // Do not localize
    PushBody(LJSON, AStatus);
  finally
    LJSON.Free;
  end;
end;

procedure TEMSClientAPI.PushWhere(const AData: TJSONObject; const AWhere: TJSONObject);
var
  LStatus: TPushStatus;
begin
  PushWhere(AData, AWhere, LStatus);
end;

procedure TEMSClientAPI.SetConnectionInfo(const Value: TConnectionInfo);
begin
  FConnectionInfo := Value;
  ApplyConnectionInfo;
end;

procedure TEMSClientAPI.QueryResource(const AResource: string;
  const AQuery: array of string; const AJSONArray: TJSONArray; AReset: Boolean; const AAddParameters: TProc);
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
    DoAddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := AResource;
  if Assigned(AAddParameters) then
    AAddParameters();

  for S in AQuery do
  begin
    LTrim := Trim(S);
    if LTrim = '' then
      continue;
    I := LTrim.IndexOf('=');
    if I > 0 then
      FRequest.AddParameter(S.Substring(0, I).Trim, S.Substring(I + 1).Trim);
  end;

  FRequest.Execute;
  CheckForResponseError;
  if AJSONArray <> nil then
  begin
    LRoot := FRequest.Response.JSONValue as TJSONArray;
    for LJSONValue in LRoot do
      AJSONArray.AddElement(TJSONValue(LJSONValue.Clone))
  end;
end;

function TEMSClientAPI.DeleteGroup(const AGroup: TGroup): Boolean;
begin
  Result := DeleteGroup(AGroup.GroupName);
end;

function TEMSClientAPI.DeleteResource(const AResource, AID: string; const AAddParameters: TProc): Boolean;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmDELETE;
  FRequest.Resource := AResource + '/{id}'; // do not localize
  FRequest.AddParameter('id', AID,
    TRESTRequestParameterKind.pkURLSEGMENT); // Do not localize
  if Assigned(AAddParameters) then
    AAddParameters();

  FRequest.Execute;

  CheckForResponseError([EEMSClientHTTPError.TCodes.NotFound]);
  Result := FRequest.Response.StatusCode <> EEMSClientHTTPError.TCodes.NotFound
end;

function TEMSClientAPI.DeleteGroup(const AGroupName: string): Boolean;
begin
  CheckGroupName(AGroupName);
  Result := DeleteResource(TSegmentNames.Groups, AGroupName);
end;

function TEMSClientAPI.DeleteUser(const AUser: TUser): Boolean;
begin
  Result := DeleteUser(AUser.FUserID);
end;

function TEMSClientAPI.DeleteUser(const AObjectID: string): Boolean;
begin
  CheckUserID(AObjectID);
  Result := DeleteResource(TSegmentNames.Users, AObjectID);
end;


procedure TEMSClientAPI.UpdateUser(const AObjectID: string;
  const AUserObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
  LJSON: TJSONObject;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmPUT;
  FRequest.Resource := TSegmentNames.Users + '/{userId}'; // do not localize
  FRequest.AddParameter('userId', AObjectID,
    TRESTRequestParameterKind.pkURLSEGMENT); // Do not localize
  if AUserObject <> nil then
    FRequest.AddBody(AUserObject)
  else
  begin
    LJSON := TJSONObject.Create;
    try
      FRequest.AddBody(LJSON)
    finally
      LJSON.Free;
    end;
  end;

  FRequest.Execute;

  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AUpdatedAt := UpdatedAtFromObject(LResponse);
end;

procedure TEMSClientAPI.QueryUsers(const AQuery: array of string;
  const AJSONArray: TJSONArray);
var
  LResource: string;
begin
  LResource := TSegmentNames.Users + '/';
  QueryResource(LResource, AQuery, AJSONArray, True);
end;

procedure TEMSClientAPI.QueryUsers(const AQuery: array of string;
  const AJSONArray: TJSONArray; out AUsers: TArray<TUser>);
var
  LJSONValue: TJSONValue;
  LJSONArray: TJSONArray;
  LList: TList<TUser>;
  LUser: TUser;
  LResource: string;
begin
  LList := nil;
  LResource := TSegmentNames.Users + '/';
  if AJSONArray = nil then
    LJSONArray := TJSONArray.Create
  else
    LJSONArray := AJSONArray;
  try
    QueryResource(LResource, AQuery, LJSONArray, True);
    LList := TList<TUser>.Create;
    for LJSONValue in LJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LUser := UserFromObject(TJSONObject(LJSONValue));
        LList.Add(LUser);
      end
      else
        raise EEMSClientAPIError.Create(sJSONObjectExpected);
    end;
    AUsers := LList.ToArray;
  finally
    LList.Free;
    if LJSONArray <> AJSONArray then
      LJSONArray.Free;
  end;
end;

function TEMSClientAPI.MakeLoginResource(const ASegmentName: string): string;
begin
  if FConnectionInfo.LoginResource <> '' then
    Result := FConnectionInfo.LoginResource + '/' + ASegmentName
  else
    Result :=  TSegmentNames.Users + '/' + ASegmentName;
end;

function TEMSClientAPI.ModuleFromObject(const AJSONObject: TJSONObject): TModule;
var
  LModuleID: string;
begin
  LModuleID := AJSONObject.GetValue<string>(TJSONNames.ModuleID, '');
  Assert(LModuleID <> '');
  Result := ModuleFromObject(LModuleID, AJSONObject);
end;

function TEMSClientAPI.ModuleFromObject(const AModuleID: string; const AJSONObject: TJSONObject): TModule;
var
  LModuleName, LProtocol, LProtocolProps: string;
  LCreatedAt, LUpdatedAt: TDateTime;
  LCreator: string;
begin
  AJSONObject.TryGetValue<string>(TJSONNames.ModuleName, LModuleName);
  Result := TModule.Create(AModuleID, LModuleName);
  if AJSONObject.TryGetValue<string>(TJSONNames.Protocol, LProtocol) then
    Result.FProtocol := LProtocol;
  if AJSONObject.TryGetValue<string>(TJSONNames.ProtocolProps, LProtocolProps) then
    Result.FProtocolProps := LProtocolProps;
  if MetaDataFromObject(AJSONObject, LCreatedAt, LUpdatedAt, LCreator) then
  begin
    Result.FCreatedAt := LCreatedAt;
    Result.FUpdatedAt := LUpdatedAt;
    Result.FCreator := LCreator;
  end;
end;

function TEMSClientAPI.ResourceFromObject(
  const AJSONObject: TJSONObject): TModuleResource;
var
  LModuleName, LModuleID: string;
  LResourceName: string;
  LCreatedAt, LUpdatedAt: TDateTime;
  LCreator: string;
begin
  AJSONObject.TryGetValue<string>(TJSONNames.ResourceName, LResourceName);
  AJSONObject.TryGetValue<string>(TJSONNames.ModuleName, LModuleName);
  AJSONObject.TryGetValue<string>(TJSONNames.ResourceModuleID, LModuleID);
  Result := TModuleResource.Create(LResourceName, LModuleID, LModuleName);
  if MetaDataFromObject(AJSONObject, LCreatedAt, LUpdatedAt, LCreator) then
  begin
    Result.FCreatedAt := LCreatedAt;
    Result.FUpdatedAt := LUpdatedAt;
    Result.FCreator := LCreator;
  end;
end;

procedure TEMSClientAPI.LoginUser(const AUserName, APassword: string;
  out ALogin: TLogin; const AJSON: TJSONArray; AProc: TLoginProc);
var
  LJSON: TJSONObject;
  LResponse: TJSONObject;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters; // (TAuthentication.AppSecret); // Always use AppSecret
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := MakeLoginResource(TSegmentNames.Login);
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.UserName, AUserName);
    LJSON.AddPair(TJSONNames.Password, APassword);
    FRequest.AddBody(LJSON);
  finally
    LJSON.Free;
  end;

  FRequest.Execute;
  CheckForResponseError;

  LResponse := FRequest.Response.JSONValue as TJSONObject;
  ALogin := LoginFromObject(AUserName, LResponse);
  if Assigned(AJSON) then
    AJSON.AddElement(LResponse.Clone as TJSONObject);
  if Assigned(AProc) then
    AProc(ALogin, LResponse);
end;

procedure TEMSClientAPI.LoginUser(const AUserName, APassword: string;
  out ALogin: TLogin; const AJSON: TJSONArray);
begin
  LoginUser(AUserName, APassword, ALogin, AJSON, nil);
end;

procedure TEMSClientAPI.LoginUser(const AUserName, APassword: string;
  AProc: TLoginProc);
var
  LLogin: TLogin;
begin
  LoginUser(AUserName, APassword, LLogin, nil, AProc);
end;

procedure TEMSClientAPI.QueryGroups(const AQuery: array of string;
  const AJSONArray: TJSONArray);
var
  LResource: string;
begin
  LResource := TSegmentNames.Groups + '/';
  QueryResource(LResource, AQuery, AJSONArray, True);
end;

procedure TEMSClientAPI.QueryGroups(const AQuery: array of string;
  const AJSONArray: TJSONArray; out AGroups: TArray<TGroup>);
var
  LJSONValue: TJSONValue;
  LList: TList<TGroup>;
  LGroup: TGroup;
  LResource: string;
  LJSONArray: TJSONArray;
begin
  LList := nil;
  LResource := TSegmentNames.Groups + '/';
  if AJSONArray = nil then
    LJSONArray := TJSONArray.Create
  else
    LJSONArray := AJSONArray;
  try
    QueryResource(LResource, AQuery, LJSONArray, True);
    LList := TList<TGroup>.Create;
    for LJSONValue in LJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LGroup := GroupFromObject(TJSONObject(LJSONValue));
        LList.Add(LGroup);
      end
      else
        raise EEMSClientAPIError.Create(sJSONObjectExpected);
    end;
    AGroups := LList.ToArray;
  finally
    LList.Free;
    if LJSONArray <> AJSONArray then
      LJSONArray.Free;
  end;
end;

procedure TEMSClientAPI.Logout;
begin
  FSessionAuthToken := '';
  if FAuthentication = TAuthentication.Session then
    FAuthentication := TAuthentication.Default;
end;

procedure TEMSClientAPI.LogoutUser;
begin
  FRequest.ResetToDefaults;
  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := TSegmentNames.Users + '/' + TSegmentNames.Logout;
  DoAddAuthParameters; // (TAuthentication.Session); // Required

  FRequest.Execute;
  CheckForResponseError;
  FSessionAuthToken := ''; // No longer valid
end;

procedure TEMSClientAPI.SignupUser(const AUserName, APassword: string;
  const AUserFields: TJSONObject; out ALogin: TLogin);
var
  LJSON: TJSONObject;
  LResponse: TJSONObject;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters; //(TAuthentication.AppSecret); // Required

  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := MakeLoginResource(TSegmentNames.Signup); // TSegmentNames.Users + '/' + TSegmentNames.Signup;
  if AUserFields <> nil then
    LJSON := AUserFields.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.UserName, AUserName);
    LJSON.AddPair(TJSONNames.Password, APassword);
    FRequest.AddBody(LJSON);
  finally
    LJSON.Free;
  end;

  FRequest.Execute;
  CheckForResponseError([EEMSClientHTTPError.TCodes.Duplicate]);
  if FRequest.Response.StatusCode = EEMSClientHTTPError.TCodes.Duplicate then
    raise CreateHTTPException(FRequest.Response);

  LResponse := FRequest.Response.JSONValue as TJSONObject;
  ALogin := LoginFromObject(AUserName, LResponse);
end;

procedure TEMSClientAPI.AddResource(const AResource: string; const AJSON: TJSONObject; const AAddParameters: TProc);
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters; //(TAuthentication.AppSecret); // Required

  FRequest.Method := TRESTRequestMethod.rmPOST;
  FRequest.Resource := AResource;
  if Assigned(AAddParameters) then
    AAddParameters();
  FRequest.AddBody(AJSON);

  FRequest.Execute;
  CheckForResponseError([EEMSClientHTTPError.TCodes.Duplicate]);
  if FRequest.Response.StatusCode = EEMSClientHTTPError.TCodes.Duplicate then
    raise CreateHTTPException(FRequest.Response);

end;


// Add user but do not create a session
procedure TEMSClientAPI.AddUser(const AUserName, APassword: string;
  const AUserFields: TJSONObject; out AUser: TUser);
var
  LJSON: TJSONObject;
  LResponse: TJSONObject;
begin
  if AUserFields <> nil then
    LJSON := AUserFields.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.UserName, AUserName);
    LJSON.AddPair(TJSONNames.Password, APassword);
    AddResource(TSegmentNames.Users, LJSON);
//    FRequest.AddBody(LJSON);
  finally
    LJSON.Free;
  end;

  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AUser := UserFromObject(AUserName, LResponse);
end;

function TEMSClientAPI.QueryUserName(const AUserName: string; out AUser: TUser;
  const AJSON: TJSONArray; AProc: TQueryUserNameProc): Boolean;
var
  LUsers: TJSONArray;
  LUserObject: TJSONObject;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  // Closing '/' required
  FRequest.Resource := TSegmentNames.Users + '/';
  FRequest.AddParameter(TQueryParamNames.Where,
    TJSONObject.Create.AddPair(TJSONNames.UserName, TJSONString.Create(AUserName)));

  FRequest.Execute;

  CheckForResponseError;
  LUsers := FRequest.Response.JSONValue as TJSONArray;
  if LUsers.Count > 1 then
    raise EEMSClientAPIError.Create(sOneUserExpected);
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

function TEMSClientAPI.QueryUserName(const AUserName: string;
  AProc: TQueryUserNameProc): Boolean;
var
  LUser: TUser;
begin
  Result := QueryUserName(AUserName, LUser, nil, AProc);
end;

function TEMSClientAPI.QueryUserName(const AUserName: string; out AUser: TUser;
  const AJSON: TJSONArray): Boolean;
begin
  Result := QueryUserName(AUserName, AUser, AJSON, nil);
end;

function TEMSClientAPI.RetrieveUser(const AObjectID: string; out AUser: TUser;
  const AJSON: TJSONArray; AProc: TRetrieveUserProc): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckUserID(AObjectID);
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := TSegmentNames.Users + '/{userId}'; // do not localize
  FRequest.AddParameter('userId', AObjectID,
    TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.Execute;
  CheckForResponseError([EEMSClientHTTPError.TCodes.NotFound]); // 404 = not found
  if FRequest.Response.StatusCode <> EEMSClientHTTPError.TCodes.NotFound then
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

function TEMSClientAPI.RetrieveUser(const AObjectID: string;
  AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser(AObjectID, LUser, nil, AProc);
end;

procedure TEMSClientAPI.RetrieveUsersFields(const AFields: TJSONArray);
begin
  RetrieveFields(TSegmentNames.UsersFields, AFields);
end;

function TEMSClientAPI.RetrieveUsersNames: TArray<string>;
var
  LUsers: TArray<TUser>;
  LUser: TUser;
  LSkip: Integer;
  LResult: TList<string>;
begin
  LResult := TList<string>.Create;
  try
    LSkip := 0;
    while True do
    begin
      QueryUsers([Format('skip=%d', [LSkip]), 'limit=100'], nil, LUsers);
      if Length(LUsers) = 0 then
        break;
      for LUser in LUsers do
        LResult.Add(LUser.UserName);
      Inc(LSkip, 100);
    end;
    Result := LResult.ToArray;
  finally
    LResult.Free;
  end;
end;

function TEMSClientAPI.RetrieveUser(const AUser: TUser; out AFoundUser: TUser;
  const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser(AUser.UserID, AFoundUser, AJSON, nil);
end;

function TEMSClientAPI.RetrieveUser(const AUser: TUser;
  AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser(AUser.UserID, LUser, nil, AProc);
end;

function TEMSClientAPI.RetrieveUser(const AObjectID: string; out AUser: TUser;
  const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser(AObjectID, AUser, AJSON, nil);
end;

function TEMSClientAPI.RetrieveCurrentUser(AProc: TRetrieveUserProc): Boolean;
var
  LUser: TUser;
begin
  Result := RetrieveUser(TSegmentNames.Me, LUser, nil, AProc);
end;

function TEMSClientAPI.RetrieveInstallationsChannelNames: TArray<string>;
var
  LResponse: TJSONArray;
  I: Integer;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := TSegmentNames.InstallationsChannels;
  FRequest.Execute;
  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONArray;
  SetLength(Result, LResponse.Count);
  for I := 0 to Length(Result) - 1 do
    Result[I] := LResponse.Items[I].Value;
end;

procedure TEMSClientAPI.RetrieveFields(const AResourceName: string; const AFields: TJSONArray);
var
  LResponse: TJSONArray;
  LValue: TJSONValue;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := AResourceName;
  FRequest.Execute;
  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONArray;
  for LValue in LResponse do
    AFields.AddElement(LValue.Clone as TJSONValue);
end;

procedure TEMSClientAPI.RetrieveInstallationsFields(const AFields: TJSONArray);
begin
  RetrieveFields(TSegmentNames.InstallationsFields, AFields);
end;

function TEMSClientAPI.RetrieveCurrentUser(out AUser: TUser;
  const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveUser(TSegmentNames.Me, AUser, AJSON, nil);
end;

function TEMSClientAPI.RetrieveModule(const AModuleID: string;
  out AModule: TModule; const AJSON: TJSONArray;
  AProc: TRetrieveModuleProc): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckModuleID(AModuleID);
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := TSegmentNames.Modules + '/{id}'; // do not localize
  FRequest.AddParameter('id', AModuleID,
    TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.Execute;
  CheckForResponseError([EEMSClientHTTPError.TCodes.NotFound]); // 404 = not found
  if FRequest.Response.StatusCode <> EEMSClientHTTPError.TCodes.NotFound then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AModule := ModuleFromObject(AModuleId, LResponse);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AModule, LResponse);
  end
end;

function TEMSClientAPI.RetrieveModuleResource(const AModuleID, AResourceName: string;
  out AResource: TModuleResource; const AJSON: TJSONArray;
  AProc: TRetrieveModuleResourceProc): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckModuleID(AModuleID);
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := TSegmentNames.Modules + '/{mname}/' + TSegmentNames.Resources + '/{name}'; // do not localize
  FRequest.AddParameter('mname', AModuleID,
    TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.AddParameter('name', AResourceName,
    TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.Execute;
  CheckForResponseError([EEMSClientHTTPError.TCodes.NotFound]); // 404 = not found
  if FRequest.Response.StatusCode <> EEMSClientHTTPError.TCodes.NotFound then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AResource := ResourceFromObject(LResponse);
    Assert(AResource.ResourceName = AResourceName);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AResource, LResponse);
  end
end;


function TEMSClientAPI.RetrieveModuleResource(const AModuleID, AResourceName: string;
  out AFoundResource: TModuleResource; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveModuleResource(AModuleID, AResourceName, AFoundResource, AJSON, nil);
end;

function TEMSClientAPI.RetrieveModule(const AModuleID: string;
  out AFoundModule: TModule; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveModule(AModuleID, AFoundModule, AJSON, nil);
end;


function TEMSClientAPI.RetrieveGroup(const AGroupName: string;
  out AGroup: TGroup; const AJSON: TJSONArray;
  AProc: TRetrieveGroupProc): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckGroupName(AGroupName);
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := TSegmentNames.Groups + '/{id}'; // do not localize
  FRequest.AddParameter('id', AGroupName,
    TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.Execute;
  CheckForResponseError([EEMSClientHTTPError.TCodes.NotFound]); // 404 = not found
  if FRequest.Response.StatusCode <> EEMSClientHTTPError.TCodes.NotFound then
  begin
    Result := True;
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    AGroup := GroupFromObject(LResponse);
    if Assigned(AJSON) then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AGroup, LResponse);
  end
end;

function TEMSClientAPI.RetrieveGroup(const AGroupName: string;
  out AFoundGroup: TGroup; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveGroup(AGroupName, AFoundGroup, AJSON, nil);
end;

procedure TEMSClientAPI.AddUsersToGroup(const AGroupName: string; const AUsers: TArray<string>; out AUpdatedAt: TUpdatedAt);
var
  LJSONObject: TJSONObject;
  LJSONArray: TJSONArray;
  S: string;
begin
  LJSONObject := nil;
  try
    if not RetrieveGroup(AGroupName,
        procedure(const AGroup: TEMSClientAPI.TGroup; const AJSONObject: TJSONObject)
        begin
          LJSONObject := AJSONObject.Clone as TJSONObject;
        end) then
      raise EEMSClientAPIError.CreateFmt(sGroupNotFound, [AGroupName]);
    if not LJSONObject.TryGetValue<TJSONArray>('users', LJSONArray) then
    begin
      LJSONArray := TJSONArray.Create;
      LJSONObject.AddPair('users', LJSONArray);
    end;
    for S in AUsers do
      LJSONArray.Add(S);
    UpdateGroup(AGroupName, LJSONObject, AUpdatedAt);
  finally
    LJSONObject.Free;
  end;
end;

procedure TEMSClientAPI.RegisterModule(const AName, AProtocol, AProtocolProps: string;
  const ADetails: TJSONObject; const AResources: TJSONArray; out AModule: TModule);
var
  LJSON: TJSONObject;
  LResponse: TJSONObject;
begin
  if ADetails <> nil then
    LJSON := ADetails.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.ModuleName, AName);
    LJSON.AddPair(TJSONNames.Protocol, AProtocol);
    LJSON.AddPair(TJSONNames.ProtocolProps, AProtocolProps);
    if AResources <> nil then
      LJSON.AddPair(TJSONPair.Create(TJSONNames.Resources, TJSONValue(AResources.Clone)));
    AddResource(TSegmentNames.Modules, LJSON);
//    FRequest.AddBody(LJSON);
  finally
    LJSON.Free;
  end;

  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AModule := ModuleFromObject(LResponse);
end;

procedure TEMSClientAPI.RegisterModule(const AModuleName, AProtocol, AProtocolProps: string;
  const ADetails: TJSONObject; const Resources: TResourceList; out AModule: TModule);
var
  LPair: TPair<string, TJSONObject>;
  LJSONResources: TJSONArray;
  LJSONResource: TJSONObject;
begin
  LJSONResources := nil;
  try
    for LPair in Resources do
    begin
      if LJSONResources = nil then
        LJSONResources := TJSONArray.Create;
      if LPair.Value <> nil then
        LJSONResource :=  TJSONObject(LPair.Value.Clone)
      else
        LJSONResource := TJSONObject.Create;
      LJSONResource.AddPair(TJSONNames.ResourceName, LPair.Key);
      LJSONResources.AddElement(LJSONResource);
    end;
    RegisterModule(AModuleName, AProtocol, AProtocolProps, ADetails, LJSONResources, AModule);
  finally
    LJSONResources.Free;
  end;
end;

function TEMSClientAPI.RemoveUsersFromGroup(const AGroupName: string; const AUsers: TArray<string>; out AUpdatedAt: TUpdatedAt): Boolean;
var
  LJSONObject: TJSONObject;
  LJSONArray: TJSONArray;
  S: string;
  LJSONValue: TJSONValue;
  LPair: TJSONPair;
  LList: TList<string>;
begin
  Result := False;
  LJSONObject := nil;
  try
    if not RetrieveGroup(AGroupName,
        procedure(const AGroup: TEMSClientAPI.TGroup; const AJSONObject: TJSONObject)
        begin
          LJSONObject := AJSONObject.Clone as TJSONObject;
        end) then
      raise Exception.CreateFmt(sGroupNotFound, [AGroupName]);

    if LJSONObject.TryGetValue<TJSONArray>('users', LJSONArray) then
    begin
      LList := TList<string>.Create;
      try
        for LJSONValue in LJSONArray do
          LList.Add(LJSONValue.Value);
        for S in AUsers do
          if LList.Contains(S) then
          begin
            Result := True;
            LList.Remove(S);
          end;
        LJSONArray := TJSONArray.Create;
        for S in LList do
          LJSONArray.Add(S);
        LPair := LJSONObject.RemovePair('users');
        LPair.Free;
        LJSONObject.AddPair('users', LJSONArray);
      finally
        LList.Free;
      end;
      UpdateGroup(AGroupName, LJSONObject, AUpdatedAt);
    end;
  finally
    LJSONObject.Free;
  end;
end;

function TEMSClientAPI.RetrieveModule(const AModuleID: string;
  AProc: TRetrieveModuleProc): Boolean;
var
  LModule: TModule;
begin
  Result := RetrieveModule(AModuleID, LModule, nil, AProc);
end;

function TEMSClientAPI.RetrieveModule(const AModule: TModule;
  out AFoundModule: TModule; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveModule(AModule.ModuleName, AFoundModule, AJSON, nil);
end;

function TEMSClientAPI.RetrieveModule(const AModule: TModule;
  AProc: TRetrieveModuleProc): Boolean;
var
  LModule: TModule;
begin
  Result := RetrieveModule(AModule.ModuleName, LModule, nil, AProc);
end;

procedure TEMSClientAPI.RetrieveModulesFields(const AFields: TJSONArray);
begin
  RetrieveFields(TSegmentNames.ModulesFields, AFields);
end;


function TEMSClientAPI.RetrieveModuleResource(const AModuleID, AResourceName: string;
  AProc: TRetrieveModuleResourceProc): Boolean;
var
  LModule: TModuleResource;
begin
  Result := RetrieveModuleResource(AModuleID, AResourceName, LModule, nil, AProc);
end;

function TEMSClientAPI.RetrieveModuleResource(const AResource: TModuleResource;
  out AFoundResource: TModuleResource; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveModuleResource(AResource.ModuleName, AResource.ResourceName, AFoundResource, AJSON, nil);
end;

function TEMSClientAPI.RetrieveModuleResource(const AResource: TModuleResource;
  AProc: TRetrieveModuleResourceProc): Boolean;
var
  LResource: TModuleResource;
begin
  Result := RetrieveModuleResource(AResource.ModuleName, AResource.ResourceName, LResource, nil, AProc);
end;

procedure TEMSClientAPI.RetrieveModuleResourcesFields(const AFields: TJSONArray);
begin
  RetrieveFields(TSegmentNames.ResourcesFields, AFields);
end;

function TEMSClientAPI.RetrieveGroup(const AGroupName: string;
  AProc: TRetrieveGroupProc): Boolean;
var
  LGroup: TGroup;
begin
  Result := RetrieveGroup(AGroupName, LGroup, nil, AProc);
end;

function TEMSClientAPI.RetrieveGroup(const AGroup: TGroup;
  out AFoundGroup: TGroup; const AJSON: TJSONArray): Boolean;
begin
  Result := RetrieveGroup(AGroup.GroupName, AFoundGroup, AJSON, nil);
end;

function TEMSClientAPI.RetrieveGroup(const AGroup: TGroup;
  AProc: TRetrieveGroupProc): Boolean;
var
  LGroup: TGroup;
begin
  Result := RetrieveGroup(AGroup.GroupName, LGroup, nil, AProc);
end;

procedure TEMSClientAPI.RetrieveGroupsFields(const AFields: TJSONArray);
begin
  RetrieveFields(TSegmentNames.GroupsFields, AFields);
end;

function TEMSClientAPI.RetrieveGroupsNames: TArray<string>;
var
  LGroups: TArray<TGroup>;
  LGroup: TGroup;
  LSkip: Integer;
  LResult: TList<string>;
begin
  LResult := TList<string>.Create;
  try
    LSkip := 0;
    while True do
    begin
      QueryGroups([Format('skip=%d', [LSkip]), 'limit=100'], nil, LGroups);
      if Length(LGroups) = 0 then
        break;
      for LGroup in LGroups do
        LResult.Add(LGroup.GroupName);
      Inc(LSkip, 100);
    end;
    Result := LResult.ToArray;
  finally
    LResult.Free;
  end;
end;

function TEMSClientAPI.RetrieveUserGroups(const AUserID: string): TArray<string>;
var
  LResponse: TJSONArray;
  LValue: TJSONValue;
begin
  CheckUserID(AUserID);
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := TSegmentNames.Users + '/{id}' + '/groups'; // do not localize
  FRequest.AddParameter('id', AUserID,
    TRESTRequestParameterKind.pkURLSEGMENT);
  FRequest.Execute;
  CheckForResponseError;
  LResponse := FRequest.Response.JSONValue as TJSONArray;
  if LResponse is TJSONArray then
  begin
    for LValue in TJSONArray(LResponse) do
      Result := Result + [LValue.Value];
  end
  else
    raise EEMSClientAPIError.Create(sJSONArrayExpected);

end;

function TEMSClientAPI.CreateInstallationObject(const ADeviceType: string; const ADeviceToken: string; const AProperties: TJSONObject; AChannels: array of string): TJSONObject;
var
  LArray: TJSONArray;
  S: string;
  LProperties: TJSONObject;
begin
  if AProperties <> nil then
  begin
    LProperties := AProperties.Clone as TJSONObject;
    LProperties.RemovePair(TJSONNames.Pushchannels);
  end
  else
    LProperties := TJSONObject.Create;
  try
    LArray := TJSONArray.Create;
    for S in AChannels do
      LArray.AddElement(TJSONString.Create(S));
    LProperties.AddPair(TJSONNames.Pushchannels, LArray);
     Result := CreateInstallationObject(ADeviceType, ADeviceToken, LProperties);
  finally
    LProperties.Free;
  end;
end;

function TEMSClientAPI.CreateInstallationObject(const ADeviceType: string; const ADeviceToken: string; const AProperties: TJSONObject): TJSONObject;
var
  LPair: TJSONPair;
begin
  Result := TJSONObject.Create;
  Result.AddPair('deviceType', TJSONString.Create(ADeviceType));   // Do not localize
  Result.AddPair('deviceToken', TJSONString.Create(ADeviceToken));       // Do not localize
  if AProperties <> nil then
    for LPair in AProperties do
      Result.AddPair(LPair.Clone as TJSONPair);
                  
  // LProperties.AddPair('timeZone', TJSONString.Create(????));
end;

function TEMSClientAPI.CreateIOSInstallationObject(const ADeviceToken: string; const AProperties: TJSONObject): TJSONObject;
begin
  Result := CreateInstallationObject(TDeviceTypes.IOS, ADeviceToken, AProperties);
end;

function TEMSClientAPI.CreateIOSInstallationObject(const ADeviceToken: string; const AProperties: TJSONObject; AChannels: array of string): TJSONObject;
begin
  Result := CreateInstallationObject(TDeviceTypes.IOS, ADeviceToken, AProperties, AChannels);
end;

function TEMSClientAPI.CreateAndroidInstallationObject(const ADeviceToken: string; const AProperties: TJSONObject): TJSONObject;
begin
  Result := CreateInstallationObject(TDeviceTypes.Android, ADeviceToken, AProperties);
end;

function TEMSClientAPI.CreateAndroidInstallationObject(const ADeviceToken: string; const AProperties: TJSONObject; AChannels: array of string): TJSONObject;
begin
  Result := CreateInstallationObject(TDeviceTypes.Android, ADeviceToken, AProperties, AChannels);
end;

function TEMSClientAPI.DeleteInstallation(const AInstallationID: string): Boolean;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters; // (TAuthentication.MasterKey); // Required
  Result := DeleteResource(TSegmentNames.Installations, AInstallationID);
end;

procedure TEMSClientAPI.QueryInstallations(const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters; // (TAuthentication.MasterKey);     // Master required
  QueryResource(TSegmentNames.Installations, AQuery, AJSONArray, False);
end;

procedure TEMSClientAPI.QueryInstallations(const AQuery: array of string; const AJSONArray: TJSONArray; out AObjects: TArray<TInstallation>);
var
  LJSONValue: TJSONValue;
  LList: TList<TInstallation>;
  LInstallation: TInstallation;
  LJSONArray: TJSONArray;
begin
  LList := nil;
  FRequest.ResetToDefaults;
  DoAddAuthParameters; // (TAuthentication.MasterKey);     // Master required
  if AJSONArray = nil then
    LJSONArray := TJSONArray.Create
  else
    LJSONArray := AJSONArray;
  try
    QueryResource(TSegmentNames.Installations, AQuery, LJSONArray, False);
    LList := TList<TInstallation>.Create;
    for LJSONValue in LJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        // Blank backend class name
        LInstallation := InstallationFromObject(TJSONObject(LJSONValue));
        LList.Add(LInstallation);
      end
      else
        raise EEMSClientAPIError.Create(sJSONObjectExpected);
    end;
    AObjects := LList.ToArray;
  finally
    LList.Free;
    if LJSONArray <> AJSONArray then
      LJSONArray.Free;
  end;
end;

procedure TEMSClientAPI.QueryModuleResources(const AModuleID: string; const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  if AModuleID = '' then
    // Get all
    QueryResource(TSegmentNames.ModulesResources,
      AQuery, AJSONArray, False)
  else
    QueryResource(TSegmentNames.Modules + '/{mname}/' + TSegmentNames.Resources, // do not localize
      AQuery, AJSONArray, False,
      procedure begin FRequest.AddParameter('mname', AModuleID, TRESTRequestParameterKind.pkURLSEGMENT); end); // Do not localize

end;

procedure TEMSClientAPI.QueryModuleResources(const AModuleID: string; const AQuery: array of string;
  const AJSONArray: TJSONArray; out AResources: TArray<TModuleResource>);
var
  LJSONValue: TJSONValue;
  LJSONArray: TJSONArray;
  LList: TList<TModuleResource>;
  LResource: TModuleResource;
begin
  LList := nil;
  if AJSONArray = nil then
    LJSONArray := TJSONArray.Create
  else
    LJSONArray := AJSONArray;
  try
    QueryModuleResources(AModuleID, AQuery, LJSONArray);
    LList := TList<TModuleResource>.Create;
    for LJSONValue in LJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LResource := ResourceFromObject(TJSONObject(LJSONValue));
        LList.Add(LResource);
      end
      else
        raise EEMSClientAPIError.Create(sJSONObjectExpected);
    end;
    AResources := LList.ToArray;
  finally
    LList.Free;
    if LJSONArray <> AJSONArray then
      LJSONArray.Free;
  end;
end;


procedure TEMSClientAPI.QueryModules(const AQuery: array of string;
  const AJSONArray: TJSONArray);
begin
  QueryResource(TSegmentNames.Modules, AQuery, AJSONArray, False);
end;

procedure TEMSClientAPI.QueryModules(const AQuery: array of string;
  const AJSONArray: TJSONArray; out AModules: TArray<TModule>);
var
  LJSONValue: TJSONValue;
  LJSONArray: TJSONArray;
  LList: TList<TModule>;
  LModule: TModule;
begin
  LList := nil;
  if AJSONArray = nil then
    LJSONArray := TJSONArray.Create
  else
    LJSONArray := AJSONArray;
  try
    QueryModules(AQuery, LJSONArray);
    LList := TList<TModule>.Create;
    for LJSONValue in LJSONArray do
    begin
      if LJSONValue is TJSONObject then
      begin
        LModule := ModuleFromObject(TJSONObject(LJSONValue));
        LList.Add(LModule);
      end
      else
        raise EEMSClientAPIError.Create(sJSONObjectExpected);
    end;
    AModules := LList.ToArray;
  finally
    LList.Free;
    if LJSONArray <> AJSONArray then
      LJSONArray.Free;
  end;
end;

function TEMSClientAPI.QueryModuleName(const AModuleName: string;
  AProc: TQueryModuleNameProc): Boolean;
var
  LModule: TModule;
begin
  Result := QueryModuleName(AModuleName, LModule, nil, AProc);
end;

function TEMSClientAPI.QueryModuleName(const AModuleName: string; out AModule: TModule;
  const AJSON: TJSONArray): Boolean;
begin
  Result := QueryModuleName(AModuleName, AModule, AJSON, nil);
end;

function TEMSClientAPI.QueryModuleName(const AModuleName: string; out AModule: TModule;
  const AJSON: TJSONArray; AProc: TQueryModuleNameProc): Boolean;
var
  LModules: TJSONArray;
  LModuleObject: TJSONObject;
begin
  FRequest.ResetToDefaults;
  DoAddAuthParameters;
  FRequest.Method := TRESTRequestMethod.rmGET;
  // Closing '/' required
  FRequest.Resource := TSegmentNames.Modules + '/';
  FRequest.AddParameter(TQueryParamNames.Where,
    TJSONObject.Create.AddPair(TJSONNames.ModuleName, TJSONString.Create(AModuleName)));

  FRequest.Execute;

  CheckForResponseError;
  LModules := FRequest.Response.JSONValue as TJSONArray;
  if LModules.Count > 1 then
    raise EEMSClientAPIError.Create(sOneModuleExpected);
  Result := LModules.Count = 1;
  if Result then
  begin
    LModuleObject := LModules.Items[0] as TJSONObject;
    AModule := ModuleFromObject(LModuleObject);
    if Assigned(AJSON) then
      AJSON.AddElement(LModuleObject.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(AModule, LModuleObject);
  end;
end;

function TEMSClientAPI.RetrieveInstallation(const AInstallationID: string; out AFoundInstallation: TInstallation; const AJSON: TJSONArray = nil): Boolean;
begin
  Result := RetrieveInstallation(AInstallationID, AFoundInstallation, AJSON, nil, True);
end;

function TEMSClientAPI.RetrieveInstallation(const AInstallationID: string; AProc: TRetrieveInstallationProc): Boolean;
var
  LInstallation: TInstallation;
begin
  Result := RetrieveInstallation(AInstallationID, LInstallation, nil, AProc, True);
end;

function TEMSClientAPI.RetrieveInstallation(const AInstallation: TInstallation; AProc: TRetrieveInstallationProc): Boolean;
var
  LInstallation: TInstallation;
begin
  Result := RetrieveInstallation(AInstallation.InstallationID, LInstallation, nil, AProc, True);
end;

function TEMSClientAPI.RetrieveInstallation(const AInstallation: TInstallation; out AFoundInstallation: TInstallation;
  const AJSON: TJSONArray): Boolean;
var
  LInstallation: TInstallation;
begin
  Result := RetrieveInstallation(AInstallation.InstallationID, LInstallation, AJSON, nil, True);
end;

function TEMSClientAPI.RetrieveInstallation(const AInstallationID: string; out AFoundInstallation: TInstallation; const AJSON: TJSONArray;  AProc: TRetrieveInstallationProc; AReset: Boolean): Boolean;
var
  LResponse: TJSONObject;
begin
  Result := False;
  CheckInstallationID(AInstallationID);
  if AReset then
  begin
    FRequest.ResetToDefaults;
    DoAddAuthParameters;
  end;
  FRequest.Method := TRESTRequestMethod.rmGET;
  FRequest.Resource := TSegmentNames.Installations + '/'  +  AInstallationID;
  FRequest.Execute;
  CheckForResponseError([404]); // 404 = not found
  if FRequest.Response.StatusCode <> 404 then
  begin
    Result := True;
    // '{"createdAt":"2013-10-16T20:21:57.326Z","objectId":"5328czuo2e"}'
    LResponse := FRequest.Response.JSONValue as TJSONObject;
    if AJSON <> nil then
      AJSON.AddElement(LResponse.Clone as TJSONObject);
    if Assigned(AProc) then
      AProc(InstallationFromObject(LResponse), LResponse);
  end
end;

procedure TEMSClientAPI.UploadInstallation(const AJSON: TJSONObject; out ANewObject: TInstallation);
var
  LResponse: TJSONObject;
begin
  AddResource(TSegmentNames.Installations, AJSON);
  // '{"createdAt":"2013-10-16T20:21:57.326Z","objectId":"5328czuo2e"}'
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  ANewObject := InstallationFromObject(LResponse);
end;

procedure TEMSClientAPI.UpdateInstallation(const AInstallationID: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
begin
  CheckInstallationID(AInstallationID);
  PutResource(TSegmentNames.Installations, AInstallationID, AJSONObject);
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  // '{"updatedAt":"2013-10-16T20:21:57.326Z"}'
  AUpdatedAt := UpdatedAtFromObject(LResponse);
end;

procedure TEMSClientAPI.UpdateModule(const AModuleID, AModuleName, AProtocol, AProtocolProps: string; const AJSONObject: TJSONObject; const AResources: TJSONArray; out AUpdatedAt: TUpdatedAt);
var
  LJSON: TJSONObject;
begin
  CheckModuleID(AModuleID);
  if AJSONObject <> nil then
    LJSON := AJSONObject.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.ModuleName, AModuleName);
    LJSON.AddPair(TJSONNames.Protocol, AProtocol);
    LJSON.AddPair(TJSONNames.ProtocolProps, AProtocolProps);
    UpdateModule(AModuleID, LJSON, AResources, AUpdatedAt);
  finally
    LJSON.Free;
  end;
end;

procedure TEMSClientAPI.UpdateModule(const AModuleID: string; const AJSONObject: TJSONObject; const AResources: TJSONArray; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
  LJSON: TJSONObject;
begin
  CheckModuleID(AModuleID);
  if AJSONObject <> nil then
    LJSON := AJSONObject.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    if AResources <> nil then
      LJSON.AddPair(TJSONPair.Create(TJSONNames.Resources, TJSONValue(AResources.Clone)));
    PutResource(TSegmentNames.Modules, AModuleID, LJSON);
  finally
    LJSON.Free;
  end;
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AUpdatedAt := UpdatedAtFromObject(LResponse);
end;

procedure TEMSClientAPI.UpdateModuleResource(const AModuleID, AResourceName: string; const AJSONObject: TJSONObject; out AUpdatedAt: TUpdatedAt);
var
  LResponse: TJSONObject;
begin
  CheckModuleID(AModuleID);
  CheckResourceName(AResourceName);
  PutResource(TSegmentNames.Modules + '/{mname}/' + TSegmentNames.Resources, // do not localize
    AResourceName, AJSONObject,
    procedure begin FRequest.AddParameter('mname', AModuleID, TRESTRequestParameterKind.pkURLSEGMENT); end); // Do not localize
  LResponse := FRequest.Response.JSONValue as TJSONObject;
  AUpdatedAt := UpdatedAtFromObject(LResponse);
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

{ TEMSClientApi.TUserID }

constructor TEMSClientAPI.TUser.Create(const AUserName, AUserID: string);
begin
  FUserName := AUserName;
  FUserID := AUserID;
end;

{ TEMSClientApi.TGroup }

constructor TEMSClientAPI.TGroup.Create(const AGroupName: string);
begin
  FGroupName := AGroupName;
end;

{ TEMSClientApi.TInstallation }

constructor TEMSClientAPI.TInstallation.Create(const AInstallationID: string);
begin
  FInstallationID := AInstallationID;
end;

{ TEMSClientApi.TLogin }

constructor TEMSClientAPI.TLogin.Create(const AAuthToken: string;
  const AUser: TUser);
begin
  FAuthToken := AAuthToken;
  FUser := AUser;
end;

{ TEMSClientAPI.TUpdatedAt }

constructor TEMSClientAPI.TUpdatedAt.Create(AUpdatedAt: TDateTime);
begin
  FUpdatedAt := AUpdatedAt;
end;

{ EEMSClientHTTPError }

constructor EEMSClientHTTPError.Create(ACode: Integer; const AError, ADescription: string);
var
  LError: string;
begin
  FCode := ACode;
  FDescription := ADescription;
  FError := AError;

  if (AError <> '') and (ADescription <> '') then
  begin
    LError := AError;
    if LError.EndsWith('.') then
      LError := LError.Substring(0, LError.Length-1);
    inherited CreateFmt(sFormatEMSErrorDescription, [LError, ADescription])
  end
  else if AError <> '' then
    inherited CreateFmt(sFormatEMSError, [AError])
  else if ADescription <> '' then
    inherited CreateFmt(sFormatEMSError, [ADescription]);
end;

{ TEMSClientAPI.TDeviceCounts }

constructor TEMSClientAPI.TPushStatus.Create(AIOS, AAndroid: Integer);
begin
  FAndroid := AAndroid;
  FIOS := AIOS;
end;

{ TEMSClientAPI.TModule }

constructor TEMSClientAPI.TModule.Create(const AModuleID, AName: string);
begin
  FModuleID := AModuleID;
  FModuleName := AName;
end;

{ TEMSClientAPI.TModuleResource }

constructor TEMSClientAPI.TModuleResource.Create(const AName, AModuleID, AModuleName: string);
begin
  FResourceName := AName;
  FModuleName := AModuleName;
  FModuleID := AModuleID;
end;

end.


