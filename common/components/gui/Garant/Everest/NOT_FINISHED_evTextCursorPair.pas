unit NOT_FINISHED_evTextCursorPair;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/NOT_FINISHED_evTextCursorPair.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevTextCursorPair
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  evLeafParaCursorPair
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevTextCursorPair = class(TevLeafParaCursorPair)
 end;//TevTextCursorPair
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}


{$IfEnd} //evUseVisibleCursors
end.