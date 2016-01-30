unit atDocumentHistory;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atDocumentHistory.pas"
// Стереотип: "SimpleClass"

interface

uses
 l3IntfUses
 , Classes
 , DocumentUnit
;

type
 _HistoryStoredObject_ = IDocument;
 {$Include atObjectHistory.imp.pas}
 TatDocumentHistory = class(_atObjectHistory_)
 end;//TatDocumentHistory

implementation

uses
 l3ImplUses
;

{$Include atObjectHistory.imp.pas}

end.
