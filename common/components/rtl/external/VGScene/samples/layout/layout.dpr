program layout;

uses
  Forms,
  layoutdemoform in 'layoutdemoform.pas' {frmLayout};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmLayout, frmLayout);
  Application.Run;
end.
