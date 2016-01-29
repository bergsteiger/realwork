program Demo;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Options in 'Options.pas' {OptionsForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.Run;
end.
