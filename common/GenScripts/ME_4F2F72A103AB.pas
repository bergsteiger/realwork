unit evCellsOffsetsPairList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evCellsOffsetsPair
;

type
 TevCellsOffsetsPairList = class(_l3UncomparabeObjectRefList_)
  function PenultimateItem: TevCellsOffsetsPair;
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevCellsOffsetsPairList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
