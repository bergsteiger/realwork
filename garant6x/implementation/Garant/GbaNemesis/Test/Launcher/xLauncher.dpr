program xLauncher;

uses
 Windows,
 SysUtils,
 ShellAPI,
 Forms,
 ActiveX,
 ComObj;

{$R *.res}

procedure OutUsage;
begin
 MessageBox(0, 'Usage:'#13#10' xLauncher -m<1|2|3> <TargetPath>','xLauncher',MB_OK);
end;

procedure RunProcess(const aName, aParams: String);
var
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
 l_Name: String;
 l_Path: String;
begin
 l_Name := '"'+aName+'"'+aParams;
 l_Path := '"'+ExtractFilePath(aName)+'"';
 FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
 with l_StartupInfo do
 begin
  cb := DWORD(SizeOf(l_StartupInfo));
  dwFlags := STARTF_USESTDHANDLES;
 end;
 if not CreateProcess(nil, PChar(l_Name), nil, nil, False,
   CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS,
   nil, nil, l_StartupInfo, l_ProcessInformation)
 then
  raiseLastOsError;
 CloseHandle(l_ProcessInformation.hThread);
 CloseHandle(l_ProcessInformation.hProcess);
end;

procedure CopyFileX(const aSourcePath, aTargetPath: String);
var
 l_SHFileOpStruct: TSHFileOpStruct;
begin
 FillChar(l_SHFileOpStruct, SizeOf(l_SHFileOpStruct), $00);
 with l_SHFileOpStruct do
 begin
  Wnd := Application.Handle;
  wFunc := FO_COPY;
  //
  pFrom := PChar(aSourcePath+#0#0);
  //
  pTo := PChar(ExtractFilePath(aTargetPath)+#0#0);
  //
  fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_NOERRORUI;
  //
  fFlags := fFlags or FOF_SIMPLEPROGRESS;
  lpszProgressTitle := 'Bla-Bla';
 end;
 SHFileOperation(l_SHFileOpStruct);
end;

const
 cShell = 'xShell.exe';
 cCheat = 'xCheater.exe';

procedure DoMethod1(const aSourcePath, aTargetPath: String);
var
 l_Source: String;
 l_Target: String;
begin
 l_Source := aSourcePath + cShell;
 l_Target := aTargetPath + cShell;
 CopyFileX(l_Source, l_Target);
 RunProcess(l_Target, '');
end;


procedure DoMethod2(const aSourcePath, aTargetPath: String);
var
 l_Source: String;
 l_Target: String;
begin
 l_Source := aSourcePath + cShell;
 l_Target := aTargetPath + cShell;
 if FileExists(l_Target) then
  RunProcess(l_Target, '')
 else
 begin
  CopyFileX(l_Source, l_Target);
  MessageBox(0, 'File copied','xLauncher', MB_OK);
 end
end;

procedure DoMethod3(const aSourcePath, aTargetPath: String);
var
 l_Source: String;
 l_Target: String;
begin
 l_Source := aSourcePath + cShell;
 l_Target := aTargetPath + cShell;
 CopyFileX(l_Source, l_Target);
 l_Source := aSourcePath + cCheat;
 RunProcess(l_Source, Format(' %d "%s"', [GetCurrentProcessId, l_Target]));
end;

var
 l_SourceDir: String;
 l_TargetDir: String;

begin
 if ParamCount = 2 then
 begin
  OleCheck(CoInitialize(nil));
  try
   Application.Initialize;
   l_TargetDir := IncludeTrailingPathDelimiter(ParamStr(2));
   l_SourceDir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
   if not DirectoryExists(ParamStr(2)) then
   begin
    OutUsage;
    Exit;
   end;
   if UpperCase(ParamStr(1)) = '-M1' then
    DoMethod1(l_SourceDir, l_TargetDir)
   else
    if UpperCase(ParamStr(1)) = '-M2' then
     DoMethod2(l_SourceDir, l_TargetDir)
    else
     if UpperCase(ParamStr(1)) = '-M3' then
      DoMethod3(l_SourceDir, l_TargetDir)
     else
      OutUsage;
  finally
   CoUninitialize;
  end;
 end
 else
  OutUsage;
end.
