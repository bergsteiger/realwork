unit evSavedCursorListPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\evSavedCursorListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , evSavedCursor
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TevSavedCursor;
 _l3UncomparabeObjectRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
 TevSavedCursorListPrim = class(_l3UncomparabeObjectRefList_)
 end;//TevSavedCursorListPrim
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
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
//#UC START# *47B2C42A0163_47E3E5A102C9_var*
//#UC END# *47B2C42A0163_47E3E5A102C9_var*
begin
//#UC START# *47B2C42A0163_47E3E5A102C9_impl*
 Assert(false);
//#UC END# *47B2C42A0163_47E3E5A102C9_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_47E3E5A102C9_var*
//#UC END# *47B99D4503A2_47E3E5A102C9_var*
begin
//#UC START# *47B99D4503A2_47E3E5A102C9_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_47E3E5A102C9_impl*
end;//CompareExistingItems

type _Instance_R_ = TevSavedCursorListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3UncomparabeObjectRefList.imp.pas}
{$IfEnd} // Defined(evUseVisibleCursors)

end.
