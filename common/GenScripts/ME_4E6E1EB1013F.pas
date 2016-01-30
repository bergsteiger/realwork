unit nevShapePrimRefList;

// Модуль: "w:\common\components\gui\Garant\Everest\new\nevShapePrimRefList.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevShapePrim
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

 {$Define l3Items_NoSort}

 {$Define l3Items_NoChanging}

type
 _ItemType_ = TnevShapePrim;
 _l3ObjectRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3ObjectRefListPrim.imp.pas}
 TnevShapePrimRefList = class(_l3ObjectRefListPrim_)
 end;//TnevShapePrimRefList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_); forward;

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4E6E1EB1013F_var*
//#UC END# *47B2C42A0163_4E6E1EB1013F_var*
begin
//#UC START# *47B2C42A0163_4E6E1EB1013F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E6E1EB1013F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_;
 anItems: _l3Items_);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_4E6E1EB1013F_var*
//#UC END# *47B935AF0066_4E6E1EB1013F_var*
begin
//#UC START# *47B935AF0066_4E6E1EB1013F_impl*
 aPlace := anItem.Use;
//#UC END# *47B935AF0066_4E6E1EB1013F_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_;
 aList: _l3Items_);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_4E6E1EB1013F_var*
//#UC END# *47B94A5C006E_4E6E1EB1013F_var*
begin
//#UC START# *47B94A5C006E_4E6E1EB1013F_impl*
 if (aPlace <> nil) then
  TnevShapePrim(aPlace).CleanupRefs;
 FreeAndNil(aPlace);
//#UC END# *47B94A5C006E_4E6E1EB1013F_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4E6E1EB1013F_var*
//#UC END# *47B99D4503A2_4E6E1EB1013F_var*
begin
//#UC START# *47B99D4503A2_4E6E1EB1013F_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4E6E1EB1013F_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevShapePrimRefList;

{$Include l3ObjectRefListPrim.imp.pas}

end.
