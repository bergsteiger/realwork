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
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwHasTabs = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта HasTabs
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 HasTabs >>> l_Boolean
[code]  }
  private
   function HasTabs(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта HasTabs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwHasTabs

 TkwIsUnder64 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IsUnder64
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 IsUnder64 >>> l_Boolean
[code]  }
  private
   function IsUnder64(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта IsUnder64 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsUnder64

 TkwComputerName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ComputerName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 ComputerName >>> l_String
[code]  }
  private
   function ComputerName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта ComputerName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwComputerName

 TkwOSName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта OSName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 OSName >>> l_String
[code]  }
  private
   function OSName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта OSName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwOSName

 TkwRandom = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Random
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aMax Random >>> l_Integer
[code]  }
  private
   function Random(const aCtx: TtfwContext;
    aMax: Integer): Integer;
    {* Реализация слова скрипта Random }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRandom

 TkwRandomize = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта Randomize
*Пример:*
[code]
 Randomize
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwRandomize

 TkwSetRandSeed = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetRandSeed
*Пример:*
[code]
 aValue SetRandSeed
[code]  }
  private
   procedure SetRandSeed(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта SetRandSeed }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetRandSeed

 TkwRGB2String = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта RGB2String
[panel]Переводит представление R G B в шестнадцатиричное представление в виде строки:
[code]
151 40 30 RGB2String .
[code][panel]
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aR aG aB RGB2String >>> l_String
[code]  }
  private
   function RGB2String(const aCtx: TtfwContext;
    aB: Integer;
    aG: Integer;
    aR: Integer): AnsiString;
    {* Реализация слова скрипта RGB2String }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRGB2String

 TkwIntToStr = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IntToStr
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aValue IntToStr >>> l_String
[code]  }
  private
   function IntToStr(const aCtx: TtfwContext;
    aValue: Integer): AnsiString;
    {* Реализация слова скрипта IntToStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIntToStr

 TkwIsXE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IsXE
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 IsXE >>> l_Boolean
[code]  }
  private
   function IsXE(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта IsXE }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsXE

 TkwWinExec = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта WinExec
*Пример:*
[code]
 aPath WinExec
[code]  }
  private
   procedure WinExec(const aCtx: TtfwContext;
    const aPath: AnsiString);
    {* Реализация слова скрипта WinExec }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWinExec

 TkwScriptFileName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта script:FileName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 script:FileName >>> l_String
[code]  }
  private
   function script_FileName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта script:FileName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScriptFileName

 TkwSysutilsChangeFileExt = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ChangeFileExt
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName anExt sysutils:ChangeFileExt >>> l_String
[code]  }
  private
   function sysutils_ChangeFileExt(const aCtx: TtfwContext;
    const anExt: AnsiString;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ChangeFileExt }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsChangeFileExt

 TkwSysutilsExtractFileName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFileName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFileName >>> l_String
[code]  }
  private
   function sysutils_ExtractFileName(const aCtx: TtfwContext;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ExtractFileName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsExtractFileName

 TkwSysutilsExtractFilePath = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFilePath
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFilePath >>> l_String
[code]  }
  private
   function sysutils_ExtractFilePath(const aCtx: TtfwContext;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ExtractFilePath }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsExtractFilePath

 TkwSysutilsExtractFileDrive = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFileDrive
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFileDrive >>> l_String
[code]  }
  private
   function sysutils_ExtractFileDrive(const aCtx: TtfwContext;
    const aName: AnsiString): AnsiString;
    {* Реализация слова скрипта sysutils:ExtractFileDrive }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsExtractFileDrive

 TkwSysutilsDirectoryExists = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:DirectoryExists
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:DirectoryExists >>> l_Boolean
[code]  }
  private
   function sysutils_DirectoryExists(const aCtx: TtfwContext;
    const aPath: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:DirectoryExists }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsDirectoryExists

 TkwSysutilsFileExists = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:FileExists
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:FileExists >>> l_Boolean
[code]  }
  private
   function sysutils_FileExists(const aCtx: TtfwContext;
    const aPath: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:FileExists }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsFileExists

 TkwSysutilsForceDirectories = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ForceDirectories
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:ForceDirectories >>> l_Boolean
[code]  }
  private
   function sysutils_ForceDirectories(const aCtx: TtfwContext;
    const aPath: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:ForceDirectories }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsForceDirectories

 TkwSetAppPath2CurrentDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetAppPath2CurrentDir
*Пример:*
[code]
 SetAppPath2CurrentDir
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwSetAppPath2CurrentDir

 TkwApplicationExeName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:ExeName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 application:ExeName >>> l_String
[code]  }
  private
   function application_ExeName(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта application:ExeName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwApplicationExeName

 TkwGetTickCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetTickCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 GetTickCount >>> l_Integer
[code]  }
  private
   function GetTickCount(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта GetTickCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGetTickCount

 TkwApplicationActionIdle = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта application:ActionIdle
*Пример:*
[code]
 application:ActionIdle
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwApplicationActionIdle

 TkwClipboardClear = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:clear
*Пример:*
[code]
 clipboard:clear
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwClipboardClear

 TkwSetLocalDate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalDate
*Пример:*
[code]
 anYear aMonth aDay SetLocalDate
[code]  }
  private
   procedure SetLocalDate(const aCtx: TtfwContext;
    aDay: Integer;
    aMonth: Integer;
    anYear: Integer);
    {* Реализация слова скрипта SetLocalDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetLocalDate

 TkwSetLocalTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalTime
*Пример:*
[code]
 anHour aMinute aSecond aMilli SetLocalTime
[code]  }
  private
   procedure SetLocalTime(const aCtx: TtfwContext;
    aMilli: Integer;
    aSecond: Integer;
    aMinute: Integer;
    anHour: Integer);
    {* Реализация слова скрипта SetLocalTime }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetLocalTime

 TkwSetLocalDateTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalDateTime
*Пример:*
[code]
 anYear aMonth aDay anHour aMinute aSecond aMilli SetLocalDateTime
[code]  }
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
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSetLocalDateTime

 TkwGetLocalDate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalDate
*Пример:*
[code]
 GetLocalDate
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwGetLocalDate

 TkwGetLocalDateTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalDateTime
*Пример:*
[code]
 GetLocalDateTime
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwGetLocalDateTime

 TkwGetLocalTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalTime
*Пример:*
[code]
 GetLocalTime
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwGetLocalTime

 TkwStartTimer = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StartTimer
