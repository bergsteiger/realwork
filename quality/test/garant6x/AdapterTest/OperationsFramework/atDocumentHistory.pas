unit atDocumentHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/OperationsFramework/atDocumentHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::OperationsFramework::TatDocumentHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

uses
  DocumentUnit,
  Classes
  ;

type
 _HistoryStoredObject_ = IDocument;
 {$Include ..\OperationsFramework\atObjectHistory.imp.pas}
 TatDocumentHistory = class(_atObjectHistory_)
 end;//TatDocumentHistory

implementation

{$Include ..\OperationsFramework\atObjectHistory.imp.pas}

end.