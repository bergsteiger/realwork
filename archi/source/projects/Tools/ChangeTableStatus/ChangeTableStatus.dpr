program ChangeTableStatus;

{ $Id: ChangeTableStatus.dpr,v 1.1 2010/07/15 13:07:39 dinishev Exp $ }

// $Log: ChangeTableStatus.dpr,v $
// Revision 1.1  2010/07/15 13:07:39  dinishev
// [$226005005]
//

uses
  evdSchema,
  Forms,
  Main in 'Main.pas' {MainForm}
  ;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Утилита выставления флага "Выливать в псевдографику".';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
