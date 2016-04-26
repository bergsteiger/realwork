unit kwArchiEverestWordsPack;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwArchiEverestWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "kwArchiEverestWordsPack" MUID: (5166AFC5017A)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwDisableMergedCellFilter
 , kwClearFindDialog
 , kwAutoCompleteClear
 , tfwScriptingTypes
 , SysUtils
 , tfwTypeRegistrator
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
