{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Tether.Manager;

interface
{$SCOPEDENUMS ON}
{$METHODINFO ON}

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.SyncObjs, System.Tether.Comm;

type
  ETetheringException = class(Exception);

  TTetheringProfileType = string;
  TTetheringProfileTypes = TArray<TTetheringProfileType>;

  TTetheringProtocolType = string;
  TTetheringProtocolTypes = TArray<TTetheringProtocolType>;

  TTetheringAdapterType = string;
  TTetheringAdapterTypes = TArray<TTetheringAdapterType>;

  TTetheringProtocolAdapterType = TPair<TTetheringProtocolType, TTetheringAdapterType>;
  TTetheringProtocolAdapterTypes = TArray<TTetheringProtocolAdapterType>;

  TTetheringTargetHost = string;
  TTetheringTargetHosts = TArray<TTetheringTargetHost>;

  TTetheringAllowedConnection = record
    ProtocolType: TTetheringProtocolType;
    AdapterType: TTetheringAdapterType;
    Connection: string;
  end;
  TTetheringAllowedConnections = TArray<TTetheringAllowedConnection>;

  TTetheringAdapterState = (Connected, DiscoveringManagers, DiscoveringProfiles);

  TTetheringProtocol = class;
  TTetheringAdapter = class;
  TTetheringConnection = class;

  TTetheringManagerInfo = record
    ManagerIdentifier: string;
    ManagerName: string;
    ManagerText: string;
    ConnectionString: string;
    /// <summary>Manager allowed adapters of the stored manager information</summary>
    ManagerAdapters: string;
    /// <summary>Manager communications Version that is used with the stored manager connection information</summary>
    Version: Integer;
    Adapter: TTetheringAdapter;
  end;

  TTetheringProfileInfo = record
    ManagerIdentifier: string;
    ProfileIdentifier: string;
    ProfileText: string;
    ProfileGroup: string;
    ProfileType: TTetheringProfileType;
    /// <summary>Version of the profile.</summary>
    ProfileVersion: Integer;
    AllowedConnections: TTetheringAllowedConnections;
    /// <summary>Converts the Profile Information into a string.</summary>
    function ToString: string;
    /// <summary>Converts a string into a Profile Information</summary>
    procedure FromString(const AProfileInfoString: string);
  end;

  TTetheringConnection = class
  private
    FConnectionString: string;
    FProtocolType: TTetheringProtocolType;
    FProtocol: TTetheringProtocol;
  public
    destructor Destroy; override;
    function Clone: TTetheringConnection;
    property ConnectionString: string read FConnectionString write FConnectionString;
    property ProtocolType: TTetheringProtocolType read FProtocolType write FProtocolType;
    property Protocol: TTetheringProtocol read FProtocol write FProtocol;
  end;

  /// <summary>Enumerate for differents errors. It's used in NotifyErrorEvent.</summary>
  TTetheringError = (InitAdapterError);
  TTetheringManagerInfoList = class(TList<TTetheringManagerInfo>);
  TTetheringProfileInfoList = class(TList<TTetheringProfileInfo>);
  TTetheringAdapterReadEvent = procedure(const Sender: TObject; const ASource: TTetheringConnection; const AData: TBytes) of object;
  TTetheringEndManagersDiscoveryEvent = procedure(const Sender: TObject; const ARemoteManagers: TTetheringManagerInfoList) of object;
  TTetheringEndProfilesDiscoveryEvent = procedure(const Sender: TObject; const ARemoteProfiles: TTetheringProfileInfoList) of object;
  TTetheringRequestManagerPasswordEvent = procedure(const Sender: TObject; const ARemoteIdentifier: string; var Password: string) of object;
  TTetheringManagerPairedEvent = procedure(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo) of object;
  TTetheringErrorAuthEvent = procedure(const Sender: TObject; const AManagerIdentifier: string) of object;
  TTetheringNewManagerEvent = procedure(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo) of object;
  TTetheringUnPairManagerEvent = procedure(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo) of object;
  TTetheringLaunchNotificationEvent = procedure(const Sender: TObject; const AProfileId, ANotification, Data: string) of object;
  TTetheringRemoteManagerShutdownEvent = procedure(const Sender: TObject; const AManagerIdentifier: string) of object;
  /// <summary>Type for Before Connection Notification Event</summary>
  TTetheringBeforeConnectEvent = procedure(const Sender: TObject; const AProfileInfo: TTetheringProfileInfo; var AllowConnect: Boolean) of object;
  /// <summary>Type for Profile Notification Event</summary>
  TTetheringProfileEvent = procedure(const Sender: TObject; const AProfileInfo: TTetheringProfileInfo) of object;
  TTetheringNotifyEvent = procedure(const Sender: TObject) of object;
  /// <summary>Type for NotifyError Event</summary>
  TTetheringNotifyErrorEvent = procedure(const Sender, Data: TObject; AError: TTetheringError) of object;

  /// <summary>Type for NotifyCommError Event</summary>
  TTetheringNotifyCommErrorEvent = procedure(const Sender: TObject; const AManagerInfo: TTetheringManagerInfo; const AProfileInfo: TTetheringProfileInfo) of object;

  TTetheringManager = class;
  TTetheringManagerCommunicationThread = class;
  TTetheringDoLog = procedure(const Msg: string) of object;
{ Abstract class for TetheringAdapters }
  TTetheringAdapter = class
  public type
    TTetheringLogItem = (Manager, Adapter, Protocol, Comm, CommThread, Profile);
  protected type
    TTetheringLogItems = set of TTetheringLogItem;
    TTetheringLog = class
    private class var
      FLogs: TQueue<string>;
      FTetheringLog: TTetheringDoLog;
    private
      class constructor Create;
      class destructor Destroy;
      class procedure QueueLog;
      class procedure DoLog(const Msg: string);
    public
      class procedure Log(const Msg: string);
      class procedure RegisterLog(const DoLog: TTetheringDoLog);
    end;

  private type
    TThreadTimer = class(TThread)
    private
      FTimeout: Cardinal;
      FOnTimer: TTetheringNotifyEvent;
      FEvent: TEvent;
      FCancelled: Boolean;
      procedure Stop;

    public
      constructor Create(const AEvent: TTetheringNotifyEvent; Timeout: Cardinal); overload;
      destructor Destroy; override;
      procedure Execute; override;
      procedure Cancel;
      property IsCancelled: Boolean read FCancelled;
    end;

  private
    FTimerManager: TTetheringAdapter.TThreadTimer;
    FRemoteManagers: TTetheringManagerInfoList;
    [Weak] FManager: TTetheringManager;
    function GetKnownManagers: TStringList;

  protected
  class var
    FLogItems: TTetheringLogItems;
  protected
    FAdapterConnectionString: string;
    FCommThread: TTetheringManagerCommunicationThread;

    class procedure Log(const Msg: string);
    class constructor Create;

    function GetAutomaticTimeout: Cardinal; virtual; abstract;

    function GetAdapterType: TTetheringAdapterType; virtual; abstract;
    procedure AddManagerInfo(const AManagerIdentifier, AManagerName, AManagerText, AConnectionString, AManagerAdapters: string; AVersion: Integer); overload;
    procedure AddManagerInfo(const AManagerInfo: TTetheringManagerInfo); overload;
    procedure EndManagersTimer(const Sender: TObject); virtual;
    procedure AutoConnectEndManagersTimer(const Sender: TObject); virtual;
    procedure EndProfilesTimerProc(const Sender: TObject); virtual;
    procedure DoRequestManagerPassword(const ARemoteIdentifier: string; var Password: string); virtual;
    procedure DoPairedToRemote(const AManagerIdentifier, AManagerName, AManagerText, AConnectionString: string; AVersion: Integer); virtual;
    procedure DoPairedFromLocal(const AManagerIdentifier, AManagerName, AManagerText, AConnectionString: string; AVersion: Integer); virtual;
    procedure DoAuthErrorFromLocal(const AManagerIdentifier: string); virtual;
    procedure DoAuthErrorFromRemote(const AManagerIdentifier: string); virtual;
    procedure DoLaunchNotification(const AProfileId, ANotification, Data: string); virtual;

    procedure DoDiscoverManagers(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts); virtual; abstract;

    function DoCreateCommunicationThread(const AnAdapter: TTetheringAdapter): TTetheringManagerCommunicationThread ; virtual; abstract;
    procedure DoStopListening; virtual;
    procedure DoNewManager(const AManager: TTetheringManagerInfo); virtual;
    procedure DoUnPairManager(const AManager: TTetheringManagerInfo); virtual;
    procedure DoRemoteManagerShutdown(const AManagerIdentifier: string); virtual;
    procedure SetLocalConnectionString(const ALocalConnection: string);
    class function CreateInstance: TTetheringAdapter; virtual; abstract;
    property KnownManagers: TStringList read GetKnownManagers;
    function ProfilesInfo: string;
    function GetRandomString(const Len: Integer = 10): string;
    function GenerateTimer(const AEvent: TTetheringNotifyEvent; Timeout: Cardinal): TThread;
    procedure StartManagersAutoConnect(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts); overload; virtual;
    procedure StartManagersAutoConnect(const ATargetList: TTetheringTargetHosts); overload;

    function GenerateToken(const AManager, Seed: string): string;
    procedure SaveTokenFromRemote(const AManager, Seed: string);
    function CheckToken(const AManager, Seed, Token: string): Boolean;
    function CheckPassword(const APassword, Seed: string): Boolean;
    procedure SaveTokenFromLocal(const AManager, Seed: string);
    function GetHash(const Data: string): string;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function GetClientPeer(const ProtocolId: TTetheringProtocolType): TTetheringCustomComm; virtual; abstract;
    function GetServerPeer(const ProtocolId: TTetheringProtocolType): TTetheringCustomServerComm; virtual; abstract;
    procedure PairManager(const ARemoteManager: TTetheringManagerInfo); virtual;
    procedure UnPairManager(const ARemoteManager: TTetheringManagerInfo); virtual;
    procedure SendNotification(const AManager: TTetheringManagerInfo; const AProfileId, ANotification, Data: string); virtual;
    procedure NotifyShutdown; virtual;
    procedure StartManagersDiscovery(const ATarget: string); overload;
    procedure StartManagersDiscovery(Timeout: Cardinal; const ATarget: string); overload; virtual;
    procedure StartManagersDiscovery(const ATargetList: TTetheringTargetHosts); overload;
    procedure StartManagersDiscovery(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts); overload; virtual;
    procedure StartProfilesDiscovery(const ARemoteManager: TTetheringManagerInfo; Timeout: Cardinal); virtual;
    procedure CancelManagersDiscovery;
    procedure CancelProfilesDiscovery(const ARemoteManager: TTetheringManagerInfo);
    /// <summary>Start the comunication thread of the Adapter.</summary>
    function StartListening: Boolean;
    /// <summary>Returns if the adapter is listening.</summary>
    function IsListening: Boolean;
    procedure StopListening;

    function MaxConnections: Integer; virtual; abstract;
    function GetTargetConnection(const Port, Offset: Integer): string; virtual; abstract;

    property Manager: TTetheringManager read FManager;
    property AdapterType: TTetheringAdapterType read GetAdapterType;

    class procedure RegisterLog(const DoLog: TTetheringDoLog);
    /// <summary>Function that returns True if Adapter's logging system has the given LogItem enabled for logging</summary>
    class function IsLoggingItem(ALogItem: TTetheringLogItem): Boolean;
    /// <summary>Adds to the Adapter's logging system the given LogItem</summary>
    class procedure AddLogItem(ALogItem: TTetheringLogItem);
    /// <summary>Removes from the Adapter's logging system the given LogItem</summary>
    class procedure RemoveLogItem(ALogItem: TTetheringLogItem);
  end;

  TTetheringAdapterClass = class of TTetheringAdapter;
  TTetheringAdapters = class
  private
    class var FAdapters: TDictionary<TTetheringAdapterType, TTetheringAdapterClass>;
    class function GetAdapterTypes: TTetheringAdapterTypes; static;
  public
    class procedure RegisterAdapter(const AnAdapter: TTetheringAdapterClass; const AType: TTetheringAdapterType);
    class procedure UnRegisterAdapter(const AType: TTetheringAdapterType);
    class function GetAdapterInstance(const AType: TTetheringAdapterType): TTetheringAdapter;

    class constructor Create;
    class destructor Destroy;
    class property Adapters: TTetheringAdapterTypes read GetAdapterTypes;
  end;

  TTetheringCommandType = (Command, SendResponse, CloseConnection, CreateConnection, SendStream, ReadStream, None, SendString, ReadString);
  TTetheringCommand = record
  private
    FCommandType: TTetheringCommandType;
    FCommand: string;
    FParameters: TArray<string>;
    FData: TObject;
    FVersion: Integer;
  const
    CommandSep = '$';
    CommandsLength = 11;
    ParameterSep = '#';
  public
    constructor Create(const ACommand: string; AVersion: Integer; const AParameters: array of string; const AData: TObject = nil); overload;
    constructor Create(const ACommand: string; AVersion: Integer; const AParameters: TArray<string>; const AData: TObject = nil); overload;
    constructor Create(AType: TTetheringCommandType; const ACommand: string; AVersion: Integer;
      const AParameters: TArray<string> = nil; const AData: TObject = nil); overload;
    constructor Create(AType: TTetheringCommandType; const ACommand: string; AVersion: Integer;
      const AParameters: array of string; const AData: TObject = nil); overload;
    constructor Create(const ACommand: string; AVersion: Integer); overload;
    constructor Create(const RawData: TBytes); overload;
    /// <summary>Converts a Tethering Command into a string that is prepared to be sent.</summary>
    function ToString: string;
    /// <summary>Converts a Tethering Command into a UTF8 TBytes that is prepared to be sent.</summary>
    function ToBytes: TBytes;

    /// <summary>property to acquire the command type of the given command.</summary>
    property CommandType: TTetheringCommandType read FCommandType;
    /// <summary>property to acquire the command string.</summary>
    property Command: string read FCommand;
    /// <summary>property to acquire the Data object associated with the command.</summary>
    property Data: TObject read FData;
    property Parameters: TArray<string> read FParameters;
    /// <summary>Version of the profile command.</summary>
    property Version: Integer read FVersion;
  end;
  TTetheringCommands = TArray<TTetheringCommand>;

  TTetheringProfile = class;

  ////////////////////////////
  ///  TTetheringProtocol  ///
  ////////////////////////////
  TProtocolCommandEvent = procedure(const Sender: TObject; const AConnection: TTetheringCustomComm;
     const ACommand: TTetheringCommand; var Response: TTetheringCommands) of object;
  TStreamReceivedEvent = procedure(const Sender: TObject; const AProfileId: string; const AStream: TStream; const ADescription: string) of object;
  TStringReceivedEvent = procedure(const Sender: TObject; const AProfileId: string; const AString: string; const ADescription: string) of object;
  TTetheringProtocol = class
  private
    FOnCommand: TProtocolCommandEvent;
    FIsConnected: Boolean;
    FOnAfterReceiveData: TTetheringDataEvent;
    FOnBeforeSendData: TTetheringDataEvent;
    FOnAfterReceiveStream: TTetheringStreamEvent;
    FOnBeforeSendStream: TTetheringStreamEvent;
  protected
    [Weak] FAdapter: TTetheringAdapter;
    /// <summary>Profile that is using this protocol instance.</summary>
    [Weak] FProfile: TTetheringProfile;
    procedure DoOnCommand(const Sender: TObject; const AConnection: TTetheringCustomComm; const ACommand: TTetheringCommand; var Response: TTetheringCommands);
    function GetProtocolType: TTetheringProtocolType; virtual; abstract;
    function GetIsConnected: Boolean; virtual; abstract;
    function GenerateToken(const AManager, Seed: string): string;
    procedure SaveTokenFromRemote(const AManager, Seed: string);
    function CheckToken(const AManager, Seed, Token: string): Boolean;
    function CheckPassword(const APassword, Seed: string): Boolean;
    procedure SaveTokenFromLocal(const AManager, Seed: string);
    function GetHash(const AValue: string): string;
    function GetRandomString(const Len: Integer = 10): string;
    procedure StopCommunication; virtual; abstract;
    procedure StartCommunication; virtual; abstract;
    /// <summary>Procedure to send data.</summary>
    /// <remarks>The protocol implementation must implement it </remarks>
    procedure DoSendData(const AData: TBytes); virtual; abstract;
    /// <summary>Function to Receive data.</summary>
    /// <remarks>The protocol implementation must implement it </remarks>
    function DoReceiveData: TBytes; virtual; abstract;
    /// <summary>Function to Receive a stream.</summary>
    /// <remarks>The protocol implementation must implement it </remarks>
    function DoReceiveStream(const AStream: TStream): Boolean; virtual; abstract;
    /// <summary>Function to Receive a stream.</summary>
    /// <remarks>The protocol implementation must implement it </remarks>
    function DoSendStream(const AStream: TStream): Boolean; virtual; abstract;

  public
    constructor Create(const AnAdapter: TTetheringAdapter; AsClient: Boolean = False); virtual; abstract;
    function Connect(const AProfile: TTetheringConnection): Boolean; virtual; abstract;
    procedure Disconnect; virtual; abstract;

    /// <summary>Function to Send data.</summary>
    procedure SendData(const AData: string); overload; inline;
    procedure SendData(const AData: TBytes); overload;
    /// <summary>Function to Receive string data.</summary>
    function ReceiveStringData: string; inline;
    /// <summary>Function to Receive data.</summary>
    function ReceiveData: TBytes; inline;

    /// <summary>Function to Receive a stream.</summary>
    function ReceiveStream(const AStream: TStream): Boolean; inline;
    /// <summary>Function to Send a stream.</summary>
    function SendStream(const AStream: TStream): Boolean; inline;

    function ReadStringData: string; inline; deprecated 'Use ReceiveStringData';
    function ReadData: TBytes; inline; deprecated 'Use ReceiveData';
    function ReadStream(const AStream: TStream): Boolean; inline; deprecated 'Use ReceiveStream';
    function TransferStream(const AStream: TStream): Boolean; inline; deprecated 'Use SendStream';

    function GetConnectionString(const ManagerConnectionString: string): string; virtual; abstract;
    class function CreateInstance(const AnAdapter: TTetheringAdapter; AsClient: Boolean): TTetheringProtocol; virtual; abstract;

    property ProtocolType: TTetheringProtocolType read GetProtocolType;
    property IsConnected: Boolean read GetIsConnected write FIsConnected;

    /// <summary> Event to post-process the buffered data.</summary>
    /// <remarks> This function when defined should process the DataBuffer, and put it's equivalent data into the Result.</remarks>
    property OnBeforeSendData: TTetheringDataEvent read FOnBeforeSendData write FOnBeforeSendData;
    /// <summary> Event to pre-process the buffered data.</summary>
    /// <remarks> This function when defined should process the DataBuffer, and put it's equivalent data into the Result.</remarks>
    property OnAfterReceiveData: TTetheringDataEvent read FOnAfterReceiveData write FOnAfterReceiveData;

    /// <summary> Event to post-process the stream data.</summary>
    /// <remarks> This function when defined should process the InputStream, and put it's equivalent data into the OutputStream.</remarks>
    property OnBeforeSendStream: TTetheringStreamEvent read FOnBeforeSendStream write FOnBeforeSendStream;
    /// <summary> Event to pre-process the stream data.</summary>
    /// <remarks> This function when defined should process the InputStream, and put it's equivalent data into the OutputStream.</remarks>
    property OnAfterReceiveStream: TTetheringStreamEvent read FOnAfterReceiveStream write FOnAfterReceiveStream;
  end;

  TTetheringProtocolClass = class of TTetheringProtocol;
  TTetheringProtocols = class
  private
    class var FProtocols: TDictionary<TTetheringProtocolType, TTetheringProtocolClass>;
    class function GetProtocolTypes: TTetheringProtocolTypes; static;
  public
    class procedure RegisterProtocol(const AProtocol: TTetheringProtocolClass; const AProtocolType: TTetheringProtocolType);
    class procedure UnRegisterProtocol(const AProtocolType: TTetheringProtocolType);
    class function GetProtocolInstance(const AProfile: TTetheringProfile; const AProtocolType: TTetheringProtocolType;
      const AnAdapter: TTetheringAdapter; AsClient: Boolean): TTetheringProtocol;
    class constructor Create;
    class destructor Destroy;
    class property Protocols: TTetheringProtocolTypes read GetProtocolTypes;
  end;

  TTetheringParam = string;
  TTetheringParams = TArray<TTetheringParam>;

  /// <summary>Record used to manage and process a Tethering Manager Command information.</summary>
  TTetheringManagerCommand = record
  private const
    EscapePrefix = '\';
    NumStaticParams  = 3;
  private
    function GetNumParams: Integer;
  public
    /// <summary>True if the decoded command is valid.</summary>
    ValidCommand: Boolean;
    /// <summary>Text of the Command.</summary>
    CommandText: string;
    /// <summary>Numeric definition of the Command.</summary>
    Command: Integer;
    /// <summary>Connction string where the command was generated.</summary>
    ConnectionString: string;
    /// <summary>Version of the Command.</summary>
    Version: Integer;
    /// <summary>Parameters of the Command.</summary>
    Params: TTetheringParams;

    /// <summary>Function to create a command from all of it's parts.</summary>
    class function Create(const ACommandText, AConnectionString: string; AVersion: Integer;
      const AParams: TTetheringParams): TTetheringManagerCommand; static;

    /// <summary>Number of parameters of the Command.</summary>
    property NumParams: Integer read GetNumParams;

    /// <summary>Covert the Command to a string.</summary>
    function ToString: string;

    /// <summary>Decode a string into a Command.</summary>
    procedure DecodeCommand(const ACommandString: string);

    /// <summary>Class function to Escape the ocurrences of a series of separators inside a Text.</summary>
    class function EscapeSeparator(const AText: string; const Separators: array of Char): string; static;
    /// <summary>Class function to UnEscape the ocurrences of a series of separators inside a Text.</summary>
    class function UnEscapeSeparator(const AText: string; const Separators: array of Char): string; static;

    /// <summary>Class function to Join an array of strings using a separator between each string, escaping the ocurrences
    /// of that separator inside each string.</summary>
    class function Join(const ASeparator: Char; const AValues: TArray<string>): string; static;
    /// <summary>Class function to split a string into an array of strings using a separator to delimit each string,
    /// unescaping the ocurrences of that separator inside each delimited string.</summary>
    class function Split(const AString: string; const ASeparator: Char): TArray<string>; static;
  end;


  TTetheringManagerCommunicationThread = class(TThread)
  protected const
    TetheringDiscoverManagers      = 'TetheringDiscoverManagers';
    TetheringServerDiscovered      = 'TetheringServerDiscovered';
    TetheringDiscoverProfiles      = 'TetheringDiscoverProfiles';
    TetheringBeginProfiles         = 'TetheringBeginProfiles';
    TetheringEndProfiles           = 'TetheringEndProfiles';
    TetheringRequestPair           = 'TetheringRequestPair';
    TetheringRequestUnPair         = 'TetheringRequestUnPair';
    TetheringRequestPassword       = 'TetheringRequestPassword';
    TetheringPassword              = 'TetheringPassword';
    TetheringPairAccepted          = 'TetheringPairAccepted';
    TetheringPairDenied            = 'TetheringPairDenied';
    TetheringNotification          = 'TetheringNotification';
    TetheringPairingToken          = 'TetheringPairingToken';
    TetheringGeneratedToken        = 'TetheringGeneratedToken';
    EMPTYTOKEN                     = 'EMPTYTOKEN';
    TetheringOk                    = 'Ok';
    TetheringError                 = 'Error';
    TetheringEmpty                 = '';
    TetheringVersion               = '1';
  protected type
    TPairingState = (Waiting, WaitingPairResponse, Paired, WaitingPassword);
    TNetworkInfo = class
    public
      State: TPairingState;
      RandomString: string;
      EndProfilesTimer: TThread;
      ManagerId: string;
      ManagerVersion: Integer;
      ManagerAdapters: string;
      destructor Destroy; override;
    end;

    TCommandQueue = class
      private
        FQueue: TQueue<string>;
        FEvent: TEvent;
      public
        constructor Create;
        destructor Destroy; override;
        procedure Enqueue(const Acommand: string);
        function Dequeue: string;
        function Count: Integer;
        procedure WaitCommand;
    end;

  protected
    /// <summary>Command queue that holds all the received commands pending to process.</summary>
    FCommandQueue: TCommandQueue;
    FAdapter: TTetheringAdapter;
    FNotifyEndProfileDiscovery: TTetheringNotifyEvent;
    FNetworkInfo: TObjectDictionary<string, TNetworkInfo>;

    FEventAdapterSync: TEvent;
    procedure CommunicationThreadInitialized;
    procedure AddProfiles(const AConnectionString, AData: string);

    /// <summary> Return if the servers in the communication thread are listening.</summary>
    function IsListening: Boolean; virtual; abstract;

    function GetState(const Connection: string): TPairingState; virtual;
    procedure SetState(const Connection: string; AState: TPairingState); virtual;
    procedure SetManagerId(const Connection: string; const AManagerId: string); virtual;

    function GetNetworkInfo(const Connection: string): TNetworkInfo; virtual;
    function GetNetworkInfoByManager(const AManagerId: string): TNetworkInfo; virtual;

    function GenerateRandomString(const AConnection: string): string; virtual;
    function GetRandomString(const AConnection: string): string; virtual;

    function CreateManagerInfo(const AIdentifier, AName, AText, AConnectionString: string; AVersion: Integer): TTetheringManagerInfo;
    procedure CreateDiscoverProfilesTimer(const AConnection: string; Timeout: Cardinal);
    procedure DestroyDiscoverProfilesTimer(const AConnection: string);
    /// <summary>Cancels the timer for discover profiles process.</summary>
    procedure CancelDiscoverProfilesTimer(const AConnection: string);
    /// <summary>Indicates whether it is in the process of discovering profiles.</summary>
    function IsDiscoveringProfiles(const AConnection: string): Boolean;

    function GetRemoteConnectionString(const AConnection: string): string; virtual;

    function ProcessResponse(const AData: string; var RemoteConnectionString: string): string; virtual;
    procedure DoSendCommand(const AConnection, AData: string); virtual; abstract;
    property NotifyEndProfileDiscovery: TTetheringNotifyEvent read FNotifyEndProfileDiscovery write FNotifyEndProfileDiscovery;

    /// <summary>Wait for CommunicationThread initialization, (CommunicationThreadInitialized)</summary>
    procedure WaitCommThreadInitialization; virtual;
  public
    constructor Create(const AnAdapter: TTetheringAdapter); virtual;
    destructor Destroy; override;
    function CommandStr(const ACommand: string; AVersion: Integer; const Params: TTetheringParams): string;
    procedure SendCommand(const AConnection, AData: string);
  end;

  TTetheringCustomStorage = class
  public
    function LoadManagerGUID: string; virtual; abstract;
    procedure SaveManagerGUID(const AIdentifier: string); virtual; abstract;
    procedure LoadRemoteManagersGUIDs(const AGUIDPassList: TStringList); virtual; abstract;
    procedure SaveRemoteManagersGUIDs(const AGUIDPassList: TStringList); virtual; abstract;
  end;

  TTetheringOnRequestStorage = procedure(const Sender: TObject; var AStorage: TTetheringCustomStorage) of object;

  TTetheringManager = class(TComponent)
  private
    FRemoteProfiles: TTetheringProfileInfoList;
    FRemoteManagers: TTetheringManagerInfoList;
    FRemoteAutoManagers: TTetheringManagerInfoList;
    FPairedManagers: TTetheringManagerInfoList;
    FOnEndManagersDiscovery: TTetheringEndManagersDiscoveryEvent;
    FOnEndProfilesDiscovery: TTetheringEndProfilesDiscoveryEvent;
    FOnEndAutoConnect: TNotifyEvent;
    FKnownManagers: TStringList;
    FIdentifier: string;
    FText: string;
    FVersion: Integer;
    FRegisteredProfiles: TList<TTetheringProfile>;
    FAdapters: TObjectList<TTetheringAdapter>;
    FOnRequestManagerPassword: TTetheringRequestManagerPasswordEvent;
    FOnPairedToRemote: TTetheringManagerPairedEvent;
    FOnPairedFromLocal: TTetheringManagerPairedEvent;
    FOnAuthErrorFromLocal: TTetheringErrorAuthEvent;
    FOnAuthErrorFromRemote: TTetheringErrorAuthEvent;
    FOnNewManager: TTetheringNewManagerEvent;
    FOnUnPairManager: TTetheringUnPairManagerEvent;
    FOnRemoteManagerShutdown: TTetheringRemoteManagerShutdownEvent;
    FOnRequestStorage: TTetheringOnRequestStorage;
    FPassword: string;
    FStorage: TTetheringCustomStorage;
    FTempPasswords: TDictionary<string, string>;
    FAutoConnect: Boolean;
    FEnabled: Boolean;
    FOnError: TTetheringNotifyErrorEvent;
    FOnCommError: TTetheringNotifyCommErrorEvent;

    FAllowedAdapters: TTetheringAdapterTypes;

    function AdapterAllowed(AnAdapterType: TTetheringAdapterType): Boolean;

    procedure DoEndManagersDiscovery(const ARemoteManagers: TTetheringManagerInfoList);
    procedure DoEndProfilesDiscovery(const ARemoteProfiles: TTetheringProfileInfoList);
    procedure RegisterManagers(const ARemoteManagers: TTetheringManagerInfoList);
    procedure RegisterProfiles(const ARemoteProfiles: TTetheringProfileInfoList);
    procedure DoRequestManagerPassword(const ARemoteIdentifier: string; var APassword: string);
    procedure DoPairedToRemote(const AManagerInfo: TTetheringManagerInfo);
    procedure DoPairedFromLocal(const AManagerInfo: TTetheringManagerInfo);
    procedure DoRequestedNotification(const AProfileId, ANotification, Data: string);
    procedure DoAuthErrorFromLocal(const AManagerIdentifier: string);
    procedure DoAuthErrorFromRemote(const AManagerIdentifier: string);
    procedure DoNewManager(const AManager: TTetheringManagerInfo);
    procedure DoUnPairManager(const AManager: TTetheringManagerInfo);
    procedure DoRemoteManagerShutdown(const AManagerIdentifier: string);
    procedure DoRequestStorage(var AStorage: TTetheringCustomStorage);
    procedure DoEndAutoConnectDiscover(const ARemoteManagers: TTetheringManagerInfoList);

    procedure DisconnetProfilesFromManager(const AManagerId: string);
    function ManagerExists(const ARemoteManagers: TList<TTetheringManagerInfo>; const AManagerIdentifier: string): Boolean;
    function FindManager(const Id: string): TTetheringManagerInfo; overload;
    function FindManager(const Id: string; const AList: TTetheringManagerInfoList): TTetheringManagerInfo; overload;
    function FindAutoManager(const AManagerIdentifier: string): Integer;
    // Adapter management
    procedure AutoCreateAdapters;
    procedure RegisterAdapter(const AnAdapter: TTetheringAdapter);
    procedure UnRegisterAdapter(const AnAdapter: TTetheringAdapter);
    function GenerateTimer(const AEvent: TTetheringNotifyEvent; Timeout: Cardinal): TThread;
    function GenerateToken(const AManager, Seed: string): string;
    procedure SaveTokenFromRemote(const AManager, Seed: string);
    function CheckToken(const AManager, Seed, Token: string): Boolean;
    function CheckPassword(const APassword, Seed: string): Boolean;
    procedure SaveTokenFromLocal(const AManager, Seed: string);
    procedure SetEnabled(const Value: Boolean);
    function GetAllowedAdapters: string;
    procedure SetAllowedAdapters(const Value: string);

    procedure AddRemoteAutoManager(const AManagerInfo: TTetheringManagerInfo);
    procedure DeleteRemoteAutoManagers(AManagerIndex: Integer);
  protected
    procedure SetName(const NewName: TComponentName); override;
    /// <summary> Manages a connection error</summary>
    procedure DoCommError(const AProfile: TTetheringProfileInfo);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DiscoverManagers(Timeout: Cardinal; const ATarget: string = ''); overload;
    procedure DiscoverManagers(const ATarget: string = ''); overload;
    procedure DiscoverManagers(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts); overload;
    procedure DiscoverManagers(const ATargetList: TTetheringTargetHosts); overload;
    procedure CancelDiscoverManagers;
    procedure PairManager(const ARemoteManager: TTetheringManagerInfo);
    procedure UnPairManager(const ARemoteManager: TTetheringManagerInfo); overload;
    procedure UnPairManager(const ARemoteManagerIdentifier: string); overload;
    procedure DiscoverProfiles(const ARemoteManager: TTetheringManagerInfo; Timeout: Cardinal = 5000);
    procedure CancelDiscoverProfiles(const ARemoteManager: TTetheringManagerInfo);

    procedure RegisterProfile(const AProfile: TTetheringProfile);
    procedure UnRegisterProfile(const AProfile: TTetheringProfile);

    function FindRegisteredProfile(const AProfileId: string): TTetheringProfile;
    procedure SendNotification(const AManagerId, AProfileId, ANotification, Data: string);

    procedure AutoConnect(Timeout: Cardinal; const ATarget: string = ''); overload;
    procedure AutoConnect(const ATarget: string = ''); overload;
    procedure AutoConnect(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts); overload;
    procedure AutoConnect(const ATargetList: TTetheringTargetHosts); overload;

    class function ProfileInfoToString(const AProfileInfo: TTetheringProfileInfo): string;
    class function StringToProfileInfo(const AProfileString: string): TTetheringProfileInfo; inline;

    property Adapters: TObjectList<TTetheringAdapter> read FAdapters;
    property Identifier: string read FIdentifier;
    property RegisteredProfiles: TList<TTetheringProfile> read FRegisteredProfiles;
    property RemoteManagers: TTetheringManagerInfoList read FRemoteManagers;
    property RemoteProfiles: TTetheringProfileInfoList read FRemoteProfiles;
    property PairedManagers: TTetheringManagerInfoList read FPairedManagers;
    /// <summary>Property to obtain the Manager version number.</summary>
    property Version: Integer read FVersion;

  published
    // Available Events
    property OnAuthErrorFromLocal: TTetheringErrorAuthEvent read FOnAuthErrorFromLocal write FOnAuthErrorFromLocal;
    property OnAuthErrorFromRemote: TTetheringErrorAuthEvent read FOnAuthErrorFromRemote write FOnAuthErrorFromRemote;
    property OnEndManagersDiscovery: TTetheringEndManagersDiscoveryEvent read FOnEndManagersDiscovery write FOnEndManagersDiscovery;
    property OnEndProfilesDiscovery: TTetheringEndProfilesDiscoveryEvent read FOnEndProfilesDiscovery write FOnEndProfilesDiscovery;
    property OnPairedFromLocal: TTetheringManagerPairedEvent read FOnPairedFromLocal write FOnPairedFromLocal;
    property OnPairedToRemote: TTetheringManagerPairedEvent read FOnPairedToRemote write FOnPairedToRemote;
    property OnRequestManagerPassword: TTetheringRequestManagerPasswordEvent read FOnRequestManagerPassword write FOnRequestManagerPassword;
    property OnNewManager: TTetheringNewManagerEvent read FOnNewManager write FOnNewManager;
    property OnUnPairManager: TTetheringUnPairManagerEvent read FOnUnPairManager write FOnUnPairManager;
    property OnRemoteManagerShutdown: TTetheringRemoteManagerShutdownEvent read FOnRemoteManagerShutdown write FOnRemoteManagerShutdown;
    property OnEndAutoConnect: TNotifyEvent read FOnEndAutoConnect write FOnEndAutoConnect;
    property Password: string read FPassword write FPassword;
    property OnRequestStorage: TTetheringOnRequestStorage read FOnRequestStorage write FOnRequestStorage;
    property Text: string read FText write FText;
    property Enabled: Boolean read FEnabled write SetEnabled default True;

    property AllowedAdapters: string read GetAllowedAdapters write SetAllowedAdapters;
    /// <summary>This event is launched when an error happens.</summary>
    property OnError: TTetheringNotifyErrorEvent read FOnError write FOnError;

    /// <summary>Event to manage communication errors.</summary>
    property OnCommError: TTetheringNotifyCommErrorEvent read FOnCommError write FOnCommError;
  end;

  TTetheringProfile = class(TComponent)
  private
    FProtocols: TList<TTetheringProtocol>;
    FIdentifier: string;
    FImplementedProtocolAdapters: TTetheringProtocolAdapterTypes;
    FManager: TTetheringManager;
    FOnDisconnect: TTetheringProfileEvent;
    FVisible: Boolean;
    FText: string;
    FGroup: string;
    FEnabled: Boolean;
    FOnAfterReceiveData: TTetheringDataEvent;
    FOnBeforeSendData: TTetheringDataEvent;
    FOnAfterReceiveStream: TTetheringStreamEvent;
    FOnBeforeSendStream: TTetheringStreamEvent;
    FOnBeforeConnectProfile: TTetheringBeforeConnectEvent;
    FOnAfterConnectProfile: TTetheringProfileEvent;
    procedure SetupProtocols;
    procedure ClearProtocols;
    procedure SetImplementedProtocols(const Value: TTetheringProtocolAdapterTypes);
    procedure SetManager(const AManager: TTetheringManager);
    procedure SetEnabled(const Value: Boolean);
  protected
    FProfileType: TTetheringProfileType;
    FConnectedProfiles: TTetheringProfileInfoList;
    /// <summary>Connections associated to remote profiles.</summary>
    FConnections: TObjectDictionary<TTetheringProfileInfo, TTetheringConnection>;
    /// <summary>Version number of the profile.</summary>
    FVersion: Integer;
    function CheckManager(const AManagerID: string): Boolean;
    function GetProfileType: TTetheringProfileType; virtual; abstract;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    /// <summary> Function that fires OnBeforeConnect Event to Inform and allow/deny connection when a profile is trying to connect to us.</summary>
    function DoOnBeforeConnect(const AProfileInfo: TTetheringProfileInfo): Boolean; virtual;
    /// <summary> Function that fires OnAfterConnect Event to Inform after a profile is connected to us.</summary>
    procedure DoOnAfterConnect(const AProfileInfo: TTetheringProfileInfo); virtual;
    procedure DoOnDisconnect(const AProfileInfo: TTetheringProfileInfo); virtual;
    /// <summary>Process incoming data from another profile, received from a Protocol.</summary>
    /// <remarks>The profile implementation must implement it </remarks>
    procedure DoOnIncomingData(const AProtocol: TTetheringProtocol; const AData: TBytes); virtual; abstract;

    procedure OnStreamReceived(const Sender: TObject; const AProfileId: string; const AStream: TStream; const ADescription: string); virtual; abstract;
    /// <summary> Handles an incoming string that a connected remote profile sends.</summary>
    procedure OnStringReceived(const Sender: TObject; const AProfileId: string; const AString: string; const ADescription: string); virtual; abstract;
    procedure SetName(const NewName: TComponentName); override;
    procedure AddConnectedProfile(const AProfileInfo: TTetheringProfileInfo); virtual;
    procedure DisconnectFromManager(const AManagerId: string); virtual; abstract;
    function CheckProtocolAdapter(const AProtocolType: TTetheringProtocolType; const AnAdapterType: TTetheringAdapterType): Boolean; virtual;
    function GetAdapter(AnAdapterType: TTetheringAdapterType): TTetheringAdapter; virtual;
    procedure StartCommunication;
    procedure StopCommunication;

    /// <summary> Checks if a Profile is connected.</summary>
    function IsProfileConnected(const AProfileInfo: TTetheringProfileInfo): Boolean;
    /// <summary> Checks if a Profile is connected.</summary>
    /// <remarks>This function fires an exception if  the profile is not connected.</remarks>
    procedure CheckProfileIsConnected(const AProfile: TTetheringProfileInfo); inline;
    /// <summary> Checks if a Profile exists and returns its ProfileInfo.</summary>
    function FindProfile(const AProfileId: string; var AProfileInfo: TTetheringProfileInfo): Boolean;

    /// <summary> Find the Connection associated to the ProfileInfo.</summary>
    function FindConnection(const AProfile: TTetheringProfileInfo): TTetheringConnection; virtual;
    /// <summary> Obtain the Connection associated to the ProfileInfo.</summary>
    function GetConnectionTo(const AProfile: TTetheringProfileInfo; const AProtocolType: TTetheringProtocolType = '';
      const AnAdapterType: TTetheringAdapterType = ''; Connect: Boolean = True): TTetheringConnection; virtual;

    /// <summary>Function to Receive a Command.</summary>
    function DoReceiveCommand(const AConnection: TTetheringConnection): TTetheringCommand; virtual;
    /// <summary>Function to Send a Command.</summary>
    procedure DoSendCommand(const AConnection: TTetheringConnection; const ACommand: TTetheringCommand); virtual;
    /// <summary>Function to Send a Command waiting for a response.</summary>
    function DoSendCommandWithResponse(const AConnection: TTetheringConnection; const ACommand: TTetheringCommand): TTetheringCommand; virtual;

    /// <summary> Manages a connection error</summary>
    procedure DoCommError(const AProfile: TTetheringProfileInfo);
    /// <summary> Find the Profile associated to a Connection.</summary>
    function FindProfileFromConnection(const AConnection: TTetheringConnection): TTetheringProfileInfo; virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function CreateInstance(const AOwnerManager: TTetheringManager): TTetheringProfile; virtual; abstract;
    function Connect(const AProfile: TTetheringProfileInfo; const AProtocolType: TTetheringProtocolType = '';
      const AnAdapterType: TTetheringAdapterType = ''): Boolean; virtual; abstract;
    procedure Disconnect(const AProfile: TTetheringProfileInfo); virtual;
    function GetConnectedProfiles: TArray<TTetheringProfileInfo>; virtual;
    procedure Notify(const ANotification, Data: string); virtual; abstract;
    class function GetAllowedProtocolsAdapters: TTetheringProtocolAdapterTypes; virtual; abstract;
    property Identifier: string read FIdentifier;
    property Protocols: TList<TTetheringProtocol> read FProtocols;
    property ConnectedProfiles: TTetheringProfileInfoList read FConnectedProfiles;

    /// <summary>Property to access Version number of the profile.</summary>
    property Version: Integer read FVersion;

    /// <summary>Function to Receive a Command from a given profile.</summary>
    function ReceiveCommand(const AProfile: TTetheringProfileInfo): TTetheringCommand; overload;
    function ReceiveCommand(const AConnection: TTetheringConnection): TTetheringCommand; overload;

    /// <summary>Function to Send a command to a profile.</summary>
    procedure SendCommand(const AProfile: TTetheringProfileInfo; const ACommand: TTetheringCommand); overload;
    procedure SendCommand(const AConnection: TTetheringConnection; const ACommand: TTetheringCommand); overload;

    /// <summary>Function to Send a command and receive inmediately a response to that command.</summary>
    function SendCommandWithResponse(const AProfile: TTetheringProfileInfo; const ACommand: TTetheringCommand): TTetheringCommand; overload;
    function SendCommandWithResponse(const AConnection: TTetheringConnection; const ACommand: TTetheringCommand): TTetheringCommand; overload;

  published
    property ProfileType: TTetheringProfileType read GetProfileType;
    property ImplementedProtocolAdapters: TTetheringProtocolAdapterTypes read FImplementedProtocolAdapters write SetImplementedProtocols;
    property Manager: TTetheringManager read FManager write SetManager;
    property Text: string read FText write FText;
    property Visible: Boolean read FVisible write FVisible default True;
    property Group: string read FGroup write FGroup;
    property Enabled: Boolean read FEnabled write SetEnabled default True;

    property OnDisconnect: TTetheringProfileEvent read FOnDisconnect write FOnDisconnect;
    /// <summary> Event to Inform and allow/deny connection when a profile is trying to connect to us.</summary>
    property OnBeforeConnectProfile: TTetheringBeforeConnectEvent read FOnBeforeConnectProfile write FOnBeforeConnectProfile;
    /// <summary> Event to Inform after a profile is connected to us.</summary>
    property OnAfterConnectProfile: TTetheringProfileEvent read FOnAfterConnectProfile write FOnAfterConnectProfile;

    /// <summary> Event to post-process the buffered data.</summary>
    /// <remarks> This function when defined should process the DataBuffer, and put it's equivalent data into the Result.</remarks>
    property OnBeforeSendData: TTetheringDataEvent read FOnBeforeSendData write FOnBeforeSendData;
    /// <summary> Event to pre-process the buffered data.</summary>
    /// <remarks> This function when defined should process the DataBuffer, and put it's equivalent data into the Result.</remarks>
    property OnAfterReceiveData: TTetheringDataEvent read FOnAfterReceiveData write FOnAfterReceiveData;
    /// <summary> Event to post-process the stream data.</summary>
    /// <remarks> This function when defined should process the InputStream, and put it's equivalent data into the OutputStream.</remarks>
    property OnBeforeSendStream: TTetheringStreamEvent read FOnBeforeSendStream write FOnBeforeSendStream;
    /// <summary> Event to pre-process the stream data.</summary>
    /// <remarks> This function when defined should process the InputStream, and put it's equivalent data into the OutputStream.</remarks>
    property OnAfterReceiveStream: TTetheringStreamEvent read FOnAfterReceiveStream write FOnAfterReceiveStream;
  end;

  TTetheringProfileClass = class of TTetheringProfile;
  TTetheringProfiles = class
  private
    class var FProfiles: TDictionary<TTetheringProfileType, TTetheringProfileClass>;
    class var FProfileProtocolsAdapters: TObjectDictionary<TTetheringProfileType,
        TList<TPair<TTetheringProtocolType,TTetheringAdapterType>>>;
    class function GetProfiles: TTetheringProfileTypes; static;
  public
    class function GetProfileProtocolAdapters(const AProfileType: TTetheringProfileType): TTetheringProtocolAdapterTypes; static;

    class procedure RegisterProfile(const AProfile: TTetheringProfileClass; const AType: TTetheringProfileType);
    class procedure UnRegisterProfile(const AType: TTetheringProfileType);
    class function GetProfileInstance(const AType: TTetheringProfileType; const AOwnerManager: TTetheringManager): TTetheringProfile;

    class procedure RegisterProfileProtocolAdapter(const AProfileType: TTetheringProfileType;
        const AProtocol: TTetheringProtocolType; const AnAdapter: TTetheringAdapterType);
    class procedure UnRegisterProfileProtocolAdapter(const AProfileType: TTetheringProfileType;
        const AProtocol: TTetheringProtocolType; const AnAdapter: TTetheringAdapterType);

    class constructor Create;
    class destructor Destroy;
    class property Profiles: TTetheringProfileTypes read GetProfiles;
    class property AllowedProtocolAdapters[const AProfileType: TTetheringProfileType]: TTetheringProtocolAdapterTypes
       read GetProfileProtocolAdapters;
  end;


implementation

uses
  System.Hash,
  System.Tether.Consts, System.TypInfo;


type
  TTetheringManagerInfoHelper = record helper for TTetheringManagerInfo
  protected
    class function CreateBlankArray(ACount: Integer): TTetheringAdapterTypes; static;
    class function AdapterIndex(const AAdapters: TTetheringAdapterTypes; const AnAdapter: string): Integer; static;
    class function CreateArrayString(const AValue, AnAdapters, AnAdapterType: string): string; static;
    class function MergeArrayString(const OldString, NewString: string): string; static;
    class function FindManagerIndex(const AManagerList: TTetheringManagerInfoList; const AManagerId: string): Integer; static;
  public
    function MergeManagerInfo(const AManagerInfo: TTetheringMAnagerInfo): TTetheringManagerInfo;
    procedure AddConnectionString(const AConnection, AnAdapterType: string);
    function GetConnectionString(const AnAdapterType: string): string;
  end;

class function TTetheringManagerInfoHelper.CreateBlankArray(ACount: Integer): TTetheringAdapterTypes;
var
  I: Integer;
begin
  SetLength(Result, ACount);
  for I := Low(Result) to High(Result) do
    Result[I] := TTetheringManagerCommunicationThread.EMPTYTOKEN;
end;

class function TTetheringManagerInfoHelper.AdapterIndex(const AAdapters: TTetheringAdapterTypes; const AnAdapter: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := Low(AAdapters) to High(AAdapters) do
    if AAdapters[I] = AnAdapter then
      Exit(I);
end;

procedure TTetheringManagerInfoHelper.AddConnectionString(const AConnection, AnAdapterType: string);
begin
  ConnectionString := MergeArrayString(ConnectionString, CreateArrayString(AConnection, ManagerAdapters, AnAdapterType));
end;

class function TTetheringManagerInfoHelper.CreateArrayString(const AValue, AnAdapters, AnAdapterType: string): string;
var
  LAdapters,
  LParts: TTetheringAdapterTypes;
  LIndex: Integer;
begin
  LAdapters := AnAdapters.Split(['|']);
  LParts := CreateBlankArray(Length(LAdapters));
  LIndex := AdapterIndex(LAdapters, AnAdapterType);
  LParts[LIndex] := AValue;
  Result := string.Join('|', LParts);
end;

class function TTetheringManagerInfoHelper.MergeArrayString(const OldString, NewString: string): string;
var
  LOldParts,
  LParts: TArray<string>;
  I: Integer;
begin
  Result := TTetheringManagerCommunicationThread.EMPTYTOKEN;
  LOldParts := OldString.Split(['|']);
  LParts := NewString.Split(['|']);
  if Length(LParts) = Length(LOldParts) then
  begin
    for I := Low(LParts) to High(LParts) do
      if LParts[I] <> TTetheringManagerCommunicationThread.EMPTYTOKEN then
        LOldParts[I] := LParts[I];
    Result := string.Join('|', LOldParts);
  end;
end;

function TTetheringManagerInfoHelper.MergeManagerInfo(const AManagerInfo: TTetheringMAnagerInfo): TTetheringManagerInfo;
begin
  Self.ConnectionString := TTetheringManagerInfo.MergeArrayString(Self.ConnectionString, AManagerInfo.ConnectionString);
end;

class function TTetheringManagerInfoHelper.FindManagerIndex(const AManagerList: TTetheringManagerInfoList; const AManagerId: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to AManagerList.Count - 1 do
    if AManagerList[I].ManagerIdentifier = AManagerId then
      Exit(I);
end;

function TTetheringManagerInfoHelper.GetConnectionString(const AnAdapterType: string): string;
var
  LParts: TTetheringAdapterTypes;
  LIndex: Integer;
begin
  LParts := Self.ConnectionString.Split(['|']);
  LIndex := Self.AdapterIndex(Self.ManagerAdapters.Split(['|']), AnAdapterType);
  Result := LParts[LIndex];
end;

{ TTetheringAdapter.TThreadTimer }

procedure TTetheringAdapter.TThreadTimer.Stop;
begin
  FOnTimer := nil;
  FEvent.SetEvent;
end;

constructor TTetheringAdapter.TThreadTimer.Create(const AEvent: TTetheringNotifyEvent; Timeout: Cardinal);
begin
  inherited Create(True);
  FOnTimer := AEvent;
  FTimeout := Timeout;
  FEvent := TEvent.Create;
end;

destructor TTetheringAdapter.TThreadTimer.Destroy;
begin
  Stop;
  inherited;
  FEvent.Free;
end;

procedure TTetheringAdapter.TThreadTimer.Execute;
begin
  inherited;
  FEvent.WaitFor(FTimeout);
  if not FCancelled and Assigned(FOnTimer) then
    FOnTimer(nil);
end;

procedure TTetheringAdapter.TThreadTimer.Cancel;
begin
  FCancelled := True;
  FEvent.SetEvent;
end;

{ TTetheringManager }

function TTetheringManager.AdapterAllowed(AnAdapterType: TTetheringAdapterType): Boolean;
var
  I: Integer;
begin
  Result := Length(FAllowedAdapters) = 0;
  for I := Low(FAllowedAdapters) to High(FAllowedAdapters) do
    if FAllowedAdapters[I] = AnAdapterType then
      Exit(True);
end;

procedure TTetheringManager.AutoConnect(Timeout: Cardinal; const ATarget: string);
var
  LTargetArray: TTetheringTargetHosts;
begin
  LTargetArray := ATarget.Split([';']);
  AutoConnect(Timeout, LTargetArray);
end;

procedure TTetheringManager.AutoConnect(const ATarget: string);
var
  LTargetArray: TTetheringTargetHosts;
begin
  LTargetArray := ATarget.Split([';']);
  AutoConnect(LTargetArray);
end;

procedure TTetheringManager.AutoConnect(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts);
var
  I: Integer;
begin
  for I := 0 to FAdapters.Count - 1 do
    FAdapters[I].StartManagersAutoConnect(Timeout, ATargetList);
end;

procedure TTetheringManager.AddRemoteAutoManager(const AManagerInfo: TTetheringManagerInfo);
begin
  TMonitor.Enter(FRemoteAutoManagers);
  try
    FRemoteAutoManagers.Add(AManagerInfo);
  finally
    TMonitor.Exit(FRemoteAutoManagers);
  end;
end;

procedure TTetheringManager.AutoConnect(const ATargetList: TTetheringTargetHosts);
var
  I: Integer;
begin
  for I := 0 to FAdapters.Count - 1 do
    FAdapters[I].StartManagersAutoConnect(ATargetList);
end;

procedure TTetheringManager.AutoCreateAdapters;
var
  AdapterType: TTetheringAdapterType;
  LAdapter: TTetheringAdapter;
begin
  if (not (csDesigning in ComponentState)) and (FAdapters.Count = 0) then
    for AdapterType in TTetheringAdapters.Adapters do
    begin
      if AdapterAllowed(AdapterType) then
      begin
        // Now we create the adapter instance.
        LAdapter := TTetheringAdapters.GetAdapterInstance(AdapterType);
        // We can only register those adapters that are physically available and whose adapter type is allowed;
        if LAdapter <> nil then
          RegisterAdapter(LAdapter);
      end
    end;
end;

procedure TTetheringManager.CancelDiscoverManagers;
var
  I: Integer;
begin
  for I := 0 to FAdapters.Count - 1 do
    FAdapters[I].CancelManagersDiscovery;
end;

procedure TTetheringManager.CancelDiscoverProfiles(const ARemoteManager: TTetheringManagerInfo);
begin
  ARemoteManager.Adapter.CancelProfilesDiscovery(ARemoteManager);
end;

constructor TTetheringManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FAllowedAdapters := ['Network'];
  FEnabled := True;
  Text := Name;
  FVersion := 1;

  FAdapters := TObjectList<TTetheringAdapter>.Create;
  FRegisteredProfiles := TList<TTetheringProfile>.Create;
  FRemoteManagers := TTetheringManagerInfoList.Create;
  FRemoteAutoManagers := TTetheringManagerInfoList.Create;
  FRemoteProfiles := TTetheringProfileInfoList.Create;
  FPairedManagers := TTetheringManagerInfoList.Create;
  FKnownManagers := TStringList.Create;
  FTempPasswords := TDictionary<string, string>.Create;
end;

function TTetheringManager.CheckPassword(const APassword, Seed: string): Boolean;
begin
  Result := THashSHA1.GetHashString(Password + Seed) = APassword;
end;

function TTetheringManager.CheckToken(const AManager, Seed, Token: string): Boolean;
var
  Index: Integer;
begin
  Result := False;

  Index := FKnownManagers.IndexOfName(AManager);
  if Index >= 0 then
    Result := THashSHA1.GetHashString(FKnownManagers.ValueFromIndex[Index] + Seed) = Token;
end;

procedure TTetheringManager.DeleteRemoteAutoManagers(AManagerIndex: Integer);
begin
  TMonitor.Enter(FRemoteAutoManagers);
  try
    FRemoteAutoManagers.Delete(AManagerIndex);
  finally
    TMonitor.Exit(FRemoteAutoManagers);
  end;
end;

destructor TTetheringManager.Destroy;
var
  I: Integer;
begin
  Enabled := False;

  for I := FRegisteredProfiles.Count - 1 downto 0  do
    FRegisteredProfiles[I].Notification(Self, opRemove);

  for I := FAdapters.Count - 1 downto 0 do
    UnRegisterAdapter(FAdapters[I]);

  FAdapters.Free;
  FStorage.Free;
  FKnownManagers.Free;
  FPairedManagers.Free;
  FRemoteProfiles.Free;
  FRemoteAutoManagers.Free;
  FRemoteManagers.Free;
  FRegisteredProfiles.Free;
  FTempPasswords.Free;
  inherited;
end;

procedure TTetheringManager.DiscoverManagers(Timeout: Cardinal; const ATarget: string);
var
  LTargetArray: TTetheringTargetHosts;
begin
  LTargetArray := ATarget.Split([';']);
  DiscoverManagers(Timeout, LTargetArray);
end;

procedure TTetheringManager.DiscoverManagers(const ATarget: string);
var
  LTargetArray: TTetheringTargetHosts;
begin
  LTargetArray := ATarget.Split([';']);
  DiscoverManagers(LTargetArray);
end;

procedure TTetheringManager.DiscoverManagers(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts);
var
  I: Integer;
begin
  if Enabled then
  begin
    for I := 0 to FAdapters.Count - 1 do
      FAdapters[I].StartManagersDiscovery(Timeout, ATargetList);
  end
  else
    raise ETetheringException.CreateFmt(SDisabledManager, [Identifier]);
end;

procedure TTetheringManager.DiscoverManagers(const ATargetList: TTetheringTargetHosts);
var
  I: Integer;
begin
  if Enabled then
  begin
    for I := 0 to FAdapters.Count - 1 do
      FAdapters[I].StartManagersDiscovery(ATargetList);
  end
  else
    raise ETetheringException.CreateFmt(SDisabledManager, [Identifier]);
end;

procedure TTetheringManager.DiscoverProfiles(const ARemoteManager: TTetheringManagerInfo; Timeout: Cardinal);
begin
  ARemoteManager.Adapter.StartProfilesDiscovery(ARemoteManager, Timeout);
end;

procedure TTetheringManager.DoPairedFromLocal(const AManagerInfo: TTetheringManagerInfo);
var
  LManagerInfo: TTetheringManagerInfo;
begin
  if not ManagerExists(FPairedManagers, AManagerInfo.ManagerIdentifier) then
    FPairedManagers.Add(AManagerInfo);
  DiscoverProfiles(AManagerInfo);
  if Assigned(FOnPairedFromLocal) then
  begin
    LManagerInfo := AManagerInfo;
    TThread.Synchronize(nil,
      procedure
      begin
        FOnPairedFromLocal(Self, LManagerInfo);
      end);
  end;
end;

procedure TTetheringManager.DoEndAutoConnectDiscover(const ARemoteManagers: TTetheringManagerInfoList);

  procedure RegisterAutoManagers(const ARemoteManagers: TList<TTetheringManagerInfo>);
  var
    I: Integer;
  begin
    if ARemoteManagers <> nil then
      for I := 0 to ARemoteManagers.Count - 1 do
        if FindAutoManager(ARemoteManagers[I].ManagerIdentifier) < 0 then
          AddRemoteAutoManager(ARemoteManagers[I]);
  end;

var
  I: Integer;
begin
  if ARemoteManagers <> nil then
  begin
    if ARemoteManagers.Count = 0 then
    begin
      FAutoConnect := False;
      if Assigned(FOnEndAutoConnect) then
        TThread.Synchronize(nil,
          procedure
          begin
            FOnEndAutoConnect(Self);
          end);
    end
    else
    begin
      RegisterManagers(ARemoteManagers);
      RegisterAutoManagers(ARemoteManagers);
      FAutoConnect := True;
      for I := 0 to ARemoteManagers.Count -1 do
        PairManager(ARemoteManagers[I]);
    end;
  end;
end;

procedure TTetheringManager.DoEndManagersDiscovery(const ARemoteManagers: TTetheringManagerInfoList);
begin
  RegisterManagers(ARemoteManagers);
  if Assigned(FOnEndManagersDiscovery) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnEndManagersDiscovery(Self, ARemoteManagers);
      end);
end;

procedure TTetheringManager.DoEndProfilesDiscovery(const ARemoteProfiles: TTetheringProfileInfoList);
var
  I: Integer;
  J: Integer;
  ManagerIndex: Integer;
begin
  if ARemoteProfiles <> nil then
  begin
    RegisterProfiles(ARemoteProfiles);
    if FAutoConnect and (ARemoteProfiles.Count > 0) then
    begin
      ManagerIndex := FindAutoManager(ARemoteProfiles[0].ManagerIdentifier);
      if ManagerIndex >= 0 then
      begin
        DeleteRemoteAutoManagers(ManagerIndex);
        for I := 0 to FRegisteredProfiles.Count - 1 do
          if FRegisteredProfiles[I].Group <> '' then
            for J := 0 to ARemoteProfiles.Count - 1 do
              if FRegisteredProfiles[I].Group = ARemoteProfiles[J].ProfileGroup then
                FRegisteredProfiles[I].Connect(ARemoteProfiles[J]);
      end;
      if FRemoteAutoManagers.Count = 0 then
      begin
        FAutoConnect := False;
        if Assigned(FOnEndAutoConnect) then
          TThread.Synchronize(nil,
            procedure
            begin
              FOnEndAutoConnect(Self);
            end);
      end;
      Exit;
    end;
  end;

  if Assigned(FOnEndProfilesDiscovery) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnEndProfilesDiscovery(Self, ARemoteProfiles);
      end);
end;

procedure TTetheringManager.DoNewManager(const AManager: TTetheringManagerInfo);
var
  LManager: TTetheringManagerInfo;
  LIndex: Integer;
begin
  // Add the incoming manager to our RemoteManagers list.
  TMonitor.Enter(FRemoteManagers);
  try
    LIndex := TTetheringManagerInfo.FindManagerIndex(FRemoteManagers, AManager.ManagerIdentifier);
    // Add the incoming manager to our RemoteManagers list.
    if LIndex = -1 then
    begin
      FRemoteManagers.Add(AManager);
      LManager := AManager;
    end
    else
    begin
      // If is already in the list, update manager information.
      LManager := FRemoteManagers.Items[LIndex];
      LManager.MergeManagerInfo(AManager);
      FRemoteManagers.Items[LIndex] := LManager;
    end;
  finally
    TMonitor.Exit(FRemoteManagers);
  end;

  if Assigned(FOnNewManager) then
  begin
    TThread.Synchronize(nil,
      procedure
      begin
        FOnNewManager(Self, LManager);
      end);
  end;
end;

procedure TTetheringManager.DoRequestManagerPassword(const ARemoteIdentifier: string; var APassword: string);
var
  LPassword: string;
begin
  APassword := FPassword;
  if Assigned(FOnRequestManagerPassword) then
  begin
    LPassword := APassword;
    TThread.Synchronize(nil,
      procedure
      begin
        FOnRequestManagerPassword(Self, ARemoteIdentifier, LPassword);
      end);
    APassword := LPassword;
  end;
  FTempPasswords.AddOrSetValue(ARemoteIdentifier, APassword);
end;

procedure TTetheringManager.DoRequestStorage(var AStorage: TTetheringCustomStorage);
begin
  AStorage := nil;
  if Assigned(FOnRequestStorage) then
    FOnRequestStorage(Self, AStorage);
end;

procedure TTetheringManager.DisconnetProfilesFromManager(const AManagerId: string);
var
  I: Integer;
begin
  for I := FRegisteredProfiles.Count - 1 downto 0 do
    FRegisteredProfiles[I].DisconnectFromManager(AManagerId);

  for I := FRemoteProfiles.Count - 1 downto 0 do
    if FRemoteProfiles[I].ManagerIdentifier = AManagerId then
      FRemoteProfiles.Delete(I);

  for I := FRemoteManagers.Count - 1 downto 0 do
    if FRemoteManagers[I].ManagerIdentifier = AManagerId then
      FRemoteManagers.Delete(I);
end;

procedure TTetheringManager.DoUnPairManager(const AManager: TTetheringManagerInfo);
var
  I: Integer;
  LManager: TTetheringManagerInfo;
begin
  for I := 0 to FPairedManagers.Count - 1 do
    if FPairedManagers[I].ManagerIdentifier = AManager.ManagerIdentifier then
    begin
      DisconnetProfilesFromManager(AManager.ManagerIdentifier);
      FPairedManagers.Delete(I);
      Break;
    end;

  I := FKnownManagers.IndexOfName(AManager.ManagerIdentifier);
  if I >= 0 then
  begin
    FKnownManagers.Delete(I);
    if FStorage <> nil then
      FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
  end;

  if Assigned(FOnUnPairManager) then
  begin
    LManager := AManager;
    TThread.Synchronize(nil,
      procedure
      begin
        FOnUnPairManager(Self, LManager);
      end);
  end;
end;

function TTetheringManager.FindRegisteredProfile(const AProfileId: string): TTetheringProfile;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FRegisteredProfiles.Count - 1 do
    if FRegisteredProfiles[I].Identifier = AProfileId then
      Exit(FRegisteredProfiles[I]);
end;

procedure TTetheringManager.DoRemoteManagerShutdown(const AManagerIdentifier: string);

  procedure DisconnectProfile(const AProfileInfo: TTetheringProfileInfo);
  var
    I: Integer;
  begin
    for I := 0 to FRegisteredProfiles.Count - 1 do
      FRegisteredProfiles[I].Disconnect(AProfileInfo);
  end;

var
  I: Integer;
  LManagerInfo: TTetheringManagerInfo;
begin
  TMonitor.Enter(FPairedManagers);
  try
    if ManagerExists(FPairedManagers, AManagerIdentifier) then
    begin
      for I := FRemoteProfiles.Count - 1 downto 0 do
        if FRemoteProfiles[I].ManagerIdentifier = AManagerIdentifier then
        begin
          DisconnectProfile(FRemoteProfiles[I]);
          FRemoteProfiles.Delete(I);
        end;

      LManagerInfo := FindManager(AManagerIdentifier);
      FPairedManagers.Remove(LManagerInfo);
    end;
  finally
    TMonitor.Exit(FPairedManagers);
  end;

  TMonitor.Enter(FRemoteManagers);
  try
    LManagerInfo := FindManager(AManagerIdentifier, FRemoteManagers);
    FRemoteManagers.Remove(LManagerInfo);
  finally
    TMonitor.Exit(FRemoteManagers);
  end;

  if Assigned(FOnRemoteManagerShutdown) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnRemoteManagerShutdown(Self, AManagerIdentifier);
      end);
