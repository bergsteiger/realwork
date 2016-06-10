unit nsBrowserInfo;

interface
uses
  Classes, Windows;

type
 TnsBrowserType = (btNone, btChrome, btFirefox, btOpera, btIE, btEdge);

 TnsBrowserInfo = record
  rType    : TnsBrowserType;
  rExists  : Boolean;
  rVersion : Integer;
 end;

 TValidBrowserInfo = record
  rType: TnsBrowserType;
  rName: String;
  rMinVersion: Integer;
  rExeName: Boolean;
 end;


 function nsGetDefaultBrowserString: String;
 (* - возвращает строку с умолчательным браузером из реестра *)
 function nsGetBrowserType(const aBrowserStr: String): TnsBrowserType;
 (* - Возвращает тип браузера по строке с его именем  *)
 function nsIsValidBrowser(aBrowserType: TnsBrowserType; aCheckingDefault: Boolean = False): Boolean;
 (* - Валидирует браузер, установленный в системе, по его типу *)
 function nsIsValidDefaultBrowser: Boolean;
 
 function nsGetFirstValidBrowserExeName: String;
 (* - Возвращает имя exe-файла первого встреченного в системе браузера из белого списка *)
 function nsGetFirstValidBrowserInfo: TValidBrowserInfo;
 (* - Возвращает параметры первого встреченного в системе браузера из белого списка *)
 function nsGetBrowserInfo(aBrowserType: TnsBrowserType; aCheckingDefault: Boolean = False): TnsBrowserInfo;
 (* - Возвращает информацию о наличии и версии браузера по типу *)
 function nsLaunchBrowser(const aBrowserInfo: TValidBrowserInfo; const aUrl: String): Boolean;
 (* - Запустить браузер и открыть в нём урл *)

type
 ASSOCF = Integer;
 ASSOCSTR = Integer;

 TAssocQueryString = function(flags: ASSOCF; str: ASSOCSTR; pszAssoc: PChar;
   pszExtra: PChar; pszOut: PChar; var pcchOut: DWORD): HRESULT; stdcall;

const
  // ASSOCF enum
  ASSOCF_NONE                      = $00000000;
  ASSOCF_INIT_NOREMAPCLSID         = $00000001;
  ASSOCF_INIT_BYEXENAME            = $00000002;
  ASSOCF_OPEN_BYEXENAME            = $00000002;
  ASSOCF_INIT_DEFAULTTOSTAR        = $00000004;
  ASSOCF_INIT_DEFAULTTOFOLDER      = $00000008;
  ASSOCF_NOUSERSETTINGS            = $00000010;
  ASSOCF_NOTRUNCATE                = $00000020;
  ASSOCF_VERIFY                    = $00000040;
  ASSOCF_REMAPRUNDLL               = $00000080;
  ASSOCF_NOFIXUPS                  = $00000100;
  ASSOCF_IGNOREBASECLASS           = $00000200;
  ASSOCF_INIT_IGNOREUNKNOWN        = $00000400;
  ASSOCF_INIT_FIXED_PROGID         = $00000800;
  ASSOCF_IS_PROTOCOL               = $00001000;
  ASSOCF_INIT_FOR_FILE             = $00002000;

  //ASSOCSTR enum
  ASSOCSTR_COMMAND                 = 1;
  ASSOCSTR_EXECUTABLE              = 2;
  ASSOCSTR_FRIENDLYDOCNAME         = 3;
  ASSOCSTR_FRIENDLYAPPNAME         = 4;
  ASSOCSTR_NOOPEN                  = 5;
  ASSOCSTR_SHELLNEWVALUE           = 6;
  ASSOCSTR_DDECOMMAND              = 7;
  ASSOCSTR_DDEIFEXEC               = 8;
  ASSOCSTR_DDEAPPLICATION          = 9;
  ASSOCSTR_DDETOPIC                = 10;
  ASSOCSTR_INFOTIP                 = 11;
  ASSOCSTR_QUICKTIP                = 12;
  ASSOCSTR_TILEINFO                = 13;
  ASSOCSTR_CONTENTTYPE             = 14;
  ASSOCSTR_DEFAULTICON             = 15;
  ASSOCSTR_SHELLEXTENSION          = 16;
  ASSOCSTR_DROPTARGET              = 17;
  ASSOCSTR_DELEGATEEXECUTE         = 18;
  ASSOCSTR_SUPPORTED_URI_PROTOCOLS = 19;
  ASSOCSTR_PROGID                  = 20;
  ASSOCSTR_APPID                   = 21;
  ASSOCSTR_APPPUBLISHER            = 22;
  ASSOCSTR_APPICONREFERENCE        = 23;
  ASSOCSTR_MAX                     = 24;

