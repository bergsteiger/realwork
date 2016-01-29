program ribbon;

uses
  Forms,
  ribbonfrm in 'ribbonfrm.pas' {frmRibbon};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmRibbon, frmRibbon);
  Application.Run;
end.
