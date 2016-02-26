unit NOT_FINISHED_TestFrameWork;

// Модуль: "w:\common\components\rtl\external\DUnit\src\NOT_FINISHED_TestFrameWork.pas"
// Стереотип: "UtilityPack"

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 , SysUtils
;

type
 TTestResult = class(TObject)
  private
   FStop: Boolean;
  public
   function ShouldStop: Boolean;
 end;//TTestResult

 ITest = interface
  ['{3BA74AE0-1DCB-48A8-B8E4-410AAAD2FE44}']
  function HasScriptChildren: Boolean;
  procedure RunTest(aTestResult: TTestResult);
  function GetSubFolder: AnsiString;
  procedure ClearEtalons;
 end;//ITest

 TAbstractTest = class(TInterfacedObject, ITest)
  protected
   function DoGetSubFolder: AnsiString; virtual; abstract;
   procedure DoClearEtalon; virtual; abstract;
   procedure Cleanup; virtual;
   procedure InitFields; virtual;
   function GetEnabled: Boolean; virtual;
   procedure SetEnabled(Value: Boolean); virtual;
   function GetFolder: AnsiString; virtual;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; virtual;
    {* Идентификатор элемента модели, который описывает тест }
   function DoHasScriptChildren: Boolean; virtual;
   procedure DoRunTest(aTestResult: TTestResult); virtual; abstract;
   function HasScriptChildren: Boolean;
   procedure RunTest(aTestResult: TTestResult);
   function GetSubFolder: AnsiString;
   procedure ClearEtalons;
  public
   function NotForTerminalSession: Boolean; virtual;
    {* Не запускать тест в терминальной сессии }
 end;//TAbstractTest

 ITestSuite = interface
  ['{1524FACE-9F51-4D1D-99F8-6CB79114530A}']
  procedure AddTest(const aTest: ITest);
  procedure ReReadAbstractTests;
 end;//ITestSuite

 TTestFailure = class
 end;//TTestFailure

 TTestCase = class(TAbstractTest)
  private
   f_TestResult: TTestResult;
   f_DataSubFolder: AnsiString;
    {* Поле для свойства DataSubFolder }
  protected
   function ShouldStop: Boolean;
   function FolderMode: Boolean;
    {* Тест для файлов из папки. }
   class function IsScript: Boolean; virtual;
    {* Хак для конструктора - из-за хитрой иерархии и кучи конструкторов в TTestSuite. }
   procedure DoRunTest(aTestResult: TTestResult); override;
   function DoGetSubFolder: AnsiString; override;
   procedure DoClearEtalon; override;
  public
   class function Suite: ITestSuite; virtual;
   constructor Create(const aMethodName: AnsiString;
    const aFolder: AnsiString); reintroduce; virtual;
  public
   property DataSubFolder: AnsiString
    read f_DataSubFolder;
    {* Папка с данными тестов для режима работы с файлами из папки. }
 end;//TTestCase

 TTestCaseClass = TTestCase;

 TTestSuite = class(TAbstractTest, ITestSuite)
  private
   f_Suffix: AnsiString;
  protected
   procedure DoReReadAbstractTests; virtual;
   procedure DoAddTest(const aTest: ITest); virtual;
   procedure AddTest(const aTest: ITest);
   procedure DoRunTest(aTestResult: TTestResult); override;
   function DoGetSubFolder: AnsiString; override;
   procedure ReReadAbstractTests;
   procedure DoClearEtalon; override;
  public
   procedure AddTests(aTestClass: TTestCaseClass); virtual;
 end;//TTestSuite

 TTestMethod = procedure of object;

 ETestFailure = class(EAbort)
 end;//ETestFailure

procedure RegisterTest;
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
 , ITestWordsPack
 {$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)
;

procedure RegisterTest;
//#UC START# *4EA66E6C038E_4B2A0DCE03A9_var*
//#UC END# *4EA66E6C038E_4B2A0DCE03A9_var*
begin
//#UC START# *4EA66E6C038E_4B2A0DCE03A9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EA66E6C038E_4B2A0DCE03A9_impl*
end;//RegisterTest

function TTestResult.ShouldStop: Boolean;
//#UC START# *4DDE1A9201A4_4B2F4252038D_var*
//#UC END# *4DDE1A9201A4_4B2F4252038D_var*
begin
//#UC START# *4DDE1A9201A4_4B2F4252038D_impl*
 Result := FStop;
//#UC END# *4DDE1A9201A4_4B2F4252038D_impl*
end;//TTestResult.ShouldStop

