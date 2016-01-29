unit m4WordIDStrListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , m4WordIDStr
;

type
 Tm4WordIDStrListPrim = class(_l3ObjectRefListPrim_)
  {* Список списков идентификаторов слов }
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
 end;//Tm4WordIDStrListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
