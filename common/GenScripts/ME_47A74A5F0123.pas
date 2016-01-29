unit l3TypedListPrim.imp;

interface

uses
 l3IntfUses
 , l3Types
 , l3Interfaces
 , l3Core
;

type
 _l3TypedListPrim_ = class(_l3Items_)
  function Clone: Pointer; overload;
  procedure Assign(anOther: _l3TypedListPrim_); overload;
  function GrowByOne: PItemType;
   {* Увеличивает размер списка на единицу и возвращает указатель на последний элемент для заполнения. Этот элемент инициализирован нулями. }
  procedure Insert(anIndex: Integer;
   const anItem: _ItemType_);
   {* Вставляет элемент в список. }
  function IndexOf(const anItem: _ItemType_): Integer;
   {* Возвращает индекс элемента списка или -1, если элемента в списке нет. }
  function Remove(const anItem: _ItemType_): Integer;
   {* Удаляет элемент из списка и возвращает его индекс. }
  function Add(const anItem: _ItemType_): Integer;
   {* Добавляет элемент списка. }
  procedure Move(CurIndex: Integer;
   NewIndex: Integer);
   {* передвигает элементы списка. }
  function IterateBackF(aHi: Tl3Index;
   aLo: Tl3Index;
   anAction: Tl3IteratorAction): Integer;
   {* перебирает элементы списка в обратном порядке и освобождает заглушку для anAction. }
  function IterateBack(aHi: Tl3Index;
   aLo: Tl3Index;
   anAction: Tl3IteratorAction): Integer;
   {* перебирает элементы списка в обратном порядке. }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure Assign(Source: TPersistent); overload;
  function JoinWith(aList: _l3TypedListPrim_): Integer; overload;
   {* Объединяет один список с другим. }
  function Iterate(aLo: Tl3Index;
   aHi: Tl3Index;
   Action: Tl3IteratorAction): Integer;
   {* перебирает все элементы хранилища с aLo по aHi. }
  function IterateAll(Action: Tl3IteratorAction): Integer;
   {* перебирает все элементы хранилища. }
  procedure Clear;
  function GetItem(Index: Integer): _ItemType_;
  function DoAdd(const aData: _ItemType_): Integer;
   {* Добавляет элемент в список. }
  procedure DoInsert(anIndex: Integer;
   const aData: _ItemType_);
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure DoSetItem(anIndex: Integer;
   const anItem: _ItemType_);
  procedure DeleteLast;
   {* Удаляет последний элемент списка. }
  procedure Create;
  function Clone: Pointer; overload;
   {* функция для получения копии объекта. }
  procedure ReAllocList(NewCapacity: Integer;
   aList: _l3Items_);
   {* изменяет мощность списка. }
  function GetCapacity(aList: _l3Items_): Integer;
  function GetItemSlot(anIndex: Integer;
   aList: _l3Items_): PItemType;
  function Count: Integer;
   {* Число элементов. }
 end;//_l3TypedListPrim_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 PLong = ^Integer;
  {* Указатель на целое. }
 
end.
