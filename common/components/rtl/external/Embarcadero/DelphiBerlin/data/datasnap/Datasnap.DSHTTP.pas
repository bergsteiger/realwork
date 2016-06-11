{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSHTTP;

interface

uses
  System.JSON,
  System.Classes,
  System.SysUtils,
  Data.DBXCommon,
  Data.DBXTransport,
  Data.DbxDatasnap,
  Datasnap.DSHTTPCommon,
  Datasnap.DSAuth,
  Datasnap.DSTransport,
  Datasnap.DSCommonServer,
  Datasnap.DSServer,
  Datasnap.DSService,
  Datasnap.DSSession,
  System.Generics.Collections,
  Web.WebFileDispatcher,
  IPPeerAPI;

type
  /// <summary>Serves a response to a DataSnap/cache request for supported
  /// request types (GET and DELETE).</summary>
  TDSHTTPCacheContextService = class(TDSRequestFilterManager)
  private
    FSession: TDSSession;
    FLocalConnection: Boolean;

    ///  <summary> Parses the request for the desired Cache item ID, command index and parameter index.
    ///     Any of these can be -1 instead of an actual value, as long as the ones after it are also -1.
    ///  </summary>
    function ParseRequst(Request: string; out CacheId, CommandIndex, ParameterIndex: Integer): Boolean;
    procedure InvalidRequest(Response: TDSHTTPResponse; Request: string);
    ///  <summary> Returns the Cache Item IDs as held by the cache </summary>
    procedure GetCacheContents(out Value: TJSONValue);
    ///  <summary> Returns the number of commands held by the item. (Usually 1)
    /// </summary>
    procedure GetCacheItemContents(const CacheId: Integer; out Value: TJSONValue);
    ///  <summary> Returns the number of parameters held by the command
    /// </summary>
    procedure GetCommandContents(const CacheId: Integer; const CommandIndex: Integer; out Value: TJSONValue);
    ///  <summary> Returns the parameter value as either JSON or TStream, depending on the request
    /// </summary>
    procedure GetParameterValue(const RequestInfo: TDSHTTPRequest; const CacheId: Integer;
                                const CommandIndex: Integer; const ParameterIndex: Integer;
                                out Response: TJSONValue; out ResponseStream: TStream; out IsError: Boolean);
    ///  <summary> Returns the parameter index for the given command. </summary>
    function GetOriginalParamIndex(const Command: TDBXCommand; const Parameter: TDBXParameter): Integer;
    ///  <summary> Returns true if Streams should be returned as JSON, false to return them as content stream
    /// </summary>
    function StreamsAsJSON(const RequestInfo: TDSHTTPRequest): Boolean;

    function ByteContent(JsonValue: TJSONValue): TArray<Byte>;
  public
    constructor Create(Session: TDSSession; LocalConnection: Boolean); reintroduce; virtual;

    ///  <summary> Uses the given Request string to deterine which part of the cache the client is interested in,
    ///     and populates the result accordingly.
    ///  </summary>
    procedure ProcessGETRequest(const RequestInfo: TDSHTTPRequest; Response: TDSHTTPResponse; Request: string);
    ///  <summary> Uses the given Request string to deterine which part of the cache the client wants to delete,
    ///     and populates the result accordingly after performing the deletion.
    ///  </summary>
    procedure ProcessDELETERequest(const RequestInfo: TDSHTTPRequest; Response: TDSHTTPResponse; Request: string);
  end;

  /// <summary>Represents the DataSnap-specific REST server.</summary>
  TDSRESTServer = class
  public type
    TParsingRequestEvent = TDSServiceResponseHandler.TParsingRequestEvent;
    TParseRequestEvent = TDSServiceResponseHandler.TParseRequestEvent;
  private
    /// <summary> Time in miliseconds a session will remain valid. </summary>
    /// <remarks> After this time passes, the session is marked as expired and eventually removed.
    ///     If 0 is specified, the session never expires.
    /// </remarks>
    FSessionTimeout: Integer;
    ///  <summary> Name of a DSServer in the current process </summary>
    FDSServerName: string;
    FDSHTTPAuthenticationManager: TDSCustomAuthenticationManager;
    FProtocolHandlerFactory: TDSJSONProtocolHandlerFactory;
    FIPImplementationID: string;
    FRESTContext: string;
    FDSContext: string;
    FSessionLifetime: TDSSessionLifetime;

    FTrace: TDSHTTPServiceTraceEvent;
    FParseRequestEvent: TParseRequestEvent;
    FParsingRequestEvent: TParsingRequestEvent;

    FResultEvent: TDSRESTResultEvent;
    FDSServer: TDSCustomServer;

    function GetRestContext: string;
    function GetDsContext: string;

    procedure SetRestContext(const ctx: string);
    procedure SetDsContext(const ctx: string);

    ///  <summary> Tries to consume the prefix out of the context. Returns what
    ///    is left of it, nil if the prefix is not found.
    ///  <param name="prefix">prefix string, not null or empty</param>
    ///  <param name="context">current context, never null or empty</param>
    ///  <param name="unused">unused part of the context</param>
    ///  <return>true if the context has the prefix</return>
    ///  </summary>
    function Consume(const Prefix: string; const Context: string; out Unused: string): Boolean;

    function ByteContent(DataStream: TStream): TArray<Byte>; overload;
    function ByteContent(JsonValue: TJSONValue): TArray<Byte>; overload;

    property RESTContext: string read GetRestContext write SetRESTContext;
    property DSContext: string read GetDSContext write SetDSContext;

    procedure SetAuthenticationManager(AuthenticationManager: TDSCustomAuthenticationManager); virtual;

    function IsClosingSession(const Request: string): Boolean;
    function IsOpeningClientChannel(const Request: string): Boolean;
    function IsClosingClientChannel(const Request: string): Boolean;
    procedure UpdateSessionTunnelHook(const Request: string; Session: TDSSession; RequestInfo: TDSHTTPRequest); virtual;
    procedure CloseRESTSession(Session: TDSSession; ResponseInfo: TDSHTTPResponse);
    procedure CheckClientChannelMethod(const Request: string);

    function CreateRESTService(const AuthUserName, AuthPassword: string): TDSRESTService; virtual;

  strict protected
    procedure SetDSServerName(AName: string); virtual;
    function ConsumeOtherContext(const AContext: string; out APrefix: string; out AUnused: string): Boolean; virtual;
    procedure DoDSOtherCommand(
      const AContext: TDSHTTPContext;
      const ARequestInfo: TDSHTTPRequest;
      const AResponseInfo: TDSHTTPResponse;
      const APrefix: string;
      const ARequest: string;
      ALocalConnection: Boolean); virtual;
    procedure DoDSRESTCommand(ARequestInfo: TDSHTTPRequest; AResponseInfo: TDSHTTPResponse; Request: string);
    procedure DoCommand(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
                                    AResponseInfo: TDSHTTPResponse);
    procedure DoCommandOtherContext(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
                                    AResponseInfo: TDSHTTPResponse; const ARequest: string); virtual;
  protected
    function Decode(Data: string): string; virtual; abstract;

  public
    constructor Create; overload;
    constructor Create(const AIPImplementationID: string); overload;
    constructor Create(const ADSServer: TDSCustomServer); overload;
    constructor Create(const ADSServer: TDSCustomServer; const AIPImplementationID: string); overload; virtual;
    destructor Destroy; override;

    procedure CreateProtocolHandlerFactory(ATransport: TDSServerTransport); virtual;
    procedure ClearProtocolHandlerFactory; virtual;

    property DSServer: TDSCustomServer read FDSServer write FDSServer;
    property DSServerName: string read FDSServerName write SetDSServerName;
    property DSAuthenticationManager: TDSCustomAuthenticationManager read FDSHTTPAuthenticationManager
                                            write SetAuthenticationManager;
    property SessionTimeout: Integer read FSessionTimeout write FSessiontimeout;
    property SessionLifetime: TDSSessionLifetime read FSessionLifetime write FSessionLifetime;
    property IPImplementationID: string read FIPImplementationID;

    /// <summary>Event to call when a REST call is having its result built, to be returned.</summary>
    property ResultEvent: TDSRESTResultEvent read FResultEvent write FResultEvent;
    property OnParsingRequest: TParsingRequestEvent read FParsingRequestEvent write FParsingRequestEvent;
    property OnParseRequest: TParseRequestEvent read FParseRequestEvent write FParseRequestEvent;
  end;

  /// <summary>HTTP server that provides DataSnap-specific implementations for
  /// different command types, and supports both REST and HTTP.</summary>
  TDSHTTPServer = class(TDSRESTServer)
  strict private
    ///  <summary> DS host name. Only used if DSServerName is not specified </summary>
    FDSHostname: string;
    ///  <summary> DS host port number. Only used if DSServerName is not specified </summary>
    FDSPort: Integer;
    ///  <summary> Filter reference </summary>
    FFilters: TTransportFilterCollection;
    ///  <summary>true if the user credentials are passed through remote DS instance</summary>
    FCredentialsPassThrough: Boolean;
    ///  <summary>DS user credentials, they work in tandem with the pass through</summary>
    FDSAuthUser: string;
    FDSAuthPassword: string;
    FCacheContext: string;

//    /// <summary> Time in miliseconds a session will remain valid. </summary>
//    /// <remarks> After this time passes, the session is marked as expired and eventually removed.
//    ///     If 0 is specified, the session never expires.
//    /// </remarks>
//    FSessionTimeout: Integer;
    FSessionEvent: TDSSessionEvent;
  private
    FTunnelService: TDSTunnelService;

    procedure SetDSHostname(AHostname: string);
    procedure SetDSPort(APort: Integer);
    procedure SetFilters(AFilterCollection: TTransportFilterCollection);
    procedure SetAuthenticationManager(AuthenticationManager: TDSCustomAuthenticationManager); override;

    function GetTunnelService: TDSTunnelService;
    procedure CloseAllTunnelSessions;

    function CreateRESTService(const AuthUserName, AuthPassword: string): TDSRESTService; override;
    function GetCacheContext: string;
    procedure SetCacheContext(const ctx: string);

    function GetClientChannelInfo(Request: string; out ChannelName, ClientChannelId, ClientCallbackID,  SecurityToken: string): Boolean;
    procedure UpdateSessionTunnelHook(const Request: string; Session: TDSSession; RequestInfo: TDSHTTPRequest); override;
    procedure CloseSessionTunnels(Session: TDSSession);

  strict protected
    procedure SetDSServerName(AName: string); override;
    procedure DoTunnelCommand(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest; AResponseInfo: TDSHTTPResponse);

    function ConsumeOtherContext(const AContext: string; out APrefix: string; out AUnused: string): Boolean; override;
    procedure DoDSOtherCommand(
      const AContext: TDSHTTPContext;
      const ARequestInfo: TDSHTTPRequest;
      const AResponseInfo: TDSHTTPResponse;
      const APrefix: string;
      const ARequest: string;
      ALocalConnection: Boolean); override;
    procedure DoDSCacheCommand(ARequestInfo: TDSHTTPRequest; AResponseInfo: TDSHTTPResponse; Request: string;
                               LocalConnection: Boolean);
  public
    constructor Create(const ADSServer: TDSCustomServer; const AIPImplementationID: string); overload; override;
    destructor Destroy; override;

    procedure CreateProtocolHandlerFactory(ATransport: TDSServerTransport); override;
    procedure ClearProtocolHandlerFactory; override;

    property CacheContext: string read GetCacheContext write SetCacheContext;
    property TunnelService: TDSTunnelService read GetTunnelService;
    property DSHostname: string read FDSHostname write SetDSHostname;
    property DSPort: Integer read FDSPort write SetDSPort;
    property Filters: TTransportFilterCollection read FFilters write SetFilters;
    property CredentialsPassThrough: Boolean read FCredentialsPassThrough write FCredentialsPassThrough;
    property DSAuthUser: string read FDSAuthUSer write FDSAuthUser;
    property DSAuthPassword: string read FDSAuthPassword write FDSAuthPassword;
  end;

  /// <summary>Default implementation of a response handler that returns JSON
  /// for all data types, except for the case where the user specifies that he
  /// wants a TStream to be returned in the response stream when the TStream is
  /// the only output/response parameter of the method being invoked.</summary>
  TDSDefaultResponseHandler = class(TDSJsonResponseHandler)
  private
    FStoreHandler: Boolean;
  protected
    function HandleParameter(const Command: TDBXCommand; const Parameter: TDBXParameter;
                             out Response: TJSONValue; var ResponseStream: TStream): Boolean; override;
    procedure PopulateContent(ResponseInfo: TDSHTTPResponse; Response: TJSONValue;
                              ResponseStream: TStream); override;
  public
    constructor Create(AllowBinaryStream: Boolean; DSService: TDSService; CommandType: TDSHTTPCommandType;
                       ServiceInstanceOwner: Boolean = True);
    destructor Destroy; override;

    procedure Close; override;
  end;

  /// <summary>Implements the REST architecture for the REST service provider of
  /// a DataSnap server.</summary>
  TCustomDSRESTServerTransport = class(TDSServerTransport)
  public type
    TParsingRequestEvent = procedure(Sender: TObject; const ARequest: string; const ASegments: TStrings;
                         var ADSMethodName: string; const AParamValues: TStrings; var AHandled: Boolean) of object;
    TParseRequestEvent = procedure(Sender: TObject; const ARequest: string; const ASegments: TStrings;
                         var ADSMethodName: string; const AParamValues: TStrings) of object;
  strict protected
    FRESTServer: TDSRESTServer;
  strict private
    { Private declarations }
    FSessionLifetime: TDSSessionLifetime;
    FSessionTimeout: Integer;
    FDSContext: string;
    FDSRestContext: string;
    FAuthenticationManager: TDSCustomAuthenticationManager;
    FTrace: TDSHTTPServiceTraceEvent;
    FResultEvent: TDSRESTResultEvent;
    FParsingRequestEvent: TParsingRequestEvent;
    FParseRequestEvent: TParseRequestEvent;
  private
    function GetRESTServer: TDSRESTServer;
    procedure UpdateDSServerName;
    function IsDSContextStored: Boolean;
    function IsRESTContextStored: Boolean;
    procedure ReadTrace(Reader: TReader);
    procedure ReadFormatResult(Reader: TReader);
    procedure ReadProperty(Reader: TReader; const ANewProperty: string);
  protected
    procedure Loaded; override;
    procedure RequiresServer;
    function CreateRESTServer: TDSRESTServer; virtual; abstract;
    procedure InitializeRESTServer; virtual;
    { Protected declarations }
    procedure SetRESTContext(const Ctx: string );
    procedure SetDSContext(const Ctx: string);
    procedure SetTraceEvent(Event: TDSHTTPServiceTraceEvent);

    procedure SetParseRequestEvent(Event: TParseRequestEvent);
    function GetParseRequestEvent: TParseRequestEvent;
    procedure SetParsingRequestEvent(Event: TParsingRequestEvent);
    function GetParsingRequestEvent: TParsingRequestEvent;

    procedure SetServer(const AServer: TDSCustomServer); override;
    procedure SetAuthenticationManager(const AuthenticationManager: TDSCustomAuthenticationManager);
    procedure SetResultEvent(const RestEvent: TDSRESTResultEvent);
    procedure SetIPImplementationID(const AIPImplementationID: string); override;

    function GetRESTContext: string;
    function GetDSContext: string;
    function GetTraceEvent: TDSHTTPServiceTraceEvent;
    function GetAuthenticationManager: TDSCustomAuthenticationManager;
    function GetResultEvent: TDSRESTResultEvent;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetSessionTimeout: Integer; virtual;
    procedure SetSessionTimeout(const Milliseconds: Integer); virtual;
    function GetIPImplementationID: string; override;
    // Backward compatability
    procedure DefineProperties(Filer: TFiler); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property RESTServer: TDSRESTServer read GetRESTServer;

    [Stored('IsDSContextStored'), nodefault]
    property DSContext: string read GetDSContext write SetDSContext stored IsDSContextStored nodefault;
    ///  <summary> REST URL context like in http://my.site.com/datasnap/rest/...
    ///     In the example above rest denotes that the request is a REST request
    ///     and is processed by REST service
    ///  </summary>
    [Stored('IsRESTContextStored'), nodefault]
    property RESTContext: string read GetRESTContext write SetRESTContext stored IsRESTContextStored nodefault;

    property AuthenticationManager: TDSCustomAuthenticationManager read GetAuthenticationManager
                                               write SetAuthenticationManager;
    ///  <summary> Time in miliseconds a session will remain valid. </summary>
    ///  <remarks> After this time passes, the session is marked as expired and eventually removed.
    ///     If 0 is specified, the session never expires.
    /// </remarks>
    [Default(1200000)]
    property SessionTimeout: Integer read GetSessionTimeout write SetSessionTimeout default 1200000;
    property SessionLifetime: TDSSessionLifetime read FSessionLifetime write FSessionLifetime default TDSSessionLifetime.TimeOut;
    ///  <summary> User trace code might go here
    ///  </summary>
    property OnHTTPTrace: TDSHTTPServiceTraceEvent read GetTraceEvent write SetTraceEvent;
    property Trace: TDSHTTPServiceTraceEvent read GetTraceEvent write SetTraceEvent;  // Old name
    /// <summary>Event to call when a REST call is having its result built.</summary>
    /// <remarks>The result can be modified by this event, changing its format or content.</remarks>
    property OnFormatResult: TDSRESTResultEvent read GetResultEvent write SetResultEvent;
    property FormatResult: TDSRESTResultEvent read GetResultEvent write SetResultEvent; // Old name

    property OnParseRequest: TParseRequestEvent read GetParseRequestEvent write SetParseRequestEvent;
    property OnParsingRequest: TParsingRequestEvent read GetParsingRequestEvent write SetParsingRequestEvent;
  end;


  /// <summary>Represents the HTTP service provider of a DataSnap server,
  /// providing lightweight HTTP services for DataSnap, and implementing
  /// protocols such as REST.</summary>
  TCustomDSHTTPServerTransport = class(TCustomDSRESTServerTransport)
  strict protected
    FHttpServer: TDSHTTPServer;
  strict private
    { Private declarations }
    FCredentialsPassthrough: Boolean;
    FDSAuthPassword: string;
    FDSAuthUser: string;
    FDSPort: Integer;
    FDSHostName: string;
    FDSCacheContext: string;
    function IsCacheContextStored: Boolean;
  private
    function GetHttpServer: TDSHTTPServer;
    function IsDSHostnameStored: Boolean;
    procedure SetCacheContext(const Ctx: string);
    function GetCacheContext: string;
  protected
    function CreateHttpServer: TDSHTTPServer; virtual; abstract;
    function CreateRESTServer: TDSRESTServer; override;
    procedure InitializeRESTServer; override;
    procedure InitializeHttpServer; virtual;
    { Protected declarations }
    procedure SetDSHostname(Host: string );
    procedure SetDSPort(Port: Integer);
    function GetDSHostname: string;
    function GetDSPort: Integer;

    procedure SetFilters(const Value: TTransportFilterCollection); override;
    procedure ServerCloseAllTunnelSessions;
    procedure SetCredentialsPassThrough(const AFlag: Boolean); virtual;
    procedure SetDSAuthUser(const UserName: string); virtual;
    procedure SetDSAuthPassword(const UserPassword: string); virtual;
    function GetCredentialsPassThrough: Boolean;
    function GetDSAuthUser: string; virtual;
    function GetDSAuthPassword: string; virtual;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;

    property HttpServer: TDSHTTPServer read GetHttpServer;

    ///  <summary> Cache URL context, like in http://my.site.com/datasnap/cache/...
    ///  </summary>
    [Stored('IsCacheContextStored'), nodefault]
    property CacheContext: string read GetCacheContext write SetCacheContext stored IsCacheContextStored nodefault;

    ///  <summary> Datasnap Server machine name. Only used when DSServer is not set </summary>
    [Stored('IsDSHostnameStored'), nodefault]
    property DSHostname: string read GetDSHostname write SetDSHostname stored IsDSHostnameStored nodefault;
    ///  <summary> Datasnap Server port number. Only used when DSServer is not set </summary>
    [Default(211)]
    property DSPort: Integer read GetDSPort write SetDSPort default 211;
    ///  <summary> true if the user credentials are authenticated at the endpoint </summary>
    [Default(False)]
    property CredentialsPassThrough: Boolean read GetCredentialsPassThrough write SetCredentialsPassThrough default False;

    property DSAuthUser: string read GetDSAuthUser write SetDSAuthUser;
    property DSAuthPassword: string read GetDSAuthPassword write SetDSAuthPassword;

  end;

  /// <summary>Implements the REST architecture for the REST service provider of
  /// a DataSnap server.</summary>
  TDSRESTServerTransport = class(TCustomDSRESTServerTransport)
  published
    property DSContext;
    property RESTContext;
    property Server;
    property AuthenticationManager;
    property SessionTimeout;
    property SessionLifetime;
    property OnParseRequest;
    property OnParsingRequest;
    property OnHTTPTrace;
    property OnFormatResult;
  end;

  /// <summary>Lightweight HTTP service provider for DataSnap servers that
  /// implements internet protocols such as REST or HTTP.</summary>
  TDSHTTPServerTransport = class(TCustomDSHTTPServerTransport)
  published
    property DSContext;
    property RESTContext;
    property CacheContext;
    property Server;
    property DSHostname;
    property DSPort;
    property Filters;
    property AuthenticationManager;
    property CredentialsPassThrough;
    property DSAuthUser;
    property DSAuthPassword;
    property SessionTimeout;
                                      
    property OnHTTPTrace;
    property OnFormatResult;
  end;


  /// <summary>Response handler for the case when complex data types are stored
  /// on the server in a cache and the URL (Uniform Resource Identifier) to the
  /// object in the cache is passed back to the user instead of the value of the
  /// cached object.</summary>
  TDSCacheResponseHandler = class(TDSJsonResponseHandler)
  protected
    FResultHandler: TDSCacheResultCommandHandler;
    FCacheId: Integer;
    function GetCacheObject: TDSCacheResultCommandHandler;
    function HandleParameter(const Command: TDBXCommand; const Parameter: TDBXParameter;
                             out Response: TJSONValue; var ResponseStream: TStream): Boolean; override;
    procedure PopulateContent(ResponseInfo: TDSHTTPResponse; Response: TJSONValue;
                              ResponseStream: TStream); override;
    function GetComplexParams(Command: TDBXCommand; out Index: Integer;
                              AddIfNotFound: Boolean = True): TDSCommandComplexParams;
    procedure ProcessResultObject(var ResultObj: TJSONObject; Command: TDBXCommand); override;
  public
    constructor Create(DSService: TDSService; CommandType: TDSHTTPCommandType; ServiceInstanceOwner: Boolean = True);
    destructor Destroy; override;

    procedure Close; override;
  end;

  /// <summary>Represents the factory class for creating an appropriate instance
  /// of TDSServiceResponseHandler.</summary>
  TDSResponseHandlerFactory = class
  public
    /// <summary> Returns a new instance of the appropriate TDSServiceResponseHandler implementation,
    ///     based on the provided information.
    /// </summary>
    class function CreateResponseHandler(DSService: TDSService;
                                         RequestInfo: TDSHTTPRequest;
                                         CommandType: TDSHTTPCommandType = TDSHTTPCommandType.hcUnknown;
                                         HTTPServer: TDSHTTPServer = nil): TDSServiceResponseHandler; overload;
    /// <summary> Returns a new instance of the appropriate TDSServiceResponseHandler implementation,
    ///     based on the provided information.
    /// </summary>
    class function CreateResponseHandler(DSService: TDSService;
                                         RequestInfo: TDSHTTPRequest;
                                         CommandType: TDSHTTPCommandType;
                                         HTTPServer: TDSRESTServer): TDSServiceResponseHandler; overload;
  end;

  TDSHTTPServiceComponent = class;

  TDSCustomCertFiles = class;

  TDSHTTPService = class(TCustomDSHTTPServerTransport)
  private
    FComponentList: TList<TComponent>;
    FCertFiles: TDSCustomCertFiles;
    FDefaultPort: Integer;
    FActive: Boolean;
    procedure RemoveComponent(const AComponent: TDSHTTPServiceComponent);
    procedure AddComponent(const AComponent: TDSHTTPServiceComponent);
    procedure SetCertFiles(const AValue: TDSCustomCertFiles);
  protected
    function CreateHttpServer: TDSHTTPServer; override;
    procedure InitializeHttpServer; override;
    procedure HTTPOtherContext(
      AContext: TDSHTTPContext;
      ARequestInfo: TDSHTTPRequest; AResponseInfo: TDSHTTPResponse;
      const ARequest: string; var AHandled: Boolean); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetHttpPort: Word; virtual;
    function GetServerSoftware: string; virtual;
    procedure SetIPImplementationID(const Value: string); override;

    function IsActive: Boolean; virtual;
    procedure SetActive(Status: Boolean); virtual;
    procedure SetHttpPort(const Port: Word); virtual;
    ///<summary>
    ///  Called by the server when it is starting.
    ///</summary>
    procedure Start; override;
    ///<summary>
    ///  Called by the server when it is stoping.
    ///</summary>
    procedure Stop; override;
  published
    { Published declarations }
    ///  <summary> HTTP port </summary>
    [Default(_IPPORT_HTTP)]
    property HttpPort: Word read GetHttpPort write SetHttpPort default _IPPORT_HTTP;
    ///  <summary> REST URL context like in http://my.site.com/datasnap/rest/...
    ///     In the example above rest denotes that the request is a REST request
    ///     and is processed by REST service
    ///  </summary>
    ///  <summary> True to start the service, false to stop it
    ///  </summary>
    [Default(False)]
    property Active: Boolean read IsActive write SetActive default False;
    ///  <summary> Server software, read only
    ///  </summary>
    property ServerSoftware: string read GetServerSoftware;
    /// <summary> X.509 certificates and keys</summary>
    property CertFiles: TDSCustomCertFiles read FCertFiles write SetCertFiles;

    property IPImplementationID;
    property DSContext;
    property RESTContext;
    property CacheContext;
    property OnHTTPTrace;
    property OnFormatResult;
    property Server;
    property DSHostname;
    property DSPort;
    property Filters;
    property AuthenticationManager;
    property CredentialsPassThrough;
    property DSAuthUser;
    property DSAuthPassword;
    property SessionTimeout;
  end;

  {$IFNDEF NEXTGEN}
  TGetPEMFilePasskey = procedure(ASender: TObject; var APasskey: AnsiString) of object;
  {$ENDIF}
  TGetPEMFileSBPasskey = procedure(ASender: TObject; APasskey: TStringBuilder) of object;

  /// <summary>Provides information about X.509 certificates and private keys</summary>
  /// <remarks>Associate with a TDSHTTPService component to enable server side SSL</remarks>
  TDSCustomCertFiles = class(TComponent)
  private
    FCertFile: string;
    FKeyFile: string;
    FRootCertFile: string;
    {$IFNDEF NEXTGEN}
    FGetPEMFilePasskey: TGetPEMFilePasskey;
    {$ENDIF}
    FGetPEMFileSBPasskey: TGetPEMFileSBPasskey;
    function GetCertFile: string;
    function GetKeyFile: string;
    function GetRootCertFile: string;
    procedure SetCertFile(const Value: string);
    procedure SetRootCertFile(const Value: string);
    procedure SetKeyFile(const Value: string);
    {$IFNDEF NEXTGEN}
    procedure SetOnGetPEMFilePasskey(const Value: TGetPEMFilePasskey);
    function GetOnGetPEMFilePasskey: TGetPEMFilePasskey;
    {$ENDIF}
    procedure SetOnGetPEMFileSBPasskey(const Value: TGetPEMFileSBPasskey);
    function GetOnGetPEMFileSBPasskey: TGetPEMFileSBPasskey;
  published
    /// <summary>Provides the HTTP server implementation object with  X.509 information</summary>
    /// <param name="AServer">HTTP server implementation object</param>
    procedure SetServerProperties(AServer: TObject); virtual;
  public
    /// <summary>File of the X.509 root certificate</summary>
    property RootCertFile: string read GetRootCertFile write SetRootCertFile;
    /// <summary>File of the X.509 certificate</summary>
    property CertFile: string read GetCertFile write SetCertFile;
    /// <summary>File of the X.509 private key</summary>
    property KeyFile: string read GetKeyFile write SetKeyFile;
    {$IFNDEF NEXTGEN}
    /// <summary>Event handler to provide the string used to encrypt the private key in KeyFile</summary>
    property OnGetPEMFilePasskey: TGetPEMFilePasskey read GetOnGetPEMFilePasskey write SetOnGetPEMFilePasskey;
    {$ENDIF}
    /// <summary>Event handler to provide the string used to encrypt the private key in KeyFile</summary>
    property OnGetPEMFileSBPasskey: TGetPEMFileSBPasskey read GetOnGetPEMFileSBPasskey write SetOnGetPEMFileSBPasskey;
  end;

  /// <summary>Provides information about X.509 certificates and private
  /// keys.</summary>
  TDSCertFiles = class(TDSCustomCertFiles)
  published
    property RootCertFile;
    property CertFile;
    property KeyFile;
    {$IFNDEF NEXTGEN}
    property OnGetPEMFilePasskey;
    {$ENDIF}
    property OnGetPEMFileSBPasskey;
  end;

  TDSHTTPServiceComponent = class(TComponent)
  private
    FService: TDSHTTPService;
    procedure SetService(const AValue: TDSHTTPService);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    procedure DoCommand(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
      AResponseInfo: TDSHTTPResponse; const ARequest: string; var AHandled: Boolean); virtual; abstract;
  public
  published
    property Service: TDSHTTPService read FService write SetService;
  end;

  TDispatchFileEvent = procedure (Sender: TObject; const AFileName: string;
    AContext: TDSHTTPContext; Request: TDSHTTPRequest;
    Response: TDSHTTPResponse; var Handled: Boolean) of object;

  TDSCustomHTTPServiceFileDispatcher = class(TDSHTTPServiceComponent)
  private
    FFileDispatcherProperties: TWebFileDispatcherProperties;
    FBeforeDispatch: TDispatchFileEvent;
    FAfterDispatch: TDispatchFileEvent;
    procedure SetWebFileExtensions(const Value: TWebFileExtensions);
    function GetWebFileExtensions: TWebFileExtensions;
    procedure SetWebDirectories(const Value: TWebDirectories);
    function GetWebDirectories: TWebDirectories;
    function GetRootDirectory: string;
    procedure SetRootDirectory(const Value: string);
    function IsRootDirectoryStored: Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    procedure DoCommand(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
      AResponseInfo: TDSHTTPResponse; const ARequest: string; var AHandled: Boolean); override;
  protected
    procedure DoBeforeDispatch(Sender: TObject; const AFileName: string;
      AContext: TDSHTTPContext; Request: TDSHTTPRequest;
      Response: TDSHTTPResponse; var Handled: Boolean); virtual;
    property BeforeDispatch: TDispatchFileEvent read FBeforeDispatch write FBeforeDispatch;
    property AfterDispatch: TDispatchFileEvent read FAfterDispatch write FAfterDispatch;
    property WebFileExtensions: TWebFileExtensions read GetWebFileExtensions write SetWebFileExtensions;
    property WebDirectories: TWebDirectories read GetWebDirectories write SetWebDirectories;
    [Stored('IsRootDirectoryStored'), nodefault]
    property RootDirectory: string read GetRootDirectory write SetRootDirectory stored IsRootDirectoryStored nodefault;
  end;

  TDSHTTPServiceFileDispatcher = class(TDSCustomHTTPServiceFileDispatcher)
  published
    property BeforeDispatch;
    property AfterDispatch;
    property WebFileExtensions;
    property WebDirectories;
    property RootDirectory;
  end;

  TDSHTTPRequestIndy = class;
  TDSHTTPResponseIndy = class;

  /// <summary>Represents the Indy implementation of the DataSnap HTTP
  /// context.</summary>
  TDSHTTPContextIndy = class(TDSHTTPContext)
  private
    FContext: IIPContext;
    FRequest: TDSHTTPRequestIndy;
    FResponse: TDSHTTPResponseIndy;
  public
    constructor Create(const AContext: IIPContext; const ARequestInfo: IIPHTTPRequestInfo;
                                const AResponseInfo: IIPHTTPResponseInfo);
    destructor Destroy; override;
    function Connected: Boolean; override;
    ///  <summary>Indy Context.  Provided so that event handlers can get to Indy specific properties.
    ///  </summary>
    property Context: IIPContext read FContext;
  end;

  ///  <summary>A Indy implementation of DataSnap HTTP Request
  ///  </summary>
  TDSHTTPRequestIndy = class(TDSHTTPRequest)
  strict private
    FRequestInfo: IIPHTTPRequestInfo;
    FDocument: string;
  protected
    function GetCommand: string; override;
    function GetCommandType: TDSHTTPCommandType; override;
    function GetDocument: string; override;
    function GetParams: TStrings; override;
    function GetPostStream: TStream; override;
    function GetAuthUserName: string; override;
    function GetAuthPassword: string; override;
    function GetURI: string; override;
    function GetPragma: string; override;
    function GetAccept: string; override;
    function GetRemoteIP: string; override;
    function GetUserAgent: string; override;
    function GetProtocolVersion: string; override;
  public
    constructor Create(ARequestInfo: IIPHTTPRequestInfo);
    ///  <summary>Indy RequestInfo.  Provided so that event handlers can get to Indy specific properties.
    ///  </summary>
    property RequestInfo: IIPHTTPRequestInfo read FRequestInfo;
  end;

  ///  <summary>Indy implementation of  DataSnap HTTP Response
  ///  </summary>
  TDSHTTPResponseIndy = class(TDSHTTPResponse)
  strict private
    FResponseInfo: IIPHTTPResponseInfo;
  strict protected
    function GetContentStream: TStream; override;
    function GetResponseNo: Integer; override;
    function GetResponseText: string; override;
    procedure SetContentStream(const Value: TStream); override;
    procedure SetResponseNo(const Value: Integer); override;
    procedure SetResponseText(const Value: string); override;
    function GetContentText: string; override;
    procedure SetContentText(const Value: string); override;
    function GetContentLength: Int64; override;
    procedure SetContentLength(const Value: Int64); override;
    function GetCloseConnection: Boolean; override;
    procedure SetCloseConnection(const Value: Boolean); override;
    function GetPragma: string; override;
    procedure SetPragma(const Value: string); override;
    function GetContentType: string; override;
    procedure SetContentType(const Value: string); override;
    function GetFreeContentStream: Boolean; override;
    procedure SetFreeContentStream(const Value: Boolean); override;
  public
    constructor Create(AResponseInfo: IIPHTTPResponseInfo);

    procedure SetHeaderAuthentication(const Value: string; const Realm: string); override;

    ///  <summary>Indy ResponseInfo.  Provided so that event handlers can get to Indy specific properties.
    ///  </summary>
    property ResponseInfo: IIPHTTPResponseInfo read FResponseInfo;
  end;


  /// <summary>Singleton that manages http applications.</summary>
  TDSHTTPApplication = class
  public const
    // Context object names
    sSessionObject = 'session';
  private
    class var
      FInstance: TDSHTTPApplication;
  private
    /// <summary> Loads the session with the given session ID and sets it into the thread. </summary>
    /// <remarks> Pass in an empty string to create a new session </remarks>
    /// <returns> True if successful, false if passed an expired or invalid session ID </returns>
    function LoadRESTSession(const SessionId, UserName: string;
      SessionTimeout: Integer; ASessionLifetime: TDSSessionLifetime;
      const TunnelService: TDSTunnelService;
      const AuthManager: TDSCustomAuthenticationManager;
      const ARequestInfo: TDSHTTPRequest; out IsNewSession: Boolean): Boolean;
    function GetHTTPDispatch: TDSHTTPDispatch;
    procedure SetSessionRequestInfo(const ASession: TDSSession;
      const ARequest: TDSHTTPRequest);
    function GetDispatching: Boolean;
  public
    /// <summary> Checks the request for a Session ID and returns it if one is found. </summary>
    /// <remarks> Checks the Pragama header and optionally the query parameter of the url.
    ///    If checking both places, the URL parameter takes priority if both locations have values specified.
    /// </remarks>
    /// <returns> The found session ID or empty string if none found. </returns>
    function GetRequestSessionId(const ARequestInfo: TDSHTTPRequest; const CheckURLParams: Boolean = True): string;
    procedure StartDispatch(const AContext: TDSHTTPContext;
      const ARequest: TDSHTTPRequest; const AResponse: TDSHTTPResponse);
    procedure EndDispatch;
    property Dispatching: Boolean read GetDispatching;
    property HTTPDispatch: TDSHTTPDispatch read GetHTTPDispatch;
    class property Instance: TDSHTTPApplication read FInstance;
  end;

implementation

uses
{$IFNDEF POSIX}
  Winapi.ActiveX,
  System.Win.ComObj,
{$ENDIF}
  System.StrUtils,
  Data.DBXClientResStrs,
  Data.DBXCommonIndy,
  Data.DBXJSONCommon,
  Data.DBXPlatform,
  System.TypInfo,
  Datasnap.DSServerResStrs;

const
  DATASNAP_CONTEXT = 'datasnap';
  TUNNEL_CONTEXT = 'tunnel';
  TUNNEL_INFO_LIST = 'tunnelinfolist';
  SESSION_EXPIRED = 'Session has expired'; // do not localize
  SESSION_EXPIRED_MSG = 'The specified session has expired due to inactivity or was an invalid Session ID'; //do not localize
  CANNOT_PROCESS_PARAM = 'Query parameter %0:s (%1:s) is not accepted as a valid converter. The converter type might not be registered yet hence the request is rejected'; //do not localize
  QUERY_PARAM_CONFLICT = 'Query parameters are conflicting. This is usually due to references on the same output parameter'; //do not localize
  NO_SERVER_DATA = 'Server stopped sending data. The connection was terminated or connection timeout.'; //do not localize
  PROTOCOL_COMMAND_NOT_SUPPORTED = 'Command %s in request is not supported. Accepted commands are: GET, POST and PUT'; //do not localize
  INVALID_DATASNAP_CONTEXT = 'Expected datasnap context in request %s'; //do not localize
  INVALID_REQUEST = 'Invalid request format. (%s)'; //do not localize

type
  TDSHTTPOtherContextEvent = procedure(
      AContext: TDSHTTPContext;
      ARequestInfo: TDSHTTPRequest; AResponseInfo: TDSHTTPResponse;
      const ARequest: string; var AHandled: Boolean) of object;

  TDSHTTPServerIndy = class(TDSHTTPServer)
  strict private
    FHTTPOtherContext: TDSHTTPOtherContextEvent;
  private
    FServer: IIPHTTPServer;
    FDefaultPort: Word;
    FServerSoftware: string;
    FIPImplementationID: string;
    FPeerProcs: IIPPeerProcs;
    function PeerProcs: IIPPeerProcs;
    function GetActive: Boolean;
    function GetDefaultPort: Word;
    procedure SetActive(const Value: Boolean);
    procedure SetDefaultPort(const Value: Word);
    procedure DoIndyCommand(AContext: IIPContext;
      ARequestInfo: IIPHTTPRequestInfo; AResponseInfo: IIPHTTPResponseInfo);
    function GetServerSoftware: string;
    procedure SetServerSoftware(const Value: string);
    property HTTPOtherContext: TDSHTTPOtherContextEvent read FHTTPOtherContext write FHTTPOtherContext;
  protected
    function Decode(Data: string): string; override;
    procedure DoCommandOtherContext(AContext: TDSHTTPContext;
      ARequestInfo: TDSHTTPRequest; AResponseInfo: TDSHTTPResponse;
      const ARequest: string); override;
    procedure InitializeServer; virtual;
  public
    constructor Create(const ADSServer: TDSCustomServer; const AIPImplementationID: string = ''); override;
    destructor Destroy; override;
    property Server: IIPHTTPServer read FServer;
    property DefaultPort: Word read GetDefaultPort write SetDefaultPort;
    property Active: Boolean read GetActive write SetActive;
    property ServerSoftware: string read GetServerSoftware write SetServerSoftware;
  end;

  TDSHTTPSServerIndy = class(TDSHTTPServerIndy)
  private
    FCertFile: string;
    FKeyFile: string;
    FRootCertFile: string;
    {$IFNDEF NEXTGEN}
    FOnGetPEMFilePasskey: TGetPEMFilePasskey;
    {$ENDIF}
    FOnGetPEMFileSBPasskey: TGetPEMFileSBPasskey;
    procedure ServerOnConnect(AContext: IIPContext);
    function GetCertFile: string;
    function GetKeyFile: string;
    function GetRootCertFile: string;
    procedure SetCertFile(const Value: string);
    procedure SetKeyFile(const Value: string);
    procedure SetRootCertFile(const Value: string);
    function GetSSLOptions: IIPSSLOptions;
    procedure OnGetPassword(APasskey: TStringBuilder);
  protected
    procedure DoGetPEMFilePasskey(ASender: TObject; APasskey: TStringBuilder); virtual;
    procedure InitializeServer; override;
    property SSLOptions: IIPSSLOptions read GetSSLOptions;
  public
    destructor Destroy; override;
    {$IFNDEF NEXTGEN}
    property OnGetPEMFilePasskey: TGetPEMFilePasskey read FOnGetPEMFilePasskey write FOnGetPEMFilePasskey;
    {$ENDIF}
    property OnGetPEMFileSBPasskey: TGetPEMFileSBPasskey read FOnGetPEMFileSBPasskey write FOnGetPEMFileSBPasskey;
    property RootCertFile: string read GetRootCertFile write SetRootCertFile;
    property CertFile: string read GetCertFile write SetCertFile;
    property KeyFile: string read GetKeyFile write SetKeyFile;
  end;

{ TDSHTTPServerIndy }

constructor TDSHTTPServerIndy.Create(const ADSServer: TDSCustomServer; const AIPImplementationID: string = '');
begin
  inherited Create(ADSServer, AIPImplementationID);
  FIPImplementationID := AIPImplementationID;
  FServerSoftware := 'DatasnapHTTPService/2011';
end;

procedure TDSHTTPServerIndy.InitializeServer;
begin
  if FServer <> nil then
  begin
    FServer.UseNagle := False;
    FServer.KeepAlive := True;
    FServer.ServerSoftware := FServerSoftware;
    FServer.DefaultPort := FDefaultPort;

    FServer.OnCommandGet := Self.DoIndyCommand;
    FServer.OnCommandOther := Self.DoIndyCommand;
  end;
end;

function TDSHTTPServerIndy.PeerProcs: IIPPeerProcs;
begin
  if FPeerProcs = nil then
    FPeerProcs := IPProcs(FIPImplementationID);
  Result := FPeerProcs;
end;

function TDSHTTPServerIndy.Decode(Data: string): string;
begin
  if Data.IndexOf('%') >= 0 then  // Optimization
    Result := PeerProcs.URLDecode(Data)
  else
    Result := Data;
end;

destructor TDSHTTPServerIndy.Destroy;
begin
  inherited;
  if FServer <> nil then
  begin
    FServer.Active := False;
    FServer := nil;
  end;
end;

                                   
procedure TDSHTTPServerIndy.DoIndyCommand(AContext: IIPContext; ARequestInfo: IIPHTTPRequestInfo;
                                AResponseInfo: IIPHTTPResponseInfo);
var
  LContext: TDSHTTPContextIndy;
begin
  LContext := TDSHTTPContextIndy.Create(AContext, ARequestInfo, AResponseInfo);
  try
    DoCommand(LContext, LContext.FRequest, LContext.FResponse);
  finally
    LContext.Free;
  end;
end;

procedure TDSHTTPServerIndy.DoCommandOtherContext(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
                                    AResponseInfo: TDSHTTPResponse; const ARequest: string);
var
  LHandled: Boolean;
begin
  LHandled := False;
  if Assigned(FHTTPOtherContext) then
  begin
    FHTTPOtherContext(AContext, ARequestInfo, AResponseInfo, ARequest, LHandled);
  end;
  if not LHandled then
    inherited;
end;

function TDSHTTPServerIndy.GetActive: Boolean;
begin
  if FServer <> nil then
    Result := FServer.Active
  else
    Result := False;
end;

function TDSHTTPServerIndy.GetDefaultPort: Word;
begin
  if FServer <> nil then
    Result := FServer.DefaultPort
  else
    Result := FDefaultPort;
end;

function TDSHTTPServerIndy.GetServerSoftware: string;
begin
  if FServer <> nil then
    Result := FServer.ServerSoftware
  else
    Result := FServerSoftware;
end;

procedure TDSHTTPServerIndy.SetActive(const Value: Boolean);
begin
  if Value and (FServer = nil) then
  begin
    FServer := PeerFactory.CreatePeer(FIPImplementationID, IIPHTTPServer, nil) as IIPHTTPServer;
    InitializeServer;
  end;
  if FServer <> nil then
    FServer.Active := Value;
end;

procedure TDSHTTPServerIndy.SetDefaultPort(const Value: Word);
begin
  if FServer <> nil then
    FServer.DefaultPort := Value
  else
    FDefaultPort := Value;
end;

procedure TDSHTTPServerIndy.SetServerSoftware(const Value: string);
begin
  if FServer <> nil then
    FServer.ServerSoftware := Value
  else
    FServerSoftware := Value;
end;

{ TDSHTTPService }

constructor TDSHTTPService.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDefaultPort := _IPPORT_HTTP;
  FComponentList := TList<TComponent>.Create;  // Does not own objects
end;

procedure TDSHTTPService.RemoveComponent(const AComponent: TDSHTTPServiceComponent);
begin
  if (AComponent <> nil) and (FComponentList <> nil) then
    FComponentList.Remove(AComponent);
end;

procedure TDSHTTPService.AddComponent(const AComponent: TDSHTTPServiceComponent);
begin
  if FComponentList.IndexOf(AComponent) = -1 then
    FComponentList.Add(AComponent);
end;

function TDSHTTPService.CreateHttpServer: TDSHTTPServer;
var
  LHTTPServer: TDSHTTPServerIndy;
begin
  if Assigned(FCertFiles) then
    LHTTPServer := TDSHTTPSServerIndy.Create(Self.Server, IPImplementationID)
  else
    LHTTPServer := TDSHTTPServerIndy.Create(Self.Server, IPImplementationID);
  Result := LHTTPServer;
  LHTTPServer.HTTPOtherContext := HTTPOtherContext;
end;

procedure TDSHTTPService.HTTPOtherContext(
      AContext: TDSHTTPContext;
      ARequestInfo: TDSHTTPRequest; AResponseInfo: TDSHTTPResponse;
      const ARequest: string; var AHandled: Boolean);
var
  I: Integer;
  LComponent: TComponent;
begin
  for I := 0 to FComponentList.Count - 1 do
  begin
    LComponent := FComponentList[I];
    if LComponent is TDSHTTPServiceComponent then
    begin
      TDSHTTPServiceComponent(LComponent).DoCommand(AContext, ARequestInfo, AResponseInfo,
        ARequest, AHandled);
      if AHandled then
        break;
    end;
  end;
end;

destructor TDSHTTPService.Destroy;
begin
  TDSSessionManager.Instance.TerminateAllSessions(self);
  ServerCloseAllTunnelSessions;
  FreeAndNil(FComponentList);
  inherited;
end;

function TDSHTTPService.GetHttpPort: Word;
begin
  if Assigned(FHttpServer) then
    Result := TDSHTTPServerIndy(FHttpServer).DefaultPort
  else
    Result := FDefaultPort;
end;

procedure TDSHTTPService.SetHttpPort(const Port: Word);
begin
  FDefaultPort := Port;
  if Assigned(FHttpServer) then
    TDSHTTPServerIndy(FHttpServer).DefaultPort := Port;
end;

procedure TDSHTTPService.InitializeHttpServer;
begin
  inherited;
  if FCertFiles <> nil then
    FCertFiles.SetServerProperties(FHttpServer);
  TDSHTTPServerIndy(FHttpServer).DefaultPort := FDefaultPort;
  TDSHTTPServerIndy(FHttpServer).Active := FActive;
end;

function TDSHTTPService.IsActive: Boolean;
begin
  if Assigned(FHttpServer) then
    Result := TDSHTTPServerIndy(FHttpServer).Active
  else
    Result := FActive;
end;

procedure TDSHTTPService.SetActive(Status: Boolean);
begin
  if not Status then
    ServerCloseAllTunnelSessions;
  FActive := Status;
  if Assigned(FHttpServer) then
    TDSHTTPServerIndy(FHttpServer).Active := Status
  else if not (csLoading in ComponentState) then
    // Create FHttpServer
    if FActive then
      RequiresServer;
end;

procedure TDSHTTPService.SetCertFiles(const AValue: TDSCustomCertFiles);
begin
  if (AValue <> FCertFiles) then
  begin
    if Assigned(FCertFiles) then
      RemoveFreeNotification(FCertFiles);
    FCertFiles := AValue;
    if Assigned(FCertFiles) then
      FreeNotification(FCertFiles);
  end;
end;

procedure TDSHTTPService.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FCertFiles) then
    FCertFiles := nil;
