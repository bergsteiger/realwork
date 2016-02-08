unit NOT_FINISHED_l3ItemsStorage;

// Модуль: "w:\common\components\rtl\Garant\L3\NOT_FINISHED_l3ItemsStorage.pas"
// Стереотип: "SimpleClass"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoPersistentDataContainer
 , l3Types
 , l3Interfaces
 , l3NotifyPtrList
;

type
 _l3LockedChange_Parent_ = Tl3ProtoPersistentDataContainer;
 {$Include l3LockedChange.imp.pas}
 _l3Sortable_Parent_ = _l3LockedChange_;
 {$Include l3Sortable.imp.pas}
 _l3ChangingChangedNotifier_Parent_ = _l3Sortable_;
 {$Include l3ChangingChangedNotifier.imp.pas}
 Tl3ItemsStorage = class(_l3ChangingChangedNotifier_)
  protected
   procedure Swap(var I1: _ItemType_;
    var I2: _ItemType_); override;
    {* Меняет элементы хранилища местами. Не проверяет валидность индексов. }
 end;//Tl3ItemsStorage

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3IID
 , l3InterfacesMisc
;

function DoCompareItems(const A: _ItemType_;
 const B: _ItemType_;
 aSortIndex: Tl3SortIndex
{$If Defined(l3Items_CompareItemsRec_NeedsRList)};
 aList: _l3Sortable_
{$IfEnd} // Defined(l3Items_CompareItemsRec_NeedsRList)
): Integer;
//#UC START# *47B5B5F1038E_4908A9FF0357_var*
//#UC END# *47B5B5F1038E_4908A9FF0357_var*
begin
//#UC START# *47B5B5F1038E_4908A9FF0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B5B5F1038E_4908A9FF0357_impl*
end;//DoCompareItems

{$Include l3LockedChange.imp.pas}

type _Instance_R_ = Tl3ItemsStorage;

{$Include l3Sortable.imp.pas}

{$Include l3ChangingChangedNotifier.imp.pas}

procedure Tl3ItemsStorage.Swap(var I1: _ItemType_;
 var I2: _ItemType_);
 {* Меняет элементы хранилища местами. Не проверяет валидность индексов. }
//#UC START# *47B5B88203A7_4908A9FF0357_var*
//#UC END# *47B5B88203A7_4908A9FF0357_var*
begin
//#UC START# *47B5B88203A7_4908A9FF0357_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B5B88203A7_4908A9FF0357_impl*
end;//Tl3ItemsStorage.Swap

end.
