program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  struct_int in 'struct_int.pas',
  struct in 'struct.pas',
  main in 'main.pas';

begin
  mainproc;
end.