procedure TAbstractTest.Cleanup;
//#UC START# *4B2F40FD0088_4B2F40E70101_var*
//#UC END# *4B2F40FD0088_4B2F40E70101_var*
begin
//#UC START# *4B2F40FD0088_4B2F40E70101_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2F40FD0088_4B2F40E70101_impl*
end;//TAbstractTest.Cleanup

procedure TAbstractTest.InitFields;
//#UC START# *4B30EEA10210_4B2F40E70101_var*
//#UC END# *4B30EEA10210_4B2F40E70101_var*
begin
//#UC START# *4B30EEA10210_4B2F40E70101_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B30EEA10210_4B2F40E70101_impl*
end;//TAbstractTest.InitFields

function TAbstractTest.GetEnabled: Boolean;
//#UC START# *4C07996901BE_4B2F40E70101_var*
//#UC END# *4C07996901BE_4B2F40E70101_var*
begin
//#UC START# *4C07996901BE_4B2F40E70101_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C07996901BE_4B2F40E70101_impl*
end;//TAbstractTest.GetEnabled

procedure TAbstractTest.SetEnabled(Value: Boolean);
//#UC START# *4C446D7903B7_4B2F40E70101_var*
//#UC END# *4C446D7903B7_4B2F40E70101_var*
begin
//#UC START# *4C446D7903B7_4B2F40E70101_impl*
 !!! Needs to be implemented !!!
//#UC END# *4C446D7903B7_4B2F40E70101_impl*
end;//TAbstractTest.SetEnabled

function TAbstractTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
//#UC START# *4C937013031D_4B2F40E70101_var*
//#UC END# *4C937013031D_4B2F40E70101_var*
begin
//#UC START# *4C937013031D_4B2F40E70101_impl*
 Result := '';
//#UC END# *4C937013031D_4B2F40E70101_impl*
end;//TAbstractTest.GetFolder

function TAbstractTest.NotForTerminalSession: Boolean;
 {* Не запускать тест в терминальной сессии }
//#UC START# *4C988C1B0246_4B2F40E70101_var*
//#UC END# *4C988C1B0246_4B2F40E70101_var*
begin
//#UC START# *4C988C1B0246_4B2F40E70101_impl*
 Result := false;
//#UC END# *4C988C1B0246_4B2F40E70101_impl*
end;//TAbstractTest.NotForTerminalSession

function TAbstractTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
//#UC START# *4DAED6F60146_4B2F40E70101_var*
//#UC END# *4DAED6F60146_4B2F40E70101_var*
begin
//#UC START# *4DAED6F60146_4B2F40E70101_impl*
 Result := '';
//#UC END# *4DAED6F60146_4B2F40E70101_impl*
end;//TAbstractTest.GetModelElementGUID

function TAbstractTest.DoHasScriptChildren: Boolean;
//#UC START# *4DCCD004030E_4B2F40E70101_var*
//#UC END# *4DCCD004030E_4B2F40E70101_var*
begin
//#UC START# *4DCCD004030E_4B2F40E70101_impl*
 Result := False;
//#UC END# *4DCCD004030E_4B2F40E70101_impl*
end;//TAbstractTest.DoHasScriptChildren

function TAbstractTest.HasScriptChildren: Boolean;
//#UC START# *4DCCCFF001A4_4B2F40E70101_var*
//#UC END# *4DCCCFF001A4_4B2F40E70101_var*
begin
//#UC START# *4DCCCFF001A4_4B2F40E70101_impl*
 Result := DoHasScriptChildren;
//#UC END# *4DCCCFF001A4_4B2F40E70101_impl*
end;//TAbstractTest.HasScriptChildren

procedure TAbstractTest.RunTest(aTestResult: TTestResult);
//#UC START# *4DDE1E8702D3_4B2F40E70101_var*
//#UC END# *4DDE1E8702D3_4B2F40E70101_var*
begin
//#UC START# *4DDE1E8702D3_4B2F40E70101_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDE1E8702D3_4B2F40E70101_impl*
end;//TAbstractTest.RunTest

function TAbstractTest.GetSubFolder: AnsiString;
//#UC START# *4F9A4FBF00C0_4B2F40E70101_var*
//#UC END# *4F9A4FBF00C0_4B2F40E70101_var*
begin
//#UC START# *4F9A4FBF00C0_4B2F40E70101_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F9A4FBF00C0_4B2F40E70101_impl*
end;//TAbstractTest.GetSubFolder

procedure TAbstractTest.ClearEtalons;
//#UC START# *51B1DD5F0080_4B2F40E70101_var*
//#UC END# *51B1DD5F0080_4B2F40E70101_var*
begin
//#UC START# *51B1DD5F0080_4B2F40E70101_impl*
 !!! Needs to be implemented !!!
