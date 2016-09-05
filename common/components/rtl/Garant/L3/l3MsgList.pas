unit l3MsgList;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MsgList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "Tl3MsgList" MUID: (57C52EF90214)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , Windows
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TMsg;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 Tl3MsgList = class(_l3RecordListPrim_)
 end;//Tl3MsgList

implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57C52EF90214impl_uses*
 //#UC END# *57C52EF90214impl_uses*
;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_57C52EF90214_var*
//#UC END# *47B07CF403D0_57C52EF90214_var*
begin
//#UC START# *47B07CF403D0_57C52EF90214_impl*
 Result := (A.hwnd = B.hwnd) and (A.message = B.message) and (A.wParam = B.wParam) and
  (A.lParam = B.wParam) and (A.time = B.time) and (A.pt.X = B.pt.X) and (A.pt.Y = B.pt.Y);
//#UC END# *47B07CF403D0_57C52EF90214_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57C52EF90214_var*
//#UC END# *47B2C42A0163_57C52EF90214_var*
begin
//#UC START# *47B2C42A0163_57C52EF90214_impl*
 Assert(False);
//#UC END# *47B2C42A0163_57C52EF90214_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57C52EF90214_var*
//#UC END# *47B99D4503A2_57C52EF90214_var*
begin
//#UC START# *47B99D4503A2_57C52EF90214_impl*
 Assert(False);
 Result := -1;
//#UC END# *47B99D4503A2_57C52EF90214_impl*
end;//CompareExistingItems

type _Instance_R_ = Tl3MsgList;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}

end.
