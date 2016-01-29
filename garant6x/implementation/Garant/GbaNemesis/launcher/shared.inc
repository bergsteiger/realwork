// shared.inc

function  GetApplication: string; forward;
function  GetCommandLine: string; forward;
function  GetLevelPrefix: string; forward;
function  GetLocale_I18N: string; forward;

{$IFDEF USE_MULTIFILE_ENCODER}
procedure ExpandIniFileSectionItem(var a_Item: string); forward;
procedure SelectFileDir(var a_FileDir: string); forward;

function  GetExecuteRootAliasReplace: string; forward;

function  ReplaceAliases(const a_String: string): string; forward;
{$ENDIF USE_MULTIFILE_ENCODER}

function  GetCurrentDirectory: string; forward;
procedure ErrorMessageBox(const a_Text: string; const a_RaiseAbort: Boolean = True); forward;
function  QuoteStringIfNeed(const a_String: string): string; forward;
function  RemoveFinalSlash(const a_String: string): string; forward;
function  RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string): DWORD; overload; forward;

{$IFDEF USE_MULTIFILE_ENCODER}
procedure ExpandIniFileSectionItem(var a_Item: string);
begin
 a_Item := ReplaceAliases(a_Item);
end;

type
 TReplaceCacheRecord = record
  r_FileDir: string;
  r_Replace: string;
 end;

var
 g_ReplaceFileDirCache: array of TReplaceCacheRecord;

