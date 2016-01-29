{*******************************************************}
{                                                       }
{               Delphi DBX Framework                    }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

/// <summary> DBX Client </summary>

unit Data.DbxSocketChannelNative;

{$Z+}

interface

uses
  Data.DBXCommon,
  System.SysUtils,
  Data.DBXTransport,
  IPPeerAPI,
  Data.DBXOpenSSL
{$IF DEFINED(WINDOWS) and not DEFINED(NEXTGEN)}
  , System.Win.ScktComp
{$ENDIF WINDOWS and not NEXTGEN}
;

type
  TDBXSocketChannel = class(TDBXChannel)
  strict private
    FCommLayer:   TDBXCommunicationLayer;
  protected
    function GetChannelInfo: TDBXChannelInfo; override;
  public
    constructor Create; overload;
    constructor Create( const id: Integer); overload;
    destructor Destroy; override;
    procedure Open; override;
    procedure Close; override;
    procedure Terminate;
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
  end;

{$IF DEFINED(WINDOWS) and not DEFINED(NEXTGEN)}
  TDBXTCPLayer = class(TDBXCommunicationLayer)
  strict private
    FTcpClient:   TClientSocket;
    FConnected: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Open(const DBXProperties: TDBXProperties); override;
    procedure Close; override;
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    procedure Terminate; override;
    function Info: string; override;
  end;
{$ENDIF WINDOWS and not NEXTGEN}

  TDBXIdTCPLayer = class(TDBXCommunicationLayer)
  strict private
    FIdSocket:  IIPTCPClient;
    FConnected: Boolean;
    FIPImplementationID: string;
  protected
    function ReadData(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer;
    function CreateClientSocket: IIPTCPClient; virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Open(const DBXProperties: TDBXProperties); override;
    procedure Close; override;
    function Read(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    function Write(const Buffer: TArray<Byte>; const Offset: Integer; const Count: Integer): Integer; override;
    procedure Terminate; override;
    function Info: string; override;
  end;

implementation

uses
  System.TypInfo, Data.DBXClientResStrs;

{ TDBXSocketChannel }

procedure TDBXSocketChannel.Close;
begin
  if FCommLayer <> nil then
  begin
    FCommLayer.Close;
    FreeAndNil(FCommLayer);
  end;
  FreeAndNil(FChannelInfo);
end;

procedure TDBXSocketChannel.Terminate;
begin
  FreeAndNil(FChannelInfo);
  if FCommLayer <> nil then
  begin
    FCommLayer.Terminate;
    try
      FreeAndNil(FCommLayer);
    except
      // ignore
    end;
  end;
end;

constructor TDBXSocketChannel.Create;
begin
  inherited Create;
end;

constructor TDBXSocketChannel.Create( const id: Integer);
begin
  inherited Create;
end;

destructor TDBXSocketChannel.Destroy;
begin
  Close;
  inherited Destroy;
end;

function TDBXSocketChannel.GetChannelInfo: TDBXChannelInfo;
begin
  Result := FChannelInfo;
end;

procedure TDBXSocketChannel.Open;
var
  CommProtocol: string;
begin
  Close;

  CommProtocol := DbxProperties[TDBXPropertyNames.CommunicationProtocol];
  if CommProtocol = '' then
    CommProtocol := 'tcp/ip'; // default communication layer

  // get communication layer from the communication factory
  FCommLayer := TDBXCommunicationLayerFactory.communicationLayer(CommProtocol);

  if FCommLayer = nil then
    raise TDBXError.Create(0, Format(SNoRegisteredLayer, [CommProtocol, TDBXCommunicationLayer.ClassName, TDBXCommunicationLayerFactory.ClassName]));

  FCommLayer.Open(DBXProperties);

  FChannelInfo := TDBXSocketChannelInfo.Create(0, FCommLayer.Info);
end;

function TDBXSocketChannel.Read(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
//  Assert(Offset = 0);
  Result := FCommLayer.Read(Buffer, Offset, Count);
end;

function TDBXSocketChannel.Write(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
//  Assert(Offset = 0);
  Result := FCommLayer.Write(Buffer, Offset, Count);
end;

{TDBXTCPLayer}

{$IF DEFINED(WINDOWS) and not DEFINED(NEXTGEN)}
procedure TDBXTCPLayer.Close;
begin
  if FTcpClient <> nil then
  begin
    if not Terminated then
    begin
      inherited Terminate;
      FTcpClient.Close;
    end;
    try
      FreeAndNil(FTcpClient);
    except on ESocketError do
      // nothing
    end;
  end;
end;

procedure TDBXTCPLayer.Terminate;
begin
  if not Terminated then
    FTcpClient.Socket.Close(true);
end;

constructor TDBXTCPLayer.Create;
begin
end;

destructor TDBXTCPLayer.Destroy;
begin
  Close;
end;

function TDBXTCPLayer.Info: string;
begin
  Result := FTcpClient.Address;
end;

procedure TDBXTCPLayer.Open(const DBXProperties: TDBXProperties);
var
  timeout: string;
  commTimeout: string;
begin
  Close;
  if FTcpClient = nil then
    FTcpClient := TClientSocket.Create(nil);
  FTcpClient.Host := DbxProperties[TDBXPropertyNames.HostName];
  FTcpClient.Port := DbxProperties.GetInteger(TDBXPropertyNames.Port);
  FTcpClient.ClientType := ctBlocking;

  timeout := DbxProperties[TDBXPropertyNames.ConnectTimeout];
  if timeout = '' then
    ConnectTimeout := 0
  else
    ConnectTimeout := StrToInt(timeout);
  commTimeout := DbxProperties[TDBXPropertyNames.CommunicationTimeout];
  if commTimeout = '' then
    CommunicationTimeout := 0
  else
    CommunicationTimeout := StrToInt(commTimeout);

  FConnected := false;

  FTcpClient.Open();
end;

function TDBXTCPLayer.Read(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
  if not FTcpClient.Socket.Connected then
    exit(-1);

  if FConnected and (CommunicationTimeout <> 0) then
  begin
    try
      TDBXScheduler.Instance.AddEvent(IntPtr(Pointer(Self)), procedure begin
          Terminate;
        end, CommunicationTimeout);
      try
        Result := FTcpClient.Socket.ReceiveBuf(Buffer[Offset], Count);
      finally
        if TDBXScheduler.Instance <> nil then
          TDBXScheduler.Instance.CancelEvent(IntPtr(Pointer(Self)))
      end
    except
      on E: Exception do
          raise TDBXError.Create(SCommunicationTimeout)
    end;
    if Terminated then
      raise TDBXError.Create(SCommunicationTimeout)
  end
  else if not FConnected and (ConnectTimeout <> 0) then
  begin
    try
      TDBXScheduler.Instance.AddEvent(IntPtr(Pointer(Self)), procedure begin
          if not FConnected then
            Terminate;
        end, ConnectTimeout);
      try
        Result := FTcpClient.Socket.ReceiveBuf(Buffer[Offset], Count);
      finally
        if TDBXScheduler.Instance <> nil then
          TDBXScheduler.Instance.CancelEvent(IntPtr(Pointer(Self)))
      end
    except
      on E: Exception do
          raise TDBXError.Create(SConnectionTimeout)
    end;
    FConnected := true;
    if Terminated then
      raise TDBXError.Create(SConnectionTimeout)
  end else
  begin
    Result := FTcpClient.Socket.ReceiveBuf(Buffer[Offset], Count);
  end;

  if Result = 0 then
    Result := -1; // we cannot have zero with blocking - close the communication
end;

function TDBXTCPLayer.Write(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
//  Assert(Offset = 0);
  if FTcpClient <> nil then
  begin
    FTcpClient.Socket.SendBuf(Buffer[Offset], Count);
    Result := Count
  end
  else
    Result := -1;
end;
{$ENDIF WINDOWS and not NEXTGEN}

{ TDBXIdTCPLayer }

procedure TDBXIdTCPLayer.Close;
begin
  if FIdSocket <> nil then
  begin
    if not Terminated then
    begin
      inherited Terminate;
      if FIdSocket.IOHandler <> nil then
        FIdSocket.IOHandler.Close;
    end;
    try
      FIdSocket := nil;
    except on Exception do
      // nothing
    end;
  end;
end;

constructor TDBXIdTCPLayer.Create;
begin
  inherited;
end;

function TDBXIdTCPLayer.CreateClientSocket: IIPTCPClient;
begin
  Result := PeerFactory.CreatePeer(FIPImplementationID, IIPTCPClient, nil) as IIPTCPClient;
end;

destructor TDBXIdTCPLayer.Destroy;
begin
  Close;
  inherited;
end;

function TDBXIdTCPLayer.Info: string;
begin
  Result := FIdSocket.BoundIP;
end;

procedure TDBXIdTCPLayer.Open(const DBXProperties: TDBXProperties);
var
  timeout: string;
  commTimeout: string;
  LIPVersionStr: string;
  LIPVersion: Integer;
begin
  Close;
  FIPImplementationID := DbxProperties[TDBXPropertyNames.IPImplementationID];
  if FIdSocket = nil then
    FIdSocket := CreateClientSocket;
  FIdSocket.Host := DbxProperties[TDBXPropertyNames.HostName];
  FIdSocket.Port := DbxProperties.GetInteger(TDBXPropertyNames.Port);

  LIPVersionStr := DbxProperties[TDBXPropertyNames.CommunicationIPVersion].Trim;
  LIPVersion := GetEnumValue(TypeInfo(TIPVersionPeer), LIPVersionStr);
  if LIPVersion > -1 then
    FIdSocket.IPVersion := TIPVersionPeer(LIPVersion)
  else
    FIdSocket.IPVersion := TIPVersionPeer.IP_IPv4;

  timeout := DbxProperties[TDBXPropertyNames.ConnectTimeout];
  if timeout = '' then
    ConnectTimeout := 0
  else
    ConnectTimeout := StrToInt(timeout);
  commTimeout := DbxProperties[TDBXPropertyNames.CommunicationTimeout];
  if commTimeout = '' then
    CommunicationTimeout := 0
  else
    CommunicationTimeout := StrToInt(commTimeout);

  FIdSocket.UseNagle := false;
  FIdSocket.Connect;

  FConnected := false;
end;

function TDBXIdTCPLayer.Read(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
  if Terminated then
    exit(-1);

  if FConnected and (CommunicationTimeout > 0) then
  begin
    try
      TDBXScheduler.Instance.AddEvent(IntPtr(Pointer(Self)), procedure begin
          Terminate;
        end, CommunicationTimeout);
      Result := ReadData(Buffer, Offset, Count);
      if TDBXScheduler.Instance <> nil then
        TDBXScheduler.Instance.CancelEvent(IntPtr(Pointer(Self)))
    except
      on E: Exception do
          raise TDBXError.Create(SCommunicationTimeout)
    end;
    if Terminated then
      raise TDBXError.Create(SCommunicationTimeout)
  end
  else if not FConnected and (ConnectTimeout > 0) then
  begin
    try
      TDBXScheduler.Instance.AddEvent(IntPtr(Pointer(Self)), procedure begin
          if not FConnected then
            Terminate;
        end, ConnectTimeout);
      Result := ReadData(Buffer, Offset, Count);
      if TDBXScheduler.Instance <> nil then
        TDBXScheduler.Instance.CancelEvent(IntPtr(Pointer(Self)))
    except
      on E: Exception do
          raise TDBXError.Create(SConnectionTimeout)
    end;
    if Terminated then
      raise TDBXError.Create(SConnectionTimeout)
  end
  else
    Result := ReadData(Buffer, Offset, Count);
  FConnected := true;
end;

function TDBXIdTCPLayer.ReadData(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
var
  idx, size, available, total: Integer;
  Buff: TIPBytesPeer;
begin
  idx := Offset;
  size := Count - 1;

  Buffer[idx] := FIdSocket.IOHandler.ReadByte;
  Inc(idx);
  total := 1;

  available := FIdSocket.IOHandler.InputBuffer.Size;
  while (size > 0) and (available > 0) do
  begin
    if size <= available then
      available := size;

    FIdSocket.IOHandler.ReadBytes(Buff, available, false);
    Move(Buff[0], Buffer[idx], available);
    idx := idx + available;
    total := total + available;
    size := size - available;
    available := FIdSocket.IOHandler.InputBuffer.Size;
  end;
  exit(total);
end;

procedure TDBXIdTCPLayer.Terminate;
begin
  if FIdSocket <> nil then
  begin
    if not Terminated then
    begin
      inherited Terminate;
      FIdSocket.IOHandler.Close;
    end;
  end;
end;

function TDBXIdTCPLayer.Write(const Buffer: TArray<Byte>; const Offset,
  Count: Integer): Integer;
begin
  if Terminated then
    exit(-1)
  else if FIdSocket <> nil then
  begin
    FIdSocket.IOHandler.Write(TIPBytesPeer(Buffer), Count, Offset);
    exit(Count);
  end
  else
    exit(-1);
end;

initialization
{$IF DEFINED(WINDOWS) and not DEFINED(NEXTGEN)}
  TDBXCommunicationLayerFactory.RegisterLayer('xtcp/ip', TDBXTCPLayer);
{$ENDIF WINDOWS and not NEXTGEN}
  TDBXCommunicationLayerFactory.RegisterLayer('tcp/ip', TDBXIdTCPLayer);
  TTransportFilterFactory.RegisterFilter(TTransportCypherFilter);
  TTransportFilterFactory.RegisterFilter(TRSAFilter);

finalization
{$IF DEFINED(WINDOWS) and not DEFINED(NEXTGEN)}
  TDBXCommunicationLayerFactory.UnregisterLayer('xtcp/ip');
{$ENDIF WINDOWS and not NEXTGEN}
  TDBXCommunicationLayerFactory.UnregisterLayer('tcp/ip');
  TTransportFilterFactory.UnregisterFilter(TTransportCypherFilter);
  TTransportFilterFactory.UnregisterFilter(TRSAFilter);

end.

