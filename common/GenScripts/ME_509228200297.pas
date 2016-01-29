unit evCellsOffsetsList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evCellsCharOffsets
 , evEditorInterfaces
;

type
 TevCellsOffsetsList = class(_l3UncomparabeObjectRefList_)
  procedure Try2RemeberWidths(const anIterator: IedCellsIterator);
  function FindList(const anIterator: IedCellsIterator;
   aForTempate: Boolean): TevCellsCharOffsets;
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevCellsOffsetsList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