end;

procedure TTetheringManager.DoRequestedNotification(const AProfileId, ANotification, Data: string);
var
  Profile: TTetheringProfile;
begin
  Profile := FindRegisteredProfile(AProfileId);

  if Profile <> nil then
    Profile.Notify(ANotification, Data);
end;

procedure TTetheringManager.DoAuthErrorFromLocal(const AManagerIdentifier: string);
var
  Index: Integer;
begin
  if FAutoConnect then
  begin
    Index := FindAutoManager(AManagerIdentifier);
    if Index >= 0 then
      DeleteRemoteAutoManagers(Index);
    if FRemoteAutoManagers.Count = 0 then
    begin
      FAutoConnect := False;
      if Assigned(FOnEndAutoConnect) then
        TThread.Synchronize(nil,
          procedure
          begin
            FOnEndAutoConnect(Self);
          end);
    end;
  end;

  Index := FKnownManagers.IndexOfName(AManagerIdentifier);
  if Index >= 0 then
  begin
    FKnownManagers.Delete(Index);
    if FStorage <> nil then
      FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
  end;
  if Assigned(FOnAuthErrorFromLocal) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnAuthErrorFromLocal(Self, AManagerIdentifier);
      end);
end;

procedure TTetheringManager.DoAuthErrorFromRemote(const AManagerIdentifier: string);
var
  Index: Integer;
