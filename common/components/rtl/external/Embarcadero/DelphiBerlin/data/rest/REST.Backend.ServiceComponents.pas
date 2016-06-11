{*******************************************************}
{                                                       }
{             Delphi REST Client Framework              }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit REST.Backend.ServiceComponents;

interface

uses
  System.Classes, System.SysUtils, System.JSON, System.Generics.Collections,
  REST.Client, REST.BindSource,
  Data.Bind.Components, Data.Bind.ObjectScope,
  REST.Backend.Providers, REST.Backend.ServiceTypes,
  REST.Backend.BindSource,
  REST.Backend.PushTypes, REST.Backend.Consts,
  REST.Backend.MetaTypes;

type
  TCustomBackendUsers = class(TBackendServiceComponentAuth<IBackendUsersService, TBackendUsersApi>, IRESTIPComponent)
  private
    function GetUsers: TBackendUsersApi;
    function GetProviderService: IBackendUsersService;
  protected
    function InternalCreateBackendServiceAPI: TBackendUsersApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendUsersApi; override;
    function CreateAuthAccess: IAuthAccess; override;
  public
    property Users: TBackendUsersApi read GetUsers;
    property ProviderService: IBackendUsersService read GetProviderService;
    function CreateUserAPI: TBackendUsersApi;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendUsers = class(TCustomBackendUsers)
  published
    property Provider;
    property Auth;
  end;

  TCustomBackendGroups = class(TBackendServiceComponentAuth<IBackendGroupsService, TBackendGroupsApi>, IRESTIPComponent)
  private
    function GetGroups: TBackendGroupsApi;
    function GetProviderService: IBackendGroupsService;
  protected
    function InternalCreateBackendServiceAPI: TBackendGroupsApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendGroupsApi; override;
    function CreateAuthAccess: IAuthAccess; override;
  public
    property Groups: TBackendGroupsApi read GetGroups;
    property ProviderService: IBackendGroupsService read GetProviderService;
    function CreateGroupsAPI: TBackendGroupsApi;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendGroups = class(TCustomBackendGroups)
  published
    property Provider;
    property Auth;
  end;

  TCustomBackendStorage = class(TBackendServiceComponentAuth<IBackendStorageService, TBackendStorageApi>, IRESTIPComponent)
  private
    function GetStorage: TBackendStorageApi;
    function GetProviderService: IBackendStorageService;
  protected
    function InternalCreateBackendServiceAPI: TBackendStorageApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendStorageApi; override;
    function CreateAuthAccess: IAuthAccess; override;
  public
    property Storage: TBackendStorageApi read GetStorage;
    property ProviderService: IBackendStorageService read GetProviderService;
    function CreateStorageAPI: TBackendStorageApi;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendStorage = class(TCustomBackendStorage)
  published
    property Provider;
    property Auth;
  end;

  TCustomBackendFiles = class(TBackendServiceComponentAuth<IBackendFilesService, TBackendFilesApi>, IRESTIPComponent)
  private
    function GetFiles: TBackendFilesApi;
    function GetProviderService: IBackendFilesService;
  protected
    function InternalCreateBackendServiceAPI: TBackendFilesApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendFilesApi; override;
    function CreateAuthAccess: IAuthAccess; override;
  public
    property Files: TBackendFilesApi read GetFiles;
    property ProviderService: IBackendFilesService read GetProviderService;
    function CreateFilesAPI: TBackendFilesApi;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendFiles = class(TCustomBackendFiles)
  published
    property Provider;
    property Auth;
  end;

  TSubBackendQueryBindSource = class;

  TCustomBackendQuery = class(TBackendBindSourceComponentAuth<IBackendQueryService, TBackendQueryApi>, IRESTResponseJSON, IRESTIPComponent)
  private type
    TNotify = TRESTComponentNotify;

    TNotifyList = TRESTComponentNotifyList<TNotify>;
  private
    FNotifyList: TNotifyList;
    FJSONNotifyList: TList<TNotifyEvent>;
    FBackendClassName: string;
    FQueryLines: TStrings;
    FJSONResult: TJSONArray;
    FBindSource: TSubBackendQueryBindSource;
    FBackendService: string;
    function GetQueryApi: TBackendQueryApi;
    procedure SetQueryLines(const Value: TStrings);
    procedure SetBackendClassName(const Value: string);
    procedure PropertyValueChanged;
    procedure JSONValueChanged;
    function GetProviderService: IBackendQueryService;
    procedure SetBackendService(const Value: string);
  protected
    function CreateAuthAccess: IAuthAccess; override;
    function CreateBindSource: TBaseObjectBindSource; override;
    function InternalCreateBackendServiceAPI: TBackendQueryApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendQueryApi; override;
    { IRESTResponseJSON }   // Support ResponseAdapter
    procedure AddJSONChangedEvent(const ANotify: TNotifyEvent);
    procedure RemoveJSONChangedEvent(const ANotify: TNotifyEvent);
    procedure GetJSONResponse(out AJSONValue: TJSONValue; out AHasOwner: Boolean);
    function HasJSONResponse: Boolean;
    function HasResponseContent: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute;
    procedure ClearResult;
    procedure SetJSONResult(const AJSONResult: TJSONArray);
    function CreateQueryAPI: TBackendQueryApi;
    property QueryLines: TStrings read FQueryLines write SetQueryLines;
    property BackendClassName: string read FBackendClassName write SetBackendClassName;
    property BackendService: string read FBackendService write SetBackendService;
    property JSONResult: TJSONArray read FJSONResult;
    property BindSource: TSubBackendQueryBindSource read FBindSource;
    property QueryApi: TBackendQueryApi read GetQueryApi;
    property ProviderService: IBackendQueryService read GetProviderService;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendQuery = class(TCustomBackendQuery)
  published
    property Provider;
    property Auth;
    property BackendClassName;
    property BackendService;
    property QueryLines;
    property BindSource;
  end;

  /// <summary>
  /// LiveBindings adapter for TCustomBackendQuery. Create bindable members
  /// </summary>
  TBackendQueryAdapter = class(TRESTComponentAdapter)
  public type
    TNotify = class(TRESTComponentNotify)
    private
      FAdapter: TBackendQueryAdapter;
      constructor Create(const AAdapter: TBackendQueryAdapter);
    public
      procedure PropertyValueChanged(Sender: TObject); override;
    end;
  private
    FQuery: TCustomBackendQuery;
    FNotify: TNotify;
    procedure SetQuery(const AQuery: TCustomBackendQuery);
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
    property Query: TCustomBackendQuery read FQuery write SetQuery;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomBackendQuery. Creates adapter
  /// </summary>
  TCustomBackendQueryBindSource = class(TRESTComponentBindSource)
  private
    FAdapter: TBackendQueryAdapter;
    function GetQuery: TCustomBackendQuery;
    procedure SetQuery(const AValue: TCustomBackendQuery);
  protected
    function CreateAdapter: TRESTComponentAdapter; override;
  public
    property Query: TCustomBackendQuery read GetQuery write SetQuery;
    property Adapter: TBackendQueryAdapter read FAdapter;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomRESTRequest.  Publishes subcomponent properties
  /// </summary>
  TSubBackendQueryBindSource = class(TCustomBackendQueryBindSource)
  published
    property AutoActivate;
    property AutoEdit;
    property AutoPost;
  end;

  TSubPushSenderBindSource = class;

  [HPPGEN(HPPGenAttribute.mkFriend, 'TPushSenderAdapter')]
  TCustomBackendPush = class(TBackendBindSourceComponentAuth<IBackendPushService, TBackendPushApi>, IRESTIPComponent)
  public type
    TSendEvent = TNotifyEvent;
    TSendingEvent = TNotifyEvent;

    TExtrasItem = class;

    TExtrasCollection = class(TOwnedCollection)
    private type
      TEnumerator = class(TCollectionEnumerator)
      public
        function GetCurrent: TExtrasItem; inline;
        property Current: TExtrasItem read GetCurrent;
      end;
    protected
      function GetItem(AIndex: integer): TExtrasItem;
      procedure SetItem(AIndex: integer; const AValue: TExtrasItem);
      function GetAttrCount: integer; override;
      function GetAttr(Index: integer): string; override;
      function GetItemAttr(Index, ItemIndex: integer): string; override;
      procedure Update(AItem: TCollectionItem); override;
    public
      constructor Create(const AOwner: TComponent);
      procedure UpdateExtras(const AExtras: TPushData.TExtras);

      function GetEnumerator: TEnumerator;
      property Items[AIndex: Integer]: TExtrasItem read GetItem write SetItem; default;
    end;

    TExtrasItem = class(TCollectionItem)
    private
      FName: string;
      FValue: string;
    protected
      procedure SetName(const AValue: string);
      procedure SetValue(const AValue: string);
    public
      procedure Assign(ASource: TPersistent); override;
      function ToString: string; override;
      function GetDisplayName: string; override;
    published
      property Name: string read FName write SetName;
      property Value: string read FValue write SetValue;
    end;

  private type
    TNotify = class(TRESTComponentNotify)
    public
      procedure ExtrasListChanged(Sender: TObject); virtual;
    end;
    TNotifyList = TRESTComponentNotifyList<TNotify>;
  private
    FNotifyList: TNotifyList;
    FPushData: TPushData;
    FExtras: TExtrasCollection;
    FBindSource: TSubPushSenderBindSource;
    FOnSending: TSendingEvent;
    FOnSend: TSendEvent;
    FTarget: TStrings;
    function GetProviderService: IBackendPushService;
    procedure PropertyValueChanged;
    procedure ExtrasListChanged;
    function GetPushAPI: TBackendPushAPI;
    procedure SetAPS(const Value: TPushData.TAPS);
    procedure SetMessage(const Value: string);
    function GetAPS: TPushData.TAPS;
    function GetMessage: string;
    function GetGCM: TPushData.TGCM;
    procedure SetGCM(const Value: TPushData.TGCM);
    procedure SetExtras(const Value: TExtrasCollection);
    procedure SetTarget(const Value: TStrings);
  protected
    function InternalCreateBackendServiceAPI: TBackendPushApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendPushApi; override;
    function CreateBindSource: TBaseObjectBindSource; override;
    procedure DoSend; virtual;
    procedure DoSending; virtual;
    function CreateAuthAccess: IAuthAccess; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    /// <summary>Broadcasts a push notification to all installations</summary>
    procedure PushData(const AData: TPushData); overload;
    /// <summary>Sends push notifications to the installations that match a target</summary>
    procedure PushData(const AData: TPushData; const ATarget: TJSONObject); overload;
    /// <summary>Sends a push notification to installations that match the Target property.
    /// The APS, GCM, Extras, and Message properties will be used to build a push notification. If the Target property
    /// is empty then the push notification is broadcast to all installations.
    /// </summary>
    procedure Push; overload;
    /// <summary>Data sent to apple devices when use the Push() procedure.</summary>
    property APS: TPushData.TAPS read GetAPS write SetAPS;
    /// <summary>Data sent to android devices when use the Push() procedure.</summary>
    property GCM: TPushData.TGCM read GetGCM write SetGCM;
    /// <summary>Custom data sent when use the Push() procedure.
    property Extras: TExtrasCollection read FExtras write SetExtras;
    /// <summary>Message to send to all devices when use the Push() procedure.  Use this property as an alternative to setting APS.Alert and GCM.Message.</summary>
    property Message: string read GetMessage write SetMessage;
    property BindSource: TSubPushSenderBindSource read FBindSource;
    property OnSending: TSendingEvent read FOnSending write FOnSending;
    property OnSend: TSendEvent read FOnSend write FOnSend;
    property PushAPI: TBackendPushAPI read GetPushAPI;
    /// <summary>Specify where to send push.  Example: {"where":{"devicetype":"ios"}}.
    /// Target must be text that can be parsed into a JSON object.  The member names are provider-specific.
    /// "where" is a typical member name.  Some providers also support "channels", such as {"channels":["a", "b"]}
    /// </summary>
    property Target: TStrings read FTarget write SetTarget;
    property ProviderService: IBackendPushService read GetProviderService;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendPush = class(TCustomBackendPush)
  published
    property Provider;
    property Auth;
    property Message;
    property APS;
    property GCM;
    property Extras;
    property BindSource;
    property Target;
  end;

  /// <summary>
  /// LiveBindings adapter for TCustomBackendPush. Create bindable members
  /// </summary>
  TPushSenderAdapter = class(TRESTComponentAdapter)
  public type
    TNotify = class(TCustomBackendPush.TNotify)
    private
      FAdapter: TPushSenderAdapter;
      constructor Create(const AAdapter: TPushSenderAdapter);
    public
      procedure PropertyValueChanged(Sender: TObject); override;
      procedure ExtrasListChanged(Sender: TObject); override;
    end;
  private
    FComponent: TCustomBackendPush;
    FNotify: TNotify;
    procedure SetPushSender(const APushSender: TCustomBackendPush);
    procedure AddPropertyFields;
    procedure AddParameterFields;
    procedure ExtrasListChanged;
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
    property PushSender: TCustomBackendPush read FComponent write SetPushSender;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomBackendPush. Creates adapter
  /// </summary>
  TCustomPushSenderBindSource = class(TRESTComponentBindSource)
  private
    FAdapter: TPushSenderAdapter;
    function GetComponent: TCustomBackendPush;
    procedure SetComponent(const AValue: TCustomBackendPush);
  protected
    function CreateAdapter: TRESTComponentAdapter; override;
  public
    property Component: TCustomBackendPush read GetComponent write SetComponent;
    property Adapter: TPushSenderAdapter read FAdapter;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomBackendPush.  Publishes subcomponent properties
  /// </summary>
  TSubPushSenderBindSource = class(TCustomPushSenderBindSource)
  published
    property AutoActivate;
    property AutoEdit;
    property AutoPost;
  end;


  TSubLoginBindSource = class;

  TCustomBackendAuth = class(TBackendBindSourceComponent<IBackendAuthService, TBackendAuthApi>, IBackendAuthReg, IRESTIPComponent)
  public type
    TSendEvent = TNotifyEvent;
    TSendingEvent = TNotifyEvent;

    TUserDetailsItem = class;

    TUserDetailsCollection = class(TOwnedCollection)
    private type
      TEnumerator = class(TCollectionEnumerator)
      public
        function GetCurrent: TUserDetailsItem; inline;
        property Current: TUserDetailsItem read GetCurrent;
      end;
    protected
      function GetItem(AIndex: integer): TUserDetailsItem;
      procedure SetItem(AIndex: integer; const AValue: TUserDetailsItem);
      function GetAttrCount: integer; override;
      function GetAttr(Index: integer): string; override;
      function GetItemAttr(Index, ItemIndex: integer): string; override;
      procedure Update(AItem: TCollectionItem); override;
    public
      constructor Create(const AOwner: TComponent);
      procedure ClearValues;
      function GetEnumerator: TEnumerator;
      property Items[AIndex: Integer]: TUserDetailsItem read GetItem write SetItem; default;
    end;

    TUserDetailsItem = class(TCollectionItem)
    private
      FName: string;
      FValue: string;
    protected
      procedure SetName(const AValue: string);
      procedure SetValue(const AValue: string);
    public
      procedure Assign(ASource: TPersistent); override;
      function ToString: string; override;
      function GetDisplayName: string; override;
    published
      property Name: string read FName write SetName;
      property Value: string read FValue write SetValue;
    end;

  public type
    TNotify = class(TRESTComponentNotify)
    public
      procedure UserDetailsChanged(Sender: TObject); virtual;
    end;
    TNotifyList = TRESTComponentNotifyList<TNotify>;
    TLoginPromptEvent = procedure(Sender: TObject; var AUserName, APassword: string) of object;
  private
    FLoggedInValue: TBackendEntityValue;
    FNotifyList: TNotifyList;
    FUserDetails: TUserDetailsCollection;
    FBindSource: TSubLoginBindSource;
    FPassword: string;
    FUserName: string;
    FLoginPrompt: Boolean;
    FAuthAccess: TList<IAuthAccess>;
    FAuthentication: TBackendAuthentication;
    FDefaultAuthentication: TBackendDefaultAuthentication;
    FOnLoggedIn: TNotifyEvent;
    FOnLoggingIn: TNotifyEvent;
    FOnSigningUp: TNotifyEvent;
    FOnSignedUp: TNotifyEvent;
    FOnLoggedOut: TNotifyEvent;
    FOnLoginPrompt: TLoginPromptEvent;
    function GetProviderService: IBackendAuthService;
    procedure PropertyValueChanged;
    procedure UserDetailsChanged;
    function GetAuthApi: TBackendAuthApi;
    procedure SetUserDetails(const Value: TUserDetailsCollection);
    procedure SetPassword(const Value: string);
    procedure SetUserName(const Value: string);
    procedure DoAuthAccess(const AProc: TProc<IAuthAccess>);
    procedure ValidateAuthAccess;
    function GetLoggedIn: Boolean;
    function GetLoggedInToken: string;
    function GetLoggedInUserName: string;
    procedure CheckLoggedIn;
  protected
    { IBackendAuthReg }
    procedure RegisterForAuth(const AAuthAccess: IAuthAccess);
    procedure UnregisterForAuth(const AAuthAccess: IAuthAccess);

    function InternalCreateBackendServiceAPI: TBackendAuthApi; override;
    function InternalCreateIndependentBackendServiceAPI: TBackendAuthApi; override;
    function CreateBindSource: TBaseObjectBindSource; override;
    procedure SetAuthentication(const Value: TBackendAuthentication);
    procedure SetDefaultAuthentication(
      const Value: TBackendDefaultAuthentication);
    function LoginDialog(out AUserName, APassword: string): Boolean; virtual;
    procedure DoLoggedIn; virtual;
    procedure DoLoggingIn; virtual;
    procedure DoLoggedOut; virtual;
    function DoLogInPrompt(out AUserName, APassword: string): Boolean; virtual;
    procedure DoSignedUp; virtual;
    procedure DoSigningUp; virtual;
    procedure ProviderChanged; override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Login; overload;
    procedure Login(const ALogin: TBackendEntityValue; const AJSON: TJSONObject); overload;
    procedure Signup;
    procedure Logout;
    procedure UpdateUserDetails;
    procedure UserDetailsToJSON(const AJSON: TJSONObject);
    procedure JSONToUserDetails(const AJSON: TJSONObject);
    procedure ClearFieldValues;
