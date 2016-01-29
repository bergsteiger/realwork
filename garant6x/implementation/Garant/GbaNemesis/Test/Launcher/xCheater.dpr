program xCheater;

uses
 Windows,
 SysUtils
 ;

{$R *.res}

var
 l_Parent: THandle;
 l_File: String;
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
 l_Name: String;
 l_Path: String;

begin
 if ParamCount = 2 then
 begin
  l_Parent := OpenProcess(SYNCHRONIZE, False, StrToInt(ParamStr(1)));
  if l_Parent <> 0 then
  begin
   WaitForSingleObject(l_Parent, INFINITE);
   CloseHandle(l_Parent);
  end; 
  l_File := ParamStr(2);
  l_Name := '"'+l_File+'"';
  l_Path := '"'+ExtractFilePath(l_File)+'"';
  if FileExists(l_File) then
  begin
   FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
   with l_StartupInfo do
   begin
    cb := DWORD(SizeOf(l_StartupInfo));
    dwFlags := STARTF_USESTDHANDLES;
   end;
   CreateProcess(nil, PChar(l_File), nil, nil, False,
     CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS,
     nil, PChar(ExtractFilePath(l_File)), l_StartupInfo, l_ProcessInformation);
   CloseHandle(l_ProcessInformation.hThread);
   CloseHandle(l_ProcessInformation.hProcess);
  end
  else
   MessageBox(0, 'File not found','xCheater', MB_OK);
 end
 else
  MessageBox(0, 'Wrong params','xCheater', MB_OK);
end.
