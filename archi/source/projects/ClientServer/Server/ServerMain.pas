unit ServerMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPServer, IdContext, StdCtrls, idIOHandler,
  l3Base, ncsServerTransporter, ncsMessage, ActnList,
  ncsMessageInterfaces;

type
  TForm1 = class(TForm, IncsMessageExecutorFactory, IncsExecutor)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button8: TButton;
    ActionList1: TActionList;
    Action1: TAction;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action1Update(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
    f_TcpServer: TidTCPServer;
    f_Thread: TThread;
    f_IO: TidIOHandler;
    f_Transporter: IncsServerTransporter;
    f_List: TInterfaceList;
    procedure OnTCPServerExecute(aContext: TIdContext);
    procedure OnTCPServerExecuteNew(aContext: TIdContext);
    procedure OnTCPServerExecuteStress(aContext: TIdContext);
  protected
    //  IncsMessageExecutorFactory
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
   // IncsExecutor
   procedure Execute(const aContext: TncsExecuteContext);
  public
    { Public declarations }
    procedure WndProc(var aMessage: TMessage); override;
  end;

var
  Form1: TForm1;

implementation

uses
 IdSocketHandle, ncsLoginMessage, csIdIOHandlerAbstractAdapter, ncsLoginReply,
 csIdIOHandlerAdapter, ncsMessageFactory, ncsMessageExecutorFactory, nscMessagesReg,
 ncsSynchroServerTransporter;

var
 msg_DataReady: THandle = 0;

{$R *.dfm}

const
 c_TcpServerListenQueueSize = 50;
 c_TcpServerTerminateWaitTime = 60 * 1000;

type
 TSendThread = class(TThread)
 private
  f_IO: TidIOHandler;
 protected
  procedure Execute; override;
 public
  constructor Create(aHandler: TidIOHandler);
 end;

procedure TForm1.FormCreate(Sender: TObject);
var
 l_Binding: TIdSocketHandle;
begin
 f_List := TInterfaceList.Create;
 TncsMessageExecutorFactory.Instance.Register(Self);
 f_TcpServer := TidTCPServer.Create(Self);
 with f_TcpServer do
 begin
  ListenQueue := c_TcpServerListenQueueSize;
  MaxConnections := 0;
  TerminateWaitTime := c_TcpServerTerminateWaitTime;
//  OnExecute := OnTCPServerExecute;
//  OnExecute := OnTCPServerExecuteNew;
  OnExecute := OnTCPServerExecuteStress;

//  OnListenException := TcpServerListenExceptionHandler;
  // OnException := TcpServerExceptionHandler;


  Bindings.Clear;
  l_Binding := Bindings.Add;
  l_Binding.Port := 31000;
  l_Binding.IP := '127.0.0.1';
  Active := True;
 end; // with
 NcsServerRegister;
 TncsMessageFactory.Instance.Register(TncsLoginMessage);
end;

procedure TForm1.OnTCPServerExecute(aContext: TIdContext);
var
  S: String;
begin
  f_IO := aContext.Connection.IOHandler;
  f_IO.ReadTimeout := 10000;
  f_IO.WriteBufferOpen;
  try
   repeat
     S := aContext.Connection.IOHandler.ReadLn;
     if S = 'STOP' then
      Exit;
     PostMessage(Handle, msg_DataReady, Integer(StrNew(PChar(S))), 0);
   until False;
  finally
   f_IO.WriteBufferClose;
   f_IO := nil;
  end;
end;

procedure TForm1.WndProc(var aMessage: TMessage);
var
  P: PChar;
begin
  inherited WndProc(aMessage);
  if aMessage.Msg = msg_DataReady then
  begin
    if Memo1.Lines.Count > 100 then
      Memo1.Lines.Clear;
    P := PChar(aMessage.WParam);
    Memo1.Lines.Add(StrPas(P));
    StrDispose(P);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  f_Thread := TSendThread.Create(f_IO);
  f_Thread.Resume;
end;

{ TSendThread }

constructor TSendThread.Create(aHandler: TidIOHandler);
begin
  inherited Create(True);
  f_IO := aHandler;
end;

procedure TSendThread.Execute;
var
  IDX: Integer;
begin
  IDX := 0;
  while not terminated do
  begin
    f_IO.WriteLn(Format('SERVER %d', [IDX]));
    f_IO.WriteBufferFlush;
    Sleep(500);
    Inc(IDX);
  end;
  f_IO.WriteLn('STOP');
  f_IO.WriteBufferFlush;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 f_Thread.Terminate;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Assigned(f_Transporter) then
   f_Transporter.Terminate;
  f_Transporter := nil;
  FreeAndNil(f_Thread);

  f_TcpServer.Active := False;
  f_TcpServer.Bindings.Clear;
  FreeAndNil(f_TcpServer);

  TncsMessageExecutorFactory.Instance.UnRegister(Self);
  FreeAndNil(f_List);
end;

procedure TForm1.OnTCPServerExecuteNew(aContext: TIdContext);
var
 l_IOHandler: TcsIdIOHandlerAbstractAdapter;
// l_IsMainSocket: Boolean;
 l_Transporter: IncsServerTransporter;
begin
 try
  l_IOHandler := TcsIdIOHandlerAdapter.Create(aContext.Connection.IOHandler);
  try
//   l_Transporter := TncsServerTransporter.Make(l_IOHandler, l_IsMainSocket);
   l_Transporter := TncsSynchroServerTransporter.Make(l_IOHandler);
//   if l_IsMainSocket then
    f_Transporter := l_Transporter;
   try
//    f_Transporter.ProcessMessages(l_IsMainSocket);
    f_Transporter.ProcessMessages(True);
   finally
    l_Transporter := nil;
//    if l_IsMainSocket then
//     f_Transporter := l_Transporter;
   end;
  finally
   FreeAndNil(l_IOHandler);
  end;
 finally
  aContext.COnnection.Disconnect(True);
 end;
end;

procedure TForm1.Action1Execute(Sender: TObject);
begin
// Do nothing
end;

procedure TForm1.Action1Update(Sender: TObject);
begin
  if Assigned(f_Transporter) and f_Transporter.Connected then
    Action1.Caption := 'COnnected'
  else
    Action1.Caption := 'DisCOnnected';
end;

procedure TForm1.Execute(const aContext: TncsExecuteContext);
var
  S: String;
  l_Reply: TncsLoginReply;
begin
  S := aContext.rMessage.ClassName + ' ' + TncsLoginMessage(aContext.rMessage).Login;
  PostMessage(Handle, msg_DataReady, Integer(StrNew(PChar(S))), 0);
  l_Reply := TncsLoginReply.Create(aContext.rMessage);
  try
   aContext.rTransporter.Send(l_Reply);
  finally
   FreeAndNil(l_Reply);
  end;
end;

function TForm1.MakeExecutor(aMessage: TncsMessage): IncsExecutor;
begin
 Result := Self;
end;

procedure TForm1.OnTCPServerExecuteStress(aContext: TIdContext);
var
 l_IOHandler: TcsIdIOHandlerAbstractAdapter;
 l_Transporter: IncsServerTransporter;
// l_IsMainSocket: Boolean;
begin
 try
  l_IOHandler := TcsIdIOHandlerAdapter.Create(aContext.Connection.IOHandler);
  try
   l_Transporter := TncsSynchroServerTransporter.Make(l_IOHandler);
//   l_Transporter := TncsServerTransporter.Make(l_IOHandler, l_IsMainSocket);
   try
//    if l_IsMainSocket then
     f_List.Add(l_Transporter);
    try
//     l_Transporter.ProcessMessages(l_IsMainSocket);
     l_Transporter.ProcessMessages(True);
    finally
//     if l_IsMainSocket then
      f_List.Remove(l_Transporter);
    end;
   finally
    l_Transporter := nil;
   end;
  finally
   FreeAndNil(l_IOHandler);
  end;
 finally
  aContext.COnnection.Disconnect(True);
 end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
 if CheckBox1.CHecked then
  f_TcpServer.OnExecute := OnTCPServerExecuteStress
 else
  f_TcpServer.OnExecute := OnTCPServerExecuteNew;
end;

initialization
 msg_DataReady := RegisterWindowMessage('205');

end.