//    procedure RetrieveUserDetails;
//    procedure GetDetails; overload;
//    procedure GetDetails(const ALogin: TBackendEntityValue); overload;
//    procedure ClearDetails;

    property UserDetails: TUserDetailsCollection read FUserDetails write SetUserDetails;
    property UserName: string read FUserName write SetUserName;
    property Password: string read FPassword write SetPassword;
    property LoginPrompt: Boolean read FLoginPrompt write FLoginPrompt;
    property BindSource: TSubLoginBindSource read FBindSource;
    property AuthAPI: TBackendAuthApi read GetAuthApi;
    property ProviderService: IBackendAuthService read GetProviderService;
    property Authentication: TBackendAuthentication read FAuthentication write SetAuthentication
      default TBackendAuthentication.Default;
    property DefaultAuthentication: TBackendDefaultAuthentication read FDefaultAuthentication write SetDefaultAuthentication
      default TBackendDefaultAuthentication.None;
    property LoggedIn: Boolean read GetLoggedIn;
    property LoggedInToken: string read GetLoggedInToken;
    property LoggedInUserName: string read GetLoggedInUserName;
    property OnLoginPrompt: TLoginPromptEvent read FOnLoginPrompt write FOnLoginPrompt;
    property OnLoggingIn: TNotifyEvent read FOnLoggingIn write FOnLoggingIn;
    property OnLoggedIn: TNotifyEvent read FOnLoggedIn write FOnLoggedIn;
    property OnSigningUp: TNotifyEvent read FOnSigningUp write FOnSigningUp;
    property OnSignedUp: TNotifyEvent read FOnSignedUp write FOnSignedUp;
    property OnLoggedOut: TNotifyEvent read FOnLoggedOut write FOnLoggedOut;
    property LoggedInValue: TBackendEntityValue read FLoggedInValue;
  end;

  [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidiOSSimulator or pidiOSDevice or pidiOSDevice64 or pidAndroid)]
  TBackendAuth = class(TCustomBackendAuth)
  published
    property Provider;
    property UserName;
    property Password;
    property LoginPrompt;
    property UserDetails;
    property BindSource;
    property Authentication;
    property DefaultAuthentication;
    property OnLoginPrompt;
    property OnLoggingIn;
    property OnLoggedIn;
    property OnSigningUp;
    property OnSignedUp;
    property OnLoggedOut;
  end;

  /// <summary>
  /// LiveBindings adapter for TCustomBackendAuth. Create bindable members
  /// </summary>
  TBackendAuthAdapter = class(TRESTComponentAdapter)
  public type
    TNotify = class(TCustomBackendAuth.TNotify)
    private
      FAdapter: TBackendAuthAdapter;
      constructor Create(const AAdapter: TBackendAuthAdapter);
    public
      procedure PropertyValueChanged(Sender: TObject); override;
      procedure UserDetailsChanged(Sender: TObject); override;
    end;
  private
    FComponent: TCustomBackendAuth;
    FNotify: TNotify;
    procedure SetBackendAuth(const ALogin: TCustomBackendAuth);
    procedure AddPropertyFields;
    procedure AddParameterFields;
    procedure UserDetailsChanged;
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
    property BackendAuth: TCustomBackendAuth read FComponent write SetBackendAuth;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomBackendAuth. Creates adapter
  /// </summary>
  TCustomLoginBindSource = class(TRESTComponentBindSource)
  private
    FAdapter: TBackendAuthAdapter;
    function GetComponent: TCustomBackendAuth;
    procedure SetComponent(const AValue: TCustomBackendAuth);
  protected
    function CreateAdapter: TRESTComponentAdapter; override;
  public
    property Component: TCustomBackendAuth read GetComponent write SetComponent;
    property Adapter: TBackendAuthAdapter read FAdapter;
  end;

  /// <summary>
  /// LiveBindings bindsource for TCustomBackendAuth.  Publishes subcomponent properties
  /// </summary>
  TSubLoginBindSource = class(TCustomLoginBindSource)
  published
    property AutoActivate;
    property AutoEdit;
    property AutoPost;
  end;

  TAuthAccess = class(TInterfacedObject, IAuthAccess)
  private
    FAuthentication: TFunc<IBackendAuthenticationApi>;
    FComponent: IBackendServiceComponent;
  private
    procedure Login(const ALogin: TBackendEntityValue);
    procedure Logout;
    procedure SetAuthentication(const Value: TBackendAuthentication);
    procedure SetDefaultAuthentication(
      const Value: TBackendDefaultAuthentication);
    function GetProvider: IBackendProvider;
  public
    constructor Create(const AComponent: IBackendServiceComponent;
      const AAuthentication: TFunc<IBackendAuthenticationApi>);
  end;

