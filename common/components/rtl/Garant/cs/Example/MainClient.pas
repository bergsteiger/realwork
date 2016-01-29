unit MainClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  l3Base,
  CsClient, CsNotification, CsDataPipe;

type
 TMainClientForm = class(TForm)
   btConnect: TButton;
   btDisconnect: TButton;
   lbState: TLabel;
   btQuery: TButton;
   procedure FormCreate(Sender: TObject);
   procedure FormClose(Sender: TObject; var Action: TCloseAction);
   procedure btConnectClick(Sender: TObject);
   procedure btDisconnectClick(Sender: TObject);
   procedure btQueryClick(Sender: TObject);
 private
  f_Client: TCsClient;
  f_Num: Integer;
  f_Str: string;
  f_QueryResult: string;
  procedure Info(const aStr: string);
  procedure OnNotif(aNotificationType: TCsNotificationType;
                    aNumber: Integer;
                    const aText: string);
  procedure TestQuery(aPipe: TCsDataPipe);
 public
   { Public declarations }
 end;

var
  MainClientForm: TMainClientForm;

implementation

{$R *.dfm}

uses
 CsQueryTypes;

procedure TMainClientForm.FormCreate(Sender: TObject);
begin
 f_Client := TCsClient.Create;
 f_Client.OnNotification := Self.OnNotif;
 lbState.Caption := 'Not connected';
end;

procedure TMainClientForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 if f_Client.IsStarted then
  f_Client.Stop;
 l3Free(f_Client);
end;

procedure TMainClientForm.btConnectClick(Sender: TObject);
begin
 f_Client.Start('localhost', 7777);
 if f_Client.IsStarted then
 begin
  Info('Connected');
  if f_Client.Login('guest', '12345') then
   Info('Connected & Logged');
 end;
end;

procedure TMainClientForm.Info(const aStr: string);
begin
 lbState.Caption := aStr;
end;

procedure TMainClientForm.btDisconnectClick(Sender: TObject);
begin
 f_Client.Stop;
 Info('Disconnected');
end;

procedure TMainClientForm.btQueryClick(Sender: TObject);
begin
 // задаем параметры запроса
 f_Num := 3;
 f_Str := 'Ку';

 // выполняем запрос
 if f_Client.Exec(qtTest, TestQuery) then
  ShowMessage(SysUtils.Format('%d times of "%s" is "%s"', [f_Num, f_Str, f_QueryResult]))
 else
  ShowMessage(SysUtils.Format('Неудача', []));
end;

procedure TMainClientForm.OnNotif(aNotificationType: TCsNotificationType;
  aNumber: Integer; const aText: string);
begin
 ShowMessage(aText);
end;

procedure TMainClientForm.TestQuery(aPipe: TCsDataPipe);
begin
 aPipe.Write(f_Num);
 aPipe.Write(f_Str);
 f_QueryResult := aPipe.ReadStr;
end;

end.
