unit NOT_FINISHED_l3FieldSortRecList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/NOT_FINISHED_l3FieldSortRecList.pas"
// �����: 25.04.2006 09:30
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::RecLists::Tl3FieldSortRecList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Types,
  l3RecList
  ;

type
 Tl3FieldSortRecList = class(Tl3RecList)
 private
 // private fields
   f_FieldSize : TSmallIntArray;
   f_FieldOffs : TLongArray;
   f_SortFields : TSmallIntArray;
 end;//Tl3FieldSortRecList

implementation

uses
  m2MemLib
  ;

end.