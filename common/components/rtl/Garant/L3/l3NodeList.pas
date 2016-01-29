unit l3NodeList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3NodeList.pas"
// �����: 20.03.2008 14:11
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3Trees::Tl3NodeList
//
// ������ ����� ������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Tree_TLB,
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Il3Node;
 _l3InterfaceRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3InterfaceRefList.imp.pas}
 Tl3NodeList = class(_l3InterfaceRefList_)
  {* ������ ����� ������. }
 end;//Tl3NodeList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3NodeList;

{$Include ..\L3\l3InterfaceRefList.imp.pas}

end.