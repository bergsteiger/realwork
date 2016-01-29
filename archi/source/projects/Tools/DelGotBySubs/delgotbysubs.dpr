program delgotbysubs;

{ $Id: delgotbysubs.dpr,v 1.5 2015/04/03 11:30:20 lukyanets Exp $ }

// $Log: delgotbysubs.dpr,v $
// Revision 1.5  2015/04/03 11:30:20  lukyanets
// Изолируем HT
//
// Revision 1.4  2014/10/08 13:07:25  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.3  2008/09/29 12:24:24  fireton
// - bugfix: изменение инициализации базы
//
// Revision 1.2  2008/09/10 12:42:32  fireton
// - предварительная проверка прав на директорию образов
// - более тщательная обработка ошибок при переименовании файлов
//
// Revision 1.1  2008/09/02 15:04:02  fireton
// - первый коммит
//

uses
  Forms,
  Controls,
  Dialogs,
  l3IniFile,
  ddHTInit,
  Dt_Types,
  daDataProvider,
  dtbMain in 'dtbMain.pas' {MainForm};

{$R *.res}

function GlobalInit: Boolean;
var
 l_IP  : string;
 l_Port: Integer;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  StationConfig:=TCfgList.Create('Archi.ini');
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
 Application.Title := 'Архивариус: удаление "получено по рассылке"';
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

  if Assigned(GlobalHtServer) then
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
