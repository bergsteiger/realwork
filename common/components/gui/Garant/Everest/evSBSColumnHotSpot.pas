unit evSBSColumnHotSpot;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evSBSColumnHotSpot.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevSBSColumnHotSpot
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
  evTableColumnHotSpot,
  nevBase
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 _SBSColumnMarker_Parent_ = TevTableColumnHotSpot;
 {$Include ..\Everest\SBSColumnMarker.imp.pas}
 TevSBSColumnHotSpot = class(_SBSColumnMarker_)
 end;//TevSBSColumnHotSpot
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  k2Except
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

{$Include ..\Everest\SBSColumnMarker.imp.pas}


{$IfEnd} //evUseVisibleCursors
end.