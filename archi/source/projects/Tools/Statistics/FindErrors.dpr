program FindErrors;

{ $Id: FindErrors.dpr,v 1.1 2004/05/07 15:58:54 law Exp $ }

// $Log: FindErrors.dpr,v $
// Revision 1.1  2004/05/07 15:58:54  law
// - change: ������� FindErrors ��������� � ������� Tools.
//
// Revision 1.1  2002/04/11 14:42:30  law
// - new project: FindErrors.
//
// Revision 1.1  2002/02/20 12:45:01  law
// - new units: ������ ���������� ���������� ����������.
//
// Revision 1.1  2002/01/16 15:42:07  law
// - new project: Old2New.
//

uses
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
