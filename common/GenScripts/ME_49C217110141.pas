unit evEpsilonLongIntList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 TevEpsilonLongIntList = class(Tl3ProtoDataContainer)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevEpsilonLongIntList
 
implementation

uses
 l3ImplUses
 , evConst
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
