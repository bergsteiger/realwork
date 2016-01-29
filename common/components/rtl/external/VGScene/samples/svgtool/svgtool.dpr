program svgtool;

uses
  Forms,
  svgtoolfrm in 'svgtoolfrm.pas' {frmSVGTool};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmSVGTool, frmSVGTool);
  Application.Run;
end.
