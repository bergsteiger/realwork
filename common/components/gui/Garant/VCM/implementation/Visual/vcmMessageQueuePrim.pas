unit vcmMessageQueuePrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/gui/Garant/VCM/implementation/Visual/vcmMessageQueuePrim.pas"
// Начат: 27.06.2011 18:58
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::VCM$Visual::Visual::TvcmMessageQueuePrim
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If not defined(NoVCM)}
uses
  l3Interfaces,
  vcmGUI,
  l3ProtoDataContainer,
  l3Memory,
  l3Types,
  l3Core,
  l3Except,
  Classes
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}
type
 TvcmMessageQueueItem = record
   rMsgId : TvcmMessageID;
   rMessage : Il3CString;
 end;//TvcmMessageQueueItem

 {$Define l3Items_NoSort}

 _ItemType_ = TvcmMessageQueueItem;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TvcmMessageQueuePrim = class(_l3RecordListPrim_)
 end;//TvcmMessageQueuePrim
{$IfEnd} //not NoVCM

implementation

{$If not defined(NoVCM)}
uses
  l3Base,
  l3MinMax,
  RTLConsts,
  SysUtils
  ;
{$IfEnd} //not NoVCM

{$If not defined(NoVCM)}

// start class TvcmMessageQueuePrim

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_); forward;
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort


function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If not defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
  const B: _ItemType_): Boolean;
//#UC START# *47B07CF403D0_4E089A99009F_var*
//#UC END# *47B07CF403D0_4E089A99009F_var*
begin
//#UC START# *47B07CF403D0_4E089A99009F_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4E089A99009F_impl*
end;//IsSameItems
{$IfEnd} //not l3Items_IsAtomic

{$If defined(l3Items_NeedsAssignItem) AND not defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
  const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4E089A99009F_var*
//#UC END# *47B2C42A0163_4E089A99009F_var*
begin
//#UC START# *47B2C42A0163_4E089A99009F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E089A99009F_impl*
end;//AssignItem
{$IfEnd} //l3Items_NeedsAssignItem AND not l3Items_NoSort

function CompareExistingItems(const CI: CompareItemsRec): Integer;
//#UC START# *47B99D4503A2_4E089A99009F_var*
//#UC END# *47B99D4503A2_4E089A99009F_var*
begin
//#UC START# *47B99D4503A2_4E089A99009F_impl*
 Result := -1;
 Assert(false);
//#UC END# *47B99D4503A2_4E089A99009F_impl*
end;//CompareExistingItems

type _Instance_R_ = TvcmMessageQueuePrim;

{$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}


{$IfEnd} //not NoVCM
end.