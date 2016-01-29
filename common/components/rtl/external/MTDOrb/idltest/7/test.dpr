program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  objref_int in 'objref_int.pas',
  objref in 'objref.pas';

begin
  mainproc;
end.
