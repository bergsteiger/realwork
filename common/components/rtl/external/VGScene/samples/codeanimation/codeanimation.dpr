program codeanimation;

uses
  Forms,
  codeanifrm in 'codeanifrm.pas' {frmAniCode};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAniCode, frmAniCode);
  Application.Run;
end.
