unit NOT_FINISHED_evOldEverestTypes;
 {* Пакет совместимости со старым редктором. }

// Модуль: "w:\common\components\gui\Garant\EverestCommon\NOT_FINISHED_evOldEverestTypes.pas"
// Стереотип: "Interfaces"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , nevTools
;

type
 IevBaseTagSelection = interface
  ['{C9401658-FBBE-45F5-8A75-990EE729C253}']
 end;//IevBaseTagSelection

 IevTagSelection = interface
  ['{18AEEA62-775A-43FA-8B64-AC95A8F3C73B}']
 end;//IevTagSelection

 IevTagROPoint = interface
  ['{4FC67A31-728B-40ED-B9C4-C3C9DD54D4B2}']
 end;//IevTagROPoint

 TevBaseCursor = record
 end;//TevBaseCursor

 IevDataObject = interface
  ['{F818351F-5887-4C9E-8AFC-5E0398FD789D}']
 end;//IevDataObject

 InevRange = nevTools.InevRange;

implementation

uses
 l3ImplUses
;

end.
