program UpdateOldIndex;

{ $Id: UpdateOldIndex.dpr,v 1.1 2002/04/03 12:14:31 law Exp $ }

// $Log: UpdateOldIndex.dpr,v $
// Revision 1.1  2002/04/03 12:14:31  law
// - new project: UpdateOldIndex.
//
// Revision 1.1  2002/02/20 12:45:01  law
// - new units: первая реализация индексации документов.
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