implementation

uses
  REST.JSON, REST.Backend.Exception;

{ TCustomBackendQuery }

constructor TCustomBackendQuery.Create(AOwner: TComponent);
begin
  /// it is important to create the notify-list before
  /// calling the inherited constructor
  FNotifyList := TNotifyList.Create;
  FJSONNotifyList := TList<TNotifyEvent>.Create;
  inherited;
  FQueryLines := TStringList.Create;
end;

function TCustomBackendQuery.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetQueryApi.AuthenticationApi;
    end);
end;

function TCustomBackendQuery.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubBackendQueryBindSource.Create(self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(true);
  FBindSource.Query := self;

  Result := FBindSource;
end;

function TCustomBackendQuery.CreateQueryAPI: TBackendQueryApi;
begin
  Result := InternalCreateIndependentBackendServiceAPI;
end;

destructor TCustomBackendQuery.Destroy;
begin
  FreeAndNil(FNotifyList);
  FreeAndNil(FJSONNotifyList);
  FQueryLines.Free;
  inherited;
end;

procedure TCustomBackendQuery.AddJSONChangedEvent(const ANotify: TNotifyEvent);
begin
  Assert(not FJSONNotifyList.Contains(ANotify));
  if not FJSONNotifyList.Contains(ANotify) then
    FJSONNotifyList.Add(ANotify);
end;

procedure TCustomBackendQuery.ClearResult;
begin
  if FJSONResult <> nil then
  begin
    FreeAndNil(FJSONResult);
    JSONValueChanged;
  end;
end;

procedure TCustomBackendQuery.Execute;
var
  LQuery: TArray<string>;
  LResult: TJSONArray;
begin
  // Clear
  LResult := TJSONArray.Create;
  try
    FreeAndNil(FJSONResult);
    LQuery := QueryLines.ToStringArray;
    GetBackendServiceApi.Query(BackendService, BackendClassName, LQuery, LResult);
  except
    LResult.Free;
    raise;
  end;
  SetJSONResult(LResult);
end;

procedure TCustomBackendQuery.SetJSONResult(const AJSONResult: TJSONArray);
begin
  FreeAndNil(FJSONResult);
  FJSONResult := AJSONResult;
  JSONValueChanged;
end;

procedure TCustomBackendQuery.GetJSONResponse(out AJSONValue: TJSONValue;
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

function TCustomBackendQuery.GetProviderService: IBackendQueryService;
begin
  Result := GetBackendService;
end;

function TCustomBackendQuery.GetQueryApi: TBackendQueryApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomBackendQuery.HasJSONResponse: Boolean;
begin
  Result := FJSONResult <> nil;
end;

function TCustomBackendQuery.HasResponseContent: Boolean;
begin
  Result := HasJSONResponse;
end;

function TCustomBackendQuery.InternalCreateBackendServiceAPI: TBackendQueryApi;
begin
  Result := TBackendQueryApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendQuery.InternalCreateIndependentBackendServiceAPI: TBackendQueryApi;
begin
  Result := TBackendQueryApi.Create(GetBackendService.CreateQueryApi); // Service.CreateStorageApi);
end;

procedure TCustomBackendQuery.PropertyValueChanged;
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

procedure TCustomBackendQuery.JSONValueChanged;
var
  LNotifyEvent: TNotifyEvent;
begin
  PropertyValueChanged;
  for LNotifyEvent in  FJSONNotifyList do
    LNotifyEvent(Self);
end;

procedure TCustomBackendQuery.RemoveJSONChangedEvent(const ANotify: TNotifyEvent);
begin
  Assert(FJSONNotifyList.Contains(ANotify));
  FJSONNotifyList.Remove(ANotify);
end;

procedure TCustomBackendQuery.SetBackendClassName(const Value: string);
begin
  if FBackendClassName <> Value then
  begin
    FBackendClassName := Value;
    PropertyValueChanged;
  end;
end;

procedure TCustomBackendQuery.SetBackendService(const Value: string);
begin
  if FBackendService <> Value then
  begin
    FBackendService := Value;
    PropertyValueChanged;
  end;
end;

procedure TCustomBackendQuery.SetQueryLines(const Value: TStrings);
begin
  FQueryLines.Assign(Value);
  PropertyValueChanged;
end;


{ TCustomBackendQueryBindSource }

function TCustomBackendQueryBindSource.CreateAdapter: TRESTComponentAdapter;
begin
  FAdapter := TBackendQueryAdapter.Create(self);
  result := FAdapter;
end;

function TCustomBackendQueryBindSource.GetQuery: TCustomBackendQuery;
begin
  result := FAdapter.Query;
end;

procedure TCustomBackendQueryBindSource.SetQuery(const AValue: TCustomBackendQuery);
begin
  FAdapter.Query := AValue;
end;

{ TBackendQueryAdapter }

procedure TBackendQueryAdapter.SetQuery(const AQuery: TCustomBackendQuery);
var
  LActive: Boolean;
begin
  if FQuery <> AQuery then
  begin
    if FQuery <> nil then
    begin
      if FQuery.FNotifyList <> nil then
        FQuery.FNotifyList.RemoveNotify(FNotify);
      FQuery.RemoveFreeNotification(self);
    end;
    LActive := Active;
    Active := False;
    FQuery := AQuery;
    if FQuery <> nil then
    begin
      if FQuery.FNotifyList <> nil then
        FQuery.FNotifyList.AddNotify(FNotify);
      FQuery.FreeNotification(self);
    end;
    if LActive and CanActivate then
      Active := true;
  end;
end;

procedure TBackendQueryAdapter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if Operation = opRemove then
  begin
    if AComponent = FQuery then
      Query := nil
  end;
end;

constructor TBackendQueryAdapter.Create(AComponent: TComponent);
begin
  inherited;
  FNotify := TNotify.Create(self);
end;

destructor TBackendQueryAdapter.Destroy;
begin
  inherited;
  if (FQuery <> nil) then
  begin
    if FQuery.FNotifyList <> nil then
      FQuery.FNotifyList.RemoveNotify(FNotify);
  end;
  FNotify.Free;
end;

procedure TBackendQueryAdapter.DoChangePosting;
begin
  inherited;

end;

procedure TBackendQueryAdapter.AddFields;
begin
  AddPropertyFields;
end;

procedure TBackendQueryAdapter.AddPropertyFields;
const
  sJSONResult = 'JSONResult';
  sBackendClassName = 'BackendClassName';
  sBackendService = 'BackendService';
  sQueryStrings = 'QueryStrings';
var
  LGetMemberObject: IGetMemberObject;
begin
  CheckInactive;
  ClearFields;
  if FQuery <> nil then
  begin
    LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);
    CreateReadOnlyField<string>(sJSONResult, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        if FQuery.JSONResult <> nil then
          result := TJSON.Format(FQuery.JSONResult)
        else
          Result := '';
      end);
    CreateReadWriteField<string>(sBackendClassName, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := FQuery.BackendClassName
      end,
      procedure(AValue: string)
      begin
        FQuery.BackendClassName := AValue;
      end);
    CreateReadWriteField<string>(sBackendService, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := FQuery.BackendService
      end,
      procedure(AValue: string)
      begin
        FQuery.BackendService := AValue;
      end);
    CreateReadWriteField<string>(sQueryStrings, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := FQuery.QueryLines.Text
      end,
      procedure(AValue: string)
      begin
        FQuery.QueryLines.Text := AValue
      end);
  end;
end;

function TBackendQueryAdapter.GetCanActivate: Boolean;
begin
  result := (FQuery <> nil);
end;

procedure TBackendQueryAdapter.GetMemberNames(AList: TStrings);
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

function TBackendQueryAdapter.GetSource: TBaseLinkingBindSource;
begin
  result := FQuery;
end;

{ TBackendQueryAdapter.TNotify }

constructor TBackendQueryAdapter.TNotify.Create(
  const AAdapter: TBackendQueryAdapter);
begin
  FAdapter := AAdapter
end;

procedure TBackendQueryAdapter.TNotify.PropertyValueChanged(Sender: TObject);
begin
  if Assigned(FAdapter) then
    FAdapter.RefreshFields;
end;

{ TCustomPushSender }

constructor TCustomBackendPush.Create(AOwner: TComponent);
begin
  /// it is important to create the notify-list before
  /// calling the inherited constructor
  FNotifyList := TNotifyList.Create;
  FPushData := TPushData.Create;
  FPushData.OnChange :=
    procedure
    begin
      PropertyValueChanged;
    end;
  FExtras := TExtrasCollection.Create(Self);
  FTarget := TStringList.Create;
  inherited;
end;

destructor TCustomBackendPush.Destroy;
begin
  FreeAndNil(FNotifyList);
  inherited;
  FExtras.Free;
  FPushData.Free;
  FTarget.Free;
end;

procedure TCustomBackendPush.DoSend;
begin
       
end;

procedure TCustomBackendPush.DoSending;
begin
       
end;

function TCustomBackendPush.GetAPS: TPushData.TAPS;
begin
  Result := FPushData.APS;
end;

function TCustomBackendPush.GetGCM: TPushData.TGCM;
begin
  Result := FPushData.GCM;
end;

function TCustomBackendPush.GetMessage: string;
begin
  Result := FPushData.Message;
end;

function TCustomBackendPush.GetProviderService: IBackendPushService;
begin
  Result := GetBackendService;
end;

function TCustomBackendPush.GetPushAPI: TBackendPushAPI;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomBackendPush.InternalCreateBackendServiceAPI: TBackendPushApi;
begin
  Result := TBackendPushApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendPush.InternalCreateIndependentBackendServiceAPI: TBackendPushApi;
begin
  Result := TBackendPushApi.Create(GetBackendService.CreatePushApi); // Service.CreateStorageApi);
end;

procedure TCustomBackendPush.PropertyValueChanged;
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

procedure TCustomBackendPush.ExtrasListChanged;
begin
  if (FNotifyList <> nil) then
  begin
    FNotifyList.notify(
      procedure(ANotify: TNotify)
      begin
        ANotify.ExtrasListChanged(self);
      end);
  end;
end;

procedure TCustomBackendPush.PushData(const AData: TPushData);
begin
                      
  PushData(AData, nil);
end;

procedure TCustomBackendPush.PushData(const AData: TPushData; const ATarget: TJSONObject);
begin
  GetBackendServiceApi.PushToTarget(AData, ATarget);
end;

procedure TCustomBackendPush.Push;
var
  LTargetString: string;
  LTargetJSON: TJSONValue;
begin
  LTargetJSON := nil;
  try
    FExtras.UpdateExtras(FPushData.Extras);
    LTargetString := Target.Text;
    if Trim(LTargetString) <> '' then
      LTargetJSON := TJSONObject.ParseJSONValue(LTargetString);
    if LTargetJSON is TJSONObject then
      PushData(FPushData, TJSONObject(LTargetJSON))
    else
      PushData(FPushData);
  finally
    LTargetJSON.Free;
  end;
end;

procedure TCustomBackendPush.SetAPS(const Value: TPushData.TAPS);
begin
  FPushData.APS := Value;
end;

procedure TCustomBackendPush.SetExtras(const Value: TExtrasCollection);
begin
  FExtras.Assign(Value);
end;

procedure TCustomBackendPush.SetTarget(const Value: TStrings);
begin
  FTarget.Assign(Value);
  PropertyValueChanged;
end;

procedure TCustomBackendPush.SetGCM(const Value: TPushData.TGCM);
begin
  FPushData.GCM := Value;
end;

procedure TCustomBackendPush.SetMessage(const Value: string);
begin
  FPushData.Message := Value;
end;

function TCustomBackendPush.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetPushAPI.AuthenticationApi;
    end);
