program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  a in 'a.pas',
  a_int in 'a_int.pas',
  b_int in 'b_int.pas';

begin
  mainproc;
end.
