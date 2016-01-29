unit l3EnumList.imp;

interface

uses
 l3IntfUses
;

type
 _l3EnumList_ = class(_l3StandardMemTypedList_)
  {* Стандартный список из элементов перечислимого типа }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure DoExchange(var A: _ItemType_;
   var B: _ItemType_;
   anItems: _l3Items_);
   {* Меняет элементы списка местами. Без всяких проверок. }
  procedure FillItem(var aPlace: _ItemType_;
   const anItem: _ItemType_;
   anItems: _l3Items_);
   {* Заполняет элемент списка. }
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_l3EnumList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
