unit evSBSColumnBorderMarker;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Everest"
// ������: "w:/common/components/gui/Garant/Everest/evSBSColumnBorderMarker.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Cursors::TevSBSColumnBorderMarker
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
  evColumnBorderMarker,
  nevBase
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 _SBSColumnMarker_Parent_ = TevColumnBorderMarker;
 {$Include ..\Everest\SBSColumnMarker.imp.pas}
 TevSBSColumnBorderMarker = class(_SBSColumnMarker_)
 end;//TevSBSColumnBorderMarker
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