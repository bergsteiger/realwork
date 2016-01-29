unit vcmInsiderTest;

interface

uses
 l3IntfUses
 , BaseTest
 , tfwScriptingInterfaces
 , l3Filer
 , l3Interfaces
;

type
 TvcmInsiderTest = class(TBaseTest, ItfwScriptCaller)
  {* ������� ���� ������������� "������" ������������ ���������� }
  procedure OwnScriptFromFile;
   {* ��������� "�����������" ���� �� ����� }
  function DoResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
  procedure CheckOutputFiler(aWasException: Boolean);
  function DoResolveOutputFilePath(const aFile: AnsiString): AnsiString;
  function DoResolveInputFilePath(const aFile: AnsiString): AnsiString;
  function GetScriptName: AnsiString;
  procedure Check(aCondition: Boolean;
   const aMessage: AnsiString);
   {* ��������� ��������� }
  procedure Print(const aStr: Tl3WString); overload;
  procedure Print(const aStr: Il3CString); overload;
  function ResolveIncludedFilePath(const aFile: AnsiString): AnsiString;
  function ResolveOutputFilePath(const aFile: AnsiString): AnsiString;
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
 end;//TvcmInsiderTest
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3String
 , KTestRunner
 , kwPrintDataSaver
 , TestFrameWork
 , StrUtils
 , l3EtalonsService
 , l3_String
 , l3Chars
 , tfwScriptEngine
;

end.
