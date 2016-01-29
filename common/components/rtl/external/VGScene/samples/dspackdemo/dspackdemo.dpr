program dspackdemo;

uses
  Forms,
  dspackfrm in 'dspackfrm.pas' {frmDSPackDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDSPackDemo, frmDSPackDemo);
  Application.Run;
end.
