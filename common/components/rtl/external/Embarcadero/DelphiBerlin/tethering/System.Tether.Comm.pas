{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Tether.Comm;

interface

{$IFNDEF IOS}
  {$DEFINE BT_PLATFORM}
{$ENDIF}

uses
  System.SysUtils, System.Classes, System.Generics.Collections, System.Types,
{$IFDEF BT_PLATFORM}
   System.SyncObjs, System.Bluetooth,
{$ENDIF}
  IPPeerAPI;

type
  ETetheringCommException = class(Exception);

  /// <summary>Enumeration for IP Version values</summary>
  TCommIPVersion = TIPVersionPeer;

  /// <summary> Event to pre-process and post-process the buffered data.</summary>
  /// <remarks> This function when defined should process the DataBuffer, and put it's equivalent data into the Result.</remarks>
  TTetheringDataEvent = function(const Sender: TObject; const ADataBuffer: TByteDynArray): TByteDynArray of object;
  /// <summary> Event to pre-process and post-process the stream data.</summary>
  /// <remarks> This function when defined should process the InputStream, and put it's equivalent data into the OutputStream.</remarks>
  TTetheringStreamEvent = procedure(const Sender: TObject; const AInputStream, AOutputStream: TStream) of object;

  TTetheringCustomComm = class
  private
    FOnAfterReceiveData: TTetheringDataEvent;
    FOnBeforeSendData: TTetheringDataEvent;
    FOnAfterReceiveStream: TTetheringStreamEvent;
    FOnBeforeSendStream: TTetheringStreamEvent;
  protected
    FSecured: Boolean;
    /// <summary>Last used Target for a connection</summary>
    FTarget: string;

    function DoConnect(const ATarget: string): Boolean; virtual; abstract;
    procedure DoDisconnect; virtual; abstract;
    function GetConnected: Boolean; virtual; abstract;
    function DoReadData: TBytes; virtual; abstract;
    procedure DoWriteData(const AData: TBytes); virtual; abstract;
    procedure DoReadStream(const AStream: TStream); virtual; abstract;
    procedure DoWriteStream(const AStream: TStream); virtual; abstract;

  public
    function Connect(const ATarget: string): Boolean;  // Only valid when is used as a client
    /// <summary>Closes a connection and opens it again.</summary>
    function ReConnect: Boolean;
    procedure Disconnect;
    function ReadData: TBytes;
    procedure WriteData(const AData: TBytes);
    procedure ReadStream(const AStream: TStream);
    procedure WriteStream(const AStream: TStream);

    property Connected: Boolean read GetConnected;
    property Secured: Boolean read FSecured write FSecured default False;

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


  // Server side

  TServerCommExecuteEvent = procedure(const AConnection: TTetheringCustomComm) of object;
  TServerCommConnectEvent = procedure(const AConnection: TTetheringCustomComm) of object;
  TServerCommDisconnectEvent = procedure(const AConnection: TTetheringCustomComm) of object;

  TTetheringCustomServerComm = class
  private
    FOnAfterReceiveData: TTetheringDataEvent;
    FOnBeforeSendData: TTetheringDataEvent;
    FOnAfterReceiveStream: TTetheringStreamEvent;
    FOnBeforeSendStream: TTetheringStreamEvent;
  protected
    FTarget: string; // In network is a port, in bluetooth is a GUID
    FActive: Boolean;
    FSecured: Boolean;

    FOnExecute: TServerCommExecuteEvent;
    FOnConnect: TServerCommConnectEvent;
    FOnDisconnect: TServerCommDisconnectEvent;

    function DoStartServer: Boolean; virtual; abstract;
    procedure DoStopServer; virtual; abstract;
    procedure SetTarget(const Value: string); virtual;
    procedure DoOnExecute(const AConnection: TTetheringCustomComm); virtual;
    procedure DoOnConnect(const AConnection: TTetheringCustomComm); virtual;
    procedure DoOnDisconnect(const AConnection: TTetheringCustomComm); virtual;

  public
    function StartServer: Boolean;
    procedure StopServer;
    property Target: string read FTarget write SetTarget;
    property Active: Boolean read FActive;
    property Secured: Boolean read FSecured write FSecured default False;
    property OnExecute: TServerCommExecuteEvent read FOnExecute write FOnExecute;
    property OnConnect: TServerCommConnectEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TServerCommDisconnectEvent read FOnDisconnect write FOnDisconnect;

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



{ Network classes }

  TNetworkCommUDPData = procedure(const AConnectionString: string; const AData: TBytes) of object;
  TNetworkCommMulticastData = procedure(const AConnectionString: string; const AData: TBytes) of object;

  TTetheringNetworkComm = class(TTetheringCustomComm)
  private const
    ReadTimeout = 200;
  protected
    /// <summary>IP Version that is going to be used by the NetworkComm</summary>
    FIPVersion: TCommIPVersion;
    FTCPClient: IIPTCPClient;
    [Weak] FIOHandler: IIPIOHandler;
    /// <summary>Remote connection string that identifies connection parameters of NetworkComm</summary>
    FRemoteConnectionString: string;

    function DoConnect(const ATarget: string): Boolean; override;
    procedure DoDisconnect; override;

    function GetConnected: Boolean; override;
    function DoReadData: TBytes; override;
    procedure DoWriteData(const AData: TBytes); override;
    procedure DoReadStream(const AStream: TStream); override;
    procedure DoWriteStream(const AStream: TStream); override;

  public
    constructor Create(const AIOHandler: IIPIOHandler; const ARemoteConnectionString: string; AIPVersion: TCommIPVersion);
    destructor Destroy; override;

    /// <summary>Property to retrieve the connection string of NetworkComm</summary>
    property RemoteConnectionString: string read FRemoteConnectionString;
  end;

  TTetheringNetworkServerComm = class(TTetheringCustomServerComm)
  private
    FIPVersion: TCommIPVersion;
    // TCP Server
    FTCPServer: IIPTCPServer;
    FContexts: TObjectDictionary<IIPContext, TTetheringNetworkComm>;
    FSocket: IIPSocketHandle;

    function GetComm(const AContext: IIPContext): TTetheringNetworkComm;
    procedure DoOnExecuteServer(AContext: IIPContext);
    procedure DoOnConnectServer(AContext: IIPContext);
    procedure DoOnDisconnectServer(AContext: IIPContext);
  protected
    procedure SetTarget(const Value: string); override;
    function DoStartServer: Boolean; override;
    procedure DoStopServer; override;

  public
    constructor Create(AIPVersion: TCommIPVersion);
    destructor Destroy; override;
  end;

  /// <summary>Class to manage the UDP communications in Tethering</summary>
  TTetheringNetworkServerCommUDP = class(TTetheringCustomServerComm)
  private
    FIPVersion: TCommIPVersion;
    // UDP Server
    FUDPServer: IIPUDPServer;
    FSocketUDP: IIPSocketHandle;
    FOnUDPData: TNetworkCommUDPData;

    procedure DoUDPRead(AThread: IIPUDPListenerThread; const AData: TIPBytesPeer; ABinding: IIPSocketHandle);

    function GetUDPPort: Integer;
  protected
    procedure SetTarget(const Value: string); override;
    function DoStartServer: Boolean; override;
    procedure DoStopServer; override;

  public
    /// <summary>Function to broadcast the given data.</summary>
    /// <param name="AData">Data to be broadcasted</param>
    /// <param name="AHost">A specific host to broadcast the data</param>
    /// <param name="InitialPort">Initial port to send the data</param>
    /// <param name="FinalPort">Final port to send the data</param>
    procedure BroadcastData(const AData: TBytes; const AHost: string; InitialPort, FinalPort: Integer);
    constructor Create(AIPVersion: TCommIPVersion);
    destructor Destroy; override;

    /// <summary>UDP Port used to send and receive data</summary>
    property UDPPort: Integer read GetUDPPort;

    /// <summary>Property to specify a procedure that is executed when data is received from the UDP Port </summary>
    property OnUDPData: TNetworkCommUDPData read FOnUDPData write FOnUDPData;
  end;

  /// <summary>Class to manage the Multicast communications in Tethering</summary>
  TTetheringNetworkServerCommMulticast = class(TTetheringCustomServerComm)
  private const
    TetheringMulticastGroup: array [TCommIPVersion] of string = (
      // '239.192.000.000'; Organization-Local Scope. [Meyer,RFC2365] {Do not Localize}
      '239.192.2.204',  // Organization-Local Scope. Ends with 2CC - 2.204 {Do not Localize}
      'FF08:0:0:0:0:0:0:2CC'  // All Organization Hosts... {Do not Localize}
    );

  private
    FIPVersion: TCommIPVersion;
    // Multicast Server
    FMulticastServer: IIPMulticastServer;
    FMulticastClient: IIPMulticastClient;
    FOnMulticastData: TNetworkCommMulticastData;

    procedure DoMulticastRead(Sender: TObject; const AData: TIPBytesPeer; const ABinding: IIPSocketHandle);

    function GetMulticastPort: Integer;
  protected
    procedure SetTarget(const Value: string); override;
    function DoStartServer: Boolean; override;
    procedure DoStopServer; override;

  public
    /// <summary>Function to broadcast the given data.</summary>
    /// <param name="AData">Data to be broadcasted</param>
    /// <param name="AHost">A specific host to broadcast the data</param>
    /// <param name="InitialPort">Initial port to send the data</param>
    /// <param name="FinalPort">Final port to send the data</param>
    procedure MulticastData(const AData: TBytes; const AHost: string; InitialPort, FinalPort: Integer);
    constructor Create(AIPVersion: TCommIPVersion);
    destructor Destroy; override;

    /// <summary>Multicast Port used to send and receive data</summary>
    property MulticastPort: Integer read GetMulticastPort;

    /// <summary>Property to specify a procedure that is executed when data is received from the Multicast Port </summary>
    property OnMulticastData: TNetworkCommMulticastData read FOnMulticastData write FOnMulticastData;
  end;

{$IFDEF BT_PLATFORM}
{ Bluetooth classes }

  TTetheringBTComm = class(TTetheringCustomComm)
  private const
    ReadTimeout = 600;
  private
    FBufferLock: TObject;
    FInternalBuffer: TBytes;
    FInternalSocket: TBluetoothSocket;

    function AvailableData: Boolean;
    function InternalReadData: TBytes;
  protected
    [Weak] FSocket: TBluetoothSocket;

    function DoConnect(const ATarget: string): Boolean; override;
    procedure DoDisconnect; override;

    function GetConnected: Boolean; override;
    function DoReadData: TBytes; override;
    procedure DoWriteData(const AData: TBytes); override;
    procedure DoReadStream(const AStream: TStream); override;
    procedure DoWriteStream(const AStream: TStream); override;
  public
    constructor Create(const ASocket: TBluetoothSocket = nil; ASecured: Boolean = False);
    destructor Destroy; override;
  end;

  TTetheringBTServerComm = class(TTetheringCustomServerComm)
  private const
    AcceptTimeout = 1000;
  public const
    /// <summary>A GUID mask to find main server socket.</summary>
    BTServerBaseUUID: TGUID = '{00000000-62AA-0000-BBBF-BF3E3BBB1374}';
  protected
    type
      TRegisteredServer = record
        FGUID: TGUID;
        FOnExecute: TServerCommExecuteEvent;
        FOnConnect: TServerCommConnectEvent;
        FOnDisconnect: TServerCommDisconnectEvent;
        FOnAfterReceiveData: TTetheringDataEvent;
        FOnBeforeSendData: TTetheringDataEvent;
        FOnAfterReceiveStream: TTetheringStreamEvent;
        FOnBeforeSendStream: TTetheringStreamEvent;
      end;
    /// <summary>A list with all registered servers.</summary>
    class var FRegisteredServers: TList<TRegisteredServer>;
  private type
    TBTCommThread = class(TThread)
    private
      FEvent: TEvent;
    protected
      [Weak] FServerComm: TTetheringBTServerComm;
      [Weak] FSocket: TBluetoothSocket;
      procedure Execute; override;
    public
      constructor Create(const AServerComm: TTetheringBTServerComm; const ASocket: TBluetoothSocket);
      destructor Destroy; override;
    End;

    TBTListenerThread = class(TThread)
    protected
      [Weak] FServerSocket: TBluetoothServerSocket;
      [Weak] FServerComm: TTetheringBTServerComm;
      procedure Execute; override;
    public
      constructor Create(const AServerComm: TTetheringBTServerComm; const AServerSocket: TBluetoothServerSocket);
      destructor Destroy; override;
    End;

  private
    function FindRegisteredServer(const AGUID: TGUID): Integer;
    procedure RegisterServer(const AGUID: TGUID);
    procedure UnRegisterServer(const AGUID: TGUID);
    class destructor Destroy;
    class constructor Create;
  protected
    class var FServerSocket: TBluetoothServerSocket;
    /// <summary>GUID of the bluetooth server socket.</summary>
    class var FGUIDServer: TGUID;
    class var FListener: TBTListenerThread;

    FGUID: TGUID;
    procedure SetTarget(const Value: string); override;
    function DoStartServer: Boolean; override;
    procedure DoStopServer; override;
  public
    constructor Create;
    destructor Destroy; override;
  end;
{$ENDIF BT_PLATFORM}

implementation

uses
  System.Tether.Consts, System.Tether.Manager, System.RegularExpressions, System.Rtti;

type
  TLogAdapter = class(TTetheringAdapter);


function CheckExceptionName(const E: Exception; const AName: string): Boolean;
var
  LClass: TClass;
begin
  LClass := E.ClassType;
  while LClass <> nil do
  begin
     if LClass.ClassNameIs(AName) then
       Break;
     LClass := LClass.ClassParent;
  end;
  Result := LClass <> nil;
end;


{ TTetheringCustomComm }

function TTetheringCustomComm.Connect(const ATarget: string): Boolean;
var
  Res: Boolean;
begin
  if (FTarget <> ATarget) or not Connected then
  begin
    if Connected then
      Disconnect;
    FTarget := ATarget;
    try
      Res := DoConnect(ATarget);
    except
      Res := False;
    end;
    Result := Res;
  end
  else
    Result := True;
end;

procedure TTetheringCustomComm.Disconnect;
begin
  try
    DoDisconnect;
  except
  end;
end;

function TTetheringCustomComm.ReadData: TBytes;
begin
  if Assigned(FOnAfterReceiveData) then
    Result := TBytes(FOnAfterReceiveData(Self, TByteDynArray(DoReadData)))
  else
    Result := DoReadData;
  if (Result <> nil) and TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('TTetheringCustomComm.ReadData: "' + TEncoding.UTF8.GetString(Result) + '"');
end;

procedure TTetheringCustomComm.ReadStream(const AStream: TStream);
var
  LStream: TStream;
begin
  if Assigned(FOnAfterReceiveStream) then
  begin
    LStream := TMemoryStream.Create;
    try
      DoReadStream(LStream);
      FOnAfterReceiveStream(Self, LStream, AStream);
    finally
      LStream.Free;
    end;
  end
  else
    DoReadStream(AStream);
end;

function TTetheringCustomComm.ReConnect: Boolean;
begin
  if Connected then
    Disconnect;
  Result := Connect(FTarget);
end;

procedure TTetheringCustomComm.WriteData(const AData: TBytes);
begin
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('TTetheringCustomComm.WriteData: "' + TEncoding.UTF8.GetString(AData) + '"');
  if Assigned(FOnBeforeSendData) then
    DoWriteData(TBytes(FOnBeforeSendData(Self, TByteDynArray(AData))))
  else
    DoWriteData(AData);
end;

procedure TTetheringCustomComm.WriteStream(const AStream: TStream);
var
  LStream: TStream;
begin
  if Assigned(FOnBeforeSendStream) then
  begin
    LStream := TMemoryStream.Create;
    try
      FOnBeforeSendStream(Self, AStream, LStream);
      DoWriteStream(LStream);
    finally
      LStream.Free;
    end;
  end
  else
    DoWriteStream(AStream);
end;

{ TTetheringNetworkComm }

constructor TTetheringNetworkComm.Create(const AIOHandler: IIPIOHandler; const ARemoteConnectionString: string; AIPVersion: TCommIPVersion);
begin
  inherited Create;
  FIPVersion := AIPVersion;
  FIOHandler := AIOHandler;
  FRemoteConnectionString := ARemoteConnectionString;
end;

destructor TTetheringNetworkComm.Destroy;
begin
  DoDisconnect;
  FTCPClient := nil;
  FIOHandler := nil;
  inherited;
end;

procedure TTetheringNetworkComm.DoDisconnect;
begin
  try
    if (FTCPClient <> nil) {and GetConnected} then
      FTCPClient.Disconnect;
  except
  end;
end;

function TTetheringNetworkComm.DoConnect(const ATarget: string): Boolean;
var
  Pos: Integer;
  LHost: string;
  LPort: Integer;
  LRttiContext: TRttiContext;
  LRttiType: TRttiType;
  LRttiProperty: TRttiProperty;
  Obj: TObject;
begin
  inherited;
  if FTCPClient = nil then
  begin
    FTCPClient := PeerFactory.CreatePeer('', IIPTCPClient, nil) as IIPTCPClient;
    FTCPClient.IPVersion := FIPVersion;
  end;

  // We set the ConnectTimeout of the TCPClient using Rtti
  Obj := FTCPClient.GetObject;
  LRttiContext := TRttiContext.Create;
  LRttiType := LRttiContext.GetType(Obj.ClassType);
  LRttiProperty := LRttiType.GetProperty('ConnectTimeout');
  LRttiProperty.SetValue(Obj, 5000);

  Pos := ATarget.IndexOf(TetheringConnectionSeparator);
  if Pos < 0 then
    raise ETetheringCommException.CreateFmt(SInvalidNetworkTargetFormat, [ATarget]);

  LHost := ATarget.Substring(0, Pos);
  LPort := ATarget.Substring(Pos + 1, Length(ATarget)).ToInteger;
  try
    if (FTCPClient.Host <> LHost) or (FTCPClient.Port <> LPort) then
    begin
      if GetConnected then
        FTCPClient.Disconnect;
      FTCPClient.Host := LHost;
      FTCPClient.Port := LPort;
      FTCPClient.Connect;
    end
    else
    begin
      if not GetConnected then
        FTCPClient.Connect;
    end;
    Result := GetConnected;
    FIOHandler := FTCPClient.IOHandler;
  except
    Result := False;
  end;
end;

function TTetheringNetworkComm.DoReadData: TBytes;
var
  BuffSize: Integer;
  MaxTimes: Integer;
begin
  MaxTimes := 0;
  while (FIOHandler <> nil) and (MaxTimes < ReadTimeout) and (FIOHandler.InputBuffer.Size = 0) do
  begin
    if FIOHandler.InputBuffer.Size = 0 then
      FIOHandler.CheckForDataOnSource(10);
    Inc(MaxTimes);
  end;

  if (FIOHandler <> nil) and (FIOHandler.InputBuffer.Size > 0) then
  begin
    BuffSize := FIOHandler.InputBuffer.Size;
    SetLength(Result, BuffSize);
    FIOHandler.ReadBytes(Result, BuffSize, False);
    if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
      TLogAdapter.Log('DoReadData(' + FRemoteConnectionString + '): "' + TEncoding.UTF8.GetString(Result) + '"');
  end
  else
    SetLength(Result, 0);
end;

procedure TTetheringNetworkComm.DoReadStream(const AStream: TStream);
begin
  if FIOHandler <> nil then
    FIOHandler.ReadStream(AStream);
end;

procedure TTetheringNetworkComm.DoWriteData(const AData: TBytes);
begin
  if FIOHandler <> nil then
  begin
    if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
      TLogAdapter.Log('DoWriteData(' + FRemoteConnectionString + '): "' + TEncoding.UTF8.GetString(AData) + '"');
    FIOHandler.Write(AData);
  end;
end;

procedure TTetheringNetworkComm.DoWriteStream(const AStream: TStream);
begin
  if FIOHandler <> nil then
    FIOHandler.Write(AStream, 0, True);
end;

function TTetheringNetworkComm.GetConnected: Boolean;
begin
  try
    if FTCPClient <> nil then
      Result := FTCPClient.Connected
    else if FIOHandler <> nil then
      Result := FIOHandler.Connected
    else
      Result := False;
  except
    DoDisconnect;
    Result := False;
  end;
end;

{ TTetheringCustomServerComm }

procedure TTetheringCustomServerComm.DoOnConnect(const AConnection: TTetheringCustomComm);
begin
  if Assigned(FOnConnect) then
    FOnConnect(AConnection);
end;

procedure TTetheringCustomServerComm.DoOnDisconnect(const AConnection: TTetheringCustomComm);
begin
  if Assigned(FOnDisconnect) then
    FOnDisconnect(AConnection);
end;

procedure TTetheringCustomServerComm.DoOnExecute(const AConnection: TTetheringCustomComm);
begin
  if Assigned(FOnExecute) then
    FOnExecute(AConnection);
end;

procedure TTetheringCustomServerComm.SetTarget(const Value: string);
begin
  FTarget := Value;
end;

procedure TTetheringCustomServerComm.StopServer;
begin
  if FActive then
  begin
    DoStopServer;
    FActive := False;
  end;
end;

function TTetheringCustomServerComm.StartServer: Boolean;
begin
  if not FActive then
    FActive := DoStartServer;
  Result := FActive;
end;


{ TTetheringNetworkServerComm }

constructor TTetheringNetworkServerComm.Create(AIPVersion: TCommIPVersion);
begin
  inherited Create;
  FIPVersion := AIPVersion;
  FContexts := TObjectDictionary<IIPContext, TTetheringNetworkComm>.Create([doOwnsValues]);
  FTCPServer := PeerFactory.CreatePeer('', IIPTCPServer, nil) as IIPTCPServer;
  FTCPServer.OnExecute := DoOnExecuteServer;
  FTCPServer.OnDisconnect := DoOnDisconnectServer;
  FTCPServer.OnConnect := DoOnConnectServer;
  FSocket := FTCPServer.Bindings.Add;
  FSocket.IPVersion := FIPVersion;
end;

destructor TTetheringNetworkServerComm.Destroy;
begin
  StopServer;
  inherited;
  FContexts.Free;
  FSocket := nil;
  FTCPServer := nil;
end;

function TTetheringNetworkServerComm.GetComm(const AContext: IIPContext): TTetheringNetworkComm;
var
  LConnectionString: string;
begin
  if not FContexts.TryGetValue(AContext, Result) then
  begin
    LConnectionString := AContext.Connection.Socket.Binding.PeerIP + TetheringConnectionSeparator +
      AContext.Connection.Socket.Binding.PeerPort.ToString;
    Result := TTetheringNetworkComm.Create(AContext.Connection.IOHandler, LConnectionString, FIPVersion);
    Result.OnAfterReceiveData := OnAfterReceiveData;
    Result.OnBeforeSendData := OnBeforeSendData;
    Result.OnAfterReceiveStream := OnAfterReceiveStream;
    Result.OnBeforeSendStream := OnBeforeSendStream;
    FContexts.Add(AContext, Result);
    if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
      TLogAdapter.Log('** -> TTetheringNetworkServerComm.GetComm(' + LConnectionString + ')');
  end;
end;

procedure TTetheringNetworkServerComm.SetTarget(const Value: string);
begin
  inherited;
  FSocket.Port := Value.ToInteger;
end;

procedure TTetheringNetworkServerComm.DoOnConnectServer(AContext: IIPContext);
begin
  DoOnConnect(GetComm(AContext));
end;

procedure TTetheringNetworkServerComm.DoOnDisconnectServer(AContext: IIPContext);
begin
  DoOnDisconnect(GetComm(AContext));
end;

procedure TTetheringNetworkServerComm.DoOnExecuteServer(AContext: IIPContext);
begin
  DoOnExecute(GetComm(AContext));
end;

procedure TTetheringNetworkServerComm.DoStopServer;
begin
  if FTCPServer <> nil then
    FTCPServer.Active := False;
end;

function TTetheringNetworkServerComm.DoStartServer: Boolean;
begin
  Result := True;
  try
    FTCPServer.Active := True;
  except
    // This is a non conventional method to catch an exception that is in a library that we do not want to have a dependency.
    // This is considered a HACK and not a good sample of programming techniques.
    // We are going to let this code handle the exceptions until we add a proper mechanism to propagate the
    // Indy exceptions through the IPPeerAPI in an ordered and safe manner.
    on E: Exception do
    begin
      Result := False;
      if not CheckExceptionName(E, 'EIdCouldNotBindSocket') then // Do not translate
        raise;
    end;
  end;
end;

{ TTetheringNetworkServerCommUDP }

constructor TTetheringNetworkServerCommUDP.Create(AIPVersion: TCommIPVersion);
begin
  inherited Create;
  FIPVersion := AIPVersion;
  FUDPServer := PeerFactory.CreatePeer('', IIPUDPServer, nil) as IIPUDPServer;
  FUDPServer.ThreadedEvent := True;
  FUDPServer.OnRead := DoUDPRead;
  FUDPServer.IPVersion := FIPVersion;
  FSocketUDP := FUDPServer.Bindings.Add;
  FSocketUDP.IPVersion := FIPVersion;
end;

destructor TTetheringNetworkServerCommUDP.Destroy;
begin
  StopServer;
  inherited;
  FSocketUDP := nil;
  FUDPServer := nil;
end;

procedure TTetheringNetworkServerCommUDP.BroadcastData(const AData: TBytes; const AHost: string;
  InitialPort, FinalPort: Integer);
var
  I: Integer;
  LHost: string;
begin
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('** UDP ** BroadcastData to "' + AHost + '":  "' + TEncoding.UTF8.GetString(AData) + '"');
  if AHost = '' then
  begin
    if FIPVersion = TCommIPVersion.IP_IPv4 then
      LHost := '255.255.255.255'
    else
      LHost := '0:0:0:0:0:0:255.255.255.255';

    for I := InitialPort to FinalPort do
      FUDPServer.Broadcast(AData, I, LHost)
  end
  else
    for I := InitialPort to FinalPort do
      FUDPServer.SendBuffer(AHost, I, AData);
end;

function TTetheringNetworkServerCommUDP.DoStartServer: Boolean;
begin
  Result := True;
  try
    FUDPServer.Active := True;
  except
    // This is a non conventional method to catch an exception that is in a library that we do not want to have a dependency.
    // This is considered a HACK and not a good sample of programming techniques.
    // We are going to let this code handle the exceptions until we add a proper mechanism to propagate the
    // Indy exceptions through the IPPeerAPI in an ordered and safe manner.
    on E: Exception do
    begin
      Result := False;
      if not CheckExceptionName(E, 'EIdCouldNotBindSocket') then // Do not translate
        raise;
    end;
  end;
end;

procedure TTetheringNetworkServerCommUDP.DoStopServer;
begin
  if FUDPServer <> nil then
    FUDPServer.Active := False;
end;

procedure TTetheringNetworkServerCommUDP.DoUDPRead(AThread: IIPUDPListenerThread; const AData: TIPBytesPeer;
  ABinding: IIPSocketHandle);
var
  LConnection: string;
begin
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('IN -> DoUDPRead "' + ABinding.PeerIP + '":  "' + TEncoding.UTF8.GetString(AData) + '"');
  if Assigned(FOnUDPData) and (Length(AData) > 0) then
  begin
    LConnection := ABinding.PeerIP + TetheringConnectionSeparator + ABinding.PeerPort.ToString;
    FOnUDPData(LConnection, AData);
  end;
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('OUT -> DoUDPRead "' + LConnection + '":  "' + TEncoding.UTF8.GetString(AData) + '"');
end;

function TTetheringNetworkServerCommUDP.GetUDPPort: Integer;
begin
  Result := FSocketUDP.Port;
end;

procedure TTetheringNetworkServerCommUDP.SetTarget(const Value: string);
begin
  inherited;
  FSocketUDP.Port := Value.ToInteger;
end;

{ TTetheringNetworkServerCommMulticast }

constructor TTetheringNetworkServerCommMulticast.Create(AIPVersion: TCommIPVersion);
begin
  inherited Create;
  FIPVersion := AIPVersion;
  FMulticastServer := PeerFactory.CreatePeer('', IIPMulticastServer, nil) as IIPMulticastServer;
  FMulticastServer.IPVersion := FIPVersion;

  FMulticastClient := PeerFactory.CreatePeer('', IIPMulticastClient, nil) as IIPMulticastClient;
  FMulticastClient.IPVersion := FIPVersion;
  FMulticastClient.ThreadedEvent := True;
  FMulticastClient.OnMulticast := DoMulticastRead;

  FMulticastServer.MulticastGroup := TetheringMulticastGroup[FIPVersion];
  FMulticastClient.MulticastGroup := TetheringMulticastGroup[FIPVersion];
end;

destructor TTetheringNetworkServerCommMulticast.Destroy;
begin
  FMulticastClient := nil;
  FMulticastServer := nil;
  inherited;
end;

procedure TTetheringNetworkServerCommMulticast.DoMulticastRead(Sender: TObject; const AData: TIPBytesPeer;
  const ABinding: IIPSocketHandle);
var
  LConnection: string;
begin
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('IN  -> DoMulticastRead "' + ABinding.PeerIP  + TetheringConnectionSeparator +
      ABinding.PeerPort.ToString + '":  "' + TEncoding.UTF8.GetString(AData) + '"');
  if Assigned(FOnMulticastData) and (Length(AData) > 0) then
  begin
    LConnection := ABinding.PeerIP + TetheringConnectionSeparator + ABinding.PeerPort.ToString;
    FOnMulticastData(LConnection, AData);
  end;
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('OUT -> DoMulticastRead "' + LConnection + '":  "' + TEncoding.UTF8.GetString(AData) + '"');
end;

function TTetheringNetworkServerCommMulticast.DoStartServer: Boolean;
begin
  Result := True;
  try
    FMulticastServer.Active := True;
    FMulticastClient.Active := True;
  except
    // This is a non conventional method to catch an exception that is in a library that we do not want to have a dependency.
    // This is considered a HACK and not a good sample of programming techniques.
    // We are going to let this code handle the exceptions until we add a proper mechanism to propagate the
    // Indy exceptions through the IPPeerAPI in an ordered and safe manner.
    on E: Exception do
    begin
      Result := False;
      FMulticastClient.Active := False;
      FMulticastServer.Active := False;
      if not CheckExceptionName(E, 'EIdCouldNotBindSocket') then // Do not translate
        raise;
    end;
  end;
end;

procedure TTetheringNetworkServerCommMulticast.DoStopServer;
begin
  if FMulticastServer <> nil then
    FMulticastServer.Active := False;
  if FMulticastClient <> nil then
    FMulticastClient.Active := False;
end;

function TTetheringNetworkServerCommMulticast.GetMulticastPort: Integer;
begin
  Result := FMulticastServer.Port;
end;

procedure TTetheringNetworkServerCommMulticast.MulticastData(const AData: TBytes; const AHost: string; InitialPort,
  FinalPort: Integer);
var
  I: Integer;
begin
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Comm) then
    TLogAdapter.Log('MulticastData to "' + AHost + '":  "' + TEncoding.UTF8.GetString(AData) + '"');
  if AHost = '' then
  begin
    if FMulticastServer.MulticastGroup <> TetheringMulticastGroup[FIPVersion] then
      FMulticastServer.MulticastGroup := TetheringMulticastGroup[FIPVersion];
  end
  else
    FMulticastServer.MulticastGroup := AHost;

  for I := InitialPort to FinalPort do
    FMulticastServer.Send(TIPBytesPeer(AData), I);