procedure SelectFileDir(var a_FileDir: string);
 //
 function GetReplace(const a_FileDir: string): string;
 var
  l_Index: Integer;
 begin
  Result := a_FileDir;
  //
  for l_Index := Low (g_ReplaceFileDirCache) to High (g_ReplaceFileDirCache) do
   with g_ReplaceFileDirCache [l_Index] do
    if (Pos(Format('%s\', [r_FileDir]), Format('%s\', [Result])) = 1) then
    begin
     Delete(Result, 1, Length(r_FileDir));
     Insert(r_Replace, Result, 1);
     //
     Break;
    end;
 end;
 //
 procedure SetReplace(const a_FileDir: string; const a_Replace: string);
 var
  l_Length: Integer;
 begin
  l_Length := Length(g_ReplaceFileDirCache);
  //
  SetLength(g_ReplaceFileDirCache, Succ (l_Length));
  //
  with g_ReplaceFileDirCache [l_Length] do
  begin
   r_FileDir := a_FileDir;
   r_Replace := a_Replace;
  end;
 end;
 //
 function ShowMissingFolderDialog: Boolean;
 var
  l_FileName: string;
 begin
  Result := False;
  //
  l_FileName := ChangeFileExt(Format('%s\%s', [GetCurrentDirectory, GetApplication]), '.ini');
  //
  if (FileExists(l_FileName)) then
   with TIniFile.Create(l_FileName) do
    try
     Result := ReadString(c_Locale_ForceEnglish_Section, 'ShowMissingFolderDialog', '0') <> '0';
    finally
     Free;
    end;
 end;
 //
begin
 a_FileDir := GetReplace(a_FileDir);
 //
 if (not(DirectoryExists(a_FileDir)) and ShowMissingFolderDialog) then
 begin
  with TFolderNotExistForm.Create(Application) do
   try
    ReplacePath := a_FileDir;
    //
    if (ShowModal <> mrCancel) then
     SetReplace(a_FileDir, RemoveFinalSlash(ReplacePath));
   finally
    Free;
   end;
  //
  a_FileDir := GetReplace(a_FileDir);
 end;
end;

function GetExecuteRootAliasReplace: string;
begin
 Result := RemoveFinalSlash(ExtractFileDir(ParamStr(0)));
end;

function ReplaceAliases(const a_String: string): string;
 //
 type
  TGetAliasReplace = function: string;
 //
 function ReplaceAlias(var a_String: string; const a_Alias: string; const a_GetAliasReplace: TGetAliasReplace): Boolean;
 var
  l_Pos: Integer;
 begin
  Result := False;
  //
  l_Pos := Pos(a_Alias, a_String);
  if (l_Pos > 0) then
  begin
   Delete(a_String, l_Pos, Length(a_Alias));
   Insert(a_GetAliasReplace, a_String, l_Pos);
   //
   Result := True;
  end;
 end;
 //
var
 l_AliasReplaced: Boolean;
begin
 Result := a_String;
 //
 if (Result <> '') then
  repeat
   l_AliasReplaced := False;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(ExecuteRoot)', GetExecuteRootAliasReplace) or l_AliasReplaced;
  until not(l_AliasReplaced);
end;
{$ENDIF USE_MULTIFILE_ENCODER}

function GetApplication: string;
begin
 Result := c_Application;
end;

function GetCommandLine: string;
 //
 function GetCommandLineParams: string;
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
  for l_Index := 1 to ParamCount do
   Result := AddParamStrToCommandLine(Result, QuoteStringIfNeed(ParamStr(l_Index)));
 end;
 //
begin
 Result := Format('%s%s %s', [c_CommandLinePrefix, c_CommandLine, GetCommandLineParams]);
end;

function GetLevelPrefix: string;
begin
 Result := c_LevelPrefix;
end;

function GetLocale_I18N: string;
const
 c_Section: string = 'F1Server Params';
var
 l_FileName: string;
begin
 Result := c_Locale_I18N;
 //
 l_FileName := ChangeFileExt(Format('%s\%s', [GetCurrentDirectory, GetApplication]), '.ini');
 //
 if (FileExists(l_FileName)) then
  with TIniFile.Create(l_FileName) do
   try
    if (
     (
      SectionExists(c_Locale_ForceEnglish_Section)
     ) and (
      Pos(
       c_Locale_ForceEnglish_SubString
       , ReadString(
        c_Locale_ForceEnglish_Section
        , c_Locale_ForceEnglish_Item
        , ''
       )
      ) > 0
     )
    ) then
     Result := c_Locale_ForceEnglish_Value
    else
     if (SectionExists(c_Section)) then
      Result := ReadString(c_Section, '-Locale', c_Locale_I18N);
   finally
    Free;
   end;
end;

function GetCurrentDirectory: string;
begin
 Result := Format('%s\%s', [RemoveFinalSlash(ExtractFileDir(ParamStr(0))), GetLevelPrefix]);
end;

procedure ErrorMessageBox(const a_Text: string; const a_RaiseAbort: Boolean);
var
 l_Caption: string;
 l_Text: string;
begin
 with Application do
 begin
  l_Caption := Title;
  l_Text := Format(GetCurrentLocaleMessage(c_CommonErrorMessage), [a_Text]);
  //
  MessageBox(PChar(l_Text), PChar(l_Caption), MB_OK+MB_ICONERROR);
 end;
 //
 if (a_RaiseAbort) then
  Abort;
end;

function QuoteStringIfNeed(const a_String: string): string;
begin
 if ((Pos(' ', a_String) <> 0) or (Pos('''', a_String) <> 0)) then
  Result := Format('"%s"', [a_String])
 else
  Result := a_String;
end;

function RemoveFinalSlash(const a_String: string): string;
var
 l_Length: Integer;
begin
 Result := a_String;
 //
 l_Length := Length(Result);
 if ((l_Length > 0) and (Result[l_Length] = '\')) then
  SetLength(Result, Pred(l_Length));
end;

function RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string): DWORD;
 //
 function GetCreationFlags: DWORD;
 begin
  Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
 end;
 //
{$IFDEF USE_MULTIFILE_ENCODER}
 function HideStatusSaveConformation: Boolean;
 var
  l_FileName: string;
 begin
  Result := False;
  //
  l_FileName := ChangeFileExt(Format('%s\%s', [GetCurrentDirectory, GetApplication]), '.ini');
  //
  if (FileExists(l_FileName)) then
   with TIniFile.Create(l_FileName) do
    try
     Result := ReadString(c_Locale_ForceEnglish_Section, 'HideStatusSaveConformation', '0') <> '0';
    finally
     Free;
    end;
 end;
 //
 function InstallationStatusEnabled: Boolean;
 var
  l_FileName: string;
 begin
  Result := False;
  //
  l_FileName := ChangeFileExt(Format('%s\%s', [GetCurrentDirectory, GetApplication]), '.ini');
  //
  if (FileExists(l_FileName)) then
   with TIniFile.Create(l_FileName) do
    try
     Result := ReadString(c_Locale_ForceEnglish_Section, 'EnableInstallationStatusSaving', '1') <> '0';
    finally
     Free;
    end;
 end;
 //
 procedure PutFileToStorage(const a_FileName: string; a_StorageName: string);
  //
  function GetFileSize(const a_FileName: string): Int64;
  var
   l_SearchRec: TSearchRec;
  begin
   Result := 0;
   //
   if (FindFirst(a_FileName, faAnyFile, l_SearchRec) = 0) then
   begin
    with l_SearchRec.FindData do
     Result := Int64(nFileSizeHigh)*Int64(DWORD(-1))+ nFileSizeLow;
    //
    FindClose(l_SearchRec);
   end;
  end;
  //
 var
  l_FileStream: TStream;
  //
  l_IntegerSize: Byte;
  l_Length: Integer;
  l_Name: string;
  l_Size: Int64;
  //
  l_FullSize: Int64;
 begin
  l_FileStream := TFileStream.Create(a_FileName, fmOpenRead+fmShareDenyNone);
  try
   with TFileStream.Create(a_StorageName, fmOpenReadWrite+fmShareExclusive) do
    try
     (*
      header format:
       sizeof(integer) [byte]                      |>
       length+ 1       [integer]                   |+sizeof(byte)
       filename        [(length+ 1)* sizeof(char)] |+sizeof(byte)+ sizeof(integer)
       size            [int64]                     |+sizeof(byte)+ sizeof(integer)+ (length+ 1)* sizeof(char)
       data            [size]                      |+sizeof(byte)+ sizeof(integer)+ (length+ 1)* sizeof(char)+ sizeof(int64)
     *)
     try
      repeat
       ReadBuffer(l_IntegerSize, SizeOf(l_IntegerSize));
       //
       if (l_IntegerSize = $FF) then
       begin
        Seek(-SizeOf(l_IntegerSize), soFromCurrent);
        Break;
       end;
       //
       if (SizeOf(l_Length) <= l_IntegerSize) then
       begin
        l_Length := 0; // full bytes cleanup
        //
        ReadBuffer(l_Length, l_IntegerSize);
       end else
        ErrorMessageBox(GetCurrentLocaleMessage(c_MiniUseStorageUnsupportedIntegerSize));
       //
       Seek(l_Length, soFromCurrent);
       //
       ReadBuffer(l_Size, SizeOf(l_Size));
       //
       Seek(l_Size, soFromCurrent);
      until (Position > Size);
     except
      on EReadError do;
     end;
     //
     l_Name := ExtractFileName(a_FileName);
     //
     l_IntegerSize := SizeOf(l_Length);
     //
     l_Length := Length(l_Name);
     if (l_Length > 0) then
      Inc(l_Length);
     //
     l_Size := l_FileStream.Size;
     //
     l_FullSize := SizeOf(l_IntegerSize)+ SizeOf(l_Length)+ l_Length+ SizeOf(l_Size)+ l_Size;
     //
     if ((Size-Position) < l_FullSize) then
      ErrorMessageBox(GetCurrentLocaleMessage(c_MiniUseStorageFileFull))
     else
     begin
      WriteBuffer(l_IntegerSize, SizeOf(l_IntegerSize));
      //
      WriteBuffer(l_Length, SizeOf(l_Length));
      WriteBuffer(PChar(l_Name)^, l_Length);
      //
      WriteBuffer(l_Size, SizeOf(l_Size));
      //
      CopyFrom(l_FileStream, l_Size);
     end;
    finally
     Free;
    end;
  finally
   FreeAndNil(l_FileStream);
  end;
 end;
{$ENDIF USE_MULTIFILE_ENCODER}
 //
var
 l_Application: string;
 l_Commandline: string;
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
 //
{$IFDEF USE_MULTIFILE_ENCODER}
var
 l_Handle: THandle;
 //
 l_Directory: string;
 //
 l_FileName: string;
 l_StorageName: string;
 //
 l_UseStorageFile: Boolean;
 //
 l_ExpandIniFileSectionItem: TExpandIniFileSectionItemEvent;
 l_SelectFileDir: TSelectFileDirEvent;
 //
 l_Now: TDateTime;
 //
 l_Year: Word;
 l_Month: Word;
 l_Day: Word;
 //
 l_Hour: Word;
 l_Min: Word;
 l_Sec: Word;
 l_MSec: Word;
 //
 l_IgnoreFirstException: Boolean;
{$ENDIF USE_MULTIFILE_ENCODER}
begin
 Result := DWORD(STILL_ACTIVE);
 //
{$IFDEF USE_MULTIFILE_ENCODER}
 l_Handle := CreateMutex(nil, False, c_RunningCopyMutexName);
 //
 if (l_Handle <> THandle(0)) then
 begin
  if (GetLastError = ERROR_ALREADY_EXISTS) then
  begin
   Win32Check(CloseHandle(l_Handle));
   l_Handle := THandle(0);
  end;
 end
 else
  Win32Check(False);
 //
 try
{$ENDIF USE_MULTIFILE_ENCODER}
  l_Application := Format('%s\%s', [a_CurrentDirectory, a_Application]);
  //
  if ((l_Application <> '') and FileExists(l_Application)) then
  begin
   l_CommandLine := QuoteStringIfNeed(l_Application);
   if (a_CommandLine <> '') then
    l_CommandLine := Format('%s %s', [l_CommandLine, a_CommandLine]);
   //
   FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
   with l_StartupInfo do
   begin
    cb := DWORD(SizeOf(l_StartupInfo));
    dwFlags := STARTF_USESTDHANDLES;
   end;
   //
   if (
    CreateProcess(
     nil
     , PChar(l_CommandLine)
     , nil
     , nil
     , False
     , GetCreationFlags
     , nil
     , PChar(a_CurrentDirectory)
     , l_StartupInfo
     , l_ProcessInformation
    )
   ) then
   begin
    with l_ProcessInformation do
    begin
     CloseHandle(hThread);
     try
      if (WaitForSingleObject(hProcess, INFINITE) = WAIT_FAILED) then
       TerminateProcess(hProcess, WAIT_FAILED);

      Win32Check(GetExitCodeProcess(hProcess, Result));
     finally
      CloseHandle(hProcess);
     end;
    end;
   end
   else
    ErrorMessageBox(Format(GetCurrentLocaleMessage(c_CommonUnableStartProcess), [l_Application]));
  end;
{$IFDEF USE_MULTIFILE_ENCODER}
  if (
   (
     l_Handle <> THandle(0)
   ) and (
     InstallationStatusEnabled
   ) and (
    (
     HideStatusSaveConformation
    ) or (
     Application.MessageBox(
      PChar(GetCurrentLocaleMessage(c_MiniUseMultiFileEncoderText))
      , PChar(GetCurrentLocaleMessage(c_MiniUseMultiFileEncoderCaption))
      , MB_ICONINFORMATION+MB_YESNO
     ) = IDYES
    )
   ) and (
    SelectDirectory(GetCurrentLocaleMessage(c_MiniUseMultiFileEncoderSelectFolder), '', l_Directory)
   )
  )
  then
  begin
   l_Directory := RemoveFinalSlash(l_Directory);
   //
   l_StorageName := Format('%s\%s.GarantLS', [l_Directory, c_StorageFileName]);
   l_UseStorageFile := FileExists(l_StorageName);
   //
   if (l_UseStorageFile) then
   begin
    SetLength(l_Directory, GetTempPath(0, nil));
    //
    if (Length(l_Directory) = 0) then
     l_Directory := 'C:\'
    else
     SetLength(l_Directory, Integer(GetTempPath(DWORD(Length(l_Directory)), PChar(l_Directory))));
    //
    l_Directory := Format('%s\%s', [RemoveFinalSlash(l_Directory), c_StorageFileName]);
   end;
   //
   l_Now := Now;
   //
   DecodeDate(l_Now, l_Year, l_Month, l_Day);
   DecodeTime(l_Now, l_Hour, l_Min, l_Sec, l_MSec);
   //
   l_FileName := Format(
    '%s\%.04u-%.02u-%.02u-%.02u-%.02u-%.02u-%.03u.mf'
    , [
     l_Directory
     , l_Year
     , l_Month
     , l_Day
     , l_Hour
     , l_Min
     , l_Sec
     , l_MSec
    ]
   );
   //
   l_IgnoreFirstException := True;
   //
   while (True) do
   begin
    try
     ForceDirectories(l_Directory);
     try
      with TMultiFileEncoder.Instance do
      begin
       l_ExpandIniFileSectionItem := OnExpandIniFileSectionItem;
       try
        OnExpandIniFileSectionItem := ExpandIniFileSectionItem;
        //
        l_SelectFileDir := OnSelectFileDir;
        try
         OnSelectFileDir := SelectFileDir;
         //
         FileName := l_FileName;
         try
          with TWaitMessageForm.Create(nil) do
          try
           Text := GetCurrentLocaleMessage(c_MiniUseMultiFileEncoding);
           //
           Show;
           try
            Application.ProcessMessages;
            //
            CryptIniFileItems(ChangeFileExt(ParamStr(0), '.ini'));
           finally
            Hide;
           end;
          finally
           Free;
          end;
         finally
          FileName := '';
         end;
        finally
         OnSelectFileDir := l_SelectFileDir;
        end;
       finally
        OnExpandIniFileSectionItem := l_ExpandIniFileSectionItem;
       end;
      end;
      //
      if ((l_UseStorageFile) and FileExists(l_FileName)) then
      begin
       l_IgnoreFirstException := False;
       //
       PutFileToStorage(l_FileName, l_StorageName);
       //
       Application.MessageBox(
        PChar(GetCurrentLocaleMessage(c_MiniUseStatusSavedSuccessfullyText))
        , PChar(GetCurrentLocaleMessage(c_MiniUseStatusSavedSuccessfullyCaption))
        , MB_ICONINFORMATION+MB_OK
       );
      end
      else
       Application.MessageBox(
        PChar(GetCurrentLocaleMessage(c_MiniUseStatusSavedText))
        , PChar(GetCurrentLocaleMessage(c_MiniUseStatusSavedCaption))
        , MB_ICONINFORMATION+MB_OK
       );
     finally
      if (l_UseStorageFile) then
      begin
       if (FileExists(l_FileName)) then
        DeleteFile(l_FileName);
       //
       RemoveDir(l_Directory);
      end;
     end;
    except
     if ((l_UseStorageFile) and (l_IgnoreFirstException)) then
     begin
      l_IgnoreFirstException := False;
      //
      l_Directory := Format('%s\%s', [RemoveFinalSlash(ExtractFileDir(ParamStr(0))), c_StorageFileName]);
      l_FileName := Format('%s\%s', [l_Directory, ExtractFileName(l_FileName)]);
      //
      Continue;
     end
     else
      raise;
    end;
    //
    Break;
   end;
  end;
 finally
  if (l_Handle <> THandle(0)) then
   Win32Check(CloseHandle(l_Handle));
 end;
{$ENDIF USE_MULTIFILE_ENCODER}
end;

{$IFDEF USE_MULTIFILE_ENCODER}
const
 c_BufferSize = 32*1024*1024; // 32 Mb
var
 l_FillCount: Integer;
 //
 l_FileDir: string;
 l_FileName: string;
 //
 l_FileSize: Int64;
 //
 l_Buffer: Pointer;
 l_BufferSize: Integer;
{$ENDIF USE_MULTIFILE_ENCODER}
begin
 try
  with Application do
   if (Handle <> HWND(0)) then
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
  //
  SetCurrentLocale(GetLocale_I18N);
  //
  Application.Initialize;
  Application.Title := GetCurrentLocaleMessage(c_ApplicationTitle);
  //
{$IFDEF USE_MULTIFILE_ENCODER}
  if ((ParamCount = 2) and (CompareText('-create', ParamStr(1)) = 0)) then
  begin
   l_FillCount := 0;
   //
   l_FileDir := RemoveFinalSlash(ParamStr(2));
   l_FileName := Format('%s\%s.GarantLS', [l_FileDir, c_StorageFileName]);
   //
   try
    with TWaitMessageForm.Create(nil) do
    try
     Text := GetCurrentLocaleMessage(c_MiniUseCreateStorageFile);
     //
     Show;
     try
      GetMem(l_Buffer, c_BufferSize);
      try
       FillChar(l_Buffer^, c_BufferSize, $FF);
       //
       repeat
        with TFileStream.Create(l_FileName, fmCreate) do
         try
          l_BufferSize := c_BufferSize;
          //
          repeat
           Application.ProcessMessages;
           //
           if ((Write(l_Buffer^, l_BufferSize) = 0) and (l_BufferSize <> 0)) then
            l_BufferSize := l_BufferSize div 2;
           //
           FlushFileBuffers(THandle(Handle));
           Sleep(0);
          until (l_BufferSize = 0);
          //
          l_FileSize := Size;
         finally
          Free;
         end;
        //
        if (l_FileSize <> 0) then
        begin
         Inc (l_FillCount);
         //
         l_FileName := Format('%s\VolumeFiller%.05u', [l_FileDir, l_FillCount]);
        end
        else
         Break;
       until False;
      finally
       FreeMem(l_Buffer);
      end;
     finally
      Hide;
     end;
    finally
     Free;
    end;
   except
    on EFCreateError do
     if (l_FillCount = 0) then
      raise;
   end;
   //
   Application.MessageBox(
    PChar(GetCurrentLocaleMessage(c_MiniUseStorageCreatedText))
    , PChar(GetCurrentLocaleMessage(c_MiniUseStorageCreatedCaption))
    , MB_ICONINFORMATION+MB_OK
   );
  end
  else
{$ENDIF USE_MULTIFILE_ENCODER}
   ExitCode := Integer(RunProcess(GetApplication, GetCommandLine, GetCurrentDirectory));
 except
  on EAbort do ExitCode := -1;
  on E: Exception do
  begin
   ErrorMessageBox(Format(GetCurrentLocaleMessage(c_CommonUnexpectedException), [E.Message]), False);
   ExitCode := -2;
  end;
 end;
end.
