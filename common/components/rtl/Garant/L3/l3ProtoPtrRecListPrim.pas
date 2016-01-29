unit l3ProtoPtrRecListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// �����: ����� �.�.
// ������: "w:/common/components/rtl/Garant/L3/l3ProtoPtrRecListPrim.pas"
// �����: 20.04.2006 17:10
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::RecLists::Tl3ProtoPtrRecListPrim
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include ..\L3\l3Define.inc}

interface

uses
  l3Memory,
  l3ProtoDataContainer,
  l3PureMixIns,
  l3Interfaces,
  l3Types,
  l3Except,
  Classes
  ;

 {$Define l3Items_NeedsBeforeFreeItem}

 {$Define l3Items_HasChanging}

 {$Define l3Items_IsProto}

type
 _DataType_ = Tl3Ptr;
 _l3Changing_Parent_ = Tl3ProtoDataContainer;
 {$Include ..\L3\l3Changing.imp.pas}
 _l3UntypedList_Parent_ = _l3Changing_;
 {$Include ..\L3\l3UntypedList.imp.pas}
 Tl3ProtoPtrRecListPrim = class(_l3UntypedList_)
 end;//Tl3ProtoPtrRecListPrim

implementation

uses
  SysUtils,
  RTLConsts,
  l3Base,
  l3MinMax
  ;

{$Include ..\L3\l3Changing.imp.pas}

type _Instance_R_ = Tl3ProtoPtrRecListPrim;

{$Include ..\L3\l3UntypedList.imp.pas}

end.