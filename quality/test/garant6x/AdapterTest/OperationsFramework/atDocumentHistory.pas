unit atDocumentHistory;

// Модуль: "w:\quality\test\garant6x\AdapterTest\OperationsFramework\atDocumentHistory.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TatDocumentHistory" MUID: (483A9A3600C3)

interface

uses
 l3IntfUses
 , Classes
 , DocumentUnit
;

type
 _HistoryStoredObject_ = IDocument;
 {$Include w:\quality\test\garant6x\AdapterTest\OperationsFramework\atObjectHistory.imp.pas}
 TatDocumentHistory = class(_atObjectHistory_)
 end;//TatDocumentHistory

implementation

uses
 l3ImplUses
;

{$Include w:\quality\test\garant6x\AdapterTest\OperationsFramework\atObjectHistory.imp.pas}

end.
