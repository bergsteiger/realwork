program impchdate;

{ $Id: impchdate.dpr,v 1.5 2015/06/16 09:35:46 fireton Exp $ }

// $Log: impchdate.dpr,v $
// Revision 1.5  2015/06/16 09:35:46  fireton
// - ��������� impchdate � ������
//
// Revision 1.4  2015/04/03 11:30:22  lukyanets
// ��������� HT
//
// Revision 1.3  2015/03/18 12:04:17  fireton
// - ���������
//
// Revision 1.2  2014/10/08 13:07:28  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.1  2013/10/10 11:19:07  fireton
// - ������� ���������� ���������� ����������
//
// Revision 1.3  2008/09/29 12:24:24  fireton
// - bugfix: ��������� ������������� ����
//
// Revision 1.2  2008/09/10 12:42:32  fireton
// - ��������������� �������� ���� �� ���������� �������
// - ����� ���������� ��������� ������ ��� �������������� ������
//
// Revision 1.1  2008/09/02 15:04:02  fireton
// - ������ ������
//

uses
  Forms,
  Controls,
  Dialogs,
  l3IniFile,
  ddHTInit,
  ddClientBaseEngine,
  Dt_Types,
  Dt_Serv,
  daDataProvider,
  icdMain in 'icdMain.pas' {Form1};

{$R *.res}
{$R versioninfo.res}

{$I ProjectDefine.inc}

function GlobalInit: Boolean;
var
 l_IP  : string;
 l_Port: Integer;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  //StationConfig:=TCfgList.Create('Archi.ini');
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
   if GlobalDataProvider.AdminRights then
   begin
    Application.CreateForm(TForm1, Form1);
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
