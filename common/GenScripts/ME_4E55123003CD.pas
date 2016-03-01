unit evStandardStylesListPrim;

// Модуль: "w:\common\components\gui\Garant\Everest\evStandardStylesListPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , evResultFontInterfaces
;

type
 TevStandardStylesCacheByFixedFont = array [Boolean] of IevResultFont;

 TevStandardStylesCacheByVisibility = array [Boolean] of TevStandardStylesCacheByFixedFont;

 TevStandardStylesCacheByJustification = array [Boolean] of TevStandardStylesCacheByVisibility;

 TevStandardStylesCacheItem = object
  public
   rValue: TevStandardStylesCacheByJustification;
   rID: Integer;
 end;//TevStandardStylesCacheItem

 _ItemType_ = TevStandardStylesCacheItem;
 _l3RecordListPrimPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}
 TevStandardStylesListPrim = class(_l3RecordListPrimPrim_)
  protected
   procedure InitFields; override;
  public
   class procedure evFreeStandardStylesCache(var theCache: TevStandardStylesCacheByJustification);
 end;//TevStandardStylesListPrim

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
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
//#UC START# *47B07CF403D0_4E55123003CD_var*
//#UC END# *47B07CF403D0_4E55123003CD_var*
begin
//#UC START# *47B07CF403D0_4E55123003CD_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4E55123003CD_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4E55123003CD_var*
//#UC END# *47B2C42A0163_4E55123003CD_var*
begin
//#UC START# *47B2C42A0163_4E55123003CD_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E55123003CD_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

procedure FreeItem(var aPlace: _ItemType_
{$If Defined(l3Items_FreeItem_NeedsList)};
 aList: _l3Items_
{$IfEnd} // Defined(l3Items_FreeItem_NeedsList)
);
 {* Очищает элемент списка }
//#UC START# *47B94A5C006E_4E55123003CD_var*
//#UC END# *47B94A5C006E_4E55123003CD_var*
begin
//#UC START# *47B94A5C006E_4E55123003CD_impl*
 TevStandardStylesListPrim.EvFreeStandardStylesCache(aPlace.rValue);
 Finalize(aPlace);
//#UC END# *47B94A5C006E_4E55123003CD_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4E55123003CD_var*
//#UC END# *47B99D4503A2_4E55123003CD_var*
begin
//#UC START# *47B99D4503A2_4E55123003CD_impl*
 Result := CI.rA.rID - CI.rB.rID;
//#UC END# *47B99D4503A2_4E55123003CD_impl*
end;//CompareExistingItems

type _Instance_R_ = TevStandardStylesListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrimPrim.imp.pas}

class procedure TevStandardStylesListPrim.evFreeStandardStylesCache(var theCache: TevStandardStylesCacheByJustification);
//#UC START# *4E55156E009C_4E55123003CD_var*
var
 j : Boolean{TevIndentType};
 k : Boolean;
 l : Boolean;
//#UC END# *4E55156E009C_4E55123003CD_var*
begin
//#UC START# *4E55156E009C_4E55123003CD_impl*
 for j := Low(j) to High(j) do
  for k := Low(k) to High(k) do
   for l := Low(l) to High(l) do
    if (theCache[j, k, l] <> nil) then
     theCache[j, k, l] := nil;
//#UC END# *4E55156E009C_4E55123003CD_impl*
end;//TevStandardStylesListPrim.evFreeStandardStylesCache

procedure TevStandardStylesListPrim.InitFields;
//#UC START# *47A042E100E2_4E55123003CD_var*
//#UC END# *47A042E100E2_4E55123003CD_var*
begin
//#UC START# *47A042E100E2_4E55123003CD_impl*
 inherited;
 Sorted := true;
//#UC END# *47A042E100E2_4E55123003CD_impl*
end;//TevStandardStylesListPrim.InitFields

end.
