program calendar_serv;

uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  Forms,
  server in 'server.pas' {Form1},
  calendar in 'calendar.pas',
  calendar_int in 'calendar_int.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
