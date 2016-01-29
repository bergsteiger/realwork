program EldoSExplorer;

uses
  Forms,
  ExplorerMain in 'ExplorerMain.pas' {frmElShellExplorer};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'EldoS Explor';
  Application.CreateForm(TfrmElShellExplorer, frmElShellExplorer);
  Application.Run;
end.
