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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TSysUtilsPackResNameGetter
 
 TkwHasTabs = class(TtfwGlobalKeyWord)
  {* ����� ������� HasTabs
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 HasTabs >>> l_Boolean
[code]  }
  function HasTabs(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� HasTabs }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwHasTabs
 
 TkwIsUnder64 = class(TtfwGlobalKeyWord)
  {* ����� ������� IsUnder64
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 IsUnder64 >>> l_Boolean
[code]  }
  function IsUnder64(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� IsUnder64 }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsUnder64
 
 TkwComputerName = class(TtfwGlobalKeyWord)
  {* ����� ������� ComputerName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 ComputerName >>> l_String
[code]  }
  function ComputerName(const aCtx: TtfwContext): AnsiString;
   {* ���������� ����� ������� ComputerName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwComputerName
 
 TkwOSName = class(TtfwGlobalKeyWord)
  {* ����� ������� OSName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 OSName >>> l_String
[code]  }
  function OSName(const aCtx: TtfwContext): AnsiString;
   {* ���������� ����� ������� OSName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOSName
 
 TkwRandom = class(TtfwGlobalKeyWord)
  {* ����� ������� Random
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aMax Random >>> l_Integer
[code]  }
  function Random(const aCtx: TtfwContext;
   aMax: Integer): Integer;
   {* ���������� ����� ������� Random }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRandom
 
 TkwRandomize = class(TtfwGlobalKeyWord)
  {* ����� ������� Randomize
*������:*
[code]
 Randomize
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRandomize
 
 TkwSetRandSeed = class(TtfwGlobalKeyWord)
  {* ����� ������� SetRandSeed
*������:*
[code]
 aValue SetRandSeed
[code]  }
  procedure SetRandSeed(const aCtx: TtfwContext;
   aValue: Integer);
   {* ���������� ����� ������� SetRandSeed }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetRandSeed
 
 TkwRGB2String = class(TtfwGlobalKeyWord)
  {* ����� ������� RGB2String
[panel]��������� ������������� R G B � ����������������� ������������� � ���� ������:
[code]
151 40 30 RGB2String .
[code][panel]
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aR aG aB RGB2String >>> l_String
[code]  }
  function RGB2String(const aCtx: TtfwContext;
   aB: Integer;
   aG: Integer;
   aR: Integer): AnsiString;
   {* ���������� ����� ������� RGB2String }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwRGB2String
 
 TkwIntToStr = class(TtfwGlobalKeyWord)
  {* ����� ������� IntToStr
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aValue IntToStr >>> l_String
[code]  }
  function IntToStr(const aCtx: TtfwContext;
   aValue: Integer): AnsiString;
   {* ���������� ����� ������� IntToStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIntToStr
 
 TkwIsXE = class(TtfwGlobalKeyWord)
  {* ����� ������� IsXE
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 IsXE >>> l_Boolean
[code]  }
  function IsXE(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� IsXE }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwIsXE
 
 TkwWinExec = class(TtfwGlobalKeyWord)
  {* ����� ������� WinExec
*������:*
[code]
 aPath WinExec
[code]  }
  procedure WinExec(const aCtx: TtfwContext;
   const aPath: AnsiString);
   {* ���������� ����� ������� WinExec }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwWinExec
 
 TkwScriptFileName = class(TtfwGlobalKeyWord)
  {* ����� ������� script:FileName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 script:FileName >>> l_String
[code]  }
  function script_FileName(const aCtx: TtfwContext): AnsiString;
   {* ���������� ����� ������� script:FileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScriptFileName
 
 TkwSysutilsChangeFileExt = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:ChangeFileExt
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aName anExt sysutils:ChangeFileExt >>> l_String
[code]  }
  function sysutils_ChangeFileExt(const aCtx: TtfwContext;
   const anExt: AnsiString;
   const aName: AnsiString): AnsiString;
   {* ���������� ����� ������� sysutils:ChangeFileExt }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsChangeFileExt
 
 TkwSysutilsExtractFileName = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:ExtractFileName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFileName >>> l_String
[code]  }
  function sysutils_ExtractFileName(const aCtx: TtfwContext;
   const aName: AnsiString): AnsiString;
   {* ���������� ����� ������� sysutils:ExtractFileName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsExtractFileName
 
 TkwSysutilsExtractFilePath = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:ExtractFilePath
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFilePath >>> l_String
[code]  }
  function sysutils_ExtractFilePath(const aCtx: TtfwContext;
   const aName: AnsiString): AnsiString;
   {* ���������� ����� ������� sysutils:ExtractFilePath }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsExtractFilePath
 
 TkwSysutilsExtractFileDrive = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:ExtractFileDrive
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aName sysutils:ExtractFileDrive >>> l_String
[code]  }
  function sysutils_ExtractFileDrive(const aCtx: TtfwContext;
   const aName: AnsiString): AnsiString;
   {* ���������� ����� ������� sysutils:ExtractFileDrive }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsExtractFileDrive
 
 TkwSysutilsDirectoryExists = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:DirectoryExists
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:DirectoryExists >>> l_Boolean
[code]  }
  function sysutils_DirectoryExists(const aCtx: TtfwContext;
   const aPath: AnsiString): Boolean;
   {* ���������� ����� ������� sysutils:DirectoryExists }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsDirectoryExists
 
 TkwSysutilsFileExists = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:FileExists
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:FileExists >>> l_Boolean
[code]  }
  function sysutils_FileExists(const aCtx: TtfwContext;
   const aPath: AnsiString): Boolean;
   {* ���������� ����� ������� sysutils:FileExists }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsFileExists
 
 TkwSysutilsForceDirectories = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:ForceDirectories
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aPath sysutils:ForceDirectories >>> l_Boolean
[code]  }
  function sysutils_ForceDirectories(const aCtx: TtfwContext;
   const aPath: AnsiString): Boolean;
   {* ���������� ����� ������� sysutils:ForceDirectories }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsForceDirectories
 
 TkwSetAppPath2CurrentDir = class(TtfwGlobalKeyWord)
  {* ����� ������� SetAppPath2CurrentDir
*������:*
[code]
 SetAppPath2CurrentDir
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetAppPath2CurrentDir
 
 TkwApplicationExeName = class(TtfwGlobalKeyWord)
  {* ����� ������� application:ExeName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 application:ExeName >>> l_String
[code]  }
  function application_ExeName(const aCtx: TtfwContext): AnsiString;
   {* ���������� ����� ������� application:ExeName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationExeName
 
 TkwGetTickCount = class(TtfwGlobalKeyWord)
  {* ����� ������� GetTickCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 GetTickCount >>> l_Integer
[code]  }
  function GetTickCount(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� GetTickCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetTickCount
 
 TkwApplicationActionIdle = class(TtfwGlobalKeyWord)
  {* ����� ������� application:ActionIdle
*������:*
[code]
 application:ActionIdle
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationActionIdle
 
 TkwClipboardClear = class(TtfwGlobalKeyWord)
  {* ����� ������� clipboard:clear
*������:*
[code]
 clipboard:clear
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwClipboardClear
 
 TkwSetLocalDate = class(TtfwGlobalKeyWord)
  {* ����� ������� SetLocalDate
*������:*
[code]
 anYear aMonth aDay SetLocalDate
[code]  }
  procedure SetLocalDate(const aCtx: TtfwContext;
   aDay: Integer;
   aMonth: Integer;
   anYear: Integer);
   {* ���������� ����� ������� SetLocalDate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetLocalDate
 
 TkwSetLocalTime = class(TtfwGlobalKeyWord)
  {* ����� ������� SetLocalTime
*������:*
[code]
 anHour aMinute aSecond aMilli SetLocalTime
[code]  }
  procedure SetLocalTime(const aCtx: TtfwContext;
   aMilli: Integer;
   aSecond: Integer;
   aMinute: Integer;
   anHour: Integer);
   {* ���������� ����� ������� SetLocalTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetLocalTime
 
 TkwSetLocalDateTime = class(TtfwGlobalKeyWord)
  {* ����� ������� SetLocalDateTime
*������:*
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
   {* ���������� ����� ������� SetLocalDateTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSetLocalDateTime
 
 TkwGetLocalDate = class(TtfwGlobalKeyWord)
  {* ����� ������� GetLocalDate
*������:*
[code]
 GetLocalDate
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetLocalDate
 
 TkwGetLocalDateTime = class(TtfwGlobalKeyWord)
  {* ����� ������� GetLocalDateTime
*������:*
[code]
 GetLocalDateTime
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetLocalDateTime
 
 TkwGetLocalTime = class(TtfwGlobalKeyWord)
  {* ����� ������� GetLocalTime
*������:*
[code]
 GetLocalTime
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwGetLocalTime
 
 TkwStartTimer = class(TtfwGlobalKeyWord)
  {* ����� ������� StartTimer
*������:*
[code]
 StartTimer
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStartTimer
 
 TkwStopTimer = class(TtfwGlobalKeyWord)
  {* ����� ������� StopTimer
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aName StopTimer >>> l_Integer
[code]  }
  function StopTimer(const aCtx: TtfwContext;
   const aName: AnsiString): Integer;
   {* ���������� ����� ������� StopTimer }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStopTimer
 
 TkwStopTimerEx = class(TtfwGlobalKeyWord)
  {* ����� ������� StopTimerEx
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aName aSubName StopTimerEx >>> l_Integer
[code]  }
  function StopTimerEx(const aCtx: TtfwContext;
   const aSubName: AnsiString;
   const aName: AnsiString): Integer;
   {* ���������� ����� ������� StopTimerEx }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwStopTimerEx
 
 TkwTimeToLog = class(TtfwGlobalKeyWord)
  {* ����� ������� TimeToLog
*������:*
[code]
 aName aSubName aValue TimeToLog
[code]  }
  procedure TimeToLog(const aCtx: TtfwContext;
   aValue: Integer;
   const aSubName: AnsiString;
   const aName: AnsiString);
   {* ���������� ����� ������� TimeToLog }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTimeToLog
 
 TkwShiftDate = class(TtfwGlobalKeyWord)
  {* ����� ������� ShiftDate
*������:*
[code]
 aDeltaY aDeltaM aDeltaD ShiftDate
[code]  }
  procedure ShiftDate(const aCtx: TtfwContext;
   aDeltaD: Integer;
   aDeltaM: Integer;
   aDeltaY: Integer);
   {* ���������� ����� ������� ShiftDate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwShiftDate
 
 TkwShiftTime = class(TtfwGlobalKeyWord)
  {* ����� ������� ShiftTime
*������:*
[code]
 aDeltaMilli ShiftTime
[code]  }
  procedure ShiftTime(const aCtx: TtfwContext;
   aDeltaMilli: Integer);
   {* ���������� ����� ������� ShiftTime }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwShiftTime
 
 TkwClipboardGetFormattedText = class(TtfwGlobalKeyWord)
  {* ����� ������� clipboard:GetFormattedText
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aFormat clipboard:GetFormattedText >>> l_Il3CString
[code]  }
  function clipboard_GetFormattedText(const aCtx: TtfwContext;
   const aFormat: TtfwStackValue): Il3CString;
   {* ���������� ����� ������� clipboard:GetFormattedText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwClipboardGetFormattedText
 
 TkwClipboardSetText = class(TtfwGlobalKeyWord)
  {* ����� ������� clipboard:SetText
*������:*
[code]
 aValue clipboard:SetText
[code]  }
  procedure clipboard_SetText(const aCtx: TtfwContext;
   const aValue: Il3CString);
   {* ���������� ����� ������� clipboard:SetText }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwClipboardSetText
 
 TkwScriptExceptionStack = class(TtfwGlobalKeyWord)
  {* ����� ������� script:ExceptionStack
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 script:ExceptionStack >>> l_ItfwValueList
[code]  }
  function script_ExceptionStack(const aCtx: TtfwContext): ItfwValueList;
   {* ���������� ����� ������� script:ExceptionStack }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwScriptExceptionStack
 
 TkwSysutilsParamCount = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:ParamCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 sysutils:ParamCount >>> l_Integer
[code]  }
  function sysutils_ParamCount(const aCtx: TtfwContext): Integer;
   {* ���������� ����� ������� sysutils:ParamCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsParamCount
 
 TkwSysutilsParamStr = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:ParamStr
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 anIndex sysutils:ParamStr >>> l_String
[code]  }
  function sysutils_ParamStr(const aCtx: TtfwContext;
   anIndex: Integer): AnsiString;
   {* ���������� ����� ������� sysutils:ParamStr }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsParamStr
 
 TkwSysutilsGetCurrentDir = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:GetCurrentDir
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 sysutils:GetCurrentDir >>> l_String
[code]  }
  function sysutils_GetCurrentDir(const aCtx: TtfwContext): AnsiString;
   {* ���������� ����� ������� sysutils:GetCurrentDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsGetCurrentDir
 
 TkwSysutilsSetCurrentDir = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:SetCurrentDir
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:SetCurrentDir >>> l_Boolean
[code]  }
  function sysutils_SetCurrentDir(const aCtx: TtfwContext;
   const aDir: AnsiString): Boolean;
   {* ���������� ����� ������� sysutils:SetCurrentDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsSetCurrentDir
 
 TkwSysutilsCreateDir = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:CreateDir
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:CreateDir >>> l_Boolean
[code]  }
  function sysutils_CreateDir(const aCtx: TtfwContext;
   const aDir: AnsiString): Boolean;
   {* ���������� ����� ������� sysutils:CreateDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsCreateDir
 
 TkwSysutilsRemoveDir = class(TtfwGlobalKeyWord)
  {* ����� ������� sysutils:RemoveDir
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aDir sysutils:RemoveDir >>> l_Boolean
[code]  }
  function sysutils_RemoveDir(const aCtx: TtfwContext;
   const aDir: AnsiString): Boolean;
   {* ���������� ����� ������� sysutils:RemoveDir }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwSysutilsRemoveDir
 
end.