var
 AssocQueryString: TAssocQueryString = nil; 

implementation

uses
 SysUtils,
 StrUtils,
 Registry,
 ShellApi,
 l3Base,
 l3WinVersionHelper,
 nsRegistryHelper;

const
 // Белый список бразуеров с учетом версий
 cValidBrowsersArr: array[0..7] of TValidBrowserInfo =
  ((rType: btChrome;  rName: 'chrome.exe';       rMinVersion: 33; rExeName: True),
   (rType: btChrome;  rName: 'Google Chrome';    rMinVersion: 33; rExeName: False),
   (rType: btFirefox; rName: 'firefox.exe';      rMinVersion: 29; rExeName: True),
   (rType: btOpera;   rName: 'opera.exe';        rMinVersion: 20; rExeName: True),
   (rType: btOpera;   rName: 'opera';            rMinVersion: 20; rExeName: False),
   (rType: btOpera;   rName: 'launcher.exe';     rMinVersion: 20; rExeName: True),
   (rType: btIE;      rName: 'iexplore.exe';     rMinVersion: 10; rExeName: True),
   (rType: btEdge;    rName: 'launchwinapp.exe'; rMinVersion: 1;  rExeName: True)
   );

function CallAssocStr(out aBrowserStr: String): boolean;
var
 l_PBrowser: PChar;
 l_BrowserStr: String;
 l_BrowserLen: DWORD;
begin
 l_PBrowser := nil;
 l_BrowserLen := 0;
 AssocQueryString(ASSOCF_NOTRUNCATE or ASSOCF_VERIFY or ASSOCF_IS_PROTOCOL,
  ASSOCSTR_EXECUTABLE, PChar('http'), PChar('open'), l_PBrowser, l_BrowserLen);

 SetLength(l_BrowserStr, l_BrowserLen);

 Result := Succeeded(AssocQueryString(ASSOCF_NOTRUNCATE or ASSOCF_VERIFY or ASSOCF_IS_PROTOCOL,
  ASSOCSTR_EXECUTABLE, PChar('http'), PChar('open'), PChar(l_BrowserStr), l_BrowserLen));
 aBrowserStr := PChar(l_BrowserStr);
end;


function nsValidateBrowser(const aBrowser: TnsBrowserInfo): Boolean; forward;

function nsClearBrowserString(const aString: String;
                             const aBrowserName: String): String;
var
 l_Str: String;
 l_FileName: String;
 l_Path: String;
 l_ExtPos: Integer;
begin
 if AnsiSameText(aString, aBrowserName) OR FileExists(aString) then
  Result := aString
 else
 begin
  l_Str := aString;
  l_FileName := ExtractFileName(l_Str);
  l_Path := ExtractFilePath(l_Str);
  l_ExtPos := Pos(UpperCase('.exe'), UpperCase(l_FileName));
  l_FileName := Trim(LeftStr(l_FileName, l_ExtPos + Length('.exe')));
  Result := AnsiDequotedStr(Format('%s%s', [l_Path, l_FileName]), '"');
 end;
end;
                          
function nsExtractVersionMajor(const aVersionString: String): Integer;
var
 l_VersionString: String;
 l_DotPos: Integer;
