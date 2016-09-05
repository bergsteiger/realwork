unit k2PropertyArray;

// Модуль: "w:\common\components\rtl\Garant\K2\k2PropertyArray.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tk2PropertyArray" MUID: (53AABF30022F)

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Variant
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

type
 _ItemType_ = Tl3VariantDef;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 _l3OpenArray_Parent_ = _l3UncomparabeObjectRefList_;
 {$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}
 Tk2PropertyArray = class(_l3OpenArray_)
 end;//Tk2PropertyArray

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *53AABF30022Fimpl_uses*
 //#UC END# *53AABF30022Fimpl_uses*
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_53AABF30022F_var*
//#UC END# *47B2C42A0163_53AABF30022F_var*
begin
//#UC START# *47B2C42A0163_53AABF30022F_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_53AABF30022F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_53AABF30022F_var*
//#UC END# *47B99D4503A2_53AABF30022F_var*
begin
//#UC START# *47B99D4503A2_53AABF30022F_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_53AABF30022F_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2PropertyArray;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}

{$Include w:\common\components\rtl\Garant\L3\l3OpenArray.imp.pas}

end.
