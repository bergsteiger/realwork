program regiontool;

{ $Id: regiontool.dpr,v 1.13 2016/07/14 06:26:57 lukyanets Exp $}

// $Log: regiontool.dpr,v $
// Revision 1.13  2016/07/14 06:26:57  lukyanets
// �� ����������
//
// Revision 1.12  2015/04/03 11:30:25  lukyanets
// ��������� HT
//
// Revision 1.11  2015/02/17 08:26:56  fireton
// - ������� ������������� ����� ������� ����
//
// Revision 1.10  2014/10/16 11:00:27  lukyanets
// ����� ������������� ������� �������
//
// Revision 1.9  2014/10/08 14:04:45  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.8  2014/10/08 13:07:30  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.7  2013/11/11 10:21:02  fireton
// - ��������� ������ �� ProjectDefine
// - ������ ������ ���� ���������� � ��������
//
// Revision 1.6  2011/07/28 08:30:18  fireton
// - �������� version info ��������� ��������
//
// Revision 1.5  2011/07/27 10:45:34  fireton
// - version info � ������ �������
//
// Revision 1.4  2010/01/22 10:40:26  narry
// - ����������
//
// Revision 1.3  2007/06/19 09:48:50  fireton
// - ����������� �������� ���������� ���������� �������������
//
// Revision 1.2  2007/05/07 08:09:41  fireton
// - cBadRegion ������� � ��������� ������
//
// Revision 1.1  2007/04/09 11:31:43  fireton
// - ������ ������
//

{$I ProjectDefine.inc}

uses
  Controls,
  Forms,
  Dialogs,
  SysUtils,
  l3IniFile,
  ddHTInit,
  Dt_Types,
  daDataProvider,
  ddClientBaseEngine,
  rtMain in 'rtMain.pas' {MainForm},
  rtRegionIDDlg in 'rtRegionIDDlg.pas' {RegionIDDlg},
  rtGrinder in 'rtGrinder.pas';

{$R *.res}
{$R versioninfo.res} // �������� Version Info

function GlobalInit: Boolean;
var
 l_IP  : string;
 l_Port: Integer;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  InitStationConfig;//('Archi.ini');
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
 Application.Title := '����������: ���������� �������� � UserID';
 Application.Initialize;
 try
  try
   if GlobalInit then
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
  except
   // �� ��� �� � Application.Run, ������� �� ����������� ���� ������������ �����
   Application.HandleException(nil);
   Exit;
  end;
 finally
  GlobalDone;
 end;
end.
