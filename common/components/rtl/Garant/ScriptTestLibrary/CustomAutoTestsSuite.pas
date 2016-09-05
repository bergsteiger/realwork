unit CustomAutoTestsSuite;

// Модуль: "w:\common\components\rtl\Garant\ScriptTestLibrary\CustomAutoTestsSuite.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "CustomAutoTestsSuite" MUID: (4DC24CA4037E)

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , TestFrameWork
;

type
 TCustomAutoTestSuite = class(TTestSuite)
  private
   procedure CheckExists(const aDirName: AnsiString);
   function Try2FindTest(const aTestName: AnsiString): Boolean;
  protected
   function GetDataFolder: AnsiString; virtual;
    {* Возвращает папку с данными для создания тестов. }
   function GetExt: AnsiString; virtual;
   function DoHasScriptChildren: Boolean; override;
  public
   procedure AddTests(aTestClass: TTestCaseClass); override;
 end;//TCustomAutoTestSuite
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // NOT Defined(NotTunedDUnit)
 , SysUtils
 , l3Base
 , l3FileUtils
 //#UC START# *4DC24CA4037Eimpl_uses*
 //#UC END# *4DC24CA4037Eimpl_uses*
;

function TCustomAutoTestSuite.GetDataFolder: AnsiString;
 {* Возвращает папку с данными для создания тестов. }
//#UC START# *4EA50B95037D_4DC40A7E00C8_var*
//#UC END# *4EA50B95037D_4DC40A7E00C8_var*
begin
//#UC START# *4EA50B95037D_4DC40A7E00C8_impl*
 Result := 'Auto';
//#UC END# *4EA50B95037D_4DC40A7E00C8_impl*
end;//TCustomAutoTestSuite.GetDataFolder

function TCustomAutoTestSuite.GetExt: AnsiString;
//#UC START# *4EA50C04021B_4DC40A7E00C8_var*
//#UC END# *4EA50C04021B_4DC40A7E00C8_var*
begin
//#UC START# *4EA50C04021B_4DC40A7E00C8_impl*
 Result := '.script';
//#UC END# *4EA50C04021B_4DC40A7E00C8_impl*
end;//TCustomAutoTestSuite.GetExt

procedure TCustomAutoTestSuite.CheckExists(const aDirName: AnsiString);
//#UC START# *506D80B002A6_4DC40A7E00C8_var*
var
 i         : Integer;
 l_Count   : Integer;
 l_FileName: String;
//#UC END# *506D80B002A6_4DC40A7E00C8_var*
begin
//#UC START# *506D80B002A6_4DC40A7E00C8_impl*
 l_Count := FTests.Count - 1;
 for i := l_Count downto 0 do
 begin
  l_FileName := ConcatDirName(aDirName, (FTests[i] as ITest).Name);
  if not FileExists(l_FileName) then
   FTests.Delete(i);
 end; // for i := l_Count downto 0 do
//#UC END# *506D80B002A6_4DC40A7E00C8_impl*
end;//TCustomAutoTestSuite.CheckExists

function TCustomAutoTestSuite.Try2FindTest(const aTestName: AnsiString): Boolean;
//#UC START# *506D8174020F_4DC40A7E00C8_var*
var
 i      : Integer;
 l_Count: Integer;
//#UC END# *506D8174020F_4DC40A7E00C8_var*
begin
//#UC START# *506D8174020F_4DC40A7E00C8_impl*
 Result := False;
 l_Count := FTests.Count - 1;
 for i := 0 to l_Count do
  if (FTests[i] as ITest).Name = aTestName then
  begin
   Result := True;
   Break;
  end; // if (FTests[i] as ITest).Name = aTestName then
//#UC END# *506D8174020F_4DC40A7E00C8_impl*
end;//TCustomAutoTestSuite.Try2FindTest

procedure TCustomAutoTestSuite.AddTests(aTestClass: TTestCaseClass);
//#UC START# *4DC38C96018E_4DC40A7E00C8_var*
var
 l_IsNew: Boolean;

 function l_TestAdd(const aFileName: string): Boolean;
 var
  l_TestName: string;
 begin
  Result := True;
  l_TestName := ExtractFileName(aFileName);
  if Pos('.etalon', l_TestName) = 0 then
  begin
   if not l_IsNew and Try2FindTest(l_TestName) then Exit;
   AddTest(aTestClass.Create(l_TestName, GetDataFolder) as ITest);
  end;
 end;

var
 l_Dir    : String;
 l_FPStub : Pointer;
//#UC END# *4DC38C96018E_4DC40A7E00C8_var*
begin
//#UC START# *4DC38C96018E_4DC40A7E00C8_impl*
 CheckIgnoreCVS;;
{$IFNDEF InsiderTest}
 // V - страшный ХАК!!!
 if g_CVSPath = '' then
  g_CVSPath := 'w:\common\components\DailyTest';
{$ENDIF InsiderTest}
 l_Dir := FileFromCurrent(GetDataFolder + '\', True, false);
 l_FPStub := l3LocalStub(@l_TestAdd);
 l_IsNew := Self.FTests.Count = 0;
 try
  ProcessFilesWithMask(l_Dir, '*' + GetExt, TFileProcessingFunc(l_FPStub));
 finally
  l3FreeLocalStub(l_FPStub);
 end;
 if not l_IsNew then
  CheckExists(l_Dir);
//#UC END# *4DC38C96018E_4DC40A7E00C8_impl*
end;//TCustomAutoTestSuite.AddTests

function TCustomAutoTestSuite.DoHasScriptChildren: Boolean;
//#UC START# *4DCCD004030E_4DC40A7E00C8_var*
//#UC END# *4DCCD004030E_4DC40A7E00C8_var*
begin
//#UC START# *4DCCD004030E_4DC40A7E00C8_impl*
 Result := True;
//#UC END# *4DCCD004030E_4DC40A7E00C8_impl*
end;//TCustomAutoTestSuite.DoHasScriptChildren
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
