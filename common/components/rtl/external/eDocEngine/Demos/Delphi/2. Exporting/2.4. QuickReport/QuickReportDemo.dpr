program QuickReportDemo;

uses
  Forms,
  eDocQR in 'eDocQR.pas' {frmQR};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmQR, frmQR);
  Application.Run;
end.