begin
  if FAutoConnect then
  begin
    Index := FindAutoManager(AManagerIdentifier);
    if Index >= 0 then
      DeleteRemoteAutoManagers(Index);
    if FRemoteAutoManagers.Count = 0 then
    begin
      FAutoConnect := False;
      if Assigned(FOnEndAutoConnect) then
        TThread.Synchronize(nil,
          procedure
          begin
            FOnEndAutoConnect(Self);
          end);
    end;
  end;
  Index := FKnownManagers.IndexOfName(AManagerIdentifier);
  if Index >= 0 then
  begin
    FKnownManagers.Delete(Index);
    if FStorage <> nil then
      FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
  end;
  if Assigned(FOnAuthErrorFromRemote) then
    TThread.Synchronize(nil,
      procedure
      begin
        FOnAuthErrorFromRemote(Self, AManagerIdentifier);
      end);
end;

procedure TTetheringManager.DoCommError(const AProfile: TTetheringProfileInfo);
var
  LManager: TTetheringManagerInfo;
  LProfile: TTetheringProfileInfo;
  I: Integer;
begin
  LManager := FindManager(AProfile.ManagerIdentifier);
  if Assigned(FOnCommError) then
  begin
    LProfile := AProfile;
    TThread.CreateAnonymousThread(procedure
      begin
        TThread.Queue(nil, procedure
          var
            I: Integer;
          begin
                                                                                             
            if LManager.Adapter <> nil then
            begin
              for I := 0 to FPairedManagers.Count - 1 do
                if FPairedManagers[I].ManagerIdentifier = LManager.ManagerIdentifier then
                begin
                  DisconnetProfilesFromManager(LManager.ManagerIdentifier);
                  FPairedManagers.Delete(I);
                  Break;
                end;

              I := FKnownManagers.IndexOfName(LManager.ManagerIdentifier);
              if I >= 0 then
              begin
                FKnownManagers.Delete(I);
                if FStorage <> nil then
                  FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
              end;
            end;
            FOnCommError(Self, LManager, LProfile);
          end);
      end).Start;
  end
  else
  begin
                                                                                     
    if LManager.Adapter <> nil then
    begin
      for I := 0 to FPairedManagers.Count - 1 do
        if FPairedManagers[I].ManagerIdentifier = LManager.ManagerIdentifier then
        begin
          DisconnetProfilesFromManager(LManager.ManagerIdentifier);
          FPairedManagers.Delete(I);
          Break;
        end;

      I := FKnownManagers.IndexOfName(LManager.ManagerIdentifier);
      if I >= 0 then
      begin
        FKnownManagers.Delete(I);
        if FStorage <> nil then
          FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
      end;
    end;
  end;
