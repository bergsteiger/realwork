{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSCommonServer;

interface

uses
  System.JSON,
  System.Classes,
  Data.DBXCommon,
  Data.DBXCommonTable,
  Data.DBXMessageHandlerCommon,
  Data.DBXMessageHandlerServer,
  Data.DBXPlatform,
  Data.DBXSqlScanner,
  Data.DBXTransport,
  Datasnap.DSCommonProxy,
  Datasnap.DSCommonTable,
  Datasnap.DSPlatform,
  Datasnap.DSReflect,
  System.SysUtils,
  System.Rtti;

type
  TDSCustomServer = class;
  TDSErrorEventObject = class;
  TDSConnectEventObject = class;
  TDSPrepareEventObject = class;
  TDSAuthorizeEventObject = class;
  TDSAuthenticateEventObject = class;
  TDSServerComponent = class;
  TDSCustomServerClass = class;
  TDSServerConnection = class;
  TDSServerConnectionHandler = class;
  TDSServerMethod = class;
  TDSServerMethodProvider = class;
  TDSServerTransport = class;
  TInstanceProviderItem = class;

  
  TDSClassInfo = class
  public
    destructor Destroy; override;
    procedure Close;
  private
    FPackageName: string;
    FClassName: string;
    FUnitName: string;
    FRoleName: string;
    FLifeCycle: string;
    FDsClass: TDSClass;
    FAdminClass: Boolean;
    FServerClass: TDSCustomServerClass;
  public
    property DSClassName: string read FClassName write FClassName;
    property DSClass: TDSClass read FDsClass write FDsClass;
    property LifeCycle: string read FLifeCycle write FLifeCycle;
    property PackageName: string read FPackageName write FPackageName;
    property RoleName: string read FRoleName write FRoleName;
    property CustomAdminClass: Boolean read FAdminClass write FAdminClass;
    property ServerClass: TDSCustomServerClass read FServerClass write FServerClass;
    property DSUnitName: string read FUnitName write FUnitName;
  end;

  TDSConfiguration = class
  public
    function CopyConfiguration: TDSConfiguration;
  protected
    function GetClassTable: TDBXTable;
    procedure SetClassTable(const Classes: TDBXTable);
    function GetMethodTable: TDBXTable;
    procedure SetMethodTable(const Methods: TDBXTable);
  private
    procedure CreateClassTable;
    procedure CreateMethodTable;
  private
    FClassTable: TDBXTable;
    FMethodTable: TDBXTable;
  public
    property ClassTable: TDBXTable read GetClassTable write SetClassTable;
    property MethodTable: TDBXTable read GetMethodTable write SetMethodTable;
  end;

  TDSCustomAdmin = class(TDBXServerComponent)
  public
    constructor Create; overload; override;
    constructor Create(AOwner: TComponent); overload; override;
    function GetDSServerName: string; override;
  protected
    function GetDBXContext: TDBXContext;
    procedure SetServerConnection(const Con: TDSServerConnectionHandler);
  protected
    FServer: TDSCustomServer;
    FServerCon: TDSServerConnectionHandler;
  public
    property DBXContext: TDBXContext read GetDBXContext;
    property ServerConnection: TDSServerConnectionHandler write SetServerConnection;
  end;

  TDSMethodInfo = class
  public
    constructor Create; virtual;
    destructor Destroy; override;
  protected
    procedure SetMethodAlias(const MethodAlias: string);
    function GetDSMethod: TDSMethod;
  private
    FMethodAlias: string;
    FClassInfo: TDSClassInfo;
    FDsMethod: TDSMethod;
    FRoleName: string;
    FMethodName: string;
    FSearchName: string;
    FAuthRole: TObject; // TRoleAuth;
    procedure SetAuthRole(ARoleAuth: TObject);
  public
    property DSClassInfo: TDSClassInfo read FClassInfo write FClassInfo;
    property MethodAlias: string read FMethodAlias write SetMethodAlias;
    property SearchName: string read FSearchName;
    property DSMethodName: string read FMethodName write FMethodName;
    property RoleName: string read FRoleName write FRoleName;
    property DSMethod: TDSMethod read GetDSMethod write FDsMethod;
    ///  <summary>user authoring attribute</summary>
    ///  <remarks>When setting a value, the previously held value will be destroyed.</remarks>
    property AuthRole: TObject read FAuthRole write SetAuthRole;
  end;

  /// <summary>Provides administrative built-in server methods.</summary>
  DSAdmin = class(TDSCustomAdmin)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    
    /// <summary> Provide a unique name for the platform of the server
    /// </summary>
    function GetPlatformName: string;
    
    /// <summary> Releases resources allocated for parameters of previous server method
    /// </summary>
    /// <returns>true if all allocated resources were freed; If a deallocation fails
    ///   then false is returned - this is not stopping the deallocation of the
    ///   rest of them. </returns>
    function ClearResources: Boolean;
    
    /// <summary> Provide a collection of all platform specific packages or assemblies.
    /// </summary>
    /// <returns>a <see cref="TDSPackageEntity"/> as a <see cref="TDBXReader"/> collection of all platform specific
    ///  packages or assemblies.</returns>
    function FindPackages: TDBXReader;
    
    /// <summary> Find all classes for a given package with class name pattern.
    /// </summary>
    /// <param name="packageName">name of package to search.  Set to null to search all packages.  May be ignored on some platforms.</param>
    /// <param name="classPattern">if not null, all classes that have this string in their name will be selected.</param>
    /// <returns>a collection of <see cref="TDSClassEntity"/> as a <see cref="TDBXReader"/>.</returns>
    function FindClasses(const PackageName: string; const ClassPattern: string): TDBXReader;
    
    /// <summary> Find public methods for a class.
    /// </summary>
    /// <param name="packageName">name of package to search.  Set to null to search all packages.  May be ignored on some platforms.</param>
    /// <param name="classPattern">if not null, all classes that have this string in their name will be selected.</param>
    /// <param name="methodPattern">if not null, all methods that have this string in their name will be selected.</param>
    /// <returns>a collection of <see cref="TDSMethodEntity"/> as a <see cref="TDBXReader"/>.</returns>
    function FindMethods(const PackageName: string; const ClassPattern: string; const MethodPattern: string): TDBXReader;
    
    /// <summary>
    /// </summary>
    /// <param name="classReader">collection of <see cref="TDSClassEntity"/> as a <see cref="TDBXReader"/> that
    ///  with server methods to register with this server.</param>
    procedure CreateServerClasses(const ClassReader: TDBXReader);
    
    /// <summary>
    /// </summary>
    /// <param name="classReader">collection of <see cref="TDSClassEntity"/> as a <see cref="TDBXReader"/> to be
    ///  dropped from the server.</param>
    procedure DropServerClasses(const ClassReader: TDBXReader);
    
    /// <summary> Register server methods with the server so they can be called from a client.
    /// </summary>
    /// <param name="methodReader">collection <see cref="TDSMethodEntity"/> as a <see cref="TDBXReader"/> containing
    ///  server methods to register with the server.</param>
    procedure CreateServerMethods(const MethodReader: TDBXReader);
    
    /// <summary> Unregister server methods from the server.
    /// </summary>
    /// <param name="methodReader">collection of <see cref="TDSMethodEntity"/> as a <see cref="TDBXReader"/> containing
    ///  server methods to be unregistered from the server.</param>
    procedure DropServerMethods(const MethodReader: TDBXReader);
    
    /// <summary> Provide a collection of classes registered with the server.
    /// </summary>
    /// <returns>list of <see cref="TDSClassEntity"/> as a <see cref="TDBXReader"/> containing classes registered with the server.</returns>
    function GetServerClasses: TDBXReader;
    
    /// <summary> Returns the list of server classes as a JSONArray.
    /// </summary>
    /// <remarks> 
    ///  If no classes are available the array will be empty.
    ///  
    /// </remarks>
    /// <returns>list of server classes exposing DS methods: ["ClassName", ...]</returns>
    function ListClasses: TJSONArray;
    
    /// <summary> Returns the description of a given server class.
    /// </summary>
    /// <remarks> The JSON object content is:
    ///    {'className':{'LifeCycle':'xyz','RoleName':'abc','methods':['method1',...]}}
    ///  In case the server does not expose the given class name appends:
    ///    {'className':null}
    ///    
    /// </remarks>
    /// <param name="className">- server class name, nor null or empty</param>
    /// <returns>class description</returns>
    function DescribeClass(const ClassName: string): TJSONObject;
    
    /// <summary> Returns the list of methods a class exposes.
    /// </summary>
    /// <remarks> 
    ///  If no methods are exposed to DS the list will be empty. The order is non-determined.
    ///  
    /// </remarks>
    /// <param name="className">- server class name, nor null or empty</param>
    /// <returns>method list ["MethodName", ...]</returns>
    function ListMethods(const ClassName: string): TJSONArray;
    
    /// <summary> Returns the method meta data in a JSON object
    ///  
    ///  The object has the following structure: {'methodName':{parameterSignature}}.
    /// </summary>
    /// <remarks> If the method cannot be found
    ///  then the result is {'methodName':null}.
    ///  
    ///  Each parameter signature is a JSON pair formed by direction and data type.
    ///  The directions are: In, InOut, Out and Return
    ///  
    /// </remarks>
    /// <param name="serverMethodName">- server class method name</param>
    /// <returns>method meta data</returns>
    function DescribeMethod(const ServerMethodName: string): TJSONObject;
    
    /// <summary> Provide a collection containing methods registered with the server
    /// </summary>
    function GetServerMethods: TDBXReader;
    
    /// <summary> Provide a collection containing parameters for methods registered with the server
    /// </summary>
    function GetServerMethodParameters: TDBXReader;
    
    /// <summary> This method associates a server side database connection with a client connection.
    /// </summary>
    /// <remarks> This provides client access to all database drivers installed on the server.
    ///  If this method called from the client, the connection is
    ///  not actually returned to the client.  Instead, all sql and sql stored procedures
    ///  called by the client will be executed against this connection.
    ///  This connection will be closed automatically when the client connection is closed.
    ///  If this method is called more than once by a single client connection, the secondary
    ///  invocations will close the prior database connection.
    /// </remarks>
    /// <param name="newConName">name of a connection to</param>
    /// <returns><see cref="TDBXConnection"/> instance.</returns>
    function GetConnection(const NewConName: string): TDBXConnection;

    /// <summary> This method provides a row of information on all available server side connections.
    /// </summary>
    /// <returns>A reader with the columns specified in <see cref="TDSConnectionColumns"/></returns>
    function GetDatabaseConnectionProperties: TDBXReader;
  private
    FCon: TDBXConnection;
    FConName: string;
  end;

  TDSCustomServer = class abstract(TComponent)
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure GetServerClassList(const List: TDBXArrayList);
    procedure RemoveServerComponent(const AComponent: TDSServerComponent);
    procedure AddServerComponent(const AComponent: TDSServerComponent);
    procedure Stop; virtual;

    /// <summary> Start the server
    /// </summary>
    procedure Start; virtual;
    procedure GetServerClasses(const ServerCon: TDSServerConnectionHandler; const Classes: TDSClassEntity); overload;

    /// <summary> Delegate for TDSServerMethodProvider.getServerClasses(JSONArray)
    /// </summary>
    procedure GetServerClasses(const Container: TJSONArray); overload;

    /// <summary> Delegate for TDSServerMethodProvider.getServerClass(String, JSONObject)
    /// </summary>
    procedure GetServerClass(const ClassName: string; const Container: TJSONObject);

    /// <summary> Delegate for TDSServerMethodProvider#getServerMethods(String, JSONArray)
    /// </summary>
    procedure GetServerMethods(const ClassName: string; const Container: TJSONArray); overload;

    /// <summary> Delegate for TDSServerMethodProvider#getServerMethod(String, String, JSONObject)
    /// </summary>
    procedure GetServerMethod(const ServerMethodName: string; const Container: TJSONObject);
    procedure CreateServerClasses(const Classes: TDSClassEntity);
    procedure DropServerClasses(const Classes: TDSClassEntity);
    procedure GetServerMethods(const ServerCon: TDSServerConnectionHandler; const Methods: TDSMethodEntity); overload;
    procedure GetServerMethodParameters(const ServerCon: TDSServerConnectionHandler; const Parameters: TDSMethodParametersEntity);
    procedure CreateServerMethods(const Methods: TDSMethodEntity);
    procedure DropServerMethods(const Methods: TDSMethodEntity);
    function GetServerConnection(const Properties: TDBXProperties): TDBXConnection; virtual; abstract;
  protected
    class function FindCustomServer(const Name: string): TDSCustomServer; static;
    function GetClassTable: TDBXTable;
    procedure SetClassTable(const Classes: TDBXTable);
    function GetMethodTable: TDBXTable;
    procedure SetMethodTable(const Methods: TDBXTable);
    procedure Connecting(const ConnectEventObject: TDSConnectEventObject); virtual; abstract;
    procedure Disconnecting(const ConnectEventObject: TDSConnectEventObject); virtual; abstract;
    procedure Preparing(const PrepareEventObject: TDSPrepareEventObject); virtual; abstract;
    procedure Error(const ErrorEventObject: TDSErrorEventObject); virtual; abstract;
  private
    procedure StartTransports;
    procedure StopTransports;
  protected
    FDbxContext: TDBXContext;
    /// <summary> Run necessary code before transport layer stops</summary>
    procedure TransportStopping(const Sender: TDSServerTransport); virtual;
  private
    FStarted: Boolean;
    FConfig: TDSConfiguration;
    FServerMethodProvider: TDSServerMethodProvider;
    FComponentList: TDBXArrayList;
    FHideDSAdmin: Boolean;
  public
    property Started: Boolean read FStarted;
    property ClassTable: TDBXTable read GetClassTable write SetClassTable;
    property MethodTable: TDBXTable read GetMethodTable write SetMethodTable;
    property ServerMethodProvider: TDSServerMethodProvider read FServerMethodProvider;
    property HideDSAdmin: Boolean read FHideDSAdmin write FHideDSAdmin;
    property DbxContext: TDBXContext read FDbxContext;
  end;

  TDSDefaultCommandHandler = class(TDBXCommandHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXCommandHandler);
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    destructor Destroy; override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  private
    FServerCon: TDSServerConnectionHandler;
    FServerMethod: TDSServerMethod;
    FActiveStreamerRowList: TDBXActiveTableReaderList;
    FNextHandler: TDBXCommandHandler;
  public
    property ServerCon: TDSServerConnectionHandler write FServerCon;
  end;

  TDSDefaultDatabaseConnectionHandler = class(TDBXConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const Con: TDSServerConnectionHandler; const ANextHandler: TDBXConnectionHandler);
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    function DbxBeforeRequest: Boolean; override;
    procedure DbxErrorMessage(const ErrorMessage: TDBXErrorMessage); override;
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  protected
    function GetProductName: string; override;
  private
    FServerCon: TDSServerConnectionHandler;
    FNextHandler: TDBXConnectionHandler;
  end;

  TDSEventObject = class
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
  private
    FDbxContext: TDBXContext;
    FTransport: TDSServerTransport;
    FServer: TDSCustomServer;
    FDbxConnection: TDBXConnection;
    FServerConnectionHandler: TDSServerConnectionHandler;
  public
    property DbxContext: TDBXContext read FDbxContext;
    property Transport: TDSServerTransport read FTransport;
    property Server: TDSCustomServer read FServer;
    property DbxConnection: TDBXConnection read FDbxConnection;
    property ServerConnectionHandler: TDSServerConnectionHandler read FServerConnectionHandler;
  end;

  TDSErrorEventObject = class(TDSEventObject)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
  private
    FError: Exception;
  public
    
    /// <summary> Provide an Exception instance of the error.
    /// </summary>
    /// <returns>Exception instance of the error.</returns>
    property Error: Exception read FError write FError;
  end;

  
  /// <summary>Is an event object that is provided to an event handler that
  /// destroys an instance for a server class.</summary>
  TDSDestroyInstanceEventObject = class(TDSEventObject)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
  private
    FServerClassInstance: TObject;
  public
    
    /// <summary> 
    ///  Provide an instance of the server class that needs to be destroyed by the event handler.
    /// </summary>
    /// <returns>instance of the server class that needs to be destroyed by the event handler.</returns>
    property ServerClassInstance: TObject read FServerClassInstance write FServerClassInstance;
  end;

  
  /// <summary>Event object provided to an event handler that creates an
  /// instance for a server class.</summary>
  TDSCreateInstanceEventObject = class(TDSEventObject)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
  private
    FServerClassInstance: TObject;
  public
    
    /// <summary> 
    ///  Provide an instance of the server class created by the event handler.
    /// </summary>
    /// <returns>instance of the server class created by the event handler.</returns>
    property ServerClassInstance: TObject read FServerClassInstance write FServerClassInstance;
  end;

  
  /// <summary> 
  ///  Event object provided before a client connects to the server.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSConnectEventObject = class(TDSEventObject)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const AChannelInfo: TDBXChannelInfo; const ADbxConnection: TDBXConnection; const AConnectProperties: TDBXProperties);
  private
    FConnectProperties: TDBXProperties;
    FChannelInfo: TDBXChannelInfo;
  public
    
    /// <summary> Provide connection properties specified by the client.
    /// </summary>
    /// <returns>connection properties specified by the client.</returns>
    property ConnectProperties: TDBXProperties read FConnectProperties write FConnectProperties;
    
    /// <summary> Provide transport specific information from the transport implementation.
    /// </summary>
    /// <returns>transport specific information from the transport implementation.</returns>
    property ChannelInfo: TDBXChannelInfo read FChannelInfo;
  end;

  TDSInstanceProvider = class abstract
  public
    function GetInstance(const ServerCon: TDSServerConnectionHandler; const ClassInfo: TDSClassInfo): TObject; virtual; abstract;
  end;

  TDSHashtableInstanceProvider = class(TDSInstanceProvider)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
    destructor Destroy; override;
    function GetInstance(const ServerCon: TDSServerConnectionHandler; const ClassInfo: TDSClassInfo): TObject; override;
  private
    FInstanceTable: TDBXObjectStore;
    FList: TInstanceProviderItem;
    FDestroyInstanceEventObject: TDSDestroyInstanceEventObject;
  end;

  
  /// <summary>DataSnap implementation of a subset of
  /// TDBXMetaDataCommands.</summary>
  DSMetadata = class(TDSCustomAdmin)
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create; overload; override;
    
    /// <summary> Implementation of <c>TDBXMetaDataCommands.GetProcedures</c> metadata command.
    /// </summary>
    /// <remarks> This implementation will return all registered server methods.
    ///  If the DataSnap server was connected with a <c>TDBXPropertyNames.ServerConnection</c>
    ///  property specified, the stored procedures from the server connection will be included
    ///  in the returned result.
    /// </remarks>
    /// <param name="procedureNamePattern">An empty string selects all procedures.</param>
    /// <param name="procedureType">If an empty string is specified, both procedures and functions will be
    ///  returned.  To select just procedures, specify PROCEDURES.  To select just functions, specify
    ///  FUNCTIONS.</param>
    /// <returns>A reader with the columns specified in the <c>TDBXProceduresColumns</c> class.</returns>
    function GetProcedures(const ProcedureNamePattern: string; const ProcedureType: string): TDBXReader;
    
    /// <summary> Implementation of <c>TDBXMetaDataCommands.GetProcedureParameters</c> metadata command.
    /// </summary>
    /// <remarks> This implementation will return parameter information for all registered server methods.
    ///  If the DataSnap server was connected with a <c>TDBXPropertyNames.ServerConnection</c>
    ///  property specified, the stored procedures from the server connection will also be included
    ///  in the returned result.
    /// </remarks>
    /// <param name="procedureNamePattern">An empty string selects parameters for all procedures.</param>
    /// <returns>A reader with the columns specified in the <c>TDBXProcedureParametersColumns</c> class.</returns>
    function GetProcedureParameters(const ProcedureNamePattern: string): TDBXReader;
    
    /// <summary> Implementation of <c>TDBXMetaDataCommands.GetDatabase</c> metadata command.
    /// </summary>
    /// <remarks> This implementation is used when a DataSnap server is connected to without
    ///  specifying the <c>TDBXPropertyNames.ServerConnection</c> property.
    /// </remarks>
    /// <returns>A single row with database specific metadata.</returns>
    function GetDatabase: TDBXReader;
  end;

  /// <summary>Implements event objects provided before a server method is
  /// prepared.</summary>
  TDSServerMethodEventObject = class(TDSEventObject)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
  private
    FMethodAlias: string;
    FServerClass: TDSCustomServerClass;
    FMethodInstance: TObject;
  public

    /// <summary> Provide reference to the <see cref="TDSCustomServerClass"/> instance of the method being prepared.
    /// </summary>
    /// <remarks>
    /// </remarks>
    /// <returns>reference to the <see cref="TDSCustomServerClass"/> instance of the method being prepared.</returns>
    property ServerClass: TDSCustomServerClass read FServerClass write FServerClass;

    /// <summary> Provide the name of the server method.
    /// </summary>
    /// <returns>the name of the server method.</returns>
    property MethodAlias: string read FMethodAlias;
    /// <summary> Provide the instance of the server methods class.
    /// </summary>
    /// <returns>reference to the server methods class instance.</returns>
    property MethodInstance: TObject read FMethodInstance;
  end;

  /// <summary>Implements event objects provided to server method
  /// events.</summary>
  TDSServerMethodUserEventObject = class(TDSServerMethodEventObject)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
    destructor Destroy; override;
  private
    FUserRoles: TStrings;
    FAuthorizedRoles: TStrings;
    FDeniedRoles: TStrings;
    FUserName: string;
    function GetSessionUserName: string;
  public
    /// <summary> Provide the user name associated with the session.
    /// </summary>
    /// <returns>reference to the user name.</returns>
    property UserName: string read GetSessionUserName;
    /// <summary> Provides the role names associated with this user
    /// </summary>
    /// <returns>reference to a user's role list</returns>
    property UserRoles: TStrings read FUserRoles;
    ///  <summary> List of roles which are authorized to access the construct annotated with this attribute
    ///  </summary>
    property AuthorizedRoles : TStrings read FAuthorizedRoles;
    ///  <summary> List of roles which are NOT authorized to access the construct annotated with this attribute.
    ///  </summary>
    ///  <remarks> Unauthorized access with one of these roles will result in an exception being thrown.
    ///  </remarks>
    property DeniedRoles : TStrings read FDeniedRoles;
  end;


  /// <summary>
  ///  Event object provided before a server method is prepared.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSPrepareEventObject = class(TDSServerMethodUserEventObject)

  end;

  /// <summary>
  ///  Event object provided before a server method is authorized.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSAuthorizeEventObject = class(TDSServerMethodUserEventObject)

  end;

  /// <summary>
  ///  Event object provided before a user is authenticated.
  /// </summary>
  /// <remarks>
  /// </remarks>
  TDSAuthenticateEventObject = class(TDSEventObject)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
  end;

  TDSServerCommand = class(TDBXCommand)
  public
    constructor Create(const Context: TDBXContext; const AServerCon: TDSServerConnection; const AConHandler: TDSServerConnectionHandler);
  protected
    procedure DerivedOpen; override;
    function CreateParameterRow: TDBXRow; override;
    procedure DerivedPrepare; override;
    function DerivedExecuteQuery: TDBXReader; override;
    procedure DerivedExecuteUpdate; override;
    procedure DerivedClose; override;
    function DerivedGetNextReader: TDBXReader; override;
    function GetRowsAffected: Int64; override;
    procedure SetRowSetSize(const RowSetSize: Int64); override;
    procedure SetMaxBlobSize(const MaxBlobSize: Int64); override;
  private
    procedure Execute;
  private
    FConHandler: TDSServerConnectionHandler;
    FServerCon: TDSServerConnection;
    FRowsAffected: Int64;
    FServerParameterList: TDBXParameterList;
  end;

  TDSServerCommandHandler = class(TDBXCommandHandler)
  public
    constructor Create(const ADbxContext: TDBXContext);
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  end;

  TDSServerComponent = class abstract(TComponent)
  public
    constructor Create(AOwner: TComponent); override;
    procedure Start; virtual;
    procedure Stop; virtual;
  protected
    function GetServer: TDSCustomServer; virtual;
    procedure SetServer(const AServer: TDSCustomServer); virtual;
  private
    FServer: TDSCustomServer;
  public
    property Server: TDSCustomServer read GetServer write SetServer;
  end;

  TDSCustomServerClass = class abstract(TDSServerComponent)
  public
    constructor Create(AOwner: TComponent); override;
  protected
    function GetDSClass: TDSClass; virtual; abstract;
    procedure CreateInstance(const CreateInstanceEventObject: TDSCreateInstanceEventObject); virtual; abstract;
    procedure DestroyInstance(const DestroyInstanceEventObject: TDSDestroyInstanceEventObject); virtual; abstract;
    procedure Preparing(const PrepareEventObject: TDSPrepareEventObject); virtual; abstract;
  private
    FLifeCycle: string;
    FRoleName: string;
  public
    property LifeCycle: string read FLifeCycle write FLifeCycle;
    property RoleName: string read FRoleName write FRoleName;
  protected
    property DSClass: TDSClass read GetDSClass;
  end;

  TDSServerConnectionFactory = class
  private
    class var
      FInstance: TDSServerConnectionFactory;
  private
    FDBXContext: TDBXContext;
    function CombineDriverProperties(
      ConProperties: TDBXProperties): TDBXProperties;
    function GetConnection(const DBXContext: TDBXContext; const ConnectionProperties: TDBXProperties;
      const AServer: TDSCustomServer): TDSServerConnection; overload;
  public
    function GetConnection(const ConnectionProperties: TDBXProperties;
      const AServer: TDSCustomServer): TDSServerConnection; overload;
  public
    constructor Create;
    destructor Destroy; override;
    class property Instance: TDSServerConnectionFactory read FInstance;
  end;

  TDSServerConnection = class(TDBXConnection)
  public
    constructor Create(const Builder: TDBXConnectionBuilder); overload;
    constructor Create(const Properties: TDBXProperties; const AServer: TDSCustomServer); overload;
    destructor Destroy; override;
    procedure InitSharedConnectionHandler(const ASharedHandler: TDSServerConnectionHandler);
    function CreateCommand: TDBXCommand; override;
    procedure Commit(const Transaction: TDBXTransaction); override;
    procedure Rollback(const Transaction: TDBXTransaction); override;
  protected
    procedure DerivedOpen; override;
    function CreateAndBeginTransaction(const IsolationLevel: Integer): TDBXTransaction; override;
    procedure DerivedGetCommandTypes(const List: TStrings); override;
    procedure DerivedGetCommands(const CommandType: string; const List: TStrings); override;
    procedure DerivedClose; override;
    function  GetDatabaseMetaData: TDBXDatabaseMetaData; override;
  private
    FDSServer: TDSCustomServer;
    FConHandler: TDSServerConnectionHandler;
    FNextHandler: TDBXConnectionHandler;
    FPrepareMessage: TDBXPrepareMessage;
    FExecuteMessage: TDBXExecuteMessage;
    FCommandCloseMessage: TDBXCommandCloseMessage;
    FConnectMessage: TDBXConnectMessage;
    FDisConnectMessage: TDBXDisconnectMessage;
    FNextResultMessage: TDBXNextResultMessage;
    FTxBeginMessage: TDBXTxBeginMessage;
    FTxEndMessage: TDBXTxEndMessage;
  public
    property ServerConnectionHandler: TDSServerConnectionHandler read FConHandler;
    property PrepareMessage: TDBXPrepareMessage read FPrepareMessage;
    property ExecuteMessage: TDBXExecuteMessage read FExecuteMessage;
    property CommandCloseMessage: TDBXCommandCloseMessage read FCommandCloseMessage;
    property NextResultMessage: TDBXNextResultMessage read FNextResultMessage;
    property DSServer: TDSCustomServer read FDSServer;
  end;

  TDSServerConnectionHandler = class(TDBXConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXConnectionHandler; const AChannel: TDbxChannel);
    destructor Destroy; override;
    function ClearResources: Boolean; override;
    procedure InitSharedConnectionHandler(const ASharedHandler: TDSServerConnectionHandler);
    function CreateInstance(const ServerClass: TDSCustomServerClass; const DsClass: TDSClass): TObject;
    procedure DestroyInstance(const ServerClass: TDSCustomServerClass; const Instance: TObject);
    procedure PrepareServerMethod(const MethodAlias: string; const ServerMethod: TDSServerMethod;
      const UserName: string; const UserRoles, AuthorizedRoles, DeniedRoles: TStrings);
    function GetAuthorizeMethodEventObject(
      const ServerMethod: TDSServerMethod;
      const UserName: string; const UserRoles, AuthorizedRoles, DeniedRoles: TStrings): TDSAuthorizeEventObject;
    function UsesDbxParameters: Boolean;
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    function GetInstance(const ClassInfo: TDSClassInfo): TObject;
    function AcquireNewCommandHandler(const Message: TDBXCommandMessage; const InNextCommandHandler: TDBXCommandHandler): TDBXCommandHandler;
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    function DbxBeforeRequest: Boolean; override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    procedure DbxError(const Ex: Exception);
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
  protected
    procedure SetServerConnection(const AServerCon: TDSServerConnection);
    function GetSQLScanner: TDBXSqlScanner;
    function GetProductName: string; override;
    procedure SetDbxConnection(const Con: TDBXConnection);
    procedure SetTransport(const Transport: TDSServerTransport); virtual;
  private
    procedure FetchServerConnection;
    function AddCommandHandler(const Handler: TDBXCommandHandler): Integer;
    procedure FreeCommandHandler(const Handler: TDBXCommandHandler);
    function GetCommandHandler(const Handle: Integer): TDBXCommandHandler;
    function IsCall(const CommandText: string): Integer;
    function FirstToken(const CommandText: string): string;
    function ScanMetaDataParameter(const InCommandText: string): string;
    function ConvertMetaDataCommandToServerMethodHandler(const Message: TDBXCommandMessage): Boolean;
    procedure DestroyEventObjects;
    procedure CreateEventObjects;
    procedure InitDatabaseConnectionHandler;
  private
    FConProperties: TDBXProperties;
    FConHandle: Integer;
    FServer: TDSCustomServer;
    FDatabaseConnectionHandler: TDBXConnectionHandler;
    FHasServerConnection: Boolean;
    FInstanceProvider: TDSHashtableInstanceProvider;
    FCommandHandlers: TDBXCommandHandlerArray;
    FLastCommandHandler: Integer;
    FNextHandler: TDBXConnectionHandler;
    FErrorMessage: TDBXErrorMessage;
    FScanner: TDBXSqlScanner;
    FDbxConnection: TDBXConnection;
    FTransport: TDSServerTransport;
    FChannel: TDbxChannel;
    FCreateInstanceEventObject: TDSCreateInstanceEventObject;
    FDestroyInstanceEventObject: TDSDestroyInstanceEventObject;
    FPrepareEventObject: TDSPrepareEventObject;
    FAuthenticateEventObject: TDSAuthenticateEventObject;
    FAuthorizeEventObject: TDSAuthorizeEventObject;
    FConnectEventObject: TDSConnectEventObject;
    FErrorEventObject: TDSErrorEventObject;
    FServerCon: TDSServerConnection;
    FSharedConHandler: TDSServerConnectionHandler;
    procedure InitServerMethodEventObject(
      EventObject: TDSServerMethodUserEventObject;
      const MethodAlias: string; const ServerMethod: TDSServerMethod;
      const UserName: string; const UserRoles, AuthorizedRoles, DeniedRoles: TStrings);
  public
    property Channel: TDBXChannel read FChannel;
    property ServerConnection: TDSServerConnection write SetServerConnection;
    property SQLScanner: TDBXSqlScanner read GetSQLScanner;
    property ConProperties: TDBXProperties read FConProperties;
    property DbxConnection: TDBXConnection read FDbxConnection write SetDbxConnection;
    property Transport: TDSServerTransport write SetTransport;
    property ConHandle: Integer read FConHandle write FConHandle;
    property Server: TDSCustomServer read FServer write FServer;
    property CreateInstanceEventObject: TDSCreateInstanceEventObject read FCreateInstanceEventObject write FCreateInstanceEventObject;
    property AuthenticateEventObject: TDSAuthenticateEventObject read FAuthenticateEventObject write FAuthenticateEventObject;
  end;

  TDSServerHelp = class
  public
    class function GetServerConnectionHandler(const Con: TDSServerConnection): TDSServerConnectionHandler; static;
  end;

  TDSServerMethod = class
  public
    constructor Create;
    destructor Destroy; override;
    procedure Invoke(const Message: TDBXExecuteMessage);
    function ClearResources: Boolean; virtual;
  protected
    procedure SetServerSideCommand(const ServerSide: Boolean);
    procedure SetParameters(const Parameters: TDBXServerParameterList);
  private
    FServerConnection: TDSServerConnectionHandler;
    FMethod: TDSMethod;
    FMethodInfo: TDSMethodInfo;
    FMethodValues: TDSMethodValues;
    FServerClass: TDSCustomServerClass;
    FMethodInstance: TObject;
    FAdapterInstance: TObject;
    FParameters: TDBXServerParameterList;
    FDbxParameters: TDBXParameterArray;
    FReturnParameter: TDBXParameter;
    FHasOutOrReturnParameters: Boolean;
    FRow: TDBXStreamerRow;
    FLifeCycle: string;
  public
    property ReturnParameter: TDBXParameter read FReturnParameter;
    property Parameters: TDBXServerParameterList read FParameters write SetParameters;
    property Method: TDSMethod read FMethod write FMethod;
    property MethodInstance: TObject read FMethodInstance write FMethodInstance;
    property AdapterInstance: TObject read FAdapterInstance write FAdapterInstance;
    property MethodValues: TDSMethodValues write FMethodValues;
    property ServerSideCommand: Boolean write SetServerSideCommand;
    property ReturnValue: TDBXParameter write FReturnParameter;
    property ServerConnection: TDSServerConnectionHandler write FServerConnection;
    property HasOutOrReturnParameters: Boolean read FHasOutOrReturnParameters write FHasOutOrReturnParameters;
    property Row: TDBXStreamerRow write FRow;
    property ServerClass: TDSCustomServerClass read FServerClass write FServerClass;
    property MethodInfo: TDSMethodInfo read FMethodInfo write FMethodInfo;
    property Lifecycle: string read FLifeCycle write FLifeCycle;
  end;

  TDSServerMethodCommandHandler = class(TDBXCommandHandler)
  public
    constructor Create(const ADbxContext: TDBXContext; const AServerCon: TDSServerConnectionHandler; const ANextHandler: TDBXCommandHandler);
    destructor Destroy; override;
    function ClearResources: Boolean; override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
  private
    procedure DestroyInstance;
    procedure DestroyServerMethod;
    procedure InitInvocationLifeCycle;
    procedure DestroyInstanceIfNotNeeded;
  private
    FServerCon: TDSServerConnectionHandler;
    FServerMethod: TDSServerMethod;
    FNextHandler: TDBXCommandHandler;
    FHasInvocationLifeCycle: Boolean;
    FHasExecuted: Boolean;
  public
    property ServerConnection: TDSServerConnectionHandler write FServerCon;
  end;

  
  /// <summary> Manages the loading and caching for DSServerMethod instances.
  /// </summary>
  /// <remarks> Registered DSServerMethod definitions are read from the class
  ///  and method tables.
  /// 
  /// </remarks>
  TDSServerMethodProvider = class
  public
    constructor Create;
    destructor Destroy; override;
    function GetClassInfo(const ClassName: string): TDSClassInfo;
    procedure GetServerClasses(const ServerCon: TDSServerConnectionHandler; const Classes: TDSClassEntity); overload;
    
    /// <summary> Populates container with the list of registered classes.
    /// </summary>
    /// <remarks> Container is expected to have a count in maximum double digits, otherwise streams
    ///  are recommended.
    ///  
    /// </remarks>
    /// <param name="container">- JSON array container</param>
    procedure GetServerClasses(const Container: TJSONArray); overload;
    
    /// <summary> Appends to the provided container the JSON representation of the server class
    ///    {'className':{'LifeCycle':'xyz','RoleName':'abc','methods':['method1',...]}}
    ///  In case the server does not expose the given class name appends:
    ///    {'className':null}
    ///    
    /// </summary>
    /// <param name="className">- server class name, nor null or empty</param>
    /// <param name="container">- container to be appended to</param>
    procedure GetServerClass(const ClassName: string; const Container: TJSONObject);
    procedure AddServerClass(const ClassInfo: TDSClassInfo);
    procedure DropServerClass(const ServerClassName: string);
    procedure CreateServerMethod(const ClassInfo: TDSClassInfo; const MethodInfo: TDSMethodInfo;
                                 const typeCtx: TRTTIType;
                                 const ClassAuthRole: TObject);
    procedure DropSeverMethod(const MethodAlias: string);
    procedure GetServerMethods(const ServerCon: TDSServerConnectionHandler; const Methods: TDSMethodEntity); overload;
    
    /// <summary> Retrieves and populates the container with the list of available methods
    ///  the class offers for DS calls.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <param name="className">- class name</param>
    /// <param name="container">- container to be populated with method names</param>
    procedure GetServerMethods(const ClassName: string; const Container: TJSONArray); overload;
    
    /// <summary> Populates the container with the server method meta data.
    /// </summary>
    /// <remarks> Each entry is: 'methodName':{parameterSignature}. If the method cannot be found
    ///  then the entry is 'methodName':null.
    ///  
    /// </remarks>
    /// <param name="serverMethodName">- server class method name</param>
    /// <param name="container">- container to withhold the server methods</param>
    procedure GetServerMethod(const ServerMethodName: string; const Container: TJSONObject);
    procedure GetServerMethodParameters(const ServerCon: TDSServerConnectionHandler; const Parameters: TDSMethodParametersEntity); overload;
    
    /// <summary> Populates container with the method parameters signature.
    /// </summary>
    /// <remarks> 
    ///  Each parameter signature is a JSON pair formed by direction and data type.
    ///  The directions are: In, InOut, Out and Return
    ///  
    /// </remarks>
    /// <param name="searchName">- method server name (with the class name)</param>
    /// <param name="container">- object that will hold the parameters</param>
    procedure GetServerMethodParameters(const SearchName: string; const Container: TJSONObject); overload;
    procedure GetProcedures(const ServerCon: TDSServerConnectionHandler; const ProcedureNamePattern: string; const ProcedureTypePattern: string; const Procedures: TDSProcedureEntity);
    procedure GetProcedureParameters(const ServerCon: TDSServerConnectionHandler; const SchemaPattern: string; const MethodPattern: string; const ProcedureParameters: TDSProcedureParametersEntity);
    procedure UpdateConfiguration(const Config: TDSConfiguration);
    function GetServerMethodInstance(const ServerCon: TDSServerConnectionHandler; const MethodInfo: TDSMethodInfo): TObject;
    function HasServerMethod(const MethodName: string): Boolean;
    function PrepareMethod(const Con: TDSServerConnectionHandler; const Message: TDBXCommandMessage; const ActiveStreamerRowList: TDBXActiveTableReaderList; const InRow: TDBXStreamerRow): TDSServerMethod;
    procedure Open;
    procedure Close;
  private
    function IsCallableMethod(const Method: TDSMethod): Boolean;
    function CreateMethodAlias(const MethodClass: TDSMethod): string;
    procedure AddAllMethods(ARTTICtx: TRTTIContext; const ClassInfo: TDSClassInfo);
    function AddBuiltinMethods(ARTTICtx: TRTTIContext; const PackageName: string; const UnitName: string; const ClassName: string; const AdminClass: Boolean): TDSClassInfo;
    procedure AddRegisteredServerClasses(ARttiContext: TRttiContext);
    procedure DropServerMethod(const MethodInfo: TDSMethodInfo; const Index: Integer);
    procedure InsertServerMethodParameter(const MethodInfo: TDSMethodInfo; const Parameters: TDSMethodParametersEntity);
    function GetParameterMode(const ParameterClass: TDSClass): string;
    procedure AddParameter(const ServerCon: TDSServerConnectionHandler; const Parameter: TDSClass; const ParameterName: string; const SchemaName: string; const ProcedureName: string; const ParamIndex: Integer; const ProcedureParameters: TDSProcedureParametersEntity);
    procedure CheckConfiguration(const Config: TDSConfiguration);
    procedure ProcessConfiguration(const Config: TDSConfiguration);
    procedure UnknownLifeCycle(const LifeCycle: string);
    function GetServerInstance(const ServerCon: TDSServerConnectionHandler; const ClassInfo: TDSClassInfo): TObject;
    function GetDbxParameterDirection(const DsClass: TDSClass): Integer;
    function CreateServerParameter(const Con: TDSServerConnectionHandler; const DsClass: TDSClass; const DbxRow: TDBXRow): TDBXParameter;
    procedure PrepareParameters(const Con: TDSServerConnectionHandler; const MethodInfo: TDSMethodInfo; const ServerMethod: TDSServerMethod; const Item: TDBXActiveTableReaderItem);
    function GetAuthRole(const attrs: TArray<TCustomAttribute>; const defValue: TObject = nil): TObject;
  private
    FConfig: TDSConfiguration;
    FOpen: Boolean;
    FPackageTable: TDBXObjectStore;
    FClassTable: TDBXObjectStore;
    FClassList: TDBXStringList;
    FMethodTable: TDBXObjectStore;
    FMethodSearchNameList: TDBXStringList;
    FStreamerTable: TDBXObjectStore;
    FServerInstanceProvider: TDSHashtableInstanceProvider;
    FServer: TDSCustomServer;
  public
    property Server: TDSCustomServer write FServer;
  end;

  TDSServerTransport = class abstract(TDSServerComponent)
  public
    constructor Create(ATransportOwner: TComponent); override;

    /// <summary> Frees openMessage, disconnectMessage, filterList content, filterList object, sets serverConnections to null
    /// </summary>
    destructor Destroy; override;
    procedure AddConnection(const Con: TDBXConnectionHandler);
    procedure RemoveConnection(const Con: TDBXConnectionHandler);
    procedure CloseConnections;
    procedure WaitForClosedConnections;
  protected
    /// <summary> Signs the server that the transport layer is stopping. </summary>
    procedure Stopping;
    procedure Disconnecting(const Con: TDBXConnectionHandler); virtual;
    procedure SetBufferKBSize(const BufferKBSize: Integer);
    
    /// <summary> Returns the filter list, never null but may be empty.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <returns>transport filter list, never null</returns>
    function GetFilters: TTransportFilterCollection; virtual;
    
    /// <summary> Copies the contents of an existing filter collection
    /// </summary>
    /// <param name="value">the existing filter collection</param>
    procedure SetFilters(const Value: TTransportFilterCollection); virtual;

    function GetIPImplementationID: string; virtual;
    procedure SetIPImplementationID(const AIPImplementationID: string); virtual;
  private
    FServerConnections: TDBXConnectionHandlerArray;
    FDbxContext: TDBXContext;
    FOpenMessage: TDBXOpenMessage;
    FDisconnectMessage: TDBXDisconnectMessage;
    FBufferKBSize: Integer;
    FIPImplementationID: string;
    
    /// <summary> string list that holds the filter id's 
    /// </summary>
    FFilterList: TTransportFilterCollection;
  public
    property DbxContext: TDBXContext read FDbxContext write FDbxContext;
    property BufferKBSize: Integer read FBufferKBSize write SetBufferKBSize;
    
    /// <summary> Returns the filter list, never null but may be empty.
    /// </summary>
    /// <remarks> 
    /// </remarks>
    /// <returns>transport filter list, never null</returns>
    property Filters: TTransportFilterCollection read GetFilters write SetFilters;

    property IPImplementationID: string read GetIPImplementationID write SetIPImplementationID;
  end;

  TDSSystemProperties = class
  public
    
    /// <summary>Specify directory for temp files.
    /// </summary>
    const TempDir = 'TempDir';
    
    /// <summary> Specify the port to communicate with a server.
    /// </summary>
    /// <remarks> Default is 211.
    /// </remarks>
    const Port = 'Port';
    
    /// <summary>Specify directory for temp files.
    /// </summary>
    const ConfigDir = 'ConfigDir';
  end;

  TDSVoidConnectionHandler = class(TDBXConnectionHandler)
  public
    constructor Create(const ADbxContext: TDBXContext);
    function AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler; override;
    function DbxBeforeRequest: Boolean; override;
    function CreateDbxRow: TDBXStreamerRow; override;
    procedure DbxConnect(const Message: TDBXConnectMessage); override;
    procedure DbxDisconnect(const Message: TDBXDisconnectMessage); override;
    procedure DbxOpen(const Message: TDBXOpenMessage); override;
    procedure DbxTxBegin(const Message: TDBXTxBeginMessage); override;
    procedure DbxTxEnd(const Message: TDBXTxEndMessage); override;
    procedure DbxVendorProperty(const Message: TDBXVendorPropertyMessage); override;
    procedure DbxCommandClose(const Message: TDBXCommandCloseMessage); override;
    procedure DbxErrorMessage(const Message: TDBXErrorMessage); override;
    procedure DbxExecute(const Message: TDBXExecuteMessage); override;
    procedure DbxMoreBlob(const Message: TDBXMoreBlobMessage); override;
    procedure DbxNext(const Message: TDBXNextMessage); override;
    procedure DbxNextResult(const Message: TDBXNextResultMessage); override;
    procedure DbxPrepare(const Message: TDBXPrepareMessage); override;
    procedure DbxReaderClose(const Message: TDBXReaderCloseMessage); override;
  protected
    function GetProductName: string; override;
  end;

  TInstanceProviderItem = class
  type
    TServerClassNotifier = class(TComponent)
    private
      FParent: TInstanceProviderItem;
    public
      constructor Create(AParent: TInstanceProviderItem); reintroduce;
      procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    end;
  public
    constructor Create(const AClassName: string; const ADestroyEventObject: TDSDestroyInstanceEventObject; const AServerClass: TDSCustomServerClass; const AInstance: TObject);
    procedure DestroyInstance;
  public
    FNext: TInstanceProviderItem;
  private
    FServerClassNotifier: TServerClassNotifier;
    FInstanceClassName: string;
    FDestroyEventObject: TDSDestroyInstanceEventObject;
    FServerClass: TDSCustomServerClass;
    FInstance: TObject;
  public
    property Instance: TObject read FInstance;
    property InstanceClassName: string read FInstanceClassName;
  end;

implementation

uses
  Data.DBXMessageHandlerJSonServer,
  Data.DBXTableFactory,
  Datasnap.DSNames,
  Datasnap.DSServer,
  Datasnap.DSServerResStrs,
  Datasnap.DSAuth,
  Datasnap.DSSession,
  Data.DBXJSON,
  Data.DBXClientResStrs,
  Data.DBXCommonResStrs,
  System.Generics.Collections,
  Data.DBXMetadataCommon
{$IFDEF MACOS}
  , Macapi.CoreFoundation
{$ENDIF MACOS}
;

destructor TDSClassInfo.Destroy;
begin
  FreeAndNil(FDsClass);
  inherited Destroy;
end;

procedure TDSClassInfo.Close;
begin
end;

function TDSConfiguration.CopyConfiguration: TDSConfiguration;
var
  Config: TDSConfiguration;
begin
  Config := TDSConfiguration.Create;
  Config.FClassTable := FClassTable;
  Config.FMethodTable := FMethodTable;
  Result := Config;
end;

function TDSConfiguration.GetClassTable: TDBXTable;
begin
  CreateClassTable;
  Result := FClassTable;
end;

procedure TDSConfiguration.SetClassTable(const Classes: TDBXTable);
begin
end;

function TDSConfiguration.GetMethodTable: TDBXTable;
begin
  CreateMethodTable;
  Result := FMethodTable;
end;

procedure TDSConfiguration.SetMethodTable(const Methods: TDBXTable);
begin
end;

procedure TDSConfiguration.CreateClassTable;
var
  PackageName: TDBXValueType;
  ClassName: TDBXValueType;
  RoleName: TDBXValueType;
  LifeCycle: TDBXValueType;
  TypeList: TDBXValueTypeArray;
begin
  if FClassTable = nil then
  begin
    FClassTable := TDBXTableFactory.CreateDBXTable;
    FClassTable.DBXTableName := 'ClassTable';
    PackageName := TDBXValueType.Create;
    PackageName.Name := TDSClassColumns.PackageName;
    PackageName.DisplayName := TDSClassColumns.PackageName;
    PackageName.DataType := TDBXDataTypes.WideStringType;
    PackageName.Size := 256;
    ClassName := TDBXValueType.Create;
    ClassName.Name := TDSClassColumns.ServerClassName;
    ClassName.DisplayName := TDSClassColumns.ServerClassName;
    ClassName.DataType := TDBXDataTypes.WideStringType;
    ClassName.Size := 256;
    RoleName := TDBXValueType.Create;
    RoleName.Name := TDSClassColumns.RoleName;
    RoleName.DisplayName := TDSClassColumns.ServerClassName;
    RoleName.DataType := TDBXDataTypes.WideStringType;
    RoleName.Size := 256;
    LifeCycle := TDBXValueType.Create;
    LifeCycle.Name := TDSClassColumns.LifeCycle;
    LifeCycle.DisplayName := TDSClassColumns.ServerClassName;
    LifeCycle.DataType := TDBXDataTypes.WideStringType;
    LifeCycle.Size := 256;
    SetLength(TypeList,4);
    TypeList[0] := PackageName;
    TypeList[1] := ClassName;
    TypeList[2] := RoleName;
    TypeList[3] := LifeCycle;
    FClassTable.Columns := TypeList;
  end;
end;

procedure TDSConfiguration.CreateMethodTable;
var
  ClassName: TDBXValueType;
  MethodName: TDBXValueType;
  RoleName: TDBXValueType;
  TypeList: TDBXValueTypeArray;
begin
  if FMethodTable = nil then
  begin
    FMethodTable := TDBXTableFactory.CreateDBXTable;
    FMethodTable.DBXTableName := 'MethodTable';
    ClassName := TDBXValueType.Create;
    ClassName.Name := TDSMethodColumns.ServerClassName;
    ClassName.DisplayName := TDSMethodColumns.ServerClassName;
    ClassName.DataType := TDBXDataTypes.WideStringType;
    ClassName.Size := 256;
    MethodName := TDBXValueType.Create;
    MethodName.Name := TDSMethodColumns.ServerMethodName;
    MethodName.DisplayName := TDSMethodColumns.ServerMethodName;
    MethodName.DataType := TDBXDataTypes.WideStringType;
    MethodName.Size := 256;
    RoleName := TDBXValueType.Create;
    RoleName.Name := TDSMethodColumns.RoleName;
    RoleName.DisplayName := TDSMethodColumns.RoleName;
    RoleName.DataType := TDBXDataTypes.WideStringType;
    RoleName.Size := 256;
    SetLength(TypeList,3);
    TypeList[0] := ClassName;
    TypeList[1] := MethodName;
    TypeList[2] := RoleName;
    FMethodTable.Columns := TypeList;
  end;
end;

constructor TDSCustomAdmin.Create;
begin
  Create(nil);
end;

constructor TDSCustomAdmin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TDSCustomAdmin.GetDSServerName: string;
begin
  if FServer is TDSServer then
    Result := (TDSServer(FServer)).Name
  else 
    Result := '';
end;

function TDSCustomAdmin.GetDBXContext: TDBXContext;
begin
  if FServerCon = nil then
    Result := nil
  else 
    Result := FServerCon.DBXContext;
end;

procedure TDSCustomAdmin.SetServerConnection(const Con: TDSServerConnectionHandler);
begin
  if FServer = nil then
  begin
    FServer := Con.Server;
    FServerCon := Con;
  end;
end;

constructor DSAdmin.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor DSAdmin.Destroy;
begin
  FreeAndNil(FCon);
  FConName := NullString;
  inherited Destroy;
end;

function DSAdmin.GetPlatformName: string;
begin
  Result := TDSPlatform.PlatformName;
end;

function DSAdmin.ClearResources: Boolean;
begin
  Result := self.FServerCon.ClearResources;
end;

function DSAdmin.FindPackages: TDBXReader;
var
  Table: TDBXTable;
  Iterator: TDSPackageEntity;
  DsPackage: TDSPackage;
  Packages: TDBXStringArray;
  Index: Integer;
begin
  Iterator := nil;
  DsPackage := nil;
  try
    Iterator := TDSPackageEntity.Create(False);
    DsPackage := TDSPackage.Create;
    Packages := DsPackage.DSPackages;
    for Index := 0 to Length(Packages) - 1 do
    begin
      Iterator.Table.Insert;
      Iterator.PackageName := Packages[Index];
      Iterator.Table.Post;
    end;
    Table := Iterator.Table;
  finally
    Iterator.Free;
    DsPackage.Free;
  end;
  Result := TDBXTableReader.Create(DBXContext, Table);
end;

function DSAdmin.FindClasses(const PackageName: string; const ClassPattern: string): TDBXReader;
var
  Table: TDBXTable;
  Entity: TDSClassEntity;
  DsPackage: TDSPackage;
  List: TDBXStringArray;
  Index: Integer;
begin
  Entity := nil;
  DsPackage := nil;
  try
    Entity := TDSClassEntity.Create(False);
    DsPackage := TDSPackage.Create;
    List := DsPackage.GetDSClasses(C_Conditional(ClassPattern.IsEmpty, '', ClassPattern));
    for Index := 0 to Length(List) - 1 do
    begin
      Entity.Table.Insert;
      Entity.ServerClassName := List[Index];
      Entity.Table.Post;
    end;
    Table := Entity.Table;
  finally
    Entity.Free;
    DsPackage.Free;
  end;
  Result := TDBXTableReader.Create(DBXContext, Table);
end;

function DSAdmin.FindMethods(const PackageName: string; const ClassPattern: string; const MethodPattern: string): TDBXReader;
var
  Table: TDBXTable;
  Methods: TDSMethodEntity;
  DsPackage: TDSPackage;
  List: TDBXStringArray;
  DsClass: TDSClass;
  DsMethods: TDSMethodArray;
  ClassName, LowerCaseMethodPattern, MethodName, ShortClassName: string;
  ClassIndex, LastDot, MethodIndex: Integer;
begin
  Methods := nil;
  DsPackage := nil;
  DsClass := nil;
  DsMethods := nil;
  if not MethodPattern.IsEmpty then
    LowerCaseMethodPattern := MethodPattern.ToLower
  else 
    LowerCaseMethodPattern := NullString;
  try
    Methods := TDSMethodEntity.Create(False);
    DsPackage := TDSPackage.Create;
    List := DsPackage.GetDSClasses(ClassPattern);
    for ClassIndex := 0 to Length(List) - 1 do
    begin
      DsClass := DsPackage.CreateDSClass(List[ClassIndex]);
      if DsClass.ClassLoadError.IsEmpty then
      begin
        DsMethods := DsClass.Methods;
        ClassName := List[ClassIndex];
        LastDot := ClassName.LastIndexOf('.');
        if ClassName.IndexOf('.') > -1 then
          ShortClassName := ClassName.Substring(LastDot + 1, ClassName.Length - (LastDot + 1))
        else
          ShortClassName := ClassName;
        for MethodIndex := 0 to Length(DsMethods) - 1 do
        begin
          MethodName := DsMethods[MethodIndex].DSMethodName;
          if (MethodPattern.IsEmpty) or (MethodPattern.Length < 1) or (MethodName.ToLower.IndexOf(LowerCaseMethodPattern) > -1) then
          begin
            Methods.Table.Insert;
            Methods.MethodAlias := ShortClassName + '.' + MethodName;
            Methods.ServerClassName := ClassName;
            Methods.ServerMethodName := MethodName;
            Methods.Table.Post;
          end;
        end;
      end;
      FreeAndNil(DsClass);
      FreeObjectArray(TDBXFreeArray(DsMethods));
    end;
    Table := Methods.Table;
  finally
    if DsMethods <> nil then
      FreeObjectArray(TDBXFreeArray(DsMethods));
    DsPackage.Free;
    DsClass.Free;
    Methods.Free;
    List := nil;
  end;
  Result := TDBXTableReader.Create(DBXContext, Table);
end;

procedure DSAdmin.CreateServerClasses(const ClassReader: TDBXReader);
var
  ClassTable: TDBXTable;
  Classes: TDSClassEntity;
begin
  ClassTable := nil;
  Classes := nil;
  try
    ClassTable := TDBXReaderTable.Create(ClassReader);
    Classes := TDSClassEntity.Create(ClassTable, False);
    if Classes.Table.Next then
      FServer.CreateServerClasses(Classes);
  finally
    Classes.Free;
    ClassTable.Free;
  end;
end;

procedure DSAdmin.DropServerClasses(const ClassReader: TDBXReader);
var
  ClassTable: TDBXTable;
  Classes: TDSClassEntity;
begin
  ClassTable := nil;
  Classes := nil;
  try
    ClassTable := TDBXReaderTable.Create(ClassReader);
    Classes := TDSClassEntity.Create(ClassTable, False);
    if Classes.Table.Next then
      FServer.DropServerClasses(Classes);
  finally
    Classes.Free;
    ClassTable.Free;
  end;
end;

procedure DSAdmin.CreateServerMethods(const MethodReader: TDBXReader);
var
  MethodTable: TDBXTable;
  Methods: TDSMethodEntity;
begin
  MethodTable := nil;
  Methods := nil;
  try
    MethodTable := TDBXReaderTable.Create(MethodReader);
    Methods := TDSMethodEntity.Create(MethodTable, False);
    if Methods.Table.Next then
      FServer.CreateServerMethods(Methods);
  finally
    Methods.Free;
    MethodTable.Free;
  end;
end;

procedure DSAdmin.DropServerMethods(const MethodReader: TDBXReader);
var
  MethodTable: TDBXTable;
  Methods: TDSMethodEntity;
begin
  MethodTable := TDBXReaderTable.Create(MethodReader);
  Methods := TDSMethodEntity.Create(MethodTable, False);
  try
    if Methods.Table.Next then
      FServer.DropServerMethods(Methods);
  finally
    Methods.Free;
    MethodTable.Free;
  end;
end;

function DSAdmin.GetServerClasses: TDBXReader;
var
  Classes: TDSClassEntity;
  Table: TDBXTable;
  ReturnReader: TDBXTableReader;
begin
  Classes := nil;
  Table := nil;
  try
    Classes := TDSClassEntity.Create(False);
    FServer.GetServerClasses(FServerCon, Classes);
    Table := Classes.Table;
    ReturnReader := TDBXTableReader.Create(DBXContext, Table);
    Table := nil;
  finally
    Classes.Free;
    Table.Free;
  end;
  Result := ReturnReader;
end;

function DSAdmin.ListClasses: TJSONArray;
var
  Container: TJSONArray;
begin
  Container := TJSONArray.Create;
  FServer.GetServerClasses(Container);
  Result := Container;
end;

function DSAdmin.DescribeClass(const ClassName: string): TJSONObject;
var
  Container: TJSONObject;
begin
  Container := TJSONObject.Create;
  FServer.GetServerClass(ClassName, Container);
  Result := Container;
end;

function DSAdmin.ListMethods(const ClassName: string): TJSONArray;
var
  Container: TJSONArray;
begin
  Container := TJSONArray.Create;
  FServer.GetServerMethods(ClassName, Container);
  Result := Container;
end;

function DSAdmin.DescribeMethod(const ServerMethodName: string): TJSONObject;
var
  Container: TJSONObject;
begin
  Container := TJSONObject.Create;
  FServer.GetServerMethod(ServerMethodName, Container);
  Result := Container;
end;

function DSAdmin.GetServerMethods: TDBXReader;
var
  Methods: TDSMethodEntity;
  Table: TDBXTable;
  ReturnReader: TDBXTableReader;
begin
  Methods := nil;
  Table := nil;
  try
    Methods := TDSMethodEntity.Create(False);
    FServer.GetServerMethods(FServerCon, Methods);
    Table := Methods.Table;
    ReturnReader := TDBXTableReader.Create(DBXContext, Table);
    Table := nil;
  finally
    Methods.Free;
    Table.Free;
  end;
  Result := ReturnReader;
end;

function DSAdmin.GetServerMethodParameters: TDBXReader;
var
  MethodParameters: TDSMethodParametersEntity;
  Table: TDBXTable;
  ReturnReader: TDBXTableReader;
begin
  MethodParameters := nil;
  Table := nil;
  try
    MethodParameters := TDSMethodParametersEntity.Create(False);
    FServer.GetServerMethodParameters(FServerCon, MethodParameters);
    Table := MethodParameters.Table;
    ReturnReader := TDBXTableReader.Create(DBXContext, Table);
    Table := nil;
  finally
    MethodParameters.Free;
    Table.Free;
  end;
  Result := ReturnReader;
end;

function DSAdmin.GetConnection(const NewConName: string): TDBXConnection;
var
  NewCon: TDBXConnection;
begin
  if (FConName.IsEmpty) or not (FConName = NewConName) then
  begin
    NewCon := TDSPlatform.GetDatabaseConnection(FServerCon.DBXContext, NewConName, FServerCon.ConProperties);
    FCon.Free;
    FCon := NewCon;
    FConName := NewConName;
  end;
  Result := FCon;
end;

function DSAdmin.GetDatabaseConnectionProperties: TDBXReader;
var
  Connections: TDSConnectionEntity;
  Table: TDBXTable;
  ReturnReader: TDBXTableReader;
begin
  Connections := nil;
  Table := nil;
  try
    Connections := TDSConnectionEntity.Create(False);
    TDSPlatform.GetConnectionProperties(Connections);
    Table := Connections.Table;
    ReturnReader := TDBXTableReader.Create(DBXContext, Table);
    Table := nil;
  finally
    Connections.Free;
    Table.Free;
  end;
  Result := ReturnReader;
end;

constructor TDSCustomServer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FConfig := TDSConfiguration.Create;
  FComponentList := TDBXArrayList.Create;
  FDbxContext := TDBXContext.Create;
  FDbxContext.TraceLevel := TDBXTraceLevels.Debug;
end;

class function TDSCustomServer.FindCustomServer(const Name: string): TDSCustomServer;
begin
  Result := TDSServer.FindServer(Name);
end;

destructor TDSCustomServer.Destroy;
begin
  FreeAndNil(FConfig);
  FreeAndNil(FComponentList);
  FreeAndNil(FDbxContext);
  FreeAndNil(FServerMethodProvider);
  inherited Destroy;
end;

procedure TDSCustomServer.GetServerClassList(const List: TDBXArrayList);
var
  ServerComponent: TObject;
  Index: Integer;
begin
  for Index := 0 to FComponentList.Count - 1 do
  begin
    ServerComponent := FComponentList[Index];
    if ServerComponent is TDSCustomServerClass then
      List.Add(ServerComponent);
  end;
end;

procedure TDSCustomServer.RemoveServerComponent(const AComponent: TDSServerComponent);
begin
  if (AComponent <> nil) and (FComponentList <> nil) then
    FComponentList.Remove(AComponent);
end;

procedure TDSCustomServer.AddServerComponent(const AComponent: TDSServerComponent);
var
  Index: Integer;
begin
  for Index := 0 to FComponentList.Count - 1 do
  begin
    if FComponentList[Index] = AComponent then
      Exit;
  end;
  FComponentList.Add(AComponent);
end;

procedure TDSCustomServer.StartTransports;
var
  Transport: TDSServerTransport;
  ServerComponent: TObject;
  Index: Integer;
begin
  for Index := 0 to FComponentList.Count - 1 do
  begin
    ServerComponent := FComponentList[Index];
    if ServerComponent is TDSServerTransport then
    begin
      Transport := TDSServerTransport(ServerComponent);
      Transport.DbxContext := FDbxContext;
      Transport.Start;
    end;
  end;
end;

procedure TDSCustomServer.StopTransports;
var
  Transport: TDSServerTransport;
  ServerComponent: TObject;
  Index: Integer;
begin
  for Index := 0 to FComponentList.Count - 1 do
  begin
    ServerComponent := FComponentList[Index];
    if ServerComponent is TDSServerTransport then
    begin
      Transport := TDSServerTransport(ServerComponent);
      Transport.Stop;
    end;
  end;
end;

procedure TDSCustomServer.TransportStopping(const Sender: TDSServerTransport);
begin
//
end;

procedure TDSCustomServer.Stop;
begin
  if FStarted then
  begin
    try
      StopTransports;
      FreeAndNil(FServerMethodProvider);
    finally
      // Stop even if exception
      FStarted := False;
    end;
  end;
end;

procedure TDSCustomServer.Start;
begin
  if not FStarted then
    try
      StartTransports;
      FServerMethodProvider := TDSServerMethodProvider.Create;
      FServerMethodProvider.Server := self;
      FServerMethodProvider.Open;
      FStarted := True;
    finally
      if not FStarted then
      begin
        StopTransports;
        if FServerMethodProvider <> nil then
        begin
          FServerMethodProvider.Close;
          FreeAndNil(FServerMethodProvider);
        end;
      end;
    end;
end;

function TDSCustomServer.GetClassTable: TDBXTable;
begin
  Result := FConfig.ClassTable;
end;

procedure TDSCustomServer.SetClassTable(const Classes: TDBXTable);
begin
end;

function TDSCustomServer.GetMethodTable: TDBXTable;
begin
  Result := FConfig.MethodTable;
end;

procedure TDSCustomServer.SetMethodTable(const Methods: TDBXTable);
begin
end;

procedure TDSCustomServer.GetServerClasses(const ServerCon: TDSServerConnectionHandler; const Classes: TDSClassEntity);
begin
  FServerMethodProvider.GetServerClasses(ServerCon, Classes);
end;

procedure TDSCustomServer.GetServerClasses(const Container: TJSONArray);
begin
  FServerMethodProvider.GetServerClasses(Container);
end;

procedure TDSCustomServer.GetServerClass(const ClassName: string; const Container: TJSONObject);
begin
  FServerMethodProvider.GetServerClass(ClassName, Container);
end;

procedure TDSCustomServer.GetServerMethods(const ClassName: string; const Container: TJSONArray);
begin
  FServerMethodProvider.GetServerMethods(ClassName, Container);
end;

procedure TDSCustomServer.GetServerMethod(const ServerMethodName: string; const Container: TJSONObject);
begin
  FServerMethodProvider.GetServerMethod(ServerMethodName, Container);
end;

procedure TDSCustomServer.CreateServerClasses(const Classes: TDSClassEntity);
var
  ClassInfo: TDSClassInfo;
begin
  ClassInfo := nil;
  try
    while Classes.Table.InBounds do
    begin
      ClassInfo := TDSClassInfo.Create;
      ClassInfo.DSClassName := Classes.ServerClassName;
      ClassInfo.PackageName := Classes.PackageName;
      ClassInfo.LifeCycle := Classes.LifeCycle;
      ClassInfo.RoleName := Classes.RoleName;
      FServerMethodProvider.AddServerClass(ClassInfo);
      Classes.Table.Next;
    end;
    ClassInfo := nil;
  finally
    FreeAndNil(ClassInfo);
  end;
end;

procedure TDSCustomServer.DropServerClasses(const Classes: TDSClassEntity);
begin
  while Classes.Table.InBounds do
  begin
    FServerMethodProvider.DropServerClass(Classes.ServerClassName);
    Classes.Table.Next;
  end;
end;

procedure TDSCustomServer.GetServerMethods(const ServerCon: TDSServerConnectionHandler; const Methods: TDSMethodEntity);
begin
  FServerMethodProvider.GetServerMethods(ServerCon, Methods);
end;

procedure TDSCustomServer.GetServerMethodParameters(const ServerCon: TDSServerConnectionHandler; const Parameters: TDSMethodParametersEntity);
begin
  FServerMethodProvider.GetServerMethodParameters(ServerCon, Parameters);
end;

procedure TDSCustomServer.CreateServerMethods(const Methods: TDSMethodEntity);
var
  MethodInfo: TDSMethodInfo;
begin
  MethodInfo := nil;
  try
    while Methods.Table.InBounds do
    begin
      MethodInfo := TDSMethodInfo.Create;
      MethodInfo.MethodAlias := Methods.MethodAlias;
      MethodInfo.DSMethodName := Methods.ServerMethodName;
      MethodInfo.RoleName := Methods.RoleName;
      FServerMethodProvider.CreateServerMethod(FServerMethodProvider.GetClassInfo(Methods.ServerClassName),
                                               MethodInfo, nil, nil);
      Methods.Table.Next;
    end;
    MethodInfo := nil;
  finally
    FreeAndNil(MethodInfo);
  end;
end;

procedure TDSCustomServer.DropServerMethods(const Methods: TDSMethodEntity);
begin
  while Methods.Table.InBounds do
    FServerMethodProvider.DropSeverMethod(Methods.MethodAlias);
end;

constructor TDSDefaultCommandHandler.Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXCommandHandler);
begin
  inherited Create(ADbxContext);
  FActiveStreamerRowList := TDBXActiveTableReaderList.Create;
  FNextHandler := ANextHandler;
