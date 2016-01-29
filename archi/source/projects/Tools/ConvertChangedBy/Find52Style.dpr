program Find52Style;

{ $Id: Find52Style.dpr,v 1.1 2012/01/04 11:34:36 narry Exp $ }

// $Log: Find52Style.dpr,v $
// Revision 1.1  2012/01/04 11:34:36  narry
// Утилита построения списка измененных (325261072)
//
// Revision 1.1  2011/06/23 13:33:33  narry
// Написать утилиту, которая выделит текст с датами изменений в отдельный абзац (255979284)
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
  Find52StyleMain in 'Find52StyleMain.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '"Архивариус". Поиск стиля 52';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