begin
 Result := 0;
 l_VersionString := aVersionString;
 l_DotPos := Pos('.', l_VersionString);
 if (l_DotPos <> 0) then
  Delete(l_VersionString, l_DotPos, Length(l_VersionString) - Pred(l_DotPos));
 TryStrToInt(l_VersionString, Result);
end;

function nsGetProductVersionMajor(const AFileName: string): Cardinal;
var
 l_FileName: string;
 l_InfoSize: DWORD;
 l_Wnd: DWORD;
 l_VerBuf: Pointer;
 l_FI: PVSFixedFileInfo;
 l_VerSize: DWORD;
begin
 Result := Cardinal(-1);
 l_FileName := AFileName;
 UniqueString(l_FileName);
 l_InfoSize := GetFileVersionInfoSize(PChar(l_FileName), l_Wnd);
 if (l_InfoSize <> 0) then
 begin
  GetMem(l_VerBuf, l_InfoSize);
  try
   if GetFileVersionInfo(PChar(l_FileName), l_Wnd, l_InfoSize, l_VerBuf) then
    if VerQueryValue(l_VerBuf, '\', Pointer(l_FI), l_VerSize) then
     Result := HiWord(l_FI.dwProductVersionMS);
  finally
   FreeMem(l_VerBuf);
  end;
 end;
end;

function nsCheckFirefox(ARegistry: TRegistry): TnsBrowserInfo;
const
 cFirefoxRegistryKey = 'SOFTWARE\Mozilla\Mozilla Firefox';
 cFirefoxRegistryKeyBinMask = 'SOFTWARE\Mozilla\Mozilla Firefox\%s\bin';
 cFirefoxRegistryKeyMainMask = 'SOFTWARE\Mozilla\Mozilla Firefox\%s\Main';
 cFirefoxVersionValueName = 'CurrentVersion';
 cFirefoxPathValueName = 'PathToExe';
 cFireFoxExeName = 'firefox.exe';

 function lp_GetFirefoxPath(aRoot: DWORD): String;
 var
  l_Str: String;
  l_Key: String;
 begin
  Result := '';
  l_Str := '';
  ARegistry.RootKey := aRoot;
  if ARegistry.OpenKeyReadOnly(cFirefoxRegistryKey) then
  begin
   l_Str := ARegistry.ReadString(cFirefoxVersionValueName);
   ARegistry.CloseKey;
   l_Key := Format(cFirefoxRegistryKeyBinMask, [l_Str]);
   // - ищем в SOFTWARE\Mozilla\Mozilla Firefox\<версия>\bin
   if ARegistry.OpenKeyReadOnly(l_Key) then
    Result := ARegistry.ReadString(cFirefoxPathValueName);
   ARegistry.CloseKey;
   if (Result = '') then
   begin
    l_Key := Format(cFirefoxRegistryKeyMainMask, [l_Str]);
    // - ищем в SOFTWARE\Mozilla\Mozilla Firefox\<версия>\Main
    if ARegistry.OpenKeyReadOnly(l_Key) then
    begin
     Result := ARegistry.ReadString(cFirefoxPathValueName);
     ARegistry.CloseKey;     
    end;
   end;
  end;
 end;//lp_GetFirefoxPath

var
 l_Path: String;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 Result.rType := btFirefox;
 
 l_Path := lp_GetFirefoxPath(HKEY_CURRENT_USER);
 if (l_Path = '') then
  l_Path := lp_GetFirefoxPath(HKEY_LOCAL_MACHINE);
  
 if (l_Path <> '') then
 begin
  l_Path := nsClearBrowserString(l_Path, cFireFoxExeName);
  if FileExists(l_Path) then
  begin
   Result.rExists := True;
   Result.rVersion := nsGetProductVersionMajor(l_Path);
  end;
 end;
end;

function nsCheckOpera(ARegistry: TRegistry; aCheckingDefault: Boolean): TnsBrowserInfo;
const
 cOperaExeName = 'Opera.exe';
 cOperaLauncherExeName = 'launcher.exe';

 function lp_MakeOperaInfo(const APath: String): TnsBrowserInfo;
 var
  l_Path: String;
  l_ExeName: String;
 begin
  l3FillChar(Result, SizeOf(Result), 0);
  Result.rType := btOpera;
  if AnsiContainsText(APath, cOperaExeName) then
   l_ExeName := cOperaExeName
  else
  if AnsiContainsText(APath, cOperaLauncherExeName) then
   l_ExeName := cOperaLauncherExeName;
  l_Path := nsClearBrowserString(APath, l_ExeName);
  if FileExists(l_Path) then
  begin
   Result.rExists := True;
   Result.rVersion := nsGetProductVersionMajor(l_Path);
  end;
 end;

const
 cOperaRegistryKey = 'SOFTWARE\Opera Software';
 cOperaPathValueName = 'Last CommandLine v2';
var
 l_Path: String;
begin
 l_Path := '';
 l3FillChar(Result, SizeOf(Result), 0);
 Result.rType := btOpera;
 ARegistry.RootKey := HKEY_LOCAL_MACHINE;
 if ARegistry.KeyExists(cOperaRegistryKey) and
    ARegistry.OpenKeyReadOnly(cOperaRegistryKey) then
 begin
  l_Path := ARegistry.ReadString(cOperaPathValueName);
  ARegistry.CloseKey;
 end;
 if (l_Path = '') then
 begin
  ARegistry.RootKey := HKEY_CURRENT_USER;
  if ARegistry.KeyExists(cOperaRegistryKey) and
     ARegistry.OpenKeyReadOnly(cOperaRegistryKey) then
  begin
   l_Path := ARegistry.ReadString(cOperaPathValueName);
   ARegistry.CloseKey;
  end;
 end;
 if (l_Path <> '') then
  Result := lp_MakeOperaInfo(l_Path);
 if aCheckingDefault AND AnsiContainsText(l_Path, nsGetDefaultBrowserString) then
  Exit;
 // Все, что было сверху - для новых "Опер" не работает.
 // Поэтому - заточка для новой "Оперы", которая в реестр пишет "launcher.exe":
 if (not Result.rExists) OR
    (not nsValidateBrowser(Result)) then
 begin
  l_Path := '';
  ARegistry.RootKey := HKEY_LOCAL_MACHINE;
  if ARegistry.KeyExists('Applications\Opera.exe\Shell\Open\Command') AND
     ARegistry.OpenKeyReadOnly('Applications\Opera.exe\Shell\Open\Command') then
  begin
   l_Path := ARegistry.ReadString('');
   ARegistry.CloseKey;
  end;
  if (l_Path = '') then
  begin
   ARegistry.RootKey := HKEY_LOCAL_MACHINE;
   if ARegistry.KeyExists('\Software\Clients\StartMenuInternet\Opera\Shell\Open\Command') AND
      ARegistry.OpenKeyReadOnly('\Software\Clients\StartMenuInternet\Opera\Shell\Open\Command') then
   begin
    l_Path := ARegistry.ReadString('');
    ARegistry.CloseKey;
   end;
   Result := lp_MakeOperaInfo(l_Path);
   if aCheckingDefault AND AnsiContainsText(l_Path, nsGetDefaultBrowserString) then
    Exit;
   // могли ничего не найти - от старой "Оперы" после обновления остаются в реестре
   // ошметки с несуществующими путями и файлами, а могли найти старый exe-шник
   if (not Result.rExists) OR
      (not nsValidateBrowser(Result)) then
    // Заточка для новой "Оперы", установленной поверх старой, когда новая
    // складывается в отдельную папку внутри основной папки "Оперы"
    if ARegistry.KeyExists('\Software\Clients\StartMenuInternet\OperaStable\Shell\Open\Command') AND
       ARegistry.OpenKeyReadOnly('\Software\Clients\StartMenuInternet\OperaStable\Shell\Open\Command') then
    begin
     l_Path := ARegistry.ReadString('');
     ARegistry.CloseKey;
    end;
  end;
  Result := lp_MakeOperaInfo(l_Path);
  if aCheckingDefault AND AnsiContainsText(l_Path, nsGetDefaultBrowserString) then
   Exit;
  // и так - тоже могли ничего не найти
  if (not Result.rExists) OR
     (not nsValidateBrowser(Result)) then
  begin
   ARegistry.RootKey := HKEY_LOCAL_MACHINE;
   if ARegistry.KeyExists('\Software\Classes\Opera\Shell\Open\Command') AND
      ARegistry.OpenKeyReadOnly('\Software\Classes\Opera\Shell\Open\Command') then
   begin
    l_Path := ARegistry.ReadString('');
    ARegistry.CloseKey;
   end
   else
   if ARegistry.KeyExists('\Software\Classes\Opera.HTML\Shell\Open\Command') AND
      ARegistry.OpenKeyReadOnly('\Software\Classes\Opera.HTML\Shell\Open\Command') then
   begin
    l_Path := ARegistry.ReadString('');
    ARegistry.CloseKey;
   end
   else
   if ARegistry.KeyExists('\Software\Classes\OperaStable\Shell\Open\Command') AND
      ARegistry.OpenKeyReadOnly('\Software\Classes\OperaStable\Shell\Open\Command') then
   begin
    l_Path := ARegistry.ReadString('');
    ARegistry.CloseKey;
   end;
   Result := lp_MakeOperaInfo(l_Path);
  end;
 end;
end;

function nsCheckChrome(ARegistry: TRegistry): TnsBrowserInfo;

 function lp_DoCheckChrome(aRootKey: DWORD; out aBrowserInfo: TnsBrowserInfo): Boolean;
 const
  cChromeRegistryKey = '\Software\Google\Update\Clients\{8A69D345-D564-463c-AFF1-A69D9E530F96}';
  cChromeVersionValueName = 'pv';
 var
  l_VersionStr: String;
  l_Version: Integer;
 begin
  l3FillChar(aBrowserInfo, SizeOf(aBrowserInfo), 0);
  aBrowserInfo.rType := btChrome;
  l_Version := 0;
  Result := False;
  ARegistry.RootKey := aRootKey;
  if ARegistry.KeyExists(cChromeRegistryKey) and
     ARegistry.OpenKeyReadOnly(cChromeRegistryKey) then
  begin
   l_VersionStr := ARegistry.ReadString(cChromeVersionValueName);
   l_Version := nsExtractVersionMajor(l_VersionStr);
   if (l_Version <> 0) then
   begin
    Result := True;
    aBrowserInfo.rExists := True;
    aBrowserInfo.rVersion := l_Version;
   end;
  end;
 end;//lp_DoCheckChrome

var
 l_VersionStr: String;
 l_Version: Integer;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 if (not lp_DoCheckChrome(HKEY_LOCAL_MACHINE, Result)) then
  lp_DoCheckChrome(HKEY_CURRENT_USER, Result);
 // - http://mdp.garant.ru/pages/viewpage.action?pageId=564264353
end;

function nsCheckIE(ARegistry: TRegistry): TnsBrowserInfo;
const
 cIERegistryKey = '\Software\Microsoft\Internet Explorer';
 cIEVersionValueName = 'svcVersion';
 // -http://mdp.garant.ru/pages/viewpage.action?pageId=564249113,
 // http://support.microsoft.com/kb/969393/ru
 cIEStartMenuKeyName = 'SOFTWARE\Microsoft\Internet Explorer\Capabilities\Startmenu';
 cIEStartMenuValueName = 'StartmenuInternet';

 function lp_IsIEEnabled: Boolean;
 begin
  ARegistry.RootKey := HKEY_LOCAL_MACHINE;
  if ARegistry.KeyExists(cIEStartMenuKeyName) and
    ARegistry.OpenKeyReadOnly(cIEStartMenuKeyName) then
    Result := (ARegistry.ReadString(cIEStartMenuValueName) <> '')
  else
   Result := False;
 end;

var
 l_Browser: String;
 l_VersionStr: String;
 l_Version: Integer;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 Result.rType := btIE;

 if Tl3WinVersionHelper.IsWindows10OrGreater then
 begin
  if CallAssocStr(l_Browser) then
   if FileExists(l_Browser) and
      (AnsiSameText(ExtractFileName(l_Browser), 'iexplore.exe')) then
   begin
    Result.rExists := True;
    Result.rVersion := nsGetProductVersionMajor(l_Browser);
    Exit;
   end;
  ARegistry.RootKey := HKEY_CURRENT_USER;
 end
 else
  ARegistry.RootKey := HKEY_LOCAL_MACHINE;

 if ARegistry.KeyExists(cIERegistryKey) and
    ARegistry.OpenKeyReadOnly(cIERegistryKey) then
 begin
  l_VersionStr := ARegistry.ReadString(cIEVersionValueName);
  ARegistry.CloseKey;
  l_Version := nsExtractVersionMajor(l_VersionStr);
  if (l_Version <> 0) then
  begin
   Result.rExists := lp_IsIEEnabled;
   Result.rVersion := l_Version;
  end;
 end;
end;

function nsCheckEdge(ARegistry: TRegistry): TnsBrowserInfo;
const
 cAppPackagesKey = 'Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages';
 cEdgeMask = 'Microsoft.MicrosoftEdge';
var
 l_Enum: InsRegistryKeyEnumerator;
 l_Name: String;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 Result.rType := btEdge;
 l_Enum := TnsRegistryHelper.KeyEnumerator(HKEY_CURRENT_USER, cAppPackagesKey);
 while l_Enum.MoveNext do
 begin
  l_Name := l_Enum.Name;
  if AnsiContainsText(l_Enum.Name, cEdgeMask) then
  begin
    Result.rExists := True;
    Result.rVersion := 1; // Ну пока хоть так - всё равно никакой версии нам не дадут
    Break;
  end;
 end;
end;

function nsValidateBrowser(const aBrowser: TnsBrowserInfo): Boolean;
var
 l_Index: Integer;
 l_BrowserRequirements: TValidBrowserInfo;
begin
 Result := False;
 for l_Index := Low(cValidBrowsersArr) to High(cValidBrowsersArr) do
 begin
  l_BrowserRequirements := cValidBrowsersArr[l_Index];
  if (aBrowser.rType = l_BrowserRequirements.rType) then
  begin
   Result := aBrowser.rExists AND
             (aBrowser.rVersion >= l_BrowserRequirements.rMinVersion);
   if Result then
    Break;
  end;
 end;
end;

function nsGetDefaultBrowserString: String;
var
 l_Reg: TRegistry;
 l_Browser: String;
begin
 l_Reg := TRegistry.Create;
 l_Reg.RootKey := HKEY_CURRENT_USER;
 l_Browser := '';
 try
  if not Tl3WinVersionHelper.IsWindows7OrGreater then
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=620665143
  begin
   if l_Reg.KeyExists('\Software\Classes\http\shell\open\command') and
    l_Reg.OpenKeyReadOnly('\Software\Classes\http\shell\open\command') then
   begin
    l_Browser := l_Reg.ReadString('');
    l_Reg.CloseKey;
   end;
  end
  else
  begin
   if not CallAssocStr(l_Browser) then
   begin
    l_Reg.RootKey := HKEY_LOCAL_MACHINE;
    if l_Reg.KeyExists('\Software\Clients\StartMenuInternet') and
     l_Reg.OpenKeyReadOnly('\Software\Clients\StartMenuInternet') then
    begin
     l_Browser := l_Reg.ReadString('');
     l_Reg.CloseKey;
    end
    else
     l_Browser := '';
    if l_Browser = '' then
    begin
     l_Reg.RootKey := HKEY_LOCAL_MACHINE;
     if l_Reg.KeyExists('\Software\Clients\StartMenuInternet') and
      l_Reg.OpenKeyReadOnly('\Software\Clients\StartMenuInternet') then
     begin
      l_Browser := l_Reg.ReadString('');
      l_Reg.CloseKey;
     end;
    end;
   end;
  end; //if XP--;
  Result := PChar(l_Browser);
 finally
  l_Reg.Free;
 end;
end;


function nsGetBrowserType(const aBrowserStr: String): TnsBrowserType;
var
 l_Index: Integer;
begin
 Result := btNone;
 for l_Index := Low(cValidBrowsersArr) to High(cValidBrowsersArr) do
  if AnsiContainsText(aBrowserStr, cValidBrowsersArr[l_Index].rName) then
  begin
   Result := cValidBrowsersArr[l_Index].rType;
   Break;
  end;
end;

function nsGetBrowserInfo(aBrowserType: TnsBrowserType; aCheckingDefault: Boolean): TnsBrowserInfo;
var
 l_Reg: TRegistry;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 l_Reg := TRegistry.Create;
 try
  case aBrowserType of
   btChrome:
    Result := nsCheckChrome(l_Reg);
   btFirefox:
    Result := nsCheckFirefox(l_Reg);
   btOpera:
    Result := nsCheckOpera(l_Reg, aCheckingDefault);
   btIE:
    Result := nsCheckIE(l_Reg);
   btEdge:
    Result := nsCheckEdge(l_Reg);
  end;
 finally
  FreeAndNil(l_Reg);
 end;
end;

function nsLaunchBrowser(const aBrowserInfo: TValidBrowserInfo; const aUrl: String): Boolean;
var
 l_ShellExecuteInfo: {$IfDef XE}TShellExecuteInfoA{$Else}TShellExecuteInfo{$EndIf};
 l_BrowserCommand: String;
 l_Parameters: String;
begin
 if (aBrowserInfo.rType = btEdge) then
 begin
  l_BrowserCommand := Format('microsoft-edge:%s', [aUrl]);
  l_Parameters := '';
 end
 else
 begin
  l_BrowserCommand := aBrowserInfo.rName;
  l_Parameters := aUrl;
 end;
 l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), 0);
 with l_ShellExecuteInfo do
 begin
  cbSize := SizeOf(l_ShellExecuteInfo);
  lpVerb := 'open';
  lpFile := PChar(l_BrowserCommand);
  // - http://mdp.garant.ru/pages/viewpage.action?pageId=563197648
  lpParameters := PChar(l_Parameters);
  nShow := SW_SHOWNORMAL;
 end;//with l_ShellExecuteInfo
 Result := ShellExecuteExA(@l_ShellExecuteInfo); 
