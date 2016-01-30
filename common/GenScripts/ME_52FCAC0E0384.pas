unit QueryListPrim;

// Модуль: "w:\common\components\rtl\Garant\DT\QueryListPrim.pas"
// Стереотип: "SimpleClass"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , SavedQuery
 , l3PureMixIns
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , l3NotifyPtrList
;

 {$Define l3Items_IsProto}

 {$Define l3Items_HasChanging}

type
 _ItemType_ = TSavedQuery;
 _l3Changing_Parent_ = Tl3ProtoDataContainer;
 {$Include l3Changing.imp.pas}
 _l3UncomparabeObjectRefList_Parent_ = _l3Changing_;
 {$Include l3UncomparabeObjectRefList.imp.pas}
 _l3ChangingChangedNotifier_Parent_ = _l3UncomparabeObjectRefList_;
 {$Include l3ChangingChangedNotifier.imp.pas}
 _l3LockedChange_Parent_ = _l3ChangingChangedNotifier_;
 {$Include l3LockedChange.imp.pas}
 _l3OpenArray_Parent_ = _l3LockedChange_;
 {$Include l3OpenArray.imp.pas}
 TQueryListPrim = class(_l3OpenArray_)
 end;//TQueryListPrim
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
//#UC START# *47B2C42A0163_52FCAC0E0384_var*
//#UC END# *47B2C42A0163_52FCAC0E0384_var*
begin
//#UC START# *47B2C42A0163_52FCAC0E0384_impl*
 Assert(false);
//#UC END# *47B2C42A0163_52FCAC0E0384_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_52FCAC0E0384_var*
//#UC END# *47B99D4503A2_52FCAC0E0384_var*
begin
//#UC START# *47B99D4503A2_52FCAC0E0384_impl*
 Result := CI.rA.CompareWith(CI.rB^);
//#UC END# *47B99D4503A2_52FCAC0E0384_impl*
end;//CompareExistingItems

{$Include l3Changing.imp.pas}

type _Instance_R_ = TQueryListPrim;

{$Include l3UncomparabeObjectRefList.imp.pas}

{$Include l3ChangingChangedNotifier.imp.pas}

{$Include l3LockedChange.imp.pas}

{$Include l3OpenArray.imp.pas}
{$IfEnd} // NOT Defined(Nemesis)

end.
