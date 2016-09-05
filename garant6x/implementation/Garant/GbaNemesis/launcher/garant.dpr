program garant;

{$APPTYPE GUI}
{$R *.RES}

uses
 RTLConsts
 , StrUtils
 , SysUtils
 , Windows
 , ActiveX
 , ComObj
 , ShellAPI
 , ShlObj
 , Classes
 , IniFiles
 , Registry
 , Forms
 , Controls
 , LocaleMessages in 'i18n\LocaleMessages.pas'
 , SelectInstallFolder in 'forms\SelectInstallFolder.pas' {SelectInstallFolderForm}
{$IFDEF DEBUG}
 , WaitMessage in 'forms\WaitMessage.pas' {WaitMessageForm}
{$ENDIF DEBUG}
 , nsErrorReport in '..\nsErrorReport.pas'
 , Logo_Form in '..\View\PrimCommon\Forms\Logo_Form.pas' {Logo_Form}
 , Dialogs
 , vcmDialogs
 , l3Base
 , l3MessageID
 , nsApplication
 , nsRegistryTools in '..\nsRegistryTools.pas'
 , FileOperations;

const
 c_AllFilesMask = '*.*';
 //
 c_4AllParam = '-4all';
 //
 c_Emulator0Param = '-ga';
 c_Emulator1Param = '-ge';
 c_Emulator2Param = '-gr';
 //
 c_ForceSettingsConversionParam = '-r';
 //
 c_WaitForExitParam = '-WaitForExit';
 //
 c_SilentParam = '-silent';
 //
 c_ShellLoginParam = '-F1ShellLogin';
 c_ShellPasswordParam = '-F1ShellPassword';
 c_ShellOpenDocParam = '-OpenByNumber';
 c_ShellSilentRunAndExitParam = '-SilentRunAndExit';
 //
 c_NoValue = 'no';
 c_YesValue = 'yes';
 //
 c_RegisteredValue: string = 'Registered';
 c_UnRegisteredValue: string = 'Unregistered';

type
 ELauncherError = class (Exception);

function ApplicationMessageBox(const a_Text: string; a_Flags: Longint): Integer; forward;
//
procedure CommonMessageBox(const a_Text: string; const a_Flags: Integer); forward;
//
procedure ErrorMessageBox(const a_Text: string); forward;
procedure WarningMessageBox(const a_Text: string); forward;
//
procedure CleanReadOnlyAttributeForPath(const a_Path: string; a_FilesMask: string = c_AllFilesMask); forward;
//
procedure DoFileOperation(const a_FileOp: UINT; const a_FromPath: string; const a_ToPath: string; const a_ProgressTitle: string; const a_CheckCopyIfNeed: Boolean = False); forward;
//
function  OpenIniFile(const a_FileName: string): TIniFile; forward;
//
function  ReadIniFileSection(const a_FileName: string; const a_Section: string): TStrings; forward;
function  ReadIniFileSectionValues(const a_FileName: string; const a_Section: string): TStrings; forward;
function  ReadIniFileSections(const a_FileName: string): TStrings; forward;
//
function  ReadIniFileString(const a_FileName: string; const a_Section: string; a_Ident: string; a_Default: string): string; forward;
//
function  CheckItemPrefix(const a_String: string): Boolean; forward;
//
function  CreateRegistrationName(const a_Value: string): string; forward;
//
function  GetAllProxyEnvHostAliasReplace: string; forward;
function  GetApplicationAliasReplace: string; forward;
function  GetCacheIniFileNameAliasReplace: string; forward;
function  GetCacheRootAliasReplace: string; forward;
function  GetCacheRunThroughAliasReplace: string; forward;
function  GetCleanerDisplayNameAliasReplace: string; forward;
function  GetCleanerPublisherAliasReplace: string; forward;
function  GetCleanerRegistryKeyAliasReplace: string; forward;
function  GetCleanerRegistryPathAliasReplace: string; forward;
function  GetCleanerUninstallStringAliasReplace: string; forward;
function  GetCleanerVersionMajorAliasReplace: string; forward;
function  GetCleanerVersionMinorAliasReplace: string; forward;
function  GetCommandLineAliasReplace: string; forward;
function  GetCommandLineFromIniFile(const a_IniFileName: string): string; forward;
function  GetCommandLineParamsAliasReplace: string; forward;
function  GetConsultingCheckerApplicationAliasReplace: string; forward;
function  GetConsultingCheckerCommandLineAliasReplace: string; forward;
function  GetConsultingCheckerCurrentDirectoryAliasReplace: string; forward;
function  GetConsultingConfigCommonAliasReplace: string; forward;
function  GetConsultingConfigCommonProxyAuthAliasReplace: string; forward;
function  GetConsultingConfigCommonProxyHostAliasReplace: string; forward;
function  GetConsultingConfigCommonProxyPortAliasReplace: string; forward;
function  GetConsultingConfigCommonSynchronizeAliasReplace: string; forward;
function  GetConsultingConfigCurrentAliasReplace: string; forward;
function  GetConsultingConfigProxySynchronizeAliasReplace: string; forward;
function  GetCreateDesktopShortcutsAliasReplace: string; forward;
function  GetCurrentDirectoryAliasReplace: string; forward;
function  GetDealerInfFileAliasReplace: string; forward;
function  GetDefaultDirectoryAliasReplace: string; forward;
function  GetDefaultPathAliasReplace: string; forward;
function  GetDesktopPathAliasReplace: string; forward;
function  GetDRServerAliasReplace: string; forward;
function  GetDownloaderProxyHostAliasReplace: string; forward;
function  GetEmulatorKeyAliasReplace: string; forward;
function  GetEmulatorPathAliasReplace: string; forward;
function  GetEmulatorValueAliasReplace: string; forward;
function  GetEmulatorValueNameAliasReplace: string; forward;
function  GetExecuteRootAliasReplace: string; forward;
function  GetF1ServerActiveDataPathAliasReplace: string; forward;
function  GetF1ServerConsultingClientEnableAliasReplace: string; forward;
function  GetF1ServerConsultingServerAddressAliasReplace: string; forward;
function  GetF1ServerLocaleAliasReplace: string; forward;
function  GetF1ServerLocaleEngAliasReplace: string; forward;
function  GetHttpProxyEnvHostAliasReplace: string; forward;
function  GetInstallRootAliasReplace: string; forward;
function  GetLocaleCleanerNameAliasReplace: string; forward;
function  GetLocaleKeyAliasReplace: string; forward;
function  GetLocalePathAliasReplace: string; forward;
function  GetLocaleProductNameAliasReplace: string; forward;
function  GetLocalePublisherAliasReplace: string; forward;
function  GetLocaleValueAliasReplace: string; forward;
function  GetLocaleValueNameAliasReplace: string; forward;
function  GetOrignalRootAliasReplace: string; forward;
function  GetOsAliasReplace: string; forward;
function  GetProductIdAliasReplace: string; forward;
function  GetProductIdValueNameAliasReplace: string; forward;
function  GetProxyHostAliasReplace: string; forward;
function  GetProxyHostIniFileNameAliasReplace: string; forward;
function  GetURLProtocolNameAliasReplace: string; forward;
function  GetRegistryKeyAliasReplace: string; forward;
function  GetRegistryPathAliasReplace: string; forward;
function  GetRegistryValueAliasReplace: string; forward;
function  GetRegistryValueNameAliasReplace: string; forward;
function  GetSettingsCurrentDirectoryAliasReplace: string; forward;
function  GetSettingsExportApplicationAliasReplace: string; forward;
function  GetSettingsExportCommandLineAliasReplace: string; forward;
function  GetSettingsExportCommandLineFileAliasReplace: string; forward;
function  GetSettingsExportCurrentDirectoryAliasReplace: string; forward;
function  GetSettingsPreviousDirectoryAliasReplace: string; forward;
function  GetSettingsSourceDirectoryAliasReplace: string; forward;
function  GetSettingsVersionAliasReplace: string; forward;
function  GetShowCreateDesktopShortcutsDialogAliasReplace: string; forward;
function  GetShowInstallRootDialogAliasReplace: string; forward;
function  GetThisApplicationAliasReplace: string; forward;
function  GetThisFixFileNameAliasReplace: string; forward;
function  GetThisIniFileNameAliasReplace: string; forward;
function  GetWhiteListKeyAliasReplace: string; forward;
function  GetWhiteListPathAliasReplace: string; forward;
function  GetWhiteListValueAliasReplace: string; forward;
function  GetWhiteListValueNameAliasReplace: string; forward;
function  GetWhiteListAliasReplace: string; forward;
function  GetWinInetProxyHostAliasReplace: string; forward;
function  GetWinInetProxyPortAliasReplace: string; forward;
function  GetUnknownIdAliasReplace: string; forward;
//
function  ExtractHostName(const a_Url: string): string; forward;
//
function  GetIniFileCurrentSectionName: string; forward;
function  GetIniFileDownloaderSectionName: string; forward;
function  GetIniFileF1ServerSectionName: string; forward;
function  GetIniFileLauncherDesktopShortcutsSectionName: string; forward;
function  GetIniFileLauncherForceCreateFoldersSectionName: string; forward;
function  GetIniFileLauncherRegistrationSectionName: string; forward;
function  GetIniFileLauncherSectionName: string; forward;
function  GetIniFileLauncherUnRegistrationSectionName: string; forward;
//
function  GetLauncherRegistryKey: HKEY; forward;
function  GetLauncherRegistryPath: string; forward;
//
function  GetRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string): string; forward;
procedure PutRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_ProductId: string); forward;
//
function  IsDifferentFileAge(const a_FileAge1: Integer; const a_FileAge2: Integer): Boolean; forward;
//
function  IsLocalCacheEnabled: Boolean; forward;
//
function  IsRegistrationEnabled: Boolean; forward;
function  IsUnRegistrationEnabled: Boolean; forward;
//
function  GetNotEmptyStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string = ''): string; forward;
function  GetProductType(a_RealType: Boolean = False): TProductType; forward;
function  GetWinInetProxy: string; forward;
function  GetSpecialFolderPath(const a_CSIDL: Integer): string; forward;
function  GetStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string = ''): string; forward;
function  GetStringFromRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryDefaultValue: string = ''): string; forward;
function  IsDirectoryEmpty(const a_Path: string): Boolean; forward;
function  IsSilentParamExist: Boolean; forward;
procedure PutIntegerToRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryValue: Integer); forward;
procedure PutStringToRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryValue: string); forward;
function  QuoteStringIfNeed(const a_String: string): string; forward;
procedure RegisterCleaner; forward;
function  RegistryKeyToKey(const a_RegistryKey: string): HKEY; forward;
function  RemoveFinalSlash(const a_String: string): string; forward;
function  ReplaceAliases(const a_String: string): string; forward;
procedure RunProcess(a_Application: TApplication; const a_ProductName: string); overload; forward;
function  RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string; const a_WaitForExit: Boolean = True; a_LogoForm: TForm = nil): DWORD; overload; forward;

var
 g_InstallRootAliasReplaceRecursionCount: Integer = 0;
 g_IniFileRecursionCount: Integer = 0;
 //
 g_ForceShowInstallRootDialog: Boolean = False;
 g_ShowInstallRootDialog: Boolean = True;
 //
 g_ReplaceExecuteRoot: Boolean = True;
 g_ReplaceInstallRoot: Boolean = True;
 //
 g_CacheUpdateFailed: Boolean = True;
 g_UseCacheRunThrough: Boolean = False;
 g_ForceRegistryValue: Integer = 0;
 //
 g_AllowForceSettingsConversion: Boolean = True;

function ApplicationMessageBox(const a_Text: string; a_Flags: Longint): Integer;
var
 l_Msg: Tl3Message;
 l_Checked: Boolean;
begin
 l3FillChar(l_Msg, SizeOf(l_Msg));
 // Временно переделываем все диалоги в MB_USERICON(mtCustom), чтоб отображался заголовок диалогового окна
 a_Flags := (a_Flags and $FF0F) or MB_USERICON;

 // TMsgDlgType
 case (a_Flags and $F0) of
  MB_ICONWARNING:
   l_Msg.rData.rDlgType := mtWarning;
  MB_ICONERROR:
   l_Msg.rData.rDlgType := mtError;
  MB_ICONINFORMATION:
   l_Msg.rData.rDlgType := mtInformation;
  MB_ICONQUESTION:
   l_Msg.rData.rDlgType := mtConfirmation;
  MB_USERICON:
   l_Msg.rData.rDlgType := mtCustom;
 end;

 // TMsgDlgButtons
 case (a_Flags and $F) of
  MB_OKCANCEL:
  begin
   l_Msg.rData.rButtons := [mbOK, mbCancel];
   if ((a_Flags and $F00) = MB_DEFBUTTON2) then
    l_Msg.rData.rDefaultButton := mbCancel
   else
    l_Msg.rData.rDefaultButton := mbOK;
  end;

  MB_ABORTRETRYIGNORE:
  begin
   l_Msg.rData.rButtons := [mbAbort, mbRetry, mbIgnore];
   if ((a_Flags and $F00) = MB_DEFBUTTON2) then
    l_Msg.rData.rDefaultButton := mbRetry
   else
   if ((a_Flags and $F00) = MB_DEFBUTTON3) then
     l_Msg.rData.rDefaultButton := mbIgnore
    else
     l_Msg.rData.rDefaultButton := mbAbort;
  end;
  
  MB_YESNOCANCEL:
  begin
   l_Msg.rData.rButtons := [mbYes, mbNo, mbCancel];
   if ((a_Flags and $F00) = MB_DEFBUTTON2) then
    l_Msg.rData.rDefaultButton := mbNo
   else
    if ((a_Flags and $F00) = MB_DEFBUTTON3) then
     l_Msg.rData.rDefaultButton := mbCancel
    else
     l_Msg.rData.rDefaultButton := mbYes;
  end;

  MB_YESNO:
  begin
   l_Msg.rData.rButtons := [mbYes, mbNo];
   if ((a_Flags and $F00) = MB_DEFBUTTON2) then
    l_Msg.rData.rDefaultButton := mbNo
   else
    l_Msg.rData.rDefaultButton := mbYes;
  end;

  MB_RETRYCANCEL:
  begin
   l_Msg.rData.rButtons := [mbRetry, mbCancel];
   // кнопка CANCEL идет перед RETRY
   if ((a_Flags and $F00) = MB_DEFBUTTON2) then
    l_Msg.rData.rDefaultButton := mbRetry
   else
    l_Msg.rData.rDefaultButton := mbCancel;
  end;
 else
  // MB_OK:
  l_Msg.rData.rButtons := [mbOK];
  l_Msg.rData.rDefaultButton := mbOK;
 end;
 l_Msg.rMessage := l3CStr(a_Text);
 Result := vcmMessageDlgPrim(l_Msg, l_Checked, taLeftJustify, 0, nil, nil, True);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=565477460
