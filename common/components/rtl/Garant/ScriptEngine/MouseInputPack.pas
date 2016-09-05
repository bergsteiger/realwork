unit MouseInputPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\MouseInputPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MouseInputPack" MUID: (4F8EC88A01F2)

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
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4F8EC88A01F2impl_uses*
 //#UC END# *4F8EC88A01F2impl_uses*
;
{$IfEnd} // NOT Defined(NoScripts)

end.
