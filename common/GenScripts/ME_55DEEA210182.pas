unit l3NotSortedObjectRefList.imp;

interface

uses
 l3IntfUses
;

 {$Define l3Items_NoSort}
 
type
 _l3NotSortedObjectRefList_ = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_l3NotSortedObjectRefList_
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
