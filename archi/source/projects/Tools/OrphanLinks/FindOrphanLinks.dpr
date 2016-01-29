program FindOrphanLinks;

uses
  Forms,
  Controls,
  Dialogs,
  l3IniFile,
  ddHTInit,
  Dt_Types,
  DT_Serv,
  ddClientBaseEngine,
  findMain in 'findMain.pas' {MainForm};

{$R *.res}

function GlobalInit: Boolean;
var
 l_IP  : string;
 l_Port: Integer;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  //StationConfig:=TCfgList.Create('Archi.ini');
  Result := InitBaseEngine(nil, False, True);
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure GlobalDone;
begin
 if Assigned(g_BaseEngine) and (g_BaseEngine.IsStarted) then
  DoneClientBaseEngine;
end;


begin
 Application.Title := '����������: �������� "�������� �� ��������"';
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

  if Assigned(GlobalHtServer) then
  begin
   Application.CreateForm(TMainForm, MainForm);
   Application.Run;
  end;
 finally
  GlobalDone;
 end;
end.

