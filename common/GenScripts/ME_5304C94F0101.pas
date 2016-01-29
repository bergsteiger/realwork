unit k2DictionaryPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

 {$Define l3Items_NeedsAssignItem}
 
 {$Define l3Items_CaseUnsensitive}
 
 {$Define l3Items_NeedsBeforeFreeItem}
 
 {$Undef l3Items_NoSort}
 
type
 Tk2DictionaryPrim = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tk2DictionaryPrim
 
implementation

uses
 l3ImplUses
 , k2BaseTypes
 , k2Tags
 , l3String
 , k2NonOptimizeContext
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