end;

procedure TTetheringNetworkServerCommMulticast.SetTarget(const Value: string);
begin
  inherited;
  FMulticastServer.Port := Value.ToInteger;
  FMulticastClient.DefaultPort := Value.ToInteger;
end;

{$IFDEF BT_PLATFORM}
type
  TRedirectedServer = class(TThread)
  private
    FSecured: Boolean;
    FGUID: TGUID;
    FThreadComm: TTetheringBTServerComm.TBTCommThread;
    [Weak] FServerComm: TTetheringBTServerComm;
    FSyncEvent: TEvent;
    FServerSocket: TBluetoothServerSocket;
  protected
    procedure Execute; override;
    procedure TerminatedSet; override;
  public
    constructor Create(const AServerComm: TTetheringBTServerComm; const AGUID: TGUID; Secured: Boolean);
    destructor Destroy; override;
    function  WaitInitialization: Boolean;
  End;


{ TTetheringBTComm }

function TTetheringBTComm.AvailableData: Boolean;
begin
  if Length(FInternalBuffer) > 0 then
    Exit(True);

  if FSocket <> nil then
  begin
    TMonitor.Enter(FBufferLock);
    try
      try
        FInternalBuffer := FSocket.ReceiveData(ReadTimeout);
      except
        ReConnect;
        if FSocket <> nil then
          FInternalBuffer := FSocket.ReceiveData(ReadTimeout)
        else
          raise ETetheringCommException.CreateFmt(SNoConnections, [FTarget]);
      end;
    finally
      TMonitor.Exit(FBufferLock);
    end;
  end;
  Result := Length(FInternalBuffer) > 0;