end;

procedure CommonMessageBox(const a_Text: string; const a_Flags: Integer);
 //
 function MakeMessage(const a_Text: string): string;
  //
  function DealerInfListToString(const a_Strings: TStrings): string;
  var
   l_Index: Integer;
   l_Length: Integer;
  begin
   Result := '';
   //
   if (a_Strings <> nil) then
    with a_Strings do
     for l_Index := 0 to Pred(Count) do
      if (Result = '') then
       Result := Strings[l_Index]
      else
       Result := Format('%s'#13'%s', [Result, Strings[l_Index]]);
   //
   while (Length(Result) > 0) and (Result[1] = #13) do
    Delete(Result, 1, 1);
   //
   l_Length := Length(Result);
   while ((l_Length > 0) and ((Result[l_Length] = ' ') or (Result[l_Length] = #13))) do
   begin
    Delete(Result, l_Length, 1);
    Dec(l_Length);
   end;
   //
   for l_Index := 1 to Length(Result) do
    case Result[l_Index] of
     #128..#159,
     #160..#175:
      Result[l_Index] := Char(Byte(Result[l_Index])+64);
     #224..#239:
      Result[l_Index] := Char(Byte(Result[l_Index])+16);
     #240:
      Result[l_Index] := #168;
     #241:
      Result[l_Index] := #184;
    end;
   begin
   end;
  end;
  //
 var
  l_DealerInfList: TStrings;
 begin
  l_DealerInfList := TStringList.Create;
  try
   with l_DealerInfList do
   begin
    try
     LoadFromFile(ReplaceAliases('%(DealerInfFile)'));
    except
     Clear;
    end;
    //
    Result := Format('%s'#13#13'%s', [a_Text, DealerInfListToString(l_DealerInfList)]);
   end;
  finally
   FreeAndNil(l_DealerInfList);
  end;
 end;
 //
var
 l_Caption: string;
 l_Text: string;
begin
 if not IsSilentParamExist then
  with Application do
  begin
   l_Caption := Title;
   l_Text := MakeMessage(a_Text);
   //
   ApplicationMessageBox(l_Text, a_Flags);
  end;
end;

procedure ErrorMessageBox(const a_Text: string);
begin
 CommonMessageBox(Format(GetCurrentLocaleMessage(c_CommonErrorMessage), [a_Text]), MB_OK+MB_ICONERROR);
end;

procedure WarningMessageBox(const a_Text: string);
begin
 CommonMessageBox(Format(GetCurrentLocaleMessage(c_GarantWarningMessage), [a_Text]), MB_OK+MB_ICONWARNING);
end;

procedure CleanReadOnlyAttributeForPath(const a_Path: string; a_FilesMask: string);
var
 l_SearchRec: TSearchRec;
 l_SearchResult: Integer;
begin
 l_SearchResult := FindFirst(Format('%s\%s', [a_Path, a_FilesMask]), Integer(faAnyFile), l_SearchRec);
 try
  while (l_SearchResult = 0) do
  begin
   with l_SearchRec do
    if ((Name <> '.') and (Name <> '..')) then
    begin
     if ((Attr and Integer(faDirectory)) <> 0) then
      CleanReadOnlyAttributeForPath(Format('%s\%s', [a_Path, Name]))
     else
      if ((Attr and Integer(faReadOnly)) <> 0) then
       Win32Check(FileSetAttr(Format('%s\%s', [a_Path, Name]), Attr and not(Integer(faReadOnly))) = Integer(ERROR_SUCCESS));
    end;
   //
   l_SearchResult := FindNext(l_SearchRec);
  end;
 finally
  SysUtils.FindClose(l_SearchRec);
 end;
end;

procedure DoFileOperation(const a_FileOp: UINT; const a_FromPath: string; const a_ToPath: string; const a_ProgressTitle: string; const a_CheckCopyIfNeed: Boolean);
 //
 function AddFileNameIfNeed(const a_Path: string; const a_Name: string): string;
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
     Result := Format('%s\%s', [a_Path, a_Name]);
  finally
   FreeMem(l_FileVersionInfo);
  end;
 end;
 //
 procedure DoCompareFolderContent(const a_FromPath: string; const a_FromMask: string; const a_ToPath: string; const a_ProgressTitle: string);
  //
  function IsFoldersEquivalent(const a_FromPath: string; const a_FromMask: string; const a_ToPath: string; out a_CurrentFromFile: string; out a_CurrentToFile: string): Boolean;
   //
   function IsFilesEquivalent(const a_FromFile: string; const a_ToFile: string; out a_CurrentFromFile: string; out a_CurrentToFile: string): Boolean;
   type
    TByteBuffer = packed array [1..64*1024] of Byte;
   var
    l_CommonSize: Longint;
    l_FromBuffer: TByteBuffer;
    l_FromStream: TStream;
    l_FromStreamReadResult: Longint;
    l_ToBuffer: TByteBuffer;
    l_ToStream: TStream;
    l_ToStreamReadResult: Longint;
   begin
    a_CurrentFromFile := a_FromFile;
    a_CurrentToFile := a_ToFile;
    //
    try
     l_FromStream := TFileStream.Create(a_FromFile, fmOpenRead+fmShareDenyNone);
     try
      l_ToStream := TFileStream.Create(a_ToFile, fmOpenRead+fmShareDenyNone);
      try
       Result := (l_FromStream.Size = l_ToStream.Size);
       //
       if (Result) then
        repeat
         Application.ProcessMessages;
         //
         l_FromStreamReadResult := l_FromStream.Read(l_FromBuffer, SizeOf(l_FromBuffer));
         l_ToStreamReadResult := l_ToStream.Read(l_ToBuffer, SizeOf(l_ToBuffer));
         //
         if (l_FromStreamReadResult <> l_ToStreamReadResult) then
          Result := False
         else
         begin
          l_CommonSize := l_FromStreamReadResult;
          //
          if (l_CommonSize = 0) then
           Break
          else
           Result := CompareMem(@l_FromBuffer, @l_ToBuffer, l_CommonSize);
         end;
        until not(Result);
      finally
       FreeAndNil(l_ToStream);
      end;
     finally
      FreeAndNil(l_FromStream);
     end;
    except
     Result := False;
    end;
   end;
   //
  var
   l_SearchRec: TSearchRec;
   l_SearchResult: Integer;
  begin
   Result := True;
   //
   l_SearchResult := FindFirst(Format('%s\%s', [a_FromPath, a_FromMask]), Integer(faAnyFile), l_SearchRec);
   try
    while (l_SearchResult = 0) do
    begin
     Application.ProcessMessages;
     //
     with l_SearchRec do
      if ((Name <> '.') and (Name <> '..')) then
      begin
       if ((Attr and Integer(faDirectory)) <> 0) then
        Result := IsFoldersEquivalent(Format('%s\%s', [a_FromPath, Name]), c_AllFilesMask, Format('%s\%s', [a_ToPath, Name]), a_CurrentFromFile, a_CurrentToFile)
       else
        Result := IsFilesEquivalent(Format('%s\%s', [a_FromPath, Name]), Format('%s\%s', [a_ToPath, Name]), a_CurrentFromFile, a_CurrentToFile);
       //
       if not(Result) then
        Break;
      end;
     //
     l_SearchResult := FindNext(l_SearchRec);
    end;
   finally
    SysUtils.FindClose(l_SearchRec);
   end;
  end;
  //
 var
  l_CurrentFromFile: string;
  l_CurrentToFile: string;
 begin
{$IFDEF DEBUG}
  with TWaitMessageForm.Create(nil) do
  try
   Text := GetCurrentLocaleMessage(c_GarantCheckCopyResults);
   //
   Show;
   try
    Application.ProcessMessages;
{$ENDIF DEBUG}
    //
    if not(IsFoldersEquivalent(a_FromPath, a_FromMask, a_ToPath, l_CurrentFromFile, l_CurrentToFile)) then
     raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_GarantCheckOperationFailed), [a_ProgressTitle, l_CurrentFromFile, l_CurrentToFile]));
{$IFDEF DEBUG}
   finally
    Hide;
   end;
  finally
   Free;
  end;
{$ENDIF DEBUG}
 end;
 //
var
 l_FromName: string;
 l_FromPath: string;
 //
 l_ToName: string;
 l_ToPath: string;
 //
 l_SHFileOpStruct: TSHFileOpStruct;
begin
 if (DirectoryExists(a_FromPath)) then
 begin
  l_FromPath := a_FromPath;
  l_FromName := ExtractFileName(l_FromPath);
  //
  l_ToPath := a_ToPath;
  l_ToName := ExtractFileName(l_ToPath);
  //
  if (AnsiCompareText(l_FromName, l_ToName) = 0) then
   l_ToPath := ExtractFileDir(l_ToPath);
  //
  l_ToPath := Format('%s\%s', [l_ToPath, l_FromName]);
  //
  l_FromName := c_AllFilesMask;
 end
 else
 begin
  l_FromName := ExtractFileName(a_FromPath);
  l_FromPath := ExtractFileDir(a_FromPath);
  //
  l_ToPath := a_ToPath;
 end;
 //
 if ((a_FileOp <> UINT(FO_DELETE)) or ((l_FromName = c_AllFilesMask) and DirectoryExists(l_FromPath)) or ((l_FromName <> c_AllFilesMask) and FileExists(Format('%s\%s', [l_FromPath, l_FromName])))) then
 begin
  if (a_FileOp in [UINT(FO_COPY), UINT(FO_MOVE)]) and not(DirectoryExists(l_ToPath)) and not(ForceDirectories(l_ToPath)) then
    raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_GarantCannotCreateFolder), [l_ToPath]));
  //
  with Application do
  begin
   BringToFront;
   //
   l3FillChar(l_SHFileOpStruct, SizeOf(l_SHFileOpStruct), $00);
   with l_SHFileOpStruct do
   begin
    Wnd := Handle;
    wFunc := a_FileOp;
    //
    if (l_FromPath <> '') then
     pFrom := PChar(Format('%s\%s'#0, [l_FromPath, l_FromName]));
    //
    if (l_ToPath <> '') then
     pTo := PChar(Format('%s'#0, [AddFileNameIfNeed(l_ToPath, l_FromName)]));
    //
    fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or FOF_NOERRORUI;
    //
    if (a_ProgressTitle = '') then
     fFlags := fFlags or FOF_SILENT
    else
     begin
      fFlags := fFlags or FOF_SIMPLEPROGRESS;
      lpszProgressTitle := PChar(Format('%s...', [a_ProgressTitle]));
     end;
   end;
  end;
  //
  if (FileOperation(l_SHFileOpStruct) <> 0) then
  begin
   if (l_SHFileOpStruct.fAnyOperationsAborted) then
    raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_GarantOperationAborted), [a_ProgressTitle]))
   else
    raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_GarantOperationFailed), [a_ProgressTitle]));
  end;
  //
  if (((a_FileOp = UINT(FO_DELETE)) or (a_FileOp = UINT (FO_MOVE))) and (l_FromName = c_AllFilesMask) and DirectoryExists(l_FromPath)) then
   RemoveDir(l_FromPath);
  //
  if (a_CheckCopyIfNeed and (a_FileOp = UINT(FO_COPY)) and DirectoryExists(l_FromPath) and DirectoryExists(l_ToPath)) then
   DoCompareFolderContent(l_FromPath, l_FromName, l_ToPath, a_ProgressTitle);
 end;
end;

var
 g_IniFilesCache: TStrings = nil;
 //
 g_ReadIniFileSectionCache: TStrings = nil;
 g_ReadIniFileSectionValuesCache: TStrings = nil;
 //
 g_ReadIniFileSectionsCache: TStrings = nil;
 //
 g_ReadIniFileStringCache: TStrings = nil;

procedure OpenIniFileCleanup;
var
 l_Index: Integer;
begin
 if (g_IniFilesCache <> nil) then
 begin
  with g_IniFilesCache do
   for l_Index := Pred(Count) downto 0 do
    try
     Objects [l_Index].Free;
    except
    end;
  //
  FreeAndNil(g_IniFilesCache);
 end;
end;

function OpenIniFile(const a_FileName: string): TIniFile;
var
 l_KeyName: string;
 l_Object: TIniFile;
 //
 l_Index: Integer;
begin
 if (g_IniFilesCache = nil) then
 begin
  AddExitProc(OpenIniFileCleanup);
  g_IniFilesCache := TStringList.Create;
 end;
 //
 l_KeyName := Format('^%s$', [AnsiUpperCase(a_FileName)]);
 //
 with g_IniFilesCache do
 begin
  l_Index := IndexOf(l_KeyName);
  //
  if (l_Index < 0) then
  begin
   l_Object := TIniFile.Create(a_FileName);
   try
    l_Index := AddObject(l_KeyName, TObject(l_Object));
   except
    l_Object.Free;
    //
    raise;
   end;
  end;
  //
  Result := Objects [l_Index] as TIniFile;
 end;
end;

procedure ReadIniFileSectionCleanup;
var
 l_Index: Integer;
begin
 if (g_ReadIniFileSectionCache <> nil) then
 begin
  with g_ReadIniFileSectionCache do
   for l_Index := Pred(Count) downto 0 do
    try
     Objects [l_Index].Free;
    except
    end;
  //
  FreeAndNil(g_ReadIniFileSectionCache);
 end;
end;

function ReadIniFileSection(const a_FileName: string; const a_Section: string): TStrings;
var
 l_KeyName: string;
 l_Object: TStrings;
 //
 l_Index: Integer;
begin
 if (g_ReadIniFileSectionCache = nil) then
 begin
  AddExitProc(ReadIniFileSectionCleanup);
  g_ReadIniFileSectionCache := TStringList.Create;
 end;
 //
 l_KeyName := Format('^%s:%s$', [AnsiUpperCase(a_FileName), AnsiUpperCase(a_Section)]);
 //
 with g_ReadIniFileSectionCache do
 begin
  l_Index := IndexOf(l_KeyName);
  //
  if (l_Index < 0) then
  begin
   l_Object := TStringList.Create;
   try
    OpenIniFile(a_FileName).ReadSection(a_Section, l_Object);
    //
    l_Index := AddObject(l_KeyName, TObject(l_Object));
   except
    l_Object.Free;
    //
    raise;
   end;
  end;
  //
  Result := Objects [l_Index] as TStrings;
 end;
