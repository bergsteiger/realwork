{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Datasnap.DSPlatform;

interface

uses
  Datasnap.DSCommonTable,
  Data.DBXCommon,
  Data.DBXJSON,
  System.Classes,
  System.JSON;

type
  {$MethodInfo ON}
  TDBXServerComponent = class(TComponent)
  private
    HasTunnelSessionEvent: Boolean;
    function ConsumeAllClientChannel(const ChannelName: string; const ChannelId: string;
                            const CallbackId: string; const SecurityToken: string; ChannelNames: TStringList;
                            ChannelCallback: TDBXCallback; Timeout: Cardinal): Boolean;
    function ConsumeOneClientChannel(const ChannelName, ClientManagerId, CallbackId: string;
                                     const SecurityToken: string; ChannelNames: TStringList;
                                     ResponseData: TJSONValue; Timeout: Cardinal): TJSONValue;
  protected
    /// <summary>Returns the name of the Server for the current instance of this component</summary>
    function GetDSServerName: string; virtual; abstract;
  public
    constructor Create(AOwner: TComponent); overload; override;
    constructor Create; reintroduce; overload; virtual;

    ///  <summary> Consume callback channel events one at a time </summary>
    ///  <remarks> Used mainly with JS API </remarks>
    function ConsumeClientChannel(const ChannelName, ClientManagerId, CallbackId, ChannelNames: string;
                                  const SecurityToken: string;
                                 ResponseData: TJSONValue): TJSONValue;
    function ConsumeClientChannelTimeout(const ChannelName, ClientManagerId, CallbackId: string;
                                         const ChannelNames, SecurityToken: string;
                                         Timeout: Integer; ResponseData: TJSONValue): TJSONValue;
    ///  <summary> Connects to the channel when the first callback registers with client manager
    ///  </summary>
    function ConnectClientChannel(const ChannelName: string; const ChannelId: string;
                            const CallbackId, ChannelNames, SecurityToken: string;
                            ChannelCallback: TDBXCallback): Boolean;
    function ConnectClientChannelTimeout(const ChannelName: string; const ChannelId: string;
                            const CallbackId, ChannelNames, SecurityToken: string;
                            ChannelCallback: TDBXCallback; Timeout: Integer): Boolean;
    ///  <summary> Closes the client channel </summary>
    function CloseClientChannel(const ChannelId, SecurityToken: string): Boolean;
    ///  <summary> Registers a new callback callback </summary>
    function RegisterClientCallback(const ChannelId: string;
                            const CallbackId, ChannelNames, SecurityToken: string; ChannelCallback: TDBXCallback): Boolean;
    function RegisterClientCallbackServer(const ChannelId: string;
                            const CallbackId, ChannelNames, SecurityToken: string): Boolean;
    ///  <summary> Unregisters the client callback </summary>
    function UnregisterClientCallback(const ChannelId: string;
                                      const CallbackId: string; const SecurityToken: string): Boolean;
    /// <summary> Broadcast a message to all of the registered callbacks of the given channel </summary>
    /// <remarks> Annotated with 'ChannelBroadcast' as the authorized role. </remarks>
    /// <param name="ChannelName">Name of the channel to notify all registered callbacks for</param>
    /// <param name="Msg">The message to broadcast</param>
    /// <returns>true if the broadcast was successful, false otherwise</returns>
    function BroadcastToChannel(const ChannelName: string; const Msg: TJSONValue): Boolean;
    function BroadcastObjectToChannel(const ChannelName: string; const Msg: TObject): Boolean;
    /// <summary> Notifies a client callback with the specified message </summary>
    /// <remarks> Annotated with 'ChannelNotify' as the authorized role. </remarks>
    /// <param name="ClientId"> The ChannelId of the client </param>
    /// <param name="CallbackId"> The Id of the callback on the client to notify </param>
    /// <param name="Msg">The message to notify with</param>
    /// <param name="Response">Output parameter containing the client's response value</param>
    /// <returns>true if the notification was successful, false otherwise</returns>
    function NotifyCallback(const ClientId: string;
                            const CallbackId: string;
                            const Msg: TJSONValue; out Response: TJSONValue): Boolean;
    function NotifyObject(const ClientId, CallbackId: string;
                          const Msg: TObject; out Response: TObject): Boolean;

  end;
  {$MethodInfo OFF}

  TDSPlatform = class
  public
    class function DefaultPackageName: string; static;
    class function DataSnapAdminClassName: string; static;
    class function DataSnapAdminUnitName: string; static;
    class function MetadataClassName: string; static;
    class function MetadataUnitName: string; static;
    class function PlatformName: string; static;
    class function GetDatabaseConnection(DBXContext: TDBXContext;
                                                ServerConnectionName: string;
                                                ConProperties: TDBXProperties
                                                ): TDBXConnection; static;
    class procedure GetConnectionProperties(Connections: TDSConnectionEntity); static;
  end;

implementation

uses
  Data.DBXCommonTable,
  Datasnap.DSCommonServer,
  Data.DBXMessageHandlerJSonServer,
  Datasnap.DSServer,
  Datasnap.DSSession,
  System.SysUtils;

{ TDSPlatform }

class function TDSPlatform.DataSnapAdminUnitName: string;
begin
  Result := 'DSCommonServer';
end;

class function TDSPlatform.DefaultPackageName: string;
begin
  Result := '';
end;

class procedure TDSPlatform.GetConnectionProperties(
  Connections: TDSConnectionEntity);
var
  Factory: TDBXConnectionFactory;
  Items: TStrings;
  Row: Integer;
  DriverName, Name: string;
  ConProperties: TDBXProperties;
  LProperties: TDBXProperties;
begin
  Factory := TDBXConnectionFactory.GetConnectionFactory;
  Items := TStringList.Create;
  try
    TDBXConnectionFactory.Lock;
    try
      Factory.GetConnectionItems(Items);
      for Row := 0 to Items.Count - 1 do
      begin
        Connections.Table.Insert;
        Name := Items[Row];
        Connections.ConnectionName := Name;
        ConProperties := Factory.GetConnectionProperties(Name);
        Connections.ConnectionProperties := ConProperties.Properties.DelimitedText;
        DriverName := ConProperties[TDBXPropertyNames.DriverName];
        Connections.DriverName := DriverName;
        if DriverName.Length > 0 then
        begin
          try
            LProperties := Factory.GetDriverProperties(DriverName);
            if LProperties <> nil then
              Connections.DriverProperties := LProperties.Properties.DelimitedText
          except on ex: Exception do
            Connections.DriverProperties := ex.Message;
          end;
        end;
        Connections.Table.Post;
      end;
    finally
      TDBXConnectionFactory.Unlock;
    end;
  finally
    Items.Free;
  end;
end;

class function TDSPlatform.GetDatabaseConnection(
  DBXContext: TDBXContext;
  ServerConnectionName: string;
  ConProperties: TDBXProperties
): TDBXConnection;
begin
  Result :=
  TDBXDriverHelp.GetConnection(
                                TDBXConnectionFactory.GetConnectionFactory,
                                DBXContext,
                                ServerConnectionName
                                );

end;

class function TDSPlatform.DataSnapAdminClassName: string;
begin
  Result := 'DSAdmin';
end;

class function TDSPlatform.PlatformName: string;
begin
  Result := 'win32';
end;

class function TDSPlatform.MetadataClassName: string;
begin
  Result := 'DSMetadata';
end;

class function TDSPlatform.MetadataUnitName: string;
begin
  Result := 'DSCommonServer';
end;

{ TDBXServerComponent }

constructor TDBXServerComponent.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasTunnelSessionEvent := False;
end;

function TDBXServerComponent.ConsumeAllClientChannel(const ChannelName,
  ChannelId, CallbackId, SecurityToken: string; ChannelNames: TStringList;
  ChannelCallback: TDBXCallback; Timeout: Cardinal): Boolean;
var
  ServerCallback: TDBXServerCallback;
  DSServer: TDSServer;
  CallbackTunnel: TDSCallbackTunnel;
  Msg: TJSONObject;
  Data: TJSONValue;
  ArgType: Integer;
  IsBroadcast: Boolean;
  IsAquired: Boolean;
  QueueMessage: TDSCallbackTunnelBufferItem;
  WasConnectionLost: Boolean;
  LSessionEvent: TDSSessionEvent;
  LSession: TDSSession;
  LSessionId: string;
begin
  WasConnectionLost := False;
  if ChannelCallback is TDBXCallbackDelegate then
  begin
    ServerCallback := (ChannelCallback as TDBXCallbackDelegate).Delegate as TDBXServerCallback;
    // get the server instance
    DSServer := ServerCallback.DsServer as TDSServer;
    // get the callback tunnel
    CallbackTunnel := DSServer.CreateChannelTunnel(ChannelName, ChannelId, CallbackId, ChannelNames, SecurityToken);
    if CallbackTunnel <> nil then
    begin
      //add a session event used to close this tunnel if the session closes
      LSession := TDSSessionManager.GetThreadSession;
      if LSession <> nil then
      begin
        LSessionId := LSession.SessionName;
        LSessionEvent :=
            procedure(Sender: TObject; const EventType: TDSSessionEventType;
                                       const Session: TDSSession)
            begin
              case EventType of
                SessionClose:
                begin
                  if LSessionId = Session.SessionName then
                                                                                         
                    TMonitor.Pulse(CallbackTunnel.Queue);
                end;
              end;
            end;
        TDSSessionManager.Instance.AddSessionEvent(LSessionEvent);
      end;

      try
        // wait for exit message
        repeat
          Data := nil;
          IsBroadcast := false;
          ArgType := TDBXCallback.ArgJson;

          QueueMessage := nil;

          TMonitor.Enter(CallbackTunnel.Queue);
          try
            {Wait for a queue item to be added if the queue is empty, otherwise
             don't wait and just pop the next queue item}
            if CallbackTunnel.Queue.QueueSize = 0 then
              IsAquired := TMonitor.Wait(CallbackTunnel.Queue, Timeout)
            else
              IsAquired := true;

            if IsAquired and (CallbackTunnel.Queue.QueueSize > 0) then
            begin
              {Get the next queued item from the tunnel}
              QueueMessage := CallbackTunnel.Queue.PopItem;
              Data := QueueMessage.Msg;
              IsBroadcast := QueueMessage.IsBroadcast;
              ArgType := QueueMessage.ArgType;
            end;
          finally
            TMonitor.Exit(CallbackTunnel.Queue);
          end;

          if IsAquired and (Data <> nil) then
          begin
            if IsBroadcast then
            begin
              try
                //if this is a broadcast, but has a callbackId specified, it is a selective broadcast,
                //to only one of the callbacks of the client.
                if QueueMessage.CallbackId <> EmptyStr then
                  Msg := TJSONObject.Create( TJSONPair.Create('invoke',
                         TJSONArray.Create( TJSONString.Create(QueueMessage.CallbackId),
                                            Data).Add(ArgType)))
                else
                begin
                  Msg := TJSONObject.Create(TJSONPair.Create('broadcast',
                                            TJSONArray.Create(Data).Add(ArgType)));
                end;

                if (QueueMessage.ChannelName <> EmptyStr) and
                   (QueueMessage.ChannelName <> CallbackTunnel.ServerChannelName) then
                  Msg.AddPair(TJSONPair.Create('channel', QueueMessage.ChannelName));

                try
                  ChannelCallback.Execute(Msg).Free;
                except
                  try
                    // Remove the callback tunnel from the list, it will be freed at the end of this method
                    InternalRemoveCallbackTunnel(DSServer, CallbackTunnel);
                  except
                  end;
                  raise;
                end;
              finally
                QueueMessage.InstanceOwner := false;
                FreeAndNil(QueueMessage);
              end;
            end
            else if Assigned(QueueMessage) then
            begin
              TMonitor.Enter(QueueMessage);
              try
                Msg := TJSONObject.Create( TJSONPair.Create('invoke',
                       TJSONArray.Create( TJSONString.Create(QueueMessage.CallbackId),
                                          Data).Add(ArgType)));
                try
                  QueueMessage.Response :=  ChannelCallback.Execute(Msg);
                except
                  on E : Exception do
                  begin
                    QueueMessage.IsError := True;
                    QueueMessage.Response := TJSONObject.Create(TJSONPair.Create('error', E.Message));
                    if ChannelCallback.ConnectionLost then
                    begin
                      WasConnectionLost := True;
                      TMonitor.Pulse(QueueMessage);
                      try
                        // Remove the callback tunnel from the list, it will be freed at the end of this method
                        InternalRemoveCallbackTunnel(DSServer, CallbackTunnel);
                      except
                      end;
                      Break;
                    end;
                  end;
                end;
                TMonitor.Pulse(QueueMessage);
              finally
                TMonitor.Exit(QueueMessage);
              end;
            end;
          end
          else
          begin
            try
              // Remove the callback tunnel from the list, it will be freed at the end of this method
              InternalRemoveCallbackTunnel(DSServer, CallbackTunnel);
            except
            end;
          end;
        until (not IsAquired) or (Data = nil);
      finally
        //remove the session event used to close the tunnel if the session closes
        if LSession <> nil then
          TDSSessionManager.Instance.RemoveSessionEvent(LSessionEvent);

        //if the connection wasn't lost then this must be the termination (nil) message, so free it
        //otherwise, the caller sending the message (who pushed it into the tunnel's queue) should free it
        if not WasConnectionLost then
          FreeAndNil(QueueMessage)
        else
        begin
          //loop over all remaining messages and pulse them. Free one if Data = nil (the termination message)
          //this is done so no messages are left in the queue waiting and so the termination message gets freed
          while CallbackTunnel.Queue.QueueSize > 0 do
          begin
            QueueMessage := CallbackTunnel.Queue.PopItem;
            if QueueMessage <> nil then
            begin
              TMonitor.Pulse(QueueMessage);
              if QueueMessage.Msg = nil then
                FreeAndNil(QueueMessage);
            end;
          end;
        end;

        // free the callback tunnel
        TDSCallbackTunnelManagerInternal(TDSCallbackTunnelManager.Instance).CloseChannelTunnel(CallbackTunnel);
      end;
      exit(true);
    end
    else
      exit(false);
  end
  else
    exit(false);
end;

function TDBXServerComponent.ConsumeClientChannel(const ChannelName, ClientManagerId,
  CallbackId, ChannelNames, SecurityToken: string; ResponseData: TJSONValue): TJSONValue;
begin
  Result := ConsumeClientChannelTimeout(ChannelName, ClientManagerId, CallbackId, ChannelNames,
                                        SecurityToken, -1, ResponseData);
end;

function TDBXServerComponent.ConsumeClientChannelTimeout(const ChannelName,
  ClientManagerId, CallbackId, ChannelNames, SecurityToken: string; Timeout: Integer;
  ResponseData: TJSONValue): TJSONValue;
var
  ms: Cardinal;
  LChannelNames: TStringList;
begin
  if Timeout < 0 then
    ms := INFINITE
  else
    ms := Timeout * 1000;

  LChannelNames := nil;

  //only build a list of channel names if a callback is beign registered and specifies some in CSV form
  if (CallbackId <> EmptyStr) and (ChannelNames <> EmptyStr) then
  begin
    LChannelNames := TStringList.Create;
    LChannelNames.CommaText := ChannelNames;
  end;

  try
    Result := ConsumeOneClientChannel(ChannelName, ClientManagerId, CallbackId,
                                      SecurityToken, LChannelNames, ResponseData, ms);
  finally
    FreeAndNil(LChannelNames);
  end;
end;

function TDBXServerComponent.ConsumeOneClientChannel(const ChannelName,
  ClientManagerId, CallbackId, SecurityToken: string; ChannelNames: TStringList; ResponseData: TJSONValue;
  Timeout: Cardinal): TJSONValue;
var
  DSServer: TDSServer;
  CallbackTunnel: TDSCallbackTunnel;
  Data: TJSONValue;
  IsBroadcast: Boolean;
  IsTimeout: Boolean;
  QueueMessage: TDSCallbackTunnelBufferItem;
  ArgType: Integer;
  StartupMessage: TDSCallbackTunnelBufferItem;
  Msg: TJSONObject;
  EmptyQueuePulsed: Boolean;
begin
  StartupMessage := nil;

  DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
  if DSServer <> nil then
  begin
    if CallbackId <> EmptyStr then
    begin
      // ignore data
      CallbackTunnel := DSServer.CreateChannelTunnel(ChannelName, ClientManagerId, CallbackId,
                                                     ChannelNames, SecurityToken);
      if CallbackTunnel = nil then
        exit(TJSONObject.Create( TJSONPair.Create('error',
                       TJSONString.Create(ChannelName+':'+ClientManagerId+':'+CallbackId))));

      Msg := TJSONObject.Create;
      Msg.AddPair(TJSONPair.Create('created', TJSONTrue.Create));
      StartupMessage := TDSCallbackTunnelBufferItem.Create(ChannelName, CallbackId, False, Msg, TDBXCallback.ArgJson);
    end
    else
    begin
      CallbackTunnel := DSServer.CallbackTunnelOf(ClientManagerId);

      //set the state of the tunnel as waiting on the server side. (no message sent to client yet)
      if (CallbackTunnel <> nil) then
      begin
        //pulse the queue, to free a previously waiting tunnel, if one exists
        if CallbackTunnel.State = ctsWaitingOnServer then
          TMonitor.Pulse(CallbackTunnel.Queue);
        CallbackTunnel.State := ctsWaitingOnServer;
      end;

      if (CallbackTunnel <> nil) and (CallbackTunnel.ThinPop <> nil) then
      begin
        if not CallbackTunnel.ThinPop.IsBroadcast then
        begin
          if not Assigned(ResponseData) then
            CallbackTunnel.ThinPop.Response := TJSONNull.Create
          else
            CallbackTunnel.ThinPop.Response := ResponseData.Clone as TJSONValue;
          TMonitor.Pulse(CallbackTunnel.ThinPop)
        end
        else
        begin
          CallbackTunnel.ThinPop.Free;
          CallbackTunnel.ThinPop := nil;
        end;
      end
      else if (CallbackTunnel = nil) then
        exit(TJSONObject.Create( TJSONPair.Create('error',
                       TJSONString.Create(ChannelName+':'+ClientManagerId))));
    end;

    Data := nil;
    IsBroadcast := false;
    QueueMessage := nil;
    ArgType := TDBXCallback.ArgJson;

    TMonitor.Enter(CallbackTunnel.Queue);
    try
      {Wait for a queue item to be added if the queue is empty}
      if (StartupMessage = nil) and (CallbackTunnel.Queue.QueueSize = 0) then
        IsTimeout := not TMonitor.Wait(CallbackTunnel.Queue, Timeout)
      else
        IsTimeout := False;

      //the queue is empty, there is no first message, and waiting on a message didn't time out,
      //so the tunnel must have been re-issued by the client.
      EmptyQueuePulsed := (not CallbackTunnel.Queue.ShutDown) and (not IsTimeout) and (StartupMessage = nil) and (CallbackTunnel.Queue.QueueSize = 0);

      if (not IsTimeout) and ((StartupMessage <> nil) or (CallbackTunnel.Queue.QueueSize > 0)) then
      begin
        if StartupMessage <> nil then
          QueueMessage := StartupMessage
        else
          QueueMessage := CallbackTunnel.Queue.PopItem;

        if Assigned(QueueMessage) then
        begin
          if StartupMessage = nil then
            CallbackTunnel.ThinPop := QueueMessage;
          Data := QueueMessage.Msg;
          //nil the message, as it will be memory managed by the response being sent
          QueueMessage.Msg := nil;
          IsBroadcast := QueueMessage.IsBroadcast;
          ArgType := QueueMessage.ArgType;
        end;
      end
    finally
      TMonitor.Exit(CallbackTunnel.Queue);
    end;

    //When an empty queue is pulsed, this means that a second thread is trying to reestablish this tunne.
    //usually that means the client has disconnected and is reconnecting and reestablishing the tunnel.
    //when this happens, the first tunnel HTTP response should be abandoned.
    if EmptyQueuePulsed then
      exit(TJSONObject.Create(TJSONPair.Create('error', TJSONString.Create('tunnel_replaced'))));

    try
      if IsBroadcast and (Data <> nil) then
      begin
        //call invoke if a CallbackId is specified, to invoke just that callback, but to ignore
        //the client's response
        if QueueMessage.CallbackId <> EmptyStr then
          Msg := TJSONObject.Create( TJSONPair.Create('invoke',
                                     TJSONArray.Create( TJSONString.Create(QueueMessage.CallbackId),
                                                        Data).Add(ArgType)))
        else
          Msg := TJSONObject.Create(TJSONPair.Create('broadcast',
                                    TJSONArray.Create(Data).Add(ArgType)) );

        if (QueueMessage.ChannelName <> EmptyStr) and
             (QueueMessage.ChannelName <> CallbackTunnel.ServerChannelName) then
          Msg.AddPair(TJSONPair.Create('channel', QueueMessage.ChannelName));

        //signify we are now waiting for the client to respond
        CallbackTunnel.State := ctsWaitingForClient;
        exit(Msg);
      end
      else if (QueueMessage <> nil) and (Data <> nil) then
      begin
        //signify we are now waiting for the client to respond
        CallbackTunnel.State := ctsWaitingForClient;
        exit( TJSONObject.Create( TJSONPair.Create('invoke',
                         TJSONArray.Create( TJSONString.Create(QueueMessage.CallbackId),
                                            Data).Add(ArgType))));
      end
      else
      begin
        //note that in this case, the tunnel is closing, so we aren't waiting for the client.
        //setting this state here just to make it clear. It should already be in this state.
        CallbackTunnel.State := ctsWaitingOnServer;

        if (QueueMessage <> nil) then
        begin
          if QueueMessage = CallbackTunnel.ThinPop then
            CallbackTunnel.ThinPop := nil;
          QueueMessage.InstanceOwner := true;
          FreeAndNil(QueueMessage);
        end;
        TDSCallbackTunnelManagerInternal(TDSCallbackTunnelManager.Instance).CloseChannelTunnel(CallbackTunnel);
        if IsTimeout then
          exit(TJSONObject.Create( TJSONPair.Create('timeout', TJSONTrue.Create)))
        else
          exit( TJSONObject.Create( TJSONPair.Create('close', TJSONTrue.Create)))
      end;
    finally
      FreeAndNil(StartupMessage);
    end;
  end
  else
    exit( TJSONObject.Create( TJSONPair.Create('error', TJSONString.Create(GetDSServerName()))));
end;

function TDBXServerComponent.BroadcastToChannel(const ChannelName: string; const Msg: TJSONValue): Boolean;
var
  DSServer: TDSServer;
begin
  DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
  if DSServer <> nil then
    exit(DSServer.BroadcastMessage(ChannelName, TJSONValue(Msg.Clone)))
  else
    exit(false);
end;

function TDBXServerComponent.BroadcastObjectToChannel(const ChannelName: string; const Msg: TObject): Boolean;
var
  DSServer: TDSServer;
begin
  DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
  if DSServer <> nil then
    exit(DSServer.BroadcastObject(ChannelName, Msg))
  else
    exit(false);
end;

function TDBXServerComponent.NotifyCallback(const ClientId, CallbackId: string;
                                            const Msg: TJSONValue; out Response: TJSONValue): Boolean;
var
  DSServer: TDSServer;
begin
  DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
  if DSServer <> nil then
    exit(DSServer.NotifyCallback(ClientId, CallbackId, TJSONValue(Msg.Clone), Response))
  else
    exit(false);
end;

function TDBXServerComponent.NotifyObject(const ClientId, CallbackId: string;
                                            const Msg: TObject; out Response: TObject): Boolean;
var
  DSServer: TDSServer;
begin
  DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
  if DSServer <> nil then
    exit(DSServer.NotifyObject(ClientId, CallbackId, Msg, Response))
  else
    exit(false);
end;

function TDBXServerComponent.CloseClientChannel(const ChannelId, SecurityToken: string): Boolean;
var
  DSServer: TDSServer;
begin
    // get the server instance
    DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
    if DSServer <> nil then
    begin
      try
        DSServer.UnregisterChannelCallback(ChannelId, SecurityToken, false);
      except
        exit(false);
      end;
      exit(true)
    end
    else
      exit(false);
end;

function TDBXServerComponent.ConnectClientChannel(const ChannelName, ChannelId,
  CallbackId, ChannelNames, SecurityToken: string; ChannelCallback: TDBXCallback): Boolean;
var
  LChannelNames: TStringList;
begin
  LChannelNames := TStringList.Create;
  LChannelNames.CommaText := ChannelNames;

  try
    Result := ConsumeAllClientChannel(ChannelName, ChannelId, CallbackId, SecurityToken, LChannelNames,
                                      ChannelCallback, INFINITE);
  finally
    FreeAndNil(LChannelNames);
  end;
end;

function TDBXServerComponent.ConnectClientChannelTimeout(const ChannelName,
  ChannelId, CallbackId, ChannelNames, SecurityToken: string; ChannelCallback: TDBXCallback;
  Timeout: Integer): Boolean;
var
  ms: Cardinal;
  LChannelNames: TStringList;
begin
  if Timeout < 0 then
    ms := INFINITE
  else
    ms := Timeout * 1000;

  LChannelNames := TStringList.Create;
  LChannelNames.CommaText := ChannelNames;

  try
    Result := ConsumeAllClientChannel(ChannelName, ChannelId, CallbackId, SecurityToken, LChannelNames,
                                      ChannelCallback, ms);
  finally
    FreeAndNil(LChannelNames);
  end;
end;

constructor TDBXServerComponent.Create;
begin
  inherited Create(nil);
  HasTunnelSessionEvent := False;
end;

function TDBXServerComponent.RegisterClientCallback(const ChannelId, CallbackId, ChannelNames, SecurityToken: string;
                                                    ChannelCallback: TDBXCallback): Boolean;
var
  ServerCallback: TDBXServerCallback;
  DSServer: TDSServer;
  LChannelNames: TStringList;
begin
  if ChannelCallback is TDBXCallbackDelegate then
  begin
    ServerCallback := (ChannelCallback as TDBXCallbackDelegate).Delegate as TDBXServerCallback;
    // get the server instance
    DSServer := ServerCallback.DsServer as TDSServer;

    LChannelNames := TStringList.Create;
    LChannelNames.CommaText := ChannelNames;

    try
      exit(DSServer.RegisterChannelCallback(ChannelId, CallbackId, LChannelNames, SecurityToken));
    finally
      FreeAndNil(LChannelNames);
    end;
  end
  else
    exit(false)
end;

function TDBXServerComponent.RegisterClientCallbackServer(const ChannelId, CallbackId, ChannelNames,
                                                          SecurityToken: string): Boolean;
var
  DSServer: TDSServer;
  LChannelNames: TStringList;
begin
  DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
  if DSServer <> nil then
    try
      LChannelNames := TStringList.Create;
      LChannelNames.CommaText := ChannelNames;
      try
        exit(DSServer.RegisterChannelCallback(ChannelId, CallbackId, LChannelNames, SecurityToken));
      finally
        FreeAndNil(LChannelNames);
      end;
    except
    end;
  exit(false);
end;

function TDBXServerComponent.UnregisterClientCallback(const ChannelId, CallbackId, SecurityToken: string): Boolean;
var
  DSServer: TDSServer;
begin
  DSServer := TDSServer.FindServer(GetDSServerName()) as TDSServer;
  if DSServer <> nil then
  begin
    try
      DSServer.UnregisterChannelCallback(ChannelId, CallbackId, SecurityToken);
    except
      exit(false);
    end;
    exit(true);
  end;
  exit(false)
end;

initialization
  RegisterClass(DSAdmin);
  RegisterClass(DSMetadata);

end.
