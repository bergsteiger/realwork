unit CustomFolderTestSuite;

// Модуль: "w:\common\components\rtl\Garant\Abstract_Tests\CustomFolderTestSuite.pas"
// Стереотип: "SimpleClass"

{$Include TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomAutoTestsSuite
 , TestFrameWork
;

type
 TCustomFolderTestSuite = class(TCustomAutoTestSuite)
  private
   f_DataFolder: AnsiString;
  protected
   function GetDataFolder: AnsiString; override;
    {* Возвращает папку с данными для создания тестов. }
   function GetExt: AnsiString; override;
  public
   procedure AddTests(aTestClass: TTestCaseClass); override;
 end;//TCustomFolderTestSuite
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
;

procedure TCustomFolderTestSuite.AddTests(aTestClass: TTestCaseClass);
//#UC START# *4DC38C96018E_4EA515800122_var*
//#UC END# *4DC38C96018E_4EA515800122_var*
begin
//#UC START# *4DC38C96018E_4EA515800122_impl*
 f_DataFolder := aTestClass.ClassName;
 inherited;
//#UC END# *4DC38C96018E_4EA515800122_impl*
end;//TCustomFolderTestSuite.AddTests

function TCustomFolderTestSuite.GetDataFolder: AnsiString;
 {* Возвращает папку с данными для создания тестов. }
//#UC START# *4EA50B95037D_4EA515800122_var*
//#UC END# *4EA50B95037D_4EA515800122_var*
begin
//#UC START# *4EA50B95037D_4EA515800122_impl*
 Result := f_DataFolder;
//#UC END# *4EA50B95037D_4EA515800122_impl*
end;//TCustomFolderTestSuite.GetDataFolder

function TCustomFolderTestSuite.GetExt: AnsiString;
//#UC START# *4EA50C04021B_4EA515800122_var*
//#UC END# *4EA50C04021B_4EA515800122_var*
begin
//#UC START# *4EA50C04021B_4EA515800122_impl*
 Result := '.evd';
//#UC END# *4EA50C04021B_4EA515800122_impl*
end;//TCustomFolderTestSuite.GetExt
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
