{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSCommon;

interface

uses
  System.JSON,
  System.SysUtils,
  System.Classes,
  System.Generics.Collections,
  Data.DBXCommon,
  Data.DBXJSON,
  Data.DBXJSONReflect,
  Data.DbxDatasnap
  ;

type
  /// <summary>User event type for notification of callback tunnel events, such
  /// as create and close.</summary>
  TDSCallbackTunnelEventType = (TunnelCreate, TunnelClose, TunnelClosedByServer, CallbackAdded, CallbackRemoved);

  TDSCallbackChannelEvent = procedure(Sender: TObject) of object;

  /// <summary>Implements a callback and string list pairing, where Callback is
  /// one of the channel callbacks of the client, and Channels is a list of
  /// names of channels, aside from the channel of the callback channel manager,
  /// where the callback listens.</summary>
  TDSCallbackItem = class
  private
    FServerChannelName: string;
    FCallback: TDBXCallback;
    FChannels: TStrings;
  public
    constructor Create(ServerChannelName: string; Callback: TDBXCallback; Channels: TStrings = nil); overload;
    constructor Create(ServerChannelName: string; Callback: TDBXCallback; Channels: string = ''); overload;
    destructor Destroy; override;

    ///  <summary>Returns true if this callback is 'listening' to the given Channel name.
    ///    Specifically, if the channel name is the server channel name, or in the Channels list.
    ///  </summary>
    function ListeningOn(ChannelName: string): Boolean;

    ///  <summary>Name of the channel the manager this item is in listens on.</summary>
    property ServerChannelName: string read FServerChannelName;
    ///  <summary>The callback wrapped by this item.</summary>
    property Callback: TDBXCallback read FCallback;
    ///  <summary>A list of channel names this specific callback is interested in, or nil</summary>
    property Channels: TStrings read FChannels;
  end;

  TDSClientCallbackChannelManager = class;

  /// <summary>Event item passed in through the TDSClientChannelManagerEvent to
  /// provide tunnel event information.</summary>
  TDSClientChannelEventItem = record
    ///<summary>The type of event occurring for a tunnel (channel.)</summary>
    EventType: TDSCallbackTunnelEventType;
    ///<summary>The ID of the tunnel (Channel) being acted on.</summary>
    TunnelId: string;
    ///<summary>The tunnel (Channel) being acted on.</summary>
    Tunnel: TDSClientCallbackChannelManager;
    ///<summary>The ServerChannelName of the tunnel (Channel) being acted on.</summary>
    TunnelChannelName: string;
    /// <summary>The ID of the callback being added or removed. Empty string if the tunnel is being closed.
    /// </summary>
    CallbackId: string;
    /// <summary>The callback item which wraps the callback this event is for. nil if tunnel is being closed.
    /// </summary>
    CallbackItem: TDSCallbackItem;
  end;

  ///  <summary> User event for notification of channel events, such as create and close. </summary>
  TDSClientChannelManagerEvent =
                procedure(Sender: TObject; const EventItem: TDSClientChannelEventItem) of object;

  /// <summary>Is an enumeration of DataSnap tunnel states.</summary>
  TDSChannelThreadState = (ctsStopped, ctsStarted, ctsFailed);

  ///  <summary> Client callback manager handles the client callbacks that are registered
  ///    with a specific DS Server instance (DSHostname, DSPort, Communication protocol).
  ///
  ///    ChannelName property value will determine the server channel the callbacks will
  ///    be registered to. DS Server can handle multiple callback channels based on a name.
  ///    Callbacks can respond to messages posted to a channel asynchronously.
  ///
  ///    Manager Id is an unique identifier within a channel that will make possible
  ///    peer-to-peer callbacks.
  ///  </summary>
  TDSClientCallbackChannelManager = class(TComponent)
    strict private
      FSecurityToken: string;
      FDSHostname: string;
      FDSPort: string;
      FDSPath: string;
      FCommunicationProtocol: string;
      FChannelName: string;
      FManagerId: string;
      FConnectionTimeout: string;
      FCommunicationTimeout: string;
      FStopped: Boolean;
      FUserName: string;
      FPassword: string;
      FProxyHost: string;
      FProxyPort: Integer;
      FProxyUsername: string;
      FProxyPassword: string;
      FIPImplementationID: string;

      //Unique ID of the callback as the Key, and the callback item wrapping the callback as the value
      FLocalCallbackRepo: TDictionary<string, TDSCallbackItem>;

    private
      FChannelManagerEvent: TDSClientChannelManagerEvent;

      procedure NotifyChange(EventType: TDSCallbackTunnelEventType; const CallbackId: string;
                             Item: TDSCallbackItem);
    protected
      type

      TDSChannelInvokeEvent = procedure (const Id: string; Data: TJSONValue; out Response: TJSONValue) of object;
      TDSChannelBroadcastEvent = procedure (Data: TJSONValue; ChannelName: string) of object;

      TParamSetup = reference to procedure (Params: TDBXParameterList);
      TDSWorker = reference to procedure;

      TDSChannelCallback = class(TDBXCallback)
        private
          FInvokeEvent: TDSChannelInvokeEvent;
          FInvokeObjectEvent: TDSChannelInvokeEvent;
          FBroadcastEvent: TDSChannelBroadcastEvent;
          FBroadcastObjectEvent: TDSChannelBroadcastEvent;

        public
          constructor Create(const InvokeEvent: TDSChannelInvokeEvent;
                             const InvokeObjectEvent: TDSChannelInvokeEvent;
                             const BroadcastEvent: TDSChannelBroadcastEvent;
                             const BroadcastObjectEvent: TDSChannelBroadcastEvent); overload;
          destructor Destroy; override;

          function Execute(const Arg: TJSONValue): TJSONValue; override;
      end;

      TDSChannelThread = class(TThread)
      private
        FWorker: TDSWorker;
        [Weak] FManager: TDSClientCallbackChannelManager;
      protected
        procedure Execute; override;
      public
        constructor Create(Worker: TDSWorker; Manager: TDSClientCallbackChannelManager = nil);
      end;

      /// <summary>
      ///   Thread for execution of a Callback. This is done in its own thread so that if
      ///   the callback takes too long to return then the thread can be abandoned
      ///   and the client/server won't hang.
      /// </summary>
      TDSExecuteThread = class(TThread)
      protected
        FCallback: TDBXCallback;
        FData: TJSONValue;
        FResponse: TJSONValue;
        procedure Execute; override;
      public
        constructor Create(Callback: TDBXCallback; Data: TJSONValue);
        destructor Destroy; override;
        property Response: TJSONValue read FResponse;
      end;

    strict private
      FChannelCallback: TDSChannelCallback;
      FOnServerConnectionError: TDSCallbackChannelEvent;
      FOnServerConnectionTerminate: TDSCallbackChannelEvent;
      FRegConverters: TDictionary<string, TConverterEvent>;
      FRegReverters: TDictionary<string, TReverterEvent>;
      FDSChannelThread: TDSChannelThread;
      FNotifyLock: TObject;

    protected
      ///  <summary> The current state of the tunnel thread </summary>
      FState: TDSChannelThreadState;

      ///  <summary> If State is failed, this may hold a meaningful error message. </summary>
      FStateError: string;

      ///  <summary> Creates the DBX DataSnap properties map from local fields
      ///  </summary>
      function DBXConnectionProperties(NoTimeout: Boolean = false): TDBXDatasnapProperties;
      ///  <summary> Generic method for remote invocation
      ///  </summary>
      procedure ExecuteRemote(const AClassName, AMethodName: string; ParamSetup: TParamSetup;
                              ParamCheckup: TParamSetup; NoTimeout: Boolean = false);

      procedure Broadcast(Data: TJSONValue; ChannelName: string);
      procedure BroadcastObject(Data: TJSONValue; ChannelName: string);
      procedure Invoke(const Id: string; Data: TJSONValue; out Response: TJSONValue);
      procedure InvokeObject(const Id: string; Data: TJSONValue; out Response: TJSONValue);
      function GetIPImplementationID: string; virtual;
      procedure SetIPImplementationID(const AIPImplementationID: string); virtual;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;

      ///  <summary>Returns a list of all callback Ids registered with this manager.</summary>
      function GetCallbackIds: TArray<string>;

      ///  <summary>Returns the item (and true) if one with the given Id exists. nil (and false) otherwise.
      ///  </summary>
      function GetCallbackItem(const CallbackId: string; out Item: TDSCallbackItem): Boolean;

      ///  <summary> Registers a callback with the channel manager. The callback id
      ///   uniquely identifies it and it is used for peer-to-peer message exchange.
      ///
      ///   It returns false if the registration failed (there is already a callback with
      ///    the same id, invalid arguments, connection with DS Server failed, etc)
      ///  </summary>
      function RegisterCallback(const CallbackId: string;
                                const Callback: TDBXCallback): Boolean; overload;
      function RegisterCallback(const CallbackId, ChannelNames: string;
                                const Callback: TDBXCallback): Boolean; overload;
      ///  <summary> Registers a callback with the channel manager. The callback's name
      ///   uniquely identifies it and it is used for peer-to-peer message exchange.
      ///
      ///   It returns false if the registration failed (there is already a callback with
      ///    the same name, invalid arguments, connection with DS Server failed, etc)
      ///  </summary>
      function RegisterCallback(const ChannelNames: string; const Callback: TDBXNamedCallback): Boolean; overload;
      function RegisterCallback(const Callback: TDBXNamedCallback): Boolean; overload;
      ///  <summary> Unregisters a callback from the channel manager given the callback's unique Id (name)
      ///  </summary>
      function UnregisterCallback(const CallbackId: string): Boolean;
      ///  <summary> Closes the client channel, which will internally unregister all callbacks.
      ///  </summary>
      function CloseClientChannel: Boolean;
      ///  <summary> Broadcasts a message to all callbacks of the channel this is registered with.
      ///  </summary>
      ///  <remarks>
      ///    Function takes ownership of the argument
      ///  </remarks>
      function BroadcastToChannel(const Msg: TJSONValue; ChannelName: string = ''): Boolean;
      ///  <summary> Broadcasts a message to all callbacks of the channel this is registered with.
      ///  </summary>
      ///  <remarks>
      ///    Function takes ownership of the argument
      ///  </remarks>
      function BroadcastObjectToChannel(const Msg: TObject; ChannelName: string = ''): Boolean;
      /// <summary> Notifies a client callback with the specified message </summary>
      ///  <remarks>
      ///    Function takes ownership of the input message argument
      ///  </remarks>
      function NotifyCallback(const CallbackId, ManagerId: string;
                              const Msg: TJSONValue; out Response: TJSONValue): Boolean;
      /// <summary> Notifies a client callback with the specified message </summary>
      ///  <remarks>
      ///    Function takes ownership of the input message argument
      ///  </remarks>
      function NotifyObjectCallback(const CallbackId, ManagerId: string;
                              const Msg: TObject; out Response: TObject): Boolean;

      function GetJSONMarshaler: TJSONMarshal;
      function GetJSONUnMarshaler: TJSONUnMarshal;

      procedure AddConverter(event: TConverterEvent);
      procedure AddReverter(event: TReverterEvent);

      ///  <summary> Marshal argument using local marshaler</summary>
      function MarshalData(Data: TObject): TJSONValue;
      ///  <summary> UnMarshal argument using local unmarshaler</summary>
      function UnMarshalJSON(Data: TJSONValue): TObject;

      ///  <summary> Makes a copy of this manager, without any of its registered callbacks.</summary>
      function Copy: TDSClientCallbackChannelManager;

      ///  <summary> The current state of the tunnel thread. </summary>
      property State: TDSChannelThreadState read FState;

      ///  <summary> If State is failed, this may hold a meaningful error message. </summary>
      property StateError: string read FStateError;
    published
      property DSHostname: string read FDSHostname write FDSHostname;
      property DSPort: string read FDSPort write FDSPort;
      property DSPath: string read FDSPath write FDSPath;
      property CommunicationProtocol: string read FCommunicationProtocol write FCommunicationProtocol;
      property ChannelName: string read FChannelName write FChannelName;
      property ManagerId: string read FManagerId write FManagerId;
      property OnServerConnectionError: TDSCallbackChannelEvent read FOnServerConnectionError
                write FOnServerConnectionError;
      property OnServerConnectionTerminate: TDSCallbackChannelEvent read FOnServerConnectionTerminate
                write FOnServerConnectionTerminate;
      ///  <summary>miliseconds expected for the connection to be established</summary>
      property ConnectionTimeout: string read FConnectionTimeout write FConnectionTimeout;
      property CommunicationTimeout: string read FCommunicationTimeout write FCommunicationTimeout;
      ///  <summary>User name to authenticate with.</summary>
      property UserName: string read FUserName write FUserName;
      ///  <summary>Password to authenticate with.</summary>
      property Password: string read FPassword write FPassword;
      /// <summary>The host to proxy requests through, or empty string to not use a proxy.</summary>
      property ProxyHost: string read FProxyHost write FProxyHost;
      /// <summary>The port on the proxy host to proxy requests through. Ignored if DSProxyHost isn't set.
      /// </summary>
      [Default(8888)]
      property ProxyPort: Integer read FProxyPort write FProxyPort default 8888;
      /// <summary>The user name for authentication with the specified proxy.</summary>
      property ProxyUsername: string read FProxyUsername write FProxyUsername;
      /// <summary>The password for authentication with the specified proxy.</summary>
      property ProxyPassword: string read FProxyPassword write FProxyPassword;

      property IPImplementationID: string read GetIPImplementationID write SetIPImplementationID;

      /// <summary>Event to be notified when the channel is opened or closed and when callbacks are added and removed.
      /// </summary>
      property OnChannelStateChange: TDSClientChannelManagerEvent read FChannelManagerEvent write FChannelManagerEvent;
  end;

  TDSSessionHelper = class
  public
    class function GenerateSessionId: string; static;
  end;

  /// <summary>Class to represent DataSnap service exceptions within the
  /// Datasnap.DSCommon unit.</summary>
  TDSServiceException = class(Exception)
  end;

implementation

uses Data.DBXClientResStrs;

class function TDSSessionHelper.GenerateSessionId: string;
var
  P1, P2, P3: Integer;
begin
  P1 := Random(1000000);
  P2 := Random(1000000);
  P3 := Random(1000000);
  Result := Format('%d.%d.%d', [P1, P2, P3]);
end;

{ TDSClientCallbackChannelManager }

procedure TDSClientCallbackChannelManager.Broadcast(Data: TJSONValue; ChannelName: string);
var
  ValEnum: TEnumerator<TDSCallbackItem>;
  DoForAll: Boolean;
  LJSONValue: TJSONValue;
begin
  TMonitor.Enter(FLocalCallbackRepo);
  try
    // get the values enumerator
    ValEnum := FLocalCallbackRepo.Values.GetEnumerator;
    try
      DoForAll := (ChannelName = '') or (FChannelName = ChannelName);

      // invoke execute of each callback
      while ValEnum.MoveNext do
        if DoForAll or ValEnum.Current.ListeningOn(ChannelName) then
        begin
          LJSONValue := ValEnum.Current.Callback.Execute(Data);
          LJSONValue.Free;
        end;
    finally
      ValEnum.Free;
    end;
  finally
    TMonitor.Exit(FLocalCallbackRepo);
  end;
end;

procedure TDSClientCallbackChannelManager.BroadcastObject(Data: TJSONValue; ChannelName: string);
var
  ValEnum: TEnumerator<TDSCallbackItem>;
  DataObj: TObject;
  DoForAll: Boolean;
  LObject: TObject;
begin
  DataObj := UnMarshalJSON(Data);
  try
    TMonitor.Enter(FLocalCallbackRepo);
    try
      // get the values enumerator
      ValEnum := FLocalCallbackRepo.Values.GetEnumerator;
      try
        DoForAll := (ChannelName = '') or (FChannelName = ChannelName);

        // invoke execute of each callback
        while ValEnum.MoveNext do
          if DoForAll or ValEnum.Current.ListeningOn(ChannelName) then
          begin
            LObject := ValEnum.Current.Callback.Execute(DataObj);
            LObject.Free;
          end;
      finally
        ValEnum.Free;
      end;
    finally
      TMonitor.Exit(FLocalCallbackRepo);
    end
  finally
    DataObj.Free
  end
end;

function TDSClientCallbackChannelManager.CloseClientChannel: Boolean;
var
  Status : Boolean;
begin
  try
    Status := False;
    //if the manager has been started, then we need to close it
    if State = ctsStarted then
    begin
      ExecuteRemote('DSAdmin', 'CloseClientChannel',
        procedure (Params: TDBXParameterList) begin
          Params[0].Value.AsString := FManagerId;
          Params[1].Value.AsString := FSecurityToken;
        end,
        procedure (Params: TDBXParameterList) begin
          Status := Params[2].Value.AsBoolean;
        end);
    end;
    Result := Status;
    //If the close command is successful, clear all local callback references
    if Status then
    begin
      FLocalCallbackRepo.Clear;
      FState := ctsStopped;
      FStateError := EmptyStr;
      NotifyChange(TunnelClose, EmptyStr, nil);
    end;
  except
    Result := false;
  end;
end;

function TDSClientCallbackChannelManager.Copy: TDSClientCallbackChannelManager;
begin
  Result := TDSClientCallbackChannelManager.Create(nil);
  Result.FDSHostname := FDSHostname;
  Result.FDSPort := FDSPort;
  Result.FDSPath := FDSPath;
  Result.FCommunicationProtocol := FCommunicationProtocol;
  Result.FChannelName := FChannelName;
  Result.FConnectionTimeout := FConnectionTimeout;
  Result.FCommunicationTimeout := FCommunicationTimeout;
  Result.FUserName := FUserName;
  Result.FPassword := FPassword;
  Result.FProxyHost := FProxyHost;
  Result.FProxyPort := FProxyPort;
  Result.FProxyUsername := FProxyUsername;
  Result.FProxyPassword := FProxyPassword;

  Result.OnServerConnectionTerminate := OnServerConnectionTerminate;
  Result.OnServerConnectionError := OnServerConnectionError;
  Result.OnChannelStateChange := OnChannelStateChange;
end;

constructor TDSClientCallbackChannelManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FNotifyLock := TObject.Create;
  FIPImplementationID := '';
  FManagerId := TDSSessionHelper.GenerateSessionId;
  FLocalCallbackRepo := TObjectDictionary<string, TDSCallbackItem>.Create([doOwnsValues]);
  FChannelCallback := TDSChannelCallback.Create(Invoke, InvokeObject, Broadcast, BroadcastObject);
{$IFNDEF AUTOREFCOUNT}
  FChannelCallback.AddRef; // take ownership
{$ENDIF !AUTOREFCOUNT}
  FRegConverters := TObjectDictionary<string, TConverterEvent>.Create([doOwnsValues]);
  FRegReverters := TObjectDictionary<string, TReverterEvent>.Create([doOwnsValues]);
  FSecurityToken := IntToStr(Random(100000)) + '.' + IntToStr(Random(100000));
  FChannelManagerEvent := nil;
  FState := ctsStopped;
  FStateError := EmptyStr;

  FProxyPort := 8888;
end;

function TDSClientCallbackChannelManager.DBXConnectionProperties(NoTimeout: Boolean): TDBXDatasnapProperties;
begin
  Result := TDBXDatasnapProperties.Create(nil);
  Result.Values[TDBXPropertyNames.DriverName] := 'Datasnap';
  Result.Values[TDBXPropertyNames.HostName] := FDSHostname;
  Result.Values[TDBXPropertyNames.CommunicationProtocol] := FCommunicationProtocol;
  Result.Values[TDBXPropertyNames.Port] := FDSPort;
  Result.Values[TDBXPropertyNames.URLPath] := FDSPath;
  Result.Values[TDBXPropertyNames.DSAuthenticationUser] := FUserName;
  Result.Values[TDBXPropertyNames.DSAuthenticationPassword] := FPassword;
  Result.Values[TDBXPropertyNames.DSProxyHost] := FProxyHost;
  Result.Values[TDBXPropertyNames.DSProxyPort] := IntToStr(FProxyPort);
  Result.Values[TDBXPropertyNames.DSProxyUsername] := FProxyUsername;
  Result.Values[TDBXPropertyNames.DSProxyPassword] := FProxyPassword;
  if not NoTimeout then
  begin
    Result.Values[TDBXPropertyNames.ConnectTimeout] := FConnectionTimeout;
    Result.Values[TDBXPropertyNames.CommunicationTimeout] := FCommunicationTimeout
  end
end;

destructor TDSClientCallbackChannelManager.Destroy;
begin
  try
    // unregister all outstanding callbacks
    CloseClientChannel();
  except
    // igonore I/O errors at this point
  end;
  if FDSChannelThread <> nil then
  begin
    FDSChannelThread.WaitFor;
    FDSChannelThread.Free;
  end;

  // free the repo
  FreeAndNil( FLocalCallbackRepo );


{$IFNDEF AUTOREFCOUNT}
  // release the callback
  FChannelCallback.Release;
{$ELSE}
  FChannelCallback.Free;
{$ENDIF !AUTOREFCOUNT}

  FreeAndNil(FRegConverters);
  FreeAndNil(FRegReverters);
  FNotifyLock.Free;
  inherited;
end;

procedure TDSClientCallbackChannelManager.ExecuteRemote(const AClassName,
  AMethodName: string; ParamSetup, ParamCheckup: TParamSetup; NoTimeout: Boolean);
var
  DBXConnection: TDBXConnection;
  DBXProperties: TDBXDatasnapProperties;
  DBXCommand: TDBXCommand;
begin
  DBXProperties := DBXConnectionProperties(NoTimeout);
  try
    TDBXConnectionFactory.Lock;
    try
      DBXConnection := TDBXConnectionFactory.GetConnectionFactory.GetConnection(DBXProperties);
    finally
      TDBXConnectionFactory.Unlock;
    end;
    try
      DBXCommand := DBXConnection.CreateCommand;
      try
        DBXCommand.CommandType := TDBXCommandTypes.DSServerMethod;
        DBXCommand.Text := Format('%s.%s', [AClassName, AMethodName]);
        DBXCommand.Prepare;

        ParamSetup(DBXCommand.Parameters);

        DBXCommand.ExecuteUpdate;
        ParamCheckup(DBXCommand.Parameters);
      finally
        try
          DBXCommand.Close;
        except
          // ignore closing exceptions
        end;
        DBXCommand.Free;
      end;
    finally
      try
        DBXConnection.Close;
      except
        // ignore it
      end;
      DBXConnection.Free;
    end;
  finally
    DBXProperties.Free;
  end;
end;

procedure TDSClientCallbackChannelManager.Invoke(const Id: string;
  Data: TJSONValue; out Response: TJSONValue);
var
  Item: TDSCallbackItem;
  Callback: TDBXCallback;
  ExecThread: TDSExecuteThread;
begin
  TMonitor.Enter(FLocalCallbackRepo);
  try
    if FLocalCallbackRepo.TryGetValue(Id, Item) then
    begin
      Callback := Item.Callback;
      try
        TMonitor.Enter(Callback);
        ExecThread := TDSExecuteThread.Create(Callback, Data);

        if not TMonitor.Wait(Callback, 5000) then
          ExecThread.Terminate;

        Response := ExecThread.Response;
      finally
        TMonitor.Exit(Callback);
        FreeAndNil(ExecThread);
      end;
    end
    else
      raise TDSServiceException.Create(Format(SNoRegisteredCallbackForId, [Id]));
  finally
    TMonitor.Exit(FLocalCallbackRepo);
  end;
end;

procedure TDSClientCallbackChannelManager.InvokeObject(const Id: string;
  Data: TJSONValue; out Response: TJSONValue);
var
  Item: TDSCallbackItem;
  Callback: TDBXCallback;
  ResponseObj: TObject;
  DataObj: TObject;
begin
  DataObj := UnMarshalJSON(Data);
  try
    TMonitor.Enter(FLocalCallbackRepo);
    try
      if FLocalCallbackRepo.TryGetValue(Id, Item) then
      begin
        Callback := Item.Callback;
        ResponseObj := Callback.Execute(DataObj);
        try
          Response := MarshalData(ResponseObj)
        finally
          ResponseObj.Free
        end
      end
      else
        raise TDSServiceException.Create(Format(SNoRegisteredCallbackForId, [Id]));
    finally
      TMonitor.Exit(FLocalCallbackRepo);
    end;
  finally
    DataObj.Free;
  end
end;

function TDSClientCallbackChannelManager.RegisterCallback(const ChannelNames: string;
                                                          const Callback: TDBXNamedCallback): Boolean;
begin
  Result := RegisterCallback(Callback.Name, ChannelNames, Callback);
end;

function TDSClientCallbackChannelManager.RegisterCallback(const CallbackId: string;
                                                          const Callback: TDBXCallback): Boolean;
begin
  Result := RegisterCallback(CallbackId, '', Callback);
end;

function TDSClientCallbackChannelManager.RegisterCallback(
  const CallbackId, ChannelNames: string; const Callback: TDBXCallback): Boolean;
var
  Status: Boolean;
  Item, LItem: TDSCallbackItem;
begin
  TMonitor.Enter(FLocalCallbackRepo);
  try
    if not FLocalCallbackRepo.ContainsKey(CallbackId) then
    begin
      Item := TDSCallbackItem.Create(FChannelName, Callback, ChannelNames);
      FLocalCallbackRepo.Add(CallbackId, Item);

      if FLocalCallbackRepo.Count = 1 then
      begin
        FState := ctsStarted;
        FStateError := EmptyStr;

        // start a thread if this is the first registered callback (check if there an active one)
        FDSChannelThread := TDSChannelThread.Create(
          procedure
          begin
            try
              ExecuteRemote('DSAdmin', 'ConnectClientChannel',
                procedure (Params: TDBXParameterList)
                begin
                  Params[0].Value.AsString := FChannelName;
                  Params[1].Value.AsString := FManagerId;
                  Params[2].Value.AsString := CallbackId;
                  Params[3].Value.AsString := ChannelNames;
                  Params[4].Value.AsString := FSecurityToken;
                  Params[5].Value.SetCallbackValue(FChannelCallback);
                end,
                procedure (Params: TDBXParameterList)
                begin
                end,
                true);
            except
              on E: Exception do
              begin
                //remove callback, because it wasn't added successfully
                FLocalCallbackRepo.Remove(CallbackId);
                FState := ctsFailed;
                FStateError := E.Message;

                //don't pass item because we want it out of the callback repo list before sending the notification
                //this is because if the person receiving the notification tries to re-create the tunnel,
                //we need to be sure the tunnel repo is empty
                NotifyChange(TunnelClosedByServer, CallbackId, nil);
              end;
            end;
          end,
          Self);
         Status := true;

        if FLocalCallbackRepo.TryGetValue(CallbackId, LItem) then
          NotifyChange(TunnelCreate, CallbackId, LItem);
      end
      else
      begin
        Status := False;
        ExecuteRemote('DSAdmin', 'RegisterClientCallback',
          procedure (Params: TDBXParameterList) begin
            Params[0].Value.AsString := FManagerId;
            Params[1].Value.AsString := CallbackId;
            Params[2].Value.AsString := ChannelNames;
            Params[3].Value.AsString := FSecurityToken;
            Params[4].Value.SetCallbackValue(FChannelCallback);
          end,
          procedure (Params: TDBXParameterList) begin
            Status := Params[5].Value.AsBoolean;
          end);

          if Status then
            NotifyChange(CallbackAdded, CallbackId, Item);
      end;

      //remove callback, because it wasn't added successfully
      if not Status then
        FLocalCallbackRepo.Remove(CallbackId);
      Result := Status;
    end
    else
      Result := false;
  finally
    TMonitor.Exit(FLocalCallbackRepo);
  end;
end;

function TDSClientCallbackChannelManager.UnregisterCallback(const CallbackId: string): Boolean;
var
  Status: Boolean;
  Item: TDSCallbackItem;
begin
  TMonitor.Enter(FLocalCallbackRepo);
  try
    if FLocalCallbackRepo.ContainsKey(CallbackId) then
    begin
      ExecuteRemote('DSAdmin', 'UnregisterClientCallback',
        procedure (Params: TDBXParameterList) begin
          Params[0].Value.AsString := FManagerId;
          Params[1].Value.AsString := CallbackId;
          Params[2].Value.AsString := FSecurityToken;
        end,
        procedure (Params: TDBXParameterList) begin
          Status := Params[3].Value.AsBoolean;
        end);
      if Status then
      begin
        FLocalCallbackRepo.TryGetValue(CallbackId, Item);

        //notify of removal before it happens, so client has access to the Item.
        NotifyChange(CallbackRemoved, CallbackId, Item);

        FLocalCallbackRepo.Remove(CallbackId);

        // close the channel if no other callbacks are registered
        if FLocalCallbackRepo.Count = 0 then
        begin
          ExecuteRemote('DSAdmin', 'CloseClientChannel',
            procedure (Params: TDBXParameterList) begin
              Params[0].Value.AsString := FManagerId;
              Params[1].Value.AsString := FSecurityToken;
            end,
            procedure (Params: TDBXParameterList) begin
              Status := Params[2].Value.AsBoolean;
            end);

          if Status then
          begin
            FState := ctsStopped;
            FStateError := EmptyStr;
            NotifyChange(TunnelClose, CallbackId, nil);
          end;
        end;
      end;
      Result := Status;
    end
    else
      Result := false
  finally
    TMonitor.Exit(FLocalCallbackRepo);
  end;
end;

function TDSClientCallbackChannelManager.BroadcastToChannel(const Msg: TJSONValue;
                                                            ChannelName: string): Boolean;
var
  Status: Boolean;
begin
  if ChannelName = EmptyStr then
    ChannelName := FChannelName;

  Status := false;
  ExecuteRemote('DSAdmin', 'BroadcastToChannel',
    procedure (Params: TDBXParameterList) begin
      Params[0].Value.AsString := ChannelName;
      Params[1].Value.SetJSONValue(Msg, True);
    end,
    procedure (Params: TDBXParameterList) begin
      Status := Params[2].Value.AsBoolean;
    end);
  Result := Status;
end;

function TDSClientCallbackChannelManager.BroadcastObjectToChannel(const Msg: TObject; ChannelName: string): Boolean;
var
  Status: Boolean;
begin
  if ChannelName = EmptyStr then
    ChannelName := FChannelName;

  Status := false;
  ExecuteRemote('DSAdmin', 'BroadcastObjectToChannel',
    procedure (Params: TDBXParameterList) begin
      Params[0].Value.AsString := ChannelName;
      Params[1].Value.SetJSONValue(MarshalData(Msg), True);
{$IFNDEF AUTOREFCOUNT}
      Msg.Free
{$ENDIF !AUTOREFCOUNT}
    end,
    procedure (Params: TDBXParameterList) begin
      Status := Params[2].Value.AsBoolean;
    end);
  Result := Status;
end;

function TDSClientCallbackChannelManager.NotifyCallback(const CallbackId, ManagerId: string; const Msg: TJSONValue;
                                                        out Response: TJSONValue): Boolean;
var
  Status: Boolean;
  Resp: TJSONValue;
begin
  Status := false;
  ExecuteRemote('DSAdmin', 'NotifyCallback',
    procedure (Params: TDBXParameterList) begin
      Params[0].Value.AsString := ManagerId;
      Params[1].Value.AsString := CallbackId;
      Params[2].Value.SetJSONValue(Msg, True);
    end,
    procedure (Params: TDBXParameterList) begin
      Resp := Params[3].Value.GetJSONValue;
      Status := Params[4].Value.AsBoolean;
    end);
  Response := Resp;
  Result := Status;
end;

procedure TDSClientCallbackChannelManager.NotifyChange(EventType: TDSCallbackTunnelEventType;
                                                       const CallbackId: string;
                                                       Item: TDSCallbackItem);
var
  Event: TDSClientChannelEventItem;
begin
  TMonitor.Enter(FNotifyLock);
  try
    //If the tunnel is stopped and the event isn't a tunnel create, then ignore it.
    if FStopped and (EventType <> TunnelCreate) then
      Exit;

    //if the current event is a stop event, then mark the channel as stopped
    FStopped := (EventType = TunnelClose) or (EventType = TunnelClosedByServer);

    if Assigned(FChannelManagerEvent) then
    begin
      Event.EventType := EventType;
      Event.TunnelId := FManagerId;
      Event.Tunnel := Self;
      Event.TunnelChannelName := FChannelName;
      Event.CallbackId := CallbackId;
      Event.CallbackItem := Item;

      try
        FChannelManagerEvent(Self, Event);
      except
      end;
    end;
  finally
    TMonitor.Exit(FNotifyLock);
  end;
end;

function TDSClientCallbackChannelManager.NotifyObjectCallback(const CallbackId, ManagerId: string; const Msg: TObject;
                                                        out Response: TObject): Boolean;
var
  Status: Boolean;
  Resp: TJSONValue;
begin
  Status := false;
  try
    ExecuteRemote('DSAdmin', 'NotifyObject',
      procedure (Params: TDBXParameterList) begin
        Params[0].Value.AsString := ManagerId;
        Params[1].Value.AsString := CallbackId;
        Params[2].Value.SetJSONValue(MarshalData(Msg), True);
{$IFNDEF AUTOREFCOUNT}
        Msg.Free;
{$ENDIF !AUTOREFCOUNT}
      end,
      procedure (Params: TDBXParameterList) begin
        Resp := Params[3].Value.GetJSONValue;
        Status := Params[4].Value.AsBoolean;
      end);
    Response := UnMarshalJSON(Resp);
  finally
    Resp.Free
  end;
  Result := Status;
end;

function TDSClientCallbackChannelManager.GetCallbackIds: TArray<string>;
begin
  if FLocalCallbackRepo <> nil then
    Result := FLocalCallbackRepo.Keys.ToArray
  else
    Result := nil;
end;

function TDSClientCallbackChannelManager.GetCallbackItem(const CallbackId: string;
                                                         out Item: TDSCallbackItem): Boolean;
begin
  Result := False;
  Item := nil;

  if (FLocalCallbackRepo <> nil) and FLocalCallbackRepo.TryGetValue(CallbackId, Item) then
    Exit(True);
end;

function TDSClientCallbackChannelManager.GetIPImplementationID: string;
begin
  Result := FIPImplementationID;
end;

function TDSClientCallbackChannelManager.GetJSONMarshaler: TJSONMarshal;
begin
  // Get marshaller with registered converters
  Result := TJSONConverters.GetJSONMarshaler;
end;

function TDSClientCallbackChannelManager.GetJSONUnMarshaler: TJSONUnMarshal;
begin
  // Get unmarshaller with registered reverters
  Result := TJSONConverters.GetJSONUnMarshaler;
end;

procedure TDSClientCallbackChannelManager.AddConverter(event: TConverterEvent);
begin
  FRegConverters.Add(TJSONMarshal.ComposeKey(event.FieldClassType, event.FieldName), event);
end;

procedure TDSClientCallbackChannelManager.AddReverter(event: TReverterEvent);
begin
  FRegReverters.Add(TJSONMarshal.ComposeKey(event.FieldClassType, event.FieldName), event);
end;

function TDSClientCallbackChannelManager.MarshalData(Data: TObject): TJSONValue;
var
  marshal: TJSONMarshal;
begin
  marshal := GetJSONMarshaler;
  try
    Result := marshal.Marshal(Data);
  finally
    marshal.Free;
  end;
end;

function TDSClientCallbackChannelManager.UnMarshalJSON(Data: TJSONValue): TObject;
var
  unmarshal: TJSONUnMarshal;
begin
  unmarshal := GetJSONUnMarshaler;
  try
    Result := unmarshal.UnMarshal(Data);
  finally
    unmarshal.Free;
  end;
end;


function TDSClientCallbackChannelManager.RegisterCallback(const Callback: TDBXNamedCallback): Boolean;
begin
  Result := RegisterCallback('', Callback);
end;

procedure TDSClientCallbackChannelManager.SetIPImplementationID(
  const AIPImplementationID: string);
begin
  FIPImplementationID := AIPImplementationID;
end;

{ TDSClientCallbackChannelManager.TDSChannelCallback }

constructor TDSClientCallbackChannelManager.TDSChannelCallback.Create(
  const InvokeEvent: TDSChannelInvokeEvent;
  const InvokeObjectEvent: TDSChannelInvokeEvent;
  const BroadcastEvent: TDSChannelBroadcastEvent;
  const BroadcastObjectEvent: TDSChannelBroadcastEvent);
begin
  FInvokeEvent := InvokeEvent;
  FInvokeObjectEvent := InvokeObjectEvent;
  FBroadcastEvent := BroadcastEvent;
  FBroadcastObjectEvent := BroadcastObjectEvent;
end;

destructor TDSClientCallbackChannelManager.TDSChannelCallback.Destroy;
begin

  inherited;
end;

function TDSClientCallbackChannelManager.TDSChannelCallback.Execute(
  const Arg: TJSONValue): TJSONValue;
var
  Data: TJSONObject;
  Cmd: TJSONPair;
  ChannelPair: TJSONPair;
  ArgType: Integer;
  ChannelName: string;
begin
  if not (Arg is TJSONObject) then
    raise TDSServiceException.Create(SJSONValueNotObject);

  Data := TJSONObject(Arg);

  Cmd := Data.Get('invoke');
  if Cmd = nil then
    Cmd := Data.Get('broadcast');
  ChannelPair := Data.Get('channel');

  if (Cmd <> nil) and (AnsiCompareText('invoke', Cmd.JsonString.Value) = 0) then
  begin
    ArgType := ((Cmd.JsonValue as TJSONArray).Items[2] as TJSONNumber).AsInt;
    if ArgType = TDBXCallback.ArgObject then
      FInvokeObjectEvent((Cmd.JsonValue as TJSONArray).Items[0].Value, (Cmd.JsonValue as TJSONArray).Items[1],
                 Result)
    else
      FInvokeEvent((Cmd.JsonValue as TJSONArray).Items[0].Value, (Cmd.JsonValue as TJSONArray).Items[1],
                 Result);
  end
  else if (Cmd <> nil) and (AnsiCompareText('broadcast', Cmd.JsonString.Value) = 0) then
  begin
    //get the value of 'channel' if there is one, and pass it into the broadcast event
    if ChannelPair <> nil then
      ChannelName := ChannelPair.JsonValue.Value;

    ArgType := ((Cmd.JsonValue as TJSONArray).Items[1] as TJSONNumber).AsInt;
    if ArgType = TDBXCallback.ArgObject then
      FBroadcastObjectEvent((Cmd.JsonValue as TJSONArray).Items[0], ChannelName)
    else
      FBroadcastEvent((Cmd.JsonValue as TJSONArray).Items[0], ChannelName);
    Result := TJSONTrue.Create;
  end
  else
    raise TDSServiceException.Create(Format(SCommandNotImplemented, [Cmd.JsonString]));
end;

{ TDSClientCallbackChannelManager.TDSChannelThread }

constructor TDSClientCallbackChannelManager.TDSChannelThread.Create(
  Worker: TDSWorker; Manager: TDSClientCallbackChannelManager);
begin
  FWorker := Worker;
  FManager := Manager;
  FreeOnTerminate := False;
  inherited Create(False); // Suspended
end;

procedure TDSClientCallbackChannelManager.TDSChannelThread.Execute;
begin
  try
    FWorker
  finally
                     
    if (FManager <> nil) then
      FManager.NotifyChange(TunnelClosedByServer, EmptyStr, nil);
  end;
end;

{ TDSClientCallbackChannelManager.TDSExecuteThread }

constructor TDSClientCallbackChannelManager.TDSExecuteThread.Create(Callback: TDBXCallback; Data: TJSONValue);
begin
  FreeOnTerminate := False;
  FCallback := Callback;
  FData := Data;
  FResponse := nil;
  inherited Create;
end;

destructor TDSClientCallbackChannelManager.TDSExecuteThread.Destroy;
begin

  inherited;
end;

procedure TDSClientCallbackChannelManager.TDSExecuteThread.Execute;
begin
  inherited;
  TMonitor.Enter(FCallback);
  TMonitor.Exit(FCallback);
  try
    FResponse := FCallback.Execute(FData);
  finally
    if not Terminated then
      TMonitor.Pulse(FCallback);
  end;
end;

{ TDSCallbackItem }

constructor TDSCallbackItem.Create(ServerChannelName: string; Callback: TDBXCallback; Channels: TStrings);
begin
  FServerChannelName := ServerChannelName;
  FCallback := Callback;
  FChannels := Channels;
end;

constructor TDSCallbackItem.Create(ServerChannelName: string; Callback: TDBXCallback; Channels: string);
begin
  FServerChannelName := ServerChannelName;
  FCallback := Callback;
  FChannels := nil;

  if Channels <> EmptyStr then
  begin
    FChannels := TStringList.Create;
    FChannels.CommaText := Channels;
  end;
end;

destructor TDSCallbackItem.Destroy;
begin
  FreeAndNil(FCallback);
  FreeAndNil(FChannels);
  inherited;
end;

function TDSCallbackItem.ListeningOn(ChannelName: string): Boolean;
begin
  Result := (ChannelName = FServerChannelName) or
            ((FChannels <> nil) and (ChannelName <> '') and (FChannels.IndexOf(ChannelName) > -1));
end;

end.
