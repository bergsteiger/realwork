program RestoreHLinks;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  HLinkRestorer in 'HLinkRestorer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

