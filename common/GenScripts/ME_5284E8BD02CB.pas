unit CodeBranchingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CodeBranchingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "CodeBranchingPack" MUID: (5284E8BD02CB)

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
 , kwIfElse
 , kwElse
 , kwCASE
 , kwDEFAULT
 , kwRAISE
 , kwBracketBegin
 , kwBEGIN
 , kwRULES
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
