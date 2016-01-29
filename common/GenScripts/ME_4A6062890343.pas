unit evHugeParaListPrim;

interface

uses
 l3IntfUses
 , k2ListTag
;

 {$Define l3Items_NoOwner}
 
type
 TevHugeParaListPrim = class(Tk2ListTag)
  {* Список параграфов с числом свойств больше 32 }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevHugeParaListPrim
 
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