end;

procedure TDSDefaultCommandHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

destructor TDSDefaultCommandHandler.Destroy;
begin
  FreeAndNil(FServerMethod);
  FreeAndNil(FActiveStreamerRowList);
  inherited Destroy;
end;

procedure TDSDefaultCommandHandler.DbxExecute(const Message: TDBXExecuteMessage);
begin
  if string.Compare(Message.Command, TDBXMetaDataCommands.GetDatabase, True) = 0 then
  begin
    if FServerMethod = nil then
    begin
      Message.Command := TDSMetadataMethods.GetDatabase;
      FServerMethod := FServerCon.Server.ServerMethodProvider.PrepareMethod(FServerCon, Message, FActiveStreamerRowList, FNextHandler.CreateDbxRow);
    end;
    FServerMethod.Parameters.NewRowGeneration;
    FServerMethod.Invoke(Message);
    FNextHandler.DbxExecute(Message);
  end
  else 
    raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSDefaultCommandHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSDefaultCommandHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSDefaultCommandHandler.DbxNext(const Message: TDBXNextMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSDefaultCommandHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSDefaultCommandHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
end;

procedure TDSDefaultCommandHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
end;

constructor TDSDefaultDatabaseConnectionHandler.Create(const ADbxContext: TDBXContext; const Con: TDSServerConnectionHandler; const ANextHandler: TDBXConnectionHandler);
begin
  inherited Create(ADbxContext);
  FServerCon := Con;
  FNextHandler := ANextHandler;
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
end;

function TDSDefaultDatabaseConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := True;
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxErrorMessage(const ErrorMessage: TDBXErrorMessage);
begin
  FNextHandler.DbxErrorMessage(ErrorMessage);
end;

function TDSDefaultDatabaseConnectionHandler.GetProductName: string;
begin
  Result := 'DataSnap';
end;

function TDSDefaultDatabaseConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
var
  Handler: TDSDefaultCommandHandler;
begin
  Handler := TDSDefaultCommandHandler.Create(DBXContext, nil);
  Handler.ServerCon := FServerCon;
  Result := Handler;
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
  Message.PropertyValue := '';
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxNext(const Message: TDBXNextMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
end;

procedure TDSDefaultDatabaseConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
end;

constructor TDSEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create;
  FDbxContext := ADbxContext;
  FServer := AServer;
  FTransport := ATransport;
  FDbxConnection := ADbxConnection;
end;

constructor TDSErrorEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create(ADbxContext, AServer, ATransport, ADbxConnection);
end;

constructor TDSDestroyInstanceEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create(ADbxContext, AServer, ATransport, ADbxConnection);
end;

constructor TDSCreateInstanceEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create(ADbxContext, AServer, ATransport, ADbxConnection);
end;

constructor TDSConnectEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const AChannelInfo: TDBXChannelInfo; const ADbxConnection: TDBXConnection; const AConnectProperties: TDBXProperties);
begin
  inherited Create(ADbxContext, AServer, ATransport, ADbxConnection);
  FConnectProperties := AConnectProperties;
  FChannelInfo := AChannelInfo;
end;

constructor TDSHashtableInstanceProvider.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create;
  FInstanceTable := TDBXObjectStore.Create(True);
  FDestroyInstanceEventObject := TDSDestroyInstanceEventObject.Create(ADbxContext, AServer, ATransport, ADbxConnection);
end;

destructor TDSHashtableInstanceProvider.Destroy;
var
  Item: TInstanceProviderItem;
begin
  Item := FList;
  while Item <> nil do
  begin
    Item.DestroyInstance;
    Item := Item.FNext;
  end;
  FreeAndNil(FInstanceTable);
  FList := nil;
  FreeAndNil(FDestroyInstanceEventObject);
  inherited Destroy;
end;

function TDSHashtableInstanceProvider.GetInstance(const ServerCon: TDSServerConnectionHandler; const ClassInfo: TDSClassInfo): TObject;
var
  ObjectInstance: TObject;
  Item: TInstanceProviderItem;
  ClassName: string;
  ServerClass: TDSCustomServerClass;
  LDestroyInstanceEventObject: TDSDestroyInstanceEventObject;
begin
  ClassName := ClassInfo.DSClassName;
  ObjectInstance := FInstanceTable[ClassName];
  if ObjectInstance <> nil then
    Exit((TInstanceProviderItem(ObjectInstance)).Instance);
  ServerClass := ClassInfo.ServerClass;
  ObjectInstance := ServerCon.CreateInstance(ServerClass, ClassInfo.DSClass);
  if ClassInfo.LifeCycle = TDSLifeCycle.Server then
    LDestroyInstanceEventObject := FDestroyInstanceEventObject
  else
    // This event object has information about the connection
    LDestroyInstanceEventObject := ServerCon.FDestroyInstanceEventObject;
  Item := TInstanceProviderItem.Create(ClassName, LDestroyInstanceEventObject, ServerClass, ObjectInstance);
  Item.FNext := FList;
  FList := Item;
  FInstanceTable[ClassName] := Item;
  Result := ObjectInstance;
end;

constructor DSMetadata.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

constructor DSMetadata.Create;
begin
  Create(nil);
end;

function DSMetadata.GetProcedures(const ProcedureNamePattern: string; const ProcedureType: string): TDBXReader;
var
  Procedures: TDSProcedureEntity;
  ReturnReader: TDBXTableReader;
  Con: TDBXConnection;
  Command: TDBXCommand;
  Reader: TDBXReader;
  Table: TDBXTable;
  CommandText: string;
  Ordinal: Integer;
begin
  Procedures := nil;
  try
    Procedures := TDSProcedureEntity.Create(False);
    FServer.ServerMethodProvider.GetProcedures(FServerCon, ProcedureNamePattern, ProcedureType, Procedures);
    Con := FServerCon.DbxConnection;
    if Con <> nil then
    begin
      Command := Con.CreateCommand;
      Reader := nil;
      try
        Command.CommandType := TDBXCommandTypes.DbxMetadata;
        CommandText := TDBXMetaDataCommands.GetProcedures + ' ' + ProcedureNamePattern + ';';
        if ProcedureType.Length > 0 then
          CommandText := CommandText + ' ' + ProcedureType;
        Command.Text := CommandText;
        Reader := Command.ExecuteQuery;
        Table := Procedures.Table;
        while Reader.Next do
        begin
          Table.Insert;
          for Ordinal := 0 to Reader.ColumnCount - 1 do
            Table.Value[Ordinal].SetValue(Reader.Value[Ordinal]);
          Table.Post;
        end;
      finally
        FreeAndNil(Command);
        FreeAndNil(Reader);
      end;
    end;
    ReturnReader := TDBXTableReader.Create(DBXContext, Procedures.Table);
  finally
    FreeAndNil(Procedures);
  end;
  Result := ReturnReader;
end;

function DSMetadata.GetProcedureParameters(const ProcedureNamePattern: string): TDBXReader;
var
  ProcedureParameters: TDSProcedureParametersEntity;
  ReturnReader: TDBXTableReader;
  Con: TDBXConnection;
  Command: TDBXCommand;
  Reader: TDBXReader;
  Table: TDBXTable;
  Ordinal: Integer;
begin
  ProcedureParameters := nil;
  try
    ProcedureParameters := TDSProcedureParametersEntity.Create(False);
    FServer.ServerMethodProvider.GetProcedureParameters(FServerCon, '', ProcedureNamePattern, ProcedureParameters);
    Con := FServerCon.DbxConnection;
    if Con <> nil then
    begin
      Command := Con.CreateCommand;
      Reader := nil;
      try
        Command.CommandType := TDBXCommandTypes.DbxMetadata;
        Command.Text := TDBXMetaDataCommands.GetProcedureParameters + ' ' + ProcedureNamePattern;
        Reader := Command.ExecuteQuery;
        Table := ProcedureParameters.Table;
        while Reader.Next do
        begin
          Table.Insert;
          for Ordinal := 0 to Reader.ColumnCount - 1 do
            Table.Value[Ordinal].SetValue(Reader.Value[Ordinal]);
          Table.Post;
        end;
      finally
        FreeAndNil(Command);
        FreeAndNil(Reader);
      end;
    end;
    ReturnReader := TDBXTableReader.Create(DBXContext, ProcedureParameters.Table);
  finally
    FreeAndNil(ProcedureParameters);
  end;
  Result := ReturnReader;
end;

function DSMetadata.GetDatabase: TDBXReader;
var
  Table: TDBXTable;
  QuoteChar: TDBXValueType;
  ProcedureQuoteChar: TDBXValueType;
  MaxCommands: TDBXValueType;
  SupportsTransactions: TDBXValueType;
  SupportsNestedTransactions: TDBXValueType;
  SupportsRowSetSize: TDBXValueType;
  ProductVersion: TDBXValueType;
  ProductName: TDBXValueType;
  QuotePrefix: TDBXValueType;
  QuoteSuffix: TDBXValueType;
  SupportsLowerCaseIdentifiers: TDBXValueType;
  SupportsUpperCaseIdentifiers: TDBXValueType;
  SupportsSPReturnCode: TDBXValueType;
  SupportsParameterMetadata: TDBXValueType;
  SupportsCatalogFunctions: TDBXValueType;
  SupportsCatalogs: TDBXValueType;
  SupportsSchemas: TDBXValueType;
  Columns: TDBXValueTypeArray;
begin
  Table := TDBXTableFactory.CreateDBXTable;
  QuoteChar := TDBXValueType.Create;
  QuoteChar.Name := TDBXMetaDatabaseColumnNames.QuoteChar;
  QuoteChar.DataType := TDBXDataTypes.WideStringType;
  QuoteChar.Size := 16;
  ProcedureQuoteChar := TDBXValueType.Create;
  ProcedureQuoteChar.Name := TDBXMetaDatabaseColumnNames.ProcedureQuoteChar;
  ProcedureQuoteChar.DataType := TDBXDataTypes.WideStringType;
  ProcedureQuoteChar.Size := 16;
  MaxCommands := TDBXValueType.Create;
  MaxCommands.Name := TDBXMetaDatabaseColumnNames.MaxCommands;
  MaxCommands.DataType := TDBXDataTypes.Int32Type;
  SupportsTransactions := TDBXValueType.Create;
  SupportsTransactions.Name := TDBXMetaDatabaseColumnNames.SupportsTransactions;
  SupportsTransactions.DataType := TDBXDataTypes.BooleanType;
  SupportsNestedTransactions := TDBXValueType.Create;
  SupportsNestedTransactions.Name := TDBXMetaDatabaseColumnNames.SupportsNestedTransactions;
  SupportsNestedTransactions.DataType := TDBXDataTypes.BooleanType;
  SupportsRowSetSize := TDBXValueType.Create;
  SupportsRowSetSize.Name := TDBXMetaDatabaseColumnNames.SupportsRowSetSize;
  SupportsRowSetSize.DataType := TDBXDataTypes.BooleanType;
  ProductVersion := TDBXValueType.Create;
  ProductVersion.Name := TDBXMetaDatabaseColumnNames.ProductVersion;
  ProductVersion.DataType := TDBXDataTypes.WideStringType;
  ProductVersion.Size := 128;
  ProductName := TDBXValueType.Create;
  ProductName.Name := TDBXMetaDatabaseColumnNames.ProductName;
  ProductName.DataType := TDBXDataTypes.WideStringType;
  ProductName.Size := 128;
  QuotePrefix := TDBXValueType.Create;
  QuotePrefix.Name := TDBXMetaDatabaseColumnNames.QuotePrefix;
  QuotePrefix.DataType := TDBXDataTypes.WideStringType;
  QuotePrefix.Size := 16;
  QuoteSuffix := TDBXValueType.Create;
  QuoteSuffix.Name := TDBXMetaDatabaseColumnNames.QuoteSuffix;
  QuoteSuffix.DataType := TDBXDataTypes.WideStringType;
  QuoteSuffix.Size := 16;
  SupportsLowerCaseIdentifiers := TDBXValueType.Create;
  SupportsLowerCaseIdentifiers.Name := TDBXMetaDatabaseColumnNames.SupportsLowerCaseIdentifiers;
  SupportsLowerCaseIdentifiers.DataType := TDBXDataTypes.BooleanType;
  SupportsUpperCaseIdentifiers := TDBXValueType.Create;
  SupportsUpperCaseIdentifiers.Name := TDBXMetaDatabaseColumnNames.SupportsUpperCaseIdentifiers;
  SupportsUpperCaseIdentifiers.DataType := TDBXDataTypes.BooleanType;
  SupportsSPReturnCode := TDBXValueType.Create;
  SupportsSPReturnCode.Name := TDBXMetaDatabaseColumnNames.SupportsSPReturnCode;
  SupportsSPReturnCode.DataType := TDBXDataTypes.BooleanType;
  SupportsParameterMetadata := TDBXValueType.Create;
  SupportsParameterMetadata.Name := TDBXMetaDatabaseColumnNames.SupportsParameterMetadata;
  SupportsParameterMetadata.DataType := TDBXDataTypes.BooleanType;
  SupportsCatalogFunctions := TDBXValueType.Create;
  SupportsCatalogFunctions.Name := TDBXMetaDatabaseColumnNames.SupportsCatalogFunctions;
  SupportsCatalogFunctions.DataType := TDBXDataTypes.BooleanType;
  SupportsCatalogs := TDBXValueType.Create;
  SupportsCatalogs.Name := TDBXMetaDatabaseColumnNames.SupportsCatalogFunctions;
  SupportsCatalogs.DataType := TDBXDataTypes.BooleanType;
  SupportsSchemas := TDBXValueType.Create;
  SupportsSchemas.Name := TDBXMetaDatabaseColumnNames.SupportsCatalogFunctions;
  SupportsSchemas.DataType := TDBXDataTypes.BooleanType;
  SetLength(Columns,17);
  Columns[0] := QuoteChar;
  Columns[1] := ProcedureQuoteChar;
  Columns[2] := MaxCommands;
  Columns[3] := SupportsTransactions;
  Columns[4] := SupportsNestedTransactions;
  Columns[5] := SupportsRowSetSize;
  Columns[6] := ProductVersion;
  Columns[7] := ProductName;
  Columns[8] := QuotePrefix;
  Columns[9] := QuoteSuffix;
  Columns[10] := SupportsLowerCaseIdentifiers;
  Columns[11] := SupportsUpperCaseIdentifiers;
  Columns[12] := SupportsSPReturnCode;
  Columns[13] := SupportsParameterMetadata;
  Columns[14] := SupportsCatalogFunctions;
  Columns[15] := SupportsCatalogs;
  Columns[16] := SupportsSchemas;
  Table.Columns := Columns;
  Table.Insert;
  Table.Value[0].AsString := '"';
  Table.Value[1].AsString := '"';
  Table.Value[2].AsInt32 := 2147483647;
  Table.Value[3].AsBoolean := False;
  Table.Value[4].AsBoolean := False;
  Table.Value[5].AsBoolean := False;
  Table.Value[6].AsString := '2008';
  Table.Value[7].AsString := 'DataSnap';
  Table.Value[8].AsString := '"';
  Table.Value[9].AsString := '"';
  Table.Value[10].AsBoolean := False;
  Table.Value[11].AsBoolean := False;
  Table.Value[12].AsBoolean := False;
  Table.Value[13].AsBoolean := False;
  Table.Value[14].AsBoolean := False;
  Table.Value[15].AsBoolean := False;
  Table.Value[16].AsBoolean := False;
  Table.Post;
  Result := TDBXTableReader.Create(DBXContext, Table);
end;

constructor TDSMethodInfo.Create;
begin
  FAuthRole := nil;
end;

destructor TDSMethodInfo.Destroy;
begin
  FreeAndNil(FDsMethod);
  FreeAndNil(FAuthRole);

  inherited Destroy;
end;

procedure TDSMethodInfo.SetMethodAlias(const MethodAlias: string);
begin
  self.FMethodAlias := MethodAlias;
  self.FSearchName := UpperCase(MethodAlias);
end;

function TDSMethodInfo.GetDSMethod: TDSMethod;
begin
  if FDsMethod = nil then
    FDsMethod := FClassInfo.DSClass.CreateMethod(FMethodName);
  Result := FDsMethod;
end;

procedure TDSMethodInfo.SetAuthRole(ARoleAuth: TObject);
begin
  if ARoleAuth = FAuthRole then
    Exit;

  //Free any previous auth role, and nil the field.
  FreeAndNil(FAuthRole);

  if ARoleAuth is TRoleAuth then
  begin
    if not TRoleAuth(ARoleAuth).IsDesignTime then
    begin
      // AuthRole is an RTTI attribute, make a copy so that RTTI reference is not required
      FAuthRole := TRoleAuth.Create(TRoleAuth(ARoleAuth).AuthorizedRoles, TRoleAuth(ARoleAuth).DeniedRoles);
    end
    else
      FAuthRole := ARoleAuth;
  end;
end;

constructor TDSServerMethodEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create(ADbxContext, AServer, ATransport, ADbxConnection);
end;


function TDSServerMethodUserEventObject.GetSessionUserName: string;
begin
  if FUserName <> '' then
    Result := FUserName
  else
    if (ServerConnectionHandler <> nil) and (ServerConnectionHandler.ConProperties <> nil) then
      Result := Self.ServerConnectionHandler.ConProperties.Values[TDBXPropertyNames.DSAuthenticationUser]
    else
      Result := '';
end;

constructor TDSServerMethodUserEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create(ADbxContext, AServer, ATransport, ADbxConnection);
end;

destructor TDSServerMethodUserEventObject.Destroy;
begin
  FreeAndNil(FUserRoles);
  FreeAndNil(FAuthorizedRoles);
  FreeAndNil(FDeniedRoles);
  inherited;
end;

constructor TDSAuthenticateEventObject.Create(const ADbxContext: TDBXContext; const AServer: TDSCustomServer; const ATransport: TDSServerTransport; const ADbxConnection: TDBXConnection);
begin
  inherited Create(ADbxContext, AServer, ATransport, ADbxConnection);
end;

constructor TDSServerCommand.Create(const Context: TDBXContext; const AServerCon: TDSServerConnection; const AConHandler: TDSServerConnectionHandler);
begin
  inherited Create(Context);
  FConHandler := AConHandler;
  FServerCon := AServerCon;
end;

procedure TDSServerCommand.DerivedOpen;
begin
end;

function TDSServerCommand.CreateParameterRow: TDBXRow;
begin
  Result := TDBXNoOpRow.Create(FDbxContext);
end;

procedure TDSServerCommand.DerivedPrepare;
var
  CommandParams: TDBXParameterList;
  Params: TDBXParameterList;
  CommandParam: TDBXParameter;
  Param: TDBXParameter;
  Message: TDBXPrepareMessage;
  Ordinal: Integer;
  begin
    Message := FServerCon.PrepareMessage;
    Message.ServerSideCommand := True;
    Message.Reset;
    Message.Command := Text;
    Message.CommandType := CommandType;
    FConHandler.AcquireNewCommandHandler(Message, nil);
    Message.HandleMessage(FConHandler);
    Params := Message.Parameters;
  FServerParameterList := Params;
  CommandParams := Parameters;
  Parameters.ClearParameters;
  for Ordinal := 0 to Params.Count - 1 do
  begin
    Param := Params.Parameter[Ordinal];
    CommandParam := TDBXParameter.Create(FDbxContext, nil, Param);
    CommandParams.AddParameter(CommandParam);
    CommandParam.Value.SetValue(Param.Value);
  end;
end;

procedure TDSServerCommand.Execute;
var
  Count: Integer;
  Ordinal: Integer;
  Params: TDBXParameterList;
  CommandParams: TDBXParameterList;
  Message: TDBXExecuteMessage;
begin
  Message := FServerCon.ExecuteMessage;
  if not IsPrepared then
    Prepare;
  for Ordinal := 0 to Parameters.Count - 1 do
    FServerParameterList.Parameter[Ordinal].Value.SetValue(Parameters.Parameter[Ordinal].Value);
  Message.Command := Text;
  Message.CommandType := CommandType;
  Message.CommandHandle := FServerCon.PrepareMessage.CommandHandle;
  Message.Parameters := Parameters;
  Message.HandleMessage(FConHandler);
  Params := Message.Parameters;
  CommandParams := Parameters;
  if Params <> nil then
  begin
    Count := Params.Count;
    if Count > 0 then
      for Ordinal := 0 to Count - 1 do
      begin
        CommandParams.Parameter[Ordinal].Value.SetValue(Params.Parameter[Ordinal].Value);
        Params.Parameter[Ordinal].Value.SetNull;
      end;
  end;
  FRowsAffected := Message.RowsAffected;
end;

function TDSServerCommand.DerivedExecuteQuery: TDBXReader;
var
  List: TDBXParameterList;
  Parameter: TDBXParameter;
  Reader: TDBXReader;
begin
  Execute;
  List := Parameters;
  if (List <> nil) and (List.Count > 0) then
  begin
    Parameter := List.Parameter[List.Count - 1];
    if Parameter.DataType = TDBXDataTypes.TableType then
    begin
      Reader := Parameter.Value.GetDBXReader;
      Parameter.Value.SetNull;
      Exit(Reader);
    end;
  end;
  Result := nil;
end;

procedure TDSServerCommand.DerivedExecuteUpdate;
begin
  Execute;
end;

procedure TDSServerCommand.DerivedClose;
var
  Message: TDBXCommandCloseMessage;
begin
  Message := FServerCon.CommandCloseMessage;
  Message.CommandHandle := FServerCon.PrepareMessage.CommandHandle;
  Message.HandleMessage(FConHandler);
end;

function TDSServerCommand.DerivedGetNextReader: TDBXReader;
var
  Message: TDBXNextResultMessage;
begin
  Message := FServerCon.NextResultMessage;
  Message.CommandHandle := FServerCon.PrepareMessage.CommandHandle;
  Message.HandleMessage(FConHandler);
  Result := Message.NextResult;
end;

function TDSServerCommand.GetRowsAffected: Int64;
begin
  Result := FRowsAffected;
end;

procedure TDSServerCommand.SetRowSetSize(const RowSetSize: Int64);
begin
end;

procedure TDSServerCommand.SetMaxBlobSize(const MaxBlobSize: Int64);
begin
end;

constructor TDSServerCommandHandler.Create(const ADbxContext: TDBXContext);
begin
  inherited Create(ADbxContext);
end;

procedure TDSServerCommandHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, Message.ErrorMessage, Message.Error);
end;

