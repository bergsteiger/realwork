program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  inheritance_int in 'inheritance_int.pas',
  inheritance in 'inheritance.pas';

begin
  mainproc;
end.
