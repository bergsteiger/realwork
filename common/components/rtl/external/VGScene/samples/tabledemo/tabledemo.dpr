program tabledemo;

uses
  Forms,
  tablefrm in 'tablefrm.pas' {frmTableDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmTableDemo, frmTableDemo);
  Application.Run;
end.
