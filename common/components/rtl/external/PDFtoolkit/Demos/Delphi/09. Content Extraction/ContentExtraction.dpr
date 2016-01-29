program ContentExtraction;

uses
  Forms,
  uContentExtraction in 'uContentExtraction.pas' {Form1},
  PDFtoolkitUsage in 'PDFtoolkitUsage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
