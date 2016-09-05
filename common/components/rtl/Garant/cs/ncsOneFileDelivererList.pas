unit ncsOneFileDelivererList;

// ������: "w:\common\components\rtl\Garant\cs\ncsOneFileDelivererList.pas"
// ���������: "SimpleClass"
// ������� ������: "TncsOneFileDelivererList" MUID: (546F3918029F)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , ncsOneFileDeliverer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TncsOneFileDeliverer;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TncsOneFileDelivererList = class(_l3UncomparabeObjectRefList_)
 end;//TncsOneFileDelivererList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *546F3918029Fimpl_uses*
 //#UC END# *546F3918029Fimpl_uses*
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_546F3918029F_var*
//#UC END# *47B2C42A0163_546F3918029F_var*
begin
//#UC START# *47B2C42A0163_546F3918029F_impl*
 Assert(False);
//#UC END# *47B2C42A0163_546F3918029F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_546F3918029F_var*
//#UC END# *47B99D4503A2_546F3918029F_var*
begin
//#UC START# *47B99D4503A2_546F3918029F_impl*
 Assert(False);
//#UC END# *47B99D4503A2_546F3918029F_impl*
end;//CompareExistingItems

type _Instance_R_ = TncsOneFileDelivererList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
