unit AutoTestSuiteWithDUnitSupport;

// Модуль: "w:\common\components\rtl\Garant\DUnit_Script_Support\AutoTestSuiteWithDUnitSupport.pas"
// Стереотип: "SimpleClass"

{$Include dsDefine.inc}

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
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts)

end.
