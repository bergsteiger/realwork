unit ddTaskItemList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , ddServerTask
;

 {$Undef l3Items_NoSort}
 
type
 TddTaskItemList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TddTaskItemList
 
implementation

uses
 l3ImplUses
 , SysUtils
 , StrUtils
 , l3Types
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
