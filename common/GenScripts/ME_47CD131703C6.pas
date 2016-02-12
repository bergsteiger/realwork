unit vtNavigatorFormListPrimPrim;
 {* Список форм навигатора }

// Модуль: "w:\common\components\gui\Garant\VT\vtNavigatorFormListPrimPrim.pas"
// Стереотип: "SimpleClass"

{$Include vtDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vtNavigatorForm
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvtNavigatorForm;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TvtNavigatorFormListPrimPrim = class(_l3UncomparabeObjectRefList_)
  {* Список форм навигатора }
 end;//TvtNavigatorFormListPrimPrim
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
//#UC START# *47B2C42A0163_47CD131703C6_var*
//#UC END# *47B2C42A0163_47CD131703C6_var*
begin
//#UC START# *47B2C42A0163_47CD131703C6_impl*
 Assert(False);
//#UC END# *47B2C42A0163_47CD131703C6_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47CD131703C6_var*
//#UC END# *47B99D4503A2_47CD131703C6_var*
begin
//#UC START# *47B99D4503A2_47CD131703C6_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA.CloseHandler.Form) - Integer(CI.rB.CloseHandler.Form);
 //Assert(False);
//#UC END# *47B99D4503A2_47CD131703C6_impl*
end;//CompareExistingItems

type _Instance_R_ = TvtNavigatorFormListPrimPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // NOT Defined(NoVCM)

end.
