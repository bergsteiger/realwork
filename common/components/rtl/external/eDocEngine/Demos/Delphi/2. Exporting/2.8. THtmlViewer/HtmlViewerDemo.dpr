program HtmlViewerDemo;

uses
  Forms,
  eDocHtmlViewer in 'eDocHtmlViewer.pas' {frmHtmlViewer};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHtmlViewer, frmHtmlViewer);
  Application.Run;
end.
