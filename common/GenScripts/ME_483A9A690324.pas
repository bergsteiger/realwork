unit atListHistory;

// ������: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atListHistory.pas"
// ���������: "SimpleClass"

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

{$Include w:\quality\test\garant6x\AdapterTest\OperationsFramework\atObjectHistory.imp.pas}

end.