*Пример:*
[code]
 StartTimer
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwStartTimer

 TkwStopTimer = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimer
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName StopTimer >>> l_Integer
[code]  }
  private
   function StopTimer(const aCtx: TtfwContext;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimer

 TkwStopTimerEx = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimerEx
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName aSubName StopTimerEx >>> l_Integer
[code]  }
  private
   function StopTimerEx(const aCtx: TtfwContext;
    const aSubName: AnsiString;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimerEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimerEx

 TkwTimeToLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта TimeToLog
*Пример:*
[code]
 aName aSubName aValue TimeToLog
[code]  }
  private
   procedure TimeToLog(const aCtx: TtfwContext;
    aValue: Integer;
    const aSubName: AnsiString;
    const aName: AnsiString);
    {* Реализация слова скрипта TimeToLog }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwTimeToLog

 TkwShiftDate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ShiftDate
*Пример:*
[code]
 aDeltaY aDeltaM aDeltaD ShiftDate
[code]  }
  private
   procedure ShiftDate(const aCtx: TtfwContext;
    aDeltaD: Integer;
    aDeltaM: Integer;
    aDeltaY: Integer);
    {* Реализация слова скрипта ShiftDate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShiftDate

 TkwShiftTime = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта ShiftTime
*Пример:*
[code]
 aDeltaMilli ShiftTime
[code]  }
  private
   procedure ShiftTime(const aCtx: TtfwContext;
    aDeltaMilli: Integer);
    {* Реализация слова скрипта ShiftTime }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShiftTime

 TkwClipboardGetFormattedText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:GetFormattedText
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aFormat clipboard:GetFormattedText >>> l_Il3CString
[code]  }
  private
   function clipboard_GetFormattedText(const aCtx: TtfwContext;
    const aFormat: TtfwStackValue): Il3CString;
    {* Реализация слова скрипта clipboard:GetFormattedText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwClipboardGetFormattedText

 TkwClipboardSetText = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:SetText
*Пример:*
[code]
 aValue clipboard:SetText
[code]  }
  private
   procedure clipboard_SetText(const aCtx: TtfwContext;
    const aValue: Il3CString);
    {* Реализация слова скрипта clipboard:SetText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwClipboardSetText

 TkwScriptExceptionStack = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта script:ExceptionStack
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 script:ExceptionStack >>> l_ItfwValueList
[code]  }
  private
   function script_ExceptionStack(const aCtx: TtfwContext): ItfwValueList;
    {* Реализация слова скрипта script:ExceptionStack }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwScriptExceptionStack

 TkwSysutilsParamCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ParamCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 sysutils:ParamCount >>> l_Integer
[code]  }
  private
   function sysutils_ParamCount(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:ParamCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsParamCount

 TkwSysutilsParamStr = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ParamStr
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 anIndex sysutils:ParamStr >>> l_String
[code]  }
  private
   function sysutils_ParamStr(const aCtx: TtfwContext;
    anIndex: Integer): AnsiString;
    {* Реализация слова скрипта sysutils:ParamStr }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsParamStr

 TkwSysutilsGetCurrentDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:GetCurrentDir
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 sysutils:GetCurrentDir >>> l_String
[code]  }
  private
   function sysutils_GetCurrentDir(const aCtx: TtfwContext): AnsiString;
    {* Реализация слова скрипта sysutils:GetCurrentDir }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsGetCurrentDir

 TkwSysutilsSetCurrentDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:SetCurrentDir
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:SetCurrentDir >>> l_Boolean
[code]  }
  private
   function sysutils_SetCurrentDir(const aCtx: TtfwContext;
    const aDir: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:SetCurrentDir }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsSetCurrentDir

 TkwSysutilsCreateDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:CreateDir
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:CreateDir >>> l_Boolean
[code]  }
  private
   function sysutils_CreateDir(const aCtx: TtfwContext;
    const aDir: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:CreateDir }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsCreateDir

 TkwSysutilsRemoveDir = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:RemoveDir
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:RemoveDir >>> l_Boolean
[code]  }
  private
   function sysutils_RemoveDir(const aCtx: TtfwContext;
    const aDir: AnsiString): Boolean;
    {* Реализация слова скрипта sysutils:RemoveDir }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsRemoveDir

 TkwSysutilsLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:Log
*Пример:*
[code]
 aStr sysutils:Log
[code]  }
  private
   procedure sysutils_Log(const aCtx: TtfwContext;
    const aStr: AnsiString);
    {* Реализация слова скрипта sysutils:Log }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsLog

 TkwStopTimerNoLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimerNoLog
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName StopTimerNoLog >>> l_Integer
[code]  }
  private
   function StopTimerNoLog(const aCtx: TtfwContext;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimerNoLog }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimerNoLog

 TkwStopTimerExNoLog = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimerExNoLog
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName aSubName StopTimerExNoLog >>> l_Integer
[code]  }
  private
   function StopTimerExNoLog(const aCtx: TtfwContext;
    const aSubName: AnsiString;
    const aName: AnsiString): Integer;
    {* Реализация слова скрипта StopTimerExNoLog }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStopTimerExNoLog

 TkwSysutilsLocale = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:Locale
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 sysutils:Locale >>> l_Integer
[code]  }
  private
   function sysutils_Locale(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:Locale }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsLocale

 TkwSysutilsCodePage = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:CodePage
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 sysutils:CodePage >>> l_Integer
[code]  }
  private
   function sysutils_CodePage(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:CodePage }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsCodePage

 TkwSysutilsGetACP = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:GetACP
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 sysutils:GetACP >>> l_Integer
[code]  }
  private
   function sysutils_GetACP(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта sysutils:GetACP }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwSysutilsGetACP

 TSysUtilsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TSysUtilsPackResNameGetter

function TkwHasTabs.HasTabs(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта HasTabs }
//#UC START# *8B165BF2764A_3FBA7C4F7F80_var*
//#UC END# *8B165BF2764A_3FBA7C4F7F80_var*
begin
//#UC START# *8B165BF2764A_3FBA7C4F7F80_impl*
 Result := Tl3TabService.Instance.HasTabs;
//#UC END# *8B165BF2764A_3FBA7C4F7F80_impl*
end;//TkwHasTabs.HasTabs

procedure TkwHasTabs.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(HasTabs(aCtx));
end;//TkwHasTabs.DoDoIt

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

class function TkwHasTabs.GetWordNameForRegister: AnsiString;
begin
 Result := 'HasTabs';
end;//TkwHasTabs.GetWordNameForRegister

function TkwIsUnder64.IsUnder64(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта IsUnder64 }
//#UC START# *E7960C7CE4B0_F9F8F376A6AB_var*
//#UC END# *E7960C7CE4B0_F9F8F376A6AB_var*
begin
//#UC START# *E7960C7CE4B0_F9F8F376A6AB_impl*
 Result := l3Is64System;
//#UC END# *E7960C7CE4B0_F9F8F376A6AB_impl*
end;//TkwIsUnder64.IsUnder64

procedure TkwIsUnder64.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(IsUnder64(aCtx));
end;//TkwIsUnder64.DoDoIt

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

