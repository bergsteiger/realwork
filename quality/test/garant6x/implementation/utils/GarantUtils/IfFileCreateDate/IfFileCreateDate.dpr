program IfFileCreateDate;

{$APPTYPE CONSOLE}

uses
  SysUtils, DateUtils;
var
  MinsBetween: Int64;

function GetFileDateTime(FileName: string): TDateTime;
var
  intFileAge: LongInt;
begin
  intFileAge := FileAge(FileName);
  if intFileAge = -1 then
    Result := 0
  else
    Result := FileDateToDateTime(intFileAge)
end;

begin
  ExitCode := 0;
  if ParamCount = 2 then
  begin
    MinsBetween := MinutesBetween(Now, GetFileDateTime(ParamStr(1)));
    Writeln('MinutesBetween = ' + IntToStr(MinsBetween));
    if MinsBetween > StrToInt(ParamStr(2)) then
      ExitCode := 1;
    Writeln('Exitcode = ' + IntToStr(ExitCode));
  end
  else
    Writeln('Usage: IfFileCreateDate.exe <filename> <mins>');
end.
