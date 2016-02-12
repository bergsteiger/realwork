unit l3ProtoPersistentWithHandleRefListPrim;

// ������: "w:\common\components\rtl\Garant\L3\l3ProtoPersistentWithHandleRefListPrim.pas"
// ���������: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoPersistentWithHandle
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tl3ProtoPersistentWithHandle;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3ProtoPersistentWithHandleRefListPrim = class(_l3UncomparabeObjectRefList_)
 end;//Tl3ProtoPersistentWithHandleRefListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_52FCCB1B0273_var*
//#UC END# *47B2C42A0163_52FCCB1B0273_var*
begin
//#UC START# *47B2C42A0163_52FCCB1B0273_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FCCB1B0273_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_52FCCB1B0273_var*
//#UC END# *47B99D4503A2_52FCCB1B0273_var*
begin
//#UC START# *47B99D4503A2_52FCCB1B0273_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FCCB1B0273_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ProtoPersistentWithHandleRefListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
