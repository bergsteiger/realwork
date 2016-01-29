unit nevObjectList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/Everest/new/nevObjectList.pas"
// Начат: 15.02.2011 12:30
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::Views::TnevObjectList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
  nevTools,
  l3ProtoDataContainer,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;

type
 _ItemType_ = InevObject;
 _l3InterfaceRefListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}
 TnevObjectList = class(_l3InterfaceRefListPrim_)
 end;//TnevObjectList

implementation

uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;

// start class TnevObjectList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4D5A47B80258_var*
//#UC END# *47B07CF403D0_4D5A47B80258_var*
begin
//#UC START# *47B07CF403D0_4D5A47B80258_impl*
 Result := A.AsObject.Box.IsSame(B.AsObject.Box);
//#UC END# *47B07CF403D0_4D5A47B80258_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4D5A47B80258_var*
//#UC END# *47B2C42A0163_4D5A47B80258_var*
begin
//#UC START# *47B2C42A0163_4D5A47B80258_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4D5A47B80258_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4D5A47B80258_var*
//#UC END# *47B99D4503A2_4D5A47B80258_var*
begin
//#UC START# *47B99D4503A2_4D5A47B80258_impl*
 Assert(false);
 Result := -1;
//#UC END# *47B99D4503A2_4D5A47B80258_impl*
end;//CompareExistingItems

type _Instance_R_ = TnevObjectList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefListPrim.imp.pas}

end.