end;

constructor TTetheringBTComm.Create(const ASocket: TBluetoothSocket; ASecured: Boolean);
begin
  FSocket := ASocket;
  FSecured := ASecured;
  FBufferLock := TObject.Create;
end;

destructor TTetheringBTComm.Destroy;
begin
  if FInternalSocket <> nil then
    FInternalSocket.Free;
  FBufferLock.Free;
  inherited;
end;

function TTetheringBTComm.DoConnect(const ATarget: string): Boolean;
type
  TConnectState = (Ok, Error, NotFound);

var
  LResult: Boolean;
begin
  TThread.Synchronize(nil, procedure

    function IsTTetheringBTBase(AGUID: TGUID): Boolean;
    const
      TTetheringBTBaseUUID: TGUID = '{00000000-62AA-0000-BBBF-BF3E3BBB1374}';
    begin
      AGUID.D1 := 0;
      AGUID.D3 := 0;

      Result := AGUID = TTetheringBTBaseUUID;

      if not Result then
      begin
        AGUID.D2 := AGUID.D2 - $11;
        Result := AGUID = TTetheringBTBaseUUID;
      end;
      if not Result then
      begin
        AGUID.D2 := AGUID.D2 - $11;
        Result := AGUID = TTetheringBTBaseUUID;
      end;
      if not Result then
      begin
        AGUID.D2 := AGUID.D2 - $11;
        Result := AGUID = TTetheringBTBaseUUID;
      end;
    end;


    function ConnectToService(const AGUIDService: TGUID; const AGUIDDestination: TGUID; var ASocket: TBluetoothSocket;
      const ADevice:TBluetoothDevice): TConnectState;
    var
      I: Integer;
      LBuffer: TBytes;
      Response: string;
    begin
      for I := 0 to 1 do // 2 retries
      begin
        try     // Create socket to BT Server
          ASocket := ADevice.CreateClientSocket(AGUIDService, FSecured);
          ASocket.Connect;
          Break;
        except
          on E: Exception do
          begin
            if ASocket <> nil then
              ASocket.Close;
            Exit(Error);
          end;
        end;
        Sleep(15);
      end;
      // Send to which virtual server I want to connect
      ASocket.SendData(TEncoding.UTF8.GetBytes(AGUIDDestination.ToString));
      for I := 0 to 1 do // 2 retries
      begin
        try
          LBuffer := ASocket.ReceiveData(ReadTimeout);
        except
        end;
        if Length(LBuffer) > 0 then
          Break;
      end;
      if (Length(LBuffer) > 0) then
        Response := TEncoding.UTF8.GetString(LBuffer);
      if (Length(LBuffer) = 0) or (Response <> 'ok') then
      begin
        ASocket.Close;
        ASocket := nil;
        if Response = 'not found' then
          Result := NotFound
        else
          Result := Error;
      end
      else
        Result := Ok;
    end;

  var
    Pos: Integer;
    LDeviceName: string;
    LService: TBluetoothService;
    LGUID: TGUID;
    LGUIDService: TGUID;
    LGUIDTranslated: TGUID;
    LBuffer: TBytes;
    LSocket: TBluetoothSocket;
    I: Integer;
    LText: string;
    LState: TConnectState;
    LDevice: TBluetoothDevice;
  begin

  inherited;
  Pos := ATarget.IndexOf(TetheringConnectionSeparator);
  if Pos < 0 then
    raise ETetheringCommException.CreateFmt(SInvalidBluetoothTargetFormat, [ATarget]);

  LDeviceName := ATarget.Substring(0, Pos);
  LGUIDService := LGUID.Create(ATarget.Substring(Pos + 1, Length(ATarget)));
  LResult := False;
  FSocket := nil;
  for LDevice in TBluetoothManager.Current.LastPairedDevices do
    if SameText(LDevice.Address, LDeviceName) or SameText(LDevice.DeviceName, LDeviceName) then
    begin
      if IsTTetheringBTBase(LGUIDService) then
      begin
        if LGUIDService.D2 = $62AA then // It's a main Server GUID
        begin
          for I := 0 to 2 do // 3 retries
          begin
            LState := ConnectToService(LGUIDService, LGUIDService, FInternalSocket, LDevice);
            if LState = Error then
              Sleep(30)
            else if LState = NotFound then
              Break
            else
            begin
              FSocket := FInternalSocket;
              LResult := True;
              Break;
            end;
          end;
          Break;
        end
        else
        begin
          // Search main Server GUID
          for LService in LDevice.GetServices do
          begin
            LGUID := LService.UUID;
            LGUID.D1 := 0;
            LGUID.D3 := 0;
            if LGUID = TTetheringBTServerComm.BTServerBaseUUID then
            begin
              LSocket := nil;
              for I := 0 to 2 do // 3 retries
              begin
                LState := ConnectToService(LService.UUID, LGUIDService, LSocket, LDevice);
                if LState = Error then
                  Sleep(30)
                else
                  Break;
              end;
              if LSocket <> nil then
              begin
                for I := 0 to 2 do // 3 retries
                begin
                  try
                    LBuffer := LSocket.ReceiveData(ReadTimeout);
                  except
                  end;
                  if Length(LBuffer) > 0 then
                    Break;
                end;
                LText:= TEncoding.UTF8.GetString(LBuffer);
                if LText <> 'error' then
                begin
                  try
                    LSocket.SendData(TEncoding.UTF8.GetBytes('ok, redirected readed'));
                  except
                  end;
                  LSocket.Close;
                  LSocket.Free;
                  LGUIDTranslated := TGUID.Create(TEncoding.UTF8.GetString(LBuffer));
                  if FInternalSocket <> nil then
                    FInternalSocket.Free;
                  FInternalSocket := LDevice.CreateClientSocket(LGUIDTranslated, FSecured);
                  FSocket := FInternalSocket;
                  Break;
                end;
              end;
            end;
          end;

          // Now try to read redirected server and connect to it
          if FSocket <> nil then
          begin
            try
              FSocket.Connect;
              LResult := True;
            except
              LResult := False;
            end;
          end
          else
            LResult := False;
        end;
      end
      else
      begin  // direct cConnect(not used)
        if FInternalSocket <> nil then
          FInternalSocket.Free;
        FInternalSocket := LDevice.CreateClientSocket(LGUID, FSecured);
        FSocket := FInternalSocket;
        if FSocket <> nil then
        begin
          try
            FSocket.Connect;
            LResult := True;
          except
            LResult := False;
          end;
        end
        else
          LResult := False;


      end;

      Break;
    end;

  end);

  Result := LResult;
