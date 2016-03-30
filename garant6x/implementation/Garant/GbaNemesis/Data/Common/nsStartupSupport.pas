unit nsStartupSupport;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\nsStartupSupport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsStartupSupport" MUID: (55B26A1C0277)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , Windows
 , SyncObjs
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , Classes
 , Messages
;

type
 TnsStartupSupport = class(TvcmCacheableBase)
  private
   f_CheckRunTimer: TTimer;
   f_DataInstallerCommandLine: AnsiString;
   f_DataUpdaterCommandLine: AnsiString;
   f_DownloaderCommandLine: AnsiString;
   f_DataInstallerProcessHandle: THandle;
   f_DataUpdaterProcessHandle: THandle;
   f_DownloaderProcessHandle: THandle;
   f_StartupSupportWindow: THandle;
   f_LoginLockCount: Integer;
  private
   class function UniqueClassName: AnsiString;
   class function ShowActiveFormMessage: LongWord;
   class function UnlockLoginMessage: LongWord;
   class function GetAppHandleMessage: LongWord;
   class function OpenByNumberMessage: LongWord;
   class function RunDataInstallerMessage: LongWord;
   class function RunDataUpdaterMessage: LongWord;
   class function RunDownloaderMessage: LongWord;
   class function TrySendMessage(const aClassName: AnsiString;
    aMessage: LongWord;
    aCopyDataBuffer: Pointer = nil;
    aCopyDataBufferLength: Integer = 0): Boolean;
   class function IsParamStrExist(const aParamStr: AnsiString): Boolean;
   class function QuoteStringIfNeed(const aString: AnsiString): AnsiString;
   class function GetCommandLine: AnsiString;
   class function GetDataInstallerCommandLine: AnsiString;
   class function GetDataUpdaterCommandLine: AnsiString;
   class function GetDownloaderCommandLine: AnsiString;
   class function GetDataInstallerMutexName: AnsiString;
   class function GetDataUpdaterMutexName: AnsiString;
   class function GetDownloaderMutexName: AnsiString;
   class function GetPrimeRunningCopyMutexName: AnsiString;
   class function GetShellRunningCopyMutexName: AnsiString;
   class function GetAdminRunningCopyMutexName: AnsiString;
   class function GetShutdownEventName: AnsiString;
   class function GetStartupMutexName: AnsiString;
   class function IsCopyRunning(var aMutexHandle: THandle;
    var aMutexHoldCount: Integer;
    const aMutexName: AnsiString): Boolean;
   class procedure InitMutex(var aMutexHandle: THandle;
    var aMutexHoldCount: Integer;
    const aMutexName: AnsiString;
    aResult: PBoolean = nil);
   class procedure DoneMutex(var aMutexHandle: THandle;
    var aMutexHoldCount: Integer);
   class procedure InitEvent(var aEventHandle: THandle;
    var aEventOpenCount: Integer;
    const aEventName: AnsiString);
   class procedure DoneEvent(var aEventHandle: THandle;
    var aEventOpenCount: Integer);
   class procedure WaitEvent(const aEventName: AnsiString;
    var aMutexHandle: THandle;
    var aMutexHoldCount: Integer;
    const aMutexName: AnsiString);
   class procedure WaitWhileMutexNotExist(const aMutexName: AnsiString);
   function AllocateHWnd(aWndMethod: TWndMethod): THandle;
   procedure DeallocateHWnd(var aHWnd: THandle);
   procedure WndProc(var aMessage: TMessage);
   procedure LockLogin;
   procedure UnlockLogin;
   function IsLoginLocked: Boolean;
   function ShowActiveForm: Boolean;
   procedure RunProcess(const aProcessName: AnsiString;
    const aCommandLine: AnsiString;
    var aProcessHandle: THandle);
   function IsProcessRunning(aProcessHandle: THandle): Boolean;
   function WaitWhileProcessIsRunning(aHardWait: Boolean;
    aIsProcessRunning: Boolean;
    var aProcessHandle: THandle): Boolean;
   procedure RunDataInstallerProcess(const aCommandLine: AnsiString);
   function IsDataInstallerProcessRunning: Boolean;
   function WaitWhileDataInstallerProcessIsRunning(aHardWait: Boolean): Boolean;
   procedure RunDataUpdaterProcess(const aCommandLine: AnsiString);
   function IsDataUpdaterProcessRunning: Boolean;
   function WaitWhileDataUpdaterProcessIsRunning(aHardWait: Boolean): Boolean;
   procedure RunDownloaderProcess(const aCommandLine: AnsiString);
   function IsDownloaderProcessRunning: Boolean;
   function WaitWhileDownloaderProcessIsRunning(aHardWait: Boolean): Boolean;
   procedure OnTimer(Sender: TObject);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   constructor Create; reintroduce;
   class procedure DestroyInstance;
   class function IsRunDataInstallerParamExist: Boolean;
   class function IsRunDataUpdaterParamExist: Boolean;
   class function IsRunDownloaderParamExist: Boolean;
   class function IsRunParamExist: Boolean;
   class function IsSilentRunAndExitParamExist: Boolean;
   class function IsEqualCopyRunning: Boolean;
   class function IsPrimeCopyRunning: Boolean;
   class function IsShellCopyRunning: Boolean;
   class function IsAdminCopyRunning: Boolean;
   class function TryUnlockLogin: Boolean;
   class procedure TrySendOpenByNumer;
   class function TryRunDataInstaller: Boolean;
   class function TryRunDataUpdater: Boolean;
   class function TryRunDownloader: Boolean;
   class function TrySwitchToOtherRunningCopy: Boolean;
   class function CheckAndCreatePrimeRunningCopyMutex: Boolean;
   class procedure CreatePrimeRunningCopyMutex;
   class procedure ReleasePrimeRunningCopyMutex;
   class function CheckAndCreateShellRunningCopyMutex: Boolean;
   class procedure CreateShellRunningCopyMutex;
   class procedure ReleaseShellRunningCopyMutex;
   class function CheckAndCreateAdminRunningCopyMutex: Boolean;
   class procedure CreateAdminRunningCopyMutex;
   class procedure ReleaseAdminRunningCopyMutex;
   class function CheckAndCreateRunningCopyMutex: Boolean;
   class procedure CreateRunningCopyMutex;
   class procedure ReleaseRunningCopyMutex;
   class procedure ShutdownPendingNotify;
   class procedure ShutdownCompletedNotify;
   class procedure StartupPendingNotify;
   class procedure StartupCompletedNotify;
   class procedure WaitForDataInstallerExit;
   class procedure WaitForDataUpdaterExit;
   class procedure WaitForDownloaderExit;
   function CheckAndRunSupportProcessesIfNeed: Boolean;
   procedure TryActivateMainForm;
   class function Instance: TnsStartupSupport;
    {* Метод получения экземпляра синглетона TnsStartupSupport }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TnsStartupSupport

function nsIsOtherPrimeOrShellRunning(aTopForm: TCustomForm): Boolean;
procedure nsCheckRequiredFonts(aTopForm: TCustomForm);

implementation

uses
 l3ImplUses
 , SysUtils
 , ShellAPI
 , l3Types
 , l3FontManager
 , l3Interlocked
 , afwFacade
 , nsUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , l3Base
;

var g_TnsStartupSupport: TnsStartupSupport = nil;
 {* Экземпляр синглетона TnsStartupSupport }
var g_DataInstallerMutexHandle: THandle = THandle(INVALID_HANDLE_VALUE);
var g_DataInstallerMutexHoldCount: Integer = 0;
var g_DataUpdaterMutexHandle: THandle = THandle(INVALID_HANDLE_VALUE);
var g_DataUpdaterMutexHoldCount: Integer = 0;
var g_DownloaderMutexHandle: THandle = THandle(INVALID_HANDLE_VALUE);
var g_DownloaderMutexHoldCount: Integer = 0;
var g_StartupSupportMutexHandle: THandle = THandle(INVALID_HANDLE_VALUE);
var g_StartupSupportMutexHoldCount: Integer = 0;
var g_PrimeRunningCopyMutexHandle: THandle = THandle(INVALID_HANDLE_VALUE);
var g_PrimeRunningCopyMutexHoldCount: Integer = 0;
var g_ShellRunningCopyMutexHandle: THandle = THandle(INVALID_HANDLE_VALUE);
var g_ShellRunningCopyMutexHoldCount: Integer = 0;
var g_AdminRunningCopyMutexHandle: THandle = THandle(INVALID_HANDLE_VALUE);
var g_AdminRunningCopyMutexHoldCount: Integer = 0;
var g_StartupMutex: THandle = THandle(INVALID_HANDLE_VALUE);
var g_StartupMutexHoldCount: Integer = 0;
var g_ShutdownEvent: THandle = THandle(INVALID_HANDLE_VALUE);
var g_ShutdownEventOpenCount: Integer = 0;
var g_ShowActiveFormMessage: LongWord = 0;
var g_UnlockLoginMessage: LongWord = 0;
var g_OpenByNumberMessage: LongWord = 0;
var g_RunDataInstallerMessage: LongWord = 0;
var g_RunDataUpdaterMessage: LongWord = 0;
var g_RunDownloaderMessage: LongWord = 0;
var g_GetAppHandleMessage: LongWord = 0;
var g_CriticalSection: TCriticalSection = nil;

const
 c_RunDataInstallerParamStr = '-RunDataInstaller';
 c_DataInstallerProcessName = 'F1DataSetup.run';
 c_DataInstallerDefaultCommandLine = 'C:\\';
 c_RunDataUpdaterParamStr = '-RunDataUpdater';
 c_DataUpdaterProcessName = 'F1DataUpd.run';
 c_DataUpdaterDefaultCommandLine = '';
 c_RunDownloaderParamStr = '-RunDownloader';
 c_DownloaderProcessName = 'F1Download.run';
 c_DownloaderDefaultCommandLine = '';
 c_SilentRunAndExitParamStr = '-SilentRunAndExit';
 c_ShowActiveFormMessageName = '{2A2BF3E9-EE0F-4F30-A698-9EF166EC51CB}';
 c_UnlockLoginMessageName = '{461CFCA5-CFCE-4FB4-B56C-192C6FA96201}';
 c_OpenByNumberMessageName = '{0DD3BAF8-2DCE-47B7-ABF2-1373BB590016}';
 c_RunDataInstallerMessageName = '{465AA2E3-DD43-429F-AE3C-DEE2F89749B7}';
 c_RunDataUpdaterMessageName = '{EC86497D-E85F-472A-A444-379B230D1BC5}';
 c_RunDownloaderMessageName = '{8DFDDB6A-C46A-4F9B-8F1B-82A305BBC3B0}';
 c_GetAppHandleMessageName = '{90F2FE9B-2BE0-4BA1-9779-447B716884BD}';
 c_SleepTime = 250;

procedure TnsStartupSupportFree;
 {* Метод освобождения экземпляра синглетона TnsStartupSupport }
begin
 l3Free(g_TnsStartupSupport);
