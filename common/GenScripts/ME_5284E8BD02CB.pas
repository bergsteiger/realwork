unit CodeBranchingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\CodeBranchingPack.pas"
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
 , kwIfElse
 , kwElse
 , kwCASE
 , kwDEFAULT
 , kwRAISE
 , kwBracketBegin
 , kwBEGIN
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
