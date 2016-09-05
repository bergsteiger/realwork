unit EditorParaCoordsToScreenPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\EditorParaCoordsToScreenPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "EditorParaCoordsToScreenPack" MUID: (4F954F670262)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4F954F670262impl_uses*
 //#UC END# *4F954F670262impl_uses*
;
{$IfEnd} // NOT Defined(NoScripts)

end.