class function TkwIsUnder64.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsUnder64';
end;//TkwIsUnder64.GetWordNameForRegister

function TkwComputerName.ComputerName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта ComputerName }
//#UC START# *67A0331D6030_0D7A9FAE3386_var*
var
 l_CompSize : Integer;
 l_S : AnsiString;
//#UC END# *67A0331D6030_0D7A9FAE3386_var*
begin
//#UC START# *67A0331D6030_0D7A9FAE3386_impl*
 l_CompSize := MAX_COMPUTERNAME_LENGTH + 1;
 SetLength(l_S, l_CompSize);

 Win32Check(GetComputerNameA(PAnsiChar(l_S), LongWord(l_CompSize)));
 SetLength(l_S, l_CompSize);
 Result := l_S;
//#UC END# *67A0331D6030_0D7A9FAE3386_impl*
end;//TkwComputerName.ComputerName

procedure TkwComputerName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(ComputerName(aCtx));
end;//TkwComputerName.DoDoIt

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

class function TkwComputerName.GetWordNameForRegister: AnsiString;
begin
 Result := 'ComputerName';
end;//TkwComputerName.GetWordNameForRegister

function TkwOSName.OSName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта OSName }
//#UC START# *FD0E945E9EFD_20F254F4B4BB_var*
//#UC END# *FD0E945E9EFD_20F254F4B4BB_var*
begin
//#UC START# *FD0E945E9EFD_20F254F4B4BB_impl*
 Result := GetWindowsVersionString;
//#UC END# *FD0E945E9EFD_20F254F4B4BB_impl*
end;//TkwOSName.OSName

procedure TkwOSName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(OSName(aCtx));
end;//TkwOSName.DoDoIt

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

class function TkwOSName.GetWordNameForRegister: AnsiString;
begin
 Result := 'OSName';
end;//TkwOSName.GetWordNameForRegister

function TkwRandom.Random(const aCtx: TtfwContext;
 aMax: Integer): Integer;
 {* Реализация слова скрипта Random }
//#UC START# *20FE7F32818E_E438AFCDC08A_var*
//#UC END# *20FE7F32818E_E438AFCDC08A_var*
begin
//#UC START# *20FE7F32818E_E438AFCDC08A_impl*
 Result := System.Random(aMax);
//#UC END# *20FE7F32818E_E438AFCDC08A_impl*
end;//TkwRandom.Random

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

class function TkwRandom.GetWordNameForRegister: AnsiString;
begin
 Result := 'Random';
end;//TkwRandom.GetWordNameForRegister

procedure TkwRandomize.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EA3D9826565B_var*
//#UC END# *4DAEEDE10285_EA3D9826565B_var*
begin
//#UC START# *4DAEEDE10285_EA3D9826565B_impl*
 System.Randomize;
//#UC END# *4DAEEDE10285_EA3D9826565B_impl*
end;//TkwRandomize.DoDoIt

function TkwRandomize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwRandomize.GetResultTypeInfo

function TkwRandomize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwRandomize.GetAllParamsCount

class function TkwRandomize.GetWordNameForRegister: AnsiString;
begin
 Result := 'Randomize';
end;//TkwRandomize.GetWordNameForRegister

procedure TkwSetRandSeed.SetRandSeed(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта SetRandSeed }
//#UC START# *61B70695D7A5_153639A6E4C3_var*
//#UC END# *61B70695D7A5_153639A6E4C3_var*
begin
//#UC START# *61B70695D7A5_153639A6E4C3_impl*
 RandSeed := aValue;
//#UC END# *61B70695D7A5_153639A6E4C3_impl*
end;//TkwSetRandSeed.SetRandSeed

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

class function TkwSetRandSeed.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetRandSeed';
end;//TkwSetRandSeed.GetWordNameForRegister

function TkwRGB2String.RGB2String(const aCtx: TtfwContext;
 aB: Integer;
 aG: Integer;
 aR: Integer): AnsiString;
 {* Реализация слова скрипта RGB2String }
//#UC START# *3FC73A87B28A_1BF05B2801A2_var*
var
 l_Color : TColor;
//#UC END# *3FC73A87B28A_1BF05B2801A2_var*
begin
//#UC START# *3FC73A87B28A_1BF05B2801A2_impl*
 l_Color := TColor(RGB(aR, aG, aB));
 Result := ColorToString(l_Color);
//#UC END# *3FC73A87B28A_1BF05B2801A2_impl*
end;//TkwRGB2String.RGB2String

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

class function TkwRGB2String.GetWordNameForRegister: AnsiString;
begin
 Result := 'RGB2String';
end;//TkwRGB2String.GetWordNameForRegister

function TkwIntToStr.IntToStr(const aCtx: TtfwContext;
 aValue: Integer): AnsiString;
 {* Реализация слова скрипта IntToStr }
//#UC START# *75D135739708_117748A67531_var*
//#UC END# *75D135739708_117748A67531_var*
begin
//#UC START# *75D135739708_117748A67531_impl*
 Result := SysUtils.IntToStr(aValue);
//#UC END# *75D135739708_117748A67531_impl*
end;//TkwIntToStr.IntToStr

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

class function TkwIntToStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'IntToStr';
end;//TkwIntToStr.GetWordNameForRegister

function TkwIsXE.IsXE(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта IsXE }
//#UC START# *59381C9832D8_8B86F9435925_var*
//#UC END# *59381C9832D8_8B86F9435925_var*
begin
//#UC START# *59381C9832D8_8B86F9435925_impl*
 {$IfDef XE}
 Result := true;
 {$Else  XE}
 Result := false;
 {$EndIf XE}
//#UC END# *59381C9832D8_8B86F9435925_impl*
end;//TkwIsXE.IsXE

procedure TkwIsXE.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(IsXE(aCtx));
end;//TkwIsXE.DoDoIt

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

class function TkwIsXE.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsXE';
end;//TkwIsXE.GetWordNameForRegister

procedure TkwWinExec.WinExec(const aCtx: TtfwContext;
 const aPath: AnsiString);
 {* Реализация слова скрипта WinExec }
//#UC START# *F86B14A38365_7B3EE646F965_var*
var
 l_S : AnsiString;
//#UC END# *F86B14A38365_7B3EE646F965_var*
begin
//#UC START# *F86B14A38365_7B3EE646F965_impl*
 l_S := aPath;
 if (ExtractFilePath(l_S) = '') then
  l_S := ExtractFilePath(ParamStr(0)) + l_S;
 Windows.WinExec(PAnsiChar(l_S), {SW_HIDE}SW_SHOWNORMAL);
//#UC END# *F86B14A38365_7B3EE646F965_impl*
end;//TkwWinExec.WinExec

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