end;

function TCustomBackendPush.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubPushSenderBindSource.Create(self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(true);
  FBindSource.Component := self;

  Result := FBindSource;
end;

{ TCustomPushSenderBindSource }

function TCustomPushSenderBindSource.CreateAdapter: TRESTComponentAdapter;
begin
  FAdapter := TPushSenderAdapter.Create(self);
  result := FAdapter;
end;

function TCustomPushSenderBindSource.GetComponent: TCustomBackendPush;
begin
  result := FAdapter.PushSender;
end;

procedure TCustomPushSenderBindSource.SetComponent(const AValue: TCustomBackendPush);
begin
  FAdapter.PushSender := AValue;
end;

{ TPushSenderAdapter }

procedure TPushSenderAdapter.SetPushSender(const APushSender: TCustomBackendPush);
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

procedure TPushSenderAdapter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if Operation = opRemove then
  begin
    if AComponent = FComponent then
      PushSender := nil
  end;
end;

procedure TPushSenderAdapter.ExtrasListChanged;
begin
  if (FComponent <> nil) and not(csLoading in FComponent.ComponentState) then
  begin
    if Active and not Posting then
    begin
      // Force extras to be recreated
      Active := False;
      Active := True;
    end;
  end;
end;

constructor TPushSenderAdapter.Create(AComponent: TComponent);
begin
  inherited;
  FNotify := TNotify.Create(self);
end;

destructor TPushSenderAdapter.Destroy;
begin
  inherited;
  if (FComponent <> nil) then
  begin
    if FComponent.FNotifyList <> nil then
      FComponent.FNotifyList.RemoveNotify(FNotify);
  end;
  FNotify.Free;
end;

procedure TPushSenderAdapter.DoChangePosting;
begin
  inherited;

end;

procedure TPushSenderAdapter.AddFields;
begin
  AddPropertyFields;
  AddParameterFields;
end;

procedure TPushSenderAdapter.AddPropertyFields;
const
  sMessage = 'Message';
  sAPSAlert = 'APS.Alert';
  sAPSBadge = 'APS.Badge';
  sAPSSound = 'APS.Sound';
  sGCMTitle = 'GCM.Title';
  sGCMMsg = 'GCM.Msg';
  sGCMMessage = 'GCM.Message';
  sGCMAction = 'GCM.Action';
  sTarget = 'Target';
var
  LGetMemberObject: IGetMemberObject;
begin
  CheckInactive;
  ClearFields;
  if FComponent <> nil then
  begin
    LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);
    CreateReadWriteField<string>(sMessage, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.Message
      end,
      procedure(AValue: string)
      begin
        FComponent.Message := AValue;
      end);
    CreateReadWriteField<string>(sAPSAlert, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.APS.Alert;
      end,
      procedure(AValue: string)
      begin
        FComponent.APS.Alert := AValue;
      end);
    CreateReadWriteField<string>(sAPSBadge, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.APS.Badge
      end,
      procedure(AValue: string)
      begin
        FComponent.APS.Badge := AValue;
      end);
    CreateReadWriteField<string>(sAPSSound, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.APS.Sound
      end,
      procedure(AValue: string)
      begin
        FComponent.APS.Sound := AValue;
      end);
    CreateReadWriteField<string>(sGCMAction, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.GCM.Action
      end,
      procedure(AValue: string)
      begin
        FComponent.GCM.Action := AValue;
      end);
    CreateReadWriteField<string>(sGCMTitle, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.GCM.Title
      end,
      procedure(AValue: string)
      begin
        FComponent.GCM.Title := AValue;
      end);
    CreateReadWriteField<string>(sGCMMessage, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.GCM.Message
      end,
      procedure(AValue: string)
      begin
        FComponent.GCM.Message := AValue;
      end);
    CreateReadWriteField<string>(sGCMMsg, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.GCM.Msg
      end,
      procedure(AValue: string)
      begin
        FComponent.GCM.Msg := AValue;
      end);
    CreateReadWriteField<string>(sTarget, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := FComponent.Target.Text
      end,
      procedure(AValue: string)
      begin
        FComponent.Target.Text := AValue
      end);
  end;
