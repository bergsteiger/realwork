unit SHDTestScriptEngine;

// Модуль: "w:\common\components\rtl\Garant\Daily\SHDTestScriptEngine.pas"
// Стереотип: "SimpleClass"

{$Include TestDefine.inc.pas}

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
;
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoScripts) AND NOT Defined(InsiderTest)

end.
