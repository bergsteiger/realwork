unit msmViewRefList;

// Модуль: "w:\common\components\gui\Garant\msm\msmViewRefList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TmsmViewRefList" MUID: (57EA53530213)

{$Include w:\common\components\msm.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , msmControllers
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TmsmView;
 _l3ObjectRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}
 TmsmViewRefList = class(_l3ObjectRefListPrim_)
 end;//TmsmViewRefList

implementation

uses
 l3ImplUses
 , l3Base
 , SysUtils
 , l3MinMax
 , RTLConsts
 //#UC START# *57EA53530213impl_uses*
 //#UC END# *57EA53530213impl_uses*
;

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)}
;
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
); forward;

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)}
;
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57EA53530213_var*
//#UC END# *47B2C42A0163_57EA53530213_var*
begin
//#UC START# *47B2C42A0163_57EA53530213_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57EA53530213_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_57EA53530213_var*
//#UC END# *47B935AF0066_57EA53530213_var*
begin
//#UC START# *47B935AF0066_57EA53530213_impl*
 aPlace := l3Use(anItem);
//#UC END# *47B935AF0066_57EA53530213_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_57EA53530213_var*
//#UC END# *47B94A5C006E_57EA53530213_var*
begin
//#UC START# *47B94A5C006E_57EA53530213_impl*
 FreeAndNil(aPlace);
//#UC END# *47B94A5C006E_57EA53530213_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57EA53530213_var*
//#UC END# *47B99D4503A2_57EA53530213_var*
begin
//#UC START# *47B99D4503A2_57EA53530213_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_57EA53530213_impl*
end;//CompareExistingItems

type _Instance_R_ = TmsmViewRefList;

{$Include w:\common\components\rtl\Garant\L3\l3ObjectRefListPrim.imp.pas}

end.
