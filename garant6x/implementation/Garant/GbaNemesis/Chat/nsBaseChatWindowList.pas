unit nsBaseChatWindowList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Chat"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Chat/nsBaseChatWindowList.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Встроенные продукты::Chat::Chat::ChatImpl::TnsBaseChatWindowList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3SimpleDataContainer,
  ChatInterfaces,
  l3Types,
  l3Memory,
  l3Interfaces,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 _ItemType_ = IbsChatWindow;
 _l3InterfacePtrListPrim_Parent_ = Tl3SimpleDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrListPrim.imp.pas}
 TnsBaseChatWindowList = class(_l3InterfacePtrListPrim_)
 end;//TnsBaseChatWindowList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsBaseChatWindowList

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4A6D72AD01D4_var*
//#UC END# *47B07CF403D0_4A6D72AD01D4_var*
begin
//#UC START# *47B07CF403D0_4A6D72AD01D4_impl*
 Result := A.UserID = B.UserID;
//#UC END# *47B07CF403D0_4A6D72AD01D4_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4A6D72AD01D4_var*
//#UC END# *47B2C42A0163_4A6D72AD01D4_var*
begin
//#UC START# *47B2C42A0163_4A6D72AD01D4_impl*
 Assert(False);
//#UC END# *47B2C42A0163_4A6D72AD01D4_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4A6D72AD01D4_var*
//#UC END# *47B99D4503A2_4A6D72AD01D4_var*
begin
//#UC START# *47B99D4503A2_4A6D72AD01D4_impl*
 {$IfDef l3Items_HasCustomSort}
 Assert(CI.rSortIndex = l3_siNative);
 {$EndIf l3Items_HasCustomSort}
 Result := Integer(CI.rA.UserID) - Integer(CI.rB.UserID);
//#UC END# *47B99D4503A2_4A6D72AD01D4_impl*
end;//CompareExistingItems

type _Instance_R_ = TnsBaseChatWindowList;

{$Include w:\common\components\rtl\Garant\L3\l3InterfacePtrListPrim.imp.pas}


{$IfEnd} //not Admin AND not Monitorings
end.