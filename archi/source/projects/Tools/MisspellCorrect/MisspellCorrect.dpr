program MisspellCorrect;

{ $Id: MisspellCorrect.dpr,v 1.1 2010/05/07 14:21:26 fireton Exp $ }

// $Log: MisspellCorrect.dpr,v $
// Revision 1.1  2010/05/07 14:21:26  fireton
// - initial
//

uses
  evdSchema,
  Forms,
  Main in 'Main.pas' {MainForm}
  ;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