class function TkwWinExec.GetWordNameForRegister: AnsiString;
begin
 Result := 'WinExec';
end;//TkwWinExec.GetWordNameForRegister

function TkwScriptFileName.script_FileName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта script:FileName }
//#UC START# *430363D4F3AC_C64998CA8748_var*
//#UC END# *430363D4F3AC_C64998CA8748_var*
begin
//#UC START# *430363D4F3AC_C64998CA8748_impl*
 Result := aCtx.rStreamFactory.FileName;
//#UC END# *430363D4F3AC_C64998CA8748_impl*
end;//TkwScriptFileName.script_FileName

procedure TkwScriptFileName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(script_FileName(aCtx));
end;//TkwScriptFileName.DoDoIt

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

class function TkwScriptFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:FileName';
end;//TkwScriptFileName.GetWordNameForRegister

function TkwSysutilsChangeFileExt.sysutils_ChangeFileExt(const aCtx: TtfwContext;
 const anExt: AnsiString;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ChangeFileExt }
//#UC START# *5D9DF8E375F9_68C847BC1029_var*
//#UC END# *5D9DF8E375F9_68C847BC1029_var*
begin
//#UC START# *5D9DF8E375F9_68C847BC1029_impl*
 Result := ChangeFileExt(aName, anExt);
//#UC END# *5D9DF8E375F9_68C847BC1029_impl*
end;//TkwSysutilsChangeFileExt.sysutils_ChangeFileExt

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

class function TkwSysutilsChangeFileExt.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ChangeFileExt';
end;//TkwSysutilsChangeFileExt.GetWordNameForRegister

function TkwSysutilsExtractFileName.sysutils_ExtractFileName(const aCtx: TtfwContext;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ExtractFileName }
//#UC START# *48BEA5CAB9AB_35FFB5DF4CE1_var*
//#UC END# *48BEA5CAB9AB_35FFB5DF4CE1_var*
begin
//#UC START# *48BEA5CAB9AB_35FFB5DF4CE1_impl*
 Result := ExtractFileName(aName);
//#UC END# *48BEA5CAB9AB_35FFB5DF4CE1_impl*
end;//TkwSysutilsExtractFileName.sysutils_ExtractFileName

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

class function TkwSysutilsExtractFileName.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ExtractFileName';
end;//TkwSysutilsExtractFileName.GetWordNameForRegister

function TkwSysutilsExtractFilePath.sysutils_ExtractFilePath(const aCtx: TtfwContext;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ExtractFilePath }
//#UC START# *80C1D574516D_E5B80654F1A7_var*
//#UC END# *80C1D574516D_E5B80654F1A7_var*
begin
//#UC START# *80C1D574516D_E5B80654F1A7_impl*
 Result := ExtractFilePath(aName);
//#UC END# *80C1D574516D_E5B80654F1A7_impl*
end;//TkwSysutilsExtractFilePath.sysutils_ExtractFilePath

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

class function TkwSysutilsExtractFilePath.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ExtractFilePath';
end;//TkwSysutilsExtractFilePath.GetWordNameForRegister

function TkwSysutilsExtractFileDrive.sysutils_ExtractFileDrive(const aCtx: TtfwContext;
 const aName: AnsiString): AnsiString;
 {* Реализация слова скрипта sysutils:ExtractFileDrive }
//#UC START# *7607F0C19FA3_968E4E29A5EA_var*
//#UC END# *7607F0C19FA3_968E4E29A5EA_var*
begin
//#UC START# *7607F0C19FA3_968E4E29A5EA_impl*
 Result := ExtractFileDrive(aName);
//#UC END# *7607F0C19FA3_968E4E29A5EA_impl*
end;//TkwSysutilsExtractFileDrive.sysutils_ExtractFileDrive

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

class function TkwSysutilsExtractFileDrive.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ExtractFileDrive';
end;//TkwSysutilsExtractFileDrive.GetWordNameForRegister

function TkwSysutilsDirectoryExists.sysutils_DirectoryExists(const aCtx: TtfwContext;
 const aPath: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:DirectoryExists }
//#UC START# *A6E45D572442_ACB27923B254_var*
//#UC END# *A6E45D572442_ACB27923B254_var*
begin
//#UC START# *A6E45D572442_ACB27923B254_impl*
 Result := DirectoryExists(aPath);
//#UC END# *A6E45D572442_ACB27923B254_impl*
end;//TkwSysutilsDirectoryExists.sysutils_DirectoryExists

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

class function TkwSysutilsDirectoryExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:DirectoryExists';
end;//TkwSysutilsDirectoryExists.GetWordNameForRegister

function TkwSysutilsFileExists.sysutils_FileExists(const aCtx: TtfwContext;
 const aPath: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:FileExists }
//#UC START# *880D1E65813C_8709A220B763_var*
//#UC END# *880D1E65813C_8709A220B763_var*
begin
//#UC START# *880D1E65813C_8709A220B763_impl*
 Result := FileExists(aPath);
//#UC END# *880D1E65813C_8709A220B763_impl*
end;//TkwSysutilsFileExists.sysutils_FileExists

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

class function TkwSysutilsFileExists.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:FileExists';
end;//TkwSysutilsFileExists.GetWordNameForRegister

function TkwSysutilsForceDirectories.sysutils_ForceDirectories(const aCtx: TtfwContext;
 const aPath: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:ForceDirectories }
//#UC START# *DF7BBEF65068_4F6F96722B37_var*
//#UC END# *DF7BBEF65068_4F6F96722B37_var*
begin
//#UC START# *DF7BBEF65068_4F6F96722B37_impl*
 Result := ForceDirectories(aPath);
//#UC END# *DF7BBEF65068_4F6F96722B37_impl*
end;//TkwSysutilsForceDirectories.sysutils_ForceDirectories

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

class function TkwSysutilsForceDirectories.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ForceDirectories';
end;//TkwSysutilsForceDirectories.GetWordNameForRegister

procedure TkwSetAppPath2CurrentDir.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_21D0FBE864A6_var*
//#UC END# *4DAEEDE10285_21D0FBE864A6_var*
begin
//#UC START# *4DAEEDE10285_21D0FBE864A6_impl*
 SetCurrentDir(ExtractFilePath(ParamStr(0)));
//#UC END# *4DAEEDE10285_21D0FBE864A6_impl*
end;//TkwSetAppPath2CurrentDir.DoDoIt

function TkwSetAppPath2CurrentDir.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwSetAppPath2CurrentDir.GetResultTypeInfo

function TkwSetAppPath2CurrentDir.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwSetAppPath2CurrentDir.GetAllParamsCount

class function TkwSetAppPath2CurrentDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetAppPath2CurrentDir';
end;//TkwSetAppPath2CurrentDir.GetWordNameForRegister

