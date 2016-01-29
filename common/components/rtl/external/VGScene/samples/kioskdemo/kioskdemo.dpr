program kioskdemo;

uses
  Forms,
  kioskform in 'kioskform.pas' {frmKiosk};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmKiosk, frmKiosk);
  Application.Run;
end.
