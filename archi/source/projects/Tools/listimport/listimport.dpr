program listimport;

{$I ProjectDefine.inc}

uses
  Forms,
  Controls,
  Dialogs,
  l3IniFile,
  ddHtInit,
  daDataProvider,
  ddClientBaseEngine,
  liMain in 'liMain.pas' {MainForm},
  liEngine in 'liEngine.pas';

{$R *.res}
{$R versioninfo.res} // включаем Version Info

function GlobalInit: Boolean;
var
 l_IP  : string;
 l_Port: Integer;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  //InitStationConfig('Archi.ini');
  Result := InitBaseEngine();
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
 Application.Title := 'Архивариус: импорт реестров';
 Application.Initialize;
 try
  try
   if not GlobalInit then
    Exit;
  except
   // Мы еще не в Application.Run, поэтому об исключениях надо позаботиться самим
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
    MessageDlg('У вас нет административных прав!', mtError, [mbYes], 0);
   end;
  end;
 finally
  GlobalDone;
 end;
end.
