{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Tether.TCPProtocol;

interface
{$SCOPEDENUMS ON}

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Tether.Manager, System.Tether.Comm;

type
  TTetheringTCPProtocol = class(TTetheringProtocol)
  private type
    TConnectionPair = TPair<string, TTetheringCustomComm>;
  public const
    ProtocolID = 'TCP'; // do not localize
  private const
    ReadTimeout = 200;
  private
    FTCPClient: TTetheringCustomComm;
    [Weak] FTCPResponseClient: TTetheringCustomComm;

    FTCPServer: TTetheringCustomServerComm;
    FImplementationID: string;
    FActiveTarget: string;
    FAsClient: Boolean;
    procedure DoOnExecute(const AConnection: TTetheringCustomComm);
    procedure DoOnConnect(const AConnection: TTetheringCustomComm);
    procedure DoOnDisconnect(const AConnection: TTetheringCustomComm);
    procedure StartServerSide;
  protected
    function GetProtocolType: TTetheringProtocolType; override;
    function GetIsConnected: Boolean; override;
    procedure DoSendData(const AData: TBytes); override;
    function DoReceiveData: TBytes; override;
    /// <summary>Function to Receive a stream.</summary>
    function DoReceiveStream(const AStream: TStream): Boolean; override;
    /// <summary>Function to Send a stream.</summary>
    function DoSendStream(const AStream: TStream): Boolean; override;
  public
    constructor Create(const AnAdapter: TTetheringAdapter; AsClient: Boolean = False); override;
    destructor Destroy; override;
    procedure StopCommunication; override;
    procedure StartCommunication; override;
    function Connect(const AProfile: TTetheringConnection): Boolean; override;
    procedure Disconnect; override;
    function GetConnectionString(const ManagerConnectionString: string): string; override;
    class function CreateInstance(const AnAdapter: TTetheringAdapter; AsClient: Boolean): TTetheringProtocol; override;
  end;


implementation

uses
  System.Tether.Consts;

type
  TFakeProfile = class(TTetheringProfile);
  TFakeAdapter = class(TTetheringAdapter);

{ TTetheringTCPProtocol }

function TTetheringTCPProtocol.Connect(const AProfile: TTetheringConnection): Boolean;
const
  OkResponse = 'Ok'; // do not localize
var
  SepPos: Integer;
  ClientToken: string;
  ManagerID: string;
  RandomString: string;
  ServerToken: string;
begin
  SepPos := AProfile.ConnectionString.IndexOf(TetheringConnectionSeparator);
  if SepPos > 0 then
  begin
    Result := FTCPClient.Connect(AProfile.ConnectionString);
    if Result then
    begin
      RandomString := ReceiveStringData;
      if RandomString <> OkResponse then
      begin
        ManagerID := FAdapter.Manager.Identifier;
        SendData(ManagerID);
        ManagerID := ReceiveStringData;
        ClientToken := GenerateToken(ManagerID, RandomString);
        SendData(TEncoding.UTF8.GetBytes(ClientToken));
        ServerToken := ReceiveStringData;
        if ServerToken <> OkResponse then
        begin
          FTCPClient.Disconnect;
          Result := False;
        end;
      end;
    end;
  end
  else
    Result := False;
end;

procedure TTetheringTCPProtocol.StopCommunication;
begin
  try
    if (FTCPClient <> nil) and FTCPClient.Connected then
      FTCPClient.Disconnect;
  except
  end;
  if not FAsClient then
  begin
    if (FTCPServer <> nil) then
    begin
      try
        FTCPServer.StopServer;
      except
      end;
      FreeAndNil(FTCPServer);
    end;
  end;
end;

procedure TTetheringTCPProtocol.StartCommunication;
begin
  if FTCPClient = nil then
  begin
    FTCPClient := FAdapter.GetClientPeer(ProtocolID);
    FTCPClient.OnAfterReceiveData := OnAfterReceiveData;
    FTCPClient.OnBeforeSendData := OnBeforeSendData;
    FTCPClient.OnAfterReceiveStream := OnAfterReceiveStream;
    FTCPClient.OnBeforeSendStream := OnBeforeSendStream;
    FTCPResponseClient := FTCPClient;
  end;
  if not FAsClient then
  begin
    if (FTCPServer = nil) or ((FTCPServer <> nil) and not FTCPServer.Active) then
      StartServerSide;
  end;
end;

constructor TTetheringTCPProtocol.Create(const AnAdapter: TTetheringAdapter; AsClient: Boolean = False);
begin
  inherited;
  FAdapter := AnAdapter;
  FImplementationID := '';
  FAsClient := AsClient;
end;

class function TTetheringTCPProtocol.CreateInstance(const AnAdapter: TTetheringAdapter; AsClient: Boolean): TTetheringProtocol;
begin
  Result := TTetheringTCPProtocol.Create(AnAdapter, AsClient);
end;

destructor TTetheringTCPProtocol.Destroy;
begin
  FTCPResponseClient := nil;
  try
    if (FTCPClient <> nil) and FTCPClient.Connected then
      FTCPClient.Disconnect;
  except
  end;

  FTCPCLient.Free;
  if (not FAsClient) and (FTCPServer <> nil) then
  begin
    try
      FTCPServer.StopServer;
    except
    end;
    FTCPServer.Free;
  end;

  inherited;
end;

procedure TTetheringTCPProtocol.Disconnect;
begin
  FTCPClient.Disconnect;
end;

procedure TTetheringTCPProtocol.DoOnConnect(const AConnection: TTetheringCustomComm);
const
  OkResponse = 'Ok'; // do not localize
  ErrorResponse = 'Error'; // do not localize
var
  ServerToken, ClientToken: string;
  RandomString: string;
  ClientManagerID: string;
  ServerManagerID: string;

  function InternalReadData: string;
  begin
    Result := TEncoding.UTF8.GetString(AConnection.ReadData);
  end;

  procedure InternalSendData(const StrData: string);
  begin
    AConnection.WriteData(TEncoding.UTF8.GetBytes(StrData));
  end;

begin
  if FAdapter.Manager.Password = '' then
    InternalSendData(OkResponse)
  else
  begin
    RandomString := GetRandomString;
    InternalSendData(RandomString);
    ClientManagerID := InternalReadData;
    ServerToken := GenerateToken(ClientManagerID, RandomString);
    ServerManagerID := FAdapter.Manager.Identifier;
    InternalSendData(ServerManagerID);
    ClientToken := InternalReadData;
    if (ServerToken <> ClientToken) or (ClientToken = '') then
    begin
      InternalSendData(ErrorResponse);
      AConnection.Disconnect;
    end
    else
      InternalSendData(OkResponse);
  end;
end;

procedure TTetheringTCPProtocol.DoOnDisconnect(const AConnection: TTetheringCustomComm);
begin
  // Do nothing...
end;

procedure TTetheringTCPProtocol.DoOnExecute(const AConnection: TTetheringCustomComm);
var
  Buffer: TBytes;
begin
  Buffer := AConnection.ReadData;
  if Length(Buffer) > 0 then
  begin
    if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Protocol) then
      TFakeAdapter.Log('Protocol Received: <' + TEncoding.UTF8.GetString(Buffer) + '>');
    FTCPResponseClient := AConnection;
    TFakeProfile(FProfile).DoOnIncomingData(Self, Buffer);
    FTCPResponseClient := FTCPClient;
  end;