end;

function TTetheringManager.ManagerExists(const ARemoteManagers: TList<TTetheringManagerInfo>;
  const AManagerIdentifier: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to ARemoteManagers.Count - 1 do
    if ARemoteManagers[I].ManagerIdentifier = AManagerIdentifier then
      Exit(True);
end;

procedure TTetheringManager.DoPairedToRemote(const AManagerInfo: TTetheringManagerInfo);
var
  LManager: TTetheringManagerInfo;
begin
  if not ManagerExists(FPairedManagers, AManagerInfo.ManagerIdentifier) then
    FPairedManagers.Add(AManagerInfo);
  DiscoverProfiles(AManagerInfo);
  if Assigned(FOnPairedToRemote) then
  begin
    LManager := AManagerInfo;
    TThread.Synchronize(nil,
      procedure
      begin
        FOnPairedToRemote(Self, LManager);
      end);
  end;
end;

function TTetheringManager.GenerateTimer(const AEvent: TTetheringNotifyEvent; Timeout: Cardinal): TThread;
begin
  Result := TTetheringAdapter.TThreadTimer.Create(AEvent, Timeout);
end;

procedure TTetheringManager.PairManager(const ARemoteManager: TTetheringManagerInfo);
var
  I: Integer;
begin
  for I := 0 to FPairedManagers.Count - 1 do
    if FPairedManagers[I].ManagerIdentifier = ARemoteManager.ManagerIdentifier then
      Exit;
  ARemoteManager.Adapter.PairManager(ARemoteManager);
end;

procedure TTetheringManager.RegisterAdapter(const AnAdapter: TTetheringAdapter);
begin
  if FIdentifier = '' then
  begin
    DoRequestStorage(FStorage);
    if FStorage <> nil then
    begin
      FIdentifier := FStorage.LoadManagerGUID;
      FStorage.LoadRemoteManagersGUIDs(FKnownManagers);
    end
    else
      FIdentifier := TGUID.NewGuid.ToString;  // In this moment we have loose the feature of save pairing info
  end;

  if FAdapters.IndexOf(AnAdapter) < 0 then
  begin
    AnAdapter.FManager := Self;
    FAdapters.Add(AnAdapter);
    if FEnabled then
      if not AnAdapter.StartListening then
        if Assigned(FOnError) then
          FOnError(Self, AnAdapter, TTetheringError.InitAdapterError);
  end;
end;

procedure TTetheringManager.RegisterManagers(const ARemoteManagers: TTetheringManagerInfoList);

  function ExistsManager(const AManager: TTetheringManagerInfo): Boolean;
  var
    J: Integer;
  begin
    Result := False;
    for J := 0 to FRemoteManagers.Count - 1 do
      if FRemoteManagers[J].ManagerIdentifier = AManager.ManagerIdentifier then Exit(True);
  end;

var
  I: Integer;
begin
  if ARemoteManagers <> nil then
    for I := 0 to ARemoteManagers.Count - 1 do
      if not ExistsManager(ARemoteManagers[I]) then
        FRemoteManagers.Add(ARemoteManagers[I]);
end;

procedure TTetheringManager.RegisterProfile(const AProfile: TTetheringProfile);
begin
  if FRegisteredProfiles.IndexOf(AProfile) < 0 then
  begin
    // Create all needed adapters for the manager.
    AutoCreateAdapters;
    FRegisteredProfiles.Add(AProfile);
  end;
end;

procedure TTetheringManager.RegisterProfiles(const ARemoteProfiles: TTetheringProfileInfoList);

  function ExistsProfile(const AProfile: TTetheringProfileInfo): Integer;
  var
    J: Integer;
  begin
    Result := -1;
    for J := 0 to FRemoteProfiles.Count - 1 do
      if FRemoteProfiles[J].ProfileIdentifier = AProfile.ProfileIdentifier then
        Exit(J);
  end;

var
  I: Integer;
  LIndex: Integer;
begin
  if ARemoteProfiles <> nil then
    for I := 0 to ARemoteProfiles.Count - 1 do
    begin
      LIndex := ExistsProfile(ARemoteProfiles[I]);
      if LIndex >= 0 then
        FRemoteProfiles.Delete(LIndex);
      FRemoteProfiles.Add(ARemoteProfiles[I]);
    end;
end;

procedure TTetheringManager.SendNotification(const AManagerId, AProfileId, ANotification, Data: string);

  function FindRemoteProfile(const AManager, AProfile: string): TTetheringProfileInfo;
  var
    I: Integer;
  begin
    TMonitor.Enter(FRemoteProfiles);
    try
      Result := Default(TTetheringProfileInfo);
      for I := 0 to FRemoteProfiles.Count - 1 do
        if (FRemoteProfiles[I].ManagerIdentifier = AManager) and (FRemoteProfiles[I].ProfileIdentifier = AProfile)  then
          Result := FRemoteProfiles[I];
    finally
      TMonitor.Exit(FRemoteProfiles);
    end;

  end;

var
  LManager: TTetheringManagerInfo;
  I: Integer;
begin
  if Identifier = AManagerId then
  begin
    for I := 0 to FAdapters.Count - 1 do
    begin
      LManager.ConnectionString := FAdapters[I].FAdapterConnectionString;
      LManager.ManagerAdapters := FAdapters[I].AdapterType;
      try
        FAdapters[I].SendNotification(LManager, AProfileId, ANotification, Data);
      except
                                   
        DoCommError(FindRemoteProfile(AManagerId, AProfileId));
      end;
    end;
  end
  else
  begin
    LManager := FindManager(AManagerId);
    if LManager.Adapter <> nil then
      try
        LManager.Adapter.SendNotification(LManager, AProfileId, ANotification, Data);
      except
                                   
        DoCommError(FindRemoteProfile(AManagerId, AProfileId));
      end;
  end;
end;

procedure TTetheringManager.SaveTokenFromLocal(const AManager, Seed: string);
var
  Index: Integer;
begin
  Index := FKnownManagers.IndexOfName(AManager);
  if Index >= 0 then
    FKnownManagers.Delete(Index);

  FKnownManagers.Add(AManager + '=' + THashSHA1.GetHashString(FPassword + Seed));
  if FStorage <> nil then
    FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
end;

procedure TTetheringManager.SaveTokenFromRemote(const AManager, Seed: string);
var
  Pass: string;
  Index: Integer;
begin
  Index := FKnownManagers.IndexOfName(AManager);

  if FTempPasswords.TryGetValue(AManager, Pass) then
  begin
    if Index >= 0 then
      FKnownManagers.Delete(Index);
    FKnownManagers.Add(AManager + '=' + THashSHA1.GetHashString(Pass + Seed));
    if FStorage <> nil then
      FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
    FTempPasswords.Remove(AManager);
  end;
end;

procedure TTetheringManager.SetAllowedAdapters(const Value: string);
var
  LProfile: TTetheringProfile;
  I: Integer;
  LValue: string;
begin
  if Value <> '' then
    LValue := Value
  else
    LValue := 'Network';

  if LValue <> AllowedAdapters then
  begin
    if FAdapters.Count = 0 then
      FAllowedAdapters := LValue.Split(['|', ';'])
    else
      if not FEnabled then
      begin
        for I := FPairedManagers.Count - 1 downto 0 do
          UnPairManager(FPairedManagers[I]);

        for LProfile in FRegisteredProfiles do
          LProfile.ClearProtocols;

        for I := FAdapters.Count - 1 downto 0 do
          UnRegisterAdapter(FAdapters[I]);

        FAllowedAdapters := LValue.Split(['|', ';']);

        AutoCreateAdapters;
        for LProfile in FRegisteredProfiles do
          LProfile.SetupProtocols;
      end
      else
        raise ETetheringException.Create(SCannotSetAllowedAdapters);
  end;
end;

procedure TTetheringManager.SetEnabled(const Value: Boolean);
var
  I: Integer;
  LListening: Boolean;
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if not (csDesigning in ComponentState) then
    begin
      if FEnabled then
      begin
        LListening := False;
        for I := 0 to FAdapters.Count - 1 do
          if not FAdapters[I].StartListening then
          begin
            if Assigned(FOnError) then
              FOnError(Self, FAdapters[I], TTetheringError.InitAdapterError);
          end
          else
            LListening := True;

        if LListening then
          for I := 0 to FRegisteredProfiles.Count - 1 do
              FRegisteredProfiles[I].StartCommunication
        else
          FEnabled := False;
      end
      else
      begin
        for I := 0 to FRegisteredProfiles.Count - 1 do
            FRegisteredProfiles[I].StopCommunication;

        for I := 0 to FAdapters.Count - 1 do
            FAdapters[I].StopListening;
      end;
    end;
  end;
end;

procedure TTetheringManager.SetName(const NewName: TComponentName);
begin
  if Text = Name then
    Text := NewName;
  inherited;
end;

function TTetheringManager.FindAutoManager(const AManagerIdentifier: string): Integer;
var
  I: Integer;
begin
  TMonitor.Enter(FRemoteAutoManagers);
  try
    for I := 0 to FRemoteAutoManagers.Count - 1 do
      if FRemoteAutoManagers[I].ManagerIdentifier = AManagerIdentifier then
        Exit(I);
  finally
    TMonitor.Exit(FRemoteAutoManagers);
  end;
  Result := -1;
end;

function TTetheringManager.FindManager(const Id: string; const AList: TTetheringManagerInfoList): TTetheringManagerInfo;
var
  I: Integer;
begin
  Result := Default(TTetheringManagerInfo);
  for I := 0 to AList.Count - 1 do
    if AList[I].ManagerIdentifier = Id then
      Exit(AList[I]);
end;

function TTetheringManager.FindManager(const Id: string): TTetheringManagerInfo;
begin
  Result := FindManager(Id, FPairedManagers);
end;

function TTetheringManager.GenerateToken(const AManager, Seed: string): string;
var
  Index: Integer;
begin
  Result := '';

  Index := FKnownManagers.IndexOfName(AManager);
  if Index >= 0 then
    Result := THashSHA1.GetHashString(FKnownManagers.ValueFromIndex[Index] + Seed);
end;

function TTetheringManager.GetAllowedAdapters: string;
begin
  if Length(FAllowedAdapters) = 0 then
    Result := ''
  else
    Result := string.Join('|', FAllowedAdapters);
end;

procedure TTetheringManager.UnPairManager(const ARemoteManager: TTetheringManagerInfo);
var
  I: Integer;
begin
  if ARemoteManager.Adapter <> nil then
  begin
    ARemoteManager.Adapter.UnPairManager(ARemoteManager);

    for I := 0 to FPairedManagers.Count - 1 do
      if FPairedManagers[I].ManagerIdentifier = ARemoteManager.ManagerIdentifier then
      begin
        DisconnetProfilesFromManager(ARemoteManager.ManagerIdentifier);
        FPairedManagers.Delete(I);
        Break;
      end;

    I := FKnownManagers.IndexOfName(ARemoteManager.ManagerIdentifier);
    if I >= 0 then
    begin
      FKnownManagers.Delete(I);
      if FStorage <> nil then
        FStorage.SaveRemoteManagersGUIDs(FKnownManagers);
    end;
  end;
end;

procedure TTetheringManager.UnPairManager(const ARemoteManagerIdentifier: string);
begin
  UnPairManager(FindManager(ARemoteManagerIdentifier));
end;

procedure TTetheringManager.UnRegisterAdapter(const AnAdapter: TTetheringAdapter);
begin
  FAdapters.Remove(AnAdapter);
end;

procedure TTetheringManager.UnRegisterProfile(const AProfile: TTetheringProfile);
begin
  FRegisteredProfiles.Remove(AProfile);
end;

class function TTetheringManager.ProfileInfoToString(const AProfileInfo: TTetheringProfileInfo): string;
begin
  Result := AProfileInfo.ToString;
end;

class function TTetheringManager.StringToProfileInfo(const AProfileString: string): TTetheringProfileInfo;
begin
  Result.FromString(AProfileString);
end;


{ TTetheringManagerProfiles }

class constructor TTetheringProfiles.Create;
begin
  FProfiles := TDictionary<TTetheringProfileType, TTetheringProfileClass>.Create;
  FProfileProtocolsAdapters := TObjectDictionary<TTetheringProfileType, TList<TPair<TTetheringProtocolType,
    TTetheringAdapterType>>>.Create([doOwnsValues]);
end;

class destructor TTetheringProfiles.Destroy;
begin
  FProfileProtocolsAdapters.Free;
  FProfiles.Free;
end;

class function TTetheringProfiles.GetProfileInstance(const AType: TTetheringProfileType;
  const AOwnerManager: TTetheringManager): TTetheringProfile;
var
  AProfileRef: TTetheringProfileClass;
begin
  if FProfiles.TryGetValue(AType, AProfileRef) then
    Result := AProfileRef.CreateInstance(AOwnerManager)
  else
    Result := nil;
end;

class function TTetheringProfiles.GetProfileProtocolAdapters(const AProfileType: TTetheringProfileType): TTetheringProtocolAdapterTypes;
begin
  Setlength(Result, 0);
  if FProfiles.ContainsKey(AProfileType) then
    if FProfileProtocolsAdapters.ContainsKey(AProfileType) then
      Result := FProfileProtocolsAdapters.Items[AProfileType].ToArray
    else
      raise ETetheringException.CreateFmt(SProfileWithoutProtocolAdapters, [AProfileType])
  else
    raise ETetheringException.CreateFmt(SProfileNotRegistered, [AProfileType]);
end;

class function TTetheringProfiles.GetProfiles: TTetheringProfileTypes;
begin
  Result := FProfiles.Keys.ToArray;
end;

class procedure TTetheringProfiles.RegisterProfile(const AProfile: TTetheringProfileClass; const AType: TTetheringProfileType);
begin
  if not FProfiles.ContainsKey(AType) then
    FProfiles.Add(AType, AProfile)
  else
    raise ETetheringException.CreateFmt(SProfileAlreadyRegistered, [AType]);
end;

class procedure TTetheringProfiles.RegisterProfileProtocolAdapter(const AProfileType: TTetheringProfileType;
  const AProtocol: TTetheringProtocolType; const AnAdapter: TTetheringAdapterType);
var
  AList: TList<TTetheringProtocolAdapterType>;
  APair: TTetheringProtocolAdapterType;
begin
  if FProfiles.ContainsKey(AProfileType) then
  begin
    APair := TTetheringProtocolAdapterType.Create(AProtocol,AnAdapter);
    if not FProfileProtocolsAdapters.ContainsKey(AProfileType) then
    begin
      AList := TList<TTetheringProtocolAdapterType>.Create;
      AList.Add(APair);
      FProfileProtocolsAdapters.Add(AProfileType, AList);
    end
    else FProfileProtocolsAdapters.Items[AProfileType].Add(APair);
  end
  else
    raise ETetheringException.CreateFmt(SProfileNotRegistered, [AProfileType]);
end;

class procedure TTetheringProfiles.UnRegisterProfile(const AType: TTetheringProfileType);
begin
  FProfiles.Remove(AType);
end;

class procedure TTetheringProfiles.UnRegisterProfileProtocolAdapter(const AProfileType: TTetheringProfileType;
  const AProtocol: TTetheringProtocolType; const AnAdapter: TTetheringAdapterType);
var
  AList: TList<TTetheringProtocolAdapterType>;
  I: Integer;
begin
  if FProfileProtocolsAdapters.TryGetValue(AProfileType, AList) then
  begin
    for I := AList.Count - 1 downto 0 do
      if (AList[I].Key = AProtocol) and (AList[I].Value = AnAdapter) then
        AList.Delete(I);
    if AList.Count = 0 then
      FProfileProtocolsAdapters.Remove(AProfileType);
  end;
end;

{ TTetheringProfile }

constructor TTetheringProfile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisible := True;
  FEnabled := True;
  FConnectedProfiles := TTetheringProfileInfoList.Create;
  FProtocols := TList<TTetheringProtocol>.Create;
  FImplementedProtocolAdapters := GetAllowedProtocolsAdapters;
  FIdentifier := TGUID.NewGuid.ToString;
  Text := Name;
  FConnections := TObjectDictionary<TTetheringProfileInfo, TTetheringConnection>.Create([doOwnsValues]);
end;

destructor TTetheringProfile.Destroy;
begin
  Enabled := False;

  FConnections.Free;

  ClearProtocols;
  FProtocols.Free;
  FConnectedProfiles.Free;

  if FManager <> nil then
    FManager.UnRegisterProfile(Self);
  FManager := nil;

  inherited;
end;

procedure TTetheringProfile.AddConnectedProfile(const AProfileInfo: TTetheringProfileInfo);
var
  I: Integer;
begin
  for I := 0 to FConnectedProfiles.Count - 1 do
    if (FConnectedProfiles[I].ManagerIdentifier = AProfileInfo.ManagerIdentifier) and
       (FConnectedProfiles[I].ProfileIdentifier = AProfileInfo.ProfileIdentifier) then
    begin
      FConnectedProfiles.Delete(I);
      Break;
    end;

  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Profile) then
    TTetheringAdapter.Log('AddConnectedProfile: "' + AProfileInfo.ToString + '"');
  FConnectedProfiles.Add(AProfileInfo);
