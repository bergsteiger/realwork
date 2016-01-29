program Appender;

uses
 SysUtils
 ;

var
 F : Text;
 N : AnsiString;
begin
 N := ParamStr(1);
 AssignFile(F, N);
 if FileExists(N) then
  Append(F)
 else
  Rewrite(F);
 try
  WriteLn(F, ParamStr(2));
 finally
  CloseFile(F);
 end;//try..finally
end.