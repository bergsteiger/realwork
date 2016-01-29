program layered;

uses
  Forms,
  layerfrm in 'layerfrm.pas' {frmLayered};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLayered, frmLayered);
  Application.Run;
end.