end;//TnsStartupSupportFree

function nsIsOtherPrimeOrShellRunning(aTopForm: TCustomForm): Boolean;
//#UC START# *55B26D620046_55B26A1C0277_var*
//#UC END# *55B26D620046_55B26A1C0277_var*
begin
//#UC START# *55B26D620046_55B26A1C0277_impl*
 Result := False;
 //
 if (aTopForm <> nil) then
 begin
  aTopForm.Hide;
  afw.ProcessMessages;
 end;
 //
 try
  with TnsStartupSupport do
  begin
{$IFDEF Monitorings}
   if (IsShellCopyRunning) then
   begin
    vcmSay(err_ShellIsRunning);
    Result := True;
   end;
   if (IsAdminCopyRunning) then
   begin
    vcmSay(err_AdminIsRunningForPrime);
    Result := True;
   end;
{$ELSEIF defined(Admin)}
   if (IsShellCopyRunning) then
   begin
    vcmSay(err_ShellIsRunningForAdmin);
    Result := True;
   end;
   if (IsPrimeCopyRunning) then
   begin
    vcmSay(err_PrimeIsRunningForAdmin);
    Result := True;
   end;
{$ELSE  Monitorings}
   if (IsPrimeCopyRunning) then
   begin
    vcmSay(err_PrimeIsRunning);
    Result := True;
   end;
   if (IsAdminCopyRunning) then
   begin
    vcmSay(err_AdminIsRunningForShell);
    Result := True;
   end;
{$IFEND Monitorings}
  end;
 finally
  if (aTopForm <> nil) then
  begin
   aTopForm.Show;
   afw.ProcessMessages;
  end;
 end;
//#UC END# *55B26D620046_55B26A1C0277_impl*
end;//nsIsOtherPrimeOrShellRunning

procedure nsCheckRequiredFonts(aTopForm: TCustomForm);
//#UC START# *55B26D77039C_55B26A1C0277_var*
var
 l_ArialNotExist: Boolean;
 l_CourierNewNotExist: Boolean;
 //
 function Iterator(aFont: PObject; aIndex: Long): Boolean;
 begin
  Result := True;
  //
  with Tl3LogFont(aFont^).LogFont.elfLogFont do
   if (StrIComp(@lfFaceName, PChar('Arial')) = 0) then
    l_ArialNotExist := False
   else
    if (StrIComp(@lfFaceName, PChar('Courier New')) = 0) then
     l_CourierNewNotExist := False;
 end;
 //
//#UC END# *55B26D77039C_55B26A1C0277_var*
begin
//#UC START# *55B26D77039C_55B26A1C0277_impl*
 l_ArialNotExist := True;
 l_CourierNewNotExist := True;
 //
 with Fonts do
  IterateAllF(l3L2IA(@Iterator));
 //
 if (l_ArialNotExist or l_CourierNewNotExist) then
 begin
  if (aTopForm <> nil) then
  begin
   aTopForm.Hide;
   afw.ProcessMessages;
  end;
  try
   vcmSay(war_RequiredFontsNotExist);
  finally
   if (aTopForm <> nil) then
   begin
    aTopForm.Show;
    afw.ProcessMessages;
   end;
  end;
 end;
//#UC END# *55B26D77039C_55B26A1C0277_impl*
end;//nsCheckRequiredFonts

class function TnsStartupSupport.UniqueClassName: AnsiString;
//#UC START# *55B25BCC01C6_4AA7C26401C4_var*
//#UC END# *55B25BCC01C6_4AA7C26401C4_var*
begin
//#UC START# *55B25BCC01C6_4AA7C26401C4_impl*
 Result := Format('%s:{65591D5E-77E5-4699-BF40-E7B1FB186037}', [ClassName]);
//#UC END# *55B25BCC01C6_4AA7C26401C4_impl*
end;//TnsStartupSupport.UniqueClassName

class function TnsStartupSupport.ShowActiveFormMessage: LongWord;
//#UC START# *55B25BEE03C3_4AA7C26401C4_var*
//#UC END# *55B25BEE03C3_4AA7C26401C4_var*
begin
//#UC START# *55B25BEE03C3_4AA7C26401C4_impl*
 Result := g_ShowActiveFormMessage;
//#UC END# *55B25BEE03C3_4AA7C26401C4_impl*
end;//TnsStartupSupport.ShowActiveFormMessage

class function TnsStartupSupport.UnlockLoginMessage: LongWord;
//#UC START# *55B25C1B03A1_4AA7C26401C4_var*
//#UC END# *55B25C1B03A1_4AA7C26401C4_var*
begin
//#UC START# *55B25C1B03A1_4AA7C26401C4_impl*
 Result := g_UnlockLoginMessage;
//#UC END# *55B25C1B03A1_4AA7C26401C4_impl*
end;//TnsStartupSupport.UnlockLoginMessage

class function TnsStartupSupport.GetAppHandleMessage: LongWord;
//#UC START# *55B25C3A016E_4AA7C26401C4_var*
//#UC END# *55B25C3A016E_4AA7C26401C4_var*
begin
//#UC START# *55B25C3A016E_4AA7C26401C4_impl*
 Result := g_GetAppHandleMessage;
//#UC END# *55B25C3A016E_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetAppHandleMessage

class function TnsStartupSupport.OpenByNumberMessage: LongWord;
//#UC START# *55B25C5302A7_4AA7C26401C4_var*
//#UC END# *55B25C5302A7_4AA7C26401C4_var*
begin
//#UC START# *55B25C5302A7_4AA7C26401C4_impl*
 Result := g_OpenByNumberMessage;
//#UC END# *55B25C5302A7_4AA7C26401C4_impl*
end;//TnsStartupSupport.OpenByNumberMessage

class function TnsStartupSupport.RunDataInstallerMessage: LongWord;
//#UC START# *55B25C7D01F1_4AA7C26401C4_var*
//#UC END# *55B25C7D01F1_4AA7C26401C4_var*
begin
//#UC START# *55B25C7D01F1_4AA7C26401C4_impl*
 Result := g_RunDataInstallerMessage;
//#UC END# *55B25C7D01F1_4AA7C26401C4_impl*
end;//TnsStartupSupport.RunDataInstallerMessage

class function TnsStartupSupport.RunDataUpdaterMessage: LongWord;
//#UC START# *55B25C9301ED_4AA7C26401C4_var*
//#UC END# *55B25C9301ED_4AA7C26401C4_var*
begin
//#UC START# *55B25C9301ED_4AA7C26401C4_impl*
 Result := g_RunDataUpdaterMessage;
//#UC END# *55B25C9301ED_4AA7C26401C4_impl*
end;//TnsStartupSupport.RunDataUpdaterMessage

class function TnsStartupSupport.RunDownloaderMessage: LongWord;
//#UC START# *55B25CAE030D_4AA7C26401C4_var*
//#UC END# *55B25CAE030D_4AA7C26401C4_var*
begin
//#UC START# *55B25CAE030D_4AA7C26401C4_impl*
 Result := g_RunDownloaderMessage;
//#UC END# *55B25CAE030D_4AA7C26401C4_impl*
end;//TnsStartupSupport.RunDownloaderMessage

class function TnsStartupSupport.TrySendMessage(const aClassName: AnsiString;
 aMessage: LongWord;
 aCopyDataBuffer: Pointer = nil;
 aCopyDataBufferLength: Integer = 0): Boolean;
//#UC START# *55B25CC900E7_4AA7C26401C4_var*
var
 l_CopyDataStruct: TCopyDataStruct;
 l_WindowHandle: HWND;
//#UC END# *55B25CC900E7_4AA7C26401C4_var*
begin
//#UC START# *55B25CC900E7_4AA7C26401C4_impl*
 l_WindowHandle := FindWindow(PChar(aClassName), nil);
 //
 Result := (l_WindowHandle <> HWND(0));
 if Result then
 begin
  if ((aCopyDataBuffer <> nil) and (aCopyDataBufferLength <> 0)) then
  begin
   with l_CopyDataStruct do
   begin
    Assert((SizeOf(aMessage) = SizeOf(DWORD)) and (SizeOf(aCopyDataBufferLength) = SizeOf(DWORD)));
    //
    dwData := DWORD(aMessage);
    cbData := DWORD(aCopyDataBufferLength);
    lpData := aCopyDataBuffer;
   end;
   //
   if (SendMessage(l_WindowHandle, WM_COPYDATA, WPARAM(0), LPARAM(@l_CopyDataStruct)) <> LRESULT(aMessage)) then
   begin
    Result := False;
    Exit;
   end;
  end;
  //
  Assert(SizeOf(aMessage) = SizeOf(UINT));
  //
  Result := (SendMessage(l_WindowHandle, UINT(aMessage), WPARAM(0), LPARAM(0)) = LRESULT(aMessage));
 end;
 //
 afw.ProcessMessages;
//#UC END# *55B25CC900E7_4AA7C26401C4_impl*
end;//TnsStartupSupport.TrySendMessage

class function TnsStartupSupport.IsParamStrExist(const aParamStr: AnsiString): Boolean;
//#UC START# *55B25CF000BE_4AA7C26401C4_var*
var
 l_Index: Integer;
//#UC END# *55B25CF000BE_4AA7C26401C4_var*
begin
//#UC START# *55B25CF000BE_4AA7C26401C4_impl*
 Result := False;
 //
 for l_Index := 1 to ParamCount do
  if (StrIComp(PChar(ParamStr(l_Index)), PChar(aParamStr)) = 0) then
  begin
   Result := True;
   Break;
  end;
//#UC END# *55B25CF000BE_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsParamStrExist

