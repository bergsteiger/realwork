unit evBreakParaCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evBreakParaCursor.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevBreakParaCursor
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  evSolidParaCursor,
  nevTools
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 _nevBreakParaAnchorModify_Parent_ = TevSolidParaCursor;
 {$Include ..\Everest\nevBreakParaAnchorModify.imp.pas}
 TevBreakParaCursor = class(_nevBreakParaAnchorModify_)
 end;//TevBreakParaCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}

{$Include ..\Everest\nevBreakParaAnchorModify.imp.pas}


{$IfEnd} //evUseVisibleCursors
end.