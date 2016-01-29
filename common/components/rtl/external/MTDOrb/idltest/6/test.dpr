program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  sequence_int in 'sequence_int.pas',
  sequence in 'sequence.pas';

begin
  mainproc;
end.
