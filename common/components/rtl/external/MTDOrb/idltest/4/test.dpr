program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  enum in 'enum.pas',
  enum_int in 'enum_int.pas';

begin
  mainproc;
end.
