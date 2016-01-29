unit exprTokensList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3Interfaces
;

type
 TexprTokenInfo = object
  {* Информация о токене }
 end;//TexprTokenInfo
 
 {$Define l3Items_NoSort}
 
 TexprTokensList = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TexprTokensList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