end;

procedure TTetheringBTComm.DoDisconnect;
begin
  if FSocket <> nil then
  begin
    FSocket.Close;
    FSocket := nil;
  end;
  if FInternalSocket <> nil then
    FreeAndNil(FInternalSocket);
end;

function TTetheringBTComm.DoReadData: TBytes;
begin
  TMonitor.Enter(FBufferLock);
  try
    if (Length(FInternalBuffer) = 0) and (FSocket <> nil) then

    try
      FInternalBuffer := FSocket.ReceiveData(ReadTimeout);
    except
      ReConnect;
      if FSocket <> nil then
        FInternalBuffer := FSocket.ReceiveData(ReadTimeout)
      else
        raise ETetheringCommException.CreateFmt(SNoConnections, [FTarget]);
    end;

    Result := InternalReadData;
  finally
    TMonitor.Exit(FBufferLock);
  end;
end;

function TTetheringBTComm.InternalReadData: TBytes;
var
  BufferLength: Integer;
  TempBuff: TBytes;
begin
  if Length(FInternalBuffer) > 0 then
  begin
    BufferLength := PInteger(@FInternalBuffer[0])^;

    if BufferLength <= 0 then
    begin
      SetLength(FInternalBuffer, 0);
      SetLength(Result, 0);
    end
    else
    begin
      while Length(FInternalBuffer) - SizeOf(Integer) < BufferLength do // Need more data from socket
      begin
        try
          TempBuff := FSocket.ReceiveData(ReadTimeout);
        except
          ReConnect;
          if FSocket <> nil then
            TempBuff := FSocket.ReceiveData(ReadTimeout)
          else
            raise ETetheringCommException.CreateFmt(SNoConnections, [FTarget]);
        end;
        FInternalBuffer := FInternalBuffer + TempBuff;
      end;

      Result := Copy(FInternalBuffer, SizeOf(Integer), BufferLength);
      if Length(FInternalBuffer) - (BufferLength + SizeOf(Integer)) <= 0 then
        SetLength(FInternalBuffer, 0)
      else
        FInternalBuffer := Copy(FInternalBuffer, BufferLength + SizeOf(Integer),
          Length(FInternalBuffer) - (BufferLength + SizeOf(Integer)));
    end;
  end
  else
    SetLength(Result, 0);
