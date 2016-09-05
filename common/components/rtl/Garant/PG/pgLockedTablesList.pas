unit pgLockedTablesList;

// Модуль: "w:\common\components\rtl\Garant\PG\pgLockedTablesList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TpgLockedTablesList" MUID: (57A835C502DB)

{$Include w:\common\components\rtl\Garant\PG\pgDefine.inc}

interface

{$If Defined(UsePostgres)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , daTypes
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TdaTablesSet;
 _l3StandardTypedList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3StandardTypedList.imp.pas}
 TpgLockedTablesList = class(_l3StandardTypedList_)
 end;//TpgLockedTablesList
{$IfEnd} // Defined(UsePostgres)

implementation

{$If Defined(UsePostgres)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57A835C502DBimpl_uses*
 //#UC END# *57A835C502DBimpl_uses*
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
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

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57A835C502DB_var*
//#UC END# *47B07CF403D0_57A835C502DB_var*
begin
//#UC START# *47B07CF403D0_57A835C502DB_impl*
 Result := A = B;
//#UC END# *47B07CF403D0_57A835C502DB_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57A835C502DB_var*
//#UC END# *47B2C42A0163_57A835C502DB_var*
begin
//#UC START# *47B2C42A0163_57A835C502DB_impl*
 aTo := aFrom;
//#UC END# *47B2C42A0163_57A835C502DB_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FillItem(var aPlace: _ItemType_;
 const anItem: _ItemType_
{$If Defined(l3Items_FillItem_NeedsList)};
 anItems: _l3Items_
{$IfEnd} // Defined(l3Items_FillItem_NeedsList)
);
 {* Заполняет элемент списка. }
//#UC START# *47B935AF0066_57A835C502DB_var*
//#UC END# *47B935AF0066_57A835C502DB_var*
begin
//#UC START# *47B935AF0066_57A835C502DB_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_57A835C502DB_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_57A835C502DB_var*
//#UC END# *47B94A5C006E_57A835C502DB_var*
begin
//#UC START# *47B94A5C006E_57A835C502DB_impl*
 aPlace := [];
//#UC END# *47B94A5C006E_57A835C502DB_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57A835C502DB_var*
//#UC END# *47B99D4503A2_57A835C502DB_var*
begin
//#UC START# *47B99D4503A2_57A835C502DB_impl*
 Assert(False, 'not implemented');
//#UC END# *47B99D4503A2_57A835C502DB_impl*
end;//CompareExistingItems

type _Instance_R_ = TpgLockedTablesList;

{$Include w:\common\components\rtl\Garant\L3\l3StandardTypedList.imp.pas}
{$IfEnd} // Defined(UsePostgres)

end.
