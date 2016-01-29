program flashdemo;

uses
  Forms,
  flashdemofrm in 'flashdemofrm.pas' {frmFlash};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFlash, frmFlash);
  Application.Run;
end.
