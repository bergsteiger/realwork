{*******************************************************}
{                                                       }
{                Delphi Runtime Library                 }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit SockAppNotify;

{$R-}

interface

uses
  System.Classes, System.SysUtils, IdTCPClient, idTCPConnection, IdGlobal,
  SockTransport, IndySockTransport,
  Web.HTTPApp, IdUDPServer, IdSocketHandle, IdUDPClient, System.SyncObjs, System.Contnrs;


{$IFDEF LINUX}
const
  sExecWaitToken = 'webappdbgtoken';
{$ENDIF}
type

  TWebAppInfo = class(TObject)
  public
    Port: Integer;
    FileName: string;
    LastAccess: Cardinal;
  end;

  // Listen for running web applications
  TRunningWebAppListener = class(TObject)
  private
    FList: TObjectList;
    FLock: TCriticalSection;
    FConnection: TIdUDPServer;
    procedure OnUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);
    procedure RegisterWebApp(APort: Integer; const AProgID, AFileName: string);
    procedure UnregisterWebApp(APort: Integer; const AProgID, AFileName: string);
    function FindPort(APort: Integer): Integer;
    function FindFileName(AFileName: string): Integer;
    function GetActive: Boolean;
    function GetPort: Integer;
    procedure SetActive(const Value: Boolean);
    procedure SetPort(const Value: Integer);
  public
    property Connection: TIdUDPServer read FConnection;
    procedure RemovePort(APort: Integer);
    function GetPortOfFileName(AFileName: string): Integer;
    property Active: Boolean read GetActive write SetActive;
    property Port: Integer read GetPort write SetPort;
    constructor Create;
    destructor Destroy; override;
  end;

  // Register a running web app
  TRunningWebAppNotifier = class(TObject)
  private
    FAppPort: Integer;
    FConnection: TIdUDPClient;
    FProgID: string;
    FFileName: string;
    FSendRegister: Boolean;
    FSendInterval: Cardinal;
    procedure Send(const AValue: string);
    procedure SendRegister;
    procedure StartSenderThread;
    procedure StopSenderThread;
  public
    constructor Create(AAppPort: Integer; const AProgID, AFileName: string);
    destructor Destroy; override;
    procedure Register;
    procedure Unregister;
  end;

implementation

uses
  System.RTLConsts, SockAppReg, System.IniFiles, Winapi.Windows,
  SockConst;


const
  iDefaultUDPPort = 8090;
  iSendInterval = 500;


{ TRunningWebAppListener }

constructor TRunningWebAppListener.Create;
begin
  inherited;
  FConnection := TIdUDPServer.Create(nil);
  FConnection.DefaultPort := iDefaultUDPPort;
  FConnection.OnUDPRead := OnUDPRead;
  FConnection.ThreadedEvent := True;   // No need to synchronize OnUDPRead
  FConnection.ReceiveTimeout := 100;
  FLock := TCriticalSection.Create;
  FList := TObjectList.Create(True { Owns objects });
end;

destructor TRunningWebAppListener.Destroy;
begin
  FConnection.Active := False;
  FConnection.Free;
  FLock.Free;
  FList.Free;
  inherited;
end;

const
  sRegString = 'Command=%s;Port=%d;ProgID=%s;FileName=%s';
  sRegisterCommand = 'R';
  sUnregisterCommand = 'U';


procedure TRunningWebAppListener.OnUDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes;
  ABinding: TIdSocketHandle);
var
  DataStringStream: TBytesStream;
  S: TStrings;
  Command: string;
  Port: Integer;
  ProgID: string;
  FileName: string;
  Temp: string;
begin
  DataStringStream := TBytesStream.Create();
  S := TStringList.Create;
  try
    DataStringStream.Write(AData[0], Length(AData));
    Temp := string(PAnsiChar(DataStringStream.Memory));
    ExtractStrings([';'],[], PChar(Temp), S);
    Command := S.Values['Command'];
    try
      Port := StrToInt(S.Values['Port']);
    except
      Port := 0;
    end;
    ProgID := S.Values['ProgID'];
    FileName := S.Values['FileName'];
    if CompareText(Command, sRegisterCommand) = 0 then
      RegisterWebApp(Port, ProgID, FileName)
    else if CompareText(Command, sUnregisterCommand) = 0 then
      UnregisterWebApp(Port, ProgID, FileName)
    else
      raise Exception.Create(sUnknownCommand);
  finally
    DataStringStream.Free;
    S.Free;
  end;
end;

function TRunningWebAppListener.FindPort(APort: Integer): Integer;
var
  I: Integer;
begin
  FLock.Enter;
  try
    for I := 0 to FList.Count - 1 do
      if TWebAppInfo(FList[I]).Port = APort then
      begin
        Result := I;
        Exit;
      end;
    Result := -1;
  finally
    FLock.Leave;
  end;
end;

function TRunningWebAppListener.FindFileName(AFileName: string): Integer;
var
  I: Integer;
