program DbVerify;

{ $Id: DbVerify.dpr,v 1.1 2005/09/26 14:23:36 step Exp $ }
// $Log: DbVerify.dpr,v $
// Revision 1.1  2005/09/26 14:23:36  step
// занесено в cvs
//

uses
  Forms,
  Main in 'Main.pas' {FormMain},
  DbVerifier in 'DbVerifier.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Проверка БД "Архивариуса"';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
