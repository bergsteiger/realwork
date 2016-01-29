unit l3ProtoPersistentWithHandleRefListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "L3"
// ������: "w:/common/components/rtl/Garant/L3/l3ProtoPersistentWithHandleRefListPrim.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi Low Level::L3::Garbage::Tl3ProtoPersistentWithHandleRefListPrim
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
  l3ProtoPersistentWithHandle,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = Tl3ProtoPersistentWithHandle;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include ..\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3ProtoPersistentWithHandleRefListPrim = class(_l3UncomparabeObjectRefList_)
 end;//Tl3ProtoPersistentWithHandleRefListPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tl3ProtoPersistentWithHandleRefListPrim

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FCCB1B0273_var*
//#UC END# *47B2C42A0163_52FCCB1B0273_var*
begin
//#UC START# *47B2C42A0163_52FCCB1B0273_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FCCB1B0273_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_52FCCB1B0273_var*
//#UC END# *47B99D4503A2_52FCCB1B0273_var*
begin
//#UC START# *47B99D4503A2_52FCCB1B0273_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FCCB1B0273_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ProtoPersistentWithHandleRefListPrim;

{$Include ..\L3\l3UncomparabeObjectRefList.imp.pas}

end.