end;

function TDSHTTPService.GetServerSoftware: string;
begin
  if not (csLoading in ComponentState) then
    RequiresServer;
  if FHttpServer <> nil then
    Result := TDSHTTPServerIndy(FHttpServer).ServerSoftware
  else
    Result := '';
end;

procedure TDSHTTPService.SetIPImplementationID(const Value: string);
begin
  if IsActive then
    raise TDSServiceException.Create(sCannotChangeIPImplID);
  inherited SetIPImplementationID(Value);
end;

procedure TDSHTTPService.Stop;
begin
  TDSSessionManager.Instance.TerminateAllSessions(self);
  SetActive(False);
  inherited;
end;

procedure TDSHTTPService.Start;
begin
  inherited;
  RequiresServer;
  if Assigned(FHttpServer) then
  begin
    // Moved
    //TDSHTTPServerIndy(FHttpServer).Server.UseNagle := False;
    TDSHTTPServerIndy(FHttpServer).Active := True;
  end;
end;

{ TDSHTTPResponseIndy }

constructor TDSHTTPResponseIndy.Create(AResponseInfo: IIPHTTPResponseInfo);
begin
  FResponseInfo := AResponseInfo;
end;

procedure TDSHTTPResponseIndy.SetHeaderAuthentication(const Value: string; const Realm: string);
begin
  FResponseInfo.AuthRealm := Realm;
  FResponseInfo.WWWAuthenticate.Add('Basic')
