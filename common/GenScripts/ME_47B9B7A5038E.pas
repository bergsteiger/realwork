unit k2PropSorter;
 {* ����������� �������. }

// ������: "w:\common\components\rtl\Garant\K2\k2PropSorter.pas"
// ���������: "SimpleClass"

{$Include k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , k2Base
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tk2CustomProperty;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tk2PropSorter = class(_l3UncomparabeObjectRefList_)
  {* ����������� �������. }
 end;//Tk2PropSorter

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_47B9B7A5038E_var*
//#UC END# *47B2C42A0163_47B9B7A5038E_var*
begin
//#UC START# *47B2C42A0163_47B9B7A5038E_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47B9B7A5038E_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_47B9B7A5038E_var*
//#UC END# *47B99D4503A2_47B9B7A5038E_var*
begin
//#UC START# *47B99D4503A2_47B9B7A5038E_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA^.OrderKey.Compare(CI.rB^.OrderKey);
//#UC END# *47B99D4503A2_47B9B7A5038E_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2PropSorter;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
