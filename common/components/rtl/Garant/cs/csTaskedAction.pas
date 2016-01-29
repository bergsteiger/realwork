unit csTaskedAction;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csTaskedAction.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::Actions::TcsTaskedAction
//
// Действие на сервере с возможностью помещения в очередь
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  csAction
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsTaskedAction = {abstract} class(TcsAction)
  {* Действие на сервере с возможностью помещения в очередь }
 end;//TcsTaskedAction
{$IfEnd} //not Nemesis

implementation

end.