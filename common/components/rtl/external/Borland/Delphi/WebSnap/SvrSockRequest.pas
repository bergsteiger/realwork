unit SvrSockRequest;

interface

uses HTTPApp, IdTCPClient;

type
  TRequestConnection = class(TObject)
  private
    FClient: TIdTCPClient;
  public
    constructor Create(APort: Integer);
    destructor Destroy; override;
    procedure Disconnect;
    function Connect: Boolean;
    procedure Request(ARequest: TWebRequest; AResponse: TWebResponse; AUsingStub: Boolean);
  end;

implementation

uses SockRequestInterpreter, SockTransport, IndySockTransport, Classes, SysUtils,
  IdException, SvrConst;

{ TRequestConnection }

function TRequestConnection.Connect: Boolean;
begin
  try
    FClient.Connect;
  except
    on E: EIdSocketError do
      case E.LastError of
        10061 { Connection refused } :
        begin
          Result := False;
          Exit;
        end;
      end;
    else
      raise;
  end;
  Result := True;
end;

procedure TRequestConnection.Disconnect;
begin
  FClient.Disconnect;
end;

constructor TRequestConnection.Create(APort: Integer);
begin
  inherited Create;
  FClient := TIdTCPClient.Create(nil);
  FClient.Port := APort;
  FClient.Host := '127.0.0.1';
end;

procedure TRequestConnection.Request(ARequest: TWebRequest; AResponse: TWebResponse; AUsingStub: Boolean);
var
  DataBlockInterpreter: TLogWebAppDataBlockInterpreter;
  Transport: ITransport;
begin
  try
    Transport := TIndyTCPConnectionTransport.Create(FClient);
    try
     DataBlockInterpreter := TLogWebAppDataBlockInterpreter.Create(TLogSendDataBlock.Create(Transport));
     try
       DataBlockInterpreter.CallHandleRequest(ARequest, AResponse, AUsingStub);
     finally
       DataBlockInterpreter.Free;
     end;
    finally
      Transport := nil;
    end;
  except
    on E: Exception do
    begin
      E.Message := Format(sSocketRequestError, [E.Message]);
      raise;
    end;
  end;
end;

destructor TRequestConnection.Destroy;
begin
  Disconnect;
  FClient.Free;
  inherited;
end;


end.
 