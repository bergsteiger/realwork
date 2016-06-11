{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit EMS.Services;

interface

uses System.SysUtils, System.Classes, EMS.ResourceAPI, EMS.ResourceTypes,
  System.JSON, System.Generics.Collections;


type

  TEMSApplicationService = class
  public
    class procedure AddStartupNotification(AProc: TProc); // FIFO order
    class procedure AddShutdownNotification(AProc: TProc); // LIFO order
  end;

  TEMSServices = class
  public
    class function GetService<T: IInterface>: T;
    class function TryGetService<T: IInterface>(out Intf: T): Boolean;
  end;

  IEMSLoggingService = interface;

  TEMSLoggingService = class
  private
    class function GetLoggingEnabled: Boolean; static;
    class function GetService: IEMSLoggingService; static;
  public
    class procedure Log(const ACategory: string; const AJSON: TJSONObject);
    class property LoggingEnabled: Boolean read GetLoggingEnabled;
  end;

  IEMSServices = interface(IInterface)
    ['{E9E681C2-3399-4D55-A294-F20E2A59BE35}']
    function SupportsService(const Service: TGUID): Boolean;
    function GetService(const Service: TGUID): IInterface; overload;
    function TryGetService(const Service: TGUID; out Svc): Boolean; overload;
  end;

  IEMSEndPointSegmentsService = interface
    ['{15ECD41C-D332-48BA-9C3E-67152EF24205}']
    procedure ExtractSegments(const AString: string; const AList: TEMSEndPointSegmentList);
    function CountSegments(const AValue: string): Integer;
  end;

  IEMSApplicationService = interface
    ['{D5D6FAF8-9AFE-4A9A-81BB-659016EDB179}']
    /// <summary>Used internally to tell this service to send startup notifications</summary>
    procedure Startup;
    /// <summary>Used internally to tell this service to send shutdown notifications</summary>
    procedure Shutdown;
    procedure AddStartupNotification(AProc: TProc); // FIFO order
    procedure AddShutdownNotification(AProc: TProc); // LIFO order
  end;

  IEMSLoggingService = interface
    ['{261E2580-D991-4E1B-9FFF-D68EBD2DEB6F}']
    function GetLoggingEnabled: Boolean;
    procedure Log(const ACategory: string; const AJSON: TJSONObject);
    property LoggingEnabled: Boolean read GetLoggingEnabled;
  end;

  /// <summary>Query parameter name/value pair</summary>
  TEMSResourceRequestQueryParam = TPair<string, string>;
  /// <summary>Array of query parameters</summary>
  TEMSResourceRequestQueryParams = TArray<TPair<string, string>>;
  /// <summary>Array of URL segments</summary>
  TEMSResourceRequestSegments = TArray<string>;

  /// <summary>Context of an EMS Resource request to the EMS Server.</summary>
  IEMSResourceRequestContext = interface

  end;

  /// <summary>Content of an EMS Resource request.</summary>
  IEMSResourceRequestContent = interface

  end;

  /// <summary>Response to a resource request that you executed.</summary>
  IEMSResourceResponseContent = interface
    /// <summary>Get the HTTP status code, such as 200</summary>
    function GetStatusCode: Integer;
    /// <summary>Get the content type such as "application/json"</summary>
    function GetContentType: string;
    /// <summary>Try to get a stream from the response.  False is returned if the response does not have content.</summary>
    function TryGetStream(out AStream: TStream): Boolean; overload;
    /// <summary>Try to get a stream from the response.  False is returned if the response does not have content.</summary>
    function TryGetStream(out AStream: TStream; out AContentType: string): Boolean; overload;
    /// <summary>Try to get a JSON object from the response.  False is returned if the response does not provide this type.</summary>
    function TryGetObject(out AJSONObject: TJSONObject): Boolean;
    /// <summary>Try to get a JSON array from the response.  False is returned if the response does not provide this type.</summary>
    function TryGetArray(out AJSONArray: TJSONArray): Boolean;
    /// <summary>Try to get a JSON value from the response.  False is returned if the response does not provide this type.</summary>
    function TryGetValue(out AJSONValue: TJSONValue): Boolean;
    /// <summary>Try to get an byte array from the response.  False is returned if the response does not have content.</summary>
    function TryGetBytes(out ABytes: TBytes): Boolean;
    /// <summary>Try to get a stream from the response.  An exception is raised if the response does not have content.</summary>
    function GetStream: TStream;
    /// <summary>Try to get a JSON object from the response.  An exception is raised if the response does not provide this type.</summary>
    function GetObject: TJSONObject;
    /// <summary>Try to get a JSON array from the response.  An exception is raised if the response does not provide this type.</summary>
    function GetArray: TJSONArray;
    /// <summary>Try to get a JSON value from the response.  An exception is raised if the response does not provide this type.</summary>
    function GetValue: TJSONValue;
    /// <summary>Try to get an byte array from the response.  An exception is raised if the response does not have content.</summary>
    function GetBytes: TBytes;
    /// <summary>Get the content type such as "application/json"</summary>
    property ContentType: string read GetContentType;
    /// <summary>Get the HTTP status code, such as 200</summary>
    property StatusCode: Integer read GetStatusCode;
  end;

  /// <summary>Base interface for services that make requests to
  /// resources.</summary>
  IEMSResourceRequest = interface
    /// <summary>Create a context using the context parameter passed to aa custom resource endpoint. If the TEndpointContext identifies a user, the result will identify then same user.</summary>
    function CreateRequestContext(const AContext: TEndpointContext): IEMSResourceRequestContext;
    /// <summary>Create content/payload from a JSON value.</summary>
    function CreateRequestContent(const AJSON: TJSONValue): IEMSResourceRequestContent; overload;
    /// <summary>Create content/payload from a stream.</summary>
    function CreateRequestContent(const AContentType: string; const AStream: TStream): IEMSResourceRequestContent; overload;
    /// <summary>Create content/payload from a byte array.</summary>
    function CreateRequestContent(const AContentType: string; const ABytes: TBytes): IEMSResourceRequestContent; overload;

    /// <summary>Execute a resource request that passes content/payload.  Typically this version of Execute is used for PUT and POST requests.</summary>
    function Execute(const AContext: IEMSResourceRequestContext;
      const AMethodType: TEndpointRequest.TMethod; const AResourceName: string;
      const ASegments: TEMSResourceRequestSegments;
      const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent; overload;

    /// <summary>Execute a resource request that does not pass content/payload.  Typically this version of Execute is used for GET and DELETE requests.</summary>
    function Execute(const AContext: IEMSResourceRequestContext;
      AMethodType: TEndpointRequest.TMethod; const AResourceName: string;
      const ASegments: TEMSResourceRequestSegments;
      const AQueryParams: TEMSResourceRequestQueryParams): IEMSResourceResponseContent;  overload;

    /// <summary>Execute DELETE resource request.</summary>
    function Delete(const AContext: IEMSResourceRequestContext; const AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams): IEMSResourceResponseContent;
    /// <summary>Execute GET resource request.</summary>
    function Get(const AContext: IEMSResourceRequestContext; const AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams): IEMSResourceResponseContent;
    /// <summary>Execute PATCH resource request.</summary>
    function Patch(const AContext: IEMSResourceRequestContext; const AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
    /// <summary>Execute POST resource request.</summary>
    function Post(const AContext: IEMSResourceRequestContext; const AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
    /// <summary>Execute PUT resource request.</summary>
    function Put(const AContext: IEMSResourceRequestContext; const AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
  end;

  /// <summary>Service for executing internal EMS resource endpoint requests
  /// from another custom EMS resource endpoint implementations.</summary>
  IEMSInternalResourceRequestService = interface(IEMSResourceRequest)
    ['{0C98920E-E524-4917-8F00-AC968C0A9D13}']
  end;

  /// <summary>Interface that provides methods to execute EMS Edge Module
  /// resource request from custom EMS Resource endpoint
  /// implementations.</summary>
  IEMSModuleResourceRequest = interface(IEMSResourceRequest)
    function GetModuleName: string;
    /// <summary>Get the name of the module.</summary>
    property ModuleName: string read GetModuleName;
  end;

  /// <summary>Service interface for executing EMS Edge Module resource requests
  /// from custom EMS Resource endpoint implementation.</summary>
  IEMSModuleResourceRequestService = interface
    ['{24772850-762F-43FA-9B9E-0818750F0E06}']
    function CreateRequest(const AModuleName: string): IEMSModuleResourceRequest;
  end;


  /// <summary>Supports internal executing of built-in EMS Resource endpoints
  /// from a custom EMS Resource endpoint implementation.</summary>
  TEMSInternalAPI = class
  private
    FContext: IEMSResourceRequestContext;
    FService: IEMSInternalResourceRequestService;
  public type
    /// <summary>Names used to format JSON objects which are passed to built-in endpoints.</summary>
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
      GroupUsers = 'users';
    end;

    /// <summary>Names of resources and URL segments which are used to execute build-in endpoints</summary>
    TSegmentNames = record
    public const
      Users = 'users';
      Groups = 'groups';
      Installations = 'installations';
      Edgemodules = 'edgemodules';
      Resources = 'resources';
      Login = 'login';
      Signup = 'signup';
      Logout = '_logout';
      Me = 'me';
      Push = 'push';
    end;

    /// <summary>Query parameter name/value pair.</summary>
    TQueryParam = TPair<string, string>;
    /// <summary>Array of query parameters.</summary>
    TQueryParams = TArray<TQueryParam>;
    /// <summary>Names used in built-in endpoint query parameters.</summary>
    TQueryParamNames = record
    public const
      Order = 'order';
      Where = 'where';
      Limit = 'limit';
      Skip = 'skip';
    end;

  public
    /// <summary>Create an api class that uses the context passed to a custom endpoint.</summary>
    constructor Create(const AContext: TEndpointContext);
    // Users
    /// <summary>Add a new EMS user.  User fields parameter my be nil.</summary>
    function AddUser(const AUserName, APassword: string;
      const AUserFields: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Add a new EMS user.  JSON parameter must include username and password.</summary>
    function AddUser(const AJSONBody: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Delete an EMS user.  False is returned if the user was not found.</summary>
    function DeleteUser(const AObjectID: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Delete an EMS user.  False is returned if the user was not found.</summary>
    function DeleteUser(const AObjectID: string): Boolean; overload;
    /// <summary>Login an EMS user.</summary>
    function LoginUser(const AUserName, APassword: string): IEMSResourceResponseContent; overload;
    /// <summary>Login an EMS user.  JSON parameter must include username and password.</summary>
    function LoginUser(const AJSONLogin: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Logout a user.  This causes the server-side session id to be cleared.  All clients will need to re-login.</summary>
    function Logout: IEMSResourceResponseContent; overload;
    /// <summary>Get the user with a give user name.  False is returned if the user was not found.</summary>
    function QueryUserName(const AUserName: string;
      out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>>Get the user with a give user name.  False is returned if the user was not found.</summary>
    function QueryUserName(const AUserName: string): Boolean; overload;
    /// <summary>Retreive users using query parameters.  If the parameters are empty then the result is unfiltered and unordered.</summary>
    function QueryUsers(const AQuery: TQueryParams): IEMSResourceResponseContent; overload;
    /// <summary>Get the properties of a user.  False is returned if the user was not found.</summary>
    function RetrieveUser(const AObjectID: string; out AResponse: IEMSResourceResponseContent): Boolean;
    /// <summary>Signup a user.  The response will include the session id.</summary>
    function SignupUser(const AUserName, APassword: string;
      const AUserFields: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Signup a user.  The JSON parameter must include the username and password.  The response will include the session id.</summary>
    function SignupUser(const AJSONBody: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Update the fields of a user.  This method may be used to add custom name/value pairs to the object.  To delete a custom name/value pair, pass a null value in the JSON object (e.g.; "SomeName":null)</summary>
    function UpdateUser(const AObjectID: string;
      const AUserFields: TJSONObject): IEMSResourceResponseContent; overload;
    // Groups
    /// <summary>Add one or more users to a group.  The group parameter must identify an existing group.</summary>
    function AddUsersToGroup(const AGroupName: string;
      const AUsers: TArray<string>): IEMSResourceResponseContent;
    /// <summary>Create a user group.</summary>
    function CreateGroup(const AGroupName: string;
      const AGroupFields: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Create a user group.</summary>
    function CreateGroup(const AJSONBody: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Delete a user group.</summary>
    function DeleteGroup(const AGroupName: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Delete a user group.</summary>
    function DeleteGroup(const AGroupName: string): Boolean; overload;
    /// <summary>Retreive groups using query parameters.  If the parameters are empty then the result is unfiltered and unordered.</summary>
    function QueryGroups(const AQuery: TQueryParams): IEMSResourceResponseContent;
    /// <summary>Remove one or more users from a group.</summary>
    function RemoveUsersFromGroup(const AGroupName: string;
      const AUsers: TArray<string>; out AResponse: IEMSResourceResponseContent): Boolean;
    /// <summary>Retrieve a user group.  False is returned if the group was not found.</summary>
    function RetrieveGroup(const AGroupName: string; out AResponse: IEMSResourceResponseContent): Boolean;
    /// <summary>Update the fields of a user group.  This method may be used to add custom name/value pairs to the object.  To delete a custom name/value pair, pass a null value in the JSON object (e.g.; "SomeName":null)</summary>
    function UpdateGroup(const AGroupName: string;
      const AGroupFields: TJSONObject): IEMSResourceResponseContent; overload;
    // Installations
    /// <summary>Delete an installation.  False is returned if the installation was not found.</summary>
    function DeleteInstallation(const AInstallationID: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Delete an installation.  False is returned if the installation was not found.</summary>
    function DeleteInstallation(const AInstallationID: string): Boolean; overload;
    /// <summary>Retreive installations using query parameters.  If the parameters are empty then the result is unfiltered and unordered.</summary>
    function QueryInstallations(const AQuery: TQueryParams): IEMSResourceResponseContent;
    /// <summary>Retrieve a paraticular installation.  False is returned if the installation was not found.</summary>
    function RetrieveInstallation(const AInstallationID: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Update the fields of an installation.  This method may be used to add custom name/value pairs to the object.  To delete a custom name/value pair, pass a null value in the JSON object (e.g.; "SomeName":null)</summary>
    function UpdateInstallation(const AInstallationID: string; const AJSONObject: TJSONObject): IEMSResourceResponseContent; overload;
    // Push
    /// <summary>Broadcast a push notification to all installations.</summary>
    function PushBroadcast(const AData: TJSONObject): IEMSResourceResponseContent;
    /// <summary>Send a push notfication to particular installations.  A target parameters identifies which installations.  The target may identifiy channels and/or a where filter such as {"where":{"email":"xyz@xmail.com"}, "channels": ["a","b"]}"</summary>
    function PushToTarget(const AData: TJSONObject; const ATarget: TJSONObject): IEMSResourceResponseContent;
    /// <summary>Send a push notification to installations associated with channels</summary>
    function PushToChannels(const AData: TJSONObject; const AChannels: array of string): IEMSResourceResponseContent;
    /// <summary>Send a push notification to installations identified by a where filter such as {"email":"xyz@xmail.com"} </summary>
    function PushWhere(const AData: TJSONObject; const AWhere: TJSONObject): IEMSResourceResponseContent;
    // Edge modules and resources
    /// <summary>Delete an edge module.  False is returned if the module was not found.</summary>
    function UnregisterModule(const AModuleName: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Delete an edge module.  False is returned if the module was not found.</summary>
    function UnregisterModule(const AModuleName: string): Boolean; overload;
    /// <summary>Delete an edge resource.  False is returned if the resource was not found.</summary>
    function UnregisterModuleResource(const AModuleName, AResourceName: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Delete an edge resource.  False is returned if the resource was not found.</summary>
    function UnregisterModuleResource(const AModuleName, AResourceName: string): Boolean; overload;
    /// <summary>Retreive modules using query parameters.  If the parameters are empty then the result is unfiltered and unordered.</summary>
    function QueryModules(const AQuery: TQueryParams): IEMSResourceResponseContent;
    /// <summary>Retreive module resources using query parameters.  If the parameters are empty then the result is unfiltered and unordered.</summary>
    function QueryModuleResources(const AQuery: TQueryParams): IEMSResourceResponseContent; overload;
    /// <summary>Retreive module resources using query parameters.  If the parameters are empty then the result is unfiltered and unordered.</summary>
    function QueryModuleResources(const AModuleName: string; const AQuery: TQueryParams): IEMSResourceResponseContent; overload;
    /// <summary>Retrieve a particular module.  False is returned if the module was not found.</summary>
    function RetrieveModule(const AModuleName: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Retrieve a particular module resource.  False is returned if the module resource was not found.</summary>
    function RetrieveModuleResource(const AModuleName, AResourceName: string; out AResponse: IEMSResourceResponseContent): Boolean; overload;
    /// <summary>Update the fields of a module.  This method may be used to add custom name/value pairs to the object.  To delete a custom name/value pair, pass a null value in the JSON object (e.g.; "SomeName":null)</summary>
    function UpdateModule(const AModuleName: string; const AJSONObject: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Update the fields of a module resource.  This method may be used to add custom name/value pairs to the object.  To delete a custom name/value pair, pass a null value in the JSON object (e.g.; "SomeName":null)</summary>
    function UpdateModuleResource(const AModuleName, AResourceName: string; const AJSONObject: TJSONObject): IEMSResourceResponseContent; overload;
    /// <summary>Execute DELETE resource request.</summary>
    function ModuleResourceDelete(const AModuleName, AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams): IEMSResourceResponseContent;
    /// <summary>Execute GET resource request.</summary>
    function ModuleResourceGet(const AModuleName, AResourceName: string;  const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams): IEMSResourceResponseContent;
    /// <summary>Execute PATCH resource request.</summary>
    function ModuleResourcePatch(const AModuleName, AResourceName: string;  const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
    /// <summary>Execute POST resource request.</summary>
    function ModuleResourcePost(const AModuleName, AResourceName: string;  const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
    /// <summary>Execute PUT resource request.</summary>
    function ModuleResourcePut(const AModuleName, AResourceName: string;  const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
  end;

  /// <summary>Exception that may raise when you interact with the members of
  /// the TEMSInternalAPI class.</summary>
  EEMSInternalAPIError = class(Exception);

var
 (* The EMSServices global variable is initialized by the EMS server.
    From this interface all of the IxxxxServices interfaces
    may be queried for.
  *)
  EMSServices: IEMSServices;

implementation

uses System.TypInfo, EMS.Consts;

{ TEMSServices }

class function TEMSServices.GetService<T>: T;
var
  LGuid: TGuid;
  LIntf: IInterface;
begin
  LGuid := GetTypeData(TypeInfo(T))^.Guid;
  LIntf := EMSServices.GetService(LGuid);
  Result := T(LIntf);
end;

class function TEMSServices.TryGetService<T>(out Intf: T): Boolean;
var
  LGuid: TGuid;
  LIntf: IInterface;
begin
  LGuid := GetTypeData(TypeInfo(T))^.Guid;
  Result := EMSServices.TryGetService(LGuid, LIntf);
  if Result then
    Intf := T(LIntf);

end;

{ TEMSApplicationService }

class procedure TEMSApplicationService.AddShutdownNotification(AProc: TProc);
begin
  Assert( TEMSServices.GetService<IEMSApplicationService> <> nil);
  TEMSServices.GetService<IEMSApplicationService>.AddShutdownNotification(AProc);
end;

class procedure TEMSApplicationService.AddStartupNotification(AProc: TProc);
begin
  Assert( TEMSServices.GetService<IEMSApplicationService> <> nil);
  TEMSServices.GetService<IEMSApplicationService>.AddStartupNotification(AProc);
end;

{ TEMSLoggingService }

class procedure TEMSLoggingService.Log(const ACategory: string;
  const AJSON: TJSONObject);
var
  LService: IEMSLoggingService;
begin
  LService := GetService;
  if (LService <> nil) and (LService.LoggingEnabled) then
    LService.Log(ACategory, AJSON);
end;

class function TEMSLoggingService.GetLoggingEnabled: Boolean;
var
  LService: IEMSLoggingService;
begin
  LService := GetService;
  if LService <> nil then
    Result := LService.LoggingEnabled
  else
    Result := False;
end;

class function TEMSLoggingService.GetService: IEMSLoggingService;
begin
  if not EMS.Services.EMSServices.TryGetService(IEMSLoggingService, Result) then
    Result := nil;
end;

{ TEMSInternalAPI }

function TEMSInternalAPI.AddUser(const AUserName, APassword: string;
  const AUserFields: TJSONObject): IEMSResourceResponseContent;
var
  LJSON: TJSONObject;
begin
  if AUserFields <> nil then
    LJSON := AUserFields.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.UserName, AUserName);
    LJSON.AddPair(TJSONNames.Password, APassword);
    Result := AddUser(LJSON);
  finally
    LJSON.Free;
  end;
end;

function TEMSInternalAPI.AddUser(
  const AJSONBody: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AJSONBody);
  Result := FService.Post(FContext, TSegmentNames.Users, nil, nil, LRequest);
end;

function TEMSInternalAPI.AddUsersToGroup(const AGroupName: string;
  const AUsers: TArray<string>): IEMSResourceResponseContent;
var
  LJSONObject: TJSONObject;
  LTemp: TJSONArray;
  LJSONArray: TJSONArray;
  S: string;
  LResponse: IEMSResourceResponseContent;
begin
  LJSONArray := nil;
  try
    if not RetrieveGroup(AGroupName, LResponse) then
      raise EEMSInternalAPIError.CreateFmt(sGroupNotFound, [AGroupName]);
    LJSONArray := nil;
    if LResponse.TryGetObject(LJSONObject) then
      if LJSONObject.TryGetValue<TJSONArray>(TJSONNames.GroupName, LTemp) then
        LJSONArray := LTemp.Clone as TJSONArray;
    if LJSONArray = nil then
      LJSONArray := TJSONArray.Create;
    for S in AUsers do
      LJSONArray.Add(S);
    LJSONObject := TJSONObject.Create;
    try
      LJSONObject.AddPair(TJSONNames.GroupName, LJSONArray);
      LJSONArray := nil;
      UpdateGroup(AGroupName, LJSONObject);
    finally
      LJSONObject.Free;
    end;
  finally
    LJSONArray.Free;
  end;
end;

function TEMSInternalAPI.RemoveUsersFromGroup(const AGroupName: string;
  const AUsers: TArray<string>;
  out AResponse: IEMSResourceResponseContent): Boolean;
var
  LJSONObject: TJSONObject;
  LJSONArray: TJSONArray;
  S: string;
  LResponse: IEMSResourceResponseContent;
  LList: TList<string>;
  LJSONValue: TJSONValue;
begin
  Result := False;
  if not RetrieveGroup(AGroupName, LResponse) then
    raise EEMSInternalAPIError.CreateFmt(sGroupNotFound, [AGroupName]);
  if LResponse.TryGetObject(LJSONObject) then
  begin
    if LJSONObject.TryGetValue<TJSONArray>(TJSONNames.GroupName, LJSONArray) then
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
        if Result then
        begin
          LJSONObject := TJSONObject.Create;
          try
            LJSONArray := TJSONArray.Create;
            LJSONObject.AddPair(TJSONNames.GroupName, LJSONArray);
            for S in LList do
              LJSONArray.Add(S);
            AResponse := UpdateGroup(AGroupName, LJSONObject);
          finally
            LJSONObject.Free;
          end;
        end;
      finally
        LList.Free;
      end;
    end;
  end;
end;

constructor TEMSInternalAPI.Create(const AContext: TEndpointContext);
begin
  FService := TEMSServices.GetService<IEMSInternalResourceRequestService>;
  FContext := FService.CreateRequestContext(AContext);
end;

function TEMSInternalAPI.CreateGroup(
  const AJSONBody: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AJSONBody);
  Result := FService.Post(FContext, TSegmentNames.Groups, nil, nil, LRequest);
end;

function TEMSInternalAPI.CreateGroup(const AGroupName: string;
  const AGroupFields: TJSONObject): IEMSResourceResponseContent;
var
  LJSON: TJSONObject;
begin
  if AGroupFields <> nil then
    LJSON := AGroupFields.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.GroupName, AGroupName);
    Result := CreateGroup(LJSON);
  finally
    LJSON.Free;
  end;
end;

function TEMSInternalAPI.LoginUser(const AUserName, APassword: string): IEMSResourceResponseContent;
var
  LJSON: TJSONObject;
begin
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.UserName, AUserName);
    LJSON.AddPair(TJSONNames.Password, APassword);
    Result := LoginUser(LJSON);
  finally
    LJSON.Free;
  end;
end;

function TEMSInternalAPI.DeleteUser(const AObjectID: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Delete(FContext, TSegmentNames.Users, TEMSResourceRequestSegments.Create(AObjectID), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.DeleteGroup(const AGroupName: string): Boolean;
var
  LResponse: IEMSResourceResponseContent;
begin
  LResponse := FService.Delete(FContext, TSegmentNames.Groups, TEMSResourceRequestSegments.Create(AGroupName), nil);
  Result := LResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.DeleteInstallation(
  const AInstallationID: string): Boolean;
var
  LResponse: IEMSResourceResponseContent;
begin
  LResponse := FService.Delete(FContext, TSegmentNames.Installations, TEMSResourceRequestSegments.Create(AInstallationID), nil);
  Result := LResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.UnregisterModule(
  const AModuleName: string): Boolean;
var
  LResponse: IEMSResourceResponseContent;
begin
  LResponse := FService.Delete(FContext, TSegmentNames.Edgemodules, TEMSResourceRequestSegments.Create(AModuleName), nil);
  Result := LResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.UnregisterModuleResource(
  const AModuleName, AResourceName: string): Boolean;
var
  LResponse: IEMSResourceResponseContent;
begin
  LResponse := FService.Delete(FContext, TSegmentNames.Edgemodules, TEMSResourceRequestSegments.Create(AModuleName, TSegmentNames.Resources, AResourceName), nil);
  Result := LResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.ModuleResourceDelete(const AModuleName, AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams): IEMSResourceResponseContent;
var
  LSegments: TEMSResourceRequestSegments;
begin
  LSegments :=  TEMSResourceRequestSegments.Create(AModuleName, AResourceName) + ASegments;
  Result := FService.Delete(FContext, TSegmentNames.Edgemodules, LSegments, AQueryParams);
end;

function TEMSInternalAPI.ModuleResourceGet(const AModuleName, AResourceName: string; const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams): IEMSResourceResponseContent;
var
  LSegments: TEMSResourceRequestSegments;
begin
  LSegments :=  TEMSResourceRequestSegments.Create(AModuleName, AResourceName) + ASegments;
  Result := FService.Get(FContext, TSegmentNames.Edgemodules, LSegments, AQueryParams);
end;

function TEMSInternalAPI.ModuleResourcePost(const AModuleName, AResourceName: string;  const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
var
  LSegments: TEMSResourceRequestSegments;
begin
  LSegments :=  TEMSResourceRequestSegments.Create(AModuleName, AResourceName) + ASegments;
  Result := FService.Post(FContext, TSegmentNames.Edgemodules, LSegments, AQueryParams, ARequestContent);
end;

function TEMSInternalAPI.ModuleResourcePut(const AModuleName, AResourceName: string;  const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
var
  LSegments: TEMSResourceRequestSegments;
begin
  LSegments :=  TEMSResourceRequestSegments.Create(AModuleName, AResourceName) + ASegments;
  Result := FService.Put(FContext, TSegmentNames.Edgemodules, LSegments, AQueryParams, ARequestContent);
end;

function TEMSInternalAPI.ModuleResourcePatch(const AModuleName, AResourceName: string;  const ASegments: TEMSResourceRequestSegments; const AQueryParams: TEMSResourceRequestQueryParams;
      const ARequestContent: IEMSResourceRequestContent): IEMSResourceResponseContent;
var
  LSegments: TEMSResourceRequestSegments;
begin
  LSegments :=  TEMSResourceRequestSegments.Create(AModuleName, AResourceName) + ASegments;
  Result := FService.Patch(FContext, TSegmentNames.Edgemodules, LSegments, AQueryParams, ARequestContent);
end;

function TEMSInternalAPI.UpdateModule(const AModuleName: string;
  const AJSONObject: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AJSONObject);
  Result := FService.Put(FContext, TSegmentNames.Edgemodules, TEMSResourceRequestSegments.Create(AModuleName), nil, LRequest);
end;


function TEMSInternalAPI.DeleteInstallation(const AInstallationID: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Delete(FContext, TSegmentNames.Installations, TEMSResourceRequestSegments.Create(AInstallationID), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.UnregisterModule(const AModuleName: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Delete(FContext, TSegmentNames.EdgeModules, TEMSResourceRequestSegments.Create(AModuleName), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.UnregisterModuleResource(const AModuleName, AResourceName: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Delete(FContext, TSegmentNames.EdgeModules, TEMSResourceRequestSegments.Create(AModuleName, TSegmentNames.Resources, AResourceName), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.DeleteGroup(const AGroupName: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
var
  LResponse: IEMSResourceResponseContent;
begin
  LResponse := FService.Delete(FContext, TSegmentNames.Groups, TEMSResourceRequestSegments.Create(AGroupName), nil);
  Result := LResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.DeleteUser(const AObjectID: string): Boolean;
var
  LResponse: IEMSResourceResponseContent;
begin
  LResponse := FService.Delete(FContext, TSegmentNames.Users, TEMSResourceRequestSegments.Create(AObjectID), nil);
  Result := LResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.LoginUser(
  const AJSONLogin: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AJSONLogin);
  Result := FService.Post(FContext, TSegmentNames.Users, TEMSResourceRequestSegments.Create(TSegmentNames.Login), nil, LRequest);
end;

function TEMSInternalAPI.Logout: IEMSResourceResponseContent;
begin
  Result := FService.Post(FContext, TSegmentNames.Users, TEMSResourceRequestSegments.Create(TSegmentNames.Logout), nil, nil);
end;

function TEMSInternalAPI.PushBroadcast(
  const AData: TJSONObject): IEMSResourceResponseContent;
begin
  Result := PushToTarget(AData, nil);
end;

function TEMSInternalAPI.PushToChannels(const AData: TJSONObject;
  const AChannels: array of string): IEMSResourceResponseContent;
var
  LJSON: TJSONObject;
  LChannels: TJSONArray;
  S: string;
  LRequest: IEMSResourceRequestContent;
begin
  if Length(AChannels) = 0 then
    raise EEMSInternalAPIError.Create(sChannelNamesExpected);
  LJSON := TJSONObject.Create;
  try
    LChannels := TJSONArray.Create;
    for S in AChannels do
      LChannels.Add(S);
    LJSON.AddPair(TJSONNames.PushChannels, LChannels);
    LRequest := FService.CreateRequestContent(LJSON);
    Result := FService.Post(FContext, TSegmentNames.Push, nil, nil, LRequest);
  finally
    LJSON.Free;
  end;
end;

function TEMSInternalAPI.PushToTarget(const AData,
  ATarget: TJSONObject): IEMSResourceResponseContent;
var
  LJSON: TJSONObject;
  LPair: TJSONPair;
  LRequest: IEMSResourceRequestContent;
begin
  LJSON := TJSONObject.Create;
  try
    if AData <> nil then
      LJSON.AddPair(TJSONNames.PushData, AData.Clone as TJSONObject);    // Do not localize
    if ATarget <> nil then
      for LPair in ATarget do
        // such as "where" and "channels"
        LJSON.AddPair(LPair.Clone as TJSONPair);
    LRequest := FService.CreateRequestContent(LJSON);
    Result := FService.Post(FContext, TSegmentNames.Push, nil, nil, LRequest);
  finally
    LJSON.Free;
  end;
end;

function TEMSInternalAPI.PushWhere(const AData,
  AWhere: TJSONObject): IEMSResourceResponseContent;
var
  LJSON: TJSONObject;
  LRequest: IEMSResourceRequestContent;
begin
  LJSON := TJSONObject.Create;
  try
    if AWhere <> nil then
      LJSON.AddPair(TJSONNames.PushWhere, AWhere.Clone as TJSONObject);  // Do not localize
    if AData <> nil then
      LJSON.AddPair(TJSONNames.PushData, AData.Clone as TJSONObject);    // Do not localize
    LRequest := FService.CreateRequestContent(LJSON);
    Result := FService.Post(FContext, TSegmentNames.Push, nil, nil, LRequest);
  finally
    LJSON.Free;
  end;
end;

function TEMSInternalAPI.QueryGroups(
  const AQuery: TQueryParams): IEMSResourceResponseContent;
begin
  Result := FService.Get(FContext, TSegmentNames.Groups, nil, AQuery);
end;

function TEMSInternalAPI.QueryInstallations(
  const AQuery: TQueryParams): IEMSResourceResponseContent;
begin
  Result := FService.Get(FContext, TSegmentNames.Installations, nil, AQuery);
end;

function TEMSInternalAPI.QueryModules(
  const AQuery: TQueryParams): IEMSResourceResponseContent;
begin
  Result := FService.Get(FContext, TSegmentNames.Edgemodules, nil, AQuery);
end;

function TEMSInternalAPI.QueryModuleResources(
  const AQuery: TQueryParams): IEMSResourceResponseContent;
begin
  Result := FService.Get(FContext, TSegmentNames.Edgemodules, TEMSResourceRequestSegments.Create(TSegmentNames.Resources), AQuery);
end;

function TEMSInternalAPI.QueryModuleResources(
  const AModuleName: string; const AQuery: TQueryParams): IEMSResourceResponseContent;
begin
  Result := FService.Get(FContext, TSegmentNames.Edgemodules, TEMSResourceRequestSegments.Create(AModuleName, TSegmentNames.Resources), AQuery);
end;

function TEMSInternalAPI.QueryUserName(const AUserName: string): Boolean;
var
  LResponse: IEMSResourceResponseContent;
begin
  Result := QueryUserName(AUserName, LResponse);
end;

function TEMSInternalAPI.QueryUsers(
  const AQuery: TQueryParams): IEMSResourceResponseContent;
begin
  Result := FService.Get(FContext, TSegmentNames.Users, nil, AQuery);
end;

function TEMSInternalAPI.RetrieveGroup(const AGroupName: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Get(FContext, TSegmentNames.Groups, TEMSResourceRequestSegments.Create(AGroupName), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.RetrieveInstallation(const AInstallationID: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Get(FContext, TSegmentNames.Installations, TEMSResourceRequestSegments.Create(AInstallationID), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.RetrieveModule(const AModuleName: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Get(FContext, TSegmentNames.EdgeModules, TEMSResourceRequestSegments.Create(AModuleName), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.RetrieveModuleResource(const AModuleName, AResourceName: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Get(FContext, TSegmentNames.EdgeModules, TEMSResourceRequestSegments.Create(AModuleName, TSegmentNames.Resources, AResourceName), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.RetrieveUser(const AObjectID: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
begin
  AResponse := FService.Get(FContext, TSegmentNames.Users, TEMSResourceRequestSegments.Create(AObjectID), nil);
  Result := AResponse.StatusCode <> 404;
end;

function TEMSInternalAPI.SignupUser(const AUserName, APassword: string; const AUserFields: TJSONObject): IEMSResourceResponseContent;
var
  LJSON: TJSONObject;
begin
  if AUserFields <> nil then
    LJSON := AUserFields.Clone as TJSONObject
  else
    LJSON := TJSONObject.Create;
  try
    LJSON.AddPair(TJSONNames.UserName, AUserName);
    LJSON.AddPair(TJSONNames.Password, APassword);
    Result := SignupUser(LJSON);
  finally
    LJSON.Free;
  end;
end;

function TEMSInternalAPI.SignupUser(const AJSONBody: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AJSONBody);
  Result := FService.Post(FContext, TSegmentNames.Users, TEMSResourceRequestSegments.Create(TSegmentNames.Signup), nil, LRequest);
end;

function TEMSInternalAPI.UpdateGroup(const AGroupName: string;
  const AGroupFields: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AGroupFields);
  Result := FService.Put(FContext, TSegmentNames.Groups, TEMSResourceRequestSegments.Create(AGroupName), nil, LRequest);
end;

function TEMSInternalAPI.UpdateInstallation(const AInstallationID: string;
  const AJSONObject: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AJSONObject);
  Result := FService.Put(FContext, TSegmentNames.Installations, TEMSResourceRequestSegments.Create(AInstallationID), nil, LRequest);
end;

function TEMSInternalAPI.UpdateModuleResource(const AModuleName, AResourceName: string;
  const AJSONObject: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AJSONObject);
  Result := FService.Put(FContext, TSegmentNames.Edgemodules, TEMSResourceRequestSegments.Create(AModuleName, TSegmentNames.Resources, AResourceName), nil, LRequest);
end;

function TEMSInternalAPI.UpdateUser(const AObjectID: string;
  const AUserFields: TJSONObject): IEMSResourceResponseContent;
var
  LRequest: IEMSResourceRequestContent;
begin
  LRequest := FService.CreateRequestContent(AUserFields);
  Result := FService.Put(FContext, TSegmentNames.Users, TEMSResourceRequestSegments.Create(AObjectID), nil, LRequest);
end;

function TEMSInternalAPI.QueryUserName(const AUserName: string;
  out AResponse: IEMSResourceResponseContent): Boolean;
var
  LJSON: TJSONObject;
  LWhere: string;
  LQueryParams: TEMSResourceRequestQueryParams;
  LJSONArray: TJSONArray;
begin
  LJSON := TJSONObject.Create.AddPair(TJSONNames.UserName, TJSONString.Create(AUserName));
  try
    LWhere := LJSON.ToJSON;
  finally
    LJSON.Free;
  end;
  LQueryParams := TEMSResourceRequestQueryParams.Create(
    TPair<string, string>.Create(
      TEMSInternalAPI.TQueryParamNames.Where,
      LWhere)
  );
  AResponse := FService.Get(FContext, TSegmentNames.Users, nil, LQueryParams);
  Result := AResponse.TryGetArray(LJSONArray) and (LJSONArray.Count > 0);
end;


end.
