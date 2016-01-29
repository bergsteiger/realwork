program ConvertChangedBy;

{ $Id: ConvertChangedBy.dpr,v 1.2 2012/01/04 11:34:36 narry Exp $ }

// $Log: ConvertChangedBy.dpr,v $
// Revision 1.2  2012/01/04 11:34:36  narry
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
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '"Архивариус". Исправление заголовков.';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
