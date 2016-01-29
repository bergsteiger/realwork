program NameSpell;

{ $Id: NameSpell.dpr,v 1.1 2011/07/07 05:56:36 narry Exp $ }

// $Log: NameSpell.dpr,v $
// Revision 1.1  2011/07/07 05:56:36  narry
// Утилита исправления названий и текстов (271757472)
//
uses
  evdSchema,
  Forms,
  NameSpellMain in 'NameSpellMain.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '"Архивариус". Чистка названий и текстов.';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