function TkwApplicationExeName.application_ExeName(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта application:ExeName }
//#UC START# *BBBD58864003_B3D96AECB8FC_var*
//#UC END# *BBBD58864003_B3D96AECB8FC_var*
begin
//#UC START# *BBBD58864003_B3D96AECB8FC_impl*
 Result := ParamStr(0);
//#UC END# *BBBD58864003_B3D96AECB8FC_impl*
end;//TkwApplicationExeName.application_ExeName

procedure TkwApplicationExeName.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(application_ExeName(aCtx));
end;//TkwApplicationExeName.DoDoIt

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

class function TkwApplicationExeName.GetWordNameForRegister: AnsiString;
begin
 Result := 'application:ExeName';
end;//TkwApplicationExeName.GetWordNameForRegister

function TkwGetTickCount.GetTickCount(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта GetTickCount }
//#UC START# *5DDD1E88CFCD_283A1C53257F_var*
//#UC END# *5DDD1E88CFCD_283A1C53257F_var*
begin
//#UC START# *5DDD1E88CFCD_283A1C53257F_impl*
 Result := Windows.GetTickCount;
//#UC END# *5DDD1E88CFCD_283A1C53257F_impl*
end;//TkwGetTickCount.GetTickCount

procedure TkwGetTickCount.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(GetTickCount(aCtx));
end;//TkwGetTickCount.DoDoIt

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

class function TkwGetTickCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetTickCount';
end;//TkwGetTickCount.GetWordNameForRegister

procedure TkwApplicationActionIdle.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4321FF105F4A_var*
//#UC END# *4DAEEDE10285_4321FF105F4A_var*
begin
//#UC START# *4DAEEDE10285_4321FF105F4A_impl*
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
//#UC END# *4DAEEDE10285_4321FF105F4A_impl*
end;//TkwApplicationActionIdle.DoDoIt

function TkwApplicationActionIdle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwApplicationActionIdle.GetResultTypeInfo

function TkwApplicationActionIdle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwApplicationActionIdle.GetAllParamsCount

class function TkwApplicationActionIdle.GetWordNameForRegister: AnsiString;
begin
 Result := 'application:ActionIdle';
end;//TkwApplicationActionIdle.GetWordNameForRegister

procedure TkwClipboardClear.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2761B617CA85_var*
//#UC END# *4DAEEDE10285_2761B617CA85_var*
begin
//#UC START# *4DAEEDE10285_2761B617CA85_impl*
 l3System.ClearClipboard;
//#UC END# *4DAEEDE10285_2761B617CA85_impl*
end;//TkwClipboardClear.DoDoIt

function TkwClipboardClear.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwClipboardClear.GetResultTypeInfo

function TkwClipboardClear.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwClipboardClear.GetAllParamsCount

class function TkwClipboardClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'clipboard:clear';
end;//TkwClipboardClear.GetWordNameForRegister

procedure TkwSetLocalDate.SetLocalDate(const aCtx: TtfwContext;
 aDay: Integer;
 aMonth: Integer;
 anYear: Integer);
 {* Реализация слова скрипта SetLocalDate }
//#UC START# *FCCD09033538_8A50690C658A_var*
var
 l_Time: TSystemTime;
//#UC END# *FCCD09033538_8A50690C658A_var*
begin
//#UC START# *FCCD09033538_8A50690C658A_impl*
 Windows.GetLocalTime(l_Time);
 
 l_Time.wDay := aDay;
 l_Time.wMonth := aMonth;
 l_Time.wYear := anYear;

 Windows.SetLocalTime(l_Time);
//#UC END# *FCCD09033538_8A50690C658A_impl*
end;//TkwSetLocalDate.SetLocalDate

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

class function TkwSetLocalDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetLocalDate';
end;//TkwSetLocalDate.GetWordNameForRegister

procedure TkwSetLocalTime.SetLocalTime(const aCtx: TtfwContext;
 aMilli: Integer;
 aSecond: Integer;
 aMinute: Integer;
 anHour: Integer);
 {* Реализация слова скрипта SetLocalTime }
//#UC START# *5AB6E7F355A8_453F93ACCEA3_var*
var
 l_Time: TSystemTime;
//#UC END# *5AB6E7F355A8_453F93ACCEA3_var*
begin
//#UC START# *5AB6E7F355A8_453F93ACCEA3_impl*
 Windows.GetLocalTime(l_Time);

 l_Time.wMilliseconds := aMilli;
 l_Time.wSecond := aSecond;
 l_Time.wMinute := aMinute;
 l_Time.wHour := anHour;

 Windows.SetLocalTime(l_Time);
//#UC END# *5AB6E7F355A8_453F93ACCEA3_impl*
end;//TkwSetLocalTime.SetLocalTime

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

class function TkwSetLocalTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetLocalTime';
end;//TkwSetLocalTime.GetWordNameForRegister

procedure TkwSetLocalDateTime.SetLocalDateTime(const aCtx: TtfwContext;
 aMilli: Integer;
 aSecond: Integer;
 aMinute: Integer;
 anHour: Integer;
 aDay: Integer;
 aMonth: Integer;
 anYear: Integer);
 {* Реализация слова скрипта SetLocalDateTime }
//#UC START# *86288D38BB4F_CC86921D0E73_var*
var
 l_Time: TSystemTime;
//#UC END# *86288D38BB4F_CC86921D0E73_var*
begin
//#UC START# *86288D38BB4F_CC86921D0E73_impl*
 Windows.GetLocalTime(l_Time);

 l_Time.wMilliseconds := aMilli;
 l_Time.wSecond := aSecond;
 l_Time.wMinute := aMinute;
 l_Time.wHour := anHour;
 l_Time.wDay := aDay;
 l_Time.wMonth := aMonth;
 l_Time.wYear := anYear;

 Windows.SetLocalTime(l_Time);
//#UC END# *86288D38BB4F_CC86921D0E73_impl*
end;//TkwSetLocalDateTime.SetLocalDateTime

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

class function TkwSetLocalDateTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'SetLocalDateTime';
end;//TkwSetLocalDateTime.GetWordNameForRegister

procedure TkwGetLocalDate.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F6C5E61F680C_var*
var
  l_Time: TSystemTime;
//#UC END# *4DAEEDE10285_F6C5E61F680C_var*
begin
//#UC START# *4DAEEDE10285_F6C5E61F680C_impl*
 Windows.GetLocalTime(l_Time);
 aCtx.rEngine.PushInt(l_Time.wYear);
 aCtx.rEngine.PushInt(l_Time.wMonth);
 aCtx.rEngine.PushInt(l_Time.wDay);
//#UC END# *4DAEEDE10285_F6C5E61F680C_impl*
end;//TkwGetLocalDate.DoDoIt

function TkwGetLocalDate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGetLocalDate.GetResultTypeInfo

