program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  pseudo_int in 'pseudo_int.pas',
  pseudo in 'pseudo.pas';

begin
  mainproc;
end.
