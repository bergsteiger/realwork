unit pgJournalCache;

interface

uses
 l3IntfUses
 , daTypes
 , l3ProtoDataContainer
;

type
 TpgJournalCacheRec = object
 end;//TpgJournalCacheRec
 
 TpgJournalCacheList = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TpgJournalCacheList
 
 PpgJournalCacheRec = ^TpgJournalCacheRec;
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
