unit SysUtilsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\SysUtilsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "SysUtilsPack" MUID: (4F5EFA23015A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
 , l3Interfaces
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , l3TabService
 , l3SysUtils
 , Windows
 , JclSysInfo
 , l3Base
 , l3String
 , SysUtils
 , Classes
 , DateUtils
 , Graphics
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 {$If NOT Defined(NoVCL)}
 , Clipbrd
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Utils
 , l3CStringDataObject
 , l3Chars
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4F5EFA23015Aimpl_uses*
 //#UC END# *4F5EFA23015Aimpl_uses*
;

type
 TkwHasTabs = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта HasTabs }
  private
   function HasTabs(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта HasTabs }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwHasTabs

 TkwIsUnder64 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IsUnder64 }
  private
   function IsUnder64(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта IsUnder64 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsUnder64

 TkwComputerName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ComputerName }
  private
   function ComputerName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта ComputerName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwComputerName

 TkwOSName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта OSName }
  private
   function OSName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта OSName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwOSName

 TkwRandom = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Random }
  private
   function Random(const aCtx: TtfwContext;
    aMax: Integer): Integer;
    {* Реализация слова скрипта Random }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRandom

 TkwRandomize = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Randomize }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRandomize

 TkwSetRandSeed = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetRandSeed }
  private
   procedure SetRandSeed(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта SetRandSeed }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetRandSeed

 TkwRGB2String = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта RGB2String }
  private
   function RGB2String(const aCtx: TtfwContext;
    aB: Integer;
    aG: Integer;
    aR: Integer): AnsiString;
    {* Реализация слова скрипта RGB2String }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRGB2String

 TkwIntToStr = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IntToStr }
  private
   function IntToStr(const aCtx: TtfwContext;
    aValue: Integer): AnsiString;
    {* Реализация слова скрипта IntToStr }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIntToStr

 TkwIsXE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IsXE }
  private
   function IsXE(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта IsXE }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsXE

 TkwWinExec = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WinExec }
  private
   procedure WinExec(const aCtx: TtfwContext;
    const aPath: AnsiString);
    {* Реализация слова скрипта WinExec }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWinExec

 TkwScriptFileName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта script:FileName }
  private
   function script_FileName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта script:FileName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScriptFileName

 TkwSysutilsChangeFileExt = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ChangeFileExt }
  private
   function sysutils_ChangeFileExt(const aCtx: TtfwContext;
    const anExt: AnsiString;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ChangeFileExt }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsChangeFileExt

 TkwSysutilsExtractFileName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFileName }
  private
   function sysutils_ExtractFileName(const aCtx: TtfwContext;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ExtractFileName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsExtractFileName

 TkwSysutilsExtractFilePath = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFilePath }
  private
   function sysutils_ExtractFilePath(const aCtx: TtfwContext;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ExtractFilePath }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsExtractFilePath

 TkwSysutilsExtractFileDrive = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFileDrive }
  private
   function sysutils_ExtractFileDrive(const aCtx: TtfwContext;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ExtractFileDrive }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsExtractFileDrive

 TkwSysutilsDirectoryExists = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:DirectoryExists }
  private
   function sysutils_DirectoryExists(const aCtx: TtfwContext;
    const aPath: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:DirectoryExists }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsDirectoryExists

 TkwSysutilsFileExists = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:FileExists }
  private
   function sysutils_FileExists(const aCtx: TtfwContext;
    const aPath: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:FileExists }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsFileExists

 TkwSysutilsForceDirectories = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ForceDirectories }
  private
   function sysutils_ForceDirectories(const aCtx: TtfwContext;
    const aPath: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:ForceDirectories }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsForceDirectories

 TkwSetAppPath2CurrentDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetAppPath2CurrentDir }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetAppPath2CurrentDir

 TkwApplicationExeName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:ExeName }
  private
   function application_ExeName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта application:ExeName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationExeName

 TkwGetTickCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetTickCount }
  private
   function GetTickCount(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта GetTickCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetTickCount

 TkwApplicationActionIdle = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:ActionIdle }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationActionIdle

 TkwClipboardClear = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:clear }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwClipboardClear

 TkwSetLocalDate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalDate }
  private
   procedure SetLocalDate(const aCtx: TtfwContext;
    aDay: Integer;
    aMonth: Integer;
    anYear: Integer);
    {* Реализация слова скрипта SetLocalDate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetLocalDate

 TkwSetLocalTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalTime }
  private
   procedure SetLocalTime(const aCtx: TtfwContext;
    aMilli: Integer;
    aSecond: Integer;
    aMinute: Integer;
    anHour: Integer);
    {* Реализация слова скрипта SetLocalTime }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetLocalTime

 TkwSetLocalDateTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalDateTime }
  private
   procedure SetLocalDateTime(const aCtx: TtfwContext;
    aMilli: Integer;
    aSecond: Integer;
    aMinute: Integer;
    anHour: Integer;
    aDay: Integer;
    aMonth: Integer;
    anYear: Integer);
    {* Реализация слова скрипта SetLocalDateTime }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetLocalDateTime

 TkwGetLocalDate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalDate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetLocalDate

 TkwGetLocalDateTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalDateTime }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetLocalDateTime

 TkwGetLocalTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalTime }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetLocalTime

 TkwStartTimer = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StartTimer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStartTimer

 TkwStopTimer = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimer }
  private
   function StopTimer(const aCtx: TtfwContext;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimer }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimer

 TkwStopTimerEx = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimerEx }
  private
   function StopTimerEx(const aCtx: TtfwContext;
    const aSubName: AnsiString;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimerEx }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimerEx

 TkwTimeToLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта TimeToLog }
  private
   procedure TimeToLog(const aCtx: TtfwContext;
    aValue: Integer;
    const aSubName: AnsiString;
    const aName: AnsiString);
    {* Реализация слова скрипта TimeToLog }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTimeToLog

 TkwShiftDate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ShiftDate }
  private
   procedure ShiftDate(const aCtx: TtfwContext;
    aDeltaD: Integer;
    aDeltaM: Integer;
    aDeltaY: Integer);
    {* Реализация слова скрипта ShiftDate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShiftDate

 TkwShiftTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ShiftTime }
  private
   procedure ShiftTime(const aCtx: TtfwContext;
    aDeltaMilli: Integer);
    {* Реализация слова скрипта ShiftTime }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShiftTime

 TkwClipboardGetFormattedText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:GetFormattedText }
  private
   function clipboard_GetFormattedText(const aCtx: TtfwContext;
    const aFormat: TtfwStackValue): Il3CString;
    {* Реализация слова скрипта clipboard:GetFormattedText }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwClipboardGetFormattedText

 TkwClipboardSetText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:SetText }
  private
   procedure clipboard_SetText(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта clipboard:SetText }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwClipboardSetText

 TkwScriptExceptionStack = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта script:ExceptionStack }
  private
   function script_ExceptionStack(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта script:ExceptionStack }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScriptExceptionStack

 TkwSysutilsParamCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ParamCount }
  private
   function sysutils_ParamCount(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:ParamCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsParamCount

 TkwSysutilsParamStr = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ParamStr }
  private
   function sysutils_ParamStr(const aCtx: TtfwContext;
    anIndex: Integer): AnsiString;
    {* Реализация слова скрипта sysutils:ParamStr }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsParamStr

 TkwSysutilsGetCurrentDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:GetCurrentDir }
  private
   function sysutils_GetCurrentDir(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта sysutils:GetCurrentDir }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsGetCurrentDir

 TkwSysutilsSetCurrentDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:SetCurrentDir }
  private
   function sysutils_SetCurrentDir(const aCtx: TtfwContext;
    const aDir: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:SetCurrentDir }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsSetCurrentDir

 TkwSysutilsCreateDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:CreateDir }
  private
   function sysutils_CreateDir(const aCtx: TtfwContext;
    const aDir: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:CreateDir }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsCreateDir

 TkwSysutilsRemoveDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:RemoveDir }
  private
   function sysutils_RemoveDir(const aCtx: TtfwContext;
    const aDir: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:RemoveDir }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsRemoveDir

 TkwSysutilsLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:Log }
  private
   procedure sysutils_Log(const aCtx: TtfwContext;
    const aStr: AnsiString);
    {* Реализация слова скрипта sysutils:Log }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsLog

 TkwStopTimerNoLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimerNoLog }
  private
   function StopTimerNoLog(const aCtx: TtfwContext;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimerNoLog }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimerNoLog

 TkwStopTimerExNoLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimerExNoLog }
  private
   function StopTimerExNoLog(const aCtx: TtfwContext;
    const aSubName: AnsiString;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimerExNoLog }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimerExNoLog

 TkwSysutilsLocale = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:Locale }
  private
   function sysutils_Locale(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:Locale }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsLocale

 TkwSysutilsCodePage = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:CodePage }
  private
   function sysutils_CodePage(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:CodePage }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsCodePage

 TkwSysutilsGetACP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:GetACP }
  private
   function sysutils_GetACP(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:GetACP }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsGetACP

 TkwIntToHex = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IntToHex }
  private
   function IntToHex(const aCtx: TtfwContext;
    aValue: Integer;
    aDigits: Integer): AnsiString;
    {* Реализация слова скрипта IntToHex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIntToHex

 TkwSysutilsCreateGUID = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:CreateGUID }
  private
   function sysutils_CreateGUID(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта sysutils:CreateGUID }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsCreateGUID

 TkwCreateDOSProcessRedirected = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта CreateDOSProcessRedirected }
  private
   function CreateDOSProcessRedirected(const aCtx: TtfwContext;
    const CommandLine: AnsiString;
    const InputFile: AnsiString;
    const OutputFile: AnsiString): Boolean;
    {* Реализация слова скрипта CreateDOSProcessRedirected }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCreateDOSProcessRedirected

 TSysUtilsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TSysUtilsPackResNameGetter

function TkwHasTabs.HasTabs(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта HasTabs }
//#UC START# *555F0CD4039A_555F0CD4039A_Word_var*
//#UC END# *555F0CD4039A_555F0CD4039A_Word_var*
begin
//#UC START# *555F0CD4039A_555F0CD4039A_Word_impl*
 Result := Tl3TabService.Instance.HasTabs;
//#UC END# *555F0CD4039A_555F0CD4039A_Word_impl*
end;//TkwHasTabs.HasTabs

class function TkwHasTabs.GetWordNameForRegister: AnsiString;
begin
 Result := 'HasTabs';
end;//TkwHasTabs.GetWordNameForRegister

function TkwHasTabs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwHasTabs.GetResultTypeInfo