end;

function TDSHTTPResponseIndy.GetCloseConnection: Boolean;
begin
  Result := FResponseInfo.CloseConnection;
end;

function TDSHTTPResponseIndy.GetContentLength: Int64;
begin
  Result := FResponseInfo.ContentLength;
end;

function TDSHTTPResponseIndy.GetContentStream: TStream;
begin
  Result := FResponseInfo.ContentStream;
end;

function TDSHTTPResponseIndy.GetContentText: string;
begin
  Result := FResponseInfo.ContentText;
end;

function TDSHTTPResponseIndy.GetContentType: string;
begin
  Result := FResponseInfo.ContentType;
end;

function TDSHTTPResponseIndy.GetFreeContentStream: Boolean;
begin
  Result := FResponseInfo.FreeContentStream;
end;

function TDSHTTPResponseIndy.GetPragma: string;
begin
  Result := FResponseInfo.Pragma;
end;

function TDSHTTPResponseIndy.GetResponseNo: Integer;
begin
  Result := FResponseInfo.ResponseNo;
end;

function TDSHTTPResponseIndy.GetResponseText: string;
begin
  Result := FResponseInfo.ResponseText;
end;

procedure TDSHTTPResponseIndy.SetCloseConnection(const Value: Boolean);
begin
  FResponseInfo.CloseConnection := Value;
end;

procedure TDSHTTPResponseIndy.SetContentLength(const Value: Int64);
begin
  FResponseInfo.ContentLength := Value;
end;

procedure TDSHTTPResponseIndy.SetContentStream(const Value: TStream);
begin
  FResponseInfo.ContentStream := Value;
end;

procedure TDSHTTPResponseIndy.SetContentText(const Value: string);
begin
  FResponseInfo.ContentText := Value;
end;

procedure TDSHTTPResponseIndy.SetContentType(const Value: string);
begin
  FResponseInfo.ContentType := Value;
end;

procedure TDSHTTPResponseIndy.SetFreeContentStream(const Value: Boolean);
begin
  FResponseInfo.FreeContentStream := Value;
end;

procedure TDSHTTPResponseIndy.SetPragma(const Value: string);
begin
  inherited;
  FResponseInfo.Pragma := Value;
end;

procedure TDSHTTPResponseIndy.SetResponseNo(const Value: Integer);
begin
  FResponseInfo.ResponseNo := Value;
end;

procedure TDSHTTPResponseIndy.SetResponseText(const Value: string);
begin
  FResponseInfo.ResponseText := Value;
end;

{ TDSHTTPRequestIndy }

constructor TDSHTTPRequestIndy.Create(ARequestInfo: IIPHTTPRequestInfo);
begin
  FRequestInfo := ARequestInfo;
end;

function TDSHTTPRequestIndy.GetAccept: string;
begin
  Result := FRequestInfo.Accept;
end;

function TDSHTTPRequestIndy.GetAuthPassword: string;
begin
  Result := FRequestInfo.AuthPassword;
end;

function TDSHTTPRequestIndy.GetAuthUserName: string;
begin
  Result := FRequestInfo.AuthUserName;
end;

function TDSHTTPRequestIndy.GetCommand: string;
begin
  Result := FRequestInfo.Command;
end;

function TDSHTTPRequestIndy.GetCommandType: TDSHTTPCommandType;
begin
  case FRequestInfo.CommandType of
    THTTPCommandTypePeer.hcUnknown:
      Result := TDSHTTPCommandType.hcUnknown;
    THTTPCommandTypePeer.hcGET:
      Result := TDSHTTPCommandType.hcGET;
    THTTPCommandTypePeer.hcPOST:
      Result := TDSHTTPCommandType.hcPOST;
    THTTPCommandTypePeer.hcDELETE:
      Result := TDSHTTPCommandType.hcDELETE;
    THTTPCommandTypePeer.hcPUT:
      Result := TDSHTTPCommandType.hcPUT;
    THTTPCommandTypePeer.hcTRACE,
    THTTPCommandTypePeer.hcHEAD,
    THTTPCommandTypePeer.hcOPTION:
      Result := TDSHTTPCommandType.hcOther;
  else
    //Result := TDSHTTPCommandType.hcUnknown;
    raise TDSServiceException.Create(sUnknownCommandType);
  end;
