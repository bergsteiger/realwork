program Client;

uses
  Forms,
  ClientUnit in 'ClientUnit.pas' {Form1},
  simple_int in 'simple_int.pas',
  simple in 'simple.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
