unit ddDocumentAtomList;

// ������: "w:\common\components\rtl\Garant\dd\ddDocumentAtomList.pas"
// ���������: "SimpleClass"

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddDocumentAtom
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TddDocumentAtom;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TddDocumentAtomList = class(_l3UncomparabeObjectRefList_)
 end;//TddDocumentAtomList

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
//#UC START# *47B2C42A0163_518A04EF001B_var*
//#UC END# *47B2C42A0163_518A04EF001B_var*
begin
//#UC START# *47B2C42A0163_518A04EF001B_impl*
 Assert(False);
//#UC END# *47B2C42A0163_518A04EF001B_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* ���������� ��� ������������ ��������. }
//#UC START# *47B99D4503A2_518A04EF001B_var*
//#UC END# *47B99D4503A2_518A04EF001B_var*
begin
//#UC START# *47B99D4503A2_518A04EF001B_impl*
 Assert(False);
 Result := -1;
//#UC END# *47B99D4503A2_518A04EF001B_impl*
end;//CompareExistingItems

type _Instance_R_ = TddDocumentAtomList;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
