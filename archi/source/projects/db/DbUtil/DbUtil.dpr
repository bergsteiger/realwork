program DbUtil;

{ $Id: DbUtil.dpr,v 1.8 2015/01/13 09:09:01 voba Exp $ }
// $Log: DbUtil.dpr,v $
// Revision 1.8  2015/01/13 09:09:01  voba
// -����� �������� �������
//
// Revision 1.7  2015/01/12 15:59:49  voba
// -�����
//
// Revision 1.6  2011/07/28 08:30:14  fireton
// - �������� version info ��������� ��������
//
// Revision 1.5  2011/07/27 10:44:53  fireton
// - version info � ������ �������
//
// Revision 1.4  2008/03/25 14:20:19  narry
// - ��������� ��������� ������ ������ �� ������� �������
//
// Revision 1.3  2007/05/11 08:24:14  narry
// - ����������� ���� ������
//
// Revision 1.2  2007/04/17 13:09:20  narry
// - ��������� �������� ������������ ������ ����
//
// Revision 1.1  2004/07/21 16:58:59  step
// ������� �� ������������ �� - �������� � CVS
//

uses
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}
{$R versioninfo.res} // �������� Version Info

begin
 Application.Initialize;
 Application.CreateForm(TMainForm, MainForm);
 Application.Run;
end.