end;

function TTetheringProfile.CheckManager(const AManagerId: string): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := 0 to FManager.FPairedManagers.Count - 1 do
    if CompareText(AManagerId, FManager.FPairedManagers[I].ManagerIdentifier) = 0 then
      Exit(True);
end;

procedure TTetheringProfile.CheckProfileIsConnected(const AProfile: TTetheringProfileInfo);
begin
  if not IsProfileConnected(AProfile) then
    raise ETetheringException.CreateFmt(SProfileNotConnected, [AProfile.ProfileIdentifier]);
end;

function TTetheringProfile.CheckProtocolAdapter(const AProtocolType: TTetheringProtocolType;
  const AnAdapterType: TTetheringAdapterType): Boolean;
var
  LItem: TTetheringProtocolAdapterType;
begin
  for LItem in FImplementedProtocolAdapters do
    if (LItem.Key = AProtocolType) and (LItem.Value = AnAdapterType) then
      Exit(True);

  Result := False;
end;

procedure TTetheringProfile.ClearProtocols;
var
  AProtocol: TTetheringProtocol;
  I: Integer;
begin
  for I := FProtocols.Count - 1 downto 0 do
  begin
    AProtocol := FProtocols[I];
    AProtocol.Free;
  end;
  FProtocols.Clear;
end;

procedure TTetheringProfile.Disconnect(const AProfile: TTetheringProfileInfo);
var
  LConnection: TTetheringConnection;
begin
  if FConnectedProfiles.IndexOf(AProfile) >= 0 then
  begin
    DoOnDisconnect(AProfile);
    FConnectedProfiles.Remove(AProfile);
  end;
  LConnection := FindConnection(AProfile);
  if LConnection <> nil then
  begin
    try
      LConnection.Protocol.Disconnect;
    except
    end;
    FConnections.Remove(AProfile);
  end;
end;

function TTetheringProfile.DoOnBeforeConnect(const AProfileInfo: TTetheringProfileInfo): Boolean;
begin
  Result := True;
  if Assigned(FOnBeforeConnectProfile) then
    FOnBeforeConnectProfile(Self, AProfileInfo, Result);
end;

procedure TTetheringProfile.DoCommError(const AProfile: TTetheringProfileInfo);
begin
  FManager.DoCommError(AProfile);
end;

procedure TTetheringProfile.DoOnAfterConnect(const AProfileInfo: TTetheringProfileInfo);
begin
  if Assigned(FOnAfterConnectProfile) then
    FOnAfterConnectProfile(Self, AProfileInfo);
end;

procedure TTetheringProfile.DoOnDisconnect(const AProfileInfo: TTetheringProfileInfo);
begin
  if Assigned(FOnDisconnect) then
    FOnDisconnect(Self, AProfileInfo);
end;

function TTetheringProfile.DoReceiveCommand(const AConnection: TTetheringConnection): TTetheringCommand;
begin
  try
    if AConnection.Protocol <> nil then
      Result := TTetheringCommand.Create(AConnection.Protocol.ReceiveData)
    else
      Result := TTetheringCommand.Create(TTetheringManagerCommunicationThread.TetheringError, Version);
  except
                               
    DoCommError(FindProfileFromConnection(AConnection));
    Result := TTetheringCommand.Create(TTetheringManagerCommunicationThread.TetheringError, Version);
  end;
end;

procedure TTetheringProfile.DoSendCommand(const AConnection: TTetheringConnection; const ACommand: TTetheringCommand);
begin
  try
    if AConnection.Protocol <> nil then
    AConnection.Protocol.SendData(ACommand.ToBytes);
  except
                               
    DoCommError(FindProfileFromConnection(AConnection));
  end;
end;

function TTetheringProfile.DoSendCommandWithResponse(const AConnection: TTetheringConnection;
  const ACommand: TTetheringCommand): TTetheringCommand;
begin
  SendCommand(AConnection, ACommand);
  Result := ReceiveCommand(AConnection);
end;

function TTetheringProfile.FindConnection(const AProfile: TTetheringProfileInfo): TTetheringConnection;
var
  LProfile: TTetheringProfileInfo;
begin
  Result := nil;
  for LProfile in FConnections.Keys do
    if (LProfile.ManagerIdentifier = AProfile.ManagerIdentifier) and
       (LProfile.ProfileIdentifier = AProfile.ProfileIdentifier) then
      Exit(FConnections.Items[LProfile]);
end;

function TTetheringProfile.FindProfile(const AProfileId: string; var AProfileInfo: TTetheringProfileInfo): Boolean;
var
  I: Integer;
begin
  for I := 0 to Manager.RemoteProfiles.Count - 1 do
  begin
    if CompareText(AProfileId, Manager.RemoteProfiles[I].ProfileIdentifier) = 0 then
    begin
      AProfileInfo := Manager.RemoteProfiles[I];
      Exit(True);
    end;
  end;

  Result := False;
end;

function TTetheringProfile.FindProfileFromConnection(const AConnection: TTetheringConnection): TTetheringProfileInfo;
var
  APair: TPair<TTetheringProfileInfo, TTetheringConnection>;
begin
  for APair in FConnections do
    if APair.Value = AConnection then
      Exit(APair.Key);
  Result := Default(TTetheringProfileInfo);
end;

function TTetheringProfile.GetAdapter(AnAdapterType: TTetheringAdapterType): TTetheringAdapter;
var
  LAdapter: TTetheringAdapter;
begin
  for LAdapter in Manager.Adapters do
    if LAdapter.AdapterType = AnAdapterType then
      Exit(LAdapter);

  Result := nil;
end;

function TTetheringProfile.GetConnectedProfiles: TArray<TTetheringProfileInfo>;
begin
  Result := FConnectedProfiles.ToArray;
end;

function TTetheringProfile.GetConnectionTo(const AProfile: TTetheringProfileInfo;
  const AProtocolType: TTetheringProtocolType; const AnAdapterType: TTetheringAdapterType;
  Connect: Boolean): TTetheringConnection;
var
  LProtocolType: string;
  LAdapterType: string;
  LConnection: TTetheringAllowedConnection;
  LConnectionString: string;
  LAllowedAdapter: TTetheringAdapterType;
begin
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Profile) then
    TTetheringAdapter.Log(Format('GetConnectionTo("%s", "%s", "%s")', [AProfile.ToString, AProtocolType, AnAdapterType]));;
  Result := FindConnection(AProfile);
  if Result = nil then
  begin
    if Length(AProfile.AllowedConnections) <= 0 then
      raise ETetheringException.CreateFmt(SNoConnections, [AProfile.ProfileIdentifier]);

    if ((AProtocolType = '') and (AnAdapterType <> '')) or ((AProtocolType <> '') and (AnAdapterType = '')) then
      raise ETetheringException.CreateFmt(SNoProtocolAndAdapter, [AProfile.ProfileIdentifier]);

    if (not CheckProtocolAdapter(AProtocolType, AnAdapterType)) and (AProtocolType <> '') then
      raise ETetheringException.CreateFmt(SNoConnections, [AProfile.ProfileIdentifier]);

    LProtocolType := '';
    LAdapterType := '';
    for LAllowedAdapter in FManager.FAllowedAdapters do
      for LConnection in AProfile.AllowedConnections do
        if LConnection.AdapterType = LAllowedAdapter then
        begin
          if AProtocolType <> '' then
          begin
            if (AProtocolType = LConnection.ProtocolType) and (AnAdapterType = LConnection.AdapterType) then
            begin
              LProtocolType := AProtocolType;
              LAdapterType := AnAdapterType;
              LConnectionString := LConnection.Connection;
              Break;
            end;
          end
          else
          begin
            if CheckProtocolAdapter(LConnection.ProtocolType, LConnection.AdapterType) then
            begin
              LProtocolType := LConnection.ProtocolType;
              LAdapterType := LConnection.AdapterType;
              LConnectionString := LConnection.Connection;
              Break;
            end;
          end;
        end;

    if LProtocolType = '' then
      raise ETetheringException.CreateFmt(SNoConnections, [AProfile.ProfileIdentifier]);

    Result := TTetheringConnection.Create;
    try
      Result.ConnectionString := LConnectionString;
      Result.ProtocolType := LProtocolType;
      Result.Protocol := TTetheringProtocols.GetProtocolInstance(Self, Result.ProtocolType, GetAdapter(LAdapterType), True);
    except
      FreeAndNil(Result);
    end;

    if Result <> nil then
      FConnections.Add(AProfile, Result);
  end;

  if Result = nil then
    raise ETetheringException.CreateFmt(SCanNotGetConnection, [AProfile.ProfileIdentifier]);

  if Connect then
    if not Result.Protocol.IsConnected then
    begin
                                 
      if not Result.Protocol.Connect(Result) then
      begin
        DoCommError(AProfile);
        Abort;
    end;
//        raise ETetheringException.CreateFmt(SCanNotConnect, [AProfile.ProfileIdentifier]);
    end;
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Profile) then
    TTetheringAdapter.Log(Format('GetConnectionTo("%s", "%s", "%s") -> "%s"', [AProfile.ToString, AProtocolType, AnAdapterType, Result.ConnectionString]));;