function TkwHasTabs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwHasTabs.GetAllParamsCount

function TkwHasTabs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwHasTabs.ParamsTypes

procedure TkwHasTabs.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(HasTabs(aCtx));
end;//TkwHasTabs.DoDoIt

function TkwIsUnder64.IsUnder64(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта IsUnder64 }
//#UC START# *555F0D370239_555F0D370239_Word_var*
//#UC END# *555F0D370239_555F0D370239_Word_var*
begin
//#UC START# *555F0D370239_555F0D370239_Word_impl*
 Result := l3Is64System;
//#UC END# *555F0D370239_555F0D370239_Word_impl*
end;//TkwIsUnder64.IsUnder64

class function TkwIsUnder64.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsUnder64';
end;//TkwIsUnder64.GetWordNameForRegister

function TkwIsUnder64.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsUnder64.GetResultTypeInfo

function TkwIsUnder64.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwIsUnder64.GetAllParamsCount

function TkwIsUnder64.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwIsUnder64.ParamsTypes

procedure TkwIsUnder64.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(IsUnder64(aCtx));
end;//TkwIsUnder64.DoDoIt

function TkwComputerName.ComputerName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта ComputerName }
//#UC START# *555F0D840371_555F0D840371_Word_var*
var
 l_CompSize : Integer;
 l_S : AnsiString;
//#UC END# *555F0D840371_555F0D840371_Word_var*
begin
//#UC START# *555F0D840371_555F0D840371_Word_impl*
 l_CompSize := MAX_COMPUTERNAME_LENGTH + 1;
 SetLength(l_S, l_CompSize);

 Win32Check(GetComputerNameA(PAnsiChar(l_S), LongWord(l_CompSize)));
 SetLength(l_S, l_CompSize);
 Result := l_S;
//#UC END# *555F0D840371_555F0D840371_Word_impl*
end;//TkwComputerName.ComputerName

class function TkwComputerName.GetWordNameForRegister: AnsiString;
begin
 Result := 'ComputerName';
end;//TkwComputerName.GetWordNameForRegister

function TkwComputerName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwComputerName.GetResultTypeInfo

function TkwComputerName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwComputerName.GetAllParamsCount

function TkwComputerName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwComputerName.ParamsTypes

procedure TkwComputerName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(ComputerName(aCtx));
end;//TkwComputerName.DoDoIt

function TkwOSName.OSName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта OSName }
//#UC START# *555F0DC900C0_555F0DC900C0_Word_var*
//#UC END# *555F0DC900C0_555F0DC900C0_Word_var*
begin
//#UC START# *555F0DC900C0_555F0DC900C0_Word_impl*
 Result := GetWindowsVersionString;
//#UC END# *555F0DC900C0_555F0DC900C0_Word_impl*
end;//TkwOSName.OSName

class function TkwOSName.GetWordNameForRegister: AnsiString;
begin
 Result := 'OSName';
end;//TkwOSName.GetWordNameForRegister

function TkwOSName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwOSName.GetResultTypeInfo

function TkwOSName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwOSName.GetAllParamsCount

function TkwOSName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwOSName.ParamsTypes

procedure TkwOSName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(OSName(aCtx));
end;//TkwOSName.DoDoIt

function TkwRandom.Random(const aCtx: TtfwContext;
 aMax: Integer): Integer;
 {* Реализация слова скрипта Random }
//#UC START# *555F0DF30159_555F0DF30159_Word_var*
//#UC END# *555F0DF30159_555F0DF30159_Word_var*
begin
//#UC START# *555F0DF30159_555F0DF30159_Word_impl*
 Result := System.Random(aMax);
//#UC END# *555F0DF30159_555F0DF30159_Word_impl*
end;//TkwRandom.Random

class function TkwRandom.GetWordNameForRegister: AnsiString;
begin
 Result := 'Random';
end;//TkwRandom.GetWordNameForRegister

function TkwRandom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwRandom.GetResultTypeInfo

function TkwRandom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRandom.GetAllParamsCount

function TkwRandom.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwRandom.ParamsTypes

procedure TkwRandom.DoDoIt(const aCtx: TtfwContext);
var l_aMax: Integer;
begin
 try
  l_aMax := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMax: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Random(aCtx, l_aMax));
end;//TkwRandom.DoDoIt

class function TkwRandomize.GetWordNameForRegister: AnsiString;
begin
 Result := 'Randomize';
end;//TkwRandomize.GetWordNameForRegister

function TkwRandomize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwRandomize.GetResultTypeInfo

function TkwRandomize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwRandomize.GetAllParamsCount

function TkwRandomize.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwRandomize.ParamsTypes

procedure TkwRandomize.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F0E15007C_Word_var*
//#UC END# *4DAEEDE10285_555F0E15007C_Word_var*
begin
//#UC START# *4DAEEDE10285_555F0E15007C_Word_impl*
 System.Randomize;
//#UC END# *4DAEEDE10285_555F0E15007C_Word_impl*
end;//TkwRandomize.DoDoIt

procedure TkwSetRandSeed.SetRandSeed(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта SetRandSeed }
//#UC START# *555F0E3300FB_555F0E3300FB_Word_var*
//#UC END# *555F0E3300FB_555F0E3300FB_Word_var*
begin
//#UC START# *555F0E3300FB_555F0E3300FB_Word_impl*
 RandSeed := aValue;
//#UC END# *555F0E3300FB_555F0E3300FB_Word_impl*
end;//TkwSetRandSeed.SetRandSeed

class function TkwSetRandSeed.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetRandSeed';
end;//TkwSetRandSeed.GetWordNameForRegister

function TkwSetRandSeed.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetRandSeed.GetResultTypeInfo

function TkwSetRandSeed.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSetRandSeed.GetAllParamsCount

function TkwSetRandSeed.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwSetRandSeed.ParamsTypes

procedure TkwSetRandSeed.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetRandSeed(aCtx, l_aValue);
end;//TkwSetRandSeed.DoDoIt

function TkwRGB2String.RGB2String(const aCtx: TtfwContext;
 aB: Integer;
 aG: Integer;
 aR: Integer): AnsiString;
 {* Реализация слова скрипта RGB2String }
//#UC START# *555F0E6D015F_555F0E6D015F_Word_var*
var
 l_Color : TColor;
//#UC END# *555F0E6D015F_555F0E6D015F_Word_var*
begin
//#UC START# *555F0E6D015F_555F0E6D015F_Word_impl*
 l_Color := TColor(RGB(aR, aG, aB));
 Result := ColorToString(l_Color);
//#UC END# *555F0E6D015F_555F0E6D015F_Word_impl*
end;//TkwRGB2String.RGB2String

class function TkwRGB2String.GetWordNameForRegister: AnsiString;
begin
 Result := 'RGB2String';
end;//TkwRGB2String.GetWordNameForRegister

function TkwRGB2String.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwRGB2String.GetResultTypeInfo

function TkwRGB2String.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwRGB2String.GetAllParamsCount

function TkwRGB2String.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwRGB2String.ParamsTypes

procedure TkwRGB2String.DoDoIt(const aCtx: TtfwContext);
var l_aB: Integer;
var l_aG: Integer;
var l_aR: Integer;
begin
 try
  l_aB := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aB: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aG := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aG: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aR := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aR: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(RGB2String(aCtx, l_aB, l_aG, l_aR));
end;//TkwRGB2String.DoDoIt

function TkwIntToStr.IntToStr(const aCtx: TtfwContext;
 aValue: Integer): AnsiString;
 {* Реализация слова скрипта IntToStr }
//#UC START# *555F0F000329_555F0F000329_Word_var*
//#UC END# *555F0F000329_555F0F000329_Word_var*
begin
//#UC START# *555F0F000329_555F0F000329_Word_impl*
 Result := SysUtils.IntToStr(aValue);
//#UC END# *555F0F000329_555F0F000329_Word_impl*
end;//TkwIntToStr.IntToStr

class function TkwIntToStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'IntToStr';
end;//TkwIntToStr.GetWordNameForRegister

function TkwIntToStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwIntToStr.GetResultTypeInfo

function TkwIntToStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIntToStr.GetAllParamsCount

function TkwIntToStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwIntToStr.ParamsTypes

procedure TkwIntToStr.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(IntToStr(aCtx, l_aValue));
end;//TkwIntToStr.DoDoIt

function TkwIsXE.IsXE(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта IsXE }
//#UC START# *555F0F220176_555F0F220176_Word_var*
//#UC END# *555F0F220176_555F0F220176_Word_var*
begin
//#UC START# *555F0F220176_555F0F220176_Word_impl*
 {$IfDef XE}
 Result := true;
 {$Else  XE}
 Result := false;
 {$EndIf XE}
//#UC END# *555F0F220176_555F0F220176_Word_impl*
end;//TkwIsXE.IsXE

class function TkwIsXE.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsXE';
end;//TkwIsXE.GetWordNameForRegister

function TkwIsXE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsXE.GetResultTypeInfo

function TkwIsXE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwIsXE.GetAllParamsCount

function TkwIsXE.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwIsXE.ParamsTypes

procedure TkwIsXE.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(IsXE(aCtx));
end;//TkwIsXE.DoDoIt

procedure TkwWinExec.WinExec(const aCtx: TtfwContext;
 const aPath: AnsiString);
 {* Реализация слова скрипта WinExec }
//#UC START# *555F0F4A0046_555F0F4A0046_Word_var*
var
 l_S : AnsiString;
//#UC END# *555F0F4A0046_555F0F4A0046_Word_var*
begin
//#UC START# *555F0F4A0046_555F0F4A0046_Word_impl*
 l_S := aPath;
 if (ExtractFilePath(l_S) = '') then
  l_S := ExtractFilePath(ParamStr(0)) + l_S;
 Windows.WinExec(PAnsiChar(l_S), {SW_HIDE}SW_SHOWNORMAL);
//#UC END# *555F0F4A0046_555F0F4A0046_Word_impl*
end;//TkwWinExec.WinExec

class function TkwWinExec.GetWordNameForRegister: AnsiString;
begin
 Result := 'WinExec';
end;//TkwWinExec.GetWordNameForRegister

function TkwWinExec.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwWinExec.GetResultTypeInfo

function TkwWinExec.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWinExec.GetAllParamsCount

function TkwWinExec.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwWinExec.ParamsTypes

procedure TkwWinExec.DoDoIt(const aCtx: TtfwContext);
var l_aPath: AnsiString;
begin
 try
  l_aPath := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPath: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 WinExec(aCtx, l_aPath);
end;//TkwWinExec.DoDoIt

