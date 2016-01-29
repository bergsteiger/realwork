program Basic;

uses
  Forms,
  uProgress in 'uProgress.pas' {frmProgress},
  uMain in 'uMain.pas' {fmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfrmProgress, frmProgress);
  Application.Run;
end.
