program calendarcl;

uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  Forms,
  client in 'client.pas' {Form1},
  calendar in 'calendar.pas',
  calendar_int in 'calendar_int.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
