program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  union in 'union.pas',
  union_int in 'union_int.pas';

begin
  mainproc;
end.
