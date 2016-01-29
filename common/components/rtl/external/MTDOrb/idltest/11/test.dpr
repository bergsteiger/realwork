program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  _const_int in '_const_int.pas',
  _const in '_const.pas';

begin
  mainproc;
end.
