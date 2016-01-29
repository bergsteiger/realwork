unit kwCompiledScriptCompileAndProcess;

interface

uses
 l3IntfUses
 , kwCompiledWordWorker
 , tfwScriptingInterfaces
 , tfwStreamFactory
 , l3Interfaces
;

type
 TkwCompiledScriptCompileAndProcess = class(TkwCompiledWordWorker, ItfwScriptCaller)
  function MakeStream(const aData: AnsiString): TtfwStreamFactory;
  procedure CheckOutputWithInput(const aIn: AnsiString;
   const aOut: AnsiString;
   aHeaderBegin: AnsiChar;
   aEtalonNeedsComputerName: Boolean;
   aEtalonCanHaveDiff: Boolean;
   const anExtraFileName: AnsiString;
   aNeedsCheck: Boolean); overload;
  procedure DoDoIt(const aCtx: TtfwContext);
  procedure Check(aCondition: Boolean;
   const aMessage: AnsiString);
   {* Проверяет инвариант }
  procedure Print(const aStr: Tl3WString); overload;
  procedure Print(const aStr: Il3CString); overload;
  function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
  function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
  procedure CheckWithEtalon(const aFileName: AnsiString;
   aHeaderBegin: AnsiChar);
  function ResolveInputFilePath(const aFile: AnsiString): AnsiString;
  procedure CheckPrintEtalon(const aLogName: AnsiString;
   const aOutputName: AnsiString);
  function ShouldStop: Boolean;
  procedure CheckTimeout(aNow: Cardinal;
   aTimeout: Cardinal);
  function StartTimer: Longword;
  function StopTimer(const aSt: AnsiString;
   const aSubName: AnsiString;
   aNeedTimeToLog: Boolean): Longword;
  function KPage: AnsiString;
  procedure ToLog(const aSt: AnsiString);
  procedure CheckOutputWithInput(const aSt: AnsiString;
   aHeaderBegin: AnsiChar;
   const anExtraFileName: AnsiString;
   aNeedsCheck: Boolean); overload;
  function GetIsWritingToK: Boolean;
  function GetIsFakeCVS: Boolean;
  function GetCVSPath: AnsiString;
  procedure DontRaiseIfEtalonCreated;
  procedure TimeToLog(aTime: Cardinal;
   const aSt: AnsiString;
   const aSubName: AnsiString);
  function GetTestSetFolderName: AnsiString;
  function GetEtalonSuffix: AnsiString;
  function CompileOnly: Boolean;
  procedure CheckPictureOnly;
 end;//TkwCompiledScriptCompileAndProcess
 
implementation

uses
 l3ImplUses
 , tfwFileStreamFactory
 , kwMain
 , kwMainCodeController
 , SysUtils
;

end.
