unit l3IDIndexPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Variant
;

type
 Tl3IDIndexPrim = class(_l3UncomparabeObjectRefList_)
  {* Индекс объектов по их Handle. }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tl3IDIndexPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