//#UC END# *51B1DD5F0080_4B2F40E70101_impl*
end;//TAbstractTest.ClearEtalons

function TTestCase.ShouldStop: Boolean;
//#UC START# *4DDE2A3D0314_4B2A0DDE028B_var*
//#UC END# *4DDE2A3D0314_4B2A0DDE028B_var*
begin
//#UC START# *4DDE2A3D0314_4B2A0DDE028B_impl*
 Result := f_TestResult.ShouldStop;
//#UC END# *4DDE2A3D0314_4B2A0DDE028B_impl*
end;//TTestCase.ShouldStop

class function TTestCase.Suite: ITestSuite;
//#UC START# *4EA553E901DB_4B2A0DDE028B_var*
//#UC END# *4EA553E901DB_4B2A0DDE028B_var*
begin
//#UC START# *4EA553E901DB_4B2A0DDE028B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EA553E901DB_4B2A0DDE028B_impl*
end;//TTestCase.Suite

function TTestCase.FolderMode: Boolean;
 {* Тест для файлов из папки. }
//#UC START# *4EA6790E0142_4B2A0DDE028B_var*
//#UC END# *4EA6790E0142_4B2A0DDE028B_var*
begin
//#UC START# *4EA6790E0142_4B2A0DDE028B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4EA6790E0142_4B2A0DDE028B_impl*
end;//TTestCase.FolderMode

class function TTestCase.IsScript: Boolean;
 {* Хак для конструктора - из-за хитрой иерархии и кучи конструкторов в TTestSuite. }
//#UC START# *4DC395670274_4B2A0DDE028B_var*
//#UC END# *4DC395670274_4B2A0DDE028B_var*
begin
//#UC START# *4DC395670274_4B2A0DDE028B_impl*
 Result := False;
//#UC END# *4DC395670274_4B2A0DDE028B_impl*
end;//TTestCase.IsScript

constructor TTestCase.Create(const aMethodName: AnsiString;
 const aFolder: AnsiString);
//#UC START# *4DC399CA00BC_4B2A0DDE028B_var*
//#UC END# *4DC399CA00BC_4B2A0DDE028B_var*
begin
//#UC START# *4DC399CA00BC_4B2A0DDE028B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DC399CA00BC_4B2A0DDE028B_impl*
end;//TTestCase.Create

procedure TTestCase.DoRunTest(aTestResult: TTestResult);
//#UC START# *4DDE29F101B1_4B2A0DDE028B_var*
//#UC END# *4DDE29F101B1_4B2A0DDE028B_var*
begin
//#UC START# *4DDE29F101B1_4B2A0DDE028B_impl*
 Assert(Assigned(FMethod), 'Method "' + FTestName + '" not found');
 FExpectedException := nil;
 try
  try
{$IFDEF CLR}
   aTestResult.FMethodPtr := nil;
{$ELSE}
   CheckMethodIsNotEmpty(TMethod(FMethod).Code);
   aTestResult.FMethodPtr := TMethod(FMethod).Code;
{$ENDIF}
   FCheckCalled := False;
   f_TestResult := aTestResult;
   try
    Invoke(FMethod);
   finally
    f_TestResult := nil;
   end;
   if FFailsOnNoChecksExecuted and (not FCheckCalled) then
    Fail('No checks executed in TestCase', aTestResult.FMethodPtr);
   StopExpectingException;
  except
   on E: ETestFailure  do
   begin
    raise;
   end;
   on E: Exception  do
   begin
    if not Assigned(FExpectedException) then
     raise
    else
     if not E.ClassType.InheritsFrom(fExpectedException) then
      FailNotEquals(fExpectedException.ClassName, E.ClassName, 'unexpected exception', ExceptAddr);
   end
  end;
 finally
  FExpectedException := nil;
 end;
//#UC END# *4DDE29F101B1_4B2A0DDE028B_impl*
end;//TTestCase.DoRunTest

function TTestCase.DoGetSubFolder: AnsiString;
//#UC START# *4F9A4FD70148_4B2A0DDE028B_var*
//#UC END# *4F9A4FD70148_4B2A0DDE028B_var*
begin
//#UC START# *4F9A4FD70148_4B2A0DDE028B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F9A4FD70148_4B2A0DDE028B_impl*
end;//TTestCase.DoGetSubFolder

procedure TTestCase.DoClearEtalon;
//#UC START# *51B1DD8E0018_4B2A0DDE028B_var*
//#UC END# *51B1DD8E0018_4B2A0DDE028B_var*
begin
//#UC START# *51B1DD8E0018_4B2A0DDE028B_impl*
 !!! Needs to be implemented !!!
//#UC END# *51B1DD8E0018_4B2A0DDE028B_impl*
end;//TTestCase.DoClearEtalon