function TkwGetLocalDate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetLocalDate.GetAllParamsCount

class function TkwGetLocalDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetLocalDate';
end;//TkwGetLocalDate.GetWordNameForRegister

procedure TkwGetLocalDateTime.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1FE2F18F76F6_var*
var
  l_Time: TSystemTime;
//#UC END# *4DAEEDE10285_1FE2F18F76F6_var*
begin
//#UC START# *4DAEEDE10285_1FE2F18F76F6_impl*
 Windows.GetLocalTime(l_Time);
 aCtx.rEngine.PushInt(l_Time.wYear);
 aCtx.rEngine.PushInt(l_Time.wMonth);
 aCtx.rEngine.PushInt(l_Time.wDay);
 aCtx.rEngine.PushInt(l_Time.wHour);
 aCtx.rEngine.PushInt(l_Time.wMinute);
 aCtx.rEngine.PushInt(l_Time.wSecond);
 aCtx.rEngine.PushInt(l_Time.wMilliseconds);
//#UC END# *4DAEEDE10285_1FE2F18F76F6_impl*
end;//TkwGetLocalDateTime.DoDoIt

function TkwGetLocalDateTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGetLocalDateTime.GetResultTypeInfo

function TkwGetLocalDateTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetLocalDateTime.GetAllParamsCount

class function TkwGetLocalDateTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetLocalDateTime';
end;//TkwGetLocalDateTime.GetWordNameForRegister

procedure TkwGetLocalTime.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_47E01D1A49DA_var*
var
  l_Time: TSystemTime;
//#UC END# *4DAEEDE10285_47E01D1A49DA_var*
begin
//#UC START# *4DAEEDE10285_47E01D1A49DA_impl*
 Windows.GetLocalTime(l_Time); 
 aCtx.rEngine.PushInt(l_Time.wHour);
 aCtx.rEngine.PushInt(l_Time.wMinute);
 aCtx.rEngine.PushInt(l_Time.wSecond);
 aCtx.rEngine.PushInt(l_Time.wMilliseconds);
//#UC END# *4DAEEDE10285_47E01D1A49DA_impl*
end;//TkwGetLocalTime.DoDoIt

function TkwGetLocalTime.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGetLocalTime.GetResultTypeInfo

function TkwGetLocalTime.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwGetLocalTime.GetAllParamsCount

class function TkwGetLocalTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'GetLocalTime';
end;//TkwGetLocalTime.GetWordNameForRegister

procedure TkwStartTimer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_084854089DF8_var*
//#UC END# *4DAEEDE10285_084854089DF8_var*
begin
//#UC START# *4DAEEDE10285_084854089DF8_impl*
 aCtx.rCaller.StartTimer;
//#UC END# *4DAEEDE10285_084854089DF8_impl*
end;//TkwStartTimer.DoDoIt

function TkwStartTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwStartTimer.GetResultTypeInfo

function TkwStartTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwStartTimer.GetAllParamsCount

class function TkwStartTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'StartTimer';
end;//TkwStartTimer.GetWordNameForRegister

function TkwStopTimer.StopTimer(const aCtx: TtfwContext;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimer }
//#UC START# *D41B4A8BB159_E113BA65B398_var*
//#UC END# *D41B4A8BB159_E113BA65B398_var*
begin
//#UC START# *D41B4A8BB159_E113BA65B398_impl*
 Result := aCtx.rCaller.StopTimer(aName);
//#UC END# *D41B4A8BB159_E113BA65B398_impl*
end;//TkwStopTimer.StopTimer

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

class function TkwStopTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimer';
end;//TkwStopTimer.GetWordNameForRegister

function TkwStopTimerEx.StopTimerEx(const aCtx: TtfwContext;
 const aSubName: AnsiString;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimerEx }
//#UC START# *9630E77C53F3_861A2BB899E3_var*
//#UC END# *9630E77C53F3_861A2BB899E3_var*
begin
//#UC START# *9630E77C53F3_861A2BB899E3_impl*
 Result := aCtx.rCaller.StopTimer(aName, aSubName)
//#UC END# *9630E77C53F3_861A2BB899E3_impl*
end;//TkwStopTimerEx.StopTimerEx

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

class function TkwStopTimerEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimerEx';
end;//TkwStopTimerEx.GetWordNameForRegister

procedure TkwTimeToLog.TimeToLog(const aCtx: TtfwContext;
 aValue: Integer;
 const aSubName: AnsiString;
 const aName: AnsiString);
 {* Реализация слова скрипта TimeToLog }
//#UC START# *1CD228A2D1EA_1C56158F55E7_var*

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
//#UC END# *1CD228A2D1EA_1C56158F55E7_var*
begin
//#UC START# *1CD228A2D1EA_1C56158F55E7_impl*
 l_S2 := Mangle(aSubName);
 l_S1 := Mangle(aName);
 aCtx.rCaller.TimeToLog(aValue, l_S1, l_S2);
//#UC END# *1CD228A2D1EA_1C56158F55E7_impl*
end;//TkwTimeToLog.TimeToLog

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

class function TkwTimeToLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'TimeToLog';
end;//TkwTimeToLog.GetWordNameForRegister

procedure TkwShiftDate.ShiftDate(const aCtx: TtfwContext;
 aDeltaD: Integer;
 aDeltaM: Integer;
 aDeltaY: Integer);
 {* Реализация слова скрипта ShiftDate }
//#UC START# *90D645BF4786_7411EFEEC0A2_var*
var
 l_Time: TSystemTime;
 l_DelphiTime: TDateTime;
