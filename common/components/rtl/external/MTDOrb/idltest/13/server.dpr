program server;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  ex in 'ex.pas',
  ex_int in 'ex_int.pas',
  srv_main in 'srv_main.pas';

begin
  mainproc;
end.
