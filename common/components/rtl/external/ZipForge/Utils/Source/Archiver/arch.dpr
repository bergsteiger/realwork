program arch;

uses
  Forms,
  arch1 in 'arch1.pas' {MainForm},
  uAbout in 'uAbout.pas' {AboutBox},
  uAdd in 'uAdd.pas' {frmAdd},
  uExtract in 'uExtract.pas' {frmExtract},
  uProgress in 'uProgress.pas' {frmProgress};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Archiver';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.CreateForm(TfrmAdd, frmAdd);
  Application.CreateForm(TfrmExtract, frmExtract);
  Application.CreateForm(TfrmProgress, frmProgress);
  Application.Run;
end.
