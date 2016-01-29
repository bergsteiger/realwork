{
  (с) 2009 Гарант
  Упрощает запуск drwtsn32.exe.
  Пример запуска: DrWatsonRun.exe F1Server.exe
  Получает PID процесса по его названию, после чего вызывает drwtsn32.exe -p PID
}

program DrWatsonRun;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows, Messages;

  const
    TH32CS_SNAPPROCESS=2;

  type
    TPROCESSENTRY32 = record
      dwSize:DWORD;
      cntUsage:DWORD;
      th32ProcessID:DWORD;
      th32DefaultHeapID:DWORD;
      th32ModuleID:DWORD;
      cntThreads:DWORD;
      th32ParentProcessID:DWORD;
      pcPriClassBase:DWORD;
      dwFlags:DWORD;
      szExeFile:array [0..MAX_PATH] of char;
    end;

function CreateToolhelp32Snapshot(dwFlags, th32ProcessID: DWORD): dword;stdcall; external 'kernel32.dll';
function Process32First(hSnapshot:THandle; lppe:Pointer): Boolean; stdcall external 'kernel32.dll';
function Process32Next(hSnapshot:THandle; lppe:Pointer): Boolean; stdcall external 'kernel32.dll';

function GetProcessId(pName: PChar): dword;
var
  Snap: dword;
  Process: TPROCESSENTRY32;
begin
  Result := 0;
  Snap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  if Snap <> INVALID_HANDLE_VALUE then
     begin
      Process.dwSize := SizeOf(TPROCESSENTRY32);
      if Process32First(Snap, @Process) then
         repeat
          if lstrcmpi(Process.szExeFile, pName) = 0 then
             begin
              Result := Process.th32ProcessID;
              CloseHandle(Snap);
              Exit;
             end;
         until not Process32Next(Snap, @Process);
      Result := 0;
      CloseHandle(Snap);
     end;
end;

var
  cmdline, pid: string;

begin
  WriteLn;
  WriteLn('(c)Garant 2009, Run Dr. Watson 32 for memory dump by process name.');
  if ParamStr(1) <> '' then
  begin
    WriteLn('Process name: ' + ParamStr(1));
    pid := IntToStr(GetProcessId(PChar(ParamStr(1))));
    WriteLn('Process PID: ' + pid);
    WriteLn;

    if pid = '0' then
      cmdline := 'Process not found!'
    else
      cmdline := 'drwtsn32.exe -p ' + pid;

    WriteLn('Command line: ' + cmdline);

    if pid <> '0' then WinExec(PAnsiChar(cmdline), SW_HIDE);
  end
  else
    WriteLn('Usage: DrWatsonRun.exe [process_name]');

  WriteLn;
end.

