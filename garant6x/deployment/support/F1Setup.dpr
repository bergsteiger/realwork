program F1Setup;

{$APPTYPE GUI}
{$R *.RES}

uses
 RTLConsts
 , SysUtils
 , Windows
 , Classes
 , Controls
 , Forms
 , IniFiles
 , Registry
 , SelectItem in 'forms\SelectItem.pas' {SelectItemForm}
 ;

function CurrentIniFile: string;
begin
 Result := ChangeFileExt(ParamStr(0), '.ini');
end;

function CurrentInstallersFolder: string;
 //
 var
  l_BasePath: string;
  l_PathHasDoubleSlashPrefix: Boolean;
 //
begin
 with TIniFile.Create(CurrentIniFile) do
  try
   l_BasePath := ExtractFileDir(ParamStr(0));
   l_PathHasDoubleSlashPrefix := (Pos('\\', l_BasePath) = 1);
   //
   Result := StringReplace(
    Format('%s\%s', [l_BasePath, ReadString('Common', 'InstallersFolder', 'setup')])
    , '\\'
    , '\'
    , [rfReplaceAll]
   );
   //
   if (l_PathHasDoubleSlashPrefix) then
    Result := Format('\%s', [Result]);
  finally
   Free;
  end;
end;

function CurrentUninstallPath: string;
begin
 with TIniFile.Create(CurrentIniFile) do
  try
   Result := ReadString('Common', 'UninstallPath', 'Software\Microsoft\Windows\CurrentVersion\Uninstall');
  finally
   Free;
  end;
end;

function CurrentUninstallRootKey: HKEY;
 //
 var
  l_UninstallRootKey: string;
 //
begin
 with TIniFile.Create(CurrentIniFile) do
  try
   l_UninstallRootKey := ReadString('Common', 'UninstallRootKey', 'HKEY_LOCAL_MACHINE');
   //
   if (StrIComp(PChar(l_UninstallRootKey), PChar('HKEY_CLASSES_ROOT')) = 0) then
    Result := HKEY(HKEY_CLASSES_ROOT)
   else
    if (StrIComp(PChar(l_UninstallRootKey), PChar('HKEY_CURRENT_USER')) = 0) then
     Result := HKEY(HKEY_CURRENT_USER)
    else
     if (StrIComp(PChar(l_UninstallRootKey), PChar('HKEY_LOCAL_MACHINE')) = 0) then
      Result := HKEY(HKEY_LOCAL_MACHINE)
     else
      if (StrIComp(PChar(l_UninstallRootKey), PChar('HKEY_USERS')) = 0) then
       Result := HKEY(HKEY_USERS)
      else
       if (StrIComp(PChar(l_UninstallRootKey), PChar('HKEY_PERFORMANCE_DATA')) = 0) then
        Result := HKEY(HKEY_PERFORMANCE_DATA)
       else
        if (StrIComp(PChar(l_UninstallRootKey), PChar('HKEY_CURRENT_CONFIG')) = 0) then
         Result := HKEY(HKEY_CURRENT_CONFIG)
        else
         if (StrIComp(PChar(l_UninstallRootKey), PChar('HKEY_DYN_DATA')) = 0) then
          Result := HKEY(HKEY_DYN_DATA)
         else
         begin
          Assert(False, 'Unknown Uninstall Root');
          //
          Result := HKEY(-1); // disable warning `Return value of function might be undefined`.
         end;
  finally
   Free;
  end;
end;

procedure ErrorMessageBox(const a_Text: string; const a_RaiseAbort: Boolean = True);
begin
 with Application do
  MessageBox(PChar(a_Text), PChar(Title), MB_OK+MB_ICONERROR);
 //
 if (a_RaiseAbort) then
  Abort;
end;

function KeyToValue(const a_SectionName: string; const a_Key: string): string;
begin
 Result := a_Key;
 //
 try
  with TIniFile.Create(CurrentIniFile) do
   try
    Result := ReadString(a_SectionName, a_Key, a_Key);
   finally
    Free;
   end;
 except
 end;
end;

