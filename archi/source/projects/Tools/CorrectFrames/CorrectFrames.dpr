program CorrectFrames;

{ $Id: CorrectFrames.dpr,v 1.2 2009/08/07 09:28:10 lulin Exp $ }

// $Log: CorrectFrames.dpr,v $
// Revision 1.2  2009/08/07 09:28:10  lulin
// {RequestLink:159353531}.
//
// Revision 1.1  2009/08/07 06:33:55  lulin
// {RequestLink:159353531}.
//
// Revision 1.1  2009/08/07 06:31:40  lulin
// {RequestLink:159353531}.
//
// Revision 1.1  2004/05/07 15:58:54  law
// - change: утилита FindErrors переехала в каталог Tools.
//
// Revision 1.1  2002/04/11 14:42:30  law
// - new project: FindErrors.
//
// Revision 1.1  2002/02/20 12:45:01  law
// - new units: первая реализация индексации документов.
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
