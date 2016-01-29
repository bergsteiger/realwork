program FastReportDemo;

uses
  Forms,
  eDocFR in 'eDocFR.pas' {frmFR};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFR, frmFR);
  Application.Run;
end.
