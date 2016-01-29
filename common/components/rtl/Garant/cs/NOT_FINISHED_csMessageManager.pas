unit NOT_FINISHED_csMessageManager;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/NOT_FINISHED_csMessageManager.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::cs::Tasks::csMessageManager
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include ..\cs\CsDefine.inc}

interface

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TcsMessageManager = class
 end;//TcsMessageManager
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  csMessageRecepientListPrim,
  csMessageRecepientList
  ;

{$IfEnd} //AppServerSide AND not Nemesis
end.