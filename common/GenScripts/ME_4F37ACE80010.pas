unit CompilationPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CompilationPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwFORWARD
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
