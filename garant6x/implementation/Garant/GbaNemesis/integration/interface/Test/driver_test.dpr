program driver_test;

uses
  Forms,
  testunit in 'testunit.pas' {Form1},
  nsIntegrationInterface in '..\nsIntegrationInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
