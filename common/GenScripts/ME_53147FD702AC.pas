unit l3FontManagerPrimPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3LogFont
;

 {$Undef l3Items_NoSort}
 
 {$Define l3Items_CaseUnsensitive}
 
type
 Tl3FontManagerPrimPrim = class(_l3UncomparabeObjectRefList_)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3FontManagerPrimPrim
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Types
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
