unit k2SortTagsListPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "K2"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/K2/k2SortTagsListPrim.pas"
// Начат: 23.05.2011 18:57
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::K2::k2PrimObjects::Tk2SortTagsListPrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\K2\k2Define.inc}

interface

uses
  l3Types,
  l3ProtoDataContainer,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = TLongArray;
 _l3RefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}
 Tk2SortTagsListPrim = class(_l3RefList_)
 end;//Tk2SortTagsListPrim

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class Tk2SortTagsListPrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  ); forward;

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  ); forward;

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4DDA75CE02A8_var*
//#UC END# *47B07CF403D0_4DDA75CE02A8_var*
begin
//#UC START# *47B07CF403D0_4DDA75CE02A8_impl*
 Result := (l3LongArrayCompare(A, B) = 0);
//#UC END# *47B07CF403D0_4DDA75CE02A8_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4DDA75CE02A8_var*
//#UC END# *47B2C42A0163_4DDA75CE02A8_var*
begin
//#UC START# *47B2C42A0163_4DDA75CE02A8_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4DDA75CE02A8_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

procedure FillItem(var aPlace: _ItemType_;
  const anItem: _ItemType_
  {$If defined(l3Items_FillItem_NeedsList)}
  ;
  anItems: _l3Items_
  {$IfEnd} //l3Items_FillItem_NeedsList
  );
//#UC START# *47B935AF0066_4DDA75CE02A8_var*
//#UC END# *47B935AF0066_4DDA75CE02A8_var*
begin
//#UC START# *47B935AF0066_4DDA75CE02A8_impl*
 aPlace := anItem;
//#UC END# *47B935AF0066_4DDA75CE02A8_impl*
end;//FillItem

procedure FreeItem(var aPlace: _ItemType_
  {$If defined(l3Items_FreeItem_NeedsList)}
  ;
  aList: _l3Items_
  {$IfEnd} //l3Items_FreeItem_NeedsList
  );
//#UC START# *47B94A5C006E_4DDA75CE02A8_var*
//#UC END# *47B94A5C006E_4DDA75CE02A8_var*
begin
//#UC START# *47B94A5C006E_4DDA75CE02A8_impl*
 aPlace := nil;
//#UC END# *47B94A5C006E_4DDA75CE02A8_impl*
end;//FreeItem

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4DDA75CE02A8_var*
//#UC END# *47B99D4503A2_4DDA75CE02A8_var*
begin
//#UC START# *47B99D4503A2_4DDA75CE02A8_impl*
 Result := l3LongArrayCompare(CI.rA^, CI.rB^);
//#UC END# *47B99D4503A2_4DDA75CE02A8_impl*
end;//CompareExistingItems

type _Instance_R_ = Tk2SortTagsListPrim;

{$Include w:\common\components\rtl\Garant\L3\l3RefList.imp.pas}

end.