class function TnsStartupSupport.QuoteStringIfNeed(const aString: AnsiString): AnsiString;
//#UC START# *55B25D8E0373_4AA7C26401C4_var*
//#UC END# *55B25D8E0373_4AA7C26401C4_var*
begin
//#UC START# *55B25D8E0373_4AA7C26401C4_impl*
 if ((Pos(' ', aString) <> 0) or (Pos('''', aString) <> 0)) then
  Result := Format('"%s"', [aString])
 else
  Result := aString;
//#UC END# *55B25D8E0373_4AA7C26401C4_impl*
end;//TnsStartupSupport.QuoteStringIfNeed

class function TnsStartupSupport.GetCommandLine: AnsiString;
//#UC START# *55B25DA80055_4AA7C26401C4_var*
 //
 function AddParamStrToCommandLine(const aCommandLine: AnsiString; const aParamStr: AnsiString): AnsiString;
 begin
  if (aCommandLine = '') then
   Result := aParamStr
  else
   Result := Format('%s %s', [aCommandLine, aParamStr]);
 end;
 //
var
 l_Index: Integer;
 l_ParamStr: AnsiString;
//#UC END# *55B25DA80055_4AA7C26401C4_var*
begin
//#UC START# *55B25DA80055_4AA7C26401C4_impl*
 Result := '';
 //
 for l_Index := 1 to ParamCount do
 begin
  l_ParamStr := ParamStr(l_Index);
  //
  if (ANSICompareText(l_ParamStr, c_RunDataInstallerParamStr) <> 0) and
     (ANSICompareText(l_ParamStr, c_RunDataUpdaterParamStr) <> 0) and
     (ANSICompareText(l_ParamStr, c_RunDownloaderParamStr) <> 0) then
   Result := AddParamStrToCommandLine(Result, QuoteStringIfNeed(l_ParamStr));
 end;
//#UC END# *55B25DA80055_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetCommandLine

class function TnsStartupSupport.GetDataInstallerCommandLine: AnsiString;
//#UC START# *55B25DCD0153_4AA7C26401C4_var*
//#UC END# *55B25DCD0153_4AA7C26401C4_var*
begin
//#UC START# *55B25DCD0153_4AA7C26401C4_impl*
 Result := GetCommandLine;
 //
 if (Result = '') then
  Result := c_DataInstallerDefaultCommandLine;
//#UC END# *55B25DCD0153_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetDataInstallerCommandLine

class function TnsStartupSupport.GetDataUpdaterCommandLine: AnsiString;
//#UC START# *55B25DE20201_4AA7C26401C4_var*
//#UC END# *55B25DE20201_4AA7C26401C4_var*
begin
//#UC START# *55B25DE20201_4AA7C26401C4_impl*
  Result := GetCommandLine;
 //
 if (Result = '') then
  Result := c_DataUpdaterDefaultCommandLine;
//#UC END# *55B25DE20201_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetDataUpdaterCommandLine

class function TnsStartupSupport.GetDownloaderCommandLine: AnsiString;
//#UC START# *55B25DFB0076_4AA7C26401C4_var*
//#UC END# *55B25DFB0076_4AA7C26401C4_var*
begin
//#UC START# *55B25DFB0076_4AA7C26401C4_impl*
 Result := GetCommandLine;
 //
 if (Result = '') then
  Result := c_DownloaderDefaultCommandLine;
//#UC END# *55B25DFB0076_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetDownloaderCommandLine

class function TnsStartupSupport.GetDataInstallerMutexName: AnsiString;
//#UC START# *55B25E1B02C2_4AA7C26401C4_var*
//#UC END# *55B25E1B02C2_4AA7C26401C4_var*
begin
//#UC START# *55B25E1B02C2_4AA7C26401C4_impl*
 Result := '{36D6F6B9-0F28-4116-9294-7B1FE4BA88CD}';
//#UC END# *55B25E1B02C2_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetDataInstallerMutexName

class function TnsStartupSupport.GetDataUpdaterMutexName: AnsiString;
//#UC START# *55B262A4026E_4AA7C26401C4_var*
//#UC END# *55B262A4026E_4AA7C26401C4_var*
begin
//#UC START# *55B262A4026E_4AA7C26401C4_impl*
 Result := '{5B78E993-D593-4A45-8ECA-354E6E7701C6}';
//#UC END# *55B262A4026E_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetDataUpdaterMutexName

class function TnsStartupSupport.GetDownloaderMutexName: AnsiString;
//#UC START# *55B262B30071_4AA7C26401C4_var*
//#UC END# *55B262B30071_4AA7C26401C4_var*
begin
//#UC START# *55B262B30071_4AA7C26401C4_impl*
 Result := '{EE316E6D-97EB-47E1-90A1-5CC7E8E14C7D}';
//#UC END# *55B262B30071_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetDownloaderMutexName

class function TnsStartupSupport.GetPrimeRunningCopyMutexName: AnsiString;
//#UC START# *55B262C70002_4AA7C26401C4_var*
//#UC END# *55B262C70002_4AA7C26401C4_var*
begin
//#UC START# *55B262C70002_4AA7C26401C4_impl*
 Result := '{C5105D38-60D1-4EBB-8CC2-A61BA61EA72D}';
//#UC END# *55B262C70002_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetPrimeRunningCopyMutexName

class function TnsStartupSupport.GetShellRunningCopyMutexName: AnsiString;
//#UC START# *55B262D20386_4AA7C26401C4_var*
//#UC END# *55B262D20386_4AA7C26401C4_var*
begin
//#UC START# *55B262D20386_4AA7C26401C4_impl*
 Result := '{42C5893E-0DE0-4A5F-BE50-BA602DA4A73E}';
//#UC END# *55B262D20386_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetShellRunningCopyMutexName

class function TnsStartupSupport.GetAdminRunningCopyMutexName: AnsiString;
//#UC START# *55B262DE03CE_4AA7C26401C4_var*
//#UC END# *55B262DE03CE_4AA7C26401C4_var*
begin
//#UC START# *55B262DE03CE_4AA7C26401C4_impl*
 Result := '{5040A698-A262-4AF0-BB46-9DD7AC93A559}';
//#UC END# *55B262DE03CE_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetAdminRunningCopyMutexName

class function TnsStartupSupport.GetShutdownEventName: AnsiString;
//#UC START# *55B262EB025D_4AA7C26401C4_var*
//#UC END# *55B262EB025D_4AA7C26401C4_var*
begin
//#UC START# *55B262EB025D_4AA7C26401C4_impl*
 Result := '{7C9B7D1E-D28D-48D6-9FC5-D07C29BD9802}';
//#UC END# *55B262EB025D_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetShutdownEventName

class function TnsStartupSupport.GetStartupMutexName: AnsiString;
//#UC START# *55B262F703D3_4AA7C26401C4_var*
//#UC END# *55B262F703D3_4AA7C26401C4_var*
begin
//#UC START# *55B262F703D3_4AA7C26401C4_impl*
 Result := '{0765EE38-91E1-4662-91B1-5F5FB01716DB}';
//#UC END# *55B262F703D3_4AA7C26401C4_impl*
end;//TnsStartupSupport.GetStartupMutexName

class function TnsStartupSupport.IsCopyRunning(var aMutexHandle: THandle;
 var aMutexHoldCount: Integer;
 const aMutexName: AnsiString): Boolean;
//#UC START# *55B2632C005B_4AA7C26401C4_var*
//#UC END# *55B2632C005B_4AA7C26401C4_var*
begin
//#UC START# *55B2632C005B_4AA7C26401C4_impl*
 with g_CriticalSection do
 begin
  Enter;
  try
   Result := True;
   //
   if (aMutexHandle = THandle(INVALID_HANDLE_VALUE)) then
   begin
    aMutexHandle := CreateMutex(nil, False, PChar(aMutexName));
    if (aMutexHandle = THandle(0)) then
    begin
     aMutexHandle := THandle(INVALID_HANDLE_VALUE);
     //
     Win32Check(False);
    end;
   end;
   //
   if (aMutexHoldCount = 0) then
   begin
    case WaitForSingleObject(aMutexHandle, 0) of
     WAIT_FAILED:
      Win32Check(False);
     //
     WAIT_OBJECT_0:
     begin
      Result := False;
      //
      Win32Check(ReleaseMutex(aMutexHandle));
      Win32Check(CloseHandle(aMutexHandle));
     end;
    end;
    //
    aMutexHandle := THandle(INVALID_HANDLE_VALUE);
   end;
  finally
   Leave;
  end;
 end;
//#UC END# *55B2632C005B_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsCopyRunning

class procedure TnsStartupSupport.InitMutex(var aMutexHandle: THandle;
 var aMutexHoldCount: Integer;
 const aMutexName: AnsiString;
 aResult: PBoolean = nil);
//#UC START# *55B263F301B5_4AA7C26401C4_var*
//#UC END# *55B263F301B5_4AA7C26401C4_var*
begin
//#UC START# *55B263F301B5_4AA7C26401C4_impl*
 with g_CriticalSection do
 begin
  Enter;
  try
   if (aMutexHandle = THandle(INVALID_HANDLE_VALUE)) then
   begin
    aMutexHandle := CreateMutex(nil, False, PChar(aMutexName));
    if (aMutexHandle = THandle(0)) then
    begin
     aMutexHandle := THandle(INVALID_HANDLE_VALUE);
     //
     Win32Check(False);
    end;
   end;
   //
   if (aMutexHoldCount = 0) then
    if (aResult = nil) then
     while (True) do
      case WaitForSingleObject(aMutexHandle, c_SleepTime) of
       WAIT_ABANDONED,
       WAIT_OBJECT_0:
        Break;
       //
       WAIT_TIMEOUT:
        afw.ProcessMessages;
      else
       Win32Check(False);
      end
    else
    begin
     case WaitForSingleObject(aMutexHandle, 0) of
      WAIT_ABANDONED,
      WAIT_OBJECT_0:
       aResult^ := True;
      //
      WAIT_TIMEOUT:
      begin
       aResult^ := False;
       //
       Dec(aMutexHoldCount); // mutex is not hold
      end;
     else
      Win32Check(False);
     end;
     //
     afw.ProcessMessages;
    end;
    //
    Inc(aMutexHoldCount);
  finally
   Leave;
  end;
 end;
//#UC END# *55B263F301B5_4AA7C26401C4_impl*
end;//TnsStartupSupport.InitMutex

class procedure TnsStartupSupport.DoneMutex(var aMutexHandle: THandle;
 var aMutexHoldCount: Integer);
//#UC START# *55B2641602E0_4AA7C26401C4_var*
//#UC END# *55B2641602E0_4AA7C26401C4_var*
begin
//#UC START# *55B2641602E0_4AA7C26401C4_impl*
 with g_CriticalSection do
 begin
  Enter;
  try
   if (aMutexHandle <> THandle(INVALID_HANDLE_VALUE)) then
   begin
    Dec(aMutexHoldCount);
    //
    if (aMutexHoldCount = 0) then
    begin
     Win32Check(ReleaseMutex(aMutexHandle));
     Win32Check(CloseHandle(aMutexHandle));
     //
     aMutexHandle := THandle(INVALID_HANDLE_VALUE);
    end;
   end;
  finally
   Leave;
  end;
 end;
//#UC END# *55B2641602E0_4AA7C26401C4_impl*
end;//TnsStartupSupport.DoneMutex

class procedure TnsStartupSupport.InitEvent(var aEventHandle: THandle;
 var aEventOpenCount: Integer;
 const aEventName: AnsiString);
//#UC START# *55B2643203DB_4AA7C26401C4_var*
//#UC END# *55B2643203DB_4AA7C26401C4_var*
begin
//#UC START# *55B2643203DB_4AA7C26401C4_impl*
 with g_CriticalSection do
 begin
  Enter;
  try
   if (aEventHandle = THandle(INVALID_HANDLE_VALUE)) then
   begin
    aEventHandle := CreateEvent(nil, False, False, PChar(aEventName));
    if (aEventHandle = THandle(0)) then
    begin
     aEventHandle := THandle(INVALID_HANDLE_VALUE);
     //
     Win32Check(False);
    end;
   end;
   //
   Inc(aEventOpenCount);
  finally
   Leave;
  end;
 end;
//#UC END# *55B2643203DB_4AA7C26401C4_impl*
end;//TnsStartupSupport.InitEvent

class procedure TnsStartupSupport.DoneEvent(var aEventHandle: THandle;
 var aEventOpenCount: Integer);
//#UC START# *55B2645A02AB_4AA7C26401C4_var*
//#UC END# *55B2645A02AB_4AA7C26401C4_var*
begin
//#UC START# *55B2645A02AB_4AA7C26401C4_impl*
 with g_CriticalSection do
 begin
  Enter;
  try
   if (aEventHandle <> THandle(INVALID_HANDLE_VALUE)) then
   begin
    Dec(aEventOpenCount);
    //
    if (aEventOpenCount = 0) then
    begin
     Win32Check(SetEvent(aEventHandle));
     Win32Check(CloseHandle(aEventHandle));
     //
     aEventHandle := THandle(INVALID_HANDLE_VALUE);
    end;
   end;
  finally
   Leave;
  end;
 end;
//#UC END# *55B2645A02AB_4AA7C26401C4_impl*
end;//TnsStartupSupport.DoneEvent

class procedure TnsStartupSupport.WaitEvent(const aEventName: AnsiString;
 var aMutexHandle: THandle;
 var aMutexHoldCount: Integer;
 const aMutexName: AnsiString);
//#UC START# *55B26474016B_4AA7C26401C4_var*
var
 l_Event: THandle;
//#UC END# *55B26474016B_4AA7C26401C4_var*
begin
//#UC START# *55B26474016B_4AA7C26401C4_impl*
 with g_CriticalSection do
 begin
  Enter;
  try
   while (True) do
   begin
    l_Event := OpenEvent(EVENT_ALL_ACCESS, False, PChar(aEventName));
    //
    if (l_Event <> THandle(0)) then
     try
      case WaitForSingleObject(l_Event, c_SleepTime) of
       WAIT_ABANDONED,
       WAIT_OBJECT_0:
        Break;
       //
       WAIT_TIMEOUT:
        afw.ProcessMessages;
      else
       Win32Check(False);
      end;
     finally
      Win32Check(CloseHandle(l_Event));
     end
    else
     Break;
   end;
   //
   InitMutex(aMutexHandle, aMutexHoldCount, aMutexName);
  finally
   Leave;
  end;
 end;
//#UC END# *55B26474016B_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitEvent

class procedure TnsStartupSupport.WaitWhileMutexNotExist(const aMutexName: AnsiString);
//#UC START# *55B2649400D7_4AA7C26401C4_var*
var
 l_Handle: THandle;
//#UC END# *55B2649400D7_4AA7C26401C4_var*
begin
//#UC START# *55B2649400D7_4AA7C26401C4_impl*
 repeat
  l_Handle := CreateMutex(nil, False, PChar(aMutexName));
  //
  if (l_Handle <> THandle(0)) then
  begin
   if (GetLastError = ERROR_ALREADY_EXISTS) then
   begin
    // WAIT OPTIMIZATION {
    case WaitForSingleObject(l_Handle, INFINITE) of
     WAIT_ABANDONED,
     WAIT_OBJECT_0:
      Win32Check(ReleaseMutex(l_Handle));
     else
      Win32Check(False);
    end;
    // } WAIT OPTIMIZATION
    //
    Win32Check(CloseHandle(l_Handle));
    l_Handle := THandle(0);
    //
    afw.ProcessMessages;
   end;
  end
  else
   Win32Check(False);
 until (l_Handle <> THandle(0));
 //
 Win32Check(CloseHandle(l_Handle));
//#UC END# *55B2649400D7_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitWhileMutexNotExist

function TnsStartupSupport.AllocateHWnd(aWndMethod: TWndMethod): THandle;
//#UC START# *55B264F102E2_4AA7C26401C4_var*
 //
 procedure RegisterWndClass;
  //
  function IsWndClassRegistered(const aClassName: PChar): Boolean;
  var
   l_WndClass: TWndClass;
  begin
   Result := GetClassInfo(HInstance, aClassName, l_WndClass);
  end;
  //
 var
  l_WndClass: TWndClass;
 begin
  l3FillChar(l_WndClass, SizeOf(l_WndClass), $00);
  //
  with l_WndClass do
  begin
   lpfnWndProc := @DefWindowProc;
   hInstance := SysInit.HInstance;
   lpszClassName := PChar(UniqueClassName);
   //
   if IsWndClassRegistered(lpszClassName) then
    Windows.UnregisterClass(lpszClassName, hInstance);
  end;
  Windows.RegisterClass(l_WndClass);
 end;
 //
//#UC END# *55B264F102E2_4AA7C26401C4_var*
begin
//#UC START# *55B264F102E2_4AA7C26401C4_impl*
 RegisterWndClass;
 //
 Result := CreateWindowEx(WS_EX_TOOLWINDOW, PChar(UniqueClassName), nil, WS_POPUP , 0, 0, 0, 0, 0, 0, HInstance, nil);
 //
 if Assigned(aWndMethod) then
  SetWindowLong(Result, GWL_WNDPROC, Longint(MakeObjectInstance(aWndMethod)));
//#UC END# *55B264F102E2_4AA7C26401C4_impl*
end;//TnsStartupSupport.AllocateHWnd

procedure TnsStartupSupport.DeallocateHWnd(var aHWnd: THandle);
//#UC START# *55B265100333_4AA7C26401C4_var*
var
 l_ObjectInstance: Pointer;
//#UC END# *55B265100333_4AA7C26401C4_var*
begin
//#UC START# *55B265100333_4AA7C26401C4_impl*
 l_ObjectInstance := Pointer(GetWindowLong(aHWnd, GWL_WNDPROC));
 DestroyWindow(aHWnd);
 //
 FreeObjectInstance(l_ObjectInstance);
 //
 Windows.UnregisterClass(PChar(UniqueClassName), HInstance);
 //
 aHWnd := HWND(0);
//#UC END# *55B265100333_4AA7C26401C4_impl*
end;//TnsStartupSupport.DeallocateHWnd

procedure TnsStartupSupport.WndProc(var aMessage: TMessage);
//#UC START# *55B265250051_4AA7C26401C4_var*
var
 l_Param: AnsiString;
//#UC END# *55B265250051_4AA7C26401C4_var*
begin
//#UC START# *55B265250051_4AA7C26401C4_impl*
 try
  with aMessage do
  begin
   {$If not Defined(Admin) AND not Defined(Monitorings)}
   if (Msg = WM_COPYDATA) then
   begin
    with PCopyDataStruct(LParam)^ do
    begin
{$If not Defined(Admin) AND not Defined(Monitorings)}
     if (dwData = DWORD(OpenByNumberMessage)) then
     begin
      SetString(l_Param, PChar(lpData), Integer(cbData));
      //http://mdp.garant.ru/pages/viewpage.action?pageId=481813781
      //http://mdp.garant.ru/pages/viewpage.action?pageId=483399976
      if not nsOpenDocumentByNumber(l_Param, True, False) then
       nsOpenLink(l_Param, True, False);
      //
      TryActivateMainForm;
      Result := Longint(dwData);
      Exit;
     end;
{$IfEnd}
     //
     if (dwData = DWORD(RunDataInstallerMessage)) then
     begin
      SetString(f_DataInstallerCommandLine, PChar(lpData), Integer(cbData));
      //
      Result := Longint(dwData);
      Exit;
     end;
     //
     if (dwData = DWORD(RunDataUpdaterMessage)) then
     begin
      SetString(f_DataUpdaterCommandLine, PChar(lpData), Integer(cbData));
      //
      Result := Longint(dwData);
      Exit;
     end;
     //
     if (dwData = DWORD(RunDownloaderMessage)) then
     begin
      SetString(f_DownloaderCommandLine, PChar(lpData), Integer(cbData));
      //
      Result := Longint(dwData);
      Exit;
     end;
    end;
   end//Msg = WM_COPYDATA
   else
   {$IfEnd}
   //
   if (Msg = ShowActiveFormMessage) then
   begin
    if ShowActiveForm then
    begin
     Result := Longint(ShowActiveFormMessage);
     Exit;
    end;
   end
   else
   //
   if (Msg = GetAppHandleMessage) then
   begin
    Result := Application.Handle;
    Exit;
   end
   else
   //
   if (Msg = UnlockLoginMessage) then
   begin
    if IsLoginLocked then
    begin
     UnlockLogin;
     //
     Result := Longint(UnlockLoginMessage);
     Exit;
    end;
   end
   else
   //
   if (Msg = RunDataInstallerMessage) then
   begin
    InitMutex(g_DataInstallerMutexHandle, g_DataInstallerMutexHoldCount, GetDataInstallerMutexName);
    try
     RunDataInstallerProcess(f_DataInstallerCommandLine);
     f_CheckRunTimer.Enabled := True;
    except
     DoneMutex(g_DataInstallerMutexHandle, g_DataInstallerMutexHoldCount);
     //
     raise;
    end;
    //
    Result := Longint(RunDataInstallerMessage);
    Exit;
   end
   else
   //
   if (Msg = RunDataUpdaterMessage) then
   begin
    InitMutex(g_DataUpdaterMutexHandle, g_DataUpdaterMutexHoldCount, GetDataUpdaterMutexName);
    try
     RunDataUpdaterProcess(f_DataUpdaterCommandLine);
     f_CheckRunTimer.Enabled := True;
    except
     DoneMutex(g_DataUpdaterMutexHandle, g_DataUpdaterMutexHoldCount);
     //
     raise;
    end;
    //
    Result := Longint(RunDataUpdaterMessage);
    Exit;
   end
   else
   //
   if (Msg = RunDownloaderMessage) then
   begin
    InitMutex(g_DownloaderMutexHandle, g_DownloaderMutexHoldCount, GetDownloaderMutexName);
    try
     RunDownloaderProcess(f_DownloaderCommandLine);
     f_CheckRunTimer.Enabled := True;
    except
     DoneMutex(g_DownloaderMutexHandle, g_DownloaderMutexHoldCount);
     //
     raise;
    end;
    //
    Result := Longint(RunDownloaderMessage);
    Exit;
   end;//Msg = RunDownloaderMessage
   //
   Result := DefWindowProc(f_StartupSupportWindow, Msg, WParam, LParam);
  end;
 except
  on E: Exception do
   l3System.Exception2Log(E);
 end;
//#UC END# *55B265250051_4AA7C26401C4_impl*
end;//TnsStartupSupport.WndProc

procedure TnsStartupSupport.LockLogin;
//#UC START# *55B265410057_4AA7C26401C4_var*
//#UC END# *55B265410057_4AA7C26401C4_var*
begin
//#UC START# *55B265410057_4AA7C26401C4_impl*
 l3InterlockedIncrement(f_LoginLockCount);
//#UC END# *55B265410057_4AA7C26401C4_impl*
end;//TnsStartupSupport.LockLogin

procedure TnsStartupSupport.UnlockLogin;
//#UC START# *55B2654B009E_4AA7C26401C4_var*
//#UC END# *55B2654B009E_4AA7C26401C4_var*
begin
//#UC START# *55B2654B009E_4AA7C26401C4_impl*
 l3InterlockedDecrement(f_LoginLockCount);
//#UC END# *55B2654B009E_4AA7C26401C4_impl*
end;//TnsStartupSupport.UnlockLogin

function TnsStartupSupport.IsLoginLocked: Boolean;
//#UC START# *55B2658C0198_4AA7C26401C4_var*
//#UC END# *55B2658C0198_4AA7C26401C4_var*
begin
//#UC START# *55B2658C0198_4AA7C26401C4_impl*
 Result := (l3InterlockedExchangeAdd(@f_LoginLockCount, 0) <> 0);
//#UC END# *55B2658C0198_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsLoginLocked

function TnsStartupSupport.ShowActiveForm: Boolean;
//#UC START# *55B265A300AD_4AA7C26401C4_var*
var
 l_ActiveForm: TForm;
 l_WindowPlacement: TWindowPlacement;
//#UC END# *55B265A300AD_4AA7C26401C4_var*
begin
//#UC START# *55B265A300AD_4AA7C26401C4_impl*
 Result := False;
 //
 l_ActiveForm := Screen.ActiveForm;
 if (l_ActiveForm <> nil) then
 begin
  with Application do
  begin
   BringToFront;
   OpenIcon(Handle);
  end;
  //
  with l_ActiveForm do
  begin
   l_WindowPlacement.Length := SizeOf(l_WindowPlacement);
   GetWindowPlacement(Handle, @l_WindowPlacement);
   //
   BringToFront;
   OpenIcon(Handle);
   //
   if ((l_WindowPlacement.Flags and WPF_RESTORETOMAXIMIZED) <> 0) then
    ShowWindow(Handle, SW_MAXIMIZE);
  end;
  //
  Result := True;
 end;
//#UC END# *55B265A300AD_4AA7C26401C4_impl*
end;//TnsStartupSupport.ShowActiveForm

procedure TnsStartupSupport.RunProcess(const aProcessName: AnsiString;
 const aCommandLine: AnsiString;
 var aProcessHandle: THandle);
//#UC START# *55B265B50159_4AA7C26401C4_var*
 function GetCreationFlags: DWORD;
 begin
  Result := CREATE_DEFAULT_ERROR_MODE or DETACHED_PROCESS or NORMAL_PRIORITY_CLASS;
 end;
 //
 function GetOsDependentCatalog: AnsiString;
 begin
  if (Longint(GetVersion) < 0) then
   Result := Format('%s%s', [ExtractFilePath(ParamStr(0)), 'win9X\'])
  else
   Result := Format('%s%s', [ExtractFilePath(ParamStr(0)), 'winNT\']);
 end;
 //
 function RunProcessWithParams(const aProcessName: AnsiString; const aCommandLine: AnsiString; const aCurrentDirectory: AnsiString; var aProcessHandle: THandle): Boolean;
 const
  ERROR_ELEVATION_REQUIRED = 740;
 var
  l_ProcessInformation: TProcessInformation;
  l_ProcessName: AnsiString;
  l_StartupInfo: TStartupInfo;
  //
  l_CommandLine: AnsiString;
  l_NameServiceIOR: AnsiString;
  l_ShellExecuteInfo: TShellExecuteInfo;
 begin
  l3FillChar(l_StartupInfo, SizeOf(l_StartupInfo), $00);
  with l_StartupInfo do
  begin
   cb := DWORD(SizeOf(l_StartupInfo));
   dwFlags := STARTF_USESTDHANDLES;
  end;
  //
  l_ProcessName := Format('%s%s', [aCurrentDirectory, aProcessName]);
  //
  Result := CreateProcess(nil, PChar(Format('%s %s', [QuoteStringIfNeed(l_ProcessName), aCommandLine])), nil, nil, False, GetCreationFlags, nil, PChar(aCurrentDirectory), l_StartupInfo, l_ProcessInformation);
  if Result then
   with l_ProcessInformation do
   begin
    CloseHandle(hThread);
    //
    if (aProcessHandle = THandle(INVALID_HANDLE_VALUE)) then
     aProcessHandle := hProcess
    else
     Win32Check(CloseHandle(hProcess));
   end
  else
   // UAC: Run through "Elevation Dialog" ShellExecuteEx-implementation
   if ({GetLastError = ERROR_ELEVATION_REQUIRED // MoleBox <= 4_5408 BUG}True) then
   begin
    l_CommandLine := aCommandLine;
    l_NameServiceIOR := GetEnvironmentVariable('NameServiceIOR');
    if (l_NameServiceIOR <> '') then
     l_CommandLine := Format('-ORBInitRef NameService=%s %s', [l_NameServiceIOR, l_CommandLine]);
    //
    l3FillChar(l_ShellExecuteInfo, SizeOf(l_ShellExecuteInfo), $00);
    //
    with l_ShellExecuteInfo do
    begin
     cbSize := SizeOf(l_ShellExecuteInfo);
     //
     fMask := SEE_MASK_CLASSNAME or SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI or SEE_MASK_NOCLOSEPROCESS;
     lpVerb := 'runas';
     //
     lpFile := PChar(l_ProcessName);
     lpParameters := PChar(l_CommandLine);
     //
     nShow := SW_SHOWDEFAULT;
     //
     lpClass := 'exefile';
    end;
    //
    Result := ShellExecuteEx(@l_ShellExecuteInfo);
    if (Result) then
     with l_ShellExecuteInfo do
     begin
      if (aProcessHandle = THandle(INVALID_HANDLE_VALUE)) then
       aProcessHandle := hProcess
      else
       Win32Check(CloseHandle(hProcess));
     end;
   end;
 end;
//#UC END# *55B265B50159_4AA7C26401C4_var*
begin
//#UC START# *55B265B50159_4AA7C26401C4_impl*
 if not(RunProcessWithParams(aProcessName, aCommandLine, GetOsDependentCatalog, aProcessHandle) or RunProcessWithParams(aProcessName, aCommandLine, ExtractFilePath(ParamStr(0)), aProcessHandle)) then
   ; // $TODO: сообщение, что не смогли удачно запустить процесс
//#UC END# *55B265B50159_4AA7C26401C4_impl*
end;//TnsStartupSupport.RunProcess

function TnsStartupSupport.IsProcessRunning(aProcessHandle: THandle): Boolean;
//#UC START# *55B265D2028C_4AA7C26401C4_var*
var
 l_ExitCode: DWORD absolute ExitCode;
//#UC END# *55B265D2028C_4AA7C26401C4_var*
begin
//#UC START# *55B265D2028C_4AA7C26401C4_impl*
 Result := (aProcessHandle <> THandle(INVALID_HANDLE_VALUE));
 //
 if (Result) then
 begin
  Result := (WaitForSingleObject(aProcessHandle, 0) = WAIT_TIMEOUT);
  //
  if (not Result) then
  begin
   Assert(SizeOf(l_ExitCode) = SizeOf(ExitCode));
   Win32Check(GetExitCodeProcess(aProcessHandle, l_ExitCode));
   //
   if (l_ExitCode = DWORD(STILL_ACTIVE)) then
    Result := False;
  end;
 end;
//#UC END# *55B265D2028C_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsProcessRunning

function TnsStartupSupport.WaitWhileProcessIsRunning(aHardWait: Boolean;
 aIsProcessRunning: Boolean;
 var aProcessHandle: THandle): Boolean;
//#UC START# *55B265EB03AD_4AA7C26401C4_var*
var
 l_ExitCode: DWORD absolute ExitCode;
//#UC END# *55B265EB03AD_4AA7C26401C4_var*
begin
//#UC START# *55B265EB03AD_4AA7C26401C4_impl*
 Result := True;
 if (aProcessHandle <> THandle(INVALID_HANDLE_VALUE)) then
 begin
  if aIsProcessRunning then
  begin
   while (True) do
    case WaitForSingleObject(aProcessHandle, c_SleepTime) of
     WAIT_ABANDONED,
     WAIT_OBJECT_0:
      Break;
     //
     WAIT_TIMEOUT:
      if aHardWait then
       afw.ProcessMessages
      else
      begin
       Result := False;
       Break;
      end;
    else
     TerminateProcess(aProcessHandle, WAIT_FAILED);
     Win32Check(False);
    end;
   //
   if Result then
   begin
    Assert(SizeOf(l_ExitCode) = SizeOf(ExitCode));
    Win32Check(GetExitCodeProcess(aProcessHandle, l_ExitCode));
   end; 
  end;
  //
  if Result then
  begin
   CloseHandle(aProcessHandle);
   aProcessHandle := THandle(INVALID_HANDLE_VALUE);
  end;
 end;
//#UC END# *55B265EB03AD_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitWhileProcessIsRunning

procedure TnsStartupSupport.RunDataInstallerProcess(const aCommandLine: AnsiString);
//#UC START# *55B266240168_4AA7C26401C4_var*
//#UC END# *55B266240168_4AA7C26401C4_var*
begin
//#UC START# *55B266240168_4AA7C26401C4_impl*
 if not (IsDataInstallerProcessRunning) then
  RunProcess(c_DataInstallerProcessName, aCommandLine, f_DataInstallerProcessHandle);
//#UC END# *55B266240168_4AA7C26401C4_impl*
end;//TnsStartupSupport.RunDataInstallerProcess

function TnsStartupSupport.IsDataInstallerProcessRunning: Boolean;
//#UC START# *55B266430031_4AA7C26401C4_var*
//#UC END# *55B266430031_4AA7C26401C4_var*
begin
//#UC START# *55B266430031_4AA7C26401C4_impl*
 Result := IsProcessRunning(f_DataInstallerProcessHandle);
//#UC END# *55B266430031_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsDataInstallerProcessRunning

function TnsStartupSupport.WaitWhileDataInstallerProcessIsRunning(aHardWait: Boolean): Boolean;
//#UC START# *55B2665A0293_4AA7C26401C4_var*
//#UC END# *55B2665A0293_4AA7C26401C4_var*
begin
//#UC START# *55B2665A0293_4AA7C26401C4_impl*
 Result := WaitWhileProcessIsRunning(aHardWait, IsDataInstallerProcessRunning, f_DataInstallerProcessHandle);
 //
 if Result and (g_DataInstallerMutexHandle <> THandle(INVALID_HANDLE_VALUE)) then
  while (l3InterlockedExchangeAdd(g_DataInstallerMutexHoldCount, 0) <> 0) do
   DoneMutex(g_DataInstallerMutexHandle, g_DataInstallerMutexHoldCount);
//#UC END# *55B2665A0293_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitWhileDataInstallerProcessIsRunning

procedure TnsStartupSupport.RunDataUpdaterProcess(const aCommandLine: AnsiString);
//#UC START# *55B26671029E_4AA7C26401C4_var*
//#UC END# *55B26671029E_4AA7C26401C4_var*
begin
//#UC START# *55B26671029E_4AA7C26401C4_impl*
 if not (IsDataUpdaterProcessRunning) then
  RunProcess(c_DataUpdaterProcessName, aCommandLine, f_DataUpdaterProcessHandle);
//#UC END# *55B26671029E_4AA7C26401C4_impl*
end;//TnsStartupSupport.RunDataUpdaterProcess

function TnsStartupSupport.IsDataUpdaterProcessRunning: Boolean;
//#UC START# *55B266870310_4AA7C26401C4_var*
//#UC END# *55B266870310_4AA7C26401C4_var*
begin
//#UC START# *55B266870310_4AA7C26401C4_impl*
 Result := IsProcessRunning(f_DataUpdaterProcessHandle);
//#UC END# *55B266870310_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsDataUpdaterProcessRunning

function TnsStartupSupport.WaitWhileDataUpdaterProcessIsRunning(aHardWait: Boolean): Boolean;
//#UC START# *55B266A80232_4AA7C26401C4_var*
//#UC END# *55B266A80232_4AA7C26401C4_var*
begin
//#UC START# *55B266A80232_4AA7C26401C4_impl*
 Result := WaitWhileProcessIsRunning(aHardWait, IsDataUpdaterProcessRunning, f_DataUpdaterProcessHandle);
 //
 if Result and (g_DataUpdaterMutexHandle <> THandle(INVALID_HANDLE_VALUE)) then
  while (l3InterlockedExchangeAdd(g_DataUpdaterMutexHoldCount, 0) <> 0) do
   DoneMutex(g_DataUpdaterMutexHandle, g_DataUpdaterMutexHoldCount);
//#UC END# *55B266A80232_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitWhileDataUpdaterProcessIsRunning

procedure TnsStartupSupport.RunDownloaderProcess(const aCommandLine: AnsiString);
//#UC START# *55B266BC03A9_4AA7C26401C4_var*
//#UC END# *55B266BC03A9_4AA7C26401C4_var*
begin
//#UC START# *55B266BC03A9_4AA7C26401C4_impl*
 if not (IsDownloaderProcessRunning) then
  RunProcess(c_DownloaderProcessName, aCommandLine, f_DownloaderProcessHandle);
//#UC END# *55B266BC03A9_4AA7C26401C4_impl*
end;//TnsStartupSupport.RunDownloaderProcess

function TnsStartupSupport.IsDownloaderProcessRunning: Boolean;
//#UC START# *55B266D200D7_4AA7C26401C4_var*
//#UC END# *55B266D200D7_4AA7C26401C4_var*
begin
//#UC START# *55B266D200D7_4AA7C26401C4_impl*
 Result := IsProcessRunning(f_DownloaderProcessHandle);
//#UC END# *55B266D200D7_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsDownloaderProcessRunning

function TnsStartupSupport.WaitWhileDownloaderProcessIsRunning(aHardWait: Boolean): Boolean;
//#UC START# *55B266E50283_4AA7C26401C4_var*
//#UC END# *55B266E50283_4AA7C26401C4_var*
begin
//#UC START# *55B266E50283_4AA7C26401C4_impl*
 Result := WaitWhileProcessIsRunning(aHardWait, IsDownloaderProcessRunning, f_DownloaderProcessHandle);
 //
 if Result and (g_DownloaderMutexHandle <> THandle(INVALID_HANDLE_VALUE)) then
  while (l3InterlockedExchangeAdd(g_DownloaderMutexHoldCount, 0) <> 0) do
   DoneMutex(g_DownloaderMutexHandle, g_DownloaderMutexHoldCount);
//#UC END# *55B266E50283_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitWhileDownloaderProcessIsRunning

procedure TnsStartupSupport.OnTimer(Sender: TObject);
//#UC START# *55B266FB022D_4AA7C26401C4_var*
var
 l_Waited: Boolean;
//#UC END# *55B266FB022D_4AA7C26401C4_var*
begin
//#UC START# *55B266FB022D_4AA7C26401C4_impl*
 with f_CheckRunTimer do
 begin
  Enabled := False;
  l_Waited := True;
  try
   if (not IsDataInstallerProcessRunning) then
    l_Waited := WaitWhileDataInstallerProcessIsRunning(False);
   //
   if (not IsDataUpdaterProcessRunning) then
    l_Waited := WaitWhileDataUpdaterProcessIsRunning(False);
   //
   if (not IsDownloaderProcessRunning) then
    l_Waited := WaitWhileDownloaderProcessIsRunning(False);
  finally
   Enabled := (not l_Waited) or IsDataInstallerProcessRunning or IsDataUpdaterProcessRunning or IsDownloaderProcessRunning;
  end;
 end;
//#UC END# *55B266FB022D_4AA7C26401C4_impl*
end;//TnsStartupSupport.OnTimer

constructor TnsStartupSupport.Create;
//#UC START# *55B269E802B9_4AA7C26401C4_var*
//#UC END# *55B269E802B9_4AA7C26401C4_var*
begin
//#UC START# *55B269E802B9_4AA7C26401C4_impl*
 inherited Create{(nil)};
 //
 f_DataInstallerCommandLine := c_DataInstallerDefaultCommandLine;
 f_DataUpdaterCommandLine := c_DataUpdaterDefaultCommandLine;
 f_DownloaderCommandLine := c_DownloaderDefaultCommandLine;
 //
 f_DataInstallerProcessHandle := THandle(INVALID_HANDLE_VALUE);
 f_DataUpdaterProcessHandle := THandle(INVALID_HANDLE_VALUE);
 f_DownloaderProcessHandle := THandle(INVALID_HANDLE_VALUE);
 //
 f_StartupSupportWindow := AllocateHWnd(WndProc);
 //
 f_CheckRunTimer := TTimer.Create(nil);
 //
 with f_CheckRunTimer do
 begin
  Enabled := False;
  Interval := 0500; // 0.5 of second
  //
  OnTimer := Self.OnTimer;
 end;
//#UC END# *55B269E802B9_4AA7C26401C4_impl*
end;//TnsStartupSupport.Create

class procedure TnsStartupSupport.DestroyInstance;
//#UC START# *55B26AC301C3_4AA7C26401C4_var*
//#UC END# *55B26AC301C3_4AA7C26401C4_var*
begin
//#UC START# *55B26AC301C3_4AA7C26401C4_impl*
 if (g_TnsStartupSupport <> nil) then
 begin
  with g_TnsStartupSupport do
  begin
   WaitWhileDataInstallerProcessIsRunning(True);
   WaitWhileDataUpdaterProcessIsRunning(True);
   WaitWhileDownloaderProcessIsRunning(True);
  end;
  vcmFree(g_TnsStartupSupport);
 end;
//#UC END# *55B26AC301C3_4AA7C26401C4_impl*
end;//TnsStartupSupport.DestroyInstance

class function TnsStartupSupport.IsRunDataInstallerParamExist: Boolean;
//#UC START# *55B26AD2024F_4AA7C26401C4_var*
//#UC END# *55B26AD2024F_4AA7C26401C4_var*
begin
//#UC START# *55B26AD2024F_4AA7C26401C4_impl*
 Result := IsParamStrExist(c_RunDataInstallerParamStr);
//#UC END# *55B26AD2024F_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsRunDataInstallerParamExist

class function TnsStartupSupport.IsRunDataUpdaterParamExist: Boolean;
//#UC START# *55B26AEC01CD_4AA7C26401C4_var*
//#UC END# *55B26AEC01CD_4AA7C26401C4_var*
begin
//#UC START# *55B26AEC01CD_4AA7C26401C4_impl*
 Result := IsParamStrExist(c_RunDataUpdaterParamStr);
//#UC END# *55B26AEC01CD_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsRunDataUpdaterParamExist

class function TnsStartupSupport.IsRunDownloaderParamExist: Boolean;
//#UC START# *55B26AF90280_4AA7C26401C4_var*
//#UC END# *55B26AF90280_4AA7C26401C4_var*
begin
//#UC START# *55B26AF90280_4AA7C26401C4_impl*
 Result := IsParamStrExist(c_RunDownloaderParamStr);
//#UC END# *55B26AF90280_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsRunDownloaderParamExist

class function TnsStartupSupport.IsRunParamExist: Boolean;
//#UC START# *55B26B09006D_4AA7C26401C4_var*
//#UC END# *55B26B09006D_4AA7C26401C4_var*
begin
//#UC START# *55B26B09006D_4AA7C26401C4_impl*
 Result := IsRunDataInstallerParamExist or IsRunDataUpdaterParamExist or IsRunDownloaderParamExist;
//#UC END# *55B26B09006D_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsRunParamExist

class function TnsStartupSupport.IsSilentRunAndExitParamExist: Boolean;
//#UC START# *55B26B1900FC_4AA7C26401C4_var*
//#UC END# *55B26B1900FC_4AA7C26401C4_var*
begin
//#UC START# *55B26B1900FC_4AA7C26401C4_impl*
 Result := IsParamStrExist(c_SilentRunAndExitParamStr);
//#UC END# *55B26B1900FC_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsSilentRunAndExitParamExist

class function TnsStartupSupport.IsEqualCopyRunning: Boolean;
//#UC START# *55B26B27031E_4AA7C26401C4_var*
//#UC END# *55B26B27031E_4AA7C26401C4_var*
begin
//#UC START# *55B26B27031E_4AA7C26401C4_impl*
{$IFDEF Monitorings}
 Result := IsPrimeCopyRunning;
{$ELSEIF defined(Admin)}
 Result := IsAdminCopyRunning;
{$ELSE}
 Result := IsShellCopyRunning;
{$IFEND Monitorings}
//#UC END# *55B26B27031E_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsEqualCopyRunning

class function TnsStartupSupport.IsPrimeCopyRunning: Boolean;
//#UC START# *55B26B3700B3_4AA7C26401C4_var*
//#UC END# *55B26B3700B3_4AA7C26401C4_var*
begin
//#UC START# *55B26B3700B3_4AA7C26401C4_impl*
 Result := IsCopyRunning(g_PrimeRunningCopyMutexHandle, g_PrimeRunningCopyMutexHoldCount, GetPrimeRunningCopyMutexName);
//#UC END# *55B26B3700B3_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsPrimeCopyRunning

class function TnsStartupSupport.IsShellCopyRunning: Boolean;
//#UC START# *55B26B440013_4AA7C26401C4_var*
//#UC END# *55B26B440013_4AA7C26401C4_var*
begin
//#UC START# *55B26B440013_4AA7C26401C4_impl*
 Result := IsCopyRunning(g_ShellRunningCopyMutexHandle, g_ShellRunningCopyMutexHoldCount, GetShellRunningCopyMutexName);
//#UC END# *55B26B440013_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsShellCopyRunning

class function TnsStartupSupport.IsAdminCopyRunning: Boolean;
//#UC START# *55B26B4F03C0_4AA7C26401C4_var*
//#UC END# *55B26B4F03C0_4AA7C26401C4_var*
begin
//#UC START# *55B26B4F03C0_4AA7C26401C4_impl*
 Result := IsCopyRunning(g_AdminRunningCopyMutexHandle, g_AdminRunningCopyMutexHoldCount, GetAdminRunningCopyMutexName);
//#UC END# *55B26B4F03C0_4AA7C26401C4_impl*
end;//TnsStartupSupport.IsAdminCopyRunning

class function TnsStartupSupport.TryUnlockLogin: Boolean;
//#UC START# *55B26B5B0269_4AA7C26401C4_var*
//#UC END# *55B26B5B0269_4AA7C26401C4_var*
begin
//#UC START# *55B26B5B0269_4AA7C26401C4_impl*
 Result := TrySendMessage(UniqueClassName, UnlockLoginMessage);
//#UC END# *55B26B5B0269_4AA7C26401C4_impl*
end;//TnsStartupSupport.TryUnlockLogin

class procedure TnsStartupSupport.TrySendOpenByNumer;
//#UC START# *55B26B8D0134_4AA7C26401C4_var*
{$If not Defined(Admin) AND not Defined(Monitorings)}
 //
 function IsOpenByNumberParamExist(out aParam: AnsiString): Boolean;
 var
  l_Index: Integer;
 begin
  Result := False;
  //
  for l_Index := 1 to ParamCount do
   if (StrIComp(PChar(ParamStr(l_Index)), '-OpenByNumber') = 0) then
   begin
    Result := (l_Index < ParamCount);
    //
    if (Result) then
     aParam := ParamStr (Succ(l_Index));
    //
    Break;
   end;
 end;
 //
var
 l_Param: AnsiString;
{$IfEnd}
//#UC END# *55B26B8D0134_4AA7C26401C4_var*
begin
//#UC START# *55B26B8D0134_4AA7C26401C4_impl*
{$If not Defined(Admin) AND not Defined(Monitorings)}
 if (IsOpenByNumberParamExist(l_Param) and (l_Param <> '')) then
  TrySendMessage(UniqueClassName, OpenByNumberMessage, PChar(l_Param), Length(l_Param));
{$IfEnd}
//#UC END# *55B26B8D0134_4AA7C26401C4_impl*
end;//TnsStartupSupport.TrySendOpenByNumer

class function TnsStartupSupport.TryRunDataInstaller: Boolean;
//#UC START# *55B26BAA0016_4AA7C26401C4_var*
var
 l_CommandLine: AnsiString;
 l_CommandLineLength: Integer;
//#UC END# *55B26BAA0016_4AA7C26401C4_var*
begin
//#UC START# *55B26BAA0016_4AA7C26401C4_impl*
 l_CommandLine := GetDataInstallerCommandLine;
 l_CommandLineLength := Length(l_CommandLine);
 //
 Result := TrySendMessage(UniqueClassName, RunDataInstallerMessage, PChar(l_CommandLine), l_CommandLineLength);
//#UC END# *55B26BAA0016_4AA7C26401C4_impl*
end;//TnsStartupSupport.TryRunDataInstaller

class function TnsStartupSupport.TryRunDataUpdater: Boolean;
//#UC START# *55B26BB70294_4AA7C26401C4_var*
var
 l_CommandLine: AnsiString;
 l_CommandLineLength: Integer;
//#UC END# *55B26BB70294_4AA7C26401C4_var*
begin
//#UC START# *55B26BB70294_4AA7C26401C4_impl*
 l_CommandLine := GetDataInstallerCommandLine;
 l_CommandLineLength := Length(l_CommandLine);
 //
 Result := TrySendMessage(UniqueClassName, RunDataUpdaterMessage, PChar(l_CommandLine), l_CommandLineLength);
//#UC END# *55B26BB70294_4AA7C26401C4_impl*
end;//TnsStartupSupport.TryRunDataUpdater

class function TnsStartupSupport.TryRunDownloader: Boolean;
//#UC START# *55B26BC402E6_4AA7C26401C4_var*
var
 l_CommandLine: AnsiString;
 l_CommandLineLength: Integer;
//#UC END# *55B26BC402E6_4AA7C26401C4_var*
begin
//#UC START# *55B26BC402E6_4AA7C26401C4_impl*
 l_CommandLine := GetDataInstallerCommandLine;
 l_CommandLineLength := Length(l_CommandLine);
 //
 Result := TrySendMessage(UniqueClassName, RunDownloaderMessage, PChar(l_CommandLine), l_CommandLineLength);
//#UC END# *55B26BC402E6_4AA7C26401C4_impl*
end;//TnsStartupSupport.TryRunDownloader

class function TnsStartupSupport.TrySwitchToOtherRunningCopy: Boolean;
//#UC START# *55B26BD20208_4AA7C26401C4_var*
var
 l_Form: THandle;
 l_AppHandle: THandle;
//#UC END# *55B26BD20208_4AA7C26401C4_var*
begin
//#UC START# *55B26BD20208_4AA7C26401C4_impl*
 Result := False;
 //
 while (IsEqualCopyRunning) do
 begin
  l_Form := FindWindow(PChar(UniqueClassName), nil);
  if (l_Form <> THandle(0)) then
  begin
   l_AppHandle := SendMessage(l_Form, GetAppHandleMessage, 0, 0);
   //
   if (l_AppHandle <> THandle(0)) then
    Result := {SetForegroundWindow(l_AppHandle) and} (SendMessage(l_Form, ShowActiveFormMessage, 0, 0) = LRESULT(ShowActiveFormMessage));
   //
   Break;
  end;
  //
  Sleep(250);
 end;
//#UC END# *55B26BD20208_4AA7C26401C4_impl*
end;//TnsStartupSupport.TrySwitchToOtherRunningCopy

class function TnsStartupSupport.CheckAndCreatePrimeRunningCopyMutex: Boolean;
//#UC START# *55B26BE700B1_4AA7C26401C4_var*
//#UC END# *55B26BE700B1_4AA7C26401C4_var*
begin
//#UC START# *55B26BE700B1_4AA7C26401C4_impl*
 InitMutex(g_PrimeRunningCopyMutexHandle, g_PrimeRunningCopyMutexHoldCount, GetPrimeRunningCopyMutexName, @Result);
//#UC END# *55B26BE700B1_4AA7C26401C4_impl*
end;//TnsStartupSupport.CheckAndCreatePrimeRunningCopyMutex

class procedure TnsStartupSupport.CreatePrimeRunningCopyMutex;
//#UC START# *55B26C000141_4AA7C26401C4_var*
//#UC END# *55B26C000141_4AA7C26401C4_var*
begin
//#UC START# *55B26C000141_4AA7C26401C4_impl*
 InitMutex(g_PrimeRunningCopyMutexHandle, g_PrimeRunningCopyMutexHoldCount, GetPrimeRunningCopyMutexName);
//#UC END# *55B26C000141_4AA7C26401C4_impl*
end;//TnsStartupSupport.CreatePrimeRunningCopyMutex

class procedure TnsStartupSupport.ReleasePrimeRunningCopyMutex;
//#UC START# *55B26C0C03DB_4AA7C26401C4_var*
//#UC END# *55B26C0C03DB_4AA7C26401C4_var*
begin
//#UC START# *55B26C0C03DB_4AA7C26401C4_impl*
 DoneMutex(g_PrimeRunningCopyMutexHandle, g_PrimeRunningCopyMutexHoldCount);
//#UC END# *55B26C0C03DB_4AA7C26401C4_impl*
end;//TnsStartupSupport.ReleasePrimeRunningCopyMutex

class function TnsStartupSupport.CheckAndCreateShellRunningCopyMutex: Boolean;
//#UC START# *55B26C22010D_4AA7C26401C4_var*
//#UC END# *55B26C22010D_4AA7C26401C4_var*
begin
//#UC START# *55B26C22010D_4AA7C26401C4_impl*
 InitMutex(g_ShellRunningCopyMutexHandle, g_ShellRunningCopyMutexHoldCount, GetShellRunningCopyMutexName, @Result);
//#UC END# *55B26C22010D_4AA7C26401C4_impl*
end;//TnsStartupSupport.CheckAndCreateShellRunningCopyMutex

class procedure TnsStartupSupport.CreateShellRunningCopyMutex;
//#UC START# *55B26C3701E0_4AA7C26401C4_var*
//#UC END# *55B26C3701E0_4AA7C26401C4_var*
begin
//#UC START# *55B26C3701E0_4AA7C26401C4_impl*
 InitMutex(g_ShellRunningCopyMutexHandle, g_ShellRunningCopyMutexHoldCount, GetShellRunningCopyMutexName);
//#UC END# *55B26C3701E0_4AA7C26401C4_impl*
end;//TnsStartupSupport.CreateShellRunningCopyMutex

class procedure TnsStartupSupport.ReleaseShellRunningCopyMutex;
//#UC START# *55B26C430082_4AA7C26401C4_var*
//#UC END# *55B26C430082_4AA7C26401C4_var*
begin
//#UC START# *55B26C430082_4AA7C26401C4_impl*
 DoneMutex(g_ShellRunningCopyMutexHandle, g_ShellRunningCopyMutexHoldCount);
//#UC END# *55B26C430082_4AA7C26401C4_impl*
end;//TnsStartupSupport.ReleaseShellRunningCopyMutex

class function TnsStartupSupport.CheckAndCreateAdminRunningCopyMutex: Boolean;
//#UC START# *55B26C5203E6_4AA7C26401C4_var*
//#UC END# *55B26C5203E6_4AA7C26401C4_var*
begin
//#UC START# *55B26C5203E6_4AA7C26401C4_impl*
 InitMutex(g_AdminRunningCopyMutexHandle, g_AdminRunningCopyMutexHoldCount, GetAdminRunningCopyMutexName, @Result);
//#UC END# *55B26C5203E6_4AA7C26401C4_impl*
end;//TnsStartupSupport.CheckAndCreateAdminRunningCopyMutex

class procedure TnsStartupSupport.CreateAdminRunningCopyMutex;
//#UC START# *55B26C9E028E_4AA7C26401C4_var*
//#UC END# *55B26C9E028E_4AA7C26401C4_var*
begin
//#UC START# *55B26C9E028E_4AA7C26401C4_impl*
 InitMutex(g_AdminRunningCopyMutexHandle, g_AdminRunningCopyMutexHoldCount, GetAdminRunningCopyMutexName);
//#UC END# *55B26C9E028E_4AA7C26401C4_impl*
end;//TnsStartupSupport.CreateAdminRunningCopyMutex

class procedure TnsStartupSupport.ReleaseAdminRunningCopyMutex;
//#UC START# *55B26CB00237_4AA7C26401C4_var*
//#UC END# *55B26CB00237_4AA7C26401C4_var*
begin
//#UC START# *55B26CB00237_4AA7C26401C4_impl*
 DoneMutex(g_AdminRunningCopyMutexHandle, g_AdminRunningCopyMutexHoldCount);
//#UC END# *55B26CB00237_4AA7C26401C4_impl*
end;//TnsStartupSupport.ReleaseAdminRunningCopyMutex

class function TnsStartupSupport.CheckAndCreateRunningCopyMutex: Boolean;
//#UC START# *55B26CBD0364_4AA7C26401C4_var*
//#UC END# *55B26CBD0364_4AA7C26401C4_var*
begin
//#UC START# *55B26CBD0364_4AA7C26401C4_impl*
{$IFDEF Monitorings}
 Result := CheckAndCreatePrimeRunningCopyMutex;
{$ELSEIF defined(Admin)}
 Result := CheckAndCreateAdminRunningCopyMutex;
{$ELSE  Monitorings}
 Result := CheckAndCreateShellRunningCopyMutex;
{$IFEND Monitorings}
//#UC END# *55B26CBD0364_4AA7C26401C4_impl*
end;//TnsStartupSupport.CheckAndCreateRunningCopyMutex

class procedure TnsStartupSupport.CreateRunningCopyMutex;
//#UC START# *55B26CCC0133_4AA7C26401C4_var*
//#UC END# *55B26CCC0133_4AA7C26401C4_var*
begin
//#UC START# *55B26CCC0133_4AA7C26401C4_impl*
 while (not CheckAndCreateRunningCopyMutex) do
  Sleep(0);
//#UC END# *55B26CCC0133_4AA7C26401C4_impl*
end;//TnsStartupSupport.CreateRunningCopyMutex

class procedure TnsStartupSupport.ReleaseRunningCopyMutex;
//#UC START# *55B26CD8020F_4AA7C26401C4_var*
//#UC END# *55B26CD8020F_4AA7C26401C4_var*
begin
//#UC START# *55B26CD8020F_4AA7C26401C4_impl*
{$IFDEF Monitorings}
 ReleasePrimeRunningCopyMutex;
{$ELSEIF defined(Admin)}
 ReleaseAdminRunningCopyMutex;
{$ELSE  Monitorings}
 ReleaseShellRunningCopyMutex;
{$IFEND Monitorings}
//#UC END# *55B26CD8020F_4AA7C26401C4_impl*
end;//TnsStartupSupport.ReleaseRunningCopyMutex

class procedure TnsStartupSupport.ShutdownPendingNotify;
//#UC START# *55B26CE500AC_4AA7C26401C4_var*
//#UC END# *55B26CE500AC_4AA7C26401C4_var*
begin
//#UC START# *55B26CE500AC_4AA7C26401C4_impl*
 InitEvent(g_ShutdownEvent, g_ShutdownEventOpenCount, GetShutdownEventName);
//#UC END# *55B26CE500AC_4AA7C26401C4_impl*
end;//TnsStartupSupport.ShutdownPendingNotify

class procedure TnsStartupSupport.ShutdownCompletedNotify;
//#UC START# *55B26CF2025B_4AA7C26401C4_var*
//#UC END# *55B26CF2025B_4AA7C26401C4_var*
begin
//#UC START# *55B26CF2025B_4AA7C26401C4_impl*
 ReleaseRunningCopyMutex;
 //
 DoneEvent(g_ShutdownEvent, g_ShutdownEventOpenCount);
//#UC END# *55B26CF2025B_4AA7C26401C4_impl*
end;//TnsStartupSupport.ShutdownCompletedNotify

class procedure TnsStartupSupport.StartupPendingNotify;
//#UC START# *55B26D010246_4AA7C26401C4_var*
//#UC END# *55B26D010246_4AA7C26401C4_var*
begin
//#UC START# *55B26D010246_4AA7C26401C4_impl*
 WaitEvent(GetShutdownEventName, g_StartupMutex, g_StartupMutexHoldCount, GetStartupMutexName);
//#UC END# *55B26D010246_4AA7C26401C4_impl*
end;//TnsStartupSupport.StartupPendingNotify

class procedure TnsStartupSupport.StartupCompletedNotify;
//#UC START# *55B26D0D013E_4AA7C26401C4_var*
//#UC END# *55B26D0D013E_4AA7C26401C4_var*
begin
//#UC START# *55B26D0D013E_4AA7C26401C4_impl*
 DoneMutex(g_StartupMutex, g_StartupMutexHoldCount);
//#UC END# *55B26D0D013E_4AA7C26401C4_impl*
end;//TnsStartupSupport.StartupCompletedNotify

class procedure TnsStartupSupport.WaitForDataInstallerExit;
//#UC START# *55B26D1903D3_4AA7C26401C4_var*
//#UC END# *55B26D1903D3_4AA7C26401C4_var*
begin
//#UC START# *55B26D1903D3_4AA7C26401C4_impl*
 WaitWhileMutexNotExist(GetDataInstallerMutexName);
//#UC END# *55B26D1903D3_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitForDataInstallerExit

class procedure TnsStartupSupport.WaitForDataUpdaterExit;
//#UC START# *55B26D26011D_4AA7C26401C4_var*
//#UC END# *55B26D26011D_4AA7C26401C4_var*
begin
//#UC START# *55B26D26011D_4AA7C26401C4_impl*
 WaitWhileMutexNotExist(GetDataUpdaterMutexName);
//#UC END# *55B26D26011D_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitForDataUpdaterExit

class procedure TnsStartupSupport.WaitForDownloaderExit;
//#UC START# *55B26D3100FF_4AA7C26401C4_var*
//#UC END# *55B26D3100FF_4AA7C26401C4_var*
begin
//#UC START# *55B26D3100FF_4AA7C26401C4_impl*
 WaitWhileMutexNotExist(GetDownloaderMutexName);
//#UC END# *55B26D3100FF_4AA7C26401C4_impl*
end;//TnsStartupSupport.WaitForDownloaderExit

function TnsStartupSupport.CheckAndRunSupportProcessesIfNeed: Boolean;
//#UC START# *55B26D3F00DD_4AA7C26401C4_var*
type
 TIsProcessRunningFunc = function: Boolean of object;
 //
 procedure WaitWhileLoginIsLocked(const aIsProcessRunningFunc: TIsProcessRunningFunc);
 begin
  while IsLoginLocked do
   if aIsProcessRunningFunc then
   begin
    afw.ProcessMessages;
    Sleep(c_SleepTime);
   end
   else
    Abort;
 end;
 //
//#UC END# *55B26D3F00DD_4AA7C26401C4_var*
begin
//#UC START# *55B26D3F00DD_4AA7C26401C4_impl*
 Result := False;
 //
 if IsRunDataInstallerParamExist then
 begin
  RunDataInstallerProcess(GetDataInstallerCommandLine);
  //
  StartupCompletedNotify;
  try
   LockLogin;
   WaitWhileLoginIsLocked(IsDataInstallerProcessRunning);
  finally
   StartupPendingNotify;
  end;
  //
  Result := IsDataInstallerProcessRunning;
 end
 else
  if IsRunDataUpdaterParamExist then
  begin
   RunDataUpdaterProcess(GetDataUpdaterCommandLine);
   //
   StartupCompletedNotify;
   try
    LockLogin;
    WaitWhileLoginIsLocked(IsDataUpdaterProcessRunning);
   finally
    StartupPendingNotify;
   end;
   //
   Result := IsDataUpdaterProcessRunning;
  end
  else
   if IsRunDownloaderParamExist then
   begin
    RunDownloaderProcess(GetDownloaderCommandLine);
    //
    StartupCompletedNotify;
    try
     LockLogin;
     WaitWhileLoginIsLocked(IsDownloaderProcessRunning);
    finally
     StartupPendingNotify;
    end;
    //
    Result := IsDownloaderProcessRunning;
   end;
//#UC END# *55B26D3F00DD_4AA7C26401C4_impl*
end;//TnsStartupSupport.CheckAndRunSupportProcessesIfNeed

procedure TnsStartupSupport.TryActivateMainForm;
//#UC START# *55F80B1F01CD_4AA7C26401C4_var*
var
 l_CurrWnd,
 l_MyTID,
 l_CurrTID: THandle;
//#UC END# *55F80B1F01CD_4AA7C26401C4_var*
begin
//#UC START# *55F80B1F01CD_4AA7C26401C4_impl*
 if Assigned(Application.MainForm) and Application.MainForm.HandleAllocated then
 begin
  if (Application.MainForm.WindowState = wsMinimized) then
   ShowWindow(Application.MainForm.Handle, SW_RESTORE);

  l_CurrWnd := GetForegroundWindow;
  if (l_CurrWnd <> Application.MainForm.Handle) then
  begin
   l_MyTID := GetCurrentThreadId;
   l_CurrTID := GetWindowThreadProcessId(l_CurrWnd, nil);
   AttachThreadInput(l_MyTID, l_CurrTID, True);
   try
    BringWindowToTop(Application.MainForm.Handle);
    SetForegroundWindow(Application.MainForm.Handle);
   finally
    AttachThreadInput(l_MyTID, l_CurrTID, False);
   end;
  end;
 end;
//#UC END# *55F80B1F01CD_4AA7C26401C4_impl*
end;//TnsStartupSupport.TryActivateMainForm

class function TnsStartupSupport.Instance: TnsStartupSupport;
 {* Метод получения экземпляра синглетона TnsStartupSupport }
begin
 if (g_TnsStartupSupport = nil) then
 begin
  l3System.AddExitProc(TnsStartupSupportFree);
  g_TnsStartupSupport := Create;
 end;
 Result := g_TnsStartupSupport;
end;//TnsStartupSupport.Instance

class function TnsStartupSupport.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TnsStartupSupport <> nil;
end;//TnsStartupSupport.Exists

procedure TnsStartupSupport.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4AA7C26401C4_var*
//#UC END# *479731C50290_4AA7C26401C4_var*
begin
//#UC START# *479731C50290_4AA7C26401C4_impl*
 l3Free(f_CheckRunTimer);
 DeallocateHWnd(f_StartupSupportWindow);
 //
 f_LoginLockCount := 0;
 //
 inherited;
//#UC END# *479731C50290_4AA7C26401C4_impl*
end;//TnsStartupSupport.Cleanup

initialization
//#UC START# *55B271BE0327*
 g_ShowActiveFormMessage := RegisterWindowMessage(c_ShowActiveFormMessageName);
 g_UnlockLoginMessage := RegisterWindowMessage(c_UnlockLoginMessageName);
 g_OpenByNumberMessage := RegisterWindowMessage(c_OpenByNumberMessageName);
 g_RunDataInstallerMessage := RegisterWindowMessage(c_RunDataInstallerMessageName);
 g_RunDataUpdaterMessage := RegisterWindowMessage(c_RunDataUpdaterMessageName);
 g_RunDownloaderMessage := RegisterWindowMessage(c_RunDownloaderMessageName);
 g_GetAppHandleMessage := RegisterWindowMessage(c_GetAppHandleMessageName);
 //
 g_CriticalSection := TCriticalSection.Create;
//#UC END# *55B271BE0327*

end.