end;

                                                           
function TDSHTTPRequestIndy.GetDocument: string;
var
{$IFDEF NEXTGEN}
  RawStr: array of byte;
{$ELSE}
  RawStr: RawByteString;
{$ENDIF}
  Count, I: Integer;
  CharCode: SmallInt;
begin
  // RAID 272624: Indy doesn't properly decodes the encoded URLs; this will be fixed in
  // Indy 11 we are told. If so, this code can be replaced with
  //
  // Result := LRequestInfo.Document
  //
  if FDocument = EmptyStr then
  begin
    Count := FRequestInfo.Document.Length;
{$IFDEF NEXTGEN}
  SetLength(RawStr, Count);
{$ELSE}
    RawStr := '';
{$ENDIF}
    for I := 0 to Count - 1 do
    begin
      CharCode := Ord(FRequestInfo.Document.Chars[I]);
      if CharCode > 255 then
      begin
        FDocument := FRequestInfo.Document;
        Exit(FDocument)
      end;
{$IFDEF NEXTGEN}
      RawStr[I] := Byte(CharCode);
{$ELSE}
      RawStr := RawStr + AnsiChar(CharCode);
{$ENDIF}
    end;
    FDocument := UTF8ToString(RawStr)
  end;
  Exit(FDocument);
end;

function TDSHTTPRequestIndy.GetParams: TStrings;
begin
  Result := FRequestInfo.Params;
end;

function TDSHTTPRequestIndy.GetPostStream: TStream;
begin
  Result := FRequestInfo.PostStream;
end;

function TDSHTTPRequestIndy.GetPragma: string;
begin
  Result := FRequestInfo.Pragma;
end;

function TDSHTTPRequestIndy.GetRemoteIP: string;
begin
  Result := FRequestInfo.RemoteIP;
end;

function TDSHTTPRequestIndy.GetURI: string;
begin
  Result := FRequestInfo.URI;
end;

function TDSHTTPRequestIndy.GetUserAgent: string;
begin
  Result := FRequestInfo.UserAgent;
end;

function TDSHTTPRequestIndy.GetProtocolVersion: string;
begin
  Result := FRequestInfo.Version;
end;

{ TDSHTTPContextIndy }

function TDSHTTPContextIndy.Connected: Boolean;
begin
  Result := FContext.Connection.Connected;
end;

constructor TDSHTTPContextIndy.Create(const AContext: IIPContext; const ARequestInfo: IIPHTTPRequestInfo;
                                const AResponseInfo: IIPHTTPResponseInfo);
begin
  inherited Create;
  FContext := AContext;
  FRequest := TDSHTTPRequestIndy.Create(ARequestInfo);
  FResponse := TDSHTTPResponseIndy.Create(AResponseInfo);
end;

destructor TDSHTTPContextIndy.Destroy;
begin
  FRequest.Free;
  FResponse.Free;
  inherited;
end;

{ TDSHTTPServiceComponent }

procedure TDSHTTPServiceComponent.SetService(const AValue: TDSHTTPService);
begin
  if (AValue <> Service) then
  begin
    if Assigned(Service) then
      RemoveFreeNotification(Service);
    if Assigned(AValue) then
      FreeNotification(AValue);
  end;
  if FService <> nil then
    FService.RemoveComponent(self);
  if AValue <> nil then
    AValue.AddComponent(self);
  self.FService := AValue;
end;

procedure TDSHTTPServiceComponent.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FService) then
    FService := nil;
end;

type
  TIndyDispatchFileRequest = class(TDispatchFileRequest)
  private
    FContext: TDSHTTPContextIndy;
    FRequestInfo:  TDSHTTPRequestIndy;
    FResponseInfo: TDSHTTPResponseIndy;
    FComponent: TDSCustomHTTPServiceFileDispatcher;
  protected
    function IsGetRequest: Boolean; override;
    function IsHeadRequest: Boolean; override;
    procedure SetErrorCode(AStatusCode: Integer); override;
    function GetIfModifiedSince: TDateTime; override;
    procedure SetContentStream(AStream: TStream); override;
    procedure SetContentLength(ALength: Integer); override;
    procedure SetContentType(const AValue: string); override;
    procedure SetLastModified(AValue: TDateTime); override;
    function GetExceptionClass: TClass; override;
    procedure DoBeforeDispatch(const AFileName: string; var AHandled: Boolean); override;
    procedure DoAfterDispatch(const AFileName: string; var AHandled: Boolean); override;
    function GetRequestPathInfo: string; override;
    function GetResponseSent: Boolean; override;
  public
    constructor Create(AComponent: TDSCustomHTTPServiceFileDispatcher; AContext: TDSHTTPContextIndy; ARequestInfo: TDSHTTPRequestIndy;
      AResponseInfo: TDSHTTPResponseIndy);
  end;

{ TIndyDispatchFileRequest }

constructor TIndyDispatchFileRequest.Create(AComponent: TDSCustomHTTPServiceFileDispatcher; AContext: TDSHTTPContextIndy; ARequestInfo: TDSHTTPRequestIndy;
  AResponseInfo: TDSHTTPResponseIndy);
begin
  inherited Create(AComponent.FFileDispatcherProperties);
  FComponent := AComponent;
  FContext := AContext;
  FRequestInfo := ARequestInfo;
  FResponseInfo := AResponseInfo;
end;

function TIndyDispatchFileRequest.IsGetRequest: Boolean;
begin
  Result := FRequestInfo.RequestInfo.CommandType = THTTPCommandTypePeer.hcGET;
end;

function TIndyDispatchFileRequest.IsHeadRequest: Boolean;
begin
  Result := FRequestInfo.RequestInfo.CommandType = THTTPCommandTypePeer.hcHEAD;
end;

procedure TIndyDispatchFileRequest.SetErrorCode(AStatusCode: Integer);
begin
 FResponseInfo.ResponseInfo.ResponseNo := AStatusCode;
end;

function TIndyDispatchFileRequest.GetIfModifiedSince: TDateTime;
begin
  Result := IPProcs(FRequestInfo.RequestInfo.GetIPImplementationID).GMTToLocalDateTime(FRequestInfo.RequestInfo.RawHeaders.Values['If-Modified-Since']);  {do not localize}
end;

procedure TIndyDispatchFileRequest.SetContentStream(AStream: TStream);
begin
  FResponseInfo.ResponseInfo.ContentStream := AStream;
end;

procedure TIndyDispatchFileRequest.SetContentLength(ALength: Integer);
begin
  FResponseInfo.ResponseInfo.ContentLength := ALength;
end;

procedure TIndyDispatchFileRequest.SetContentType(const AValue: string);
begin
  FResponseInfo.ResponseInfo.ContentType := AValue;
end;

procedure TIndyDispatchFileRequest.SetLastModified(AValue: TDateTime);
begin
  TDSHTTPRequestIndy(FRequestInfo).RequestInfo.LastModified := AValue;
end;

function TIndyDispatchFileRequest.GetExceptionClass: TClass;
begin
  Result := Exception;
end;

procedure TIndyDispatchFileRequest.DoBeforeDispatch(const AFileName: string; var AHandled: Boolean);
begin
  FComponent.DoBeforeDispatch(FComponent, AFileName, FContext, FRequestInfo, FResponseInfo, AHandled);
end;

procedure TIndyDispatchFileRequest.DoAfterDispatch(const AFileName: string; var AHandled: Boolean);
begin
  if Assigned(FComponent.FAfterDispatch) then
    FComponent.FAfterDispatch(FComponent, AFileName, FContext, FRequestInfo, FResponseInfo, AHandled);
  if (not FResponseInfo.ResponseInfo.HeaderHasBeenWritten) and (FResponseInfo.ResponseInfo.ContentText = '') then
  begin
    // Force write of error message
    FResponseInfo.ResponseInfo.WriteHeader;
    FResponseInfo.ResponseInfo.WriteContent;
  end;
end;

{ TIndyDispatchFileRequest }

function TIndyDispatchFileRequest.GetRequestPathInfo: string;
begin
  Result := FRequestInfo.Document;
end;
 
function TIndyDispatchFileRequest.GetResponseSent: Boolean;
begin 
  Result := False;
end;

{ TDSCustomHTTPServiceFileDispatcher }

constructor TDSCustomHTTPServiceFileDispatcher.Create(AOwner: TComponent);
begin
  inherited;
  FFileDispatcherProperties := TWebFileDispatcherProperties.Create(Self);
end;

procedure TDSCustomHTTPServiceFileDispatcher.DoBeforeDispatch(Sender: TObject;
  const AFileName: string; AContext: TDSHTTPContext; Request: TDSHTTPRequest;
  Response: TDSHTTPResponse; var Handled: Boolean);
begin
  if Assigned(FBeforeDispatch) then
    FBeforeDispatch(Sender, AFileName, AContext, Request, Response, Handled);
end;

procedure TDSCustomHTTPServiceFileDispatcher.DoCommand(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
  AResponseInfo: TDSHTTPResponse; const ARequest: string; var AHandled: Boolean);
var
  LDispatcher: TIndyDispatchFileRequest;
begin
  AHandled := False;
  if AContext is TDSHTTPContextIndy then
  begin
    LDispatcher := TIndyDispatchFileRequest.Create(Self,
      TDSHTTPContextIndy(AContext),  TDSHTTPRequestIndy(ARequestInfo),
      TDSHTTPResponseIndy(AResponseInfo));
    try
      AHandled := LDispatcher.DispatchFileRequest;
    finally
      LDispatcher.Free;
    end;
  end;
end;

function TDSCustomHTTPServiceFileDispatcher.GetWebDirectories: TWebDirectories;
begin
  Result := FFileDispatcherProperties.WebDirectories;
end;

function TDSCustomHTTPServiceFileDispatcher.GetRootDirectory: string;
begin
  Result := FFileDispatcherProperties.RootDirectory;
end;

function TDSCustomHTTPServiceFileDispatcher.GetWebFileExtensions: TWebFileExtensions;
begin
  Result := FFileDispatcherProperties.WebFileExtensions;
end;

procedure TDSCustomHTTPServiceFileDispatcher.SetWebDirectories(
  const Value: TWebDirectories);
begin
  FFileDispatcherProperties.WebDirectories := Value;
end;

procedure TDSCustomHTTPServiceFileDispatcher.SetRootDirectory(const Value: string);
begin
  FFileDispatcherProperties.RootDirectory := Value;
end;

function TDSCustomHTTPServiceFileDispatcher.IsRootDirectoryStored: Boolean;
begin
  Result := not SameText(GetRootDirectory, '.');
end;

procedure TDSCustomHTTPServiceFileDispatcher.SetWebFileExtensions(
  const Value: TWebFileExtensions);
begin
 FFileDispatcherProperties.WebFileExtensions := Value;
end;

{ TDSCertFiles }

function TDSCustomCertFiles.GetCertFile: string;
begin
  Result := FCertFile;
end;

function TDSCustomCertFiles.GetKeyFile: string;
begin
  Result := FKeyFile;
end;

{$IFNDEF NEXTGEN}
procedure TDSCustomCertFiles.SetOnGetPEMFilePasskey(
  const Value: TGetPEMFilePasskey);
begin
  FGetPEMFilePasskey := Value;
end;
{$ENDIF}

procedure TDSCustomCertFiles.SetOnGetPEMFileSBPasskey(
  const Value: TGetPEMFileSBPasskey);
begin
  FGetPEMFileSBPasskey := Value;
end;

function TDSCustomCertFiles.GetRootCertFile: string;
begin
  Result := FRootCertFile;
end;

procedure TDSCustomCertFiles.SetCertFile(const Value: string);
begin
  FCertFile := Value;
end;

procedure TDSCustomCertFiles.SetKeyFile(const Value: string);
begin
  FKeyFile := Value;
end;

{$IFNDEF NEXTGEN}
function TDSCustomCertFiles.GetOnGetPEMFilePasskey: TGetPEMFilePasskey;
begin
  Result := FGetPEMFilePassKey;
end;
{$ENDIF}

function TDSCustomCertFiles.GetOnGetPEMFileSBPasskey: TGetPEMFileSBPasskey;
begin
  Result := FGetPEMFileSBPassKey;
end;

procedure TDSCustomCertFiles.SetRootCertFile(const Value: string);
begin
  FRootCertFile := Value;
end;

procedure TDSCustomCertFiles.SetServerProperties(AServer: TObject);
var
  LServer: TDSHTTPSServerIndy;
begin
  if AServer is TDSHTTPSServerIndy then
  begin
    LServer := TDSHTTPSServerIndy(AServer);
    LServer.CertFile := CertFile;
    LServer.KeyFile := KeyFile;
    LServer.RootCertFile := RootCertFile;
    LServer.OnGetPEMFileSBPasskey := OnGetPEMFileSBPasskey;
{$IFNDEF NEXTGEN}
    LServer.OnGetPEMFilePasskey := OnGetPEMFilePasskey;
{$ENDIF}
  end
  else
  begin
    raise TDSServiceException.Create(Format(SUnknownServerType, [AServer.ClassName]));
  end;
end;

{ TDSHTTPSServerIndy }

destructor TDSHTTPSServerIndy.Destroy;
begin
  inherited;
end;

(*
<< Client>>>
Create a VCL Application and drop a TIdTCPClient and a
TIdSSLIOHandlerSocketOpenSSL on the form. Set the TIdTCPClient's Host
to localhost, Port to 16000 and IOHandler to the SSL IOHandler.
Next, alter the SSL options so that Method is set to sslvSSLv3 and Mode
is set to sslmClient.
Next create OnCreate/OnDestroy event handlers for the form and in that
put Client.Connect/Client.Disconnect respectively.
Compile.
<< Server>>
Create a VCL Application and drop a TIdCMDTcpServer and a
TIdServerIOHandlerSSLOpenSSL on the form. Set the TIdCMDTCPServer's
Bindings to 127.0.0.1:16000 and IOHandler to the SSL IOHandler.
Next alter the SSL options so that Method is set to sslvSSLv3 and Mode
is set to sslmServer. Set CertFile to server.cert, KeyFile to
server.key and RootCertFile to ca.cert.
Next, create event handlers for the form OnCreate/OnDestroy to
Server.Active := True/Server.Active := False respectively.
Compile.
*)

function TDSHTTPSServerIndy.GetSSLOptions: IIPSSLOptions;
var
  Handler: IIPServerIOHandlerSSLOpenSSL;
begin
  if Server <> nil then
  begin
    if not Supports(Server.IOHandler, IIPServerIOHandlerSSLOpenSSL, Handler) then
      raise TDSServiceException.Create(sUnsupportedServerIOHandler);
    Result := Handler.SSLOptions;
  end;
end;

function TDSHTTPSServerIndy.GetCertFile: string;
begin
  if SSLOptions <> nil then
    Result := SSLOptions.CertFile
  else
    Result := FCertFile;
end;

function TDSHTTPSServerIndy.GetKeyFile: string;
begin
  if SSLOptions <> nil then
    Result := SSLOptions.KeyFile
  else
    Result := FKeyFile;
end;

function TDSHTTPSServerIndy.GetRootCertFile: string;
begin
  if SSLOptions <> nil then
    Result := SSLOptions.RootCertFile
  else
    Result := FRootCertFile;
end;

procedure TDSHTTPSServerIndy.InitializeServer;
var
  LIOHandler: IIPServerIOHandlerSSLOpenSSL;
begin
  inherited;
  if Server <> nil then
  begin
    LIOHandler := PeerFactory.CreatePeer(IPImplementationID, IIPServerIOHandlerSSLOpenSSL, Server.GetObject as TComponent) as IIPServerIOHandlerSSLOpenSSL; //TIdServerIOHandlerSSLOpenSSL.Create(Server);
    LIOHandler.SSLOptions.Method := TIPSSLVersionPeer.sslvTLSv1;
    LIOHandler.SSLOptions.Mode := TIPSSLModePeer.sslmServer;
    LIOHandler.SSLOptions.CertFile := FCertFile;
    LIOHandler.SSLOptions.RootCertFile := FRootCertFile;
    LIOHandler.SSLOptions.KeyFile := FKeyFile;

    LIOHandler.OnGetPassword := OnGetPassword;
    Server.IOHandler := LIOHandler;
    Assert(not Assigned(Server.OnConnect));
    Server.OnConnect := ServerOnConnect;
  end;
end;

procedure TDSHTTPSServerIndy.OnGetPassword(APasskey: TStringBuilder);
begin
  DoGetPEMFilePasskey(Self, APasskey);
end;

procedure TDSHTTPSServerIndy.DoGetPEMFilePasskey(ASender : TObject; APasskey: TStringBuilder);
{$IFNDEF NEXTGEN}
var
  LPass: AnsiString;
{$ENDIF}
begin
  if Assigned(FOnGetPEMFileSBPasskey) then
    FOnGetPEMFileSBPasskey(ASender, APasskey)
  {$IFNDEF NEXTGEN}
  else if Assigned(FOnGetPEMFilePasskey) then
  begin
    LPass := AnsiString(APasskey.ToString);
    FOnGetPEMFilePasskey(ASender, LPass);
    APasskey.Clear;
    APasskey.Append(LPass);
  end;
  {$ENDIF}
end;

procedure TDSHTTPSServerIndy.ServerOnConnect(AContext: IIPContext);
var
  Handler: IIPSSLIOHandlerSocketBase;
begin
  // Passthrough = False to enable SSL.  Indy supports SSL on a per connection basis.
  // For DataSnap, SSL is always enabled for an HTTPS connection
  if not Supports(AContext.Connection.IOHandler, IIPSSLIOHandlerSocketBase, Handler) then
    raise TDSServiceException.Create(sUnsupportedServerIOHandler);
  Handler.PassThrough := False;
end;

procedure TDSHTTPSServerIndy.SetCertFile(const Value: string);
begin
  if SSLOptions <> nil then
    SSLOptions.CertFile := Value
  else
    FCertFile := Value;
