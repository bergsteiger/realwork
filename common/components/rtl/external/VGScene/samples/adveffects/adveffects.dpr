program adveffects;

uses
  Forms,
  adveffectsfrm in 'adveffectsfrm.pas' {frmAdvEffects};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAdvEffects, frmAdvEffects);
  Application.Run;
end.
