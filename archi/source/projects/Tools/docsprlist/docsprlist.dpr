program docsprlist;

{ $Id: docsprlist.dpr,v 1.4 2015/04/03 11:30:22 lukyanets Exp $ }

// $Log: docsprlist.dpr,v $
// Revision 1.4  2015/04/03 11:30:22  lukyanets
// ��������� HT
//
// Revision 1.3  2014/10/13 10:31:47  lukyanets
// ������� ������������� ���������
//
// Revision 1.2  2014/10/08 13:07:27  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.1  2008/04/24 15:00:50  fireton
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
  dslMain in 'dslMain.pas' {MainForm};

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
 Application.Title := '����������: ������ ���������� �� ���������';
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