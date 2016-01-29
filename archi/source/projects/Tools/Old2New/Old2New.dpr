program Old2New;

{ $Id: Old2New.dpr,v 1.1 2004/05/07 09:29:59 law Exp $ }

// $Log: Old2New.dpr,v $
// Revision 1.1  2004/05/07 09:29:59  law
// - change: утилита Old2New переехала в каталог Tools.
//
// Revision 1.2  2002/02/20 13:30:44  law
// - cleanup.
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
