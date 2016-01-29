program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  module in 'module.pas',
  module_int in 'module_int.pas';

begin
  mainproc;
end.
