unit CompilationPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CompilationPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CompilationPack" MUID: (4F37ACE80010)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