procedure TTestSuite.DoReReadAbstractTests;
//#UC START# *5040A3CE0118_4DC24566022C_var*
//#UC END# *5040A3CE0118_4DC24566022C_var*
begin
//#UC START# *5040A3CE0118_4DC24566022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5040A3CE0118_4DC24566022C_impl*
end;//TTestSuite.DoReReadAbstractTests

procedure TTestSuite.DoAddTest(const aTest: ITest);
//#UC START# *4DC28F1301D6_4DC24566022C_var*
//#UC END# *4DC28F1301D6_4DC24566022C_var*
begin
//#UC START# *4DC28F1301D6_4DC24566022C_impl*
 Assert(Assigned(aTest));
 if FSuffix = '' then
  FSuffix := aTest.GetSuffixName;
 FTests.Add(aTest);
//#UC END# *4DC28F1301D6_4DC24566022C_impl*
end;//TTestSuite.DoAddTest

procedure TTestSuite.AddTests(aTestClass: TTestCaseClass);
//#UC START# *4DC38C96018E_4DC24566022C_var*
var
 l_MethodIter       : Integer;
 l_NameOfMethod     : string;
 l_MethodEnumerator : TMethodEnumerator;
//#UC END# *4DC38C96018E_4DC24566022C_var*
begin
//#UC START# *4DC38C96018E_4DC24566022C_impl*
 { call on the method enumerator to get the names of the test
   cases in the testClass }
 l_MethodEnumerator := nil;
 try
  l_MethodEnumerator := TMethodEnumerator.Create(aTestClass);
  { make sure we add each test case  to the list of tests }
  for l_MethodIter := 0 to l_MethodEnumerator.MethodCount - 1 do
  begin
   l_NameOfMethod := l_MethodEnumerator.NameOfMethod[l_MethodIter];
   Self.AddTest(aTestClass.Create(l_NameOfMethod) as ITest);
  end; //  for l_MethodIter := 0 to l_MethodEnumerator.Methodcount - 1 do
 finally
  l_MethodEnumerator.Free;
 end;
//#UC END# *4DC38C96018E_4DC24566022C_impl*
end;//TTestSuite.AddTests

procedure TTestSuite.AddTest(const aTest: ITest);
//#UC START# *4DC28F0500F3_4DC24566022C_var*
//#UC END# *4DC28F0500F3_4DC24566022C_var*
begin
//#UC START# *4DC28F0500F3_4DC24566022C_impl*
 DoAddTest(aTest);
//#UC END# *4DC28F0500F3_4DC24566022C_impl*
end;//TTestSuite.AddTest

procedure TTestSuite.DoRunTest(aTestResult: TTestResult);
//#UC START# *4DDE29F101B1_4DC24566022C_var*
var
 i      : Integer;
 l_Test : ITest;
//#UC END# *4DDE29F101B1_4DC24566022C_var*
begin
//#UC START# *4DDE29F101B1_4DC24566022C_impl*
 Assert(Assigned(aTestResult));
 Assert(Assigned(FTests));

 aTestResult.StartSuite(Self);
 for i := 0 to FTests.Count - 1 do
 begin
  if aTestResult.ShouldStop then Break;
  l_Test := FTests[i] as ITest;
  l_Test.RunWithFixture(aTestResult);
 end; // for i := 0 to FTests.Count - 1 do
 aTestResult.EndSuite(Self);
//#UC END# *4DDE29F101B1_4DC24566022C_impl*
end;//TTestSuite.DoRunTest

function TTestSuite.DoGetSubFolder: AnsiString;
//#UC START# *4F9A4FD70148_4DC24566022C_var*
//#UC END# *4F9A4FD70148_4DC24566022C_var*
begin
//#UC START# *4F9A4FD70148_4DC24566022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F9A4FD70148_4DC24566022C_impl*
end;//TTestSuite.DoGetSubFolder

procedure TTestSuite.ReReadAbstractTests;
//#UC START# *5040A3B80283_4DC24566022C_var*
//#UC END# *5040A3B80283_4DC24566022C_var*
begin
//#UC START# *5040A3B80283_4DC24566022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5040A3B80283_4DC24566022C_impl*
end;//TTestSuite.ReReadAbstractTests

procedure TTestSuite.DoClearEtalon;
//#UC START# *51B1DD8E0018_4DC24566022C_var*
//#UC END# *51B1DD8E0018_4DC24566022C_var*
begin
//#UC START# *51B1DD8E0018_4DC24566022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *51B1DD8E0018_4DC24566022C_impl*
end;//TTestSuite.DoClearEtalon
{$IfEnd} // Defined(nsTest)

end.
