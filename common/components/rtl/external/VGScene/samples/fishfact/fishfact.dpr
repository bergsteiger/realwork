program fishfact;

uses
  Forms,
  fishfactfrm in 'fishfactfrm.pas' {frmFishFact};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmFishFact, frmFishFact);
  Application.Run;
end.