end;

procedure TDSHTTPSServerIndy.SetKeyFile(const Value: string);
begin
  if SSLOptions <> nil then
    SSLOptions.KeyFile := Value
  else
    FKeyFile := Value;
end;

procedure TDSHTTPSServerIndy.SetRootCertFile(const Value: string);
begin
  if SSLOptions <> nil then
    SSLOptions.RootCertFile := Value
  else
    FRootCertFile := Value;
end;

{TDSHTTPServer}

constructor TDSRESTServer.Create;
begin
  Create(nil, '');
end;

constructor TDSRESTServer.Create(const AIPImplementationID: string);
begin
  Create(nil, AIPImplementationID);
end;

constructor TDSRESTServer.Create(const ADSServer: TDSCustomServer);
begin
  Create(ADSServer, '');
end;

constructor TDSRESTServer.Create(const ADSServer: TDSCustomServer; const AIPImplementationID: string);
begin
  inherited Create;
  FDSServer := ADSServer;
  FIPImplementationID := AIPImplementationID;

//  Default values defined elsewhere
//  FRESTContext := REST_CONTEXT;
//  FCacheContext := CACHE_CONTEXT;
//  FDSContext := DATASNAP_CONTEXT;
//  FDSHostname := 'localhost';
//  FDSPort := 211;
//  FCredentialsPassThrough := false;
//  FSessionTimeout := 1200000;
//  FDSAuthUser := EmptyStr;
//  FDSAuthPassword := EmptyStr;

  FResultEvent := nil;
  FProtocolHandlerFactory := nil;
end;

constructor TDSHTTPServer.Create(const ADSServer: TDSCustomServer; const AIPImplementationID: string);
begin
  inherited;

  FTunnelService := TDSTunnelService.Create(FDSHostname, FDSPort, FFilters, FProtocolHandlerFactory);

  //Listen for a session closing event and close the session's tunnel, if one exists
  FSessionEvent :=
    procedure(Sender: TObject; const EventType: TDSSessionEventType; const Session: TDSSession)
    begin
      case EventType of
        SessionClose:
          CloseSessionTunnels(Session);
      end;
    end;
  TDSSessionManager.Instance.AddSessionEvent(FSessionEvent);
end;

destructor TDSRESTServer.Destroy;
begin
  FreeAndNil(FProtocolHandlerFactory);

  inherited;
end;

destructor TDSHTTPServer.Destroy;
begin
  if Assigned(FSessionEvent) then
    if TDSSessionManager.Instance <> nil then
      TDSSessionManager.Instance.RemoveSessionEvent(FSessionEvent);
  FreeAndNil(FTunnelService);
  inherited;
end;

procedure TDSRESTServer.CreateProtocolHandlerFactory(ATransport: TDSServerTransport);
begin
  FreeAndNil(FProtocolHandlerFactory);
  FProtocolHandlerFactory := TDSJSONProtocolHandlerFactory.Create(ATransport);
 //TunnelService.ProtocolHandlerFactory := FProtocolHandlerFactory;
end;

procedure TDSHTTPServer.CreateProtocolHandlerFactory(ATransport: TDSServerTransport);
begin
  inherited;
  TunnelService.ProtocolHandlerFactory := FProtocolHandlerFactory;
end;

procedure TDSRESTServer.ClearProtocolHandlerFactory;
begin
  FreeAndNil(FProtocolHandlerFactory);
end;

procedure TDSHTTPServer.ClearProtocolHandlerFactory;
begin
  inherited;
  TunnelService.ProtocolHandlerFactory := nil;
end;

function TDSHTTPServer.GetTunnelService: TDSTunnelService;
begin
  if FTunnelService = nil then
    FTunnelService := TDSTunnelService.Create(FDSHostname, FDSPort, FFilters, FProtocolHandlerFactory);
  Result := FTunnelService;
end;

procedure TDSHTTPServer.CloseAllTunnelSessions;
begin
  if FTunnelService <> nil then
    FTunnelService.TerminateAllSessions;
end;

procedure TDSRESTServer.CloseRESTSession(Session: TDSSession; ResponseInfo: TDSHTTPResponse);
begin
  Assert(ResponseInfo <> nil);

  if (Session <> nil) then
  begin
    try
      TDSSessionManager.Instance.CloseSession(Session.SessionName);
      ResponseInfo.ResponseNo := 200;
      ResponseInfo.ResponseText := '{"result":[true]}';
    except
    end;
  end
  else
  begin
    ResponseInfo.ResponseNo := 400;
    ResponseInfo.ResponseText := SESSION_EXPIRED_MSG;
  end;
end;

function TDSHTTPServer.GetCacheContext: string;
begin
  Result := FCacheContext + '/';
end;

function TDSRESTServer.IsClosingSession(const Request: string): Boolean;
begin
  Result := AnsiStartsText('/CloseSession/', Request);
end;

const
  sDSAdmin = '/DSAdmin/';

function TDSRESTServer.IsClosingClientChannel(const Request: string): Boolean;
begin
  Result := AnsiStartsText(sDSAdmin + 'CloseClientChannel/', Request) or
            AnsiStartsText(sDSAdmin + '%22CloseClientChannel%22/', Request);
end;

function TDSRESTServer.IsOpeningClientChannel(const Request: string): Boolean;
begin
  Result := AnsiStartsText(sDSAdmin + 'ConsumeClientChannel/', Request) or
            AnsiStartsText(sDSAdmin + '%22ConsumeClientChannel%22/', Request);
end;

procedure TDSRESTServer.CheckClientChannelMethod(const Request: string);
begin
  if AnsiStartsText(sDSAdmin, Request) then
    if IsOpeningClientChannel(Request) or IsClosingClientChannel(Request) then
      raise TDSServiceException.CreateFmt(sChannelMethodsNotSupported, [ClassName]);
end;

function TDSHTTPServer.GetClientChannelInfo(Request: string;
                                            out ChannelName, ClientChannelId, ClientCallbackID, SecurityToken: string): Boolean;
var
  OpeningClientChannel: Boolean;
  Tokens: TStringList;
begin
  Result := False;

  OpeningClientChannel := IsOpeningClientChannel(Request);

  if OpeningClientChannel or IsClosingClientChannel(Request) then
  begin
    Tokens := TStringList.Create;
    Tokens.Delimiter := '/';
    Tokens.DelimitedText := Request;

    try
      if (OpeningClientChannel and (Tokens.Count > 7)) or (Tokens.Count > 5) then
      begin
        ChannelName := Tokens[3];
        ClientChannelId := Tokens[4];
        if OpeningClientChannel then
        begin
          ClientCallbackID := Tokens[5];
          SecurityToken := Tokens[7];
        end
        else
          SecurityToken := Tokens[5];

        Result := ClientChannelId <> EmptyStr;
      end;
    finally
      FreeAndNil(Tokens);
    end;
  end;
end;

function TDSRESTServer.GetDsContext: string;
begin
  Result := FDSContext + '/';
end;

function TDSRESTServer.GetRestContext: string;
begin
  Result := FRESTContext + '/';
end;

procedure TDSRESTServer.SetAuthenticationManager(
  AuthenticationManager: TDSCustomAuthenticationManager);
begin
  FDSHTTPAuthenticationManager := AuthenticationManager;
end;

procedure TDSHTTPServer.SetAuthenticationManager(
  AuthenticationManager: TDSCustomAuthenticationManager);
begin
  inherited;
  if FTunnelService <> nil then
    FTunnelService.DSAuthenticationManager := AuthenticationManager;
end;

procedure TDSHTTPServer.SetCacheContext(const ctx: string);
begin
  if (ctx <> EmptyStr) and (ctx.Chars[ctx.Length - 1] = '/') then
    FCacheContext := ctx.Substring(0, ctx.Length - 1)
  else
    FCacheContext := ctx;
end;

procedure TDSRESTServer.SetDsContext(const ctx: string);
begin
  if (ctx <> EmptyStr) and (ctx.Chars[ctx.Length - 1] = '/') then
    FDSContext := ctx.Substring(0, ctx.Length - 1)
  else
    FDSContext := ctx;
end;

procedure TDSHTTPServer.SetDSHostname(AHostname: string);
begin
  FDSHostname := AHostname;
  TunnelService.DSHostname := AHostname;
end;

procedure TDSHTTPServer.SetDSPort(APort: Integer);
begin
  FDSPort := Aport;
  TunnelService.DSPort := APort;
end;

procedure TDSRESTServer.SetDSServerName(AName: string);
begin
  FDSServerName := AName;
end;

procedure TDSHTTPServer.SetDSServerName(AName: string);
begin
  inherited;
  TunnelService.HasLocalServer := AName <> EmptyStr;
end;

procedure TDSHTTPServer.SetFilters(AFilterCollection: TTransportFilterCollection);
begin
  FFilters := AFilterCollection;
  TunnelService.Filters := AFilterCollection;
end;

procedure TDSRESTServer.SetRestContext(const ctx: string);
begin
  if (ctx <> EmptyStr) and (ctx.Chars[ctx.Length - 1] = '/') then
    FRESTContext := ctx.Substring(0, ctx.Length - 1)
  else
    FRESTContext := ctx;
end;

procedure TDSHTTPServer.CloseSessionTunnels(Session: TDSSession);
var
  RESTService: TDSRESTService;
  CloseTunnelRequest: string;
  RespHandler: TDSServiceResponseHandler;
  Obj: TObject;
  InfoList: TList<TDSSessionTunnelInfo>;
  Info: TDSSessionTunnelInfo;
  I: Integer;
begin
  InfoList := nil;

  if Session.HasObject(TUNNEL_INFO_LIST) then
  begin
    Obj := Session.GetObject(TUNNEL_INFO_LIST);
    if Obj Is TList<TDSSessionTunnelInfo> then
      InfoList := TList<TDSSessionTunnelInfo>(Obj);
  end;

  if (Session <> nil) and (InfoList <> nil) then
  begin
    for I := 0 to (InfoList.Count - 1) do
    begin
      Info := InfoList.Items[I];

      CloseTunnelRequest :=
        Format('/DSAdmin/CloseClientChannel/%s/%s/', [Info.ClientChannelId, Info.SecurityToken]);

      RESTService := CreateRESTService(Info.AuthUser, Info.AuthPassword);
      RespHandler := TDSResponseHandlerFactory.CreateResponseHandler(RESTService, nil, TDSHTTPCommandType.hcGET);

      try
        try
          RESTService.ProcessGETRequest(CloseTunnelRequest, nil, nil, RespHandler);
        except
        end;
      finally
        FreeAndNil(RespHandler);
      end;
    end;
  end;
end;

procedure TDSRESTServer.UpdateSessionTunnelHook(const Request: string; Session: TDSSession; RequestInfo: TDSHTTPRequest);
begin
  CheckClientChannelMethod(Request);
end;


procedure TDSHTTPServer.UpdateSessionTunnelHook(const Request: string; Session: TDSSession; RequestInfo: TDSHTTPRequest);
var
  SessionChannelName: string;
  SessionClientChannelId: string;
  SessionSecurityToken: string;
  SessionClientCallbackID: string;
  Obj: TObject;
  Info: TDSSessionTunnelInfo;
  InfoList: TList<TDSSessionTunnelInfo>;
  I: Integer;
begin
  Assert(Session <> nil);
  Assert(RequestInfo <> nil);

  if IsOpeningClientChannel(Request) then
  begin
    if GetClientChannelInfo(Request, SessionChannelName, SessionClientChannelId, SessionClientCallbackID, SessionSecurityToken) then
    begin
      if SessionClientCallbackID <> '' then
      begin
        Info.ChannelName := SessionChannelName;
        Info.ClientChannelId := SessionClientChannelId;
        Info.SecurityToken := SessionSecurityToken;
        Info.AuthUser := RequestInfo.AuthUserName;
        Info.AuthPassword := RequestInfo.AuthPassword;

        if not Session.HasObject(TUNNEL_INFO_LIST) then
          Session.PutObject(TUNNEL_INFO_LIST, TList<TDSSessionTunnelInfo>.Create);

        Obj := Session.GetObject(TUNNEL_INFO_LIST) ;

        if (Obj Is TList<TDSSessionTunnelInfo>) then
          TList<TDSSessionTunnelInfo>(Obj).Add(Info);
      end;
    end;
  end
  else if IsClosingClientChannel(Request) then
  begin
    if GetClientChannelInfo(Request, SessionChannelName, SessionClientChannelId, SessionClientCallbackID, SessionSecurityToken) then
    begin
      Obj := Session.GetObject(TUNNEL_INFO_LIST); //SessionClientChannelId
      if Obj Is TList<TDSSessionTunnelInfo> then
      begin
        InfoList := TList<TDSSessionTunnelInfo>(Obj);
        for I := 0 to (InfoList.Count - 1) do
        begin
          Info := InfoList.Items[I];
          if (SessionClientChannelId = Info.ClientChannelId) and (SessionSecurityToken = Info.SecurityToken) then
          begin
            InfoList.Delete(I);
            Exit;
          end;
        end;
      end;
    end;
  end;
end;

function TDSRESTServer.ByteContent(DataStream: TStream): TArray<Byte>;
var
  Buffer: TArray<Byte>;
begin
  if not Assigned(DataStream) then
    exit(nil);

  SetLength(Buffer, DataStream.Size);
  // the content may have been read
  DataStream.Position := 0;
  if DataStream.Size > 0 then
    DataStream.Read(Buffer[0], DataStream.Size);

  Result := Buffer;
end;

function TDSRESTServer.ByteContent(JsonValue: TJSONValue): TArray<Byte>;
var
  Buffer: TArray<Byte>;
begin
  SetLength(Buffer, JsonValue.EstimatedByteSize);
  SetLength(Buffer, JsonValue.ToBytes(Buffer, 0));

  Result := Buffer;
end;


function TDSHTTPApplication.GetRequestSessionId(const ARequestInfo: TDSHTTPRequest;
                                           const CheckURLParams: Boolean): string;
var
  SessionID: string;
  PragmaStr: string;
  PragmaList: TStringList;
begin
  //empty string will be returned for session ID unless found in Pragma header
  SessionID := '';

  if CheckURLParams then
  begin
    SessionID := ARequestInfo.Params.Values['SESSIONID'];
    if SessionID = '' then
      SessionID := ARequestInfo.Params.Values['sid'];
  end;

  //if no session ID is given in the URL, then try to load it from the Pragma header field
  if SessionID = '' then
  begin
    PragmaStr := ARequestInfo.Pragma;
    if PragmaStr <> '' then
    begin
      PragmaList := TStringList.Create;
      PragmaList.CommaText := PragmaStr;

      //Pragma is a comma-separaged list of keys with optional value pairings.
      //session id is stored as a key/value pair with "dssession" as the key
      SessionID := PragmaList.Values['dssession'];

      FreeAndNil(PragmaList);
    end;
  end;

                                                

  Result := SessionID;
end;

function TDSHTTPApplication.LoadRESTSession(const SessionId: string; const UserName: string;
                           SessionTimeout: Integer; ASessionLifetime: TDSSessionLifetime;
                           const TunnelService: TDSTunnelService;
                           const AuthManager: TDSCustomAuthenticationManager;
                           const ARequestInfo: TDSHTTPRequest;
                           out IsNewSession: Boolean): Boolean;
var
  Session: TDSSession;
  LDispatch: TDSHTTPDispatch;
begin
  TDSSessionManager.ClearThreadSession;

  //if session id wasn't specified then create a new session
  if SessionID = '' then
  begin
    IsNewSession := True;

    Session := TDSSessionManager.Instance.CreateSession<TDSRESTSession>(function: TDSSession begin
        Result := TDSRESTSession.Create(AuthManager);
        Result.ObjectCreator := TunnelService;
                                                 

        //populate session data while creating, so session event fires with data already populated
        SetSessionRequestInfo(Result, ARequestInfo);
    end, UserName, ASessionLifetime);

    Assert(ASessionLifetime = Session.SessionLifetime);
    Session.LifeDuration := SessionTimeout;
    case Session.SessionLifetime of
      TDSSessionLifetime.TimeOut:
      begin
        if SessionTimeout > 0 then
        begin
          Session.ScheduleInactiveTerminationEvent;
        end;
      end;

      TDSSessionLifetime.Request:
      begin
        LDispatch := TDSHTTPApplication.Instance.GetHTTPDispatch;
        Assert(LDispatch <> nil);
        if LDispatch <> nil then
          // Free when done with request
          LDispatch.OwnedObjects.Add(Session);
      end;
    end;

  end
  else
  begin
    IsNewSession := False;

    //check if the Session ID is valid by trying to get it's matching session from the manager
    Session := TDSSessionManager.Instance.Session[SessionID];
                                                    

    //if the session ID wasn't valid, return false showing session retrieval failed
    if (Session = nil) or (not Session.IsValid) then
    begin
      exit(False);
    end
    else
      Session.MarkActivity; //session is being used again, so mark as active
  end;

  if Session <> nil then
    TDSSessionManager.SetAsThreadSession(Session);

  exit(True);
end;

                                      
procedure TDSHTTPServer.DoDSCacheCommand(ARequestInfo: TDSHTTPRequest;
                                         AResponseInfo: TDSHTTPResponse;
                                         Request: string;
                                         LocalConnection: Boolean);
var
  CmdType: TDSHTTPCommandType;
  SessionID: string;
  Session: TDSSession;
  IsNewSession: Boolean;
  SessionFailure: Boolean;
  CacheService: TDSHTTPCacheContextService;
  Len: Integer;
  ParamName: string;
