program ExpressBarV3;

uses
  Forms,
  main in 'main.pas' {MainForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'ExpressBar Demo (Enchanced Style)';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