end;

procedure ReadIniFileSectionValuesCleanup;
var
 l_Index: Integer;
begin
 if (g_ReadIniFileSectionValuesCache <> nil) then
 begin
  with g_ReadIniFileSectionValuesCache do
   for l_Index := Pred(Count) downto 0 do
    try
     Objects [l_Index].Free;
    except
    end;
  //
  FreeAndNil(g_ReadIniFileSectionValuesCache);
 end;
end;

function ReadIniFileSectionValues(const a_FileName: string; const a_Section: string): TStrings;
var
 l_KeyName: string;
 l_Object: TStrings;
 //
 l_Index: Integer;
begin
 if (g_ReadIniFileSectionValuesCache = nil) then
 begin
  AddExitProc(ReadIniFileSectionValuesCleanup);
  g_ReadIniFileSectionValuesCache := TStringList.Create;
 end;
 //
 l_KeyName := Format('^%s:%s$', [AnsiUpperCase(a_FileName), AnsiUpperCase(a_Section)]);
 //
 with g_ReadIniFileSectionValuesCache do
 begin
  l_Index := IndexOf(l_KeyName);
  //
  if (l_Index < 0) then
  begin
   l_Object := TStringList.Create;
   try
    OpenIniFile(a_FileName).ReadSectionValues(a_Section, l_Object);
    //
    l_Index := AddObject(l_KeyName, TObject(l_Object));
   except
    l_Object.Free;
    //
    raise;
   end;
  end;
  //
  Result := Objects [l_Index] as TStrings;
 end;
end;

procedure ReadIniFileSectionsCleanup;
var
 l_Index: Integer;
begin
 if (g_ReadIniFileSectionsCache <> nil) then
 begin
  with g_ReadIniFileSectionsCache do
   for l_Index := Pred(Count) downto 0 do
    try
     Objects [l_Index].Free;
    except
    end;
  //
  FreeAndNil(g_ReadIniFileSectionsCache);
 end;
end;

function ReadIniFileSections(const a_FileName: string): TStrings;
var
 l_KeyName: string;
 l_Object: TStrings;
 //
 l_Index: Integer;
begin
 if (g_ReadIniFileSectionsCache = nil) then
 begin
  AddExitProc(ReadIniFileSectionsCleanup);
  g_ReadIniFileSectionsCache := TStringList.Create;
 end;
 //
 l_KeyName := Format('^%s$', [AnsiUpperCase(a_FileName)]);
 //
 with g_ReadIniFileSectionsCache do
 begin
  l_Index := IndexOf(l_KeyName);
  //
  if (l_Index < 0) then
  begin
   l_Object := TStringList.Create;
   try
    OpenIniFile(a_FileName).ReadSections(l_Object);
    //
    l_Index := AddObject(l_KeyName, TObject(l_Object));
   except
    l_Object.Free;
    //
    raise;
   end;
  end;
  //
  Result := Objects [l_Index] as TStrings;
 end;
end;

procedure ReadIniFileStringCleanup;
var
 l_Index: Integer;
begin
 if (g_ReadIniFileStringCache <> nil) then
 begin
  with g_ReadIniFileStringCache do
   for l_Index := Pred(Count) downto 0 do
    try
     StrDispose(PChar(Objects [l_Index]));
    except
    end;
  //
  FreeAndNil(g_ReadIniFileStringCache);
 end;
end;

function ReadIniFileString(const a_FileName: string; const a_Section: string; a_Ident: string; a_Default: string): string;
var
 l_KeyName: string;
 l_Object: PChar;
 //
 l_Index: Integer;
begin
 Result := '';
 //
 if (g_ReadIniFileStringCache = nil) then
 begin
  AddExitProc(ReadIniFileStringCleanup);
  g_ReadIniFileStringCache := TStringList.Create;
 end;
 //
 l_KeyName := Format('^%s:%s:%s$', [AnsiUpperCase(a_FileName), AnsiUpperCase(a_Section), AnsiUpperCase(a_Ident)]);
 //
 with g_ReadIniFileStringCache do
 begin
  l_Index := IndexOf(l_KeyName);
  //
  if (l_Index < 0) then
  begin
   l_Object := StrNew(PChar(OpenIniFile(a_FileName).ReadString(a_Section, a_Ident, a_Default)));
   try
    l_Index := AddObject(l_KeyName, TObject(l_Object));
   except
    StrDispose(l_Object);
    //
    raise;
   end;
  end;
  //
  Result := PChar(Objects [l_Index]);
 end;
end;


function CheckItemPrefix(const a_String: string): Boolean;
const
 c_ItemPrefix = 'Item';
 c_ItemPrefixLength = Length(c_ItemPrefix);
begin
 Result := (StrLIComp(PChar(a_String), c_ItemPrefix, c_ItemPrefixLength) = 0);
end;

function CreateRegistrationName(const a_Value: string): string;
begin
 Result := Format('Registration=%s', [ExtractFileName(a_Value)]);
end;

function GetAllProxyEnvHostAliasReplace: string;
const
 c_ProxyEnvName: string = '%ALL_PROXY%';
begin
 Result := ExtractHostName(ReplaceAliases(c_ProxyEnvName));
 //
 if (Result = c_ProxyEnvName) then
  Result := '';
end;

function GetApplicationAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'Application');
end;

function GetCacheIniFileNameAliasReplace: string;
begin
 Result := ChangeFileExt(ReplaceAliases('$(ThisApplication)'), '.cache');
end;

function GetCacheRootAliasReplace: string;
var
 l_CacheIniFileName: string;
begin
 Result := '';
 //
 try
  l_CacheIniFileName := ReplaceAliases('$(CacheIniFileName)');
  //
  if not(g_CacheUpdateFailed) then
   if FileExists(l_CacheIniFileName) then
    Result := GetStringFromIniFile(l_CacheIniFileName, 'Cache', 'Root')
   else
    if (GetProductType <> ptUnknown) then
     Result := '$(InstallRoot)';
 except
 end;
 //
 if (Result = '') then
  Result := '$(ExecuteRoot)';
end;

function GetCacheRunThroughAliasReplace: string;
begin
 Result := '';
 //
 try
  Result := GetStringFromIniFile(ReplaceAliases('$(CacheIniFileName)'), 'Cache', 'RunThrough');
 except
 end;
end;

function GetCleanerDisplayNameAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'CleanerDisplayName');
end;

function GetCleanerPublisherAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'CleanerPublisher');
end;

function GetCleanerRegistryKeyAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'CleanerRegistryKey');
end;

function GetCleanerRegistryPathAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'CleanerRegistryPath');
end;

function GetCleanerUninstallStringAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'CleanerUninstallString');
end;

{$I '..\nsBuildVersion.inc'}

function GetCleanerVersionMajorAliasReplace: string;
var
 l_BuildVersion: string;
 l_Position: Integer;
begin
 Result := c_BuildVersion;
 l_Position := Pos('.', Result);
 //
 if (l_Position > 0) then begin
  Result := Copy(Result, 1, Pred(l_Position));
 end;
end;

function GetCleanerVersionMinorAliasReplace: string;
var
 l_Position: Integer;
begin
 Result := c_BuildVersion;
 l_Position := Pos('.', Result);
 //
 if (l_Position > 0) then begin
  Delete(Result, 1, l_Position);
  //
  l_Position := Pos('.', Result);
  //
  if (l_Position > 0) then begin
   Result := Copy(Result, 1, Pred(l_Position));
  end;
 end
 else
  Result := '';
end;

function GetCommandLineAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'CommandLine');
end;

function GetCommandLineFromIniFile(const a_IniFileName: string): string;
begin
 Result := GetStringFromIniFile(a_IniFileName, GetIniFileLauncherSectionName, 'CommandLine');
end;

function GetCommandLineParamsAliasReplace: string;
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
 l_ParamStr: string;
 //
 l_OpenByNumberFound: Boolean;
 l_OpenPrefix: string;
begin
 Result := '';
 //
 l_OpenByNumberFound := False;
 //
 with OpenIniFile(ReplaceAliases('$(ThisIniFileName)')) do
  for l_Index := 1 to ParamCount do
  begin
   l_ParamStr := ParamStr(l_Index);
   //
   if (
    not (SectionExists(l_ParamStr))
    and (StrIComp(PChar(l_ParamStr), PChar(c_4AllParam)) <> 0)
    and (StrIComp(PChar(l_ParamStr), PChar(c_Emulator0Param)) <> 0)
    and (StrIComp(PChar(l_ParamStr), PChar(c_Emulator1Param)) <> 0)
    and (StrIComp(PChar(l_ParamStr), PChar(c_Emulator2Param)) <> 0)
    and (StrIComp(PChar(l_ParamStr), PChar(c_ForceSettingsConversionParam)) <> 0)
    and (StrIComp(PChar(l_ParamStr), PChar(c_WaitForExitParam)) <> 0)
    and (StrIComp(PChar(l_ParamStr), PChar(c_SilentParam)) <> 0)
   ) then begin
    if (l_OpenByNumberFound) then
    begin
     l_OpenPrefix := LowerCase(Format('%s://', [ReplaceAliases('%(URLProtocolName)')]));
     //
     if (Pos(l_OpenPrefix, LowerCase(l_ParamStr)) = 1) then
     begin
      Delete(l_ParamStr, 1, Length(l_OpenPrefix));
      l_ParamStr := RemoveFinalSlash(l_ParamStr);
     end;
    end;
    //
    l_OpenByNumberFound := (StrIComp(PChar(l_ParamStr), PChar(c_ShellOpenDocParam)) = 0);
    //
    Result := AddParamStrToCommandLine(Result, QuoteStringIfNeed(l_ParamStr));
   end;
  end;
end;

function GetConsultingCheckerApplicationAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ConsultingCheckerApplication');
end;

function GetConsultingCheckerCommandLineAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ConsultingCheckerCommandLine');
end;

function GetConsultingCheckerCurrentDirectoryAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ConsultingCheckerCurrentDirectory');
end;

function GetConsultingConfigCommonAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ConsultingConfigCommon');
end;

function GetConsultingConfigCommonProxyAuthAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('%(ConsultingConfigCommon)'), 'htbp', 'proxy_auth');
end;

function GetConsultingConfigCommonProxyHostAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('%(ConsultingConfigCommon)'), 'htbp', 'proxy_host');
end;

function GetConsultingConfigCommonProxyPortAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('%(ConsultingConfigCommon)'), 'htbp', 'proxy_port');
end;

function GetConsultingConfigCommonSynchronizeAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('%(ConsultingConfigCommon)'), 'htbp', 'synchronize');
end;

function GetConsultingConfigCurrentAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ConsultingConfigCurrent');
end;

function GetConsultingConfigProxySynchronizeAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ConsultingConfigProxySynchronize');
end;

function GetCreateDesktopShortcutsAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'CreateDesktopShortcuts', '');
 //
 if ((Result <> '') and ((StrIComp(PChar(Result), PChar(c_NoValue)) <> 0) and (StrIComp(PChar(Result), PChar(c_YesValue)) <> 0))) then
  raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonUnrecognisedParameterValue), ['CreateDesktopShortcuts', Result]));
 //
 if ((StrIComp(PChar(Result), PChar(c_YesValue)) = 0) and IsSilentParamExist) then
  Result := c_NoValue;
end;

function GetCurrentDirectoryAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'CurrentDirectory');
end;

function GetDefaultDirectoryAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'DefaultDirectory');
end;

function GetDealerInfFileAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'DealerInfFile');
end;

function GetDefaultPathAliasReplace: string;
 //
 function MakeLegacyPath: string;
 begin
  SetLength(Result, MAX_PATH);
  SetLength(Result, GetWindowsDirectory(PChar(Result), MAX_PATH));
  //
  Result := ExtractFileDrive(Result);
  if (Result = '') then
   Result := 'C:';
  //
  Result := Format('%s\Program Files', [RemoveFinalSlash(Result)]);
 end;
 //
begin
 Result := GetSpecialFolderPath(CSIDL_APPDATA);
 //
 if (Result = '') then
  Result := MakeLegacyPath;
 //
 Result := RemoveFinalSlash(Result);
end;

function GetDesktopPathAliasReplace: string;
begin
 Result := GetSpecialFolderPath(CSIDL_DESKTOPDIRECTORY);
 //
 if ((Result = '') or (not(DirectoryExists(Result)) and not(ForceDirectories(Result)))) then
  raise ELauncherError.Create(GetCurrentLocaleMessage(c_GarantUnableGetDesktopPath));
end;

function GetDRServerAliasReplace: string;
begin
 Result := ExtractHostName(GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileF1ServerSectionName, '-DRServer'));
 //
 if (Result = '') then
  Result := 'revision.garant.ru';
end;

function  GetDownloaderProxyHostAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileDownloaderSectionName, 'ProxyAdress');
end;

function GetEmulatorKeyAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'EmulatorKey');
end;

function GetEmulatorPathAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'EmulatorPath');
end;

function GetEmulatorValueAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'EmulatorValue');
end;

function GetEmulatorValueNameAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'EmulatorValueName');
end;

function GetExecuteRootAliasReplace: string;
begin
 Result := RemoveFinalSlash(ExtractFileDir(ParamStr(0)));
end;

function GetF1ServerActiveDataPathAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileF1ServerSectionName, '-GCMActiveDataPath');
end;

function GetF1ServerConsultingClientEnableAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileF1ServerSectionName, '-ConsultingClientEnable');
end;

function GetF1ServerConsultingServerAddressAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileF1ServerSectionName, '-ConsultingServerAddress');
end;

function GetF1ServerLocaleAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileF1ServerSectionName, '-Locale');
end;

function GetF1ServerLocaleEngAliasReplace: string;
var
 l_F1ServerLocale: string;
begin
 Result := '';
 //
 l_F1ServerLocale := UpperCase(ReplaceAliases('%(F1ServerLocale)'));
 //
 if ((Length(l_F1ServerLocale) >= 2) and (l_F1ServerLocale [1] = 'E') and (l_F1ServerLocale [2] = 'N')) then
 begin
  Result := '-eng';
 end;
end;

