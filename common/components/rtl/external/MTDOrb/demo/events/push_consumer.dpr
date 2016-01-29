program push_consumer;

uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  Forms,
  push_consumer_main in 'push_consumer_main.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
