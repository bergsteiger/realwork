program IsTheySwitch;

uses
  Forms,
  its_Main in 'its_Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
