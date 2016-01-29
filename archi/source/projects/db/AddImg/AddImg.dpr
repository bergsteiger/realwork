program AddImg;

{ $Id: AddImg.dpr,v 1.18 2014/12/12 11:48:06 fireton Exp $ }
// $Log: AddImg.dpr,v $
// Revision 1.18  2014/12/12 11:48:06  fireton
// - �� �����������
//
// Revision 1.17  2014/10/16 11:15:39  lukyanets
// ����� ������������� ������� �������
//
// Revision 1.16  2014/10/16 11:00:25  lukyanets
// ����� ������������� ������� �������
//
// Revision 1.15  2014/10/08 14:04:43  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.14  2014/10/08 13:07:24  lukyanets
// ��������� ��������� � ���������� �����
//
// Revision 1.13  2013/05/20 11:30:50  fireton
// - �� ����������
//
// Revision 1.12  2011/07/28 08:30:11  fireton
// - �������� version info ��������� ��������
//
// Revision 1.11  2011/07/27 10:44:19  fireton
// - version info � ������ �������
//
// Revision 1.10  2008/10/03 10:25:54  fireton
// - ������� ��������� ������ ����� ���� �� ������ TIFF
//
// Revision 1.9  2008/09/15 10:36:56  fireton
// - ���������� ������������� (������������� ServerConfig)
//
// Revision 1.8  2008/05/05 11:21:50  fireton
// - �� ���������������
//
// Revision 1.7  2007/04/28 08:44:37  fireton
// - ������ � �������� ������������� ������ ������������ ������������
//
// Revision 1.6  2006/12/14 10:11:09  fireton
// - ��������� "��������������" � �������
// - ������� "������� �� ���������"
// - ������ ��������������
// - ������ ����
//
// Revision 1.5  2006/12/13 13:50:57  fireton
// - ��������� ������ � ���������
// - ���� "�������� �� ��������" ��� ����, ����������� ��� "�������� �� �������� 2"
// - ������ ������� ������ � ��� ���������
// - ����������� ������ � ���� ���������
//
// Revision 1.4  2005/11/03 14:24:45  step
// ���������� ���������� ������������ ��
//
// Revision 1.3  2005/10/27 13:18:29  step
// ��������� ����������� ��������� �������� �������������
//
// Revision 1.2  2005/05/17 09:32:34  lulin
// - cleanup.
//
// Revision 1.1  2005/03/15 17:16:13  step
// �������� � CVS
//

{$I ProjectDefine.inc}

uses
  Forms, Controls, SysUtils, Dialogs,
  Main in 'Main.pas' {formMain},
  ImgLoader in 'ImgLoader.pas',
 l3Base,

 l3IniFile,
 ddHTInit,
 ddClientBaseEngine

 ;

{$R *.res}
{$R versioninfo.res} // �������� Version Info

function GlobalInit: Boolean;
begin
 Result := False;
 Screen.Cursor := crHourGlass;
 try
  InitStationConfig();
  Result := InitBaseEngine();
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure GlobalDone;
begin
 DoneClientBaseEngine;
end;


begin
 Application.Initialize;

 try
  if not GlobalInit then
   Exit;
 except
  on E: Exception do
  begin
   MessageDlg(E.Message, mtError, [mbYes], 0);
   GlobalDone;
   Exit;
  end;
 end;

 Application.Title := '����������: ����������� ������� � ��';
  Application.CreateForm(TformMain, formMain);
 Application.Run;
 GlobalDone;
end.
