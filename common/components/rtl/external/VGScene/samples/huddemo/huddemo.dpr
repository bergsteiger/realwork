program huddemo;

uses
  Forms,
  hudemofrm in 'hudemofrm.pas' {frmHUDDemo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHUDDemo, frmHUDDemo);
  Application.Run;
end.