end;

procedure TPushSenderAdapter.AddParameterFields;

  procedure ClearExtrasFields;
  var
    I: integer;
  begin
    for I := Fields.Count - 1 downto 0 do
      if (Fields[I] is TReadWriteField<string>) and (TReadWriteField<string>(Fields[I]).Persistent <> nil) then
        Fields.Delete(I);
  end;

  procedure MakeExtrasFieldNames(const ADictionary: TDictionary<string, TCustomBackendPush.TExtrasItem>);
  const
    sPrefix = 'Extras.';
  var
    I: integer;
    LExtrasCollection: TCustomBackendPush.TExtrasCollection;
    LExtrasItem: TCustomBackendPush.TExtrasItem;
    LName: string;
    LIndex: integer;
    LSuffix: string;
  begin
    Assert(ADictionary.Count = 0);
    LExtrasCollection := FComponent.Extras;
    for I := 0 to LExtrasCollection.Count - 1 do
    begin
      LExtrasItem := LExtrasCollection[I];
      LName := LExtrasItem.Name;
      if LName = '' then
        LName := IntToStr(LExtrasItem.Index);
      LName := sPrefix + LName;
      LIndex := 1;
      LSuffix := '';
      while ADictionary.ContainsKey(LName + LSuffix) do
      begin
        LSuffix := IntToStr(LIndex);
        inc(LIndex);
      end;
      ADictionary.Add(LName + LSuffix, LExtrasItem);
    end;
  end;

  procedure MakeExrasField(const AExtrasItem: TCustomBackendPush.TExtrasItem; const AFieldName: string;
  const AGetMemberObject: IGetMemberObject);
  begin
    CreateReadWriteField<string>(AFieldName, AGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := AExtrasItem.Value;
      end,
      procedure(AValue: string)
      begin
        AExtrasItem.Value := AValue;
      end, AExtrasItem); // is member of field

  end;

var
  LDictionary: TDictionary<string, TCustomBackendPush.TExtrasItem>;
  LPair: TPair<string, TCustomBackendPush.TExtrasItem>;
  LGetMemberObject: IGetMemberObject;
begin
  ClearExtrasFields;
  if FComponent <> nil then
  begin
    LDictionary := TDictionary<string, TCustomBackendPush.TExtrasItem>.Create;
    try
      MakeExtrasFieldNames(LDictionary);
      LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);
      for LPair in LDictionary do
        MakeExrasField(LPair.Value, LPair.Key, LGetMemberObject);
    finally
      LDictionary.Free;
    end;
  end;
end;

function TPushSenderAdapter.GetCanActivate: Boolean;
begin
  result := (FComponent <> nil);
end;

procedure TPushSenderAdapter.GetMemberNames(AList: TStrings);
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

function TPushSenderAdapter.GetSource: TBaseLinkingBindSource;
begin
  result := FComponent;
end;

{ TPushSenderAdapter.TNotify }

constructor TPushSenderAdapter.TNotify.Create(
  const AAdapter: TPushSenderAdapter);
begin
  FAdapter := AAdapter
end;

procedure TPushSenderAdapter.TNotify.ExtrasListChanged(Sender: TObject);
begin
  if Assigned(FAdapter) then
    FAdapter.ExtrasListChanged;
end;

procedure TPushSenderAdapter.TNotify.PropertyValueChanged(Sender: TObject);
begin
  if Assigned(FAdapter) then
    FAdapter.RefreshFields;
end;

{ TCustomBackendStorage }

function TCustomBackendStorage.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetStorage.AuthenticationApi;
    end);
end;

function TCustomBackendStorage.CreateStorageAPI: TBackendStorageApi;
begin
  Result := InternalCreateIndependentBackendServiceAPI;
end;

function TCustomBackendStorage.GetProviderService: IBackendStorageService;
begin
  Result := GetBackendService;
end;

function TCustomBackendStorage.GetStorage: TBackendStorageApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomBackendStorage.InternalCreateBackendServiceAPI: TBackendStorageApi;
begin
  Result := TBackendStorageApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendStorage.InternalCreateIndependentBackendServiceAPI: TBackendStorageApi;
begin
  Result := TBackendStorageApi.Create(GetBackendService.CreateStorageApi); // Service.CreateStorageApi);
end;

{ TCustomBackendUsers }

function TCustomBackendUsers.CreateUserAPI: TBackendUsersApi;
begin
  Result := InternalCreateIndependentBackendServiceAPI;
end;

function TCustomBackendUsers.GetProviderService: IBackendUsersService;
begin
  Result := GetBackendService;
end;

function TCustomBackendUsers.GetUsers: TBackendUsersApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomBackendUsers.InternalCreateBackendServiceAPI: TBackendUsersApi;
begin
  Result := TBackendUsersApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendUsers.InternalCreateIndependentBackendServiceAPI: TBackendUsersApi;
begin
  Result := TBackendUsersApi.Create(GetBackendService.CreateUsersApi); // Service.CreateStorageApi);
end;

function TCustomBackendUsers.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetUsers.AuthenticationApi;
    end);
end;


{ TCustomBackendGroups }

function TCustomBackendGroups.CreateGroupsAPI: TBackendGroupsApi;
begin
  Result := InternalCreateIndependentBackendServiceAPI;
end;

function TCustomBackendGroups.GetProviderService: IBackendGroupsService;
begin
  Result := GetBackendService;
end;

function TCustomBackendGroups.GetGroups: TBackendGroupsApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomBackendGroups.InternalCreateBackendServiceAPI: TBackendGroupsApi;
begin
  Result := TBackendGroupsApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendGroups.InternalCreateIndependentBackendServiceAPI: TBackendGroupsApi;
begin
  Result := TBackendGroupsApi.Create(GetBackendService.CreateGroupsApi); // Service.CreateStorageApi);
end;

function TCustomBackendGroups.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetGroups.AuthenticationApi;
    end);
end;

{ TCustomBackendFiles }

function TCustomBackendFiles.CreateFilesAPI: TBackendFilesApi;
begin
  Result := InternalCreateIndependentBackendServiceAPI;
end;

function TCustomBackendFiles.GetFiles: TBackendFilesApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomBackendFiles.GetProviderService: IBackendFilesService;
begin
  Result := GetBackendService;
end;

function TCustomBackendFiles.InternalCreateBackendServiceAPI: TBackendFilesApi;
begin
  Result := TBackendFilesApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendFiles.InternalCreateIndependentBackendServiceAPI: TBackendFilesApi;
begin
  Result := TBackendFilesApi.Create(GetBackendService.CreateFilesApi); // Service.CreateStorageApi);
end;

function TCustomBackendFiles.CreateAuthAccess: IAuthAccess;
begin
  Result := TAuthAccess.Create(Self,
    function: IBackendAuthenticationApi
    begin
      Result := Self.GetFiles.AuthenticationApi;
    end);
end;


{ TCustomBackendPush.TExtrasCollection.TEnumerator }

