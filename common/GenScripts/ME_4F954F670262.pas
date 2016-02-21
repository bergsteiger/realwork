unit EditorParaCoordsToScreenPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\EditorParaCoordsToScreenPack.pas"
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
 , kwPopEditorParaCoordsToScreen
 , kwPopEditorParaEndCoordsToScreen
 , kwPopEditorParaMiddleCoordsToScreen
 , kwPopEditorCursorCoordsToScreen
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
