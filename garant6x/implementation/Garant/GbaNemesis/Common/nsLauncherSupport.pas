unit nsLauncherSupport;

interface

uses
 Windows,
 SysUtils
 ;

type
 ELauncherError = class (Exception);

 TRunWaitFunc = procedure of object;

function QuoteStringIfNeed(const a_String: string): string;
function RunProcess(const a_Application: string; const a_CommandLine: string;
 const a_CurrentDirectory: string; const a_WaitForExit: Boolean = True;
 const aWaitFunc: TRunWaitFunc = nil): DWORD;

const
 c_SomeError = 1;
 c_AnotherInstanceRunning = 2; 

implementation

Uses
 LocaleMessages
 ;

function QuoteStringIfNeed(const a_String: string): string;
begin
 if ((Pos(' ', a_String) <> 0) or (Pos('''', a_String) <> 0)) then
  Result := Format('"%s"', [a_String])
 else
  Result := a_String;
end;

function RunProcess(const a_Application: string; const a_CommandLine: string;
 const a_CurrentDirectory: string; const a_WaitForExit: Boolean;
 const aWaitFunc: TRunWaitFunc): DWORD;
 //
 function GetCreationFlags: DWORD;
 begin
  Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
 end;
 //
const
 c_WaitTime: DWORD = 250; // 0.25 of second
var
 l_Application: string;
 l_Commandline: string;
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
begin
 l_Application := Format('%s\%s', [a_CurrentDirectory, a_Application]);
 //
 if FileExists(l_Application) then
 begin
  Result := DWORD(STILL_ACTIVE);
  //
  FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
  with l_StartupInfo do
  begin
   cb := DWORD(SizeOf(l_StartupInfo));
   dwFlags := STARTF_USESTDHANDLES;
  end;
  //
  l_CommandLine := QuoteStringIfNeed(l_Application);
  if (a_CommandLine <> '') then
   l_CommandLine := Format('%s %s', [l_CommandLine, a_CommandLine]);
  //
  if CreateProcess(nil, PChar(l_CommandLine), nil, nil, False, GetCreationFlags, nil, PChar(a_CurrentDirectory), l_StartupInfo, l_ProcessInformation) then
  begin
   with l_ProcessInformation do
   begin
    CloseHandle(hThread);
    try
     if a_WaitForExit then
      repeat
       if (WaitForSingleObject(hProcess, c_WaitTime) = WAIT_FAILED) then
        TerminateProcess(hProcess, WAIT_FAILED);
       //
       if Assigned(aWaitFunc) then
        aWaitFunc;
       Win32Check(GetExitCodeProcess(hProcess, Result));
      until (Result <> DWORD(STILL_ACTIVE))
     else
      Result := 0;
    finally
     CloseHandle(hProcess);
    end;
   end;
  end
  else
   raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonUnableStartProcess), [l_Application]));
 end
 else
  raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonFileNotFound), [l_Application]));
end;

end.