end;

function TTetheringProfile.IsProfileConnected(const AProfileInfo: TTetheringProfileInfo): Boolean;
begin
  Result := FConnectedProfiles.IndexOf(AProfileInfo) <> -1;
end;

procedure TTetheringProfile.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (AComponent = FManager) and (Operation = opRemove) then
    SetManager(nil);
end;

function TTetheringProfile.ReceiveCommand(const AProfile: TTetheringProfileInfo): TTetheringCommand;
var
  LConnection: TTetheringConnection;
begin
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    Result := ReceiveCommand(LConnection);
  finally
    TMonitor.Exit(LConnection);
  end;
end;

function TTetheringProfile.ReceiveCommand(const AConnection: TTetheringConnection): TTetheringCommand;
begin
  Result := DoReceiveCommand(AConnection);
end;

procedure TTetheringProfile.SendCommand(const AConnection: TTetheringConnection; const ACommand: TTetheringCommand);
begin
  DoSendCommand(AConnection, ACommand);
end;

procedure TTetheringProfile.SendCommand(const AProfile: TTetheringProfileInfo; const ACommand: TTetheringCommand);
var
  LConnection: TTetheringConnection;
begin
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    DoSendCommand(LConnection, ACommand);
  finally
    TMonitor.Exit(LConnection);
  end;
end;

function TTetheringProfile.SendCommandWithResponse(const AConnection: TTetheringConnection;
  const ACommand: TTetheringCommand): TTetheringCommand;
begin
  Result := DoSendCommandWithResponse(AConnection, ACommand);
end;

function TTetheringProfile.SendCommandWithResponse(const AProfile: TTetheringProfileInfo; const ACommand: TTetheringCommand): TTetheringCommand;
var
  LConnection: TTetheringConnection;
begin
  LConnection := GetConnectionTo(AProfile);
  TMonitor.Enter(LConnection);
  try
    Result := DoSendCommandWithResponse(LConnection, ACommand);
  finally
    TMonitor.Exit(LConnection);
  end;
end;