procedure TDSServerCommandHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
end;

procedure TDSServerCommandHandler.DbxExecute(const Message: TDBXExecuteMessage);
begin
end;

procedure TDSServerCommandHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
end;

procedure TDSServerCommandHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSServerCommandHandler.DbxNext(const Message: TDBXNextMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSServerCommandHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

procedure TDSServerCommandHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
  raise Exception.Create(SUnsupportedOperation);
end;

constructor TDSServerComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TDSServerComponent.GetServer: TDSCustomServer;
begin
  Result := FServer;
end;

procedure TDSServerComponent.SetServer(const AServer: TDSCustomServer);
begin
  if FServer <> nil then
    FServer.RemoveServerComponent(self);
  if AServer <> nil then
    AServer.AddServerComponent(self);
  self.FServer := AServer;
end;

procedure TDSServerComponent.Start;
begin
//
end;

procedure TDSServerComponent.Stop;
begin
//
end;

constructor TDSCustomServerClass.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

//  private DBXCommandHandler commandHandler;
//  public final DBXCommandHandler getCommandHandler() {
//    return commandHandler;
//  }
constructor TDSServerConnection.Create(const Builder: TDBXConnectionBuilder);
begin
  inherited Create(Builder);
//    commandHandler      = new DSServerCommandHandler(builder.getDBXContext());
  FPrepareMessage := TDBXPrepareMessage.Create;
  FExecuteMessage := TDBXExecuteMessage.Create;
  FCommandCloseMessage := TDBXCommandCloseMessage.Create;
  FConnectMessage := TDBXConnectMessage.Create;
  FDisConnectMessage := TDBXDisconnectMessage.Create;
  FNextResultMessage := TDBXNextResultMessage.Create;
  FTxBeginMessage := TDBXTxBeginMessage.Create;
  FTxEndMessage := TDBXTxEndMessage.Create;
end;

constructor TDSServerConnection.Create(const Properties: TDBXProperties;
  const AServer: TDSCustomServer);
var
  LDriverDef: TDBXDriverDef;
begin
  FDSServer := AServer;
  Assert(AServer <> nil);
  FConnectionProperties := Properties.Clone;
  FDriverDelegate := TDSServerDriver.Create(LDriverDef);
  Create(TDBXConnectionBuilder(nil));
end;

destructor TDSServerConnection.Destroy;
begin
  Close;
  FreeAndNil(FNextHandler);
  FreeAndNil(FExecuteMessage);
  FreeAndNil(FPrepareMessage);
  FreeAndNil(FCommandCloseMessage);
  FreeAndNil(FConnectMessage);
  FreeAndNil(FDisConnectMessage);
  FreeAndNil(FNextResultMessage);
  FreeAndNil(FTxBeginMessage);
  FreeAndNil(FTxEndMessage);
  FreeAndNil(FConHandler);                     
  inherited Destroy;
end;

function TDSServerConnection.GetDatabaseMetaData: TDBXDatabaseMetaData;
begin
  if FDatabaseMetaData = nil then
  begin
    FDatabaseMetaData := TDBXDatabaseMetaData.Create(FDBXContext);
    //FDatabaseMetaData.Init(Self);  // TODO
  end;
  Result := FDatabaseMetaData;
end;

//    Diagnostic.freeAndNullout(conHandler);

procedure TDSServerConnection.InitSharedConnectionHandler(const ASharedHandler: TDSServerConnectionHandler);
begin
  FConHandler.InitSharedConnectionHandler(ASharedHandler);
end;

function TDSServerConnection.CreateCommand: TDBXCommand;
var
  Command: TDSServerCommand;
begin
  Command := TDSServerCommand.Create(FDbxContext, self, FConHandler);
  Result := Command;
end;

                                                
procedure TDSServerConnection.DerivedOpen;
var
  Session: TDSSession;
  LChannel: TDBXLocalChannel;
  LChannelInfo: TDBXChannelInfo;
  LClientInfo: TDBXClientInfo;
begin
  FConnectMessage.ConnectProperties := FConnectionProperties;
  if SameText(FConnectionProperties.Values[ 'InProcessServer' (*TDBXPropertyNames.InprocessServer*) ], 'REST') then
  begin
    FNextHandler := TDSVoidConnectionHandler.Create(FDbxContext);
    LChannel := nil;
    try
      LChannel := TDBXLocalChannel.Create(FConnectionProperties[TDBXPropertyNames.HostName]);
      LChannelInfo := LChannel.ChannelInfo;
      LClientInfo.IpAddress := LChannel.ChannelInfo.Info;
      LClientInfo.Protocol := FConnectionProperties[TDBXPropertyNames.CommunicationProtocol];
      LChannelInfo.ClientInfo := LClientInfo;
    except
    end;
    FConHandler := TDSServerConnectionHandler.Create(FDbxContext, FNextHandler, LChannel);
    FConHandler.ServerConnection := self;
    if FDSServer <> nil then
      FConHandler.Server := FDSServer
    else
      FConHandler.Server := TDSServer.FindCustomServer(FConnectionProperties[TDBXPropertyNames.DriverName]);
    FConHandler.DbxConnect(FConnectMessage);
  end
  else
  begin
    TMonitor.Enter(self);
    try
      begin
        if FConHandler = nil then
        begin
          FNextHandler := TDSVoidConnectionHandler.Create(FDbxContext);

          LChannel := nil;
          Session := TDSSessionManager.GetThreadSession;
          if Session <> nil then
          begin
            try
                                                                            
              LChannel := TDBXLocalChannel.Create(Session.GetData('RemoteIP'));
              LChannelInfo := LChannel.ChannelInfo;
              LClientInfo.IpAddress := LChannel.ChannelInfo.Info;
              LClientInfo.Protocol := Session.GetData('CommunicationProtocol');
              LClientInfo.AppName := Session.GetData('RemoteAppName');
              LChannelInfo.ClientInfo := LClientInfo;
            except
            end;
          end;

          FConHandler := TDSServerConnectionHandler.Create(FDbxContext, FNextHandler, LChannel);
          FConHandler.ServerConnection := self;
          FConHandler.Server := TDSServer.FindCustomServer(FConnectionProperties[TDBXPropertyNames.DriverName]);
          FConHandler.DbxConnect(FConnectMessage);
        end;
      end
    finally
      TMonitor.Exit(self);
    end
  end;

end;

function TDSServerConnection.CreateAndBeginTransaction(const IsolationLevel: Integer): TDBXTransaction;
begin
  Result := nil;
end;

procedure TDSServerConnection.Commit(const Transaction: TDBXTransaction);
begin
  FTxEndMessage.Commit := True;
  FConHandler.DbxTxEnd(FTxEndMessage);
end;

procedure TDSServerConnection.Rollback(const Transaction: TDBXTransaction);
begin
  FTxEndMessage.Commit := True;
  FConHandler.DbxTxEnd(FTxEndMessage);
end;

procedure TDSServerConnection.DerivedGetCommandTypes(const List: TStrings);
begin
end;

procedure TDSServerConnection.DerivedGetCommands(const CommandType: string; const List: TStrings);
begin
end;

procedure TDSServerConnection.DerivedClose;
begin
  if FConHandler <> nil then
    FConHandler.DbxDisconnect(FDisConnectMessage);
end;

constructor TDSServerConnectionHandler.Create(const ADbxContext: TDBXContext; const ANextHandler: TDBXConnectionHandler; const AChannel: TDbxChannel);
begin
  inherited Create(ADbxContext);
  SetLength(FCommandHandlers,16);
  FNextHandler := ANextHandler;
  FChannel := AChannel;
  FErrorMessage := TDBXErrorMessage.Create;
end;

destructor TDSServerConnectionHandler.Destroy;
var
  DatabaseServerConnectionHandler: TDSServerConnectionHandler;
begin
  if FTransport <> nil then
    FTransport.RemoveConnection(self);
  FreeAndNil(FDatabaseConnectionHandler);
  FreeAndNil(FInstanceProvider);
  FreeObjectArray(TDBXFreeArray(FCommandHandlers));
  FCommandHandlers := nil;
  FreeAndNil(FErrorMessage);
  FreeAndNil(FChannel);
  DestroyEventObjects;
  if FServerCon <> nil then
  begin
    DatabaseServerConnectionHandler := FServerCon.ServerConnectionHandler;
    if DatabaseServerConnectionHandler = self then
    begin
      FServerCon.FConHandler := nil;
      FreeAndNil(FServerCon)
    end
    else
    begin
      DatabaseServerConnectionHandler.Free;
      FServerCon := nil;
    end;
  end;
  FreeAndNil(FScanner);
  inherited Destroy;
end;

function TDSServerConnectionHandler.ClearResources: Boolean;
var
  Clear: Boolean;
  Handle: Integer;
begin
  Clear := True;
  for Handle := 0 to Length(FCommandHandlers) - 1 do
  begin
    if FCommandHandlers[Handle] <> nil then
      Clear := FCommandHandlers[Handle].ClearResources and Clear;
  end;
  Result := Clear;
end;

procedure TDSServerConnectionHandler.SetServerConnection(const AServerCon: TDSServerConnection);
begin
  TMonitor.Enter(self);
  try
  begin
    if FServerCon = nil then
      FServerCon := AServerCon;
  end
  finally
    TMonitor.Exit(self);
  end

end;

procedure TDSServerConnectionHandler.InitSharedConnectionHandler(const ASharedHandler: TDSServerConnectionHandler);
begin
  TMonitor.Enter(self);
  try
  begin
    if (FSharedConHandler = nil) and (ASharedHandler <> self) then
      FSharedConHandler := ASharedHandler;
  end
  finally
    TMonitor.Exit(self);
  end

end;

procedure TDSServerConnectionHandler.FetchServerConnection;
var
  Props: TDBXProperties;
begin
  if FServerCon = nil then
    TMonitor.Enter(self);
    try
    begin
      if FServerCon = nil then
      begin
        Props := TDBXProperties.Create;
        try
          FServerCon := TDSServerConnection(Server.GetServerConnection(Props));
          FServerCon.InitSharedConnectionHandler(self);
        finally
          FreeAndNil(Props);
        end;
      end;
    end
    finally
      TMonitor.Exit(self);
    end

end;

function TDSServerConnectionHandler.CreateInstance(const ServerClass: TDSCustomServerClass; const DsClass: TDSClass): TObject;
var
  Instance: TObject;
begin
  if ServerClass <> nil then
  begin
    FCreateInstanceEventObject.ServerClassInstance := nil;
    ServerClass.CreateInstance(FCreateInstanceEventObject);
    Instance := FCreateInstanceEventObject.ServerClassInstance;
    if Instance <> nil then
      Exit(Instance);
  end;
  Result := DsClass.CreateInstance;
end;

procedure TDSServerConnectionHandler.DestroyInstance(const ServerClass: TDSCustomServerClass; const Instance: TObject);
begin
  if ServerClass <> nil then
  begin
    FDestroyInstanceEventObject.ServerClassInstance := Instance;
    ServerClass.DestroyInstance(FDestroyInstanceEventObject);
    FDestroyInstanceEventObject.ServerClassInstance.Free;
    FDestroyInstanceEventObject.ServerClassInstance := nil;
  end
  else 
    Instance.Free;
end;

procedure TDSServerConnectionHandler.InitServerMethodEventObject(EventObject: TDSServerMethodUserEventObject; const MethodAlias: string; const ServerMethod: TDSServerMethod;
  const UserName: string; const UserRoles, AuthorizedRoles, DeniedRoles: TStrings);
var
  ServerClass: TDSCustomServerClass;
begin
  EventObject.FMethodAlias := MethodAlias;
  ServerClass := ServerMethod.ServerClass;
  EventObject.ServerClass := ServerClass;
  EventObject.FMethodInstance := ServerMethod.MethodInstance;
  EventObject.FUserName := UserName;

  EventObject.FUserRoles.Free;
  EventObject.FAuthorizedRoles.Free;
  EventObject.FDeniedRoles.Free;

  EventObject.FUserRoles := nil;
  EventObject.FAuthorizedRoles := nil;
  EventObject.FDeniedRoles := nil;

  if Assigned(UserRoles) then
  begin
    EventObject.FUserRoles := TStringList.Create;
    EventObject.FUserRoles.AddStrings(UserRoles);
  end;

  if Assigned(AuthorizedRoles) then
  begin
    Eventobject.FAuthorizedRoles := TStringList.Create;
    Eventobject.FAuthorizedRoles.AddStrings(AuthorizedRoles);
  end;

  if Assigned(DeniedRoles) then
  begin
    EventObject.FDeniedRoles := TStringList.Create;
    EventObject.FDeniedRoles.AddStrings(DeniedRoles);
  end;
end;

function TDSServerConnectionHandler.GetAuthorizeMethodEventObject(
  const ServerMethod: TDSServerMethod;
  const UserName: string; const UserRoles, AuthorizedRoles, DeniedRoles: TStrings): TDSAuthorizeEventObject;
begin
  InitServerMethodEventObject(FAuthorizeEventObject, ServerMethod.MethodInfo.MethodAlias, ServerMethod, UserName,
  UserRoles, AuthorizedRoles, DeniedRoles);
  Result := FAuthorizeEventObject;
end;

procedure TDSServerConnectionHandler.PrepareServerMethod(const MethodAlias: string; const ServerMethod: TDSServerMethod;
  const UserName: string; const UserRoles, AuthorizedRoles, DeniedRoles: TStrings);
begin
  InitServerMethodEventObject(FPrepareEventObject, MethodAlias, ServerMethod, UserName, UserRoles, AuthorizedRoles, DeniedRoles);
  if FPrepareEventObject.ServerClass <> nil then
    FPrepareEventObject.ServerClass.Preparing(FPrepareEventObject);
  FServer.Preparing(FPrepareEventObject);
end;

function TDSServerConnectionHandler.GetSQLScanner: TDBXSqlScanner;
begin
  if FScanner = nil then
    FScanner := TDBXSqlScanner.Create('"', '"', '"');
  Result := FScanner;
end;

function TDSServerConnectionHandler.UsesDbxParameters: Boolean;
begin
  Result := True;
end;

function TDSServerConnectionHandler.GetProductName: string;
begin
  Result := FDatabaseConnectionHandler.ProductName;
end;

function TDSServerConnectionHandler.AddCommandHandler(const Handler: TDBXCommandHandler): Integer;
var
  EndState: Integer;
  TempCommandHandlers: TDBXCommandHandlerArray;
  Index: Integer;
begin
  EndState := Length(FCommandHandlers);
  while FLastCommandHandler < EndState do
  begin
    if FCommandHandlers[FLastCommandHandler] = nil then
      break;
    Inc(FLastCommandHandler);
  end;
  if FLastCommandHandler = EndState then
  begin
    SetLength(TempCommandHandlers,EndState + 8);
    for Index := 0 to EndState - 1 do
      TempCommandHandlers[Index] := FCommandHandlers[Index];
    FCommandHandlers := TempCommandHandlers;
  end;
  FCommandHandlers[FLastCommandHandler] := Handler;
  Handler.CommandHandle := FLastCommandHandler;
  Result := FLastCommandHandler;
end;

procedure TDSServerConnectionHandler.FreeCommandHandler(const Handler: TDBXCommandHandler);
var
  Handle: Integer;
begin
  Handle := Handler.CommandHandle;
  if Handle < FLastCommandHandler then
    FLastCommandHandler := Handle;
  FCommandHandlers[Handle] := nil;
  Handler.Free;
end;

function TDSServerConnectionHandler.GetCommandHandler(const Handle: Integer): TDBXCommandHandler;
begin
  if Handle < 0 then
    raise TDBXError.Create(TDBXErrorCodes.InvalidHandle, SCommandClosed);
  if (Handle >= Length(FCommandHandlers)) or (FCommandHandlers[Handle] = nil) then
    raise TDBXError.Create(TDBXErrorCodes.InvalidArgument, Format(SInvalidCommandHandle, [IntToStr(Handle)]), nil);
  Result := FCommandHandlers[Handle];
end;

procedure TDSServerConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

function TDSServerConnectionHandler.GetInstance(const ClassInfo: TDSClassInfo): TObject;
begin
  if FSharedConHandler <> nil then
    Result := FSharedConHandler.GetInstance(ClassInfo)
  else 
  begin
    if FInstanceProvider = nil then
      FInstanceProvider := TDSHashtableInstanceProvider.Create(DBXContext, Server, FTransport, DbxConnection);
    Result := FInstanceProvider.GetInstance(self, ClassInfo);
  end;
end;

function TDSServerConnectionHandler.IsCall(const CommandText: string): Integer;
var
  Count, Index: Integer;
  Ch: Char;
begin
  Count := CommandText.Length;
  for Index := 0 to Count - 1 do
    case CommandText.Chars[Index] of
      ' ',
      #$9,
      #$d,
      #$a:;
      'C',
      'c':
        begin
          if (Count - Index) > 5 then
          begin
            Ch := CommandText.Chars[Index + 1];
            if (Ch = 'A') or (Ch = 'a') then
            begin
              Ch := CommandText.Chars[Index + 2];
              if (Ch = 'L') or (Ch = 'l') then
              begin
                Ch := CommandText.Chars[Index + 3];
                if (Ch = 'L') or (Ch = 'l') then
                  case CommandText.Chars[Index + 4] of
                    ' ',
                    #$9,
                    #$d,
                    #$a:
                      Exit(Index);
                  end;
              end;
            end;
          end;
          Exit(-1);
        end;
      else
        Exit(-1);
    end;
  Result := -1;
end;

function TDSServerConnectionHandler.FirstToken(const CommandText: string): string;
var
  Count: Integer;
  StartIndex: Integer;
  Index: Integer;
begin
  Count := CommandText.Length;
  Index := 0;
  StartIndex := 0;
  while Index < Count do
  begin
    case CommandText.Chars[Index] of
      ' ',
      #$9,
      #$d,
      #$a,
      '"':;
      else
        begin
          StartIndex := Index;
          Index := Index + 1;
          while Index < Count do
          begin
            case CommandText.Chars[Index] of
              ' ',
              #$9,
              #$d,
              #$a,
              '"',
              '(':
                Exit(CommandText.Substring(StartIndex, Index - StartIndex));
            end;
            Index := Index + 1;
          end;
        end;
    end;
    Index := Index + 1;
  end;
  Result := CommandText.Substring(StartIndex, Index - StartIndex);
end;

function TDSServerConnectionHandler.ScanMetaDataParameter(const InCommandText: string): string;
var
  CommandText: string;
begin
  CommandText := InCommandText;
  while True do
  begin
    if FScanner.NextToken = TDBXSqlScanner.TokenId then
      CommandText := CommandText + FScanner.Id
    else
      break;
    if FScanner.NextToken = TDBXSqlScanner.TokenPeriod then
      CommandText := CommandText + '.'
    else 
      break;
  end;
  Result := CommandText;
end;

function TDSServerConnectionHandler.ConvertMetaDataCommandToServerMethodHandler(const Message: TDBXCommandMessage): Boolean;
var
  CommandText, CommandType: string;
  PrevScanner, Scanner: TDBXSqlScanner;
  OwnScanner: Boolean;
begin
  CommandType := Message.CommandType;
  CommandText := Message.Command;
  PrevScanner := nil;
  if (CommandType = TDBXCommandTypes.DbxMetadata) then
  begin
    if Assigned(DbxConnection) and Assigned(DbxConnection.DatabaseMetaData) then
    begin
      //Default SQLScanner uses " quote characters, but use the specific
      //quote characters specified in the database metadata if available
      Scanner := TDBXSqlScanner.Create(DbxConnection.DatabaseMetaData.QuoteChar,
                                       DbxConnection.DatabaseMetaData.QuotePrefix,
                                       DbxConnection.DatabaseMetaData.QuoteSuffix);
      PrevScanner := FScanner;
      FScanner := Scanner;
      OwnScanner := False;
    end
    else
    begin
      Scanner := SQLScanner;
      OwnScanner := True;
    end;
    try
      Scanner.Init(CommandText);
      if Scanner.NextToken = TDBXSqlScanner.TokenId then
      begin
        if string.Compare(Scanner.Id, TDBXMetaDataCommands.GetProcedures, True) = 0 then
        begin
          CommandText := TDSMetadataMethods.GetProcedures + '("';
          CommandText := ScanMetaDataParameter(CommandText);
          CommandText := CommandText + '", "';
          CommandText := ScanMetaDataParameter(CommandText);
          CommandText := CommandText + '")';
          Message.Command := CommandText;
          Message.CommandType := TDBXCommandTypes.DsServerMethod;
          Exit(True);
        end
        else if string.Compare(Scanner.Id, TDBXMetaDataCommands.GetProcedureParameters, True) = 0 then
        begin
          CommandText := TDSMetadataMethods.GetProcedureParameters + '("';
          CommandText := ScanMetaDataParameter(CommandText);
          CommandText := CommandText + '")';
          Message.Command := CommandText;
          Message.CommandType := TDBXCommandTypes.DsServerMethod;
          Exit(True);
        end;
      end;
    finally
      if not OwnScanner then
      begin
        Scanner.Free;
        FScanner := PrevScanner;
      end;
    end;
  end;
  Result := False;
end;

function TDSServerConnectionHandler.AcquireNewCommandHandler(const Message: TDBXCommandMessage; const InNextCommandHandler: TDBXCommandHandler): TDBXCommandHandler;
var
  DatabaseHandler, NextCommandHandler: TDBXCommandHandler;
  CommandText, CommandType, ServerMethodText: string;
  CallIndex: Integer;
  ConvertToServerMethod: Boolean;
  ServerHandler: TDSServerMethodCommandHandler;
begin
  NextCommandHandler := InNextCommandHandler;
  CommandType := Message.CommandType;
  CommandText := Message.Command;
  CallIndex := IsCall(CommandText);
  ServerMethodText := CommandText;
  ConvertToServerMethod := False;
  if CallIndex > -1 then
  begin
    ServerMethodText := CommandText.Substring(CallIndex + 5, CommandText.Length - (CallIndex + 5));
    if (string.Compare(CommandType, TDBXCommandTypes.DsServerMethod, True) = 0) then
      Message.Command := ServerMethodText
    else if FServer.ServerMethodProvider.HasServerMethod(FirstToken(ServerMethodText)) then
      ConvertToServerMethod := True;
  end
  else if string.Compare(CommandType, TDBXCommandTypes.DbxStoredProcedure, True) = 0 then
  begin
    if FServer.ServerMethodProvider.HasServerMethod(FirstToken(ServerMethodText)) then
      ConvertToServerMethod := True;
  end;
  if ConvertToServerMethod then
  begin
    CommandType := TDBXCommandTypes.DsServerMethod;
    Message.CommandType := CommandType;
    Message.Command := ServerMethodText;
  end;
  if string.Compare(CommandType, TDBXCommandTypes.DsServerMethod, True) = 0 then
  begin
    if NextCommandHandler = nil then
      NextCommandHandler := FNextHandler.AcquireCommandHandler(Message);
    ServerHandler := TDSServerMethodCommandHandler.Create(DBXContext, self, NextCommandHandler);
    ServerHandler.ServerConnection := self;
    AddCommandHandler(ServerHandler);
    Message.CommandHandle := ServerHandler.CommandHandle;
    Exit(ServerHandler);
  end
  else if FHasServerConnection then
  begin
    if ConvertMetaDataCommandToServerMethodHandler(Message) then
      Exit(AcquireCommandHandler(Message))
    else 
    begin
      DatabaseHandler := FDatabaseConnectionHandler.AcquireCommandHandler(Message);
      AddCommandHandler(DatabaseHandler);
      Message.CommandHandle := DatabaseHandler.CommandHandle;
      Exit(DatabaseHandler);
    end;
  end
  else if (string.Compare(CommandText, TDBXMetaDataCommands.GetDatabase, True) = 0) and (Message.CommandType = TDBXCommandTypes.DbxMetadata) then
  begin
    Message.Command := TDSMetadataMethods.GetDatabase;
    Message.CommandType := TDBXCommandTypes.DsServerMethod;
    Exit(AcquireCommandHandler(Message));
  end
  else if ConvertMetaDataCommandToServerMethodHandler(Message) then
    Exit(AcquireCommandHandler(Message));
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, Format(SUnrecognizedCommandType, [Message.CommandType]));
end;

function TDSServerConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
var
  CommandHandle: Integer;
begin
  CommandHandle := Message.CommandHandle;
  if CommandHandle >= 0 then
    Result := FCommandHandlers[CommandHandle]
  else 
    Result := AcquireNewCommandHandler(Message, nil);
end;

function TDSServerConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := True;
end;

procedure TDSServerConnectionHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  try
    FErrorEventObject.Error := Message.Error;
    FServer.Error(FErrorEventObject);
  except
    on Ex: Exception do
    begin
    end;
  end;
  FNextHandler.DbxErrorMessage(Message);
end;

procedure TDSServerConnectionHandler.DbxError(const Ex: Exception);
begin
  FErrorMessage.Error := Ex;
  DbxErrorMessage(FErrorMessage);
end;

procedure TDSServerConnectionHandler.DestroyEventObjects;
begin
  FreeAndNil(FCreateInstanceEventObject);
  FreeAndNil(FDestroyInstanceEventObject);
  FreeAndNil(FPrepareEventObject);
  FreeAndNil(FConnectEventObject);
  FreeAndNil(FErrorEventObject);
  FreeAndNil(FAuthenticateEventObject);
  FreeAndNil(FAuthorizeEventObject);
end;

procedure TDSServerConnectionHandler.CreateEventObjects;
var
  ChannelInfo: TDBXChannelInfo;