function TkwScriptFileName.script_FileName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта script:FileName }
//#UC START# *555F0F880363_555F0F880363_Word_var*
//#UC END# *555F0F880363_555F0F880363_Word_var*
begin
//#UC START# *555F0F880363_555F0F880363_Word_impl*
 Result := aCtx.rStreamFactory.FileName;
//#UC END# *555F0F880363_555F0F880363_Word_impl*
end;//TkwScriptFileName.script_FileName

class function TkwScriptFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:FileName';
end;//TkwScriptFileName.GetWordNameForRegister

function TkwScriptFileName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwScriptFileName.GetResultTypeInfo

function TkwScriptFileName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwScriptFileName.GetAllParamsCount

function TkwScriptFileName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwScriptFileName.ParamsTypes

procedure TkwScriptFileName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(script_FileName(aCtx));
end;//TkwScriptFileName.DoDoIt

function TkwSysutilsChangeFileExt.sysutils_ChangeFileExt(const aCtx: TtfwContext;
 const anExt: AnsiString;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ChangeFileExt }
//#UC START# *555F0FC90086_555F0FC90086_Word_var*
//#UC END# *555F0FC90086_555F0FC90086_Word_var*
begin
//#UC START# *555F0FC90086_555F0FC90086_Word_impl*
 Result := ChangeFileExt(aName, anExt);
//#UC END# *555F0FC90086_555F0FC90086_Word_impl*
end;//TkwSysutilsChangeFileExt.sysutils_ChangeFileExt

class function TkwSysutilsChangeFileExt.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ChangeFileExt';
end;//TkwSysutilsChangeFileExt.GetWordNameForRegister

function TkwSysutilsChangeFileExt.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSysutilsChangeFileExt.GetResultTypeInfo

function TkwSysutilsChangeFileExt.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwSysutilsChangeFileExt.GetAllParamsCount

function TkwSysutilsChangeFileExt.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwSysutilsChangeFileExt.ParamsTypes

procedure TkwSysutilsChangeFileExt.DoDoIt(const aCtx: TtfwContext);
var l_anExt: AnsiString;
var l_aName: AnsiString;
begin
 try
  l_anExt := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anExt: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(sysutils_ChangeFileExt(aCtx, l_anExt, l_aName));
end;//TkwSysutilsChangeFileExt.DoDoIt

function TkwSysutilsExtractFileName.sysutils_ExtractFileName(const aCtx: TtfwContext;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ExtractFileName }
//#UC START# *555F1009034D_555F1009034D_Word_var*
//#UC END# *555F1009034D_555F1009034D_Word_var*
begin
//#UC START# *555F1009034D_555F1009034D_Word_impl*
 Result := ExtractFileName(aName);
//#UC END# *555F1009034D_555F1009034D_Word_impl*
end;//TkwSysutilsExtractFileName.sysutils_ExtractFileName

class function TkwSysutilsExtractFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ExtractFileName';
end;//TkwSysutilsExtractFileName.GetWordNameForRegister

function TkwSysutilsExtractFileName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSysutilsExtractFileName.GetResultTypeInfo

function TkwSysutilsExtractFileName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsExtractFileName.GetAllParamsCount

function TkwSysutilsExtractFileName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsExtractFileName.ParamsTypes

procedure TkwSysutilsExtractFileName.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(sysutils_ExtractFileName(aCtx, l_aName));
end;//TkwSysutilsExtractFileName.DoDoIt

function TkwSysutilsExtractFilePath.sysutils_ExtractFilePath(const aCtx: TtfwContext;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ExtractFilePath }
//#UC START# *555F10300119_555F10300119_Word_var*
//#UC END# *555F10300119_555F10300119_Word_var*
begin
//#UC START# *555F10300119_555F10300119_Word_impl*
 Result := ExtractFilePath(aName);
//#UC END# *555F10300119_555F10300119_Word_impl*
end;//TkwSysutilsExtractFilePath.sysutils_ExtractFilePath

class function TkwSysutilsExtractFilePath.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ExtractFilePath';
end;//TkwSysutilsExtractFilePath.GetWordNameForRegister

function TkwSysutilsExtractFilePath.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSysutilsExtractFilePath.GetResultTypeInfo

function TkwSysutilsExtractFilePath.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsExtractFilePath.GetAllParamsCount

function TkwSysutilsExtractFilePath.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsExtractFilePath.ParamsTypes

procedure TkwSysutilsExtractFilePath.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(sysutils_ExtractFilePath(aCtx, l_aName));
end;//TkwSysutilsExtractFilePath.DoDoIt

function TkwSysutilsExtractFileDrive.sysutils_ExtractFileDrive(const aCtx: TtfwContext;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ExtractFileDrive }
//#UC START# *555F105D037F_555F105D037F_Word_var*
//#UC END# *555F105D037F_555F105D037F_Word_var*
begin
//#UC START# *555F105D037F_555F105D037F_Word_impl*
 Result := ExtractFileDrive(aName);
//#UC END# *555F105D037F_555F105D037F_Word_impl*
end;//TkwSysutilsExtractFileDrive.sysutils_ExtractFileDrive

class function TkwSysutilsExtractFileDrive.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ExtractFileDrive';
end;//TkwSysutilsExtractFileDrive.GetWordNameForRegister

function TkwSysutilsExtractFileDrive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSysutilsExtractFileDrive.GetResultTypeInfo

function TkwSysutilsExtractFileDrive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsExtractFileDrive.GetAllParamsCount

function TkwSysutilsExtractFileDrive.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsExtractFileDrive.ParamsTypes

procedure TkwSysutilsExtractFileDrive.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(sysutils_ExtractFileDrive(aCtx, l_aName));
end;//TkwSysutilsExtractFileDrive.DoDoIt

function TkwSysutilsDirectoryExists.sysutils_DirectoryExists(const aCtx: TtfwContext;
 const aPath: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:DirectoryExists }
//#UC START# *555F10880253_555F10880253_Word_var*
//#UC END# *555F10880253_555F10880253_Word_var*
begin
//#UC START# *555F10880253_555F10880253_Word_impl*
 Result := DirectoryExists(aPath);
//#UC END# *555F10880253_555F10880253_Word_impl*
end;//TkwSysutilsDirectoryExists.sysutils_DirectoryExists

class function TkwSysutilsDirectoryExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:DirectoryExists';
end;//TkwSysutilsDirectoryExists.GetWordNameForRegister

function TkwSysutilsDirectoryExists.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSysutilsDirectoryExists.GetResultTypeInfo

function TkwSysutilsDirectoryExists.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsDirectoryExists.GetAllParamsCount

function TkwSysutilsDirectoryExists.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsDirectoryExists.ParamsTypes

procedure TkwSysutilsDirectoryExists.DoDoIt(const aCtx: TtfwContext);
var l_aPath: AnsiString;
begin
 try
  l_aPath := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPath: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(sysutils_DirectoryExists(aCtx, l_aPath));
end;//TkwSysutilsDirectoryExists.DoDoIt

function TkwSysutilsFileExists.sysutils_FileExists(const aCtx: TtfwContext;
 const aPath: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:FileExists }
//#UC START# *555F10BB02BF_555F10BB02BF_Word_var*
//#UC END# *555F10BB02BF_555F10BB02BF_Word_var*
begin
//#UC START# *555F10BB02BF_555F10BB02BF_Word_impl*
 Result := FileExists(aPath);
//#UC END# *555F10BB02BF_555F10BB02BF_Word_impl*
end;//TkwSysutilsFileExists.sysutils_FileExists

class function TkwSysutilsFileExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:FileExists';
end;//TkwSysutilsFileExists.GetWordNameForRegister

function TkwSysutilsFileExists.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSysutilsFileExists.GetResultTypeInfo

function TkwSysutilsFileExists.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsFileExists.GetAllParamsCount

function TkwSysutilsFileExists.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsFileExists.ParamsTypes

procedure TkwSysutilsFileExists.DoDoIt(const aCtx: TtfwContext);
var l_aPath: AnsiString;
begin
 try
  l_aPath := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPath: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(sysutils_FileExists(aCtx, l_aPath));
end;//TkwSysutilsFileExists.DoDoIt

function TkwSysutilsForceDirectories.sysutils_ForceDirectories(const aCtx: TtfwContext;
 const aPath: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:ForceDirectories }
//#UC START# *555F10EC036B_555F10EC036B_Word_var*
//#UC END# *555F10EC036B_555F10EC036B_Word_var*
begin
//#UC START# *555F10EC036B_555F10EC036B_Word_impl*
 Result := ForceDirectories(aPath);
//#UC END# *555F10EC036B_555F10EC036B_Word_impl*
end;//TkwSysutilsForceDirectories.sysutils_ForceDirectories

class function TkwSysutilsForceDirectories.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ForceDirectories';
end;//TkwSysutilsForceDirectories.GetWordNameForRegister

function TkwSysutilsForceDirectories.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSysutilsForceDirectories.GetResultTypeInfo

function TkwSysutilsForceDirectories.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsForceDirectories.GetAllParamsCount

function TkwSysutilsForceDirectories.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsForceDirectories.ParamsTypes

procedure TkwSysutilsForceDirectories.DoDoIt(const aCtx: TtfwContext);
var l_aPath: AnsiString;
begin
 try
  l_aPath := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aPath: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(sysutils_ForceDirectories(aCtx, l_aPath));
end;//TkwSysutilsForceDirectories.DoDoIt

class function TkwSetAppPath2CurrentDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetAppPath2CurrentDir';
end;//TkwSetAppPath2CurrentDir.GetWordNameForRegister

function TkwSetAppPath2CurrentDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetAppPath2CurrentDir.GetResultTypeInfo

function TkwSetAppPath2CurrentDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSetAppPath2CurrentDir.GetAllParamsCount

function TkwSetAppPath2CurrentDir.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSetAppPath2CurrentDir.ParamsTypes

procedure TkwSetAppPath2CurrentDir.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F11230214_Word_var*
//#UC END# *4DAEEDE10285_555F11230214_Word_var*
begin
//#UC START# *4DAEEDE10285_555F11230214_Word_impl*
 SetCurrentDir(ExtractFilePath(ParamStr(0)));
//#UC END# *4DAEEDE10285_555F11230214_Word_impl*
end;//TkwSetAppPath2CurrentDir.DoDoIt

function TkwApplicationExeName.application_ExeName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта application:ExeName }
//#UC START# *555F117F016A_555F117F016A_Word_var*
//#UC END# *555F117F016A_555F117F016A_Word_var*
begin
//#UC START# *555F117F016A_555F117F016A_Word_impl*
 Result := ParamStr(0);