function TCustomBackendPush.TExtrasCollection.TEnumerator.GetCurrent: TExtrasItem;
begin
  Result := TExtrasItem(inherited GetCurrent);
end;

{ TCustomBackendPush.TExtrasCollection }

constructor TCustomBackendPush.TExtrasCollection.Create(const AOwner: TComponent);
begin
  inherited Create(AOwner, TExtrasItem);
end;

function TCustomBackendPush.TExtrasCollection.GetAttr(Index: integer): string;
begin
  case index of
    0:
      Result := sExtrasName;
    1:
      Result := sExtrasValue;
  else
    Result := ''; { do not localize }
  end;
end;

function TCustomBackendPush.TExtrasCollection.GetAttrCount: integer;
begin
  Result := 2;
end;

function TCustomBackendPush.TExtrasCollection.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(self);
end;

function TCustomBackendPush.TExtrasCollection.GetItem(AIndex: integer): TExtrasItem;
begin
  Result := TExtrasItem(inherited Items[AIndex]);
end;

function TCustomBackendPush.TExtrasCollection.GetItemAttr(Index, ItemIndex: integer): string;
begin
  case index of
    0:
      begin
        Result := Items[ItemIndex].Name;
        if Result = '' then
          Result := IntToStr(ItemIndex);
      end;
    1:
      Result := Items[ItemIndex].Value;
  else
    Result := '';
  end;
end;

procedure TCustomBackendPush.TExtrasCollection.SetItem(AIndex: integer; const AValue: TExtrasItem);
begin
  inherited SetItem(AIndex, TCollectionItem(AValue));
end;

procedure TCustomBackendPush.TExtrasCollection.Update(AItem: TCollectionItem);
begin
  inherited;
  if Self.Owner <> nil then
  begin
    if AItem = nil then // Entire list changed
      if Self.Owner is TCustomBackendPush then
        TCustomBackendPush(Self.Owner).ExtrasListChanged;
  end;
end;

procedure TCustomBackendPush.TExtrasCollection.UpdateExtras(
  const AExtras: TPushData.TExtras);
var
  LItem: TCustomBackendPush.TExtrasItem;
begin
  AExtras.Clear;
  for LItem in Self do
    AExtras.Add(LItem.Name, LItem.Value);
end;

//function TCustomBackendPush.CreateAuthAccess: IAuthAccess;
//begin
//  Result := TAuthAccess.Create(Self,
//    function: IBackendAuthenticationApi
//    begin
//      Result := Self.GetPushApi.AuthenticationApi;
//    end);
//end;

{ TCustomBackendPush.TExtrasItem }

procedure TCustomBackendPush.TExtrasItem.Assign(ASource: TPersistent);
var
  LExtra: TExtrasItem;
begin
  if (ASource is TExtrasItem) then
  begin
    LExtra := TExtrasItem(ASource);

    FName := LExtra.Name;
    FValue := LExtra.Value;
  end
  else
    inherited;
end;

function TCustomBackendPush.TExtrasItem.GetDisplayName: string;
begin
  result := FName;
end;

procedure TCustomBackendPush.TExtrasItem.SetName(const AValue: string);
begin
  if FName <> AValue then
  begin
    FName := AValue;
    Changed(False);

    if Self.Collection.Owner is TCustomBackendPush then
      TCustomBackendPush(Self.Collection.Owner).ExtrasListChanged;
  end;
end;

procedure TCustomBackendPush.TExtrasItem.SetValue(const AValue: string);
begin
  if FValue <> AValue then
  begin
    FValue := AValue;
    Changed(False);

    if (Self.Collection is TExtrasCollection) and (Self.Collection.Owner <> nil) then
      if Self.Collection.Owner is TCustomBackendPush then
        TCustomBackendPush(Self.Collection.Owner).PropertyValueChanged;
  end;
end;

function TCustomBackendPush.TExtrasItem.ToString: string;
begin
  result := Format('%s=%s', [FName, FValue])
end;

{ TCustomBackendPush.TNotify }

procedure TCustomBackendPush.TNotify.ExtrasListChanged(Sender: TObject);
begin
//
end;


{ TCustomBackendLogin }

procedure TCustomBackendAuth.ClearFieldValues;
begin
  UserName := '';
  Password := '';
  UserDetails.ClearValues;
end;

constructor TCustomBackendAuth.Create(AOwner: TComponent);
begin
  /// it is important to create the notify-list before
  /// calling the inherited constructor
  FNotifyList := TNotifyList.Create;
  FUserDetails := TUserDetailsCollection.Create(Self);
  FAuthAccess := TList<IAuthAccess>.Create;
  FDefaultAuthentication := TBackendDefaultAuthentication.None;
  inherited;
end;

destructor TCustomBackendAuth.Destroy;
begin
  FreeAndNil(FNotifyList);
  inherited;
  FUserDetails.Free;
  FAuthAccess.Free;
end;

procedure TCustomBackendAuth.ValidateAuthAccess;
var
  LProvider: IBackendProvider;
begin
  LProvider := nil;
  DoAuthAccess(
    procedure(AAuthAccess: IAuthAccess)
    begin
      if (AAuthAccess.Provider <> nil) and (LProvider <> nil) then
      begin
        if AAuthAccess.Provider <> LProvider then
        begin
          raise EBackendServiceError.Create(sBackendAuthMultipleProviders);
        end;
      end
      else if LProvider <> nil then
        LProvider := AAuthAccess.Provider;
    end);
  if (Self.Provider <> nil) and (LProvider <> nil) then
    if LProvider <> Self.Provider then
      raise EBackendServiceError.Create(sBackendAuthMultipleProviders);
end;

function TCustomBackendAuth.GetProviderService: IBackendAuthService;
begin
  Result := GetBackendService;
end;

function TCustomBackendAuth.GetAuthApi: TBackendAuthApi;
begin
  Result := GetBackendServiceAPI;
end;

function TCustomBackendAuth.GetLoggedIn: Boolean;
begin
  Result := LoggedInToken <> '';
end;

function TCustomBackendAuth.InternalCreateBackendServiceAPI: TBackendAuthApi;
begin
  Result := TBackendAuthApi.Create(GetBackendService); // Service.CreateStorageApi);
end;

function TCustomBackendAuth.InternalCreateIndependentBackendServiceAPI: TBackendAuthApi;
begin
  Result := TBackendAuthApi.Create(GetBackendService.CreateAuthApi); // Service.CreateStorageApi);
end;

procedure TCustomBackendAuth.JSONToUserDetails(const AJSON: TJSONObject);
var
  LItem: TUserDetailsItem;
  S: string;
begin
  for LItem in Self.UserDetails do
  begin
    if AJSON.TryGetValue<string>(LItem.Name, S) then
      LItem.Value := S
    else
      LItem.Value := '';
  end;
end;

procedure TCustomBackendAuth.UserDetailsToJSON(const AJSON: TJSONObject);
var
  LItem: TUserDetailsItem;
begin
  for LItem in Self.UserDetails do
  begin
    if LItem.Name <> '' then
      AJSON.AddPair(LItem.Name, LItem.Value)
  end;
end;

procedure TCustomBackendAuth.Loaded;
begin
  inherited;
  if Provider <> nil then
  begin
    Self.GetAuthApi.Authentication := FAuthentication;
    Self.GetAuthApi.DefaultAuthentication := FDefaultAuthentication;
  end;
  DoAuthAccess(
    procedure(AAuth: IAuthAccess)
    begin
      AAuth.SetAuthentication(FAuthentication);
      AAuth.SetDefaultAuthentication(FDefaultAuthentication);
    end);
end;

procedure TCustomBackendAuth.Login(const ALogin: TBackendEntityValue; const AJSON: TJSONObject);
var
  LLogin: TBackendEntityValue;
begin
  FLoggedInValue := ALogin;
  FAuthentication := TBackendAuthentication.Session;  // Do not set property.  Property setter calls DoAuthAccess
  if AJSON <> nil then
    JSONToUserDetails(AJSON);
  Self.GetAuthApi.Login(ALogin);
  LLogin := ALogin;
                          
  DoAuthAccess(
    procedure(AAuth: IAuthAccess)
    begin
      AAuth.Login(LLogin);
    end);
  DoLoggedin;
end;

procedure TCustomBackendAuth.Login;
var
  LLogin: TBackendEntityValue;
  LUserName: string;
  LPassword: string;
  LJSON: TJSONObject;
begin
  LJSON := nil;
  try
    ValidateAuthAccess;
    DoLoggingIn;
    LUserName := FUserName;
    LPassword := FPassword;
    if LoginPrompt then
    begin
      DoLoginPrompt(LUserName, LPassword);
      if LUserName = '' then
        Exit;  // EXIT
    end;
    GetBackendServiceApi.LoginUser(LUserName, LPassword,
      procedure(const AObject: TBackendEntityValue; const AJSON: TJSONObject)
      begin
        LLogin := AObject;
        if AJSON <> nil then
          LJSON := AJSON.Clone as TJSONObject;
      end);
    Login(LLogin, LJSON);
  finally
    LJSON.Free;
  end;
end;

procedure TCustomBackendAuth.Signup;
var
  LJSON: TJSONObject;
  LLogin: TBackendEntityValue;