end;

procedure TTetheringBTComm.DoReadStream(const AStream: TStream);
var
  Buffer: TBytes;
begin
  Buffer := DoReadData;
  AStream.Write(Buffer, 0, Length(Buffer));
end;

procedure TTetheringBTComm.DoWriteData(const AData: TBytes);
var
  B: TBytes;
  L: Integer;
begin
  if FSocket <> nil then
  begin
    L := Length(AData);
    if L >= 0 then
    begin
      SetLength(B, SizeOf(Integer));
      PInteger(@B[0])^ := L;
      try
        FSocket.SendData(B + AData);
      except
        ReConnect;
        if FSocket <> nil then
          FSocket.SendData(B + AData)
        else
          raise ETetheringCommException.CreateFmt(SNoConnections, [FTarget]);
      end;
    end;
  end;
end;

procedure TTetheringBTComm.DoWriteStream(const AStream: TStream);
const
  BuffSize = 8192;
var
  Buffer: TBytes;
  Readed: Integer;
  L: Integer;
begin
  L := AStream.Size;
  if L >= 0 then
  begin
    SetLength(Buffer, BuffSize);
    Buffer[0] := LongRec(L).Bytes[0];
    Buffer[1] := LongRec(L).Bytes[1];
    Buffer[2] := LongRec(L).Bytes[2];
    Buffer[3] := LongRec(L).Bytes[3];

    Readed := AStream.Read(@Buffer[4], 0, Length(Buffer) - SizeOf(Integer));
    try
      FSocket.SendData(Buffer);
    except
      ReConnect;
      if FSocket <> nil then
        FSocket.SendData(Buffer)
      else
        raise ETetheringCommException.CreateFmt(SNoConnections, [FTarget]);
    end;

    if Readed = Length(Buffer) - SizeOf(Integer) then
      repeat
        Readed := AStream.Read(Buffer, 0, Length(Buffer));
        SetLength(Buffer, Readed);
        try
          FSocket.SendData(Buffer);
        except
          ReConnect;
          if FSocket <> nil then
            FSocket.SendData(Buffer)
          else
            raise ETetheringCommException.CreateFmt(SNoConnections, [FTarget]);
        end;
      until Readed < BuffSize;
  end;
