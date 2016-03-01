unit l3SearchNodePrimList;

// ������: "w:\common\components\rtl\Garant\L3\l3SearchNodePrimList.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3SearchNodePrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

type
 _ItemType_ = Tl3SearchNodePrim;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tl3SearchNodePrimList = class(_l3UncomparabeObjectRefList_)
 end;//Tl3SearchNodePrimList

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
//#UC START# *47B2C42A0163_4E5CDF6B0356_var*
//#UC END# *47B2C42A0163_4E5CDF6B0356_var*
begin
//#UC START# *47B2C42A0163_4E5CDF6B0356_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E5CDF6B0356_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_4E5CDF6B0356_var*
//#UC END# *47B99D4503A2_4E5CDF6B0356_var*
begin
//#UC START# *47B99D4503A2_4E5CDF6B0356_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4E5CDF6B0356_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3SearchNodePrimList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
