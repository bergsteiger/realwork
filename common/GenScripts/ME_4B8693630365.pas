unit nevShapePrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_NoChanging}
 
 {$Define l3Items_NoSort}
 
type
 TnevShapePrim = class(_l3ObjectRefListPrim_)
  {* Информация об отрисованном объекте }
  procedure CleanupRefs;
   {* Очищает ссылки на сторонние объекты }
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
 end;//TnevShapePrim
 
implementation

uses
 l3ImplUses
 , nevShapesPainted
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
