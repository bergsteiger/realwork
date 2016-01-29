program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  _array_int in '_array_int.pas',
  _array in '_array.pas';

begin
  mainproc;
end.
