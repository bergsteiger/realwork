{****************************************************************}
{                                                                }
{       Borland Delphi Visual Component Library                  }
{                                                                }
{       Copyright (c) 2000-2002  Borland Software Corporation    }
{                                                                }
{****************************************************************}

unit SockApp;

interface

uses
  SockHTTP, Classes, IdTCPConnection, IdTCPServer;

type

  TStartMode = (smNormal, smRegServer, smUnregServer);

  TWebAppSockObjectFactory = class(TObject)
  private
    FClassName: string;
    FStartMode: TStartMode;
    function GetProgID: string;
    function GetFileName: string;
    procedure Initialize;
  public
    procedure UpdateRegistry(Register: Boolean);
    constructor Create(const ClassName: string);
    property ProgID: string read GetProgID;
    property StartMode: TStartMode read FStartMode;
    property FileName: string read GetFileName;
  end;

implementation

uses SysUtils, WebReq, WebCntxt, SockRequestInterpreter, SockTransport, IndySockTransport, SockAppReg, SockAppNotify;

var
  FSockWebRequestHandler: TSockWebRequestHandler;

function SockWebRequestHandler: TWebRequestHandler;
begin
  if not Assigned(FSockWebRequestHandler) then
    FSockWebRequestHandler := TSockWebRequestHandler.Create(nil);
  Result := FSockWebRequestHandler;
end;

type
  // Implement the IWebRequest interface using a socket data block interpreter
  TSockWebRequestAccess = class(TInterfacedObject, ISockWebRequestAccess)
  private
    FInterpreter: TWebRequestDataBlockInterpreter;
    function  GetFieldByName(const Name: string): string;
    function  ReadClient(var Buffer: string; Count: Integer): Integer;
    function  TranslateURI(const Value: string): string;
    function  WriteClient(const Buffer: string): Integer;
    function  GetStringVariable(Index: Integer): string;
    function  WriteHeaders(StatusCode: Integer;
      StatusText: string; Headers: string): Boolean;
    function  UsingStub: Boolean;
    function  ReadString(var Buffer: string; Count: Integer): Integer;
  public
    constructor Create(AInterpreter: TWebRequestDataBlockInterpreter);
  end;

  // Interpret a web request encapsulated in a socket data block
  TWebRequestDataBlockInterpreterHandleRequest = class(TWebRequestDataBlockInterpreter)
  protected
    function DoHandleRequest(Data: IDataBlock): IDataBlock; override;
  end;

  // Listen for requests from web app debugger
  TWebRequestListener = class(TObject)
  private
    FConnection: TIdTCPServer;
    procedure ServerExecute(AThread: TIdPeerThread);
    function GetPort: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property Port: Integer read GetPort;
  end;


constructor TWebRequestListener.Create;
begin
  inherited;
  FConnection := TIdTCPServer.Create(nil);
  FConnection.DefaultPort := 0;
  FConnection.Active := True;
  FConnection.OnExecute := ServerExecute;
end;

destructor TWebRequestListener.Destroy;
begin
  FConnection.Active := False;
  FConnection.Free;
  inherited;
end;

function TWebRequestListener.GetPort: Integer;
begin
  Result := FConnection.Bindings[0].Port;
end;

procedure TWebRequestListener.ServerExecute(AThread: TIdPeerThread);
var
  DataBlockInterpreter: TWebRequestDataBlockInterpreter;
  Transport: ITransport;
  DataBlock: IDataBlock;

begin
  with AThread.Connection do
  begin
    try
      Transport := TIndyTCPConnectionTransport.Create(AThread.Connection);
      DataBlock := Transport.Receive(True, 0);
      try
       Assert(DataBlock <> nil, 'nil datablock');
       DataBlockInterpreter := TWebRequestDataBlockInterpreterHandleRequest.Create(TLogSendDataBlock.Create(Transport));
       try
         DataBlockInterpreter.InterpretData(DataBlock);
       finally
         DataBlockInterpreter.Free;
       end;
      finally
        Transport := nil;
        DataBlock := nil;
      end;
    finally
      // jmt.!!! Don't disconnect?
      // Disconnect;
    end;
  end;
end;

// Handle a request from web app debugger
function TWebRequestDataBlockInterpreterHandleRequest.DoHandleRequest(Data: IDataBlock): IDataBlock;
var
  RetVal: Variant;
begin
  try
    TSockWebRequestHandler(SockWebRequestHandler).Run(TSockWebRequestAccess.Create(Self));
  except
    on E: Exception do
    begin
     WriteVariant(E.Message, Data);
     Data.Signature := ResultSig or asError;
     Exit;
    end;
  end;
  RetVal := True;
  WriteVariant(RetVal, Data);
  Data.Signature := ResultSig or asHandleRequest;
  Result := FSendDataBlock.Send(Data, True);
end;

var
  WebRequestListener: TWebRequestListener;

{ TSockWebRequestAccess }

