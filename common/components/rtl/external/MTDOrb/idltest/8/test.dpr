program test;
{$APPTYPE CONSOLE}
uses
{$IFDEF USELIB}
  ShareMem,
{$ENDIF}
  main in 'main.pas',
  attribute_int in 'attribute_int.pas',
  attribute in 'attribute.pas';

begin
  mainproc;
end.
