program AdjustToPage;

{ $Id: AdjustToPage.dpr,v 1.4 2011/07/28 08:30:11 fireton Exp $ }

// $Log: AdjustToPage.dpr,v $
// Revision 1.4  2011/07/28 08:30:11  fireton
// - включаем version info отдельным ресурсом
//
// Revision 1.3  2011/07/27 10:44:23  fireton
// - version info в ночных сборках
//
// Revision 1.2  2010/07/01 15:20:04  narry
// - K222036156
//
// Revision 1.1  2010/04/16 09:15:42  fireton
// - initial commit
//

uses
  evdSchema,
  Forms,
  Main in 'Main.pas' {MainForm}
  ;

{$R *.res}
{$R versioninfo.res} // включаем Version Info

begin
  Application.Initialize;
  Application.Title := '"Архивариус". Автоматическая расстановка разделов.';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