function GetHttpProxyEnvHostAliasReplace: string;
const
 c_ProxyEnvName: string = '%HTTP_PROXY%';
begin
 Result := ExtractHostName(ReplaceAliases(c_ProxyEnvName));
 //
 if (Result = c_ProxyEnvName) then
  Result := '';
end;

function GetInstallRootAliasReplace: string;
 //
 function CalculateSizeForPath(const a_Path: string): Int64;
 var
  l_SearchRec: TSearchRec;
  l_SearchResult: Integer;
 begin
  Result := 0;
  //
  l_SearchResult := FindFirst(Format('%s\%s', [a_Path, c_AllFilesMask]), Integer(faAnyFile), l_SearchRec);
  try
   while (l_SearchResult = 0) do
   begin
    with l_SearchRec do
     if ((Name <> '.') and (Name <> '..')) then
     begin
      if ((Attr and Integer(faDirectory)) <> 0) then
       Inc(Result, CalculateSizeForPath(Format('%s\%s', [a_Path, Name])))
      else
       Inc(Result, Int64(Size)+Int64(64*1024));
     end;
    //
    l_SearchResult := FindNext(l_SearchRec);
   end;
  finally
   SysUtils.FindClose(l_SearchRec);
  end;
 end;
 //
 procedure UpdateUserSettingsIfNeed;
  //
  procedure CleanupRegistryPath(const a_SkipFlag: Boolean = False); forward;
  procedure CopyEtalonSettingsToCurrent(const a_SkipFlag: Boolean = False); forward;
  procedure ExportPreviousSettings(const a_SkipFlag: Boolean = False); forward;
  function  IsForceSettingsConversionParamExist: Boolean; forward;
  procedure MoveCurrentSettingsToPrevious(const a_SkipFlag: Boolean = False); forward;
  procedure MovePreviousSettingsToCurrent(const a_SkipFlag: Boolean = False); forward;
  procedure MoveSettingsFromPathToPath(const a_FromPath: string; const a_ToPath: string; const a_ProgressTitle: string); forward;
  //
  procedure CleanupRegistryPath(const a_SkipFlag: Boolean);
  var
   l_RegistryPath: string;
  begin
   if not(a_SkipFlag) then
    try
     l_RegistryPath := ReplaceAliases('%(RegistryPath)');
     //
     with TRegistry.Create(Longword(KEY_ALL_ACCESS)) do
      try
       RootKey := RegistryKeyToKey(ReplaceAliases('%(RegistryKey)'));
       //
       if OpenKey(l_RegistryPath, False) then
       begin
        CloseKey;
        //
        DeleteKey(l_RegistryPath);
       end;
      finally
       Free;
      end;
    except
    end;
  end;
  //
  procedure CopyEtalonSettingsToCurrent(const a_SkipFlag: Boolean);
   //
   procedure CopyEtalonSettingsFromPathToPath(const a_FromPath: string; const a_ToPath: string);
   begin
    if DirectoryExists(a_FromPath) then
    begin
     try
      DoFileOperation(FO_COPY, a_FromPath, a_ToPath, GetCurrentLocaleMessage(c_GarantSettingsCopyOperation), True);
     except
      DoFileOperation(FO_DELETE, a_ToPath, '', GetCurrentLocaleMessage(c_GarantSettingsRevertOperation));
      //
      raise;
     end;
     //
     CleanReadOnlyAttributeForPath(a_ToPath);
    end
    else
     raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_GarantEtalonSettingsFolderAbsent), [a_FromPath]));
   end;
   //
  begin
   if not(a_SkipFlag) then
    CopyEtalonSettingsFromPathToPath(ReplaceAliases('%(SettingsSourceDirectory)'), ReplaceAliases('%(SettingsCurrentDirectory)'));
  end;
  //
  procedure ExportPreviousSettings(const a_SkipFlag: Boolean);
  var
   l_ExitCode: DWORD;
   l_SettingsExportApplication: string;
  begin
   if not(a_SkipFlag) then
    l_SettingsExportApplication := ReplaceAliases('%(SettingsExportApplication)');
    //
    if ((l_SettingsExportApplication <> '') and not(IsDirectoryEmpty(ReplaceAliases('%(SettingsPreviousDirectory)')))) then
    begin
{$IFDEF DEBUG}
     with TWaitMessageForm.Create(nil) do
     try
      Text := GetCurrentLocaleMessage(c_GarantSettingsExportOperation);
      //
      Show;
      try
       Application.ProcessMessages;
{$ENDIF DEBUG}
       //
       l_ExitCode := RunProcess(l_SettingsExportApplication, ReplaceAliases('%(SettingsExportCommandLine)'), ReplaceAliases('%(SettingsExportCurrentDirectory)'));
{$IFDEF DEBUG}
      finally
       Hide;
      end;
     finally
      Free;
     end;
{$ENDIF DEBUG}
     //
     if (l_ExitCode <> 0) then
      raise ELauncherError.CreateFmt(GetCurrentLocaleMessage(c_GarantOperationFailed), [GetCurrentLocaleMessage(c_GarantSettingsExportOperation)]);
    end;
  end;
  //
  function IsForceSettingsConversionParamExist: Boolean;
  var
   l_Index: Integer;
  begin
   Result := False;
   //
   for l_Index := 1 to ParamCount do
    if (StrIComp(PChar(ParamStr(l_Index)), PChar(c_ForceSettingsConversionParam)) = 0) then
    begin
     Result := True;
     Break;
    end;
  end;
  //
  procedure MoveCurrentSettingsToPrevious(const a_SkipFlag: Boolean);
  begin
   if not(a_SkipFlag) then
    MoveSettingsFromPathToPath(ReplaceAliases('%(SettingsCurrentDirectory)'), ReplaceAliases('%(SettingsPreviousDirectory)'), GetCurrentLocaleMessage(c_GarantSettingsSaveOperation));
  end;
  //
  procedure MovePreviousSettingsToCurrent(const a_SkipFlag: Boolean);
  begin
   if not(a_SkipFlag) then
    MoveSettingsFromPathToPath(ReplaceAliases('%(SettingsPreviousDirectory)'), ReplaceAliases('%(SettingsCurrentDirectory)'), GetCurrentLocaleMessage(c_GarantSettingsRestoreOperation));
  end;
  //
  procedure MoveSettingsFromPathToPath(const a_FromPath: string; const a_ToPath: string; const a_ProgressTitle: string);
  var
   l_FromCopyPath: string;
  begin
   if DirectoryExists(a_FromPath) then
   begin
    l_FromCopyPath := Format('%s\%s', [a_FromPath, c_AllFilesMask]);
    //
    DoFileOperation(FO_DELETE, a_ToPath, '', a_ProgressTitle);
    DoFileOperation(FO_COPY, l_FromCopyPath, a_ToPath, a_ProgressTitle);
    DoFileOperation(FO_DELETE, a_FromPath, '', a_ProgressTitle);
   end;
  end;
  //
 const
  c_RegistryValueName = 'SettingsVersion';
 var
  l_IsForceSettingsConversionParamExist: Boolean;
  l_SettingsCurrentDirectory: string;
  l_SettingsVersion: string;
 begin
  l_IsForceSettingsConversionParamExist := (IsForceSettingsConversionParamExist and g_AllowForceSettingsConversion);
  l_SettingsVersion := ReplaceAliases('%(SettingsVersion)');
  //
  if (l_IsForceSettingsConversionParamExist or (l_SettingsVersion <> GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName))) then
  begin
   g_AllowForceSettingsConversion:= False;
   //
   MoveCurrentSettingsToPrevious(l_IsForceSettingsConversionParamExist);
   //
   try
    CopyEtalonSettingsToCurrent(l_IsForceSettingsConversionParamExist);
    //
    try
     ExportPreviousSettings;
    except
     on E: ELauncherError do
     begin
      WarningMessageBox(E.Message);
      //
      CleanupRegistryPath(l_IsForceSettingsConversionParamExist);
     end;
    end;
   except
    MovePreviousSettingsToCurrent;
    //
    raise;
   end;
   //
   RegisterCleaner;
   PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName, l_SettingsVersion);
  end
  else
  begin
   l_SettingsCurrentDirectory := RemoveFinalSlash(ReplaceAliases('%(SettingsCurrentDirectory)'));
   //
   if (not(DirectoryExists(l_SettingsCurrentDirectory)) or IsDirectoryEmpty(l_SettingsCurrentDirectory)) then
    CopyEtalonSettingsToCurrent;
  end;
 end;
 //
const
 c_RegistryValueName = 'InstallRoot';
var
 l_ShowInstallRootDialog: Boolean;
begin
 Inc(g_InstallRootAliasReplaceRecursionCount);
 try
  Result := RemoveFinalSlash(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName));
  //
  while (True) do
  begin
   if ((Result = '') or (g_ForceShowInstallRootDialog) or ((g_InstallRootAliasReplaceRecursionCount = 1) and g_ShowInstallRootDialog and (not(DirectoryExists(Result)) or IsDirectoryEmpty(Result)))) then
   begin
    with TSelectInstallFolderForm.Create(Application) do
     try
      if (Result <> '') then
       DefaultPath := Result
      else
       DefaultPath := ReplaceAliases('%(DefaultDirectory)');
      //
      ExecuteRoot := ReplaceAliases('$(ExecuteRoot)');
      //
      ProductType := GetProductType;
      try
       RequiredSize := CalculateSizeForPath(ReplaceAliases('%(SettingsSourceDirectory)'));
      except
      end;
      //
      l_ShowInstallRootDialog := g_ForceShowInstallRootDialog or (StrIComp(PChar(ReplaceAliases('%(ShowInstallRootDialog)')), PChar(c_YesValue)) = 0);
      g_ForceShowInstallRootDialog := False;
      //
      repeat
       if (l_ShowInstallRootDialog and (ShowModal = mrCancel)) then
        Abort;
       //
       l_ShowInstallRootDialog := True;
      until (ForceDirectories (InstallPath));
      //
      Result := InstallPath;
      //
      g_ShowInstallRootDialog := False;
     finally
      Free;
     end;
    //
    PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName, Result);
   end;
   //
   Result := RemoveFinalSlash(Result);
   //
   if ((g_InstallRootAliasReplaceRecursionCount = 1) and (GetProductType(True) <> ptUnknown)) then
    try
     UpdateUserSettingsIfNeed;
    except
     on E: ELauncherError do
     begin
      g_ForceShowInstallRootDialog := True;
      //
      ErrorMessageBox(E.Message);
      Continue;
     end;
    end;
   //
   Break;
  end;
 finally
  Dec(g_InstallRootAliasReplaceRecursionCount);
 end;
end;

function GetLocaleCleanerNameAliasReplace: string;
 //
 function ProductTypeToString(const a_ProductType: TProductType): string;
 begin
  case a_ProductType of
   ptDesktop:
    Result := GetCurrentLocaleMessage(c_GarantVersionDesktop);
   ptMobile:
    Result := GetCurrentLocaleMessage(c_GarantVersionMobile);
   ptNetware:
    Result := GetCurrentLocaleMessage(c_GarantVersionNetware);
   ptWorking:
    Result := GetCurrentLocaleMessage(c_GarantVersionWorking);
   ptClient:
    Result := GetCurrentLocaleMessage(c_GarantVersionClient);
   ptSuperMobile:
    Result := GetCurrentLocaleMessage(c_GarantVersionSuperMobile);
   else
    Result := GetCurrentLocaleMessage(c_GarantVersionUnknown);
  end;
 end;
 //
begin
 Result := Format('"%s" (%s) %s', [ReplaceAliases('$(LocaleProductName)'), ProductTypeToString(GetProductType), GetCurrentLocaleMessage(c_GarantCurrentUser)]);
end;

function GetLocaleKeyAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'LocaleKey');
end;

function GetLocalePathAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'LocalePath');
end;

function GetLocaleProductNameAliasReplace: string;
begin
 Result := GetCurrentLocaleMessage(c_ApplicationTitle);
end;

function GetLocalePublisherAliasReplace: string;
begin
 Result := GetCurrentLocaleMessage(c_Publisher);
end;

function GetLocaleValueAliasReplace: string;
begin
 if (Pos(' -eng ', ReplaceAliases('%(CommandLine)')) <> 0) then
  Result := 'en'
 else
  Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'LocaleValue');
end;

function GetLocaleValueNameAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'LocaleValueName');
end;

function GetOrignalRootAliasReplace: string;
begin
 Inc(g_ForceRegistryValue);
 try
  Result := RemoveFinalSlash(ExtractFileDir(ReplaceAliases('$(ThisIniFileName)')));
 finally
  Dec(g_ForceRegistryValue);
 end;
end;

function GetOsAliasReplace: string;
begin
 if (Longint(GetVersion) < 0) then
  Result := 'win9X'
 else
  Result := 'winNT';
end;

function GetProductIdAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), 'Version', ReplaceAliases('%(ProductIdValueName)'), ReplaceAliases('%(UnknownId)'));
end;

function GetProductIdValueNameAliasReplace: string;
begin
 Result := '-ProductId';
end;

function GetProxyHostAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('%(ProxyHostIniFileName)'), 'htbp', 'proxy_host');
end;

function GetProxyHostIniFileNameAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ProxyHostIniFileName');
end;

function GetURLProtocolNameAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'URLProtocolName', 'garantF1');
end;

function GetRegistryKeyAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'RegistryKey');
end;

function GetRegistryPathAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'RegistryPath');
end;

function GetRegistryValueAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'RegistryValue');
end;

function GetRegistryValueNameAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'RegistryValueName');
end;

function GetSettingsCurrentDirectoryAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsCurrentDirectory');
end;

function GetSettingsExportApplicationAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsExportApplication');
end;

function GetSettingsExportCommandLineAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsExportCommandLine');
end;

