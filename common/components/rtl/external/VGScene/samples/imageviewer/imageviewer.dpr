program imageviewer;

uses
  Forms,
  imageviewerfrm in 'imageviewerfrm.pas' {frmImageViewer};

{$R *.res}

begin                          
  Application.Initialize;
  Application.CreateForm(TfrmImageViewer, frmImageViewer);
  Application.Run;
end.                                                                                                   