end;

function TTetheringBTComm.GetConnected: Boolean;
begin
  if FSocket <> nil then
    Result := FSocket.Connected
  else
    Result := False;
end;


{ TTetheringBTServerComm }

constructor TTetheringBTServerComm.Create;
begin
  inherited;
end;

class constructor TTetheringBTServerComm.Create;
begin
  FRegisteredServers := TList<TRegisteredServer>.Create;
end;

destructor TTetheringBTServerComm.Destroy;
begin
  inherited;
end;

class destructor TTetheringBTServerComm.Destroy;
begin
  FRegisteredServers.Free;
  if FServerSocket <> nil then
    FServerSocket.Close;
  if FListener <> nil then
    FListener.Free;
  if FServerSocket <> nil then
    FServerSocket.Free;
end;

function TTetheringBTServerComm.DoStartServer: Boolean;
begin
  Result := True;
  // Create a Unique Server to manage connections
  if FListener = nil then
  begin
    try
      FGUIDServer := BTServerBaseUUID;
      FGUIDServer.D1 := Cardinal(Pointer(Self));
      FGUIDServer.D3 := Random(65535);
      FServerSocket := TBluetoothManager.Current.CreateServerSocket('BTServer_' + FGUIDServer.ToString, FGUIDServer, FSecured);
      if FServerSocket <> nil then
      begin
        FListener := TBTListenerThread.Create(Self, FServerSocket);
        FListener.Start;
      end
      else
        Result := False;
    except
      Result := False;
    end;
  end;
  if Result then
    RegisterServer(FGUID);
