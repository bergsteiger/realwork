unit evSelectedParts;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , nevBase
;

type
 TevSelectedPart = record
 end;//TevSelectedPart
 
 TevSelectedParts = class(Tl3ProtoDataContainer)
  {* Коллекция выделенных прямоугольников }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevSelectedParts
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
