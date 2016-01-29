unit k2SimpleTagListPrim.imp;

interface

uses
 l3IntfUses
;

 {$Define l3Items_NoChanging}
 
 {$Define l3Items_NoOwner}
 
type
 _k2SimpleTagListPrim_ = class(_l3VariantListPrim_, Ml3Unknown)
  {* Список параграфов }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//_k2SimpleTagListPrim_
 
implementation

uses
 l3ImplUses
 , k2BaseTypes
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
