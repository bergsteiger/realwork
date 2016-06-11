{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSTCPServerTransport;

interface

uses
  System.Classes,
  Data.DBXTransport,
  Datasnap.DSAuth,
  Datasnap.DSCommonServer,
  Datasnap.DSTransport,
  IPPeerAPI,
  System.SysUtils;

type

  TDSTCPChannel = class(TDBXChannel)
  strict private
    FContext: IIPContext;
    FChannelInfo: TDBXSocketChannelInfo;
    FReadBuffer: TArray<Byte>;
    FConnectionLost: Boolean;
    FSessionId: string;
  protected
    function IsConnectionLost: Boolean; override;
    function GetChannelInfo: TDBXChannelInfo; override;
  public
    constructor Create(AContext: IIPContext);
    destructor Destroy; override;
    procedure Open; override;
    procedure Close; override;
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;

    /// <summary>Enables KeepAlive for this channel's socket connection.</summary>
    /// <remarks>If the channel is idle for longer than KeepAliveTime, then a KeepAlive packet is sent and
    ///          a response is waited for for the given interval, before terminating the connection.
    ///          The number of keep-alive packet retries is OS specific and can't be specified here.
    /// </remarks>
    /// <param name="KeepAliveTime">The idle time in milliseconds before sending a keep-alive packet.</param>
    /// <param name="KeepAliveInterval">How long to wait in milliseconds before sending successive
    ///                                 keep-alive packets when the previous one receives no response.</param>
    function EnableKeepAlive(KeepAliveTime: Integer; KeepAliveInterval: Integer = 100): Boolean;
    /// <summary>Disables keep-alive packets for the channel's connection.</summary>
    procedure DisableKeepAlive;

    /// <summary>Returns the connection object for this channel if one is available.</summary>
    /// <remarks>This is generally an instance of TIdTCPConnection.</remarks>
    function GetConnection: TObject;

    /// <summary>Returns the session ID for the channel.</summary>
    /// <remarks>This will not be populated until a Read has been made.</remarks>
    property SessionId: string read FSessionId;
  end;

  /// <summary>Event for TCP connections being established.</summary>
  TDSTCPConnectEventObject = record
  private
    FConnection: TObject;
    FChannel: TDSTCPChannel;
  public
    /// <summary>Creates a new instance of TDSTCPConnectEventObject, setting the proper fields.</summary>
    constructor Create(AConnection: TObject; AChannel: TDSTCPChannel);

    /// <summary>The underlying connection. Generally an instance of TIdTCPConnection.</summary>
    property Connection: TObject read FConnection;
    /// <summary>The channel wrapping the connection</summary>
    property Channel: TDSTCPChannel read FChannel;
  end;

  /// <summary>Event for TCP connections being closed.</summary>
  TDSTCPDisconnectEventObject = record
  private
    FConnection: TObject;
  public
    /// <summary>Creates a new instance of TDSTCPDisconnectEventObject.</summary>
    constructor Create(AConnection: TObject);

    /// <summary>The underlying connection. Generally an instance of TIdTCPConnection.</summary>
    property Connection: TObject read FConnection;
  end;

  ///<summary>
  ///  Event for TCP connections being established.
  ///</summary>
  TDSTCPConnectEvent = procedure(Event: TDSTCPConnectEventObject) of object;

  ///<summary>
  ///  Event for TCP connections being closed.
  ///</summary>
  TDSTCPDisconnectEvent = procedure(Event: TDSTCPDisconnectEventObject) of object;

  /// <summary>The enablement options for KeepAlive.</summary>
  TDSKeepAliveEnablement = (kaDefault, kaEnabled, kaDisabled);

  /// <summary>Socket-based transport for a TDSServer server.</summary>
  TDSTCPServerTransport = class(TDSServerTransport)
  strict private
    FPort: Integer;
    FMaxThreads: Integer;
    FPoolSize: Integer;
    FProtocolHandlerFactory:   TDSJSONProtocolHandlerFactory;
    FAuthenticationManager: TDSCustomAuthenticationManager;
    FTDSTCPConnectEvent: TDSTCPConnectEvent;
    FTDSTCPDisconnectEvent: TDSTCPDisconnectEvent;
    FKeepAliveEnablement: TDSKeepAliveEnablement;
    FKeepAliveTime: Integer;
    FKeepAliveInterval: Integer;
    procedure DoOnConnect(AContext: IIPContext);
    procedure DoOnDisconnect(AContext: IIPContext);
    procedure DoOnExecute(AContext: IIPContext);
  protected
    FTcpServer: IIPTCPServer;
    class function GetTcpChannel(
      AConnectionHandler: TDSServerConnectionHandler): TDBXChannel; static;
    function CreateTcpServer: IIPTCPServer; virtual;
    function CreateTcpChannel(AContext: IIPContext): TDBXChannel; virtual;
    procedure SetServer(const AServer: TDSCustomServer); override;
    procedure SetAuthenticationManager(const AuthManager: TDSCustomAuthenticationManager);
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure SetIPImplementationID(const AIPImplementationID: string); override;
  public
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;
    ///<summary>
    ///  Called by the server when it is starting.
    ///</summary>
    procedure Start; override;
    ///<summary>
    ///  Called by the server when it is stoping.
    ///</summary>
    procedure Stop; override;
  published
    ///<summary>
    ///  TCP/IP server side port.  Defaults to 211.
    ///</summary>
    [Default(211)]
    property Port: Integer read FPort write FPort default 211;
    ///<summary>
    ///  Maximum amount of threads allowed in the scheduler. No limit is imposed on thread pool size if set to 0.
    ///  Must be set before server is started.
    ///  Defaults to 0.
    ///</summary>
    [Default(0)]
    property MaxThreads: Integer read FMaxThreads write FMaxThreads default 0;
    ///<summary>
    ///  Maximum amount of threads allocated in the thread pool.  Must be set before server is started.
    ///  Defaults to 10.
    ///</summary>
    [Default(10)]
    property PoolSize: Integer read FPoolSize write FPoolSize default 10;
    ///<summary>
    ///  <c>TDSServer</c> instance that this transport is servicing.
    ///</summary>
    property Server;
    ///<summary>
    ///  Buffer size in kilobytes to use for TCP/IP read and write operations.
    ///</summary>
    [Default(32)]
    property BufferKBSize default 32;
    ///<summary>
    ///  Collection of filters that will process the bytestream in this transport
    ///</summary>
    property Filters;
    ///<summary>
    ///  Authentication Manager to use when invoking server methods.
    ///</summary>
    property AuthenticationManager: TDSCustomAuthenticationManager read FAuthenticationManager write SetAuthenticationManager;
    ///<summary>
    ///  Event fired when a connections are established.
    ///</summary>
    property OnConnect: TDSTCPConnectEvent read FTDSTCPConnectEvent write FTDSTCPConnectEvent;
    ///<summary>
    ///  Event fired when a connections are closed.
    ///</summary>
    property OnDisconnect: TDSTCPDisconnectEvent read FTDSTCPDisconnectEvent write FTDSTCPDisconnectEvent;
    ///<summary>Decides if new connections have KeepAlive enabled, disabled or OS default setting.</summary>
    ///<remarks>The other keep-alive values are only used if this is set to kaEnabled.
    ///         The KeepAlive setting can be overridden on a case-by-case bases for each connection, by
    ///         implementing the OnConnect event of this component.
    ///</remarks>
    property KeepAliveEnablement: TDSKeepAliveEnablement read FKeepAliveEnablement write FKeepAliveEnablement default kaDefault;
    ///<summary>If KeepAlive is set to enabled, specifies the KeepAlive time to use (ms).</summary>
    ///<remarks>See TDSTCPChannel.EnableKeepAlive for more information on this property.</remarks>
    [Default(300000)]
    property KeepAliveTime: Integer read FKeepAliveTime write FKeepAliveTime default 300000;
    ///<summary>If KeepAlive is set to enabled, specifies the KeepAlive interval to use (ms).</summary>
    ///<remarks>See TDSTCPChannel.EnableKeepAlive for more information on this property.</remarks>
    [Default(100)]
    property KeepAliveInterval: Integer read FKeepAliveInterval write FKeepAliveInterval default 100;

    property IPImplementationID;
  end;

implementation

uses
{$IFNDEF POSIX}
  Winapi.ActiveX,
  System.Win.ComObj,
{$ENDIF}
  Data.DBXClientResStrs,
  Data.DBXCommon,
  Data.DBXMessageHandlerCommon,
  Data.DBXTransportFilter,
  Datasnap.DSSession,
  Data.DBXMessageHandlerJSonServer;


type
  // Internal subclass of TDSTCPChannel used to inject new functionality into the channel
  // for XE2 updates, without causing any interface breaking changes.
  TDSTCPChannelInternal = class(TDSTCPChannel)
  public
    constructor Create(AContext: IIPContext);
    procedure Close; override;
  private
    FEventMethod: TDSSessionEvent;
    //event to log in the TDSSessionManager. When this Channel's session is closed, close the channel
    //if it isn't already being closed.
    procedure ChannelSessionEvent(Sender: TObject; const EventType: TDSSessionEventType;
                                  const Session: TDSSession);
  end;

{ TDSTCPChannelInternal }

procedure TDSTCPChannelInternal.ChannelSessionEvent(Sender: TObject;
  const EventType: TDSSessionEventType; const Session: TDSSession);
begin
  //if the sesison has been initiated for this connection
  if (not ConnectionLost) and
     (Session <> nil) and
     (SessionId <> EmptyStr) and
     //and this is an event for a session closing
     (EventType = SessionClose) and
     //and the session beign closed is this channel's (connection's) session
     (Session.SessionName = SessionId)
     then
  begin
    //close the connection
    Close;
  end;
end;

{ TDSTCPConnectionEvent }

constructor TDSTCPConnectEventObject.Create(AConnection: TObject; AChannel: TDSTCPChannel);
begin
  FConnection := AConnection;
  FChannel := AChannel;
end;

procedure TDSTCPChannelInternal.Close;
begin
  TDSSessionManager.Instance.RemoveSessionEvent(FEventMethod);
  inherited;
end;

constructor TDSTCPChannelInternal.Create(AContext: IIPContext);
begin
  inherited Create(AContext);
  FEventMethod := ChannelSessionEvent;
  TDSSessionManager.Instance.AddSessionEvent(FEventMethod);
end;

{ TDSTCPDisconnectEventObject }

constructor TDSTCPDisconnectEventObject.Create(AConnection: TObject);
begin
  FConnection := AConnection;
end;

{ TDSTCPServerTransport }

constructor TDSTCPServerTransport.Create(AOwner: TComponent);
begin
  inherited;
  FPort := 211;
  FProtocolHandlerFactory := TDSJSONProtocolHandlerFactory.Create(Self);
  FTDSTCPConnectEvent := nil;
  FTDSTCPDisconnectEvent := nil;
  FKeepAliveEnablement := kaDefault; //use OS specified KeepAlive settings
  FKeepAliveTime := 300000; //5 minutes before using KeepAlive packets
  FKeepAliveInterval := 100; //100 millisecond wait between retires
  FPoolSize := 10;
end;

destructor TDSTCPServerTransport.Destroy;
begin
  Stop;
  FreeAndNil(FProtocolHandlerFactory);
  inherited;
end;

function TDSTCPServerTransport.CreateTcpChannel(AContext: IIPContext): TDBXChannel;
begin
  Result := TDSTCPChannelInternal.Create(AContext);
end;

class function TDSTCPServerTransport.GetTcpChannel(AConnectionHandler: TDSServerConnectionHandler): TDBXChannel;
var
  LChannel: TDBXChannel;
begin
  Result := nil;
  LChannel := AConnectionHandler.Channel;
  if LChannel is TDBXFilterSocketChannel then
  begin
    Result := TDBXFilterSocketChannel(LChannel).Channel;
  end;
end;

procedure TDSTCPServerTransport.DoOnConnect(AContext: IIPContext);
var
  IndyChannel: TDBXChannel;
  FilterChannel: TDBXFilterSocketChannel;
  Event: TDSTCPConnectEventObject;
begin
  FilterChannel := TDBXFilterSocketChannel.Create(Filters);

  IndyChannel := CreateTcpChannel(AContext);

{$IFNDEF POSIX}
  if CoInitFlags = -1 then
    CoInitializeEx(nil, COINIT_MULTITHREADED)
  else
    CoInitializeEx(nil, CoInitFlags);
{$ENDIF}
  IndyChannel.Open;

  // set the delegate
  FilterChannel.Channel := IndyChannel;

  AContext.Data := FProtocolHandlerFactory.CreateProtocolHandler(FilterChannel);
  if AContext.Data is TDBXJSonServerProtocolHandler then
  begin
    if TDBXJSonServerProtocolHandler(AContext.Data).DSSession = nil then
    begin
      TDBXJSonServerProtocolHandler(AContext.Data).DSSession :=
        TDSSessionManager.Instance.CreateSession<TDSTCPSession>(
          function: TDSSession
          begin
            Result := TDSTCPSession.Create(AuthenticationManager);
            Result.PutData('CommunicationProtocol', 'tcp/ip');
            Result.PutData('RemoteIP', AContext.Connection.Socket.Binding.PeerIP);
            Result.PutData('RemotePort', IntToStr(AContext.Connection.Socket.Binding.PeerPort));
          end,
          ''
        );
    end;
  end;

  if Assigned(FTDSTCPConnectEvent) and (AContext <> nil) and (AContext.Connection <> nil) and
    (FTcpServer <> nil) and FTcpServer.Active then
  begin
    if IndyChannel Is TDSTCPChannel then
    begin
      //enable keep alive, disable it, or leave the OS default setting as it is
      if FKeepAliveEnablement = kaEnabled then
        TDSTCPChannel(IndyChannel).EnableKeepAlive(FKeepAliveTime, FKeepAliveInterval)
      else if FKeepAliveEnablement = kaDisabled then
        TDSTCPChannel(IndyChannel).DisableKeepAlive;

      Event := TDSTCPConnectEventObject.Create(AContext.Connection.GetObject, TDSTCPChannel(IndyChannel));
    end
    else
      Event := TDSTCPConnectEventObject.Create(AContext.Connection.GetObject, nil);

    try
      OnConnect(Event);
    except
    end;
  end;
end;

procedure TDSTCPServerTransport.DoOnDisconnect(AContext: IIPContext);
var
  TempData: TObject;
  Event: TDSTCPDisconnectEventObject;
begin
  if Assigned(FTDSTCPDisconnectEvent) and (AContext <> nil) and (AContext.Connection <> nil) and
    (FTcpServer <> nil) and FTcpServer.Active then
  begin
    Event := TDSTCPDisconnectEventObject.Create(AContext.Connection.GetObject);

    try
      OnDisconnect(Event);
    except
    end;
  end;

  TempData := AContext.Data;
  AContext.Data := nil;
  TempData.DisposeOf;
{$IFNDEF POSIX}
  CoUninitialize;
{$ENDIF}
end;

procedure TDSTCPServerTransport.DoOnExecute(AContext: IIPContext);
begin
  // Added for a several reasons.  1) This method can be called when
  // there is nothing to read.  Since Indy 10 is polling based, if
  // we just return, there will be heavy cpu usage as this this method
  // spins in the callers loop.  Calling CheckForDataOnSource with
  // a value of 10 milliseconds avoids the cpu overhead.
  // 2) HandleNonBlockingProtocol should not be called unless there is 1 or
  // more bytes to read.  An error will occur if nothing can be read.
  // 3) In the case of a disconnect message, AContext.Data is freed.  However
  // this method will continue to be called until the server detects that
  // the client socket has been closed.
  //
  if AContext.Connection.IOHandler.InputBuffer.Size = 0 then
    AContext.Connection.IOHandler.CheckForDataOnSource(10);

  if AContext.Connection.IOHandler.InputBuffer.Size > 0 then
  begin
    try
      TDBXProtocolHandler(AContext.Data).SetUp(FAuthenticationManager);
      Assert(TDSSessionManager.GetThreadSession <> nil);

      TDSSessionManager.GetThreadSession.ObjectCreator := self;
      TDBXProtocolHandler(AContext.Data).HandleNonBlockingProtocol;
    finally
      TDSSessionManager.ClearThreadSession;
    end;
  end;
end;

procedure TDSTCPServerTransport.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if (AComponent = Server) then
      Server := nil
    else if (AComponent = FAuthenticationManager) then
      FAuthenticationManager := nil;
  end;
end;

procedure TDSTCPServerTransport.SetAuthenticationManager(const AuthManager: TDSCustomAuthenticationManager);
begin
  if Assigned(FAuthenticationManager) then
    FAuthenticationManager.RemoveFreeNotification(Self);

  FAuthenticationManager := AuthManager;

  if Assigned(FAuthenticationManager) then
    FAuthenticationManager.FreeNotification(Self);
end;

procedure TDSTCPServerTransport.SetServer(const AServer: TDSCustomServer);
begin
  if (AServer <> Server) then
  begin
    if Assigned(Server) then
      RemoveFreeNotification(Server);
    if Assigned(AServer) then
    begin
      FreeNotification(AServer);
      DBXContext := AServer.DBXContext;
    end;
  end;
  inherited SetServer(AServer);
end;

procedure TDSTCPServerTransport.SetIPImplementationID(const AIPImplementationID: string);
begin
  if FTcpServer <> nil then
    raise TDBXError.Create(0, sCannotChangeIPImplID);
  inherited SetIPImplementationID(AIPImplementationID);
end;

function TDSTCPServerTransport.CreateTcpServer: IIPTCPServer;
begin
  Result := PeerFactory.CreatePeer(IPImplementationID, IIPTCPServer, nil) as IIPTCPServer;
end;

procedure TDSTCPServerTransport.Start;
var
  Scheduler: IIPSchedulerOfThreadPool;
  LSocketHandle: IIPSocketHandle;
begin
  inherited;
  FTcpServer := CreateTcpServer;
  FTcpServer.OnConnect := DoOnConnect;
  FTcpServer.OnDisconnect := DoOnDisconnect;
  FTcpServer.OnExecute := DoOnExecute;
  FTcpServer.UseNagle := false;
  FTcpServer.Bindings.Add.Port := FPort; //default IPv4
  if GStackPeers(IPImplementationID).SupportsIPv6 then
  begin
    LSocketHandle := FTcpServer.Bindings.Add;
    LSocketHandle.Port := FPort; //default IPv4
    LSocketHandle.IPVersion := TIPVersionPeer.IP_IPv6
  end;
  Scheduler := PeerFactory.CreatePeer(IPImplementationID, IIPSchedulerOfThreadPool, FTCPServer.GetObject as TComponent) as IIPSchedulerOfThreadPool;
  Scheduler.MaxThreads := MaxThreads;
  Scheduler.PoolSize := PoolSize;
  FTCPServer.Scheduler := Scheduler;
  FTcpServer.Active := True;
end;

procedure TDSTCPServerTransport.Stop;
begin
  if FTcpServer <> nil then
  begin
    Stopping; // Let server know that transport is being stopped
    FTcpServer.Active := False;
    FTcpServer := nil;
  end;
  inherited;
end;

{ TDSTCPChannel }

procedure TDSTCPChannel.Close;
begin
  inherited;
  if Assigned(FContext) and Assigned(FContext.Connection) then
    try
      FContext.Connection.Disconnect;
    except
      on Exception do
      // nothing
    end;
  FreeAndNil(FChannelInfo);
end;

constructor TDSTCPChannel.Create(AContext: IIPContext);
begin
  inherited Create;
  FContext := AContext;
end;

destructor TDSTCPChannel.Destroy;
begin
  Close;
  inherited;
end;

procedure TDSTCPChannel.DisableKeepAlive;
begin
  if (FContext <> nil) and (GStackPeers(FContext.GetIPImplementationID) <> nil) and (FContext.Connection <> nil) and
     (FContext.Connection.Socket <> nil) and (FContext.Connection.Socket.Binding <> nil) then
  begin
    GStackPeers(FContext.GetIPImplementationID).SetKeepAliveValues(FContext.Connection.Socket.Binding.Handle, False, 0, 0);
  end;
end;

function TDSTCPChannel.EnableKeepAlive(KeepAliveTime, KeepAliveInterval: Integer): Boolean;
begin
  Result := False;

  if (FContext <> nil) and (GStackPeers(FContext.GetIPImplementationID) <> nil) and (FContext.Connection <> nil) and
     (FContext.Connection.Socket <> nil) and (FContext.Connection.Socket.Binding <> nil) then
  begin
    GStackPeers(FContext.GetIPImplementationID).SetKeepAliveValues(FContext.Connection.Socket.Binding.Handle, True, KeepAliveTime, KeepAliveInterval);
    Result := True;
  end;
end;

function TDSTCPChannel.GetChannelInfo: TDBXChannelInfo;
begin
  Result := FChannelInfo;
end;

function TDSTCPChannel.GetConnection: TObject;
begin
  Result := nil;
  if (FContext <> nil) then
    Result := FContext.Connection.GetObject;
end;

function TDSTCPChannel.IsConnectionLost: Boolean;
begin
  Result := FConnectionLost;
end;

procedure TDSTCPChannel.Open;
var
  ClientInfo: TDBXClientInfo;
begin
  inherited;
  FreeAndNil(FChannelInfo);
  FChannelInfo := TDBXSocketChannelInfo.Create(IntPtr(FContext.Connection), FContext.Connection.Socket.Binding.PeerIP);

  ClientInfo := FChannelInfo.ClientInfo;

  ClientInfo.IpAddress := FContext.Connection.Socket.Binding.PeerIP;
  ClientInfo.ClientPort := IntToStr(FContext.Connection.Socket.Binding.PeerPort);
  ClientInfo.Protocol := 'tcp/ip';

  FChannelInfo.ClientInfo := ClientInfo;
end;

function TDSTCPChannel.Read(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
var
  ActualReadCount: Integer;
  Session: TDSSession;
begin
  //Set the SessionId for this channel if it hasn't already been set
  if FSessionId = EmptyStr then
  begin
    Session := TDSSessionManager.Instance.GetThreadSession;
    if Session <> nil then
      FSessionId := Session.SessionName;
  end;

  // wait for data
  while FContext.Connection.IOHandler.InputBuffer.Size = 0 do
    if FContext.Connection.IOHandler.Connected then
      // try again
      try
        FContext.Connection.IOHandler.CheckForDataOnSource(10);
      except
        FConnectionLost := True;
        raise TDBXError.Create(0, SConnectionLost);
      end
    else
    begin
      FConnectionLost := True;
      raise TDBXError.Create(0, SConnectionLost);
    end;

  if FContext.Connection.IOHandler.InputBuffer.Size < Count then
    ActualReadCount := FContext.Connection.IOHandler.InputBuffer.Size
  else
    ActualReadCount := Count;

  if Length(FReadBuffer) < ActualReadCount then
    SetLength(FReadBuffer, ActualReadCount);

  FContext.Connection.IOHandler.ReadBytes(TIPBytesPeer(FReadBuffer), ActualReadCount, False);
  Move(FReadBuffer[0], Buffer[Offset], ActualReadCount);

  Result := ActualReadCount;
end;

function TDSTCPChannel.Write(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
  Assert(Offset = 0);
  FContext.Connection.IOHandler.Write(TIPBytesPeer(Buffer), Count, Offset);
  Result := Count;
end;

end.
