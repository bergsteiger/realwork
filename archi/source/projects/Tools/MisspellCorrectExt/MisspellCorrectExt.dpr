program MisspellCorrectExt;

uses
  Forms,
  mceMain in 'mceMain.pas' {MainForm},
  evdSchema;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
