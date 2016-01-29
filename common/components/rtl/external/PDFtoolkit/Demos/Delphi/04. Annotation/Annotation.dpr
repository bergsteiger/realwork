program Annotation;

uses
  Forms,
  uAnnotation in 'uAnnotation.pas' {Form1},
  PDFtoolkitUsage in 'PDFtoolkitUsage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
