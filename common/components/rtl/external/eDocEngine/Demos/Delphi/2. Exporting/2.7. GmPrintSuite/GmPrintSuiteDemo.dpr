program GmPrintSuiteDemo;

uses
  Forms,
  eDocGmPrintSuite in 'eDocGmPrintSuite.pas' {frmGmPrintSuite};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmGmPrintSuite, frmGmPrintSuite);
  Application.Run;
end.
