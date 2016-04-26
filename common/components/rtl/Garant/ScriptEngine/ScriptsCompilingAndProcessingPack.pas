unit ScriptsCompilingAndProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ScriptsCompilingAndProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ScriptsCompilingAndProcessingPack" MUID: (53DA23CD0105)

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
 , kwScriptCompileAndProcess
 , kwScriptCompileStringAndProcess
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
