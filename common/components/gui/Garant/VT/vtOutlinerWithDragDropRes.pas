unit vtOutlinerWithDragDropRes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "VT"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/VT/vtOutlinerWithDragDropRes.pas"
// �����: 10.03.2010 21:43
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::VT::Outliner::vtOutlinerWithDragDropRes
//
// ������� ��� TvtOutlinerWithDragDrop
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\VT\vtDefine.inc}

interface

uses
  l3StringIDEx
  ;

var
  { ������������ ������ TreeViewMessages }
 str_nsc_MultiSelectDraggingText : Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'nsc_MultiSelectDraggingText'; rValue : '�����: %d');
  { '�����: %d' }

implementation

uses
  l3MessageID
  ;


initialization
// ������������� str_nsc_MultiSelectDraggingText
 str_nsc_MultiSelectDraggingText.Init;

end.