unit atDocumentHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "AdapterTest"
// ������: "w:/quality/test/garant6x/AdapterTest/OperationsFramework/atDocumentHistory.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x_test::AdapterTest::OperationsFramework::TatDocumentHistory
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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