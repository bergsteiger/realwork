program Viewer;

uses
  Forms,
  Main in 'Main.pas' {frmPDFViewerDemo},
  Password in 'Password.pas' {frmPassword},
  gtAboutBoxDlg in 'gtAboutBoxDlg.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPDFViewerDemo, frmPDFViewerDemo);
  Application.CreateForm(TfrmPassword, frmPassword);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.                                     
