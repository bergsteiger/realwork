unit l3ProtoObjectPtrList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ProtoObjectPtrList.pas"
// �����: 18.11.2010 15:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Containers::Tl3ProtoObjectPtrList
//
// ������ ���������� �� Tl3ProtoObject
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3ProtoObject,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tl3ProtoObject;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3ObjectPtrList.imp.pas}
 Tl3ProtoObjectPtrList = class(_l3ObjectPtrList_)
  {* ������ ���������� �� Tl3ProtoObject }
 end;//Tl3ProtoObjectPtrList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

type _Instance_R_ = Tl3ProtoObjectPtrList;

{$Include ..\L3\l3ObjectPtrList.imp.pas}

end.