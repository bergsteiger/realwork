unit m3EndingReplaceListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Interfaces
;

type
 Tm3EndingReplaceItem = object
 end;//Tm3EndingReplaceItem
 
 Tm3EndingReplaceListPrim = class(Tl3ProtoDataContainer)
  function CompareStrings(const aStr1: Tl3WString;
   const aStr2: Tl3WString): Integer;
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//Tm3EndingReplaceListPrim
 
implementation

uses
 l3ImplUses
 , l3String
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