end;

procedure TTetheringTCPProtocol.DoSendData(const AData: TBytes);
begin
  if FTCPResponseClient <> nil then
    try
      FTCPResponseClient.WriteData(AData);
    except
      if FTCPResponseClient.ReConnect then
        FTCPResponseClient.WriteData(AData);
    end;
  if TTetheringAdapter.IsLoggingItem(TTetheringAdapter.TTetheringLogItem.Protocol) then
    TFakeAdapter.Log('Protocol Sent: <' + TEncoding.UTF8.GetString(AData) + '>');
end;

function TTetheringTCPProtocol.DoSendStream(const AStream: TStream): Boolean;
var
  LOldPos: Int64;
  TmpStream: TMemoryStream;
begin
  Result := True;
  try
    TmpStream := TMemoryStream.Create;
    try
      TMonitor.Enter(AStream);
      LOldPos := AStream.Position;
      try
        AStream.Position := 0;
        TmpStream.CopyFrom(AStream, AStream.Size);
      finally
        AStream.Position := LOldPos;
        TMonitor.Exit(AStream);
      end;
      TmpStream.Position := 0;
      FTCPResponseClient.WriteStream(TmpStream);
    finally
      TmpStream.Free;
    end;
  except
    Result := False;
  end;
end;

function TTetheringTCPProtocol.GetConnectionString(const ManagerConnectionString: string): string;
begin
  Result := ManagerConnectionString.Substring(0, ManagerConnectionString.IndexOf(TetheringConnectionSeparator)) +
    TetheringConnectionSeparator + FActiveTarget;
end;

function TTetheringTCPProtocol.GetProtocolType: TTetheringProtocolType;
begin
  Result := ProtocolID;
end;

function TTetheringTCPProtocol.GetIsConnected: Boolean;
begin
  Result := (FTCPClient <> nil) and FTCPClient.Connected;
end;

function TTetheringTCPProtocol.DoReceiveStream(const AStream: TStream): Boolean;
begin
  Result := True;
  try
    FTCPResponseClient.ReadStream(AStream);
    AStream.Position := 0;
  except
    Result := False;
  end;
end;

function TTetheringTCPProtocol.DoReceiveData: TBytes;
begin
  Result := FTCPResponseClient.ReadData;
end;

procedure TTetheringTCPProtocol.StartServerSide;
var
  I: Integer;
begin
  if FTCPServer = nil then
  begin
    FTCPServer := FAdapter.GetServerPeer(ProtocolID);
    FTCPServer.OnExecute := DoOnExecute;
    FTCPServer.OnConnect := DoOnConnect;
    FTCPServer.OnDisconnect := DoOnDisconnect;
    FTCPServer.OnAfterReceiveData := OnAfterReceiveData;
    FTCPServer.OnBeforeSendData := OnBeforeSendData;
    FTCPServer.OnAfterReceiveStream := OnAfterReceiveStream;
    FTCPServer.OnBeforeSendStream := OnBeforeSendStream;
  end
  else
    try
      FTCPServer.StopServer;
    except
    end;

  for I := 0 to FAdapter.MaxConnections - 1 do
  begin
    FTCPServer.Target := FAdapter.GetTargetConnection(I, 0);
    FActiveTarget := FTCPServer.Target;
    if FTCPServer.StartServer then
      Break;
  end;

  if not FTCPServer.Active then raise ETetheringException.CreateFmt(SProtocolCreation, [TTetheringTCPProtocol.ProtocolID]);
end;


initialization
  TTetheringProtocols.RegisterProtocol(TTetheringTCPProtocol, TTetheringTCPProtocol.ProtocolID);

finalization
  TTetheringProtocols.UnRegisterProtocol(TTetheringTCPProtocol.ProtocolID);
end.
