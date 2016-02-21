unit MouseInputPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\MouseInputPack.pas"
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
 , kwMouseLeftDown
 , kwMouseLeftUp
 , kwMouseMiddleUp
 , kwMouseMiddleDown
 , kwMouseRightUp
 , kwMouseRightDown
 , kwMouseSetCursorPosition
 , kwMouseGetCursorIndex
 , kwMouseGetCursorNameByIndex
 , kwMouseGetCursorPosition
 , kwMouseWheelUp
 , kwMouseWheelDown
 , tfwScriptingTypes
;
{$IfEnd} // NOT Defined(NoScripts)

end.
