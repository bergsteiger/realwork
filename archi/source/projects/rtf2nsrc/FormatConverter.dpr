program FormatConverter;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  FileConverter;

begin
 with TFileConverter.Create do
 try
  Run;
 finally
  Free;
 end;
end.
 