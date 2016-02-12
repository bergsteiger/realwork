unit vgSortableObjectList;

// Модуль: "w:\common\components\rtl\external\VGScene\vgSortableObjectList.pas"
// Стереотип: "SimpleClass"

{$Include vg_define.inc}

interface

{$If NOT Defined(NoVGScene)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , vgTypesPrim
 , vgCustomObject
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TvgCustomObject;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TvgSortableObjectList = class(_l3PtrList_)
  public
   procedure Sort(aComparer: TvgObjectSortCompare);
 end;//TvgSortableObjectList
{$IfEnd} // NOT Defined(NoVGScene)

implementation

{$If NOT Defined(NoVGScene)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

var f_CurrentComparer: TvgObjectSortCompare = nil;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4D552B230161_var*
//#UC END# *47B07CF403D0_4D552B230161_var*
begin
//#UC START# *47B07CF403D0_4D552B230161_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_4D552B230161_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D552B230161_var*
//#UC END# *47B2C42A0163_4D552B230161_var*
begin
//#UC START# *47B2C42A0163_4D552B230161_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D552B230161_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_4D552B230161_var*
//#UC END# *47B99D4503A2_4D552B230161_var*
begin
//#UC START# *47B99D4503A2_4D552B230161_impl*
 Assert(Assigned(f_CurrentComparer));
 Result := f_CurrentComparer(CI.rA^, CI.rB^);
//#UC END# *47B99D4503A2_4D552B230161_impl*
end;//CompareExistingItems

type _Instance_R_ = TvgSortableObjectList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}

procedure TvgSortableObjectList.Sort(aComparer: TvgObjectSortCompare);
//#UC START# *4D552BB90144_4D552B230161_var*
//#UC END# *4D552BB90144_4D552B230161_var*
begin
//#UC START# *4D552BB90144_4D552B230161_impl*
 Assert(not Assigned(f_CurrentComparer));
 f_CurrentComparer := aComparer;
 try
  inherited Sort;
 finally
  f_CurrentComparer := nil;
 end;//try..finaly
//#UC END# *4D552BB90144_4D552B230161_impl*
end;//TvgSortableObjectList.Sort
{$IfEnd} // NOT Defined(NoVGScene)

end.
