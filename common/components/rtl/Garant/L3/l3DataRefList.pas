unit l3DataRefList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3DataRefList.pas"
// �����: 07.02.2008 10:10
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3DataRefList
//
// ������ ������ �� ����� ������. ��� ���� ������������ ����������� �������� ����� ������. ���
// ������ ������ ���� �������� �������� l3System.GetLocalMem.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3SimpleDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Pointer;
 _l3DataRefList_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3DataRefList.imp.pas}
 Tl3DataRefList = class(_l3DataRefList_)
  {* ������ ������ �� ����� ������. ��� ���� ������������ ����������� �������� ����� ������. ��� ������ ������ ���� �������� �������� l3System.GetLocalMem. }
 end;//Tl3DataRefList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3DataRefList;

{$Include ..\L3\l3DataRefList.imp.pas}

end.