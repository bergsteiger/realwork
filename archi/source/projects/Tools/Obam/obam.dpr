program obam;

uses
  Forms,
  o_main in 'o_main.pas' {MainForm},
  ObamReader in 'ObamReader.pas';

{$R *.res}
{$R versioninfo.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
