{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSSession;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.SyncObjs,
  System.JSON, Data.DBXCommon, Data.DbxDataSnap, Data.DBXTransport,
  Data.DBXMessageHandlerCommon,
  {$IFDEF CLR}
  DBXSocketChannelManaged,
  {$ELSE}
  Data.DbxSocketChannelNative,
  {$ENDIF}
  Datasnap.DSAuth, Datasnap.DSCommonServer, Datasnap.DSTransport,
  Datasnap.DSCommon, Datasnap.DSService;

type
  /// <summary>Record holding information that is mapped to a specific tunnel,
  /// which is to be associated with a session.</summary>
  TDSSessionTunnelInfo = record
    ///  <summary> The Channel Name associated with the tunnel. </summary>
    ChannelName: string;
    ///  <summary> The ID of the tunnel, as specified by the client. </summary>
    ClientChannelId: string;
    ///  <summary> Security token associated with the tunnel, for authorised modification. </summary>
    SecurityToken: string;
    ///  <summary> The User associated with the tunnel. </summary>
    AuthUser: string;
    ///  <summary> The password of the user associated with the tunnel. </summary>
    AuthPassword: string;
  end;

  TDSSessionCacheKeys = TList<Integer>;

  /// <summary>Implements a cache for holding commands with complex parameter
  /// types, stored for later reuse.</summary>
  TDSSessionCache = class
  private
    FItems : TDictionary<Integer, TResultCommandHandler>;
  public
    constructor Create;
    destructor Destroy; override;

    ///  <summary> Trys to add the given item to the list of items managed by the cache. If successful
    ///     this will return the unique ID for the item in the cache. If not successful, -1 will be returned.
    ///  </summary>
    function AddItem(Item: TResultCommandHandler): Integer;
    ///  <summary> Removes the given item from the list of managed items if found.
    ///  </summary>
    ///  <remarks> Does not claim ownership of the item. </remarks>
    procedure RemoveItem(Item: TResultCommandHandler); overload;
    ///  <summary> Removes the item with the given ID from the list of managed items if found.
    ///  </summary>
    ///  <remarks> If InstanceOwner is set to false, the item will be returned if found, or nil if not found.
    ///     If InstanceOwner is true, nil will always be returned.
    ///  </remarks>
    function RemoveItem(ID: Integer; InstanceOwner: Boolean = True): TResultCommandHandler; overload;
    ///  <summary> Returns the item with the given ID, or nil if not found.
    ///  </summary>
    function GetItem(ID: Integer): TResultCommandHandler;
    ///  <summary> Returns the ID for the item, or -1 if not found
    ///  </summary>
    function GetItemID(Item: TResultCommandHandler): Integer;
    ///  <summary> Returns a list of IDs currently helf by the cache </summary>
    function GetItemIDs: TDSSessionCacheKeys;
    ///  <summary> Clears all of the items stred in this cache,
    ///     freeing them if InstanceOwner is True. (defaults to true)
    ///  </summary>
    procedure ClearAllItems(InstanceOwner: Boolean = True);
  end;

  {$SCOPEDENUMS ON}
  /// <summary>Represents the current value of the lifetime of the HTTP
  /// session.</summary>
  TDSSessionLifetime = (TimeOut, Request);
  {$SCOPEDENUMS OFF}

  /// <summary>Represents the type of the session status.</summary>
  TDSSessionStatus = (Active, Closed, Idle, Terminated, Connected, Expired);

  TDSSession = class;

  TDSSessionData = class(TObject)
  private
    FDSSession: TDSSession;
    procedure SetSession(const ASession: TDSSession);
  public
    constructor Create; virtual;

    /// <summary> Returns true if the session holds data for the given key. </summary>
    function HasData(const AKey: string): Boolean; virtual; abstract;
    ///  <summary> Retrieve a value string stored in this session for the given key </summary>
    function GetData(const AKey: string): string; virtual; abstract;
    ///  <summary> Store a value string in this session with the given key </summary>
    procedure PutData(const AKey, LValue: string); virtual; abstract;
    ///  <summary> Remove a value string from this session matching the given key </summary>
    procedure RemoveData(const AKey: string); virtual; abstract;

    /// <summary> Returns true if the session holds an Object for the given key. </summary>
    function HasObject(const AKey: string): Boolean; virtual; abstract;
    ///  <summary> Retrieve a value Object stored in this session for the given key </summary>
    function GetObject(const AKey: string): TObject; virtual; abstract;
    ///  <summary> Store an Object in this session with the given key </summary>
    ///  <remarks> Returns false is the object couldn't be inserted. (Invalid/in-use key) </remarks>
    function PutObject(const AKey: string; AValue: TObject): Boolean; virtual; abstract;
    ///  <summary> Remove an Object from this session matching the given key </summary>
    function RemoveObject(const AKey: string; AInstanceOwner: Boolean): TObject; virtual; abstract;
    property Session: TDSSession read FDSSession;
  end;

  TDSSessionDictionaryData = class(TDSSessionData)
  private
    FMetaData: TDictionary<string,string>; /// map of metadata stored in the session
    FMetaObjects: TDictionary<string,TObject>;
    procedure CheckTransient;
  public
    constructor Create; override;
    destructor Destroy; override;
    function HasData(const AKey: string): Boolean; override;
    function GetData(const AKey: string): string; override;
    procedure PutData(const AKey, LValue: string); override;
    procedure RemoveData(const AKey: string); override;

    function HasObject(const AKey: string): Boolean; override;
    function GetObject(const AKey: string): TObject; override;
    function PutObject(const AKey: string; AValue: TObject): Boolean; override;
    function RemoveObject(const AKey: string; AInstanceOwner: Boolean): TObject; override;
  end;

  TDSSession = class(TPersistent)
  private
    FSessionData: TDSSessionData;
    FStartDateTime: TDateTime;   /// creation timestamp
    FDuration: Integer;          /// in miliseconds, 0 for infinite (default)
    FStatus: TDSSessionStatus;   /// default idle
    FLastActivity: Cardinal;     /// timestamp of the last activity on this session
    FUserName: string;           /// user name that was authenticated with this session
    FSessionName: string;        /// session name, may be internally generated, exposed to 3rd party
    FUserRoles: TStrings;        /// user roles defined through authentication
    FCache: TDSSessionCache;
    FLastResultStream: TObject;  /// Allow any object which owns a stream, or the stream itself, to be stored here
    FCreator: TObject;           /// Creator of the session object reference
    FSessionLifetime: TDSSessionLifetime;
  private
    procedure SetSessionName(const sessionId: string);
    procedure SetUserName(const userName: string);
    procedure SetLifetime(Value: TDSSessionLifetime);
    procedure CheckSessionData;
    function CreateSessionData: TDSSessionData;

  protected
    ///  <return> session internal id </return>
    function GetId: NativeInt;

    ///  <summary> terminates the current session, normally triggered by a scheduler </summary>
    procedure TerminateSession; virtual;
    ///  <summary> Terminates the session only if LifeDuration is less than than the
    ///     difference between the last active time and now.</summary>
    procedure TerminateInactiveSession; virtual;
    ///  <summary>returns true if session did not have any activity for number of seconds specified</summary>
    function IsIdle(Seconds: Cardinal): Boolean;
    function IsIdleMS(Milliseconds: Cardinal): Boolean;
    ///  <summary> Returns the session status </summary>
    ///  <remarks> Sets the session to expired if it was not already terminated, and it has been idle for Duration.
    ///  </remarks>
    function GetSessionStatus: TDSSessionStatus; virtual;
    procedure GetAuthRoleInternal(ServerMethod: TDSServerMethod; AuthManager : TDSCustomAuthenticationManager;
      out AuthorizedRoles, DeniedRoles: TStrings);
    ///  <summary> Raise an exception if this is a transient session</summary>
    ///  <remarks> Transient sessions have limitations.  For example, transient sessions can't store data
    ///  </remarks>
    procedure CheckTransient; virtual;
  public
    ///  <summary>Creates an anonymous session</summary>
    constructor Create; overload; virtual;
    constructor Create(const SessionName: string); overload; virtual;
    constructor Create(const SessionName: string; const AUser: string); overload; virtual;
    destructor Destroy; override;

    ///  <summary> Marks session be active </summary>
    procedure MarkActivity;
    ///  <summary> Schedules an event in elapsed time
    ///  </summary>
    ///  <param name="event">Event to be run after the time elapses</param>
    ///  <param name="elapsedTime">Elapsed time in miliseconds</param>
    procedure ScheduleUserEvent(Event: TDBXScheduleEvent; ElapsedTime: Integer);
    ///  <summary> Schedule a session termination event at FCreateDateTime + FDuration
    ///  </summary>
    procedure ScheduleTerminationEvent;
    ///  <summary> Similar to ScheduleTerminationEvent, but will be called continually each time the event
    ///     is executed until the session has been idle for longer than LifeDuration.
    ///  </summary>
    procedure ScheduleInactiveTerminationEvent;
    ///  <summary> Cancel the last shceduled event </summary>
    procedure CancelScheduledEvent;
    ///  <summary> Authenticate a connection from the given properties and any data stored in the Session. </summary>
    ///  <remarks> Subclasses of TDSSession should override this, to be useful, but also call into this base
    ///     implementation (ignoring the return value of this base implementation.)
    ///  </remarks>
    function Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean; overload; virtual;
    ///  <summary> Checks that the user of the current session has authorization for the given method. </summary>
    function Authorize(EventObject: TDSAuthorizeEventObject): Boolean; overload; virtual;
    ///  <summary> Returns true if the given method requires authorization, false otherwise. </summary>
    ///  <remarks> For example 'DSMetadata.GetDatabase' is called when a SQLConnection to the server
    ///    is established, so checking for authorization would be redundant (and possibly falsly fail)
    ///    as the connection is already authenticated.
    ///  </remarks>
    function RequiresAuthorization(MethodInfo: TDSMethodInfo): Boolean; virtual;
    ///  <summary> Get authorized and denied roles associated with server method </summary>
    procedure GetAuthRoles(ServerMethod: TDSServerMethod; out AuthorizedRoles,
      DeniedRoles: TStrings);  virtual;

    ///  <summary> Convenience function which returns true if status is Active, Connected or Idle
    ///  </summary>
    function IsValid: Boolean; virtual;

    ///  <summary>
    ///    Generates a unique session id
    ///  </summary>
    ///  <remarks>
    ///    No assumptions should be made about the id structure or content other
    ///    than unicity on the current process
    ///  </remarks>
    ///  <return>session id as a string</return>
    class function GenerateSessionId: string; static;
    ///  <summary>
    ///    To be called when session ends. The communication channel is closed.
    ///  </summary>
    procedure Close; virtual;
    ///  <summary> Terminates the session </summary>
    ///  <remarks> It is exceptionally used when a session needs to be terminated
    ///    due to the overall process state. All memory is released as session ends
    ///    normally. Calling terminate may induce abnormal termination of
    ///    dependent mid-tier apps</remarks>
    procedure Terminate; virtual;

    /// <summary> Returns true if the session holds data for the given key. </summary>
    function HasData(Key: string): Boolean;
    ///  <summary> Retrieve a value string stored in this session for the given key </summary>
    function GetData(Key: string): string;
    ///  <summary> Store a value string in this session with the given key </summary>
    procedure PutData(Key, Value: string);
    ///  <summary> Remove a value string from this session matching the given key </summary>
    procedure RemoveData(Key: string);

    /// <summary> Returns true if the session holds an Object for the given key. </summary>
    function HasObject(Key: string): Boolean;
    ///  <summary> Retrieve a value Object stored in this session for the given key </summary>
    function GetObject(Key: string): TObject;
    ///  <summary> Store an Object in this session with the given key </summary>
    ///  <remarks> Returns false is the object couldn't be inserted. (Invalid/in-use key) </remarks>
    function PutObject(Key: string; Value: TObject): Boolean;
    ///  <summary> Remove an Object from this session matching the given key </summary>
    function RemoveObject(Key: string; InstanceOwner: Boolean = True): TObject;

    ///  <summary> Returns the miliseconds since last activity </summary>
    function ElapsedSinceLastActvity: Cardinal;
    ///  <summary> Returns the miliseconds remaining before the session expires </summary>
    function ExpiresIn: Cardinal;

    ///  <summary> session duration in miliseconds </summary>
    property LifeDuration: Integer read FDuration write FDuration;
    ///  <summary> session id </summary>
    property Id: NativeInt read GetId;
    ///  <summary> Session status </summary>
    property Status: TDSSessionStatus read GetSessionStatus;
    ///  <summary> For scheduled managed sessions, has the scheduled time</summary>
    property StartDateTime: TDateTime read FStartDateTime;
    ///  <summary>Session's user name, empty for anonymous</summary>
    property UserName: string read FUserName;
    ///  <summary>Session name, immutable</summary>
    property SessionName: string read FSessionName;
    ///  <summary>User roles set through authentication</summary>
    property UserRoles: TStrings read FUserRoles;
    ///  <summary>Cache for storing and retrieving previously executed commands and their results.</summary>
    ///  <remarks>Optionally used in conjunction with REST when a command execution results
    ///     in multiple complex typed result objects. (Streams, Tables, Objects.)
    ///  </remarks>
    property ParameterCache: TDSSessionCache read FCache;
    ///  <summary> Holds a reference to the last result stream sent to a client. </summary>
    ///  <remarks> Used for REST, when sending a result stream back to the client, as there is no
    ///     easy way to tie in with the response sent to the client to know whent he stream is no longer needed.
    ///     The object stored here is a TObject instead of a stream to handle the case where there is an object
    ///     wrapping the stream which needs to be freed with the stream.
    ///  </remarks>
    property LastResultStream: TObject read FLastResultStream write FLastResultStream;
    ///  <summary>Exposes the creator object. It can be the server transport, http service, etc</summary>
    ///  <remarks>It is used usually to distinguish between sessions in a Close event, or to extract more
    ///    metadata about the session context
    ///  </remarks>
    property ObjectCreator: TObject read FCreator write FCreator;
    ///  <summary>Lifetime of session </summary>
    property SessionLifetime: TDSSessionLifetime read FSessionLifetime;
  end;

  /// <summary>Exception raised by TDSSession.</summary>
  TDSSessionError = class(Exception)
  end;

  TDSAuthSession = class(TDSSession)
  private
  protected
    FAuthManager : TDSCustomAuthenticationManager;
  public
    procedure GetAuthRoles(ServerMethod: TDSServerMethod; out AuthorizedRoles,
      DeniedRoles: TStrings); override;
    function Authorize(EventObject: TDSAuthorizeEventObject): Boolean; override;
    ///  <summary> The Authentication manager held by this session. Used for
    ///    user (role) Authorization.
    ///  </summary>
    property AuthManager: TDSCustomAuthenticationManager read FAuthManager;
  end;


  /// <summary>Session class for the REST communication protocol that holds an
  /// instance of an authentication manager.</summary>
  TDSRESTSession = class(TDSAuthSession)
  public
    ///  <summary> Creates an instance of a REST Session, passing in the
    ///    authentication manager to hold a reference to.
    ///  </summary>
    constructor Create(AAuthManager: TDSCustomAuthenticationManager); virtual;
    ///  <summary> Extension of Authenticate to wrap the TCP authentication manager call
    ///  </summary>
    function Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean; override;
  end;

  /// <summary>Session class for the HTTP communication protocol, which acts
  /// like a proxy for the socket channel with the DataSnap server.</summary>
  TDSTunnelSession = class(TDSAuthSession)
  private
    ///  <summary>
    ///    User pointer
    ///  </summary>
    FUserPointer: Pointer;
    ///  <summary>
    ///    User flag
    ///  </summary>
    FUserFlag: Integer;
  protected
    procedure TerminateSession; override;

  public
    constructor Create;  reintroduce;
    destructor Destroy; override;

    ///  <summary>
    ///     To be called when the session starts. The communication channel is
    ///     being setup at thie moment.
    ///  </summary>
    procedure Open; virtual; abstract;
    ///  <summary>
    ///    Reopens the socket channel toward a different location. All required parameters
    ///    are expected to be present in the argument
    ///  </summary>
    ///  <param name="DBXDatasnapProperties">connection properties</param>
    procedure Reopen(DBXDatasnapProperties: TDBXDatasnapProperties); virtual;


    ///  <summary> Reads bytes from communication layer. </summary>
    ///  <remarks>If none are avaiable yet the call may be blocking. </remarks>
    ///  <param name="Buffer">Byte array buffer with capacity to store data</param>
    ///  <param name="Offset">Byte array index from where the read bytes are stored</param>
    ///  <param name="Count">Expected number of bytes to be read. It is assumed there
    ///    is enough capacity in the buffer area for them</param>
    ///  <return>Actual number of bytes being read, -1 on error</return>
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; virtual; abstract;
    ///  <summary> Sends bytes into the communication layer. </summary>
    ///  <remarks> The operation may be blocking until data is consumed by the mid-tier. </remarks>
    ///  <param name="Buffer">Byte array buffer with data to be written</param>
    ///  <param name="Offset">Index from the bytes are written</param>
    ///  <param name="Count">Number of bytes to be written. It is expected that
    ///     the buffer has enough capacity to match the parameter</param>
    ///  <return>Actual number of bytes being written</return>
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; virtual; abstract;

    property UserPointer: Pointer read FUserPointer write FUserPointer;
    property UserFlag: Integer read FUserFlag write FUserFlag;
  end;

  /// <summary>Manages the HTTP session for a remote DataSnap
  /// instance.</summary>
  TDSRemoteSession = class(TDSTunnelSession)
  private
    ///  <summary>
    ///    Communication channel with the actual resources
    ///  </summary>
    FSocketChannel: TDBXSocketChannel;
  public
    constructor Create(DBXDatasnapProperties: TDBXDatasnapProperties);
    destructor Destroy; override;

    procedure Open; override;
    procedure Reopen(DBXDatasnapProperties: TDBXDatasnapProperties); override;
    procedure Close; override;
    procedure Terminate; override;

    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    ///  <summary> Extension of Authenticate to wrap the TCP authentication manager call
    ///  </summary>
    function Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean; override;

    property SocketChannel: TDBXSocketChannel read FSocketChannel write FSocketChannel;
  end;

  /// <summary>Type of user events.</summary>
  TDSSessionEventType = (SessionCreate, SessionClose);

  /// <summary>User event for notification of session events, such as Create and
  /// Terminate.</summary>
  TDSSessionEvent = reference to procedure(Sender: TObject;
                              const EventType: TDSSessionEventType;
                              const Session: TDSSession);

  TDSSessionVisitor = reference to procedure(const Session: TDSSession);

  /// <summary>Implements a singleton that will manage the session
  /// objects.</summary>
  TDSSessionManager = class
  type
    TFactoryMethod = reference to function: TDSSession;

  strict private
    FSessionContainer: TDictionary<string, TDSSession>;
    FListeners: TList<TDSSessionEvent>;

  private
    class var
      FInstance: TDSSessionManager;

    ///  <summary> Returns the session object based on its id
    ///  </summary>
    ///  <param name="SessionId">session identifier</param>
    ///  <return>a session object, nil if not found</return>
    function GetSession(SessionId: string): TDSSession;
    ///  <summary> Returns the tunnel session object based on its id
    ///  </summary>
    ///  <param name="SessionId">session identifier</param>
    ///  <return>tunnel session object, nil if not found or is not a tunnel session</return>
    function GetTunnelSession(SessionId: string): TDSTunnelSession;

    function GetUniqueSessionId: string;

    procedure TerminateSession(session: TDSSession); overload;
    procedure CloseSession(session: TDSSession); overload;

    ///  <summary> Internal function for notifying the registered events
    ///  </summary>
    procedure NotifyEvents(session: TDSSession; EventType: TDSSessionEventType);
    procedure TerminateAllSessions(const ACreator: TObject;
      AAllSessions: Boolean); overload;

  public
    constructor Create;
    destructor Destroy; override;

    function CreateSession<T: TDSSession>(factory: TFactoryMethod;
      ASessionLifetime: TDSSessionLifetime; DoNotify: Boolean = True): T; overload;
    function CreateSession<T: TDSSession>(factory: TFactoryMethod; userName: string): T; overload;
    function CreateSession<T: TDSSession>(factory: TFactoryMethod; userName: string; ASessionLifetime: TDSSessionLifetime): T; overload;
    function CreateSession<T: TDSSession>(factory: TFactoryMethod; DoNotify: Boolean = True): T; overload;

    ///  <summary> Add the given session event to the list of events which gets
    ///     executed when a change occurrs with a session through this manager.
    ///  </summary>
    procedure AddSessionEvent(Event: TDSSessionEvent);
    ///  <summary> Remove the given session event to the list of events which gets
    ///     executed when a change occurrs with a session through this manager.
    ///  </summary>
    ///  <returns> true if successfully removed, false otherwise. </returns>
    function RemoveSessionEvent(Event: TDSSessionEvent): Boolean;

    ///  <summary>Closes the session identified by argument
    ///  </summary>
    ///  <remarks> The session object is freed, no further access to it is expected
    ///  </remarks>
    ///  <param name="SessionId">session identifier</param>
    procedure CloseSession(SessionId: string); overload;
    ///  <summary> Terminates all registered sessions for a given owner. Usually when the owner is taken
    ///    offline or being closed.
    ///  </summary>
    procedure TerminateAllSessions(const ACreator: TObject); overload;
    ///  <summary> Terminates all registered sessions. Usually when the the server is stopped.
    ///  </summary>
    procedure TerminateAllSessions; overload;
    ///  <summary> Iterates over all sessions and invokes the TDSSessionVisitor for each.
    ///  </summary>
    procedure ForEachSession(AVisitor: TDSSessionVisitor);
    ///  <summary> Removes the session from session container and invokes session's Teminate method
    ///  </summary>
    ///  <remarks> Further session access will not be possible
    ///  </remarks>
    ///  <param name="SessionId">session unique name</param>
    procedure TerminateSession(const sessionId: string); overload;
    ///  <summary> Returns number of open sessions
    ///  </summary>
    ///  <returns>number of open session</returns>
    function GetSessionCount: Integer;
    ///  <summary>Removes the session from session container
    ///  </summary>
    ///  <param name="SessionId">session identifier</param>
    function RemoveSession(SessionId: string): TDSSession;
    ///  <summary> Adds all open session keys to parameter container
    ///  </summary>
    ///  <param name="Container">string list</param>
    procedure GetOpenSessionKeys(Container: TStrings); overload;
    procedure GetOpenSessionKeys(Container: TStrings; ACreator: TObject); overload;

    ///  <summary> Returns the Session for the current thread.
    ///  </summary>
    class function GetThreadSession: TDSSession;
    ///  <summary> Sets the given session as the session for the thread calling this function.
    ///  </summary>
    class procedure SetAsThreadSession(Session: TDSSession);
    ///  <summary> Removes any session set to be the session for the current thread
    ///  </summary>
    class procedure ClearThreadSession;

    property Session[id: string]: TDSSession read GetSession;
    property TunnelSession[id: string]: TDSTunnelSession read GetTunnelSession;

    class property Instance: TDSSessionManager read FInstance;
  end;

  /// <summary>Synchronizes the local channel.</summary>
  TDSSynchronizedLocalChannel = class(TDBXLocalChannel)
  private
    FReadSemaphore: TSemaphore;
    FLocalReadSemaphore: TSemaphore;
    FWriteSemaphore: TSemaphore;
    FLocalWriteSemaphore: TSemaphore;
    FTerminated: Boolean;

  public
    constructor Create(const ServerName: string);
    destructor Destroy; override;

    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function WriteLocalData(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;

    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function ReadLocalData(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;

    procedure Terminate;
  end;

  /// <summary>Consumes the remote byte stream produced by a remote source. The
  /// remote source is proxied by a local session instance passed to the
  /// constructor.</summary>
  TDSLocalServer = class(TThread)
  private
    FErrorMsg: string;
    FLocalChannel: TDBXLocalChannel;
    FDBXProtocolHandler: TDBXProtocolHandler;
    FSession: TDSSession;

  protected
    procedure Execute; override;
    ///  <summary> Processes the byte stream as it comes along
    ///  </summary>
    ///  <remarks> The tunnel session is synchronizing the read/write semaphores
    ///  </remarks>
    procedure ConsumeByteStream;

  public
    constructor Create(ALocalChannel: TDBXLocalChannel; AProtocolHandlerFactory: TDSJSONProtocolHandlerFactory;
                           AFilters: TTransportFilterCollection; Session: TDSSession);
    destructor Destroy; override;

    ///  <summary> Returns true if the local server protocol failed at some point</summary>
    ///  <remarks>Error management is passive due to multi-threaded environment. It
    ///    is the responsability of the user thread to use this flag appropriately.
    ///    The error message can be acquired using ErrorMsg property.
    ///  </remarks>
    ///  <returns>true if the communication protocol exprienced an error</returns>
    function HasError: Boolean;
    ///  <summary>Error message when HasError function returns true</summary>
    property ErrorMsg: string read FErrorMsg;
  end;



  /// <summary>Manages the HTTP session for a local DataSnap instance.</summary>
  TDSLocalSession = class(TDSTunnelSession)
  private
    FFilters: TTransportFilterCollection;
    FProtocolHandlerFactory: TDSJSONProtocolHandlerFactory;
    FLocalChannel: TDSSynchronizedLocalChannel;
    FDSLocalServer: TDSLocalServer;

  public
    constructor Create(AFilters: TTransportFilterCollection; AProtocolHandlerFactory: TDSJSONProtocolHandlerFactory);
    destructor Destroy; override;

    procedure Open; override;
    procedure Close; override;
    procedure Terminate; override;

    ///  <summary> Extension of Authenticate to wrap the TCP authentication manager call
    ///  </summary>
    function Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean; override;
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
  end;

  TTunnelSessionEvent = procedure(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>;
                                          var Count: Integer) of object;

  /// <summary>Implements the HTTP tunneling logic.</summary>
  TDSTunnelService = class
  strict private
    FFilters: TTransportFilterCollection;
    FProtocolHandlerFactory: TDSJSONProtocolHandlerFactory;
    FDSHostname: string;
    FDSPort: Integer;
    FHasLocalServer: Boolean;

  private
    FDBXProperties: TDBXDatasnapProperties;
    FOnOpenSession: TTunnelSessionEvent;
    FOnErrorOpenSession: TTunnelSessionEvent;
    FOnCloseSession: TTunnelSessionEvent;
    FOnWriteSession: TTunnelSessionEvent;
    FOnReadSession: TTunnelSessionEvent;
    FOnErrorWriteSession: TTunnelSessionEvent;
    FOnErrorReadSession: TTunnelSessionEvent;
    FDSAuthenticationManager: TDSCustomAuthenticationManager;

  protected
    ///  <summary> True if the current session id signals the session closure
    ///  </summary>
    ///  <return>true if current session should be closed</return>
    class function CanCloseSession(var id: string): Boolean;
    ///  <summary> Creates a tunnel session based on the tunnel creation parameters
    ///  </summary>
    ///  <param name="Session">output tunnel session object</param>
    ///  <param name="RemoteIP">The connecting client's IP address</param>
    procedure CreateSession(out Session: TDSTunnelSession; RemoteIP: string = ''); overload;
    ///  <summary> Creates a tunnel session based on the tunnel creation parameters
    ///  </summary>
    ///  <param name="Session">output tunnel session object</param>
    ///  <param name="ClientInfo">Info about the connecting client</param>
    procedure CreateSession(out Session: TDSTunnelSession; ClientInfo: TDBXClientInfo); overload;
    function GetSession(const SessionId: string): TDSTunnelSession;
    ///  <summary>Default implementation of the OpenSession event</summary>
    ///  <remarks>Event is triggered each time a session is opened successfully.
    ///     Default implementation delegates to OnOpenSession property if set</remarks>
    ///  <param name="Sender">Event sender</param>
    ///  <param name="Session">Tunnel session instance that manages current comunication</param>
    ///  <param name="Content">Bytes content</param>
    ///  <param name="Count">Byte content size (in bytes)</param>
    procedure DefaultOpenSessionEvent(Sender: TObject; Session: TDSTunnelSession;
                                            Content: TArray<Byte>; var Count: Integer);
    ///  <summary>Default implementation of the ErrorOpenSession event</summary>
    ///  <remarks>Event is triggered when a session cannot be opened. Default implementation
    ///    delegates to OnOpenSessionError property if set, otherwise re-throws the
    ///    exception.</remarks>
    ///  <param name="Sender">Event sender</param>
    ///  <param name="Session">Tunnel session instance that manages current comunication</param>
    ///  <param name="Content">Bytes content</param>
    ///  <param name="Count">Byte content size (in bytes)</param>
    procedure DefaultErrorOpenSessionEvent(Sender: TObject; Session: TDSTunnelSession;
                                            Content: TArray<Byte>; var Count: Integer);
    ///  <summary>Default implementation of the CloseSession event</summary>
    ///  <remarks>Event is triggered each time a session is closed successfully.
    ///     Default implementation delegates to OnCloseSession property if set</remarks>
    ///  <param name="Sender">Event sender</param>
    ///  <param name="Session">Tunnel session instance that manages current comunication</param>
    ///  <param name="Content">Bytes content</param>
    ///  <param name="Count">Byte content size (in bytes)</param>
    procedure DefaultCloseSessionEvent(Sender: TObject; Session: TDSTunnelSession;
                                            Content: TArray<Byte>; var Count: Integer);
    ///  <summary>Default implementation of the WriteSession event</summary>
    ///  <remarks>Event is triggered each time a session performs a write operation successfully.
    ///     Default implementation delegates to OnWriteSession property if set</remarks>
    ///  <param name="Sender">Event sender</param>
    ///  <param name="Session">Tunnel session instance that manages current comunication</param>
    ///  <param name="Content">Bytes content</param>
    ///  <param name="Count">Byte content size (in bytes)</param>
    procedure DefaultWriteSessionEvent(Sender: TObject; Session: TDSTunnelSession;
                                            Content: TArray<Byte>; var Count: Integer);
    ///  <summary>Default implementation of the ReadSession event</summary>
    ///  <remarks>Event is triggered each time a session performs a read operation successfully.
    ///     Default implementation delegates to OnReadSession property if set</remarks>
    ///  <param name="Sender">Event sender</param>
    ///  <param name="Session">Tunnel session instance that manages current comunication</param>
    ///  <param name="Content">Bytes content</param>
    ///  <param name="Count">Byte content size (in bytes)</param>
    procedure DefaultReadSessionEvent(Sender: TObject; Session: TDSTunnelSession;
                                            Content: TArray<Byte>; var Count: Integer);
    ///  <summary>Default implementation of the ErrorWriteSession event</summary>
    ///  <remarks>Event is triggered each time a session fails to write data.
    ///     Default implementation delegates to OnErrorWriteSession property if set, otherwise it
    ///     rethrows the exception.
    ///  </remarks>
    ///  <param name="Sender">Event sender</param>
    ///  <param name="Session">Tunnel session instance that manages current comunication</param>
    ///  <param name="Content">Bytes content</param>
    ///  <param name="Count">Byte content size (in bytes)</param>
    procedure DefaultErrorWriteSessionEvent(Sender: TObject; Session: TDSTunnelSession;
                                            Content: TArray<Byte>; var Count: Integer);
    ///  <summary>Default implementation of the ErrorReadSession event</summary>
    ///  <remarks>Event is triggered each time a session fails to write data.
    ///     Default implementation delegates to OnErrorReadSession property if set, otherwise it
    ///     rethrows the exception.
    ///  </remarks>
    ///  <param name="Sender">Event sender</param>
    ///  <param name="Session">Tunnel session instance that manages current comunication</param>
    ///  <param name="Content">Bytes content</param>
    ///  <param name="Count">Byte content size (in bytes)</param>
    procedure DefaultErrorReadSessionEvent(Sender: TObject; Session: TDSTunnelSession;
                                            Content: TArray<Byte>; var Count: Integer);

    procedure SetDSHostname(AHostname: string);
    procedure SetDSPort(APort: Integer);

  public
    ///  <summary> Constructor with hostname and port to write and read the byte stream
    ///  </summary>
    ///  <param name="DSHostname">datasnap server machine</param>
    ///  <param name="DSPort">datasnap server port it listens to</param>
    ///  <param name="AFilters">the filters collection</param>
    ///  <param name="AProtocolHandlerFactory">the protocol handler factory</param>
    constructor Create(DSHostname: string; DSPort: Integer; AFilters: TTransportFilterCollection;
                           AProtocolHandlerFactory: TDSJSONProtocolHandlerFactory); virtual;
    destructor Destroy; override;

    ///  <summary>Pass through of user credentials</summary>
    ///  <param name="userName">user name</param>
    ///  <param name="userPass">user password</param>
    procedure AddUserCredentials(const userName: string; const userPass: string);
    ///  <summary> Terminates all registered sessions. Usually when the server is taken
    ///    offline or being closed.
    ///  </summary>
    procedure TerminateAllSessions;
    ///  <summary> Terminates session with session id among the input parameters
    ///  </summary>
    ///  <remarks> Further session access will not be possible
    ///  </remarks>
    ///  <param name="Params">Parameter collection</param>
    class procedure TerminateSession(const Params: TStrings); overload;
    ///  <summary> Returns number of open sessions
    ///  </summary>
    ///  <returns>number of open session</returns>
    function GetSessionCount: Integer;
    ///  <summary>Closes the session identified by argument
    ///  </summary>
    ///  <remarks> The session object is freed, no further access to it is expected
    ///  </remarks>
    ///  <param name="SessionId">session identifier</param>
    procedure CloseSession(SessionId: string); overload;
    ///  <summary> Adds all open session keys to parameter container
    ///  </summary>
    ///  <param name="Container">string list</param>
    procedure GetOpenSessionKeys(Container: TStrings);

    ///  <summary>
    ///    Initializes the session pointed to by the specified parameter value for 'dss'
    ///    If the value of the 'dss' parameter is 0, then a new session will be created and the
    ///    value for dss in the given params will be replaced.
    ///  </summary>
    function InitializeSession(Params: TStrings; RemoteIP: string = ''): TDSTunnelSession; overload;
    function InitializeSession(Params: TStrings; ClientInfo: TDBXClientInfo): TDSTunnelSession; overload;

    ///  <summary>
    ///    Handles the POST requests. They are assimilated to write operations.
    ///    The response consists in the session id and the actual amount of bytes
    ///    successfully delivered to the destination.
    ///  </summary>
    ///  <param name="Params">HTTP parameters (name=value) that provide the session id
    ///    (dss) and eventually the content size (c). The content is expected to be available
    ///    in the byte stream. A session id zero (0) is equivalent to a new session.
    ///    The code will generate a new session id that will be returned as content
    ///    in the JSON object.
    ///  </param>
    ///  <param name="Content">Byte content to be forwarded to the session's communication channel</param>
    ///  <param name="JsonResponse">Output parameters with the session id and actual data write size.
    ///  <param name="CloseConnection">true if server has to signal client to close the connection</param>
    ///    Upon success the response is: {"response":[[sessionId],[count]]
    ///  </param>
    procedure ProcessPOST(Params: TStrings; Content: TArray<Byte>; out JsonResponse: TJSONValue; out CloseConnection: Boolean);
    ///  <summary>
    ///    Handles the GET requests. They are assimilated to the read operations. The
    ///    response is returned as a byte stream.
    ///  </summary>
    ///  <param name="Params">Request parameters with session id (dss) and expected byte
    ///    count to be read (c).
    ///  </param>
    ///  <param name="Len">Actual number of bytes read</param>
    ///  <param name="CloseConnection">true if server has to signal client to close the connection</param>
    ///  <return>byte stream</return>
    function ProcessGET(Params: TStrings; var Len: Integer; out CloseConnection: Boolean): TStream;
    ///  <summary> Returns true if the request parameters provide user name and paasword
    ///  </summary>
    ///  <returns>true if the request needs authentication</returns>
    function NeedsAuthentication(Params: TStrings): Boolean;
    ///  <summary>Remote host name where the DataSnap Server will process the requests
    ///  </summary>
    property DSHostname: string read FDSHostname write SetDSHostname;
    ///  <summary>Remote DataSnap port that processes the requests</summary>
    property DSPort: Integer read FDSPort write SetDSPort;
    ///  <summary>True if the DataSnap process is in process.</summary>
    ///  <remarks>In process servers have precedence over the remote ones. Hence, if
    ///    property is true DSHostname and DSPort will be ignored.
    ///  </remarks>
    property HasLocalServer: Boolean read FHasLocalServer write FHasLocalServer;
    ///  <summary>Communication filters such as compression or encryption</summary>
    property Filters: TTransportFilterCollection read FFilters write FFilters;
    ///  <summary>Factory that will provide the protocol handler</summary>
    property ProtocolHandlerFactory: TDSJSONProtocolHandlerFactory read FProtocolHandlerFactory
                                                write FProtocolHandlerFactory;
    ///  <summary>
    ///    Event invoked after the tunnel session was open
    ///  </summary>
    property OnOpenSession: TTunnelSessionEvent read FOnOpenSession write FOnOpenSession;
    ///  <summary>
    ///    Event invoked if a session cannot open
    ///  </summary>
    property OnErrorOpenSession: TTunnelSessionEvent read FOnErrorOpenSession write FOnErrorOpenSession;
    ///  <summary> Event invoked before the session is closed
    ///  </summary>
    property OnCloseSession: TTunnelSessionEvent read FOnCloseSession write FOnCloseSession;
    ///  <summary> Event invoked after the data has been written into the tunnel channel
    ///  </summary>
    property OnWriteSession: TTunnelSessionEvent read FOnWriteSession write FOnWriteSession;
    ///  <summary> Event invoked after the data has been read from the tunnel channel
    ///  </summary>
    property OnReadSession: TTunnelSessionEvent read FOnReadSession write FOnReadSession;
    ///  <summary> Event invoked if channel write failed because of connection error
    ///  </summary>
    property OnErrorWriteSession: TTunnelSessionEvent read FOnErrorWriteSession write FOnErrorWriteSession;
    ///  <summary> Event invoked if channel read failed because of connection error or timeout
    ///  </summary>
    property OnErrorReadSession: TTunnelSessionEvent read FOnErrorReadSession write FOnErrorReadSession;
    ///  <summary> Returns number of open sessions
    ///  </summary>
    property SessionCount: Integer read GetSessionCount;
    ///  <summary> The Authentication manager for use with this tunnel service
    ///  </summary>
    property DSAuthenticationManager: TDSCustomAuthenticationManager read FDSAuthenticationManager
                             write FDSAuthenticationManager;

  end;

  /// <summary>Represents the session class for the TCP communication
  /// protocol.</summary>
  TDSTCPSession = class(TDSAuthSession)
  public
    ///  <summary> Creates an instance of a TCP Session, passing in the
    ///    authentication manager to hold a reference to.
    ///  </summary>
    constructor Create(AAuthManager: TDSCustomAuthenticationManager); overload; virtual;
    constructor Create(AAuthManager: TObject); overload; virtual;
    ///  <summary> Extension of Authenticate to wrap the TCP authentication manager call
    ///  </summary>
    function Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean; override;
  end;

implementation

uses
{$IFNDEF POSIX}
  Winapi.ActiveX,
  System.Win.ComObj,
  Winapi.Windows,
{$ELSE}
{$IFNDEF LINUX64}
  Macapi.CoreServices,
{$ENDIF}
{$ENDIF}
  Data.DBXPlatform,
  Data.DBXClientResStrs,
  DataSnap.DSServerResStrs,
  Data.DBXTransportFilter;

ThreadVar
  VDSSession: TDSSession; {Session for the current thread}

const
  QP_DSS      = 'dss';
  QP_COUNT    = 'c';
  DRIVER_NAME = 'Datasnap';

type
    TAnonymousBlock = reference to procedure;

procedure Synchronized(monitor: TObject; proc: TAnonymousBlock);
begin
  TMonitor.Enter(monitor);
  try
    proc;
  finally
    TMonitor.Exit(monitor);
  end;
end;

{TDSTunnelSession}

constructor TDSTunnelSession.Create;
begin
  inherited;
  FUserFlag := 0;
  FUserPointer := nil;
end;

destructor TDSTunnelSession.Destroy;
begin
  inherited;
end;

procedure TDSTunnelSession.Reopen(DBXDatasnapProperties: TDBXDatasnapProperties);
begin
    // do nothing
end;

procedure TDSTunnelSession.TerminateSession;
begin
  inherited;

end;

{TDSRemoteSession}

constructor TDSRemoteSession.Create(DBXDatasnapProperties: TDBXDatasnapProperties);
begin
  inherited Create;

  FSocketChannel := TDBXSocketChannel.Create;
  FSocketChannel.DBXProperties := DBXDatasnapProperties;
end;

destructor TDSRemoteSession.Destroy;
begin
  FreeAndNil(FSocketChannel);
  inherited;
end;

procedure TDSRemoteSession.Open;
begin
  FSocketChannel.Open;
  FStatus := Connected;
end;

  procedure TDSRemoteSession.Reopen(DBXDatasnapProperties: TDBXDatasnapProperties);
  begin
    try
      Close;
    finally
      FreeAndNil(FSocketChannel);
    end;

    FSocketChannel := TDBXSocketChannel.Create;
    FSocketChannel.DBXProperties := DBXDatasnapProperties;

    Open;
  end;

function TDSRemoteSession.Authenticate(
  const AuthenticateEventObject: TDSAuthenticateEventObject;
  connectionProps: TDBXProperties): Boolean;
begin
  inherited;

  {Authentication will be done elsewhere for HTTP}
  exit(True);
end;

procedure TDSRemoteSession.Close;
  begin
    inherited;
    FSocketChannel.Close;
  end;

  procedure TDSRemoteSession.Terminate;
  begin
    inherited;
    FSocketChannel.Terminate;
  end;

  function TDSRemoteSession.Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer;
  begin
    Result := FSocketChannel.Read(Buffer, Offset, Count);
  end;

  function TDSRemoteSession.Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer;
  begin
    Result := FSocketChannel.Write(Buffer, Offset, Count);
  end;

{TDSSynchronizedLocalChannel}

  constructor TDSSynchronizedLocalChannel.Create(const ServerName: string);
  begin
    inherited Create(ServerName);

    FReadSemaphore := TSemaphore.Create(nil, 0, MaxInt, '');
    FLocalReadSemaphore := TSemaphore.Create(nil, 1, MaxInt, '');
    FWriteSemaphore := TSemaphore.Create(nil, 0, MaxInt, '');
    FLocalWriteSemaphore := TSemaphore.Create(nil, 1, MaxInt, '');
    FTerminated := false;
  end;

  destructor TDSSynchronizedLocalChannel.Destroy;
  begin
    FreeAndNil(FReadSemaphore);
    FreeAndNil(FWriteSemaphore);
    FreeAndNil(FLocalReadSemaphore);
    FreeAndNil(FLocalWriteSemaphore);
    inherited;
  end;

  procedure TDSSynchronizedLocalChannel.Terminate;
  begin
    FTerminated := true;

    FLocalWriteSemaphore.Release;
    FLocalReadSemaphore.Release;
    FWriteSemaphore.Release;
    FReadSemaphore.Release;
  end;

  function TDSSynchronizedLocalChannel.Read(const Buffer: TArray<Byte>; const Offset: Integer;
                                               const Count: Integer): Integer;
  var
    status: TWaitResult;
  begin
    status := FReadSemaphore.WaitFor(INFINITE);
    if status = wrError then
      Raise TDBXError.Create(0, Format(SWaitFailure, ['Read']));
    if status = wrTimeout then
      Raise TDBXError.Create(0, Format(SWaitTimeout, ['Read']));
    if FTerminated then
      Raise TDBXError.Create(0, SWaitTerminated);

    Result := inherited Read(Buffer, Offset, Count);

    // if all written data was consumed allow subsequent write local data
    if not HasWriteData then
      FLocalWriteSemaphore.Release
    else
      FReadSemaphore.Release;
  end;

  function TDSSynchronizedLocalChannel.WriteLocalData(const Buffer: TArray<Byte>; const Offset: Integer;
                                                const Count: Integer): Integer;
  var
    status: TWaitResult;
  begin
    if FTerminated then
      Raise TDBXError.Create(0, SWaitTerminated);
    status := FLocalWriteSemaphore.WaitFor(INFINITE);
    if status = wrError then
      Raise TDBXError.Create(0, Format(SWaitFailure, ['WriteLocalData']));
    if status = wrTimeout then
      Raise TDBXError.Create(0, Format(SWaitTimeout, ['WriteLocalData']));
    if FTerminated then
      Raise TDBXError.Create(0, SWaitTerminated);

    Result := inherited WriteLocalData(Buffer, Offset, Count);
    FReadSemaphore.Release;
  end;

  function TDSSynchronizedLocalChannel.Write(const Buffer: TArray<Byte>; const Offset: Integer;
                                                const Count: Integer): Integer;
  var
    status: TWaitResult;
  begin
    status := FLocalReadSemaphore.WaitFor(INFINITE);
    if status = wrError then
      Raise TDBXError.Create(0, Format(SWaitFailure, ['Write']));
    if status = wrTimeout then
      Raise TDBXError.Create(0, Format(SWaitTimeout, ['Write']));
    if FTerminated then
      Raise TDBXError.Create(0, SWaitTerminated);

    Result := inherited Write(Buffer, Offset, Count);
    FWriteSemaphore.Release;
  end;

  function TDSSynchronizedLocalChannel.ReadLocalData(const Buffer: TArray<Byte>; const Offset: Integer;
                                                const Count: Integer): Integer;
  var
    status: TWaitResult;
  begin
    if FTerminated then
      Raise TDBXError.Create(0, SWaitTerminated);
    status := FWriteSemaphore.WaitFor(INFINITE);
    if status = wrError then
      Raise TDBXError.Create(0, Format(SWaitFailure, ['ReadLocalData']));
    if status = wrTimeout then
      Raise TDBXError.Create(0, Format(SWaitTimeout, ['ReadLocalData']));
    if FTerminated then
      Raise TDBXError.Create(0, SWaitTerminated);

    Result := inherited ReadLocalData(Buffer, Offset, Count);

    if not HasReadData then
      FLocalReadSemaphore.Release
    else
      FWriteSemaphore.Release;
  end;

{TDSLocalSession}

  constructor TDSLocalSession.Create(AFilters: TTransportFilterCollection; AProtocolHandlerFactory: TDSJSONProtocolHandlerFactory);
  begin
    inherited Create;

    FFilters := AFilters;
    FProtocolHandlerFactory := AProtocolHandlerFactory;
  end;

  destructor TDSLocalSession.Destroy;
  begin
    FFilters := nil; // no ownership
    FProtocolHandlerFactory := nil; // no ownership

    if not FDSLocalServer.Terminated then
      FDSLocalServer.Terminate;
    FreeAndNil(FDSLocalServer);

    inherited
  end;

  procedure TDSLocalSession.Open;
  var
    RemoteIP: string;
    ClientInfo: TDBXClientInfo;
  begin
    RemoteIP := GetData('RemoteIP');
    if RemoteIP = EmptyStr then
      RemoteIP := 'local';
    FLocalChannel := TDSSynchronizedLocalChannel.Create(RemoteIP);

    ClientInfo.IpAddress := RemoteIP;
    ClientInfo.Protocol := GetData('CommunicationProtocol');
    ClientInfo.AppName := GetData('RemoteAppName');

    FLocalChannel.ChannelInfo.ClientInfo := ClientInfo;

    // start DS local
    FDSLocalServer := TDSLocalServer.Create(FLocalChannel, FProtocolHandlerFactory, FFilters, Self);
    FStatus := Connected;
  end;

function TDSLocalSession.Authenticate(
  const AuthenticateEventObject: TDSAuthenticateEventObject;
  connectionProps: TDBXProperties): Boolean;
begin
  inherited;

  if FAuthManager <> nil then
    exit(FAuthManager.Authenticate(AuthenticateEventObject, connectionProps));

  exit(True);
end;

procedure TDSLocalSession.Close;
  begin
    // stop the DS local
    FStatus := Closed;

    FLocalChannel.Terminate;

    FDSLocalServer.Terminate;

    if not FDSLocalServer.Finished then
      FDSLocalServer.WaitFor;
  end;

  procedure TDSLocalSession.Terminate;
  begin
    Close;
  end;

  function TDSLocalSession.Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer;
  begin
    Result := FLocalChannel.ReadLocalData(Buffer, Offset, Count);
    if (FStatus = Connected) and FDSLocalServer.HasError then
      Raise TDBXError.Create(0, FDSLocalServer.ErrorMsg);
  end;

  function TDSLocalSession.Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer;
  begin
    Result := FLocalChannel.WriteLocalData(Buffer, Offset, Count);
    if (FStatus = Connected) and FDSLocalServer.HasError then
      Raise TDBXError.Create(0, FDSLocalServer.ErrorMsg);
  end;

{TDSLocalServer}

  constructor TDSLocalServer.Create(ALocalChannel: TDBXLocalChannel; AProtocolHandlerFactory: TDSJSONProtocolHandlerFactory;
                           AFilters: TTransportFilterCollection; Session: TDSSession);
  var
    FilterChannel: TDBXFilterSocketChannel;
  begin
    inherited Create(false);

    FSession := Session;

    FLocalChannel := ALocalChannel;

    FilterChannel := TDBXFilterSocketChannel.Create(AFilters);
    FilterChannel.Channel := FLocalChannel;

    FDBXProtocolHandler := AProtocolHandlerFactory.CreateProtocolHandler(FilterChannel);
  end;

  destructor TDSLocalServer.Destroy;
  begin
    FreeAndNil( FDBXProtocolHandler );
    FLocalChannel := nil; // soft reference
  end;

  procedure TDSLocalServer.ConsumeByteStream;
  begin
    try
      FDBXProtocolHandler.HandleProtocol;
    except
      on ex: Exception do
        if not Terminated then
        begin
          FErrorMsg := ex.Message;
          Terminate;
        end;
    end;
  end;

  procedure TDSLocalServer.Execute;
  begin
{$IFNDEF POSIX}
  if CoInitFlags = -1 then
    CoInitializeEx(nil, COINIT_MULTITHREADED)
  else
    CoInitializeEx(nil, CoInitFlags);
{$ENDIF}
    try
      if FSession <> nil then
        TDSSessionManager.SetAsThreadSession(FSession);
      ConsumeByteStream;
    finally
{$IFNDEF POSIX}
    CoUninitialize;
{$ENDIF}
    end
  end;

  function TDSLocalServer.HasError: Boolean;
  begin
    Result := FErrorMsg <> EmptyStr;
  end;

{TDSTunnelService}

  constructor TDSTunnelService.Create(DSHostname: string; DSPort: Integer; AFilters: TTransportFilterCollection;
                           AProtocolHandlerFactory: TDSJSONProtocolHandlerFactory );
  begin
    FDSHostname := DSHostname;
    FDSPort := DSPort;
    FFilters := AFilters;
    FProtocolHandlerFactory := AProtocolHandlerFactory;

    FDBXProperties := TDBXDatasnapProperties.Create(nil);
    FDBXProperties.Values[ TDBXPropertyNames.DriverName ] := DRIVER_NAME;
    FDBXProperties.Values[ TDBXPropertyNames.HostName ] := FDSHostname;
    FDBXProperties.Values[ TDBXPropertyNames.Port ] := IntToStr( FDSPort );
  end;

  destructor TDSTunnelService.Destroy;
  begin
    FreeAndNil(FDBXProperties);

    FFilters := nil; // no ownership
    FProtocolHandlerFactory := nil; // no ownership

    inherited;
  end;

  procedure TDSTunnelService.AddUserCredentials(const userName, userPass: string);
begin
  FDBXProperties.DSAuthUser := userName;
  FDBXProperties.DSAuthPassword := userPass;
end;

class function TDSTunnelService.CanCloseSession(var id: string): Boolean;
  begin
    Result := id.StartsWith('-');
    if Result then
      id := id.Remove(0, 1);
  end;

  procedure TDSTunnelService.CreateSession(out Session: TDSTunnelSession; RemoteIP: string);
  var
    ClientInfo: TDBXClientInfo;
  begin
    ClientInfo.IpAddress := RemoteIP;
    CreateSession(Session, ClientInfo);
  end;

  procedure TDSTunnelService.CreateSession(out Session: TDSTunnelSession; ClientInfo: TDBXClientInfo);
  var
    Len: Integer;
  begin
    Session := TDSSessionManager.Instance.CreateSession<TDSTunnelSession>(function: TDSSession begin
      if HasLocalServer then
        Result := TDSLocalSession.Create(FFilters, FProtocolHandlerFactory)
      else
      begin
        Result := TDSRemoteSession.Create(FDBXProperties);
      end;
      Result.ObjectCreator := self;

      if ClientInfo.IpAddress <> EmptyStr then
        Result.PutData('RemoteIP', ClientInfo.IpAddress);
      if ClientInfo.Protocol <> EmptyStr then
        Result.PutData('CommunicationProtocol', ClientInfo.Protocol);
      if ClientInfo.AppName <> EmptyStr then
        Result.PutData('RemoteAppName', ClientInfo.AppName);
      Result.PutData('ProtocolSubType', 'tunnel');

    end, FDBXProperties.UserName);

    try
      Session.FAuthManager := FDSAuthenticationManager;
      Session.Open;
    except
      on ex: Exception do
        try
          DefaultErrorOpenSessionEvent(ex, Session, nil, Len);
        except
          TDSSessionManager.Instance.RemoveSession(Session.SessionName);
          FreeAndNil(Session);
          raise;
        end;
    end;

    DefaultOpenSessionEvent(self, Session, nil, Len);
  end;

  procedure TDSTunnelService.CloseSession(SessionId: string);
  var
    Session: TDSSession;
    Len: Integer;
  begin
    Session := TDSSessionManager.Instance.Session[SessionId];
    if (Session <> nil) and (Session is TDSTunnelSession) then
    begin
      try
        DefaultCloseSessionEvent(self, TDSTunnelSession(Session), nil, Len);
      finally
        TDSSessionManager.Instance.CloseSession(SessionId);
      end
    end
  end;

  procedure TDSTunnelService.TerminateAllSessions;
  var
    I: Integer;
    openSessions: TStringList;
  begin
    openSessions := TStringList.Create;
    try
      TDSSessionManager.Instance.GetOpenSessionKeys(openSessions, self);
      for I := 0 to openSessions.Count - 1 do
        TDSSessionManager.Instance.TerminateSession(openSessions[I]);
    finally
      openSessions.Free;
    end;
  end;

  class procedure TDSTunnelService.TerminateSession(const Params: TStrings);
  var
    SessionId: string;
  begin
    SessionId := Params.Values[QP_DSS];
    if (SessionId <> '') and (SessionId <> '0') then
      TDSSessionManager.Instance.TerminateSession(SessionId);
  end;

function TDSTunnelService.GetSession(const SessionId: string): TDSTunnelSession;
begin
  Result :=  TDSSessionManager.Instance.TunnelSession[SessionId];
end;

function TDSTunnelService.GetSessionCount: Integer;
  var
    openSessions: TStringList;
  begin
    openSessions := TStringList.Create;
    try
      TDSSessionManager.Instance.GetOpenSessionKeys(openSessions, self);
      Result := openSessions.Count;
    finally
      openSessions.Free;
    end;
  end;

function TDSTunnelService.InitializeSession(Params: TStrings; RemoteIP: string): TDSTunnelSession;
var
  ClientInfo: TDBXClientInfo;
begin
  ClientInfo.IpAddress := RemoteIp;
  Result := InitializeSession(Params, ClientInfo);
end;

function TDSTunnelService.InitializeSession(Params: TStrings; ClientInfo: TDBXClientInfo): TDSTunnelSession;
var
  Session: TDSTunnelSession;
  PSessionId: string;
begin
  Session := nil;

  PSessionId := Params.Values[QP_DSS];
  if PSessionId = '0' then
  begin
    // first time - implicit session creation
    CreateSession(Session, ClientInfo);
    PSessionId := Session.SessionName;
    // save the session id for error processing
    Params.Values[QP_DSS] := PSessionId;
  end
  else
    // get the session object
    Session := GetSession(PSessionId);

  if Session <> nil then
    //associate session and thread
    TDSSessionManager.SetAsThreadSession(Session);

  Result := Session;
end;

function TDSTunnelService.NeedsAuthentication(Params: TStrings): Boolean;
var
  PSessionId: string;
begin
  PSessionId := Params.Values[QP_DSS];
  Result := PSessionId = '0';
end;

procedure TDSTunnelService.GetOpenSessionKeys(Container: TStrings);
begin
    TDSSessionManager.Instance.GetOpenSessionKeys(Container, self);
end;

procedure TDSTunnelService.ProcessPOST(Params: TStrings; Content: TArray<Byte>; out JsonResponse: TJSONValue;
                                                 out CloseConnection: Boolean);
var
    Session: TDSTunnelSession;
    PLen, PSessionId: string;
    Len: Integer;
    JsonParams: TJSONArray;
begin
    // get the session id
    PSessionId := Params.Values[QP_DSS];
    if PSessionId <> '' then
    begin
      // close session request?
      if (Length(Content) >= 5) and (Content[0] = 100) and (Content[1] = 115) and (Content[2] = 115) and (Content[3] = 61) and
        (Content[4] = 45) then //dss=-
      begin
        CloseConnection := True;
        CloseSession(PSessionId);
      end
      else
      begin
        CloseConnection := False;

        //creates or looks-up session for given session ID.
        //content of Params will be replaced for 'dss' if session is created
        Session := InitializeSession(Params);

        if Session <> nil then
        begin
          //associate session and thread
          TDSSessionManager.SetAsThreadSession(Session);

          // number of bytes to be written
          PLen := Params.Values[QP_COUNT];
          if PLen = '' then
            Len := Length(Content)
          else
            Len := StrToInt(PLen);

          try
            // write Len bytes
            Len := Session.Write(Content, 0, Len);
          except
            on ex: Exception do
              DefaultErrorWriteSessionEvent(ex, Session, Content, Len);
          end;

          JsonResponse := TJSONObject.Create;
          JsonParams := TJSONArray.Create;
          TJSONObject(JsonResponse).AddPair(
                            TJSONPair.Create(TJSONString.Create('response'),
                                             JsonParams));
          JsonParams.AddElement(TJSONString.Create(PSessionId));
          JsonParams.AddElement(TJSONNumber.Create(Len));

          //dis-associate the session from the thread
          // Session cleared by TDSApplication.EndDispatch
          // TDSSessionManager.ClearThreadSession;

          DefaultWriteSessionEvent(self, Session, Content, Len);
        end
        else
          raise TDSServiceException.Create(SNoSessionFound);
      end;
    end
    else
      raise TDSServiceException.Create(Format(SNoSessionInRequest, [QP_DSS]));
end;

  function TDSTunnelService.ProcessGET(Params: TStrings; var Len: Integer; out CloseConnection: Boolean): TStream;
  var
    Session: TDSTunnelSession;
    PLen, PSessionId: string;
    Buff: TArray<Byte>;
    Count: Integer;
  begin
    Result := nil;
    // get the session id
    PSessionId := Params.Values[QP_DSS];
    if PSessionId <> '' then
    begin
      // close session request?
      if CanCloseSession(PSessionId) then
      begin
        CloseSession(PSessionId);
        CloseConnection := True;
      end
      else
      begin
        CloseConnection := False;

        //creates or looks-up session for given session ID.
        //content of Params will be replaced for 'dss' if session is created
        Session := InitializeSession(Params);

        if Session <> nil then
        begin
          //associate session and thread
          // TDSSessionManager.SetAsThreadSession(Session);
          Assert(TDSSessionManager.GetThreadSession = Session);

          // number of bytes to be read
          PLen := Params.Values[QP_COUNT];
          if PLen = '' then
            raise TDSServiceException.Create(Format(SNoCountParam, [QP_COUNT]))
          else
            Count := StrToInt(PLen);
          SetLength(Buff, Count);
          Len := Count;
          try
            // read Len bytes
            Len := Session.Read(Buff, 0, Count);
          except
            on ex: Exception do
              DefaultErrorReadSessionEvent(ex, Session, Buff, Len);
          end;

          //dis-associate the session from the thread
          // See TDSHTTPAppliction.EndDispatch
          // TDSSessionManager.ClearThreadSession;

          DefaultReadSessionEvent(self, Session, Buff, Len);

          if Len < Count then
            SetLength(Buff, Len);
          // write then into the stream
          Result := TBytesStream.Create(Buff);
        end
        else
          raise TDSServiceException.Create(SNoSessionFound);
      end;
    end
    else
      raise TDSServiceException.Create(Format(SNoSessionInRequest, [QP_DSS]));
  end;

  procedure TDSTunnelService.DefaultOpenSessionEvent(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>; var Count: Integer);
  begin
    if Assigned(FOnOpenSession) then
      FOnOpenSession(Sender, Session, Content, Count);
  end;

  procedure TDSTunnelService.DefaultErrorOpenSessionEvent(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>; var Count: Integer);
  begin
    if Assigned(FOnErrorOpenSession) then
      FOnErrorOpenSession(Sender, Session, Content, Count)
    else if Sender is Exception then
      raise TDSServiceException.Create(Exception(Sender).Message)
    else
      raise TDSServiceException.Create(SCommunicationErr);
  end;

  procedure TDSTunnelService.DefaultCloseSessionEvent(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>; var Count: Integer);
  begin
    if Assigned(FOnCloseSession) then
      FOnCloseSession(Sender, Session, Content, Count)
  end;

  procedure TDSTunnelService.DefaultWriteSessionEvent(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>; var Count: Integer);
  begin
    if Assigned(FOnWriteSession) then
      FOnWriteSession(Sender, Session, Content, Count)
  end;

  procedure TDSTunnelService.DefaultReadSessionEvent(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>; var Count: Integer);
  begin
    if Assigned(FOnReadSession) then
      FOnReadSession(Sender, Session, Content, Count)
  end;

  procedure TDSTunnelService.DefaultErrorWriteSessionEvent(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>; var Count: Integer);
  begin
    if Assigned(FOnErrorWriteSession) then
      FOnErrorWriteSession(Sender, Session, Content, Count)
    else if Sender is Exception then
      raise TDSServiceException.Create(Exception(Sender).Message)
    else
      raise TDSServiceException.Create(SCommunicationErr);
  end;

  procedure TDSTunnelService.DefaultErrorReadSessionEvent(Sender: TObject; Session: TDSTunnelSession; Content: TArray<Byte>; var Count: Integer);
  begin
    if Assigned(FOnErrorReadSession) then
      FOnErrorReadSession(Sender, Session, Content, Count)
    else if Sender is Exception then
      raise TDSServiceException.Create(Exception(Sender).Message)
    else
      raise TDSServiceException.Create(SCommunicationErr);
  end;

  procedure TDSTunnelService.SetDSHostname(AHostname: string);
  begin
    FDSHostname := AHostname;
    FDBXProperties.Values[ TDBXPropertyNames.HostName ] := FDSHostname;
  end;

  procedure TDSTunnelService.SetDSPort(APort: Integer);
  begin
    FDSPort := APort;
    FDBXProperties.Values[ TDBXPropertyNames.Port ] := IntToStr( FDSPort );
  end;

{ TDSTCPSession }

function TDSTCPSession.Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean;
begin
  inherited;

  if FAuthManager <> nil then
    exit(FAuthManager.Authenticate(AuthenticateEventObject, connectionProps));

  exit(True);
end;

constructor TDSTCPSession.Create(AAuthManager: TObject);
begin
  Create(TDSCustomAuthenticationManager(AAuthManager));
end;

constructor TDSTCPSession.Create(AAuthManager: TDSCustomAuthenticationManager);
begin
  FAuthManager := AAuthManager;
  inherited Create;
end;

{ TDSSession }

function TDSSession.Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean;
begin
  {If FUserName has not yet been assigned then try to populate it from the connection properties.
   Note that the usefulness of this attempt will depend on the extended implementation of this session.}
  if FUserName = '' then
    FUserName := connectionProps.Values[TDBXPropertyNames.DSAuthenticationUser];

  Result := True;
end;

function TDSSession.Authorize(EventObject: TDSAuthorizeEventObject): Boolean;
begin
  Result := True;
end;

procedure TDSSession.CancelScheduledEvent;
begin
  if TDBXScheduler.Instance <> nil then
    TDBXScheduler.Instance.CancelEvent(Id);
end;

procedure TDSSession.CheckTransient;
begin
 case FSessionLifetime of
   TDSSessionLifetime.TimeOut: ;
   TDSSessionLifetime.Request:
     raise TDSSessionError.Create(sOperationNotAllowedOnTransientSession);
 end;
end;

constructor TDSSession.Create(const SessionName: string);
begin
  FSessionName := SessionName;
  Create;
end;

constructor TDSSession.Create(const SessionName: string; const AUser: string);
begin
  FUserName := AUser;
  Create(SessionName);
end;

constructor TDSSession.Create;
var
  LSessionData: TDSSessionData;
begin
  FDuration := 0;
  FStatus := Idle;
  FStartDateTime := Now;
  LSessionData := CreateSessionData;
  LSessionData.SetSession(Self);
  Assert(FSessionData = LSessionData);
  FUserRoles := TStringList.Create;
  FCache := TDSSessionCache.Create;
  MarkActivity;
end;

destructor TDSSession.Destroy;
begin
  if TDSSessionManager.GetThreadSession = Self then
     TDSSessionManager.ClearThreadSession;

  FreeAndNil(FSessionData);
  FreeAndNil(FUserRoles);
  FreeAndNil(FCache);

  if LastResultStream <> nil then
    try
      FreeAndNil(FLastResultStream);
    except
    end;

  inherited;
end;

function TDSSession.CreateSessionData: TDSSessionData;
begin
  Result := TDSSessionDictionaryData.Create;
end;

function TDSSession.ElapsedSinceLastActvity: Cardinal;
begin
  exit( TThread.GetTickCount - FLastActivity );
end;

function TDSSession.ExpiresIn: Cardinal;
var
  Elapsed: Integer;
begin
  Elapsed := Integer(ElapsedSinceLastActvity);
  if (Elapsed >= LifeDuration) then
    Exit(0);

  Result := LifeDuration - Elapsed;
end;

class function TDSSession.GenerateSessionId: string;
begin
  Result := TDSSessionHelper.GenerateSessionId;
end;

procedure TDSSession.CheckSessionData;
begin
  if FSessionData = nil then
     raise TDSSessionError.Create(sNoSessionData);
end;

function TDSSession.HasData(Key: string): Boolean;
begin
  CheckSessionData;
  Result := FSessionData.HasData(Key);
end;

function TDSSession.HasObject(Key: string): Boolean;
begin
  CheckSessionData;
  Result := FSessionData.HasObject(Key);
end;

function TDSSession.GetObject(Key: string): TObject;
begin
  CheckSessionData;
  Result := FSessionData.GetObject(Key);
end;

                                                                                           
function TDSSession.PutObject(Key: string; Value: TObject): Boolean;
begin
  CheckSessionData;
  Result := FSessionData.PutObject(Key, Value);
end;

function TDSSession.RemoveObject(Key: string; InstanceOwner: Boolean): TObject;
begin
  CheckSessionData;
  Result := FSessionData.RemoveObject(Key, InstanceOwner)
end;

procedure TDSSession.GetAuthRoleInternal(ServerMethod: TDSServerMethod;
  AuthManager: TDSCustomAuthenticationManager; out AuthorizedRoles, DeniedRoles: TStrings);
var
  RoleAuth: TRoleAuth;
  MethodInfo: TDSMethodInfo;
  FreeAuthRole: Boolean;
begin
  AuthorizedRoles := nil;
  DeniedRoles := nil;

  FreeAuthRole := true;
  RoleAuth := nil;
  if (ServerMethod <> nil) and (ServerMethod.MethodInfo <> nil) then
  begin
    MethodInfo := ServerMethod.MethodInfo;
    //Try to find a design time auth role
    if (AuthManager <> nil) and (MethodInfo.DSClassInfo <> nil) then
    begin
      //only compute the design time Role Auth once
      if (MethodInfo.AuthRole = nil) or
         (not TRoleAuth(MethodInfo.AuthRole).IsDesignTime) then
      begin
        RoleAuth := TRoleAuth(AuthManager.GetAuthRole(MethodInfo.DSClassInfo.DSClassName, MethodInfo.DSMethodName));

        if (RoleAuth = nil) and (MethodInfo.AuthRole = nil) then
          // Create an empty roleauth if there isn't one from RTTI or authentication manager
          RoleAuth := TRoleAuth.Create(nil, nil, True);
      end;
    end;

    //if no design-time role found, use the one populated through RTI, if one exists
    if RoleAuth = nil then
    begin
      RoleAuth := TRoleAuth(MethodInfo.AuthRole);
      FreeAuthRole := false;
    end;
  end;

  //copy the string lists being sent back, so users can't modify them,
  //and so the TRoleAuth itself can be freed, unless it was a code attribute.
  if RoleAuth <> nil then
  begin
    if RoleAuth.AuthorizedRoles <> nil then
    begin
      AuthorizedRoles := TStringList.Create;
      AuthorizedRoles.AddStrings(RoleAuth.AuthorizedRoles);
    end;
    if RoleAuth.DeniedRoles <> nil then
    begin
      DeniedRoles := TStringList.Create;
      DeniedRoles.AddStrings(RoleAuth.DeniedRoles);
    end;
  end;

  if FreeAuthRole then
    FreeAndNil(Roleauth);
end;

procedure TDSSession.GetAuthRoles(ServerMethod: TDSServerMethod;
  out AuthorizedRoles, DeniedRoles: TStrings);
begin
  AuthorizedRoles := nil;
  DeniedRoles := nil;
end;

function TDSSession.GetData(Key: string): string;
begin
  CheckSessionData;
  Result := FSessionData.GetData(Key);
end;

function TDSSession.GetId: NativeInt;
begin
  exit(IntPtr(Pointer(Self)));
end;

function TDSSession.GetSessionStatus: TDSSessionStatus;
begin
  if ((FStatus = TDSSessionStatus.Active) or
         (FStatus = TDSSessionStatus.Idle) or
         (FStatus = TDSSessionStatus.Connected))
       and (FDuration > 0) and IsIdleMS(FDuration) then
  begin
    FStatus := TDSSessionStatus.Expired;
  end;
  Result := FStatus;
end;

procedure TDSSession.Close;
begin
  FStatus := Closed;
end;

procedure TDSSession.Terminate;
begin
  FStatus := Closed;
end;

function TDSSession.IsValid: Boolean;
begin
  Result := (Status = TDSSessionStatus.Active) or
            (Status = TDSSessionStatus.Idle) or
            (Status = TDSSessionStatus.Connected);
end;

function TDSSession.IsIdle(Seconds: Cardinal): Boolean;
begin
  Result := IsIdleMS(Seconds * 1000);
end;

function TDSSession.IsIdleMS(Milliseconds: Cardinal): Boolean;
begin
  Result := ElapsedSinceLastActvity > Milliseconds;
end;

procedure TDSSession.MarkActivity;
begin
  FStatus := Active;
  FLastActivity := TThread.GetTickCount;
end;


procedure TDSSession.PutData(Key, Value: string);
begin
  CheckSessionData;
  FSessionData.PutData(Key, Value);
end;

procedure TDSSession.RemoveData(Key: string);
begin
  CheckSessionData;
  FSessionData.RemoveData(Key);
end;

function TDSSession.RequiresAuthorization(MethodInfo: TDSMethodInfo): Boolean;
begin
  Result := (MethodInfo <> nil) and
            (MethodInfo.MethodAlias <> 'DSMetadata.GetDatabase') and
             //GetPlatformName is often used to validate a connection, we will allow this call by anyone
            (MethodInfo.MethodAlias <> 'DSAdmin.GetPlatformName');
end;

procedure TDSSession.TerminateInactiveSession;
begin
  if (FDuration > 0) and (IsIdleMS(FDuration)) then
  begin
    try
      TerminateSession;
      TDSSessionManager.Instance.TerminateSession(SessionName);
    except
    end;
  end
  else
    ScheduleInactiveTerminationEvent;
end;


procedure TDSSession.ScheduleInactiveTerminationEvent;
begin
  if FDuration > 0 then
    ScheduleUserEvent(TerminateInactiveSession, FDuration);
end;

procedure TDSSession.ScheduleTerminationEvent;
begin
  if FDuration > 0 then
    ScheduleUserEvent(TerminateSession, FDuration);
end;

procedure TDSSession.ScheduleUserEvent(Event: TDBXScheduleEvent; ElapsedTime: Integer);
begin
  if TDBXScheduler.Instance <> nil then
    TDBXScheduler.Instance.AddEvent(Id, Event, ElapsedTime);
end;

procedure TDSSession.SetSessionName(const sessionId: string);
begin
  FSessionName := sessionId;
end;

procedure TDSSession.SetUserName(const userName: string);
begin
  FUserName := userName;
end;

procedure TDSSession.SetLifetime(Value: TDSSessionLifetime);
begin
  FSessionLifetime := Value;
end;

procedure TDSSession.TerminateSession;
begin
  FStatus := Terminated;
end;

{ TDSSessionManager }

procedure TDSSessionManager.CloseSession(session: TDSSession);
begin
  try
    if Assigned(session) then
    begin
      Assert(session.SessionName <> '');
      // Session should have been removed from the list by now
      Assert(GetSession(session.SessionName) = nil);
      if TDBXScheduler.Instance <> nil then
        TDBXScheduler.Instance.CancelEvent(session.Id);

      NotifyEvents(session, SessionClose);

      session.Close;
    end
  finally
    session.Free;
  end;
end;

procedure TDSSessionManager.AddSessionEvent(Event: TDSSessionEvent);
begin
  if not Assigned(FListeners) then
    FListeners := TList<TDSSessionEvent>.Create;

  System.TMonitor.Enter(FListeners);
  try
    if not FListeners.Contains(Event) then
      FListeners.Add(Event);
  finally
    System.TMonitor.Exit(FListeners);
  end;
end;

function TDSSessionManager.RemoveSessionEvent(Event: TDSSessionEvent): Boolean;
begin
  if Assigned(FListeners) then
  begin
    System.TMonitor.Enter(FListeners);
    try
      exit(FListeners.Remove(Event) > -1);
    finally
      System.TMonitor.Exit(FListeners);
    end;
  end;
  Result := False;
end;

class procedure TDSSessionManager.SetAsThreadSession(Session: TDSSession);
begin
  VDSSession := Session;
end;

class procedure TDSSessionManager.ClearThreadSession;
begin
  VDSSession := nil;
end;

procedure TDSSessionManager.CloseSession(SessionId: string);
var
 session: TDSSession;
begin
  Assert(sessionId <> '');
  session := RemoveSession(SessionId);
  if Assigned(session) then
    CloseSession(session);
end;

constructor TDSSessionManager.Create;
begin
  FSessionContainer := TDictionary<string, TDSSession>.Create;
end;

function TDSSessionManager.CreateSession<T>(factory: TFactoryMethod; userName: string;
  ASessionLifetime: TDSSessionLifetime): T;
begin
  Result := CreateSession<T>(factory, ASessionLifetime, False);
  Result.SetUserName(userName);
  case ASessionLifetime of
    TDSSessionLifetime.TimeOut:
      NotifyEvents(Result, SessionCreate);
    TDSSessionLifetime.Request: ;
  else
    Assert(False);
  end;
end;

function TDSSessionManager.CreateSession<T>(factory: TFactoryMethod; userName: string): T;
begin
  Result := CreateSession<T>(factory, False);
  Result.SetUserName(userName);

  NotifyEvents(Result, SessionCreate);
end;

function TDSSessionManager.CreateSession<T>(factory: TFactoryMethod; ASessionLifetime: TDSSessionLifetime; DoNotify: Boolean): T;
var
  sessionId: string;
begin
  case ASessionLifetime of
    TDSSessionLifetime.TimeOut:
    begin
      TMonitor.Enter(self);
      try
        sessionId := GetUniqueSessionId;
        Result := T(factory);
        Result.SetLifetime(ASessionLifetime);
        Result.SetSessionName(sessionId);
        FSessionContainer.Add(sessionId, Result);
      finally
        TMonitor.Exit(self);
      end;
    end;
    TDSSessionLifetime.Request:
    begin
      Assert(DoNotify = False);
      DoNotify := False;
      Result := T(factory);
      Result.SetLifetime(ASessionLifetime);
    end;
  end;
  if DoNotify then
    NotifyEvents(Result, SessionCreate);
end;

function TDSSessionManager.CreateSession<T>(factory: TFactoryMethod; DoNotify: Boolean): T;
var
  sessionId: string;
begin
  Result := CreateSession<T>(factory, TDSSessionLifetime.TimeOut, DoNotify);
//  TMonitor.Enter(self);
//  try
//    sessionId := GetUniqueSessionId;
//    Result := T(factory);
//    Result.SetSessionName(sessionId);
//    FSessionContainer.Add(sessionId, Result);
//  finally
//    TMonitor.Exit(self);
//  end;
//
//  if DoNotify then
//    NotifyEvents(Result, SessionCreate);
end;

destructor TDSSessionManager.Destroy;
var
  keys: TStrings;
  key: string;
begin
  keys := TStringList.Create;

  try
    GetOpenSessionKeys(keys);

    for key in keys do
    begin
      TerminateSession(key);
    end;
  finally
    FInstance := nil;
    FreeAndNil(FListeners);
    FreeAndNil(FSessionContainer);
    FreeAndNil(keys);

    inherited;
  end;
end;

procedure TDSSessionManager.GetOpenSessionKeys(Container: TStrings);
begin
  Synchronized(self, procedure
  var
      keyEnumerator: TDictionary<string, TDSSession>.TKeyEnumerator;
  begin
      keyEnumerator := FSessionContainer.Keys.GetEnumerator;
      while keyEnumerator.MoveNext do
        Container.Add(keyEnumerator.Current);
      keyEnumerator.Free
  end);
end;

procedure TDSSessionManager.GetOpenSessionKeys(Container: TStrings; ACreator: TObject);
begin
  Synchronized(self, procedure
  var
      valueEnumerator: TDictionary<string, TDSSession>.TValueEnumerator;
  begin
      valueEnumerator := FSessionContainer.Values.GetEnumerator;
      while valueEnumerator.MoveNext do
        if valueEnumerator.Current.ObjectCreator = ACreator then
          Container.Add(valueEnumerator.Current.SessionName);
      valueEnumerator.Free
  end);
end;

function TDSSessionManager.GetSession(SessionId: string): TDSSession;
begin
  TMonitor.Enter(self);
  try
    FSessionContainer.TryGetValue(SessionId, Result);
  finally
    TMonitor.Exit(self);
  end;
end;

function TDSSessionManager.GetSessionCount: Integer;
var
  Count: Integer;
begin
  Synchronized(Self, procedure begin
    Count := FSessionContainer.Count;
  end);
  Result := Count;
end;

class function TDSSessionManager.GetThreadSession: TDSSession;
begin
  Result := VDSSession;
end;

function TDSSessionManager.GetTunnelSession(
  SessionId: string): TDSTunnelSession;
var
  session: TDSSession;
begin
  session := GetSession(SessionId);
  if (session <> nil) and (session is TDSTunnelSession) then
    Result := TDSTunnelSession(session)
  else
    Result := nil;
end;

function TDSSessionManager.GetUniqueSessionId: string;
begin
  // assumes the container is thread secure
  repeat
    Result := TDSSession.GenerateSessionId
  until not FSessionContainer.ContainsKey(Result);
end;

procedure TDSSessionManager.NotifyEvents(session: TDSSession; EventType: TDSSessionEventType);
var
  Event: TDSSessionEvent;
  I, Count: Integer;
  LListeners: TList<TDSSessionEvent>;
begin
  if Assigned(FListeners) then
  begin
    System.TMonitor.Enter(Self);
    try
      LListeners := TList<TDSSessionEvent>.Create;

      //copy the events into a new list, so the FListeners
      //doesn't need to remain locked while calling each event.
      //this prevents deadlocks if events try to remove themselves, for example
      System.TMonitor.Enter(FListeners);
      try
        Count := FListeners.Count - 1;
        for I := 0 to Count do
          LListeners.Add(FListeners.Items[I]);
      finally
        System.TMonitor.Exit(FListeners);
      end;

      try
        Count := LListeners.Count - 1;
        for I := Count downto 0 do
        begin
          Event := LListeners.Items[I];
          try
            if FListeners.Contains(Event) then
              Event(Self, EventType, session);
          except
          end;
        end;
      finally
        FreeAndNil(LListeners);
      end;
    finally
      System.TMonitor.Exit(Self);
    end;
  end;
end;

function TDSSessionManager.RemoveSession(SessionId: string): TDSSession;
var
  session: TDSSession;
begin
  session := nil;
  Synchronized(self, procedure begin
    FSessionContainer.TryGetValue(SessionId, session);
    if session <> nil then
      FSessionContainer.Remove(SessionId);
  end);
  Result := session;
end;

procedure TDSSessionManager.TerminateAllSessions(const ACreator: TObject; AAllSessions: Boolean);
var
  LList: TList<TDSSession>;
  LSession: TDSSession;
begin
  Assert((ACreator <> nil) or AAllSessions);
  LList := TList<TDSSession>.Create;
  try
    ForEachSession(procedure(const Session: TDSSession) begin
      if AAllSessions or (Session.ObjectCreator = ACreator) then
        LList.Add(RemoveSession(Session.SessionName));
    end);
    for LSession in LList do
      TerminateSession(LSession);
  finally
    LList.Free;
  end;
end;

procedure TDSSessionManager.TerminateAllSessions(const ACreator: TObject);
begin
  TerminateAllSessions(ACreator, False);
end;

procedure TDSSessionManager.TerminateAllSessions;
begin
  TerminateAllSessions(nil, True);
end;

procedure TDSSessionManager.ForEachSession(AVisitor: TDSSessionVisitor);
begin
  Synchronized(self, procedure
  var
    valEnumerator: TDictionary<string, TDSSession>.TValueEnumerator;
  begin
    valEnumerator := FSessionContainer.Values.GetEnumerator;
    try
      while valEnumerator.MoveNext do
        AVisitor(valEnumerator.Current);
    finally
      valEnumerator.Free
    end;
  end);
end;

procedure TDSSessionManager.TerminateSession(session: TDSSession);
begin
  try
    if Assigned(session) then
    begin
      // Session should have been removed from the list by now
      Assert(GetSession(session.SessionName) = nil);
      if TDBXScheduler.Instance <> nil then
        TDBXScheduler.Instance.CancelEvent(session.Id);
      session.Terminate;
      NotifyEvents(session, SessionClose);
    end;
  finally
    session.Free;
  end;
end;

procedure TDSSessionManager.TerminateSession(const sessionId: string);
var
  session: TDSSession;
begin
  session := RemoveSession(sessionId);
  if Assigned(session) then
    TerminateSession(session);
end;

{ TDSAuthSession }

procedure TDSAuthSession.GetAuthRoles(ServerMethod: TDSServerMethod;
   out AuthorizedRoles, DeniedRoles: TStrings);
begin
  AuthorizedRoles := nil;
  DeniedRoles := nil;
  if (ServerMethod <> nil) and (ServerMethod.MethodInfo <> nil) then
    if (FAuthManager <> nil) then
      GetAuthRoleInternal(ServerMethod, FAuthManager, AuthorizedRoles, DeniedRoles);
end;

function TDSAuthSession.Authorize(EventObject: TDSAuthorizeEventObject): Boolean;
begin
  if (FAuthManager <> nil) then
  begin
    exit(FAuthManager.Authorize(EventObject))
  end;

  exit(True); //return true if no authentication manager is set
end;

{ TDSRESTSession }

function TDSRESTSession.Authenticate(const AuthenticateEventObject: TDSAuthenticateEventObject; connectionProps: TDBXProperties): Boolean;
begin
  inherited;

  exit(True); //currently, authentication will be done elsewhere for REST
end;

constructor TDSRESTSession.Create(AAuthManager: TDSCustomAuthenticationManager);
begin
  FAuthManager := AAuthManager;
  inherited Create;
end;

{ TDSSessionCache }

function TDSSessionCache.AddItem(Item: TResultCommandHandler): Integer;
var
  LargestId: Integer;
  Id: Integer;
begin
  if (Item = nil) then
    exit(-1);

  TMonitor.Enter(FItems);
  try
    LargestId := -1;
    for Id in FItems.Keys do
    begin
      if FItems.Items[Id] = Item then
        exit(Id);

      if (Id > LargestId) then
        LargestId := Id;
    end;

    Id := LargestId + 1;

    FItems.Add(Id, Item);

    Result := Id;
  finally
    TMonitor.Exit(FItems);
  end;
end;

procedure TDSSessionCache.ClearAllItems(InstanceOwner: Boolean);
var
  Item: TResultCommandHandler;
begin
  if Assigned(FItems) then
  begin
    TMonitor.Enter(FItems);
    try
      if InstanceOwner then
      begin
        for Item in FItems.Values do
          try
            Item.Free;
          except
          end;
      end;
      FItems.Clear;
    finally
      TMonitor.Exit(FItems);
    end;
  end;
end;

constructor TDSSessionCache.Create;
begin
  FItems := TDictionary<Integer, TResultCommandHandler>.Create;
end;

destructor TDSSessionCache.Destroy;
begin
  ClearAllItems(True);
  FreeAndNil(FItems);
  inherited;
end;

function TDSSessionCache.GetItem(ID: Integer): TResultCommandHandler;
var
  Item: TResultCommandHandler;
begin
  Result := nil;
  if FItems.TryGetValue(ID, Item) then
  begin
    Result := Item;
  end;
end;

function TDSSessionCache.GetItemID(Item: TResultCommandHandler): Integer;
var
  Id: Integer;
begin
  Result := -1;
  if (Item <> nil) and Assigned(FItems) then
  begin
    TMonitor.Enter(FItems);
    try
      for Id in FItems.Keys do
      begin
        if FItems.Items[Id] = Item then
          exit(Id);
      end;
    finally
      TMonitor.Exit(FItems);
    end;
  end;
end;

function TDSSessionCache.GetItemIDs: TDSSessionCacheKeys;
var
  Key: Integer;
begin
  Result := TDSSessionCacheKeys.Create;

  TMonitor.Enter(FItems);
  try
    for Key in FItems.Keys do
      Result.Add(Key);
  finally
    TMonitor.Exit(FItems);
    Result.Sort;
  end;
end;

procedure TDSSessionCache.RemoveItem(Item: TResultCommandHandler);
var
  Val: TResultCommandHandler;
  I: Integer;
  IndexToRemove: Integer;
begin
  if (Item = nil) or not Assigned(FItems) then
    Exit;

  IndexToRemove := -1;

  TMonitor.Enter(FItems);
  try
    for I in FItems.Keys do
    begin
      Val := FItems.Items[I];
      if Val = Item then
      begin
        IndexToRemove := I;
      end;
    end;

    if (IndexToRemove > -1) then
      RemoveItem(IndexToRemove, False);
  finally
    TMonitor.Exit(FItems);
  end;
end;

function TDSSessionCache.RemoveItem(ID: Integer; InstanceOwner: Boolean): TResultCommandHandler;
var
  Item: TResultCommandHandler;
begin
  Result := nil;

  TMonitor.Enter(FItems);
  try
    if FItems.TryGetValue(ID, Item) then
    begin
      FItems.Remove(ID);

      if InstanceOwner then
        Item.Free
      else
        Result := Item;
    end;
  finally
    TMonitor.Exit(FItems);
  end;
end;

{ TDSSessionDictionaryData }

constructor TDSSessionDictionaryData.Create;
begin
  inherited;
  FMetaData := TDictionary<string,string>.Create;
  FMetaObjects := TDictionary<string,TObject>.Create;
end;

destructor TDSSessionDictionaryData.Destroy;
var
  LObjEnumerator: TDictionary<string, TObject>.TValueEnumerator;
begin
  LObjEnumerator := FMetaObjects.Values.GetEnumerator;
  try
    while LObjEnumerator.MoveNext do
      try
        LObjEnumerator.Current.Free;
      except
      end;
  finally
    LObjEnumerator.Free
  end;

  FMetaObjects.Free;
  FMetaData.Free;
end;

function TDSSessionDictionaryData.HasData(const AKey: string): Boolean;
begin
  Result := FMetaData.ContainsKey(AnsiLowerCase(AKey));
end;

function TDSSessionDictionaryData.HasObject(const AKey: string): Boolean;
begin
  Result := FMetaObjects.ContainsKey(AnsiLowerCase(AKey));
end;

function TDSSessionDictionaryData.GetData(const AKey: string): string;
var
  LValue: string;
begin
  if (FMetaData.TryGetValue(AnsiLowerCase(AKey), LValue)) then
    exit(LValue);

  Result := '';
end;

procedure TDSSessionDictionaryData.CheckTransient;
begin
  if Session <> nil then
    Session.CheckTransient;
end;

procedure TDSSessionDictionaryData.PutData(const AKey, LValue: string);
var
  LLowerKey: string;
begin
  CheckTransient;
  LLowerKey := AnsiLowerCase(AKey);
  FMetaData.Remove(LLowerKey);
  FMetaData.Add(LLowerKey, LValue);
end;

function TDSSessionDictionaryData.PutObject(const AKey: string;
  AValue: TObject): Boolean;
begin
  CheckTransient;
  Result := True;
                                                                                        
  if not HasObject(AKey) then
    FMetaObjects.Add(AnsiLowerCase(AKey), AValue)
  else
    Exit(False);
end;

procedure TDSSessionDictionaryData.RemoveData(const AKey: string);
begin
  CheckTransient;
  FMetaData.Remove(AnsiLowerCase(AKey));
end;

function TDSSessionDictionaryData.RemoveObject(const AKey: string;
  AInstanceOwner: Boolean): TObject;
var
  LVal: TObject;
begin
  CheckTransient;
  Result := nil;

  if HasObject(AKey) then
  begin
    LVal := GetObject(AKey);
    FMetaObjects.Remove(AnsiLowerCase(AKey));

    if AInstanceOwner then
      FreeAndNil(LVal)
    else
      Result := LVal;
  end;
end;

function TDSSessionDictionaryData.GetObject(const AKey: string): TObject;
begin
  if (FMetaObjects.TryGetValue(AnsiLowerCase(AKey), Result)) then
    Exit;

  Result := nil;
end;

{ TDSSessionData }

constructor TDSSessionData.Create;
begin
end;

procedure TDSSessionData.SetSession(const ASession: TDSSession);
begin
  if FDSSession <> nil then
    FDSSession.FSessionData := nil;
  FDSSession := ASession;
  if FDSSEssion <> nil then
    FDSSession.FSessionData := Self;
end;

initialization
  Randomize;
  TDSSessionManager.FInstance := TDSSessionManager.Create;

finalization
  TDSSessionManager.FInstance.Free;

end.
