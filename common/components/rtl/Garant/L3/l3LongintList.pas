unit l3LongintList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3LongintList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3LongintList
//
// ������ ����� �����
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3LongintListPrim
  ;

type
 _ListType_ = Tl3LongintListPrim;
 _l3ListOperations_Parent_ = Tl3LongintListPrim;
 {$Include ..\L3\l3ListOperations.imp.pas}
 Tl3LongintList = class(_l3ListOperations_)
  {* ������ ����� ����� }
 end;//Tl3LongintList

implementation

{$Include ..\L3\l3ListOperations.imp.pas}

end.