begin
  if FChannel = nil then
    ChannelInfo := nil
  else 
    ChannelInfo := FChannel.ChannelInfo;
  DestroyEventObjects;
  FCreateInstanceEventObject := TDSCreateInstanceEventObject.Create(DBXContext, FServer, FTransport, FDbxConnection);
  FCreateInstanceEventObject.FServerConnectionHandler := Self;
  FDestroyInstanceEventObject := TDSDestroyInstanceEventObject.Create(DBXContext, FServer, FTransport, FDbxConnection);
  FDestroyInstanceEventObject.FServerConnectionHandler := Self;
  FPrepareEventObject := TDSPrepareEventObject.Create(DBXContext, FServer, FTransport, FDbxConnection);
  FPrepareEventObject.FServerConnectionHandler := Self;
  FConnectEventObject := TDSConnectEventObject.Create(DBXContext, FServer, FTransport, ChannelInfo, FDbxConnection, FConProperties);
  FConnectEventObject.FServerConnectionHandler := Self;
  FErrorEventObject := TDSErrorEventObject.Create(DBXContext, FServer, FTransport, FDbxConnection);
  FErrorEventObject.FServerConnectionHandler := Self;
  FAuthorizeEventObject := TDSAuthorizeEventObject.Create(DBXContext, FServer, FTransport, FDbxConnection);
  FAuthorizeEventObject.FServerConnectionHandler := Self;
  FAuthenticateEventObject := TDSAuthenticateEventObject.Create(DBXContext, FServer, FTransport, FDbxConnection);
  FAuthenticateEventObject.FServerConnectionHandler := Self;
