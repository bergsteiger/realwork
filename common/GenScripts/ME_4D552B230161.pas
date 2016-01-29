unit vgSortableObjectList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vgTypesPrim
 , vgCustomObject
;

type
 TvgSortableObjectList = class(_l3PtrList_)
  procedure Sort(aComparer: TvgObjectSortCompare);
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TvgSortableObjectList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
