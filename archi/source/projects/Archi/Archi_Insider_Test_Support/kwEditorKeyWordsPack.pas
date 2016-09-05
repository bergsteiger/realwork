unit kwEditorKeyWordsPack;

// Модуль: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\kwEditorKeyWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "kwEditorKeyWordsPack" MUID: (4F5DA0BF025A)

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
 , kwPopEditorEditFormula
 , kwPopEditorAlignCellsBoundary
 , kwPopEditorSetStyle2Block
 , kwPopEditorInsertFormula
 , kwPushMainForm
 , kwPopEditorSetStyle2Table
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4F5DA0BF025Aimpl_uses*
 //#UC END# *4F5DA0BF025Aimpl_uses*
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
