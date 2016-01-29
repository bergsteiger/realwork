unit l3Items.imp;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Types
;

type
 PFindItemType = ^_ItemType_;
 
 CompareItemsRec = record
  {* Данные для сравнения элементов списка. }
 end;//CompareItemsRec
 
 {$Define l3Items_NoChanging}
 
 {$Define l3Items_NoOwner}
 
 _l3Items_ = class(_l3Sortable_)
  {* Список }
  procedure Delete(Index: Integer);
   {* удалить элемент с индексом Index. }
  procedure DoDelete(Index: Integer);
   {* Удаляет элемент с индексом Index. Не проверяет валидность индекса. }
  procedure MoveItems(Dst: Integer;
   Src: Integer;
   aSize: Cardinal;
   aList: _l3Items_);
   {* Передвигает кусок памяти. }
  procedure FillSlot(var aPlace: _ItemType_;
   const anItem: _ItemType_);
   {* Заполняет место элемента его значением. }
  procedure DirectInsert(anIndex: Integer;
   const aData: _ItemType_);
   {* Непосредственное удаление элемента. Без проверки валидности индекса. }
  procedure CheckSetItem(anIndex: Integer);
   {* Проверяет валидность индекса при вставке. }
  procedure ReAllocList(NewCapacity: Integer;
   aList: _l3Items_);
   {* изменяет мощность списка. }
  function GetCapacity(aList: _l3Items_): Integer;
  procedure BeforeAddToCache;
  procedure Release;
  procedure CheckIndex(Index: Integer);
   {* проверяет валидность индекса и поднимает исключение, если он неправильный. }
  function ItemSlot(anIndex: Integer): PItemType;
  procedure DoExchange(var A: _ItemType_;
   var B: _ItemType_;
   anItems: _l3Items_);
   {* Меняет элементы списка местами. Без всяких проверок. }
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
  procedure FreeSlot(var aPlace: _ItemType_);
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
  function ExpandSize(aTargetSize: Integer): Integer;
  function GetEmpty: Boolean;
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
  procedure Exchange(I1: Integer;
   I2: Integer);
   {* Меняет элементы списка местами. Проверяет валидность индекса. }
  function GetItemSlot(anIndex: Integer;
   aList: _l3Items_): PItemType;
  function IterateF(I1: Tl3Index;
   I2: Tl3Index;
   Action: Tl3IteratorAction): Integer;
  function IterateAllF(Action: Tl3IteratorAction): Integer;
  procedure BeforeFreeItem(var aPlace: _ItemType_);
   {* Нотификация потомкам об освобождении элемента списка }
  function DoCompareItems(const A: _ItemType_;
   const B: _ItemType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Sortable_): Integer;
  procedure Swap(var I1: _ItemType_;
   var I2: _ItemType_);
   {* Меняет элементы хранилища местами. Не проверяет валидность индексов. }
  function CompareItemWithData(const anItem: _ItemType_;
   const aData: _FindDataType_;
   aSortIndex: Tl3SortIndex;
   aList: _l3Searcher_): Integer;
   {* Сравнивает существующий элемент с искомым. }
 end;//_l3Items_
 
implementation

uses
 l3ImplUses
 , RTLConsts
;

end.
