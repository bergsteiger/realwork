unit eeDocumentCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest Engine"
// ������: "w:/common/components/gui/Garant/Everest_Engine/eeDocumentCursor.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For F1::Everest Engine::Cursors::TeeDocumentCursor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest_Engine\eeDefine.inc}

interface

uses
  Classes
  {$If defined(evUseVisibleCursors)}
  ,
  evDocumentCursor
  {$IfEnd} //evUseVisibleCursors
  
  ;

type
 TeeDocumentCursor = class(TevDocumentCursor)
 end;//TeeDocumentCursor

implementation

end.