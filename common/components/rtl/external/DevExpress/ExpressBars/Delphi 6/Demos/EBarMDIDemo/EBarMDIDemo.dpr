program EBarMDIDemo;

uses
  Forms,
  Unit1 in 'Unit1.pas' {MainForm};

{$R *.RES}

begin
  Application.Title := 'ExpressBar MDI Demo';
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
