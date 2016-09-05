unit NOT_FINISHED_nsDownloaderThreadList;

// Модуль: "w:\common\components\gui\Garant\Nemesis\NOT_FINISHED_nsDownloaderThreadList.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsDownloaderThreadList" MUID: (57BFDE7402F0)

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoDataContainer
 , nsDownloaderThread
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
 , Classes
;

type
 _ItemType_ = TnsDownloaderThread;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TnsDownloaderThreadList = class(_l3PtrList_)
 end;//TnsDownloaderThreadList
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
 //#UC START# *57BFDE7402F0impl_uses*
 //#UC END# *57BFDE7402F0impl_uses*
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
//#UC START# *47B07CF403D0_57BFDE7402F0_var*
//#UC END# *47B07CF403D0_57BFDE7402F0_var*
begin
//#UC START# *47B07CF403D0_57BFDE7402F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B07CF403D0_57BFDE7402F0_impl*
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
//#UC START# *47B2C42A0163_57BFDE7402F0_var*
//#UC END# *47B2C42A0163_57BFDE7402F0_var*
begin
//#UC START# *47B2C42A0163_57BFDE7402F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B2C42A0163_57BFDE7402F0_impl*
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
//#UC START# *47B99D4503A2_57BFDE7402F0_var*
//#UC END# *47B99D4503A2_57BFDE7402F0_var*
begin
//#UC START# *47B99D4503A2_57BFDE7402F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *47B99D4503A2_57BFDE7402F0_impl*
end;//CompareExistingItems

type _Instance_R_ = TnsDownloaderThreadList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
{$IfEnd} // Defined(Nemesis)

end.