constructor TSockWebRequestAccess.Create(AInterpreter: TWebRequestDataBlockInterpreter);
begin
  FInterpreter := AInterpreter;
  inherited Create;
end;

function TSockWebRequestAccess.GetFieldByName(const Name: string): string;
begin
  Result := FInterpreter.CallGetFieldByName(Name);
end;

function TSockWebRequestAccess.GetStringVariable(Index: Integer): string;
begin
  Result := FInterpreter.CallGetStringVariable(Index);
end;

function TSockWebRequestAccess.ReadClient(var Buffer: string;
  Count: Integer): Integer;
begin
  Result := FInterpreter.CallReadClient(Buffer, Count);
end;

function TSockWebRequestAccess.ReadString(var Buffer: string;
  Count: Integer): Integer;
begin
  Result := FInterpreter.CallReadString(Buffer, Count);
end;

function TSockWebRequestAccess.TranslateURI(const Value: string): string;
begin
  Result := FInterpreter.CallTranslateURI(Value);
end;

function TSockWebRequestAccess.UsingStub: Boolean;
begin
  Result := FInterpreter.CallUsingStub;
end;

function TSockWebRequestAccess.WriteClient(const Buffer: string): Integer;
begin
  Result := FInterpreter.CallWriteClient(Buffer);
end;

function TSockWebRequestAccess.WriteHeaders(StatusCode: Integer; StatusText,
  Headers: string): Boolean;
begin
  Result := FInterpreter.CallWriteHeaders(StatusCode, StatusText, Headers);
end;

var
  RunningWebAppNotifier: TRunningWebAppNotifier;
  WebAppSockObjectFactory: TWebAppSockObjectFactory;

{ TWebAppSockObjectFactory }

constructor TWebAppSockObjectFactory.Create(
  const ClassName: string);

  function FindSwitch(const Switch: string): Boolean;
  begin
    Result := FindCmdLineSwitch(Switch, ['-', '/'], True);
  end;
begin
  WebAppSockObjectFactory := Self;
  FClassName := ClassName;
  if FindSwitch('REGSERVER') then
    FStartMode := smRegServer
  else if FindSwitch('UNREGSERVER') then
    FStartMode := smUnregServer
  else
    FStartMode := smNormal;
end;

function TWebAppSockObjectFactory.GetFileName: string;
begin
  Result := GetModuleName(hinstance);
end;

function TWebAppSockObjectFactory.GetProgID: string;
begin
  if FClassName <> '' then
    Result := ChangeFileExt(ExtractFileName(FileName), '') + '.' + FClassName else
    Result := '';
end;

{$IFDEF LINUX}
procedure NotifyWebAppDbg;
var
  fd: Integer;
  PipeStream: THandleStream;
  S: string;
begin
  if ParamStr(1) = sExecWaitToken then
  begin
    fd := StrToInt(ParamStr(2));
    PipeStream := THandleStream.Create(fd);
    try
      S := ParamStr(1);
      PipeStream.Write(S[1], Length(S));
    finally
      PipeStream.Free;
    end;
  end;
end;
{$ENDIF}

procedure TWebAppSockObjectFactory.Initialize;
begin
  UpdateRegistry(StartMode <> smUnregServer);
  if StartMode <> smNormal then
    Halt;
  WebRequestListener := TWebRequestListener.Create;
  RunningWebAppNotifier := TRunningWebAppNotifier.Create(WebRequestListener.Port,
    WebAppSockObjectFactory.ProgID, WebAppSockObjectFactory.FileName);
  RunningWebAppNotifier.Register;
{$IFDEF LINUX}
  NotifyWebAppDbg;
{$ENDIF}
end;

procedure TWebAppSockObjectFactory.UpdateRegistry(Register: Boolean);
begin
  if Register then
    SockAppReg.RegisterWebApp(GetModuleName(hinstance), GetProgID)
  else
    SockAppReg.UnregisterWebApp(GetProgID);
end;

var
  SaveInitProc: Pointer = nil;
  SaveExitProc: Pointer = nil;

procedure InitApp;
begin
  if SaveInitProc <> nil then TProcedure(SaveInitProc);
  if WebAppSockObjectFactory <> nil then
    WebAppSockObjectFactory.Initialize;
end;

procedure FinalizeApp;
begin
  if RunningWebAppNotifier <> nil then
  begin
    RunningWebAppNotifier.Unregister;
    RunningWebAppNotifier.Free;
  end;
  if SaveExitProc <> nil then TProcedure(ExitProc);
  FreeAndNil(WebAppSockObjectFactory);
  FreeAndNil(WebRequestListener);
  FreeAndNil(FSockWebRequestHandler);
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Internet\SockApp.pas initialization enter'); {$EndIf}
  WebReq.WebRequestHandlerProc := SockWebRequestHandler;
  SaveInitProc := InitProc;
  InitProc := @InitApp;
  SaveExitProc := ExitProc;
  ExitProc := @FinalizeApp;
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\external\Borland\Delphi\Internet\SockApp.pas initialization leave'); {$EndIf}
end.
