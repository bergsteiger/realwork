program docren;

{ $Id: docren.dpr,v 1.4 2015/04/03 11:30:21 lukyanets Exp $ }

// $Log: docren.dpr,v $
// Revision 1.4  2015/04/03 11:30:21  lukyanets
// Изолируем HT
//
// Revision 1.3  2014/10/13 10:31:46  lukyanets
// Убираем дублирующиеся параметры
//
// Revision 1.2  2014/10/08 13:07:27  lukyanets
// Переносим процедуры в правильное место
//
// Revision 1.1  2007/12/03 09:11:21  fireton
// - первый коммит
//

uses
  Controls,
  Forms,
  Dialogs,
  l3IniFile,
  ddHTInit,
  Dt_Types,
  daDataProvider,
  drMain in 'drMain.pas' {MainForm};

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
  l_IP := StationConfig.ReadParamStrDef('ServerName', '');
  l_Port := StationConfig.ReadParamIntDef('ServerPort', 32100);
  Result := InitBaseEngine(akClient, l_IP, l_Port);
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure GlobalDone;
begin
 DoneClientBaseEngine;
end;


begin
 Application.Title := 'Архивариус: переименование заголовков документов';
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