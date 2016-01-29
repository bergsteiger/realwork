program HCAdapterTest;

uses
  Forms,
  MainForm in 'MainForm.pas' {frmMain},
  hcDeleteQueryOptionsForm in 'View\hcDeleteQueryOptionsForm.pas' {frmDeleteQueryOptions},
  hcQueryStatusForm in 'View\hcQueryStatusForm.pas' {frmQueryStatus};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
