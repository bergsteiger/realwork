program driver_test;

uses
  Forms in 'w:\common\components\rtl\external\Borland\Delphi\Vcl\Forms.pas',
  Classes in 'W:\common\components\rtl\external\Borland\Delphi\Rtl\Common\Classes.pas',
  testunit in 'testunit.pas' {Form1},
  nsIntegrationInterface in '..\nsIntegrationInterface.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
