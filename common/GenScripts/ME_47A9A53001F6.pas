unit l3ClassCacheEntry;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_NoSort}
 
type
 Tl3ClassCacheEntry = class(_l3ObjectRefListPrim_)
  procedure Create;
  function Add(Item: TObject): Integer;
  function DeleteTailWithoutFree: Pointer;
   {* удалить последний элемент, без его отпускания }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3ClassCacheEntry
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
