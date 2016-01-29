unit Pl3StringIDExList;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , l3StringIDEx
;

type
 TPl3StringIDExList = class(Tl3ProtoDataContainer)
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TPl3StringIDExList
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
