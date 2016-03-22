unit IncludesAndUsesPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\IncludesAndUsesPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "IncludesAndUsesPack" MUID: (4F476424014E)

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
 , tfwScriptingTypes
 , kwInclude
 , kwUses
;
{$IfEnd} // NOT Defined(NoScripts)

end.