begin
  CacheService := nil;
  CmdType := ARequestInfo.CommandType;

  SessionID := TDSHTTPApplication.Instance.GetRequestSessionId(aRequestInfo, True);

  //Try to load the session with the given session ID into the current thread
  SessionFailure :=
     not TDSHTTPApplication.Instance.LoadRESTSession(SessionID, ARequestInfo.AuthUserName, FSessionTimeout, FSessionLifetime,
                           nil (*FTunnelService*), FDSHTTPAuthenticationManager, ARequestInfo,
                           IsNewSession);
  Session := TDSSessionManager.GetThreadSession;

  //free any stream which was stored from a previous execution
  if Session <> nil then
  begin
    Session.LastResultStream.Free;
    Session.LastResultStream := nil;
  end;

  try
    if (Session = nil) or SessionFailure then
    begin
      AResponseInfo.ResponseNo := 403; //Forbidden
      AResponseInfo.ResponseText := SESSION_EXPIRED;
      AResponseInfo.ContentText := '{"SessionExpired":"' + SSessionExpiredMsg + '"}';
    end
    else
    begin
      CacheService := TDSHTTPCacheContextService.Create(Session, LocalConnection);

      Len := 0;
      while (Len < ARequestInfo.Params.Count) do
      begin
        try
          ParamName := ARequestInfo.Params.Names[Len];
          CacheService.ProcessQueryParameter(ParamName, ARequestInfo.Params.Values[ParamName]);
        finally
          Inc(Len);
        end;
      end;

      // dispatch to the appropriate service
      case CmdType of
        TDSHTTPCommandType.hcGET: CacheService.ProcessGETRequest(ARequestInfo, AResponseInfo, Request);
        TDSHTTPCommandType.hcDELETE: CacheService.ProcessDELETERequest(ARequestInfo, AResponseInfo, Request);
        else
        begin
          AResponseInfo.ResponseNo := 501;
          AResponseInfo.ContentText := Format(SCommandNotSupported, [ARequestInfo.Command]);
        end;
      end;
    end;
  finally
    CacheService.Free;
    AResponseInfo.CloseConnection := true;
    // Session cleared by TDSHTTPApplication.EndDispatch
    //TDSSessionManager.ClearThreadSession;
  end;
end;

function TDSRESTServer.CreateRESTService(const AuthUserName, AuthPassword: string): TDSRESTService;
begin
                                                        
  Assert(FDSServerName <> '');
  Assert(DSServer <> nil);
  Result := TDSRESTService.Create(DSServer, '', 0, AuthUserName, AuthPassword, IPImplementationID)
end;

function TDSHTTPServer.CreateRESTService(const AuthUserName, AuthPassword: string): TDSRESTService;
begin
  if FCredentialsPassthrough then
    Result := TDSRESTService.Create(FDSServerName, FDSHostname, FDSPort, AuthUserName, AuthPassword, IPImplementationID)
  else
    Result := TDSRESTService.Create(FDSServerName, FDSHostname, FDSPort, FDSAuthUser, FDSAuthPassword, IPImplementationID);
end;


                            
// Entry point for rest.  Should be able to create session before calling this method
procedure TDSRESTServer.DoDSRESTCommand(ARequestInfo: TDSHTTPRequest;
                                        AResponseInfo: TDSHTTPResponse;
                                        Request: string);
var
  CmdType: TDSHTTPCommandType;
  ResponseOk: Integer;
  RESTService: TDSRESTService;
  Len: Integer;
  ParamName: string;
  SessionID: string;
  Session: TDSSession;
  IsNewSession: Boolean;
  SessionFailure: Boolean;
  RespHandler: TDSServiceResponseHandler;
  OwnService: Boolean;
begin
  OwnService := True;
  RespHandler := nil;

  CmdType := ARequestInfo.CommandType;
  ResponseOk := 200;

  RESTService := CreateRESTService(ARequestInfo.AuthUserName, ARequestInfo.AuthPassword);

  // process query parameters
  Len := 0;
  while (Len < ARequestInfo.Params.Count) and (ResponseOk < 300) do
  begin
    ParamName := ARequestInfo.Params.Names[Len];
    //check for session ID parameter in the URL
    if (Uppercase(ParamName) = 'SESSIONID') or (Uppercase(ParamName) = 'SID') then
    begin
      SessionID := ARequestInfo.Params.Values[ParamName]
    end
    else if not RESTService.ProcessQueryParameter(ParamName, ARequestInfo.Params.ValueFromIndex[Len]) then
    begin
      ResponseOK := 409;
      AResponseInfo.ResponseText := Format(CANNOT_PROCESS_PARAM, [ARequestInfo.Params.Names[Len],
                                           ARequestInfo.Params.Values[ARequestInfo.Params.Names[Len]]]);
    end;
    Inc(Len);
  end;
  if (ResponseOK < 300) and not RESTService.CheckConvertersForConsistency then
  begin
    // 409 - Indicates that the request could not be processed because of conflict in the request
    AResponseInfo.ResponseNo := 409;
    AResponseInfo.ResponseText := QUERY_PARAM_CONFLICT;
  end;

  //if no session ID is given in the URL, then try to load it from the Pragma header field
  if SessionID = EmptyStr then
  begin
    SessionID := TDSHTTPApplication.Instance.GetRequestSessionId(aRequestInfo, False);
  end;

  //Try to load the session with the given session ID into the current thread
  SessionFailure :=
     not TDSHTTPApplication.FInstance.LoadRESTSession(SessionID, ARequestInfo.AuthUserName, FSessionTimeout, FSessionLifetime,
                           nil (*FTunnelService*), FDSHTTPAuthenticationManager, ARequestInfo,
                           IsNewSession);
  Session := TDSSessionManager.GetThreadSession;

  //free any stream which was stored from a previous execution
  if Session <> nil then
  begin
    Session.LastResultStream.Free;
    Session.LastResultStream := nil;

    if not SessionFailure then
      UpdateSessionTunnelHook(Request, Session, ARequestInfo);
  end;

  if not SessionFailure and IsClosingSession(Request) then
  begin
    try
      CloseRESTSession(Session, AResponseInfo);
    finally
      FreeAndNil(RESTService);
                                                                         
      TDSSessionManager.ClearThreadSession;
    end;
    exit;
  end;

  try
    if SessionFailure then
    begin
      AResponseInfo.ResponseNo := 403; //Forbidden
      AResponseInfo.ResponseText := SESSION_EXPIRED;
      AResponseInfo.ContentText := '{"SessionExpired":"' + SSessionExpiredMsg + '"}';
    end
    else if ResponseOK >= 300 then
    begin
      // pre-parsing failed and the decision is in ResponseOK, response text already set
      AResponseInfo.ResponseNo := ResponseOK;
    end
    //don't need to authenticate if returning to a previously authenticated session
    else if (FDSHTTPAuthenticationManager <> nil) and IsNewSession and not FDSHTTPAuthenticationManager.Authenticate(
                    DATASNAP_CONTEXT, RESTContext, ARequestInfo.AuthUserName, ARequestInfo.AuthPassword,
                      ARequestInfo, AResponseInfo) then
      if ARequestInfo.AuthUserName <> EmptyStr then
        AResponseInfo.ResponseNo := 403
      else
      begin
        AResponseInfo.SetHeaderAuthentication('Basic', 'REST');
        AResponseInfo.ResponseNo := 401
      end
    else
    begin
      if Session <> nil then
      begin
        AResponseInfo.Pragma := 'dssession=' + Session.SessionName;
        AResponseInfo.Pragma := AResponseInfo.Pragma + ',dssessionexpires=' + IntToStr(Session.ExpiresIn);
      end;

      OwnService := False;
      //create the response handler for populating the response info
      RespHandler := TDSResponseHandlerFactory.CreateResponseHandler(RESTService, ARequestInfo, TDSHTTPCommandType.hcUnknown, Self);
      if RespHandler = nil then
      begin
        AResponseInfo.ResponseNo := 406; //Not Acceptable
      end
      else
      begin
        if RespHandler is  TDSServiceResponseHandler then
        begin
          TDSServiceResponseHandler(RespHandler).OnParseRequest := Self.OnParseRequest;
          TDSServiceResponseHandler(RespHandler).OnParsingRequest := Self.OnParsingRequest;
        end;

        //add the query parameters to invocation metadata
        if ARequestInfo.Params.Count > 0 then
          GetInvocationMetadata().QueryParams.AddStrings(ARequestInfo.Params);

        // dispatch to the appropriate service
        case CmdType of
          TDSHTTPCommandType.hcGET:
            RESTService.ProcessGETRequest(Request, nil, nil, RespHandler);
          TDSHTTPCommandType.hcPOST:
            RESTService.ProcessPOSTRequest(Request, ARequestInfo.Params, byteContent( ARequestInfo.PostStream ),
                                        RespHandler);
          TDSHTTPCommandType.hcPUT:
          begin
            RESTService.ProcessPUTRequest(Request, ARequestInfo.Params, byteContent( ARequestInfo.PostStream ),
                                        RespHandler);
          end;
          TDSHTTPCommandType.hcDELETE:
            RESTService.ProcessDELETERequest(Request, nil, nil, RespHandler);
          else
          begin
            GetInvocationMetadata().ResponseCode := 501;
            GetInvocationMetadata().ResponseContent := Format(SCommandNotSupported, [ARequestInfo.Command]);
          end;
        end;

        //populate the Response Info from the execution result
        RespHandler.PopulateResponse(AResponseInfo, GetInvocationMetadata());
      end;
    end;
  finally
    if RespHandler = nil then
      FreeAndNil(RESTService);

    if RespHandler <> nil then
      RespHandler.Close;

    if OwnService then
      FreeAndNil(RESTService);

                                    
    if (GetInvocationMetadata(False) <> nil) and
         GetInvocationMetadata.CloseSession and
        (TDSSessionManager.GetThreadSession <> nil) then
    begin
      if TDSSessionManager.GetThreadSession.SessionName <> '' then
        TDSSessionManager.Instance.CloseSession(TDSSessionManager.GetThreadSession.SessionName);
      TDSSessionManager.ClearThreadSession;
    end;
    // Session cleared by TDSHTTPApplication.EndDispatch
    // TDSSessionManager.ClearThreadSession;
  end;
end;

procedure TDSRESTServer.DoDSOtherCommand(
      const AContext: TDSHTTPContext;
      const ARequestInfo: TDSHTTPRequest;
      const AResponseInfo: TDSHTTPResponse;
      const APrefix: string;
      const ARequest: string;
      ALocalConnection: Boolean);
begin
  Assert(False);

end;

procedure TDSHTTPServer.DoDSOtherCommand(
      const AContext: TDSHTTPContext;
      const ARequestInfo: TDSHTTPRequest;
      const AResponseInfo: TDSHTTPResponse;
      const APrefix: string;
      const ARequest: string;
      ALocalConnection: Boolean);

begin
  if SameText(APrefix, FCacheContext) then
    DoDSCacheCommand(ARequestInfo, AResponseInfo, ARequest, FDSServerName <> EmptyStr)
  else
    DoTunnelCommand(AContext, ARequestInfo, AResponseInfo)
end;

procedure TDSHTTPServer.DoTunnelCommand(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
                                        AResponseInfo: TDSHTTPResponse);
var
  CmdType: TDSHTTPCommandType;
  JsonResponse: TJSONValue;
  Len: Integer;
  NeedsAuthentication: Boolean;
  CloseConnection: Boolean;
  ClientInfo: TDBXClientInfo;
begin
  JsonResponse := nil;
  CmdType := ARequestInfo.CommandType;

  // Note that CredentialsPassthrough, DSAuthUser and DSAuthPassword properties
  // do not apply when tunneling using a DBX connection (which is what is happening in this method).
  // Instead, the DBX connection string credentials from the client are passed though the
  // tunnel without modification.
  // The CredentialsPassthrough, DSAuthUser and DSAuthPassword properties
  // do apply when tunneling using a REST connection. See TDSHTTPServer.DoJSONCommand.

  // Optionally, the client may send user/password in HTTP headers in addition to the
  // credentials in the DBX connection string.  If the tunnel is between processea, this gives
  // the HTTP end of the tunnel a chance to authenticate before the TCP/IP end.
  // HTTP authentication is ignored when tunneling in-process because authentication will take place
  // when the DBX connection string is received from the client.
  NeedsAuthentication := (not FTunnelService.HasLocalServer) and FTunnelService.NeedsAuthentication(ARequestInfo.Params);

  ClientInfo.IpAddress := ARequestInfo.RemoteIP;
  ClientInfo.Protocol := ARequestInfo.ProtocolVersion;
  ClientInfo.AppName := ARequestInfo.UserAgent;

  //initialize the session so that it will be available when authenticating.
  FTunnelService.InitializeSession(ARequestInfo.Params, ClientInfo);

  try
    try
      if (FDSHTTPAuthenticationManager <> nil) and NeedsAuthentication and
          not FDSHTTPAuthenticationManager.Authenticate(DATASNAP_CONTEXT, TUNNEL_CONTEXT,
              ARequestInfo.AuthUserName, ARequestInfo.AuthPassword, ARequestInfo, AResponseInfo) then
        AResponseInfo.ResponseNo := 401
      else
      begin
        case CmdType of
          TDSHTTPCommandType.hcGET:
          begin
            Len := 0;
            AResponseInfo.ContentStream := FTunnelService.ProcessGET(ARequestInfo.Params, Len, CloseConnection);
            AResponseInfo.ContentLength := Len;
            AResponseInfo.CloseConnection := CloseConnection;
            if Len = 0 then
            begin
              // no data are available from DS - server error
              AResponseInfo.ResponseNo := 500;
              AResponseInfo.ResponseText := NO_SERVER_DATA;
              AResponseInfo.CloseConnection := true;
            end;
          end;
          TDSHTTPCommandType.hcPUT, TDSHTTPCommandType.hcPOST:
          begin
            FTunnelService.ProcessPOST(ARequestInfo.Params, ByteContent(ARequestInfo.PostStream),
                                       JsonResponse, CloseConnection);
            AResponseInfo.CloseConnection := CloseConnection;
          end;
          TDSHTTPCommandType.hcDELETE:
          begin
            AResponseInfo.ResponseNo := 501;
            AResponseInfo.ResponseText := Format(PROTOCOL_COMMAND_NOT_SUPPORTED, [ARequestInfo.Command]);
            AResponseInfo.CloseConnection := true;
          end
          else
          begin
            AResponseInfo.ResponseNo := 501;
            AResponseInfo.ResponseText := Format(PROTOCOL_COMMAND_NOT_SUPPORTED, [ARequestInfo.Command]);
            AResponseInfo.CloseConnection := true;
          end;
        end;

        if JsonResponse <> nil then
        begin
          AResponseInfo.ResponseNo := 200;
          AResponseInfo.ContentText := StringOf(ByteContent(JsonResponse));
        end;
      end;
    except on Ex: Exception do
    begin
      AResponseInfo.ResponseNo := 500;
      AResponseInfo.ResponseText := Ex.message;
      AResponseInfo.CloseConnection := true;
    end;
  end;
  finally
    JsonResponse.Free;
    // if client dropped the connection session can be terminated.
    try
      if not AContext.Connected then
        TDSTunnelService.TerminateSession(ARequestInfo.Params);
    except on Exception do
      TDSTunnelService.TerminateSession(ARequestInfo.Params);
    end;
  end;
end;

procedure TDSRESTServer.DoCommand(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
                                  AResponseInfo: TDSHTTPResponse);
var
  Request: string;
  NextRequest: string;
  NextContext: string;
  RestCtxt: string;
  StartDispatch: Boolean;
begin

  // HTTPDispatch object if necessary
  StartDispatch := not TDSHTTPApplication.Instance.Dispatching;
  if StartDispatch then
    TDSHTTPApplication.Instance.StartDispatch(AContext, ARequestInfo, AResponseInfo);
  try
{$IFNDEF POSIX}
  if CoInitFlags = -1 then
    CoInitializeEx(nil, COINIT_MULTITHREADED)
  else
    CoInitializeEx(nil, CoInitFlags);
{$ENDIF}
  try
    // check for context, if not found send the appropriate error message
    Request := ARequestInfo.URI;
    if Consume(FDSContext, Request, NextRequest) then
    begin
      Request := NextRequest;
      if Consume(FRESTContext, Request, NextRequest) then
      begin
        // datasnap/rest
        DoDSRESTCommand(ARequestInfo, AResponseInfo, NextRequest);
      end
      else if ConsumeOtherContext(Request, NextContext, NextRequest) then
      begin
        DoDSOtherCommand(AContext, ARequestInfo, AResponseInfo, NextContext, NextRequest, FDSServerName <> EmptyStr);
      end
      else
      begin
        RestCtxt := Trim(FRESTContext);
        if RestCtxt = EmptyStr then
          RestCtxt := SProtocolRestEmpty;

        AResponseInfo.ResponseNo := 501; {rest or other service not found in URI}
        AResponseInfo.ContentText := Format(SProtocolNotSupported, [Request, RestCtxt]);
        AResponseInfo.CloseConnection := true;
      end;
    end
    else
    begin
      // This may dispatch .js files for example
      DoCommandOtherContext(AContext, ARequestInfo, AResponseInfo, Request);
    end;
    if Assigned(Self.FTrace ) then
    begin
      FTrace(Self, AContext, ARequestInfo, AResponseInfo);
    end;
  finally
                                                     
    ClearInvocationMetadata();
{$IFNDEF POSIX}
    CoUnInitialize;
{$ENDIF}
  end;
  finally
    if StartDispatch then
      TDSHTTPApplication.Instance.EndDispatch;
  end;
end;

procedure TDSRESTServer.DoCommandOtherContext(AContext: TDSHTTPContext; ARequestInfo: TDSHTTPRequest;
                                    AResponseInfo: TDSHTTPResponse; const ARequest: string);
begin
  AResponseInfo.ResponseNo := 404; {datasnap not found}
  AResponseInfo.ResponseText := Format(INVALID_DATASNAP_CONTEXT, [ARequest]);
  AResponseInfo.CloseConnection := true;
end;

function TDSRESTServer.ConsumeOtherContext(const AContext: string; out APrefix: string; out AUnused: string): Boolean;
begin
  APrefix := '';
  AUnused := '';
  Result := False;
end;

function TDSHTTPServer.ConsumeOtherContext(const AContext: string; out APrefix: string; out AUnused: string): Boolean;
begin
  APrefix := TUNNEL_CONTEXT;
  Result := Consume(APrefix, AContext, AUnused);
  if not Result then
  begin
    APrefix := FCacheContext;
    Result := Consume(APrefix, AContext, AUnused);
  end;
end;

function TDSRESTServer.Consume(const Prefix: string; const Context: string; out Unused: string): Boolean;
var
  SlashDel, StartIdx: Integer;
  Ctx: string;
