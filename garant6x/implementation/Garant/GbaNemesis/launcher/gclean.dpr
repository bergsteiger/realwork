program gclean;

{$APPTYPE GUI}
{$R *.RES}

uses
 RTLConsts
 , Windows
 , ShellAPI
 , SysUtils
 , Classes
 , IniFiles
 , Registry
 , Forms
 , LocaleMessages in 'i18n\LocaleMessages.pas'
 ;

procedure ErrorMessageBox(const a_Text: string); forward;
//
function  GetInstallRootAliasReplace: string; forward;
function  GetLocaleAliasReplace: string; forward;
function  GetLocaleProductNameAliasReplace: string; forward;
function  GetProductIdAliasReplace: string; forward;
function  GetProductIdValueNameAliasReplace: string; forward;
function  GetRegistryKeyAliasReplace: string; forward;
function  GetRegistryPathAliasReplace: string; forward;
function  GetThisApplicationAliasReplace: string; forward;
function  GetThisIniFileNameAliasReplace: string; forward;
function  GetUnknownIdAliasReplace: string; forward;
function  GetURLProtocolNameAliasReplace: string; forward;
//
function  GetIniFileCleanerSectionName: string; forward;
//
function  GetLauncherRegistryKey: HKEY; forward;
function  GetLauncherRegistryPath: string; forward;
//
function  GetRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string): string; forward;
procedure PutRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_ProductId: string); forward;
//
function  GetNotEmptyStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string = ''): string; forward;
function  GetStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string = ''): string; forward;
function  GetStringFromRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryDefaultValue: string = ''): string; forward;
function  QuoteStringIfNeed(const a_String: string): string; forward;
procedure PutStringToRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryValue: string); forward;
function  RegistryKeyToKey(const a_RegistryKey: string): HKEY; forward;
procedure RemapRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string); forward;
function  RemoveFinalSlash(const a_String: string): string; forward;
function  ReplaceAliases(const a_String: string): string; forward;
procedure RunCleanup(const a_ParentProcessId: DWORD); forward;
procedure RunProcess(a_Application: TApplication; const a_ProductName: string); overload; forward;
procedure RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string); overload; forward;
function  ValidateEmptyIniFileValue(const a_IniFileValue: string; const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string): string; forward;

const
 c_AllFilesMask = '*.*';

type
 ECleanerError = class (Exception);

procedure ErrorMessageBox(const a_Text: string);
var
 l_Caption: string;
 l_Text: string;
begin
 with Application do
 begin
  l_Caption := Title;
  l_Text := Format(GetCurrentLocaleMessage(c_GarantCleanerErrorMessage), [a_Text]);
  //
  MessageBox(PChar(l_Text), PChar(l_Caption), MB_OK+MB_ICONERROR);
 end;
end;

function GetInstallRootAliasReplace: string;
const
 c_RegistryValueName = 'InstallRoot';
begin
 Result := RemoveFinalSlash(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName));
end;

function GetLocaleAliasReplace: string;
const
 c_RegistryValueName = 'Locale';
begin
 Result := GetStringFromRegistry(RegistryKeyToKey(ReplaceAliases('%(RegistryKey)')), ReplaceAliases('%(RegistryPath)'), c_RegistryValueName, '$(UserDefaultLocale)');
end;

function GetLocaleProductNameAliasReplace: string;
begin
 Result := Format('%s (%s)', [GetCurrentLocaleMessage(c_ApplicationTitle), GetCurrentLocaleMessage(c_GarantCleanerSubInfo)]);
end;

function GetProductIdAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), 'Version', ReplaceAliases('%(ProductIdValueName)'), ReplaceAliases('%(UnknownId)'));
end;

function GetProductIdValueNameAliasReplace: string;
begin
 Result := '-ProductId';
end;

function GetRegistryKeyAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCleanerSectionName, 'RegistryKey');
end;

function GetRegistryPathAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCleanerSectionName, 'RegistryPath');
end;

