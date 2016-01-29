unit NOT_FINISHED_csNonEditableDictsRequest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csNonEditableDictsRequest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::csNonEditableDictsRequest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csRequestTask
  ;

{$If defined(RemoteDict) AND not defined(Nemesis)}
type
 TddNonEditableDictsRequest = class(TddRequestTask)
 end;//TddNonEditableDictsRequest
{$IfEnd} //RemoteDict AND not Nemesis
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
{$IfEnd} //not Nemesis
end.