end;

procedure TDSServerConnectionHandler.SetDbxConnection(const Con: TDBXConnection);
var
  Handler: TDBXDatabaseConnectionHandler;
begin
  FDbxConnection := Con;
  FreeAndNil(FDatabaseConnectionHandler);
  try
    if Con <> nil then
    begin
      Handler := TDBXDatabaseConnectionHandler.Create(DBXContext, FNextHandler);
      Handler.DBXConnection := Con;
      FDatabaseConnectionHandler := Handler;
      FHasServerConnection := True;
    end
    else 
    begin
      FHasServerConnection := False;
      FDatabaseConnectionHandler := TDSDefaultDatabaseConnectionHandler.Create(DBXContext, self, FNextHandler);
      FDatabaseConnectionHandler.DbxOpen(nil);
    end;
  finally
    CreateEventObjects;
  end;
end;

procedure TDSServerConnectionHandler.InitDatabaseConnectionHandler;
var
  ServerConnectionName: string;
  Command: TDBXCommand;
  Parameters: TDBXParameterList;
  Parameter: TDBXParameter;
  NewConnection: TDBXConnection;
begin
  ServerConnectionName := FConProperties[TDBXPropertyNames.ServerConnection];
  if ServerConnectionName.IsEmpty then
    DbxConnection := nil
  else 
  begin
    if FLastCommandHandler > 0 then
      raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, SCloseCommands, nil);
    FetchServerConnection;
    Command := FServerCon.CreateCommand;
    try
      Command.Text := ServerConnectionName;
      Command.CommandType := TDBXCommandTypes.DsServerMethod;
      Command.ExecuteUpdate;
      Parameters := Command.Parameters;
      NewConnection := nil;
      if Parameters.Count > 0 then
      begin
        Parameter := Parameters.Parameter[Parameters.Count - 1];
        if Parameter.DataType = TDBXDataTypes.DbxConnectionType then
          NewConnection := Parameter.Value.GetDBXConnection;
      end;
      DbxConnection := NewConnection;
    finally
      FreeAndNil(Command);
    end;
  end;
end;

procedure TDSServerConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
var
  Builder: TDBXConnectionBuilder;
begin
  Builder := nil;
  try
    FConProperties := Message.ConnectProperties;
    CreateEventObjects;
    Assert(FServer <> nil);
    FServer.Connecting(FConnectEventObject);
    InitDatabaseConnectionHandler;
    Message.ProductName := FDatabaseConnectionHandler.ProductName;
    Message.ConnectionHandle := FConHandle;
    Message.HandleMessage(FNextHandler);
  except
    on Ex: Exception do
    begin
      FreeAndNil(Builder);
      Message.SuccessfulConnect := False;
      DbxError(Ex);
    end;
  end;
end;

procedure TDSServerConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
  FServer.Disconnecting(FConnectEventObject);
  if FDatabaseConnectionHandler <> nil then
    Message.HandleMessage(FDatabaseConnectionHandler);
  if FTransport <> nil then
  begin
    FTransport.Disconnecting(Self);
    FTransport.RemoveConnection(self);
  end;
  Message.HandleMessage(FNextHandler);
end;

procedure TDSServerConnectionHandler.SetTransport(const Transport: TDSServerTransport);
begin
  self.FTransport := Transport;
end;

procedure TDSServerConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
var
  Handler: TDBXCommandHandler;
  Parameters: TDBXParameterList;
  Parameter: TDBXParameter;
  Count: Integer;
  Handle: Integer;
begin
  Handle := Message.CommandHandle;
  if Handle < 0 then
    Handler := AcquireCommandHandler(Message)
  else
    Handler := GetCommandHandler(Handle);
  Handler.DbxExecute(Message);
  Parameters := Message.Parameters;
  if Parameters <> nil then
  begin
    Count := Parameters.Count;
    if Count > 0 then
    begin
      Parameter := Parameters.Parameter[Count - 1];
      if Parameter.DataType = TDBXDataTypes.DbxConnectionType then
      begin
        if FSharedConHandler = nil then
          DbxConnection := Parameter.Value.GetDBXConnection;
      end;
    end;
  end;
end;

procedure TDSServerConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
var
  Handler: TDBXCommandHandler;
begin
  Handler := GetCommandHandler(Message.CommandHandle);
  Handler.DbxNextResult(Message);
end;

procedure TDSServerConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
var
  Handler: TDBXCommandHandler;
  Handle: Integer;
begin
  Handle := Message.CommandHandle;
  if Handle < 0 then
    Handler := AcquireCommandHandler(Message)
  else 
    Handler := GetCommandHandler(Handle);
  Handler.DbxPrepare(Message);
end;

procedure TDSServerConnectionHandler.DbxNext(const Message: TDBXNextMessage);
var
  Handler: TDBXCommandHandler;
begin
  Handler := GetCommandHandler(Message.CommandHandle);
  Handler.DbxNext(Message);
end;

procedure TDSServerConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
var
  Handler: TDBXCommandHandler;
begin
  Handler := GetCommandHandler(Message.CommandHandle);
  Handler.DbxMoreBlob(Message);
end;

procedure TDSServerConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
var
  Handler: TDBXCommandHandler;
begin
  Handler := GetCommandHandler(Message.CommandHandle);
  Handler.DbxCommandClose(Message);
  FreeCommandHandler(Handler);
end;

procedure TDSServerConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
var
  Handler: TDBXCommandHandler;
begin
  Handler := GetCommandHandler(Message.CommandHandle);
  Handler.DbxReaderClose(Message);
end;

procedure TDSServerConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
begin
  FDatabaseConnectionHandler.DbxTxBegin(Message);
  Message.HandleMessage(FNextHandler);
end;

procedure TDSServerConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
  FDatabaseConnectionHandler.DbxTxEnd(Message);
  Message.HandleMessage(FNextHandler);
end;

procedure TDSServerConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
  FDatabaseConnectionHandler.DbxVendorProperty(Message);
  Message.HandleMessage(FNextHandler);
end;

class function TDSServerHelp.GetServerConnectionHandler(const Con: TDSServerConnection): TDSServerConnectionHandler;
begin
  Result := Con.ServerConnectionHandler;
end;

constructor TDSServerMethod.Create;
begin
  inherited Create;
end;

destructor TDSServerMethod.Destroy;
var
  LAdapter: TServerClassAdapter;
begin
  if (FMethodInstance <> FAdapterInstance) and (Lifecycle = TDSLifeCycle.Invocation) then
  begin
    LAdapter := TServerClassAdapterFactory.GetAdapter(sProviderServerAdapter);
    try
      if (LAdapter <> nil) and LAdapter.IsSupportedAdapterType(FAdapterInstance) then
        LAdapter.ClearDataModule(FAdapterInstance);
    finally
      LAdapter.Free;
    end;
    FreeAndNil(FAdapterInstance);
  end;
  FreeAndNil(FParameters);
  FreeAndNil(FMethodValues);
  FDbxParameters := nil;
  inherited Destroy;
end;

procedure TDSServerMethod.Invoke(const Message: TDBXExecuteMessage);
var
  Index: Integer;
  Direction: Integer;
  Count: Integer;
  Parameter: TDBXParameter;
  TableIndex: Integer;
  Value: TDBXWritableValue;
begin
  Count := FParameters.Count;
//    parameters.newRowGeneration();  // forces input parameters to be fetched.
  try
    TableIndex := 0;
    for Index := 0 to Count - 1 do
    begin
      Parameter := FParameters.Parameter[Index];
      if Parameter.ParameterDirection = TDBXParameterDirections.OutParameter then
        Parameter.Value.SetNull
      else 
        case Parameter.DataType of
          TDBXDataTypes.TableType:
            begin
              Direction := FParameters.Parameter[Index].ParameterDirection;
              if (((Direction = TDBXParameterDirections.InParameter) or (Direction = TDBXParameterDirections.InOutParameter))) and (Message.TableReaderCount > 0) then
              begin
                Value := Parameter.Value;
                if not Value.IsNull then
                begin
                  Value.SetDBXReader(Message.GetTableReader(TableIndex), False);
                  Inc(TableIndex);
                end;
              end;
            end;
          TDBXDataTypes.DbxConnectionType:
            begin
              Value := Parameter.Value;
              if FServerConnection.DbxConnection = nil then
                Value.SetNull
              else 
                Value.SetDBXConnection(FServerConnection.DbxConnection);
            end;
          TDBXDataTypes.CallbackType:
            begin
              Value := Parameter.Value;
              if Value.GetCallbackValue is TDBXCallbackDelegate then
              begin
                (TDBXCallbackDelegate(Value.GetCallbackValue)).ConnectionHandler := Message.ConnectionHandler;
                (TDBXCallbackDelegate(Value.GetCallbackValue)).Ordinal := Index;
                (TDBXCallbackDelegate(Value.GetCallbackValue)).DsServer := FServerConnection.Server;
                if (TDBXCallbackDelegate(Value.GetCallbackValue)).Delegate <> nil then
                  (TDBXCallbackDelegate(Value.GetCallbackValue)).Delegate.Free;
                (TDBXCallbackDelegate(Value.GetCallbackValue)).Delegate := TDBXServerCallback.Create;
              end;
            end;
        end;
    end;
    FMethodValues.AssignParameterValues(FDbxParameters);
    FMethod.Invoke(FMethodInstance, FMethodValues);
    TInvocationMetadataDelegate.WriteMetadata(Message.ConnectionHandler);
    Message.HasDBXTableReaderOutOrReturnParameter := False;

    for Index := 0 to Count - 1 do
    begin
      Parameter := FParameters.Parameter[Index];
      case Parameter.ParameterDirection of
        TDBXParameterDirections.OutParameter:
          begin
            FMethodValues.GetOutValue(Parameter);
            case Parameter.DataType of
              TDBXDataTypes.TableType:
                Message.HasDBXTableReaderOutOrReturnParameter := True;
              TDBXDataTypes.DbxConnectionType:
                FServerConnection.DbxConnection := Parameter.Value.GetDBXConnection;
            end;
          end;
        TDBXParameterDirections.InOutParameter:
          begin
            if not Parameter.ValueParameter then
              FMethodValues.GetOutValue(Parameter)
            else
              Parameter.Value.MarkAsPending;
            if Parameter.DataType = TDBXDataTypes.TableType then
              Message.HasDBXTableReaderOutOrReturnParameter := True;
          end;
        TDBXParameterDirections.ReturnParameter:
          begin
            FMethodValues.GetReturnValue(Parameter);
            case Parameter.DataType of
              TDBXDataTypes.TableType:
                Message.HasDBXTableReaderOutOrReturnParameter := True;
              TDBXDataTypes.DbxConnectionType:
                FServerConnection.DbxConnection := Parameter.Value.GetDBXConnection;
            end;
          end;
      end;
    end;

    Message.HasOutOrReturnParameters := FHasOutOrReturnParameters;
    Message.Row := FRow;
    Message.Parameters := FParameters;
    FParameters.SetOutParameters;
  finally
    Message.FreeTableReaders;
    TInvocationMetadataDelegate.ClearMetadata(Message.ConnectionHandler);
  end;
end;

procedure TDSServerMethod.SetServerSideCommand(const ServerSide: Boolean);
begin
  FMethodValues.ServerSideCommand := ServerSide;
end;

procedure TDSServerMethod.SetParameters(const Parameters: TDBXServerParameterList);
var
  Ordinal, ParamCount: Integer;
begin
  FParameters := Parameters;
  ParamCount := Parameters.Count;
  if ParamCount > 0 then
  begin
    if Parameters.Parameter[ParamCount - 1].ParameterDirection = TDBXParameterDirections.ReturnParameter then
      Dec(ParamCount);
  end;
  if Parameters <> nil then
  begin
    SetLength(FDbxParameters,ParamCount);
    for Ordinal := 0 to Length(FDbxParameters) - 1 do
      FDbxParameters[Ordinal] := Parameters.Parameter[Ordinal];
  end;
end;

function TDSServerMethod.ClearResources: Boolean;
begin
  Result := self.FMethodValues.ClearReferenceParameters;
end;

constructor TDSServerMethodCommandHandler.Create(const ADbxContext: TDBXContext; const AServerCon: TDSServerConnectionHandler; const ANextHandler: TDBXCommandHandler);
begin
  inherited Create(ADbxContext);
  FServerCon := AServerCon;
  FNextHandler := ANextHandler;
end;

destructor TDSServerMethodCommandHandler.Destroy;
begin
  DestroyServerMethod;
  inherited Destroy;
end;

procedure TDSServerMethodCommandHandler.DestroyInstance;
var
  MethodInstance: TObject;
  LAdapter: TServerClassAdapter;
begin
  if FServerMethod <> nil then
  begin
    MethodInstance := FServerMethod.MethodInstance;
    if MethodInstance <> nil then
    begin
      if FServerMethod.AdapterInstance = MethodInstance then
        FServerMethod.AdapterInstance := nil;
      FServerCon.DestroyInstance(FServerMethod.ServerClass, MethodInstance);
      LAdapter := TServerClassAdapterFactory.GetAdapter(sProviderServerAdapter);
      try
        if (LAdapter <> nil) and LAdapter.IsSupportedAdapterType(FServerMethod.AdapterInstance) and
           (LAdapter.GetDataModule(FServerMethod.AdapterInstance) = FServerMethod.MethodInstance) then
          LAdapter.ClearDataModule(FServerMethod.AdapterInstance);
      finally
        LAdapter.Free;
      end;
      FServerMethod.MethodInstance := nil;
    end;
  end;
end;

procedure TDSServerMethodCommandHandler.DestroyServerMethod;
begin
  if FHasInvocationLifeCycle then
    DestroyInstance;
  FreeAndNil(FServerMethod);
end;

procedure TDSServerMethodCommandHandler.InitInvocationLifeCycle;
var
  LifeCycle: string;
begin
  LifeCycle := FServerMethod.MethodInfo.DSClassInfo.LifeCycle;
  if (not LifeCycle.IsEmpty) and (LifeCycle = TDSLifeCycle.Invocation) then
    FHasInvocationLifeCycle := True
  else 
    FHasInvocationLifeCycle := False;
end;

function TDSServerMethodCommandHandler.ClearResources: Boolean;
begin
  if FServerMethod <> nil then
    Exit(FServerMethod.ClearResources);
  Result := True;
end;

procedure TDSServerMethodCommandHandler.DbxExecute(const Message: TDBXExecuteMessage);
var
  Session: TDSSession;
  AuthorizedRoles, DeniedRoles: TStrings;
begin
  ActiveStreamerRowList.CloseAllActiveTableReaders;
  if FServerMethod = nil then
  begin
    FServerMethod := FServerCon.Server.ServerMethodProvider.PrepareMethod(FServerCon, Message, ActiveStreamerRowList, FNextHandler.CreateDbxRow);
    InitInvocationLifeCycle;
  end
  else 
  begin
    if FHasInvocationLifeCycle and FHasExecuted and (FServerMethod <> nil) then
    begin
      DestroyInstance;
      FServerMethod.AdapterInstance.Free;
      FServerMethod.AdapterInstance :=  FServerCon.Server.ServerMethodProvider.GetServerMethodInstance(FServerCon, FServerMethod.MethodInfo);
      FServerMethod.MethodInstance := FServerMethod.MethodInfo.DSMethod.GetClassInstance(FServerMethod.AdapterInstance);
    end;
    FServerMethod.Parameters.NewRowGeneration;
  end;
  FHasExecuted := True;

  // check the user access rights against the method attribute
  Session := TDSSessionManager.GetThreadSession;

  AuthorizedRoles := nil;
  DeniedRoles := nil;

  try
    if (Session <> nil) and Session.RequiresAuthorization(FServerMethod.MethodInfo) then
    begin
      Session.GetAuthRoles(FServerMethod, AuthorizedRoles, DeniedRoles);
      if not Session.Authorize(FServerCon.GetAuthorizeMethodEventObject(FServerMethod,
        Session.UserName, Session.UserRoles, AuthorizedRoles, DeniedRoles)) then
        //should this error be thrown if Session is nil?
        raise TDBXError.Create(TDBXErrorCodes.AuthorizationFailed, Format(SAuthorizationFail, [Session.UserName]));
    end;

    FServerMethod.Invoke(Message);
    Message.ActiveStreamerRowList := ActiveStreamerRowList;
    Message.HandleMessage(FNextHandler);
  finally
    FreeAndNil(AuthorizedRoles);
    FreeAndNil(DeniedRoles);
    if FHasInvocationLifeCycle then
      DestroyInstanceIfNotNeeded;
  end;
end;

procedure TDSServerMethodCommandHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
  DestroyServerMethod;
  FServerMethod := FServerCon.Server.ServerMethodProvider.PrepareMethod(FServerCon, Message, ActiveStreamerRowList, FNextHandler.CreateDbxRow);
  FHasExecuted := False;
  InitInvocationLifeCycle;
  FServerMethod.ServerSideCommand := Message.ServerSideCommand;
  Message.Parameters := FServerMethod.Parameters;
  Message.HandleMessage(FNextHandler);
end;

procedure TDSServerMethodCommandHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

procedure TDSServerMethodCommandHandler.DestroyInstanceIfNotNeeded;
var
  List: TDBXActiveTableReaderList;
begin
  List := ActiveStreamerRowList;
  if (List = nil) or List.Eos then
    DestroyInstance;
end;

procedure TDSServerMethodCommandHandler.DbxNext(const Message: TDBXNextMessage);
begin
  Message.ActiveStreamerRowList := ActiveStreamerRowList;
  Message.HandleMessage(FNextHandler);
  if FHasInvocationLifeCycle then
    DestroyInstanceIfNotNeeded;
end;

procedure TDSServerMethodCommandHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
var
  Item: TDBXActiveTableReaderItem;
  Value: TDBXValue;
  StreamReader: TDBXStreamReader;
begin
  Item := ActiveStreamerRowList.FindStreamerRowItem(Message.RowHandle);
  if Item.ParameterList <> nil then
    Value := Item.ParameterList.Parameter[Message.Ordinal].Value
  else 
    Value := Item.Reader.Value[Message.Ordinal];
  StreamReader := TDBXDriverHelp.GetStreamReader(TDBXStreamValue(Value));
  Message.StreamReader := StreamReader;
  Message.HandleMessage(FNextHandler);
  if FHasInvocationLifeCycle then
  begin
    Item.SetParameterEos(Message.Ordinal, Message.Eos);
    DestroyInstanceIfNotNeeded;
  end;
end;

procedure TDSServerMethodCommandHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

procedure TDSServerMethodCommandHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

procedure TDSServerMethodCommandHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  Message.HandleMessage(FNextHandler);
end;

constructor TDSServerMethodProvider.Create;
begin
  inherited Create;
end;

destructor TDSServerMethodProvider.Destroy;
begin
  FreeAndNil(FPackageTable);
  FreeAndNil(FClassTable);
  FreeAndNil(FClassList);
  FreeAndNil(FMethodTable);
  FreeAndNil(FMethodSearchNameList);
  FreeAndNil(FStreamerTable);
  FreeAndNil(FServerInstanceProvider);
  inherited Destroy;
end;

function TDSServerMethodProvider.GetClassInfo(const ClassName: string): TDSClassInfo;
var
  Obj: TObject;
begin
  Obj := FClassTable[ClassName];
  if Obj = nil then
    Exit(nil);
  Result := TDSClassInfo(Obj);
end;

procedure TDSServerMethodProvider.GetServerClasses(const ServerCon: TDSServerConnectionHandler; const Classes: TDSClassEntity);
var
  Count: Integer;
  ClassInfo: TDSClassInfo;
  Index: Integer;
begin
  Count := FClassList.Count;
  for Index := 0 to Count - 1 do
  begin
    ClassInfo := TDSClassInfo(FClassTable[string(FClassList[Index])]);
    Classes.Table.Insert;
    Classes.LifeCycle := ClassInfo.LifeCycle;
    Classes.PackageName := ClassInfo.PackageName;
    Classes.RoleName := ClassInfo.RoleName;
    Classes.ServerClassName := ClassInfo.DSClassName;
    Classes.Table.Post;
  end;
end;

procedure TDSServerMethodProvider.GetServerClasses(const Container: TJSONArray);
var
  Count: Integer;
  ClassInfo: TDSClassInfo;
  Index: Integer;
begin
  Count := FClassList.Count;
  for Index := 0 to Count - 1 do
  begin
    ClassInfo := TDSClassInfo(FClassTable[string(FClassList[Index])]);
    Container.AddElement(TJSONString.Create(ClassInfo.DSClassName));
  end;
end;

procedure TDSServerMethodProvider.GetServerClass(const ClassName: string; const Container: TJSONObject);
var
  ClassInfo: TDSClassInfo;
  ClassMeta: TJSONObject;
  MethodList: TJSONArray;
begin
  ClassInfo := TDSClassInfo(FClassTable[ClassName]);
  if ClassInfo <> nil then
  begin
    ClassMeta := TJSONObject.Create;
    Container.AddPair(TJSONString.Create(ClassName), ClassMeta);
    ClassMeta.AddPair(TJSONString.Create(TDSClassColumns.LifeCycle), TJSONString.Create(ClassInfo.LifeCycle));
//      classMeta.addPair(new JSONString(DSClassColumns.ROLE_NAME),
//          new JSONString(classInfo.getRoleName()));
    MethodList := TJSONArray.Create;
    ClassMeta.AddPair(TJSONString.Create('methods'), MethodList);
    GetServerMethods(ClassName, MethodList);
  end
  else 
    Container.AddPair(TJSONString.Create(ClassName), TJSONNull.Create);
end;

procedure TDSServerMethodProvider.AddServerClass(const ClassInfo: TDSClassInfo);
var
  DsPackage: TDSPackage;
  DsClass: TDSClass;
  Obj: TObject;
  ClassName: string;
begin
  ClassName := ClassInfo.DSClassName;
  Obj := FClassTable[ClassName];
  if Obj = nil then
  begin
    DsClass := ClassInfo.DSClass;
    if DsClass = nil then
    begin
      DsPackage := TDSPackage(FPackageTable[ClassInfo.PackageName]);
      DsClass := DsPackage.CreateDSClass(ClassName);
      if not DsClass.ClassLoadError.IsEmpty then
        raise TDBXError.Create(TDBXErrorCodes.ServerClassMissing, DsClass.ClassLoadError);
      ClassInfo.DSClass := DsClass;
    end;
    FClassTable[ClassName] := ClassInfo;
    FClassList.Add(ClassName);
  end
  else 
    raise TDBXError.Create(TDBXErrorCodes.ServerClassExists, Format(SServerClassExists, [ClassName]));
end;

