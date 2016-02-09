unit ScriptsCompilingAndProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ScriptsCompilingAndProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

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
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
