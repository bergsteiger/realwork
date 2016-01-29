program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  forward_int in 'forward_int.pas',
  forward in 'forward.pas';

begin
  mainproc;
end.