begin
  // empty prefix is accepted
  if Prefix = '' then
  begin
    Unused := Context;
    exit(true);
  end;

  // find first and the second REQUEST_DELIMITER indexes
  StartIdx := 1;
  SlashDel := Context.IndexOf(REQUEST_DELIMITER) + 1;
  if SlashDel = 1 then
  begin
    StartIdx := 2;
    SlashDel := Context.IndexOf(REQUEST_DELIMITER, StartIdx) + 1;
  end;

  if SlashDel = 0 then
    SlashDel := Context.IndexOf(REQUEST_PARAM_DELIMITER, StartIdx) + 1;

  if SlashDel = 0 then
    SlashDel := Context.Length + 1;
  Ctx := Context.Substring(StartIdx - 1, SlashDel - StartIdx);
  if Ctx.IndexOf('%') >= 0 then // Optimization
    Ctx := Decode(Ctx);


  if AnsiCompareText(Prefix, Ctx) = 0 then
  begin
    Unused := Context.Substring(SlashDel - 1, Context.Length - SlashDel + 1);
    Result := true;
  end
  else
    Result := false;  // prefix not found
end;

{TCustomDSHTTPServerTransport}

constructor TCustomDSRESTServerTransport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDSRESTContext := REST_CONTEXT;
  FDSContext := DATASNAP_CONTEXT;
  FSessionTimeout := 1200000;
  FResultEvent := nil;
end;

constructor TCustomDSHTTPServerTransport.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDSCacheContext := CACHE_CONTEXT;
  FDSHostname := 'localhost';
  FDSPort := 211;
  FCredentialsPassThrough := false;
  FDSAuthUser := EmptyStr;
  FDSAuthPassword := EmptyStr;
end;

function TCustomDSHTTPServerTransport.CreateRESTServer: TDSRESTServer;
begin
  FHttpServer := CreateHttpServer;
  Result := FHttpServer;
end;

procedure TCustomDSRESTServerTransport.DefineProperties(Filer: TFiler);
begin
  inherited;
    // For backwards compatibility
  Filer.DefineProperty('Trace', ReadTrace, nil, False);
  Filer.DefineProperty('FormatResult', ReadFormatResult, nil, False);
end;

type
  TOpenReader = class(TReader);

procedure TCustomDSRESTServerTransport.ReadProperty(Reader: TReader; const ANewProperty: string);
var
  LIdent: string;
  LMethod: TMethod;
begin
  LIdent := Reader.ReadIdent;
  LMethod := TOpenReader(Reader).FindMethodInstance(Reader.Root, LIdent);
  if LMethod.Code <> nil then System.TypInfo.SetMethodProp(Self, ANewProperty, LMethod);
end;

procedure TCustomDSRESTServerTransport.ReadTrace(Reader: TReader);
const
  sNewProperty = 'OnHTTPTrace';
begin
  ReadProperty(Reader, sNewProperty);
end;

procedure TCustomDSRESTServerTransport.ReadFormatResult(Reader: TReader);
const
  sNewProperty = 'OnFormatResult';
begin
  ReadProperty(Reader, sNewProperty);
end;

destructor TCustomDSRESTServerTransport.Destroy;
begin
  Server := nil;
  FreeAndNil(FRestServer);
  //FreeAndNil(FDSHTTPAuthenticationManager);
  inherited;
end;

function TCustomDSRESTServerTransport.GetResultEvent: TDSRESTResultEvent;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.ResultEvent
  else
    Result := FResultEvent;
end;

procedure TCustomDSRESTServerTransport.SetResultEvent(const RestEvent: TDSRESTResultEvent);
begin
  FResultEvent := RestEvent;
  if FRESTServer <> nil then
    FRESTServer.ResultEvent := RestEvent;
end;

function TCustomDSRESTServerTransport.GetRESTContext: string;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.RESTContext
  else
    Result := FDSRestContext + '/';
end;

procedure TCustomDSRESTServerTransport.SetRESTContext(const Ctx: string);
begin
  if (Ctx <> EmptyStr) and (Ctx.Chars[Ctx.Length - 1] = '/') then
    FDSRestContext := Ctx.Substring(0, Ctx.Length - 1)
  else
    FDSRestContext := Ctx;
  if FRESTServer <> nil then
    FRESTServer.RESTContext := Ctx;
end;

procedure TCustomDSRESTServerTransport.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
    if (AComponent = Server) then
      Server := nil
    else if (Assigned(FRestServer)) and (AComponent = FRestServer.DSAuthenticationManager) then
      FRestServer.DSAuthenticationManager := nil;
    if AComponent = FAuthenticationManager  then
      FAuthenticationManager := nil;
end;

procedure TCustomDSRESTServerTransport.SetTraceEvent(Event: TDSHTTPServiceTraceEvent);
begin
  FTrace := Event;
  if FRESTServer <> nil then
    FRESTServer.FTrace := Event;
end;

function TCustomDSRESTServerTransport.GetTraceEvent: TDSHTTPServiceTraceEvent;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.FTrace
  else
    Result := FTrace;
end;

procedure TCustomDSRESTServerTransport.SetParseRequestEvent(Event: TParseRequestEvent);
begin
  FParseRequestEvent := Event;
  if FRESTServer <> nil then
    FRESTServer.FParseRequestEvent := Event;
end;

function TCustomDSRESTServerTransport.GetParseRequestEvent: TParseRequestEvent;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.FParseRequestEvent
  else
    Result := FParseRequestEvent;
end;

procedure TCustomDSRESTServerTransport.SetParsingRequestEvent(Event: TParsingRequestEvent);
begin
  FParsingRequestEvent := Event;
  if FRESTServer <> nil then
    FRESTServer.FParsingRequestEvent := Event;
end;

function TCustomDSRESTServerTransport.GetParsingRequestEvent: TParsingRequestEvent;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.FParsingRequestEvent
  else
    Result := FParsingRequestEvent;
end;

procedure TCustomDSRESTServerTransport.InitializeRESTServer;
begin
  FRESTServer.SessionTimeout := FSessionTimeout;
  FRESTServer.DSContext := FDSContext;
  FRESTServer.RESTContext := FDSRestContext;
  FRESTServer.DSAuthenticationManager := FAuthenticationManager;
  FRESTServer.FTrace := FTrace;
  FRESTServer.FParseRequestEvent := FParseRequestEvent;
  FRESTServer.FParsingRequestEvent := FParsingRequestEvent;
  FRESTServer.ResultEvent := FResultEvent;
  FRESTServer.FSessionLifetime := FSessionLifetime;
  UpdateDSServerName;
end;

procedure TCustomDSHTTPServerTransport.InitializeRESTServer;
begin
  inherited;
  InitializeHttpServer;
end;

procedure TCustomDSHTTPServerTransport.InitializeHttpServer;
begin
  inherited;
  FHttpServer.CacheContext := FDSCacheContext;
  FHttpServer.Filters := Filters;
  FHTTPServer.CredentialsPassThrough := FCredentialsPassthrough;
  FHTTPServer.DSAuthUser := FDSAuthUser;
  FHTTPServer.DSAuthPassword := FDSAuthPassword;
  FHTTPServer.DSPort := FDSPort;
  FHTTPServer.DSHostname := FDSHostname;
end;

procedure TCustomDSRESTServerTransport.Loaded;
begin
  inherited;
  // Initialize server after properties have been loaded
  RequiresServer;
end;

procedure TCustomDSRESTServerTransport.SetAuthenticationManager(
  const AuthenticationManager: TDSCustomAuthenticationManager);
begin
  FAuthenticationManager := AuthenticationManager;
  if FRESTServer <> nil then
    FRESTServer.DSAuthenticationManager := AuthenticationManager;
end;

procedure TCustomDSHTTPServerTransport.SetCacheContext(const Ctx: string);
begin
  if (Ctx <> EmptyStr) and (Ctx.Chars[Ctx.Length - 1] = '/') then
    FDSCacheContext := Ctx.Substring(0, Ctx.Length - 1)
  else
    FDSCacheContext := Ctx;
  if FHTTPServer <> nil then
    FHTTPServer.CacheContext := Ctx;
end;

procedure TCustomDSRESTServerTransport.SetDSContext(const Ctx: string);
begin
  if (Ctx <> EmptyStr) and (Ctx.Chars[Ctx.Length - 1] = '/') then
    FDSContext := Ctx.Substring(0, Ctx.Length - 1)
  else
    FDSContext := Ctx;
  if FRESTServer <> nil then
    FRESTServer.DSContext := Ctx;
end;

procedure TCustomDSHTTPServerTransport.SetDSHostname(Host: string);
begin
  FDSHostname := Host;
  if FHttpServer <> nil then
    FHttpServer.DSHostname := Host;
end;

function TCustomDSRESTServerTransport.GetAuthenticationManager: TDSCustomAuthenticationManager;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.DSAuthenticationManager
  else
    Result := FAuthenticationManager;
end;

function TCustomDSHTTPServerTransport.GetCacheContext: string;
begin
  if FHTTPServer <> nil then
    Result := FHTTPServer.CacheContext
  else
    Result := FDSCacheContext + '/';
end;

function TCustomDSRESTServerTransport.GetDSContext: string;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.DSContext
  else
    Result := FDSContext + '/';
end;

function TCustomDSHTTPServerTransport.GetDSHostname: string;
begin
  if FHttpServer <> nil then
    Result := FHttpServer.DSHostname
  else
    Result := FDSHostname;
end;

procedure TCustomDSHTTPServerTransport.SetDSPort(Port: Integer);
begin
  FDSPort := Port;
  if FHttpServer <> nil then
    FHttpServer.DSPort := Port;
end;

procedure TCustomDSRESTServerTransport.SetServer(const AServer: TDSCustomServer);
begin
  if AServer <> Server then
  begin
    if Server <> nil then
      Server.RemoveFreeNotification(Self);
    if AServer <> nil then
      AServer.FreeNotification(Self);

    inherited SetServer(AServer);

    if FRESTServer <> nil then
      UpdateDSServerName;
  end;
end;

procedure TCustomDSRESTServerTransport.UpdateDSServerName;
begin
  FRESTServer.DSServer := Self.Server;
  if Server <> nil then
  begin
    FRESTServer.DSServerName := Server.Name;
    FRESTServer.CreateProtocolHandlerFactory(self)
  end
  else
  begin
    FRESTServer.DSServerName := EmptyStr;
    FRESTServer.ClearProtocolHandlerFactory
  end;
end;

function TCustomDSRESTServerTransport.IsDSContextStored: Boolean;
begin
  Result := not SameText(GetDSContext, 'datasnap/');
end;

function TCustomDSRESTServerTransport.IsRESTContextStored: Boolean;
begin
  Result := not SameText(GetRESTContext, 'rest/');
end;

function TCustomDSHTTPServerTransport.IsCacheContextStored: Boolean;
begin
  Result := not SameText(GetCacheContext, 'cache/');
end;

function TCustomDSHTTPServerTransport.IsDSHostnameStored: Boolean;
begin
  Result := not SameText(GetDSHostname, 'localhost');
end;

function TCustomDSHTTPServerTransport.GetDSPort: Integer;
begin
  if Assigned(FHttpServer) then
    Result := FHttpServer.DSPort
  else
    Result := FDSPort;
end;

procedure TCustomDSRESTServerTransport.RequiresServer;
begin
  if FRestServer = nil then
  begin
    FRESTServer := CreateRESTServer;
    InitializeRESTServer;
  end;
end;

function TCustomDSRESTServerTransport.GetRESTServer: TDSRESTServer;
begin
  RequiresServer;
  // Should not create during loading process because properties of transport may determine type of http server
  Assert(not (csLoading in ComponentState));
  Result := FRESTServer;
end;

function TCustomDSHttpServerTransport.GetHttpServer: TDSHttpServer;
begin
  RequiresServer;
  // Should not create during loading process because properties of transport may determine type of http server
  Assert(not (csLoading in ComponentState));
  Result := FHttpServer;
end;

procedure TCustomDSHTTPServerTransport.SetFilters(const Value: TTransportFilterCollection);
begin
  inherited SetFilters(Value);
  if FHttpServer <> nil then
    FHttpServer.Filters := GetFilters;
end;

procedure TCustomDSRESTServerTransport.SetIPImplementationID(
  const AIPImplementationID: string);
begin
  inherited;
  if Assigned(FRESTServer) then
    FRESTServer.FIPImplementationID := AIPImplementationID;
end;

procedure TCustomDSHttpServerTransport.ServerCloseAllTunnelSessions;
begin
  // Call private method of FHttpServer
  if FHttpServer <> nil then
    FHttpServer.CloseAllTunnelSessions;
end;

function TCustomDSHTTPServerTransport.GetCredentialsPassThrough: Boolean;
begin
  if FHttpServer <> nil then
    Result := FHttpServer.CredentialsPassThrough
  else
    Result := FCredentialsPassThrough;
end;

function TCustomDSHTTPServerTransport.GetDSAuthPassword: string;
begin
  if FHttpServer <> nil then
    Result := FHttpServer.DSAuthPassword
  else
    Result := FDSAuthPassword;
end;

function TCustomDSHTTPServerTransport.GetDSAuthUser: string;
begin
  if FHttpServer <> nil then
    Result := FHttpServer.DSAuthUser
  else
    Result := FDSAuthUser;
end;

procedure TCustomDSHTTPServerTransport.SetCredentialsPassThrough(const AFlag: Boolean);
begin
  FCredentialsPassThrough := AFlag;
  if FHttpServer <> nil then
    FHttpServer.CredentialsPassThrough := AFlag
end;

procedure TCustomDSHTTPServerTransport.SetDSAuthPassword(const UserPassword: string);
begin
  FDSAuthPassword := UserPassword;
  if FHttpServer <> nil then
    FHttpServer.DSAuthPassword := UserPassword
end;

procedure TCustomDSHTTPServerTransport.SetDSAuthUser(const UserName: string);
begin
  FDSAuthUser := UserName;
  if FHttpServer <> nil then
    FHttpServer.DSAuthUser := UserName
end;

procedure TCustomDSRESTServerTransport.SetSessionTimeout(const Milliseconds: Integer);
begin
  FSessionTimeout := Milliseconds;
  if FRESTServer <> nil then
    FRESTServer.SessionTimeout := Milliseconds;
end;

function TCustomDSRESTServerTransport.GetSessionTimeout: Integer;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.SessionTimeout
  else
    Result := FSessionTimeout
end;

function TCustomDSRESTServerTransport.GetIPImplementationID: string;
begin
  if FRESTServer <> nil then
    Result := FRESTServer.IPImplementationID
  else
    Result := inherited;
end;

{ TDSResponseHandlerFactory }

class function TDSResponseHandlerFactory.CreateResponseHandler(DSService: TDSService;
            RequestInfo: TDSHTTPRequest; CommandType: TDSHTTPCommandType;
            HTTPServer: TDSHTTPServer): TDSServiceResponseHandler;
begin
  Result := CreateResponseHandler(DSService, RequestInfo, CommandType, TDSRESTServer(HTTPServer));
end;

class function TDSResponseHandlerFactory.CreateResponseHandler(DSService: TDSService;
            RequestInfo: TDSHTTPRequest; CommandType: TDSHTTPCommandType;
            HTTPServer: TDSRESTServer): TDSServiceResponseHandler;
var
  Accept: string;
begin
  if RequestInfo <> nil then
    Accept := RequestInfo.Accept;

  if (CommandType = TDSHTTPCommandType.hcUnknown) and (RequestInfo <> nil) then
    CommandType := RequestInfo.CommandType;

  if RequestInfo = nil then
    Result := TDSNullResponseHandler.Create(DSService, CommandType)
  else if (AnsiContainsStr(Accept, 'application/rest')) then
    Result := TDSCacheResponseHandler.Create(DSService, CommandType)
  else
  begin
                                     
    Result := TDSDefaultResponseHandler.Create(not DSService.StreamAsJSON, DSService, CommandType);
    if Assigned(HTTPServer) and Assigned(HTTPServer.ResultEvent) then
      TDSDefaultResponseHandler(Result).ResultEvent := HTTPServer.ResultEvent;
  end;
end;

{ TDSHTTPCacheContextService }

constructor TDSHTTPCacheContextService.Create(Session: TDSSession; LocalConnection: Boolean);
begin
  Assert(Session <> nil);

  inherited Create;

  FSession := Session;
  FLocalConnection := LocalConnection;
end;

function TDSHTTPCacheContextService.ParseRequst(Request: string; out CacheId, CommandIndex,
                                                ParameterIndex: Integer): Boolean;
var
  SlashLeft, SlashRight, SlashAux: Integer;
begin
  CacheId := -1;
  CommandIndex := -1;
  ParameterIndex := -1;
  Result := True;

  SlashLeft := Request.IndexOf(REQUEST_DELIMITER) + 1;
  if SlashLeft = 0 then
  begin
    //the user is interested in the cache as a whole, and not any specific object
    Exit(True);
  end;

  if SlashLeft > 1 then
  begin
    // first / is missing
    SlashRight := SlashLeft;
    SlashLeft := 1;
  end
  else
    SlashRight := Request.IndexOf(REQUEST_DELIMITER, SlashLeft) + 1;

  SlashAux := SlashRight;

  if SlashAux < 1 then
    SlashAux := Request.Length + 1;

  if SlashAux > (SlashLeft + 1) then
  begin
    try
      CacheId := StrToInt(Request.SubString(Slashleft, SlashAux-SlashLeft-1));
    except
      Exit(False);
    end;

    if SlashRight = SlashAux then
    begin
      SlashAux := Request.IndexOf(REQUEST_DELIMITER, SlashRight) + 1;
      SlashLeft := SlashRight;
      SlashRight := SlashAux;

      if SlashAux < SlashLeft then
        SlashAux := Request.Length + 1;

      if SlashAux > (SlashLeft + 1) then
      begin
        try
          CommandIndex := StrToInt(Request.Substring(Slashleft, SlashAux-SlashLeft-1));
        except
          Exit(False);
        end;

        if SlashRight = SlashAux then
        begin
          SlashAux := Request.IndexOf(REQUEST_DELIMITER, SlashRight) + 1;
          SlashLeft := SlashRight;

          if SlashAux < SlashLeft then
            SlashAux := Request.Length + 1;

          if SlashAux > (SlashLeft + 1) then
          begin
            try
              ParameterIndex := StrToInt(Request.Substring(Slashleft, SlashAux-SlashLeft-1));
            except
              Exit(False);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDSHTTPCacheContextService.GetCacheContents(out Value: TJSONValue);