//#UC END# *555F117F016A_555F117F016A_Word_impl*
end;//TkwApplicationExeName.application_ExeName

class function TkwApplicationExeName.GetWordNameForRegister: AnsiString;
begin
 Result := 'application:ExeName';
end;//TkwApplicationExeName.GetWordNameForRegister

function TkwApplicationExeName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwApplicationExeName.GetResultTypeInfo

function TkwApplicationExeName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwApplicationExeName.GetAllParamsCount

function TkwApplicationExeName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwApplicationExeName.ParamsTypes

procedure TkwApplicationExeName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(application_ExeName(aCtx));
end;//TkwApplicationExeName.DoDoIt

function TkwGetTickCount.GetTickCount(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта GetTickCount }
//#UC START# *555F11A500DD_555F11A500DD_Word_var*
//#UC END# *555F11A500DD_555F11A500DD_Word_var*
begin
//#UC START# *555F11A500DD_555F11A500DD_Word_impl*
 Result := Windows.GetTickCount;
//#UC END# *555F11A500DD_555F11A500DD_Word_impl*
end;//TkwGetTickCount.GetTickCount

class function TkwGetTickCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetTickCount';
end;//TkwGetTickCount.GetWordNameForRegister

function TkwGetTickCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwGetTickCount.GetResultTypeInfo

function TkwGetTickCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetTickCount.GetAllParamsCount

function TkwGetTickCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwGetTickCount.ParamsTypes

procedure TkwGetTickCount.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(GetTickCount(aCtx));
end;//TkwGetTickCount.DoDoIt

class function TkwApplicationActionIdle.GetWordNameForRegister: AnsiString;
begin
 Result := 'application:ActionIdle';
end;//TkwApplicationActionIdle.GetWordNameForRegister

function TkwApplicationActionIdle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwApplicationActionIdle.GetResultTypeInfo

function TkwApplicationActionIdle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwApplicationActionIdle.GetAllParamsCount

function TkwApplicationActionIdle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwApplicationActionIdle.ParamsTypes

procedure TkwApplicationActionIdle.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F11EC00DE_Word_var*
//#UC END# *4DAEEDE10285_555F11EC00DE_Word_var*
begin
//#UC START# *4DAEEDE10285_555F11EC00DE_Word_impl*
 try
  {$IfDef l3HackedVCL}
  {$IfNDef NoVCL}
  Forms.Application.CallActionIdle;
  {$Else   NoVCL}
  Assert(false);
  {$EndIf  NoVCL}
  {$EndIf l3HackedVCL}
 except
  on EListError do;  //541670158
 end;//try..except
//#UC END# *4DAEEDE10285_555F11EC00DE_Word_impl*
end;//TkwApplicationActionIdle.DoDoIt

class function TkwClipboardClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'clipboard:clear';
end;//TkwClipboardClear.GetWordNameForRegister

function TkwClipboardClear.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwClipboardClear.GetResultTypeInfo

function TkwClipboardClear.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwClipboardClear.GetAllParamsCount

function TkwClipboardClear.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwClipboardClear.ParamsTypes

procedure TkwClipboardClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F1F2A01EF_Word_var*
//#UC END# *4DAEEDE10285_555F1F2A01EF_Word_var*
begin
//#UC START# *4DAEEDE10285_555F1F2A01EF_Word_impl*
 l3System.ClearClipboard;
//#UC END# *4DAEEDE10285_555F1F2A01EF_Word_impl*
end;//TkwClipboardClear.DoDoIt

procedure TkwSetLocalDate.SetLocalDate(const aCtx: TtfwContext;
 aDay: Integer;
 aMonth: Integer;
 anYear: Integer);
 {* Реализация слова скрипта SetLocalDate }
//#UC START# *555F1F8D0148_555F1F8D0148_Word_var*
var
 l_Time: TSystemTime;
//#UC END# *555F1F8D0148_555F1F8D0148_Word_var*
begin
//#UC START# *555F1F8D0148_555F1F8D0148_Word_impl*
 Windows.GetLocalTime(l_Time);
 
 l_Time.wDay := aDay;
 l_Time.wMonth := aMonth;
 l_Time.wYear := anYear;

 Windows.SetLocalTime(l_Time);
//#UC END# *555F1F8D0148_555F1F8D0148_Word_impl*
end;//TkwSetLocalDate.SetLocalDate

class function TkwSetLocalDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetLocalDate';
end;//TkwSetLocalDate.GetWordNameForRegister

function TkwSetLocalDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetLocalDate.GetResultTypeInfo

function TkwSetLocalDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwSetLocalDate.GetAllParamsCount

function TkwSetLocalDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwSetLocalDate.ParamsTypes

procedure TkwSetLocalDate.DoDoIt(const aCtx: TtfwContext);
var l_aDay: Integer;
var l_aMonth: Integer;
var l_anYear: Integer;
begin
 try
  l_aDay := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDay: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMonth := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonth: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anYear := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anYear: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetLocalDate(aCtx, l_aDay, l_aMonth, l_anYear);
end;//TkwSetLocalDate.DoDoIt

procedure TkwSetLocalTime.SetLocalTime(const aCtx: TtfwContext;
 aMilli: Integer;
 aSecond: Integer;
 aMinute: Integer;
 anHour: Integer);
 {* Реализация слова скрипта SetLocalTime }
//#UC START# *555F1FE70369_555F1FE70369_Word_var*
var
 l_Time: TSystemTime;
//#UC END# *555F1FE70369_555F1FE70369_Word_var*
begin
//#UC START# *555F1FE70369_555F1FE70369_Word_impl*
 Windows.GetLocalTime(l_Time);

 l_Time.wMilliseconds := aMilli;
 l_Time.wSecond := aSecond;
 l_Time.wMinute := aMinute;
 l_Time.wHour := anHour;

 Windows.SetLocalTime(l_Time);
//#UC END# *555F1FE70369_555F1FE70369_Word_impl*
end;//TkwSetLocalTime.SetLocalTime

class function TkwSetLocalTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetLocalTime';
end;//TkwSetLocalTime.GetWordNameForRegister

function TkwSetLocalTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetLocalTime.GetResultTypeInfo

function TkwSetLocalTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 4;
end;//TkwSetLocalTime.GetAllParamsCount

function TkwSetLocalTime.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwSetLocalTime.ParamsTypes

procedure TkwSetLocalTime.DoDoIt(const aCtx: TtfwContext);
var l_aMilli: Integer;
var l_aSecond: Integer;
var l_aMinute: Integer;
var l_anHour: Integer;
begin
 try
  l_aMilli := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMilli: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSecond := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSecond: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMinute := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMinute: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anHour := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anHour: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetLocalTime(aCtx, l_aMilli, l_aSecond, l_aMinute, l_anHour);
end;//TkwSetLocalTime.DoDoIt

procedure TkwSetLocalDateTime.SetLocalDateTime(const aCtx: TtfwContext;
 aMilli: Integer;
 aSecond: Integer;
 aMinute: Integer;
 anHour: Integer;
 aDay: Integer;
 aMonth: Integer;
 anYear: Integer);
 {* Реализация слова скрипта SetLocalDateTime }
//#UC START# *555F203D014D_555F203D014D_Word_var*
var
 l_Time: TSystemTime;
//#UC END# *555F203D014D_555F203D014D_Word_var*
begin
//#UC START# *555F203D014D_555F203D014D_Word_impl*
 Windows.GetLocalTime(l_Time);

 l_Time.wMilliseconds := aMilli;
 l_Time.wSecond := aSecond;
 l_Time.wMinute := aMinute;
 l_Time.wHour := anHour;
 l_Time.wDay := aDay;
 l_Time.wMonth := aMonth;
 l_Time.wYear := anYear;

 Windows.SetLocalTime(l_Time);
//#UC END# *555F203D014D_555F203D014D_Word_impl*
end;//TkwSetLocalDateTime.SetLocalDateTime

class function TkwSetLocalDateTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetLocalDateTime';
end;//TkwSetLocalDateTime.GetWordNameForRegister

function TkwSetLocalDateTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetLocalDateTime.GetResultTypeInfo

function TkwSetLocalDateTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 7;
end;//TkwSetLocalDateTime.GetAllParamsCount

function TkwSetLocalDateTime.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwSetLocalDateTime.ParamsTypes

procedure TkwSetLocalDateTime.DoDoIt(const aCtx: TtfwContext);
var l_aMilli: Integer;
var l_aSecond: Integer;
var l_aMinute: Integer;
var l_anHour: Integer;
var l_aDay: Integer;
var l_aMonth: Integer;
var l_anYear: Integer;
begin
 try
  l_aMilli := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMilli: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSecond := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSecond: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMinute := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMinute: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anHour := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anHour: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDay := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDay: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aMonth := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMonth: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anYear := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anYear: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetLocalDateTime(aCtx, l_aMilli, l_aSecond, l_aMinute, l_anHour, l_aDay, l_aMonth, l_anYear);
end;//TkwSetLocalDateTime.DoDoIt

class function TkwGetLocalDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetLocalDate';
end;//TkwGetLocalDate.GetWordNameForRegister

function TkwGetLocalDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGetLocalDate.GetResultTypeInfo

function TkwGetLocalDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetLocalDate.GetAllParamsCount

function TkwGetLocalDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwGetLocalDate.ParamsTypes

procedure TkwGetLocalDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F20810000_Word_var*
var
  l_Time: TSystemTime;
//#UC END# *4DAEEDE10285_555F20810000_Word_var*
begin
//#UC START# *4DAEEDE10285_555F20810000_Word_impl*
 Windows.GetLocalTime(l_Time);
 aCtx.rEngine.PushInt(l_Time.wYear);
 aCtx.rEngine.PushInt(l_Time.wMonth);
 aCtx.rEngine.PushInt(l_Time.wDay);
//#UC END# *4DAEEDE10285_555F20810000_Word_impl*
end;//TkwGetLocalDate.DoDoIt

class function TkwGetLocalDateTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetLocalDateTime';
end;//TkwGetLocalDateTime.GetWordNameForRegister

function TkwGetLocalDateTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGetLocalDateTime.GetResultTypeInfo

function TkwGetLocalDateTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetLocalDateTime.GetAllParamsCount

function TkwGetLocalDateTime.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwGetLocalDateTime.ParamsTypes

procedure TkwGetLocalDateTime.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F20C400A3_Word_var*
var
  l_Time: TSystemTime;
