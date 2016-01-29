program aeroglass;

uses
  Forms,
  aerofrm in 'aerofrm.pas' {frmAeroGlass};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmAeroGlass, frmAeroGlass);
  Application.Run;
end.
