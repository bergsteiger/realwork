unit evOldEverestTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EverestCommon"
// Модуль: "w:/common/components/gui/Garant/EverestCommon/NOT_FINISHED_evOldEverestTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::EverestCommon::evOldEverestTypes
//
// Пакет совместимости со старым редктором.
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\common\components\gui\Garant\EverestCommon\evDefine.inc}

interface

uses
  nevTools
  ;

type
 IevBaseTagSelection = interface(IUnknown)
   ['{C9401658-FBBE-45F5-8A75-990EE729C253}']
 end;//IevBaseTagSelection

 IevTagSelection = interface(IUnknown)
   ['{18AEEA62-775A-43FA-8B64-AC95A8F3C73B}']
 end;//IevTagSelection

 IevTagROPoint = interface(IUnknown)
   ['{4FC67A31-728B-40ED-B9C4-C3C9DD54D4B2}']
 end;//IevTagROPoint

 TevBaseCursor = record
 end;//TevBaseCursor

 IevDataObject = interface(IUnknown)
   ['{F818351F-5887-4C9E-8AFC-5E0398FD789D}']
 end;//IevDataObject

 InevRange = nevTools.InevRange;

implementation

end.