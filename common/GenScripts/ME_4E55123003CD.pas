unit evStandardStylesListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , evResultFontInterfaces
;

type
 TevStandardStylesCacheByFixedFont = array [Boolean] of IevResultFont;
 
 TevStandardStylesCacheByVisibility = array [Boolean] of TevStandardStylesCacheByFixedFont;
 
 TevStandardStylesCacheByJustification = array [Boolean] of TevStandardStylesCacheByVisibility;
 
 TevStandardStylesCacheItem = object
 end;//TevStandardStylesCacheItem
 
 TevStandardStylesListPrim = class(Tl3ProtoDataContainer)
  procedure evFreeStandardStylesCache(var theCache: TevStandardStylesCacheByJustification);
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  procedure FreeItem(var aPlace: _ItemType_;
   aList: _l3Items_);
   {* Очищает элемент списка }
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevStandardStylesListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
