unit k2PropertyArray;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Variant
;

 {$Define l3Items_NoSort}
 
type
 Tk2PropertyArray = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2PropertyArray
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
