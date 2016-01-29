unit vgCustomObjectList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VGScene"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/external/VGScene/vgCustomObjectList.pas"
// Начат: 18.02.2011 20:16
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VGScene::Impl::TvgCustomObjectList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VGScene\vg_define.inc}

interface

{$If not defined(NoVGScene)}
uses
  l3ProtoDataContainer,
  vgCustomObject,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}
type
 _ItemType_ = TvgCustomObject;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TvgCustomObjectList = class(_l3PtrList_)
 end;//TvgCustomObjectList
{$IfEnd} //not NoVGScene

implementation

{$If not defined(NoVGScene)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVGScene

{$If not defined(NoVGScene)}

// start class TvgCustomObjectList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4D5EA95401A8_var*
//#UC END# *47B07CF403D0_4D5EA95401A8_var*
begin
//#UC START# *47B07CF403D0_4D5EA95401A8_impl*
 Result := (A = B);
//#UC END# *47B07CF403D0_4D5EA95401A8_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D5EA95401A8_var*
//#UC END# *47B2C42A0163_4D5EA95401A8_var*
begin
//#UC START# *47B2C42A0163_4D5EA95401A8_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D5EA95401A8_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4D5EA95401A8_var*
//#UC END# *47B99D4503A2_4D5EA95401A8_var*
begin
//#UC START# *47B99D4503A2_4D5EA95401A8_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4D5EA95401A8_impl*
end;//CompareExistingItems

type _Instance_R_ = TvgCustomObjectList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}


{$IfEnd} //not NoVGScene
end.