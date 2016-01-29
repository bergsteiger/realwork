program effects;

uses
  Forms,
  effectsfrm in 'effectsfrm.pas' {frmEffects};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmEffects, frmEffects);
  Application.Run;
end.
