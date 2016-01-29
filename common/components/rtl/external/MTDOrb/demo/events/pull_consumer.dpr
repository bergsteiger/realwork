program pull_consumer;

uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  Forms,
  pull_consumer_main in 'pull_consumer_main.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
