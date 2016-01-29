program TestStress;

uses
  Forms,
  Main in 'Main.pas' {Form3},
  SendThread in 'SendThread.pas',
  ReceiveThread in 'ReceiveThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
