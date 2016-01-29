program client;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  ex in 'ex.pas',
  ex_int in 'ex_int.pas',
  cl_main in 'cl_main.pas';

begin
  mainproc;
end.
