program hello;

uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  Forms,
  main in 'main.pas' {Form1},
  helloworld in 'helloworld.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