function QuoteStringIfNeed(const a_String: string): string;
begin
 if ((Pos(' ', a_String) <> 0) or (Pos('''', a_String) <> 0)) then
  Result := Format('"%s"', [a_String])
 else
  Result := a_String;
end;

function RegistryExists(const a_RootKey: HKEY; const a_Path: string; const a_ValueName: string): Boolean;
begin
 Result := False;
 //
 try
  with TRegistry.Create(Longword(KEY_READ)) do
   try
    RootKey := a_RootKey;
    //
    if OpenKey(a_Path, False) then
     try
      Result := (ReadString(a_ValueName) <> '');
     finally
      CloseKey;
     end;
   finally
    Free;
   end;
 except
 end;
end;

function RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string; const a_WaitForExit: Boolean = True): DWORD;
 //
 function GetCreationFlags: DWORD;
 begin
  Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
 end;
 //
 var
  l_Application: string;
  l_Commandline: string;
  l_ProcessInformation: TProcessInformation;
  l_StartupInfo: TStartupInfo;
 // 
begin
 Result := DWORD(STILL_ACTIVE);
 //
 l_Application := QuoteStringIfNeed(Format('%s\%s', [a_CurrentDirectory, a_Application]));
 //
 FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
 with l_StartupInfo do
 begin
  cb := DWORD(SizeOf(l_StartupInfo));
  dwFlags := STARTF_USESTDHANDLES;
 end;
 //
 l_CommandLine := l_Application;
 if (a_CommandLine <> '') then
  l_CommandLine := Format('%s %s', [l_CommandLine, a_CommandLine]);
 //
 if CreateProcess(nil, PChar(l_CommandLine), nil, nil, False, GetCreationFlags, nil, PChar(a_CurrentDirectory), l_StartupInfo, l_ProcessInformation) then
 begin
  with l_ProcessInformation do
  begin
   CloseHandle(hThread);
   try
    if (a_WaitForExit) then
    begin
     if (WaitForSingleObject(hProcess, INFINITE) = WAIT_FAILED) then
      TerminateProcess(hProcess, WAIT_FAILED);
     //
     Win32Check(GetExitCodeProcess(hProcess, Result));
    end;
   finally
    CloseHandle(hProcess);
   end;
  end;
 end
 else
  ErrorMessageBox(Format('Cannot start process: "%s".', [l_Application]));
end;

function SelectInstallerLanguage: string;
 //
 const
  c_SectionName: string = 'InstallerLanguage';
 //
 procedure FiltrateByInstalledProducts(const a_Items: TStrings; const a_SectionName: string);
  //
  const
   c_PropertyName: string = 'Property.LANGUAGE';
   c_SectionName: string = 'InstallerProductId';
  //
  var
   l_Index1: Integer;
   l_Index2: Integer;
   //
   l_Value: string;
   //
   l_RegistryPath: string;
   //
   l_UninstallPath: string;
   l_UninstallRootKey: HKEY;
   //
   l_Items: TStrings;
   //
   l_LanguageFound: Boolean;
  //
 begin
  with a_Items do
   if (Count > 0) then
   begin
    l_UninstallPath := CurrentUninstallPath;
    l_UninstallRootKey := CurrentUninstallRootKey;
    //
    if (l_UninstallRootKey <> HKEY(-1)) then
    begin
     with TIniFile.Create(CurrentIniFile) do
      try
       l_Items := TStringList.Create;
       try
        ReadSection(c_SectionName, l_Items);
        //
        l_Index1 := 0;
        //
        while (l_Index1 < Count) do
        begin
         l_LanguageFound := False;
         //
         for l_Index2 := 0 to Pred(l_Items.Count) do
         begin
          l_Value := ReadString(c_SectionName, l_Items.Strings[l_Index2], '');
          //
          if (l_Value <> '') then
          begin
           l_RegistryPath := Format('%s\%s', [l_UninstallPath, l_Value]);
           //
           if (RegistryExists(l_UninstallRootKey, l_RegistryPath, 'UninstallString')) then
            try
             with TRegistry.Create(Longword(KEY_READ)) do
              try
               RootKey := l_UninstallRootKey;
               //
               if OpenKey(l_RegistryPath, False) then
                try
                 if (ReadString(c_PropertyName) = KeyToValue(a_SectionName, Strings[l_Index1])) then
                 begin
                  l_LanguageFound := True;
                  //
                  Break;
                 end;
                finally
                 CloseKey;
                end;
              finally
               Free;
              end;
            except
            end;
          end;
         end;
         //
         if (not l_LanguageFound) then
          Delete(l_Index1)
         else
          Inc(l_Index1);
        end;
       finally
        FreeAndNil(l_Items);
       end;
      finally
       Free;
      end;
     //
     if (Count = 0) then
      with TIniFile.Create(CurrentIniFile) do
       try
        ReadSection(a_SectionName, a_Items);
       finally
        Free;
       end;
    end;
   end;
 end;
 //
 procedure FiltrateByLanguages(const a_Items: TStrings);
  //
  var
   l_Index: Integer;
   l_InstallersFolder: string;
   //
   l_Value: string;
  //
 begin
  with a_Items do
   if (Count > 0) then
   begin
    l_InstallersFolder := CurrentInstallersFolder;
    //
    with TIniFile.Create(CurrentIniFile) do
     try
      l_Index := 0;
      //
      while (l_Index < Count) do
      begin
       l_Value := ReadString(c_SectionName, Strings[l_Index], '');
       //
       if ((l_Value <> '') and (not FileExists(Format('%s\*_%s.exe', [l_InstallersFolder, l_Value])))) then
        Delete(l_Index)
       else
        Inc(l_Index);
      end;
     finally
      Free;
     end;
   end;
 end;
 //
 procedure FiltrateByLegacyUpdate(const a_Items: TStrings);
  //
  const
   c_SectionName: string = 'LegacyLanguage';
  //
  var
   l_Index: Integer;
   l_Items: TStrings;
   //
   l_RegistryPath: string;
   //
   l_UninstallPath: string;
   l_UninstallRootKey: HKEY;
   //
   l_String: string;
   l_Value: string;
  //
 begin
  with a_Items do
   if (Count > 0) then
   begin
    l_Items := TStringList.Create;
    try
     with TIniFile.Create(CurrentIniFile) do
      try
       ReadSection(c_SectionName, l_Items);
      finally
       Free;
      end;
     //
     l_UninstallPath := CurrentUninstallPath;
     l_UninstallRootKey := CurrentUninstallRootKey;
     //
     if (l_UninstallRootKey <> HKEY(-1)) then
      with l_Items do
      begin
       for l_Index := 0 to Pred(Count) do
       begin
        l_String := Strings[l_Index];
        //
        l_RegistryPath := Format('%s\%s', [l_UninstallPath, l_String]);
        //
        if (RegistryExists(l_UninstallRootKey, l_RegistryPath, 'UninstallString')) then
        begin
         with TIniFile.Create(CurrentIniFile) do
          try
           l_Value := ReadString(c_SectionName, l_String, '');
           //
           with a_Items do
            if ((l_Value <> '') and (IndexOf(l_Value) <> -1)) then
            begin
             Clear;
             //
             Add(l_Value);
            end
            else
             Clear;
          finally
           Free;
          end;
         //
         Break;
        end;
       end;
      end;
    finally
     FreeAndNil(l_Items);
    end;
   end;
 end;
 //
begin
 Result := '';
 //
 with TSelectItemForm.Create(Application) do
  try
   with ItemsComboBox do
   begin
    with TIniFile.Create(CurrentIniFile) do
     try
      Description := ReadString(c_SectionName, '$', 'Choose Language');
      //
      ReadSection(c_SectionName, Items);
     finally
      Free;
     end;
    //
    FiltrateByInstalledProducts(Items, c_SectionName);
    //
    FiltrateByLanguages(Items);
    FiltrateByLegacyUpdate(Items);
    //
    if (Items.Count > 0) then
    begin
     ItemIndex := 0;
     //
     if ((Items.Count > 1) and (ShowModal = mrCancel)) then
      Abort
     else
     begin
      Result := KeyToValue('InstallerLanguage', Items.Strings[ItemIndex]);
     end;
    end;
   end;
  finally
   Free;
  end;
end;

function SelectInstallerTarget(const a_Language: string): string;
 //
 const
  c_SectionName: string = 'InstallerTargets';
 //
 procedure FiltrateByAvailability(const a_Items: TStrings);
  //
  var
   l_Index: Integer;
   l_InstallersFolder: string;
   l_Value: string;
   //
   l_FileName: string;
  //
 begin
  with a_Items do
   if (Count > 0) then
    with TIniFile.Create(CurrentIniFile) do
     try
      l_Index := 0;
      l_InstallersFolder := CurrentInstallersFolder;
      //
      while (l_Index < Count) do
      begin
       l_Value := ReadString(c_SectionName, Strings[l_Index], '');
       l_FileName := Format('%s\%s', [l_InstallersFolder, l_Value]);
       //
       if ((l_Value <> '') and (not FileExists(l_FileName))) then
        Delete(l_Index)
       else
        Inc(l_Index);
      end;
     finally
      Free;
     end;
 end;
 //
 procedure FiltrateByInstalledProducts(const a_Items: TStrings; const a_SectionName: string; const a_Language: string);
  //
  const
   c_PropertyName: string = 'Property.LANGUAGE';
   c_SectionName: string = 'InstallerProductId';
  //
  var
   l_Index: Integer;
   l_Value: string;
   //
   l_RegistryPath: string;
   //
   l_UninstallPath: string;
   l_UninstallRootKey: HKEY;
  //
 begin
  with a_Items do
   if (Count > 0) then
   begin
    l_UninstallPath := CurrentUninstallPath;
    l_UninstallRootKey := CurrentUninstallRootKey;
    //
    if (l_UninstallRootKey <> HKEY(-1)) then
    begin
     with TIniFile.Create(CurrentIniFile) do
      try
       l_Index := 0;
       //
       while (l_Index < Count) do
       begin
        l_Value := ReadString(c_SectionName, Strings[l_Index], '');
        //
        if (l_Value <> '') then
        begin
         l_RegistryPath := Format('%s\%s', [l_UninstallPath, l_Value]);
         //
         if (not RegistryExists(l_UninstallRootKey, l_RegistryPath, 'UninstallString')) then
          Delete(l_Index)
         else
          try
           with TRegistry.Create(Longword(KEY_READ)) do
            try
             RootKey := l_UninstallRootKey;
             //
             if OpenKey(l_RegistryPath, False) then
              try
               if (ReadString(c_PropertyName) <> a_Language) then
                Delete(l_Index)
               else
                Inc(l_Index);
              finally
               CloseKey;
              end;
            finally
             Free;
            end;
          except
          end;
        end;
       end;
      finally
       Free;
      end;
     //
     if (Count = 0) then
      with TIniFile.Create(CurrentIniFile) do
       try
        ReadSection(a_SectionName, a_Items);
       finally
        Free;
       end;
    end;
   end;
 end;
 //
 procedure FiltrateByLanguage(const a_Items: TStrings; const a_Language: string);
  //
  var
   l_Index: Integer;
   l_Value: string;
  //
 begin
  with a_Items do
   if (Count > 0) then
    with TIniFile.Create(CurrentIniFile) do
     try
      l_Index := 0;
      //
      while (l_Index < Count) do
      begin
       l_Value := ReadString(c_SectionName, Strings[l_Index], '');
       //
       if ((l_Value <> '') and (Pos(Format('_%s.exe', [a_Language]), l_Value) = 0)) then
        Delete(l_Index)
       else
        Inc(l_Index);
      end;
     finally
      Free;
     end;
 end;
 //
 procedure FiltrateByLegacyUpdate(const a_Items: TStrings; const a_Language: string);
  //
  function CurrentUninstallName(const a_SectionName: string): string;
  begin
   Result := '';
   //
   try
    with TIniFile.Create(CurrentIniFile) do
     try
      Result := ReadString(a_SectionName, 'UninstallName', '');
     finally
      Free;
     end;
   except
   end;
  end;
  //
  function LegacyInstallType(const a_RootKey: HKEY; const a_Path: string; const a_ValueName: string): Integer;
  begin
   Result := -1;
   //
   try
    with TRegistry.Create(Longword(KEY_READ)) do
     try
      RootKey := a_RootKey;
      //
      if OpenKey(a_Path, False) then
       try
        Result := StrToIntDef(ReadString(a_ValueName), -1);
       finally
        CloseKey;
       end;
     finally
      Free;
     end;
   except
   end;
  end;
  //
  var
   l_SectionName: string;
   //
   l_LegacyInstallType: Integer;
   //
   l_UninstallName: string;
   l_UninstallPath: string;
   l_UninstallRootKey: HKEY;
   //
   l_RegistryPath: string;
   //
   l_Value: string;
  //
 begin
  with a_Items do
   if (Count > 0) then
   begin
    l_SectionName := Format('LegacyInstallType_%s', [a_Language]);
    //
    l_UninstallName := CurrentUninstallName(l_SectionName);
    //
    if (l_UninstallName <> '') then
    begin
     l_UninstallPath := CurrentUninstallPath;
     l_UninstallRootKey := CurrentUninstallRootKey;
     //
     l_RegistryPath := Format('%s\%s', [l_UninstallPath, l_UninstallName]);
     //
     l_LegacyInstallType := LegacyInstallType(l_UninstallRootKey, l_RegistryPath, 'InstallType');
     //
     if (l_LegacyInstallType <> -1) then
     begin
      l_Value := KeyToValue(l_SectionName, IntToStr(l_LegacyInstallType));
      //
      if (IndexOf(l_Value) <> -1) then
      begin
       Clear;
       //
       Add(l_Value);
      end;
     end;
    end;
   end;
 end;
 //
begin
 Result := '';
 //
 with TSelectItemForm.Create(Application) do
  try
   with ItemsComboBox do
   begin
    with TIniFile.Create(CurrentIniFile) do
     try
      Description := ReadString('InstallerTargetsDescriptions', a_Language, 'Choose Product');
      //
      ReadSection(c_SectionName, Items);
     finally
      Free;
     end;
    //
    FiltrateByInstalledProducts(Items, c_SectionName, a_Language);
    //
    FiltrateByLanguage(Items, a_Language);
    FiltrateByLegacyUpdate(Items, a_Language);
    //
    FiltrateByAvailability(Items);
    //
    if (Items.Count > 0) then
    begin
     ItemIndex := 0;
     //
     if ((Items.Count > 1) and (ShowModal = mrCancel)) then
      Abort
     else
     begin
      Result := KeyToValue('InstallerTargets', Items.Strings[ItemIndex]);
     end;
    end;
   end;
  finally
   Free;
  end;
end;

function GetCommandLine: string;
 //
 function AddParamStrToCommandLine(const a_CommandLine: string; const a_ParamStr: string): string;
 begin
  if (a_CommandLine = '') then
   Result := a_ParamStr
  else
   Result := Format('%s %s', [a_CommandLine, QuoteStringIfNeed(a_ParamStr)]);
 end;
 //
 var
  l_Index: Integer;
 //
begin
 Result := '';
 //
 for l_Index := 1 to ParamCount do
  Result := AddParamStrToCommandLine(Result, ParamStr(l_Index));
end;

 var
  l_InstallerMutex: THandle;
  //
  l_InstallerLanguage: string;
  l_InstallerTarget: string;
 //
begin
 try
  l_InstallerMutex := CreateMutex(nil, False, '{65095A0D-F7FB-4DB3-B120-AF220C76BE41}');
  if (l_InstallerMutex <> THandle(0)) then
   try
    case WaitForSingleObject(l_InstallerMutex, INFINITE) of
     WAIT_ABANDONED,
     WAIT_OBJECT_0:
      try
       with Application do
        if (Handle <> HWND(0)) then
         SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
       //
       Application.Initialize;
       Application.Title := 'GARANT'; // Fake Title
       //
       l_InstallerLanguage := SelectInstallerLanguage;
       //
       if (l_InstallerLanguage = '') then
        ErrorMessageBox('Подходящий язык установки не может быть выбран.'#13#13'Suitable language of installer cannot be selected.')
       else
       begin
        l_InstallerTarget := SelectInstallerTarget(l_InstallerLanguage);
        //
        if (l_InstallerTarget = '') then
         ErrorMessageBox('Часть дистрибутива, необходимая для установки, не найдена.'#13#13'Required part of installer cannot be found.')
        else
         RunProcess(l_InstallerTarget, GetCommandLine, CurrentInstallersFolder);
       end;
      finally
       Win32Check(ReleaseMutex(l_InstallerMutex));
      end
     else
      Win32Check(False);
    end;
   finally
    CloseHandle(l_InstallerMutex);
   end
  else
   Win32Check(False);
 except
  on EAbort do
   ExitCode := 255;
  on E: Exception do
  begin
   ErrorMessageBox(Format('Unexpected program error, exception:'#13'%s.', [E.Message]), False);
   //
   ExitCode := 255;
  end;
 end;
end.
