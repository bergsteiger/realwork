program ClearClass;

uses
  Controls,
  Forms,
  Dialogs,
  l3IniFile,
  ddHTInit,
  Dt_Types,
  daDataProvider,
  ddClientBaseEngine,
  ccForm in 'ccform.pas' {ClearClassForm};

{$R *.res}
{$R versioninfo.res}
{$I ProjectDefine.inc}

function GlobalInit: Boolean;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  InitStationConfig;
  Result := InitBaseEngine;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure GlobalDone;
begin
 DoneClientBaseEngine;
end;

begin
 Application.Title := 'Архивариус: утилита очистки классов';
 Application.Initialize;
 try
  try
   if GlobalInit then
   begin
    if GlobalDataProvider.AdminRights then
    begin
     Application.CreateForm(TClearClassForm, ClearClassForm);
     Application.Run;
    end
    else
    begin
     MessageDlg('У вас нет административных прав!', mtError, [mbYes], 0);
    end;
   end;
  except
   // Мы еще не в Application.Run, поэтому об исключениях надо позаботиться самим
   Application.HandleException(nil);
   Exit;
  end;
 finally
  GlobalDone;
 end;
end.