procedure TDSServerMethodProvider.DropServerClass(const ServerClassName: string);
var
  ClassInfoObject: TObject;
  ClassInfo: TDSClassInfo;
  MethodInfo: TDSMethodInfo;
  Count: Integer;
  MethodIndex: Integer;
  ClassIndex: Integer;
begin
  ClassInfoObject := FClassTable[ServerClassName];
  if ClassInfoObject = nil then
    raise TDBXError.Create(TDBXErrorCodes.ServerClassMissing, Format(SServerClassMissing, [ServerClassName]));
  ClassInfo := TDSClassInfo(ClassInfoObject);
  Count := FMethodSearchNameList.Count;
  MethodIndex := 0;
  while MethodIndex < Count do
  begin
    MethodInfo := TDSMethodInfo(FMethodTable[(string(FMethodSearchNameList[MethodIndex]))]);
    if MethodInfo.DSClassInfo = ClassInfo then
    begin
      DropServerMethod(MethodInfo, MethodIndex);
      Dec(Count);
      Dec(MethodIndex);
    end;
    Inc(MethodIndex);
  end;
  ClassInfo.Close;
  Count := FClassList.Count;
  ClassIndex := 0;
  while ClassIndex < Count do
  begin
    if ((string(FClassList[ClassIndex])) = ServerClassName) then
    begin
      FClassList.Delete(ClassIndex);
      Dec(Count);
      Dec(ClassIndex);
    end;
    Inc(ClassIndex);
  end;
  FClassTable.Delete(ServerClassName);
end;

function TDSServerMethodProvider.IsCallableMethod(const Method: TDSMethod): Boolean;
begin
  if not Method.PublicMethod then
    Exit(False);
  if Method.StaticMethod then
    Exit(False);
  Result := True;
end;

function TDSServerMethodProvider.CreateMethodAlias(const MethodClass: TDSMethod): string;
var
  Alias: string;
  DsClass: TDSClass;
  ServerMethodClassName: string;
  LastDot: Integer;
begin
  DsClass := MethodClass.MethodClass;
  if DsClass.AdapteeDSClass <> nil then
    DsClass := DsClass.AdapteeDSClass;
  ServerMethodClassName := DsClass.DSClassName;
  LastDot := ServerMethodClassName.LastIndexOf('.');
  if LastDot < 0 then
    Alias := ServerMethodClassName
  else 
    Alias := ServerMethodClassName.Substring(LastDot + 1, ServerMethodClassName.Length - (LastDot + 1));
  Alias := Alias + '.' + MethodClass.DSMethodName;
  Result := Alias;
end;

procedure TDSServerMethodProvider.AddAllMethods(ARTTICtx: TRTTIContext; const ClassInfo: TDSClassInfo);
var
  BuiltinMethods: TDSMethodArray;
  BuiltinClass: TDSClass;
  BuiltinMethod: TDSMethod;
  MethodInfo: TDSMethodInfo;
  Index: Integer;
  typeCtx: TRTTIType;
  classAuthRole, codeRole: TRoleAuth;
begin
  BuiltinMethods := nil;
  classAuthRole := nil;

  try
    BuiltinClass := ClassInfo.DSClass;
    BuiltinMethods := BuiltinClass.Methods;
    if ClassInfo.DsClass <> nil then
    begin
      //see if there is a TRoleAuth attribute on the class through reflection
      typeCtx := ARTTICtx.FindType(ClassInfo.DSUnitName + '.' + ClassInfo.DSClassName);
      if typeCtx <> nil then
      begin
        codeRole := TRoleAuth(GetAuthRole(typeCtx.GetAttributes));
        if codeRole <> nil then
          classAuthRole := codeRole
      end;
    end
    else
      typeCtx := nil;

    for Index := 0 to Length(BuiltinMethods) - 1 do
    begin
      BuiltinMethod := BuiltinMethods[Index];
      if IsCallableMethod(BuiltinMethod) then
      begin
        MethodInfo := TDSMethodInfo.Create;
        MethodInfo.DSMethod := BuiltinMethod;
        MethodInfo.MethodAlias := CreateMethodAlias(BuiltinMethod);
        MethodInfo.DSMethodName := BuiltinMethod.DSMethodName;

        MethodInfo.DSClassInfo := ClassInfo;

        CreateServerMethod(ClassInfo, MethodInfo, typeCtx, classAuthRole);
      end
      else 
        BuiltinMethod.Free;
    end;
  finally
    BuiltinMethods := nil;
  end;
end;

function TDSServerMethodProvider.AddBuiltinMethods(ARTTICtx: TRTTIContext; const PackageName: string; const UnitName: string; const ClassName: string; const AdminClass: Boolean): TDSClassInfo;
var
  ClassInfo: TDSClassInfo;
begin
  ClassInfo := TDSClassInfo.Create;
  ClassInfo.PackageName := PackageName;
  ClassInfo.DSClassName := ClassName;
  ClassInfo.DSUnitName := UnitName;
  if AdminClass then
  begin
    ClassInfo.LifeCycle := TDSLifeCycle.Session;
    ClassInfo.CustomAdminClass := AdminClass;
  end
  else 
    ClassInfo.LifeCycle := TDSLifeCycle.Server;
  AddServerClass(ClassInfo);
  AddAllMethods(ARTTICtx, ClassInfo);
  Result := ClassInfo;
end;

procedure TDSServerMethodProvider.AddRegisteredServerClasses(ARttiContext: TRttiContext);
var
  List: TDBXArrayList;
  Index: Integer;
  Count: Integer;
  ServerClass: TDSCustomServerClass;
  ClassInfo: TDSClassInfo;
  DsClass: TDSClass;
  AdapteeClass: TDSClass;
  ClassName: string;
  ClassUnit: string;
begin
  List := TDBXArrayList.Create;
  try
    FServer.GetServerClassList(List);
    Count := List.Count;
    for Index := 0 to Count - 1 do
    begin
      ServerClass := TDSCustomServerClass(List[Index]);
      DsClass := ServerClass.DSClass;
      ClassName := DsClass.DSClassName;
      AdapteeClass := DsClass.AdapteeDSClass;
      if AdapteeClass <> nil then
      begin
        ClassName := AdapteeClass.DSClassName;
        ClassUnit := AdapteeClass.ClassRef.UnitName;
      end
      else
        ClassUnit := DsClass.ClassRef.UnitName;
      ClassInfo := TDSClassInfo.Create;
      ClassInfo.ServerClass := ServerClass;
      ClassInfo.DSClassName := ClassName;
      ClassInfo.LifeCycle := ServerClass.LifeCycle;
      ClassInfo.RoleName := ServerClass.RoleName;
      ClassInfo.DSClass := DsClass;
      ClassInfo.DSUnitName := ClassUnit;
      AddServerClass(ClassInfo);
      AddAllMethods(ARttiContext, ClassInfo);
    end;
  finally
    FreeAndNil(List);
  end;
end;

function TDSServerMethodProvider.GetAuthRole(const attrs: TArray<TCustomAttribute>; const DefValue: TObject): TObject;
var
  attr: TCustomAttribute;
begin
  Result := DefValue;
  for attr in attrs do
    if attr is TRoleAuth then
      exit(attr as TRoleAuth);
end;

procedure TDSServerMethodProvider.CreateServerMethod(const ClassInfo: TDSClassInfo;
                                   const MethodInfo: TDSMethodInfo; const typeCtx: TRTTIType;
                                   const ClassAuthRole: TObject);
var
  SearchName: string;
  methodCtx: TRTTIMethod;
begin
  SearchName := MethodInfo.SearchName;
  MethodInfo.DSClassInfo := ClassInfo;
  if FMethodTable[SearchName] <> nil then
    raise TDBXError.Create(TDBXErrorCodes.ServerMethodExists, Format(SServerMethodExists, [SearchName]));
  FMethodTable[SearchName] := MethodInfo;
  FMethodSearchNameList.Add(SearchName);

  // set the authoring role
  if typeCtx <> nil then
  begin
    methodCtx := typeCtx.GetMethod(MethodInfo.DSMethodName);
    if methodCtx <> nil then
      // proper method found - skip adaptors
      MethodInfo.AuthRole := GetAuthRole(methodCtx.GetAttributes, ClassAuthRole);
  end;
end;

procedure TDSServerMethodProvider.DropServerMethod(const MethodInfo: TDSMethodInfo; const Index: Integer);
begin
  FMethodSearchNameList.Delete(Index);
  FMethodTable.Delete(MethodInfo.SearchName);
end;

procedure TDSServerMethodProvider.DropSeverMethod(const MethodAlias: string);
var
  MethodInfo: TDSMethodInfo;
  Count, Index: Integer;
begin
  Count := FMethodSearchNameList.Count;
  for Index := 0 to Count - 1 do
  begin
    if string.Compare((string(FMethodSearchNameList[Index])), MethodAlias, True) = 0 then
    begin
      MethodInfo := TDSMethodInfo(FMethodTable[FMethodSearchNameList[Index]]);
      DropServerMethod(MethodInfo, Index);
      Exit;
    end;
  end;
  raise TDBXError.Create(TDBXErrorCodes.ServerMethodMissing, Format(SServerMethodMissing, [MethodAlias]));
end;

procedure TDSServerMethodProvider.GetServerMethods(const ServerCon: TDSServerConnectionHandler; const Methods: TDSMethodEntity);
var
  Count: Integer;
  MethodInfo: TDSMethodInfo;
  Index: Integer;
begin
  Count := FMethodSearchNameList.Count;
  for Index := 0 to Count - 1 do
  begin
    MethodInfo := (TDSMethodInfo(FMethodTable[string(FMethodSearchNameList[Index])]));
    Methods.Table.Insert;
    Methods.MethodAlias := MethodInfo.MethodAlias;
    Methods.RoleName := MethodInfo.RoleName;
    Methods.ServerClassName := MethodInfo.DSClassInfo.DSClassName;
    Methods.ServerMethodName := MethodInfo.DSMethodName;
    Methods.Table.Post;
  end;
end;

procedure TDSServerMethodProvider.GetServerMethods(const ClassName: string; const Container: TJSONArray);
var
  MethodInfo: TDSMethodInfo;
  Prefix: string;
  Count, Index: Integer;
begin
  Prefix := NullString;
  if not ClassName.IsEmpty then
  begin
    Prefix := ClassName.ToUpper;
    Prefix := Prefix + '.';
  end;
  Count := FMethodSearchNameList.Count;
  for Index := 0 to Count - 1 do
  begin
    MethodInfo := (TDSMethodInfo(FMethodTable[string(FMethodSearchNameList[Index])]));
    if Prefix.IsEmpty or MethodInfo.SearchName.StartsWith(Prefix) then
      Container.AddElement(TJSONString.Create(MethodInfo.MethodAlias));
  end;
end;

procedure TDSServerMethodProvider.GetServerMethod(const ServerMethodName: string; const Container: TJSONObject);
var
  MethodInfo: TDSMethodInfo;
  JsonMethodMeta: TJSONObject;
begin
  MethodInfo := TDSMethodInfo(FMethodTable[UpperCase(ServerMethodName)]);
  if MethodInfo <> nil then
  begin
    JsonMethodMeta := TJSONObject.Create;
    Container.AddPair(TJSONString.Create(ServerMethodName), JsonMethodMeta);
    GetServerMethodParameters(ServerMethodName, JsonMethodMeta);
  end
  else 
    Container.AddPair(TJSONString.Create(ServerMethodName), TJSONNull.Create);
end;

procedure TDSServerMethodProvider.InsertServerMethodParameter(const MethodInfo: TDSMethodInfo; const Parameters: TDSMethodParametersEntity);
var
  ColumnCount, Ordinal: Integer;
  Table: TDBXTable;
begin
  Table := Parameters.Table;
  ColumnCount := Length(Table.Columns);
  Parameters.Table.Insert;
  Parameters.MethodAlias := MethodInfo.MethodAlias;
  Parameters.ServerClassName := MethodInfo.DSClassInfo.DSClassName;
  Parameters.ServerMethodName := MethodInfo.DSMethodName;
  for Ordinal := 3 to ColumnCount - 1 do
    Table.Value[Ordinal].SetNull;
end;

procedure TDSServerMethodProvider.GetServerMethodParameters(const ServerCon: TDSServerConnectionHandler; const Parameters: TDSMethodParametersEntity);
var
  Count, Index, ParamCount, ParamIndex: Integer;
  MethodInfo: TDSMethodInfo;
  DsMethod: TDSMethod;
  ParamNames: TDBXStringArray;
  ParamTypes: TDSClassArray;
  DbxParameter: TDBXParameter;
  ParameterClass: TDSClass;
begin
  Count := FMethodSearchNameList.Count;
  DbxParameter := nil;
  try
    DbxParameter := TDBXParameter.Create(nil);
    for Index := 0 to Count - 1 do
    begin
      MethodInfo := (TDSMethodInfo(FMethodTable[string(FMethodSearchNameList[Index])]));
      DsMethod := MethodInfo.DSMethod;
      ParamNames := DsMethod.ParameterNames;
      ParamTypes := DsMethod.ParameterTypes;
      ParamCount := Length(ParamTypes);
      if ParamCount > 0 then
        for ParamIndex := 0 to ParamCount - 1 do
        begin
          InsertServerMethodParameter(MethodInfo, Parameters);
          Parameters.ParameterName := ParamNames[ParamIndex];
          ParameterClass := ParamTypes[ParamIndex];
          ParameterClass.GetDBXType(DbxParameter);
          Parameters.ParameterDBXDataType := DbxParameter.DataType;
          Parameters.ParameterDBXSubDataType := DbxParameter.SubType;
          Parameters.ParameterTypeName := ParameterClass.DSClassName;
          Parameters.ParameterTypeUnit := ParameterClass.TypeUnit;
          if ParameterClass.ValueParameter then
          begin
            Parameters.DBXParameterDirection := TDBXParameterDirections.InOutParameter;
            Parameters.ParameterDirection := TDBXParameterDirections.InParameter;
          end
          else 
          begin
            Parameters.DBXParameterDirection := GetDbxParameterDirection(ParameterClass);
            Parameters.ParameterDirection := GetDbxParameterDirection(ParameterClass);
          end;
          Parameters.Table.Post;
        end;
      ParameterClass := DsMethod.ReturnType;
      if not ParameterClass.VoidReturn then
      begin
        InsertServerMethodParameter(MethodInfo, Parameters);
        ParameterClass.GetDBXType(DbxParameter);
        Parameters.ParameterDBXDataType := DbxParameter.DataType;
        Parameters.ParameterDBXSubDataType := DbxParameter.SubType;
        Parameters.ParameterTypeName := ParameterClass.DSClassName;
        Parameters.ParameterTypeUnit := ParameterClass.TypeUnit;
        Parameters.DBXParameterDirection := TDBXParameterDirections.ReturnParameter;
        Parameters.ParameterDirection := TDBXParameterDirections.ReturnParameter;
        Parameters.Table.Post;
      end
      else 
      begin
        InsertServerMethodParameter(MethodInfo, Parameters);
        Parameters.DBXParameterDirection := TDBXParameterDirections.ReturnParameter;
        Parameters.ParameterDirection := TDBXParameterDirections.ReturnParameter;
        Parameters.Table.Post;
      end;
    end;
  finally
    FreeAndNil(DbxParameter);
  end;
end;

procedure TDSServerMethodProvider.GetServerMethodParameters(const SearchName: string; const Container: TJSONObject);
var
  MethodInfo: TDSMethodInfo;
  DsMethod: TDSMethod;
  ParameterClass: TDSClass;
  ParamTypes: TDSClassArray;
  ParamNames: TDBXStringArray;
  Count, I: Integer;
  Direction: string;
  ParamObj: TJSONObject;
begin
  MethodInfo := TDSMethodInfo(FMethodTable[SearchName.ToUpper]);
  if MethodInfo <> nil then
  begin
    DsMethod := MethodInfo.DSMethod;
    ParamTypes := DsMethod.ParameterTypes;
    ParamNames := DsMethod.ParameterNames;
    Count := Length(ParamTypes);
    for I := 0 to Count - 1 do
    begin
      ParameterClass := ParamTypes[I];
      Direction := 'In';
      if ParameterClass.OutParameter then
        Direction := 'Out'
      else if ParameterClass.InOutParameter then
        Direction := 'InOut';
      ParamObj := TJSONObject.Create;
      ParamObj.AddPair('direction', TJSONString.Create(Direction));
      ParamObj.AddPair('type', TJSONString.Create(ParameterClass.DSClassName));
      Container.AddPair(ParamNames[I], ParamObj);
    end;
    ParameterClass := DsMethod.ReturnType;
    if not ParameterClass.VoidReturn then
    begin
      ParamObj := TJSONObject.Create;
      ParamObj.AddPair('direction', TJSONString.Create('Return'));
      ParamObj.AddPair('type', TJSONString.Create(ParameterClass.DSClassName));
      Container.AddPair('Result', ParamObj);
    end;
  end;
end;

procedure TDSServerMethodProvider.GetProcedures(const ServerCon: TDSServerConnectionHandler; const ProcedureNamePattern: string; const ProcedureTypePattern: string; const Procedures: TDSProcedureEntity);
var
  Count: Integer;
  MethodInfo: TDSMethodInfo;
  IsVoidReturn: Boolean;
  GetProcedures: Boolean;
  GetFunctions: Boolean;
  Index: Integer;
begin
  Count := FMethodSearchNameList.Count;
  GetProcedures := True;
  GetFunctions := True;
  if (ProcedureTypePattern = 'PROCEDURE') then
    GetFunctions := False
  else if (ProcedureTypePattern = 'FUNCTION') then
    GetProcedures := False;
  for Index := 0 to Count - 1 do
  begin
    MethodInfo := (TDSMethodInfo(FMethodTable[string(FMethodSearchNameList[Index])]));
    if (ProcedureNamePattern.Length < 1) or (ProcedureNamePattern = '%') or (MethodInfo.MethodAlias.IndexOf(ProcedureNamePattern) >= 0) then
    begin
      IsVoidReturn := MethodInfo.DSMethod.ReturnType.VoidReturn;
      if (IsVoidReturn and GetProcedures) or (not IsVoidReturn and GetFunctions) then
      begin
        Procedures.Table.Insert;
        Procedures.CatalogName := '';
        Procedures.SchemaName := MethodInfo.RoleName;
        Procedures.ProcedureName := MethodInfo.MethodAlias;
        if IsVoidReturn then
          Procedures.ProcedureType := 'PROCEDURE'
        else 
          Procedures.ProcedureType := 'FUNCTION';
        Procedures.Table.Post;
      end;
    end;
  end;
end;

function TDSServerMethodProvider.GetParameterMode(const ParameterClass: TDSClass): string;
begin
  case GetDbxParameterDirection(ParameterClass) of
    TDBXParameterDirections.InOutParameter:
      Exit('INOUT');
    TDBXParameterDirections.OutParameter:
      Exit('OUT');
    TDBXParameterDirections.ReturnParameter:
      Exit('RESULT');
  end;
  Result := 'IN';
end;

procedure TDSServerMethodProvider.AddParameter(const ServerCon: TDSServerConnectionHandler; const Parameter: TDSClass; const ParameterName: string; const SchemaName: string; const ProcedureName: string; const ParamIndex: Integer; const ProcedureParameters: TDSProcedureParametersEntity);
var
  TypeName: string;
  DbxParameter: TDBXParameter;
begin
  DbxParameter := TDBXParameter.Create(ServerCon.DBXContext);
  try
    Parameter.GetDBXType(DbxParameter);
    TypeName := TDBXValueType.DataTypeName(DbxParameter.DataType);
    ProcedureParameters.Table.Insert;
    ProcedureParameters.CatalogName := '';
    ProcedureParameters.SchemaName := SchemaName;
    ProcedureParameters.ProceduredName := ProcedureName;
    ProcedureParameters.ParameterName := ParameterName;
    ProcedureParameters.ParameterMode := GetParameterMode(Parameter);
    ProcedureParameters.TypeName := TypeName;
    ProcedureParameters.Precision := -1;
    ProcedureParameters.Scale := -1;
    ProcedureParameters.Ordinal := ParamIndex;
    ProcedureParameters.Nullable := Parameter.ValueParameter;
    ProcedureParameters.DBXDataType := DbxParameter.DataType;
    ProcedureParameters.FixedLength := False;
    ProcedureParameters.Unicode := DbxParameter.DataType = TDBXDataTypes.WideStringType;
    case DbxParameter.DataType of
      TDBXDataTypes.BinaryBlobType:
        ProcedureParameters.Long := True;
      else
        ProcedureParameters.Long := False;
    end;
    ProcedureParameters.Unsigned := False;
    ProcedureParameters.Table.Post;
  finally
    FreeAndNil(DbxParameter);
  end;
end;

procedure TDSServerMethodProvider.GetProcedureParameters(const ServerCon: TDSServerConnectionHandler; const SchemaPattern: string; const MethodPattern: string; const ProcedureParameters: TDSProcedureParametersEntity);
var
  Count, Index, ParamIndex: Integer;
  Parameters: TDSClassArray;
  MethodInfo: TDSMethodInfo;
  ParamNames: TDBXStringArray;
begin
  Count := FMethodSearchNameList.Count;
  for Index := 0 to Count - 1 do
  begin
    MethodInfo := (TDSMethodInfo(FMethodTable[string(FMethodSearchNameList[Index])]));
    if ((MethodPattern.Length < 1) or (MethodInfo.MethodAlias.IndexOf(MethodPattern) >= 0)) and
       ((SchemaPattern.Length < 1) or (MethodInfo.RoleName.IndexOf(SchemaPattern) >= 0)) then
    begin
      Parameters := MethodInfo.DSMethod.ParameterTypes;
      ParamNames := MethodInfo.DSMethod.ParameterNames;
      if Parameters <> nil then
        for ParamIndex := 0 to Length(Parameters) - 1 do
          AddParameter(ServerCon, Parameters[ParamIndex], ParamNames[ParamIndex], MethodInfo.RoleName, MethodInfo.MethodAlias, ParamIndex, ProcedureParameters);
      if not MethodInfo.DSMethod.ReturnType.VoidReturn then
        AddParameter(ServerCon, MethodInfo.DSMethod.ReturnType, 'ReturnValue', MethodInfo.RoleName, MethodInfo.MethodAlias, Length(Parameters), ProcedureParameters);
    end;
  end;
end;

procedure TDSServerMethodProvider.CheckConfiguration(const Config: TDSConfiguration);
begin
end;

procedure TDSServerMethodProvider.ProcessConfiguration(const Config: TDSConfiguration);
begin
end;

procedure TDSServerMethodProvider.UpdateConfiguration(const Config: TDSConfiguration);
begin
  if FOpen then
  begin
    CheckConfiguration(Config);
    ProcessConfiguration(Config);
  end;
  self.FConfig := Config;
end;

procedure TDSServerMethodProvider.UnknownLifeCycle(const LifeCycle: string);
begin
  raise TDBXError.Create(0, 'Unknown LifeCycle:  ' + LifeCycle, nil);
end;

function TDSServerMethodProvider.GetServerInstance(const ServerCon: TDSServerConnectionHandler; const ClassInfo: TDSClassInfo): TObject;
begin
  TMonitor.Enter(FServerInstanceProvider);
  try
  begin
    Exit(FServerInstanceProvider.GetInstance(ServerCon, ClassInfo));
  end
  finally
    TMonitor.Exit(FServerInstanceProvider);
  end

end;

function TDSServerMethodProvider.GetServerMethodInstance(const ServerCon: TDSServerConnectionHandler; const MethodInfo: TDSMethodInfo): TObject;
var
  ClassInfo: TDSClassInfo;
  LifeCycle: string;
  ReturnInstance: TObject;