var
  Ids: TList<Integer>;
  Key: Integer;
  Aux: TJSONValue;
begin
  Value := TJSONObject.Create;

  Ids := FSession.ParameterCache.GetItemIDs;
  for Key in Ids do
  begin
    GetCacheItemContents(Key, Aux);
    TJSONObject(Value).AddPair(TJSONPair.Create(IntToStr(Key), Aux));
  end;

  FreeAndNil(Ids);
end;

procedure TDSHTTPCacheContextService.GetCacheItemContents(const CacheId: Integer; out Value: TJSONValue);
var
  Item: TResultCommandHandler;
  CmdArray: TJSONArray;
  Aux: TJSONValue;
  I: Integer;
begin
  Item := FSession.ParameterCache.GetItem(CacheId);

  if Item = nil then
  begin
    Value := TJSONNull.Create;
    Exit;
  end;

  CmdArray := TJSONArray.Create;

  for I := 0 to Item.GetCommandCount - 1 do
  begin
    Aux := nil;
    GetCommandContents(CacheId, I, Aux);
    if Aux <> nil then
      CmdArray.Add(TJSONObject(Aux));
  end;

  Value := TJSONObject.Create;
  TJSONObject(Value).AddPair(TJSONPair.Create('commands', CmdArray));
end;

procedure TDSHTTPCacheContextService.GetCommandContents(const CacheId: Integer; const CommandIndex: Integer;
                                                        out Value: TJSONValue);
var
  Item: TResultCommandHandler;
  Param: TDBXParameter;
  TypeNames: TJSONArray;
  Count: Integer;
  I: Integer;
begin
  Item := FSession.ParameterCache.GetItem(CacheId);

  if Item = nil then
  begin
    Value := TJSONNull.Create;
    Exit;
  end;

  Count := Item.GetParameterCount(CommandIndex);

  Value := TJSONObject.Create;
  TypeNames := TJSONArray.Create;

  for I := 0 to Count - 1 do
  begin
    Param := Item.GetCommandParameter(CommandIndex, I);
    TypeNames.Add(Param.Name);
  end;

  TJSONObject(Value).AddPair(TJSONPair.Create('parameters', TypeNames));
end;

function TDSHTTPCacheContextService.GetOriginalParamIndex(const Command: TDBXCommand;
                                                          const Parameter: TDBXParameter): Integer;
var
  I: Integer;
begin
  Result := -1;

  if (Command <> nil) and (Parameter <> nil) then
  begin
    for I := 0 to Command.Parameters.Count - 1 do
    begin
      if Command.Parameters[I] = Parameter then
        Exit(I);
    end;
  end;
end;

procedure TDSHTTPCacheContextService.InvalidRequest(Response: TDSHTTPResponse; Request: string);
begin
  if Response <> nil then
  begin
    Response.ResponseNo := 400; //Bad Request
    Response.ResponseText := Format(INVALID_REQUEST, [Request]);
    Response.CloseConnection := true;
  end;
end;

procedure TDSHTTPCacheContextService.ProcessDELETERequest(const RequestInfo: TDSHTTPRequest;
                                                          Response: TDSHTTPResponse; Request: string);
var
  CacheId, CommandIndex, ParameterIndex: Integer;
begin
  //DELETE only allowed on cache as a whole, or on a whole cache item, not individual Commands or Parameters.
  if not ParseRequst(Request, CacheId, CommandIndex, ParameterIndex) or
     (CommandIndex <> -1) or (ParameterIndex <> -1) then
  begin
    InvalidRequest(Response, Request);
    Exit;
  end;

  if (CacheId = -1) then
    FSession.ParameterCache.ClearAllItems
  else
    FSession.ParameterCache.RemoveItem(CacheId);
end;

function TDSHTTPCacheContextService.StreamsAsJSON(const RequestInfo: TDSHTTPRequest): Boolean;
var
  StreamAsJson: Boolean;
  UrlParamValue: string;
begin
  StreamAsJson := False;

  UrlParamValue := RequestInfo.Params.Values['json'];

  if UrlParamValue <> '' then
  begin
    try
      StreamAsJSON := StrToBool(UrlParamValue);
    except
    end;
  end
  else
  begin
    StreamAsJSON := AnsiContainsStr(RequestInfo.Accept, 'application/json');
  end;

  Result := StreamAsJSON;
end;

procedure TDSHTTPCacheContextService.GetParameterValue(const RequestInfo: TDSHTTPRequest; const CacheId,
  CommandIndex, ParameterIndex: Integer; out Response: TJSONValue; out ResponseStream: TStream; out IsError: Boolean);
var
  Item: TResultCommandHandler;
  Command: TDBXCommand;
  Parameter: TDBXParameter;
  ConvList: TObjectList<TDBXRequestFilter>;
  OriginalIndex: Integer;
begin
  Item := FSession.ParameterCache.GetItem(CacheId);
  IsError := False;

  if Item = nil then
  begin
    Response := TJSONString.Create(Format(SNoCachItem, [CacheId]));
    IsError := True;
    Exit;
  end;

  Parameter := Item.GetCommandParameter(CommandIndex, ParameterIndex);

  if Parameter = nil then
  begin
    Response := TJSONString.Create(Format(SNoCacheParameter, [CommandIndex, ParameterIndex]));
    IsError := True;
    Exit;
  end;

  if not StreamsAsJSON(RequestInfo) and (Parameter.DataType = TDBXDataTypes.BinaryBlobType) then
  begin
    ResponseStream := Parameter.Value.GetStream(True);
    if ResponseStream = nil then
      Response := TJSONNull.Create;
  end
  else
  begin
    ConvList := TObjectList<TDBXRequestFilter>.Create(false);

    Command := Item.GetCommand(CommandIndex);
    OriginalIndex := GetOriginalParamIndex(Command, Parameter);

    try
      Response := nil;

      //use a request filter on the returned data, if one was specified
      if OriginalIndex > -1 then
      begin
        FiltersForCriteria([OriginalIndex+1], OriginalIndex = Command.Parameters.Count - 1, ConvList);
        if ConvList.Count = 1 then
        begin
          if not ConvList.Items[0].CanConvert(Command.Parameters[OriginalIndex].Value) then
            Raise TDSServiceException.Create(Format(SCannotConvertParam, [OriginalIndex, ConvList.Items[0].Name]));
          Response := ConvList.Items[0].ToJSON(Command.Parameters[OriginalIndex].Value, FLocalConnection)
        end;
      end;

      if Response = nil then
        Response := TDBXJSONTools.DBXToJSON(Parameter.Value, Parameter.DataType, FLocalConnection);
    finally
      FreeAndNil(ConvList);
    end;
  end;
end;

function TDSHTTPCacheContextService.ByteContent(JsonValue: TJSONValue): TArray<Byte>;
var
  Buffer: TArray<Byte>;
begin
  SetLength(Buffer, JsonValue.EstimatedByteSize);
  SetLength(Buffer, JsonValue.ToBytes(Buffer, 0));

  Result := Buffer;
end;

procedure TDSHTTPCacheContextService.ProcessGETRequest(const RequestInfo: TDSHTTPRequest;
                                                       Response: TDSHTTPResponse; Request: string);
var
  CacheId, CommandIndex, ParameterIndex: Integer;
  ResultObj: TJSONObject;
  SubResult: TJSONValue;
  ResultStream: TStream;
  IsError: Boolean;
  ResultStr: string;
begin
  ResultObj := nil;
  SubResult := nil;
  ResultStream := nil;
  IsError := False;

  if not ParseRequst(Request, CacheId, CommandIndex, ParameterIndex) then
  begin
    InvalidRequest(Response, Request);
    Exit;
  end;

  //datasnap/cache
  if (CacheId = -1) then
  begin
    GetCacheContents(SubResult);
  end
  //datasnap/cache/CacheId
  else if (CommandIndex = -1) then
  begin
    GetCacheItemContents(CacheId, SubResult);
  end
  //datasnap/cache/CacheId/CommandIndex
  else if (ParameterIndex = -1) then
  begin
    GetCommandContents(CacheId, CommandIndex, SubResult);
  end
  //datasnap/cache/CacheId/CommandIndex/ParameterIndex
  else
  begin
    GetParameterValue(RequestInfo, CacheId, CommandIndex, ParameterIndex, SubResult, ResultStream, IsError);
  end;

  try
    if Assigned(ResultStream) then
    begin
      Response.ContentStream := ResultStream;
      Response.FreeContentStream := False;
    end
    else if Assigned(SubResult) then
    begin
      if IsError then
        ResultStr := 'error'
      else
        ResultStr := 'result';

      ResultObj := TJSONObject.Create;
        ResultObj.AddPair(TJSONPair.Create(ResultStr, SubResult));
      Response.ContentText := StringOf(ByteContent(ResultObj))
    end;
  finally
    //Only free SubResult if it hasn't been added to ResultObj
    if ResultObj <> nil then
      ResultObj.Free
    else if Assigned(SubResult) then
      SubResult.Free;
  end;
end;

{ TDSDefaultResponseHandler }

procedure TDSDefaultResponseHandler.Close;
var
  Session: TDSSession;
begin
  //cache the Handler, so the stream isn't killed before the response is sent
  if FStoreHandler then
  begin
    Session := TDSSessionManager.Instance.GetThreadSession;
    if Session = nil then
      Raise TDSServiceException.Create(SNoSessionFound);

    if Session.LastResultStream <> nil then
    begin
      Session.LastResultStream.Free;
      Session.LastResultStream := nil;
    end;
                                                                                        
    // that the object needs to stick around until the response is sent, not until session
    // is terminated.
    Session.LastResultStream := Self;
  end
  else
    Free;
end;

constructor TDSDefaultResponseHandler.Create(AllowBinaryStream: Boolean; DSService: TDSService;
                                             CommandType: TDSHTTPCommandType; ServiceInstanceOwner: Boolean);
begin
  inherited Create(CommandType, DSService, ServiceInstanceOwner);

  FStoreHandler := False;
  FDSService := DSService;
end;

destructor TDSDefaultResponseHandler.Destroy;
begin
  ClearCommands();
  inherited;
end;

function TDSDefaultResponseHandler.HandleParameter(const Command: TDBXCommand;
  const Parameter: TDBXParameter; out Response: TJSONValue; var ResponseStream: TStream): Boolean;
begin
  {If there is only one output/return parameter and it is a Stream, return it as a stream}
  if (not FDSService.StreamAsJSON) and FAllowStream and
       (Parameter.DataType = TDBXDataTypes.BinaryBlobType) then
  begin
    //if FAllowStream is true there should be no case where we are
    //setting a value for stream when it already has a value
    Assert(ResponseStream = nil);

    ResponseStream := Parameter.Value.GetStream(True);
    if ResponseStream <> nil then
    begin
      //set this object to store itself in the Session, to be freed later,
      //after the stream it holds is no longer required by the REST response sent to the client.
      FStoreHandler := True;
    end
    else
      Response := TJSONNull.Create;
    exit(True);
  end;
  Result := False;
end;

procedure TDSDefaultResponseHandler.PopulateContent(ResponseInfo: TDSHTTPResponse; Response: TJSONValue;
                                                    ResponseStream: TStream);
begin
  if (ResponseStream = nil) and Assigned(Response) then
    ResponseInfo.ContentText := StringOf(ByteContent(Response))
  else if (ResponseStream <> nil) then
  begin
    ResponseInfo.ContentStream := ResponseStream;
    ResponseInfo.FreeContentStream := False;
  end;
end;

{ TDSCacheResponseHandler }

constructor TDSCacheResponseHandler.Create(DSService: TDSService; CommandType: TDSHTTPCommandType;
                                           ServiceInstanceOwner: Boolean);
begin
  inherited Create(CommandType, DSService, ServiceInstanceOwner);
  FCacheId := -1;
end;

destructor TDSCacheResponseHandler.Destroy;
begin
  inherited;
end;

function TDSCacheResponseHandler.GetCacheObject: TDSCacheResultCommandHandler;
begin
  if (FResultHandler = nil) then
    FResultHandler := TDSCacheResultCommandHandler.Create(Self);

  Result := FResultHandler;
end;

function TDSCacheResponseHandler.GetComplexParams(Command: TDBXCommand; out Index: Integer;
                                                  AddIfNotFound: Boolean): TDSCommandComplexParams;
var
  CP: TDSCommandComplexParams;
  I: Integer;
begin
  Result := nil;
  Index := -1;

  for I := 0 to GetCacheObject.CacheCommands.Count - 1 do
  begin
    CP := GetCacheObject.CacheCommands[I];
    if CP.Command = Command then
    begin
      Index := I;
      Exit(CP);
    end;
  end;

  if AddIfNotFound then
  begin
    Index := GetCacheObject.CacheCommands.Count;
    CP := TDSCommandComplexParams.Create(Command);
    GetCacheObject.CacheCommands.Add(CP);
    Result := CP;
  end;
end;

procedure TDSCacheResponseHandler.Close;
begin
  //If FCacheId is not specified then this object isn't stored in the Session Cache, so should be freed here.
  if FCacheId = -1 then
    Free;
end;

function TDSCacheResponseHandler.HandleParameter(const Command: TDBXCommand; const Parameter: TDBXParameter;
                                                 out Response: TJSONValue; var ResponseStream: TStream): Boolean;
var
  CP: TDSCommandComplexParams;
  DataType: Integer;
  CommandIndex: Integer;
  ParameterIndex: Integer;
  Session: TDSSession;
  Cache: TDSSessionCache;
  UrlString: string;
begin
  Result := False;

  Session := TDSSessionManager.GetThreadSession;

  if (Session <> nil) and (Parameter <> nil) then
  begin
    DataType := Parameter.DataType;
    if ((DataType = TDBXDataTypes.TableType) or
        (DataType = TDBXDataTypes.ObjectType) or
        ((DataType = TDBXDataTypes.JsonValueType) and
          (SameText(Parameter.TypeName, 'TJSONArray') or SameText(Parameter.TypeName, 'TJSONValue') or (SameText(Parameter.TypeName, 'TJSONObject') or
          (not SameText(Parameter.TypeName.Substring(0, 5), 'TJSON'))))) or
        (DataType = TDBXDataTypes.BlobType) or
        (DataType = TDBXDataTypes.BinaryBlobType)) then
    begin
      CP := GetComplexParams(Command, CommandIndex);

      if (CP <> nil) then
      begin
        ParameterIndex := CP.AddParameter(Parameter);
        Cache := Session.ParameterCache;

        if (Cache <> nil) and (ParameterIndex > -1) then
        begin
          if FCacheId = -1 then
            FCacheId := Cache.AddItem(GetCacheObject());

          if FCacheId > -1 then
          begin
            Result := True;
            UrlString := (IntToStr(FCacheId) + '/' + IntToStr(CommandIndex) + '/' + IntToStr(ParameterIndex));
            Response := TJSONString.Create(UrlString);
          end;
        end;
      end;
    end;
  end;
end;

procedure TDSCacheResponseHandler.PopulateContent(ResponseInfo: TDSHTTPResponse; Response: TJSONValue;
                                                  ResponseStream: TStream);
begin
  //ResponseStream should NEVER be assigned in this case,
  //as any streams should instead be stored in the session cache
  Assert(ResponseStream = nil);
  if Response <> nil then
  begin
    ResponseInfo.ContentText := StringOf(ByteContent(Response));
    ResponseInfo.ContentType := 'application/rest';
  end;
end;

procedure TDSCacheResponseHandler.ProcessResultObject(var ResultObj: TJSONObject; Command: TDBXCommand);
var
  CommandIndex: Integer;
begin
  if (ResultObj <> nil) and (FResultHandler <> nil) and
     (FResultHandler.CacheCommands.Count > 0) and (FCacheId > -1) then
  begin
    GetComplexParams(Command, CommandIndex, False);

    //Add to the result object two key/value pairs: cacheId and cmdIndex.
    //These can later be used to construct URLs into different levels of the Session Parameter cache
    if (CommandIndex > -1) then
    begin
      ResultObj.AddPair(TJSONPair.Create('cacheId', TJSONNumber.Create(FCacheId)));
      ResultObj.AddPair(TJSONPair.Create('cmdIndex', TJSONNumber.Create(CommandIndex)));
    end;
  end;
end;


{ TDSHTTPApplication }

procedure TDSHTTPApplication.SetSessionRequestInfo(const ASession: TDSSession;
  const ARequest: TDSHTTPRequest);
begin
  if ARequest <> nil then
  begin
    if ARequest.RemoteIP <> EmptyStr then
      ASession.PutData('RemoteIP', ARequest.RemoteIP);
    ASession.PutData('RemoteAppName', ARequest.UserAgent);
    ASession.PutData('CommunicationProtocol', ARequest.ProtocolVersion);
    ASession.PutData('ProtocolSubType', 'rest');
  end;
end;


                                                                      
threadvar
  FDSHTTPDispatch: TDSHTTPDispatch;

function TDSHTTPApplication.GetDispatching: Boolean;
begin
  Result := FDSHTTPDispatch <> nil;
end;

procedure TDSHTTPApplication.EndDispatch;
begin
  TDSSessionManager.ClearThreadSession;
  FreeAndNil(FDSHTTPDispatch);
end;

procedure TDSHTTPApplication.StartDispatch(const AContext: TDSHTTPContext;
      const ARequest: TDSHTTPRequest; const AResponse: TDSHTTPResponse);
var
  LDispatch: TDSHTTPDispatch;
begin
  Assert(FDSHTTPDispatch = nil);
  LDispatch := TDSHTTPDispatch.Create(AContext, ARequest, AResponse);  // Owns objects
  // set threadvar
  FDSHTTPDispatch := LDispatch;
end;

function TDSHTTPApplication.GetHTTPDispatch: TDSHTTPDispatch;
begin
  Result := FDSHTTPDispatch;
end;


initialization
  TDSHTTPApplication.FInstance := TDSHTTPApplication.Create;

finalization
  TDSHTTPApplication.FInstance.Free;

end.
