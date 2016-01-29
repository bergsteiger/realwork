program imdemo;

uses
  Forms,
  imdemofrm in 'imdemofrm.pas' {frmIM};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmIM, frmIM);
  Application.Run;
end.
