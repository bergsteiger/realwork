program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  typedef_int in 'typedef_int.pas',
  typedef in 'typedef.pas';

begin
  mainproc;
end.
