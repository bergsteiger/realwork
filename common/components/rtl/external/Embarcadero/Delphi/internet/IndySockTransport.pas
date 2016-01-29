{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

// Implement socket transport interfaces using Indy components

unit IndySockTransport;

{$R-}

interface

uses
  System.Classes, System.SysUtils, IdTCPClient, idTCPConnection, SockTransport;


type

  { TIndyTCPConnectionTransport }

  TIndyTCPConnectionTransport = class(TInterfacedObject, ITransport)
  private
    FEvent: THandle;
    FSocket: TIdTCPConnection;
  protected
    { ITransport }
    function GetWaitEvent: THandle;
    function GetConnected: Boolean;
    procedure SetConnected(Value: Boolean); virtual;
    function Receive(WaitForInput: Boolean; Context: Integer): IDataBlock;
    function Send(const Data: IDataBlock): Integer;
  public
    constructor Create(AConnection: TIdTCPConnection);
    destructor Destroy; override;
  end;

  TIndyTCPClientTransport = class(TIndyTCPConnectionTransport)
  private
    FSocket: TIdTCPClient;
    FHost: string;
    FPort: Integer;
  protected
    { ITransport }
    procedure SetConnected(Value: Boolean); override;
  public
    constructor Create;
    destructor Destroy; override;
    property Host: string read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property Socket: TIdTCPClient read FSocket write FSocket;
  end;

implementation

uses
  System.RTLConsts, IdTCPStream, SockConst;


{ TIndyTCPConnectionTransport }

constructor TIndyTCPConnectionTransport.Create(AConnection: TIdTCPConnection);
begin
  inherited Create;
  FSocket := AConnection;
  FEvent := 0;
end;

destructor TIndyTCPConnectionTransport.Destroy;
begin
  // jmt.!!! SetConnected(False);
  inherited Destroy;
end;

function TIndyTCPConnectionTransport.GetWaitEvent: THandle;
begin
  (* jmt.!!! FEvent := WSACreateEvent;
  WSAEventSelect(FSocket.SocketHandle, FEvent, FD_READ or FD_CLOSE);
  *)
  Result := FEvent;
end;

function TIndyTCPConnectionTransport.GetConnected: Boolean;
begin
  Result := (FSocket <> nil) and (FSocket.Connected);
end;

procedure TIndyTCPConnectionTransport.SetConnected(Value: Boolean);
begin
  Assert(False, 'Must be implemented by descendent');
end;

function TIndyTCPConnectionTransport.Receive(WaitForInput: Boolean; Context: Integer): IDataBlock;
  procedure ReadBuffer(var Buffer; Size: Integer);
  var
    Stream: TIdTCPStream;
  begin
    Stream := TIdTCPStream.Create(FSocket);
    try
      Stream.ReadBuffer(Buffer, Size);
    finally
      Stream.Free;
    end;

  end;
var
  Sig, StreamLen: Integer;
  P: Pointer;
begin
  Result := nil;
  if not WaitForInput then
    // jmt.!!! if not FSocket.Binding.Readable(1) then Exit;
    Assert(False);  // Change this for new Indy
  ReadBuffer(Sig, Sizeof(Sig));
  CheckSignature(Sig);
  ReadBuffer(StreamLen, SizeOf(StreamLen));
  Result := TDataBlock.Create as IDataBlock;
  Result.Size := StreamLen;
  Result.Signature := Sig;
  P := Result.Memory;
  Inc(IntPtr(P), Result.BytesReserved);
  ReadBuffer(P^, StreamLen);
end;

function TIndyTCPConnectionTransport.Send(const Data: IDataBlock): Integer;
  procedure WriteBuffer(const Buffer; Size: Integer);
  var
    Stream: TIdTCPStream;
  begin
    Stream := TIdTCPStream.Create(FSocket);
    try
      Stream.WriteBuffer(Buffer, Size);
    finally
      Stream.Free;
    end;

  end;
var
  P: Pointer;
begin
  Result := 0;
  P := Data.Memory;
  WriteBuffer(P^, Data.Size + Data.BytesReserved);
end;


{ TIndyTCPClientTransport }

constructor TIndyTCPClientTransport.Create;
begin
  FSocket := TIdTCPClient.Create(nil);
  inherited Create(FSocket);
end;

destructor TIndyTCPClientTransport.Destroy;
begin
  inherited;
  FSocket.Disconnect;
  FSocket.Free;
end;

procedure TIndyTCPClientTransport.SetConnected(Value: Boolean);
begin
  if GetConnected = Value then Exit;
  if Value then
  begin
    if FHost = '' then
      raise ESocketConnectionError.Create(sNoHost);
    FSocket.Port := FPort;
    FSocket.Host := FHost;
    FSocket.Connect;
  end
  else
    FSocket.Disconnect;
end;

end.



