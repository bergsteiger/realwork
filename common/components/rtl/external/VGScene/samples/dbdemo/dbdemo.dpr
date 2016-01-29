program dbdemo;

uses
  Forms,
  dbfrm in 'dbfrm.pas' {frmDB};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDB, frmDB);
  Application.Run;
end.
