program AddThumbnail;

uses
  Forms,
  uAddThumbnail in 'uAddThumbnail.pas' {Form1},
  PDFtoolkitUsage in 'PDFtoolkitUsage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
