unit vcmFormSetFormsCollectionPrimPrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmFormSetFormsCollectionPrimPrim.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmFormSetFormsCollectionItemPrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvcmFormSetFormsCollectionItemPrim;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3UncomparabeObjectRefList.imp.pas}
 TvcmFormSetFormsCollectionPrimPrim = class(_l3UncomparabeObjectRefList_)
 end;//TvcmFormSetFormsCollectionPrimPrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
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
//#UC START# *47B2C42A0163_4FFC55AD02B3_var*
//#UC END# *47B2C42A0163_4FFC55AD02B3_var*
begin
//#UC START# *47B2C42A0163_4FFC55AD02B3_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4FFC55AD02B3_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4FFC55AD02B3_var*
//#UC END# *47B99D4503A2_4FFC55AD02B3_var*
begin
//#UC START# *47B99D4503A2_4FFC55AD02B3_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_4FFC55AD02B3_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmFormSetFormsCollectionPrimPrim;

{$Include l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
