unit nsDownloaderThreadList;

interface

uses
 l3ProtoDataContainer,
 l3Memory,
 l3Types,
 l3Interfaces,
 l3Core,
 l3Except,
 Classes,
 nsDownloaderThread;

type
 _ItemType_ = TnsDownloaderThread;
 _l3PtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}
 TnsDownloaderThreadList = class(_l3PtrList_)
 end;

implementation

uses
 l3Base,
 l3MinMax,
 RTLConsts,
 SysUtils;

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_); forward;
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer; forward;

{$If NOT Defined(l3Items_IsAtomic)}
function IsSameItems(const A: _ItemType_;
 const B: _ItemType_): Boolean;
 {* Сравнивает элементы списка }
begin
 Result := (A = B);
end;//IsSameItems
{$IfEnd} // NOT Defined(l3Items_IsAtomic)

{$If Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)}
procedure AssignItem(const aTo: _ItemType_;
 const aFrom: _ItemType_);
begin
 Assert(false);
end;//AssignItem
{$IfEnd} // Defined(l3Items_NeedsAssignItem) AND NOT Defined(l3Items_NoSort)

function CompareExistingItems(const CI: CompareItemsRec): Integer;
 {* Сравнивает два существующих элемента. }
begin
 Result := -1;
 Assert(false);
end;//CompareExistingItems

type _Instance_R_ = TnsDownloaderThreadList;

{$Include w:\common\components\rtl\Garant\L3\l3PtrList.imp.pas}

end.

