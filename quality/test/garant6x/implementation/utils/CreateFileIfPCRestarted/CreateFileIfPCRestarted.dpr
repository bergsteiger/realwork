program CreateFileIfPCRestarted;
{$APPTYPE CONSOLE}

uses
  Windows, Messages, SysUtils;

var
  f: TextFile;
  timeout : DWORD;
  filename: String;

begin
  ExitCode := 0;

  Writeln;
  Writeln('(C) 2014 Garant-Service. CreateFileIfPCRestarted');
  if ParamCount >= 1 then
  begin
    filename := ParamStr(1);
    try
      timeout := StrToInt(ParamStr(2));
    except
      timeout := 1000;
    end;
    Writeln('  Filename: ' + filename);
    Writeln('  Timeout (sec): ' + IntToStr(timeout));
    Writeln('  Worktime (sec): ' + IntToStr(GetTickCount div 1000));


    if GetTickCount div 1000 < timeout then
    begin
      try
        AssignFile(f, filename);
        Rewrite(f);
        Writeln(f, 'Ready file');
        CloseFile(f);
        Writeln('File created!');
        ExitCode := 1;
      except
      end;
    end
    else
      Writeln('File NOT created!');    
 end
 else
 begin
   Writeln('Create <filename> if work time after reboot lower then <timeout_sec>');
   Writeln('Return 1 exit code if file created else 0');
   Writeln('Example: CreateFileIfPCRestarted.exe <filename> [<timeout_sec>]');
 end;

 Writeln;
end.
