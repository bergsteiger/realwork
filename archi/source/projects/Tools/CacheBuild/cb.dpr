program cb;

{$I ProjectDefine.inc}

uses
  Forms,
  Controls,
  Dialogs,
  l3IniFile,
  ddHtInit,
  daDataProvider,
  ddClientBaseEngine,
  cb_Main in 'cb_Main.pas' {MainForm};

{$R *.res}

function GlobalInit: Boolean;
var
 l_IP  : string;
 l_Port: Integer;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
 // StationConfig := TCfgList.Create;
  Result := InitBaseEngine();
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure GlobalDone;
begin
 DoneClientBaseEngine;
end;


begin
 Application.Title := '����������: ��� ��������������';
 Application.Initialize;
 try
  try
   if not GlobalInit then
    Exit;
  except
   // �� ��� �� � Application.Run, ������� �� ����������� ���� ������������ �����
   Application.HandleException(nil);
   Exit;
  end;

  if Assigned(g_BaseEngine) and (g_BaseEngine.IsStarted) then
  begin
   if GlobalDataProvider.AdminRights then
   begin
    Application.CreateForm(TMainForm, MainForm);
  Application.Run;
   end
   else
   begin
    MessageDlg('� ��� ��� ���������������� ����!', mtError, [mbYes], 0);
   end;
  end;
 finally
  GlobalDone;
 end;
end.

