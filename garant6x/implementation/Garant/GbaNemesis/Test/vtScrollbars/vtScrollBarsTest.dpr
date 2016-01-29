program vtScrollBarsTest;

uses
  Forms,
  frMain in 'frMain.pas' {Form1},
  vtScrollbar in '..\..\..\..\..\..\common\components\gui\Garant\VT\vtScrollbar.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
