unit NOT_FINISHED_tfwScriptDebugger;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DUnitTuning"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/DUnitTuning/NOT_FINISHED_tfwScriptDebugger.pas"
// Начат: 22.04.2011 15:12
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Testing Framework::DUnitTuning::ScriptDebugger::tfwScriptDebugger
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\DUnitTuning\tfwDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
type
 TtfwScriptDebugger_Form = class
 end;//TtfwScriptDebugger_Form
{$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit

implementation

{$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts) AND not defined(NotTunedDUnit)}
uses
  vcmInsiderTest,
  tfwScriptEngine
  ;

{$IfEnd} //InsiderTest AND nsTest AND not NoScripts AND not NotTunedDUnit
end.