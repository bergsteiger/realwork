{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{          Connection compatibility classes             }
{*******************************************************}

unit Datasnap.Win.MidasCon;

interface

uses
  System.Classes, Datasnap.Win.MConnect, Datasnap.Win.SConnect;

type

{ TRemoteServer }
{ Provided for compatiblity.  Switch to using the TDCOMConnection }

  TRemoteServer = class(TDCOMConnection)
  end;

{ TMidasConnection }
{ Provided for compatiblity.
  For ConnectType ctDCOM, switch to TDCOMConnection,
  for ctSockets, switch to TSocketConnection,
  for ctOLEnterprise, switch to TOLEnterpriseConnection. }

  TConnectType = (ctDCOM, ctSockets, ctOLEnterprise);

  TMidasConnection = class(TDCOMConnection)
  private
    FSubConnection: TDispatchConnection;
    FConnectType: TConnectType;
    FServerPort: Integer;
    FUseBroker: Boolean;
  protected
    procedure SetConnectType(Value: TConnectType); virtual;
    procedure SetUseBroker(Value: Boolean); virtual;
    procedure DoConnect; override;
    procedure DoDisconnect; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ConnectType: TConnectType read FConnectType write SetConnectType;
    [Default(211)]
    property ServerPort: Integer read FServerPort write FServerPort default 211;
    property UseBroker: Boolean read FUseBroker write SetUseBroker;
  end;

implementation

uses System.SysUtils;

constructor TMIDASConnection.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FServerPort := 211;
end;

procedure TMIDASConnection.DoConnect;

  procedure InitConnection(Dest: TDispatchConnection);
  begin
      Dest.ServerName := Self.ServerName;
      Dest.ServerGUID := Self.ServerGUID;
  end;

var
  I: Integer;
begin
  case ConnectType of
    ctDCOM: inherited DoConnect;
    ctOLEnterprise:
    begin
      FSubConnection := TOLEnterpriseConnection.Create(Self);
      try
        InitConnection(FSubConnection);
        if UseBroker then
          (FSubConnection as TOLEnterpriseConnection).BrokerName := Self.ComputerName
        else
          (FSubConnection as TOLEnterpriseConnection).ComputerName := Self.ComputerName;
        (FSubConnection as TOLEnterpriseConnection).Connected := True;
        Self.SetAppServer((FSubConnection as TOLEnterpriseConnection).AppServer);
      except
        FSubConnection.Free;
        raise;
      end;
    end;
    ctSockets:
    begin
      FSubConnection := TSocketConnection.Create(Self);
      try
        for I := 1 to Length(Self.ComputerName) do
          if not CharInSet(Self.ComputerName[I], ['0'..'9','.']) then
          begin
            (FSubConnection as TSocketConnection).Host := Self.ComputerName;
            break;
          end;
        InitConnection(FSubConnection);
        if (FSubConnection as TSocketConnection).Host = '' then
          (FSubConnection as TSocketConnection).Address := Self.ComputerName;
        (FSubConnection as TSocketConnection).Port := Self.ServerPort;
        (FSubConnection as TSocketConnection).Connected := True;
        Self.SetAppServer((FSubConnection as TSocketConnection).AppServer);
      except
        FSubConnection.Free;
        raise;
      end;
    end;
  end;
end;

procedure TMIDASConnection.DoDisconnect;
begin
  inherited DoDisconnect;
  FSubConnection.Free;
  FSubConnection := nil;
end;

procedure TMIDASConnection.SetConnectType(Value: TConnectType);
begin
  if Value <> FConnectType then
  begin
    SetConnected(False);
    FConnectType := Value;
  end;
end;

procedure TMIDASConnection.SetUseBroker(Value: Boolean);
begin
  if Value <> FUseBroker then
  begin
    FUseBroker := Value;
    SetConnected(False);
  end;
end;

end.
