program docren;

{ $Id: docren.dpr,v 1.4 2015/04/03 11:30:21 lukyanets Exp $ }

// $Log: docren.dpr,v $
// Revision 1.4  2015/04/03 11:30:21  lukyanets
// ��������� HT
//
// Revision 1.3  2014/10/13 10:31:46  lukyanets
// ������� ������������� ���������
//
// Revision 1.2  2014/10/08 13:07:27  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.1  2007/12/03 09:11:21  fireton
// - ������ ������
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
 Application.Title := '����������: �������������� ���������� ����������';
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