end;

procedure TTetheringBTServerComm.DoStopServer;
begin
  UnRegisterServer(FGUID);
end;

function TTetheringBTServerComm.FindRegisteredServer(const AGUID: TGUID): Integer;
var
  I: Integer;
begin
  Result := -1;
  if FRegisteredServers <> nil then
    for I := 0 to FRegisteredServers.Count - 1 do
      if FRegisteredServers[I].FGUID = AGUID then
        Exit(I);
end;

procedure TTetheringBTServerComm.RegisterServer(const AGUID: TGUID);
var
  LRegisteredServer: TRegisteredServer;
begin
  if FindRegisteredServer(AGUID) < 0 then
  begin
    LRegisteredServer.FGUID := AGUID;
    LRegisteredServer.FOnExecute := FOnExecute;
    LRegisteredServer.FOnConnect := FOnConnect;
    LRegisteredServer.FOnDisconnect := FOnDisconnect;
    LRegisteredServer.FOnAfterReceiveData := FOnAfterReceiveData;
    LRegisteredServer.FOnBeforeSendData := FOnBeforeSendData;
    LRegisteredServer.FOnAfterReceiveStream := FOnAfterReceiveStream;
    LRegisteredServer.FOnBeforeSendStream := FOnBeforeSendStream;

    FRegisteredServers.Add(LRegisteredServer);
  end;
end;

procedure TTetheringBTServerComm.SetTarget(const Value: string);
begin
  inherited;
  FGUID := FGUID.Create(Value);
end;

procedure TTetheringBTServerComm.UnRegisterServer(const AGUID: TGUID);
var
  LIndex: Integer;
begin
  LIndex := FindRegisteredServer(AGUID);
  if LIndex >= 0 then
    FRegisteredServers.Delete(LIndex);
end;

{ TTetheringBTServerComm.TBTListenerThread }

constructor TTetheringBTServerComm.TBTListenerThread.Create(const AServerComm: TTetheringBTServerComm;
  const AServerSocket: TBluetoothServerSocket);
begin
  inherited Create(True);
  FServerSocket := AServerSocket;
  FServerComm := AServerComm;
end;

destructor TTetheringBTServerComm.TBTListenerThread.Destroy;
begin
  inherited;
//  FServerSocket.Close;
end;

procedure TTetheringBTServerComm.TBTListenerThread.Execute;
var
  LSocket: TBluetoothSocket;
  LGUID: TGUID;
  LGUIDToConnect: TGUID;
  LNewServer: TRedirectedServer;
  LServerList: TObjectList<TRedirectedServer>;
  LBuff: TBytes;
  RegisteredServers: string;
  I: Integer;
  LTempClient: TTetheringBTComm;

  procedure CleanRedirectedServers;
  var
    I: Integer;
  begin
    for I := LServerList.Count - 1 downto 0 do
      if LServerList[I].Finished then
        LServerList.Delete(I);
    if LServerList.Count > 2 then //Only 2 servers working at same time
      LServerList.Delete(0);
  end;

