unit atListHistory;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atListHistory.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , Classes
 , DynamicDocListUnit
;

type
 _HistoryStoredObject_ = IDynList;
 {$Include w:\quality\test\garant6x\AdapterTest\OperationsFramework\atObjectHistory.imp.pas}
 TatListHistory = class(_atObjectHistory_)
 end;//TatListHistory

implementation

uses
 l3ImplUses
;

{$If not Declared(_InterfaceListElement_)}type _InterfaceListElement_ = _HistoryStoredObject_;{$IfEnd}

{$Include w:\quality\test\garant6x\AdapterTest\OperationsFramework\atObjectHistory.imp.pas}

end.
