program vgdesigner;

uses
  Forms,
  designform in 'designform.pas' {frmDesigner};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDesigner, frmDesigner);
  Application.Run;
end.
