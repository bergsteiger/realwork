unit l3ProtoObjectRefList;
 {* ������ ������ �� Tl3ProtoObject }

// ������: "w:\common\components\rtl\Garant\L3\l3ProtoObjectRefList.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

type
 _ItemType_ = Tl3ProtoObject;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3ProtoObjectRefList = class(_l3UncomparabeObjectRefList_)
  {* ������ ������ �� Tl3ProtoObject }
 end;//Tl3ProtoObjectRefList

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
//#UC START# *47B2C42A0163_4CE521C80107_var*
//#UC END# *47B2C42A0163_4CE521C80107_var*
begin
//#UC START# *47B2C42A0163_4CE521C80107_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4CE521C80107_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_4CE521C80107_var*
//#UC END# *47B99D4503A2_4CE521C80107_var*
begin
//#UC START# *47B99D4503A2_4CE521C80107_impl*
 Assert(false, '�������� ��������� ���� ���������������� �������� �� ����� ���� ���������');
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA^) - Integer(CI.rB^);
//#UC END# *47B99D4503A2_4CE521C80107_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3ProtoObjectRefList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
