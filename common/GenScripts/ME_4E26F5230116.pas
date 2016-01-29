unit l3RectList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Units
;

type
 Tl3RectList = class(Tl3ProtoDataContainer)
  {* Список Tl3Rect }
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3RectList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
