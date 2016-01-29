unit tfwValueTypesListPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , tfwValueTypes
;

type
 TtfwValueTypesListPrim = class(Tl3ProtoDataContainer)
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TtfwValueTypesListPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
