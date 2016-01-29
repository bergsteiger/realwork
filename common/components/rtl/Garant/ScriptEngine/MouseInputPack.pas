unit MouseInputPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine"
// ������: "MouseInputPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine::MouseInput::MouseInputPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwMouseLeftDown,
  kwMouseLeftUp,
  kwMouseMiddleUp,
  kwMouseMiddleDown,
  kwMouseRightUp,
  kwMouseRightDown,
  kwMouseSetCursorPosition,
  kwMouseGetCursorIndex,
  kwMouseGetCursorNameByIndex,
  kwMouseGetCursorPosition,
  kwMouseWheelUp,
  kwMouseWheelDown,
  tfwScriptingTypes
  ;

{$IfEnd} //not NoScripts
end.