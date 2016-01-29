unit Pl3MessageIDListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3MessageID
;

type
 TPl3MessageIDListPrim = class(Tl3ProtoDataContainer)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TPl3MessageIDListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