//#UC END# *4DAEEDE10285_555F20C400A3_Word_var*
begin
//#UC START# *4DAEEDE10285_555F20C400A3_Word_impl*
 Windows.GetLocalTime(l_Time);
 aCtx.rEngine.PushInt(l_Time.wYear);
 aCtx.rEngine.PushInt(l_Time.wMonth);
 aCtx.rEngine.PushInt(l_Time.wDay);
 aCtx.rEngine.PushInt(l_Time.wHour);
 aCtx.rEngine.PushInt(l_Time.wMinute);
 aCtx.rEngine.PushInt(l_Time.wSecond);
 aCtx.rEngine.PushInt(l_Time.wMilliseconds);
//#UC END# *4DAEEDE10285_555F20C400A3_Word_impl*
end;//TkwGetLocalDateTime.DoDoIt

class function TkwGetLocalTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetLocalTime';
end;//TkwGetLocalTime.GetWordNameForRegister

function TkwGetLocalTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGetLocalTime.GetResultTypeInfo

function TkwGetLocalTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetLocalTime.GetAllParamsCount

function TkwGetLocalTime.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwGetLocalTime.ParamsTypes

procedure TkwGetLocalTime.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F20DD01F9_Word_var*
var
  l_Time: TSystemTime;
//#UC END# *4DAEEDE10285_555F20DD01F9_Word_var*
begin
//#UC START# *4DAEEDE10285_555F20DD01F9_Word_impl*
 Windows.GetLocalTime(l_Time); 
 aCtx.rEngine.PushInt(l_Time.wHour);
 aCtx.rEngine.PushInt(l_Time.wMinute);
 aCtx.rEngine.PushInt(l_Time.wSecond);
 aCtx.rEngine.PushInt(l_Time.wMilliseconds);
//#UC END# *4DAEEDE10285_555F20DD01F9_Word_impl*
end;//TkwGetLocalTime.DoDoIt

class function TkwStartTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'StartTimer';
end;//TkwStartTimer.GetWordNameForRegister

function TkwStartTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwStartTimer.GetResultTypeInfo

function TkwStartTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwStartTimer.GetAllParamsCount

function TkwStartTimer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwStartTimer.ParamsTypes

procedure TkwStartTimer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F210C022D_Word_var*
//#UC END# *4DAEEDE10285_555F210C022D_Word_var*
begin
//#UC START# *4DAEEDE10285_555F210C022D_Word_impl*
 aCtx.rCaller.StartTimer;
//#UC END# *4DAEEDE10285_555F210C022D_Word_impl*
end;//TkwStartTimer.DoDoIt

function TkwStopTimer.StopTimer(const aCtx: TtfwContext;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimer }
//#UC START# *555F212902C6_555F212902C6_Word_var*
//#UC END# *555F212902C6_555F212902C6_Word_var*
begin
//#UC START# *555F212902C6_555F212902C6_Word_impl*
 Result := aCtx.rCaller.StopTimer(aName);
//#UC END# *555F212902C6_555F212902C6_Word_impl*
end;//TkwStopTimer.StopTimer

class function TkwStopTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimer';
end;//TkwStopTimer.GetWordNameForRegister

function TkwStopTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStopTimer.GetResultTypeInfo

function TkwStopTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStopTimer.GetAllParamsCount

function TkwStopTimer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStopTimer.ParamsTypes

procedure TkwStopTimer.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(StopTimer(aCtx, l_aName));
end;//TkwStopTimer.DoDoIt

function TkwStopTimerEx.StopTimerEx(const aCtx: TtfwContext;
 const aSubName: AnsiString;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimerEx }
//#UC START# *555F215300EC_555F215300EC_Word_var*
//#UC END# *555F215300EC_555F215300EC_Word_var*
begin
//#UC START# *555F215300EC_555F215300EC_Word_impl*
 Result := aCtx.rCaller.StopTimer(aName, aSubName);
//#UC END# *555F215300EC_555F215300EC_Word_impl*
end;//TkwStopTimerEx.StopTimerEx

class function TkwStopTimerEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimerEx';
end;//TkwStopTimerEx.GetWordNameForRegister

function TkwStopTimerEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStopTimerEx.GetResultTypeInfo

function TkwStopTimerEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStopTimerEx.GetAllParamsCount

function TkwStopTimerEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStopTimerEx.ParamsTypes

procedure TkwStopTimerEx.DoDoIt(const aCtx: TtfwContext);
var l_aSubName: AnsiString;
var l_aName: AnsiString;
begin
 try
  l_aSubName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(StopTimerEx(aCtx, l_aSubName, l_aName));
end;//TkwStopTimerEx.DoDoIt

procedure TkwTimeToLog.TimeToLog(const aCtx: TtfwContext;
 aValue: Integer;
 const aSubName: AnsiString;
 const aName: AnsiString);
 {* Реализация слова скрипта TimeToLog }
//#UC START# *555F21920151_555F21920151_Word_var*

 function Mangle(const aStr: AnsiString): AnsiString;
(* const
  cLimit = 30;*)
 begin
  Result := aStr;
