unit daParamListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , daInterfaces
;

type
 TdaParamListPrim = class(Tl3ProtoDataContainer)
  function IsSameItems(const A: _ItemType_;
   const B: _ItemType_): Boolean;
   {* Сравнивает элементы списка }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TdaParamListPrim
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

end.
