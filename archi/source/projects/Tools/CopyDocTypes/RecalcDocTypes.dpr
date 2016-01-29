program RecalcDocTypes;

{ $Id: RecalcDocTypes.dpr,v 1.1 2004/08/25 15:17:37 step Exp $ }
// $Log: RecalcDocTypes.dpr,v $
// Revision 1.1  2004/08/25 15:17:37  step
// переименование файлов и мелкие исправления
//

uses
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Обновление типов документов';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
