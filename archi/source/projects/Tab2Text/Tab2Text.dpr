program Tab2Text;

uses
  Forms,
  Tab2TextForm in 'Tab2TextForm.pas' {Form1},
  Tab2TableGen in 'Tab2TableGen.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Преобразователь реестра цен';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
