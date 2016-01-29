program FontDemo;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  GDIPUTIL in '..\..\PDFProcessorDLL\GDIPUTIL.pas',
  GDIPAPI in '..\..\PDFProcessorDLL\GDIPAPI.pas',
  GDIPOBJ in '..\..\PDFProcessorDLL\GDIPOBJ.pas';

{$R *.res}

begin
  Application.Initialize;
  //Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
