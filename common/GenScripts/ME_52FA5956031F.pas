unit DictEditQueryList;

// ������: "w:\common\components\rtl\Garant\cs\DictEditQueryList.pas"
// ���������: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , csServerTaskTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TDictEditQuery;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TDictEditQueryList = class(_l3UncomparabeObjectRefList_)
 end;//TDictEditQueryList
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
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
//#UC START# *47B2C42A0163_52FA5956031F_var*
//#UC END# *47B2C42A0163_52FA5956031F_var*
begin
//#UC START# *47B2C42A0163_52FA5956031F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FA5956031F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_52FA5956031F_var*
//#UC END# *47B99D4503A2_52FA5956031F_var*
begin
//#UC START# *47B99D4503A2_52FA5956031F_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_52FA5956031F_impl*
end;//CompareExistingItems

type _Instance_R_ = TDictEditQueryList;

{$Include l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
