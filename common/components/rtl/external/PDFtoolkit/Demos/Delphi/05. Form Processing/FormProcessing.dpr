program FormProcessing;

uses
  Forms,
  uFormProcessing in 'uFormProcessing.pas' {Form1},
  PDFtoolkitUsage in 'PDFtoolkitUsage.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
