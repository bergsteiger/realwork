program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  container_int in 'container_int.pas',
  container in 'container.pas';

begin
  mainproc;
end.
