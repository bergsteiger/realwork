unit vcmMessageQueuePrim;

// Модуль: "w:\common\components\gui\Garant\VCM\implementation\Visual\vcmMessageQueuePrim.pas"
// Стереотип: "SimpleClass"

{$Include vcmDefine.inc}

interface

{$If NOT Defined(NoVCM)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
 , vcmGUI
;

type
 TvcmMessageQueueItem = record
  rMsgId: TvcmMessageID;
  rMessage: Il3CString;
 end;//TvcmMessageQueueItem

 {$Define l3Items_NoSort}

 _ItemType_ = TvcmMessageQueueItem;
 _l3RecordListPrim_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3RecordListPrim.imp.pas}
 TvcmMessageQueuePrim = class(_l3RecordListPrim_)
 end;//TvcmMessageQueuePrim
{$IfEnd} // NOT Defined(NoVCM)

implementation

{$If NOT Defined(NoVCM)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)
function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
//#UC START# *47B07CF403D0_4E089A99009F_var*
//#UC END# *47B07CF403D0_4E089A99009F_var*
begin
//#UC START# *47B07CF403D0_4E089A99009F_impl*
 Result := false;
 Assert(false);
//#UC END# *47B07CF403D0_4E089A99009F_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_4E089A99009F_var*
//#UC END# *47B2C42A0163_4E089A99009F_var*
begin
//#UC START# *47B2C42A0163_4E089A99009F_impl*
 Assert(false);
//#UC END# *47B2C42A0163_4E089A99009F_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
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
{$IfEnd} // NOT Defined(NoVCM)

end.
