unit nevSectionBreakListPrim;
 {* Базовый список разрывов разделов }

// Модуль: "w:\common\components\gui\Garant\Everest\nevSectionBreakListPrim.pas"
// Стереотип: "SimpleClass"

{$Include evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevTools
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = InevObject;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TnevSectionBreakListPrim = class(_l3InterfaceRefListPrim_)
  {* Базовый список разрывов разделов }
 end;//TnevSectionBreakListPrim

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
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_49192D0702C5_var*
//#UC END# *47B07CF403D0_49192D0702C5_var*
begin
//#UC START# *47B07CF403D0_49192D0702C5_impl*
 Result := (A = B) OR A.AsObject.Box.IsSame(B.AsObject.Box);
//#UC END# *47B07CF403D0_49192D0702C5_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_49192D0702C5_var*
//#UC END# *47B2C42A0163_49192D0702C5_var*
begin
//#UC START# *47B2C42A0163_49192D0702C5_impl*
 Assert(false);
//#UC END# *47B2C42A0163_49192D0702C5_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_49192D0702C5_var*
var
 l_PA : InevBasePoint;
 l_PB : InevBasePoint;
//#UC END# *47B99D4503A2_49192D0702C5_var*
begin
//#UC START# *47B99D4503A2_49192D0702C5_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 l_PA := CI.rA.MakePoint.PointToParentByLevel(MaxInt);
 l_PB := CI.rB.MakePoint.PointToParentByLevel(MaxInt);
 Result := l_PA.Compare(l_PB);
//#UC END# *47B99D4503A2_49192D0702C5_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevSectionBreakListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.