procedure TTetheringProfile.SetEnabled(const Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    if not (csDesigning in ComponentState) then
    begin
      if FEnabled then
        StartCommunication
      else
        StopCommunication;
    end;
  end;
end;

procedure TTetheringProfile.SetImplementedProtocols(const Value: TTetheringProtocolAdapterTypes);
begin
  FImplementedProtocolAdapters := Value;
  SetupProtocols;
end;

procedure TTetheringProfile.SetManager(const AManager: TTetheringManager);
var
  LListening: Boolean;
  I: Integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    if (FManager <> AManager) and (FManager <> nil) then
    begin
      ClearProtocols;
      FManager.UnRegisterProfile(Self);
    end;

    FManager := AManager;
    if AManager <> nil then
    begin
      AManager.RegisterProfile(Self);
      SetupProtocols;

      LListening := False;
      for I := 0 to AManager.FAdapters.Count - 1 do
        if AManager.FAdapters[I].IsListening then
        begin
          LListening := True;
          Break;
        end;
      AManager.Enabled := LListening;
    end;
  end
  else
    FManager := AManager;
end;

procedure TTetheringProfile.SetName(const NewName: TComponentName);
begin
  if Text = Name then
    Text := NewName;
  inherited;
end;

procedure TTetheringProfile.SetupProtocols;
var
  LPair: TTetheringProtocolAdapterType;
  LProtocol: TTetheringProtocol;
  LAdapter: TTetheringAdapter;
begin
  if not (csDesigning in ComponentState) then
  begin
    if FManager = nil then
      raise ETetheringException.Create(SNoManager);

    ClearProtocols;
    for LPair in ImplementedProtocolAdapters do
    begin
      LAdapter := GetAdapter(LPair.Value);
      if LAdapter <> nil then
      begin
        LProtocol := TTetheringProtocols.GetProtocolInstance(Self, LPair.Key, LAdapter, False);
        if LProtocol <> nil then
          FProtocols.Add(LProtocol);
      end;
    end;
  end;
end;

procedure TTetheringProfile.StartCommunication;
var
  I: Integer;
begin
  for I := 0 to FProtocols.Count - 1 do
    FProtocols[I].StartCommunication;
end;

procedure TTetheringProfile.StopCommunication;
var
  I: Integer;
begin
  for I := FConnectedProfiles.Count - 1 downto 0 do
    Disconnect(FConnectedProfiles[I]);

  for I := 0 to FProtocols.Count - 1 do
    FProtocols[I].StopCommunication;
end;


{ TTetheringAdapter }

constructor TTetheringAdapter.Create;
begin
  inherited;
  FRemoteManagers := TTetheringManagerInfoList.Create;
  FAdapterConnectionString := TTetheringManagerCommunicationThread.EMPTYTOKEN;
end;

destructor TTetheringAdapter.Destroy;
begin
  FCommThread.DisposeOf;
  FRemoteManagers.Free;
  FTimerManager.Free;
  inherited;
end;

procedure TTetheringAdapter.AddManagerInfo(const AManagerIdentifier, AManagerName, AManagerText, AConnectionString,
  AManagerAdapters: string; AVersion: Integer);
var
  Info: TTetheringManagerInfo;
  LIndex: Integer;
  LTmpConnection: string;
begin
  LTmpConnection := TTetheringManagerInfo.CreateArrayString(AConnectionString, AManagerAdapters, Self.AdapterType);
  LIndex := TTetheringManagerInfo.FindManagerIndex(FRemoteManagers, AManagerIdentifier);
  if LIndex = -1 then
  begin
    Info.ManagerIdentifier := AManagerIdentifier;
    Info.ManagerName := AManagerName;
    Info.ManagerText := AManagerText;
    Info.ConnectionString := LTmpConnection;
    Info.Version := AVersion;
    Info.Adapter := Self;
    Info.ManagerAdapters := AManagerAdapters;
    FRemoteManagers.Add(Info);
  end
  else
  begin
    Info := FRemoteManagers.Items[LIndex];
    Info.ConnectionString := TTetheringManagerInfo.MergeArrayString(Info.ConnectionString, LTmpConnection);
    FRemoteManagers.Items[LIndex] := Info;
  end;
end;

class procedure TTetheringAdapter.AddLogItem(ALogItem: TTetheringLogItem);
begin
  FLogItems := FLogItems + [ALogItem];
end;

procedure TTetheringAdapter.AddManagerInfo(const AManagerInfo: TTetheringManagerInfo);
var
  Info: TTetheringManagerInfo;
  LIndex: Integer;
begin
  LIndex := TTetheringManagerInfo.FindManagerIndex(FRemoteManagers, AManagerInfo.ManagerIdentifier);
  if LIndex = -1 then
    FRemoteManagers.Add(AManagerInfo)
  else
  begin
    Info := FRemoteManagers.Items[LIndex];
    Info.ConnectionString := TTetheringManagerInfo.MergeArrayString(Info.ConnectionString, AManagerInfo.ConnectionString);
    FRemoteManagers.Items[LIndex] := Info;
  end;
end;

procedure TTetheringAdapter.AutoConnectEndManagersTimer(const Sender: TObject);
begin
  if FTimerManager <> nil then
    FTimerManager.Cancel;
  FManager.DoEndAutoConnectDiscover(FRemoteManagers);
end;

procedure TTetheringAdapter.DoPairedFromLocal(const AManagerIdentifier, AManagerName, AManagerText, AConnectionString: string; AVersion: Integer);
var
  Info: TTetheringManagerInfo;
  LIndex: Integer;
begin
  LIndex := TTetheringManagerInfo.FindManagerIndex(FRemoteManagers, AManagerIdentifier);
  if LIndex = -1 then
  begin
    Info.ManagerIdentifier := AManagerIdentifier;
    Info.ManagerName := AManagerName;
    Info.ManagerText := AManagerText;
    Info.ConnectionString := AConnectionString;
    Info.ManagerAdapters := AdapterType;
    Info.Version := AVersion;
  end
  else
  begin
    Info := FRemoteManagers.Items[LIndex];
    Info.ConnectionString := Info.MergeArrayString(Info.ConnectionString, Info.CreateArrayString(AConnectionString, Info.ManagerAdapters, Self.AdapterType));
    Info.AddConnectionString(AConnectionString, Self.AdapterType);
    FRemoteManagers.Items[LIndex] := Info;
  end;
  Info.Adapter := Self;
  FManager.DoPairedFromLocal(Info);
end;

procedure TTetheringAdapter.DoAuthErrorFromLocal(const AManagerIdentifier: string);
begin
  FManager.DoAuthErrorFromLocal(AManagerIdentifier);
end;

procedure TTetheringAdapter.DoAuthErrorFromRemote(const AManagerIdentifier: string);
begin
  FManager.DoAuthErrorFromRemote(AManagerIdentifier);
end;

procedure TTetheringAdapter.DoLaunchNotification(const AProfileId, ANotification, Data: string);
begin
  FManager.DoRequestedNotification(AProfileId, ANotification, Data);
end;

procedure TTetheringAdapter.DoNewManager(const AManager: TTetheringManagerInfo);
begin
  FManager.DoNewManager(AManager);
end;

procedure TTetheringAdapter.DoRemoteManagerShutdown(const AManagerIdentifier: string);
begin
  FManager.DoRemoteManagerShutdown(AManagerIdentifier);
end;

procedure TTetheringAdapter.DoRequestManagerPassword(const ARemoteIdentifier: string; var Password: string);
begin
  FManager.DoRequestManagerPassword(ARemoteIdentifier, Password);
end;

procedure TTetheringAdapter.DoStopListening;
begin
  FCommThread.DisposeOf;
  FCommThread := nil;
end;

procedure TTetheringAdapter.DoUnPairManager(const AManager: TTetheringManagerInfo);
begin
  FManager.DoUnPairManager(AManager);
end;

procedure TTetheringAdapter.DoPairedToRemote(const AManagerIdentifier, AManagerName, AManagerText: string;
  const AConnectionString: string; AVersion: Integer);
var
  Info: TTetheringManagerInfo;
  LIndex: Integer;
begin
  LIndex := TTetheringManagerInfo.FindManagerIndex(FRemoteManagers, AManagerIdentifier);
  if LIndex = -1 then
  begin
    Info.ManagerIdentifier := AManagerIdentifier;
    Info.ManagerName := AManagerName;
    Info.ManagerText := AManagerText;
    Info.ConnectionString := AConnectionString;
    Info.ManagerAdapters := AdapterType;
    Info.Version := AVersion;
  end
  else
  begin
    Info := FRemoteManagers.Items[LIndex];
    Info.AddConnectionString(AConnectionString, AdapterType);
    FRemoteManagers.Items[LIndex] := Info;
  end;
  Info.Adapter := Self;
  FManager.DoPairedToRemote(Info);
end;

procedure TTetheringAdapter.SaveTokenFromLocal(const AManager, Seed: string);
begin
  FManager.SaveTokenFromLocal(AManager, Seed);
end;

procedure TTetheringAdapter.SaveTokenFromRemote(const AManager, Seed: string);
begin
  FManager.SaveTokenFromRemote(AManager, Seed);
end;

procedure TTetheringAdapter.SendNotification(const AManager: TTetheringManagerInfo; const AProfileId, ANotification,
  Data: string);
var
  LConnection: string;
begin
  if FCommThread <> nil then
  begin
    LConnection := AManager.GetConnectionString(AdapterType);
    FCommThread.SendCommand(LConnection,
      FCommThread.CommandStr(FCommThread.TetheringNotification, AManager.Version,
        [AProfileId, ANotification, Data]))
  end;
end;

procedure TTetheringAdapter.SetLocalConnectionString(const ALocalConnection: string);
begin
  if (ALocalConnection <> '') and (ALocalConnection <> TTetheringManagerCommunicationThread.EMPTYTOKEN) then
    FAdapterConnectionString := ALocalConnection;
end;

function TTetheringAdapter.StartListening: Boolean;
begin
  FCommThread := DoCreateCommunicationThread(Self);
  FCommThread.NotifyEndProfileDiscovery := EndProfilesTimerProc;
  FCommThread.Start;
  FCommThread.WaitCommThreadInitialization;

  Result := FCommThread.IsListening;
end;

procedure TTetheringAdapter.StartManagersAutoConnect(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts);
begin
  FRemoteManagers.Clear;
  FTimerManager.Free;
  FTimerManager := FManager.GenerateTimer(AutoConnectEndManagersTimer, Timeout) as TTetheringAdapter.TThreadTimer;
  FTimerManager.Start;

  TThread.CreateAnonymousThread(procedure
    begin
      DoDiscoverManagers(Timeout, ATargetList);
    end).Start;
end;

procedure TTetheringAdapter.StartManagersAutoConnect(const ATargetList: TTetheringTargetHosts);
begin
  StartManagersAutoConnect(GetAutomaticTimeout, ATargetList);
end;

procedure TTetheringAdapter.StartManagersDiscovery(const ATargetList: TTetheringTargetHosts);
begin
  StartManagersDiscovery(GetAutomaticTimeout, ATargetList);
end;

procedure TTetheringAdapter.StartManagersDiscovery(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts);
begin
  FRemoteManagers.Clear;
  FTimerManager.Free;
  FTimerManager := FManager.GenerateTimer(EndManagersTimer, Timeout) as TTetheringAdapter.TThreadTimer;
  FTimerManager.Start;

  TThread.CreateAnonymousThread(procedure
    begin
      DoDiscoverManagers(Timeout, ATargetList);
    end).Start;
end;

procedure TTetheringAdapter.StartManagersDiscovery(const ATarget: string);
begin
  StartManagersDiscovery(GetAutomaticTimeout, ATarget);
end;

procedure TTetheringAdapter.StartManagersDiscovery(Timeout: Cardinal; const ATarget: string);
var
  LTargetArray: TTetheringTargetHosts;
begin
  LTargetArray := ATarget.Split([';']);
  StartManagersDiscovery(Timeout, LTargetArray);
end;

procedure TTetheringAdapter.StartProfilesDiscovery(const ARemoteManager: TTetheringManagerInfo; Timeout: Cardinal);
var
  LConnStr: string;
begin
  if FCommThread <> nil then
  begin
    if (GetAdapterType = 'Bluetooth') and (Timeout < 6000) then
      Timeout := Timeout * 2;
    LConnStr := ARemoteManager.GetConnectionString(AdapterType);
    FCommThread.CreateDiscoverProfilesTimer(LConnStr, Timeout);
    FCommThread.SendCommand(LConnStr, FCommThread.CommandStr(FCommThread.TetheringDiscoverProfiles, ARemoteManager.Version, []));
  end;
end;

procedure TTetheringAdapter.StopListening;
begin
  DoStopListening;
end;

procedure TTetheringAdapter.UnPairManager(const ARemoteManager: TTetheringManagerInfo);
begin
  try
    if FCommThread <> nil then
      FCommThread.SendCommand(ARemoteManager.GetConnectionString(AdapterType),
        FCommThread.CommandStr(FCommThread.TetheringRequestUnPair, ARemoteManager.Version,
          [Manager.Identifier, Manager.Name, Manager.Text]));
  except
  end;
end;

procedure TTetheringAdapter.EndManagersTimer(const Sender: TObject);
begin
  if FTimerManager <> nil then
    FTimerManager.Cancel;
  FManager.DoEndManagersDiscovery(FRemoteManagers);
end;

procedure TTetheringAdapter.EndProfilesTimerProc(const Sender: TObject);
begin
  FManager.DoEndProfilesDiscovery(TTetheringProfileInfoList(Sender));
end;

function TTetheringAdapter.GetHash(const Data: string): string;
begin
  Result := THashSHA1.GetHashString(Data);
end;

function TTetheringAdapter.GetKnownManagers: TStringList;
begin
  Result := FManager.FKnownManagers;
end;

function TTetheringAdapter.GetRandomString(const Len: Integer): string;
begin
  Result := THash.GetRandomString(Len);
end;

function TTetheringAdapter.IsListening: Boolean;
begin
  Result := (FCommThread <> nil) and FCommThread.IsListening;
end;

class function TTetheringAdapter.IsLoggingItem(ALogItem: TTetheringLogItem): Boolean;
begin
  Result := ALogItem in FLogItems;
end;

procedure TTetheringAdapter.NotifyShutdown;
begin

end;

procedure TTetheringAdapter.CancelManagersDiscovery;
begin
  FreeAndNil(FTimerManager);
end;

procedure TTetheringAdapter.CancelProfilesDiscovery(const ARemoteManager: TTetheringManagerInfo);
begin
  if FCommThread <> nil then
    FCommThread.CancelDiscoverProfilesTimer(ARemoteManager.GetConnectionString(AdapterType));
end;

function TTetheringAdapter.CheckPassword(const APassword, Seed: string): Boolean;
begin
  Result := FManager.CheckPassword(APassword, Seed);
end;

function TTetheringAdapter.CheckToken(const AManager, Seed, Token: string): Boolean;
begin
  Result := FManager.CheckToken(AManager, Seed, Token);
end;

class constructor TTetheringAdapter.Create;
begin
  FLogItems := [];
end;

procedure TTetheringAdapter.PairManager(const ARemoteManager: TTetheringManagerInfo);
var
  LConnection,
  LCommStr: string;
begin
  if FCommThread <> nil then
  begin
    LConnection := ARemoteManager.GetConnectionString(AdapterType);
    FCommThread.SetState(LConnection, TTetheringManagerCommunicationThread.TPairingState.WaitingPairResponse);
    if ARemoteManager.Version = 0 then
      LCommStr := FCommThread.CommandStr(FCommThread.TetheringRequestPair, ARemoteManager.Version,
          [Manager.Identifier, Manager.Name, Manager.Text, LConnection])
    else
      LCommStr := FCommThread.CommandStr(FCommThread.TetheringRequestPair, ARemoteManager.Version,
          [Manager.Identifier, Manager.Name, Manager.Text, LConnection, Manager.AllowedAdapters]);
    FCommThread.SendCommand(LConnection, LCommStr);
  end;
end;

function TTetheringAdapter.ProfilesInfo: string;
var
  I, J: Integer;
  Info: TTetheringProfileInfo;
  Protocols: TList<TTetheringProtocol>;
begin
  Result := '';
  for I := 0 to FManager.RegisteredProfiles.Count - 1 do
  begin
    if FManager.RegisteredProfiles[I].Visible then
    begin
      Info := Default(TTetheringProfileInfo);
      Info.ManagerIdentifier := FManager.Identifier;
      Info.ProfileIdentifier := FManager.RegisteredProfiles[I].Identifier;
      Info.ProfileText := FManager.RegisteredProfiles[I].Text;
      Info.ProfileGroup := FManager.RegisteredProfiles[I].Group;
      Info.ProfileType := FManager.RegisteredProfiles[I].ProfileType;
      Info.ProfileVersion := FManager.RegisteredProfiles[I].Version;

      SetLength(Info.AllowedConnections, FManager.RegisteredProfiles[I].Protocols.Count);
      Protocols := FManager.RegisteredProfiles[I].Protocols;
      for J := 0 to Protocols.Count - 1 do
      begin
        Info.AllowedConnections[J].ProtocolType := Protocols[J].ProtocolType;
        Info.AllowedConnections[J].AdapterType := Protocols[J].FAdapter.AdapterType;
        Info.AllowedConnections[J].Connection := Protocols[J].GetConnectionString(Protocols[J].FAdapter.FAdapterConnectionString);
      end;
      Result := Result + Info.ToString + TetheringBlockSeparator;
    end;
  end;
end;

function TTetheringAdapter.GenerateTimer(const AEvent: TTetheringNotifyEvent; Timeout: Cardinal): TThread;
begin
  Result := FManager.GenerateTimer(AEvent, Timeout);
end;

function TTetheringAdapter.GenerateToken(const AManager, Seed: string): string;
begin
  Result := FManager.GenerateToken(AManager, Seed);
end;

{ TTetheringProtocol }

function TTetheringProtocol.CheckPassword(const APassword, Seed: string): Boolean;
begin
  Result := FAdapter.FManager.CheckPassword(APassword, Seed);
end;

function TTetheringProtocol.CheckToken(const AManager, Seed, Token: string): Boolean;
begin
  Result := FAdapter.FManager.CheckToken(AManager, Seed, Token);
end;

procedure TTetheringProtocol.DoOnCommand(const Sender: TObject; const AConnection: TTetheringCustomComm;
  const ACommand: TTetheringCommand; var Response: TTetheringCommands);
begin
  if Assigned(FOnCommand) then
    FOnCommand(Sender, AConnection, ACommand, Response);
end;

function TTetheringProtocol.GenerateToken(const AManager, Seed: string): string;
begin
  Result := FAdapter.FManager.GenerateToken(AManager, Seed);
end;

function TTetheringProtocol.GetHash(const AValue: string): string;
begin
  Result := THashSHA1.GetHashString(AValue);
end;

function TTetheringProtocol.GetRandomString(const Len: Integer): string;
begin
  Result := THash.GetRandomString(Len);
end;

function TTetheringProtocol.ReadData: TBytes;
begin
  Result := ReceiveData;
end;

function TTetheringProtocol.ReadStream(const AStream: TStream): Boolean;
begin
  Result := ReceiveStream(AStream);
end;

function TTetheringProtocol.ReadStringData: string;
begin
  Result := ReceiveStringData;
end;

function TTetheringProtocol.ReceiveData: TBytes;
begin
  Result := DoReceiveData;
end;

function TTetheringProtocol.ReceiveStream(const AStream: TStream): Boolean;
begin
  Result := DoReceiveStream(AStream);
end;

function TTetheringProtocol.ReceiveStringData: string;
begin
  Result := TEncoding.UTF8.GetString(ReceiveData);
end;

procedure TTetheringProtocol.SaveTokenFromLocal(const AManager, Seed: string);
begin
  FAdapter.FManager.SaveTokenFromLocal(AManager, Seed);
end;

procedure TTetheringProtocol.SaveTokenFromRemote(const AManager, Seed: string);
begin
  FAdapter.FManager.SaveTokenFromRemote(AManager, Seed);
end;

procedure TTetheringProtocol.SendData(const AData: TBytes);
begin
  DoSendData(AData);
end;

function TTetheringProtocol.SendStream(const AStream: TStream): Boolean;
begin
  Result := DoSendStream(AStream);
end;

function TTetheringProtocol.TransferStream(const AStream: TStream): Boolean;
begin
  Result := SendStream(AStream);
end;

procedure TTetheringProtocol.SendData(const AData: string);
begin
  DoSendData(TEncoding.UTF8.GetBytes(AData));
end;

{ TTetheringProtocols }

class constructor TTetheringProtocols.Create;
begin
  FProtocols := TDictionary<TTetheringProtocolType, TTetheringProtocolClass>.Create;
end;

class destructor TTetheringProtocols.Destroy;
begin
  FProtocols.Free;
end;

class function TTetheringProtocols.GetProtocolInstance(const AProfile: TTetheringProfile;
  const AProtocolType: TTetheringProtocolType; const AnAdapter: TTetheringAdapter;
  AsClient: Boolean): TTetheringProtocol;
var
  AProtocolRef: TTetheringProtocolClass;
begin
  if FProtocols.TryGetValue(AProtocolType, AProtocolRef) then
  begin
    Result := AProtocolRef.CreateInstance(AnAdapter, AsClient);
    if Result <> nil then
    begin
      Result.FProfile := AProfile;
      Result.OnAfterReceiveData := AProfile.OnAfterReceiveData;
      Result.OnBeforeSendData := AProfile.OnBeforeSendData;
      Result.OnAfterReceiveStream := AProfile.OnAfterReceiveStream;
      Result.OnBeforeSendStream := AProfile.OnBeforeSendStream;
      if AnAdapter.IsListening then
        Result.StartCommunication;
    end;
  end
  else
    Result := nil;
end;

class function TTetheringProtocols.GetProtocolTypes: TTetheringProtocolTypes;
begin
  SetLength(Result, 0);
  if FProtocols <> nil then
    Result := FProtocols.Keys.ToArray;
end;

class procedure TTetheringProtocols.RegisterProtocol(const AProtocol: TTetheringProtocolClass;
  const AProtocolType: TTetheringProtocolType);
begin
  FProtocols.Add(AProtocolType, AProtocol);
end;

class procedure TTetheringProtocols.UnRegisterProtocol(const AProtocolType: TTetheringProtocolType);
begin
  FProtocols.Remove(AProtocolType);
end;

{ TTetheringAdapters }

class constructor TTetheringAdapters.Create;
begin
  FAdapters := TDictionary<TTetheringAdapterType, TTetheringAdapterClass>.Create;
end;

class destructor TTetheringAdapters.Destroy;
begin
  FAdapters.Free;
end;

class function TTetheringAdapters.GetAdapterInstance(const AType: TTetheringAdapterType): TTetheringAdapter;
var
  AAdapterClass: TTetheringAdapterClass;
begin
  if FAdapters.TryGetValue(AType, AAdapterClass) then
    Result := AAdapterClass.CreateInstance
  else
    Result := nil;
end;

class function TTetheringAdapters.GetAdapterTypes: TTetheringAdapterTypes;
begin
  Result := FAdapters.Keys.ToArray;
end;

class procedure TTetheringAdapters.RegisterAdapter(const AnAdapter: TTetheringAdapterClass; const AType: TTetheringAdapterType);
begin
  if not FAdapters.ContainsKey(AType) then
    FAdapters.Add(AType, AnAdapter);
end;

class procedure TTetheringAdapters.UnRegisterAdapter(const AType: TTetheringAdapterType);
begin
  FAdapters.Remove(AType);
end;

{ TTetheringCommand }

constructor TTetheringCommand.Create(const ACommand: string; AVersion: Integer; const AParameters: TArray<string>; const AData: TObject);
begin
  FCommand := ACommand;
  FParameters := AParameters;
  FVersion := AVersion;
  FData := AData;
end;

constructor TTetheringCommand.Create(AType: TTetheringCommandType; const ACommand: string; AVersion: Integer;
  const AParameters: TArray<string>; const AData: TObject);
begin
  FCommandType := AType;
  FCommand := ACommand;
  FVersion := AVersion;
  FParameters := AParameters;
  FData := nil;
end;

constructor TTetheringCommand.Create(const ACommand: string; AVersion: Integer);
begin
  FCommand := ACommand;
  FVersion := AVersion;
  FParameters := [];
  FData := nil;
end;

constructor TTetheringCommand.Create(const RawData: TBytes);
var
  LStr: string;
  LParts: TArray<string>;
begin
  LStr := TEncoding.UTF8.GetString(RawData);
  LParts := TTetheringManagerCommand.Split(LStr, CommandSep);

  if Length(LParts) > 0 then
    FCommand := LParts[0]
  else
    FCommand := '';
  if Length(LParts) > 1 then
    FVersion := LParts[1].ToInteger;

  if Length(LParts) = 3 then
    FParameters := TTetheringManagerCommand.Split(LParts[2], ParameterSep)
  else
    FParameters := [];
  FData := nil;
end;

constructor TTetheringCommand.Create(AType: TTetheringCommandType; const ACommand: string; AVersion: Integer;
  const AParameters: array of string; const AData: TObject);
var
  Len: Integer;
  I: Integer;
begin
  FCommandType := AType;
  FCommand := ACommand;
  FVersion := AVersion;
  Len := Length(AParameters);
  if Len > 0 then
  begin
    SetLength(FParameters, Len);
    for I := 0 to High(AParameters) do
      FParameters[I] := AParameters[I];
  end
  else
    FParameters := [];
  FData := AData;
end;

constructor TTetheringCommand.Create(const ACommand: string; AVersion: Integer; const AParameters: array of string; const AData: TObject);
var
  Len: Integer;
  I: Integer;
begin
  FCommand := ACommand;
  FVersion := AVersion;
  Len := Length(AParameters);
  if Len > 0 then
  begin
    SetLength(FParameters, Len);
    for I := 0 to High(AParameters) do
      FParameters[I] := AParameters[I];
//    TArray.Copy<string>(AParameters, Parameters, Len);
  end
  else
    FParameters := [];
  FData := AData;
end;

function TTetheringCommand.ToBytes: TBytes;
begin
  Result := TEncoding.UTF8.GetBytes(ToString);
end;

function TTetheringCommand.ToString: string;
var
  LParams: string;
begin
  LParams := TTetheringManagerCommand.Join(ParameterSep, Parameters);
  Result := TTetheringManagerCommand.Join(CommandSep, [Command, Version.ToString, LParams]);
end;

{ TManagerCommunicationThread }

procedure TTetheringManagerCommunicationThread.AddProfiles(const AConnectionString, AData: string);
var
  I: Integer;
  StringProfiles: TArray<string>;
  LRemoteProfiles: TTetheringProfileInfoList;
begin
  if Assigned(FNotifyEndProfileDiscovery) then
  begin
    LRemoteProfiles := TTetheringProfileInfoList.Create;
    try
      StringProfiles := TTetheringManagerCommand.Split(AData, TetheringBlockSeparator);
      for I := Low(StringProfiles) to High(StringProfiles) do
        LRemoteProfiles.Add(TTetheringManager.StringToProfileInfo(StringProfiles[I]));
      FNotifyEndProfileDiscovery(LRemoteProfiles);
    finally
      LRemoteProfiles.Free;
    end;
  end;
end;

procedure TTetheringManagerCommunicationThread.CommunicationThreadInitialized;
begin
  if FEventAdapterSync <> nil then
    FEventAdapterSync.SetEvent;
end;

constructor TTetheringManagerCommunicationThread.Create(const AnAdapter: TTetheringAdapter);
begin
  inherited Create(True);
  FNetworkInfo := TObjectDictionary<string, TNetworkInfo>.Create([doOwnsValues]);
  FEventAdapterSync := TEvent.Create;
  FAdapter := AnAdapter;
  FCommandQueue := TCommandQueue.Create;
end;

procedure TTetheringManagerCommunicationThread.CreateDiscoverProfilesTimer(const AConnection: string;
  Timeout: Cardinal);
var
  Info: TNetworkInfo;
begin
  if FNetworkInfo.TryGetValue(AConnection, Info) then
  begin
    Info.EndProfilesTimer.DisposeOf;
    Info.EndProfilesTimer := FAdapter.GenerateTimer(FAdapter.EndProfilesTimerProc, Timeout);
    Info.EndProfilesTimer.Start;
  end;
end;

function TTetheringManagerCommunicationThread.CreateManagerInfo(const AIdentifier, AName, AText,
  AConnectionString: string; AVersion: Integer): TTetheringManagerInfo;
begin
  Result.ManagerIdentifier := AIdentifier;
  Result.ManagerName := AName;
  Result.ManagerText := AText;
  Result.ConnectionString := AConnectionString;
  Result.Version := AVersion;
  Result.Adapter := FAdapter;
end;

destructor TTetheringManagerCommunicationThread.Destroy;
begin
  FNetworkInfo.Free;
  FreeAndNil(FEventAdapterSync);//.Free;
  inherited;
  FCommandQueue.Free;
end;

procedure TTetheringManagerCommunicationThread.DestroyDiscoverProfilesTimer(const AConnection: string);
var
  Info: TNetworkInfo;
begin
  if FNetworkInfo.TryGetValue(AConnection, Info) then
  begin
    Info.EndProfilesTimer.DisposeOf;
    Info.EndProfilesTimer := nil;
  end;
end;

function TTetheringManagerCommunicationThread.GetState(const Connection: string): TPairingState;
var
  Info: TNetworkInfo;
begin
  if FNetworkInfo.TryGetValue(Connection, Info) then
    Result := Info.State
  else
    Result := TPairingState.Waiting;
end;

function TTetheringManagerCommunicationThread.IsDiscoveringProfiles(const AConnection: string): Boolean;
var
  Info: TNetworkInfo;
begin
  Result := False;
  if FNetworkInfo.TryGetValue(AConnection, Info) then
  begin
    if (Info.EndProfilesTimer <> nil) and (Info.EndProfilesTimer is TTetheringAdapter.TThreadTimer) then
      Result := not (Info.EndProfilesTimer as TTetheringAdapter.TThreadTimer).IsCancelled;
  end;
end;

function TTetheringManagerCommunicationThread.GenerateRandomString(const AConnection: string): string;
begin
  Result := FAdapter.GetRandomString;
  GetNetworkInfo(AConnection).RandomString := Result;
end;

function TTetheringManagerCommunicationThread.GetNetworkInfo(const Connection: string): TNetworkInfo;
begin
  if not FNetworkInfo.TryGetValue(Connection, Result) then
  begin
    Result := TNetworkInfo.Create;
    Result.State := TPairingState.Waiting;
    Result.ManagerVersion := 0;
    FNetworkInfo.AddOrSetValue(Connection, Result);
  end;
end;

function TTetheringManagerCommunicationThread.GetNetworkInfoByManager(const AManagerId: string): TNetworkInfo;
var
  APair: TPair<string, TNetworkInfo>;
begin
  Result := nil;
  for APair in FNetworkInfo do
    if APair.Value.ManagerId = AManagerId then
      Exit(APair.Value);
end;

function TTetheringManagerCommunicationThread.GetRandomString(const AConnection: string): string;
begin
  Result := GetNetworkInfo(AConnection).RandomString;
end;

function TTetheringManagerCommunicationThread.GetRemoteConnectionString(const AConnection: string): string;
begin
  Result := EMPTYTOKEN;
end;

function TTetheringManagerCommunicationThread.ProcessResponse(const AData: string; var RemoteConnectionString: string): string;

  function IsPreferredAdapter(const ARemoteAdapters: string): Boolean;
  var
    LLocalAdapters: string;
    LAdaptersLocal, LAdaptersRemote: TTetheringAdapterTypes;
    LPreferred: string;
    I: Integer;
    J: Integer;
  begin
    Result := False;
    LLocalAdapters := FAdapter.Manager.AllowedAdapters;
    LAdaptersLocal := TTetheringManagerCommand.Split(LLocalAdapters, TetheringSeparator);
    if LLocalAdapters = ARemoteAdapters then
      Result := (FAdapter.AdapterType = LAdaptersLocal[0])
    else
    begin
      LAdaptersRemote := TTetheringManagerCommand.Split(ARemoteAdapters, TetheringSeparator);
      LPreferred := '';
                                                                          
      for I := Low(LAdaptersLocal) to High(LAdaptersLocal) do
      begin
        for J := Low(LAdaptersRemote) to High(LAdaptersRemote) do
        begin
          if (LAdaptersLocal[I] = LAdaptersRemote[J]) then
          begin
            if (LPreferred = '') then
              LPreferred := LAdaptersLocal[I];

            if (LAdaptersLocal[I] = FAdapter.AdapterType) then
            begin
              Result := LPreferred = LAdaptersLocal[I];
            end;
          end;
        end
      end;
    end;
  end;

var
  State: TPairingState;
  Password, Token: string;
  ManagerInfo: TTetheringManagerInfo;
  LCommand: TTetheringManagerCommand;
  LCad: string;
  LVersion: Integer;
  LNetworkInfo: TNetworkInfo;
  LProcessCommand: Boolean;
begin
  if Terminated or (AData = '') then // Avoid process any message if communication thread is terminated
    Exit;

  Result := TetheringEmpty;
  LCommand.DecodeCommand(AData);
  if not LCommand.ValidCommand then
    Exit;

  RemoteConnectionString := LCommand.ConnectionString;

  LNetworkInfo := GetNetworkInfo(RemoteConnectionString);
  State := LNetworkInfo.State;
  LVersion := LNetworkInfo.ManagerVersion;

  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Adapter) then
    FAdapter.Log(Format('In(%s): %d: %s: %s -> %s',
      [RemoteConnectionString, LVersion, FAdapter.Manager.Text, GetEnumName(TypeInfo(TPairingState), Ord(State)), AData]));

  case State of
    TPairingState.Waiting:
      begin
        // TetheringDiscoverManagers
        if LCommand.CommandText = TetheringDiscoverManagers then
        begin
          if LCommand.Version = 0 then
            Result := CommandStr(TetheringServerDiscovered, LCommand.Version,
              [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text])
          else
            Result := CommandStr(TetheringServerDiscovered, FAdapter.Manager.Version,
              [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text, FAdapter.Manager.AllowedAdapters])
        end
        // TetheringServerDiscovered
        else if (LCommand.CommandText = TetheringServerDiscovered) and ((LCommand.NumParams = 3) or (LCommand.NumParams = 4)) then
        begin
          if LCommand.Params[0] <> FAdapter.Manager.Identifier then // To avoid add myself
          begin
            if LCommand.Version >= FAdapter.Manager.Version then
              LVersion := FAdapter.Manager.Version
            else
              LVersion := LCommand.Version;
            GetNetworkInfo(RemoteConnectionString).ManagerVersion := LVersion;
            if LCommand.NumParams = 3 then
              FAdapter.AddManagerInfo(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString,
                FAdapter.AdapterType, LVersion)
            else
              FAdapter.AddManagerInfo(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString,
                LCommand.Params[3], LVersion);
          end
        end
        // TetheringRequestPair
        else if (LCommand.CommandText = TetheringRequestPair) and (LCommand.NumParams >= 4) then
        begin
          LProcessCommand := (LCommand.NumParams = 4) or ((LCommand.NumParams = 5) and IsPreferredAdapter(LCommand.Params[4]));
          if LProcessCommand then
          begin
            if FAdapter.Manager.Password = '' then
            begin
              Result := CommandStr(TetheringPairAccepted, LVersion,
                [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text, EMPTYTOKEN]);
              SetState(RemoteConnectionString, TPairingState.Paired);
              SetManagerId(RemoteConnectionString, LCommand.Params[0]); // ??? Was LCommand.ConnectionString
              // I have to send the response before call to DoPairedFromLocal, because DiscoverProfiles is sent
              SendCommand(RemoteConnectionString, Result);
              Result := TetheringEmpty;
              FAdapter.DoPairedFromLocal(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString, LVersion);
            end
            else if FAdapter.KnownManagers.IndexOfName(LCommand.Params[0]) >= 0 then
            begin
              Result := CommandStr(TetheringPairingToken, LVersion,
                [FAdapter.Manager.Identifier, GenerateRandomString(RemoteConnectionString)]);
              SetState(RemoteConnectionString, TPairingState.WaitingPassword);
            end
            else
            begin
              Result := CommandStr(TetheringRequestPassword, LVersion,
                [FAdapter.Manager.Identifier, GenerateRandomString(RemoteConnectionString)]);
              SetState(RemoteConnectionString, TPairingState.WaitingPassword);
            end;
          end;
        end;
      end;
    TPairingState.WaitingPairResponse:
      begin
        // TetheringPairingToken
        if (LCommand.CommandText = TetheringPairingToken) and (LCommand.NumParams = 2) then
        begin
          Token := FAdapter.GenerateToken(LCommand.Params[0], LCommand.Params[1]);
          if Token = '' then // No token can be generated so we ask for password
          begin
            FAdapter.DoRequestManagerPassword(LCommand.Params[0], Password);
            Result := CommandStr(TetheringPassword, LVersion,
              [FAdapter.GetHash(Password + LCommand.Params[1]), FAdapter.Manager.Identifier, FAdapter.Manager.Name,
              FAdapter.Manager.Text]);
          end
          else
            Result := CommandStr(TetheringGeneratedToken, LVersion,
              [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text, Token])
        end
        // TetheringRequestPassword
        else if (LCommand.CommandText = TetheringRequestPassword) and (LCommand.NumParams = 2) then
        begin
          FAdapter.DoRequestManagerPassword(LCommand.Params[0], Password);
          Result := CommandStr(TetheringPassword, LVersion,
            [FAdapter.GetHash(Password + LCommand.Params[1]), FAdapter.Manager.Identifier, FAdapter.Manager.Name,
            FAdapter.Manager.Text]);
        end
        // TetheringPairDenied
        else if (LCommand.CommandText = TetheringPairDenied) and (LCommand.NumParams = 1) then
        begin
          FAdapter.DoAuthErrorFromRemote(LCommand.Params[0]);
          SetState(RemoteConnectionString, TPairingState.Waiting);
        end
        // TetheringPairAccepted
        else if (LCommand.CommandText = TetheringPairAccepted) and (LCommand.NumParams = 4) then
        begin
          SetState(RemoteConnectionString, TPairingState.Paired);
          SetManagerId(RemoteConnectionString, LCommand.Params[0]);
          FAdapter.SaveTokenFromRemote(LCommand.Params[0], LCommand.Params[3]);
          FAdapter.DoPairedToRemote(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString, LVersion);
        end
        else
          SetState(RemoteConnectionString, TPairingState.Waiting);
      end;
    TPairingState.WaitingPassword:
      begin
        // TetheringGeneratedToken
        if (LCommand.CommandText = TetheringGeneratedToken) and (LCommand.NumParams = 4) then
        begin
          if FAdapter.CheckToken(LCommand.Params[0], GetRandomString(RemoteConnectionString), LCommand.Params[3]) then
          begin
            Result := CommandStr(TetheringPairAccepted, LVersion,
              [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text, EMPTYTOKEN]);
            SetState(RemoteConnectionString, TPairingState.Paired);
            SetManagerId(RemoteConnectionString, LCommand.Params[0]);
            // I have to send the response before call to DoPairedFromLocal, because DiscoverProfiles is sent
            SendCommand(RemoteConnectionString, Result);
            Result := TetheringEmpty;
            FAdapter.DoPairedFromLocal(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString, LVersion);
          end
        end
        // TetheringPassword
        else if (LCommand.CommandText = TetheringPassword) and (LCommand.NumParams = 4) then
        begin
          if FAdapter.CheckPassword(LCommand.Params[0], GetRandomString(RemoteConnectionString)) then
          begin
            Result := CommandStr(TetheringPairAccepted, LVersion,
              [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text, GenerateRandomString(RemoteConnectionString)]);

            FAdapter.SaveTokenFromLocal(LCommand.Params[1], GetRandomString(RemoteConnectionString));
            SetState(RemoteConnectionString, TPairingState.Paired);
            SetManagerId(RemoteConnectionString, LCommand.Params[1]);
            // I have to send the response before call to DoPairedFromLocal, because DiscoverProfiles is sent
            SendCommand(RemoteConnectionString, Result);
            Result := TetheringEmpty;
            FAdapter.DoPairedFromLocal(LCommand.Params[1], LCommand.Params[2], LCommand.Params[3], RemoteConnectionString, LVersion);
          end
          else
          begin
            Result := CommandStr(TetheringPairDenied, LVersion, [FAdapter.Manager.Identifier]);
            SetState(RemoteConnectionString, TPairingState.Waiting);
            SetManagerId(RemoteConnectionString, LCommand.Params[1]);
            FAdapter.DoAuthErrorFromLocal(LCommand.Params[1]);
          end;
        end
        else
          SetState(RemoteConnectionString, TPairingState.Waiting);
      end;
    TPairingState.Paired:
      begin
        // TetheringDiscoverProfiles
        if LCommand.CommandText = TetheringDiscoverProfiles then
        begin
          Result := CommandStr(TetheringBeginProfiles, LVersion, [FAdapter.ProfilesInfo + TetheringEndProfiles]);
        end
        // TetheringNotification
        else if (LCommand.CommandText = TetheringNotification) and (LCommand.NumParams = 3) then
          FAdapter.DoLaunchNotification(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2])
        // TetheringBeginProfiles
        else if (LCommand.CommandText = TetheringBeginProfiles) then
        begin
          if IsDiscoveringProfiles(RemoteConnectionString) then
          begin
            LCad := LCommand.Params[0].Substring(0, LCommand.Params[0].Length - TetheringEndProfiles.Length - 1);
            DestroyDiscoverProfilesTimer(RemoteConnectionString);
            AddProfiles(RemoteConnectionString, LCommand.Params[0].Substring(0, LCommand.Params[0].Length - TetheringEndProfiles.Length - 1));
          end
          else
            DestroyDiscoverProfilesTimer(RemoteConnectionString);
        end
        // TetheringRequestUnPair
        else if (LCommand.CommandText = TetheringRequestUnPair) and (LCommand.NumParams = 3) then
        begin
          ManagerInfo := CreateManagerInfo(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString, LVersion);
          ManagerInfo.ManagerAdapters := FAdapter.AdapterType;
          SetState(RemoteConnectionString, TPairingState.Waiting);
          FAdapter.DoUnPairManager(ManagerInfo);
        end
        // TetheringDiscoverManagers
        else if LCommand.CommandText = TetheringDiscoverManagers then
        begin
        if LCommand.NumParams = 1 then
          Result := CommandStr(TetheringServerDiscovered, LCommand.Version,
            [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text])
        else
          if LCommand.NumParams = 2 then
          begin
            if IsPreferredAdapter(LCommand.Params[1]) then
              Result := CommandStr(TetheringServerDiscovered, FAdapter.Manager.Version,
                [FAdapter.Manager.Identifier, FAdapter.Manager.Name, FAdapter.Manager.Text, FAdapter.Manager.AllowedAdapters])
          end;
        end
        // TetheringRequestPair
        else if (LCommand.CommandText = TetheringRequestPair) and (LCommand.NumParams >= 4) then
        begin  // Ignore command
          ManagerInfo := CreateManagerInfo(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString, LVersion);
            SetState(RemoteConnectionString, TPairingState.Waiting);
          FAdapter.DoUnPairManager(ManagerInfo);
          SetState(RemoteConnectionString, TPairingState.Waiting);
            Result := ProcessResponse(AData, RemoteConnectionString);
        end
        // TetheringServerDiscovered
        else if (LCommand.CommandText = TetheringServerDiscovered) and ((LCommand.NumParams = 3) or (LCommand.NumParams = 4)) then
        begin
          if LCommand.Params[0] <> FAdapter.Manager.Identifier then // To avoid add myself
            if LCommand.NumParams = 3 then
              FAdapter.AddManagerInfo(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString, FAdapter.AdapterType, LVersion)
            else
              FAdapter.AddManagerInfo(LCommand.Params[0], LCommand.Params[1], LCommand.Params[2], RemoteConnectionString, LCommand.Params[3], LVersion);
        end
        // Command not recognized.
        else
        begin
          SetState(RemoteConnectionString, TPairingState.Waiting); // Unpair, command not recognized
          Result := ProcessResponse(AData, RemoteConnectionString);
        end;
      end;
  end;
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Adapter) then
    FAdapter.Log(Format('Out(%s): state: %s; Resp: <%s>', [RemoteConnectionString,
      GetEnumName(TypeInfo(TPairingState), Ord(GetState(RemoteConnectionString))), Result]));
