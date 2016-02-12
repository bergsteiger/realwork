unit CsProcWithIdList;

// ������: "w:\common\components\rtl\Garant\cs\CsProcWithIdList.pas"
// ���������: "SimpleClass"

{$Include CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , CsProcWithId
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TCsProcWithId;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TCsProcWithIdList = class(_l3UncomparabeObjectRefList_)
 end;//TCsProcWithIdList
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
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
//#UC START# *47B2C42A0163_537F63D60108_var*
//#UC END# *47B2C42A0163_537F63D60108_var*
begin
//#UC START# *47B2C42A0163_537F63D60108_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_537F63D60108_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_537F63D60108_var*
//#UC END# *47B99D4503A2_537F63D60108_var*
begin
//#UC START# *47B99D4503A2_537F63D60108_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_537F63D60108_impl*
end;//CompareExistingItems

type _Instance_R_ = TCsProcWithIdList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
