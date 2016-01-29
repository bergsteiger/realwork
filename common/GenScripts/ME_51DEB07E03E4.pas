unit List.imp;

interface

uses
 l3IntfUses
 , l3PtrLoc
;

type
 PItemType = ^_ItemType_;
 
 IndexType = Integer;
 
 _List_ = class(MRefCounted)
  {* Абстрактный список значений }
  procedure ReAllocList(aNewCapacity: IndexType);
  procedure CheckIndex(anIndex: IndexType);
   {* проверяет валидность индекса и поднимает исключение, если он неправильный }
  function ItemSlot(anIndex: IndexType): PItemType;
  function ExpandSize(aTargetSize: IndexType): Cardinal;
  procedure CheckSetItem(anIndex: IndexType);
   {* Проверяет валидность индекса при вставке }
  procedure Delete(anIndex: IndexType);
   {* удалить элемент с индексом anIndex }
  procedure DirectInsert(anIndex: IndexType;
   const anItem: _ItemType_);
   {* Непосредственная вставка элемента. Без проверки валидности индекса }
  procedure Insert(anIndex: IndexType;
   const anItem: _ItemType_);
   {* Вставка элемента }
  procedure MoveItems(aDst: IndexType;
   aSrc: IndexType;
   aSize: Cardinal);
  procedure Add(const anItem: _ItemType_);
   {* Добавляет элемент списка }
  function IndexOf(const anItem: _ItemType_): IndexType;
   {* Возвращает индекс элемента списка или -1, если элемента в списке нет }
  procedure Remove(const anIndex: _ItemType_);
   {* Удаляет элемент из списка }
  procedure Clear;
   {* Очищает список }
  procedure FreeItem(var thePlace: _ItemType_);
  procedure FillItem(var thePlace: _ItemType_;
   const aFrom: _ItemType_);
  function IsSame(const A: _ItemType_;
   const B: _ItemType_): Boolean;
 end;//_List_
 
implementation

uses
 l3ImplUses
 , RTLConsts
 , l3MemorySizeUtils
;

end.
