program IndexOld;

{ $Id: IndexOld.dpr,v 1.2 2007/08/25 17:45:20 lulin Exp $ }

// $Log: IndexOld.dpr,v $
// Revision 1.2  2007/08/25 17:45:20  lulin
// - bug fix: �� ���� ���������� ����� ���������.
//
// Revision 1.1  2004/05/07 13:08:35  law
// - change: ������� IndexOld ��������� � ������� Tools.
//
// Revision 1.1  2002/02/20 12:45:01  law
// - new units: ������ ���������� ���������� ����������.
//
// Revision 1.1  2002/01/16 15:42:07  law
// - new project: Old2New.
//

uses
  evdSchema,
  Forms,
  Main in 'Main.pas', {MainForm}
  D_MEMUSG in '..\..\Everest\dlg\D_MEMUSG.PAS' {MemoryUsageDlg}
  ;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
