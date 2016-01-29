unit F1ScriptEngine;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine"
// Автор: Люлин А.В.
// Модуль: "F1ScriptEngine.pas"
// Начат: 20.04.2011 20:14
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: SimpleClass::Class F1 Поддержка скриптов::ScriptEngine::ScriptEngine::TF1ScriptEngine
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptEngineEX
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _F1WordsUser_Parent_ = TtfwScriptEngineEX;
 {$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1WordsUser.imp.pas}
 TF1ScriptEngine = class(_F1WordsUser_)
 end;//TF1ScriptEngine
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwAttributeSearch,
  kwMainMenu,
  kwOk,
  kwOpenDocument,
  F1ShellWordsPack,
  TreeViewWordsPack,
  Integration,
  InterfacedNodeWordsPack,
  f1WordsPack,
  kwPopEditorDeleteUserComment
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include w:\garant6x\implementation\Garant\GbaNemesis\F1_Words\F1WordsUser.imp.pas}


{$IfEnd} //not NoScripts
end.