begin
  LJSON := TJSONObject.Create;
  try
    ValidateAuthAccess;
    DoSigningUp;
    UserDetailsToJSON(LJSON);
    GetBackendServiceApi.SignupUser(FUserName, FPassword, LJSON, LLogin);
    Login(LLogin, LJSON);
    DoSignedUp;
  finally
    LJSON.Free;
  end;
end;

procedure TCustomBackendAuth.DoLoggedIn;
begin
  if Assigned(FOnLoggedIn) then
    FOnLoggedIn(Self);
end;

procedure TCustomBackendAuth.DoLoggedOut;
begin
  if Assigned(FOnLoggedOut) then
    FOnLoggedOut(Self);
end;

function TCustomBackendAuth.DoLogInPrompt(out AUserName, APassword: string): Boolean;
begin
  if Assigned(FOnLoginPrompt) then
  begin
    FOnLoginPrompt(Self, AUserName, APassword);
    Result := AUserName <> '';
  end
  else
    Result := LoginDialog(AUserName, APassword);
end;

procedure TCustomBackendAuth.DoLoggingIn;
begin
  if Assigned(FOnLoggingIn) then
    FOnLoggingIn(Self);
end;

procedure TCustomBackendAuth.DoSignedUp;
begin
  if Assigned(FOnSignedUp) then
    FOnSignedUp(Self);
end;

procedure TCustomBackendAuth.DoSigningUp;
begin
  if Assigned(FOnSigningUp) then
    FOnSigningUp(Self);
end;

function TCustomBackendAuth.LoginDialog(out AUserName, APassword: string): Boolean;
var
  LUserName, LPassword: string;
begin
  LUserName := FUserName;
  LPassword := FPassword;
  Result := TLoginCredentialService.GetLoginCredentials('', LUserName, LPassword);
  if Result then
  begin
    AUserName := LUserName;
    APassword := LPassword;
  end;
end;

function TCustomBackendAuth.GetLoggedInToken: string;
begin
  if not FLoggedInValue.TryGetAuthToken(Result) then
    Result := '';
end;

function TCustomBackendAuth.GetLoggedInUserName: string;
begin
  if not FLoggedInValue.TryGetUserName(Result) then
    Result := '';
end;

procedure TCustomBackendAuth.DoAuthAccess(const AProc: TProc<IAuthAccess>);
var
  LItem: IAuthAccess;
begin
  for LItem in  FAuthAccess do
    AProc(LItem);
end;

procedure TCustomBackendAuth.Logout;
begin
  FLoggedInValue := TBackendEntityValue.Empty;
  FAuthentication := TBackendAuthentication.Default; // Do not set property.  Property setter calls DoAuthAccess
                        
  Self.GetAuthApi.Logout;
  DoAuthAccess(
    procedure(AAuth: IAuthAccess)
    begin
      AAuth.Logout;
    end);
  DoLoggedOut;
end;

procedure TCustomBackendAuth.PropertyValueChanged;
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

procedure TCustomBackendAuth.ProviderChanged;
begin
  inherited;
  if not (csLoading in ComponentState) then
    if Provider <> nil then
      DefaultAuthentication := Self.GetAuthApi.DefaultAuthentication;
end;

procedure TCustomBackendAuth.RegisterForAuth(const AAuthAccess: IAuthAccess);
var
  LProvider: IBackendProvider;
begin
  if not FAuthAccess.Contains(AAuthAccess) then
  begin
    LProvider := Self.Provider;
    if (LProvider <> nil) and (AAuthAccess.Provider <> nil) and (AAuthAccess.Provider <> LProvider) then
    begin
      raise EBackendServiceError.Create(sBackendAuthMismatchedProvider);
    end;
    FAuthAccess.Add(AAuthAccess);
    // Synchronize component
    if not (csLoading in ComponentState) then
    begin
      if LoggedIn then
      begin
        AAuthAccess.Login(FLoggedInValue);
        AAuthAccess.SetDefaultAuthentication(Self.DefaultAuthentication);
      end
      else
      begin
        AAuthAccess.SetDefaultAuthentication(Self.DefaultAuthentication);
        AAuthAccess.Logout;
        AAuthAccess.SetAuthentication(Self.Authentication);
      end;
    end;

  end;
end;

procedure TCustomBackendAuth.UserDetailsChanged;
begin
  if (FNotifyList <> nil) then
  begin
    FNotifyList.notify(
      procedure(ANotify: TNotify)
      begin
        ANotify.UserDetailsChanged(self);
      end);
  end;
end;

procedure TCustomBackendAuth.SetAuthentication(
  const Value: TBackendAuthentication);
begin
  // Do not check if FAuthentication <> Value then
  FAuthentication := Value;
  if not (csLoading in ComponentState) then
  begin
    if Provider <> nil then
      Self.GetAuthApi.Authentication := Value;
    DoAuthAccess(
      procedure(AAuth: IAuthAccess)
      begin
        AAuth.SetAuthentication(FAuthentication);
      end);
  end;
end;

procedure TCustomBackendAuth.SetDefaultAuthentication(
  const Value: TBackendDefaultAuthentication);
begin
  // Do not check if FAuthentication <> Value then
  FDefaultAuthentication := Value;
  if not (csLoading in ComponentState) then
  begin
    if Provider <> nil then
      Self.GetAuthApi.DefaultAuthentication := Value;
    DoAuthAccess(
      procedure(AAuth: IAuthAccess)
      begin
        AAuth.SetDefaultAuthentication(FDefaultAuthentication);
      end);
  end;
end;

procedure TCustomBackendAuth.SetUserDetails(const Value: TUserDetailsCollection);
begin
  FUserDetails.Assign(Value);
end;

procedure TCustomBackendAuth.SetPassword(const Value: string);
begin
  FPassword := Value;
  PropertyValueChanged;
end;

procedure TCustomBackendAuth.SetUserName(const Value: string);
begin
  FUserName := Value;
  PropertyValueChanged;
end;

procedure TCustomBackendAuth.UnregisterForAuth(const AAuthAccess: IAuthAccess);
begin
  FAuthAccess.Remove(AAuthAccess);
end;

//procedure TCustomBackendAuth.RetrieveUserDetails;
//begin
//
//end;

procedure TCustomBackendAuth.CheckLoggedIn;
begin
  if not LoggedIn then
    raise EBackendServiceError.Create(sLoginRequired);
end;

procedure TCustomBackendAuth.UpdateUserDetails;
var
  LJSON: TJSONObject;
  LUpdated: TBackendEntityValue;
begin
  CheckLoggedIn;
  LJSON := TJSONObject.Create;
  try
    UserDetailsToJSON(LJSON);
    GetBackendServiceApi.UpdateUser(FLoggedInValue, LJSON, LUpdated);
  finally
    LJSON.Free;
  end;
end;

function TCustomBackendAuth.CreateBindSource: TBaseObjectBindSource;
begin
  FBindSource := TSubLoginBindSource.Create(self);
  FBindSource.Name := 'BindSource'; { Do not localize }
  FBindSource.SetSubComponent(true);
  FBindSource.Component := self;

  Result := FBindSource;
end;

{ TCustomLoginBindSource }

function TCustomLoginBindSource.CreateAdapter: TRESTComponentAdapter;
begin
  FAdapter := TBackendAuthAdapter.Create(self);
  result := FAdapter;
end;

function TCustomLoginBindSource.GetComponent: TCustomBackendAuth;
begin
  result := FAdapter.BackendAuth;
end;

procedure TCustomLoginBindSource.SetComponent(const AValue: TCustomBackendAuth);
begin
  FAdapter.BackendAuth := AValue;
end;

{ TLoginAdapter }

procedure TBackendAuthAdapter.SetBackendAuth(const ALogin: TCustomBackendAuth);
var
  LActive: Boolean;
begin
  if FComponent <> ALogin then
  begin
    if FComponent <> nil then
    begin
      if FComponent.FNotifyList <> nil then
        FComponent.FNotifyList.RemoveNotify(FNotify);
      FComponent.RemoveFreeNotification(self);
    end;
    LActive := Active;
    Active := False;
    FComponent := ALogin;
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

procedure TBackendAuthAdapter.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  /// clean up component-references
  if Operation = opRemove then
  begin
    if AComponent = FComponent then
      BackendAuth := nil
  end;
end;

procedure TBackendAuthAdapter.UserDetailsChanged;
begin
  if (FComponent <> nil) and not(csLoading in FComponent.ComponentState) then
  begin
    if Active and not Posting then
    begin
      // Force to be recreated
      Active := False;
      Active := True;
    end;
  end;
end;

constructor TBackendAuthAdapter.Create(AComponent: TComponent);
begin
  inherited;
  FNotify := TNotify.Create(self);
end;

destructor TBackendAuthAdapter.Destroy;
begin
  inherited;
  if (FComponent <> nil) then
  begin
    if FComponent.FNotifyList <> nil then
      FComponent.FNotifyList.RemoveNotify(FNotify);
  end;
  FNotify.Free;
end;

procedure TBackendAuthAdapter.DoChangePosting;
begin
  inherited;

end;

procedure TBackendAuthAdapter.AddFields;
begin
  AddPropertyFields;
  AddParameterFields;
end;

