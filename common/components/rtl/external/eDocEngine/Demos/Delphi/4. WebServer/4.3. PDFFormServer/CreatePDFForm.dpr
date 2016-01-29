program CreatePDFForm;

uses
  Forms,
  Submit in 'Submit.pas' {frmSample};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSample, frmSample);
  Application.Run;
end.
