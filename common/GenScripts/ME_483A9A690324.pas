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
 {$Include atObjectHistory.imp.pas}
 TatListHistory = class(_atObjectHistory_)
 end;//TatListHistory

implementation

uses
 l3ImplUses
;

{$Include atObjectHistory.imp.pas}

end.
