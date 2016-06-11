{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.ServiceTypes;

interface

{$SCOPEDENUMS ON}

uses System.Generics.Collections, System.Classes, System.JSON,
  REST.Backend.Providers, REST.Backend.MetaTypes, REST.Client, REST.Json, REST.Json.Types;

type
  // Forward declaration of "TBackendObjectList__1" template
  {$HPPEMIT OPENNAMESPACE}
  {$HPPEMIT 'template<typename T> class DELPHICLASS TBackendObjectList__1;'}
  {$HPPEMIT CLOSENAMESPACE}

  IBackendGetMetaFactory = interface(IBackendService)
    ['{65BB9847-DF2D-4888-8B2F-36EDE51FE20A}']
    function GetMetaFactory: IBackendMetaFactory;
  end;

  IBackendQueryApi = interface;

  IBackendQueryService = interface(IBackendService)
    ['{3A22E6DA-7139-4163-B981-DEED365D92B3}']
    function GetQueryAPI: IBackendQueryApi;
    function CreateQueryApi: IBackendQueryApi;
    property QueryAPI: IBackendQueryApi read GetQueryAPI;
  end;

  TBackendObjectList<T: class, constructor> = class;

  TBackendQueryServiceNames = record
    const
      Storage = 'Storage';
      Users = 'Users';
      Installations = 'Installations';
      Groups = 'Groups';
      Modules = 'Edgemodules';
      ModulesResources = 'Edgeresources';
      Files = 'Files';
                    
  end;

  // Implemented by a service
  IBackendQueryApi = interface(IBackendGetMetaFactory)
    ['{1F54E3F6-693D-4A25-AC00-7CFFC99D6632}']
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray); overload;
    procedure Query(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
    procedure GetServiceNames(out ANames: TArray<string>);
  end;

  IBackendAuthenticationApi = interface;

  TBackendAuthenticationApi = class
  private
    function GetAuthentication: TBackendAuthentication;
    function GetDefaultAuthentication: TBackendDefaultAuthentication;
    procedure SetAuthentication(const Value: TBackendAuthentication);
    procedure SetDefaultAuthentication(
      const Value: TBackendDefaultAuthentication);
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; virtual; abstract;
  public
    procedure Login(const ALogin: TBackendEntityValue);
    procedure Logout;
    property Authentication: TBackendAuthentication read GetAuthentication write SetAuthentication;
    property DefaultAuthentication: TBackendDefaultAuthentication read GetDefaultAuthentication write SetDefaultAuthentication;
    property AuthenticationApi: IBackendAuthenticationApi read GetAuthenticationApi;
  end;

  // Wrapper
  TBackendQueryApi = class(TBackendAuthenticationApi)
  private
    FServiceApi: IBackendQueryApi;
    FService: IBackendQueryService;
    function GetServiceAPI: IBackendQueryApi;
    function CreateMetaDataType(const ADataType,
      AClassName: string): TBackendMetaClass;
    procedure Query(const AClass: TBackendMetaClass;
      const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure Query(const AClass: TBackendMetaClass;
      const AQuery: array of string; const AJSONArray: TJSONArray;
      out AMetaArray: TArray<TBackendEntityValue>); overload;
    procedure Query<T: class, constructor>(const ADataType: TBackendMetaClass;
      const AQuery: array of string; const AResultList: TBackendObjectList<T>); overload;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    constructor Create(const AApi: IBackendQueryApi); overload;
    constructor Create(const AService: IBackendQueryService); overload;
    procedure GetServiceNames(out ANames: TArray<string>);
    procedure Query(const ADataType, ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure Query(const ADataType, ABackendClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>); overload;
    procedure Query<T: class, constructor>(const ADataType, ABackendClassName: string; const AQuery: array of string; const AResultList: TBackendObjectList<T>); overload;
    property ProviderAPI: IBackendQueryApi read GetServiceAPI;
  end;

  IBackendStorageApi = interface;
  IBackendStorageApi2 = interface;

  IBackendStorageService = interface(IBackendService)
    ['{0B60B443-8D7F-4984-8DEA-B7057AD9ED7F}']
    function GetStorageApi: IBackendStorageApi;
    function CreateStorageApi: IBackendStorageApi;
    property StorageAPI: IBackendStorageApi read GetStorageAPI;
  end;

  TFindObjectProc = reference to procedure(const AObject: TBackendEntityValue; const AJSON: TJSONObject);

  TFindObjectProc<T: class> = reference to procedure(const AMetaObject: TBackendEntityValue; const AObject: T);

  // Implemented by a service
  IBackendStorageApi = interface(IBackendGetMetaFactory)
  ['{F4CBE0D9-5AAD-49EE-9D2E-3178E5DF2425}']
    function GetMetaFactory: IBackendMetaFactory;
    procedure CreateObject(const AClass: TBackendMetaClass; const AACL, AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
                                                                         
    function DeleteObject(const AObject: TBackendEntityValue): Boolean; overload;
    function FindObject(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean;
    procedure UpdateObject(const AObject: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray); overload;
    procedure QueryObjects(const AClass: TBackendMetaClass; const AQuery: array of string;
      const AJSONArray: TJSONArray; out AObjects: TArray<TBackendEntityValue>); overload;
  end;

   /// <summary>Extends IBackendStorageApi to provide custom Date Format objects</summary>
  IBackendStorageApi2 = interface(IBackendGetMetaFactory)
  ['{912DE1A0-75D5-4F79-852C-160976C6A765}']
    function GetJsonDateFormat : TJsonDateFormat;
  end;

  // Wrapper
  TBackendStorageApi = class(TBackendAuthenticationApi)
  private
    FService: IBackendStorageService;
    FServiceApi: IBackendStorageApi;
    function CreateMetaClass(const AClassName: string): TBackendMetaClass;
    function CreateMetaClassObject(const AClassName,
      AObjectID: string): TBackendEntityValue;
    procedure CreateObject(const AClass: TBackendMetaClass; const AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    procedure CreateObject(const AClass: TBackendMetaClass; const AACL, AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    procedure CreateObject<T: class, constructor>(const AClass: TBackendMetaClass; const AObject: T;
      out ACreatedObject: TBackendEntityValue); overload;
    function GetServiceAPI: IBackendStorageApi;
    procedure QueryObjects<T: class, constructor>(const AClass: TBackendMetaClass;
      const AQuery: array of string; const AResultList: TBackendObjectList<T>); overload;
    procedure QueryObjects(const AClass: TBackendMetaClass;
      const AQuery: array of string; const AJSONArray: TJSONArray;
      out AMetaArray: TArray<TBackendEntityValue>); overload;
    procedure QueryObjects(const AClass: TBackendMetaClass;
      const AQuery: array of string; const AJSONArray: TJSONArray); overload;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    constructor Create(const AApi: IBackendStorageApi); overload;
    constructor Create(const AService: IBackendStorageService); overload;
    // JSON
    procedure CreateObject(const AClassName: string; const AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    procedure CreateObject(const AClassName: string; const AACL, AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    function DeleteObject(const AClassName, AObjectID: string): Boolean; overload;
    function DeleteObject(const AObject: TBackendEntityValue): Boolean; overload;
    function FindObject(const AMetaObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindObject(const AClassName, AObjectID: string; AProc: TFindObjectProc): Boolean; overload;
    procedure QueryObjects(const AClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryObjects(const AClassName: string; const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>); overload;
    procedure UpdateObject(const AObject: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue); overload;
    procedure UpdateObject(const AClassName, AObjectID: string; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue); overload;
    // <T: class>
    procedure CreateObject<T: class, constructor>(const AClassName: string; const AObject: T;
      out ACreatedObject: TBackendEntityValue); overload;
    procedure CreateObject<T: class, constructor>(const AClassName: string; const AObject: T); overload;
    function FindObject<T: class, constructor>(const AMetaObject: TBackendEntityValue; AProc: TFindObjectProc<T>): Boolean; overload;
    procedure UpdateObject<T: class, constructor>(const AMetaObject: TBackendEntityValue; const AObject: T;
      out AUpdatedObject: TBackendEntityValue); overload;
    procedure QueryObjects<T: class, constructor>(const AClassName: string; const AQuery: array of string; const AResultList: TBackendObjectList<T>); overload;
     /// <summary>Add date format to options set used in Json processing </summary>
    function AddDateOption(ADateFormat: TJSONDateFormat; AOptions: TJSONOptions): TJSONOptions;
    property ProviderAPI: IBackendStorageApi read GetServiceAPI;
  end;

  IBackendAuthenticationApi = interface
    ['{4C0D2ADD-B6B7-40ED-B6B5-5DB66B7ECE9D}']
    procedure Login(const ALogin: TBackendEntityValue);
    procedure Logout;
    procedure SetDefaultAuthentication(ADefaultAuthentication: TBackendDefaultAuthentication);
    function GetDefaultAuthentication: TBackendDefaultAuthentication;
    procedure SetAuthentication(AAuthentication: TBackendAuthentication);
    function GetAuthentication: TBackendAuthentication;
    property Authentication: TBackendAuthentication read GetAuthentication write SetAuthentication;
    property DefaultAuthentication: TBackendDefaultAuthentication read GetDefaultAuthentication write SetDefaultAuthentication;
  end;

  IBackendAuthApi = interface;

  IBackendAuthService = interface(IBackendService)
    ['{DB06E5A1-7261-44A3-9C3E-9805744D53C9}']
    function GetAuthAPI: IBackendAuthApi;
    function CreateAuthApi: IBackendAuthApi;
    property AuthAPI: IBackendAuthApi read GetAuthAPI;
  end;

  // Implemented by a service
  IBackendAuthApi = interface(IBackendGetMetaFactory)
    ['{568A911A-B61B-45AA-8BD4-CFCAC0598CF6}']
    procedure SignupUser(const AUserName, APassword: string; const AUserData: TJSONObject;
      out ACreatedObject: TBackendEntityValue);
    procedure LoginUser(const AUserName, APassword: string; AProc: TFindObjectProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray); overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure UpdateUser(const AObject: TBackendEntityValue; const AUserData: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
  end;

  // Wrapper
  TBackendAuthApi = class(TBackendAuthenticationApi)
  private
    FService: IBackendAuthService;
    FServiceApi: IBackendAuthApi;
    function CreateMetaUserObject(const AObjectID: string): TBackendEntityValue;
    function GetServiceAPI: IBackendAuthApi;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
    function GetAuthApi: IBackendAuthApi; virtual;
  public
    constructor Create(const AApi: IBackendAuthApi); overload;
    constructor Create(const AService: IBackendAuthService); overload;
    procedure SignupUser(const AUserName, APassword: string; const AUserData: TJSONObject;
      out ACreatedObject: TBackendEntityValue);
    procedure LoginUser(const AUserName, APassword: string; AProc: TFindObjectProc); overload;
    procedure LoginUser(const AUserName, APassword: string; out ALogin: TBackendEntityValue; const AJSON: TJSONArray=nil); overload;
    function FindCurrentUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean;
    procedure UpdateUser(const AObject: TBackendEntityValue; const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue); overload;
    property ProviderAPI: IBackendAuthApi read GetServiceAPI;
  end;

  IBackendUsersApi = interface;

  IBackendUsersService = interface(IBackendService)
    ['{B6A9B066-E6C0-4A01-B70B-5A5A19C816AF}']
    function GetUsersAPI: IBackendUsersApi;
    function CreateUsersApi: IBackendUsersApi;
    property UsersAPI: IBackendUsersApi read GetUsersAPI;
  end;

  // Implemented by a service
  IBackendUsersApi = interface(IBackendAuthApi)
    ['{FD6D169C-07E8-4738-9B9A-BB50E5D423FC}']
                                                                         
    function DeleteUser(const AObject: TBackendEntityValue): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    function QueryUserName(const AUserName: string; AProc: TFindObjectProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>); overload;
  end;

  // Wrapper
  TBackendUsersApi = class(TBackendAuthApi)
  private
    FService: IBackendUsersService;
    FServiceApi: IBackendUsersApi;
    function CreateMetaUserObject(const AObjectID: string): TBackendEntityValue;
    function GetServiceAPI: IBackendUsersApi;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
    function GetAuthApi: IBackendAuthApi; override;
  public
    constructor Create(const AApi: IBackendUsersApi); overload;
    constructor Create(const AService: IBackendUsersService); overload;
                                                                         
    function DeleteUser(const AObject: TBackendEntityValue): Boolean; overload;
    function DeleteUser(const AObjectID: string): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindUser(const AObjectID: string; AProc: TFindObjectProc): Boolean; overload;
    function FindUser(const AObject: TBackendEntityValue; out AUser: TBackendEntityValue; const AJSON: TJSONArray = nil): Boolean; overload;
    function FindUser(const AObjectID: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray = nil): Boolean; overload;
    procedure UpdateUser(const AObjectID: string; const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue); overload;
    function QueryUserName(const AUserName: string; AProc: TFindObjectProc): Boolean; overload;
    function QueryUserName(const AUserName: string; out AUser: TBackendEntityValue; const AJSON: TJSONArray = nil): Boolean; overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray); overload;
    procedure QueryUsers(const AQuery: array of string; const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>); overload;
    property ProviderAPI: IBackendUsersApi read GetServiceAPI;
  end;

  IBackendGroupsApi = interface;

  IBackendGroupsService = interface(IBackendService)
    ['{D40C0565-5165-4280-9625-5593FB77FA36}']
    function GetGroupsAPI: IBackendGroupsApi;
    function CreateGroupsApi: IBackendGroupsApi;
    property GroupsAPI: IBackendGroupsApi read GetGroupsAPI;
  end;

  // Implemented by a service
  IBackendGroupsApi = interface(IBackendGetMetaFactory)
    ['{3FF2A6F6-490E-4896-B482-CD361A8C6705}']
    procedure AddUsers(const AGroupName: string; const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue);
    function RemoveUsers(const AGroupName: string; const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue): Boolean;
    procedure CreateGroup(const AGroup: string; AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    function DeleteGroup(const AObject: TBackendEntityValue): Boolean; overload;
    function FindGroup(const AObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean;
    procedure UpdateGroup(const AObject: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue);
  end;

  // Wrapper
  TBackendGroupsApi = class(TBackendAuthenticationApi)
  private
    FService: IBackendGroupsService;
    FServiceApi: IBackendGroupsApi;
    function GetServiceAPI: IBackendGroupsApi;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    function CreateMetaGroupObject(const AGroupName: string): TBackendEntityValue;
    constructor Create(const AApi: IBackendGroupsApi); overload;
    constructor Create(const AService: IBackendGroupsService); overload;
    procedure AddUsers(const AGroupName: string; const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue);
    procedure AddUser(const AGroupName: string; const AUser: string; out AUpdatedObject: TBackendEntityValue);
    function RemoveUser(const AGroupName, AUser: string; out AUpdatedObject: TBackendEntityValue): Boolean;
    function RemoveUsers(const AGroupName: string;
      const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue): Boolean;

    procedure CreateGroup(const AGroupName: string; const AJSON: TJSONObject;
      out ACreatedObject: TBackendEntityValue); overload;
    function DeleteGroup(const AGroupName: string): Boolean; overload;
    function DeleteGroup(const AGroup: TBackendEntityValue): Boolean; overload;
    function FindGroup(const AMetaObject: TBackendEntityValue; AProc: TFindObjectProc): Boolean; overload;
    function FindGroup(const AGroupName: string; AProc: TFindObjectProc): Boolean; overload;
    procedure UpdateGroup(const AGroup: TBackendEntityValue; const AJSONObject: TJSONObject;
      out AUpdatedObject: TBackendEntityValue); overload;

    property ProviderAPI: IBackendGroupsApi read GetServiceAPI;
  end;


  IBackendFilesApi = interface;

  IBackendFilesService = interface(IBackendService)
    ['{A925E828-73A5-41C0-93A4-4E12BC7949FB}']
    function GetFilesAPI: IBackendFilesApi;
    function CreateFilesApi: IBackendFilesApi;
    property FilesAPI: IBackendFilesApi read GetFilesAPI;
  end;

  // Files service must implement this
  IBackendFilesApi = interface(IBackendGetMetaFactory)
    ['{271C2472-D957-47C5-BC10-F3A15FF5261C}']
                               
    procedure UploadFile(const AFileName: string; const AContentType: string; out AFile: TBackendEntityValue); overload;
    procedure UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string; out AFile: TBackendEntityValue); overload;
    function DeleteFile(const AFile: TBackendEntityValue): Boolean; overload;
  end;

  // Files service wrapper
  TBackendFilesApi = class(TBackendAuthenticationApi)
  private
    FService: IBackendFilesService;
    FServiceApi: IBackendFilesApi;
    function GetServiceAPI: IBackendFilesApi;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    function CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
    constructor Create(const AApi: IBackendFilesApi); overload;
    constructor Create(const AService: IBackendFilesService); overload;
    procedure UploadFile(const AFileName: string; const AContentType: string; out AFile: TBackendEntityValue); overload;
    procedure UploadFile(const AFileName: string; const AStream: TStream; const AContentType: string; out AFile: TBackendEntityValue); overload;
    function DeleteFile(const AFile: TBackendEntityValue): Boolean; overload;
    function DeleteFile(const AFileID: string): Boolean; overload;
    property ProviderAPI: IBackendFilesApi read GetServiceAPI;
  end;

  TBackendObjectList<T: class, constructor> = class
  private type
    TObjectPair = TPair<T, TBackendEntityValue>;
    TObjectPairs = TArray<TObjectPair>;
    TObjectList = TList<T>;
    TObjectDictionary = TDictionary<T, TBackendEntityValue>;
  public type
    TEnumerator = class(TEnumerator<T>)
    private
      FList: TObjectList;
      FIndex: Integer;
      constructor Create(const AList: TObjectList);
    protected
      function DoGetCurrent: T; override;
      function DoMoveNext: Boolean; override;
    end;
  private
    FList: TObjectList;
    FDictionary: TObjectDictionary;
    function GetCount: Integer;
    function GetItem(I: Integer): T;
    procedure Clear;
    function GetEntityValue(I: T): TBackendEntityValue;
  public
    constructor Create;
    destructor Destroy; override;
    function GetEnumerator: TEnumerator<T>;
    function Extract(const Value: T): T;
    function ExtractArray: TArray<T>;
    procedure Add(const AValue: T; const AMetaObject: TBackendEntityValue);
    function IndexOf(I: T): Integer;
    property Count: Integer read GetCount;
    property Items[I: Integer]: T read GetItem; default;
    property EntityValues[I: T]: TBackendEntityValue read GetEntityValue;
  end;

  IBackendCustomEndpointApi = interface;

  IBackendCustomEndpointService = interface(IBackendService)
    ['{BF37269F-BBDE-4110-BAFA-A1CC725BC5D0}']
    function GetCustomEndpointAPI: IBackendCustomEndpointApi;
    function CreateCustomEndpointApi: IBackendCustomEndpointApi;
    property CustomEndpointAPI: IBackendCustomEndpointApi read GetCustomEndpointAPI;
  end;

  // Implemented by a service
  IBackendCustomEndpointApi = interface(IBackendService)
    ['{974BD7BB-C39C-4C75-8056-148026839A38}']
    procedure PrepareClient(const AClient: TCustomRESTClient);
    procedure PrepareRequest(const ARequest: TCustomRESTRequest);
    procedure CheckForResponseErrors(const AResponse: TCustomRESTResponse; AValidStatusCodes: array of Integer);
  end;

  // Wrapper
  TBackendCustomEndPointApi = class(TBackendAuthenticationApi)
  private
    FService: IBackendCustomEndpointService;
    FServiceApi: IBackendCustomEndpointApi;
    function GetServiceAPI: IBackendCustomEndpointApi;
  protected
    function GetAuthenticationApi: IBackendAuthenticationApi; override;
  public
    constructor Create(const AApi: IBackendCustomEndpointApi); overload;
    constructor Create(const AService: IBackendCustomEndpointService); overload;
    procedure PrepareClient(const AClient: TCustomRESTClient);
    procedure PrepareRequest(const ARequest: TCustomRESTRequest);
    procedure CheckForResponseErrors(const AResponse: TCustomRESTResponse; AValidStatusCodes: array of Integer);
    property ProviderAPI: IBackendCustomEndpointApi read GetServiceAPI;
  end;

implementation

uses System.SysUtils, REST.Backend.Consts, REST.Backend.Exception;

{ TBackendStorageApi }

function TBackendStorageApi.AddDateOption(ADateFormat: TJSONDateFormat; AOptions: TJSONOptions): TJSONOptions;
begin
   case ADateFormat of
      jdfISO8601 : Result := AOptions + [joDateFormatISO8601];
      jdfUnix : Result :=  AOptions + [ joDateFormatUnix];
      jdfMongo : Result :=  AOptions + [joDateFormatMongo];
      jdfParse : Result :=  AOptions + [joDateFormatParse];
   else
     Assert(False);
     Result := AOptions;
   end;
end;

procedure TBackendStorageApi.CreateObject(const AClass: TBackendMetaClass;
  const AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
begin
  GetServiceApi.CreateObject(AClass, nil, AJSON, ACreatedObject);
end;

procedure TBackendStorageApi.CreateObject(const AClass: TBackendMetaClass;
  const AACL, AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
begin
  GetServiceApi.CreateObject(AClass, AACL, AJSON, ACreatedObject);
end;

procedure TBackendStorageApi.CreateObject<T>(const AClass: TBackendMetaClass;
  const AObject: T; out ACreatedObject: TBackendEntityValue);
var
  LJSON: TJSONObject;
  LDateFormat: TJsonDateFormat;
  LOptions: TJsonOptions;
  LIntf: IBackendStorageAPI2;
begin
  if Supports(GetServiceAPI, IBackendStorageAPI2, LIntf) then
    LDateFormat := LIntf.GetJsonDateFormat
  else
    LDateFormat := jdfISO8601;
  LOptions :=  AddDateOption(LDateFormat, [joIgnoreEmptyStrings, joIgnoreEmptyArrays]);
  LJSON := TJSON.ObjectToJsonObject(AObject, LOptions);
  try
    CreateObject(AClass, LJSON, ACreatedObject);
  finally
    LJSON.Free;
  end;
end;

procedure TBackendStorageApi.CreateObject(const AClassName: string;
  const AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LClass: TBackendMetaClass;
begin
  LClass := CreateMetaClass(AClassName);
  CreateObject(LClass, AJSON, ACreatedObject);
end;

procedure TBackendStorageApi.CreateObject(const AClassName: string;
  const AACL, AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
var
  LClass: TBackendMetaClass;
begin
  LClass := CreateMetaClass(AClassName);
  CreateObject(LClass, AACL, AJSON, ACreatedObject);
end;

procedure TBackendStorageApi.CreateObject<T>(const AClassName: string;
  const AObject: T; out ACreatedObject: TBackendEntityValue);
var
  LClass: TBackendMetaClass;
begin
  LClass := CreateMetaClass(AClassName);
  CreateObject<T>(LClass, AObject, ACreatedObject);
end;

procedure TBackendStorageApi.CreateObject<T>(const AClassName: string;
  const AObject: T);
var
  LCreatedObject: TBackendEntityValue;
begin
  CreateObject<T>(AClassName, AObject, LCreatedObject);
end;

function TBackendStorageApi.DeleteObject(const AObject: TBackendEntityValue): Boolean;
begin
  Result := GetServiceApi.DeleteObject(AObject);
end;

function TBackendStorageApi.DeleteObject(const AClassName,
  AObjectID: string): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaClassObject(AClassName, AObjectID);
  Result := DeleteObject(LObject);
end;

function TBackendStorageApi.FindObject(const AMetaObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
begin
  Result := GetServiceAPI.FindObject(AMetaObject, AProc);
end;

function TBackendStorageApi.FindObject(const AClassName, AObjectID: string;
  AProc: TFindObjectProc): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaClassObject(AClassName, AObjectID);
  Result := FindObject(LObject, AProc);
end;

function TBackendStorageApi.FindObject<T>(const AMetaObject: TBackendEntityValue;
  AProc: TFindObjectProc<T>): Boolean;
var
  LJSON: TJSONObject;
  LDateFormat: TJsonDateFormat;
  LOptions: TJSONOptions;
  LIntf: IBackendStorageAPI2;
begin
  if Supports(GetServiceAPI, IBackendStorageAPI2, LIntf) then
    LDateFormat := LIntf.GetJsonDateFormat
  else
    LDateFormat := jdfISO8601;
  LOptions :=  AddDateOption(LDateFormat, []);
  Result := GetServiceAPI.FindObject(AMetaObject,
    procedure(const AInnerMetaObject: TBackendEntityValue; const AJSON: TJSONObject)
    var
      LObject: T;
    begin
      LObject := TJSON.JsonToObject<T>(AJSON, LOptions);
      try
        AProc(AInnerMetaObject, LObject);
      finally
        LObject.Free;
      end;
    end);
end;

function TBackendStorageApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendStorageApi.GetServiceAPI: IBackendStorageApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetStorageApi
end;

procedure TBackendStorageApi.QueryObjects(const AClassName: string;
  const AQuery: array of string; const AJSONArray: TJSONArray);
var
  LMetaClass:  TBackendMetaClass;
begin
  LMetaClass := CreateMetaClass(AClassName);
  QueryObjects(LMetaClass, AQuery, AJSONArray);
end;

procedure TBackendStorageApi.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AMetaArray: TArray<TBackendEntityValue>);
begin
  GetServiceApi.QueryObjects(AClass, AQuery, AJSONArray, AMetaArray);
end;

procedure TBackendStorageApi.QueryObjects(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  GetServiceApi.QueryObjects(AClass, AQuery, AJSONArray);
end;


procedure TBackendStorageApi.QueryObjects<T>(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AResultList: TBackendObjectList<T>);
var
  LJSONArray: TJSONArray;
  LJSONValue: TJSONValue;
  LMetaArray: TArray<TBackendEntityValue>;
  LObject: T;
  LList: TList<T>;
  I: Integer;
  LDateFormat: TJsonDateFormat;
  LOptions: TJSONOptions;
  LIntf: IBackendStorageAPI2;
begin
  if Supports(GetServiceAPI, IBackendStorageAPI2, LIntf) then
    LDateFormat := LIntf.GetJsonDateFormat
  else
    LDateFormat := jdfISO8601;
  LOptions :=  AddDateOption(LDateFormat, []);;
  LJSONArray := TJSONArray.Create;
  try
    QueryObjects(AClass, AQuery, LJSONArray, LMetaArray);
    I := 0;
    try
      for LJSONValue in LJSONArray do
      begin
        if LJSONValue is TJSONObject then
        begin
          LObject := TJSON.JsonToObject<T>(TJSONObject(LJSONValue), LOptions);
          AResultList.Add(LObject, LMetaArray[I]);
        end
        else
          raise EBackendServiceError.Create(sJSONObjectExpected);
        Inc(I);
      end;
    except
      AResultList.Clear;
      raise;
    end;
  finally
    LJSONArray.Free;
  end;
end;

procedure TBackendStorageApi.QueryObjects(const AClassName: string;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AMetaArray: TArray<TBackendEntityValue>);
var
  LMetaClass:  TBackendMetaClass;
begin
  LMetaClass := CreateMetaClass(AClassName);
  QueryObjects(LMetaClass, AQuery, AJSONArray, AMetaArray);
end;

procedure TBackendStorageApi.QueryObjects<T>(const AClassName: string;
  const AQuery: array of string; const AResultList: TBackendObjectList<T>);
var
  LMetaClass:  TBackendMetaClass;
begin
  LMetaClass := CreateMetaClass(AClassName);
  QueryObjects<T>(LMetaClass, AQuery, AResultList);
end;

procedure TBackendStorageApi.UpdateObject(const AObject: TBackendEntityValue;
  const AJSONObject: TJSONObject; out AUpdatedObject: TBackendEntityValue);
begin
  GetServiceAPI.UpdateObject(AObject, AJSONObject, AUpdatedObject);
end;

procedure TBackendStorageApi.UpdateObject(const AClassName, AObjectID: string;
  const AJSONObject: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaClassObject(AClassName, AObjectID);
  UpdateObject(LObject, AJSONObject, AUpdatedObject);
end;

procedure TBackendStorageApi.UpdateObject<T>(
  const AMetaObject: TBackendEntityValue; const AObject: T;
  out AUpdatedObject: TBackendEntityValue);
var
  LJSON: TJSONObject;
  LDateFormat: TJsonDateFormat;
  LOptions: TJSONOptions;
  LIntf: IBackendStorageAPI2;
begin
  if Supports(GetServiceAPI, IBackendStorageAPI2, LIntf) then
    LDateFormat := LIntf.GetJsonDateFormat
  else
    LDateFormat := jdfISO8601;
  LOptions :=  AddDateOption(LDateFormat, [joIgnoreEmptyStrings, joIgnoreEmptyArrays]);
  LJSON := TJSON.ObjectToJsonObject(AObject, LOptions);
  try
    UpdateObject(AMetaObject, LJSON, AUpdatedObject);
  finally
    LJSON.Free;
  end;
end;

constructor TBackendStorageApi.Create(const AApi: IBackendStorageApi);
begin
  FServiceApi := AApi;
  //FHelper := TBackendQueryObjectsHelper.Create(AApi);
end;

constructor TBackendStorageApi.Create(const AService: IBackendStorageService);
begin
  FService := AService;
end;

function TBackendStorageApi.CreateMetaClass(const AClassName: string): TBackendMetaClass;
var
  LFactory: IBackendMetaClassFactory;
begin
  if Supports(GetServiceApi.GetMetaFactory, IBackendMetaClassFactory, LFactory) then
    Result := LFactory.CreateMetaClass(AClassName)
  else
    raise EBackendServiceError.Create(sNoMetaFactory);
end;

function TBackendStorageApi.CreateMetaClassObject(const AClassName, AObjectID: string): TBackendEntityValue;
var
  LFactory: IBackendMetaClassObjectFactory;
begin
  if Supports(GetServiceApi.GetMetaFactory, IBackendMetaClassObjectFactory, LFactory) then
    Result := LFactory.CreateMetaClassObject(AClassName, AObjectID)
  else
    raise EBackendServiceError.Create(sNoMetaFactory);
end;

{ TBackendQueryApi }

constructor TBackendQueryApi.Create(const AApi: IBackendQueryApi);
begin
  FServiceApi := AApi;
end;

constructor TBackendQueryApi.Create(const AService: IBackendQueryService);
begin
  FService := AService;
end;

function TBackendQueryApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendQueryApi.GetServiceAPI: IBackendQueryApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetQueryApi
end;

procedure TBackendQueryApi.GetServiceNames(out ANames: TArray<string>);
begin
  GetServiceAPI.GetServiceNames(ANames);
end;

procedure TBackendQueryApi.Query(const ADataType, ABackendClassName: string;
  const AQuery: array of string; const AJSONArray: TJSONArray);
var
  LMetaClass:  TBackendMetaClass;
begin
  LMetaClass := CreateMetaDataType(ADataType, ABackendClassName);
  Query(LMetaClass, AQuery, AJSONArray);
end;

procedure TBackendQueryApi.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray);
begin
  GetServiceApi.Query(AClass, AQuery, AJSONArray);
end;

procedure TBackendQueryApi.Query(const AClass: TBackendMetaClass;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AMetaArray: TArray<TBackendEntityValue>);
begin
  GetServiceApi.Query(AClass, AQuery, AJSONArray, AMetaArray);
end;

function TBackendQueryApi.CreateMetaDataType(
  const ADataType, AClassName: string): TBackendMetaClass;
var
  LFactory: IBackendMetaDataTypeFactory;
begin
  if Supports(GetServiceApi.GetMetaFactory, IBackendMetaDataTypeFactory, LFactory) then
    Result := LFactory.CreateMetaDataType(ADataType, AClassName)
  else
    raise EBackendServiceError.Create(sNoMetaFactory);
end;

procedure TBackendQueryApi.Query(const ADataType, ABackendClassName: string;
  const AQuery: array of string; const AJSONArray: TJSONArray;
  out AMetaArray: TArray<TBackendEntityValue>);
var
  LMetaClass: TBackendMetaClass;
begin
  LMetaClass := CreateMetaDataType(ADataType, ABackendClassName);
  Assert(LMetaClass.BackendDataType = ADataType);
  Query(LMetaClass, AQuery, AJSONArray, AMetaArray);
end;

procedure TBackendQueryApi.Query<T>(const ADataType, ABackendClassName: string;
  const AQuery: array of string; const AResultList: TBackendObjectList<T>);
var
  LMetaClass: TBackendMetaClass;
begin
  LMetaClass := CreateMetaDataType(ADataType, ABackendClassName);
  Query<T>(LMetaClass, AQuery, AResultList);
end;

procedure TBackendQueryApi.Query<T>(const ADataType: TBackendMetaClass;
  const AQuery: array of string; const AResultList: TBackendObjectList<T>);
var
  LJSONArray: TJSONArray;
  LJSONValue: TJSONValue;
  LMetaArray: TArray<TBackendEntityValue>;
  LObject: T;
  LList: TList<T>;
  I: Integer;
begin
  LJSONArray := TJSONArray.Create;
  try
    Query(ADataType, AQuery, LJSONArray, LMetaArray);
    I := 0;
    try
      for LJSONValue in LJSONArray do
      begin
        if LJSONValue is TJSONObject then
        begin
          LObject := TJSON.JsonToObject<T>(TJSONObject(LJSONValue), []);
          AResultList.Add(LObject, LMetaArray[I]);
        end
        else
          raise EBackendServiceError.Create(sJSONObjectExpected);
        Inc(I);
      end;
    except
      AResultList.Clear;
      raise;
    end;
  finally
    LJSONArray.Free;
  end;
end;

{ TBackendUsersApi }
constructor TBackendUsersApi.Create(const AApi: IBackendUsersApi);
begin
  inherited Create(AApi);
  FServiceApi := AApi;
end;

constructor TBackendUsersApi.Create(const AService: IBackendUsersService);
begin
  FService := AService;
end;

function TBackendUsersApi.CreateMetaUserObject(const AObjectID: string): TBackendEntityValue;
var
  LFactory: IBackendMetaUserFactory;
begin
  if Supports(GetServiceApi.GetMetaFactory, IBackendMetaUserFactory, LFactory) then
    Result := LFactory.CreateMetaUserObject(AObjectID)
  else
    raise EBackendServiceError.Create(sNoMetaFactory);
end;

function TBackendFilesApi.CreateMetaFileObject(const AFileID: string): TBackendEntityValue;
var
  LFactory: IBackendMetaFileFactory;
begin
  if Supports(GetServiceApi.GetMetaFactory, IBackendMetaFileFactory, LFactory) then
    Result := LFactory.CreateMetaFileObject(AFileID)
  else
    raise EBackendServiceError.Create(sNoMetaFactory);
end;


function TBackendUsersApi.DeleteUser(
  const AObject: TBackendEntityValue): Boolean;
begin
  Result := GetServiceApi.DeleteUser(AObject);
end;

function TBackendUsersApi.FindUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
begin
  Result := GetServiceApi.FindUser(AObject, AProc);
end;

function TBackendUsersApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendUsersApi.GetAuthApi: IBackendAuthApi;
begin
  Result := GetServiceApi as IBackendAuthApi;
end;

function TBackendUsersApi.GetServiceAPI: IBackendUsersApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetUsersApi
end;

function TBackendUsersApi.DeleteUser(const AObjectID: string): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaUserObject(AObjectID);
  Result := DeleteUser(LObject);
end;

function TBackendUsersApi.FindUser(const AObjectID: string;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaUserObject(AObjectID);
  Result := GetServiceApi.FindUser(LObject, AUser, AJSON);
end;

function TBackendUsersApi.FindUser(const AObject: TBackendEntityValue;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
begin
  Result := GetServiceApi.FindUser(AObject, AUser, AJSON);
end;

function TBackendUsersApi.FindUser(const AObjectID: string;
  AProc: TFindObjectProc): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaUserObject(AObjectID);
  Result := FindUser(LObject, AProc);
end;

function TBackendUsersApi.QueryUserName(const AUserName: string;
  AProc: TFindObjectProc): Boolean;
begin
  Result := GetServiceAPI.QueryUserName(AUserName, AProc);
end;

procedure TBackendUsersApi.QueryUsers(const AQuery: array of string;
  const AJSONArray: TJSONArray);
begin
  GetServiceApi.QueryUsers(AQuery, AJSONArray);
end;

function TBackendUsersApi.QueryUserName(const AUserName: string;
  out AUser: TBackendEntityValue; const AJSON: TJSONArray): Boolean;
begin
  Result := GetServiceApi.QueryUserName(AUserName, AUser, AJSON);
end;

procedure TBackendUsersApi.QueryUsers(const AQuery: array of string;
  const AJSONArray: TJSONArray; out AMetaArray: TArray<TBackendEntityValue>);
begin
  GetServiceApi.QueryUsers(AQuery, AJSONArray, AMetaArray);
end;

procedure TBackendUsersApi.UpdateUser(const AObjectID: string;
  const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaUserObject(AObjectID);
  UpdateUser(LObject, AUserData, AUpdatedObject);
end;

{ TBackendGroupsApi }

constructor TBackendGroupsApi.Create(const AApi: IBackendGroupsApi);
begin
  FServiceApi := AApi;
end;

procedure TBackendGroupsApi.AddUser(const AGroupName, AUser: string; out AUpdatedObject: TBackendEntityValue);
begin
  GetServiceApi.AddUsers(AGroupName, TArray<string>.Create(AUser), AUpdatedObject);
end;

function TBackendGroupsApi.RemoveUser(const AGroupName, AUser: string; out AUpdatedObject: TBackendEntityValue): Boolean;
begin
  Result := GetServiceApi.RemoveUsers(AGroupName, TArray<string>.Create(AUser), AUpdatedObject);
end;

procedure TBackendGroupsApi.AddUsers(const AGroupName: string;
  const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue);
begin
  GetServiceApi.AddUsers(AGroupName, AUsers, AUpdatedObject);
end;

function TBackendGroupsApi.RemoveUsers(const AGroupName: string;
  const AUsers: TArray<string>; out AUpdatedObject: TBackendEntityValue): Boolean;
begin
  Result := GetServiceApi.RemoveUsers(AGroupName, AUsers, AUpdatedObject);
end;

procedure TBackendGroupsApi.UpdateGroup(const AGroup: TBackendEntityValue;
  const AJSONObject: TJSONObject; out AUpdatedObject: TBackendEntityValue);
begin
  GetServiceApi.UpdateGroup(AGroup, AJSONObject, AUpdatedObject);
end;

constructor TBackendGroupsApi.Create(const AService: IBackendGroupsService);
begin
  FService := AService;
end;

procedure TBackendGroupsApi.CreateGroup(const AGroupName: string;
  const AJSON: TJSONObject; out ACreatedObject: TBackendEntityValue);
begin
  GetServiceApi.CreateGroup(AGroupName, AJSON, ACreatedObject);
end;

function TBackendGroupsApi.CreateMetaGroupObject(const AGroupName: string): TBackendEntityValue;
var
  LFactory: IBackendMetaGroupFactory;
begin
  if Supports(GetServiceApi.GetMetaFactory, IBackendMetaGroupFactory, LFactory) then
    Result := LFactory.CreateMetaGroupObject(AGroupName)
  else
    raise EBackendServiceError.Create(sNoMetaFactory);
end;

function TBackendGroupsApi.DeleteGroup(
  const AGroup: TBackendEntityValue): Boolean;
begin
  Result := GetServiceApi.DeleteGroup(AGroup);
end;

function TBackendGroupsApi.DeleteGroup(const AGroupName: string): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaGroupObject(AGroupName);
  Result := DeleteGroup(LObject);
end;

function TBackendGroupsApi.FindGroup(const AMetaObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
begin
  Result := GetServiceApi.FindGroup(AMetaObject, AProc);
end;

function TBackendGroupsApi.FindGroup(const AGroupName: string;
  AProc: TFindObjectProc): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaGroupObject(AGroupName);
  Result := GetServiceApi.FindGroup(LObject, AProc);
end;

function TBackendGroupsApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendGroupsApi.GetServiceAPI: IBackendGroupsApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetGroupsAPI
end;


{ TBackendAuthApi }

constructor TBackendAuthApi.Create(const AApi: IBackendAuthApi);
begin
  FServiceApi := AApi;
end;

constructor TBackendAuthApi.Create(const AService: IBackendAuthService);
begin
  FService := AService;
end;

function TBackendAuthApi.CreateMetaUserObject(const AObjectID: string): TBackendEntityValue;
var
  LFactory: IBackendMetaUserFactory;
begin
  if Supports(GetServiceApi.GetMetaFactory, IBackendMetaUserFactory, LFactory) then
    Result := LFactory.CreateMetaUserObject(AObjectID)
  else
    raise EBackendServiceError.Create(sNoMetaFactory);
end;

function TBackendAuthApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendAuthApi.GetServiceAPI: IBackendAuthApi;
begin
  Result := GetAuthApi;
end;

function TBackendAuthApi.GetAuthAPI: IBackendAuthApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetAuthAPI
end;

function TBackendAuthApi.FindCurrentUser(const AObject: TBackendEntityValue;
  AProc: TFindObjectProc): Boolean;
begin
  Result := GetServiceApi.FindCurrentUser(AObject, AProc);
end;

procedure TBackendAuthApi.LoginUser(const AUserName, APassword: string;
  out ALogin: TBackendEntityValue; const AJSON: TJSONArray);
begin
  GetServiceApi.LoginUser(AUserName, APassword, ALogin, AJSON);
end;

procedure TBackendAuthApi.LoginUser(const AUserName, APassword: string;
  AProc: TFindObjectProc);
begin
  GetServiceApi.LoginUser(AUserName, APassword, Aproc);
end;

procedure TBackendAuthApi.SignupUser(const AUserName, APassword: string;
  const AUserData: TJSONObject; out ACreatedObject: TBackendEntityValue);
begin
  GetServiceApi.SignupUser(AUserName, APassword, AUserData, ACreatedObject);
end;

procedure TBackendAuthApi.UpdateUser(const AObject: TBackendEntityValue;
  const AUserData: TJSONObject; out AUpdatedObject: TBackendEntityValue);
begin
  GetServiceApi.UpdateUser(AObject, AUserData, AUpdatedObject);
end;


{ TBackendFilesApi }
constructor TBackendFilesApi.Create(const AApi: IBackendFilesApi);
begin
  FServiceApi := AApi;
end;

constructor TBackendFilesApi.Create(const AService: IBackendFilesService);
begin
  FService := AService;
end;

function TBackendFilesApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendFilesApi.GetServiceAPI: IBackendFilesApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetFilesApi
end;

procedure TBackendFilesApi.UploadFile(const AFileName, AContentType: string;
  out AFile: TBackendEntityValue);
begin
  GetServiceApi.UploadFile(AFileName, AContentType, AFile);
end;

function TBackendFilesApi.DeleteFile(const AFile: TBackendEntityValue): Boolean;
begin
  Result := GetServiceApi.DeleteFile(AFile);
end;

function TBackendFilesApi.DeleteFile(const AFileID: string): Boolean;
var
  LObject: TBackendEntityValue;
begin
  LObject := CreateMetaFileObject(AFileID);
  Result := DeleteFile(LObject);
end;

procedure TBackendFilesApi.UploadFile(const AFileName: string;
  const AStream: TStream; const AContentType: string;
  out AFile: TBackendEntityValue);
begin
  GetServiceApi.UploadFile(AFileName, AStream, AContentType, AFile);
end;

{ TBackendObjectList<T> }

constructor TBackendObjectList<T>.Create;
begin
  FDictionary := TObjectDictionary.Create;
  FList := TList<T>.Create;
end;

destructor TBackendObjectList<T>.Destroy;
begin
  Clear;
  FDictionary.Free;
  FList.Free;
  inherited;
end;

function TBackendObjectList<T>.Extract(const Value: T): T;
var
  I: Integer;
begin
  I := FList.IndexOf(Value);
  if I >= 0 then
  begin
    Result := FList[I];
    FList.Delete(I);
    FDictionary.Remove(Result);
  end
  else
    raise EBackendServiceError.Create(sObjectNotFound);
end;

function TBackendObjectList<T>.ExtractArray: TArray<T>;
var
  LPair: TObjectPair;
  LList: TList<T>;
begin
  LList := TList<T>.Create;
  try
    for LPair in FDictionary do
      LList.Add(LPair.Key);
    FDictionary.Clear; // Does not free objects
    Result := LList.ToArray;
  finally
    LList.Free;
  end;
end;

procedure TBackendObjectList<T>.Add(const AValue: T;
  const AMetaObject: TBackendEntityValue);
begin
  FDictionary.Add(AValue, AMetaObject);
  FList.Add(AValue);
end;

procedure TBackendObjectList<T>.Clear;
var
  LList: TList<T>;
begin
  LList := TObjectList<T>.Create;
  try
    LList.AddRange(FList.ToArray);
    FDictionary.Clear; // Does not free objects
    FList.Clear;
  finally
    LList.Free; // Free objects
  end;
end;

function TBackendObjectList<T>.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TBackendObjectList<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator.Create(FList);
end;

function TBackendObjectList<T>.GetItem(I: Integer): T;
begin
  Result := FList[I];
end;

function TBackendObjectList<T>.IndexOf(I: T): Integer;
begin
  Result := FList.IndexOf(I);
end;

function TBackendObjectList<T>.GetEntityValue(I: T): TBackendEntityValue;
begin
  Result := FDictionary.Items[I];
end;

{ TBackendObjectList<T>.TEnumerator }

constructor TBackendObjectList<T>.TEnumerator.Create(const AList: TObjectList);
begin
  FList := AList;
  FIndex := -1;
end;

function TBackendObjectList<T>.TEnumerator.DoGetCurrent: T;
begin
  if (FIndex < FList.Count) and (FIndex >= 0) then
    Result := FList[FIndex]
  else
    Result := nil;
end;

function TBackendObjectList<T>.TEnumerator.DoMoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < FList.Count;
end;

{ TBackendAuthenticationApi }

function TBackendAuthenticationApi.GetAuthentication: TBackendAuthentication;
begin
  Result := GetAuthenticationApi.Authentication;
end;

function TBackendAuthenticationApi.GetDefaultAuthentication: TBackendDefaultAuthentication;
begin
  Result := GetAuthenticationApi.DefaultAuthentication;
end;

procedure TBackendAuthenticationApi.Login(const ALogin: TBackendEntityValue);
begin
  GetAuthenticationApi.Login(ALogin);
end;

procedure TBackendAuthenticationApi.Logout;
begin
  GetAuthenticationApi.Logout;
end;

procedure TBackendAuthenticationApi.SetAuthentication(
  const Value: TBackendAuthentication);
begin
  GetAuthenticationApi.Authentication := Value;
end;

procedure TBackendAuthenticationApi.SetDefaultAuthentication(
  const Value: TBackendDefaultAuthentication);
begin
  GetAuthenticationApi.DefaultAuthentication := Value;
end;

{ TBackendCustomEndpointApi }

constructor TBackendCustomEndpointApi.Create(const AApi: IBackendCustomEndpointApi);
begin
  FServiceApi := AApi;
end;

procedure TBackendCustomEndPointApi.CheckForResponseErrors(
  const AResponse: TCustomRESTResponse; AValidStatusCodes: array of Integer);
begin
  GetServiceApi.CheckForResponseErrors(AResponse, AValidStatusCodes);
end;

constructor TBackendCustomEndpointApi.Create(const AService: IBackendCustomEndpointService);
begin
  FService := AService;
end;

function TBackendCustomEndpointApi.GetAuthenticationApi: IBackendAuthenticationApi;
begin
  Result := GetServiceApi as IBackendAuthenticationApi;
end;

function TBackendCustomEndpointApi.GetServiceAPI: IBackendCustomEndpointApi;
begin
  if FServiceApi <> nil then
    Result := FServiceAPI
  else
    Result := FService.GetCustomEndpointApi
end;

procedure TBackendCustomEndPointApi.PrepareClient(
  const AClient: TCustomRESTClient);
begin
  GetServiceApi.PrepareClient(AClient);
end;

procedure TBackendCustomEndPointApi.PrepareRequest(
  const ARequest: TCustomRESTRequest);
begin
  GetServiceApi.PrepareRequest(ARequest);
end;

end.
