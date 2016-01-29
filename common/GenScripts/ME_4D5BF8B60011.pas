unit l3ProtoObjectRefSortableList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3ProtoObjectComparable
;

type
 Tl3ProtoObjectRefSortableList = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3ProtoObjectRefSortableList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
