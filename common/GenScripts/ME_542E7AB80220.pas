unit m3StorageHolderListPrim;

// Модуль: "w:\common\components\rtl\Garant\m3\m3StorageHolderListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , m3StorageHolder
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = Tm3StorageHolder;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 Tm3StorageHolderListPrim = class(_l3UncomparabeObjectRefList_)
 end;//Tm3StorageHolderListPrim

implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_542E7AB80220_var*
//#UC END# *47B2C42A0163_542E7AB80220_var*
begin
//#UC START# *47B2C42A0163_542E7AB80220_impl*
 Assert(false);
//#UC END# *47B2C42A0163_542E7AB80220_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_542E7AB80220_var*
//#UC END# *47B99D4503A2_542E7AB80220_var*
begin
//#UC START# *47B99D4503A2_542E7AB80220_impl*
 Result := l3Compare(l3PCharLen(CI.rA.FileName), l3PCharLen(CI.rB.FileName), l3_siCaseUnsensitive);
//#UC END# *47B99D4503A2_542E7AB80220_impl*
end;//CompareExistingItems

type _Instance_R_ = Tm3StorageHolderListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

end.
