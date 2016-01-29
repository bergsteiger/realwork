program ReplaceSoftEnter;

{ $Id: ReplaceSoftEnter.dpr,v 1.1 2012/02/07 06:49:01 narry Exp $ }

// $Log: ReplaceSoftEnter.dpr,v $
// Revision 1.1  2012/02/07 06:49:01  narry
// Утилита по замене мягких переносов (335580209)
//
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
  ReplaceSoftEnterForm.cfg in 'ReplaceSoftEnterForm.cfg.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '"Архивариус". Поиск стиля 52';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