end;

function nsIsValidBrowser(aBrowserType: TnsBrowserType; aCheckingDefault: Boolean = False): Boolean;
begin
 Result := nsValidateBrowser(nsGetBrowserInfo(aBrowserType, aCheckingDefault));
end;

function nsIsValidDefaultBrowser: Boolean;
begin
 Result := nsIsValidBrowser(nsGetBrowserType(nsGetDefaultBrowserString), True);
end;

function nsGetFirstValidBrowserExeName: String;
begin
 Result := nsGetFirstValidBrowserInfo.rName;
end;

function nsGetFirstValidBrowserInfo: TValidBrowserInfo;
var
 l_Index: Integer;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 for l_Index := Low(cValidBrowsersArr) to High(cValidBrowsersArr) do
  if cValidBrowsersArr[l_Index].rExeName AND
     nsIsValidBrowser(cValidBrowsersArr[l_Index].rType) then
  begin
   Result := cValidBrowsersArr[l_Index];
   Break;
  end;
end;

var
  g_ShlwapiModule: HMODULE;

initialization
  g_ShlwapiModule := LoadLibrary(PChar('Shlwapi.dll'));
  AssocQueryString := GetProcAddress(g_ShlwapiModule, PChar('AssocQueryStringA'));
finalization
  FreeLibrary(g_ShlwapiModule);

end.
