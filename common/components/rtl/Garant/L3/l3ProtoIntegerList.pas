unit l3ProtoIntegerList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ProtoIntegerList.pas"
// �����: 04.10.2010 13:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::l3CoreObjects::Tl3ProtoIntegerList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Integer;
 _l3AtomicList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3AtomicList.imp.pas}
 Tl3ProtoIntegerList = class(_l3AtomicList_)
 end;//Tl3ProtoIntegerList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3ProtoIntegerList;

{$Include ..\L3\l3AtomicList.imp.pas}

end.