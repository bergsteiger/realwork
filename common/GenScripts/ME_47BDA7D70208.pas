unit l3BaseWithLargeIDListPrim;

interface

uses
 l3IntfUses
 , l3SimpleDataContainer
 , l3BaseWithID
;

type
 Tl3BaseWithLargeIDListPrim = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3BaseWithLargeIDListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