//#UC END# *90D645BF4786_7411EFEEC0A2_var*
begin
//#UC START# *90D645BF4786_7411EFEEC0A2_impl*
 Windows.GetLocalTime(l_Time);
 with l_Time do
  l_DelphiTime := EncodeDateTime(wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 l_DelphiTime := IncYear(l_DelphiTime, aDeltaY);
 l_DelphiTime := IncMonth(l_DelphiTime, aDeltaM);
 l_DelphiTime := IncDay(l_DelphiTime, aDeltaD);
 with l_Time do
  DecodeDateTime(l_DelphiTime, wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 Windows.SetLocalTime(l_Time);
//#UC END# *90D645BF4786_7411EFEEC0A2_impl*
end;//TkwShiftDate.ShiftDate

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

class function TkwShiftDate.GetWordNameForRegister: AnsiString;
begin
 Result := 'ShiftDate';
end;//TkwShiftDate.GetWordNameForRegister

procedure TkwShiftTime.ShiftTime(const aCtx: TtfwContext;
 aDeltaMilli: Integer);
 {* Реализация слова скрипта ShiftTime }
//#UC START# *1922D633B85B_9F4966698005_var*
var
 l_Time: TSystemTime;
 l_DelphiTime: TDateTime;
//#UC END# *1922D633B85B_9F4966698005_var*
begin
//#UC START# *1922D633B85B_9F4966698005_impl*
 Windows.GetLocalTime(l_Time);
 with l_Time do
  l_DelphiTime := EncodeDateTime(wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 l_DelphiTime := IncMilliSecond(l_DelphiTime, aDeltaMilli);
 with l_Time do
  DecodeDateTime(l_DelphiTime, wYear, wMonth, wDay, wHour, wMinute, wSecond, wMilliseconds);
 Windows.SetLocalTime(l_Time);
//#UC END# *1922D633B85B_9F4966698005_impl*
end;//TkwShiftTime.ShiftTime

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

class function TkwShiftTime.GetWordNameForRegister: AnsiString;
begin
 Result := 'ShiftTime';
end;//TkwShiftTime.GetWordNameForRegister

function TkwClipboardGetFormattedText.clipboard_GetFormattedText(const aCtx: TtfwContext;
 const aFormat: TtfwStackValue): Il3CString;
 {* Реализация слова скрипта clipboard:GetFormattedText }
//#UC START# *545B4C0C78E1_B4A35E44526B_var*
var
 l_Format: Cardinal;
 l_ClipbrdHandle: THandle;
 l_String: PChar;
//#UC END# *545B4C0C78E1_B4A35E44526B_var*
begin
//#UC START# *545B4C0C78E1_B4A35E44526B_impl*
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
//#UC END# *545B4C0C78E1_B4A35E44526B_impl*
end;//TkwClipboardGetFormattedText.clipboard_GetFormattedText

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

class function TkwClipboardGetFormattedText.GetWordNameForRegister: AnsiString;
begin
 Result := 'clipboard:GetFormattedText';
end;//TkwClipboardGetFormattedText.GetWordNameForRegister

procedure TkwClipboardSetText.clipboard_SetText(const aCtx: TtfwContext;
 const aValue: Il3CString);
 {* Реализация слова скрипта clipboard:SetText }
//#UC START# *3D183F3BE41C_F086F3387CB5_var*
//#UC END# *3D183F3BE41C_F086F3387CB5_var*
begin
//#UC START# *3D183F3BE41C_F086F3387CB5_impl*
 {$If Declared(Clipboard)}
 l3System.SetClipboardData(Tl3CStringDataObject.Make(aValue));
 //Clipboard.AsText := l3Str(aValue);
 {$Else}
 Assert(false);
 {$IfEnd}
//#UC END# *3D183F3BE41C_F086F3387CB5_impl*
end;//TkwClipboardSetText.clipboard_SetText

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

class function TkwClipboardSetText.GetWordNameForRegister: AnsiString;
begin
 Result := 'clipboard:SetText';
end;//TkwClipboardSetText.GetWordNameForRegister

function TkwScriptExceptionStack.script_ExceptionStack(const aCtx: TtfwContext): ItfwValueList;
 {* Реализация слова скрипта script:ExceptionStack }
//#UC START# *B7280416B2E0_E4DA6191960A_var*
//#UC END# *B7280416B2E0_E4DA6191960A_var*
begin
//#UC START# *B7280416B2E0_E4DA6191960A_impl*
 Result := aCtx.rEngine.ExceptionStack;
//#UC END# *B7280416B2E0_E4DA6191960A_impl*
end;//TkwScriptExceptionStack.script_ExceptionStack

procedure TkwScriptExceptionStack.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushList(script_ExceptionStack(aCtx));
end;//TkwScriptExceptionStack.DoDoIt

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

class function TkwScriptExceptionStack.GetWordNameForRegister: AnsiString;
begin
 Result := 'script:ExceptionStack';
end;//TkwScriptExceptionStack.GetWordNameForRegister

function TkwSysutilsParamCount.sysutils_ParamCount(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:ParamCount }
//#UC START# *FD31A8AD6225_DD119E13D005_var*
//#UC END# *FD31A8AD6225_DD119E13D005_var*
begin
//#UC START# *FD31A8AD6225_DD119E13D005_impl*
 Result := ParamCount;
//#UC END# *FD31A8AD6225_DD119E13D005_impl*
end;//TkwSysutilsParamCount.sysutils_ParamCount

procedure TkwSysutilsParamCount.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_ParamCount(aCtx));
end;//TkwSysutilsParamCount.DoDoIt

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

class function TkwSysutilsParamCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ParamCount';
end;//TkwSysutilsParamCount.GetWordNameForRegister

function TkwSysutilsParamStr.sysutils_ParamStr(const aCtx: TtfwContext;
 anIndex: Integer): AnsiString;
 {* Реализация слова скрипта sysutils:ParamStr }
//#UC START# *5E9E901ED18F_3606634B9E3C_var*
//#UC END# *5E9E901ED18F_3606634B9E3C_var*
begin
//#UC START# *5E9E901ED18F_3606634B9E3C_impl*
 Result := ParamStr(anIndex);
//#UC END# *5E9E901ED18F_3606634B9E3C_impl*
end;//TkwSysutilsParamStr.sysutils_ParamStr

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

class function TkwSysutilsParamStr.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:ParamStr';
end;//TkwSysutilsParamStr.GetWordNameForRegister

function TkwSysutilsGetCurrentDir.sysutils_GetCurrentDir(const aCtx: TtfwContext): AnsiString;
 {* Реализация слова скрипта sysutils:GetCurrentDir }
//#UC START# *D00C735B4A0F_A28B96AFE5F4_var*
//#UC END# *D00C735B4A0F_A28B96AFE5F4_var*
begin
//#UC START# *D00C735B4A0F_A28B96AFE5F4_impl*
 Result := SysUtils.GetCurrentDir;
//#UC END# *D00C735B4A0F_A28B96AFE5F4_impl*
end;//TkwSysutilsGetCurrentDir.sysutils_GetCurrentDir

procedure TkwSysutilsGetCurrentDir.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString(sysutils_GetCurrentDir(aCtx));
end;//TkwSysutilsGetCurrentDir.DoDoIt

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

class function TkwSysutilsGetCurrentDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:GetCurrentDir';
end;//TkwSysutilsGetCurrentDir.GetWordNameForRegister

function TkwSysutilsSetCurrentDir.sysutils_SetCurrentDir(const aCtx: TtfwContext;
 const aDir: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:SetCurrentDir }
//#UC START# *025851A67EF2_46A105452BD6_var*
//#UC END# *025851A67EF2_46A105452BD6_var*
begin
//#UC START# *025851A67EF2_46A105452BD6_impl*
 Result := SysUtils.SetCurrentDir(aDir); 
//#UC END# *025851A67EF2_46A105452BD6_impl*
end;//TkwSysutilsSetCurrentDir.sysutils_SetCurrentDir

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

class function TkwSysutilsSetCurrentDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:SetCurrentDir';
end;//TkwSysutilsSetCurrentDir.GetWordNameForRegister

function TkwSysutilsCreateDir.sysutils_CreateDir(const aCtx: TtfwContext;
 const aDir: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:CreateDir }
//#UC START# *E0BDBA6E01AC_B3CBD7A00B4E_var*
//#UC END# *E0BDBA6E01AC_B3CBD7A00B4E_var*
begin
//#UC START# *E0BDBA6E01AC_B3CBD7A00B4E_impl*
 Result := SysUtils.CreateDir(aDir);
//#UC END# *E0BDBA6E01AC_B3CBD7A00B4E_impl*
end;//TkwSysutilsCreateDir.sysutils_CreateDir

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

class function TkwSysutilsCreateDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:CreateDir';
end;//TkwSysutilsCreateDir.GetWordNameForRegister

function TkwSysutilsRemoveDir.sysutils_RemoveDir(const aCtx: TtfwContext;
 const aDir: AnsiString): Boolean;
 {* Реализация слова скрипта sysutils:RemoveDir }
//#UC START# *177FD19E027A_5C2417DB86EF_var*
//#UC END# *177FD19E027A_5C2417DB86EF_var*
begin
//#UC START# *177FD19E027A_5C2417DB86EF_impl*
 Result := SysUtils.RemoveDir(aDir);
//#UC END# *177FD19E027A_5C2417DB86EF_impl*
end;//TkwSysutilsRemoveDir.sysutils_RemoveDir

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

class function TkwSysutilsRemoveDir.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:RemoveDir';
end;//TkwSysutilsRemoveDir.GetWordNameForRegister

procedure TkwSysutilsLog.sysutils_Log(const aCtx: TtfwContext;
 const aStr: AnsiString);
 {* Реализация слова скрипта sysutils:Log }
//#UC START# *57A4707049E6_11AFB32EDAFF_var*
//#UC END# *57A4707049E6_11AFB32EDAFF_var*
begin
//#UC START# *57A4707049E6_11AFB32EDAFF_impl*
 l3System.Msg2Log(aStr);
//#UC END# *57A4707049E6_11AFB32EDAFF_impl*
end;//TkwSysutilsLog.sysutils_Log

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

class function TkwSysutilsLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:Log';
end;//TkwSysutilsLog.GetWordNameForRegister

function TkwStopTimerNoLog.StopTimerNoLog(const aCtx: TtfwContext;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimerNoLog }
//#UC START# *5E78D238500C_B2DDD43C4AAD_var*
//#UC END# *5E78D238500C_B2DDD43C4AAD_var*
begin
//#UC START# *5E78D238500C_B2DDD43C4AAD_impl*
 Result := aCtx.rCaller.StopTimer(aName, '', false);
//#UC END# *5E78D238500C_B2DDD43C4AAD_impl*
end;//TkwStopTimerNoLog.StopTimerNoLog

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

class function TkwStopTimerNoLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimerNoLog';
end;//TkwStopTimerNoLog.GetWordNameForRegister

function TkwStopTimerExNoLog.StopTimerExNoLog(const aCtx: TtfwContext;
 const aSubName: AnsiString;
 const aName: AnsiString): Integer;
 {* Реализация слова скрипта StopTimerExNoLog }
//#UC START# *F9CE454CCB41_74A78971F11E_var*
//#UC END# *F9CE454CCB41_74A78971F11E_var*
begin
//#UC START# *F9CE454CCB41_74A78971F11E_impl*
 Result := aCtx.rCaller.StopTimer(aName, aSubName, false);
//#UC END# *F9CE454CCB41_74A78971F11E_impl*
end;//TkwStopTimerExNoLog.StopTimerExNoLog

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

class function TkwStopTimerExNoLog.GetWordNameForRegister: AnsiString;
begin
 Result := 'StopTimerExNoLog';
end;//TkwStopTimerExNoLog.GetWordNameForRegister

function TkwSysutilsLocale.sysutils_Locale(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:Locale }
//#UC START# *EB678D53E91B_0E473EAE64F5_var*
//#UC END# *EB678D53E91B_0E473EAE64F5_var*
begin
//#UC START# *EB678D53E91B_0E473EAE64F5_impl*
 Result := GetThreadLocale;
//#UC END# *EB678D53E91B_0E473EAE64F5_impl*
end;//TkwSysutilsLocale.sysutils_Locale

procedure TkwSysutilsLocale.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_Locale(aCtx));
end;//TkwSysutilsLocale.DoDoIt

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

class function TkwSysutilsLocale.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:Locale';
end;//TkwSysutilsLocale.GetWordNameForRegister

function TkwSysutilsCodePage.sysutils_CodePage(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:CodePage }
//#UC START# *2B350B586005_99FA1EBBCB0B_var*

 function LCIDToCodePage(ALcid: LCID): Integer;
 var
   Buffer: array [0..6] of Char;
 begin
   GetLocaleInfo(ALcid, LOCALE_IDEFAULTANSICODEPAGE, Buffer, SizeOf(Buffer));
   Result:= StrToIntDef(Buffer, GetACP);
 end;
 
//#UC END# *2B350B586005_99FA1EBBCB0B_var*
begin
//#UC START# *2B350B586005_99FA1EBBCB0B_impl*
 Result := LCIDToCodePage(GetThreadLocale);
//#UC END# *2B350B586005_99FA1EBBCB0B_impl*
end;//TkwSysutilsCodePage.sysutils_CodePage

procedure TkwSysutilsCodePage.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_CodePage(aCtx));
end;//TkwSysutilsCodePage.DoDoIt

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

class function TkwSysutilsCodePage.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:CodePage';
end;//TkwSysutilsCodePage.GetWordNameForRegister

function TkwSysutilsGetACP.sysutils_GetACP(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта sysutils:GetACP }
//#UC START# *28FAC549D1D9_F3BEFDFBCD3D_var*
//#UC END# *28FAC549D1D9_F3BEFDFBCD3D_var*
begin
//#UC START# *28FAC549D1D9_F3BEFDFBCD3D_impl*
 Result := Windows.GetACP; 
//#UC END# *28FAC549D1D9_F3BEFDFBCD3D_impl*
end;//TkwSysutilsGetACP.sysutils_GetACP

procedure TkwSysutilsGetACP.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(sysutils_GetACP(aCtx));
end;//TkwSysutilsGetACP.DoDoIt

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

class function TkwSysutilsGetACP.GetWordNameForRegister: AnsiString;
begin
 Result := 'sysutils:GetACP';
end;//TkwSysutilsGetACP.GetWordNameForRegister

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
 TSysUtilsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
{$IfEnd} // NOT Defined(NoScripts)

end.
