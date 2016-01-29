unit MainServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  l3Base,
  CsServerSettings, CsServer, CsDataPipe;

type
 TMainServerForm = class(TForm)
  btBroadcast: TButton;
  lbInfo: TLabel;
  procedure FormCreate(Sender: TObject);
  procedure FormClose(Sender: TObject; var Action: TCloseAction);
  procedure btBroadcastClick(Sender: TObject);
 private
  f_Server: TCsServer;
  f_ServerSettings: TCsServerSettings;
  procedure OnServerEvent(aEventId: Integer; aData: Integer);
  procedure Info(const aStr: string);
  procedure TestReply(aPipe: TCsDataPipe);
 public

 end;

var
  MainServerForm: TMainServerForm;

implementation

{$R *.dfm}

uses
 l3FileUtils,
 IdGlobal,
 CsNotification, CsEventsProcessor, CsQueryTypes;

procedure TMainServerForm.FormCreate(Sender: TObject);
begin
 f_ServerSettings := TCsServerSettings.Create;
 f_ServerSettings.ClientsLogFile := ConcatDirName(ExtractFileDir(Application.ExeName), 'clients.log');
 f_Server := TCsServer.Create(f_ServerSettings);
 f_Server.RegisterReplyProcedure(qtTest, TestReply);
 f_Server.OnEvent := OnServerEvent;
 f_Server.Start('127.0.0.1', 7777);
end;

procedure TMainServerForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 f_Server.Stop;
 l3Free(f_Server);
 l3Free(f_ServerSettings);
end;

procedure TMainServerForm.btBroadcastClick(Sender: TObject);
var
 l_Notification: TCsNotification;
begin
 l_Notification := TCsNotification.Create(ntEmpty, 0, 'Ўироковещательное сообщение.');
 try
  f_Server.Notifier.Broadcast(l_Notification);
 finally
  l3Free(l_Notification);
 end;
end;

procedure TMainServerForm.OnServerEvent(aEventId, aData: Integer);
begin
 case aEventId of
  c_WrongProtocolVersion: Info('Error: WrongProtocolVersion. Station: ' + MakeDWordIntoIPv4Address(LongWord(aData)));
  c_ClientLogedInEvent  : Info(f_Server.ActiveClients.ClientInfoOf(aData).LoginName + ' - Loged In');
  c_ClientLogedOutEvent : Info(IntToStr(aData) + ' - Loged Out');
  c_UnregisteredQuery   : Info('Error: Unregistered Query. Station: ' + MakeDWordIntoIPv4Address(LongWord(aData)));
  c_ServerListenerError : Info('Error: Server is dead. Because of station: ' + MakeDWordIntoIPv4Address(LongWord(aData)));
 else
 end;
end;

procedure TMainServerForm.Info(const aStr: string);
begin
 lbInfo.Caption := aStr;
end;

procedure TMainServerForm.TestReply(aPipe: TCsDataPipe);
var
 l_Num: Integer;
 l_Str: string;
 l_Result: string;
 I: Integer;
begin
 l_Num := aPipe.ReadInteger;
 l_Str := aPipe.ReadStr;
 
 for I := 1 to l_Num do
  l_Result := l_Result + ' ' + l_Str;
 aPipe.Write(l_Result);
end;

end.