begin
  ClassInfo := MethodInfo.DSClassInfo;
  LifeCycle := ClassInfo.LifeCycle;
  ReturnInstance := nil;
  if LifeCycle.IsEmpty or (LifeCycle.Length < 1) or (LifeCycle = TDSLifeCycle.Server) then
    ReturnInstance := GetServerInstance(ServerCon, ClassInfo)
  else if (LifeCycle = TDSLifeCycle.Session) then
  begin
    ReturnInstance := ServerCon.GetInstance(ClassInfo);
    if ClassInfo.CustomAdminClass then
      (TDSCustomAdmin(ReturnInstance)).ServerConnection := ServerCon;
  end
  else if (LifeCycle = TDSLifeCycle.Invocation) then
    ReturnInstance := ServerCon.CreateInstance(ClassInfo.ServerClass, ClassInfo.DSClass);
  if ReturnInstance = nil then
    UnknownLifeCycle(LifeCycle);
  Result := ReturnInstance;
end;

function TDSServerMethodProvider.GetDbxParameterDirection(const DsClass: TDSClass): Integer;
var
  ParameterDirection: Integer;
begin
  ParameterDirection := TDBXParameterDirections.InParameter;
  if DsClass.InOutParameter then
    ParameterDirection := TDBXParameterDirections.InOutParameter
  else if DsClass.OutParameter then
    ParameterDirection := TDBXParameterDirections.OutParameter;
  Result := ParameterDirection;
end;

function TDSServerMethodProvider.CreateServerParameter(const Con: TDSServerConnectionHandler; const DsClass: TDSClass; const DbxRow: TDBXRow): TDBXParameter;
var
  ParameterDirection: Integer;
  Parameter: TDBXParameter;
begin
  Parameter := TDBXParameter.Create(Con.DBXContext, DbxRow);
  Parameter.ConnectionHandler := Con;
  ParameterDirection := GetDbxParameterDirection(DsClass);
  if ParameterDirection = TDBXParameterDirections.InOutParameter then
  begin
    if DsClass.ValueParameter then
      Parameter.ValueParameter := True;
  end;
  DsClass.GetDBXType(Parameter);
  Parameter.ParameterDirection := ParameterDirection;
  Result := Parameter;
end;

procedure TDSServerMethodProvider.PrepareParameters(const Con: TDSServerConnectionHandler; const MethodInfo: TDSMethodInfo; const ServerMethod: TDSServerMethod; const Item: TDBXActiveTableReaderItem);
var
  DsParamClasses: TDSClassArray;
  DsParamNames: TDBXStringArray;
  Parameters: TDBXServerParameterList;
  Parameter, ReturnParameter: TDBXParameter;
  ReturnClass: TDSClass;
  Ordinal, ParameterCount, ParameterDirection: Integer;
  Row: TDBXStreamerRow;
begin
  Row := Item.StreamerRow;
  DsParamClasses := MethodInfo.DSMethod.ParameterTypes;
  DsParamNames := MethodInfo.DSMethod.ParameterNames;
  ParameterCount := Length(DsParamClasses);
  Parameters := TDBXServerParameterList.Create(Con.DBXContext, Row);
  ReturnClass := MethodInfo.DSMethod.ReturnType;
  Item.ParameterList := Parameters;
  if not ReturnClass.VoidReturn then
    Inc(ParameterCount);
  Parameters.Count := ParameterCount;
  for Ordinal := 0 to Length(DsParamClasses) - 1 do
  begin
    Parameter := CreateServerParameter(Con, DsParamClasses[Ordinal], Row);
    Parameter.Name := DsParamNames[Ordinal];
    ParameterDirection := Parameter.ParameterDirection;
    if (ParameterDirection = TDBXParameterDirections.InOutParameter) or (ParameterDirection = TDBXParameterDirections.OutParameter) then
      ServerMethod.HasOutOrReturnParameters := True;
    Parameters.SetParameter(Ordinal, Parameter);
  end;
  if not ReturnClass.VoidReturn then
  begin
    ServerMethod.HasOutOrReturnParameters := True;
    ReturnParameter := CreateServerParameter(Con, ReturnClass, Row);
    ReturnParameter.Name := 'ReturnParameter';
    ReturnParameter.ParameterDirection := TDBXParameterDirections.ReturnParameter;
    ServerMethod.ReturnValue := ReturnParameter;
    Parameters.SetParameter(ParameterCount - 1, ReturnParameter);
  end;
  ServerMethod.Parameters := Parameters;
  ServerMethod.MethodValues := TDSMethodValues.Create;
end;

function TDSServerMethodProvider.HasServerMethod(const MethodName: string): Boolean;
begin
  Result := FMethodTable[UpperCase(MethodName)] <> nil;
end;

function TDSServerMethodProvider.PrepareMethod(const Con: TDSServerConnectionHandler; const Message: TDBXCommandMessage; const ActiveStreamerRowList: TDBXActiveTableReaderList; const InRow: TDBXStreamerRow): TDSServerMethod;
var
  Item: TDBXActiveTableReaderItem;
  MethodInfo: TDSMethodInfo;
  ServerMethod: TDSServerMethod;
  Complete: Boolean;
  MethodObject: TObject;
  Scanner: TDBXSqlScanner;
  Token: Integer;
  Ordinal: Integer;
  MethodAlias: string;
  Parameter: TDBXParameter;
  Row: TDBXStreamerRow;
  Session: TDSSession;
  UserRoles: TStrings;
  UserName: string;
  AuthorizedRoles, DeniedRoles: TStrings;
begin
  Complete := False;
  ServerMethod := TDSServerMethod.Create;
  Scanner := nil;
  Token := TDBXSqlScanner.TokenSymbol;
  MethodAlias := Message.Command;
  Row := InRow;
  try
    MethodObject := FMethodTable[UpperCase(MethodAlias)];
    if MethodObject = nil then
    begin
      Scanner := Con.SQLScanner;
      Scanner.Init(MethodAlias);
      MethodAlias := '';
      while True do
      begin
        Token := Scanner.NextToken;
        if Token = TDBXSqlScanner.TokenId then
          MethodAlias := MethodAlias + Scanner.Id
        else if Token = TDBXSqlScanner.TokenPeriod then
          MethodAlias := MethodAlias + '.'
        else 
          break;
      end;
      MethodObject := FMethodTable[UpperCase(MethodAlias)];
    end;
    if MethodObject = nil then
      raise TDBXError.Create(TDBXErrorCodes.ServerMethodMissing, Format(SServerMethodMissing, [MethodAlias]));

    MethodInfo := TDSMethodInfo(MethodObject);

    // prepare the parameters
    ServerMethod.MethodInfo := MethodInfo;
    ServerMethod.ServerConnection := Con;
    ServerMethod.Method := MethodInfo.DSMethod;
    ServerMethod.ServerClass := MethodInfo.DSClassInfo.ServerClass;
    ServerMethod.AdapterInstance := GetServerMethodInstance(Con, MethodInfo);
    ServerMethod.MethodInstance := MethodInfo.DSMethod.GetClassInstance(ServerMethod.AdapterInstance);
    ServerMethod.Lifecycle := MethodInfo.DSClassInfo.LifeCycle;

    Session := TDSSessionManager.GetThreadSession;

    if Session <> nil then
    begin
      UserName := Session.UserName;
      UserRoles := Session.UserRoles;
      Session.GetAuthRoles(ServerMethod, AuthorizedRoles, DeniedRoles);
    end
    else
    begin
      UserName := '';
      UserRoles := nil;
      AuthorizedRoles := nil;
      DeniedRoles := nil;
    end;

    try
      Con.PrepareServerMethod(MethodAlias, ServerMethod, UserName, UserRoles, AuthorizedRoles, DeniedRoles);
    finally
      FreeAndNil(AuthorizedRoles);
      FreeAndNil(DeniedRoles);
    end;

    Item := ActiveStreamerRowList.AddDBXStreamerRow(Row, 0, False, True);
    ServerMethod.Row := Row;
    Row := nil;
    PrepareParameters(Con, MethodInfo, ServerMethod, Item);
    ServerMethod.Parameters.NewRowGeneration;
    if Scanner <> nil then
    begin
      Ordinal := 0;
      if Token = TDBXSqlScanner.TokenOpenParen then
      begin
        Token := TDBXSqlScanner.TokenComma;
        while Token = TDBXSqlScanner.TokenComma do
        begin
          Token := Scanner.NextToken;
          if (Token = TDBXSqlScanner.TokenId) or (Token = TDBXSqlScanner.TokenNumber) then
          begin
            Parameter := ServerMethod.Parameters.Parameter[Ordinal];
            Parameter.Value.AsString := Scanner.Id;
            Parameter.Literal := True;
            Message.ParameterTypeChanged := True;
            Token := Scanner.NextToken;
            Inc(Ordinal);
          end;
        end;
      end;
    end;
    Complete := True;
  finally
    if not Complete then
    begin
      Row.Free;
      ServerMethod.Free;
    end;
  end;
  Result := ServerMethod;
end;

procedure TDSServerMethodProvider.Open;
var
  Complete: Boolean;
  DsPackage: TDSPackage;
  RttiContext: TRttiContext;
begin
  Complete := False;
  if not FOpen then
  begin
    FPackageTable := TDBXObjectStore.Create(True);
    FClassTable := TDBXObjectStore.Create(True);
    FClassList := TDBXStringList.Create;
    FMethodTable := TDBXObjectStore.Create(True);
    FMethodSearchNameList := TDBXStringList.Create;
    FStreamerTable := TDBXObjectStore.Create;
    FServerInstanceProvider := TDSHashtableInstanceProvider.Create(FServer.FDbxContext, FServer, nil, nil);
    DsPackage := TDSPackage.Create;
    try
      DsPackage.PackageName := TDSPlatform.DefaultPackageName;
      FPackageTable[TDSPlatform.DefaultPackageName] := DsPackage;
      FOpen := True;
      AddBuiltinMethods(RttiContext, TDSPlatform.DefaultPackageName, TDSPlatform.DataSnapAdminUnitName, TDSPlatform.DataSnapAdminClassName, True);
      AddBuiltinMethods(RttiContext, TDSPlatform.DefaultPackageName, TDSPlatform.MetadataUnitName, TDSPlatform.MetadataClassName, True);
      AddRegisteredServerClasses(RttiContext);
      UpdateConfiguration(FConfig);
      Complete := True;
    finally
      if not Complete then
      begin
        Close;
        FOpen := False;
      end;
    end;
  end;
end;

procedure TDSServerMethodProvider.Close;
begin
  FreeAndNil(FPackageTable);
  FreeAndNil(FClassTable);
  FreeAndNil(FMethodTable);
  FreeAndNil(FStreamerTable);
  FreeAndNil(FServerInstanceProvider);
  FOpen := False;
end;

constructor TDSServerTransport.Create(ATransportOwner: TComponent);
begin
  inherited Create(ATransportOwner);
  SetLength(FServerConnections,10);
  FOpenMessage := TDBXOpenMessage.Create;
  FDisconnectMessage := TDBXDisconnectMessage.Create;
  FBufferKBSize := 32;
  FFilterList := TTransportFilterCollection.Create;
  FIPImplementationID := '';
end;

destructor TDSServerTransport.Destroy;
var
  I: Integer;
begin
  FreeAndNil(FOpenMessage);
  FreeAndNil(FDisconnectMessage);
  for I := FFilterList.Count - 1 downto 0 do
    FFilterList.GetItem(I).Free;
  FreeAndNil(FFilterList);
  FServerConnections := nil;
  inherited Destroy;
end;

procedure TDSServerTransport.Disconnecting(const Con: TDBXConnectionHandler);
begin
  // No action by default
end;

procedure TDSServerTransport.AddConnection(const Con: TDBXConnectionHandler);
var
  Cons, NewCons: TDBXConnectionHandlerArray;
  Index: Integer;
begin
  Cons := FServerConnections;
  for Index := 1 to Length(Cons) - 1 do
  begin
    if Cons[Index] = nil then
    begin
      Cons[Index] := Con;
      FOpenMessage.ConnectionHandle := Index;
      FOpenMessage.HandleMessage(Con);
      Exit;
    end;
  end;
  SetLength(NewCons,Length(Cons) + 32);
  for Index := 0 to Length(Cons) - 1 do
    NewCons[Index] := Cons[Index];
  NewCons[Length(Cons)] := Con;
  FOpenMessage.ConnectionHandle := Length(Cons);
  FOpenMessage.HandleMessage(Con);
end;

procedure TDSServerTransport.RemoveConnection(const Con: TDBXConnectionHandler);
var
  Cons: TDBXConnectionHandlerArray;
  Index: Integer;
begin
  Cons := FServerConnections;
  for Index := 0 to Length(Cons) - 1 do
  begin
    if Cons[Index] = Con then
    begin
      Cons[Index] := nil;
      Exit;
    end;
  end;
end;

procedure TDSServerTransport.CloseConnections;
var
  Cons: TDBXConnectionHandlerArray;
  Index: Integer;
begin
  Cons := FServerConnections;
  for Index := 0 to Length(Cons) - 1 do
    if Cons[Index] <> nil then
      Cons[Index].DbxDisconnect(FDisconnectMessage);
end;

procedure TDSServerTransport.WaitForClosedConnections;
var
  Index, MaxWait, OpenCount: Integer;
begin
  MaxWait := 10;
  if FServerConnections <> nil then
  begin
    OpenCount := Length(FServerConnections);
    while (Decr(MaxWait) > 0) and (OpenCount > 0) do
    begin
      OpenCount := 0;
      Index := 0;
      while (MaxWait > 0) and (Index < Length(FServerConnections)) do
      begin
        if FServerConnections[Index] <> nil then
          Inc(OpenCount);
        Inc(Index);
      end;
    end;
  end;
end;

procedure TDSServerTransport.SetBufferKBSize(const BufferKBSize: Integer);
begin
  if BufferKBSize < 1 then
    self.FBufferKBSize := 1
  else if BufferKBSize > 1000 then
    self.FBufferKBSize := 1000
  else 
    self.FBufferKBSize := BufferKBSize;
end;

function TDSServerTransport.GetFilters: TTransportFilterCollection;
begin
  Result := FFilterList;
end;

procedure TDSServerTransport.SetFilters(const Value: TTransportFilterCollection);
begin
  FFilterList.Assign(Value);
end;

function TDSServerTransport.GetIPImplementationID: string;
begin
  Result := FIPImplementationID;
end;

procedure TDSServerTransport.SetIPImplementationID(const AIPImplementationID: string);
begin
  FIPImplementationID := AIPImplementationID;
end;

procedure TDSServerTransport.Stopping;
begin
  if Server <> nil then
    Server.TransportStopping(Self);
end;

constructor TDSVoidConnectionHandler.Create(const ADbxContext: TDBXContext);
begin
  inherited Create(ADbxContext);
end;

function TDSVoidConnectionHandler.AcquireCommandHandler(const Message: TDBXCommandMessage): TDBXCommandHandler;
begin
  Result := self;
end;

function TDSVoidConnectionHandler.DbxBeforeRequest: Boolean;
begin
  Result := False;
end;

function TDSVoidConnectionHandler.CreateDbxRow: TDBXStreamerRow;
begin
  Result := TDBXNoOpRow.Create(DBXContext);
end;

procedure TDSVoidConnectionHandler.DbxConnect(const Message: TDBXConnectMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxDisconnect(const Message: TDBXDisconnectMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxOpen(const Message: TDBXOpenMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxTxBegin(const Message: TDBXTxBeginMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxTxEnd(const Message: TDBXTxEndMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxVendorProperty(const Message: TDBXVendorPropertyMessage);
begin
end;

function TDSVoidConnectionHandler.GetProductName: string;
begin
  Result := NullString;
end;

procedure TDSVoidConnectionHandler.DbxCommandClose(const Message: TDBXCommandCloseMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxErrorMessage(const Message: TDBXErrorMessage);
begin
  raise TDBXError.Create(TDBXErrorCodes.InvalidOperation, Message.ErrorMessage, Message.Error);
end;

procedure TDSVoidConnectionHandler.DbxExecute(const Message: TDBXExecuteMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxMoreBlob(const Message: TDBXMoreBlobMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxNext(const Message: TDBXNextMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxNextResult(const Message: TDBXNextResultMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxPrepare(const Message: TDBXPrepareMessage);
begin
end;

procedure TDSVoidConnectionHandler.DbxReaderClose(const Message: TDBXReaderCloseMessage);
begin
end;

constructor TInstanceProviderItem.Create(const AClassName: string; const ADestroyEventObject: TDSDestroyInstanceEventObject; const AServerClass: TDSCustomServerClass; const AInstance: TObject);
begin
  inherited Create;
  FInstanceClassName := AClassName;
  FDestroyEventObject := ADestroyEventObject;
  FServerClass := AServerClass;
  FInstance := AInstance;
  FServerClassNotifier := nil;

  //creates a new notifier component instance, and registers it to be notified by the given server class component.
  //When the ServerClass component is destroyed externally, this notifier will remove it from the FServerClass field.
  //If this wasn't done, the DestroyInstance procedure would get an AccessViolation in some cases.
  if FServerClass <> nil then
  begin
    FServerClassNotifier := TServerClassNotifier.Create(Self);
    TMonitor.Enter(FServerClass);
    try
      FServerClass.FreeNotification(FServerClassNotifier);
    finally
      TMonitor.Exit(FServerClass);
    end;
  end;
end;

type
  TOpenDSDataModuleAdapterClass = class(TDSDataModuleAdapterClass);

var
  FDataModules: TList<TDataModule>;

procedure TInstanceProviderItem.DestroyInstance;
var
  LDataModule: TDataModule;
  LServerClassInstance: TObject;
begin
  if (FServerClass <> nil) and (FServerClassNotifier <> nil) then
  begin
    TMonitor.Enter(FServerClass);
    try
      FServerClass.RemoveFreeNotification(FServerClassNotifier);
    finally
      TMonitor.Exit(FServerClass);
    end;
  end;
  FreeAndNil(FServerClassNotifier);
  FDestroyEventObject.ServerClassInstance := FInstance;
  if FServerClass <> nil then
    FServerClass.DestroyInstance(FDestroyEventObject);
  if (FDestroyEventObject.Server <> nil) and (csDestroying in FDestroyEventObject.Server.ComponentState) then
  begin
    // Need special handling for data modules because may be in GlobalNameSpace.BeginWrite lock
    LServerClassInstance := FDestroyEventObject.ServerClassInstance;
    if (LServerClassInstance is TDataModule) then
    begin
      LDataModule := TDataModule(LServerClassInstance);
      LServerClassInstance := nil;
    end
    else if FDestroyEventObject.ServerClassInstance is TDSDataModuleAdapterClass then
    begin
      LDataModule := TOpenDSDataModuleAdapterClass(LServerClassInstance).ExtractDataModule;
      FreeAndNil(LServerClassInstance);
    end
    else
      LDataModule := nil;
    if LDataModule <> nil then
    begin
      TMonitor.Enter(FDataModules);
      try
        FDataModules.Add(LDataModule);
      finally
        TMonitor.Exit(FDataModules);
      end;
      LDataModule.DestroyComponents;
    end;
    LServerClassInstance.Free;
  end
  else
    FDestroyEventObject.ServerClassInstance.Free;
  FInstance := nil;
end;

{ TInstanceProviderItem.TServerClassNotifier }

constructor TInstanceProviderItem.TServerClassNotifier.Create(AParent: TInstanceProviderItem);
begin
  inherited Create(nil);
  FParent := AParent;
end;

procedure TInstanceProviderItem.TServerClassNotifier.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  //make sure the component is the right one, and the operation is remove
  //nil the server class reference, since it is now being freed elsewhere
  if (Operation = opRemove) and (FParent <> nil) and (AComponent = FParent.FServerClass) then
    FParent.FServerClass := nil;
end;

{ TDSServerConnectionFactory }

constructor TDSServerConnectionFactory.Create;
begin
  FDBXContext := TDBXContext.Create;
end;

destructor TDSServerConnectionFactory.Destroy;
begin
  FDBXContext.Free;
  inherited;
end;

function TDSServerConnectionFactory.GetConnection(
  const ConnectionProperties: TDBXProperties; const AServer: TDSCustomServer): TDSServerConnection;
begin
  Assert(AServer <> nil);
  Result := GetConnection(FDBXContext, ConnectionProperties, AServer);
end;

function TDSServerConnectionFactory.CombineDriverProperties(
  ConProperties: TDBXProperties): TDBXProperties;
//var
//  DriverProperties:   TDBXProperties;
//  DriverName: string;
//  ConnectionName: string;
//  FactoryConProperties: TDBXProperties;
begin
  Result := TDBXProperties.Create;
  Result.AddProperties(ConProperties.Properties);
//  DriverName := ConProperties[TDBXPropertyNames.DriverName];
//  if DriverName = '' then
//  begin
//    ConnectionName := ConProperties[TDBXPropertyNames.ConnectionName];
//    if ConnectionName <> '' then
//    begin
//      FactoryConProperties := HasConnectionProperties(ConnectionName);
//      if FactoryConProperties <> nil then
//      begin
//        Result.AddUniqueProperties(FactoryConProperties.FProperties);
//        DriverName := Result[TDBXPropertyNames.DriverName];
//      end;
//    end;
//
//  end;
//  if DriverName <> '' then
//  begin
//    DriverProperties := HasDriverProperties(DriverName);
//    if DriverProperties <> nil then
//      Result.AddUniqueProperties(DriverProperties.FProperties);
//  end;
                         
  Result.SetComponentOwner(ConProperties.GetOwner as TComponent);
                                       
  Result.Events.SetValues(ConProperties.Events.AllEvents);
end;

function TDSServerConnectionFactory.GetConnection(const DBXContext: TDBXContext;
    const ConnectionProperties: TDBXProperties; const AServer: TDSCustomServer): TDSServerConnection;
var
//  ConnectionBuilder:  TDBXConnectionBuilder;
  //DelegatePath:       TDBXDelegateItem;
  CombinedProperties: TDBXProperties;
begin
  Assert(AServer <> nil);
  CombinedProperties := CombineDriverProperties(ConnectionProperties);
  try
    Result := TDSServerConnection.Create(CombinedProperties, AServer);
    try
      Result.Open;
    except
      Result.Free;
      raise;
    end;
  finally
    CombinedProperties.Free;
  end;
                        
//  //DelegatePath := CreateDelegatePath('', CombinedProperties);
//  ConnectionBuilder := TDBXConnectionBuilder.Create;
//  try
////    ConnectionBuilder.FDelegatePath               := DelegatePath;
//    ConnectionBuilder.FConnectionFactory          := Self;
//    ConnectionBuilder.FDBXContext                 := TDBXContext.Create(FDBXContext);
//    ConnectionBuilder.FInputConnectionName        := ConnectionProperties[TDBXPropertyNames.ConnectionName];
//    ConnectionBuilder.FInputConnectionProperties  := ConnectionProperties;
//    ConnectionBuilder.FInputUserName              := ConnectionProperties[TDBXPropertyNames.UserName];
//    ConnectionBuilder.FInputPassword              := ConnectionProperties[TDBXPropertyNames.Password];
//    Result := ConnectionBuilder.CreateConnection as TDSServerConnection;
//    try
//      Result.Open;
//    except
//      Result.Free;
//      raise;
//    end;
//  finally
//    ConnectionBuilder.Free;
//  end;
end;

initialization
  TDSServerConnectionFactory.FInstance := TDSServerConnectionFactory.Create;
  FDataModules := TObjectList<TDataModule>.Create;
finalization
  FDataModules.Free;
  FreeAndNil(TDSServerConnectionFactory.FInstance);

end.



