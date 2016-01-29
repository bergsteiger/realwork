program JobStats;

{ $Id: JobStats.dpr,v 1.3 2004/10/06 16:31:16 step Exp $ }
// $Log: JobStats.dpr,v $
// Revision 1.3  2004/10/06 16:31:16  step
// - исправлен подсчет суммарного объема документов
// - исправлена проверка пароля
//
// Revision 1.2  2004/10/01 11:18:44  step
// изменено форматирование результатов и др. мелочи
//
// Revision 1.1  2004/09/30 18:07:00  step
// занесено в CVS
//

uses
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
 Application.Initialize;
 try
  GlobalInit;
 except
  GlobalDone;
  Exit;
 end;
 Application.CreateForm(TMainForm, MainForm);
 Application.Run;
 GlobalDone;
end.
