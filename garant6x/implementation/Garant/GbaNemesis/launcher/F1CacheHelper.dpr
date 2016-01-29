program F1CacheHelper;

{$APPTYPE GUI}
{$R *.RES}

uses
 Windows
 , SysUtils
 , ShellAPI
 , Forms
 ;

function QuoteStringIfNeed(const a_String: string): string;
begin
 if ((Pos(' ', a_String) <> 0) or (Pos('''', a_String) <> 0)) then
  Result := Format('"%s"', [a_String])
 else
  Result := a_String;
end;

function GetApplication: string;
begin
 Result := ExtractFileName(ParamStr(1));
end;

function GetCommandLine: string;
 //
 function AddParamStrToCommandLine(const a_CommandLine: string; const a_ParamStr: string): string;
 begin
  if (a_CommandLine = '') then
   Result := a_ParamStr
  else
   Result := Format('%s %s', [a_CommandLine, a_ParamStr]);
 end;
 //
var
 l_Index: Integer;
begin
 Result := '';
 //
 for l_Index := 2 to ParamCount do
  Result := AddParamStrToCommandLine(Result, QuoteStringIfNeed(ParamStr(l_Index)));
end;

function GetCurrentDirectory: string;
begin
 Result := ExtractFileDir(ParamStr(1));
 //
 if (Result = '') then
  Result := GetCurrentDir;
end;

function RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string): DWORD;
 //
 function GetCreationFlags: DWORD;
 begin
  Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
 end;
 //
 function WaitForResult(const a_Process: THandle): DWORD;
 begin
  try
   if (WaitForSingleObject(a_Process, INFINITE) = WAIT_FAILED) then
    TerminateProcess(a_Process, WAIT_FAILED);
   //
   Win32Check(GetExitCodeProcess(a_Process, Result));
  finally
   CloseHandle(a_Process);
  end;
 end;
 //
const
 ERROR_ELEVATION_REQUIRED = 740;
var
 l_Application: string;
 l_Commandline: string;
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
 //
 l_ShellExecuteInfo: TShellExecuteInfo;
 //
 l_RunSuccess: BOOL;
begin
 Result := DWORD(STILL_ACTIVE);
 //
 l_Application := Format('%s\%s', [a_CurrentDirectory, a_Application]);
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
 l_RunSuccess := CreateProcess(nil, PChar(l_CommandLine), nil, nil, False, GetCreationFlags, nil, PChar(a_CurrentDirectory), l_StartupInfo, l_ProcessInformation);
 if l_RunSuccess then
 begin
  with l_ProcessInformation do
  begin
   CloseHandle(hThread);
   //
   Result := WaitForResult(hProcess);
  end;
 end
 else
  // UAC: Run through "Elevation Dialog" ShellExecuteEx-implementation
  if ({GetLastError = ERROR_ELEVATION_REQUIRED // MoleBox <= 4_5408 BUG}True) then
  begin
   FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), $00);
   //
   with l_ShellExecuteInfo do
   begin
    cbSize := SizeOf(l_ShellExecuteInfo);
    //
    fMask := SEE_MASK_CLASSNAME or SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
    lpVerb := 'runas';
    //
    lpFile := PChar(l_Application);
    lpParameters := PChar(a_CommandLine);
    //
    nShow := SW_SHOWDEFAULT;
    //
    lpClass := 'exefile';
   end;
   //
   l_RunSuccess := ShellExecuteEx(@l_ShellExecuteInfo);
   if (l_RunSuccess) then
    Result := WaitForResult(l_ShellExecuteInfo.hProcess);
  end;
 //
 if (not l_RunSuccess) then
  with Application do
   MessageBox(PChar(Format('Cannot start process: "%s".', [l_Application])), PChar(Title), MB_OK+MB_ICONERROR);
end;

begin
 try
  with Application do
   if (Handle <> HWND(0)) then
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
  //
  Application.Initialize;
  Application.Title := 'F1CacheHelper';
  //
  ExitCode := Integer(RunProcess(GetApplication, GetCommandLine, GetCurrentDirectory));
 except
  on EAbort do ExitCode := -1;
  on E: Exception do ExitCode := -2;
 end;
end.