(*  Result := l3Transliterate(aStr);
  l3Replace(Result, ' ', '_');
  l3Replace(Result, '''', '_');
  l3Replace(Result, '(', '_');
  l3Replace(Result, ')', '_');
  l3Replace(Result, '.', '_');
  if (Length(Result) > cLimit) then
   SetLength(Result, cLimit);*)
 end;
 
var
 l_S1 : AnsiString;
 l_S2 : AnsiString;
//#UC END# *555F21920151_555F21920151_Word_var*
begin
//#UC START# *555F21920151_555F21920151_Word_impl*
 l_S2 := Mangle(aSubName);
 l_S1 := Mangle(aName);
 aCtx.rCaller.TimeToLog(aValue, l_S1, l_S2);
//#UC END# *555F21920151_555F21920151_Word_impl*
end;//TkwTimeToLog.TimeToLog

class function TkwTimeToLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'TimeToLog';
end;//TkwTimeToLog.GetWordNameForRegister

function TkwTimeToLog.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwTimeToLog.GetResultTypeInfo

function TkwTimeToLog.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwTimeToLog.GetAllParamsCount

function TkwTimeToLog.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), @tfw_tiString, @tfw_tiString]);
end;//TkwTimeToLog.ParamsTypes

procedure TkwTimeToLog.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
var l_aSubName: AnsiString;
var l_aName: AnsiString;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aSubName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 TimeToLog(aCtx, l_aValue, l_aSubName, l_aName);
end;//TkwTimeToLog.DoDoIt

procedure TkwShiftDate.ShiftDate(const aCtx: TtfwContext;
 aDeltaD: Integer;
 aDeltaM: Integer;
 aDeltaY: Integer);
 {* Реализация слова скрипта ShiftDate }
//#UC START# *555F2FF3000A_555F2FF3000A_Word_var*
var
 l_Time: TSystemTime;
 l_DelphiTime: TDateTime;
//#UC END# *555F2FF3000A_555F2FF3000A_Word_var*
begin
//#UC START# *555F2FF3000A_555F2FF3000A_Word_impl*
 Windows.GetLocalTime(l_Time);
 with l_Time do
  l_DelphiTime := EncodeDateTime(wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 l_DelphiTime := IncYear(l_DelphiTime, aDeltaY);
 l_DelphiTime := IncMonth(l_DelphiTime, aDeltaM);
 l_DelphiTime := IncDay(l_DelphiTime, aDeltaD);
 with l_Time do
  DecodeDateTime(l_DelphiTime, wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 Windows.SetLocalTime(l_Time);
//#UC END# *555F2FF3000A_555F2FF3000A_Word_impl*
end;//TkwShiftDate.ShiftDate

class function TkwShiftDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'ShiftDate';
end;//TkwShiftDate.GetWordNameForRegister

function TkwShiftDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwShiftDate.GetResultTypeInfo

function TkwShiftDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwShiftDate.GetAllParamsCount

function TkwShiftDate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwShiftDate.ParamsTypes

procedure TkwShiftDate.DoDoIt(const aCtx: TtfwContext);
var l_aDeltaD: Integer;
var l_aDeltaM: Integer;
var l_aDeltaY: Integer;
begin
 try
  l_aDeltaD := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDeltaD: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDeltaM := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDeltaM: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDeltaY := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDeltaY: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ShiftDate(aCtx, l_aDeltaD, l_aDeltaM, l_aDeltaY);
end;//TkwShiftDate.DoDoIt

procedure TkwShiftTime.ShiftTime(const aCtx: TtfwContext;
 aDeltaMilli: Integer);
 {* Реализация слова скрипта ShiftTime }
//#UC START# *555F302402C4_555F302402C4_Word_var*
var
 l_Time: TSystemTime;
 l_DelphiTime: TDateTime;
//#UC END# *555F302402C4_555F302402C4_Word_var*
begin
//#UC START# *555F302402C4_555F302402C4_Word_impl*
 Windows.GetLocalTime(l_Time);
 with l_Time do
  l_DelphiTime := EncodeDateTime(wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 l_DelphiTime := IncMilliSecond(l_DelphiTime, aDeltaMilli);
 with l_Time do
  DecodeDateTime(l_DelphiTime, wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 Windows.SetLocalTime(l_Time);
//#UC END# *555F302402C4_555F302402C4_Word_impl*
end;//TkwShiftTime.ShiftTime

class function TkwShiftTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'ShiftTime';
end;//TkwShiftTime.GetWordNameForRegister

function TkwShiftTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwShiftTime.GetResultTypeInfo

function TkwShiftTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShiftTime.GetAllParamsCount

function TkwShiftTime.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwShiftTime.ParamsTypes

procedure TkwShiftTime.DoDoIt(const aCtx: TtfwContext);
var l_aDeltaMilli: Integer;
begin
 try
  l_aDeltaMilli := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDeltaMilli: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 ShiftTime(aCtx, l_aDeltaMilli);
end;//TkwShiftTime.DoDoIt

function TkwClipboardGetFormattedText.clipboard_GetFormattedText(const aCtx: TtfwContext;
 const aFormat: TtfwStackValue): Il3CString;
 {* Реализация слова скрипта clipboard:GetFormattedText }
//#UC START# *555F35970310_555F35970310_Word_var*
var
 l_Format: Cardinal;
 l_ClipbrdHandle: THandle;
 l_String: PAnsiChar;
//#UC END# *555F35970310_555F35970310_Word_var*
begin
//#UC START# *555F35970310_555F35970310_Word_impl*
 if (aFormat.rType = tfw_vtInt) then
  l_Format := Cardinal(aFormat.AsInt)
 else
  {$If Declared(l3GetClipboardByFormatName)}
  l_Format := Cardinal(l3GetClipboardByFormatName(l3Str(aFormat.AsString)));
  {$Else}
  RunnerAssert(false, 'Не определена функция l3GetClipboardByFormatName', aCtx);
  {$IfEnd}

 {$If Declared(Clipboard)}
 if Clipboard.HasFormat(l_Format) then
 begin
  l_ClipbrdHandle := Clipboard.GetAsHandle(l_Format);
  l_String := GlobalLock(l_ClipbrdHandle);
  try
   //aCtx.rEngine.PushString( StrPas(l_String));
   if (l_Format = CF_UnicodeText) then
    Result := TtfwCStringFactory.C(l3PCharLen(PWideChar(l_String){, GlobalSize(l_ClipbrdHandle) div SizeOf(WideChar)}))
   else
   if (l_Format = CF_Text) OR (l_Format = CF_OEMTExt) then
    Result := TtfwCStringFactory.C(l3PCharLen(l_String{, GlobalSize(l_ClipbrdHandle)}))
   else 
    Result := TtfwCStringFactory.C(l3PCharLen(l_String, GlobalSize(l_ClipbrdHandle)));
  finally
   GlobalUnLock(l_ClipbrdHandle);
  end;
 end//Clipboard.HasFormat(l_Format)
 else
  // plain text
  Result := TtfwCStringFactory.C(Clipboard.AsText);
 {$Else}
 Assert(false);
 {$IfEnd}
//#UC END# *555F35970310_555F35970310_Word_impl*
end;//TkwClipboardGetFormattedText.clipboard_GetFormattedText

class function TkwClipboardGetFormattedText.GetWordNameForRegister: AnsiString;
begin
 Result := 'clipboard:GetFormattedText';
end;//TkwClipboardGetFormattedText.GetWordNameForRegister

function TkwClipboardGetFormattedText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwClipboardGetFormattedText.GetResultTypeInfo

function TkwClipboardGetFormattedText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwClipboardGetFormattedText.GetAllParamsCount

function TkwClipboardGetFormattedText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiStruct]);
end;//TkwClipboardGetFormattedText.ParamsTypes

procedure TkwClipboardGetFormattedText.DoDoIt(const aCtx: TtfwContext);
var l_aFormat: TtfwStackValue;
begin
 try
  l_aFormat := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFormat: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(clipboard_GetFormattedText(aCtx, l_aFormat));
end;//TkwClipboardGetFormattedText.DoDoIt

procedure TkwClipboardSetText.clipboard_SetText(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта clipboard:SetText }
//#UC START# *555F35EC027C_555F35EC027C_Word_var*
//#UC END# *555F35EC027C_555F35EC027C_Word_var*
begin
//#UC START# *555F35EC027C_555F35EC027C_Word_impl*
 {$If Declared(Clipboard)}
 l3System.SetClipboardData(Tl3CStringDataObject.Make(aValue));
 //Clipboard.AsText := l3Str(aValue);
 {$Else}
 Assert(false);
 {$IfEnd}
//#UC END# *555F35EC027C_555F35EC027C_Word_impl*
end;//TkwClipboardSetText.clipboard_SetText

class function TkwClipboardSetText.GetWordNameForRegister: AnsiString;
begin
 Result := 'clipboard:SetText';
end;//TkwClipboardSetText.GetWordNameForRegister

function TkwClipboardSetText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwClipboardSetText.GetResultTypeInfo

function TkwClipboardSetText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwClipboardSetText.GetAllParamsCount

function TkwClipboardSetText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwClipboardSetText.ParamsTypes

procedure TkwClipboardSetText.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Il3CString;
begin
 try
  l_aValue := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 clipboard_SetText(aCtx, l_aValue);
end;//TkwClipboardSetText.DoDoIt

function TkwScriptExceptionStack.script_ExceptionStack(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта script:ExceptionStack }
//#UC START# *5565C43A01FA_5565C43A01FA_Word_var*
//#UC END# *5565C43A01FA_5565C43A01FA_Word_var*
begin
//#UC START# *5565C43A01FA_5565C43A01FA_Word_impl*
 Result := aCtx.rEngine.ExceptionStack;
//#UC END# *5565C43A01FA_5565C43A01FA_Word_impl*
end;//TkwScriptExceptionStack.script_ExceptionStack

class function TkwScriptExceptionStack.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:ExceptionStack';
end;//TkwScriptExceptionStack.GetWordNameForRegister

function TkwScriptExceptionStack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwScriptExceptionStack.GetResultTypeInfo

function TkwScriptExceptionStack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwScriptExceptionStack.GetAllParamsCount

function TkwScriptExceptionStack.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwScriptExceptionStack.ParamsTypes

procedure TkwScriptExceptionStack.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(script_ExceptionStack(aCtx));
end;//TkwScriptExceptionStack.DoDoIt

function TkwSysutilsParamCount.sysutils_ParamCount(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:ParamCount }
//#UC START# *55CB5442020A_55CB5442020A_Word_var*
//#UC END# *55CB5442020A_55CB5442020A_Word_var*
begin
//#UC START# *55CB5442020A_55CB5442020A_Word_impl*
 Result := ParamCount;
//#UC END# *55CB5442020A_55CB5442020A_Word_impl*
end;//TkwSysutilsParamCount.sysutils_ParamCount

class function TkwSysutilsParamCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ParamCount';
end;//TkwSysutilsParamCount.GetWordNameForRegister

function TkwSysutilsParamCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwSysutilsParamCount.GetResultTypeInfo

function TkwSysutilsParamCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSysutilsParamCount.GetAllParamsCount

function TkwSysutilsParamCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSysutilsParamCount.ParamsTypes

procedure TkwSysutilsParamCount.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_ParamCount(aCtx));
end;//TkwSysutilsParamCount.DoDoIt

function TkwSysutilsParamStr.sysutils_ParamStr(const aCtx: TtfwContext;
 anIndex: Integer): AnsiString;
 {* Реализация слова скрипта sysutils:ParamStr }
//#UC START# *55CB54630103_55CB54630103_Word_var*
//#UC END# *55CB54630103_55CB54630103_Word_var*
begin
//#UC START# *55CB54630103_55CB54630103_Word_impl*
 Result := ParamStr(anIndex);
//#UC END# *55CB54630103_55CB54630103_Word_impl*
end;//TkwSysutilsParamStr.sysutils_ParamStr

class function TkwSysutilsParamStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ParamStr';
end;//TkwSysutilsParamStr.GetWordNameForRegister

function TkwSysutilsParamStr.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSysutilsParamStr.GetResultTypeInfo

function TkwSysutilsParamStr.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsParamStr.GetAllParamsCount

function TkwSysutilsParamStr.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwSysutilsParamStr.ParamsTypes

procedure TkwSysutilsParamStr.DoDoIt(const aCtx: TtfwContext);
var l_anIndex: Integer;
begin
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(sysutils_ParamStr(aCtx, l_anIndex));
end;//TkwSysutilsParamStr.DoDoIt

function TkwSysutilsGetCurrentDir.sysutils_GetCurrentDir(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта sysutils:GetCurrentDir }
//#UC START# *55CB547900E8_55CB547900E8_Word_var*
//#UC END# *55CB547900E8_55CB547900E8_Word_var*
begin
//#UC START# *55CB547900E8_55CB547900E8_Word_impl*
 Result := SysUtils.GetCurrentDir;
//#UC END# *55CB547900E8_55CB547900E8_Word_impl*
end;//TkwSysutilsGetCurrentDir.sysutils_GetCurrentDir

class function TkwSysutilsGetCurrentDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:GetCurrentDir';
end;//TkwSysutilsGetCurrentDir.GetWordNameForRegister

function TkwSysutilsGetCurrentDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSysutilsGetCurrentDir.GetResultTypeInfo

function TkwSysutilsGetCurrentDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSysutilsGetCurrentDir.GetAllParamsCount

function TkwSysutilsGetCurrentDir.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSysutilsGetCurrentDir.ParamsTypes

procedure TkwSysutilsGetCurrentDir.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(sysutils_GetCurrentDir(aCtx));
end;//TkwSysutilsGetCurrentDir.DoDoIt

function TkwSysutilsSetCurrentDir.sysutils_SetCurrentDir(const aCtx: TtfwContext;
 const aDir: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:SetCurrentDir }
//#UC START# *55CB548A02B3_55CB548A02B3_Word_var*
//#UC END# *55CB548A02B3_55CB548A02B3_Word_var*
begin
//#UC START# *55CB548A02B3_55CB548A02B3_Word_impl*
 Result := SysUtils.SetCurrentDir(aDir); 
//#UC END# *55CB548A02B3_55CB548A02B3_Word_impl*
end;//TkwSysutilsSetCurrentDir.sysutils_SetCurrentDir

class function TkwSysutilsSetCurrentDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:SetCurrentDir';
end;//TkwSysutilsSetCurrentDir.GetWordNameForRegister

function TkwSysutilsSetCurrentDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSysutilsSetCurrentDir.GetResultTypeInfo

function TkwSysutilsSetCurrentDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsSetCurrentDir.GetAllParamsCount

function TkwSysutilsSetCurrentDir.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsSetCurrentDir.ParamsTypes

procedure TkwSysutilsSetCurrentDir.DoDoIt(const aCtx: TtfwContext);
var l_aDir: AnsiString;
begin
 try
  l_aDir := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDir: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(sysutils_SetCurrentDir(aCtx, l_aDir));
end;//TkwSysutilsSetCurrentDir.DoDoIt

function TkwSysutilsCreateDir.sysutils_CreateDir(const aCtx: TtfwContext;
 const aDir: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:CreateDir }
//#UC START# *55CB54C90276_55CB54C90276_Word_var*
//#UC END# *55CB54C90276_55CB54C90276_Word_var*
begin
//#UC START# *55CB54C90276_55CB54C90276_Word_impl*
 Result := SysUtils.CreateDir(aDir);
//#UC END# *55CB54C90276_55CB54C90276_Word_impl*
end;//TkwSysutilsCreateDir.sysutils_CreateDir

class function TkwSysutilsCreateDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:CreateDir';
end;//TkwSysutilsCreateDir.GetWordNameForRegister

function TkwSysutilsCreateDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSysutilsCreateDir.GetResultTypeInfo

function TkwSysutilsCreateDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsCreateDir.GetAllParamsCount

function TkwSysutilsCreateDir.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsCreateDir.ParamsTypes

procedure TkwSysutilsCreateDir.DoDoIt(const aCtx: TtfwContext);
var l_aDir: AnsiString;
begin
 try
  l_aDir := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDir: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(sysutils_CreateDir(aCtx, l_aDir));
end;//TkwSysutilsCreateDir.DoDoIt

function TkwSysutilsRemoveDir.sysutils_RemoveDir(const aCtx: TtfwContext;
 const aDir: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:RemoveDir }
//#UC START# *55CB54EF00B8_55CB54EF00B8_Word_var*
//#UC END# *55CB54EF00B8_55CB54EF00B8_Word_var*
begin
//#UC START# *55CB54EF00B8_55CB54EF00B8_Word_impl*
 Result := SysUtils.RemoveDir(aDir);
//#UC END# *55CB54EF00B8_55CB54EF00B8_Word_impl*
end;//TkwSysutilsRemoveDir.sysutils_RemoveDir

class function TkwSysutilsRemoveDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:RemoveDir';
end;//TkwSysutilsRemoveDir.GetWordNameForRegister

function TkwSysutilsRemoveDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwSysutilsRemoveDir.GetResultTypeInfo

function TkwSysutilsRemoveDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsRemoveDir.GetAllParamsCount

function TkwSysutilsRemoveDir.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsRemoveDir.ParamsTypes

procedure TkwSysutilsRemoveDir.DoDoIt(const aCtx: TtfwContext);
var l_aDir: AnsiString;
begin
 try
  l_aDir := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDir: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(sysutils_RemoveDir(aCtx, l_aDir));
end;//TkwSysutilsRemoveDir.DoDoIt

procedure TkwSysutilsLog.sysutils_Log(const aCtx: TtfwContext;
 const aStr: AnsiString);
 {* Реализация слова скрипта sysutils:Log }
//#UC START# *570E6FCA0217_570E6FCA0217_Word_var*
//#UC END# *570E6FCA0217_570E6FCA0217_Word_var*
begin
//#UC START# *570E6FCA0217_570E6FCA0217_Word_impl*
 l3System.Msg2Log(aStr);
//#UC END# *570E6FCA0217_570E6FCA0217_Word_impl*
end;//TkwSysutilsLog.sysutils_Log

class function TkwSysutilsLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:Log';
end;//TkwSysutilsLog.GetWordNameForRegister

function TkwSysutilsLog.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSysutilsLog.GetResultTypeInfo

function TkwSysutilsLog.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwSysutilsLog.GetAllParamsCount

function TkwSysutilsLog.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwSysutilsLog.ParamsTypes

procedure TkwSysutilsLog.DoDoIt(const aCtx: TtfwContext);
var l_aStr: AnsiString;
begin
 try
  l_aStr := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStr: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 sysutils_Log(aCtx, l_aStr);
end;//TkwSysutilsLog.DoDoIt

function TkwStopTimerNoLog.StopTimerNoLog(const aCtx: TtfwContext;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimerNoLog }
//#UC START# *570FF89B00BE_570FF89B00BE_Word_var*
//#UC END# *570FF89B00BE_570FF89B00BE_Word_var*
begin
//#UC START# *570FF89B00BE_570FF89B00BE_Word_impl*
 Result := aCtx.rCaller.StopTimer(aName, '', false);
//#UC END# *570FF89B00BE_570FF89B00BE_Word_impl*
end;//TkwStopTimerNoLog.StopTimerNoLog

class function TkwStopTimerNoLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimerNoLog';
end;//TkwStopTimerNoLog.GetWordNameForRegister

function TkwStopTimerNoLog.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStopTimerNoLog.GetResultTypeInfo

function TkwStopTimerNoLog.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStopTimerNoLog.GetAllParamsCount

function TkwStopTimerNoLog.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwStopTimerNoLog.ParamsTypes

procedure TkwStopTimerNoLog.DoDoIt(const aCtx: TtfwContext);
var l_aName: AnsiString;
begin
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(StopTimerNoLog(aCtx, l_aName));
end;//TkwStopTimerNoLog.DoDoIt

function TkwStopTimerExNoLog.StopTimerExNoLog(const aCtx: TtfwContext;
 const aSubName: AnsiString;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimerExNoLog }
//#UC START# *570FF8C8038E_570FF8C8038E_Word_var*
//#UC END# *570FF8C8038E_570FF8C8038E_Word_var*
begin
//#UC START# *570FF8C8038E_570FF8C8038E_Word_impl*
 Result := aCtx.rCaller.StopTimer(aName, aSubName, false);
//#UC END# *570FF8C8038E_570FF8C8038E_Word_impl*
end;//TkwStopTimerExNoLog.StopTimerExNoLog

class function TkwStopTimerExNoLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimerExNoLog';
end;//TkwStopTimerExNoLog.GetWordNameForRegister

function TkwStopTimerExNoLog.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStopTimerExNoLog.GetResultTypeInfo

function TkwStopTimerExNoLog.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStopTimerExNoLog.GetAllParamsCount

function TkwStopTimerExNoLog.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString]);
end;//TkwStopTimerExNoLog.ParamsTypes

procedure TkwStopTimerExNoLog.DoDoIt(const aCtx: TtfwContext);
var l_aSubName: AnsiString;
var l_aName: AnsiString;
begin
 try
  l_aSubName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aSubName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(StopTimerExNoLog(aCtx, l_aSubName, l_aName));
end;//TkwStopTimerExNoLog.DoDoIt

function TkwSysutilsLocale.sysutils_Locale(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:Locale }
//#UC START# *571766B60308_571766B60308_Word_var*
//#UC END# *571766B60308_571766B60308_Word_var*
begin
//#UC START# *571766B60308_571766B60308_Word_impl*
 Result := GetThreadLocale;
//#UC END# *571766B60308_571766B60308_Word_impl*
end;//TkwSysutilsLocale.sysutils_Locale

class function TkwSysutilsLocale.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:Locale';
end;//TkwSysutilsLocale.GetWordNameForRegister

function TkwSysutilsLocale.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwSysutilsLocale.GetResultTypeInfo

function TkwSysutilsLocale.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSysutilsLocale.GetAllParamsCount

function TkwSysutilsLocale.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSysutilsLocale.ParamsTypes

procedure TkwSysutilsLocale.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_Locale(aCtx));
end;//TkwSysutilsLocale.DoDoIt

function TkwSysutilsCodePage.sysutils_CodePage(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:CodePage }
//#UC START# *571766C80011_571766C80011_Word_var*

 function LCIDToCodePage(ALcid: LCID): Integer;
 var
   Buffer: array [0..6] of Char;
 begin
   GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, SizeOf(Buffer));
   Result:= StrToIntDef(Buffer, GetACP);
 end;
 
//#UC END# *571766C80011_571766C80011_Word_var*
begin
//#UC START# *571766C80011_571766C80011_Word_impl*
 Result := LCIDToCodePage(GetThreadLocale);
//#UC END# *571766C80011_571766C80011_Word_impl*
end;//TkwSysutilsCodePage.sysutils_CodePage

class function TkwSysutilsCodePage.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:CodePage';
end;//TkwSysutilsCodePage.GetWordNameForRegister

function TkwSysutilsCodePage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwSysutilsCodePage.GetResultTypeInfo

function TkwSysutilsCodePage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSysutilsCodePage.GetAllParamsCount

function TkwSysutilsCodePage.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSysutilsCodePage.ParamsTypes

procedure TkwSysutilsCodePage.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_CodePage(aCtx));
end;//TkwSysutilsCodePage.DoDoIt

function TkwSysutilsGetACP.sysutils_GetACP(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:GetACP }
//#UC START# *5718D0250329_5718D0250329_Word_var*
//#UC END# *5718D0250329_5718D0250329_Word_var*
begin
//#UC START# *5718D0250329_5718D0250329_Word_impl*
 Result := Windows.GetACP; 
//#UC END# *5718D0250329_5718D0250329_Word_impl*
end;//TkwSysutilsGetACP.sysutils_GetACP

class function TkwSysutilsGetACP.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:GetACP';
end;//TkwSysutilsGetACP.GetWordNameForRegister

function TkwSysutilsGetACP.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwSysutilsGetACP.GetResultTypeInfo

function TkwSysutilsGetACP.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSysutilsGetACP.GetAllParamsCount

function TkwSysutilsGetACP.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSysutilsGetACP.ParamsTypes

procedure TkwSysutilsGetACP.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_GetACP(aCtx));
end;//TkwSysutilsGetACP.DoDoIt

function TkwIntToHex.IntToHex(const aCtx: TtfwContext;
 aValue: Integer;
 aDigits: Integer): AnsiString;
 {* Реализация слова скрипта IntToHex }
//#UC START# *573990470097_573990470097_Word_var*
//#UC END# *573990470097_573990470097_Word_var*
begin
//#UC START# *573990470097_573990470097_Word_impl*
 Result := SysUtils.IntToHex(aValue, aDigits);
//#UC END# *573990470097_573990470097_Word_impl*
end;//TkwIntToHex.IntToHex

class function TkwIntToHex.GetWordNameForRegister: AnsiString;
begin
 Result := 'IntToHex';
end;//TkwIntToHex.GetWordNameForRegister

function TkwIntToHex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwIntToHex.GetResultTypeInfo

function TkwIntToHex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwIntToHex.GetAllParamsCount

function TkwIntToHex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer), TypeInfo(Integer)]);
end;//TkwIntToHex.ParamsTypes

procedure TkwIntToHex.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
var l_aDigits: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aDigits := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aDigits: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(IntToHex(aCtx, l_aValue, l_aDigits));
end;//TkwIntToHex.DoDoIt

function TkwSysutilsCreateGUID.sysutils_CreateGUID(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта sysutils:CreateGUID }
//#UC START# *5755450A0019_5755450A0019_Word_var*
//#UC END# *5755450A0019_5755450A0019_Word_var*
begin
//#UC START# *5755450A0019_5755450A0019_Word_impl*
 Result := l3CreateStringGUID;
//#UC END# *5755450A0019_5755450A0019_Word_impl*
end;//TkwSysutilsCreateGUID.sysutils_CreateGUID

class function TkwSysutilsCreateGUID.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:CreateGUID';
end;//TkwSysutilsCreateGUID.GetWordNameForRegister

function TkwSysutilsCreateGUID.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwSysutilsCreateGUID.GetResultTypeInfo

function TkwSysutilsCreateGUID.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSysutilsCreateGUID.GetAllParamsCount

function TkwSysutilsCreateGUID.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwSysutilsCreateGUID.ParamsTypes

procedure TkwSysutilsCreateGUID.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(sysutils_CreateGUID(aCtx));
end;//TkwSysutilsCreateGUID.DoDoIt

function TkwCreateDOSProcessRedirected.CreateDOSProcessRedirected(const aCtx: TtfwContext;
 const CommandLine: AnsiString;
 const InputFile: AnsiString;
 const OutputFile: AnsiString): Boolean;
 {* Реализация слова скрипта CreateDOSProcessRedirected }
//#UC START# *57A44E1B036A_57A44E1B036A_Word_var*

 function CreateInheritable(out Sa: TSecurityAttributes): PSecurityAttributes;
 begin
   Sa.nLength := SizeOf(Sa);
   Sa.lpSecurityDescriptor := nil;
   Sa.bInheritHandle := True;
   if IsWinNT then
     Result := @Sa
   else
     Result := nil;
 end;

 procedure ResetMemory(out P; Size: Longint);
 begin
   if Size > 0 then
   begin
     Byte(P) := 0;
     l3FillChar(P, Size, 0);
   end;
 end;

var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  SecAtrrs: TSecurityAttributes;
  hInputFile, hOutputFile: THandle;
  l_CommandLine: AnsiString;
//#UC END# *57A44E1B036A_57A44E1B036A_Word_var*
begin
//#UC START# *57A44E1B036A_57A44E1B036A_Word_impl*
  Result := False;
  l_CommandLine := CommandLine;
  if (InputFile <> '') then
   hInputFile := CreateFile(PAnsiChar(InputFile), GENERIC_READ, FILE_SHARE_READ,
     CreateInheritable(SecAtrrs), OPEN_EXISTING, FILE_ATTRIBUTE_TEMPORARY, 0)
  else
   hInputFile := 0;
  if hInputFile <> INVALID_HANDLE_VALUE then
  begin
    hOutputFile := CreateFile(PAnsiChar(OutPutFile), GENERIC_READ or GENERIC_WRITE,
      FILE_SHARE_READ or FILE_SHARE_WRITE, CreateInheritable(SecAtrrs), OPEN_EXISTING,
      FILE_ATTRIBUTE_TEMPORARY, 0);
    if (hOutputFile = INVALID_HANDLE_VALUE) then
     hOutputFile := CreateFile(PAnsiChar(OutPutFile), GENERIC_READ or GENERIC_WRITE,
       FILE_SHARE_READ or FILE_SHARE_WRITE, CreateInheritable(SecAtrrs), CREATE_ALWAYS,
       FILE_ATTRIBUTE_TEMPORARY, 0)
    else
    begin
     FileSeek(Integer(hOutputFile), 0, FILE_END	);
    end;//hOutputFile = INVALID_HANDLE_VALUE
    if hOutputFile <> INVALID_HANDLE_VALUE then
    begin
      ResetMemory(StartupInfo, SizeOf(StartupInfo));
      ResetMemory(ProcessInfo, SizeOf(ProcessInfo));
      StartupInfo.cb := SizeOf(StartupInfo);
      StartupInfo.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      StartupInfo.wShowWindow := SW_HIDE;
      StartupInfo.hStdOutput := hOutputFile;
      StartupInfo.hStdInput := hInputFile;
      UniqueString(l_CommandLine);//in the Unicode version the parameter lpCommandLine needs to be writable
      Result := CreateProcess(nil, PAnsiChar(l_CommandLine), nil, nil, True,
        CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo,
        ProcessInfo);
      if Result then
      begin
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
        CloseHandle(ProcessInfo.hProcess);
        CloseHandle(ProcessInfo.hThread);
      end;
      CloseHandle(hOutputFile);
    end;
    CloseHandle(hInputFile);
  end;
//#UC END# *57A44E1B036A_57A44E1B036A_Word_impl*
end;//TkwCreateDOSProcessRedirected.CreateDOSProcessRedirected

class function TkwCreateDOSProcessRedirected.GetWordNameForRegister: AnsiString;
begin
 Result := 'CreateDOSProcessRedirected';
end;//TkwCreateDOSProcessRedirected.GetWordNameForRegister

function TkwCreateDOSProcessRedirected.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwCreateDOSProcessRedirected.GetResultTypeInfo

function TkwCreateDOSProcessRedirected.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 3;
end;//TkwCreateDOSProcessRedirected.GetAllParamsCount

function TkwCreateDOSProcessRedirected.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString, @tfw_tiString, @tfw_tiString]);
end;//TkwCreateDOSProcessRedirected.ParamsTypes

procedure TkwCreateDOSProcessRedirected.DoDoIt(const aCtx: TtfwContext);
var l_CommandLine: AnsiString;
var l_InputFile: AnsiString;
var l_OutputFile: AnsiString;
begin
 try
  l_CommandLine := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра CommandLine: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_InputFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра InputFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_OutputFile := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра OutputFile: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(CreateDOSProcessRedirected(aCtx, l_CommandLine, l_InputFile, l_OutputFile));
end;//TkwCreateDOSProcessRedirected.DoDoIt

class function TSysUtilsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'SysUtilsPack';
end;//TSysUtilsPackResNameGetter.ResName

{$R SysUtilsPack.res}

initialization
 TkwHasTabs.RegisterInEngine;
 {* Регистрация HasTabs }
 TkwIsUnder64.RegisterInEngine;
 {* Регистрация IsUnder64 }
 TkwComputerName.RegisterInEngine;
 {* Регистрация ComputerName }
 TkwOSName.RegisterInEngine;
 {* Регистрация OSName }
 TkwRandom.RegisterInEngine;
 {* Регистрация Random }
 TkwRandomize.RegisterInEngine;
 {* Регистрация Randomize }
 TkwSetRandSeed.RegisterInEngine;
 {* Регистрация SetRandSeed }
 TkwRGB2String.RegisterInEngine;
 {* Регистрация RGB2String }
 TkwIntToStr.RegisterInEngine;
 {* Регистрация IntToStr }
 TkwIsXE.RegisterInEngine;
 {* Регистрация IsXE }
 TkwWinExec.RegisterInEngine;
 {* Регистрация WinExec }
 TkwScriptFileName.RegisterInEngine;
 {* Регистрация script_FileName }
 TkwSysutilsChangeFileExt.RegisterInEngine;
 {* Регистрация sysutils_ChangeFileExt }
 TkwSysutilsExtractFileName.RegisterInEngine;
 {* Регистрация sysutils_ExtractFileName }
 TkwSysutilsExtractFilePath.RegisterInEngine;
 {* Регистрация sysutils_ExtractFilePath }
 TkwSysutilsExtractFileDrive.RegisterInEngine;
 {* Регистрация sysutils_ExtractFileDrive }
 TkwSysutilsDirectoryExists.RegisterInEngine;
 {* Регистрация sysutils_DirectoryExists }
 TkwSysutilsFileExists.RegisterInEngine;
 {* Регистрация sysutils_FileExists }
 TkwSysutilsForceDirectories.RegisterInEngine;
 {* Регистрация sysutils_ForceDirectories }
 TkwSetAppPath2CurrentDir.RegisterInEngine;
 {* Регистрация SetAppPath2CurrentDir }
 TkwApplicationExeName.RegisterInEngine;
 {* Регистрация application_ExeName }
 TkwGetTickCount.RegisterInEngine;
 {* Регистрация GetTickCount }
 TkwApplicationActionIdle.RegisterInEngine;
 {* Регистрация application_ActionIdle }
 TkwClipboardClear.RegisterInEngine;
 {* Регистрация clipboard_clear }
 TkwSetLocalDate.RegisterInEngine;
 {* Регистрация SetLocalDate }
 TkwSetLocalTime.RegisterInEngine;
 {* Регистрация SetLocalTime }
 TkwSetLocalDateTime.RegisterInEngine;
 {* Регистрация SetLocalDateTime }
 TkwGetLocalDate.RegisterInEngine;
 {* Регистрация GetLocalDate }
 TkwGetLocalDateTime.RegisterInEngine;
 {* Регистрация GetLocalDateTime }
 TkwGetLocalTime.RegisterInEngine;
 {* Регистрация GetLocalTime }
 TkwStartTimer.RegisterInEngine;
 {* Регистрация StartTimer }
 TkwStopTimer.RegisterInEngine;
 {* Регистрация StopTimer }
 TkwStopTimerEx.RegisterInEngine;
 {* Регистрация StopTimerEx }
 TkwTimeToLog.RegisterInEngine;
 {* Регистрация TimeToLog }
 TkwShiftDate.RegisterInEngine;
 {* Регистрация ShiftDate }
 TkwShiftTime.RegisterInEngine;
 {* Регистрация ShiftTime }
 TkwClipboardGetFormattedText.RegisterInEngine;
 {* Регистрация clipboard_GetFormattedText }
 TkwClipboardSetText.RegisterInEngine;
 {* Регистрация clipboard_SetText }
 TkwScriptExceptionStack.RegisterInEngine;
 {* Регистрация script_ExceptionStack }
 TkwSysutilsParamCount.RegisterInEngine;
 {* Регистрация sysutils_ParamCount }
 TkwSysutilsParamStr.RegisterInEngine;
 {* Регистрация sysutils_ParamStr }
 TkwSysutilsGetCurrentDir.RegisterInEngine;
 {* Регистрация sysutils_GetCurrentDir }
 TkwSysutilsSetCurrentDir.RegisterInEngine;
 {* Регистрация sysutils_SetCurrentDir }
 TkwSysutilsCreateDir.RegisterInEngine;
 {* Регистрация sysutils_CreateDir }
 TkwSysutilsRemoveDir.RegisterInEngine;
 {* Регистрация sysutils_RemoveDir }
 TkwSysutilsLog.RegisterInEngine;
 {* Регистрация sysutils_Log }
 TkwStopTimerNoLog.RegisterInEngine;
 {* Регистрация StopTimerNoLog }
 TkwStopTimerExNoLog.RegisterInEngine;
 {* Регистрация StopTimerExNoLog }
 TkwSysutilsLocale.RegisterInEngine;
 {* Регистрация sysutils_Locale }
 TkwSysutilsCodePage.RegisterInEngine;
 {* Регистрация sysutils_CodePage }
 TkwSysutilsGetACP.RegisterInEngine;
 {* Регистрация sysutils_GetACP }
 TkwIntToHex.RegisterInEngine;
 {* Регистрация IntToHex }
 TkwSysutilsCreateGUID.RegisterInEngine;
 {* Регистрация sysutils_CreateGUID }
 TkwCreateDOSProcessRedirected.RegisterInEngine;
 {* Регистрация CreateDOSProcessRedirected }
 TSysUtilsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
{$IfEnd} // NOT Defined(NoScripts)

end.
