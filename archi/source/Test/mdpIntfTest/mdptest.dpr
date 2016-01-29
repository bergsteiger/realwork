program mdptest;

uses
  Forms,
  Controls,
  Dialogs,
  {$IFNDEF ARCHIFREE}
  l3IniFile,
  ddHtInit,
  daDataProvider,
  {$ENDIF}
  mdpMain in 'mdpMain.pas' {MainForm};

{$R *.res}

{$IFNDEF ARCHIFREE}
function GlobalInit: Boolean;
var
 l_IP  : string;
 l_Port: Integer;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  StationConfig := TCfgList.Create;
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
{$ENDIF}


begin
 Application.Title := 'Архивариус: MDP Import';
 Application.Initialize;
 {$IFNDEF ARCHIFREE}
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
   {$ENDIF}
    Application.CreateForm(TMainForm, MainForm);
    Application.Run;
   {$IFNDEF ARCHIFREE}
   end
   else
   begin
    MessageDlg('У вас нет административных прав!', mtError, [mbYes], 0);
   end;
  end;
 finally
  GlobalDone;
 end;
 {$ENDIF}
end.