function GetThisApplicationAliasReplace: string;
begin
 Result := ParamStr(0);
end;

function GetUnknownIdAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), 'Version', '-UnknownId', '{00000000-0000-0000-0000-000000000000}');
end;

function GetURLProtocolNameAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCleanerSectionName, 'URLProtocolName', 'garantF1');
end;

function GetIniFileCleanerSectionName: string;
begin
 Result := 'Cleaner';
end;

function GetThisIniFileNameAliasReplace: string;
begin
 Result := ChangeFileExt(ReplaceAliases('$(ThisApplication)'), '.ini');
end;

function GetLauncherRegistryKey: HKEY;
begin
 Result := RegistryKeyToKey(GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCleanerSectionName, 'LauncherRegistryKey'));
end;

function GetLauncherRegistryPath: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCleanerSectionName, 'LauncherRegistryPath');
end;

function GetRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string): string;
begin
 Result := GetStringFromRegistry (a_RegistryKey, a_RegistryPath, ReplaceAliases('%(ProductIdValueName)'), ReplaceAliases('%(UnknownId)'));
end;

procedure PutRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_ProductId: string);
begin
 PutStringToRegistry(a_RegistryKey, a_RegistryPath, ReplaceAliases('%(ProductIdValueName)'), a_ProductId);
end;

function GetNotEmptyStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string = ''): string;
begin
 Result := ValidateEmptyIniFileValue(GetStringFromIniFile(a_IniFileName, a_IniFileSectionName, a_IniFileValueName, a_IniFileDefaultValue), a_IniFileName, a_IniFileSectionName, a_IniFileValueName);
end;

function GetStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string): string;
begin
 if FileExists(a_IniFileName) then
  with TIniFile.Create(a_IniFileName) do
   try
    if SectionExists(a_IniFileSectionName) then
     Result := ReadString(a_IniFileSectionName, a_IniFileValueName, a_IniFileDefaultValue)
    else
     Result := a_IniFileDefaultValue;
   finally
    Free;
   end
 else
  raise ECleanerError.Create(Format(GetCurrentLocaleMessage(c_CommonFileNotFound), [a_IniFileName]));
end;

function GetStringFromRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryDefaultValue: string): string;
begin
 Result := a_RegistryDefaultValue;
 //
 try
  with TRegistry.Create(Longword(KEY_READ)) do
   try
    RootKey := a_RegistryKey;
    //
    if OpenKey(a_RegistryPath, False) then
     try
      Result := ReadString(a_RegistryValueName);
     finally
      CloseKey;
     end;
   finally
    Free;
   end;
 except
  on ERegistryException do {// do nothing};
 end
end;

function QuoteStringIfNeed(const a_String: string): string;
begin
 if ((Pos(' ', a_String) <> 0) or (Pos('''', a_String) <> 0)) then
  Result := Format('"%s"', [a_String])
 else
  Result := a_String;
end;

procedure PutStringToRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryValue: string);
begin
 try
  with TRegistry.Create(Longword(KEY_WRITE or KEY_NOTIFY)) do
   try
    RootKey := a_RegistryKey;
    //
    if not(OpenKey(a_RegistryPath, True)) then
     raise ERegistryException.CreateResFmt(@SRegCreateFailed, [a_RegistryPath])
    else
     try
      WriteString(a_RegistryValueName, a_RegistryValue);
     finally
      CloseKey;
     end;
   finally
    Free;
   end;
 except
  on ERegistryException do
   raise ECleanerError.Create(GetCurrentLocaleMessage(c_GarantRegistryOperationFailed));
 end
end;

function RegistryKeyToKey(const a_RegistryKey: string): HKEY;
begin
 if (StrIComp(PChar(a_RegistryKey), PChar('HKEY_CLASSES_ROOT')) = 0) then
  Result := HKEY(HKEY_CLASSES_ROOT)
 else
  if (StrIComp(PChar(a_RegistryKey), PChar('HKEY_CURRENT_USER')) = 0) then
   Result := HKEY(HKEY_CURRENT_USER)
  else
   if (StrIComp(PChar(a_RegistryKey), PChar('HKEY_LOCAL_MACHINE')) = 0) then
    Result := HKEY(HKEY_LOCAL_MACHINE)
   else
    if (StrIComp(PChar(a_RegistryKey), PChar('HKEY_USERS')) = 0) then
     Result := HKEY(HKEY_USERS)
    else
     if (StrIComp(PChar(a_RegistryKey), PChar('HKEY_PERFORMANCE_DATA')) = 0) then
      Result := HKEY(HKEY_PERFORMANCE_DATA)
     else
      if (StrIComp(PChar(a_RegistryKey), PChar('HKEY_CURRENT_CONFIG')) = 0) then
       Result := HKEY(HKEY_CURRENT_CONFIG)
      else
       if (StrIComp(PChar(a_RegistryKey), PChar('HKEY_DYN_DATA')) = 0) then
        Result := HKEY(HKEY_DYN_DATA)
       else
       begin
        raise ECleanerError.Create(Format(GetCurrentLocaleMessage(c_CommonUnrecognisedParameterValue), ['RegistryKey', a_RegistryKey]));
        //
        Result := HKEY(-1); // disable warning `Return value of function might be undefined`.
       end;
end;

procedure RemapRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string);
 //
 procedure MoveValues(const a_RegistryKey: HKEY; const a_SrcRegistryPath: string; const a_SrcRemoveKey: Boolean; const a_DstRegistryPath: string; const a_DstRemoveKey: Boolean);
  //
  procedure MoveValue(const a_ValueName: string; const a_SrcRegistry: TRegistry; const a_DstRegistry: TRegistry);
  var
   l_Buffer: PChar;
   l_BufferLength: Integer;
  begin
   with a_SrcRegistry do
   begin
    case GetDataType(a_ValueName) of
     rdUnknown,
     rdBinary:
     begin
      l_BufferLength := GetDataSize(a_ValueName);
      //
      if (l_BufferLength >= 0) then
      begin
       GetMem(l_Buffer, l_BufferLength);
       try
        a_DstRegistry.WriteBinaryData (a_ValueName, l_Buffer^, ReadBinaryData(a_ValueName, l_Buffer^, l_BufferLength));
       finally
        FreeMem(l_Buffer);
       end;
      end
      else
       Abort; // negative registry value length
     end;
     //
     rdString,
     rdExpandString:
      a_DstRegistry.WriteString(a_ValueName, ReadString (a_ValueName));
     //
     rdInteger:
      a_DstRegistry.WriteInteger(a_ValueName, ReadInteger (a_ValueName));
     //
     else
      Abort; // unknown registry type
    end;
    //
    DeleteValue (a_ValueName);
   end;
  end;
  //
 var
  l_DstRegistry: TRegistry;
  l_SrcRegistry: TRegistry;
  //
  l_Index: Integer;
  l_ValueNamesList: TStrings;
 begin
  l_SrcRegistry := TRegistry.Create(Longword(KEY_ALL_ACCESS));
  try
   with l_SrcRegistry do
   begin
    RootKey := a_RegistryKey;
    //
    if OpenKey(a_SrcRegistryPath, False) then
    begin
     try
      l_ValueNamesList := TStringList.Create;
      try
       GetValueNames(l_ValueNamesList);
       //
       with l_ValueNamesList do
        if (Count > 0) then
        begin
         l_DstRegistry := TRegistry.Create(Longword(KEY_ALL_ACCESS));
         try
          RootKey := a_RegistryKey;
          //
          if (a_DstRemoveKey) then
          begin
           if OpenKey(a_DstRegistryPath, False) then
           begin
            CloseKey;
            //
            DeleteKey(a_DstRegistryPath);
           end;
          end;
          //
          if not(l_DstRegistry.OpenKey(a_DstRegistryPath, True)) then
           raise ERegistryException.CreateResFmt(@SRegCreateFailed, [a_DstRegistryPath])
          else
           try
            l_Index := Pred (Count);
            //
            repeat
             try
              MoveValue (Strings[l_Index], l_SrcRegistry, l_DstRegistry);
             except
              try
               repeat
                Inc (l_Index);
                //
                if (l_Index >= Count) then
                 Break;
                //
                MoveValue (Strings[l_Index], l_DstRegistry, l_SrcRegistry);
               until (False);
              except
               on ERegistryException do { // do nothing };
              end;
              //
              raise;
             end;
             //
             Dec(l_Index);
            until (l_Index < 0);
           finally
            l_DstRegistry.CloseKey;
           end;
         finally
          FreeAndNil(l_DstRegistry);
         end;
        end;
      finally
       FreeAndNil(l_ValueNamesList);
      end;
     finally
      CloseKey;
     end;
     //
     if (a_SrcRemoveKey) then
      DeleteKey(a_SrcRegistryPath);
    end;
   end;
  finally
   FreeAndNil(l_SrcRegistry);
  end;
 end;
 //
var
 l_ProductId: string;
 l_UnknownId: string;
 //
 l_RegistryProductId: string;
 //
 l_RegistryCurrentIdPath: string;
 l_RegistryProductIdPath: string;
begin
 l_ProductId := ReplaceAliases('%(ProductId)');
 l_UnknownId := ReplaceAliases('%(UnknownId)');
 //
 l_RegistryProductId := GetRegistryProductId (a_RegistryKey, a_RegistryPath);
 //
 if (StrIComp(PChar(l_RegistryProductId), PChar(l_ProductId)) <> 0) then
 begin
  if (StrIComp(PChar(l_RegistryProductId), PChar(l_UnknownId)) <> 0) then
  begin
   l_RegistryCurrentIdPath := Format('%s\%s', [a_RegistryPath, l_ProductId]);
   l_RegistryProductIdPath := Format('%s\%s', [a_RegistryPath, l_RegistryProductId]);
   //
   MoveValues(a_RegistryKey, a_RegistryPath, False, l_RegistryProductIdPath, True);
   MoveValues(a_RegistryKey, l_RegistryCurrentIdPath, True, a_RegistryPath, False);
  end;
  //
  if (StrIComp(PChar(l_ProductId), PChar(l_UnknownId)) <> 0) then
   PutRegistryProductId(a_RegistryKey, a_RegistryPath, l_ProductId);
 end;
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
   l_AliasReplaced := ReplaceAlias(Result, '$(InstallRoot)', GetInstallRootAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(Locale)', GetLocaleAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(LocaleProductName)', GetLocaleProductNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(ThisApplication)', GetThisApplicationAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(ThisIniFileName)', GetThisIniFileNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(ProductId)', GetProductIdAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(UnknownId)', GetUnknownIdAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(ProductIdValueName)', GetProductIdValueNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(URLProtocolName)', GetURLProtocolNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(RegistryKey)', GetRegistryKeyAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(RegistryPath)', GetRegistryPathAliasReplace) or l_AliasReplaced;
  until not(l_AliasReplaced);
end;

procedure RunCleanup(const a_ParentProcessId: DWORD);
 //
 procedure ClenupDirectories;
  //
  procedure ProcessSection(const a_IniFileName: string; const a_IniFileSectionName: string);
   //
   procedure RemoveDirectory(const a_DirectoryPath: string);
    //
    function AddAllFilesMaskIfNeed(const a_Path: string): string;
    var
     l_Handle: DWORD;
     l_FileVersionInfo: Pointer;
     l_FileVersionInfoSize: DWORD;
     l_VSFixedFileInfo: Pointer;
     l_VSFixedFileInfoSize: UINT;
    begin
     l_FileVersionInfoSize := GetFileVersionInfoSize(Shell32, l_Handle);
     Win32Check(l_FileVersionInfoSize <> DWORD(0));
     //
     GetMem(l_FileVersionInfo, Integer(l_FileVersionInfoSize));
     try
      Win32Check(GetFileVersionInfo(Shell32, DWORD(0), l_FileVersionInfoSize, l_FileVersionInfo));
      Win32Check(VerQueryValue(l_FileVersionInfo, '\', l_VSFixedFileInfo, l_VSFixedFileInfoSize));
      //
      with PVSFixedFileInfo(l_VSFixedFileInfo)^ do
       if (dwProductVersionMS > DWORD($00040000)) then
        Result := a_Path
       else
        Result := Format('%s\%s', [a_Path, c_AllFilesMask]);
     finally
      FreeMem(l_FileVersionInfo);
     end;
    end;
    //
   var
    l_SHFileOpStruct: TSHFileOpStruct;
   begin
    if DirectoryExists(a_DirectoryPath) then
    begin
     with Application do
     begin
      BringToFront;
      //
      FillChar(l_SHFileOpStruct, SizeOf(l_SHFileOpStruct), $00);
      with l_SHFileOpStruct do
      begin
       Wnd := Handle;
       wFunc := FO_DELETE;
       //
       if (a_DirectoryPath <> '') then
        pFrom := PChar(Format('%s\%s'#0, [a_DirectoryPath, c_AllFilesMask]));
       //
       fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_NOERRORUI or FOF_SILENT;
      end;
     end;
     //
     if (SHFileOperation(l_SHFileOpStruct) <> 0) then
     begin
      if (l_SHFileOpStruct.fAnyOperationsAborted) then
       raise ECleanerError.Create(Format(GetCurrentLocaleMessage(c_GarantCleanerDeleteAborted), [a_DirectoryPath]))
      else
       raise ECleanerError.Create(Format(GetCurrentLocaleMessage(c_GarantCleanerDeleteFailed), [a_DirectoryPath]));
     end;
     //
     if DirectoryExists(a_DirectoryPath) then
      RemoveDir(a_DirectoryPath);
    end;
   end;
   //
  const
   c_FilePrefix = 'CleanupFile';
   c_FilePrefixLength = Length(c_FilePrefix);
   //
   c_FolderPrefix = 'CleanupDir';
   c_FolderPrefixLength = Length(c_FolderPrefix);
  var
   l_FileName: string;
  begin
   if (StrLIComp(PChar(a_IniFileSectionName), c_FolderPrefix, c_FolderPrefixLength) = 0) then
    RemoveDirectory(ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, 'DirectoryPath')))
   else
    if (StrLIComp(PChar(a_IniFileSectionName), c_FilePrefix, c_FilePrefixLength) = 0) then
    begin
     l_FileName := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, 'FilePath'));
     //
     FileSetReadOnly(l_FileName, False);
     DeleteFile(l_FileName);
    end;
  end;
  //
 var
  l_Index: Integer;
  l_IniFileName: string;
  l_IniFileSections: TStrings;
 begin
  l_IniFileName := ReplaceAliases('$(ThisIniFileName)');
  //
  with TIniFile.Create(l_IniFileName) do
   try
    l_IniFileSections := TStringList.Create;
    try
     ReadSections(l_IniFileSections);
     //
     with l_IniFileSections do
      for l_Index := 0 to Pred(Count) do
       ProcessSection(l_IniFileName, Strings[l_Index]);
    finally
     FreeAndNil(l_IniFileSections);
    end;
   finally
    Free;
   end;
 end;
 //
 procedure ClenupEmptyDirectories;
  //
  procedure ProcessSection(const a_IniFileName: string; const a_IniFileSectionName: string);
  const
   c_FolderPrefix = 'CleanupEmptyDir';
   c_FolderPrefixLength = Length(c_FolderPrefix);
  begin
   if (StrLIComp(PChar(a_IniFileSectionName), c_FolderPrefix, c_FolderPrefixLength) = 0) then
    RemoveDir(ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, 'DirectoryPath')));
  end;
  //
 var
  l_Index: Integer;
  l_IniFileName: string;
  l_IniFileSections: TStrings;
 begin
  l_IniFileName := ReplaceAliases('$(ThisIniFileName)');
  //
  with TIniFile.Create(l_IniFileName) do
   try
    l_IniFileSections := TStringList.Create;
    try
     ReadSections(l_IniFileSections);
     //
     with l_IniFileSections do
      for l_Index := 0 to Pred(Count) do
       ProcessSection(l_IniFileName, Strings[l_Index]);
    finally
     FreeAndNil(l_IniFileSections);
    end;
   finally
    Free;
   end;
 end;
 //
 procedure ClenupRegistry;
  //
  procedure ProcessSection(const a_IniFileName: string; const a_IniFileSectionName: string);
   //
   procedure RemoveRegistryKey(const a_RegistryKey: string; const a_RegistryPath: string);
   var
    l_Index: Integer;
    l_NamesList: TStrings;
   begin
    try
     with TRegistry.Create(Longword(KEY_ALL_ACCESS)) do
      try
       RootKey := RegistryKeyToKey(a_RegistryKey);
       //
       if OpenKey(a_RegistryPath, False) then
       begin
        if (HasSubKeys) then
        begin
         try
          l_NamesList := TStringList.Create;
          try
           GetValueNames(l_NamesList);
           //
           with l_NamesList do
            for l_Index:=0 to Pred(Count) do
             DeleteValue(Strings[l_Index]);
          finally
           FreeAndNil(l_NamesList);
          end;
         finally
          CloseKey;
         end;
        end
        else
        begin
         CloseKey;
         //
         DeleteKey(a_RegistryPath);
        end;
       end;
      finally
       Free;
      end;
    except
    end;
   end;
   //
  const
   c_RegistryPrefix = 'CleanupReg';
   c_RegistryPrefixLength = Length(c_RegistryPrefix);
  begin
   if (StrLIComp(PChar(a_IniFileSectionName), c_RegistryPrefix, c_RegistryPrefixLength) = 0) then
    RemoveRegistryKey(ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, 'RegistryKey')), ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, 'RegistryPath')));
  end;
  //
 var
  l_Index: Integer;
  l_IniFileName: string;
  l_IniFileSections: TStrings;
 begin
  l_IniFileName := ReplaceAliases('$(ThisIniFileName)');
  //
  with TIniFile.Create(l_IniFileName) do
   try
    l_IniFileSections := TStringList.Create;
    try
     ReadSections(l_IniFileSections);
     //
     with l_IniFileSections do
      for l_Index := 0 to Pred(Count) do
       ProcessSection(l_IniFileName, Strings[l_Index]);
    finally
     FreeAndNil(l_IniFileSections);
    end;
   finally
    Free;
   end;
 end;
 //
 procedure ClenupSelfFiles;
  //
  procedure RemoveFile(const a_FileName: string);
   //
   procedure DelayRemoveFileWin9X(const a_FileName: string);
    //
    function GetWinInitFileName: string;
    begin
     SetLength(Result, GetWindowsDirectory(nil, 0));
     SetLength(Result, GetWindowsDirectory(PChar(Result), Length(Result)));
     //
     Result := Format('%s\wininit.ini', [RemoveFinalSlash(Result)]);
    end;

    function LongNameToShortName(const a_FileName: string): string;
    begin
     SetLength(Result, GetShortPathName(PChar(a_FileName), nil, 0));
     SetLength(Result, GetShortPathName(PChar(a_FileName), PChar(Result), Length(Result)));
    end;
    //
   const
    c_RenameSection = '[rename]';
   var
    l_RenameSectionIndex: Integer;
    l_WinInitFileName: string;
    l_WinInitHandle: DWORD;
    l_WinInitStream: TStream;
   begin
    l_WinInitFileName := GetWinInitFileName;
    //
    repeat
     l_WinInitHandle := CreateFile(PChar(l_WinInitFileName), GENERIC_READ+GENERIC_WRITE, 0, nil, OPEN_ALWAYS, FILE_ATTRIBUTE_NORMAL, THandle(0));
     if (l_WinInitHandle <> DWORD(INVALID_HANDLE_VALUE)) then
      try
       l_WinInitStream := THandleStream.Create(Integer(l_WinInitHandle));
       try
        with TStringList.Create do
         try
          LoadFromStream(l_WinInitStream);
          //
          l_RenameSectionIndex := IndexOf(c_RenameSection);
          if (l_RenameSectionIndex = -1) then
           l_RenameSectionIndex := Add(c_RenameSection);
          //
          Insert(Succ(l_RenameSectionIndex), Format('nul=%s', [LongNameToShortName(a_FileName)]));
          //
          l_WinInitStream.Position := 0;
          try
           SaveToStream(l_WinInitStream);
          finally
           l_WinInitStream.Size := l_WinInitStream.Position;
          end;
         finally
          Free;
         end;
       finally
        FreeAndNil(l_WinInitStream);
       end;
       //
       Break; // repeat until cycle
      finally
       CloseHandle(l_WinInitHandle);
      end;
    until False;
   end;
   //
   procedure DelayRemoveFileWinNT(const a_FileName: string);
   begin
    MoveFileEx(PChar(a_FileName), nil, MOVEFILE_DELAY_UNTIL_REBOOT);
   end;
   //
  begin
   FileSetReadOnly(a_FileName, False);
   //
   if not(DeleteFile(a_FileName)) then
   begin
    if (Longint(GetVersion) < 0) then
     DelayRemoveFileWin9X(a_FileName)
    else
     DelayRemoveFileWinNT(a_FileName);
   end;
  end;
  //
 begin
  RemoveFile(ReplaceAliases('$(ThisIniFileName)'));
  RemoveFile(ReplaceAliases('$(ThisApplication)'));
 end;
 //
 procedure ShowSuccessMessageBox;
 var
  l_Caption: string;
  l_Text: string;
 begin
  with Application do
  begin
   l_Caption := Title;
   l_Text := Format(GetCurrentLocaleMessage(c_GarantCleanerProductUninstalled), [GetCurrentLocaleMessage(c_ApplicationTitle)]);
   //
   MessageBox(PChar(l_Text), PChar(l_Caption), MB_OK+MB_ICONINFORMATION);
  end;
 end;
 //
 procedure WaitParentProcessToExit(const a_ParentProcessId: DWORD);
 var
  l_Process: THandle;
 begin
  if (a_ParentProcessId <> 0) then
  begin
   l_Process := OpenProcess(SYNCHRONIZE, False, a_ParentProcessId);
   if (l_Process <> 0) then
   begin
    if (WaitForSingleObject(l_Process, INFINITE) = WAIT_FAILED) then
     TerminateProcess(l_Process, WAIT_FAILED);
    //
    Win32Check(CloseHandle(l_Process));
   end;
  end;
 end;
 //
begin
 WaitParentProcessToExit(a_ParentProcessId);
 //
 try
  ClenupDirectories;
  ClenupEmptyDirectories;
  ClenupRegistry;
 finally
  ClenupSelfFiles;
 end;
 //
 ShowSuccessMessageBox;
end;

procedure RunProcess(a_Application: TApplication; const a_ProductName: string);
 //
 function ConfirmCleanup: Boolean;
 var
  l_Caption: string;
  l_Text: string;
 begin
  with Application do
  begin
   l_Caption := Title;
   l_Text := Format(GetCurrentLocaleMessage(c_GarantCleanerUninstallProduct), [GetCurrentLocaleMessage(c_ApplicationTitle)]);
   //
   Result := (MessageBox(PChar(l_Text), PChar(l_Caption), MB_YESNO+MB_ICONINFORMATION) = IDYES);
  end;
 end;
 //
 function CopySelfToTemp: string;
  //
  function GetTempName: string;
   //
   function GetTempDir: string;
   begin
    SetLength(Result, GetTempPath(0, nil));
    //
    if (Length(Result) = 0) then
     Result := 'C:\'
    else
     SetLength(Result, Integer(GetTempPath(DWORD(Length(Result)), PChar(Result))));
   end;
   //
  var
   l_TempFileNameBuffer: packed array [0..MAX_PATH] of Char;
  begin
   GetTempFileName(PChar(RemoveFinalSlash(GetTempDir)), PChar('g6c'), 0, @l_TempFileNameBuffer);
   Result := l_TempFileNameBuffer;
  end;
  //
 begin
  Result := GetTempName;
  //
  Win32Check(CopyFile(PChar(ReplaceAliases('$(ThisApplication)')), PChar(Result), False));
  Win32Check(CopyFile(PChar(ReplaceAliases('$(ThisIniFileName)')), PChar(ChangeFileExt(Result, '.ini')), False));
 end;
 //
const
 c_ChildProcessGuard = '{8BE63FA1-1D54-46CC-BCB3-789C2BF47170}';
var
 l_CommandLine: string;
 l_TempName: string;
begin
 a_Application.Title := a_ProductName; // Real Title
 //
 if (ParamCount = 2) and (StrIComp(PChar(ParamStr(1)), PChar(c_ChildProcessGuard)) = 0) then
  RunCleanup(DWORD(StrToIntDef(ParamStr(2), 0)))
 else
 begin
  if ConfirmCleanup then
  begin
   l_CommandLine := Format('"%s" "$%.8x"', [c_ChildProcessGuard, GetCurrentProcessId]);
   l_TempName := CopySelfToTemp;
   //
   RunProcess(ExtractFileName(l_TempName), l_CommandLine, RemoveFinalSlash(ExtractFilePath(l_TempName)));
  end
  else
   Abort;
 end;
end;

procedure RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string);
 //
 function GetCreationFlags: DWORD;
 begin
  Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
 end;
 //
var
 l_Application: string;
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
begin
 l_Application := Format('%s\%s', [a_CurrentDirectory, a_Application]);
 //
 if FileExists(l_Application) then
 begin
  FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
  with l_StartupInfo do
  begin
   cb := DWORD(SizeOf(l_StartupInfo));
   dwFlags := STARTF_USESTDHANDLES;
  end;
  //
  if CreateProcess(nil, PChar(Format('%s %s', [QuoteStringIfNeed(l_Application), a_CommandLine])), nil, nil, False, GetCreationFlags, nil, PChar(a_CurrentDirectory), l_StartupInfo, l_ProcessInformation) then
  begin
   with l_ProcessInformation do
   begin
    CloseHandle(hThread);
    CloseHandle(hProcess);
   end;
  end
  else
   raise ECleanerError.Create(Format(GetCurrentLocaleMessage(c_CommonUnableStartProcess), [l_Application]));
 end
 else
  raise ECleanerError.Create(Format(GetCurrentLocaleMessage(c_CommonFileNotFound), [l_Application]));
end;

function ValidateEmptyIniFileValue(const a_IniFileValue: string; const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string): string;
begin
 Result := a_IniFileValue;
 //
 if (Result = '') then
  raise ECleanerError.Create(Format(GetCurrentLocaleMessage(c_CommonNotEmptyValueRequired), [a_IniFileSectionName, a_IniFileValueName, a_IniFileName]));
end;

begin
 try
  with Application do
   if (Handle <> HWND(0)) then
    SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
  //
  Application.Initialize;
  Application.Title := '√¿–¿Õ“ (Û‰‡ÎÂÌËÂ)'; // Fake Title
  //
  RemapRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath);
  RemapRegistry(RegistryKeyToKey(ReplaceAliases('%(RegistryKey)')), ReplaceAliases('%(RegistryPath)'));
  //
  SetCurrentLocale(ReplaceAliases('$(Locale)'));
  RunProcess(Application, ReplaceAliases('$(LocaleProductName)'));
 except
  on EAbort do {// do nothing};
  on E: ECleanerError do ErrorMessageBox(E.Message);
  on E: Exception do ErrorMessageBox(Format(GetCurrentLocaleMessage(c_CommonUnexpectedException), [E.Message]));
 end;
end.

