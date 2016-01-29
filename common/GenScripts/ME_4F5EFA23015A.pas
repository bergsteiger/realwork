unit SysUtilsPack;

interface

uses
 l3IntfUses
 , l3Interfaces
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , tfwGlobalKeyWord
 , TypInfo
;

implementation

uses
 l3ImplUses
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
 , Forms
 , Clipbrd
 , l3Utils
 , l3CStringDataObject
 , l3Chars
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TSysUtilsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TSysUtilsPackResNameGetter
 
 TkwHasTabs = class(TtfwGlobalKeyWord)
  {* Слово скрипта HasTabs
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 HasTabs >>> l_Boolean
[code]  }
  function HasTabs(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта HasTabs }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwHasTabs
 
 TkwIsUnder64 = class(TtfwGlobalKeyWord)
  {* Слово скрипта IsUnder64
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 IsUnder64 >>> l_Boolean
[code]  }
  function IsUnder64(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта IsUnder64 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsUnder64
 
 TkwComputerName = class(TtfwGlobalKeyWord)
  {* Слово скрипта ComputerName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 ComputerName >>> l_String
[code]  }
  function ComputerName(const aCtx: TtfwContext): AnsiString;
   {* Реализация слова скрипта ComputerName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwComputerName
 
 TkwOSName = class(TtfwGlobalKeyWord)
  {* Слово скрипта OSName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 OSName >>> l_String
[code]  }
  function OSName(const aCtx: TtfwContext): AnsiString;
   {* Реализация слова скрипта OSName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOSName
 
 TkwRandom = class(TtfwGlobalKeyWord)
  {* Слово скрипта Random
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aMax Random >>> l_Integer
[code]  }
  function Random(const aCtx: TtfwContext;
   aMax: Integer): Integer;
   {* Реализация слова скрипта Random }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRandom
 
 TkwRandomize = class(TtfwGlobalKeyWord)
  {* Слово скрипта Randomize
*Пример:*
[code]
 Randomize
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRandomize
 
 TkwSetRandSeed = class(TtfwGlobalKeyWord)
  {* Слово скрипта SetRandSeed
*Пример:*
[code]
 aValue SetRandSeed
[code]  }
  procedure SetRandSeed(const aCtx: TtfwContext;
   aValue: Integer);
   {* Реализация слова скрипта SetRandSeed }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetRandSeed
 
 TkwRGB2String = class(TtfwGlobalKeyWord)
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
  function RGB2String(const aCtx: TtfwContext;
   aB: Integer;
   aG: Integer;
   aR: Integer): AnsiString;
   {* Реализация слова скрипта RGB2String }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRGB2String
 
 TkwIntToStr = class(TtfwGlobalKeyWord)
  {* Слово скрипта IntToStr
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aValue IntToStr >>> l_String
[code]  }
  function IntToStr(const aCtx: TtfwContext;
   aValue: Integer): AnsiString;
   {* Реализация слова скрипта IntToStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIntToStr
 
 TkwIsXE = class(TtfwGlobalKeyWord)
  {* Слово скрипта IsXE
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 IsXE >>> l_Boolean
[code]  }
  function IsXE(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта IsXE }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsXE
 
 TkwWinExec = class(TtfwGlobalKeyWord)
  {* Слово скрипта WinExec
*Пример:*
[code]
 aPath WinExec
[code]  }
  procedure WinExec(const aCtx: TtfwContext;
   const aPath: AnsiString);
   {* Реализация слова скрипта WinExec }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWinExec
 
 TkwScriptFileName = class(TtfwGlobalKeyWord)
  {* Слово скрипта script:FileName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 script:FileName >>> l_String
[code]  }
  function script_FileName(const aCtx: TtfwContext): AnsiString;
   {* Реализация слова скрипта script:FileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScriptFileName
 
 TkwSysutilsChangeFileExt = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ChangeFileExt
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName anExt sysutils:ChangeFileExt >>> l_String
[code]  }
  function sysutils_ChangeFileExt(const aCtx: TtfwContext;
   const anExt: AnsiString;
   const aName: AnsiString): AnsiString;
   {* Реализация слова скрипта sysutils:ChangeFileExt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsChangeFileExt
 
 TkwSysutilsExtractFileName = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFileName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFileName >>> l_String
[code]  }
  function sysutils_ExtractFileName(const aCtx: TtfwContext;
   const aName: AnsiString): AnsiString;
   {* Реализация слова скрипта sysutils:ExtractFileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsExtractFileName
 
 TkwSysutilsExtractFilePath = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFilePath
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFilePath >>> l_String
[code]  }
  function sysutils_ExtractFilePath(const aCtx: TtfwContext;
   const aName: AnsiString): AnsiString;
   {* Реализация слова скрипта sysutils:ExtractFilePath }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsExtractFilePath
 
 TkwSysutilsExtractFileDrive = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ExtractFileDrive
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFileDrive >>> l_String
[code]  }
  function sysutils_ExtractFileDrive(const aCtx: TtfwContext;
   const aName: AnsiString): AnsiString;
   {* Реализация слова скрипта sysutils:ExtractFileDrive }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsExtractFileDrive
 
 TkwSysutilsDirectoryExists = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:DirectoryExists
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:DirectoryExists >>> l_Boolean
[code]  }
  function sysutils_DirectoryExists(const aCtx: TtfwContext;
   const aPath: AnsiString): Boolean;
   {* Реализация слова скрипта sysutils:DirectoryExists }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsDirectoryExists
 
 TkwSysutilsFileExists = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:FileExists
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:FileExists >>> l_Boolean
[code]  }
  function sysutils_FileExists(const aCtx: TtfwContext;
   const aPath: AnsiString): Boolean;
   {* Реализация слова скрипта sysutils:FileExists }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsFileExists
 
 TkwSysutilsForceDirectories = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ForceDirectories
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:ForceDirectories >>> l_Boolean
[code]  }
  function sysutils_ForceDirectories(const aCtx: TtfwContext;
   const aPath: AnsiString): Boolean;
   {* Реализация слова скрипта sysutils:ForceDirectories }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsForceDirectories
 
 TkwSetAppPath2CurrentDir = class(TtfwGlobalKeyWord)
  {* Слово скрипта SetAppPath2CurrentDir
*Пример:*
[code]
 SetAppPath2CurrentDir
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetAppPath2CurrentDir
 
 TkwApplicationExeName = class(TtfwGlobalKeyWord)
  {* Слово скрипта application:ExeName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 application:ExeName >>> l_String
[code]  }
  function application_ExeName(const aCtx: TtfwContext): AnsiString;
   {* Реализация слова скрипта application:ExeName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationExeName
 
 TkwGetTickCount = class(TtfwGlobalKeyWord)
  {* Слово скрипта GetTickCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 GetTickCount >>> l_Integer
[code]  }
  function GetTickCount(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта GetTickCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetTickCount
 
 TkwApplicationActionIdle = class(TtfwGlobalKeyWord)
  {* Слово скрипта application:ActionIdle
*Пример:*
[code]
 application:ActionIdle
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationActionIdle
 
 TkwClipboardClear = class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:clear
*Пример:*
[code]
 clipboard:clear
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwClipboardClear
 
 TkwSetLocalDate = class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalDate
*Пример:*
[code]
 anYear aMonth aDay SetLocalDate
[code]  }
  procedure SetLocalDate(const aCtx: TtfwContext;
   aDay: Integer;
   aMonth: Integer;
   anYear: Integer);
   {* Реализация слова скрипта SetLocalDate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetLocalDate
 
 TkwSetLocalTime = class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalTime
*Пример:*
[code]
 anHour aMinute aSecond aMilli SetLocalTime
[code]  }
  procedure SetLocalTime(const aCtx: TtfwContext;
   aMilli: Integer;
   aSecond: Integer;
   aMinute: Integer;
   anHour: Integer);
   {* Реализация слова скрипта SetLocalTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetLocalTime
 
 TkwSetLocalDateTime = class(TtfwGlobalKeyWord)
  {* Слово скрипта SetLocalDateTime
*Пример:*
[code]
 anYear aMonth aDay anHour aMinute aSecond aMilli SetLocalDateTime
[code]  }
  procedure SetLocalDateTime(const aCtx: TtfwContext;
   aMilli: Integer;
   aSecond: Integer;
   aMinute: Integer;
   anHour: Integer;
   aDay: Integer;
   aMonth: Integer;
   anYear: Integer);
   {* Реализация слова скрипта SetLocalDateTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetLocalDateTime
 
 TkwGetLocalDate = class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalDate
*Пример:*
[code]
 GetLocalDate
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetLocalDate
 
 TkwGetLocalDateTime = class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalDateTime
*Пример:*
[code]
 GetLocalDateTime
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetLocalDateTime
 
 TkwGetLocalTime = class(TtfwGlobalKeyWord)
  {* Слово скрипта GetLocalTime
*Пример:*
[code]
 GetLocalTime
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetLocalTime
 
 TkwStartTimer = class(TtfwGlobalKeyWord)
  {* Слово скрипта StartTimer
*Пример:*
[code]
 StartTimer
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStartTimer
 
 TkwStopTimer = class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimer
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName StopTimer >>> l_Integer
[code]  }
  function StopTimer(const aCtx: TtfwContext;
   const aName: AnsiString): Integer;
   {* Реализация слова скрипта StopTimer }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStopTimer
 
 TkwStopTimerEx = class(TtfwGlobalKeyWord)
  {* Слово скрипта StopTimerEx
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName aSubName StopTimerEx >>> l_Integer
[code]  }
  function StopTimerEx(const aCtx: TtfwContext;
   const aSubName: AnsiString;
   const aName: AnsiString): Integer;
   {* Реализация слова скрипта StopTimerEx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStopTimerEx
 
 TkwTimeToLog = class(TtfwGlobalKeyWord)
  {* Слово скрипта TimeToLog
*Пример:*
[code]
 aName aSubName aValue TimeToLog
[code]  }
  procedure TimeToLog(const aCtx: TtfwContext;
   aValue: Integer;
   const aSubName: AnsiString;
   const aName: AnsiString);
   {* Реализация слова скрипта TimeToLog }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTimeToLog
 
 TkwShiftDate = class(TtfwGlobalKeyWord)
  {* Слово скрипта ShiftDate
*Пример:*
[code]
 aDeltaY aDeltaM aDeltaD ShiftDate
[code]  }
  procedure ShiftDate(const aCtx: TtfwContext;
   aDeltaD: Integer;
   aDeltaM: Integer;
   aDeltaY: Integer);
   {* Реализация слова скрипта ShiftDate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwShiftDate
 
 TkwShiftTime = class(TtfwGlobalKeyWord)
  {* Слово скрипта ShiftTime
*Пример:*
[code]
 aDeltaMilli ShiftTime
[code]  }
  procedure ShiftTime(const aCtx: TtfwContext;
   aDeltaMilli: Integer);
   {* Реализация слова скрипта ShiftTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwShiftTime
 
 TkwClipboardGetFormattedText = class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:GetFormattedText
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aFormat clipboard:GetFormattedText >>> l_Il3CString
[code]  }
  function clipboard_GetFormattedText(const aCtx: TtfwContext;
   const aFormat: TtfwStackValue): Il3CString;
   {* Реализация слова скрипта clipboard:GetFormattedText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwClipboardGetFormattedText
 
 TkwClipboardSetText = class(TtfwGlobalKeyWord)
  {* Слово скрипта clipboard:SetText
*Пример:*
[code]
 aValue clipboard:SetText
[code]  }
  procedure clipboard_SetText(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* Реализация слова скрипта clipboard:SetText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwClipboardSetText
 
 TkwScriptExceptionStack = class(TtfwGlobalKeyWord)
  {* Слово скрипта script:ExceptionStack
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 script:ExceptionStack >>> l_ItfwValueList
[code]  }
  function script_ExceptionStack(const aCtx: TtfwContext): ItfwValueList;
   {* Реализация слова скрипта script:ExceptionStack }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScriptExceptionStack
 
 TkwSysutilsParamCount = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ParamCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 sysutils:ParamCount >>> l_Integer
[code]  }
  function sysutils_ParamCount(const aCtx: TtfwContext): Integer;
   {* Реализация слова скрипта sysutils:ParamCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsParamCount
 
 TkwSysutilsParamStr = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:ParamStr
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 anIndex sysutils:ParamStr >>> l_String
[code]  }
  function sysutils_ParamStr(const aCtx: TtfwContext;
   anIndex: Integer): AnsiString;
   {* Реализация слова скрипта sysutils:ParamStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsParamStr
 
 TkwSysutilsGetCurrentDir = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:GetCurrentDir
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 sysutils:GetCurrentDir >>> l_String
[code]  }
  function sysutils_GetCurrentDir(const aCtx: TtfwContext): AnsiString;
   {* Реализация слова скрипта sysutils:GetCurrentDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsGetCurrentDir
 
 TkwSysutilsSetCurrentDir = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:SetCurrentDir
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:SetCurrentDir >>> l_Boolean
[code]  }
  function sysutils_SetCurrentDir(const aCtx: TtfwContext;
   const aDir: AnsiString): Boolean;
   {* Реализация слова скрипта sysutils:SetCurrentDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsSetCurrentDir
 
 TkwSysutilsCreateDir = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:CreateDir
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:CreateDir >>> l_Boolean
[code]  }
  function sysutils_CreateDir(const aCtx: TtfwContext;
   const aDir: AnsiString): Boolean;
   {* Реализация слова скрипта sysutils:CreateDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsCreateDir
 
 TkwSysutilsRemoveDir = class(TtfwGlobalKeyWord)
  {* Слово скрипта sysutils:RemoveDir
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:RemoveDir >>> l_Boolean
[code]  }
  function sysutils_RemoveDir(const aCtx: TtfwContext;
   const aDir: AnsiString): Boolean;
   {* Реализация слова скрипта sysutils:RemoveDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsRemoveDir
 
end.
