program xmldocfind;

{$DEFINE NeedGlobalInit}

uses
  Forms,
  Controls,
  Dialogs,
  l3IniFile,
  ddHtInit,
  daDataProvider,
  xdf_main in 'xdf_main.pas' {MainForm};

{$R *.res}

{$IFDEF NeedGlobalInit}
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
 Application.Title := 'Архивариус: тест всяких штуковин';
 Application.Initialize;
 try
  {$IFDEF NeedGlobalInit}
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
   {$IFDEF NeedGlobalInit}
   end
   else
   begin
    MessageDlg('У вас нет административных прав!', mtError, [mbYes], 0);
   end;
  end;
  {$ENDIF}
 finally
  {$IFDEF NeedGlobalInit}
  GlobalDone;
  {$ENDIF}
 end;
end.