function GetSettingsExportCommandLineFileAliasReplace: string;
begin
 try
  Result := GetCommandLineFromIniFile(ReplaceAliases(GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsExportCommandLineFile')));
 except
// Legacy compatibility {
  Result := ReplaceAliases(
   '-BasePointerCacheSize 1'
   + '-CollocatedUserManager'
   + '-GCM ORBPoolThreads=3'
   + '-GCMActiveDataPath 1'
   + '-GCMDataPath1 "$(ExecuteRoot)\data"'
   + '-GCMDataPath2 "$(ExecuteRoot)\data"'
   + '-GCMSettingsPath "%(SettingsPreviousDirectory)"'
   + '-ORBDottedDecimalAddresses 1'
   + '-ORBUseSharedProfiles 1'
   + '-XMLSavePath "%(SettingsCurrentDirectory)\xmllocal"'
  );
// } Legacy compatibility
 end;
end;

function GetSettingsExportCurrentDirectoryAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsExportCurrentDirectory');
end;

function GetSettingsPreviousDirectoryAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsPreviousDirectory');
end;

function GetSettingsSourceDirectoryAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsSourceDirectory');
end;

function GetSettingsVersionAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'SettingsVersion');
end;

function GetShowCreateDesktopShortcutsDialogAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'ShowCreateDesktopShortcutsDialog', c_NoValue);
 //
 if ((StrIComp(PChar(Result), PChar(c_NoValue)) <> 0) and (StrIComp(PChar(Result), PChar(c_YesValue)) <> 0)) then
  raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonUnrecognisedParameterValue), ['ShowCreateDesktopShortcutsDialog', Result]));
 //
 if ((StrIComp(PChar(Result), PChar(c_YesValue)) = 0) and IsSilentParamExist) then
  Result := c_NoValue;
end;

function GetShowInstallRootDialogAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'ShowInstallRootDialog', c_YesValue);
 //
 if ((StrIComp(PChar(Result), PChar(c_NoValue)) <> 0) and (StrIComp(PChar(Result), PChar(c_YesValue)) <> 0)) then
  raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonUnrecognisedParameterValue), ['ShowInstallRootDialog', Result]));
 //
 if ((StrIComp(PChar(Result), PChar(c_YesValue)) = 0) and IsSilentParamExist) then
  Result := c_NoValue;
end;

function GetThisApplicationAliasReplace: string;
begin
 Result := ParamStr(0);
end;

function GetThisFixFileNameAliasReplace: string;
begin
 Result := ChangeFileExt(ReplaceAliases('$(ThisApplication)'), '.fix');
end;

function GetThisIniFileNameAliasReplace: string;
const
 c_RegistryValueName = '$(ThisIniFileName)';
var
 l_IniFileName: string;
begin
 Result := '';
 //
 l_IniFileName := ChangeFileExt(ReplaceAliases('$(ThisApplication)'), '.ini');
 //
 if ((g_IniFileRecursionCount = 0) and g_ReplaceInstallRoot and (not(g_CacheUpdateFailed) or (g_ForceRegistryValue <> 0))) then
 begin
  Inc(g_IniFileRecursionCount);
  try
   if ((g_ForceRegistryValue = 0) and (ReplaceAliases('$(CacheRoot)') <> ReplaceAliases('$(ExecuteRoot)'))) then
    PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName, l_IniFileName);
   //
   Result := GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName, l_IniFileName);
  finally
   Dec(g_IniFileRecursionCount);
  end;
 end;
 //
 if (Result = '') then
  Result := l_IniFileName;
end;

function GetWhiteListKeyAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'WhiteListKey');
end;

function GetWhiteListPathAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'WhiteListPath');
end;

function GetWhiteListValueAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'WhiteListValue');
end;

function GetWhiteListValueNameAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileCurrentSectionName, 'WhiteListValueName');
end;

function GetWhiteListAliasReplace: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'WhiteList');
end;

function GetWinInetProxyHostAliasReplace: string;
var
 l_Position: Integer;
begin
 Result := GetWinInetProxy;
 //
 if (Result <> '') then
 begin
  l_Position := Pos(':', Result);
  //
  if (l_Position > 0) then
   SetLength(Result, Pred(l_Position));
 end;
end;

function GetWinInetProxyPortAliasReplace: string;
var
 l_Position: Integer;
begin
 Result := GetWinInetProxy;
 //
 if (Result <> '') then
 begin
  l_Position := Pos(':', Result);
  //
  if (l_Position > 0) then
   Delete(Result, 1, l_Position)
  else
   Result := '80'; // default HTTP port
 end;
end;

function GetUnknownIdAliasReplace: string;
begin
 Result := GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), 'Version', '-UnknownId', '{00000000-0000-0000-0000-000000000000}');
end;

function ExtractHostName(const a_Url: string): string;
const
 c_HTTPPrefix: string = 'http://';
var
 l_Position: Integer;
begin
 Result := a_Url;
 //
 if (Pos(c_HTTPPrefix, LowerCase(Result)) = 1) then
  Delete(Result, 1, Length(c_HTTPPrefix));
 //
 l_Position := Pos('/', Result);
 if (l_Position > 0) then
  SetLength(Result, Pred(l_Position));
 //
 l_Position := Pos(':', Result);
 if (l_Position > 0) then
  SetLength(Result, Pred(l_Position));
end;

function GetIniFileCurrentSectionName: string;
var
 l_4All: Boolean;
 l_Index: Integer;
 l_ParamStr: string;
begin
 Result := '';
 //
 l_4All := False;
 l_Index := 1;
 while (l_Index <= ParamCount) do
 begin
  l_ParamStr := ParamStr(l_Index);
  //
  if (
   (StrIComp(PChar(l_ParamStr), PChar(c_ForceSettingsConversionParam)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_Emulator0Param)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_Emulator1Param)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_Emulator2Param)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_WaitForExitParam)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_SilentParam)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_ShellSilentRunAndExitParam)) = 0)
  ) then
  begin
   // all is ok: do nothing
  end
  else
   if (
    (StrIComp(PChar(l_ParamStr), PChar(c_ShellLoginParam)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_ShellPasswordParam)) = 0)
    or (StrIComp(PChar(l_ParamStr), PChar(c_ShellOpenDocParam)) = 0)
   ) then
   begin
    Inc(l_Index); // skip one additional param
   end
   else
    if (StrIComp(PChar(l_ParamStr), PChar(c_4AllParam)) = 0) then
    begin
     l_4All := True;
    end
    else
    begin
     if (Result = '') then
      Result := l_ParamStr;
    end;
  //
  Inc(l_Index);
 end;
 //
 if (Result = '') then
  Result := 'Default';
 //
 if (l_4All) then
  Result := Format('%s-4All', [Result]);
end;

function GetIniFileDownloaderSectionName: string;
begin
 Result := 'Downloader';
end;

function GetIniFileF1ServerSectionName: string;
begin
 Result := 'F1Server Params';
end;

function GetIniFileLauncherDesktopShortcutsSectionName: string;
begin
 Result := 'LauncherDesktopShortcuts';
end;

function GetIniFileLauncherForceCreateFoldersSectionName: string;
begin
 Result := 'LauncherForceCreateFolders';
end;

function GetIniFileLauncherRegistrationSectionName: string;
begin
 Result := 'LauncherRegistration';
end;

function GetIniFileLauncherSectionName: string;
begin
 Result := 'Launcher';
end;

function GetIniFileLauncherUnRegistrationSectionName: string;
begin
 Result := 'LauncherUnRegistration';
end;

function GetLauncherRegistryKey: HKEY;
begin
 Result := RegistryKeyToKey(GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'RegistryKey'));
end;

function GetLauncherRegistryPath: string;
begin
 Result := GetNotEmptyStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'RegistryPath');
end;

function IsDifferentFileAge(const a_FileAge1: Integer; const a_FileAge2: Integer): Boolean;
begin
 Result := (
  (
   (a_FileAge1 > a_FileAge2) and ((a_FileAge1-a_FileAge2) > 1)
  ) or (
   (a_FileAge2 > a_FileAge1) and ((a_FileAge2-a_FileAge1) > 1)
  )
 );
end;

function IsLocalCacheEnabled: Boolean;
 function GetDefaultValue: Integer;
 begin
  Result := 0;
  //
  if (GetProductType <> ptUnknown) then
   Result := 1;
 end;
begin
 Result :=(StrToIntDef(GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'LocalCacheEnabled'), GetDefaultValue) <> 0);
end;

function IsRegistrationEnabled: Boolean;
begin
 Result := StrToIntDef(GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'RegistrationEnabled'), 1) <> 0;
end;

function IsUnRegistrationEnabled: Boolean;
begin
 Result := StrToIntDef(GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherSectionName, 'UnRegistrationEnabled'), 0) <> 0;
end;

function GetNotEmptyStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string = ''): string;
 //
 function ValidateEmptyIniFileValue(const a_IniFileValue: string; const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string): string;
 begin
  Result := a_IniFileValue;
  //
  if (Result = '') then
   raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonNotEmptyValueRequired), [a_IniFileSectionName, a_IniFileValueName, a_IniFileName]));
 end;
 //
begin
 Result := ValidateEmptyIniFileValue(GetStringFromIniFile(a_IniFileName, a_IniFileSectionName, a_IniFileValueName, a_IniFileDefaultValue), a_IniFileName, a_IniFileSectionName, a_IniFileValueName);
end;

function GetRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string): string;
begin
 Result := GetStringFromRegistry (a_RegistryKey, a_RegistryPath, ReplaceAliases('%(ProductIdValueName)'), ReplaceAliases('%(UnknownId)'));
end;

procedure PutRegistryProductId(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_ProductId: string);
begin
 PutStringToRegistry(a_RegistryKey, a_RegistryPath, ReplaceAliases('%(ProductIdValueName)'), a_ProductId);
end;

function GetProductType(a_RealType: Boolean): TProductType;
const
 c_IniFileVersionSectionName = 'Version';
var
 l_IniFileName: string;
 l_ProductValue: string;
begin
 Result := ptUnknown;
 //
 l_IniFileName := ReplaceAliases('$(ThisIniFileName)');
 //
 case StrToIntDef(GetStringFromIniFile(l_IniFileName, c_IniFileVersionSectionName, '-IniFile'), -1) of
  0..21: // [Version]\-IniFile
  begin
   l_ProductValue := GetStringFromIniFile(l_IniFileName, c_IniFileVersionSectionName, '-Product');
   //
   if (StrIComp(PChar(l_ProductValue), PChar('cd_or_dvd')) = 0) then
    Result := ptWorking
   else
    if (StrIComp(PChar(l_ProductValue), PChar('client')) = 0) or ((StrIComp(PChar(l_ProductValue), PChar('server')) = 0) and not a_RealType) then
     Result := ptClient
    else
     if (StrIComp(PChar(l_ProductValue), PChar('fileserver')) = 0) then
      Result := ptNetware
     else
      if (StrIComp(PChar(l_ProductValue), PChar('mobile')) = 0) then
       Result := ptMobile
      else
       if (StrIComp(PChar(l_ProductValue), PChar('desktop')) = 0) then
        Result := ptDesktop
       else
        if (StrIComp(PChar(l_ProductValue), PChar('mobile_online')) = 0) then
         Result := ptSuperMobile
        else
         Assert(False); // неизвестная тип продукта
  end;
  else
   Assert(False); // неизвестная версия инишника
 end;
end;

function GetWinInetProxy: string;
type
 PInternetProxyInfo = ^TInternetProxyInfo;
 TInternetProxyInfo = record
  r_AccessType: DWORD;
  r_Proxy: LPCSTR;
  r_ProxyBypass: LPCSTR;
 end;
 //
 TInternetQueryOptionCall = function (
  a_HInternet: Pointer
  ; a_Option: DWORD
  ; a_Buffer: Pointer
  ; var a_BufferLength: DWORD
 ): BOOL; stdcall;
const
 c_INTERNET_OPTION_PROXY = 38;
var
 l_Handle: THandle;
 //
 l_InternetProxyInfo: array of Byte;
 l_InternetProxySize: DWORD;
 //
 l_InternetQueryOptionProc: Pointer;
 l_InternetQueryOptionCall: TInternetQueryOptionCall absolute l_InternetQueryOptionProc;
begin
 Result := '';
 //
 l_Handle := LoadLibrary('wininet.dll');
 if (l_Handle <> THandle(0)) then
  try
   l_InternetQueryOptionProc := GetProcAddress(l_Handle, 'InternetQueryOptionA');
   if (l_InternetQueryOptionProc <> nil) then
   begin
    l_InternetProxySize := 0;
    //
    l_InternetQueryOptionCall(nil, c_INTERNET_OPTION_PROXY, nil, l_InternetProxySize);
    SetLength(l_InternetProxyInfo, l_InternetProxySize);
    //
    if (l_InternetQueryOptionCall(nil, c_INTERNET_OPTION_PROXY, l_InternetProxyInfo, l_InternetProxySize)) then
     Result := PInternetProxyInfo(l_InternetProxyInfo)^.r_Proxy;
   end;
  finally
   FreeLibrary(l_Handle);
  end;
end;

function GetSpecialFolderPath(const a_CSIDL: Integer): string;
var
 l_Buffer: packed array [0..MAX_PATH] of Char;
 l_ItemIDList: PItemIDList;
 l_Malloc: IMalloc;
begin
 Result := '';
 //
 try
  OleCheck(SHGetMalloc(l_Malloc));
  try
   OleCheck(SHGetSpecialFolderLocation(HWND(0), a_CSIDL, l_ItemIDList));
   try
    if SHGetPathFromIDList(l_ItemIDList, @l_Buffer) then
     Result := RemoveFinalSlash(PChar(@l_Buffer));
   finally
    l_Malloc.Free(l_ItemIDList);
   end;
  finally
   l_Malloc := nil;
  end;
 except
 end;
end;

function GetStringFromIniFile(const a_IniFileName: string; const a_IniFileSectionName: string; const a_IniFileValueName: string; const a_IniFileDefaultValue: string): string;
begin
 if FileExists(a_IniFileName) then
  Result := ReadIniFileString(a_IniFileName, a_IniFileSectionName, a_IniFileValueName, a_IniFileDefaultValue)
 else
  raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonFileNotFound), [a_IniFileName]));
end;

function GetStringFromRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryDefaultValue: string): string;
begin
 Result := '';
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
  on ERegistryException do { // do nothing };
 end;
 //
 if (Result = '') then
  Result := a_RegistryDefaultValue;
end;

function IsDirectoryEmpty(const a_Path: string): Boolean;
var
 l_SearchRec: TSearchRec;
 l_SearchResult: Integer;
begin
 Result := True;
 //
 l_SearchResult := FindFirst(Format('%s\%s', [a_Path, c_AllFilesMask]), Integer(faAnyFile), l_SearchRec);
 try
  while (l_SearchResult = 0) do
  begin
   with l_SearchRec do
    if ((Name <> '.') and (Name <> '..')) then
    begin
     Result := False;
     Break;
    end;
   //
   l_SearchResult := FindNext(l_SearchRec);
  end;
 finally
  SysUtils.FindClose(l_SearchRec);
 end;
end;

function IsSilentParamExist: Boolean;
var
 l_Index: Integer;
begin
 Result := False;
 //
 for l_Index := 1 to ParamCount do
  if (StrIComp(PChar(ParamStr(l_Index)), PChar(c_SilentParam)) = 0) then
  begin
   Result := True;
   Break;
  end;
end;

procedure PutIntegerToRegistry(const a_RegistryKey: HKEY; const a_RegistryPath: string; const a_RegistryValueName: string; const a_RegistryValue: Integer);
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
      WriteInteger(a_RegistryValueName, a_RegistryValue);
     finally
      CloseKey;
     end;
   finally
    Free;
   end;
 except
  on ERegistryException do
   raise ELauncherError.Create(GetCurrentLocaleMessage(c_GarantRegistryOperationFailed));
 end
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
   raise ELauncherError.Create(GetCurrentLocaleMessage(c_GarantRegistryOperationFailed));
 end
end;

function QuoteStringIfNeed(const a_String: string): string;
begin
 if ((Pos(' ', a_String) <> 0) or (Pos('''', a_String) <> 0)) then
  Result := Format('"%s"', [a_String])
 else
  Result := a_String;
end;

procedure RegisterCleaner;
var
 l_CleanerRegistryKey: string;
 l_CleanerRegistryPath: string;
begin
 l_CleanerRegistryKey := ReplaceAliases('%(CleanerRegistryKey)');
 if (l_CleanerRegistryKey <> '') then
 begin
  l_CleanerRegistryPath := ReplaceAliases('%(CleanerRegistryPath)');
  if (l_CleanerRegistryPath <> '') then
  begin
   PutStringToRegistry(RegistryKeyToKey(l_CleanerRegistryKey), l_CleanerRegistryPath, 'DisplayName', ReplaceAliases('%(CleanerDisplayName)'));
   PutStringToRegistry(RegistryKeyToKey(l_CleanerRegistryKey), l_CleanerRegistryPath, 'InstallLocation', ReplaceAliases('$(InstallRoot)'));
   PutStringToRegistry(RegistryKeyToKey(l_CleanerRegistryKey), l_CleanerRegistryPath, 'Publisher', ReplaceAliases('%(CleanerPublisher)'));
   PutStringToRegistry(RegistryKeyToKey(l_CleanerRegistryKey), l_CleanerRegistryPath, 'UninstallString', ReplaceAliases('%(CleanerUninstallString)'));
   PutStringToRegistry(RegistryKeyToKey(l_CleanerRegistryKey), l_CleanerRegistryPath, 'VersionMajor', ReplaceAliases('%(CleanerVersionMajor)'));
   PutStringToRegistry(RegistryKeyToKey(l_CleanerRegistryKey), l_CleanerRegistryPath, 'VersionMinor', ReplaceAliases('%(CleanerVersionMinor)'));
  end;
 end;
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
        raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonUnrecognisedParameterValue), ['RegistryKey', a_RegistryKey]));
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
 if ((l_Length > 0) and (Result[l_Length] in ['\', '/'])) then
  SetLength(Result, Pred(l_Length));
end;

function ReplaceAliases(const a_String: string): string;
 //
 type
  TGetAliasReplace = function: string;
 //
 function ExpandStringByEnvironment(const a_String: string): string;
 begin
  Result := '%%'; // minimal length must be >= 2 (Windows 95 bug)
  //
  SetLength(Result, Integer(Succ(ExpandEnvironmentStrings(PChar (a_String), PChar(Result), Length(Result)))));
  SetLength(Result, Integer(Pred(ExpandEnvironmentStrings(PChar (a_String), PChar(Result), Length(Result)))));
  //
  Result := PChar(Result); // remove terminating null character
 end;
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
 begin
  repeat
   l_AliasReplaced := False;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(Application)', GetApplicationAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(DealerInfFile)', GetDealerInfFileAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(DefaultDirectory)', GetDefaultDirectoryAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(DRServer)', GetDRServerAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(CommandLine)', GetCommandLineAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CreateDesktopShortcuts)', GetCreateDesktopShortcutsAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CurrentDirectory)', GetCurrentDirectoryAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(CleanerDisplayName)', GetCleanerDisplayNameAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CleanerPublisher)', GetCleanerPublisherAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CleanerRegistryKey)', GetCleanerRegistryKeyAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CleanerRegistryPath)', GetCleanerRegistryPathAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CleanerUninstallString)', GetCleanerUninstallStringAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CleanerVersionMajor)', GetCleanerVersionMajorAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(CleanerVersionMinor)', GetCleanerVersionMinorAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingCheckerApplication)', GetConsultingCheckerApplicationAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingCheckerCommandLine)', GetConsultingCheckerCommandLineAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingCheckerCurrentDirectory)', GetConsultingCheckerCurrentDirectoryAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingConfigCommon)', GetConsultingConfigCommonAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingConfigCurrent)', GetConsultingConfigCurrentAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingConfigProxySynchronize)', GetConsultingConfigProxySynchronizeAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingConfigCommonProxyAuth)', GetConsultingConfigCommonProxyAuthAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingConfigCommonProxyHost)', GetConsultingConfigCommonProxyHostAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingConfigCommonProxyPort)', GetConsultingConfigCommonProxyPortAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ConsultingConfigCommonSynchronize)', GetConsultingConfigCommonSynchronizeAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(EmulatorKey)', GetEmulatorKeyAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(EmulatorPath)', GetEmulatorPathAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(EmulatorValue)', GetEmulatorValueAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(EmulatorValueName)', GetEmulatorValueNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(LocaleKey)', GetLocaleKeyAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(LocalePath)', GetLocalePathAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(LocaleValue)', GetLocaleValueAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(LocaleValueName)', GetLocaleValueNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(WhiteList)', GetWhiteListAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(WhiteListKey)', GetWhiteListKeyAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(WhiteListPath)', GetWhiteListPathAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(WhiteListValue)', GetWhiteListValueAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(WhiteListValueName)', GetWhiteListValueNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(ProxyHost)', GetProxyHostAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ProxyHostIniFileName)', GetProxyHostIniFileNameAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(DownloaderProxyHost)', GetDownloaderProxyHostAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(F1ServerActiveDataPath)', GetF1ServerActiveDataPathAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(F1ServerConsultingClientEnable)', GetF1ServerConsultingClientEnableAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(F1ServerConsultingServerAddress)', GetF1ServerConsultingServerAddressAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(F1ServerLocale)', GetF1ServerLocaleAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(F1ServerLocaleEng)', GetF1ServerLocaleEngAliasReplace) or l_AliasReplaced;
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
   l_AliasReplaced := ReplaceAlias(Result, '%(RegistryValue)', GetRegistryValueAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(RegistryValueName)', GetRegistryValueNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsCurrentDirectory)', GetSettingsCurrentDirectoryAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsExportApplication)', GetSettingsExportApplicationAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsExportCommandLine)', GetSettingsExportCommandLineAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsExportCommandLineFile)', GetSettingsExportCommandLineFileAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsExportCurrentDirectory)', GetSettingsExportCurrentDirectoryAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsPreviousDirectory)', GetSettingsPreviousDirectoryAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsSourceDirectory)', GetSettingsSourceDirectoryAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(SettingsVersion)', GetSettingsVersionAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '%(ShowCreateDesktopShortcutsDialog)', GetShowCreateDesktopShortcutsDialogAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '%(ShowInstallRootDialog)', GetShowInstallRootDialogAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(CommandLineParams)', GetCommandLineParamsAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(DefaultPath)', GetDefaultPathAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(DesktopPath)', GetDesktopPathAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := (g_ReplaceExecuteRoot and ReplaceAlias(Result, '$(ExecuteRoot)', GetExecuteRootAliasReplace)) or l_AliasReplaced;
   l_AliasReplaced := (g_ReplaceInstallRoot and ReplaceAlias(Result, '$(InstallRoot)', GetInstallRootAliasReplace)) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(OriginalRoot)', GetOrignalRootAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(LocaleCleanerName)', GetLocaleCleanerNameAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(LocaleProductName)', GetLocaleProductNameAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(LocalePublisher)', GetLocalePublisherAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(Os)', GetOsAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(CacheIniFileName)', GetCacheIniFileNameAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(CacheRoot)', GetCacheRootAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(CacheRunThrough)', GetCacheRunThroughAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(ThisApplication)', GetThisApplicationAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(ThisFixFileName)', GetThisFixFileNameAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(ThisIniFileName)', GetThisIniFileNameAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(AllProxyEnvHost)', GetAllProxyEnvHostAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(HttpProxyEnvHost)', GetHttpProxyEnvHostAliasReplace) or l_AliasReplaced;
   //
   l_AliasReplaced := ReplaceAlias(Result, '$(WinInetProxyHost)', GetWinInetProxyHostAliasReplace) or l_AliasReplaced;
   l_AliasReplaced := ReplaceAlias(Result, '$(WinInetProxyPort)', GetWinInetProxyPortAliasReplace) or l_AliasReplaced;
  until not(l_AliasReplaced);
  //
  Result := ExpandStringByEnvironment(Result);
 end;
end;

procedure RunProcess(a_Application: TApplication; const a_ProductName: string);
 //
 procedure CreateDesktopShortcuts;
  //
  function CheckDesktopShortcutsStatus(const a_SuppressMessageBox: Boolean; const a_IsNoDefault: Boolean): Boolean;
  const
   c_DefaultButtons: array [Boolean] of Longint = (MB_DEFBUTTON1, MB_DEFBUTTON2);
   c_RegistryValueName = 'DesktopShortcutsStatus';
  var
   l_Text: string;
  begin
   //if true then
   if (StrIComp(PChar(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName)), PChar('Checked')) <> 0) then
   begin
    if (a_SuppressMessageBox) then
     Result := not(a_IsNoDefault)
    else
     with Application do
     begin
      l_Text := GetCurrentLocaleMessage(c_GarantCreateShortcutsOnDesktop);
      //
      Result := (ApplicationMessageBox(l_Text, c_DefaultButtons[a_IsNoDefault] + MB_YESNO + MB_ICONINFORMATION) = mrYes);
     end;
    //
    PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName, 'Checked');
   end
   else
    Result := False;
  end;
  //
  procedure CreateShortcutsOnDesktop(const a_IniFileName: string; const a_IniFileSectionName: string);
   //
   procedure CreateShortcutOnDesktop(const a_ShortcutName: string; const a_FileName: string);
   var
    l_DesktopFileName: WideString;
    l_ShellLink: IShellLink;
   begin
    OleCheck(CoCreateInstance(CLSID_ShellLink, nil, CLSCTX_INPROC_SERVER, IShellLink, l_ShellLink));
    try
     with l_ShellLink do
     begin
      OleCheck(SetPath(PChar(a_FileName)));
      OleCheck(SetWorkingDirectory(PChar(ExtractFileDir(a_FileName))));
      OleCheck(SetDescription(PChar(a_ShortcutName)));
     end;
     //
     l_DesktopFileName := Format('%s\%s.lnk', [ReplaceAliases('$(DesktopPath)'), a_ShortcutName]);
     OleCheck((l_ShellLink as IPersistFile).Save(PWideChar(l_DesktopFileName), True));
    finally
     l_ShellLink := nil;
    end;
   end;
   //
  var
   l_Index: Integer;
   l_ValueName: string;
  begin
   with ReadIniFileSection(a_IniFileName, a_IniFileSectionName) do
    for l_Index := 0 to Pred(Count) do
    begin
     l_ValueName := Strings[l_Index];
     //
     CreateShortcutOnDesktop(ReplaceAliases(l_ValueName), ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, l_ValueName)));
    end;
  end;
  //
 var
  l_CreateDesktopShortcuts: string;
 begin
  if not IsSilentParamExist then
  begin
   l_CreateDesktopShortcuts := ReplaceAliases('%(CreateDesktopShortcuts)');
   //
   if (l_CreateDesktopShortcuts <> '') then
    if (CheckDesktopShortcutsStatus((StrIComp(PChar(ReplaceAliases('%(ShowCreateDesktopShortcutsDialog)')), c_NoValue) = 0), (StrIComp(PChar(l_CreateDesktopShortcuts), c_NoValue) = 0))) then
     CreateShortcutsOnDesktop(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherDesktopShortcutsSectionName);
  end;
 end;
 //
 procedure ForceCreateFolders;
 const
  c_FolderPrefix = 'Folder';
  c_FolderPrefixLength = Length(c_FolderPrefix);
 var
  //
  l_IniFileName: string;
  l_IniFileSectionName: string;
  //
  l_Index: Integer;
  l_ValueName: string;
 begin
  l_IniFileName := ReplaceAliases('$(ThisIniFileName)');
  l_IniFileSectionName := GetIniFileLauncherForceCreateFoldersSectionName;
  //
  with ReadIniFileSection(l_IniFileName, l_IniFileSectionName) do
   for l_Index := 0 to Pred(Count) do
   begin
    l_ValueName := Strings[l_Index];
    //
    if (StrLIComp(PChar(l_ValueName), c_FolderPrefix, c_FolderPrefixLength) = 0) then
     ForceDirectories(ReplaceAliases(GetNotEmptyStringFromIniFile(l_IniFileName, l_IniFileSectionName, l_ValueName)));
   end;
 end;
 //
 procedure HotFixesUpdate;
  //
  procedure ProcessSection(const a_IniFileName: string; const a_IniFileSectionName: string);
   //
   function IsApplicationExist(const a_Application: string; const a_CurrentDirectory: string): Boolean;
   begin
    Result := FileExists(Format('%s\%s', [RemoveFinalSlash(a_CurrentDirectory), a_Application]));
   end;
   //
  const
   c_HotFixPrefix = 'HotFix';
   c_HotFixPrefixLength = Length(c_HotFixPrefix);
  var
   l_DstApplication: string;
   l_DstCommandLine: string;
   l_DstCopyCatalog: string;
   l_DstCurrentDirectory: string;
   l_SrcApplication: string;
   l_SrcCommandLine: string;
   l_SrcCopyCatalog: string;
   l_SrcCurrentDirectory: string;
   l_UIDRegistryValueName: string;
  begin
   if (StrLIComp(PChar(a_IniFileSectionName), c_HotFixPrefix, c_HotFixPrefixLength) = 0) then
   begin
    l_UIDRegistryValueName := Format('HOTFIX_%s', [GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '!UID')]);
    if (StrIComp(PChar(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, l_UIDRegistryValueName)),  PChar('Checked')) <> 0) then
    begin
{$IFDEF DEBUG}
     with TWaitMessageForm.Create(nil) do
     try
      Text := Format(GetCurrentLocaleMessage(c_GarantCheckUpdateInstallation), [a_IniFileSectionName]);
      //
      Show;
      try
       Application.ProcessMessages;
{$ENDIF DEBUG}
       //
       l_DstApplication := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '->Application'));
       l_DstCommandLine := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '->CommandLine'));
       l_DstCopyCatalog := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '->CopyCatalog'));
       l_DstCurrentDirectory := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '->CurrentDirectory'));
       //
       if IsApplicationExist(l_DstApplication, l_DstCurrentDirectory) then
       begin
        l_SrcApplication := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '<-Application'));
        l_SrcCommandLine := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '<-CommandLine'));
        l_SrcCopyCatalog := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '<-CopyCatalog'));
        l_SrcCurrentDirectory := ReplaceAliases(GetNotEmptyStringFromIniFile(a_IniFileName, a_IniFileSectionName, '<-CurrentDirectory'));
        //
        if (RunProcess(l_DstApplication, l_DstCommandLine, l_DstCurrentDirectory) = RunProcess(l_SrcApplication, l_SrcCommandLine, l_SrcCurrentDirectory)) then
         DoFileOperation(FO_COPY, l_SrcCopyCatalog, l_DstCopyCatalog, Format(GetCurrentLocaleMessage(c_GarantInstallUpdate), [a_IniFileSectionName]), True);
       end;
       //
       PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, l_UIDRegistryValueName, 'Checked');
{$IFDEF DEBUG}
      finally
       Hide;
      end;
     finally
      Free;
     end;
{$ENDIF DEBUG}
    end;
   end;
  end;
  //
 var
  l_Index: Integer;
  l_IniFileName: string;
 begin
  Inc(g_InstallRootAliasReplaceRecursionCount);
  try
   l_IniFileName := ReplaceAliases('$(ThisFixFileName)');
   //
   with ReadIniFileSections(l_IniFileName) do
    for l_Index := 0 to Pred(Count) do
     ProcessSection(l_IniFileName, Strings[l_Index]);
  finally
   Dec(g_InstallRootAliasReplaceRecursionCount);
  end;
 end;
 //
 function IsWaitForExitParamExist: Boolean;
 var
  l_Index: Integer;
 begin
  Result := False;
  //
  for l_Index := 1 to ParamCount do
   if (StrIComp(PChar(ParamStr(l_Index)), PChar(c_WaitForExitParam)) = 0) then
   begin
    Result := True;
    Break;
   end;
 end;
 //
 procedure RegisterCOMServers;
  //
  function RegistrationEnabled(const a_RegCheck: string): Boolean;
  begin
   Result := ((a_RegCheck = '') or StrToBoolDef(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, a_RegCheck, DefaultTrueBoolStr), True));
  end;
  //
  function UpdateCache(const a_FileName: string): string;
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
     //
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
    function GetTempUniqueName: string;
    var
     l_GUID: TGUID;
    begin
     CreateGUID(l_GUID);
     //
     Result := Format('%s.tmp', [GUIDToString(l_GUID)]);
    end;
    //
   var
    l_FileName: string;
   begin
    FileSetReadOnly(a_FileName, False);
    //
    if not(DeleteFile(PChar(a_FileName))) then
    begin
     l_FileName := Format('%s\%s', [ExtractFileDir(a_FileName), GetTempUniqueName]);
     //
     MoveFile(PChar(a_FileName), PChar(l_FileName));
     //
     if (Longint(GetVersion) < 0) then
      DelayRemoveFileWin9X(l_FileName)
     else
      DelayRemoveFileWinNT(l_FileName);
    end;
   end;
  var
   l_DestPath: string;
   l_FileName: string;
   l_ActionCaption: String;
  begin
   Result := a_FileName;
   //
   if IsLocalCacheEnabled and (ReplaceAliases('$(CacheRoot)') <> ReplaceAliases('$(ExecuteRoot)')) then
   begin
    Result := ReplaceAliases(Format('$(CacheRoot)\@com\%s', [ExtractFileName(a_FileName)]));
    //
    if IsDifferentFileAge(FileAge(a_FileName), FileAge(Result)) then
    begin
     if FileExists(Result) then
      RemoveFile(Result);
     //
     l_DestPath := ExtractFilePath(Result);
     //
     l_FileName := a_FileName;
     //http://mdp.garant.ru/pages/viewpage.action?pageId=420425319
     l_ActionCaption := GetCurrentLocaleMessage(c_GarantUpdateLocalCache);
     DoFileOperation(FO_COPY, l_FileName, l_DestPath, l_ActionCaption);
     //
     l_FileName := ChangeFileExt(l_FileName, '.ini');
     if FileExists(l_FileName) then
      DoFileOperation(FO_COPY, l_FileName, l_DestPath, l_ActionCaption);
    end;
   end;
  end;
  //
 var
  l_Index: Integer;
  l_Value: string;
  //
  l_Position: Integer;
  l_RegCheck: string;
 begin
  if IsRegistrationEnabled then
   with ReadIniFileSectionValues(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherRegistrationSectionName) do
   begin
    for l_Index := 0 to Pred(Count) do
     if (CheckItemPrefix(Strings[l_Index])) then
     begin
      l_RegCheck := '';
      l_Value := ReplaceAliases(ValueFromIndex[l_Index]);
      //
      l_Position := Pos('|', l_Value);
      if (l_Position > 0) then
      begin
       l_RegCheck := Copy(l_Value, Succ(l_Position), Length(l_Value)-l_Position);
       SetLength(l_Value, Pred(l_Position));
      end;
      //
      if (FileExists(l_Value) and RegistrationEnabled(l_RegCheck)) then
       try
        RegisterComServer(UpdateCache(l_Value));
        PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, CreateRegistrationName(l_Value), c_RegisteredValue);
       except
        // ignore all registration errors
       end;
     end;
   end;
 end;
 //
 procedure RegisterURLProtocol;
 type
  TSetRegistryVirtualization = function (const a_Value: Integer): Integer; stdcall;
 //
  function DisableMoleboxVirtualization(out a_VirtualizationProc: Pointer): Integer;
  const
   c_MoleboxAPI: PWideChar = 'molebox;api';
   c_DONT_VIRTUALIZE_REGISTRY = 0;
  var
   l_RawAPIBase: PChar;
  begin
   Result := 0;
   a_VirtualizationProc := nil;
   //
   if ((GetEnvironmentVariableW(c_MoleboxAPI, PWideChar(@l_RawAPIBase), SizeOf(l_RawAPIBase)) = SizeOf(l_RawAPIBase)) and (l_RawAPIBase <> nil)) then
   begin
    a_VirtualizationProc := Pointer(PDWORD(l_RawAPIBase+SizeOf(Integer)+12*SizeOf(Pointer))^);
    Result := TSetRegistryVirtualization(a_VirtualizationProc)(c_DONT_VIRTUALIZE_REGISTRY);
   end;
  end;
  //
  procedure RestoreMoleboxVirtualization(const a_VirtualizationProc: Pointer; const a_PreviousVirtualization: Integer);
  begin
   if (a_VirtualizationProc <> nil) then
   begin
    TSetRegistryVirtualization(a_VirtualizationProc)(a_PreviousVirtualization);
   end;
  end;
 //
 var
  l_MoleboxVirtualization: Integer;
  l_MoleboxVirtualizationProc: Pointer;
  //
  l_ProtocolName: string;
  l_ProtocolPath: string;
  //
  l_ProtocolOpen: string;
 begin
  try
   l_MoleboxVirtualization := DisableMoleboxVirtualization(l_MoleboxVirtualizationProc);
   try
    l_ProtocolName := ReplaceAliases('%(URLProtocolName)');
    l_ProtocolPath := Format('Software\Classes\%s', [l_ProtocolName]);
    //
    l_ProtocolOpen := Format('%s %s %%1', [ReplaceAliases('$(ThisApplication)'), c_ShellOpenDocParam]);
    //
    PutStringToRegistry(HKEY(HKEY_CURRENT_USER), l_ProtocolPath, '', Format('URL:%s Protocol', [l_ProtocolName]));
    //
    PutIntegerToRegistry(HKEY(HKEY_CURRENT_USER), l_ProtocolPath, 'EditFlags', $0100); // FTA_NoEditDesc
    //
    PutStringToRegistry(HKEY(HKEY_CURRENT_USER), l_ProtocolPath, 'FriendlyTypeName', Format('%s URL', [l_ProtocolName]));
    PutStringToRegistry(HKEY(HKEY_CURRENT_USER), l_ProtocolPath, 'URL Protocol', '');
    //
    PutStringToRegistry(HKEY(HKEY_CURRENT_USER), Format('%s\shell\open\command', [l_ProtocolPath]), '', l_ProtocolOpen);
   finally
    RestoreMoleboxVirtualization(l_MoleboxVirtualizationProc, l_MoleboxVirtualization);
   end;
  except
   // если не смогли зарегистрировать протокол - просто это игнорируем
  end;
 end;
 //
 procedure RunConsultingChecker;
 const
  c_RegistryValueName = 'ConsultingServerAccess';
 var
  l_ConsultingCheckerApplication: string;
 begin
  if (StrIComp(PChar(GetStringFromIniFile(ReplaceAliases('$(ThisIniFileName)'), 'Version', '-Product')), PChar('client')) <> 0) then
   if (StrToIntDef(ReplaceAliases('%(F1ServerConsultingClientEnable)'), -1) <> 0) then
    begin
     l_ConsultingCheckerApplication := ReplaceAliases('%(ConsultingCheckerApplication)');
     //
     if (l_ConsultingCheckerApplication <> '') then
      if (StrIComp(PChar(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName)), PChar('Checked')) <> 0) then
      begin
       RunProcess(l_ConsultingCheckerApplication, ReplaceAliases('%(ConsultingCheckerCommandLine)'), ReplaceAliases('%(ConsultingCheckerCurrentDirectory)'));
       //
       PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, c_RegistryValueName, 'Checked');
      end;
    end;
 end;
 //
 procedure SynchronizeConsultingConfigs;
 begin
  if (StrToIntDef(ReplaceAliases('%(ConsultingConfigProxySynchronize)'), 0) <> 0) then
   with OpenIniFile(ReplaceAliases('%(ConsultingConfigCurrent)')) do
    if (StrToIntDef(ReadString('htbp', 'synchronize', ''), -1) <> 0) then
    begin
     WriteString('htbp', 'proxy_auth', ReplaceAliases('%(ConsultingConfigCommonProxyAuth)'));
     WriteString('htbp', 'proxy_host', ReplaceAliases('%(ConsultingConfigCommonProxyHost)'));
     WriteString('htbp', 'proxy_port', ReplaceAliases('%(ConsultingConfigCommonProxyPort)'));
    end;
 end;
 //
 procedure UnRegisterCOMServers;
  //
  function UnRegistrationEnabled(const a_RegCheck: string): Boolean;
  begin
   Result := ((a_RegCheck = '') or not StrToBoolDef(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, a_RegCheck, DefaultTrueBoolStr), True));
  end;
  //
  procedure UnRegisterComServer(const a_Name: string);
  type
   TUnRegProc = function: HResult; stdcall;
  const
   UnRegProcName = 'DllUnregisterServer';
  var
   l_Handle: THandle;
   l_UnRegProc: TUnRegProc;
  begin
   l_Handle := SafeLoadLibrary(a_Name);
   //
   if (l_Handle <= HINSTANCE_ERROR) then
    raise Exception.CreateFmt('%s: %s', [SysErrorMessage(GetLastError), a_Name]);
   //
   try
    l_UnRegProc := GetProcAddress(l_Handle, UnRegProcName);
    if Assigned(l_UnRegProc) then
     OleCheck(l_UnRegProc)
    else RaiseLastOSError;
   finally
    FreeLibrary(l_Handle);
   end;
  end;
 //
 var
  l_Index: Integer;
  l_Value: string;
  //
  l_Position: Integer;
  l_RegCheck: string;
 begin
  if IsUnRegistrationEnabled then
   with ReadIniFileSectionValues(ReplaceAliases('$(ThisIniFileName)'), GetIniFileLauncherUnRegistrationSectionName) do
   begin
    for l_Index := 0 to Pred(Count) do
     if (CheckItemPrefix(Strings[l_Index])) then
     begin
      l_RegCheck := '';
      l_Value := ReplaceAliases(ValueFromIndex[l_Index]);
      //
      l_Position := Pos('|', l_Value);
      if (l_Position > 0) then
      begin
       l_RegCheck := Copy(l_Value, Succ(l_Position), Length(l_Value)-l_Position);
       SetLength(l_Value, Pred(l_Position));
      end;
      //
      if (FileExists(l_Value) and UnRegistrationEnabled(l_RegCheck)) then
       try
        if SameText(GetStringFromRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, CreateRegistrationName(l_Value), c_UnRegisteredValue), c_RegisteredValue) then
        begin
         UnRegisterComServer(l_Value);
         PutStringToRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath, CreateRegistrationName(l_Value), c_UnRegisteredValue);
        end;
       except
        // ignore all registration errors
       end;
     end;
   end;
 end;
 //
 function UpdateCache(const a_CacheFile: string; const a_CacheRoot: string; const a_Section: string; const a_IgnoreFileAge: Boolean): Boolean;
  //
  function IsNeedFileUpdate(const a_FromName: string; const a_ToPath: string): Boolean;
  var
   l_ToName: string;
  begin
   l_ToName := Format('%s\%s', [a_ToPath, ExtractFileName(a_FromName)]);
   //
   Result := IsDifferentFileAge(FileAge(a_FromName), FileAge(l_ToName));
  end;
  //
 var
  l_ExecuteRoot: string;
  //
  l_Index: Integer;
  l_Value: string;
  //
  l_FromPath: string;
  l_ToPath: string;
  l_ActionCaption: String;
 begin
  Result := False;
  //
  if FileExists(a_CacheFile) then
  begin
   l_ExecuteRoot := ReplaceAliases('$(ExecuteRoot)');
   //
   with ReadIniFileSectionValues(a_CacheFile, a_Section) do
    for l_Index := 0 to Pred(Count) do
     if (CheckItemPrefix(Strings[l_Index])) then
     begin
      l_Value := ReplaceAliases(ValueFromIndex[l_Index]);
      //
      l_FromPath := Format('%s\%s', [l_ExecuteRoot, l_Value]);
      l_ToPath := ReplaceAliases(a_CacheRoot);
      //
      l_Value := ExtractFileDir(l_Value);
      if (l_Value <> '') then
       l_ToPath := Format('%s\%s', [l_ToPath, l_Value]);
      //
      l_ActionCaption := GetCurrentLocaleMessage(c_GarantUpdateLocalCache);
      if DirectoryExists(l_FromPath) then
      begin
       Result := True;
       //
       DoFileOperation(FO_COPY, l_FromPath, l_ToPath, l_ActionCaption)
      end
      else
       if FileExists(l_FromPath) then
       begin
        if (a_IgnoreFileAge or IsNeedFileUpdate(l_FromPath, l_ToPath)) then
        begin
         Result := True;
         //
         DoFileOperation(FO_COPY, l_FromPath, l_ToPath, l_ActionCaption);
        end;
       end;
     end;
  end;
 end;
 //
 procedure UpdateEmulator;
  //
  function GetEmulatorValueFromCommandLine: string;
  var
   l_Index: Integer;
   l_ParamStr: string;
  begin
   Result := '';
   //
   for l_Index := 1 to ParamCount do
   begin
    l_ParamStr := ParamStr(l_Index);
    //
    if (StrIComp(PChar(l_ParamStr), PChar(c_Emulator0Param)) = 0) then
    begin
     Result := '0';
     Break;
    end;
    //
    if (StrIComp(PChar(l_ParamStr), PChar(c_Emulator1Param)) = 0) then
    begin
     Result := '1';
     Break;
    end;
    //
    if (StrIComp(PChar(l_ParamStr), PChar(c_Emulator2Param)) = 0) then
    begin
     Result := '2';
     Break;
    end;
   end;
  end;
  //
 var
  l_EmulatorKey: string;
  l_EmulatorValue: string;
 begin
  l_EmulatorKey := ReplaceAliases('%(EmulatorKey)');
  //
  if (l_EmulatorKey <> '') then
  begin
   l_EmulatorValue := GetEmulatorValueFromCommandLine;
   //
   if (l_EmulatorValue = '') then
    l_EmulatorValue := ReplaceAliases('%(EmulatorValue)');
   //
   PutIntegerToRegistry(RegistryKeyToKey(l_EmulatorKey), ReplaceAliases('%(EmulatorPath)'), ReplaceAliases('%(EmulatorValueName)'), StrToIntDef(l_EmulatorValue, 0));
  end;
 end;
 //
 procedure UpdateLauncher;
 begin
  if UpdateCache(ReplaceAliases('$(ThisIniFileName)'), ReplaceAliases('$(InstallRoot)'), 'LauncherUpdates', False) then
   RegisterCleaner;
 end;
 //
 procedure UpdateLocalCache;
  //
  procedure CleanupCache(const a_CacheFile: string);
  var
   l_CacheRoot: string;
   l_Removes: TStrings;
   //
   l_Index: Integer;
  begin
   l_CacheRoot := ReplaceAliases('$(CacheRoot)');
   l_Removes := ReadIniFileSectionValues(a_CacheFile, 'Removes');
   //
   with l_Removes do
    for l_Index := 0 to Pred(Count) do
     DoFileOperation(FO_DELETE, Format('%s\%s', [l_CacheRoot, ReplaceAliases(ValueFromIndex[l_Index])]), '',
     //http://mdp.garant.ru/pages/viewpage.action?pageId=420425319
      GetCurrentLocaleMessage(c_GarantUpdateLocalCache));
  end;
  //
  function NeedUpdateCache(const a_CacheFile: string): Boolean;
  //
  var
   l_Index: Integer;
   l_Value: string;
   //
   l_CacheRoot: string;
   l_ExecuteRoot: string;
  begin
   Result := False;
   //
   l_CacheRoot := ReplaceAliases('$(CacheRoot)');
   l_ExecuteRoot := ReplaceAliases('$(ExecuteRoot)');
   //
   with ReadIniFileSectionValues(a_CacheFile, 'CheckFiles') do
    for l_Index := 0 to Pred(Count) do
     if (CheckItemPrefix(Strings[l_Index])) then
     begin
      l_Value := ReplaceAliases(ValueFromIndex[l_Index]);
      //
      if IsDifferentFileAge(FileAge(Format('%s\%s', [l_CacheRoot, l_Value])), FileAge(Format('%s\%s', [l_ExecuteRoot, l_Value]))) then
      begin
       Result := True;
       Break;
      end;
     end;
  end;
  //
 var
  l_CacheFile: string;
  //
  l_CacheRoot: string;
  l_ExecuteRoot: string;
 begin
  if not(g_CacheUpdateFailed) then
  begin
   l_CacheRoot := ReplaceAliases('$(CacheRoot)');
   l_ExecuteRoot := ReplaceAliases('$(ExecuteRoot)');
   //
   if ((l_CacheRoot <> '') and (AnsiCompareText(l_CacheRoot, l_ExecuteRoot) <> 0)) then
    try
     l_CacheFile := ReplaceAliases('$(CacheIniFileName)');
     //
{$IFDEF DEBUG}
     with TWaitMessageForm.Create(nil) do
     try
      Text := GetCurrentLocaleMessage(c_GarantUpdateLocalCache);
      //
      Show;
      try
       Application.ProcessMessages;
{$ENDIF DEBUG}
       //
       if NeedUpdateCache(l_CacheFile) then
       begin
        CleanupCache(l_CacheFile);
        UpdateCache(l_CacheFile, l_CacheRoot, 'Updates', True);
        //
        CleanReadOnlyAttributeForPath(l_CacheRoot);
        //
        g_UseCacheRunThrough := True;
       end;
{$IFDEF DEBUG}
      finally
       Hide;
      end;
     finally
      Free;
     end;
{$ENDIF DEBUG}
    except
     g_CacheUpdateFailed := False;
     try
      try
       TFileStream.Create(Format('%s\f1.cache', [ReplaceAliases('$(CacheRoot)')]), fmCreate).Free;
      except
       // cannot create `f1.cache` file
      end;
     finally
      g_CacheUpdateFailed := True;
     end;
    end;
  end;
 end;
 //
 procedure UpdateLocale;
 var
  l_LocaleKey: string;
 begin
  l_LocaleKey := ReplaceAliases('%(LocaleKey)');
  //
  if (l_LocaleKey <> '') then
   PutStringToRegistry(RegistryKeyToKey(l_LocaleKey), ReplaceAliases('%(LocalePath)'), ReplaceAliases('%(LocaleValueName)'), ReplaceAliases('%(LocaleValue)'));
 end;
 //
 procedure UpdateRegistry;
 var
  l_RegistryKey: string;
 begin
  l_RegistryKey := ReplaceAliases('%(RegistryKey)');
  //
  if (l_RegistryKey <> '') then
   PutStringToRegistry(RegistryKeyToKey(l_RegistryKey), ReplaceAliases('%(RegistryPath)'), ReplaceAliases('%(RegistryValueName)'), ReplaceAliases('%(RegistryValue)'));
 end;
 //
 procedure UpdateWhiteList;
  //
 var
  l_WhiteListKey: string;
  l_WhiteListValue: string;
 begin
  l_WhiteListKey := ReplaceAliases('%(WhiteListKey)');
  //
  if (l_WhiteListKey <> '') then
  begin
   l_WhiteListValue := ReplaceAliases('%(WhiteListValue)');
   //
   PutStringToRegistry(RegistryKeyToKey(l_WhiteListKey), ReplaceAliases('%(WhiteListPath)'), ReplaceAliases('%(WhiteListValueName)'), l_WhiteListValue);
  end;
 end;
 //
var
 l_LogoForm: TLogoForm;
begin
 a_Application.Title := a_ProductName; // real title
 l_LogoForm := TLogoForm.Create(nil);
 try
  l_LogoForm.UpdateLoadString(GetCurrentLocaleMessage(c_LogoLoading));
  l_LogoForm.Show;
  try
   Application.ProcessMessages;
   //
   g_CacheUpdateFailed := not(IsLocalCacheEnabled);
   //
   UnRegisterCOMServers;
   //
   RegisterCOMServers;
   RegisterURLProtocol;
   //
   g_CacheUpdateFailed := g_CacheUpdateFailed or not(FileExists(ReplaceAliases('$(CacheIniFileName)')));
   UpdateLocale;
   //
   CreateDesktopShortcuts;
   ForceCreateFolders;
   //
   UpdateLauncher;
   UpdateLocalCache;
   //
   HotFixesUpdate;
   UpdateEmulator;
   UpdateLocale;
   SynchronizeConsultingConfigs;
   UpdateWhiteList;
   //
   UpdateRegistry;
   RunConsultingChecker;
   //
   ExitCode := Integer(RunProcess(ReplaceAliases('%(Application)'), ReplaceAliases('%(CommandLine)'), ReplaceAliases('%(CurrentDirectory)'), IsWaitForExitParamExist, l_LogoForm));
  finally
   l_LogoForm.Hide;
  end;
 finally
  FreeAndNil(l_LogoForm);
 end;
end;

function RunProcess(const a_Application: string; const a_CommandLine: string; const a_CurrentDirectory: string; const a_WaitForExit: Boolean; a_LogoForm: TForm): DWORD;
 //
 function GetCreationFlags: DWORD;
 begin
  Result := DWORD(CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS);
 end;
 //
 function WaitForResult(const a_Process: THandle): DWORD;
 const
  c_WaitTime: DWORD = 250; // 0.25 of second
 begin
  Result := DWORD(STILL_ACTIVE);
  //
  try
   if a_WaitForExit then
    repeat
     if (WaitForSingleObject(a_Process, c_WaitTime) = WAIT_FAILED) then
      TerminateProcess(a_Process, WAIT_FAILED);
     //
     Application.ProcessMessages;
     Win32Check(GetExitCodeProcess(a_Process, Result));
    until (Result <> DWORD(STILL_ACTIVE))
   else
    Result := 0;
  finally
   CloseHandle(a_Process);
  end;
 end;
const
 ERROR_ELEVATION_REQUIRED = 740;
var
 l_Application: string;
 l_Commandline: string;
 //
 l_CacheRunThrough: string;
 //
 l_ProcessInformation: TProcessInformation;
 l_StartupInfo: TStartupInfo;
 //
 l_ShellExecuteInfo: TShellExecuteInfo;
 //
 l_RunSuccess: BOOL;
begin
 l_Application := Format('%s\%s', [a_CurrentDirectory, a_Application]);
 //
 if FileExists(l_Application) then
 begin
  Result := DWORD(STILL_ACTIVE);
  //
  l3FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
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
  if (g_UseCacheRunThrough) then
  begin
   l_CacheRunThrough := ReplaceAliases('$(CacheRunThrough)');
   //
   if ((l_CacheRunThrough <> '') and not FileExists(l_CacheRunThrough)) then
    l_CacheRunThrough := '';
   //
   if (l_CacheRunThrough <> '') then
    l_CommandLine := Format('%s %s', [QuoteStringIfNeed(l_CacheRunThrough), l_CommandLine]);
  end;
  //
  l_RunSuccess := CreateProcess(nil, PChar(l_CommandLine), nil, nil, False, GetCreationFlags, nil, PChar(a_CurrentDirectory), l_StartupInfo, l_ProcessInformation);
  if l_RunSuccess then
  begin
   if (a_LogoForm <> nil) then
   begin
    a_LogoForm.Hide;
    //
    Application.ProcessMessages;
   end;
   //
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
    l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), $00);
    //
    with l_ShellExecuteInfo do
    begin
     cbSize := SizeOf(l_ShellExecuteInfo);
     //
     fMask := SEE_MASK_CLASSNAME or SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
     lpVerb := 'runas';
     //
     if (l_CacheRunThrough <> '') then
     begin
      lpFile := PChar(l_CacheRunThrough);
      //
      l_CommandLine := QuoteStringIfNeed(l_Application);
      if (a_CommandLine <> '') then
       l_CommandLine := Format('%s %s', [l_CommandLine, a_CommandLine]);
      //
      lpParameters := PChar(l_CommandLine);
     end
     else
     begin
      lpFile := PChar(l_Application);
      lpParameters := PChar(a_CommandLine);
     end;
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
   raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonUnableStartProcess), [l_Application]));
 end
 else
  raise ELauncherError.Create(Format(GetCurrentLocaleMessage(c_CommonFileNotFound), [l_Application]));
end;

var
 l_Handle: THandle;
begin
 try
  OleCheck(CoInitialize(nil));
  try
   with Application do
    if (Handle <> HWND(0)) then
     SetWindowLong(Handle, GWL_EXSTYLE, GetWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
   //
   Application.Initialize;
   Application.Title := 'ГАРАНТ'; // Fake Title
   //
   l_Handle := CreateMutex(nil, False, '{A19C75CF-7C98-4815-BF10-5B41FA61C58D}');
   if (l_Handle <> THandle(0)) then
    try
     case WaitForSingleObject(l_Handle, INFINITE) of
      WAIT_ABANDONED,
      WAIT_OBJECT_0:
       try
        g_ReplaceInstallRoot := False;
        try
         RemapRegistry(GetLauncherRegistryKey, GetLauncherRegistryPath);
         // http://mdp.garant.ru/pages/viewpage.action?pageId=447391132
         SetLocaleApplicationTitle;
         RemapRegistry(RegistryKeyToKey(ReplaceAliases('%(RegistryKey)')), ReplaceAliases('%(RegistryPath)'));
         //
         SetCurrentLocale(ReplaceAliases('%(LocaleValue)'));
        finally
         g_ReplaceInstallRoot := True;
        end;
       finally
        Win32Check(ReleaseMutex(l_Handle));
       end;
      else
       Win32Check(False);
     end;
    finally
     CloseHandle(l_Handle);
    end
   else
    Win32Check(False);
   RunProcess(Application, ReplaceAliases('$(LocaleProductName)'));
  finally
   CoUninitialize;
  end;
 except
  on EAbort do ExitCode := -1;
  on E: ELauncherError do
   begin
    ErrorMessageBox(E.Message);
    //
    ExitCode := -2;
   end;
  on E: Exception do
   begin
    if (not nsReportError(E)) then
     ErrorMessageBox(Format(GetCurrentLocaleMessage(c_CommonUnexpectedException), [E.Message]));
    //
    ExitCode := -3;
   end;
 end;
end.