begin
  inherited;
  LServerList := TObjectList<TRedirectedServer>.Create;
  try
    while not Terminated and (FServerSocket <> nil) do
    begin
      LSocket := FServerSocket.Accept(AcceptTimeout);
      if (not Terminated) and (LSocket <> nil) then
      begin
        try
          // Read the server that the client wants to connect
          try
            LBuff := LSocket.ReceiveData(TTetheringBTComm.ReadTimeout);
          except
          end;
          if Length(LBuff)> 0 then
          begin
            try
              LGUIDToConnect := FGUID.Create(TEncoding.UTF8.GetString(LBuff));
            except
            end;
            if LGUIDToConnect = FServerComm.FGUIDServer then  // Connect to BT Server (self), so returns registered servers
            begin
              try
                LSocket.SendData(TEncoding.UTF8.GetBytes('ok'));
              except
              end;
              RegisteredServers := '';
              for I := 0 to FServerComm.FRegisteredServers.Count - 1 do
                RegisteredServers := RegisteredServers + FServerComm.FRegisteredServers.Items[I].FGUID.ToString + TetheringConnectionSeparator;
              try
                LTempClient := TTetheringBTComm.Create(LSocket);
                LTempClient.WriteData(TEncoding.UTF8.GetBytes(RegisteredServers));
                LTempClient.Free;
                //LSocket.SendData(TEncoding.UTF8.GetBytes(RegisteredServers));
              except
              end;
              try
                LSocket.ReceiveData(TTetheringBTComm.ReadTimeout); //wait until data is readed in the other end
              except
              end;
            end
            else if FServerComm.FindRegisteredServer(LGUIDToConnect) >= 0 then
            begin
              try
                LSocket.SendData(TEncoding.UTF8.GetBytes('ok'));
              except
              end;
              LGUID := TGUID.NewGuid;
              LGUID.D2 := $62FF;
              I := FServerComm.FindRegisteredServer(LGUIDToConnect);
              FServerComm.FOnExecute := FServerComm.FRegisteredServers[I].FOnExecute;
              FServerComm.FOnConnect := FServerComm.FRegisteredServers[I].FOnConnect;
              FServerComm.FOnDisconnect := FServerComm.FRegisteredServers[I].FOnDisconnect;
              FServerComm.FOnAfterReceiveData := FServerComm.FRegisteredServers[I].FOnAfterReceiveData;
              FServerComm.FOnBeforeSendData := FServerComm.FRegisteredServers[I].FOnBeforeSendData;
              FServerComm.FOnAfterReceiveStream := FServerComm.FRegisteredServers[I].FOnAfterReceiveStream;
              FServerComm.FOnBeforeSendStream := FServerComm.FRegisteredServers[I].FOnBeforeSendStream;
              try
                LNewServer := TRedirectedServer.Create(FServerComm, LGUID, FServerComm.FSecured);
                if LNewServer <> nil then
                begin
                  LNewServer.Start;
                  LServerList.Add(LNewServer);
                  if LNewServer.WaitInitialization then
                    LSocket.SendData(TEncoding.UTF8.GetBytes(LGUID.ToString))
                  else
                    LSocket.SendData(TEncoding.UTF8.GetBytes('error'));
                end
                else
                  LSocket.SendData(TEncoding.UTF8.GetBytes('error'));
              except
                LSocket.SendData(TEncoding.UTF8.GetBytes('error'));
              end;
            end
            else
            begin
              LSocket.SendData(TEncoding.UTF8.GetBytes('not found'));
              try
                LSocket.ReceiveData(TTetheringBTComm.ReadTimeout); //wait until socket is closed in the other end
              except
              end;
            end;
          end;
        finally
          LSocket.Close;
          LSocket.Free;
        end;
      end
      else
        CleanRedirectedServers;
    end;
  finally
    LServerList.Free;
  end;
end;

{ TTetheringBTServerComm.TBTCommThread }

constructor TTetheringBTServerComm.TBTCommThread.Create(const AServerComm: TTetheringBTServerComm; const ASocket: TBluetoothSocket);
begin
  inherited Create(True);
  FServerComm := AServerComm;
  FSocket := ASocket;
  FEvent := TEvent.Create;
end;

destructor TTetheringBTServerComm.TBTCommThread.Destroy;
begin
  inherited;
  FEvent.Free;
end;

procedure TTetheringBTServerComm.TBTCommThread.Execute;
var
  LConnection: TTetheringBTComm;
begin
  inherited;

  LConnection := TTetheringBTComm.Create(FSocket, FServerComm.FSecured);
  try
    LConnection.OnAfterReceiveData := FServerComm.OnAfterReceiveData;
    LConnection.OnBeforeSendData := FServerComm.OnBeforeSendData;
    LConnection.OnAfterReceiveStream := FServerComm.OnAfterReceiveStream;
    LConnection.OnBeforeSendStream := FServerComm.OnBeforeSendStream;

    FServerComm.DoOnConnect(LConnection);
    try
      while not Terminated and (FSocket <> nil) do
      begin
        if LConnection.AvailableData and not Terminated then
          FServerComm.DoOnExecute(LConnection);
      end;
    except
    end;
    if not Terminated then
      FServerComm.DoOnDisconnect(LConnection);
  finally
    LConnection.Free;
  end;
  FEvent.SetEvent;
end;

{ TRedirectedServer }

constructor TRedirectedServer.Create(const AServerComm: TTetheringBTServerComm; const AGUID: TGUID; Secured: Boolean);
begin
  inherited Create(True);
  FGUID := AGUID;
  FSecured := Secured;
  FServerComm := AServerComm;
  FSyncEvent := TEvent.Create;
end;

destructor TRedirectedServer.Destroy;
begin
  FSyncEvent.Free;
  if FThreadComm <> nil then
    FThreadComm.Terminate;
  inherited;
  FServerSocket.Free;
end;

procedure TRedirectedServer.Execute;
const
  CountTimeOut = 10000 div TTetheringBTServerComm.AcceptTimeout;  // 10 secs timeout
var
  LoopCount: Integer;
  LSocket: TBluetoothSocket;
  I: Integer;
begin
  inherited;
  for I := 0 to 2 do
  begin
    try
      FServerSocket := TBluetoothManager.Current.CreateServerSocket('Redirected_' + FGUID.ToString, FGUID, FSecured);
      if FServerSocket <> nil then
        Break;
    except
      FServerSocket := nil;
    end;
  end;
  if FServerSocket <> nil then
  begin
    LoopCount := 0;
    FSyncEvent.SetEvent;
    while not Terminated do
    begin
      LSocket := FServerSocket.Accept(TTetheringBTServerComm.AcceptTimeout);
      if not Terminated and (LSocket <> nil) then
      begin
        FThreadComm := TTetheringBTServerComm.TBTCommThread.Create(FServerComm, LSocket);
        FThreadComm.Start;
        FThreadComm.FEvent.WaitFor(INFINITE);
        LSocket.Close;
        LSocket.Free;
        FThreadComm.DisposeOf;
        FThreadComm := nil;
        Break;
      end
      else
      begin
        if LoopCount > CountTimeOut then //It's a RedirectedServer so if no one connect in 10 secs I close it to release the channel
          Break;
        Inc(LoopCount);
      end;
    end;
  end;
end;

procedure TRedirectedServer.TerminatedSet;
begin
  inherited;
  if FServerSocket <> nil then
    FServerSocket.Close;
end;

function  TRedirectedServer.WaitInitialization: Boolean;
begin
  Result := FSyncEvent.WaitFor(1500) = wrSignaled;
end;

{$ENDIF BT_PLATFORM}

end.