procedure TBackendAuthAdapter.AddPropertyFields;
const
  sUserName = 'UserName';
  sPassword = 'Password';
var
  LGetMemberObject: IGetMemberObject;
begin
  CheckInactive;
  ClearFields;
  if FComponent <> nil then
  begin
    LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);
    CreateReadWriteField<string>(sUserName, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.UserName
      end,
      procedure(AValue: string)
      begin
        FComponent.UserName := AValue;
      end);
    CreateReadWriteField<string>(sPassword, LGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        Result := FComponent.Password;
      end,
      procedure(AValue: string)
      begin
        FComponent.Password := AValue;
      end);
  end;
end;

procedure TBackendAuthAdapter.AddParameterFields;

  procedure ClearUserDetailFields;
  var
    I: integer;
  begin
    for I := Fields.Count - 1 downto 0 do
      if (Fields[I] is TReadWriteField<string>) and (TReadWriteField<string>(Fields[I]).Persistent <> nil) then
        Fields.Delete(I);
  end;

  procedure MakeUserDetailFieldNames(const ADictionary: TDictionary<string, TCustomBackendAuth.TUserDetailsItem>);
  const
    sPrefix = 'UserDetail.';
  var
    I: integer;
    LUserDetailsCollection: TCustomBackendAuth.TUserDetailsCollection;
    LUserDetailItem: TCustomBackendAuth.TUserDetailsItem;
    LName: string;
    LIndex: integer;
    LSuffix: string;
  begin
    Assert(ADictionary.Count = 0);
    LUserDetailsCollection := FComponent.UserDetails;
    for I := 0 to LUserDetailsCollection.Count - 1 do
    begin
      LUserDetailItem := LUserDetailsCollection[I];
      LName := LUserDetailItem.Name;
      if LName = '' then
        LName := IntToStr(LUserDetailItem.Index);
      LName := sPrefix + LName;
      LIndex := 1;
      LSuffix := '';
      while ADictionary.ContainsKey(LName + LSuffix) do
      begin
        LSuffix := IntToStr(LIndex);
        inc(LIndex);
      end;
      ADictionary.Add(LName + LSuffix, LUserDetailItem);
    end;
  end;

  procedure MakeUserDetailsField(const AExtrasItem: TCustomBackendAuth.TUserDetailsItem; const AFieldName: string;
  const AGetMemberObject: IGetMemberObject);
  begin
    CreateReadWriteField<string>(AFieldName, AGetMemberObject, TScopeMemberType.mtText,
      function: string
      begin
        result := AExtrasItem.Value;
      end,
      procedure(AValue: string)
      begin
        AExtrasItem.Value := AValue;
      end, AExtrasItem); // is member of field

  end;

var
  LDictionary: TDictionary<string, TCustomBackendAuth.TUserDetailsItem>;
  LPair: TPair<string, TCustomBackendAuth.TUserDetailsItem>;
  LGetMemberObject: IGetMemberObject;
begin
  ClearUserDetailFields;
  if FComponent <> nil then
  begin
    LDictionary := TDictionary<string, TCustomBackendAuth.TUserDetailsItem>.Create;
    try
      MakeUserDetailFieldNames(LDictionary);
      LGetMemberObject := TBindSourceAdapterGetMemberObject.Create(self);
      for LPair in LDictionary do
        MakeUserDetailsField(LPair.Value, LPair.Key, LGetMemberObject);
    finally
      LDictionary.Free;
    end;
  end;
end;

function TBackendAuthAdapter.GetCanActivate: Boolean;
begin
  result := (FComponent <> nil);
end;

procedure TBackendAuthAdapter.GetMemberNames(AList: TStrings);
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

function TBackendAuthAdapter.GetSource: TBaseLinkingBindSource;
begin
  result := FComponent;
end;

{ TLoginAdapter.TNotify }

constructor TBackendAuthAdapter.TNotify.Create(
  const AAdapter: TBackendAuthAdapter);
begin
  FAdapter := AAdapter
end;

procedure TBackendAuthAdapter.TNotify.UserDetailsChanged(Sender: TObject);
begin
  if Assigned(FAdapter) then
    FAdapter.UserDetailsChanged;
end;

procedure TBackendAuthAdapter.TNotify.PropertyValueChanged(Sender: TObject);
begin
  if Assigned(FAdapter) then
    FAdapter.RefreshFields;
end;


{ TCustomBackendLogin.TUserDetailsCollection.TEnumerator }

function TCustomBackendAuth.TUserDetailsCollection.TEnumerator.GetCurrent: TUserDetailsItem;
begin
  Result := TUserDetailsItem(inherited GetCurrent);
end;

{ TCustomBackendLogin.TUserDetailsCollection }

procedure TCustomBackendAuth.TUserDetailsCollection.ClearValues;
var
  LItem: TUserDetailsItem;
begin
  for LItem in Self do
    LItem.Value := '';

end;

constructor TCustomBackendAuth.TUserDetailsCollection.Create(const AOwner: TComponent);
begin
  inherited Create(AOwner, TUserDetailsItem);
end;

function TCustomBackendAuth.TUserDetailsCollection.GetAttr(Index: integer): string;
begin
  case index of
    0:
      Result := sExtrasName;
    1:
      Result := sExtrasValue;
  else
    Result := ''; { do not localize }
  end;
end;

function TCustomBackendAuth.TUserDetailsCollection.GetAttrCount: integer;
begin
  Result := 2;
end;

function TCustomBackendAuth.TUserDetailsCollection.GetEnumerator: TEnumerator;
begin
  Result := TEnumerator.Create(self);
end;

function TCustomBackendAuth.TUserDetailsCollection.GetItem(AIndex: integer): TUserDetailsItem;
begin
  Result := TUserDetailsItem(inherited Items[AIndex]);
end;

function TCustomBackendAuth.TUserDetailsCollection.GetItemAttr(Index, ItemIndex: integer): string;
begin
  case index of
    0:
      begin
        Result := Items[ItemIndex].Name;
        if Result = '' then
          Result := IntToStr(ItemIndex);
      end;
    1:
      Result := Items[ItemIndex].Value;
  else
    Result := '';
  end;
end;

procedure TCustomBackendAuth.TUserDetailsCollection.SetItem(AIndex: integer; const AValue: TUserDetailsItem);
begin
  inherited SetItem(AIndex, TCollectionItem(AValue));
end;

procedure TCustomBackendAuth.TUserDetailsCollection.Update(AItem: TCollectionItem);
begin
  inherited;
  if Self.Owner <> nil then
  begin
    if AItem = nil then // Entire list changed
      if Self.Owner is TCustomBackendAuth then
        TCustomBackendAuth(Self.Owner).UserDetailsChanged;
  end;
end;

{ TCustomBackendLogin.TUserDetailsItem }

procedure TCustomBackendAuth.TUserDetailsItem.Assign(ASource: TPersistent);
var
  LExtra: TUserDetailsItem;
begin
  if (ASource is TUserDetailsItem) then
  begin
    LExtra := TUserDetailsItem(ASource);

    FName := LExtra.Name;
    FValue := LExtra.Value;
  end
  else
    inherited;
end;

function TCustomBackendAuth.TUserDetailsItem.GetDisplayName: string;
begin
  result := FName;
end;

procedure TCustomBackendAuth.TUserDetailsItem.SetName(const AValue: string);
begin
  if FName <> AValue then
  begin
    FName := AValue;
    Changed(False);

    if Self.Collection.Owner is TCustomBackendAuth then
      TCustomBackendAuth(Self.Collection.Owner).UserDetailsChanged;
  end;
end;

procedure TCustomBackendAuth.TUserDetailsItem.SetValue(const AValue: string);
begin
  if FValue <> AValue then
  begin
    FValue := AValue;
    Changed(False);

    if (Self.Collection is TUserDetailsCollection) and (Self.Collection.Owner <> nil) then
      if Self.Collection.Owner is TCustomBackendAuth then
        TCustomBackendAuth(Self.Collection.Owner).PropertyValueChanged;
  end;
end;

function TCustomBackendAuth.TUserDetailsItem.ToString: string;
begin
  result := Format('%s=%s', [FName, FValue])
end;

{ TCustomBackendLogin.TNotify }

procedure TCustomBackendAuth.TNotify.UserDetailsChanged(Sender: TObject);
begin
//
end;


{ TAuthAccess }

constructor TAuthAccess.Create(const AComponent: IBackendServiceComponent;
  const AAuthentication: TFunc<IBackendAuthenticationApi>);
begin
  FAuthentication := AAuthentication;
  FComponent := AComponent;
end;

function TAuthAccess.GetProvider: IBackendProvider;
begin
  Result := FComponent.Provider;
end;

procedure TAuthAccess.Login(const ALogin: TBackendEntityValue);
begin
  FAuthentication.Login(ALogin);
end;

procedure TAuthAccess.Logout;
begin
  FAuthentication.Logout;
end;

procedure TAuthAccess.SetAuthentication(const Value: TBackendAuthentication);
begin
  FAuthentication.Authentication := Value;
end;

procedure TAuthAccess.SetDefaultAuthentication(
  const Value: TBackendDefaultAuthentication);
begin
  FAuthentication.DefaultAuthentication := Value;
end;

end.