begin
  FLock.Enter;
  try
    for I := 0 to FList.Count - 1 do
      if CompareText(TWebAppInfo(FList[I]).FileName, AFileName) = 0 then
      begin
        Result := I;
        Exit;
      end;
    Result := -1;
  finally
    FLock.Leave;
  end;
end;

function TRunningWebAppListener.GetPortOfFileName(AFileName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  FLock.Enter;
  try
    I := FindFileName(AFileName);
    if I >= 0 then
    begin
      with TWebAppInfo(FList[I]) do
        Result := TWebAppInfo(FList[I]).Port
    end;
  finally
    FLock.Leave;
  end;
end;

procedure TRunningWebAppListener.RegisterWebApp(APort: Integer; const AProgID, AFileName: string);
var
  Info: TWebAppInfo;
  I: Integer;
begin
  // ProgID is not saved
  Assert(AFileName <> '');
  FLock.Enter;
  try
    for I := FList.Count - 1 downto 0 do
    begin
      Info := TWebAppInfo(FList[I]);
      if Info.Port = APort then
        FList.Delete(I)
      else if CompareText(Info.FileName, AFileName) = 0 then
        FList.Delete(I);
    end;
    Info := TWebAppInfo.Create;
    try
      Info.Port := APort;
      Info.FileName := AFileName;
    except
      Info.Free;
      exit;
    end;
    FList.Add(Info);
  finally
    FLock.Leave;
  end;
end;

procedure TRunningWebAppListener.UnregisterWebApp(APort: Integer; const AProgID, AFileName: string);
begin
  RemovePort(APort);
end;

procedure TRunningWebAppListener.RemovePort(APort: Integer);
var
  I: Integer;
begin
  FLock.Enter;
  try
    I := FindPort(APort);
    if I >= 0 then
      FList.Delete(I);
  finally
    FLock.Leave;
  end;
end;

function TRunningWebAppListener.GetActive: Boolean;
begin
  Result := FConnection.Active;
end;

function TRunningWebAppListener.GetPort: Integer;
begin
  Result := FConnection.DefaultPort;
end;

procedure TRunningWebAppListener.SetActive(const Value: Boolean);
begin
  try
    FConnection.Active := Value;
    if Value = False then
      FConnection.Bindings.Clear;
  except
    FConnection.Bindings.Clear;
    Exit;
  end;
end;

procedure TRunningWebAppListener.SetPort(const Value: Integer);
begin
  FConnection.DefaultPort := Value;
end;

{ TRunningWebAppNotifier }

type
  TTimerThread = class(TThread)
  private
    FSender: TRunningWebAppNotifier;
  public
    constructor Create(ASender: TRunningWebAppNotifier);
    procedure Execute; override;
  end;

{ TTimerThread }

constructor TTimerThread.Create(ASender: TRunningWebAppNotifier);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  FSender := ASender;
  Resume;
end;

procedure TTimerThread.Execute;
var
  SleepTime: Integer;
  Last: Cardinal;
begin
  while FSender.FSendRegister and (not Terminated) do
  begin
    try
      Last := Winapi.Windows.GetTickCount;
      Synchronize(FSender.SendRegister);
      SleepTime := FSender.FSendInterval - (Winapi.Windows.GetTickCount - Last);
      if SleepTime < 10 then SleepTime := 10;
      Sleep(SleepTime);
    except
    end;
  end;
end;

constructor TRunningWebAppNotifier.Create(AAppPort: Integer; const AProgID, AFileName: string);
var
  Reg: TCustomIniFile;
begin
  FAppPort := AAppPort;
  FProgID := AProgID;
  FFileName := AFileName;
  FConnection := TIdUDPClient.Create(nil);
  FConnection.Host := '127.0.0.1';

  Reg := CreateRegistry;
  try
    FConnection.Port := Reg.ReadInteger('', sUDPPort, iDefaultUDPPort);
  finally
    Reg.Free;
  end;
  inherited Create;
end;

destructor TRunningWebAppNotifier.Destroy;
begin
  FConnection.Free;
  inherited;
end;

procedure TRunningWebAppNotifier.Register;
begin
  StartSenderThread;
end;

procedure TRunningWebAppNotifier.SendRegister;
begin
  if FSendRegister then
    Send(Format(sRegString, [sRegisterCommand, FAppPort, FProgID, FFileName]));
end;

procedure TRunningWebAppNotifier.StartSenderThread;
begin
  Assert(not FSendRegister);
  FSendInterval := 200;
  FSendRegister := True;
  SendRegister;
  TTimerThread.Create(Self);
end;

procedure TRunningWebAppNotifier.StopSenderThread;
begin
  FSendRegister := False;
end;

procedure TRunningWebAppNotifier.Send(const AValue: string);
begin
  FConnection.Active := True;
  try
    FConnection.Send(AValue);
  finally
    FConnection.Active := False;
  end;
end;

procedure TRunningWebAppNotifier.Unregister;
begin
  StopSenderThread;
  Send(Format(sRegString, [sUnregisterCommand, FAppPort, FProgID, FFileName]));
end;

end.



