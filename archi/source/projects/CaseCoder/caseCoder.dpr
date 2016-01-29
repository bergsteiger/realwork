program caseCoder;

uses
  Forms,
  evdSchema,
  main in 'main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
