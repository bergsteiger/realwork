unit AutoTestSuiteWithDUnitSupport;

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestSuiteWithDUnitSupport.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TAutoTestSuiteWithDUnitSupport" MUID: (51307830007E)

{$Include w:\common\components\rtl\Garant\DUnit_Script_Support\dsDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CustomAutoTestsSuite
;

type
 TAutoTestSuiteWithDUnitSupport = class(TCustomAutoTestSuite)
 end;//TAutoTestSuiteWithDUnitSupport
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 {$If NOT Defined(NoVCL)}
 , kwKeyWordsPack
 {$IfEnd} // NOT Defined(NoVCL)
 //#UC START# *51307830007Eimpl_uses*
 //#UC END# *51307830007Eimpl_uses*
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
