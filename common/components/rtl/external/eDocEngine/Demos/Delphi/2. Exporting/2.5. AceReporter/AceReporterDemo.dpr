program AceReporterDemo;

uses
  Forms,
  eDocAce in 'eDocAce.pas' {frmAce};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAce, frmAce);
  Application.Run;
end.
