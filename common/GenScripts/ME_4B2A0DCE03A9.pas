unit TestFrameWork;

interface

uses
 l3IntfUses
 , SysUtils
;

type
 TTestResult = class(TObject)
  function ShouldStop: Boolean;
 end;//TTestResult
 
 ITest = interface
  function HasScriptChildren: Boolean;
  procedure RunTest(aTestResult: TTestResult);
  function GetSubFolder: AnsiString;
  procedure ClearEtalons;
 end;//ITest
 
 TAbstractTest = class(TInterfacedObject, ITest)
  function DoGetSubFolder: AnsiString;
  procedure DoClearEtalon;
  procedure Cleanup;
  procedure InitFields;
  function GetEnabled: Boolean;
  procedure SetEnabled(Value: Boolean);
  function GetFolder: AnsiString;
   {* ����� � ������� ������ ���� }
  function NotForTerminalSession: Boolean;
   {* �� ��������� ���� � ������������ ������ }
  function GetModelElementGUID: AnsiString;
   {* ������������� �������� ������, ������� ��������� ���� }
  function DoHasScriptChildren: Boolean;
  procedure DoRunTest(aTestResult: TTestResult);
  function HasScriptChildren: Boolean;
  procedure RunTest(aTestResult: TTestResult);
  function GetSubFolder: AnsiString;
  procedure ClearEtalons;
 end;//TAbstractTest
 
 ITestSuite = interface
  procedure AddTest(const aTest: ITest);
  procedure ReReadAbstractTests;
 end;//ITestSuite
 
 TTestFailure = class
 end;//TTestFailure
 
 TTestCase = class(TAbstractTest)
  function ShouldStop: Boolean;
  function Suite: ITestSuite;
  function FolderMode: Boolean;
   {* ���� ��� ������ �� �����. }
  function IsScript: Boolean;
   {* ��� ��� ������������ - ��-�� ������ �������� � ���� ������������� � TTestSuite. }
  procedure Create(const aMethodName: AnsiString;
   const aFolder: AnsiString);
  procedure DoRunTest(aTestResult: TTestResult);
  function DoGetSubFolder: AnsiString;
  procedure DoClearEtalon;
 end;//TTestCase
 
 TTestCaseClass = TTestCase;
 
 TTestSuite = class(TAbstractTest, ITestSuite)
  procedure DoReReadAbstractTests;
  procedure DoAddTest(const aTest: ITest);
  procedure AddTests(aTestClass: TTestCaseClass);
  procedure AddTest(const aTest: ITest);
  procedure DoRunTest(aTestResult: TTestResult);
  function DoGetSubFolder: AnsiString;
  procedure ReReadAbstractTests;
  procedure DoClearEtalon;
 end;//TTestSuite
 
 TTestMethod = procedure of object;
 
 ETestFailure = class(EAbort)
 end;//ETestFailure
 
implementation

uses
 l3ImplUses
;

end.
