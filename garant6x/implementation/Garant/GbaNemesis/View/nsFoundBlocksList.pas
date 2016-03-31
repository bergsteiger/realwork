unit nsFoundBlocksList;
 {* Найденные блоки для позиционирования }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFoundBlocksList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFoundBlocksList" MUID: (4B61AB64033F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , nevTools
;

type
 TnsFoundBlockInfo = object
  public
   rBlockID: Integer;
   rPoint: InevBasePoint;
 end;//TnsFoundBlockInfo

 _ItemType_ = TnsFoundBlockInfo;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TnsFoundBlocksList = class(_l3RecordListPrim_)
  {* Найденные блоки для позиционирования }
 end;//TnsFoundBlocksList

function TnsFoundBlockInfo_C(aBlockID: Integer;
 const aPoint: InevBasePoint): TnsFoundBlockInfo; overload;
function TnsFoundBlockInfo_C(aBlockID: Integer): TnsFoundBlockInfo; overload;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

function TnsFoundBlockInfo_C(aBlockID: Integer;
 const aPoint: InevBasePoint): TnsFoundBlockInfo;
//#UC START# *4B61AC4403B2_4B61ABFB015F_var*
//#UC END# *4B61AC4403B2_4B61ABFB015F_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B61AC4403B2_4B61ABFB015F_impl*
 Result.rBlockID := aBlockID;
 Result.rPoint := aPoint;
//#UC END# *4B61AC4403B2_4B61ABFB015F_impl*
end;//TnsFoundBlockInfo_C

function TnsFoundBlockInfo_C(aBlockID: Integer): TnsFoundBlockInfo;
//#UC START# *4B61AE6A01A4_4B61ABFB015F_var*
//#UC END# *4B61AE6A01A4_4B61ABFB015F_var*
begin
 Finalize(Result);
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *4B61AE6A01A4_4B61ABFB015F_impl*
 Result := TnsFoundBlockInfo_C(aBlockID, nil);
//#UC END# *4B61AE6A01A4_4B61ABFB015F_impl*
end;//TnsFoundBlockInfo_C

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4B61AB64033F_var*
//#UC END# *47B07CF403D0_4B61AB64033F_var*
begin
//#UC START# *47B07CF403D0_4B61AB64033F_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4B61AB64033F_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4B61AB64033F_var*
//#UC END# *47B2C42A0163_4B61AB64033F_var*
begin
//#UC START# *47B2C42A0163_4B61AB64033F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4B61AB64033F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4B61AB64033F_var*
//#UC END# *47B99D4503A2_4B61AB64033F_var*
begin
//#UC START# *47B99D4503A2_4B61AB64033F_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := CI.rA.rBlockID - CI.rB.rBlockID;
//#UC END# *47B99D4503A2_4B61AB64033F_impl*
end;//CompareExistingItems

type _Instance_R_ = TnsFoundBlocksList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
