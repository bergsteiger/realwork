unit SHDTestScriptEngine;

// Модуль: "w:\common\components\rtl\Garant\Daily\SHDTestScriptEngine.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TSHDTestScriptEngine" MUID: (4DC3B4A603C9)

{$Include w:\common\components\rtl\Garant\Daily\TestDefine.inc.pas}

interface

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(InsiderTest)}
uses
 l3IntfUses
 , tfwScriptEngineEX
;

type
 TSHDTestScriptEngine = class(TtfwScriptEngineEX)
 end;//TSHDTestScriptEngine
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(InsiderTest)}
uses
 l3ImplUses
 , AutoTestsSuite
 {$If NOT Defined(NoVCM)}
 , SupportKeyWords
 {$IfEnd} // NOT Defined(NoVCM)
 //#UC START# *4DC3B4A603C9impl_uses*
 //#UC END# *4DC3B4A603C9impl_uses*
;

{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(InsiderTest)
end.
