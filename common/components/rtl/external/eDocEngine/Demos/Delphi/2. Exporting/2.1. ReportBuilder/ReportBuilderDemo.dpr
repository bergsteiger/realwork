program ReportBuilderDemo;

uses
  Forms,
  eDocRB in 'eDocRB.pas' {frmRB};
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRB, frmRB);
  Application.Run;
end.
