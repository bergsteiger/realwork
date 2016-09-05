unit AutoTestsSuite;
 {* Поддержка тестов-скриптов }

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestsSuite.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TAutoTestsSuite" MUID: (4DC24756009A)

{$Include w:\common\components\rtl\Garant\DUnit_Script_Support\dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AutoTestSuiteWithDUnitSupport
;

type
 TAutoTestsSuite = class(TAutoTestSuiteWithDUnitSupport)
  {* Поддержка тестов-скриптов }
  protected
   function DoGetSubFolder: AnsiString; override;
  public
   class procedure Register;
 end;//TAutoTestsSuite
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , DailyAutoTest
 , TestFrameWork
 //#UC START# *4DC24756009Aimpl_uses*
 //#UC END# *4DC24756009Aimpl_uses*
;

class procedure TAutoTestsSuite.Register;
//#UC START# *4DC40BF302B4_4DC24756009A_var*
//#UC END# *4DC40BF302B4_4DC24756009A_var*
begin
//#UC START# *4DC40BF302B4_4DC24756009A_impl*
 TestFramework.RegisterTest(Self.Create(TDailyAutoTest));
//#UC END# *4DC40BF302B4_4DC24756009A_impl*
end;//TAutoTestsSuite.Register

function TAutoTestsSuite.DoGetSubFolder: AnsiString;
//#UC START# *4F9A4FD70148_4DC24756009A_var*
//#UC END# *4F9A4FD70148_4DC24756009A_var*
begin
//#UC START# *4F9A4FD70148_4DC24756009A_impl*
 Result := '';
 AddTests(TDailyAutoTest);
//#UC END# *4F9A4FD70148_4DC24756009A_impl*
end;//TAutoTestsSuite.DoGetSubFolder
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
