unit ClientMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, idTCPClient, StdCtrls, idIOHandler, ncsMessageInterfaces,
  ActnList;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Memo1: TMemo;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ActionList1: TActionList;
    Action1: TAction;
    Button8: TButton;
    Button9: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Action1Update(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private
    { Private declarations }
    f_TcpClient: TidTCPClient;
    f_Thread: TThread;
    f_ListenThread: TThread;
    f_IO: TidIOHandler;
    f_Transporter: IncsClientTransporter;
  public
    { Public declarations }
    procedure WndProc(var aMessage: TMessage); override;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses
 ncsLoginMessage, ncsMessage, ncsLoginReply, ncsMessageFactory,
 ncsClientTransporter, Contnrs, nscMessagesReg, ncsSynchroClientTransporter;

type
 TSendThread = class(TThread)
 private
  f_IO: TidIOHandler;
 protected
  procedure Execute; override;
 public
  constructor Create(aHandler: TidIOHandler);
 end;

 TListenThread = class(TThread)
 private
  f_IO: TidIOHandler;
  f_WNDHandle: THandle;
 protected
  procedure Execute; override;
 public
  constructor Create(aHandler: TidIOHandler; aHandle: THandle);
 end;

var
 msg_DataReady: THandle = 0;

const
 c_ClientConnectTimeout = 10 * 1000; // миллисек.

 c_ClientReadTimeout = 10 * 1000; // миллисек.

procedure TForm2.FormCreate(Sender: TObject);
begin
 f_TcpClient := TIdTcpClient.Create(Self);
 f_TcpClient.ConnectTimeout := c_ClientConnectTimeout;
 f_TcpClient.ReadTimeout := c_ClientReadTimeout;
 f_TcpClient.Host := '127.0.0.1';
 f_TcpClient.Port := 31000;

 f_Transporter := TncsSynchroClientTransporter.Make;
 NcsClientRegister;
 TncsMessageFactory.Instance.Register(TncsLoginReply);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  f_TcpClient.Connect;
  f_TcpClient.IOHandler.WriteBufferOpen;
  f_IO := f_TcpClient.IOHandler;
  f_ListenThread := TListenThread.Create(f_IO, Handle);
  f_ListenThread.Resume;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  f_TcpClient.IOHandler.WriteBufferClose;
  f_TcpClient.Disconnect(False);
  f_IO := nil;
  FreeANdNil(f_ListenThread);
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  f_Thread := TSendThread.Create(f_IO);
  f_Thread.Resume;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
 f_Thread.Terminate;
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

procedure TForm2.FormDestroy(Sender: TObject);
begin
  f_Transporter := nil;
  FreeAndNil(f_Thread);
  FreeAndNil(f_ListenThread);
end;

{ TListenThread }

constructor TListenThread.Create(aHandler: TidIOHandler; aHandle: THandle);
begin
  inherited Create(True);
  f_IO := aHandler;
  f_WNDHandle := aHandle;
end;

procedure TListenThread.Execute;
var
  S: String;
begin
 repeat
   S := f_IO.ReadLn;
   if S = 'STOP' then
    Exit;
   PostMessage(f_WNDHandle, msg_DataReady, Integer(StrNew(PChar(S))), 0);
 until False;
end;

procedure TForm2.WndProc(var aMessage: TMessage);
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

procedure TForm2.Button5Click(Sender: TObject);
begin
 f_Transporter.Connect('127.0.0.1', 31000, 'ytgfrhugwf');
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
 f_Transporter.Disconnect;
end;

procedure TForm2.Button7Click(Sender: TObject);
var
 l_Message: TncsLoginMessage;
 l_Reply: TncsMessage;
begin
 l_Message := TncsLoginMessage.Create;
 try
  l_Message.Login := 'ghj';
  f_Transporter.Send(l_Message);
  l_Reply := nil;
  if f_Transporter.WaitForReply(l_Message, l_Reply) then
  begin
   Memo1.Lines.Add(l_Reply.ClassName);
   FreeAndNil(l_Reply);
  end;
 finally
  FreeAndNil(l_Message);
 end;
end;

procedure TForm2.Action1Update(Sender: TObject);
begin
  if Assigned(f_Transporter) and f_Transporter.Connected then
    Action1.Caption := 'COnnected'
  else
    Action1.Caption := 'DisCOnnected';
end;

procedure TForm2.Action1Execute(Sender: TObject);
begin
  // Do nothing;
end;

procedure TForm2.Button9Click(Sender: TObject);
var
 l_List: TInterfaceList;
 l_ObjList: TObjectList;
 l_X: IncsClientTransporter;
 l_IDX: Integer;
 l_Message: TncsLoginMessage;
 l_Reply: TncsMessage;
begin
 l_List := TInterfaceList.Create;
 try
  for l_IDX := 0 to StrToInt(Edit1.Text) - 1 do
  begin
   l_X := TncsSynchroClientTransporter.Make;
   l_List.Add(l_X);
  end;
  for l_IDX := 0 to l_List.Count - 1 do
  begin
   IncsClientTransporter(l_List[l_IDX]).Connect('127.0.0.1', 31000, IntToStr(l_IDX));
   Memo1.Lines.Text := 'Connect '+IntToStr(l_IDX);
   Application.ProcessMessages;
  end;
  Memo1.Lines.Add('Connected');
  Application.ProcessMessages;
  l_ObjList := TObjectList.Create(True);
  try
   for l_IDX := 0 to l_List.Count - 1 do
   begin
    l_Message := TncsLoginMessage.Create;
    l_Message.Login := 'ghj' + IntToStr(l_IDX);
    IncsClientTransporter(l_List[l_IDX]).Send(l_Message);
    l_ObjList.Add(l_Message);
   end;
   for l_IDX := 0 to l_List.Count - 1 do
   begin
    l_Message := TncsLoginMessage(l_ObjList[l_IDX]);
    l_Reply := nil;
    if IncsClientTransporter(l_List[l_IDX]).WaitForReply(l_Message, l_Reply) then
    begin
      Memo1.Lines.Add(l_Reply.ClassName + ' ' + l_Message.Login);
      Application.ProcessMessages;
      FreeAndNil(l_Reply);
    end;
   end;
  finally
   FreeAndNil(l_ObjList);
  end;
  Memo1.Lines.Add('Disconnecting');
  Application.ProcessMessages;
  Memo1.Lines.Add('Disconnected');
  l_List.Clear;
 finally
  FreeAndNil(l_List);
 end;
end;

initialization
 msg_DataReady := RegisterWindowMessage('205104');

end.
