{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Tether.BluetoothAdapter;

interface

{$IFNDEF IOS}
  {$DEFINE BT_PLATFORM}
{$ENDIF}

{$IFDEF BT_PLATFORM}

{$SCOPEDENUMS ON}

uses
  System.SyncObjs, System.Tether.Manager, System.Tether.Comm;

type
  TTetheringBluetoothAdapter = class;

  TTetheringBluetoothManagerCommunicationThread = class(TTetheringManagerCommunicationThread)
  private const
    TTetheringBTBaseUUID: TGUID = '{00000000-62CC-0000-BBBF-BF3E3BBB1374}';
    MAXCONNECTIONS = 10;
  private
    FServerComm: TTetheringBTServerComm;
    FClientComm: TTetheringBTComm;
    FLastConnection: string;

    procedure DoOnExecute(const AConnection: TTetheringCustomComm);
    procedure DoOnConnect(const AConnection: TTetheringCustomComm);
    procedure DoOnDisconnect(const AConnection: TTetheringCustomComm);

  protected
    function ProcessResponse(const AData: string; var RemoteConnectionString: string): string; override;
    procedure DoSendCommand(const AConnection, AData: string); override;
    function IsListening: Boolean; override;
  public
    constructor Create(const AnAdapter: TTetheringAdapter); override;
    destructor Destroy; override;
    procedure Execute; override;
  end;

  TTetheringBluetoothAdapter = class(TTetheringAdapter)
  public const
    MaxBluetoothConnections = 6;
    AdapterID = 'Bluetooth';  // do not localize
  private
    [Weak] FCommunicationThread: TTetheringBluetoothManagerCommunicationThread;

  protected
    function GetAutomaticTimeout: Cardinal; override;
    procedure DoDiscoverManagers(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts); override;

    function GetAdapterType: TTetheringAdapterType; override;
    function DoCreateCommunicationThread(const AnAdapter: TTetheringAdapter): TTetheringManagerCommunicationThread; override;
    procedure DoStopListening; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    class function CreateInstance: TTetheringAdapter; override;
    function GetClientPeer(const ProtocolId: TTetheringProtocolType): TTetheringCustomComm; override;
    function GetServerPeer(const ProtocolId: TTetheringProtocolType): TTetheringCustomServerComm; override;

    function MaxConnections: Integer; override;
    function GetTargetConnection(const Port, Offset: Integer): string; override;
  end;

{$ENDIF BT_PLATFORM}

implementation

{$IFDEF BT_PLATFORM}
uses
  System.SysUtils, System.Tether.Consts, System.Tether.TCPProtocol, System.Bluetooth;


{ TTetheringBluetoothManagerCommunicationThread }

constructor TTetheringBluetoothManagerCommunicationThread.Create(const AnAdapter: TTetheringAdapter);
begin
  inherited Create(AnAdapter);
  FServerComm := TTetheringBTServerComm.Create;
  FClientComm := TTetheringBTComm.Create;
end;

destructor TTetheringBluetoothManagerCommunicationThread.Destroy;
begin
  FClientComm.Free;
  FServerComm.Free;
  inherited;
end;

procedure TTetheringBluetoothManagerCommunicationThread.DoOnConnect(const AConnection: TTetheringCustomComm);
begin
end;

procedure TTetheringBluetoothManagerCommunicationThread.DoOnDisconnect(const AConnection: TTetheringCustomComm);
begin
end;

procedure TTetheringBluetoothManagerCommunicationThread.DoOnExecute(const AConnection: TTetheringCustomComm);
var
  RespOk: TBytes;
  LCommand: TBytes;
  LStrCommand: string;
  LCommands: TArray<string>;
begin
  LCommand := AConnection.ReadData;
  RespOk := [Ord('O'), Ord('k')];
  AConnection.WriteData(RespOk);
  LStrCommand := TEncoding.UTF8.GetString(LCommand);
  LCommands := TTetheringManagerCommand.Split(LStrCommand, TetheringCommandSeparator);
  for LStrCommand in LCommands do
  begin
    if LStrCommand <> '' then
      FCommandQueue.Enqueue(LStrCommand);
  end;
end;

procedure TTetheringBluetoothManagerCommunicationThread.Execute;
const
  Retries = 3;
var
  I: Integer;
  LGUID: TGUID;
  Resp: string;
  RemoteConnectionString: string;
begin
  inherited;

  FServerComm.OnExecute := DoOnExecute;
  FServerComm.OnConnect := DoOnConnect;
  FServerComm.OnDisconnect := DoOnDisconnect;

  for I := 1 to Retries do
  begin
    LGUID := TTetheringBTBaseUUID;
    LGUID.D1 := Cardinal(Pointer(FAdapter));
    LGUID.D3 := Random(65535);
    FServerComm.Target := LGUID.ToString;
    if FServerComm.StartServer then
      Break;
  end;

  TTetheringBluetoothAdapter(FAdapter).SetLocalConnectionString(TBluetoothManager.Current.CurrentAdapter.Address +
    TetheringConnectionSeparator + FServerComm.Target);

  CommunicationThreadInitialized;
  if not FServerComm.Active then
    raise ETetheringException.Create(SManagerBluetoothCreation);


  while not Terminated do
  begin
    FCommandQueue.WaitCommand;
    while not Terminated and (FCommandQueue.Count > 0) do
    begin
      try
        Resp := ProcessResponse(FCommandQueue.Dequeue, RemoteConnectionString);
        if not Terminated then
          SendCommand(RemoteConnectionString, Resp);
      except
      end;
    end;
  end;

end;

function TTetheringBluetoothManagerCommunicationThread.IsListening: Boolean;
begin
  Result := FServerComm.Active;
end;

function TTetheringBluetoothManagerCommunicationThread.ProcessResponse(const AData: string;
  var RemoteConnectionString: string): string;
begin
  Result := inherited ProcessResponse(AData, RemoteConnectionString);
end;

procedure TTetheringBluetoothManagerCommunicationThread.DoSendCommand(const AConnection, AData: string);
const
  Retries = 3;
var
  I: Integer;
begin
  inherited;
  if AData <> TetheringEmpty then
  begin
    TMonitor.Enter(FClientComm);
    try
      for I := 1 to Retries do
      begin
        if FLastConnection <> AConnection then
        begin
          if FClientComm.Connected then
            FClientComm.Disconnect;
          FClientComm.Connect(AConnection);

          if FClientComm.Connected then
            FLastConnection := AConnection
          else
            FLastConnection := '';
        end;
        if FClientComm.Connected then
        begin
          try
            FClientComm.WriteData(TEncoding.UTF8.GetBytes(AData));
            FClientComm.ReadData;
          except
            FLastConnection := '';
          end;
          Break;
        end
        else
          FLastConnection := '';
      end;
    finally
      TMonitor.Exit(FClientComm);
    end;
  end;
end;

{ TTetheringBluetoothAdapter }

constructor TTetheringBluetoothAdapter.Create;
begin
  inherited;

end;

class function TTetheringBluetoothAdapter.CreateInstance: TTetheringAdapter;
var
  LBTManager: TBluetoothManager;
  LBTAdapter: TBluetoothAdapter;
begin
  Result := nil;
  // Before creating an instance we need to ensure that BT is present
  LBTManager := TBluetoothManager.Current;
  if LBTManager <> nil then
    if LBTManager.ConnectionState = TBluetoothConnectionState.Connected then
    begin
      LBTAdapter := LBTManager.CurrentAdapter;
      if LBTAdapter <> nil then
        Result := TTetheringBluetoothAdapter.Create;
    end;
end;

destructor TTetheringBluetoothAdapter.Destroy;
begin
  inherited;
end;

procedure TTetheringBluetoothAdapter.DoDiscoverManagers(Timeout: Cardinal; const ATargetList: TTetheringTargetHosts);

  function DeviceInTarget(const ADevice: TBluetoothDevice; const ATargetArray: TArray<string>): Boolean;
  var
    LTarget: string;
  begin
    Result := False;
    for LTarget in ATargetArray do
      if SameText(ADevice.Address, LTarget) or SameText(ADevice.DeviceName, LTarget) then
      begin
        Result := True;
        Break;
      end;
  end;

  function IsTTetheringManager(const AGUIDString: string): Boolean;
  var
    LGUID: TGUID;
  begin
    LGUID := TGUID.Create(AGUIDString);
    LGUID.D1 := 0;
    LGUID.D3 := 0;

    Result := LGUID = TTetheringBluetoothManagerCommunicationThread.TTetheringBTBaseUUID;
  end;

  procedure SendDiscoverCommand(const ADevice: TBluetoothDevice; const AService: TBluetoothService);
  var
    LUUID: TGUID;
    LClientComm: TTetheringBTComm;
    I: Integer;
    LBuff: TBytes;
    LServers: TArray<string>;
  begin
    LUUID := AService.UUID;
    LUUID.D1 := 0;
    LUUID.D3 := 0;

    // Try to find BT Server to get registered servers
    if LUUID = TTetheringBTServerComm.BTServerBaseUUID then
    begin
      LClientComm := TTetheringBTComm.Create;
      try
        try
          if not LClientComm.Connect(ADevice.DeviceName + TetheringConnectionSeparator + AService.UUID.ToString) then
            Exit;
        except
          Exit;
        end;
        try
          LBuff := LClientComm.ReadData;
        except
        end;
        if Length(LBuff) > 0 then
        begin
          LClientComm.WriteData(TEncoding.UTF8.GetBytes('ok'));
          LServers := TEncoding.UTF8.GetString(LBuff).Split([TetheringConnectionSeparator]);
        end
        else
          LClientComm.WriteData(TEncoding.UTF8.GetBytes('error'));
      finally
        LClientComm.Free;
      end;

      for I := 0 to High(LServers) do
      begin
        if IsTTetheringManager(LServers[I]) then
        begin
          FCommunicationThread.SendCommand(ADevice.Address + TetheringConnectionSeparator + LServers[I],
            FCommunicationThread.CommandStr(TTetheringBluetoothManagerCommunicationThread.TetheringDiscoverManagers,
              Manager.Version, [LServers[I]]));
        end;
      end;
    end;
  end;

var
  LDevice: TBluetoothDevice;
  LService: TBluetoothService;
  LDeviceList: TBluetoothDeviceList;
begin
  LDeviceList := TBluetoothManager.Current.GetPairedDevices;
  if Length(ATargetList) = 0 then
  begin
    for LDevice in LDeviceList do
    begin
      for LService in LDevice.GetServices do
        SendDiscoverCommand(LDevice, LService);
    end;
  end
  else
  begin
    for LDevice in LDeviceList do
    begin
      if DeviceInTarget(LDevice, ATargetList) then
      begin
        for LService in LDevice.GetServices do
          SendDiscoverCommand(LDevice, LService);
      end;
    end;
  end;
end;

function TTetheringBluetoothAdapter.DoCreateCommunicationThread(const AnAdapter: TTetheringAdapter): TTetheringManagerCommunicationThread;
begin
  inherited;
  Result := TTetheringBluetoothManagerCommunicationThread.Create(Self);
  FCommunicationThread := TTetheringBluetoothManagerCommunicationThread(Result); // The Adapter is responsible of releasing it
end;

procedure TTetheringBluetoothAdapter.DoStopListening;
begin
  inherited;
end;

function TTetheringBluetoothAdapter.GetAdapterType: TTetheringAdapterType;
begin
  Result := AdapterID;
end;

function TTetheringBluetoothAdapter.GetAutomaticTimeout: Cardinal;
begin
  Result := 2000 + TBluetoothManager.Current.GetPairedDevices.Count * 8500;
end;

function TTetheringBluetoothAdapter.GetClientPeer(const ProtocolId: TTetheringProtocolType): TTetheringCustomComm;
begin
  Result := TTetheringBTComm.Create;
end;

function TTetheringBluetoothAdapter.GetServerPeer(const ProtocolId: TTetheringProtocolType): TTetheringCustomServerComm;
begin
  Result := TTetheringBTServerComm.Create;
end;

function TTetheringBluetoothAdapter.GetTargetConnection(const Port, Offset: Integer): string;
var
  LGUID: TGUID;
begin
  LGUID := TTetheringBluetoothManagerCommunicationThread.TTetheringBTBaseUUID;
  LGUID.D1 := Cardinal(Pointer(Self));
  LGUID.D2 := LGUID.D2 + $11 + Offset;
  LGUID.D3 := $FFFF and (Random(65535) + Port);
  Result := LGUID.ToString;
end;

function TTetheringBluetoothAdapter.MaxConnections: Integer;
begin
  Result := MaxBluetoothConnections;
end;

initialization
  TTetheringAdapters.RegisterAdapter(TTetheringBluetoothAdapter, TTetheringBluetoothAdapter.AdapterID);

finalization
  TTetheringAdapters.UnRegisterAdapter(TTetheringBluetoothAdapter.AdapterID);

{$ENDIF BT_PLATFORM}
end.