end;

procedure TTetheringManagerCommunicationThread.CancelDiscoverProfilesTimer(const AConnection: string);
var
  Info: TNetworkInfo;
begin
  if FNetworkInfo.TryGetValue(AConnection, Info) then
  begin
    if (Info.EndProfilesTimer <> nil) and (Info.EndProfilesTimer is TTetheringAdapter.TThreadTimer) then
      (Info.EndProfilesTimer as TTetheringAdapter.TThreadTimer).Cancel;
  end;
end;

function TTetheringManagerCommunicationThread.CommandStr(const ACommand: string; AVersion: Integer;
  const Params: TTetheringParams): string;
begin
  Result := TTetheringManagerCommand.Create(ACommand, FAdapter.FAdapterConnectionString, AVersion, Params).ToString;
end;

procedure TTetheringManagerCommunicationThread.SetState(const Connection: string; AState: TPairingState);
begin
  GetNetworkInfo(Connection).State := AState;
end;

procedure TTetheringManagerCommunicationThread.WaitCommThreadInitialization;
begin
  if FEventAdapterSync <> nil then
    FEventAdapterSync.WaitFor(INFINITE);
end;

procedure TTetheringManagerCommunicationThread.SendCommand(const AConnection, AData: string);
begin
  if (FAdapter.Manager <> nil) and FAdapter.Manager.Enabled then
    DoSendCommand(AConnection, AData);
end;

procedure TTetheringManagerCommunicationThread.SetManagerId(const Connection: string; const AManagerId: string);
begin
  GetNetworkInfo(Connection).ManagerId := AManagerId;
end;

{ TTetheringConnection }

function TTetheringConnection.Clone: TTetheringConnection;
begin
  Result := TTetheringConnection.Create;
  Result.FConnectionString := FConnectionString;
  Result.FProtocolType := FProtocolType;
end;

destructor TTetheringConnection.Destroy;
begin
  FProtocol.Free;
  inherited;
end;

{ TTetheringManagerCommunicationThread.TNetworkInfo }

destructor TTetheringManagerCommunicationThread.TNetworkInfo.Destroy;
begin
  if EndProfilesTimer <> nil then
    EndProfilesTimer.DisposeOf;
  inherited;
end;

{ TTetheringAdapter.TTetheringLog }

class procedure TTetheringAdapter.TTetheringLog.Log(const Msg: string);
begin
  if Assigned(FTetheringLog) then
  begin
    TMonitor.Enter(FLogs);
    try
    FLogs.Enqueue(Msg);
    TThread.Queue(nil, QueueLog);
    finally
      TMonitor.Exit(FLogs);
  end;
end;
end;

class procedure TTetheringAdapter.TTetheringLog.RegisterLog(const DoLog: TTetheringDoLog);
begin
  FTetheringLog := DoLog;
end;

class procedure TTetheringAdapter.TTetheringLog.QueueLog;
var
  Msg: string;
begin
  TMonitor.Enter(FLogs);
  try
    Msg := FLogs.Dequeue;
  finally
    TMonitor.Exit(FLogs);
end;
  DoLog(Msg);
end;

class constructor TTetheringAdapter.TTetheringLog.Create;
begin
  FLogs := TQueue<string>.Create;
end;

class destructor TTetheringAdapter.TTetheringLog.Destroy;
begin
  FLogs.Free;
end;

class procedure TTetheringAdapter.TTetheringLog.DoLog(const Msg: string);
begin
  if Assigned(FTetheringLog) then
    FTetheringLog(Msg);
end;

class procedure TTetheringAdapter.Log(const Msg: string);
begin
  TTetheringLog.Log(Msg);
end;

class procedure TTetheringAdapter.RegisterLog(const DoLog: TTetheringDoLog);
begin
  TTetheringLog.RegisterLog(DoLog);
end;

class procedure TTetheringAdapter.RemoveLogItem(ALogItem: TTetheringLogItem);
begin
  FLogItems := FLogItems - [ALogItem];
end;

{ TTetheringManagerCommand }

class function TTetheringManagerCommand.Create(const ACommandText, AConnectionString: string; AVersion: Integer;
  const AParams: TTetheringParams): TTetheringManagerCommand;
begin
  Result.CommandText := ACommandText;
  Result.ConnectionString := AConnectionString;
  Result.Version := AVersion;
  Result.Params := AParams;
end;

procedure TTetheringManagerCommand.DecodeCommand(const ACommandString: string);
var
  LLength: Integer;
  LParts: TArray<string>;
  I: Integer;
begin
  LParts := Split(AcommandString, TetheringSeparator);
  LLength := Length(LParts);
  if LLength >= NumStaticParams then
  begin
    ValidCommand := True;
    CommandText := LParts[0];
    ConnectionString := LParts[1];
    Version := LParts[2].ToInteger;
    SetLength(Params, LLength - NumStaticParams);
    for I := NumStaticParams to LLength - 1 do
      Params[I-NumStaticParams] := UnEscapeSeparator(LParts[I], [TetheringSeparator]);
  end
  else
    ValidCommand := False;
end;

class function TTetheringManagerCommand.EscapeSeparator(const AText: string; const Separators: array of Char): string;
var
  C: Char;
begin
  Result := AText;
  for C in Separators do
    Result := Result.Replace(C, EscapePrefix+C);
end;

function TTetheringManagerCommand.GetNumParams: Integer;
begin
  Result := Length(Params);
end;

class function TTetheringManagerCommand.Join(const ASeparator: Char; const AValues: TArray<string>): string;
var
  I: Integer;
begin
  if (AValues = nil) or (Length(AValues) = 0) then
    Result := ''
  else
  begin
    Result := EscapeSeparator(AValues[0], ASeparator);
    for I := 1 to High(AValues) do
      Result := Result + ASeparator + EscapeSeparator(AValues[I], ASeparator);
  end;
end;

class function TTetheringManagerCommand.Split(const AString: string; const ASeparator: Char): TArray<string>;
const
  DeltaGrow = 32;
var
  NextSeparator, LastIndex: Integer;
  Total: Integer;
  CurrentLength: Integer;
  S: string;
begin
  Total := 0;
  LastIndex := 0;
  CurrentLength := 0;
  NextSeparator := AString.IndexOf(ASeparator, LastIndex);
  while (NextSeparator >= 0) do
  begin
    if (NextSeparator > 0) and (AString.Chars[NextSeparator-1] <> EscapePrefix) then
    begin
      S := AString.Substring(LastIndex, NextSeparator - LastIndex);

      Inc(Total);
      if CurrentLength < Total then
      begin
        CurrentLength := Total + DeltaGrow;
        SetLength(Result, CurrentLength);
      end;
      Result[Total - 1] := UnEscapeSeparator(S, ASeparator);
      LastIndex := NextSeparator + 1;
    end;
    NextSeparator := AString.IndexOf(ASeparator, NextSeparator + 1);
  end;

  if (LastIndex < AString.Length) then
  begin
    Inc(Total);
    SetLength(Result, Total);
    Result[Total - 1] := UnEscapeSeparator(AString.Substring(LastIndex, AString.Length - LastIndex), ASeparator);
  end
  else
    SetLength(Result, Total);
end;

function TTetheringManagerCommand.ToString: string;
var
  LStrings: TArray<string>;
begin
  LStrings := [CommandText, ConnectionString, Version.ToString];
  LStrings := LStrings + Params;
  Result := Join(TetheringSeparator, LStrings);
  Result := EscapeSeparator(Result, [TetheringCommandSeparator]) + TetheringCommandSeparator;
end;

class function TTetheringManagerCommand.UnEscapeSeparator(const AText: string; const Separators: array of Char): string;
var
  C: Char;
begin
  Result := AText;
  for C in Separators do
    Result := Result.Replace(string(EscapePrefix + C), C);
end;


{ TTetheringManagerCommunicationThread.TCommandQueue }

function TTetheringManagerCommunicationThread.TCommandQueue.Count: Integer;
begin
  Result := 0;
  if FQueue <> nil then
  begin
    TMonitor.Enter(FQueue);
    try
      Result := FQueue.Count;
    finally
      TMonitor.Exit(FQueue);
    end;
  end;
end;

constructor TTetheringManagerCommunicationThread.TCommandQueue.Create;
begin
  inherited;
  FQueue := TQueue<string>.Create;
  FEvent := TEvent.Create;
end;

function TTetheringManagerCommunicationThread.TCommandQueue.Dequeue: string;
begin
  if FQueue <> nil then
  begin
    TMonitor.Enter(FQueue);
    try
      if FQueue.Count > 0 then
        Result := FQueue.Dequeue
      else
        Result := '';
    finally
      TMonitor.Exit(FQueue);
    end;
  end;
end;

destructor TTetheringManagerCommunicationThread.TCommandQueue.Destroy;
begin
  FEvent.Free;
  FQueue.Free;
  inherited;
end;

procedure TTetheringManagerCommunicationThread.TCommandQueue.Enqueue(const ACommand: string);
begin
  if FQueue <> nil then
  begin
    TMonitor.Enter(FQueue);
    try
      FQueue.Enqueue(Acommand);
      FEvent.SetEvent;
    finally
      TMonitor.Exit(FQueue);
    end;
  end;
end;

procedure TTetheringManagerCommunicationThread.TCommandQueue.WaitCommand;
begin
  if FEvent <> nil then
  begin
    FEvent.ResetEvent;
    FEvent.WaitFor(100);
  end;
end;

{ TTetheringProfileInfo }

procedure TTetheringProfileInfo.FromString(const AProfileInfoString: string);
  function CreateAllowedConnections(const AData: string): TTetheringAllowedConnections;
  var
    LTmp: TArray<string>;
    LRecordStr: TArray<string>;
    I: Integer;
  begin
    LTmp := AData.Split([';']);
    SetLength(Result, Length(LTmp));
    for I:= Low(LTmp) to High(LTmp) do
    begin
      LRecordStr := LTmp[I].Split([',']);
      if Length(LRecordStr) = 3 then
      begin
        Result[I].ProtocolType := LRecordStr[0];
        Result[I].AdapterType := LRecordStr[1];
        Result[I].Connection := LRecordStr[2];
      end;
    end;
  end;

var
  Items: TArray<string>;
begin
  Self := Default(TTetheringProfileInfo);
  Items := TTetheringManagerCommand.Split(AProfileInfoString, TetheringSeparator);
  if Length(Items) = 7 then
  begin
    ManagerIdentifier := Items[0];
    ProfileIdentifier := Items[1];
    ProfileText := Items[2];
    ProfileGroup := Items[3];
    ProfileType := TTetheringProfileType(Items[4]);
    ProfileVersion := Items[5].ToInteger;
    AllowedConnections := CreateAllowedConnections(Items[6]);
  end;
end;

function TTetheringProfileInfo.ToString: string;
  function ProcessAllowedConnections(const AConnections: TTetheringAllowedConnections): string;
  var
    LConnection: TTetheringAllowedConnection;
  begin
    Result := '';
    for LConnection in AConnections do
      Result := Result + LConnection.ProtocolType + ',' + LConnection.AdapterType + ',' + LConnection.Connection + ';'
  end;
begin
  Result := TTetheringManagerCommand.Join(TetheringSeparator,
    [ManagerIdentifier, ProfileIdentifier, ProfileText, ProfileGroup, ProfileType, ProfileVersion.ToString,
    ProcessAllowedConnections(AllowedConnections)]);
end;

end.
